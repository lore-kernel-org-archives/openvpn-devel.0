From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 8 Dec 2025 19:28:50 +0000
In-Reply-To: <gerrit.1765212547000.I999916f9561a638214b70cf43de78060e9e0e792@...2715...>
References: <gerrit.1765212547000.I999916f9561a638214b70cf43de78060e9e0e792@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <66c3516973b1df9bbf027b430d4e6010437bdc88-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Og4bMj1xV6g="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: socket: Initialize
 struct in_addr_t in getaddr()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Og4bMj1xV6g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
20?usp=3Demail )

Change subject: socket: Initialize struct in_addr_t in getaddr()
......................................................................

socket: Initialize struct in_addr_t in getaddr()

We have false-positive "=E2=80=98addr=E2=80=99 may be used uninitialized"
warnings with MinGW 13.0.0 compiler. Work around them.

Change-Id: I999916f9561a638214b70cf43de78060e9e0e792
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1420
Message-Id: <20251208170320.4696-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
894.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socket.c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 80c2895..3e90833 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -202,7 +202,7 @@
 getaddr(unsigned int flags, const char *hostname, int resolve_retry_second=
s, bool *succeeded,
         struct signal_info *sig_info)
 {
-    in_addr_t addr;
+    in_addr_t addr =3D { 0 };
     int status;

     status =3D get_addr_generic(AF_INET, flags, hostname, &addr, NULL, res=
olve_retry_seconds,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1420?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I999916f9561a638214b70cf43de78060e9e0e792
Gerrit-Change-Number: 1420
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Og4bMj1xV6g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1420?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">socket: Initialize struct in_addr_t in getaddr()=
<br><br>We have false-positive &quot;=E2=80=98addr=E2=80=99 may be used uni=
nitialized&quot;<br>warnings with MinGW 13.0.0 compiler. Work around them.<=
br><br>Change-Id: I999916f9561a638214b70cf43de78060e9e0e792<br>Signed-off-b=
y: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt=
;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/=
1420<br>Message-Id: &lt;20251208170320.4696-1-gert@...1296...&gt;<br>URL: h=
ttps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34894.ht=
ml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/o=
penvpn/socket.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></p=
re>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span=
>index 80c2895..3e90833 100644</span><br><span>--- a/src/openvpn/socket.c</=
span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -202,7 +202,7 =
@@</span><br><span> getaddr(unsigned int flags, const char *hostname, int r=
esolve_retry_seconds, bool *succeeded,</span><br><span>         struct sign=
al_info *sig_info)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    in_addr_t addr;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    in_addr_t addr =3D { 0 };</span><br><span>     int stat=
us;</span><br><span> </span><br><span>     status =3D get_addr_generic(AF_I=
NET, flags, hostname, &amp;addr, NULL, resolve_retry_seconds,</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1420?usp=3Demail">change 1420</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?u=
sp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1420?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I999916f9561a638214b70cf43de=
78060e9e0e792 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1420 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Og4bMj1xV6g=--

