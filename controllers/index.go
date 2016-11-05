package controllers


type MainController struct {
	baseController
}

func (c *MainController) Index() {
	c.TplName = "index.tpl"
}