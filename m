From: "ordex (Code Review)" <gerrit@...515...>
Date: Tue, 10 Mar 2026 13:42:28 +0000
In-Reply-To: <gerrit.1772625635000.I7cf5d5ef7e2531f397ad97baf4663e3763072f6b@...2715...>
References: <gerrit.1772625635000.I7cf5d5ef7e2531f397ad97baf4663e3763072f6b@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net
Message-ID: <a374671c02f9c94ba70afc6665b9bc25dfea33c8-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="o2My+K/sEWY="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: socket: restore
 per-connection lport override over global default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--o2My+K/sEWY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

ordex has posted comments on this change by its_Giaan. ( http://gerrit.open=
vpn.net/c/openvpn/+/1555?usp=3Demail )

Change subject: socket: restore per-connection lport override over global d=
efault
......................................................................


Patch Set 1: Code-Review-1

(1 comment)

File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/1555/comment/29141286_321bf2c0?usp=3D=
email :
PS1, Line 1350:     const char *port =3D (o->mode =3D=3D MODE_POINT_TO_POIN=
T && o->ce.local_port_defined)
similarly to what we do with o->ce.proto, can we have an if just below the =
variables declaration, rather than having this longer/complex expression in=
 here?

we could just have:

if (o->mode =3D=3D MODE_POINT_TO_POINT && o->ce.local_port_defined)
{
    port =3D o->ce.local_port
}

and keep the variable declaration/initialization as it was before.
Maybe also add a comment of top of that if saying something like "if --lpor=
t is specified in a client connection block we give it higher priority"



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1555?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7cf5d5ef7e2531f397ad97baf4663e3763072f6b
Gerrit-Change-Number: 1555
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Comment-Date: Tue, 10 Mar 2026 13:42:28 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--o2My+K/sEWY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1555?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket.c:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1555/comment/29141286_321bf2c0?usp=3Demail">Patch Set =
#1, Line 1350:</a> <code style=3D"font-family:monospace,monospace">    cons=
t char *port =3D (o-&gt;mode =3D=3D MODE_POINT_TO_POINT &amp;&amp; o-&gt;ce=
.local_port_defined)</code></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">similarly to what we do with o-&gt;ce.proto=
, can we have an if just below the variables declaration, rather than havin=
g this longer/complex expression in here?</p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">we could just have:</p><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">if (o-&gt;mode =3D=3D MODE_POINT_TO_POINT &amp;&amp; o-&gt;ce.local=
_port_defined)<br>{<br>    port =3D o-&gt;ce.local_port<br>}</pre><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">and kee=
p the variable declaration/initialization as it was before.<br>Maybe also a=
dd a comment of top of that if saying something like &quot;if --lport is sp=
ecified in a client connection block we give it higher priority&quot;</p></=
li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1555?usp=3Demail">change 1555</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1555?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7cf5d5ef7e2531f397ad97baf46=
63e3763072f6b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1555 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 10 Mar 2026 13:42:28=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--o2My+K/sEWY=--

