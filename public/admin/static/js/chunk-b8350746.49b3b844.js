(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-b8350746"],{"0beb":function(t,e,a){"use strict";a("2f56")},"2f56":function(t,e,a){},"433a":function(t,e,a){"use strict";a("7153")},"4bb0":function(t,e,a){},"4d7a":function(t,e,a){"use strict";var n=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",[a("div",[a("el-radio-group",{model:{value:t.form["type"],callback:function(e){t.$set(t.form,"type",e)},expression:"form['type']"}},[a("el-radio",{attrs:{label:"text",size:"mini"}},[t._v(t._s(t._f("lang")("文字")))]),a("el-radio",{attrs:{label:"image",size:"mini"}},[t._v(t._s(t._f("lang")("图片")))])],1)],1),"text"===t.form["type"]?a("div",[a("el-input",{staticStyle:{width:"500px"},attrs:{type:"textarea",rows:6,placeholder:t._f("lang")("输入文字内容"),size:"small"},model:{value:t.form["content"],callback:function(e){t.$set(t.form,"content",e)},expression:"form['content']"}}),a("p",[a("el-button",{attrs:{type:"text",size:"small"},on:{click:t.showLinkForm}},[t._v(t._s(t._f("lang")("插入链接")))])],1)],1):t._e(),"image"===t.form["type"]?a("div",[a("el-input",{staticStyle:{width:"400px"},attrs:{type:"text",placeholder:t._f("lang")("输入图片地址或上传图片"),size:"small"},model:{value:t.form["image"],callback:function(e){t.$set(t.form,"image",e)},expression:"form['image']"}}),a("el-upload",{staticClass:"avatar-uploader",attrs:{action:"",data:{type:"image"},"http-request":t.uploadImage,"show-file-list":!1,multiple:!1}},[t.form["image"]?a("img",{staticClass:"avatar",staticStyle:{height:"100px",width:"auto"},attrs:{src:t.form["image"]}}):a("i",{staticClass:"el-icon-plus avatar-uploader-icon",staticStyle:{width:"100px",height:"100px","line-height":"100px"}})]),a("span",[t._v(t._s(t._f("lang")("10MB以内，支持bmp/png/jpeg/jpg/gif格式")))])],1):t._e(),t.linkForm?a("div",[a("el-dialog",{attrs:{"custom-class":"my-dialog",title:t._f("lang")("插入链接"),width:"460px",visible:!0,"append-to-body":!0,"close-on-click-modal":!1,"before-close":t.closeLinkForm}},[a("el-form",{ref:"form",attrs:{model:t.linkForm,rules:t.linkFormRules,"label-width":"80px"}},[a("el-form-item",{attrs:{label:t._f("lang")("标题"),prop:"title"}},[a("el-input",{staticStyle:{width:"200px"},attrs:{placeholder:t._f("lang")("链接标题"),size:"small"},model:{value:t.linkForm.title,callback:function(e){t.$set(t.linkForm,"title",e)},expression:"linkForm.title"}})],1),a("el-form-item",{attrs:{label:t._f("lang")("链接"),prop:"url"}},[a("el-input",{staticStyle:{width:"300px"},attrs:{placeholder:t._f("lang")("http:// 或 https://"),size:"small"},model:{value:t.linkForm.url,callback:function(e){t.$set(t.linkForm,"url",e)},expression:"linkForm.url"}})],1)],1),a("span",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[a("el-button",{attrs:{type:"default",icon:"el-icon-close",size:"small"},on:{click:t.closeLinkForm}},[t._v(t._s(t._f("lang")("取 消")))]),a("el-button",{attrs:{type:"primary",icon:"el-icon-check",size:"small"},on:{click:t.sumitLinkForm}},[t._v(t._s(t._f("lang")("提 交")))])],1)],1)],1):t._e()])},i=[],l=(a("f17d"),a("91b6")),r={props:{type:{type:String,default:"text"},content:{type:String,default:""},image:{type:String,default:""}},data:function(){return{form:{type:"text",content:"",image:""},formRules:{type:[{required:!0,message:this.$lang("此项必填"),trigger:"blur"}],content:[{required:!0,message:this.$lang("此项必填"),trigger:"blur"}],image:[{required:!0,message:this.$lang("此项必填"),trigger:"blur"}]},linkForm:null,linkFormRules:{title:[{required:!0,message:this.$lang("此项必填"),trigger:"blur"}],url:[{required:!0,message:this.$lang("此项必填"),trigger:"blur"}]}}},watch:{type:function(){this.form.type=this.type},content:function(){this.form.content=this.content},image:function(){this.form.image=this.image}},mounted:function(){this.form.type=this.type,this.form.content=this.content,this.form.image=this.image},methods:{getReply:function(){return this.form},uploadImage:function(t){var e=this,a=new FormData;a.append("file",t.file),t.data&&a.append("data",JSON.stringify(t.data)),Object(l["a"])(a).then((function(a){e.$set(e.form,t.data.type,a.data.path),e.$message.success(e.$lang("上传成功"))}))},showLinkForm:function(){this.linkForm={}},closeLinkForm:function(){this.linkForm=null},sumitLinkForm:function(){this.form.content+='<a href="'+this.linkForm.url+'">'+this.linkForm.title+"</a>",this.closeLinkForm()}}},o=r,s=(a("433a"),a("7d71"),a("76b2")),m=Object(s["a"])(o,n,i,!1,null,"5df40938",null);e["a"]=m.exports},"50d4":function(t,e,a){"use strict";a("4bb0")},7153:function(t,e,a){},"7d71":function(t,e,a){"use strict";a("bbb0")},"91b6":function(t,e,a){"use strict";a.d(e,"a",(function(){return i})),a.d(e,"b",(function(){return l}));var n=a("b775");function i(t){return Object(n["a"])({url:"/upload/image",method:"post",data:t})}function l(t){return Object(n["a"])({url:"/upload/pem",method:"post",data:t})}},bbb0:function(t,e,a){},cbf1:function(t,e,a){"use strict";a.r(e);var n=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",{staticClass:"app-container",staticStyle:{"padding-top":"10px"}},[a("el-tabs",{on:{"tab-click":t.switchTab},model:{value:t.tabName,callback:function(e){t.tabName=e},expression:"tabName"}},[a("el-tab-pane",{attrs:{label:t._f("lang")("关注时回复"),name:"welcomeReply"}},[t.form?a("el-form",{ref:"welcomeReply",staticStyle:{padding:"30px 0"},attrs:{model:t.form,"label-width":"120px"}},[a("el-form-item",{attrs:{label:t._f("lang")("回复内容")}},[a("replyEditor",{ref:"welcomeReplyEditor",attrs:{type:t.form.type,content:t.form.content,image:t.form.image}})],1),a("el-form-item",{attrs:{label:""}},[a("el-button",{attrs:{type:"primary",icon:"el-icon-check",size:"small"},on:{click:t.doSubmit}},[t._v(t._s(t._f("lang")("保 存")))])],1)],1):t._e()],1),a("el-tab-pane",{attrs:{label:t._f("lang")("扫码登录回复"),name:"loginReply"}},[t.form?a("el-form",{ref:"loginReply",attrs:{model:t.form,"label-width":"120px"}},[a("el-alert",{staticStyle:{width:"600px",margin:"10px 0 20px 20px"},attrs:{type:"warning",size:"small",title:t._f("lang")("当PC端扫码登录时，回复的内容"),closable:!1}}),a("el-form-item",{attrs:{label:t._f("lang")("回复内容")}},[a("replyEditor",{ref:"loginReplyEditor",attrs:{type:t.form.type,content:t.form.content,image:t.form.image}})],1),a("el-form-item",{attrs:{label:""}},[a("el-button",{attrs:{type:"primary",icon:"el-icon-check",size:"small"},on:{click:t.doSubmit}},[t._v(t._s(t._f("lang")("保 存")))])],1)],1):t._e()],1),a("el-tab-pane",{attrs:{label:t._f("lang")("默认回复"),name:"defaultReply"}},[t.form?a("el-form",{ref:"defaultReply",attrs:{model:t.form,"label-width":"120px"}},[a("el-alert",{staticStyle:{width:"600px",margin:"10px 0 20px 20px"},attrs:{type:"warning",size:"small",title:t._f("lang")("当系统不知道该如何回复时，默认发送的内容"),closable:!1}}),a("el-form-item",{attrs:{label:t._f("lang")("回复内容")}},[a("replyEditor",{ref:"defaultReplyEditor",attrs:{type:t.form.type,content:t.form.content,image:t.form.image}})],1),a("el-form-item",{attrs:{label:""}},[a("el-button",{attrs:{type:"primary",icon:"el-icon-check",size:"small"},on:{click:t.doSubmit}},[t._v(t._s(t._f("lang")("保 存")))])],1)],1):t._e()],1)],1)],1)},i=[],l=(a("f17d"),a("a7fa"),a("30f8"),a("da33")),r=a("4d7a"),o={components:{replyEditor:r["a"]},data:function(){return{tabName:"welcomeReply",form:null}},mounted:function(){this.getWxmpReply()},methods:{getWxmpReply:function(){var t=this;Object(l["d"])({type:this.tabName}).then((function(e){t.form=e.data}))},switchTab:function(){this.getWxmpReply()},doSubmit:function(){var t=this;this.$refs[this.tabName].validate((function(e){if(e){var a=t.$refs[t.tabName+"Editor"].getReply(),n=a.type,i=a.content,r=a.image;t.form.type=n,t.form.content=i,t.form.image=r,Object(l["h"])({type:t.tabName,data:JSON.stringify(t.form)}).then((function(e){t.getWxmpReply(),t.$message.success(e.message)}))}else t.$message.error(t.$lang("请填写必填项"))}))},uploadImage:function(t){function e(e){return t.apply(this,arguments)}return e.toString=function(){return t.toString()},e}((function(t){var e=this,a=new FormData;a.append("file",t.file),t.data&&a.append("data",JSON.stringify(t.data)),uploadImage(a).then((function(a){e.$set(e.form,t.data.type,a.data.path),e.$message.success(e.$lang("上传成功"))}))}))}},s=o,m=(a("0beb"),a("50d4"),a("76b2")),c=Object(m["a"])(s,n,i,!1,null,"036e3929",null);e["default"]=c.exports},da33:function(t,e,a){"use strict";a.d(e,"e",(function(){return i})),a.d(e,"i",(function(){return l})),a.d(e,"d",(function(){return r})),a.d(e,"h",(function(){return o})),a.d(e,"c",(function(){return s})),a.d(e,"b",(function(){return m})),a.d(e,"f",(function(){return c})),a.d(e,"a",(function(){return u})),a.d(e,"g",(function(){return f}));var n=a("b775");function i(t){return Object(n["a"])({url:"/wxmp/getWxmpSetting",method:"post",data:t})}function l(t){return Object(n["a"])({url:"/wxmp/setWxmpSetting",method:"post",data:t})}function r(t){return Object(n["a"])({url:"/wxmp/getWxmpReply",method:"post",data:t})}function o(t){return Object(n["a"])({url:"/wxmp/setWxmpReply",method:"post",data:t})}function s(t){return Object(n["a"])({url:"/wxmp/getKeywordList",method:"post",data:t})}function m(t){return Object(n["a"])({url:"/wxmp/getKeyword",method:"post",data:t})}function c(t){return Object(n["a"])({url:"/wxmp/saveKeyword",method:"post",data:t})}function u(t){return Object(n["a"])({url:"/wxmp/delKeyword",method:"post",data:t})}function f(t){return Object(n["a"])({url:"/wxmp/setKeywordState",method:"post",data:t})}}}]);