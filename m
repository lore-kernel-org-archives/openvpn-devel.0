From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 9 Apr 2025 10:12:11 +0000
References: <gerrit.1744193529000.Iabef94b36bae16b2c8288b15b14d660ecb06842d@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b0cd4cc4a1c3b3e2a4a09135662f65004f82ef59-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="j9SmLnyL1NY="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--j9SmLnyL1NY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/937?usp=3Demail

to review the following change.


Change subject: Doxygen: Fix obsolete links to OpenSSL documentation
......................................................................

Doxygen: Fix obsolete links to OpenSSL documentation

Change-Id: Iabef94b36bae16b2c8288b15b14d660ecb06842d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M contrib/OCSP_check/OCSP_check.sh
M doc/doxygen/doc_key_generation.h
2 files changed, 4 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/37/937/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--j9SmLnyL1NY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/937?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Doxygen: Fix obsolete links to OpenSSL documentation<br><br>C=
hange-Id: Iabef94b36bae16b2c8288b15b14d660ecb06842d<br>Signed-off-by: Frank=
 Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M contrib/OCSP_check/OCSP_c=
heck.sh<br>M doc/doxygen/doc_key_generation.h<br>2 files changed, 4 inserti=
ons(+), 4 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/op=
envpn refs/changes/37/937/1</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/contrib/OCSP_check/OCSP_ch=
eck.sh b/contrib/OCSP_check/OCSP_check.sh</span><br><span>index e4fec83..ad=
1a420 100644</span><br><span>--- a/contrib/OCSP_check/OCSP_check.sh</span><=
br><span>+++ b/contrib/OCSP_check/OCSP_check.sh</span><br><span>@@ -7,7 +7,=
7 @@</span><br><span> # OCSP server using the -port option to &quot;openssl=
 ocsp&quot;.</span><br><span> </span><br><span> # Full documentation and ex=
amples:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# http://www.o=
penssl.org/docs/apps/ocsp.html</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# https://docs.openssl.org/master/man1/openssl-ocsp/#openssl-ocs=
p</span><br><span> </span><br><span> </span><br><span> # Edit the following=
 values to suit your needs</span><br><span>diff --git a/doc/doxygen/doc_key=
_generation.h b/doc/doxygen/doc_key_generation.h</span><br><span>index d32f=
9d8..91c7a5a 100644</span><br><span>--- a/doc/doxygen/doc_key_generation.h<=
/span><br><span>+++ b/doc/doxygen/doc_key_generation.h</span><br><span>@@ -=
95,11 +95,11 @@</span><br><span>  * to supply cryptographically strong pseu=
do-random data.  The following links</span><br><span>  * contain more infor=
mation on this subject:</span><br><span>  * - For OpenSSL&#39;s \c RAND_byt=
es() function:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   ht=
tp://www.openssl.org/docs/crypto/RAND_bytes.html</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *   https://docs.openssl.org/master/man3/RAND=
_bytes/#rand_bytes</span><br><span>  * - For OpenSSL&#39;s pseudo-random nu=
mber generating system:</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *   http://www.openssl.org/docs/crypto/rand.html</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *   https://docs.openssl.org/master/man7=
/RAND/#rand</span><br><span>  * - For OpenSSL&#39;s support for external cr=
ypto modules:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   htt=
p://www.openssl.org/docs/crypto/engine.html</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *   https://docs.openssl.org/master/man7/provider/=
#provider</span><br><span>  *</span><br><span>  * In mbed TLS, the Havege r=
andom number generator is used. For details, see</span><br><span>  * the mb=
ed TLS documentation.</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/937?usp=3Demail">change 937<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/937?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iabef94b36bae16b2c8288b15b14=
d660ecb06842d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 937 </div>
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


--j9SmLnyL1NY=--

