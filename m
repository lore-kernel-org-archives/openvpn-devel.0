From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 16 Apr 2025 13:48:29 +0000
In-Reply-To: <gerrit.1730386897000.I2566ad493629e1f5fdfa6f6483b8973463404e3e@...2715...>
References: <gerrit.1730386897000.I2566ad493629e1f5fdfa6f6483b8973463404e3e@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...
Message-ID: <c55d0ae6f9cb3a123ec44bc983725e596dc1cbba-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X4QD1OC4Uf8="; charset=UTF-8
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
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--X4QD1OC4Uf8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/791?usp=3Demail )

Change subject: Reformat the whole project with clang-format
......................................................................


Patch Set 16:

(4 comments)

File sample/sample-plugins/client-connect/sample-client-connect.c:

http://gerrit.openvpn.net/c/openvpn/+/791/comment/763d178b_37f47877 :
PS14, Line 251:                    MODULE,
> So basically what you want is "BinPackArguments: true", will apply that.
Done


File sample/sample-plugins/defer/multi-auth.c:

http://gerrit.openvpn.net/c/openvpn/+/791/comment/e720aaa5_9dff2c4a :
PS14, Line 267:          np(context->test_valid_user),
> I'd vote for putting these arguments on the same line, if there is enough=
 space.
Done


http://gerrit.openvpn.net/c/openvpn/+/791/comment/6d71e7fc_faa3fc2d :
PS14, Line 418:     plog(context, PLOG_NOTE, "FUNC: openvpn_plugin_client_c=
onstructor_v1");
> Doesn't seem to be supported. There is a feature request for it: https://=
github. [=E2=80=A6]
Acknowledged


File sample/sample-plugins/log/log_v3.c:

http://gerrit.openvpn.net/c/openvpn/+/791/comment/5a59375c_600cff63 :
PS14, Line 87:             "log_v3: ** ERROR ** Incompatible plug-in interf=
ace between this plug-in and OpenVPN\n");
> yes
Acknowledged



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/791?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2566ad493629e1f5fdfa6f6483b8973463404e3e
Gerrit-Change-Number: 791
Gerrit-PatchSet: 16
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <antonio@...2726...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Comment-Date: Wed, 16 Apr 2025 13:48:29 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: ordex <antonio@...2726...>
Gerrit-MessageType: comment

--X4QD1OC4Uf8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: ordex, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/791?usp=3Demail">View C=
hange</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File sample/sample-plugins/client-c=
onnect/sample-client-connect.c:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/791/comment/763d17=
8b_37f47877">Patch Set #14, Line 251:</a> <code style=3D"font-family:monosp=
ace,monospace">                   MODULE,</code></p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">So basicall=
y what you want is &quot;BinPackArguments: true&quot;, will apply that.</bl=
ockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Don=
e</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sample/sam=
ple-plugins/defer/multi-auth.c:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/791/comment/e720aa=
a5_9dff2c4a">Patch Set #14, Line 267:</a> <code style=3D"font-family:monosp=
ace,monospace">         np(context-&gt;test_valid_user),</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">I&#39;d vote for putting these arguments on the same line, if there is =
enough space.</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/791/comment/6d71e7fc_faa3fc2d">Patch Set #14, Line 418:</a> <code styl=
e=3D"font-family:monospace,monospace">    plog(context, PLOG_NOTE, &quot;FU=
NC: openvpn_plugin_client_constructor_v1&quot;);</code></p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Does=
n&#39;t seem to be supported. There is a feature request for it: https://gi=
thub. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Acknowledged</p></li></ul></li><li style=3D"margin: 0; pa=
dding: 0;"><p>File sample/sample-plugins/log/log_v3.c:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/791/comment/5a59375c_600cff63">Patch Set #14, Line 87:</a> <code style=
=3D"font-family:monospace,monospace">            &quot;log_v3: ** ERROR ** =
Incompatible plug-in interface between this plug-in and OpenVPN\n&quot;);</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">yes</blockquote></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Acknowledged</p></li></ul></li></ul><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/791?usp=3Demail">chang=
e 791</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/791?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2566ad493629e1f5fdfa6f6483b=
8973463404e3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 791 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 16 </div>
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
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 16 Apr 2025 13:48:29=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;antonio@...2787...=
...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--X4QD1OC4Uf8=--

