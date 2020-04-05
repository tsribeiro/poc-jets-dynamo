class ApplicationController < Jets::Controller::Base

    def client_id
        ENV["JETS_ENV"].eql?("test") ? "a000aaf0-59ad-0138-53bd-2c87a333df7f" :
        request.env["adapter.event"]["requestContext"]["authorizer"]["claims"]["client_id"]
    end

    def params(raw: false, path_parameters: true, body_parameters: true)
        super.merge(client_id: client_id)
    end
end
