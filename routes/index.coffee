express = require("express")
router = express.Router()

# GET home page. 
router.get "/", (req, res) ->
	res.render "public/index.html"
	return

module.exports = router