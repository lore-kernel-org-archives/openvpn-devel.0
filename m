From: "ordex (Code Review)" <gerrit@...515...>
Date: Mon, 14 Apr 2025 19:21:32 +0000
In-Reply-To: <gerrit.1730386897000.I2566ad493629e1f5fdfa6f6483b8973463404e3e@...2715...>
References: <gerrit.1730386897000.I2566ad493629e1f5fdfa6f6483b8973463404e3e@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c1da80fbdc6a6796e849defdfd64d8c7247dfd41-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VZecLjCb77U="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Reformat the whole
 project with clang-format
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VZecLjCb77U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

ordex has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/791?usp=3Demail )

Change subject: Reformat the whole project with clang-format
......................................................................


Patch Set 14:

(8 comments)

Patchset:

PS14:
the change is extremely long, so not easy to comment to everything, but I t=
hrew a few concerns worth checking.


File sample/sample-plugins/client-connect/sample-client-connect.c:

http://gerrit.openvpn.net/c/openvpn/+/791/comment/c6e0d1ce_30cbe3ba :
PS14, Line 135:             stderr,
this hurts me a bit, for two reasons:
1) "stderr," should just stay on the same line as fprintf, given that there=
 is enough space;
2) when going to a new line, I personally prefer to see the text aligned to=
 the opening parenthesis.


http://gerrit.openvpn.net/c/openvpn/+/791/comment/27a22e79_01461376 :
PS14, Line 251:                    MODULE,
same as above, I expected MODULE to be on the line above

NOTE: I won't report any other occurrence of this in the rest of the patch


http://gerrit.openvpn.net/c/openvpn/+/791/comment/3682efec_128649c3 :
PS14, Line 252:                    "env has UV_WANT_CC_ASYNC=3D%d, but "
here there is a more generic question to answer: do we want to keep string =
on the same line, even if they are too long?
Pro being that the casual reader could be reasonably able to grep an error =
message (with some magic, due to format patterns).


File sample/sample-plugins/defer/multi-auth.c:

http://gerrit.openvpn.net/c/openvpn/+/791/comment/e5889e88_f1a4caaa :
PS14, Line 267:          np(context->test_valid_user),
I'd vote for putting these arguments on the same line, if there is enough s=
pace.


http://gerrit.openvpn.net/c/openvpn/+/791/comment/8f6e4102_5edbebdb :
PS14, Line 294:                       const char *envp[])
ratio behind this change? one arg per line?


http://gerrit.openvpn.net/c/openvpn/+/791/comment/99dbd0d9_8682fdd3 :
PS14, Line 418:     plog(context, PLOG_NOTE, "FUNC: openvpn_plugin_client_c=
onstructor_v1");
how about forcing a new line after variables declaration?


File sample/sample-plugins/log/log_v3.c:

http://gerrit.openvpn.net/c/openvpn/+/791/comment/c1025c39_05185d3b :
PS14, Line 87:             "log_v3: ** ERROR ** Incompatible plug-in interf=
ace between this plug-in and OpenVPN\n");
this is probably another instance of the same situation as before.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/791?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2566ad493629e1f5fdfa6f6483b8973463404e3e
Gerrit-Change-Number: 791
Gerrit-PatchSet: 14
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <antonio@...2726...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 14 Apr 2025 19:21:32 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--VZecLjCb77U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/791?usp=3Demail">View C=
hange</a></p><p>8 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
791?tab=3Dcomments">Patch Set #14:</a> </p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">the change is extremely long, so not easy to com=
ment to everything, but I threw a few concerns worth checking.</p></li></ul=
></li><li style=3D"margin: 0; padding: 0;"><p>File sample/sample-plugins/cl=
ient-connect/sample-client-connect.c:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/791/comment/=
c6e0d1ce_30cbe3ba">Patch Set #14, Line 135:</a> <code style=3D"font-family:=
monospace,monospace">            stderr,</code></p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">this hurts me a bit, for two reasons:<br=
>1) &quot;stderr,&quot; should just stay on the same line as fprintf, given=
 that there is enough space;<br>2) when going to a new line, I personally p=
refer to see the text aligned to the opening parenthesis.</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/791/comment/27a22e79_01461376">=
Patch Set #14, Line 251:</a> <code style=3D"font-family:monospace,monospace=
">                   MODULE,</code></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">same as above, I expected MODULE to be on the line a=
bove</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">NOTE: I =
won&#39;t report any other occurrence of this in the rest of the patch</p><=
/li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/791/comment/3682ef=
ec_128649c3">Patch Set #14, Line 252:</a> <code style=3D"font-family:monosp=
ace,monospace">                   &quot;env has UV_WANT_CC_ASYNC=3D%d, but =
&quot;</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>here there is a more generic question to answer: do we want to keep string=
 on the same line, even if they are too long?<br>Pro being that the casual =
reader could be reasonably able to grep an error message (with some magic, =
due to format patterns).</p></li></ul></li><li style=3D"margin: 0; padding:=
 0;"><p>File sample/sample-plugins/defer/multi-auth.c:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/791/comment/e5889e88_f1a4caaa">Patch Set #14, Line 267:</a> <code styl=
e=3D"font-family:monospace,monospace">         np(context-&gt;test_valid_us=
er),</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I=
&#39;d vote for putting these arguments on the same line, if there is enoug=
h space.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/791/c=
omment/8f6e4102_5edbebdb">Patch Set #14, Line 294:</a> <code style=3D"font-=
family:monospace,monospace">                      const char *envp[])</code=
></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">ratio behin=
d this change? one arg per line?</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/791/comment/99dbd0d9_8682fdd3">Patch Set #14, Line 418:<=
/a> <code style=3D"font-family:monospace,monospace">    plog(context, PLOG_=
NOTE, &quot;FUNC: openvpn_plugin_client_constructor_v1&quot;);</code></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">how about forcing =
a new line after variables declaration?</p></li></ul></li><li style=3D"marg=
in: 0; padding: 0;"><p>File sample/sample-plugins/log/log_v3.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/791/comment/c1025c39_05185d3b">Patch Set #14, Line 87:</a> <c=
ode style=3D"font-family:monospace,monospace">            &quot;log_v3: ** =
ERROR ** Incompatible plug-in interface between this plug-in and OpenVPN\n&=
quot;);</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">this is probably another instance of the same situation as before.</p></l=
i></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/791?usp=3Demail">change 791</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/791?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2566ad493629e1f5fdfa6f6483b=
8973463404e3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 791 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 14 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@...2726...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 14 Apr 2025 19:21:32=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--VZecLjCb77U=--

