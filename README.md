*Pawsitively Boba*

Immerse yourself in a cozy gaming experience with 'Pawsitively Boba,' where you can relax, unwind, and enjoy delightful adventures in a vibrant virtual world.

How to Run (on our end):

1. Git clone this repo
2. Inside the project folder, run the following commands:
node server.js
3. Open another terminal in project folder and run:
cloudflared tunnel --url http://localhost:3000/
wrangler deploy
4. Update the URL mappings for this discord application with the generated cloudflared link

How to Run (on players's end):

Visit https://clynae2.itch.io/pawsitively-boba
