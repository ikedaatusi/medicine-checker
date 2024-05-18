class CalendarsController < ApplicationController
    def index
        @q = Drug.ransack(params[:q])
        @drugs = @q.result(distinct: true).includes(:take_times).order(created_at: :desc).page(params[:page])
    end
end