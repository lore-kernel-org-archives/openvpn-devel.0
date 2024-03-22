From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 22 Mar 2024 15:59:07 +0000
References: <gerrit.1711123146000.I3c6fd36eb9daee9244d6dc6d9f22de1c5cf9d039@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <7a38a8ac8fa226b0c675a188720c8e89ccff6462-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CxZ/HZJgYzU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Use snprintf
 instead of sprintf for get_ssl_library_version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CxZ/HZJgYzU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/545?usp=3Demail

to review the following change.


Change subject: Use snprintf instead of sprintf for get_ssl_library_version
......................................................................

Use snprintf instead of sprintf for get_ssl_library_version

This is avoid a warning/error (when using -Werror) under current macOS
of sprintf:

   __deprecated_msg("This function is provided for compatibility
   reasons only.  Due to security concerns inherent in the design
   of sprintf(3), it is highly recommended that you use snprintf(3)
   instead.")

Change-Id: I3c6fd36eb9daee9244d6dc6d9f22de1c5cf9d039
---
M src/openvpn/ssl_mbedtls.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/545/1

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index b44ddd5..0730d25 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1614,7 +1614,7 @@
 {
     static char mbedtls_version[30];
     unsigned int pv =3D mbedtls_version_get_number();
-    sprintf( mbedtls_version, "mbed TLS %d.%d.%d",
+    snprintf(mbedtls_version, sizeof(mbedtls_version), "mbed TLS %d.%d.%d",
              (pv>>24)&0xff, (pv>>16)&0xff, (pv>>8)&0xff );
     return mbedtls_version;
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/545?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3c6fd36eb9daee9244d6dc6d9f22de1c5cf9d039
Gerrit-Change-Number: 545
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--CxZ/HZJgYzU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/545?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Use snprintf instead of sprintf for get_ssl_library_version<b=
r><br>This is avoid a warning/error (when using -Werror) under current macO=
S<br>of sprintf:<br><br>   __deprecated_msg(&quot;This function is provided=
 for compatibility<br>   reasons only.  Due to security concerns inherent i=
n the design<br>   of sprintf(3), it is highly recommended that you use snp=
rintf(3)<br>   instead.&quot;)<br><br>Change-Id: I3c6fd36eb9daee9244d6dc6d9=
f22de1c5cf9d039<br>---<br>M src/openvpn/ssl_mbedtls.c<br>1 file changed, 1 =
insertion(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:294=
18/openvpn refs/changes/45/545/1</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_mbedt=
ls.c b/src/openvpn/ssl_mbedtls.c</span><br><span>index b44ddd5..0730d25 100=
644</span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/s=
rc/openvpn/ssl_mbedtls.c</span><br><span>@@ -1614,7 +1614,7 @@</span><br><s=
pan> {</span><br><span>     static char mbedtls_version[30];</span><br><spa=
n>     unsigned int pv =3D mbedtls_version_get_number();</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    sprintf( mbedtls_version, &quot;mbed=
 TLS %d.%d.%d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    snprintf(mbedtls_version, sizeof(mbedtls_version), &quot;mbed TLS %d.%=
d.%d&quot;,</span><br><span>              (pv&gt;&gt;24)&amp;0xff, (pv&gt;&=
gt;16)&amp;0xff, (pv&gt;&gt;8)&amp;0xff );</span><br><span>     return mbed=
tls_version;</span><br><span> }</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/545?usp=3Demail">c=
hange 545</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/545?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3c6fd36eb9daee9244d6dc6d9f2=
2de1c5cf9d039 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 545 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--CxZ/HZJgYzU=--

