From: "MaxF (Code Review)" <gerrit@...515...>
Date: Mon, 20 Apr 2026 20:51:46 +0000
References: <gerrit.1776718304000.Ica5f37e525c3812609021750ecd3986c1420e2a4@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <47e300f887942a8821fe1c5e7c94e8d801e25281-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R7x8f90rsyU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Mbed TLS: Error out
 if we have no valid tls-groups
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

--R7x8f90rsyU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1633?usp=3Demail

to review the following change.


Change subject: Mbed TLS: Error out if we have no valid tls-groups
......................................................................

Mbed TLS: Error out if we have no valid tls-groups

Previously, when no valid groups were specified with the tls-groups
option, the Mbed TLS build of OpenVPN would start up and run, but fail
to complete a handshake, while the OpenSSL build would exit with an
error. This commit changes the behavior of the Mbed TLS build to match
the OpenSSL version.

Change-Id: Ica5f37e525c3812609021750ecd3986c1420e2a4
Signed-off-by: Max Fillinger <maximilian.fillinger@...2918...>
---
M src/openvpn/ssl_mbedtls.c
1 file changed, 6 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/33/1633/1

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 85c771a..8a0f7d2 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -450,6 +450,12 @@
         }
     }

+    /* Check if any groups were valid. */
+    if (i =3D=3D 0)
+    {
+        msg(M_FATAL, "Error: All groups in \"%s\" are invalid or unsupport=
ed.", groups);
+    }
+
     /* Recent mbedtls versions state that the list of groups must be termi=
nated
      * with 0. Older versions state that it must be terminated with MBEDTL=
S_ECP_DP_NONE
      * which is also 0, so this works either way. */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1633?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ica5f37e525c3812609021750ecd3986c1420e2a4
Gerrit-Change-Number: 1633
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--R7x8f90rsyU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>MaxF would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1633?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Mbed TLS: Error out if we have no valid tls=
-groups<br><br>Previously, when no valid groups were specified with the tls=
-groups<br>option, the Mbed TLS build of OpenVPN would start up and run, bu=
t fail<br>to complete a handshake, while the OpenSSL build would exit with =
an<br>error. This commit changes the behavior of the Mbed TLS build to matc=
h<br>the OpenSSL version.<br><br>Change-Id: Ica5f37e525c3812609021750ecd398=
6c1420e2a4<br>Signed-off-by: Max Fillinger &lt;maximilian.fillinger@...2925...=
...&gt;<br>---<br>M src/openvpn/ssl_mbedtls.c<br>1 file changed, 6 insertio=
ns(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/33/1633/1</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span><br><span>index 85c771a.=
.8a0f7d2 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><=
span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><span>@@ -450,6 +450,12 @@</=
span><br><span>         }</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* Check if any groups w=
ere valid. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (i =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL,=
 &quot;Error: All groups in \&quot;%s\&quot; are invalid or unsupported.&qu=
ot;, groups);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   =
  /* Recent mbedtls versions state that the list of groups must be terminat=
ed</span><br><span>      * with 0. Older versions state that it must be ter=
minated with MBEDTLS_ECP_DP_NONE</span><br><span>      * which is also 0, s=
o this works either way. */</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1633?usp=3Demail">chan=
ge 1633</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div =
itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1633?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ica5f37e525c3812609021750ecd=
3986c1420e2a4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1633 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--R7x8f90rsyU=--

