From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 26 Mar 2025 12:40:54 +0000
References: <gerrit.1742992852000.I8bbb6ffdac7d0029dbf3c13e62c11b61813c15ef@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ba3b779fc2f562910a3e058514f6e36150789245-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YqNLiXv+iT0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix compatibility
 with mbedTLS 2.28.10+ and 3.6.3+
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

--YqNLiXv+iT0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/918?usp=3Demail

to review the following change.


Change subject: Fix compatibility with mbedTLS 2.28.10+ and 3.6.3+
......................................................................

Fix compatibility with mbedTLS 2.28.10+ and 3.6.3+

From release notes:
In TLS clients, if mbedtls_ssl_set_hostname() has not been called,
mbedtls_ssl_handshake() now fails with
MBEDTLS_ERR_SSL_CERTIFICATE_VERIFICATION_WITHOUT_HOSTNAME
if certificate-based authentication of the server is attempted.
This is because authenticating a server without knowing what name
to expect is usually insecure. To restore the old behavior, either
call mbedtls_ssl_set_hostname() with NULL as the hostname [...]

Change-Id: I8bbb6ffdac7d0029dbf3c13e62c11b61813c15ef
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl_mbedtls.c
1 file changed, 2 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/918/1

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 92b52fe..a79c8db 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1246,6 +1246,8 @@
     ALLOC_OBJ_CLEAR(ks_ssl->ctx, mbedtls_ssl_context);
     mbedtls_ssl_init(ks_ssl->ctx);
     mbed_ok(mbedtls_ssl_setup(ks_ssl->ctx, ks_ssl->ssl_config));
+    /* Tell mbedTLS that we generally do not care about the hostname */
+    mbedtls_ssl_set_hostname(ks_ssl->ctx, NULL);

 #if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
     /* Initialize keying material exporter, new style. */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/918?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8bbb6ffdac7d0029dbf3c13e62c11b61813c15ef
Gerrit-Change-Number: 918
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--YqNLiXv+iT0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/918?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix compatibility with mbedTLS 2.28.10+ and 3.6.3+<br><br>Fro=
m release notes:<br>In TLS clients, if mbedtls_ssl_set_hostname() has not b=
een called,<br>mbedtls_ssl_handshake() now fails with<br>MBEDTLS_ERR_SSL_CE=
RTIFICATE_VERIFICATION_WITHOUT_HOSTNAME<br>if certificate-based authenticat=
ion of the server is attempted.<br>This is because authenticating a server =
without knowing what name<br>to expect is usually insecure. To restore the =
old behavior, either<br>call mbedtls_ssl_set_hostname() with NULL as the ho=
stname [...]<br><br>Change-Id: I8bbb6ffdac7d0029dbf3c13e62c11b61813c15ef<br=
>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/=
openvpn/ssl_mbedtls.c<br>1 file changed, 2 insertions(+), 0 deletions(-)<br=
><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/918=
/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls=
.c</span><br><span>index 92b52fe..a79c8db 100644</span><br><span>--- a/src/=
openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span=
><br><span>@@ -1246,6 +1246,8 @@</span><br><span>     ALLOC_OBJ_CLEAR(ks_ss=
l-&gt;ctx, mbedtls_ssl_context);</span><br><span>     mbedtls_ssl_init(ks_s=
sl-&gt;ctx);</span><br><span>     mbed_ok(mbedtls_ssl_setup(ks_ssl-&gt;ctx,=
 ks_ssl-&gt;ssl_config));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* Tell mbedTLS that we generally do not care about the hostname =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_ssl_s=
et_hostname(ks_ssl-&gt;ctx, NULL);</span><br><span> </span><br><span> #if H=
AVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB</span><br><span>     /* Initialize keyin=
g material exporter, new style. */</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/918?usp=3Demail=
">change 918</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/918?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8bbb6ffdac7d0029dbf3c13e62c=
11b61813c15ef </div>
<div style=3D"display:none"> Gerrit-Change-Number: 918 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--YqNLiXv+iT0=--

