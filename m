From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 8 Oct 2025 13:40:55 +0000
In-Reply-To: <gerrit.1759928297000.I59a49696acd665d43b21e5c23f24b86c15989cd6@...2715...>
References: <gerrit.1759928297000.I59a49696acd665d43b21e5c23f24b86c15989cd6@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <18988882db6eda0b73057e8c981b9c2e87322870-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iBdRHoS/a/0="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--iBdRHoS/a/0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
56?usp=3Demail )

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
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1256
Message-Id: <20251008133338.23652-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59243971/
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_options_parse.c
1 file changed, 13 insertions(+), 2 deletions(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I59a49696acd665d43b21e5c23f24b86c15989cd6
Gerrit-Change-Number: 1256
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--iBdRHoS/a/0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1256?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">test_options_parse: Do not use uintmax_t instead=
 of LargestIntegralType<br><br>At least on OpenBSD it seems that uintmax_t =
maps<br>to unsigned long long always, but LargestIntegralType<br>is unsigne=
d long. So if we have a version of cmocka.h<br>that defines LargestIntegral=
Type then respect that.<br><br>Change-Id: I59a49696acd665d43b21e5c23f24b86c=
15989cd6<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Ac=
ked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.=
openvpn.net/c/openvpn/+/1256<br>Message-Id: &lt;20251008133338.23652-1-gert=
@...1296...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/message/5=
9243971/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M=
 tests/unit_tests/openvpn/test_options_parse.c<br>1 file changed, 13 insert=
ions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_=
tests/openvpn/test_options_parse.c</span><br><span>index e552dd7..0ae37f5 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/test_options_parse.c</=
span><br><span>+++ b/tests/unit_tests/openvpn/test_options_parse.c</span><b=
r><span>@@ -198,14 +198,25 @@</span><br><span>                        &amp;=
option_types_found, &amp;es);</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* compat with various versi=
ons of cmocka.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * O=
lder versions have LargestIntegralType. Newer</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * versions use uintmax_t. But LargestIntegralTyp=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is not guarante=
ed to be equal to uintmax_t, so</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * we can&#39;t use that unconditionally. So we only use</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * it if cmocka.h does not=
 define LargestIntegralType.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef=
 LargestIntegralType</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define LargestIntegralType uintmax_t</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> union tokens_parameter</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    uintmax_t as_int;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    LargestIntegralType as_in=
t;</span><br><span>     void *as_pointer;</span><br><span> };</span><br><sp=
an> </span><br><span> static int</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-check_tokens(const uintmax_t value, const uintmax_t expected)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+check_tokens(const Lar=
gestIntegralType value, const LargestIntegralType expected)</span><br><span=
> {</span><br><span>     union tokens_parameter temp;</span><br><span>     =
temp.as_int =3D value;</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1256?usp=3Demail">change 12=
56</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1256?usp=3Demail"/><meta itemp=
rop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I59a49696acd665d43b21e5c23f2=
4b86c15989cd6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1256 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--iBdRHoS/a/0=--

