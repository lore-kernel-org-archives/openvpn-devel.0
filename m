From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 6 May 2026 21:21:21 +0000
References: <gerrit.1778102459000.I05720ccc3bcf706bbe62254afb74562580f5de56@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <a257245a4bb4e1668d1d94af11db8fcceaa9be79-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JdshRjScmS8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dev-tools: Fix
 run-cppcheck to cover more code
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

--JdshRjScmS8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1665?usp=3Demail

to review the following change.


Change subject: dev-tools: Fix run-cppcheck to cover more code
......................................................................

dev-tools: Fix run-cppcheck to cover more code

When specifying any -D argument all other defines
are ignored unless --force is specified as well.
I mistakenly assumed that this was covered by
--check-level=3Dexhaustive.

Change-Id: I05720ccc3bcf706bbe62254afb74562580f5de56
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M dev-tools/cppcheck-suppression
M dev-tools/run-cppcheck.sh
2 files changed, 10 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/1665/1

diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
index 1f31edb..1fefb51 100644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -22,23 +22,28 @@
 # IGN: the code header =3D 0 | (OPCODE << P_OPCODE_SHIFT) is used intentio=
nally
 badBitmaskCheck:src/openvpn/mudp.c
 badBitmaskCheck:tests/unit_tests/openvpn/test_pkt.c
+# IGN: we store integers in pointers
+CastAddressToIntegerAtReturn:src/openvpn/multi.c
 # IGN: event code uses a pointer to store integers
 intToPointerCast:src/openvpn/multi_io.c
 intToPointerCast:src/openvpn/forward.c
 # FP: crt_error is always true on Unix, but not Windows
 knownConditionTrueFalse:src/openvpn/error.h:380
 # FP: code needs to accomodate many different defines
+knownConditionTrueFalse:src/openvpn/event.c:1139
 knownConditionTrueFalse:src/openvpn/event.c:1148
+# FP: always true on Windows, but not Unix
+knownConditionTrueFalse:src/openvpn/fdmisc.c:80
 # FP: dco_win support has "false" stubs
 knownConditionTrueFalse:src/openvpn/forward.c
 knownConditionTrueFalse:src/openvpn/init.c
 knownConditionTrueFalse:src/openvpn/multi_io.c:163
-# FP: cppcheck thinks that management_query_user_pass is always true,
-# but no idea why
+# FP: cppcheck thinks that some functions always return true, but they don=
't
 knownConditionTrueFalse:src/openvpn/misc.c:97
+knownConditionTrueFalse:src/openvpn/sig.h:116
 # FP: cert_uri_supported is a wrapper around defines, so it's
 # always constant but differs depending on OpenSSL version
-knownConditionTrueFalse:src/openvpn/ssl_openssl.c:1258
+knownConditionTrueFalse:src/openvpn/ssl_openssl.c:1332
 # FP: cppcheck doesn't understand that the function changes szErrMessage
 knownConditionTrueFalse:src/tapctl/main.c:704
 knownConditionTrueFalse:src/openvpnmsica/dllmain.c:164
diff --git a/dev-tools/run-cppcheck.sh b/dev-tools/run-cppcheck.sh
index 674fc092..8fe9c97 100755
--- a/dev-tools/run-cppcheck.sh
+++ b/dev-tools/run-cppcheck.sh
@@ -13,7 +13,7 @@
 mkdir -p "$CPPCHECK_DIR"
 cd "${SOURCE_DIR}"
 cppcheck -j$(nproc) \
-	 -DHAVE_CONFIG_H -U_WIN32 \
+	 -DHAVE_CONFIG_H \
          -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \
 	 -I./include/ -I./tests/unit_tests/openvpn/ \
 	 -I./src/compat/ -I./src/openvpn/ -I./src/openvpnserv/ -I./src/plugins/au=
th-pam/ \
@@ -21,6 +21,6 @@
 	 --enable=3Dall \
 	 --suppressions-list=3D"${SCRIPT_DIR}/cppcheck-suppression" \
 	 --cppcheck-build-dir=3D"${CPPCHECK_DIR}" \
-	 --check-level=3Dexhaustive \
+	 --check-level=3Dexhaustive --force \
 	 --error-exitcode=3D1 \
 	 src/ tests/ sample/

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1665?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I05720ccc3bcf706bbe62254afb74562580f5de56
Gerrit-Change-Number: 1665
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--JdshRjScmS8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1665?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">dev-tools: Fix run-cppcheck to cover more c=
ode<br><br>When specifying any -D argument all other defines<br>are ignored=
 unless --force is specified as well.<br>I mistakenly assumed that this was=
 covered by<br>--check-level=3Dexhaustive.<br><br>Change-Id: I05720ccc3bcf7=
