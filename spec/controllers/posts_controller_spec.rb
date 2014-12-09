require 'rails_helper'

describe PostsController do
  let(:post_params) { FactoryGirl.attributes_for(:post).stringify_keys }
  let(:post) { FactoryGirl.build_stubbed(:post) }
  let(:user) { FactoryGirl.create(:user) }

  describe 'GET #index' do
    before do
      allow(Post).to receive(:all).and_return([post])
    end

    it 'receives all and return all posts' do
      expect(Post).to receive(:all)
      get :index
    end

    it 'assigns @posts' do
      get :index
      expect(assigns(:posts)).not_to be_nil
    end

    it 'renders :index template' do
      get :index
      expect(response).to render_template :index
    end

    it 'renders @posts with XML content-type' do
      put :index, format: 'xml'
      expect(response.content_type).to eq 'application/xml'
    end

    it 'renders @posts with XML output' do
      put :index, format: 'xml'
      expect(response.body).to have_xpath 'posts'
    end

  end

  describe 'GET #show' do
    before do
      allow(Post).to receive(:find).and_return(post) #Post.stub(:find).and_return :post
    end

    it 'receives find and return post' do
      expect(Post).to receive(:find).with(post.id.to_s).and_return(post)
      get :show, id: post.id
    end

    it 'assigns @post' do
      get :show, id: post.id
      expect(assigns(:post)).not_to be_nil
    end

    it 'renders :show template' do
      get :show, id: post.id
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before do
      allow(Post).to receive(:new).and_return(post)
    end

    it 'receives new and return post' do
      expect(Post).to receive(:new).and_return(post)
      get :new
    end

    it 'assigns @post' do
      get :new
      expect(assigns(:post)).not_to be_nil
    end

    it 'renders :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before do
      allow(Post).to receive(:find).and_return(:post)
    end

    it 'receives find and return post' do
      expect(Post).to receive(:find).with(post.id.to_s).and_return(post)
      get :edit, id: post.id
    end

    it 'assigns @post' do
      get :edit, id: post.id
      expect(assigns(:post)).not_to be_nil
    end

    it 'renders :edit template' do
      get :edit, id: post.id
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    #let(:post) { FactoryGirl.build(:post) }
    before do
      allow(Post).to receive(:new).with(post_params).and_return(post)
    end

    context 'with valid attributes' do
      before do
        allow(post).to receive(:save).and_return(true)
      end
      it 'assigns @post' do
        process :create, 'POST', post: post_params
        expect(assigns(:post)).not_to be_nil
      end

      it 'receives save for @post' do
        expect(post).to receive(:save)
        process :create, 'POST', post: post_params
      end

      it 'sends success notice in html' do
        process :create, 'POST', post: post_params
        expect(flash[:notice]).to eq 'Post was successfully created.'
      end

      it 'redirects to post page' do
        process :create, 'POST', post: post_params
        #post.attributes[:id] = 1
        expect(response).to redirect_to post
      end

      it 'renders :show template in json format' do
        process :create, 'POST', format: 'json', post: post_params
        expect(response).to render_template :show
      end

      it 'sends 200 OK status in json format' do
        process :create, 'POST', format: 'json', post: post_params
        expect(response.status).to eq 201
      end

    end

    context 'with invalid attributes' do
      before do
        allow(post).to receive(:save).and_return(false)
      end

      it 'sends error flash' do
        process :create, 'POST', post: post_params
        expect(flash[:error]).to eq 'Could not create post.'
      end

      it 'renders :new template' do
        process :create, 'POST', post: post_params
        expect(response).to render_template :new
      end

      it 'renders @post errors in json format' do
        process :create, 'POST', format: 'json', post: post_params
        expect(response.body).to eq post.errors.to_json
      end

      it 'sends 422 status code in json format' do
        process :create, 'POST', format: 'json', post: post_params
        expect(response.status).to eq 422
      end
    end

    context 'with forbidden attributes' do
      before do
        allow(post).to receive(:save).and_return(true)
      end

      it 'generates ParameterMissing error without post params' do
        expect { process :create, 'POST' }.to raise_error(ActionController::ParameterMissing)
      end

      it 'filters forbidden params' do
        expect(post).to receive(:save)
        process :create, 'POST', post: post_params.merge(user_id: 1)
      end
    end
  end

  describe 'PUT #update' do
    #let(:post) { FactoryGirl.create(:post) }
    context 'without ability to update' do
      before do
        allow(user).to receive_message_chain('posts.find').and_return nil #user.stub_chain(:posts, :find).and_return nil
        allow(controller).to receive(:current_user).and_return user #controller.stub(:current_user).and_return user
        put :update, id: post.id, post: post_params
      end

      it 'redirects to root page' do
        expect(response).to redirect_to(root_path)
      end

      it 'sends notice' do
        expect(flash[:notice]).to eq 'Not authorized user.'
      end
    end

    context 'with valid attributes' do
      before do
        allow(post).to receive(:update).and_return(true) #post.stub(:update).and_return true
        allow(user).to receive_message_chain('posts.find').and_return(post) #user.stub_chain(:posts, :find).and_return post
        allow(controller).to receive(:current_user).and_return(user) #controller.stub(:current_user).and_return user
      end

      it 'assigns @post' do
        put :update, id: post.id, post: post_params
        expect(assigns(:post)).not_to be_nil
      end

      it 'receives update for @post' do
        expect(post).to receive(:update).with(post_params)
        put :update, id: post.id, post: post_params
      end

      it 'sends success notice in html' do
        put :update, id: post.id, post: post_params
        expect(flash[:notice]).to eq 'Post was successfully updated.'
      end

      it 'redirects to post page' do
        put :update, id: post.id, post: post_params
        expect(response).to redirect_to :post
      end

      it 'renders :show template in json format' do
        put :update, format: 'json', id: post.id, post: post_params
        expect(response).to render_template :show
      end

      it 'sends 200 OK status in json format' do
        put :update, format: 'json', id: post.id, post: post_params
        expect(response.status).to eq 200
        #expect(response.status).to eq(404)
      end
    end

    context 'with forbidden attributes' do
      before do
        allow(post).to receive(:update).and_return(true)
        allow(user).to receive_message_chain('posts.find').and_return(post)
        allow(controller).to receive(:current_user).and_return(user)
      end

      it 'generates ParameterMissing error without post params' do
        expect { put :update, id: post.id }.to raise_error(ActionController::ParameterMissing)
      end

      it 'filters forbidden params' do
        expect(post).to receive(:update).with(post_params)
        put :update, id: post.id, post: post_params.merge(user_id: 1)
      end
    end

    context 'with invalid attributes' do
      before do
        allow(post).to receive(:update).and_return(false) #post.stub(:update).and_return false
        allow(user).to receive_message_chain('posts.find').and_return(post)
        allow(controller).to receive(:current_user).and_return(user)
      end

      it 'sends error flash' do
        put :update, id: post.id, post: post_params
        expect(flash[:error]).to eq 'Could not save post.'
      end

      it 'renders :edit template' do
        put :update, id: post.id, post: post_params
        expect(response).to render_template :edit
      end

      it 'renders @post errors in json format' do
        put :update, format: 'json', id: post.id, post: post_params
        expect(response.body).to eq post.errors.to_json
      end

      it 'sends 422 status code in json format' do
        put :update, format: 'json', id: post.id, post: post_params
        expect(response.status).to eq 422
      end

    end
  end

  describe 'DELETE #destroy' do
    before do
      allow(Post).to receive(:find).and_return(post)
      allow(post).to receive(:destroy)
    end

    it 'receives destroy for @post' do
      expect(post).to receive(:destroy)
      delete :destroy, id: post.id
    end

    it 'redirects to posts page' do
      delete :destroy, id: post.id
      expect(response).to redirect_to posts_url
    end

    it 'sends success notice in html' do
      delete :destroy, id: post.id
      expect(flash[:notice]).to eq 'Post was successfully destroyed.'
    end

    it 'sends 204 (:no_content) status in json format' do
      delete :destroy, format: 'json', id: post.id
      expect(response.status).to eq 204
    end

  end
end