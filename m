From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 27 Apr 2026 14:48:49 +0000
In-Reply-To: <gerrit.1776718304000.Ica5f37e525c3812609021750ecd3986c1420e2a4@...2715...>
References: <gerrit.1776718304000.Ica5f37e525c3812609021750ecd3986c1420e2a4@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, max@...2606...
Message-ID: <086997eb29e077673bb0761bb22fbda36a351f11-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jqLUiRQ8YQg="; charset=UTF-8
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
To: MaxF <max@...2606...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jqLUiRQ8YQg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 MaxF. ( http://gerrit.openvpn.net/c/openvpn/+/1633?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


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
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1633
Message-Id: <20260421055357.21708-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
699.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_mbedtls.c
1 file changed, 6 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/33/1633/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ica5f37e525c3812609021750ecd3986c1420e2a4
Gerrit-Change-Number: 1633
Gerrit-PatchSet: 2
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jqLUiRQ8YQg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by MaxF.</p><p=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1633?usp=3Demail">View Ch=
ange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">Mbed TLS: Error out if we have =
no valid tls-groups<br><br>Previously, when no valid groups were specified =
with the tls-groups<br>option, the Mbed TLS build of OpenVPN would start up=
 and run, but fail<br>to complete a handshake, while the OpenSSL build woul=
d exit with an<br>error. This commit changes the behavior of the Mbed TLS b=
uild to match<br>the OpenSSL version.<br><br>Change-Id: Ica5f37e525c3812609=
021750ecd3986c1420e2a4<br>Signed-off-by: Max Fillinger &lt;maximilian.filli=
nger@...2918...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&g=
t;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1633<br>Message-Id=
: &lt;20260421055357.21708-1-gert@...1296...&gt;<br>URL: https://www.mail-a=
rchive.com/openvpn-devel@lists.sourceforge.net/msg36699.html<br>Signed-off-=
by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl_mbedtl=
s.c<br>1 file changed, 6 insertions(+), 0 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/33/1633=
/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls=
.c</span><br><span>index 85c771a..8a0f7d2 100644</span><br><span>--- a/src/=
openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span=
><br><span>@@ -450,6 +450,12 @@</span><br><span>         }</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* Check if any groups were valid. */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (i =3D=3D 0)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(M_FATAL, &quot;Error: All groups in \&quot;%s\&quo=
t; are invalid or unsupported.&quot;, groups);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>     /* Recent mbedtls versions state that th=
e list of groups must be terminated</span><br><span>      * with 0. Older v=
ersions state that it must be terminated with MBEDTLS_ECP_DP_NONE</span><br=
><span>      * which is also 0, so this works either way. */</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1633?usp=3Demail">change 1633</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?us=
p=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1633?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ica5f37e525c3812609021750ecd=
3986c1420e2a4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1633 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--jqLUiRQ8YQg=--