06bbe62254afb74562580f5de56<br>Signed-off-by: Frank Lichtenheld &lt;frank@...220...=
..2641...&gt;<br>---<br>M dev-tools/cppcheck-suppression<br>M dev-tools/run=
-cppcheck.sh<br>2 files changed, 10 insertions(+), 5 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/65/1665/1</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-suppression b/dev-too=
ls/cppcheck-suppression</span><br><span>index 1f31edb..1fefb51 100644</span=
><br><span>--- a/dev-tools/cppcheck-suppression</span><br><span>+++ b/dev-t=
ools/cppcheck-suppression</span><br><span>@@ -22,23 +22,28 @@</span><br><sp=
an> # IGN: the code header =3D 0 | (OPCODE &lt;&lt; P_OPCODE_SHIFT) is used=
 intentionally</span><br><span> badBitmaskCheck:src/openvpn/mudp.c</span><b=
r><span> badBitmaskCheck:tests/unit_tests/openvpn/test_pkt.c</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# IGN: we store integers in pointe=
rs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CastAddressToInte=
gerAtReturn:src/openvpn/multi.c</span><br><span> # IGN: event code uses a p=
ointer to store integers</span><br><span> intToPointerCast:src/openvpn/mult=
i_io.c</span><br><span> intToPointerCast:src/openvpn/forward.c</span><br><s=
pan> # FP: crt_error is always true on Unix, but not Windows</span><br><spa=
n> knownConditionTrueFalse:src/openvpn/error.h:380</span><br><span> # FP: c=
ode needs to accomodate many different defines</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+knownConditionTrueFalse:src/openvpn/event.c:1139=
</span><br><span> knownConditionTrueFalse:src/openvpn/event.c:1148</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# FP: always true on Windows=
, but not Unix</span><br><span style=3D"color: hsl(120, 100%, 40%);">+known=
ConditionTrueFalse:src/openvpn/fdmisc.c:80</span><br><span> # FP: dco_win s=
upport has &quot;false&quot; stubs</span><br><span> knownConditionTrueFalse=
:src/openvpn/forward.c</span><br><span> knownConditionTrueFalse:src/openvpn=
/init.c</span><br><span> knownConditionTrueFalse:src/openvpn/multi_io.c:163=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: cppcheck thinks=
 that management_query_user_pass is always true,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-# but no idea why</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# FP: cppcheck thinks that some functions always r=
eturn true, but they don&#39;t</span><br><span> knownConditionTrueFalse:src=
/openvpn/misc.c:97</span><br><span style=3D"color: hsl(120, 100%, 40%);">+k=
nownConditionTrueFalse:src/openvpn/sig.h:116</span><br><span> # FP: cert_ur=
i_supported is a wrapper around defines, so it&#39;s</span><br><span> # alw=
ays constant but differs depending on OpenSSL version</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/openvpn/ssl_ope=
nssl.c:1258</span><br><span style=3D"color: hsl(120, 100%, 40%);">+knownCon=
ditionTrueFalse:src/openvpn/ssl_openssl.c:1332</span><br><span> # FP: cppch=
eck doesn&#39;t understand that the function changes szErrMessage</span><br=
><span> knownConditionTrueFalse:src/tapctl/main.c:704</span><br><span> know=
nConditionTrueFalse:src/openvpnmsica/dllmain.c:164</span><br><span>diff --g=
it a/dev-tools/run-cppcheck.sh b/dev-tools/run-cppcheck.sh</span><br><span>=
index 674fc092..8fe9c97 100755</span><br><span>--- a/dev-tools/run-cppcheck=
.sh</span><br><span>+++ b/dev-tools/run-cppcheck.sh</span><br><span>@@ -13,=
7 +13,7 @@</span><br><span> mkdir -p &quot;$CPPCHECK_DIR&quot;</span><br><s=
pan> cd &quot;${SOURCE_DIR}&quot;</span><br><span> cppcheck -j$(nproc) \</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	 -DHAVE_CONFIG_H -U_WIN=
32 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	 -DHAVE_CONFIG=
_H \</span><br><span>          -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEY=
ING_MATERIAL_EXPORT \</span><br><span> 	 -I./include/ -I./tests/unit_tests/=
openvpn/ \</span><br><span> 	 -I./src/compat/ -I./src/openvpn/ -I./src/open=
vpnserv/ -I./src/plugins/auth-pam/ \</span><br><span>@@ -21,6 +21,6 @@</spa=
n><br><span> 	 --enable=3Dall \</span><br><span> 	 --suppressions-list=3D&q=
uot;${SCRIPT_DIR}/cppcheck-suppression&quot; \</span><br><span> 	 --cppchec=
k-build-dir=3D&quot;${CPPCHECK_DIR}&quot; \</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	 --check-level=3Dexhaustive \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	 --check-level=3Dexhaustive --force \</s=
pan><br><span> 	 --error-exitcode=3D1 \</span><br><span> 	 src/ tests/ samp=
le/</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1665?usp=3Demail">change 1665</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1665?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I05720ccc3bcf706bbe62254afb7=
4562580f5de56 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1665 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--JdshRjScmS8=--

