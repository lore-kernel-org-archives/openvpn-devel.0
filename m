From: "mrbff (Code Review)" <gerrit@...515...>
Date: Thu, 28 Nov 2024 15:21:49 +0000
In-Reply-To: <gerrit.1732124549000.I6ecd4cb47571cc8c20e46de8595c742aeec6064a@...2715...>
References: <gerrit.1732124549000.I6ecd4cb47571cc8c20e46de8595c742aeec6064a@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <c4faa112c0e451231a05b2400042b6e5d2506c1b-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VCP4z05lV5k="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: PUSH_UPDATE: Allow
 OpenVPN in client mode to receive and handle PUSH ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VCP4z05lV5k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

mrbff has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/808?usp=3Demail )

Change subject: PUSH_UPDATE: Allow OpenVPN in client mode to receive and ha=
ndle PUSH UPDATE control messages to allow options updating at runtime.
......................................................................


Patch Set 5:

(7 comments)

File CMakeLists.txt:

http://gerrit.openvpn.net/c/openvpn/+/808/comment/8f5a6f36_8362c01a :
PS4, Line 812:
> nit: whitespace
Done


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/808/comment/bd8dd262_1158ed00 :
PS4, Line 2033:             int status =3D do_route(&c->options, c->c1.rout=
e_list, c->c1.route_ipv6_list,
> nice catch!
tnx!


File src/openvpn/options_util.c:

http://gerrit.openvpn.net/c/openvpn/+/808/comment/f8c35b78_8f40c7a2 :
PS4, Line 124: check_push_update_option_flags(char **line, unsigned int *fl=
ags)
> Add doxygen what does this function do.
Done


http://gerrit.openvpn.net/c/openvpn/+/808/comment/a0c306fd_1444ca21 :
PS4, Line 138:         if (str[1])
> below 8 lines are duplicated 3 times. Maybe define a macro and reuse it, =
and later undefine? Like [=E2=80=A6]
Clever, i like it, I tried but when the compiler optimizes it, the code get=
s skipped. Anyway, i simplified and now i use it just 2 times and with a sl=
ightly different condition so i hope is good enough


http://gerrit.openvpn.net/c/openvpn/+/808/comment/a517e1a9_3a38d88f :
PS4, Line 160:     if (c =3D=3D '-' && !(*flags & PUSH_OPT_TO_REMOVE))
> you could remove the "c =3D=3D '-'" check here and move this whole block =
under the "if" condition above
I'm not entirely sure that's what you meant but I simplified


http://gerrit.openvpn.net/c/openvpn/+/808/comment/ada8cdcc_81c709fb :
PS4, Line 221: apply_pull_filter(const struct options *o, char *line, bool =
is_update, unsigned int *push_update_option_flags)
> Let's move doxygen to the header.
Done


File src/openvpn/push.h:

http://gerrit.openvpn.net/c/openvpn/+/808/comment/276f3131_7f2768f9 :
PS4, Line 47: int process_incoming_push_update(struct context *c,
> Doxygen
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6ecd4cb47571cc8c20e46de8595c742aeec6064a
Gerrit-Change-Number: 808
Gerrit-PatchSet: 5
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Thu, 28 Nov 2024 15:21:49 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: stipa <lstipakov@...277...>
Gerrit-MessageType: comment

--VCP4z05lV5k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail">View C=
hange</a></p><p>7 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File CMakeLists.txt:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/808/comment/8f5a6f36_8362c01a">Patch Set #4, Line 812:</a> <co=
de style=3D"font-family:monospace,monospace">    </code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">nit=
: whitespace</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p=
>File src/openvpn/init.c:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/808/comment/bd8dd262_115=
8ed00">Patch Set #4, Line 2033:</a> <code style=3D"font-family:monospace,mo=
nospace">            int status =3D do_route(&amp;c-&gt;options, c-&gt;c1.r=
oute_list, c-&gt;c1.route_ipv6_list,</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">nice catch!</blo=
ckquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">tnx!=
</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn=
/options_util.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/808/comment/f8c35b78_8f40c7a2">=
Patch Set #4, Line 124:</a> <code style=3D"font-family:monospace,monospace"=
>check_push_update_option_flags(char **line, unsigned int *flags)</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">Add doxygen what does this function do.</blockquote></p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/808/comment/a0c306fd_1444ca21">=
Patch Set #4, Line 138:</a> <code style=3D"font-family:monospace,monospace"=
>        if (str[1])</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">below 8 lines are duplicated 3 t=
imes. Maybe define a macro and reuse it, and later undefine? Like [=E2=80=
=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Clever, i like it, I tried but when the compiler optimizes it, the cod=
e gets skipped. Anyway, i simplified and now i use it just 2 times and with=
 a slightly different condition so i hope is good enough</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/808/comment/a517e1a9_3a38d88f">=
Patch Set #4, Line 160:</a> <code style=3D"font-family:monospace,monospace"=
>    if (c =3D=3D &#39;-&#39; &amp;&amp; !(*flags &amp; PUSH_OPT_TO_REMOVE)=
)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">you could remove the &quot;c =3D=3D &#39;-&#39;&quo=
t; check here and move this whole block under the &quot;if&quot; condition =
above</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">I&#39;m not entirely sure that&#39;s what you meant but I simplified<=
/p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/808/comment/ad=
a8cdcc_81c709fb">Patch Set #4, Line 221:</a> <code style=3D"font-family:mon=
ospace,monospace">apply_pull_filter(const struct options *o, char *line, bo=
ol is_update, unsigned int *push_update_option_flags)</code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>Let&#39;s move doxygen to the header.</blockquote></p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"=
margin: 0; padding: 0;"><p>File src/openvpn/push.h:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/808/comment/276f3131_7f2768f9">Patch Set #4, Line 47:</a> <code style=3D"=
font-family:monospace,monospace">int process_incoming_push_update(struct co=
ntext *c,</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">Doxygen</blockquote></p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail=
">change 808</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6ecd4cb47571cc8c20e46de8595=
c742aeec6064a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 808 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 28 Nov 2024 15:21:49=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: stipa &lt;lstipakov@...1664...=
7...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--VCP4z05lV5k=--

