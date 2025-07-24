From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 24 Jul 2025 12:31:41 +0000
References: <gerrit.1753360288000.I03e5ece7580ca4ebd41a7928ead544df46e8bad1@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <423a6b1f6c4ac0a936ef04c0fc15490da1747ec2-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ipw0tndTRW4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_common: Make
 sure ssl flags are treated as unsigned
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

--ipw0tndTRW4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1104?usp=3Demail

to review the following change.


Change subject: ssl_common: Make sure ssl flags are treated as unsigned
......................................................................

ssl_common: Make sure ssl flags are treated as unsigned

tls_options.ssl_flags is already unsigned, make sure the
flags are as well to avoid spurious conversion warnings.

Change-Id: I03e5ece7580ca4ebd41a7928ead544df46e8bad1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl_common.h
1 file changed, 9 insertions(+), 9 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04/1104/1

diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index e9e50da..750891c 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -415,17 +415,17 @@
 #endif

     /* configuration file SSL-related boolean and low-permutation options =
*/
-#define SSLF_CLIENT_CERT_NOT_REQUIRED (1<<0)
-#define SSLF_CLIENT_CERT_OPTIONAL     (1<<1)
-#define SSLF_USERNAME_AS_COMMON_NAME  (1<<2)
-#define SSLF_AUTH_USER_PASS_OPTIONAL  (1<<3)
-#define SSLF_OPT_VERIFY               (1<<4)
-#define SSLF_CRL_VERIFY_DIR           (1<<5)
+#define SSLF_CLIENT_CERT_NOT_REQUIRED (1u<<0)
+#define SSLF_CLIENT_CERT_OPTIONAL     (1u<<1)
+#define SSLF_USERNAME_AS_COMMON_NAME  (1u<<2)
+#define SSLF_AUTH_USER_PASS_OPTIONAL  (1u<<3)
+#define SSLF_OPT_VERIFY               (1u<<4)
+#define SSLF_CRL_VERIFY_DIR           (1u<<5)
 #define SSLF_TLS_VERSION_MIN_SHIFT    6
-#define SSLF_TLS_VERSION_MIN_MASK     0xF  /* (uses bit positions 6 to 9) =
*/
+#define SSLF_TLS_VERSION_MIN_MASK     0xFu  /* (uses bit positions 6 to 9)=
 */
 #define SSLF_TLS_VERSION_MAX_SHIFT    10
-#define SSLF_TLS_VERSION_MAX_MASK     0xF  /* (uses bit positions 10 to 13=
) */
-#define SSLF_TLS_DEBUG_ENABLED        (1<<14)
+#define SSLF_TLS_VERSION_MAX_MASK     0xFu  /* (uses bit positions 10 to 1=
3) */
+#define SSLF_TLS_DEBUG_ENABLED        (1u<<14)
     unsigned int ssl_flags;

 #ifdef ENABLE_MANAGEMENT

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1104?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I03e5ece7580ca4ebd41a7928ead544df46e8bad1
Gerrit-Change-Number: 1104
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--ipw0tndTRW4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1104?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">ssl_common: Make sure ssl flags are treated as unsigned<br><=
br>tls_options.ssl_flags is already unsigned, make sure the<br>flags are as=
 well to avoid spurious conversion warnings.<br><br>Change-Id: I03e5ece7580=
ca4ebd41a7928ead544df46e8bad1<br>Signed-off-by: Frank Lichtenheld &lt;frank=
@...2641...&gt;<br>---<br>M src/openvpn/ssl_common.h<br>1 file changed, 9 i=
nsertions(+), 9 deletions(-)<br><br></pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29=
418/openvpn refs/changes/04/1104/1</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_com=
mon.h b/src/openvpn/ssl_common.h</span><br><span>index e9e50da..750891c 100=
644</span><br><span>--- a/src/openvpn/ssl_common.h</span><br><span>+++ b/sr=
c/openvpn/ssl_common.h</span><br><span>@@ -415,17 +415,17 @@</span><br><spa=
n> #endif</span><br><span> </span><br><span>     /* configuration file SSL-=
related boolean and low-permutation options */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define SSLF_CLIENT_CERT_NOT_REQUIRED (1&lt;&lt;0)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define SSLF_CLIENT_C=
ERT_OPTIONAL     (1&lt;&lt;1)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define SSLF_USERNAME_AS_COMMON_NAME  (1&lt;&lt;2)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define SSLF_AUTH_USER_PASS_OPTIONAL  =
(1&lt;&lt;3)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define S=
SLF_OPT_VERIFY               (1&lt;&lt;4)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define SSLF_CRL_VERIFY_DIR           (1&lt;&lt;5)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SSLF_CLIENT_CERT=
_NOT_REQUIRED (1u&lt;&lt;0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define SSLF_CLIENT_CERT_OPTIONAL     (1u&lt;&lt;1)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define SSLF_USERNAME_AS_COMMON_NAM=
E  (1u&lt;&lt;2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine SSLF_AUTH_USER_PASS_OPTIONAL  (1u&lt;&lt;3)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define SSLF_OPT_VERIFY               (1u&lt;&=
lt;4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SSLF_C=
RL_VERIFY_DIR           (1u&lt;&lt;5)</span><br><span> #define SSLF_TLS_VER=
SION_MIN_SHIFT    6</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine SSLF_TLS_VERSION_MIN_MASK     0xF  /* (uses bit positions 6 to 9) */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SSLF_TLS_VER=
SION_MIN_MASK     0xFu  /* (uses bit positions 6 to 9) */</span><br><span> =
#define SSLF_TLS_VERSION_MAX_SHIFT    10</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define SSLF_TLS_VERSION_MAX_MASK     0xF  /* (uses bit =
positions 10 to 13) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define SSLF_TLS_DEBUG_ENABLED        (1&lt;&lt;14)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define SSLF_TLS_VERSION_MAX_MASK     0xF=
u  /* (uses bit positions 10 to 13) */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define SSLF_TLS_DEBUG_ENABLED        (1u&lt;&lt;14)</sp=
an><br><span>     unsigned int ssl_flags;</span><br><span> </span><br><span=
> #ifdef ENABLE_MANAGEMENT</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1104?usp=3Demail">chang=
e 1104</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1104?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I03e5ece7580ca4ebd41a7928ead=
544df46e8bad1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1104 </div>
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


--ipw0tndTRW4=--

