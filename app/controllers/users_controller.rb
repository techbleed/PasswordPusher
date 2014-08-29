class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction

  def show
    if params.has_key?('sort')
      column = params['sort']
      direction = params['direction']

      if column =~ /^[a-z]*$/ and ['asc', 'desc'].include? direction
        @passwords = Password.where(:user_id => current_user.id).order("passwords.#{column} #{direction}").includes(:views)
      else
        @passwords = Password.where(:user_id => current_user.id).includes(:views)
      end

    else
      @passwords = Password.where(:user_id => current_user.id).includes(:views)
    end
  end

  private
      
    def sort_column
      Password.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end
        
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
