From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 27 Sep 2025 20:27:42 +0000
In-Reply-To: <gerrit.1758030602000.I88e16e15fad065cb310d38f09924053efc3a6ce5@...2715...>
References: <gerrit.1758030602000.I88e16e15fad065cb310d38f09924053efc3a6ce5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <caeae85603fe29f0ad29e0b0378c20e25e03f3b8-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t/aok7DrcTY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Allowing installing
 FreeBSD routes with interface instead of next-hop
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--t/aok7DrcTY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1193?usp=3Demail )

Change subject: Allowing installing FreeBSD routes with interface instead o=
f next-hop
......................................................................


Patch Set 3: Code-Review-1

(1 comment)

File src/openvpn/networking_freebsd.c:

http://gerrit.openvpn.net/c/openvpn/+/1193/comment/ca46df8e_422ac899 :
PS3, Line 23:     /* if gw is 0 (=3D0.0.0.0), which is not a valid gateway,
are you passing in NULL or "a pointer to 0.0.0.0"?  The code says "NULL" an=
d the comment says "gw is 0.0.0.0" which would technically be "a pointer to=
 0.0.0.0"...

Maybe just word it the same as in IPv6... `if we have no gateway (gw is NUL=
L), we are installing a route with the interface as target instead` or so.

But the logic is still confusing, the comment says "if we have no gateway" =
and the condition does "if(gateway)" and the "interface route" is down in t=
he else branch...



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1193?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I88e16e15fad065cb310d38f09924053efc3a6ce5
Gerrit-Change-Number: 1193
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Sat, 27 Sep 2025 20:27:42 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--t/aok7DrcTY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1193?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/networking_fre=
ebsd.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1193/comment/ca46df8e_422ac899">Patch Set =
#3, Line 23:</a> <code style=3D"font-family:monospace,monospace">    /* if =
gw is 0 (=3D0.0.0.0), which is not a valid gateway,</code></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">are you passing in NULL or &q=
uot;a pointer to 0.0.0.0&quot;?  The code says &quot;NULL&quot; and the com=
ment says &quot;gw is 0.0.0.0&quot; which would technically be &quot;a poin=
ter to 0.0.0.0&quot;...</p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Maybe just word it the same as in IPv6... `if we have no gateway=
 (gw is NULL), we are installing a route with the interface as target inste=
ad` or so.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Bu=
t the logic is still confusing, the comment says &quot;if we have no gatewa=
y&quot; and the condition does &quot;if(gateway)&quot; and the &quot;interf=
ace route&quot; is down in the else branch...</p></li></ul></li></ul><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1193?usp=3Dema=
il">change 1193</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1193?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I88e16e15fad065cb310d38f0992=
4053efc3a6ce5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1193 </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 27 Sep 2025 20:27:42=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--t/aok7DrcTY=--

