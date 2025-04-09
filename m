From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 9 Apr 2025 14:06:17 +0000
In-Reply-To: <gerrit.1744193529000.Iabef94b36bae16b2c8288b15b14d660ecb06842d@...2715...>
References: <gerrit.1744193529000.Iabef94b36bae16b2c8288b15b14d660ecb06842d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2cc1748fcd32793fe3674780d346259a9cf7d480-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hzpuXV5LVqo="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Doxygen: Fix
 obsolete links to OpenSSL documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hzpuXV5LVqo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/93=
7?usp=3Demail )

Change subject: Doxygen: Fix obsolete links to OpenSSL documentation
......................................................................

Doxygen: Fix obsolete links to OpenSSL documentation

Change-Id: Iabef94b36bae16b2c8288b15b14d660ecb06842d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250409125336.5835-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59171340/
Signed-off-by: Gert Doering <gert@...1296...>
---
M contrib/OCSP_check/OCSP_check.sh
M doc/doxygen/doc_key_generation.h
2 files changed, 4 insertions(+), 4 deletions(-)




diff --git a/contrib/OCSP_check/OCSP_check.sh b/contrib/OCSP_check/OCSP_che=
ck.sh
index e4fec83..ad1a420 100644
--- a/contrib/OCSP_check/OCSP_check.sh
+++ b/contrib/OCSP_check/OCSP_check.sh
@@ -7,7 +7,7 @@
 # OCSP server using the -port option to "openssl ocsp".

 # Full documentation and examples:
-# http://www.openssl.org/docs/apps/ocsp.html
+# https://docs.openssl.org/master/man1/openssl-ocsp/#openssl-ocsp


 # Edit the following values to suit your needs
diff --git a/doc/doxygen/doc_key_generation.h b/doc/doxygen/doc_key_generat=
ion.h
index d32f9d8..91c7a5a 100644
--- a/doc/doxygen/doc_key_generation.h
+++ b/doc/doxygen/doc_key_generation.h
@@ -95,11 +95,11 @@
  * to supply cryptographically strong pseudo-random data.  The following l=
inks
  * contain more information on this subject:
  * - For OpenSSL's \c RAND_bytes() function:
- *   http://www.openssl.org/docs/crypto/RAND_bytes.html
+ *   https://docs.openssl.org/master/man3/RAND_bytes/#rand_bytes
  * - For OpenSSL's pseudo-random number generating system:
- *   http://www.openssl.org/docs/crypto/rand.html
+ *   https://docs.openssl.org/master/man7/RAND/#rand
  * - For OpenSSL's support for external crypto modules:
- *   http://www.openssl.org/docs/crypto/engine.html
+ *   https://docs.openssl.org/master/man7/provider/#provider
  *
  * In mbed TLS, the Havege random number generator is used. For details, s=
ee
  * the mbed TLS documentation.

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/937?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iabef94b36bae16b2c8288b15b14d660ecb06842d
Gerrit-Change-Number: 937
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--hzpuXV5LVqo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/937?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Doxygen: Fix obsolete links to OpenSSL documen=
tation<br><br>Change-Id: Iabef94b36bae16b2c8288b15b14d660ecb06842d<br>Signe=
d-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doer=
ing &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250409125336.5835-1-gert@...220...=
..1296...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/message/591=
71340/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M c=
ontrib/OCSP_check/OCSP_check.sh<br>M doc/doxygen/doc_key_generation.h<br>2 =
files changed, 4 insertions(+), 4 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/contrib/OCSP_check/OCSP_check.sh b/contrib/OCSP_check/OCSP_=
check.sh</span><br><span>index e4fec83..ad1a420 100644</span><br><span>--- =
a/contrib/OCSP_check/OCSP_check.sh</span><br><span>+++ b/contrib/OCSP_check=
/OCSP_check.sh</span><br><span>@@ -7,7 +7,7 @@</span><br><span> # OCSP serv=
er using the -port option to &quot;openssl ocsp&quot;.</span><br><span> </s=
pan><br><span> # Full documentation and examples:</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-# http://www.openssl.org/docs/apps/ocsp.html</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# https://docs.openssl=
.org/master/man1/openssl-ocsp/#openssl-ocsp</span><br><span> </span><br><sp=
an> </span><br><span> # Edit the following values to suit your needs</span>=
<br><span>diff --git a/doc/doxygen/doc_key_generation.h b/doc/doxygen/doc_k=
ey_generation.h</span><br><span>index d32f9d8..91c7a5a 100644</span><br><sp=
an>--- a/doc/doxygen/doc_key_generation.h</span><br><span>+++ b/doc/doxygen=
/doc_key_generation.h</span><br><span>@@ -95,11 +95,11 @@</span><br><span> =
 * to supply cryptographically strong pseudo-random data.  The following li=
nks</span><br><span>  * contain more information on this subject:</span><br=
><span>  * - For OpenSSL&#39;s \c RAND_bytes() function:</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *   http://www.openssl.org/docs/crypto/=
RAND_bytes.html</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
 https://docs.openssl.org/master/man3/RAND_bytes/#rand_bytes</span><br><spa=
n>  * - For OpenSSL&#39;s pseudo-random number generating system:</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *   http://www.openssl.org/doc=
s/crypto/rand.html</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*   https://docs.openssl.org/master/man7/RAND/#rand</span><br><span>  * - F=
or OpenSSL&#39;s support for external crypto modules:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *   http://www.openssl.org/docs/crypto/eng=
ine.html</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   https:=
//docs.openssl.org/master/man7/provider/#provider</span><br><span>  *</span=
><br><span>  * In mbed TLS, the Havege random number generator is used. For=
 details, see</span><br><span>  * the mbed TLS documentation.</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/937?usp=3Demail">change 937</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/937?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iabef94b36bae16b2c8288b15b14=
d660ecb06842d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 937 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--hzpuXV5LVqo=--

