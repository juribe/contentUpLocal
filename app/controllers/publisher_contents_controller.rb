class PublisherContentsController < ApplicationController
    before_action :set_publisher, only: [:preview, :new, :index, :show, :edit, :update, :destroy, :create]
    before_action :set_publisher_content, only: [:preview, :show, :edit, :update, :destroy]

    def index
        @publisher_contents = @publisher.publisher_contents
        render :layout => false
    end

    def content
        @subdomain = request.subdomains(0).first.titleize.downcase
        @seo = params[:seo].titleize.downcase
        @publisher = Publisher.find_by(name: @subdomain)
        @content = Content.find_by(title: @seo)
        if @content && @publisher
            render :layout => false
            return
        end
        head :not_found, content_type: "text/html"
    end

    def show
    end


    def new
        @publisher_content = @publisher.publisher_contents.build
        @contents = Content.all.map{|c| [c.title, c.id]}
    end


    def edit
    end

    def preview
        render :layout => false
    end

    def create
        @publisher_content = @publisher.publisher_contents.new(publisher_content_params)
        @publisher_content.publisher_id = @publisher.id
        res = @publisher_content.save
        respond_to do |format|
            if res
              format.html { redirect_to publisher_url(@publisher), notice: "Publisher  content was successfully created." }
              format.json { render :show, status: :created, location: @publisher }
            else
              format.html { render :new, status: :unprocessable_entity }
              format.json { render json: @publisher.errors, status: :unprocessable_entity }
            end
          end
    end

    def update
        @publisher_content = PublisherContent.where("publisher_id=?", params[:publisher_id]).where("id=?", params[:id]).first
        res = @publisher_content.update(publisher_content_params)
        render_result(res)
    end


    def destroy
        @publisher_content = PublisherContent.where("publisher_id=?", params[:publisher_id]).where("id=?", params[:id]).first
        res = @publisher_content.destroy
        render_result(res)
    end

    def render_result(res)
        if res
            render json: {
                success: true,
                assignment: @publisher_content.as_json()
            }, status: 201
            return
        else
        warden.custom_failure!
        render json: {
            success: false,
            errors: @publisher_content.errors
        }, status: 201
        return
        end
    end

    private

    def set_publisher_content
        @publisher_content = PublisherContent.find(params[:id])
    end

    def set_publisher
        @publisher = Publisher.find(params[:publisher_id])
    end


    def publisher_content_params
        params.require(:publisher_content).permit(:publisher_id, :content_id)
    end
end
