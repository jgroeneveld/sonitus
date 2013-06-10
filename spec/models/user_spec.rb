require 'spec_helper'

describe User do
  it '#albums' do
    user = Fabricate(:user)
    album = Fabricate(:album)
    user.albums << album
    expect(user.albums).to include album
  end
end
