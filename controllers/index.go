package controllers


type MainController struct {
	baseController
}

func (c *MainController) Index() {
	c.Data["name"] = c.GetSession("username").(string)
	c.TplName = "index.tpl"
}