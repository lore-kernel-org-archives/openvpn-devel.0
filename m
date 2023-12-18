From: "stipa (Code Review)" <gerrit@...515...>
Date: Mon, 18 Dec 2023 15:18:31 +0000
In-Reply-To: <gerrit.1702561084000.I21a36d24f8e213c780f55acbe3e4df555c93542a@...2715...>
References: <gerrit.1702561084000.I21a36d24f8e213c780f55acbe3e4df555c93542a@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3320bed2aa11e16d786a0b40c6f9821784396576-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XSCFsTKHJvc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tun.c: don't attempt
 to delete DNS and WINS servers if they're not set
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XSCFsTKHJvc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/482?usp=3Demail )

Change subject: tun.c: don't attempt to delete DNS and WINS servers if they=
're not set
......................................................................


Patch Set 2:

(2 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/482/comment/6bccb548_434b4cc2 :
PS1, Line 19: However, due to bug we always attempted to remove DNS/WINS,
> Such a delay is the good reason I was looking for. [=E2=80=A6]
Done


File src/openvpn/tun.c:

http://gerrit.openvpn.net/c/openvpn/+/482/comment/60defa74_6e621889 :
PS1, Line 212:     if (((family =3D=3D AF_INET6) && (tt->options.dns6_len =
=3D=3D 0))
> can be shortened to "len =3D=3D 0"
Acknowledged



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/482?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I21a36d24f8e213c780f55acbe3e4df555c93542a
Gerrit-Change-Number: 482
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: d12fk <heiko@...515...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Mon, 18 Dec 2023 15:18:31 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: d12fk <heiko@...515...>
Comment-In-Reply-To: stipa <lstipakov@...277...>
Gerrit-MessageType: comment

--XSCFsTKHJvc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/482?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/482/comment/6bccb548_434b4cc2">Patch Set #1, Line 19:</a> <code style=
=3D"font-family:monospace,monospace">However, due to bug we always attempte=
d to remove DNS/WINS,</code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">Such a delay is the good reason=
 I was looking for. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/tun.c:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/482/co=
mment/60defa74_6e621889">Patch Set #1, Line 212:</a> <code style=3D"font-fa=
mily:monospace,monospace">    if (((family =3D=3D AF_INET6) &amp;&amp; (tt-=
&gt;options.dns6_len =3D=3D 0))</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">can be shortened to &=
quot;len =3D=3D 0&quot;</blockquote></p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">Acknowledged</p></li></ul></li></ul><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/482?usp=3Demail">change=
 482</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/482?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I21a36d24f8e213c780f55acbe3e=
4df555c93542a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 482 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@...515...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 18 Dec 2023 15:18:31=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: d12fk &lt;heiko@...515...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: stipa &lt;lstipakov@...1664...=
7...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--XSCFsTKHJvc=--

