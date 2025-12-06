From: "syzzer (Code Review)" <gerrit@...515...>
Date: Sat, 6 Dec 2025 20:50:57 +0000
References: <gerrit.1765054252000.I0d592d9d0c7ead296869f933c206c5d55e6cbed1@...2715...>
Reply-To: steffan@...1856..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b14bb3437b02b8f9055cee63606faaca60087f12-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0Znq5AEbdIQ="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0Znq5AEbdIQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1419?usp=3Demail

to review the following change.


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
---
M src/openvpn/ssl_mbedtls.c
1 file changed, 5 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/1419/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0d592d9d0c7ead296869f933c206c5d55e6cbed1
Gerrit-Change-Number: 1419
Gerrit-PatchSet: 1
Gerrit-Owner: syzzer <steffan@...1856...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--0Znq5AEbdIQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>syzzer would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1419?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">mbedtls: gracefully exit if certificate fil=
e is NULL<br><br>Instead of crashing because we feed a NULL pointer to strl=
en(),<br>gracefully exit with an error message.<br><br>While at it, improve=
 the error message a bit.<br><br>Change-Id: I0d592d9d0c7ead296869f933c206c5=
d55e6cbed1<br>Reported-By: Joshua Rogers &lt;contact@...2949...&gt;<br>Foun=
d-by: ZeroPath (https://zeropath.com/)<br>Signed-off-by: Steffan Karger &lt=
;steffan@...1856...&gt;<br>---<br>M src/openvpn/ssl_mbedtls.c<br>1 file cha=
nged, 5 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit.openvpn.net:29418/openvpn refs/changes/19/1419/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span><br><span=
>index 83fca78..3440319 100644</span><br><span>--- a/src/openvpn/ssl_mbedtl=
s.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><span>@@ -466=
,10 +466,14 @@</span><br><span> </span><br><span>     if (cert_inline)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (!cert_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(M_FATAL, &quot;Cannot load inline certificate: NULL&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>=
         if (!mbed_ok(mbedtls_x509_crt_parse(ctx-&gt;crt_chain, (const unsi=
gned char *)cert_file,</span><br><span>                                    =
         strlen(cert_file) + 1)))</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            msg(M_FATAL, &quot;Canno=
t load inline certificate file&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            msg(M_FATAL, &quot;Cannot load inline certif=
icate&quot;);</span><br><span>         }</span><br><span>     }</span><br><=
span>     else</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1419?usp=3Demail">change 1419</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1419?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0d592d9d0c7ead296869f933c20=
6c5d55e6cbed1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1419 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: syzzer &lt;steffan@...1856...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--0Znq5AEbdIQ=--

