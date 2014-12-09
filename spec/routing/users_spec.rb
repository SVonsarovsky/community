require 'rails_helper'

describe 'routing to users' do
  it 'routes /users/:username to users#show for username' do
    expect(get: '/users/schmidt').to route_to(
                                         controller: 'users',
                                         action: 'show',
                                         username: 'schmidt'
                                     )
  end

  it 'does not expose a delete' do
    expect(delete: '/users/1').not_to be_routable
  end
end