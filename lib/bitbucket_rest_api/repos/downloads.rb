# encoding: utf-8

module BitBucket
  class Repos::Downloads < API

    # List download links
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.downloads.list 'user-name', 'repo-name'
    #  bitbucket.repos.downloads.list 'user-name', 'repo-name' { |download| ... }
    #
    def list(user_name, repo_name, params={})
      update_validate_and_normalize_params(user_name, repo_name, params)

      response = get_request("/2.0/repositories/#{user_name}/#{repo_name}/downloads", params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    def get(user_name, repo_name, file_name, params={})
      update_validate_and_normalize_params(user_name, repo_name, params)

      response = get_request("/2.0/repositories/#{user_name}/#{repo_name}/downloads/#{file_name}", params)
      return response unless block_given?
      response.each { |el| yield el }
    end

    private
    def update_validate_and_normalize_params(user_name, repo_name, params)
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params
    end

  end # Repos::Downloads
end # BitBucket
