From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 12 Nov 2025 10:40:40 +0000
In-Reply-To: <gerrit.1762539795000.I4d905da3add9b8a3daf349eb1bc830a017cf493d@...2715...>
References: <gerrit.1762539795000.I4d905da3add9b8a3daf349eb1bc830a017cf493d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <c10edaec8642c65faa01bbed4f3cde2af67a04e5-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yhbQ1ApgJ6s="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: iservice: validate
 config path case-insensitive
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--yhbQ1ApgJ6s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/1362?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by stipa


Change subject: iservice: validate config path case-insensitive
......................................................................

iservice: validate config path case-insensitive

Windows filesystems do not differentiate by case, so we shouldn't either.

Reported-by: stephan@...2953...
Change-Id: I4d905da3add9b8a3daf349eb1bc830a017cf493d
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1362
Message-Id: <20251112093911.24196-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
340.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/validate.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/62/1362/4

diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index b3189b7..3381503 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -78,7 +78,7 @@
         res =3D PathCchCanonicalize(config_path, _countof(config_path), fn=
ame);
     }

-    return res =3D=3D S_OK && wcsncmp(config_path, s->config_dir, wcslen(s=
->config_dir)) =3D=3D 0;
+    return res =3D=3D S_OK && wcsnicmp(config_path, s->config_dir, wcslen(=
s->config_dir)) =3D=3D 0;
 }



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1362?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4d905da3add9b8a3daf349eb1bc830a017cf493d
Gerrit-Change-Number: 1362
Gerrit-PatchSet: 4
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--yhbQ1ApgJ6s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by d12fk.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1362?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by stipa</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">iservice: validate config path case=
-insensitive<br><br>Windows filesystems do not differentiate by case, so we=
 shouldn&#39;t either.<br><br>Reported-by: stephan@...2953...<br>Change-Id:=
 I4d905da3add9b8a3daf349eb1bc830a017cf493d<br>Signed-off-by: Heiko Hund &lt=
;heiko@...2662...&gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@...277...&gt;=
<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1362<br>Message-Id: =
&lt;20251112093911.24196-1-gert@...1296...&gt;<br>URL: https://www.mail-arc=
hive.com/openvpn-devel@lists.sourceforge.net/msg34340.html<br>Signed-off-by=
: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpnserv/validate=
.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/62/1362/4<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.=
c</span><br><span>index b3189b7..3381503 100644</span><br><span>--- a/src/o=
penvpnserv/validate.c</span><br><span>+++ b/src/openvpnserv/validate.c</spa=
n><br><span>@@ -78,7 +78,7 @@</span><br><span>         res =3D PathCchCanon=
icalize(config_path, _countof(config_path), fname);</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return res =3D=3D S_OK &amp;&amp; wcsncmp(config_path, s-&gt;config_dir, wc=
slen(s-&gt;config_dir)) =3D=3D 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return res =3D=3D S_OK &amp;&amp; wcsnicmp(config_path, s=
-&gt;config_dir, wcslen(s-&gt;config_dir)) =3D=3D 0;</span><br><span> }</sp=
an><br><span> </span><br><span> </span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1362?usp=3Demail"=
>change 1362</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1362?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4d905da3add9b8a3daf349eb1bc=
830a017cf493d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1362 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--yhbQ1ApgJ6s=--

