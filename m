From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 30 Oct 2025 21:14:37 +0000
In-Reply-To: <gerrit.1761496209000.I92804da010bab36cd0326759c04f955f2bda74de@...2715...>
References: <gerrit.1761496209000.I92804da010bab36cd0326759c04f955f2bda74de@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9a2c6cc54a27b21b59ce8c2f8632c4e37681fc14-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KFTldIwUva4="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: iservice: check
 return value of MultiByteToWideChar
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KFTldIwUva4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/1306?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: iservice: check return value of MultiByteToWideChar
......................................................................

iservice: check return value of MultiByteToWideChar

If the first call to MultiByteToWideChar returns 0, something must have
failed, because it returns the required buffer size including the
terminating zero. When it does return 0, just return NULL and indicate
that the call to utf8to16(_size) failed.

Found by ZeroPath.

Reported-By: Joshua Rogers <contact@...2949...>
Change-Id: I92804da010bab36cd0326759c04f955f2bda74de
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1306
Message-Id: <20251030194736.2151-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
071.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/common.c
1 file changed, 4 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/1306/2

diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index e975cc7..d25d9c0 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -276,6 +276,10 @@
 utf8to16_size(const char *utf8, int size)
 {
     int n =3D MultiByteToWideChar(CP_UTF8, 0, utf8, size, NULL, 0);
+    if (n =3D=3D 0)
+    {
+        return NULL;
+    }
     wchar_t *utf16 =3D malloc(n * sizeof(wchar_t));
     if (!utf16)
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1306?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I92804da010bab36cd0326759c04f955f2bda74de
Gerrit-Change-Number: 1306
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KFTldIwUva4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by d12fk.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1306?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">iservice: check return value of Mul=
tiByteToWideChar<br><br>If the first call to MultiByteToWideChar returns 0,=
 something must have<br>failed, because it returns the required buffer size=
 including the<br>terminating zero. When it does return 0, just return NULL=
 and indicate<br>that the call to utf8to16(_size) failed.<br><br>Found by Z=
eroPath.<br><br>Reported-By: Joshua Rogers &lt;contact@...2949...&gt;<br>Ch=
ange-Id: I92804da010bab36cd0326759c04f955f2bda74de<br>Signed-off-by: Heiko =
Hund &lt;heiko@...2662...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...=
&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1306<br>Message-=
Id: &lt;20251030194736.2151-1-gert@...1296...&gt;<br>URL: https://www.mail-=
archive.com/openvpn-devel@lists.sourceforge.net/msg34071.html<br>Signed-off=
-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpnserv/commo=
n.c<br>1 file changed, 4 insertions(+), 0 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/1306=
/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c=
</span><br><span>index e975cc7..d25d9c0 100644</span><br><span>--- a/src/op=
envpnserv/common.c</span><br><span>+++ b/src/openvpnserv/common.c</span><br=
><span>@@ -276,6 +276,10 @@</span><br><span> utf8to16_size(const char *utf8=
, int size)</span><br><span> {</span><br><span>     int n =3D MultiByteToWi=
deChar(CP_UTF8, 0, utf8, size, NULL, 0);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (n =3D=3D 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return NULL;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span>     wchar_t *utf16 =3D malloc(n * sizeof(wch=
ar_t));</span><br><span>     if (!utf16)</span><br><span>     {</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1306?usp=3Demail">change 1306</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1306?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I92804da010bab36cd0326759c04=
f955f2bda74de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1306 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--KFTldIwUva4=--

