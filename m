From: "d12fk (Code Review)" <gerrit@...515...>
Date: Sun, 23 Nov 2025 06:47:16 +0000
References: <gerrit.1763880426000.I8b26c65415f5a751f416d80a22cbb7ff14aa27c0@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <19d676cf5e7b65989dd91d132b6578441c9b9f58-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LGpocgcZ7vA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LGpocgcZ7vA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1389?usp=3Demail

to review the following change.


Change subject: iservice: make sure buffer size is not zero
......................................................................

iservice: make sure buffer size is not zero

GetItfDnsDomains expects a non-zero size buffer to return the domains
in. Check for the size as well, not just for a valid pointer.

Change-Id: I8b26c65415f5a751f416d80a22cbb7ff14aa27c0
Reported-by: Marc Heuse <marc@...2953...>
Reported-by: stephan@...2953...
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpnserv/interactive.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/1389/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8b26c65415f5a751f416d80a22cbb7ff14aa27c0
Gerrit-Change-Number: 1389
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--LGpocgcZ7vA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>d12fk would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1389?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">iservice: make sure buffer size is not zero=
<br><br>GetItfDnsDomains expects a non-zero size buffer to return the domai=
ns<br>in. Check for the size as well, not just for a valid pointer.<br><br>=
Change-Id: I8b26c65415f5a751f416d80a22cbb7ff14aa27c0<br>Reported-by: Marc H=
euse &lt;marc@...2953...&gt;<br>Reported-by: stephan@...2953...<br>Signed-o=
ff-by: Heiko Hund &lt;heiko@...2662...&gt;<br>---<br>M src/openvpnserv/inte=
ractive.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/=
1389/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv=
/interactive.c</span><br><span>index f64c247..d778e89 100644</span><br><spa=
n>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv=
/interactive.c</span><br><span>@@ -2149,7 +2149,7 @@</span><br><span> stati=
c LSTATUS</span><br><span> GetItfDnsDomains(HKEY itf, PCWSTR search_domains=
, PWSTR domains, PDWORD size)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (domains =3D=3D NULL || size =3D=3D 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (domains =3D=3D=
 NULL || size =3D=3D NULL || *size =3D=3D 0)</span><br><span>     {</span><=
br><span>         return ERROR_INVALID_PARAMETER;</span><br><span>     }</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1389?usp=3Demail">change 1389</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1389?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8b26c65415f5a751f416d80a22c=
bb7ff14aa27c0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1389 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--LGpocgcZ7vA=--

