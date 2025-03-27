From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 27 Mar 2025 09:14:05 +0000
In-Reply-To: <gerrit.1742992852000.I8bbb6ffdac7d0029dbf3c13e62c11b61813c15ef@...2715...>
References: <gerrit.1742992852000.I8bbb6ffdac7d0029dbf3c13e62c11b61813c15ef@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, max@...2606...
Message-ID: <39229a26fd52499a913f25c1ca1ba8701a6915a4-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KM77wlXzr70="; charset=UTF-8
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, MaxF <max@...2606...>

--KM77wlXzr70=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/918?usp=3Demail

to look at the new patch set (#3).


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
1 file changed, 4 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/918/3

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 92b52fe..e15c391 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1246,6 +1246,10 @@
     ALLOC_OBJ_CLEAR(ks_ssl->ctx, mbedtls_ssl_context);
     mbedtls_ssl_init(ks_ssl->ctx);
     mbed_ok(mbedtls_ssl_setup(ks_ssl->ctx, ks_ssl->ssl_config));
+    /* We do verification in our own callback depending on the
+     * exact configuration. We do not rely on the default hostname
+     * verification. */
+    ASSERT(mbed_ok(mbedtls_ssl_set_hostname(ks_ssl->ctx, NULL)));

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
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: MaxF <max@...2606...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--KM77wlXzr70=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>flichtenheld <strong>uploaded patch set #3</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/918?usp=3Demail">View Ch=
ange</a></p><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Fix compatibility with mbedTLS 2.28.10+ and 3.6.3+<br><br>From rel=
ease notes:<br>In TLS clients, if mbedtls_ssl_set_hostname() has not been c=
alled,<br>mbedtls_ssl_handshake() now fails with<br>MBEDTLS_ERR_SSL_CERTIFI=
CATE_VERIFICATION_WITHOUT_HOSTNAME<br>if certificate-based authentication o=
f the server is attempted.<br>This is because authenticating a server witho=
ut knowing what name<br>to expect is usually insecure. To restore the old b=
ehavior, either<br>call mbedtls_ssl_set_hostname() with NULL as the hostnam=
e [...]<br><br>Change-Id: I8bbb6ffdac7d0029dbf3c13e62c11b61813c15ef<br>Sign=
ed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openv=
pn/ssl_mbedtls.c<br>1 file changed, 4 insertions(+), 0 deletions(-)<br><br>=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/918/3</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</s=
pan><br><span>index 92b52fe..e15c391 100644</span><br><span>--- a/src/openv=
pn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br>=
<span>@@ -1246,6 +1246,10 @@</span><br><span>     ALLOC_OBJ_CLEAR(ks_ssl-&g=
t;ctx, mbedtls_ssl_context);</span><br><span>     mbedtls_ssl_init(ks_ssl-&=
gt;ctx);</span><br><span>     mbed_ok(mbedtls_ssl_setup(ks_ssl-&gt;ctx, ks_=
ssl-&gt;ssl_config));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* We do verification in our own callback depending on the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * exact configuration. We=
 do not rely on the default hostname</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * verification. */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ASSERT(mbed_ok(mbedtls_ssl_set_hostname(ks_ssl-&gt=
;ctx, NULL)));</span><br><span> </span><br><span> #if HAVE_MBEDTLS_SSL_SET_=
EXPORT_KEYS_CB</span><br><span>     /* Initialize keying material exporter,=
 new style. */</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/918?usp=3Demail">change 918</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/918?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8bbb6ffdac7d0029dbf3c13e62c=
11b61813c15ef </div>
<div style=3D"display:none"> Gerrit-Change-Number: 918 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: MaxF &lt;max@...2606...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--KM77wlXzr70=--

