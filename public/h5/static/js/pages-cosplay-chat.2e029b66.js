(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["pages-cosplay-chat"],{"0d9d":function(t,e,i){"use strict";i.r(e);var a=i("bf00"),n=i.n(a);for(var s in a)["default"].indexOf(s)<0&&function(t){i.d(e,t,(function(){return a[t]}))}(s);e["default"]=n.a},1424:function(t,e,i){"use strict";i.r(e);var a=i("e9de"),n=i.n(a);for(var s in a)["default"].indexOf(s)<0&&function(t){i.d(e,t,(function(){return a[t]}))}(s);e["default"]=n.a},"159d":function(t,e,i){"use strict";i.r(e);var a=i("c2a9"),n=i("a3d3");for(var s in n)["default"].indexOf(s)<0&&function(t){i.d(e,t,(function(){return n[t]}))}(s);i("5a1a");var o=i("f0c5"),r=Object(o["a"])(n["default"],a["b"],a["c"],!1,null,"0ea913b8",null,!1,a["a"],void 0);e["default"]=r.exports},"1a6f":function(t,e,i){var a=i("8d56");a.__esModule&&(a=a.default),"string"===typeof a&&(a=[[t.i,a,""]]),a.locals&&(t.exports=a.locals);var n=i("4f06").default;n("e14f3602",a,!0,{sourceMap:!1,shadowMode:!1})},4050:function(t,e,i){"use strict";i.r(e);var a=i("d6d4"),n=i("1424");for(var s in n)["default"].indexOf(s)<0&&function(t){i.d(e,t,(function(){return n[t]}))}(s);i("c9f5");var o=i("f0c5"),r=Object(o["a"])(n["default"],a["b"],a["c"],!1,null,"24a61342",null,!1,a["a"],void 0);e["default"]=r.exports},"5a13":function(t,e,i){"use strict";i.d(e,"b",(function(){return n})),i.d(e,"c",(function(){return s})),i.d(e,"a",(function(){return a}));var a={uvTabs:i("fc75").default,cosplayMsgList:i("159d").default},n=function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("v-uni-view",{staticClass:"page",class:{gold:t.aiList.length>0&&t.isGpt4(t.activeAiIndex)}},[i("uv-tabs",{staticClass:"tabs",attrs:{list:t.aiList,current:t.activeAiIndex,"key-name":"alias","line-color":"#04BABE"},on:{click:function(e){arguments[0]=e=t.$handleEvent(e),t.onTabChange.apply(void 0,arguments)}}}),i("v-uni-swiper",{staticClass:"lists",attrs:{current:t.activeAiIndex,duration:300},on:{change:function(e){arguments[0]=e=t.$handleEvent(e),t.onSwiperChange.apply(void 0,arguments)}}},t._l(t.aiList,(function(e,a){return i("v-uni-swiper-item",{key:a,staticClass:"swiper-item"},[i("cosplayMsgList",{ref:"msgList",refInFor:!0,attrs:{"ai-name":e.name,"ai-index":a,"active-ai-index":t.activeAiIndex,"role-id":t.role_id,welcome:t.welcome,"user-avatar":t.userAvatar},on:{setMessage:function(e){arguments[0]=e=t.$handleEvent(e),t.setMessage.apply(void 0,arguments)}}})],1)})),1),i("v-uni-view",{staticClass:"box-input"},[i("v-uni-view",{staticClass:"input"},[i("v-uni-textarea",{attrs:{type:"text","confirm-type":"send","auto-height":!0,placeholder:t.role.hint||"输入你的问题",maxlength:"3000","cursor-spacing":"0"},on:{confirm:function(e){arguments[0]=e=t.$handleEvent(e),t.sendConfirm.apply(void 0,arguments)},focus:function(e){arguments[0]=e=t.$handleEvent(e),t.inputFocus.apply(void 0,arguments)}},model:{value:t.message,callback:function(e){t.message=e},expression:"message"}}),i("v-uni-button",{staticClass:"btn-send",on:{click:function(e){arguments[0]=e=t.$handleEvent(e),t.sendText.apply(void 0,arguments)}}},[i("v-uni-image",{attrs:{mode:"widthFix",src:"/static/images/ic_send.png"}})],1)],1)],1)],1)},s=[]},"5a1a":function(t,e,i){"use strict";var a=i("da0a"),n=i.n(a);n.a},"8a79":function(t,e,i){"use strict";var a=i("23e7"),n=i("4625"),s=i("06cf").f,o=i("50c4"),r=i("577e"),c=i("5a34"),l=i("1d80"),u=i("ab13"),d=i("c430"),f=n("".endsWith),p=n("".slice),g=Math.min,h=u("endsWith"),v=!d&&!h&&!!function(){var t=s(String.prototype,"endsWith");return t&&!t.writable}();a({target:"String",proto:!0,forced:!v&&!h},{endsWith:function(t){var e=r(l(this));c(t);var i=arguments.length>1?arguments[1]:void 0,a=e.length,n=void 0===i?a:g(o(i),a),s=r(t);return f?f(e,s,n):p(e,n-s.length,n)===s}})},"8d56":function(t,e,i){var a=i("24fb");e=a(!1),e.push([t.i,'@charset "UTF-8";\r\n/**\r\n * 这里是uni-app内置的常用样式变量\r\n *\r\n * uni-app 官方扩展插件及插件市场（https://ext.dcloud.net.cn）上很多三方插件均使用了这些样式变量\r\n * 如果你是插件开发者，建议你使用scss预处理，并在插件代码中直接使用这些变量（无需 import 这个文件），方便用户通过搭积木的方式开发整体风格一致的App\r\n *\r\n */\r\n/**\r\n * 如果你是App开发者（插件使用者），你可以通过修改这些变量来定制自己的插件主题，实现自定义主题功能\r\n *\r\n * 如果你的项目同样使用了scss预处理，你也可以直接在你的 scss 代码中使用如下变量，同时无需 import 这个文件\r\n */\r\n/* 颜色变量 */\r\n/* 行为相关颜色 */\r\n/* 文字基本颜色 */\r\n/* 背景颜色 */\r\n/* 边框颜色 */\r\n/* 尺寸变量 */\r\n/* 文字尺寸 */\r\n/* 图片尺寸 */\r\n/* Border Radius */\r\n/* 水平间距 */\r\n/* 垂直间距 */\r\n/* 透明度 */\r\n/* 文章场景相关 */.page[data-v-c6300bfe]{background:#f7f7f8;position:absolute;width:100%;left:0;right:0;top:0;bottom:0;overflow:hidden}.page .tabs[data-v-c6300bfe]{position:absolute;top:0;left:0;width:100%;height:%?88?%;background:#fff}.page .lists[data-v-c6300bfe]{position:absolute;left:0;right:0;top:%?94?%;bottom:%?160?%;width:100%;height:auto;transition:all .3s}.page .box-input[data-v-c6300bfe]{position:absolute;width:100%;left:0;right:0;bottom:0;box-sizing:border-box;padding:%?40?% 0;border-top:1px solid #d8d8e2;background:#f6fafc}.page .box-input .input[data-v-c6300bfe]{width:%?690?%;margin:0 %?30?%;position:relative;box-sizing:border-box;box-shadow:0 0 %?12?% rgba(0,0,0,.1);background:#fefefe}.page .box-input .input uni-textarea[data-v-c6300bfe]{width:%?580?%;padding:%?20?% %?10?% %?20?% %?20?%;border-radius:%?10?%;line-height:%?40?%;max-height:%?800?%;overflow-x:hidden;overflow-y:auto;transition:all .1s ease-in-out}.page .box-input .input .btn-send[data-v-c6300bfe]{position:absolute;right:0;bottom:0;width:%?100?%;height:%?80?%;padding:0;border:none;border-radius:%?10?%;background:none;display:flex;align-items:center;justify-content:center;z-index:9}.page .box-input .input .btn-send uni-image[data-v-c6300bfe]{width:%?40?%}.page .box-input .input .btn-send[data-v-c6300bfe]::after{display:none}.page .box-input .input .btn-send[data-v-c6300bfe]:active{background:#f2f2f2}',""]),t.exports=e},"9bc1":function(t,e,i){var a=i("fd89");a.__esModule&&(a=a.default),"string"===typeof a&&(a=[[t.i,a,""]]),a.locals&&(t.exports=a.locals);var n=i("4f06").default;n("62d39200",a,!0,{sourceMap:!1,shadowMode:!1})},"9c67":function(t,e,i){"use strict";i.r(e);var a=i("5a13"),n=i("0d9d");for(var s in n)["default"].indexOf(s)<0&&function(t){i.d(e,t,(function(){return n[t]}))}(s);i("e237");var o=i("f0c5"),r=Object(o["a"])(n["default"],a["b"],a["c"],!1,null,"c6300bfe",null,!1,a["a"],void 0);e["default"]=r.exports},a3d3:function(t,e,i){"use strict";i.r(e);var a=i("e86b"),n=i.n(a);for(var s in a)["default"].indexOf(s)<0&&function(t){i.d(e,t,(function(){return a[t]}))}(s);e["default"]=n.a},bf00:function(t,e,i){"use strict";(function(t){i("7a82"),Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0,i("e25e"),i("d3b7"),i("159b"),i("caad");var a=getApp(),n={data:function(){return{isLogin:!1,role:{},role_id:0,message:"",safeAreaHeight:0,hasModel4:!1,model4Name:"高级版",userinfo:{},aiList:[],activeAiIndex:0}},computed:{welcome:function(){return{title:this.role.title,desc:this.role.welcome,tips:this.role.tips}},userAvatar:function(){return this.userinfo&&this.userinfo.avatar?this.userinfo.avatar:"/static/img/ic_user.png"}},onLoad:function(t){var e=this;t.role_id?this.setData({role_id:parseInt(t.role_id)}):t.id&&this.setData({role_id:parseInt(t.id)}),this.setData({safeAreaHeight:a.globalData.safeAreaHeight}),a.globalData.util.getSetting().then((function(t){e.setData({hasModel4:t.hasModel4,model4Name:t.model4Name,aiList:t.aiList});var i=uni.getStorageSync("ai");i&&t.aiList.forEach((function(t,a){t.name===i&&e.switchAi(a)}))})),this.getRole(),a.globalData.util.checkLogin().then((function(){e.setData({isLogin:!0}),e.getUserInfo()}))},methods:{inputFocus:function(){this.isLogin||a.globalData.util.toLogin("请登录")},sendText:function(){this.$refs.msgList[this.activeAiIndex].sendText(this.message)},sendConfirm:function(){var t=this;setTimeout((function(){t.sendText()}),50)},setMessage:function(e){t("log","message",e," at pages/cosplay/chat.vue:111"),this.message=e},quickMessage:function(t){this.message=t},onTabChange:function(t){this.switchAi(t.index)},onSwiperChange:function(t){var e=t.target.current||t.detail.current;this.switchAi(e)},switchAi:function(t){this.isGpt4(t)&&a.globalData.util.message(window.langTrans("您已进入【"+this.model4Name+"】，开始按字数计费")),this.activeAiIndex=t,uni.setStorage("ai",this.aiList[t].name)},isGpt4:function(t){var e=this.aiList[t].name;return["openai4","azure_openai4","wenxin4","claude2","hunyuan4"].includes(e)},getRole:function(){var t=this;a.globalData.util.request({url:"/cosplay/getRole",data:{role_id:this.role_id}}).then((function(e){t.setData({role:e.data}),document.title=e.data.title}))},getUserInfo:function(){var t=this;a.globalData.util.request({url:"/user/info",loading:!1}).then((function(e){t.setData({userinfo:e.data})})).catch((function(t){}))}}};e.default=n}).call(this,i("0de9")["log"])},c2a9:function(t,e,i){"use strict";i.d(e,"b",(function(){return a})),i.d(e,"c",(function(){return n})),i.d(e,"a",(function(){}));var a=function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("v-uni-scroll-view",{staticClass:"msg-list",attrs:{"scroll-x":!1,"scroll-y":!0,"scroll-with-animation":!1,"scroll-top":t.scrollTop},on:{click:function(e){arguments[0]=e=t.$handleEvent(e),t.hideCopyBtn.apply(void 0,arguments)}}},[t.lists&&t.lists.length>0?i("v-uni-view",{staticClass:"list"},[t._l(t.lists,(function(e,a){return["AI"==e.user?i("v-uni-view",{key:a+"_0",staticClass:"message",staticStyle:{background:"#f7f7f8"},attrs:{"data-index":a}},[i("v-uni-view",{staticClass:"avatar"},[i("img",{attrs:{src:"/static/img/ic_ai.png"}})]),i("v-uni-view",{staticClass:"text markdown-body"},[i("textComponent",{attrs:{text:e.message}}),i("v-uni-view",{staticClass:"tools"},[i("v-uni-view",[i("v-uni-view",{staticClass:"btn",on:{click:function(i){arguments[0]=i=t.$handleEvent(i),t.copyText(e.message)}}},[i("v-uni-image",{staticClass:"icon",attrs:{src:"/static/images/ic_copy.png"}}),i("span",[t._v(t._s(t._f("lang")("复制内容")))])],1)],1),i("v-uni-view",[i("v-uni-view",{staticClass:"btn",staticStyle:{"margin-right":"0"},attrs:{title:t._f("lang")("重新回答")},on:{click:function(e){arguments[0]=e=t.$handleEvent(e),t.retry(a-1)}}},[i("v-uni-image",{staticClass:"icon",attrs:{src:"/static/images/ic_retry.png"}})],1)],1)],1)],1)],1):i("v-uni-view",{staticClass:"message",staticStyle:{background:"#fff"}},[i("v-uni-view",{staticClass:"avatar",staticStyle:{background:"#9aa37e"}},[i("img",{attrs:{src:t.userAvatar}})]),i("v-uni-view",{staticClass:"text markdown-body",attrs:{"data-text":e.message},on:{longpress:function(e){arguments[0]=e=t.$handleEvent(e),t.showCopyBtn.apply(void 0,arguments)}}},[i("textComponent",{attrs:{text:e.message}})],1)],1)]})),t.writing||t.writingText?i("v-uni-view",{staticClass:"message",staticStyle:{background:"#f7f7f8"}},[i("v-uni-view",{staticClass:"avatar"},[i("img",{attrs:{src:"/static/img/ic_ai.png"}})]),i("v-uni-view",{staticClass:"text markdown-body"},[i("textComponent",{attrs:{text:t.writingText,writing:!(!t.writing&&!t.writingText)}}),i("v-uni-view",{staticClass:"tools"},[i("v-uni-view",[i("v-uni-view",{staticClass:"btn",on:{click:function(e){arguments[0]=e=t.$handleEvent(e),t.stopFetch.apply(void 0,arguments)}}},[i("v-uni-image",{staticClass:"icon",attrs:{src:"/static/images/ic_stop.png"}}),i("span",[t._v(t._s(t._f("lang")("停止回复")))])],1)],1)],1)],1)],1):t._e(),i("v-uni-view",{staticClass:"btn-copy",style:"left:"+t.copyBtnLeft+"px;top:"+t.copyBtnTop+"px;",on:{click:function(e){arguments[0]=e=t.$handleEvent(e),t.copyText(t.copyBtnText)}}},[t._v(t._s(t._f("lang")("复制")))])],2):i("welcome",{attrs:{module:"write",title:t.welcome.title,desc:t.welcome.desc,tips:t.welcome.tips},on:{use:function(e){arguments[0]=e=t.$handleEvent(e),t.quickMessage.apply(void 0,arguments)}}})],1)},n=[]},c9f5:function(t,e,i){"use strict";var a=i("9bc1"),n=i.n(a);n.a},d6d4:function(t,e,i){"use strict";i.d(e,"b",(function(){return a})),i.d(e,"c",(function(){return n})),i.d(e,"a",(function(){}));var a=function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("v-uni-view",{staticClass:"welcome"},[i("v-uni-view",{staticClass:"row row-ai"},[i("v-uni-view",{staticClass:"message"},[i("v-uni-view",{staticClass:"avatar"},[i("img",{attrs:{src:"/static/img/ic_ai.png"}})]),i("v-uni-view",{staticClass:"text markdown-body"},[t.welcomeTitle?i("v-uni-view",{staticClass:"title"},[t._v(t._s(t.welcomeTitle))]):t._e(),t.welcomeDesc?i("v-uni-view",{staticClass:"desc",domProps:{innerHTML:t._s(t.welcomeDesc)}}):t._e(),t.welcomeTips.length>0?i("v-uni-view",{staticClass:"tips"},[i("ul",t._l(t.welcomeTips,(function(e){return e?i("li",{on:{click:function(i){arguments[0]=i=t.$handleEvent(i),t.quickMessage(e)}}},[t._v(t._s(e))]):t._e()})),0)]):t._e()],1)],1)],1)],1)},n=[]},da0a:function(t,e,i){var a=i("f7c9");a.__esModule&&(a=a.default),"string"===typeof a&&(a=[[t.i,a,""]]),a.locals&&(t.exports=a.locals);var n=i("4f06").default;n("7bf805d8",a,!0,{sourceMap:!1,shadowMode:!1})},e237:function(t,e,i){"use strict";var a=i("1a6f"),n=i.n(a);n.a},e86b:function(t,e,i){"use strict";(function(t){i("7a82");var a=i("4ea4").default;Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var n=a(i("c7eb")),s=a(i("1da1"));i("a9e3"),i("ac1f"),i("5319"),i("498a"),i("14d9"),i("d3b7"),i("e9c4"),i("8a79"),i("c975"),i("e25e"),i("caad");var o=a(i("acd4")),r=a(i("4050"));i("45ab"),i("485c"),i("e1a1"),i("9283");var c=getApp(),l={components:{TextComponent:o.default,Welcome:r.default},props:{aiName:{type:String,default:""},aiIndex:{type:Number,default:0},activeAiIndex:{type:Number,default:0},roleId:{type:Number,default:0},welcome:{type:Object,default:{}},userAvatar:{type:String,default:"/static/img/ic_user.png"},aiAvatar:{type:String,default:"/static/img/ic_ai.png"}},watch:{activeAiIndex:{handler:function(){this.aiIndex>=this.activeAiIndex-1&&this.aiIndex<=this.activeAiIndex+1&&null===this.lists&&this.getHistoryMsg()},immediate:!0}},data:function(){return{siteroot:"",lists:null,message:"",writingText:"",writing:!1,page:1,pagesize:10,scrollTop:0,copyBtnLeft:-200,copyBtnTop:0,copyBtnText:"",copyBtnTime:0,textStacks:[],textOutputSi:0,fetchCtrl:null}},mounted:function(){this.setData({siteroot:c.globalData.siteroot.replace("/web.php","")})},methods:{sendText:function(t){var e=this;return(0,s.default)((0,n.default)().mark((function i(){var a,s,o,r,l,u,d,f,p,g,h,v,m,b;return(0,n.default)().wrap((function(i){while(1)switch(i.prev=i.next){case 0:if(!e.writing){i.next=2;break}return i.abrupt("return");case 2:if(t=e.trim(t),t){i.next=6;break}return c.globalData.util.message("请输入你的问题"),i.abrupt("return");case 6:return e.textOutputSi&&(clearInterval(e.textOutputSi),e.textOutputSi=0,e.textStacks=[]),e.lists.push({user:"我",message:t}),e.setMessage(""),e.writing=!0,e.scrollToBottom(),a=new Headers,a.append("Content-Type","application/json"),a.append("X-site",uni.getStorageSync("sitecode")),s=e.siteroot+"/web.php/chat/sendText",o={ai:e.aiName,role_id:e.roleId,message:t},e.fetchCtrl=new AbortController,i.next=19,fetch(s,{method:"POST",signal:e.fetchCtrl.signal,headers:a,body:JSON.stringify(o)});case 19:if(r=i.sent,r.ok){i.next=24;break}return e.writing=!1,c.globalData.util.message(r.statusText),i.abrupt("return");case 24:l=r.body.getReader(),u=new TextDecoder("utf-8"),d=!1,f="",e.textOutputSi=setInterval((function(){e.textStacks.length>0?(e.writingText+=e.textStacks.shift(),e.scrollToBottom()):e.writing||(clearInterval(e.textOutputSi),e.textOutputSi=0,e.writingText&&e.lists.push({user:"AI",message:e.writingText}),e.writingText="",setTimeout((function(){e.scrollToBottom()}),200))}),20);case 29:if(d){i.next=53;break}return e.scrollToBottom(),i.next=33,l.read();case 33:if(p=i.sent,g=p.value,h=p.done,!g){i.next=50;break}if(v=u.decode(g),"\n"!==v||!f.endsWith("\n")){i.next=40;break}return i.abrupt("continue",29);case 40:if(!v){i.next=50;break}if(-1===v.indexOf("[error]")){i.next=48;break}return e.writing=!1,e.writingText="",e.lists.pop(),m=v.replace("[error]",""),-1!==m.indexOf("请登录")?(e.setMessage(t),c.globalData.util.toLogin(m)):-1!==m.indexOf("请充值")?c.globalData.util.message(m,"error",(function(){this.toPay()})):c.globalData.util.message(m,"error"),i.abrupt("break",53);case 48:for(e.writing=!0,b=0;b<v.length;b++)e.textStacks.push(v[b]);case 50:d=h,i.next=29;break;case 53:e.writing=!1;case 54:case"end":return i.stop()}}),i)})))()},stopFetch:function(){var e=this,i=this.writingText;this.writing=!1,t("log","stopFetch",this.aiIndex," at components/cosplayMsgList/cosplayMsgList.vue:259"),this.fetchCtrl.abort(),setTimeout((function(){i||e.lists.pop()}),50)},retry:function(t){var e=this;uni.showModal({title:this.$lang("提示"),content:this.$lang("确定重新回答吗？"),confirmText:this.$lang("确定"),cancelText:this.$lang("取消"),success:function(i){i.confirm&&e.sendText(e.lists[t].message)}})},setMessage:function(t){this.$emit("setMessage",t)},getHistoryMsg:function(){var t=this;c.globalData.util.request({url:"/chat/getHistoryMsg",data:{ai:this.aiName,role_id:this.roleId,page:this.page,pagesize:this.pagesize},loading:!1}).then((function(e){t.setData({lists:e.data.list}),t.$nextTick((function(){setTimeout((function(){t.scrollToBottom()}),300)}))}))},scrollToBottom:function(){var t=this;setTimeout((function(){var e=uni.createSelectorQuery().in(t);e.select(".list").boundingClientRect((function(e){e&&t.setData({scrollTop:parseInt(e.height)})})),e.exec((function(t){}))}),200)},copyText:function(t){var e=document.createElement("textarea");e.value=t,e.readOnly="readOnly",e.style="width:0;height:0;",document.body.appendChild(e),e.select(),e.setSelectionRange(0,t.length),c.globalData.util.message("已复制"),document.execCommand("copy"),e.remove(),this.hideCopyBtn()},quickMessage:function(t){this.$emit("setMessage",t)},showCopyBtn:function(t){var e=this,i=uni.createSelectorQuery().in(this);i.select(".list").boundingClientRect((function(i){if(i){var a=parseInt(t.touches[0].pageX),n=parseInt(t.touches[0].pageY-i.top);n<0&&(n+=70),e.copyBtnLeft=a-30,e.copyBtnTop=n-60,e.copyBtnText=t.currentTarget.dataset.text,e.copyBtnTime=e.getTime()}})),i.exec((function(t){}))},getTime:function(){return(new Date).getTime()},hideCopyBtn:function(){var t=this.getTime();this.copyBtnLeft>0&&t-this.copyBtnTime>500&&(this.copyBtnLeft=-200,this.copyBtnText="",this.copyBtnTime=0)},trim:function(t){return t.replace(/(^\s*)|(\s*$)/g,"")},isGpt4:function(t){return["openai4","azure_openai4","wenxin4","claude2","hunyuan4"].includes(t)},toPay:function(){this.isGpt4(this.aiName)?uni.navigateTo({url:"/pages/pay/model4"}):uni.navigateTo({url:"/pages/pay/pay"})}}};e.default=l}).call(this,i("0de9")["log"])},e9de:function(t,e,i){"use strict";i("7a82"),Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0,i("ac1f"),i("5319"),i("5b81");var a={props:{module:{type:String,default:"chat"},hasModel4:{type:Boolean,default:!1},title:{type:String,default:""},desc:{type:String,default:""},tips:{type:String,default:""}},computed:{welcomeTitle:function(){return this.title?"chat"===this.module?this.$lang("你好！我是")+this.title:"cosplay"===this.module?this.$lang("我是")+this.title:this.title:""},welcomeDesc:function(){return this.desc?this.desc.replaceAll("\n","<br>"):"cosplay"===this.module?this.$lang("请输入你的问题"):""},welcomeTips:function(){return this.tips?this.tips.split("\n"):[]}},methods:{quickMessage:function(t){this.$emit("use",t)}}};e.default=a},f7c9:function(t,e,i){var a=i("24fb");e=a(!1),e.push([t.i,".msg-list[data-v-0ea913b8]{width:100%;height:100%;top:0;bottom:%?132?%;left:0;box-sizing:border-box;overflow:hidden}.message[data-v-0ea913b8]{display:flex;justify-content:flex-start;padding:%?40?% %?40?%;border-top:%?2?% solid #eee}.message[data-v-0ea913b8]:last-child{border-bottom:0}.message .text[data-v-0ea913b8]{width:100%;color:#343541;line-height:%?52?%;font-size:%?32?%;word-break:break-all;padding:%?4?% 0;overflow:hidden}.message .text span[data-v-0ea913b8]{display:inline}.message .avatar[data-v-0ea913b8]{width:%?48?%;height:%?48?%;background:#04babe;margin-right:%?30?%;color:#fff;font-size:%?28?%;border-radius:%?4?%;display:flex;align-items:center;justify-content:center;margin-top:%?6?%;overflow:hidden}.message .avatar uni-image[data-v-0ea913b8],\n.message .avatar img[data-v-0ea913b8]{width:%?48?%;height:%?48?%}.btn-copy[data-v-0ea913b8]{position:absolute;width:%?120?%;height:%?60?%;line-height:%?60?%;color:#04babe;z-index:99;background:#fff;text-align:center;border-radius:%?10?%;font-size:%?28?%;box-shadow:0 0 %?20?% rgba(0,0,0,.2)}.tools[data-v-0ea913b8]{display:flex;align-items:center;justify-content:space-between;margin-top:%?12?%}.tools .btn[data-v-0ea913b8]{font-size:%?32?%;color:#04babe;display:flex;align-items:center;float:left;margin-right:%?10?%}.tools .btn[data-v-0ea913b8]:active{opacity:.6}.tools .btn .icon[data-v-0ea913b8]{width:%?32?%;height:%?32?%;margin-right:%?6?%}",""]),t.exports=e},fd89:function(t,e,i){var a=i("24fb");e=a(!1),e.push([t.i,'@charset "UTF-8";\r\n/**\r\n * 这里是uni-app内置的常用样式变量\r\n *\r\n * uni-app 官方扩展插件及插件市场（https://ext.dcloud.net.cn）上很多三方插件均使用了这些样式变量\r\n * 如果你是插件开发者，建议你使用scss预处理，并在插件代码中直接使用这些变量（无需 import 这个文件），方便用户通过搭积木的方式开发整体风格一致的App\r\n *\r\n */\r\n/**\r\n * 如果你是App开发者（插件使用者），你可以通过修改这些变量来定制自己的插件主题，实现自定义主题功能\r\n *\r\n * 如果你的项目同样使用了scss预处理，你也可以直接在你的 scss 代码中使用如下变量，同时无需 import 这个文件\r\n */\r\n/* 颜色变量 */\r\n/* 行为相关颜色 */\r\n/* 文字基本颜色 */\r\n/* 背景颜色 */\r\n/* 边框颜色 */\r\n/* 尺寸变量 */\r\n/* 文字尺寸 */\r\n/* 图片尺寸 */\r\n/* Border Radius */\r\n/* 水平间距 */\r\n/* 垂直间距 */\r\n/* 透明度 */\r\n/* 文章场景相关 */.welcome .message[data-v-24a61342]{display:flex;justify-content:flex-start;padding:%?40?% %?40?%}.welcome .message[data-v-24a61342]:last-child{border-bottom:0}.welcome .message .text[data-v-24a61342]{width:%?560?%;color:#343541;line-height:%?52?%;font-size:%?32?%;word-break:break-all;overflow:hidden;background-color:#fff;padding:%?30?%;border-radius:%?20?%}.welcome .message .text span[data-v-24a61342]{display:inline}.welcome .message .avatar[data-v-24a61342]{width:%?48?%;height:%?48?%;background:#04babe;margin-right:%?30?%;color:#fff;font-size:%?28?%;border-radius:%?4?%;display:flex;align-items:center;justify-content:center;margin-top:%?6?%;overflow:hidden}.welcome .message .avatar uni-image[data-v-24a61342],\r\n.welcome .message .avatar img[data-v-24a61342]{width:%?48?%;height:%?48?%}.welcome .markdown-body uni-view[data-v-24a61342]{display:block}.welcome .title[data-v-24a61342]{color:#222;font-size:%?36?%;font-weight:600;letter-spacing:%?2?%;line-height:%?64?%;transition:color .1s ease-in-out}.welcome .desc[data-v-24a61342]{margin:%?20?% 0!important}.welcome .tips[data-v-24a61342]{padding:%?20?%}.welcome .tips ul[data-v-24a61342],\r\n.welcome .tips li[data-v-24a61342]{list-style:none;margin:0;padding:0}.welcome .tips li[data-v-24a61342]{background:#f7f7f8;border-radius:%?8?%;margin-bottom:%?26?%;padding:%?24?% %?30?%;font-size:%?28?%;color:#444;line-height:%?32?%;transition:background .1s ease-in-out;cursor:pointer;display:flex;justify-content:space-between;align-items:center}.welcome .tips li[data-v-24a61342]:hover, .welcome .tips li[data-v-24a61342]:active{background:#eff0f0;color:#222}',""]),t.exports=e}}]);