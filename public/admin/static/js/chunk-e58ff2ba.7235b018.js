(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-e58ff2ba"],{"09b9":function(t,e,a){"use strict";t.exports=Object.is||function(t,e){return t===e?0!==t||1/t===1/e:t!==t&&e!==e}},"29ca":function(t,e,a){"use strict";var i=a("2b5f"),o=a("45b1"),n=a("064d"),l=a("6337"),r=a("3a4d"),s=a("09b9"),c=a("199e"),p=a("f55d"),u=a("85ec");o("search",(function(t,e,a){return[function(e){var a=r(this),o=l(e)?void 0:p(e,t);return o?i(o,e,a):new RegExp(e)[t](c(a))},function(t){var i=n(this),o=c(t),l=a(e,i,o);if(l.done)return l.value;var r=i.lastIndex;s(r,0)||(i.lastIndex=0);var p=u(i,o);return s(i.lastIndex,r)||(i.lastIndex=r),null===p?-1:p.index}]}))},"2f8d":function(t,e,a){"use strict";a.r(e);var i=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",{staticClass:"app-container"},[a("div",{staticClass:"toolbar"},[a("div",{staticStyle:{width:"100%","margin-bottom":"20px",display:"flex","justify-content":"space-between","align-items":"center"}},[a("div",[a("el-button",{attrs:{type:"primary",icon:"el-icon-plus",size:"mini"},on:{click:t.clickAdd}},[t._v(t._s(t._f("lang")("添加模型")))]),a("el-button",{attrs:{type:"text",icon:"el-icon-document",size:"mini"},on:{click:t.downloadTemplate}},[t._v(t._s(t._f("lang")("下载导入模板")))]),a("el-upload",{staticClass:"btn-import",attrs:{"before-upload":t.checkExcelFile,"on-success":t.importSuccess,"show-file-list":!1,action:"/admin.php/write/importPrompt"}},[a("el-button",{attrs:{type:"default",icon:"el-icon-upload2",size:"mini"}},[t._v(t._s(t._f("lang")("导入Excel")))])],1),a("el-button",{attrs:{type:"default",icon:"el-icon-download",size:"mini",loading:t.exportLoading},on:{click:t.exportExcel}},[t._v(t._s(t._f("lang")("导出Excel")))])],1),a("div",[a("el-input",{staticClass:"input-with-select",staticStyle:{width:"240px"},attrs:{placeholder:t._f("lang")("按标题"),size:"small",clearable:""},model:{value:t.search.keyword,callback:function(e){t.$set(t.search,"keyword",e)},expression:"search.keyword"}},[a("el-button",{attrs:{slot:"append",icon:"el-icon-search"},on:{click:function(e){return t.doSearch()}},slot:"append"})],1)],1)]),a("div",{staticStyle:{width:"100%",background:"#f3f6f9",padding:"10px"}},[a("el-button-group",[a("el-button",{staticStyle:{margin:"5px 0"},attrs:{type:"all"===t.search.topic_id?"primary":"default",size:"small"},on:{click:function(e){return t.changeTopic("all")}}},[t._v(t._s(t._f("lang")("全部")))]),t._l(t.topicList,(function(e){return a("el-button",{staticStyle:{margin:"5px 0"},attrs:{type:t.search.topic_id===e.id?"primary":"default",size:"small"},on:{click:function(a){return t.changeTopic(e.id)}}},[t._v(" "+t._s(e.title))])}))],2)],1)]),a("el-table",{attrs:{data:t.dataList,stripe:"",size:"medium","header-cell-class-name":"bg-gray"}},[a("el-table-column",{attrs:{prop:"weight",label:t._f("lang")("权重"),width:"60"}}),a("el-table-column",{attrs:{prop:"topic_title",label:t._f("lang")("所属类别"),width:"140"}}),a("el-table-column",{attrs:{prop:"title",label:t._f("lang")("模型标题"),width:"200"}}),a("el-table-column",{attrs:{prop:"desc",label:t._f("lang")("描述"),width:"350"}}),a("el-table-column",{attrs:{prop:"views",label:t._f("lang")("点击量"),width:"100"}}),a("el-table-column",{attrs:{prop:"usages",label:t._f("lang")("使用量"),width:"100"}}),a("el-table-column",{attrs:{prop:"votes",label:t._f("lang")("收藏量"),width:"100"}}),a("el-table-column",{attrs:{prop:"state",label:t._f("lang")("是否启用"),width:"80"},scopedSlots:t._u([{key:"default",fn:function(e){return[a("el-switch",{attrs:{"active-value":1,"inactive-value":0},on:{change:function(a){return t.setState(e.row.id,a)}},model:{value:e.row.state,callback:function(a){t.$set(e.row,"state",a)},expression:"scope.row.state"}})]}}])}),a("el-table-column",{attrs:{label:t._f("lang")("操作")},scopedSlots:t._u([{key:"default",fn:function(e){return[a("el-button-group",[a("el-button",{attrs:{type:"text",size:"mini",icon:"el-icon-edit"},nativeOn:{click:function(a){return a.preventDefault(),t.clickEdit(e.row.id)}}},[t._v(t._s(t._f("lang")("编辑")))]),a("el-button",{attrs:{type:"text text-danger",size:"mini",icon:"el-icon-delete"},nativeOn:{click:function(a){return a.preventDefault(),t.doDel(e.row.id)}}},[t._v(t._s(t._f("lang")("删除")))])],1)]}}])})],1),a("el-pagination",{attrs:{"current-page":t.page,"page-size":t.pagesize,layout:"total, prev, pager, next",total:t.dataTotal},on:{"current-change":t.pageChange}}),t.form?a("div",[a("el-dialog",{attrs:{"custom-class":"my-dialog full-dialog",title:t._f("lang")(t.formTitle),width:"800px",visible:!0,"close-on-click-modal":!1,"before-close":t.formClose}},[a("el-form",{ref:"form",attrs:{model:t.form,rules:t.formRules,"label-width":"120px"}},[a("el-form-item",{attrs:{label:t._f("lang")("权重"),prop:"weight"}},[a("el-input",{staticStyle:{width:"110px"},attrs:{placeholder:t._f("lang")("越大越靠前"),size:"normal"},model:{value:t.form.weight,callback:function(e){t.$set(t.form,"weight",e)},expression:"form.weight"}}),a("span",{staticStyle:{color:"#666","margin-left":"10px"}},[t._v(t._s(t._f("lang")("越大越靠前")))])],1),a("el-form-item",{attrs:{label:t._f("lang")("所属类别"),prop:"title"}},[a("el-select",{staticStyle:{width:"180px"},attrs:{placeholder:t._f("lang")("选择所属类别"),size:"normal"},model:{value:t.form.topic_id,callback:function(e){t.$set(t.form,"topic_id",e)},expression:"form.topic_id"}},t._l(t.topicList,(function(e,i){return a("el-option",{key:i,attrs:{label:t._f("lang")(e.title),value:e.id}})})),1)],1),a("el-form-item",{attrs:{label:t._f("lang")("模型标题"),prop:"title"}},[a("el-input",{staticStyle:{width:"400px"},attrs:{placeholder:t._f("lang")("模型标题"),size:"normal"},model:{value:t.form.title,callback:function(e){t.$set(t.form,"title",e)},expression:"form.title"}})],1),a("el-form-item",{attrs:{label:t._f("lang")("描述"),prop:"desc"}},[a("el-input",{staticStyle:{width:"500px"},attrs:{type:"textarea",rows:3,placeholder:t._f("lang")("模型描述"),size:"normal"},model:{value:t.form.desc,callback:function(e){t.$set(t.form,"desc",e)},expression:"form.desc"}})],1),a("el-form-item",{attrs:{label:t._f("lang")("模型内容"),prop:"prompt"}},[a("el-input",{staticStyle:{width:"500px"},attrs:{type:"textarea",rows:6,placeholder:t._f("lang")("模型内容"),size:"normal"},model:{value:t.form.prompt,callback:function(e){t.$set(t.form,"prompt",e)},expression:"form.prompt"}}),a("p",{staticStyle:{margin:"0","line-height":"24px","margin-top":"10px"}},[t._v(t._s(t._f("lang")("变量说明"))+"：")]),a("p",{staticStyle:{margin:"0","line-height":"24px",color:"#888"}},[t._v(t._s(t._f("lang")("用户输入内容"))+"："),a("span",{staticStyle:{color:"#04BABE"}},[t._v("[PROMPT]")])]),a("p",{staticStyle:{margin:"0","line-height":"24px",color:"#888"}},[t._v(t._s(t._f("lang")("输出语言"))+"："),a("span",{staticStyle:{color:"#04BABE"}},[t._v("[TARGETLANGGE]")])])],1),a("el-form-item",{attrs:{label:t._f("lang")("输入框提示"),prop:"hint"}},[a("el-input",{staticStyle:{width:"500px"},attrs:{type:"textarea",rows:3,placeholder:t._f("lang")("在输入框里提示用户的文字"),size:"normal"},model:{value:t.form.hint,callback:function(e){t.$set(t.form,"hint",e)},expression:"form.hint"}})],1),a("el-form-item",{attrs:{label:t._f("lang")("欢迎语"),prop:"welcome"}},[a("el-input",{staticStyle:{width:"500px"},attrs:{type:"textarea",rows:3,placeholder:t._f("lang")("可留空，默认使用提示文字"),size:"normal"},model:{value:t.form.welcome,callback:function(e){t.$set(t.form,"welcome",e)},expression:"form.welcome"}})],1),a("el-form-item",{attrs:{label:t._f("lang")("示例问题"),prop:"tips"}},[a("el-input",{staticStyle:{width:"500px"},attrs:{type:"textarea",rows:10,size:"small"},model:{value:t.form.tips,callback:function(e){t.$set(t.form,"tips",e)},expression:"form.tips"}}),a("p",{staticStyle:{margin:"0","line-height":"24px","margin-top":"10px"}},[t._v(t._s(t._f("lang")("一行一个")))])],1),a("el-form-item",{attrs:{label:t._f("lang")("虚拟点击量"),prop:"fake_views"}},[a("el-input",{staticStyle:{width:"110px"},attrs:{placeholder:"",size:"normal"},model:{value:t.form.fake_views,callback:function(e){t.$set(t.form,"fake_views",e)},expression:"form.fake_views"}})],1),a("el-form-item",{attrs:{label:t._f("lang")("虚拟使用量"),prop:"fake_usages"}},[a("el-input",{staticStyle:{width:"110px"},attrs:{placeholder:"",size:"normal"},model:{value:t.form.fake_usages,callback:function(e){t.$set(t.form,"fake_usages",e)},expression:"form.fake_usages"}})],1),a("el-form-item",{attrs:{label:t._f("lang")("虚拟收藏量"),prop:"fake_votes"}},[a("el-input",{staticStyle:{width:"110px"},attrs:{placeholder:"",size:"normal"},model:{value:t.form.fake_votes,callback:function(e){t.$set(t.form,"fake_votes",e)},expression:"form.fake_votes"}})],1)],1),a("span",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[a("el-button",{attrs:{type:"default",icon:"el-icon-close",size:"small"},on:{click:t.formClose}},[t._v(t._s(t._f("lang")("取 消")))]),a("el-button",{attrs:{type:"primary",icon:"el-icon-check",size:"small"},on:{click:t.doSubmit}},[t._v(t._s(t._f("lang")("提 交")))])],1)],1)],1):t._e()],1)},o=[],n=(a("cac0"),a("29ca"),a("a7fa"),a("b838"),a("0d33"),a("2025"),a("3441")),l={data:function(){return{form:null,formType:null,dataList:[],dataTotal:0,topicList:[],page:1,pagesize:10,search:{topic_id:"all",keyword:""},formRules:{title:[{required:!0,message:this.$lang("此项必填"),trigger:"blur"}],desc:[{required:!0,message:this.$lang("此项必填"),trigger:"blur"}],prompt:[{required:!0,message:this.$lang("此项必填"),trigger:"blur"}],hint:[{required:!0,message:this.$lang("此项必填"),trigger:"blur"}]},exportLoading:!1}},computed:{formTitle:function(){return"add"===this.formType?"添加模型":"编辑"}},mounted:function(){this.getTopicList(),this.getList()},methods:{getTopicList:function(){var t=this;Object(n["g"])().then((function(e){t.topicList=e.data}))},getList:function(){var t=this;Object(n["e"])({page:this.page,pagesize:this.pagesize,topic_id:this.search.topic_id,keyword:this.search.keyword}).then((function(e){t.dataList=e.data.list,t.dataTotal=e.data.count}))},doSearch:function(){this.page=1,this.getList()},pageChange:function(t){this.page=t,this.getList()},clickAdd:function(){this.formType="add",this.form={weight:100}},clickEdit:function(t){var e=this;Object(n["d"])({id:t}).then((function(t){e.formType="edit",e.form=t.data}))},formClose:function(){this.form=null,this.formType=""},doSubmit:function(){var t=this;this.$refs.form.validate((function(e){e?Object(n["h"])(t.form).then((function(e){t.getList(),t.$message.success(e.message),t.formClose()})):console.log("请填写必填项")}))},doDel:function(t){var e=this;this.$confirm("删除后不可回复，确定删除吗?","提示",{confirmButtonText:"确定删除",cancelButtonText:"取消",type:"warning"}).then((function(){Object(n["a"])({id:t}).then((function(t){e.getList(),e.$message.success(t.message)}))}))},setState:function(t,e){var a=this;Object(n["j"])({id:t,state:e}).then((function(t){a.getList(),a.$message.success(t.message)}))},changeTopic:function(t){this.search.topic_id=t,this.page=1,this.getList()},downloadTemplate:function(){window.location.href="/static/prompts.xlsx"},checkExcelFile:function(t){if("application/vnd.ms-excel"!==t.type&&"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"!==t.type)return this.$message.error(this.$lang("请上传Excel文件")),!1},importSuccess:function(t,e,a){this.getTopicList(),this.getList(),this.$message.success(t.message)},exportExcel:function(){var t=this;this.exportLoading=!0,Object(n["c"])(this.search).then((function(e){Promise.all([a.e("chunk-25acb444"),a.e("chunk-2133cd4f")]).then(a.bind(null,"4bf8")).then((function(a){var i="创作模型",o=["模型类别","模型标题","描述","模型内容","输入框提示","欢迎语","示例问题"],n=["topic_title","title","desc","prompt","hint","welcome","tips"],l=e.data,r=t.formatJson(n,l);a.export_json_to_excel({header:o,data:r,filename:i,autoWidth:!0,bookType:"xlsx"}),t.exportLoading=!1}))})).catch((function(){t.exportLoading=!1}))},formatJson:function(t,e){return e.map((function(e){return t.map((function(t){return e[t]}))}))}}},r=l,s=(a("9712"),a("76b2")),c=Object(s["a"])(r,i,o,!1,null,"7791a726",null);e["default"]=c.exports},3441:function(t,e,a){"use strict";a.d(e,"g",(function(){return o})),a.d(e,"f",(function(){return n})),a.d(e,"i",(function(){return l})),a.d(e,"b",(function(){return r})),a.d(e,"k",(function(){return s})),a.d(e,"e",(function(){return c})),a.d(e,"d",(function(){return p})),a.d(e,"h",(function(){return u})),a.d(e,"a",(function(){return f})),a.d(e,"j",(function(){return d})),a.d(e,"c",(function(){return m}));var i=a("b775");function o(t){return Object(i["a"])({url:"/write/getTopicList",method:"post",data:t})}function n(t){return Object(i["a"])({url:"/write/getTopic",method:"post",data:t})}function l(t){return Object(i["a"])({url:"/write/saveTopic",method:"post",data:t})}function r(t){return Object(i["a"])({url:"/write/delTopic",method:"post",data:t})}function s(t){return Object(i["a"])({url:"/write/setTopicState",method:"post",data:t})}function c(t){return Object(i["a"])({url:"/write/getPromptList",method:"post",data:t})}function p(t){return Object(i["a"])({url:"/write/getPrompt",method:"post",data:t})}function u(t){return Object(i["a"])({url:"/write/savePrompt",method:"post",data:t})}function f(t){return Object(i["a"])({url:"/write/delPrompt",method:"post",data:t})}function d(t){return Object(i["a"])({url:"/write/setPromptState",method:"post",data:t})}function m(t){return Object(i["a"])({url:"/write/exportPrompt",method:"post",data:t})}},9712:function(t,e,a){"use strict";a("c299")},c299:function(t,e,a){}}]);