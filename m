From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 6 Dec 2025 22:38:43 +0000
In-Reply-To: <gerrit.1765054252000.I0d592d9d0c7ead296869f933c206c5d55e6cbed1@...2715...>
References: <gerrit.1765054252000.I0d592d9d0c7ead296869f933c206c5d55e6cbed1@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, steffan@...1856...
Message-ID: <5be9b03307e38a9b56b05b9997425551f86b3a26-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ApEQ4pPq+t4="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: mbedtls: gracefully
 exit if certificate file is NULL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: syzzer <steffan@...1856...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ApEQ4pPq+t4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 syzzer. ( http://gerrit.openvpn.net/c/openvpn/+/1419?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: mbedtls: gracefully exit if certificate file is NULL
......................................................................

mbedtls: gracefully exit if certificate file is NULL

Instead of crashing because we feed a NULL pointer to strlen(),
gracefully exit with an error message.

While at it, improve the error message a bit.

Change-Id: I0d592d9d0c7ead296869f933c206c5d55e6cbed1
Reported-By: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)
Signed-off-by: Steffan Karger <steffan@...1856...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1419
Message-Id: <20251206205829.27254-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
864.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_mbedtls.c
1 file changed, 5 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/1419/2

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 83fca78..3440319 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -466,10 +466,14 @@

     if (cert_inline)
     {
+        if (!cert_file)
+        {
+            msg(M_FATAL, "Cannot load inline certificate: NULL");
+        }
         if (!mbed_ok(mbedtls_x509_crt_parse(ctx->crt_chain, (const unsigne=
d char *)cert_file,
                                             strlen(cert_file) + 1)))
         {
-            msg(M_FATAL, "Cannot load inline certificate file");
+            msg(M_FATAL, "Cannot load inline certificate");
         }
     }
     else

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1419?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0d592d9d0c7ead296869f933c206c5d55e6cbed1
Gerrit-Change-Number: 1419
Gerrit-PatchSet: 2
Gerrit-Owner: syzzer <steffan@...1856...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ApEQ4pPq+t4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by syzzer.</p>=
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1419?usp=3Demail">View =
Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">mbedtls: gracefully exit if certifi=
cate file is NULL<br><br>Instead of crashing because we feed a NULL pointer=
 to strlen(),<br>gracefully exit with an error message.<br><br>While at it,=
 improve the error message a bit.<br><br>Change-Id: I0d592d9d0c7ead296869f9=
33c206c5d55e6cbed1<br>Reported-By: Joshua Rogers &lt;contact@...2949...&gt;=
<br>Found-by: ZeroPath (https://zeropath.com/)<br>Signed-off-by: Steffan Ka=
rger &lt;steffan@...1856...&gt;<br>Acked-by: Gert Doering &lt;gert@...1725...=
..&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1419<br>Messag=
e-Id: &lt;20251206205829.27254-1-gert@...1296...&gt;<br>URL: https://www.ma=
il-archive.com/openvpn-devel@lists.sourceforge.net/msg34864.html<br>Signed-=
off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl_mb=
edtls.c<br>1 file changed, 5 insertions(+), 1 deletion(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/1=
419/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbed=
tls.c</span><br><span>index 83fca78..3440319 100644</span><br><span>--- a/s=
rc/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</s=
pan><br><span>@@ -466,10 +466,14 @@</span><br><span> </span><br><span>     =
if (cert_inline)</span><br><span>     {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (!cert_file)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(M_FATAL, &quot;Cannot load inline certificate=
: NULL&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span>         if (!mbed_ok(mbedtls_x509_crt_parse(ctx-&gt;c=
rt_chain, (const unsigned char *)cert_file,</span><br><span>               =
                              strlen(cert_file) + 1)))</span><br><span>    =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg=
(M_FATAL, &quot;Cannot load inline certificate file&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            msg(M_FATAL, &quot;Cann=
ot load inline certificate&quot;);</span><br><span>         }</span><br><sp=
an>     }</span><br><span>     else</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1419?usp=3Dema=
il">change 1419</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1419?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0d592d9d0c7ead296869f933c20=
6c5d55e6cbed1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1419 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: syzzer &lt;steffan@...1856...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--ApEQ4pPq+t4=--

