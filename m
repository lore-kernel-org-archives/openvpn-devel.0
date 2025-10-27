From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 27 Oct 2025 10:02:43 +0000
In-Reply-To: <gerrit.1761489176000.I5b6881dc73358c8d1249ee2ceb968ede295105b0@...2715...>
References: <gerrit.1761489176000.I5b6881dc73358c8d1249ee2ceb968ede295105b0@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., steffan@...1856...
Message-ID: <24746e81776da03e2aae165321d0e4f15f57fd91-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WxEkiFYTbRQ="; charset=UTF-8
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
To: syzzer <steffan@...1856...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--WxEkiFYTbRQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 syzzer. ( http://gerrit.openvpn.net/c/openvpn/+/1305?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1305
Message-Id: <20251026143521.13291-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
870.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_mbedtls.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/05/1305/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I5b6881dc73358c8d1249ee2ceb968ede295105b0
Gerrit-Change-Number: 1305
Gerrit-PatchSet: 2
Gerrit-Owner: syzzer <steffan@...1856...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--WxEkiFYTbRQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by syzzer.</p>=
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1305?usp=3Demail">View =
Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">ssl_mbedtls: fix missing perf_pop()=
 call<br><br>This was triggered by a bug report submitted by Joshua Rogers,=
 who<br>used ZeroPath to discover we missed a perf_pop() call in one of the=
<br>error paths of ssl_mbedtls.c.<br><br>Move an existing perf_pop call a b=
it upwards to fix that.<br><br>The perf code is always disabled by ENABLE_P=
ERFORMANCE_METRICS being<br>commented out in perf.h. There is no configure =
flag. None of the active<br>developers remembers using it and the git log s=
hows no actual code changes<br>since at least the project structure overhau=
l of 2012. So this has no<br>real-world impact.<br><br>Change-Id: I5b6881dc=
73358c8d1249ee2ceb968ede295105b0<br>Signed-off-by: Steffan Karger &lt;steff=
an@...1856...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerr=
it URL: https://gerrit.openvpn.net/c/openvpn/+/1305<br>Message-Id: &lt;2025=
1026143521.13291-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com=
/openvpn-devel@lists.sourceforge.net/msg33870.html<br>Signed-off-by: Gert D=
oering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl_mbedtls.c<br>1 f=
ile changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/05/1305/2</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span><br=
><span>index 8fb69c3..2862989 100644</span><br><span>--- a/src/openvpn/ssl_=
mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><span>@=
@ -1489,13 +1489,13 @@</span><br><span>     /* Error during read, check for=
 retry error */</span><br><span>     if (retval &lt; 0)</span><br><span>   =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        perf_pop=
();</span><br><span>         if (MBEDTLS_ERR_SSL_WANT_WRITE =3D=3D retval |=
| MBEDTLS_ERR_SSL_WANT_READ =3D=3D retval)</span><br><span>         {</span=
><br><span>             return 0;</span><br><span>         }</span><br><spa=
n>         mbed_log_err(D_TLS_ERRORS, retval, &quot;TLS_ERROR: read tls_rea=
d_plaintext error&quot;);</span><br><span>         buf-&gt;len =3D 0;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        perf_pop();</span><=
br><span>         return -1;</span><br><span>     }</span><br><span>     /*=
 Nothing read, try again */</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1305?usp=3Demail">chan=
ge 1305</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div =
itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1305?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5b6881dc73358c8d1249ee2ceb9=
68ede295105b0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1305 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: syzzer &lt;steffan@...1856...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--WxEkiFYTbRQ=--

