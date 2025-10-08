From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 8 Oct 2025 12:58:20 +0000
References: <gerrit.1759928297000.I59a49696acd665d43b21e5c23f24b86c15989cd6@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <22c1b75eabc1c6dbd1a94427a50c11ab17bd6d0e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M1opaeYDlxY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: test_options_parse:
 Do not use uintmax_t instead of LargestIntegralType
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

--M1opaeYDlxY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1256?usp=3Demail

to review the following change.


Change subject: test_options_parse: Do not use uintmax_t instead of Largest=
IntegralType
......................................................................

test_options_parse: Do not use uintmax_t instead of LargestIntegralType

At least on OpenBSD it seems that uintmax_t maps
to unsigned long long always, but LargestIntegralType
is unsigned long. So if we have a version of cmocka.h
that defines LargestIntegralType then respect that.

Change-Id: I59a49696acd665d43b21e5c23f24b86c15989cd6
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M tests/unit_tests/openvpn/test_options_parse.c
1 file changed, 13 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/56/1256/1

diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_tes=
ts/openvpn/test_options_parse.c
index e552dd7..0ae37f5 100644
--- a/tests/unit_tests/openvpn/test_options_parse.c
+++ b/tests/unit_tests/openvpn/test_options_parse.c
@@ -198,14 +198,25 @@
                        &option_types_found, &es);
 }

+/* compat with various versions of cmocka.h
+ * Older versions have LargestIntegralType. Newer
+ * versions use uintmax_t. But LargestIntegralType
+ * is not guaranteed to be equal to uintmax_t, so
+ * we can't use that unconditionally. So we only use
+ * it if cmocka.h does not define LargestIntegralType.
+ */
+#ifndef LargestIntegralType
+#define LargestIntegralType uintmax_t
+#endif
+
 union tokens_parameter
 {
-    uintmax_t as_int;
+    LargestIntegralType as_int;
     void *as_pointer;
 };

 static int
-check_tokens(const uintmax_t value, const uintmax_t expected)
+check_tokens(const LargestIntegralType value, const LargestIntegralType ex=
pected)
 {
     union tokens_parameter temp;
     temp.as_int =3D value;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1256?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I59a49696acd665d43b21e5c23f24b86c15989cd6
Gerrit-Change-Number: 1256
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--M1opaeYDlxY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1256?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">test_options_parse: Do not use uintmax_t in=
stead of LargestIntegralType<br><br>At least on OpenBSD it seems that uintm=
ax_t maps<br>to unsigned long long always, but LargestIntegralType<br>is un=
signed long. So if we have a version of cmocka.h<br>that defines LargestInt=
egralType then respect that.<br><br>Change-Id: I59a49696acd665d43b21e5c23f2=
4b86c15989cd6<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<=
br>---<br>M tests/unit_tests/openvpn/test_options_parse.c<br>1 file changed=
, 13 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/56/1256/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_tests/open=
vpn/test_options_parse.c</span><br><span>index e552dd7..0ae37f5 100644</spa=
n><br><span>--- a/tests/unit_tests/openvpn/test_options_parse.c</span><br><=
span>+++ b/tests/unit_tests/openvpn/test_options_parse.c</span><br><span>@@=
 -198,14 +198,25 @@</span><br><span>                        &amp;option_typ=
es_found, &amp;es);</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* compat with various versions of cmo=
cka.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Older versi=
ons have LargestIntegralType. Newer</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * versions use uintmax_t. But LargestIntegralType</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * is not guaranteed to be e=
qual to uintmax_t, so</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * we can&#39;t use that unconditionally. So we only use</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * it if cmocka.h does not define La=
rgestIntegralType.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef LargestIn=
tegralType</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define L=
argestIntegralType uintmax_t</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> union tokens_parameter</span><br><span> {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    uintmax_t as_int;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    LargestIntegralType as_int;</span><=
br><span>     void *as_pointer;</span><br><span> };</span><br><span> </span=
><br><span> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-check_tokens(const uintmax_t value, const uintmax_t expected)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+check_tokens(const LargestIntegr=
alType value, const LargestIntegralType expected)</span><br><span> {</span>=
<br><span>     union tokens_parameter temp;</span><br><span>     temp.as_in=
t =3D value;</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1256?usp=3Demail">change 1256</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemt=
ype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" i=
temtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1256?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I59a49696acd665d43b21e5c23f2=
4b86c15989cd6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1256 </div>
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

--M1opaeYDlxY=--

