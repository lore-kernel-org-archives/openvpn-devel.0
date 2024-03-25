From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 25 Mar 2024 16:43:38 +0000
In-Reply-To: <gerrit.1711123146000.I3c6fd36eb9daee9244d6dc6d9f22de1c5cf9d039@...2715...>
References: <gerrit.1711123146000.I3c6fd36eb9daee9244d6dc6d9f22de1c5cf9d039@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <265ed2abd8d156ab31bb182b44e192413d5ab3db-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="L6nYgQy0xUE="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--L6nYgQy0xUE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/545?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


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
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240325125052.14135-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
458.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_mbedtls.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/545/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--L6nYgQy0xUE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
545?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Use snprintf instead of sprintf for get_ssl_l=
ibrary_version<br><br>This is avoid a warning/error (when using -Werror) un=
der current macOS<br>of sprintf:<br><br>   __deprecated_msg(&quot;This func=
tion is provided for compatibility<br>   reasons only.  Due to security con=
cerns inherent in the design<br>   of sprintf(3), it is highly recommended =
that you use snprintf(3)<br>   instead.&quot;)<br><br>Change-Id: I3c6fd36eb=
9daee9244d6dc6d9f22de1c5cf9d039<br>Signed-off-by: Arne Schwabe &lt;arne-ope=
nvpn@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;=
<br>Message-Id: &lt;20240325125052.14135-1-gert@...1296...&gt;<br>URL: http=
s://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28458.html<=
br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/open=
vpn/ssl_mbedtls.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br><=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/545/2</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</sp=
an><br><span>index b44ddd5..0730d25 100644</span><br><span>--- a/src/openvp=
n/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><=
span>@@ -1614,7 +1614,7 @@</span><br><span> {</span><br><span>     static c=
har mbedtls_version[30];</span><br><span>     unsigned int pv =3D mbedtls_v=
ersion_get_number();</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   sprintf( mbedtls_version, &quot;mbed TLS %d.%d.%d&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    snprintf(mbedtls_version, sizeo=
f(mbedtls_version), &quot;mbed TLS %d.%d.%d&quot;,</span><br><span>        =
      (pv&gt;&gt;24)&amp;0xff, (pv&gt;&gt;16)&amp;0xff, (pv&gt;&gt;8)&amp;0=
xff );</span><br><span>     return mbedtls_version;</span><br><span> }</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/545?usp=3Demail">change 545</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/545?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3c6fd36eb9daee9244d6dc6d9f2=
2de1c5cf9d039 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 545 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--L6nYgQy0xUE=--

