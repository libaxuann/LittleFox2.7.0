(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["pages-user-index"],{"0b2c":function(t,a,i){var e=i("aafe");e.__esModule&&(e=e.default),"string"===typeof e&&(e=[[t.i,e,""]]),e.locals&&(t.exports=e.locals);var n=i("4f06").default;n("7fb7d91a",e,!0,{sourceMap:!1,shadowMode:!1})},"0c0f":function(t,a,i){"use strict";i("7a82"),Object.defineProperty(a,"__esModule",{value:!0}),a.default=void 0,i("c975");var e=getApp(),n={data:function(){return{isLogin:!1,userinfo:{user_id:0,balance:0,balance_draw:0,balance_gpt4:0},drawIsOpen:!1,hasModel4:!1,model4Name:"高级版"}},onLoad:function(){var t=this;e.globalData.util.getSetting().then((function(a){t.setData({drawIsOpen:a.tabbar[3],hasModel4:a.hasModel4,model4Name:a.model4Name})}))},onShow:function(){uni.setNavigationBarTitle({title:this.$lang("个人中心")}),this.getUserInfo()},computed:{walletItemCount:function(){var t=3;return this.drawIsOpen||t--,this.hasModel4||t--,t}},methods:{getUserInfo:function(){var t=this;e.globalData.util.request({url:"/user/info"}).then((function(a){t.setData({userinfo:a.data,isLogin:!0})})).catch((function(t){403==t.errno&&e.globalData.util.toLogin("请登录")}))},getUserProfile:function(){window.location.href=e.globalData.siteroot+"/h5/getProfile"},getUserPhone:function(t){var a=this;if("getPhoneNumber:ok"!=t.detail.errMsg){var i=t.detail.errMsg;return-1!==i.indexOf("user deny")&&(i="已取消授权"),void e.globalData.util.message(i,"error")}e.globalData.util.request({url:"/user/setUserPhone",data:{encryptedData:t.detail.encryptedData,iv:t.detail.iv}}).then((function(t){a.getUserInfo()}))},linkto:function(t){if(this.isLogin){var a=t.currentTarget.dataset.url;uni.navigateTo({url:a})}else e.globalData.util.toLogin("请登录")},toPay:function(t){this.isLogin?e.globalData.util.toPay(t):e.globalData.util.toLogin("请登录")},toTask:function(){this.isLogin?uni.navigateTo({url:"/pages/task/index"}):e.globalData.util.toLogin("请登录")},toSetting:function(){this.isLogin?uni.navigateTo({url:"/pages/user/setting/index"}):e.globalData.util.toLogin("请登录")}}};a.default=n},"56d8":function(t,a,i){"use strict";i.d(a,"b",(function(){return e})),i.d(a,"c",(function(){return n})),i.d(a,"a",(function(){}));var e=function(){var t=this,a=t.$createElement,i=t._self._c||a;return i("v-uni-view",{staticClass:"page"},[i("v-uni-view",{staticClass:"bg-user"},[i("v-uni-view",{staticClass:"userinfo"},[i("v-uni-view",{staticClass:"avatar",on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.toSetting.apply(void 0,arguments)}}},[i("v-uni-image",{attrs:{src:t.userinfo.avatar||"/static/images/avatar.jpg"}})],1),i("v-uni-view",{staticClass:"info",on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.toSetting.apply(void 0,arguments)}}},[i("v-uni-view",{staticClass:"nickname"},[t._v(t._s(t.userinfo.nickname||t.$lang("未设置昵称")))]),i("v-uni-view",{staticClass:"mid",staticStyle:{"padding-left":"2rpx"}},[t._v("MID: "+t._s(t.userinfo.user_id))]),i("v-uni-button",{staticClass:"phone"},[i("v-uni-image",{attrs:{src:"/static/images/user/ic_phone.png"}}),t.userinfo.phone?i("v-uni-text",[t._v(t._s(t.userinfo.phone))]):i("v-uni-text",[t._v(t._s("未绑定手机号"))])],1)],1)],1),i("v-uni-view",{staticClass:"btn-setting",on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.toSetting.apply(void 0,arguments)}}},[i("v-uni-image",{attrs:{src:"/static/images/user/ic_setting.png"}})],1)],1),i("v-uni-view",{staticClass:"box-vip"},[i("v-uni-image",{staticClass:"bg",attrs:{src:"/static/images/user/bg-vip.png"}}),i("v-uni-view",{staticClass:"body"},[i("v-uni-view",{staticStyle:{display:"flex","align-items":"center"}},[i("v-uni-image",{staticClass:"icon",attrs:{src:"/static/images/user/ic_vip.png"}}),i("v-uni-text",[t._v(t._s(t._f("lang")("VIP会员")))]),i("v-uni-view",{staticClass:"line"}),t.userinfo.vip_expire_time?i("v-uni-text",{staticStyle:{"font-size":"24rpx"}},[t._v(t._s(t.userinfo.vip_expire_time)+" "+t._s(t._f("lang")("到期")))]):i("v-uni-text",{staticStyle:{"font-size":"24rpx"}},[t._v(t._s(t._f("lang")("享无限对话特权")))])],1),i("v-uni-view",[t.userinfo.vip_expire_time?i("v-uni-button",{staticClass:"btn-vip",staticStyle:{width:"92rpx"},on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.toPay("vip")}}},[t._v(t._s(t._f("lang")("续费")))]):i("v-uni-button",{staticClass:"btn-vip",on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.toPay("vip")}}},[t._v(t._s(t._f("lang")("立即开通")))])],1)],1)],1),t.walletItemCount>1?i("v-uni-view",{staticClass:"wallet"},[i("v-uni-view",{staticClass:"item",style:"width: "+(2==t.walletItemCount?334:216)+"rpx;",on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.toPay("chat")}}},[i("v-uni-view",[i("v-uni-text",{staticClass:"num"},[t._v(t._s(t.userinfo.balance))]),i("v-uni-text",{staticClass:"unit"},[t._v(t._s(t._f("lang")("条")))])],1),i("v-uni-view",{staticClass:"label"},[t._v(t._s(t._f("lang")("对话余额")))])],1),t.drawIsOpen?i("v-uni-view",{staticClass:"item",style:"width: "+(2==t.walletItemCount?334:216)+"rpx;",on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.toPay("draw")}}},[i("v-uni-view",[i("v-uni-text",{staticClass:"num"},[t._v(t._s(t.userinfo.balance_draw))]),i("v-uni-text",{staticClass:"unit"},[t._v(t._s(t._f("lang")("张")))])],1),i("v-uni-view",{staticClass:"label"},[t._v(t._s(t._f("lang")("绘画余额")))])],1):t._e(),t.hasModel4?i("v-uni-view",{staticClass:"item",style:"width: "+(2==t.walletItemCount?334:216)+"rpx;",on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.toPay("model4")}}},[i("v-uni-view",[i("v-uni-text",{staticClass:"num"},[t._v(t._s(t.userinfo.balance_gpt4))]),i("v-uni-text",{staticClass:"unit"},[t._v(t._s(t._f("lang")("万字")))])],1),i("v-uni-view",{staticClass:"label"},[t._v(t._s(t._f("lang")(t.model4Name+"字数")))])],1):t._e()],1):t._e(),i("v-uni-view",{staticClass:"menus"},[1===t.walletItemCount?i("v-uni-view",{staticClass:"item",on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.toPay("chat")}}},[i("v-uni-text",{staticClass:"text-grey"},[t._v(t._s(t._f("lang")("对话余额")))]),i("v-uni-view",[i("v-uni-text",{staticClass:"value"},[t._v(t._s(t.userinfo.balance)+" 条")]),i("v-uni-image",{staticClass:"arrow",attrs:{src:"/static/images/ic_arrow_r.png"}})],1)],1):t._e(),i("v-uni-view",{staticClass:"item",attrs:{"data-url":"/pages/user/card"},on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.linkto.apply(void 0,arguments)}}},[i("v-uni-text",{staticClass:"text-grey"},[t._v(t._s(t._f("lang")("卡密兑换")))]),i("v-uni-image",{staticClass:"arrow",attrs:{src:"/static/images/ic_arrow_r.png"}})],1),i("v-uni-view",{staticClass:"item",attrs:{"data-url":"/pages/task/index"},on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.linkto.apply(void 0,arguments)}}},[i("v-uni-text",{staticClass:"text-grey"},[t._v(t._s(t._f("lang")("每日任务")))]),i("v-uni-image",{staticClass:"arrow",attrs:{src:"/static/images/ic_arrow_r.png"}})],1)],1),i("v-uni-view",{staticClass:"menus"},[t.userinfo.is_commission?i("v-uni-view",{staticClass:"item",attrs:{"data-url":"/pages/commission/index"},on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.linkto.apply(void 0,arguments)}}},[i("v-uni-text",{staticClass:"text-grey"},[t._v(t._s(t._f("lang")("推广中心")))]),i("v-uni-image",{staticClass:"arrow",attrs:{src:"/static/images/ic_arrow_r.png"}})],1):t._e(),t.userinfo.commission_is_open&&!t.userinfo.is_commission?i("v-uni-view",{staticClass:"item",attrs:{"data-url":"/pages/commission/apply"},on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.linkto.apply(void 0,arguments)}}},[i("v-uni-text",{staticClass:"text-grey"},[t._v(t._s(t._f("lang")("申请推广员")))]),i("v-uni-image",{staticClass:"arrow",attrs:{src:"/static/images/ic_arrow_r.png"}})],1):t._e(),i("v-uni-view",{staticClass:"item",attrs:{"data-url":"/pages/commission/share"},on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.linkto.apply(void 0,arguments)}}},[i("v-uni-text",{staticClass:"text-grey"},[t._v(t._s(t._f("lang")("邀请好友")))]),i("v-uni-image",{staticClass:"arrow",attrs:{src:"/static/images/ic_arrow_r.png"}})],1)],1),i("v-uni-view",{staticClass:"menus",staticStyle:{"margin-bottom":"30rpx"}},[i("v-uni-view",{staticClass:"item",attrs:{"data-url":"/pages/article/list?type=help"},on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.linkto.apply(void 0,arguments)}}},[i("v-uni-text",{staticClass:"text-grey"},[t._v(t._s(t._f("lang")("使用教程")))]),i("v-uni-image",{staticClass:"arrow",attrs:{src:"/static/images/ic_arrow_r.png"}})],1),i("v-uni-view",{staticClass:"item",attrs:{"data-url":"/pages/user/feedback"},on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.linkto.apply(void 0,arguments)}}},[i("v-uni-text",{staticClass:"text-grey"},[t._v(t._s(t._f("lang")("意见反馈")))]),i("v-uni-image",{staticClass:"arrow",attrs:{src:"/static/images/ic_arrow_r.png"}})],1),i("v-uni-view",{staticClass:"item",attrs:{"data-url":"/pages/article/article?type=about"},on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.linkto.apply(void 0,arguments)}}},[i("v-uni-text",{staticClass:"text-grey"},[t._v(t._s(t._f("lang")("关于我们")))]),i("v-uni-image",{staticClass:"arrow",attrs:{src:"/static/images/ic_arrow_r.png"}})],1),i("v-uni-view",{staticClass:"item",attrs:{"data-url":"/pages/article/article?type=kefu"},on:{click:function(a){arguments[0]=a=t.$handleEvent(a),t.linkto.apply(void 0,arguments)}}},[i("v-uni-text",{staticClass:"text-grey"},[t._v(t._s(t._f("lang")("联系客服")))]),i("v-uni-image",{staticClass:"arrow",attrs:{src:"/static/images/ic_arrow_r.png"}})],1)],1)],1)},n=[]},8698:function(t,a,i){"use strict";i.r(a);var e=i("0c0f"),n=i.n(e);for(var s in e)["default"].indexOf(s)<0&&function(t){i.d(a,t,(function(){return e[t]}))}(s);a["default"]=n.a},9918:function(t,a,i){"use strict";var e=i("0b2c"),n=i.n(e);n.a},"9ce0":function(t,a,i){"use strict";i.r(a);var e=i("56d8"),n=i("8698");for(var s in n)["default"].indexOf(s)<0&&function(t){i.d(a,t,(function(){return n[t]}))}(s);i("9918");var o=i("f0c5"),r=Object(o["a"])(n["default"],e["b"],e["c"],!1,null,"af827072",null,!1,e["a"],void 0);a["default"]=r.exports},aafe:function(t,a,i){var e=i("24fb");a=e(!1),a.push([t.i,"uni-page-body[data-v-af827072]{box-sizing:border-box;background:#f7f7f8}body.?%PAGE?%[data-v-af827072]{background:#f7f7f8}.page[data-v-af827072]{position:relative}.bg-user[data-v-af827072]{position:relative;width:100%;left:0;top:0;background:#04babe;height:%?300?%;box-sizing:initial;z-index:1}.userinfo[data-v-af827072]{display:flex;align-items:flex-start;padding:%?50?% 0 0 %?60?%}.userinfo .avatar[data-v-af827072]{width:%?108?%;height:%?108?%;border-radius:%?10?%;overflow:hidden;background-color:#f8f8f8}.userinfo .avatar uni-image[data-v-af827072]{width:100%;height:100%}.userinfo .info[data-v-af827072]{display:flex;flex-direction:column;margin-left:%?30?%}.userinfo .info .nickname[data-v-af827072]{font-size:%?30?%;font-weight:700;color:#fff}.userinfo .info .mid[data-v-af827072]{font-size:%?24?%;color:#fff;line-height:%?52?%}.userinfo .info .phone[data-v-af827072]{color:#fff;background-color:rgba(0,0,0,.2);padding:%?4?% %?8?% %?4?% %?4?%;height:%?36?%;border-radius:%?6?%;display:flex;align-items:center}.userinfo .info .phone uni-image[data-v-af827072]{width:%?28?%;height:%?28?%}.userinfo .info .phone uni-text[data-v-af827072]{font-size:%?22?%}.bg-user .btn-setting[data-v-af827072]{position:absolute;right:%?40?%;top:%?70?%;width:%?56?%;height:%?56?%;padding:%?10?%;border-radius:%?20?%}.bg-user .btn-setting uni-image[data-v-af827072]{width:100%;height:100%}.bg-user .btn-setting[data-v-af827072]:active{background:rgba(0,0,0,.2)}.nologin[data-v-af827072]{display:flex;align-items:center;padding:%?20?% 0 %?60?% %?30?%}.nologin .avatar[data-v-af827072]{width:%?92?%;height:%?92?%}.nologin .avatar uni-image[data-v-af827072]{width:100%;height:100%;border-radius:50%}.nologin .info[data-v-af827072]{display:flex;flex-direction:column;margin-left:%?20?%;align-items:center}.nologin .info .nickname[data-v-af827072]{font-size:%?30?%;font-weight:700;color:#fff}.box-vip[data-v-af827072]{width:%?690?%;height:%?94?%;margin:%?-86?% auto 0 auto;border-style:none;border-width:0;border:none;position:relative}.box-vip .bg[data-v-af827072]{position:absolute;left:0;top:0;width:100%;height:100%;z-index:1}.box-vip .body[data-v-af827072]{position:absolute;left:0;top:0;width:100%;height:100%;z-index:2;font-size:%?24?%;color:#eed196;display:flex;align-items:center;justify-content:space-between;box-sizing:border-box}.box-vip .body .icon[data-v-af827072]{width:%?88?%;height:%?88?%}.box-vip .body .line[data-v-af827072]{margin:0 %?20?%;vertical-align:middle;display:inline-block;width:%?1?%;height:%?32?%;background:rgba(238,209,150,.5)}.box-vip .body .btn-vip[data-v-af827072]{display:flex;justify-content:center;align-items:center;width:%?144?%;height:%?40?%;background:linear-gradient(-90deg,#f1ce80,#ffe8b5);border-radius:%?20?%;font-size:%?24?%;padding:0;margin-right:%?20?%}.wallet[data-v-af827072]{display:flex;justify-content:space-between;align-items:center;overflow:hidden;margin:%?30?%}.wallet .item[data-v-af827072]{text-align:center;line-height:%?48?%;color:#666;font-size:%?28?%;padding:%?18?% 0;border-radius:%?10?%;background:#fff;border-radius:%?20?%;width:%?334?%;box-sizing:border-box}.wallet .item[data-v-af827072]:active{background:#f3f6f9}.wallet .item .num[data-v-af827072]{font-size:%?40?%;color:#04babe;font-weight:700;margin-right:%?10?%;letter-spacing:1px}.wallet .item .unit[data-v-af827072]{font-size:%?28?%;color:#999}.wallet .item .label[data-v-af827072]{color:#666;font-size:%?28?%;letter-spacing:1px;margin-top:%?4?%}.menus[data-v-af827072]{background:#fff;border-radius:%?20?%;padding:%?20?%;margin:%?30?% %?30?% 0 %?30?%}.menus .item[data-v-af827072]{width:100%;padding:%?24?% %?20?% %?24?% %?30?%;border-bottom:1px solid #f3f6f9;display:flex;align-items:center;justify-content:space-between;font-size:%?32?%;color:#444;box-sizing:border-box}.menus .item .value[data-v-af827072]{font-size:%?32?%;margin-right:%?20?%;color:#04babe}.menus .item .arrow[data-v-af827072]{width:%?24?%;height:%?24?%;opacity:.8}.menus .item.button[data-v-af827072]{background:#fff;border:none;outline:none;margin:0;font-size:%?32?%;color:#444;line-height:1em}.menus .item.button[data-v-af827072]::after{display:none}.menus .item[data-v-af827072]:active{background:#fafafa}.menus .item[data-v-af827072]:last-child{border-bottom:0}.text-grey[data-v-af827072]{color:#666}",""]),t.exports=a}}]);