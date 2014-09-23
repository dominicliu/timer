Ember.TEMPLATES["application"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Ember.Handlebars.helpers); data = data || {};
  var buffer = '', stack1;


  data.buffer.push("<div class=\"container\">\r\n	");
  stack1 = helpers._triageMustache.call(depth0, "outlet", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["ID"],data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("\r\n</div>");
  return buffer;
  
});

Ember.TEMPLATES["index"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Ember.Handlebars.helpers); data = data || {};
  var buffer = '', stack1, helper, options, escapeExpression=this.escapeExpression, helperMissing=helpers.helperMissing, self=this;

function program1(depth0,data) {
  
  var buffer = '';
  data.buffer.push("\r\n		<button ");
  data.buffer.push(escapeExpression(helpers.action.call(depth0, "start", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["STRING"],data:data})));
  data.buffer.push(">start</button>\r\n	");
  return buffer;
  }

function program3(depth0,data) {
  
  var buffer = '';
  data.buffer.push("\r\n		<button ");
  data.buffer.push(escapeExpression(helpers.action.call(depth0, "pause", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["STRING"],data:data})));
  data.buffer.push(">pause</button>\r\n	");
  return buffer;
  }

function program5(depth0,data) {
  
  var buffer = '';
  data.buffer.push("\r\n		<button ");
  data.buffer.push(escapeExpression(helpers.action.call(depth0, "stop", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["STRING"],data:data})));
  data.buffer.push(">stop</button>\r\n		<button ");
  data.buffer.push(escapeExpression(helpers.action.call(depth0, "restart", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["STRING"],data:data})));
  data.buffer.push(">restart</button>\r\n	");
  return buffer;
  }

function program7(depth0,data) {
  
  var buffer = '', helper, options;
  data.buffer.push("\r\n		");
  data.buffer.push(escapeExpression((helper = helpers.input || (depth0 && depth0.input),options={hash:{
    'type': ("checkbox"),
    'checked': ("notification"),
    'id': ("notification")
  },hashTypes:{'type': "STRING",'checked': "ID",'id': "STRING"},hashContexts:{'type': depth0,'checked': depth0,'id': depth0},contexts:[],types:[],data:data},helper ? helper.call(depth0, options) : helperMissing.call(depth0, "input", options))));
  data.buffer.push("\r\n		<label for=\"notification\">notification</label>\r\n	");
  return buffer;
  }

  data.buffer.push("<div class=\"text-center\">\r\n<h1>timer</h1>\r\n<table>\r\n	<tr>\r\n		<td>");
  data.buffer.push(escapeExpression((helper = helpers.input || (depth0 && depth0.input),options={hash:{
    'type': ("text"),
    'value': ("hours"),
    'id': ("hours"),
    'disabled': ("running"),
    'insert-newline': ("start")
  },hashTypes:{'type': "STRING",'value': "ID",'id': "STRING",'disabled': "ID",'insert-newline': "STRING"},hashContexts:{'type': depth0,'value': depth0,'id': depth0,'disabled': depth0,'insert-newline': depth0},contexts:[],types:[],data:data},helper ? helper.call(depth0, options) : helperMissing.call(depth0, "input", options))));
  data.buffer.push("</td>\r\n		<td class=\"colon\">:</td>\r\n		<td>");
  data.buffer.push(escapeExpression((helper = helpers['focus-input'] || (depth0 && depth0['focus-input']),options={hash:{
    'type': ("text"),
    'value': ("minutes"),
    'id': ("minutes"),
    'disabled': ("running"),
    'insert-newline': ("start")
  },hashTypes:{'type': "STRING",'value': "ID",'id': "STRING",'disabled': "ID",'insert-newline': "STRING"},hashContexts:{'type': depth0,'value': depth0,'id': depth0,'disabled': depth0,'insert-newline': depth0},contexts:[],types:[],data:data},helper ? helper.call(depth0, options) : helperMissing.call(depth0, "focus-input", options))));
  data.buffer.push("</td>\r\n		<td class=\"colon\">:</td>\r\n		<td>");
  data.buffer.push(escapeExpression((helper = helpers.input || (depth0 && depth0.input),options={hash:{
    'type': ("text"),
    'value': ("seconds"),
    'id': ("seconds"),
    'disabled': ("running"),
    'insert-newline': ("start")
  },hashTypes:{'type': "STRING",'value': "ID",'id': "STRING",'disabled': "ID",'insert-newline': "STRING"},hashContexts:{'type': depth0,'value': depth0,'id': depth0,'disabled': depth0,'insert-newline': depth0},contexts:[],types:[],data:data},helper ? helper.call(depth0, options) : helperMissing.call(depth0, "input", options))));
  data.buffer.push("</td>\r\n	</tr>\r\n	<tr>\r\n		<td class=\"caption\">hours</td>\r\n		<td></td>\r\n		<td class=\"caption\">minutes</td>\r\n		<td></td>\r\n		<td class=\"caption\">seconds</td>\r\n	</tr>\r\n</table>\r\n<p>\r\n	");
  stack1 = helpers.unless.call(depth0, "running", {hash:{},hashTypes:{},hashContexts:{},inverse:self.program(3, program3, data),fn:self.program(1, program1, data),contexts:[depth0],types:["ID"],data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("\r\n	");
  stack1 = helpers['if'].call(depth0, "runningOrPaused", {hash:{},hashTypes:{},hashContexts:{},inverse:self.noop,fn:self.program(5, program5, data),contexts:[depth0],types:["ID"],data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("\r\n	<button ");
  data.buffer.push(escapeExpression(helpers.action.call(depth0, "snooze", {hash:{},hashTypes:{},hashContexts:{},contexts:[depth0],types:["STRING"],data:data})));
  data.buffer.push(">snooze</button>\r\n</p>\r\n<p>\r\n	");
  stack1 = helpers.unless.call(depth0, "notificationDenied", {hash:{},hashTypes:{},hashContexts:{},inverse:self.noop,fn:self.program(7, program7, data),contexts:[depth0],types:["ID"],data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("\r\n</p>\r\n<p class=\"copyright\">© 2014 Dominic Liu</p>");
  return buffer;
  
});