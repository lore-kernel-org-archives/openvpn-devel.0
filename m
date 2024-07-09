From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 9 Jul 2024 16:13:27 +0000
In-Reply-To: <gerrit.1720433364000.I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e@...2715...>
References: <gerrit.1720433364000.I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <2fbf58744b4bb144f83214b82b8def9765720b17-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="W61rbczFV4w="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Allow trailing \r
 and \n in control channel message
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--W61rbczFV4w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/672?usp=3Demail )

Change subject: Allow trailing \r and \n in control channel message
......................................................................


Patch Set 3: Code-Review-1

(4 comments)

Patchset:

PS2:
> I must say that I would feel better if we had a UT covering all this. [=
=E2=80=A6]
Done


Patchset:

PS3:
Thanks, addresses my concerns. However, does not actually build currently ;)


File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/672/comment/5483cbeb_14179e53 :
PS2, Line 318:                         format_hex(BPTR(&buf), BLEN(&cmdbuf)=
, 256, &gc));
> It is "not wrong today", but this sort of booby trap will come back and b=
ite us later - so this shou [=E2=80=A6]
Done


File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/672/comment/2df6966e_2cf72181 :
PS3, Line 295:             struct buffer cmdbuf =3D extract_command_buffer(=
buf, &gc);
&buf



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e
Gerrit-Change-Number: 672
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Tue, 09 Jul 2024 16:13:27 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--W61rbczFV4w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail">Vi=
ew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/672?tab=3Dcomments">Patch Set #2:</a> </p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I must say that I=
 would feel better if we had a UT covering all this. [=E2=80=A6]</blockquot=
e></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/672?tab=3Dcomments">Patch Set #3:</a> </p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Thanks, addresses my concerns. Howev=
er, does not actually build currently ;)</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/672/comment/5483cbeb_14179e53">Patch Set #2, Line 318:</a> <code style=3D=
"font-family:monospace,monospace">                        format_hex(BPTR(&=
amp;buf), BLEN(&amp;cmdbuf), 256, &amp;gc));</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">It is &q=
uot;not wrong today&quot;, but this sort of booby trap will come back and b=
ite us later - so this shou [=E2=80=A6]</blockquote></p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D=
"margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/672/comment/2df6966e_2cf72181">Patch Set #3, Line 295:</a> <code styl=
e=3D"font-family:monospace,monospace">            struct buffer cmdbuf =3D =
extract_command_buffer(buf, &amp;gc);</code></p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">&amp;buf</p></li></ul></li></ul><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail">ch=
ange 672</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I47c992b6b73b1475cbff8a28f72=
0cf50dc1fbe3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 672 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 09 Jul 2024 16:13:27=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--W61rbczFV4w=--

