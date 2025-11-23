From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 23 Nov 2025 13:22:16 +0000
In-Reply-To: <gerrit.1763880426000.I8b26c65415f5a751f416d80a22cbb7ff14aa27c0@...2715...>
References: <gerrit.1763880426000.I8b26c65415f5a751f416d80a22cbb7ff14aa27c0@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f5de7a720ad22e5b731bb414b83cc7b0aaea6e2a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QwK1P4zxxKM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: iservice: make sure
 buffer size is not zero
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--QwK1P4zxxKM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/1389?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: iservice: make sure buffer size is not zero
......................................................................

iservice: make sure buffer size is not zero

GetItfDnsDomains expects a non-zero size buffer to return the domains
in. Check for the size as well, not just for a valid pointer.

Change-Id: I8b26c65415f5a751f416d80a22cbb7ff14aa27c0
Reported-by: Marc Heuse <marc@...2953...>
Reported-by: stephan@...2953...
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1389
Message-Id: <20251123113747.17739-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
606.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/1389/2

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index f64c247..d778e89 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2149,7 +2149,7 @@
 static LSTATUS
 GetItfDnsDomains(HKEY itf, PCWSTR search_domains, PWSTR domains, PDWORD si=
ze)
 {
-    if (domains =3D=3D NULL || size =3D=3D 0)
+    if (domains =3D=3D NULL || size =3D=3D NULL || *size =3D=3D 0)
     {
         return ERROR_INVALID_PARAMETER;
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1389?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8b26c65415f5a751f416d80a22cbb7ff14aa27c0
Gerrit-Change-Number: 1389
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--QwK1P4zxxKM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by d12fk.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1389?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">iservice: make sure buffer size is =
not zero<br><br>GetItfDnsDomains expects a non-zero size buffer to return t=
he domains<br>in. Check for the size as well, not just for a valid pointer.=
<br><br>Change-Id: I8b26c65415f5a751f416d80a22cbb7ff14aa27c0<br>Reported-by=
: Marc Heuse &lt;marc@...2953...&gt;<br>Reported-by: stephan@...2953...<br>=
Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: Gert Doerin=
g &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openv=
pn/+/1389<br>Message-Id: &lt;20251123113747.17739-1-gert@...1296...&gt;<br>=
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
606.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M=
 src/openvpnserv/interactive.c<br>1 file changed, 1 insertion(+), 1 deletio=
n(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/ope=
nvpn refs/changes/89/1389/2</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactiv=
e.c b/src/openvpnserv/interactive.c</span><br><span>index f64c247..d778e89 =
100644</span><br><span>--- a/src/openvpnserv/interactive.c</span><br><span>=
+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -2149,7 +2149,7 @@</=
span><br><span> static LSTATUS</span><br><span> GetItfDnsDomains(HKEY itf, =
PCWSTR search_domains, PWSTR domains, PDWORD size)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (domains =3D=3D NULL=
 || size =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (domains =3D=3D NULL || size =3D=3D NULL || *size =3D=3D 0)</span><br=
><span>     {</span><br><span>         return ERROR_INVALID_PARAMETER;</spa=
n><br><span>     }</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1389?usp=3Demail">change 1389</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1389?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8b26c65415f5a751f416d80a22c=
bb7ff14aa27c0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1389 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--QwK1P4zxxKM=--

