########################################################
#  Change default shell from sh to bash for ipa users  #
#   user names should be in format "user_companyname"  #
########################################################
#!/bin/bash
for user in $(ipa user-find --shell=/bin/sh | grep "User login: [a-z]*_something"|awk '{print $3}')
do
ipa user-mod $user --shell=/bin/bash ## test which users will be affected replace ipa user-mod with: echo $user
done

