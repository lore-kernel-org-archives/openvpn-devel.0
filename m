From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 22 Sep 2025 15:42:47 +0000
References: <gerrit.1758555758000.Iab9e780d9649d7581e5f6aa4b23e72bbed5e145b@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <89696078e73580fc043ae1df3bf0131b0d77de99-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UsclHRBDDXQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make unit tests
 -Wconversion clean
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

--UsclHRBDDXQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1205?usp=3Demail

to review the following change.


Change subject: Make unit tests -Wconversion clean
......................................................................

Make unit tests -Wconversion clean

Only trivial problems left after the other patches
have been merged.

Change-Id: Iab9e780d9649d7581e5f6aa4b23e72bbed5e145b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M tests/unit_tests/openvpn/test_crypto.c
M tests/unit_tests/openvpn/test_ssl.c
2 files changed, 4 insertions(+), 22 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/05/1205/1

diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index 22e6912..93dfa42 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -674,15 +674,10 @@
     struct crypto_options co;
 };

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static int
 crypto_test_epoch_setup(void **state)
 {
-    int *num_future_keys =3D (int *)*state;
+    uint16_t *num_future_keys =3D (uint16_t *)*state;
     struct epoch_test_state *data =3D calloc(1, sizeof(struct epoch_test_s=
tate));

     data->gc =3D gc_new();
@@ -699,10 +694,6 @@
     return 0;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static int
 crypto_test_epoch_teardown(void **state)
 {
@@ -906,9 +897,9 @@
 int
 main(void)
 {
-    int prestate_num13 =3D 13;
-    int prestate_num16 =3D 16;
-    int prestate_num32 =3D 32;
+    uint16_t prestate_num13 =3D 13;
+    uint16_t prestate_num16 =3D 16;
+    uint16_t prestate_num32 =3D 32;

     openvpn_unit_test_setup();
     const struct CMUnitTest tests[] =3D {
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index ed40a7d..bb02fcc 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -133,11 +133,6 @@
     const char *keyfile;
 } global_state;

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static int
 init(void **state)
 {
@@ -159,10 +154,6 @@
     return 0;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static int
 cleanup(void **state)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1205?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iab9e780d9649d7581e5f6aa4b23e72bbed5e145b
Gerrit-Change-Number: 1205
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--UsclHRBDDXQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1205?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Make unit tests -Wconversion clean<br><br>Only trivial probl=
ems left after the other patches<br>have been merged.<br><br>Change-Id: Iab=
9e780d9649d7581e5f6aa4b23e72bbed5e145b<br>Signed-off-by: Frank Lichtenheld =
&lt;frank@...2641...&gt;<br>---<br>M tests/unit_tests/openvpn/test_crypto.c=
<br>M tests/unit_tests/openvpn/test_ssl.c<br>2 files changed, 4 insertions(=
+), 22 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/05/1205/1</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/tes=
t_crypto.c b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>index 2=
2e6912..93dfa42 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_=
crypto.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_crypto.c</span=
><br><span>@@ -674,15 +674,10 @@</span><br><span>     struct crypto_options=
 co;</span><br><span> };</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ign=
ored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> static int</span><br><span> crypto_test_epoch_setup(void **state=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   int *num_future_keys =3D (int *)*state;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    uint16_t *num_future_keys =3D (uint16_t *)*state=
;</span><br><span>     struct epoch_test_state *data =3D calloc(1, sizeof(s=
truct epoch_test_state));</span><br><span> </span><br><span>     data-&gt;g=
c =3D gc_new();</span><br><span>@@ -699,10 +694,6 @@</span><br><span>     r=
eturn 0;</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static int</span><br>=
<span> crypto_test_epoch_teardown(void **state)</span><br><span> {</span><b=
r><span>@@ -906,9 +897,9 @@</span><br><span> int</span><br><span> main(void=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   int prestate_num13 =3D 13;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    int prestate_num16 =3D 16;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    int prestate_num32 =3D 32;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    uint16_t prestate_num13 =3D 13;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t prestate_num16 =3D=
 16;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t pr=
estate_num32 =3D 32;</span><br><span> </span><br><span>     openvpn_unit_te=
st_setup();</span><br><span>     const struct CMUnitTest tests[] =3D {</spa=
n><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_t=
ests/openvpn/test_ssl.c</span><br><span>index ed40a7d..bb02fcc 100644</span=
><br><span>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_ssl.c</span><br><span>@@ -133,11 +133,6 @@</s=
pan><br><span>     const char *keyfile;</span><br><span> } global_state;</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static int</span=
><br><span> init(void **state)</span><br><span> {</span><br><span>@@ -159,1=
0 +154,6 @@</span><br><span>     return 0;</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> static int</span><br><span> cleanup(void **state)</span><br><s=
pan> {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1205?usp=3Demail">change 1205</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1205?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iab9e780d9649d7581e5f6aa4b23=
e72bbed5e145b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1205 </div>
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


--UsclHRBDDXQ=--

