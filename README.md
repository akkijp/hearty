# hearty

```
curl -v -X POST https://api.line.me/oauth2/v2.1/token \
-H 'Content-Type: application/x-www-form-urlencoded' \
-d 'grant_type=authorization_code' \
-d 'code=tgePHYkTzOCeSkEF8jod' \
--data-urlencode 'redirect_uri=https://akkiline.jp.ngrok.io/oauth/callback?provider=line' \
-d 'client_id=1660737936' \
-d 'client_secret=2f79ab35efd6b1594a7029ff7e62556e'

curl -v -X POST https://api.line.me/oauth2/v2.1/token \
-H 'Content-Type: application/x-www-form-urlencoded' \
-d 'grant_type=refresh_token' \
-d 'refresh_token=9FFWbR439nt4ukmkGwl2' \
-d 'client_id=1660737936' \
-d 'client_secret=2f79ab35efd6b1594a7029ff7e62556e'

curl -v -X POST 'https://api.line.me/oauth2/v2.1/verify' \
-d 'id_token=eyJhbGciOiJIUzI1NiJ9.nVnUJ75ovXCNZj7nm4vBxwx-YUYoGd2uAas1txAfrv15uAohgO-6y5WBNprS1GvHPVpENFxQEVXmGxVJANsYnnzS70OvtbjTEgJZPIyVnV_2QuWWGsvYEMWw75HpZ5X7x5gigZhTZts_8-TN_3Lacy_CXk3_blCnlpVZbILwMbU.A4WNQBuSj-WlQb51KiUTB1xsMpnNRoUSz0k3lKIQVsg' \
-d 'client_id=1660737936'

curl -v -X GET https://api.line.me/oauth2/v2.1/userinfo \
-H 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.nVnUJ75ovXCNZj7nm4vBxwx-YUYoGd2uAas1txAfrv15uAohgO-6y5WBNprS1GvHPVpENFxQEVXmGxVJANsYnnzS70OvtbjTEgJZPIyVnV_2QuWWGsvYEMWw75HpZ5X7x5gigZhTZts_8-TN_3Lacy_CXk3_blCnlpVZbILwMbU.A4WNQBuSj-WlQb51KiUTB1xsMpnNRoUSz0k3lKIQVsg'
```
