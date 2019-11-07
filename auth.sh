#curl localhost:3000/auth/ -X POST -d '{"email": "c@examaple.com", "name": "akakou", "password": "AAAAAA", "phone": "012-345-610" }' -H "content-type:application/json" | less
curl localhost:3000/auth/sign_in -X POST -d '{"email": "c@examaple.com", "password": "AAAAAA" }' -H "content-type:application/json" | less

