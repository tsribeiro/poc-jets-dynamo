class MainAuthorizer < ApplicationAuthorizer
  authorizer(
    name: "MyCognito", # <= name is used as the "function" name
    identity_source: "Authorization", # maps to method.request.header.Authorization
    type: :cognito_user_pools,
    provider_arns: [
      "arn:aws:cognito-idp:us-east-1:176199459841:userpool/us-east-1_zCnDy26b0",
    ],
  )
  # no lambda function
end