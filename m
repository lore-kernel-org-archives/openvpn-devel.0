From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 6 Feb 2025 18:46:54 +0000
In-Reply-To: <gerrit.1732212459000.Ia267276d61fa1425ba205f54ba6eb89021f32dba@...2715...>
References: <gerrit.1732212459000.Ia267276d61fa1425ba205f54ba6eb89021f32dba@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <1560972bb58e9d08b863b414092a8b897f870037-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="skzZdX2lLkU="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dco-win: multipeer
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: cron2 <gert@...1296...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--skzZdX2lLkU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/815?usp=3Demail )

Change subject: dco-win: multipeer support
......................................................................


Patch Set 19:

(5 comments)

File src/openvpn/dco_win.c:

http://gerrit.openvpn.net/c/openvpn/+/815/comment/00d94363_34c9a1fd :
PS18, Line 146:     OVPN_MODE m =3D OVPN_MODE_MP;
> Yeah, this one is from the driver API. But I see the frustration.
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/815/comment/33928f1a_ab08b8c6 :
PS18, Line 291:     if (out.ListenAddress.Addr4.sin_family =3D=3D AF_INET)
> The driver writes to out the local transport address of the socket after =
the bind() call. [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/815/comment/f8813ec3_9bac21f1 :
PS18, Line 393: {
> I see. [=E2=80=A6]
Done


File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/815/comment/825741c8_e6fea2d1 :
PS18, Line 1326:         bool prepend_sa =3D c->options.mode =3D=3D MODE_SE=
RVER && dco_enabled(&c->options);
> Actually we cannot end up here when using DCO. [=E2=80=A6]
Done


File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/815/comment/c67d8e5e_442ec891 :
PS18, Line 3957:         read_sockaddr_from_overlapped(io, &from->dest.addr=
.sa, ret);
> SH could be either file descriptor (in case of non-dco link) or handle (n=
on-dco tun and dco link). [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/815?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia267276d61fa1425ba205f54ba6eb89021f32dba
Gerrit-Change-Number: 815
Gerrit-PatchSet: 19
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 06 Feb 2025 18:46:54 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: stipa <lstipakov@...277...>
Gerrit-MessageType: comment

--skzZdX2lLkU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/815?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_win.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/815/comment/00d94363_34c9a1fd">Patch Set #18, Line 146:</=
a> <code style=3D"font-family:monospace,monospace">    OVPN_MODE m =3D OVPN=
_MODE_MP;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">Yeah, this one is from the driver API. But =
I see the frustration.</blockquote></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">Acknowledged</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/815/comment/33928f1a_ab08b8c6">Patch Set #18, Line 29=
1:</a> <code style=3D"font-family:monospace,monospace">    if (out.ListenAd=
dress.Addr4.sin_family =3D=3D AF_INET)</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">The driver wri=
tes to out the local transport address of the socket after the bind() call.=
 [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/815/comment/f8813ec3_9bac21f1">Patch Set #18, Line 393:</a> <code style=
=3D"font-family:monospace,monospace">{</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I see. [=E2=80=
=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sr=
c/openvpn/forward.c:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/815/comment/825741c8_e6fea2d1=
">Patch Set #18, Line 1326:</a> <code style=3D"font-family:monospace,monosp=
ace">        bool prepend_sa =3D c-&gt;options.mode =3D=3D MODE_SERVER &amp=
;&amp; dco_enabled(&amp;c-&gt;options);</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Actually we c=
annot end up here when using DCO. [=E2=80=A6]</blockquote></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li st=
yle=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/815/comment/c67d8e5e_442ec891">Patch Set #18, Line 3957:</a> <=
code style=3D"font-family:monospace,monospace">        read_sockaddr_from_o=
verlapped(io, &amp;from-&gt;dest.addr.sa, ret);</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">SH co=
uld be either file descriptor (in case of non-dco link) or handle (non-dco =
tun and dco link). [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/815?usp=3Demail">change =
815</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/815?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia267276d61fa1425ba205f54ba6=
eb89021f32dba </div>
<div style=3D"display:none"> Gerrit-Change-Number: 815 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 19 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 06 Feb 2025 18:46:54=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: stipa &lt;lstipakov@...1664...=
7...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--skzZdX2lLkU=--

