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

    numbers.each do |number|
      CallExecutionJob.perform_later(number)
    end

    redirect_to root_path, notice: "Initiated #{numbers.count} calls"
  end
end


