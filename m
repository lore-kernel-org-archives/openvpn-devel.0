From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 16 Apr 2025 11:47:43 +0000
In-Reply-To: <gerrit.1730386897000.I2566ad493629e1f5fdfa6f6483b8973463404e3e@...2715...>
References: <gerrit.1730386897000.I2566ad493629e1f5fdfa6f6483b8973463404e3e@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...
Message-ID: <ef5db63937b43b629b677cccbc499d87d8e5b470-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AdtAq7s96qk="; charset=UTF-8
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

--AdtAq7s96qk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/791?usp=3Demail )

Change subject: Reformat the whole project with clang-format
......................................................................


Patch Set 14:

(6 comments)

File sample/sample-plugins/client-connect/sample-client-connect.c:

http://gerrit.openvpn.net/c/openvpn/+/791/comment/1bf6c87b_4e6169ab :
PS14, Line 135:             stderr,
> this hurts me a bit, for two reasons: [=E2=80=A6]
Not quite sure why it doesn't align to "(", it does for almost all other oc=
curences. I think it might have a trade-off here between trying to align an=
d trying to get the string in the colum limit.


http://gerrit.openvpn.net/c/openvpn/+/791/comment/4cf494a4_79f7b8ce :
PS14, Line 251:                    MODULE,
> same as above, I expected MODULE to be on the line above [=E2=80=A6]
So basically what you want is "BinPackArguments: true", will apply that.


http://gerrit.openvpn.net/c/openvpn/+/791/comment/d9dba330_b8c72914 :
PS14, Line 252:                    "env has UV_WANT_CC_ASYNC=3D%d, but "
> here there is a more generic question to answer: do we want to keep strin=
g on the same line, even if [=E2=80=A6]
Has nothing to do with this patch though, AFAICT


File sample/sample-plugins/defer/multi-auth.c:

http://gerrit.openvpn.net/c/openvpn/+/791/comment/8b72fd16_d619cd73 :
PS14, Line 294:                       const char *envp[])
> ratio behind this change? one arg per line?
yes. This is BinPackParameters. Do you also want that set to "true"?


http://gerrit.openvpn.net/c/openvpn/+/791/comment/d94e4661_457ff043 :
PS14, Line 418:     plog(context, PLOG_NOTE, "FUNC: openvpn_plugin_client_c=
onstructor_v1");
> how about forcing a new line after variables declaration?
Doesn't seem to be supported. There is a feature request for it: https://gi=
thub.com/llvm/llvm-project/issues/97303


File sample/sample-plugins/log/log_v3.c:

http://gerrit.openvpn.net/c/openvpn/+/791/comment/c9c800e4_6ecdeccd :
PS14, Line 87:             "log_v3: ** ERROR ** Incompatible plug-in interf=
ace between this plug-in and OpenVPN\n");
> this is probably another instance of the same situation as before.
yes



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
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Comment-Date: Wed, 16 Apr 2025 11:47:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: ordex <antonio@...2726...>
Gerrit-MessageType: comment

--AdtAq7s96qk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: ordex, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/791?usp=3Demail">View C=
hange</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File sample/sample-plugins/client-c=
onnect/sample-client-connect.c:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/791/comment/1bf6c8=
7b_4e6169ab">Patch Set #14, Line 135:</a> <code style=3D"font-family:monosp=
ace,monospace">            stderr,</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">this hurts me a bi=
t, for two reasons: [=E2=80=A6]</blockquote></p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Not quite sure why it doesn&#39;t align to =
&quot;(&quot;, it does for almost all other occurences. I think it might ha=
ve a trade-off here between trying to align and trying to get the string in=
 the colum limit.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/791/comment/4cf494a4_79f7b8ce">Patch Set #14, Line 251:</a> <code style=
=3D"font-family:monospace,monospace">                   MODULE,</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">same as above, I expected MODULE to be on the line above [=E2=80=
=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">So basically what you want is &quot;BinPackArguments: true&quot;, will=
 apply that.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/7=
91/comment/d9dba330_b8c72914">Patch Set #14, Line 252:</a> <code style=3D"f=
ont-family:monospace,monospace">                   &quot;env has UV_WANT_CC=
_ASYNC=3D%d, but &quot;</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">here there is a more generic =
question to answer: do we want to keep string on the same line, even if [=
=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Has nothing to do with this patch though, AFAICT</p></li></ul></=
li><li style=3D"margin: 0; padding: 0;"><p>File sample/sample-plugins/defer=
/multi-auth.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/791/comment/8b72fd16_d619cd73">Pa=
tch Set #14, Line 294:</a> <code style=3D"font-family:monospace,monospace">=
                      const char *envp[])</code></p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">ratio behin=
d this change? one arg per line?</blockquote></p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">yes. This is BinPackParameters. Do you als=
o want that set to &quot;true&quot;?</p></li><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/791/comment/d94e4661_457ff043">Patch Set #14, Line 4=
18:</a> <code style=3D"font-family:monospace,monospace">    plog(context, P=
LOG_NOTE, &quot;FUNC: openvpn_plugin_client_constructor_v1&quot;);</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">how about forcing a new line after variables declaration?</bl=
ockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Doe=
sn&#39;t seem to be supported. There is a feature request for it: https://g=
ithub.com/llvm/llvm-project/issues/97303</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File sample/sample-plugins/log/log_v3.c:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/791/comment/c9c800e4_6ecdeccd">Patch Set #14, Line 87:</a> <=
code style=3D"font-family:monospace,monospace">            &quot;log_v3: **=
 ERROR ** Incompatible plug-in interface between this plug-in and OpenVPN\n=
&quot;);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">this is probably another instance of the sam=
e situation as before.</blockquote></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">yes</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/791?usp=3Demail">change 791</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/791?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 16 Apr 2025 11:47:43=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;antonio@...2787...=
...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--AdtAq7s96qk=--

