From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 27 Mar 2025 12:18:20 +0000
In-Reply-To: <gerrit.1742992852000.I8bbb6ffdac7d0029dbf3c13e62c11b61813c15ef@...2715...>
References: <gerrit.1742992852000.I8bbb6ffdac7d0029dbf3c13e62c11b61813c15ef@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <89b31cb25e8edb182d6fdae66a2f51926567fd31-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3v/uhMlP6fY="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3v/uhMlP6fY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/918?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by MaxF


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
Acked-by: MaxF <max@...2606...>
Message-Id: <20250327113356.11233-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
262.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_mbedtls.c
1 file changed, 4 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/918/4

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
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--3v/uhMlP6fY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/918?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by MaxF</p><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">Fix compatibility with mbedTLS 2.28.10+ and 3.6.3+<br=
><br>From release notes:<br>In TLS clients, if mbedtls_ssl_set_hostname() h=
as not been called,<br>mbedtls_ssl_handshake() now fails with<br>MBEDTLS_ER=
R_SSL_CERTIFICATE_VERIFICATION_WITHOUT_HOSTNAME<br>if certificate-based aut=
hentication of the server is attempted.<br>This is because authenticating a=
 server without knowing what name<br>to expect is usually insecure. To rest=
ore the old behavior, either<br>call mbedtls_ssl_set_hostname() with NULL a=
s the hostname [...]<br><br>Change-Id: I8bbb6ffdac7d0029dbf3c13e62c11b61813=
c15ef<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked=
-by: MaxF &lt;max@...2606...&gt;<br>Message-Id: &lt;20250327113356.11233-1-=
gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1514...=
s.sourceforge.net/msg31262.html<br>Signed-off-by: Gert Doering &lt;gert@...493...=
1296...&gt;<br>---<br>M src/openvpn/ssl_mbedtls.c<br>1 file changed, 4 inse=
rtions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/18/918/4</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_mbedtls=
.c b/src/openvpn/ssl_mbedtls.c</span><br><span>index 92b52fe..e15c391 10064=
4</span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src=
/openvpn/ssl_mbedtls.c</span><br><span>@@ -1246,6 +1246,10 @@</span><br><sp=
an>     ALLOC_OBJ_CLEAR(ks_ssl-&gt;ctx, mbedtls_ssl_context);</span><br><sp=
an>     mbedtls_ssl_init(ks_ssl-&gt;ctx);</span><br><span>     mbed_ok(mbed=
tls_ssl_setup(ks_ssl-&gt;ctx, ks_ssl-&gt;ssl_config));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* We do verification in our own cal=
lback depending on the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * exact configuration. We do not rely on the default hostname</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * verification. */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(mbed_ok(mb=
edtls_ssl_set_hostname(ks_ssl-&gt;ctx, NULL)));</span><br><span> </span><br=
><span> #if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB</span><br><span>     /* Ini=
tialize keying material exporter, new style. */</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/91=
8?usp=3Demail">change 918</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/918?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8bbb6ffdac7d0029dbf3c13e62c=
11b61813c15ef </div>
<div style=3D"display:none"> Gerrit-Change-Number: 918 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--3v/uhMlP6fY=--

