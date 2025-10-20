From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 20 Oct 2025 16:16:03 +0000
In-Reply-To: <gerrit.1760969783000.I82c7c61be07593ecd5bf2f854767dda74ab5170c@...2715...>
References: <gerrit.1760969783000.I82c7c61be07593ecd5bf2f854767dda74ab5170c@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <0aca1c9e0421c6d255d1af2d122afb5a30026596-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ljeiMAitjbY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Warn if push is used
 without --mode server/--server/--server-bridge
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ljeiMAitjbY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change by plaisthos. ( http://gerrit.=
openvpn.net/c/openvpn/+/1288?usp=3Demail )

Change subject: Warn if push is used without --mode server/--server/--serve=
r-bridge
......................................................................


Patch Set 1:

(4 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/1288/comment/d7f5c5d0_97f445f3?usp=3D=
email :
PS1, Line 14: Also remove an used macro.
> "unused" I assume
Acknowledged


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/1288/comment/9676fd5c_46a87c6f?usp=3D=
email :
PS1, Line 3337:=20=20=20
> whitespace
Done


http://gerrit.openvpn.net/c/openvpn/+/1288/comment/04ba28cd_b064d58d?usp=3D=
email :
PS1, Line 3338:     if (o->push_list.head && o->mode !=3D MODE_SERVER)
> We have a lot of warnings and errors that we potentially throw if not in =
--mode server, see code aro [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/1288/comment/861ffac4_9f1909cd?usp=3D=
email :
PS1, Line 3340:         msg(M_WARN, "Note: Using --push without --mode serv=
er is an unsupported"
> We probably also should add a note under --push in the documentation.
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1288?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I82c7c61be07593ecd5bf2f854767dda74ab5170c
Gerrit-Change-Number: 1288
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 20 Oct 2025 16:16:03 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--ljeiMAitjbY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1288?usp=3Demail">View =
Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1288/comment/d7f5c5d0_97f445f3?usp=3Demail">Patch Set #1, Line 14:</=
a> <code style=3D"font-family:monospace,monospace">Also remove an used macr=
o.</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">&quot;unused&quot; I assume</blockquote></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Ackno=
wledged</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/=
openvpn/options.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1288/comment/9676fd5c_46a87c6f?=
usp=3Demail">Patch Set #1, Line 3337:</a> <code style=3D"font-family:monosp=
ace,monospace">    </code></p><p><blockquote style=3D"border-left: 1px soli=
d #aaa; margin: 10px 0; padding: 0 10px;">whitespace</blockquote></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done<=
/p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1288/comment/0=
4ba28cd_b064d58d?usp=3Demail">Patch Set #1, Line 3338:</a> <code style=3D"f=
ont-family:monospace,monospace">    if (o-&gt;push_list.head &amp;&amp; o-&=
gt;mode !=3D MODE_SERVER)</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">We have a lot of warnings a=
nd errors that we potentially throw if not in --mode server, see code aro [=
=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1288/comment/861ffac4_9f1909cd?usp=3Demail">Patch Set #1=
, Line 3340:</a> <code style=3D"font-family:monospace,monospace">        ms=
g(M_WARN, &quot;Note: Using --push without --mode server is an unsupported&=
quot;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">We probably also should add a note under --push=
 in the documentation.</blockquote></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1288?usp=3Demai=
l">change 1288</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1288?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I82c7c61be07593ecd5bf2f85476=
7dda74ab5170c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1288 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 20 Oct 2025 16:16:03=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--ljeiMAitjbY=--

