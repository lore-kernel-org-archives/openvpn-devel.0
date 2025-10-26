From: "syzzer (Code Review)" <gerrit@...515...>
Date: Sun, 26 Oct 2025 14:32:58 +0000
References: <gerrit.1761489176000.I5b6881dc73358c8d1249ee2ceb968ede295105b0@...2715...>
Reply-To: steffan@...1856..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d54f76f01c9c37212faf468049c913e7f2de28e3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JWEC7ubf/LQ="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: ssl_mbedtls:
 fix missing perf_pop() call
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JWEC7ubf/LQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1305?usp=3Demail

to review the following change.


Change subject: ssl_mbedtls: fix missing perf_pop() call
......................................................................

ssl_mbedtls: fix missing perf_pop() call

This was triggered by a bug report submitted by Joshua Rogers, who
used ZeroPath to discover we missed a perf_pop() call in one of the
error paths of ssl_mbedtls.c.

Move an existing perf_pop call a bit upwards to fix that.

The perf code is always disabled by ENABLE_PERFORMANCE_METRICS being
commented out in perf.h. There is no configure flag. None of the active
developers remembers using it and the git log shows no actual code changes
since at least the project structure overhaul of 2012. So this has no
real-world impact.

Change-Id: I5b6881dc73358c8d1249ee2ceb968ede295105b0
Signed-off-by: Steffan Karger <steffan@...1856...>
---
M src/openvpn/ssl_mbedtls.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/05/1305/1

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 8fb69c3..2862989 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1489,13 +1489,13 @@
     /* Error during read, check for retry error */
     if (retval < 0)
     {
+        perf_pop();
         if (MBEDTLS_ERR_SSL_WANT_WRITE =3D=3D retval || MBEDTLS_ERR_SSL_WA=
NT_READ =3D=3D retval)
         {
             return 0;
         }
         mbed_log_err(D_TLS_ERRORS, retval, "TLS_ERROR: read tls_read_plain=
text error");
         buf->len =3D 0;
-        perf_pop();
         return -1;
     }
     /* Nothing read, try again */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1305?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I5b6881dc73358c8d1249ee2ceb968ede295105b0
Gerrit-Change-Number: 1305
Gerrit-PatchSet: 1
Gerrit-Owner: syzzer <steffan@...1856...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--JWEC7ubf/LQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>syzzer would like plaisthos and flichtenheld to <strong>review</strong> =
this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1305?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">ssl_mbedtls: fix missing perf_pop() call<br=
><br>This was triggered by a bug report submitted by Joshua Rogers, who<br>=
used ZeroPath to discover we missed a perf_pop() call in one of the<br>erro=
r paths of ssl_mbedtls.c.<br><br>Move an existing perf_pop call a bit upwar=
ds to fix that.<br><br>The perf code is always disabled by ENABLE_PERFORMAN=
CE_METRICS being<br>commented out in perf.h. There is no configure flag. No=
ne of the active<br>developers remembers using it and the git log shows no =
actual code changes<br>since at least the project structure overhaul of 201=
2. So this has no<br>real-world impact.<br><br>Change-Id: I5b6881dc73358c8d=
1249ee2ceb968ede295105b0<br>Signed-off-by: Steffan Karger &lt;steffan@...1883...=
56...&gt;<br>---<br>M src/openvpn/ssl_mbedtls.c<br>1 file changed, 1 insert=
ion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/05/1305/1</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span><br><span>index 8fb69c3.=
.2862989 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><=
span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><span>@@ -1489,13 +1489,13 @=
@</span><br><span>     /* Error during read, check for retry error */</span=
><br><span>     if (retval &lt; 0)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        perf_pop();</span><br><span> =
        if (MBEDTLS_ERR_SSL_WANT_WRITE =3D=3D retval || MBEDTLS_ERR_SSL_WAN=
T_READ =3D=3D retval)</span><br><span>         {</span><br><span>          =
   return 0;</span><br><span>         }</span><br><span>         mbed_log_e=
rr(D_TLS_ERRORS, retval, &quot;TLS_ERROR: read tls_read_plaintext error&quo=
t;);</span><br><span>         buf-&gt;len =3D 0;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        perf_pop();</span><br><span>         ret=
urn -1;</span><br><span>     }</span><br><span>     /* Nothing read, try ag=
ain */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1305?usp=3Demail">change 1305</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1305?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5b6881dc73358c8d1249ee2ceb9=
68ede295105b0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1305 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: syzzer &lt;steffan@...1856...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--JWEC7ubf/LQ=--

