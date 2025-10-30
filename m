From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 30 Oct 2025 21:06:01 +0000
In-Reply-To: <gerrit.1761737448000.I70e221ff5d9752fec17bad18fd41dcf188ae8fbc@...2715...>
References: <gerrit.1761737448000.I70e221ff5d9752fec17bad18fd41dcf188ae8fbc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <8994170facf4837fac6184177776bcc81ec71b4d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YHS+iiphJTY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Ensure that
 get_sigtype always return non-NULL
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

--YHS+iiphJTY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1325?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Ensure that get_sigtype always return non-NULL
......................................................................

Ensure that get_sigtype always return non-NULL

There is a theoretical possibility that OpenSSL returns an NID that
OBJ_nid2sn cannot resolve and thus the function return NULL.

This is however extremely unlikely. But we still cover this case now
to make linters/code checker happy and avoid similar false positives
in the future.

Reported-by: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)
Change-Id: I70e221ff5d9752fec17bad18fd41dcf188ae8fbc
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1325
Message-Id: <20251030193003.348-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
060.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_openssl.c
1 file changed, 11 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/1325/3

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index d997141..a4a6863 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2408,7 +2408,17 @@
             return "(error getting name)";

         default:
-            return OBJ_nid2sn(nid);
+        {
+            const char *type =3D OBJ_nid2sn(nid);
+            if (!type)
+            {
+                /* This is unlikely to ever happen as OpenSSL is unlikely =
to
+                 * return an NID it cannot resolve itself but we silence
+                 * linter/code checkers here */
+                type =3D "(error getting name, OBJ_nid2sn failed)";
+            }
+            return type;
+        }
     }
 }
 #endif /* ifndef LIBRESSL_VERSION_NUMBER */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1325?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I70e221ff5d9752fec17bad18fd41dcf188ae8fbc
Gerrit-Change-Number: 1325
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YHS+iiphJTY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1325?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Ensure that get_sigtype always retu=
rn non-NULL<br><br>There is a theoretical possibility that OpenSSL returns =
an NID that<br>OBJ_nid2sn cannot resolve and thus the function return NULL.=
<br><br>This is however extremely unlikely. But we still cover this case no=
w<br>to make linters/code checker happy and avoid similar false positives<b=
r>in the future.<br><br>Reported-by: Joshua Rogers &lt;contact@...2949...&g=
t;<br>Found-by: ZeroPath (https://zeropath.com/)<br>Change-Id: I70e221ff5d9=
752fec17bad18fd41dcf188ae8fbc<br>Signed-off-by: Arne Schwabe &lt;arne@...1711...=
27...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: =
https://gerrit.openvpn.net/c/openvpn/+/1325<br>Message-Id: &lt;202510301930=
03.348-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-d=
evel@lists.sourceforge.net/msg34060.html<br>Signed-off-by: Gert Doering &lt=
;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl_openssl.c<br>1 file change=
d, 11 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/25/1325/3</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><span=
>index d997141..a4a6863 100644</span><br><span>--- a/src/openvpn/ssl_openss=
l.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -240=
8,7 +2408,17 @@</span><br><span>             return &quot;(error getting na=
me)&quot;;</span><br><span> </span><br><span>         default:</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            return OBJ_nid2sn(nid)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            const char *type=
 =3D OBJ_nid2sn(nid);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            if (!type)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               /* This is unlikely to ever happen as OpenSSL is unlikely to=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 * =
return an NID it cannot resolve itself but we silence</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                 * linter/code checkers h=
ere */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   type =3D &quot;(error getting name, OBJ_nid2sn failed)&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            return type;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     =
}</span><br><span> }</span><br><span> #endif /* ifndef LIBRESSL_VERSION_NUM=
BER */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1325?usp=3Demail">change 1325</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1325?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I70e221ff5d9752fec17bad18fd4=
1dcf188ae8fbc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1325 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--YHS+iiphJTY=--

