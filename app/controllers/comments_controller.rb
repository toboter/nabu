class CommentsController < ApplicationController
    before_action :set_commentable
    before_action :authorize, except: :index

    def index
      @comments = @commentable.root_comments
    end

    def new 
      @comment = @commentable.comment_threads.build
      @comment.parent_id = Comment.find(params[:parent_id]).id if params[:parent_id]
    end

    def create
      @comment = @commentable.comment_threads.new(comment_params)
      @comment.commentator = current_user

      # Notification.create(
      #   receiver: @comment.root.commentator, 
      #   sender: current_user, 
      #   predicate: 'replied', 
      #   link: polymorphic_url([@commentable, :comments], anchor: "comment-#{@comment.id}"))

      respond_to do |format|
        if @comment.save
          format.html { redirect_to polymorphic_url([@commentable, :comments], anchor: "comment-#{@comment.id}"), notice: "Comment was successfully created." }
          format.js
        else
          format.html { render :new }
          format.js
        end
      end
    end

    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy if @comment.commentator == current_user

      respond_to do |format|
        format.html { redirect_to polymorphic_url([@commentable, :comments]), notice: 'Comment was successfully removed.' }
        format.js
      end
    end


    private
    
      # Use callbacks to share common setup or constraints between actions.
      def set_commentable
        Rails.application.eager_load!
        # resource, id = request.path.split('/')[1,2]
        # @commentable = resource.singularize.classify.constantize.find(id)
        klass = ActiveRecord::Base.descendants.map(&:name).detect { |c| params["#{c.underscore}_id"]}
        # friendly if klass.classify.constantize.respond_to?(:friendly)
        @commentable = klass.classify.constantize.friendly.find(params["#{klass.underscore}_id"])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def comment_params
        params.require(:comment).permit(:title, :body, :subject, :parent_id)
      end

end