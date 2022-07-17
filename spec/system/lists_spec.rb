require 'rails_helper'

describe 'ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'Log inリンクが表示される: 左上から4番目のリンクが「Log in」である' do
        log_in_link = find_all('a')[4].native.inner_text
        expect(log_in_link).to match(/log in/i)
      end
      # [:href]でリンク参照
      it 'Log inリンクの内容が正しい' do
        log_in_link = find_all('a')[4][:href]
        expect(log_in_link).to eq new_user_session_path
      end
      it 'Sign Upリンクが表示される: 左上から5番目のリンクが「Sign Up」である' do
        sign_up_link = find_all('a')[5].native.inner_text
        expect(sign_up_link).to match(/sign up/i)
      end
      # [:href]でリンク参照
      it 'Sign Upリンクの内容が正しい' do
        sign_up_link = find_all('a')[5][:href]
        expect(sign_up_link).to eq new_user_registration_path
      end
    end
  end

  describe 'アバウト画面のテスト' do
    before do
      visit '/public/homes/about'
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/public/homes/about'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'タイトルが表示される' do
        expect(page).to have_content "Stray Cat's MAP"
      end
      it 'Aboutリンクが表示される: 左上から1番目のリンクが「About」である' do
        about_link = find_all('a')[1].native.inner_text
        expect(about_link).to match(/about/i)
      end
      it 'MAPリンクが表示される: 左上から2番目のリンクが「MAP」である' do
        map_link = find_all('a')[2].native.inner_text
        expect(map_link).to match(/map/i)
      end
      # posts?で書くのか?
      it "Catsリンクが表示される: 左上から3番目のリンクが「Cat's」である" do
        cats_link = find_all('a')[3].native.inner_text
        expect(cats_link).to match(/cat's/i)
      end
      it 'Log inリンクが表示される: 左上から4番目のリンクが「Log in」である' do
        log_in_link = find_all('a')[4].native.inner_text
        expect(log_in_link).to match(/log in/i)
      end
      it 'Sign upリンクが表示される: 左上から4番目のリンクが「Sign up」である' do
        sign_up_link = find_all('a')[5].native.inner_text
        expect(sign_up_link).to match(/sign up/i)
      end
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      it 'Aboutを押すと、About画面に遷移する' do
        about_link = find_all('a')[1].native.inner_text
        about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link about_link
        is_expected.to eq '/public/homes/about'
      end
      it 'MAPを押すと、MAP画面に遷移する' do
        map_link = find_all('a')[2].native.inner_text
        map_link = map_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link map_link
        is_expected.to eq '/public/posts/map'
      end
      it "cat'sを押すと、cat's画面に遷移する" do
        cats_link = find_all('a')[3].native.inner_text
        cats_link = cats_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link cats_link
        is_expected.to eq '/public/posts'
      end
      it 'Log inを押すと、ログイン画面に遷移する' do
        login_link = find_all('a')[4].native.inner_text
        login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link login_link
        is_expected.to eq '/users/sign_in'
      end
      it 'Sign upを押すと、サインアップ画面に遷移する' do
        signup_link = find_all('a')[5].native.inner_text
        signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link signup_link
        is_expected.to eq '/users/sign_up'
      end
    end
  end

  describe 'ユーザー新規登録のテスト' do
    before do
      visit new_user_registration_path
    end

    # 画像フォームの書き方
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it '「User Sign up」と表示される' do
        expect(page).to have_content 'User Sign up'
      end
      it 'imageフォームが表示される' do
        expect(page).to have_field 'user[user_image_url]'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it '新規登録ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button '新規登録' }.to change(User.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、トップ画面になっている' do
        click_button '新規登録'
        expect(current_path).to eq '/'
      end
    end
  end
  # 一般ユーザーの場合
  describe 'ユーザーログイン' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it '「User Log in」と表示される' do
        expect(page).to have_content 'User Log in'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
      it 'nameフォームは表示されない' do
        expect(page).not_to have_field 'user[name]'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先が、トップ画面になっている' do
        expect(current_path).to eq '/'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  describe 'ヘッダーのテスト: ユーザーログインしている場合' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    context 'ヘッダーの表示を確認' do
      it 'タイトルが表示される' do
        expect(page).to have_content "Stray Cat's MAP"
      end
      it 'My Pageリンクが表示される: 左上から1番目のリンクが「My Page」である' do
        my_page_link = find_all('a')[1].native.inner_text
        expect(my_page_link).to match(/my page/i)
      end
      it 'MAPリンクが表示される: 左上から2番目のリンクが「MAP」である' do
        map_link = find_all('a')[2].native.inner_text
        expect(map_link).to match(/map/i)
      end
      it 'Postリンクが表示される: 左上から3番目のリンクが「Post」である' do
        post_link = find_all('a')[3].native.inner_text
        expect(post_link).to match(/post/i)
      end
      it "Catsリンクが表示される: 左上から4番目のリンクが「Cat's」である" do
        cats_link = find_all('a')[4].native.inner_text
        expect(cats_link).to match(/cat's/i)
      end
       it 'Log outリンクが表示される: 左上から4番目のリンクが「Log out」である' do
        log_out_link = find_all('a')[5].native.inner_text
        expect(log_out_link).to match(/log out/i)
      end
    end
  end

  describe 'ユーザーログアウトのテスト' do
    let(:user) { create(:user) }

    before do
      visit root_path
      # link = find('a', id:'logout_link')
      # link.click
      # expect(page).to have_link 'log out', href: destroy_user_session_path
      # click_link 'log out'
      # logout_link = find_all('a')[4].native.inner_text
      # logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      # click_link logout_link
    end

    context 'ログアウト機能のテスト' do
      it '正しくログアウトできている: ログアウト後のリダイレクト先においてAbout画面へのリンクが存在する' do
        find('#navbarNavDropdown > ul > li:nth-child(5) > a').click
        expect(page).to have_link '', href: '/public/homes/about'
      end
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end

  # 管理者のヘッダー
  describe 'ヘッダーのテスト: 管理者ログインしている場合' do
    let(:admin) { create(:admin) }

    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
    end

    context 'ヘッダーの表示を確認' do
      it 'タイトルが表示される' do
        expect(page).to have_content "Stray Cat's MAP"
      end
      it "User'sリンクが表示される: 左上から1番目のリンクが「User's」である" do
        users_link = find_all('a')[1].native.inner_text
        expect(users_link).to match(/user's/i)
      end
      it 'MAPリンクが表示される: 左上から2番目のリンクが「MAP」である' do
        map_link = find_all('a')[2].native.inner_text
        expect(map_link).to match(/map/i)
      end
      it "Genre'sリンクが表示される: 左上から3番目のリンクが「Genre's」である" do
        genres_link = find_all('a')[3].native.inner_text
        expect(genres_link).to match(/genre's/i)
      end
      it "Cat'sリンクが表示される: 左上から4番目のリンクが「Cat's」である" do
        cats_link = find_all('a')[4].native.inner_text
        expect(cats_link).to match(/cat's/i)
      end
       it 'Log outリンクが表示される: 左上から5番目のリンクが「Log out」である' do
        log_out_link = find_all('a')[5].native.inner_text
        expect(log_out_link).to match(/log out/i)
      end
    end
  end

  describe '管理者ログアウトのテスト' do
    # let(:admin) { create(:admin) }

    before do
      visit root_path
      # fill_in 'user[name]', with: user.name
      # fill_in 'user[password]', with: user.password
      # click_link 'Log out'
      # logout_link = find_all('a')[4].native.inner_text
      # logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      # click_link logout_link
    end

    context '管理者ログアウト機能のテスト' do
      it '正しくログアウトできている: ログアウト後のリダイレクト先においてAbout画面へのリンクが存在する' do
        find('#navbarNavDropdown > ul > li:nth-child(5) > a').click
        expect(page).to have_link '', href: '/public/homes/about'
      end
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end
end