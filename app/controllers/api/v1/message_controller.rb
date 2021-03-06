      class Api::V1::MessageController < ApplicationController
            before_action :authorize_request 
            # before_action :find_user, except: %i[create index]    
            def index
            message = Message.order('created_at DESC').where('from': @current_user[:id]).or(Message.order('created_at DESC').where('to': @current_user[:id]))
            render json: {status: 'SUCCESS', message: 'Loaded Post', data:message},status: :ok
            end
            def show 
                message = Message.order('created_at DESC').where('to': params[:userId] ).or(Message.order('created_at DESC').where('from': params[:userId] ))
                render json: {status: 'SUCCESS', message: 'Loaded Post', data:message},status: :ok
            end 
            def create 
                message = Message.new(message_params)

                if message.save
                  render json: {status: 'SUCCESS', message:'Message Send', data:message},status: :ok
                else
                  render json: {status: 'ERROR', message:'Message not send', data:message.errors},status: :unprocessable_entity
                end
            end 
            def update
                message = Message.find(params[:id]) 
                if message.update(message_params)
                    render json: {status: 'SUCCESS', message:'Saved article', data:message},status: :ok
                  else
                    render json: {status: 'ERROR', message:'Article not saved', data:message.errors},status: :unprocessable_entity
                  end
            end    
            def destroy
                message = Message.find(params[:id])
                message.destroy
                render json: {status: 'SUCCESS', message:'Deleted article', data:message},status: :ok
              end
            private
           
            def message_params
              
              header = request.headers['Authorization']
              header = header.split(' ').last if header
              @decoded = JsonWebToken.decode(header)
              @current_user = User.find(@decoded[:user_id])
              # #  ,
           
              {
                "title": @current_user[:name],
                "from": @current_user[:id],
                "body": params[:body],
                "to": params[:toId],
            }
                # params.permit(:title, :body )
            end
        end
         