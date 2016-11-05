//以下为修改jQuery Validation插件兼容Bootstrap的方法，没有直接写在插件中是为了便于插件升级
        $.validator.setDefaults({
            highlight: function (element) {
                $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
            },
            success: function (element) {
                element.closest('.form-group').removeClass('has-error').addClass('has-success');
            },
            errorElement: "span",
            errorPlacement: function (error, element) {
                if (element.is(":radio") || element.is(":checkbox")) {
                    error.appendTo(element.parent().parent().parent());
                } else {
                    error.appendTo(element.parent());
                }
            },
            errorClass: "help-block m-b-none",
            validClass: "help-block m-b-none"


        });

        //以下为官方示例
        $().ready(function () {

            // validate signup form on keyup and submit
            var icon = "<i class='fa fa-times-circle'></i> ";

            var rules = {
                username: {
                    required: true,
                    minlength: 2
                },
                password: {
                    required: true,
                    minlength: 5
                },
                confirm_password: {
                    required: true,
                    minlength: 5,
                    equalTo: "#password"
                },
                email: {
                    required: true,
                    email: true
                }
            };

            if (page =="modify"){
                rules =  {
                    username: {
                        required: true,
                            minlength: 2
                    },
                    password: {
                            minlength: 5
                    },
                    confirm_password: {
                            minlength: 5,
                            equalTo: "#password"
                    },
                    email: {
                        required: true,
                            email: true
                    }
                };
            }

            $("#signupForm").validate({
                rules: rules,
                messages: {
                    username: {
                        required: icon + "请输入您的用户名",
                        minlength: icon + "用户名必须两个字符以上"
                    },
                    password: {
                        required: icon + "请输入您的密码",
                        minlength: icon + "密码必须5个字符以上"
                    },
                    confirm_password: {
                        required: icon + "请再次输入密码",
                        minlength: icon + "密码必须5个字符以上",
                        equalTo: icon + "两次输入的密码不一致"
                    },
                    email: icon + "请输入您的E-mail"
                }
            });
            $("#cron_add").validate({
                rules: {
                    time: {
                        required: true,
                        minlength: 2
                    },
                    cmd: {
                        required: true,
                    },
                    stime: {
                        required: true,
                    },
                    etime: {
                        required: true,
                    },
                    after:{
                        required: true,
                    }

                },
                messages: {
                    time: {
                        required: icon + "请输入表达"
                    },
                    cmd: {
                        required: icon + "请输入cmd"
                    },
                    stime: {
                        required: icon + "请输入开始时间"
                    },
                    etime: {
                        required: icon + "请输入结束时间"
                    },
                    after: {
                        required: icon + "请输入前置任务"
                    }
                }
            });
        });
