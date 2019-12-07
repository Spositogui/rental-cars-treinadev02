class ApplicationController < ActionController::Base
  def authorize_admin
    unless current_user.admin?
      flash[:alert] = 'Você não tem autorização para realizar esta ação'
      redirect_to root_path 
    end
  end
end


=begin
Somente administradores podem gerir filiais
Somente administradores podem gerir fabricantes
Somente administradores podem gerir modelos de carros
Somente administradores podem gerir categorias
Somente administradores podem gerir carros da frota
=end