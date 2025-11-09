class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :ai_prompt
  def index
    @logs = CallLogService.all.reverse
    @stats = CallLogService.stats
  end

  def ai_prompt
    command = params[:command]
    
    if command.blank?
      redirect_to root_path, alert: "Please enter a command"
      return
    end

    result = AiPromptService.parse(command)
    
    if result[:phone].present?
      CallExecutionJob.perform_later(result[:phone])
      redirect_to root_path, notice: "Call initiated to #{result[:phone]}"
    else
      redirect_to root_path, alert: "Could not extract phone number from: #{command}"
    end
  end

  def upload_numbers
    numbers_text = params[:numbers]
    
    if numbers_text.blank?
      redirect_to root_path, alert: "Please enter phone numbers"
      return
    end

    numbers = numbers_text.split("\n")
                    .map(&:strip)
                    .reject(&:blank?)
                    .map { |n| n.gsub(/[^\d+]/, '') }
                    .select { |n| n.length >= 10 }

    if numbers.empty?
      redirect_to root_path, alert: "No valid phone numbers found"
      return
    end

    # Process calls with a small delay between each to avoid rate limiting
    numbers.each_with_index do |number, index|
      CallExecutionJob.set(wait: (index * 0.5).seconds).perform_later(number)
    end

    redirect_to root_path, notice: "Initiated #{numbers.count} calls (processing with delays to avoid rate limits)"
  end

  def clear_logs
    CallLogService.clear
    redirect_to root_path, notice: "Call logs cleared successfully"
  end
end


