From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 23 Sep 2025 12:02:39 +0000
In-Reply-To: <gerrit.1758555758000.Iab9e780d9649d7581e5f6aa4b23e72bbed5e145b@...2715...>
References: <gerrit.1758555758000.Iab9e780d9649d7581e5f6aa4b23e72bbed5e145b@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9060816f83f698107cf563693ecf1e2963bcbd6b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Hce2SKqjgDc="; charset=UTF-8
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

--Hce2SKqjgDc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1205?usp=3Demail

to look at the new patch set (#2).


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
2 files changed, 9 insertions(+), 24 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/05/1205/2

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
index ed40a7d..8dc9b66 100644
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
@@ -152,17 +147,16 @@
     {
         fail_msg("make tmpfile for certificate or key data failed (error =
=3D %d)", errno);
     }
-    assert_int_equal(write(certfd, unittest_cert, strlen(unittest_cert)), =
strlen(unittest_cert));
-    assert_int_equal(write(keyfd, unittest_key, strlen(unittest_key)), str=
len(unittest_key));
+    /* Awkward casts required for MinGW with -O0 only */
+    assert_int_equal(write(certfd, unittest_cert, (unsigned int)strlen(uni=
ttest_cert)),
+                     strlen(unittest_cert));
+    assert_int_equal(write(keyfd, unittest_key, (unsigned int)strlen(unitt=
est_key)),
+                     strlen(unittest_key));
     close(certfd);
     close(keyfd);
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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--Hce2SKqjgDc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1205?usp=3Demail">View C=
hange</a></p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Make unit tests -Wconversion clean<br><br>Only trivial problems l=
eft after the other patches<br>have been merged.<br><br>Change-Id: Iab9e780=
d9649d7581e5f6aa4b23e72bbed5e145b<br>Signed-off-by: Frank Lichtenheld &lt;f=
rank@...2641...&gt;<br>---<br>M tests/unit_tests/openvpn/test_crypto.c<br>M=
 tests/unit_tests/openvpn/test_ssl.c<br>2 files changed, 9 insertions(+), 2=
4 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn re=
fs/changes/05/1205/2</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/test_cry=
pto.c b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>index 22e691=
2..93dfa42 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_crypt=
o.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_crypto.c</span><br>=
<span>@@ -674,15 +674,10 @@</span><br><span>     struct crypto_options co;<=
/span><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored =
&quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> static int</span><br><span> crypto_test_epoch_setup(void **state)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
t *num_future_keys =3D (int *)*state;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    uint16_t *num_future_keys =3D (uint16_t *)*state;</sp=
an><br><span>     struct epoch_test_state *data =3D calloc(1, sizeof(struct=
 epoch_test_state));</span><br><span> </span><br><span>     data-&gt;gc =3D=
 gc_new();</span><br><span>@@ -699,10 +694,6 @@</span><br><span>     return=
 0;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static int</span><br><spa=
n> crypto_test_epoch_teardown(void **state)</span><br><span> {</span><br><s=
pan>@@ -906,9 +897,9 @@</span><br><span> int</span><br><span> main(void)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
nt prestate_num13 =3D 13;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int prestate_num16 =3D 16;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    int prestate_num32 =3D 32;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    uint16_t prestate_num13 =3D 13;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    uint16_t prestate_num16 =3D 16;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t presta=
te_num32 =3D 32;</span><br><span> </span><br><span>     openvpn_unit_test_s=
etup();</span><br><span>     const struct CMUnitTest tests[] =3D {</span><b=
r><span>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests=
/openvpn/test_ssl.c</span><br><span>index ed40a7d..8dc9b66 100644</span><br=
><span>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br><span>+++ b/test=
s/unit_tests/openvpn/test_ssl.c</span><br><span>@@ -133,11 +133,6 @@</span>=
<br><span>     const char *keyfile;</span><br><span> } global_state;</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if define=
d(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static int</span><br=
><span> init(void **state)</span><br><span> {</span><br><span>@@ -152,17 +1=
47,16 @@</span><br><span>     {</span><br><span>         fail_msg(&quot;mak=
e tmpfile for certificate or key data failed (error =3D %d)&quot;, errno);<=
/span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    assert_int_equal(write(certfd, unittest_cert, strlen(unittest_cert)), =
strlen(unittest_cert));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    assert_int_equal(write(keyfd, unittest_key, strlen(unittest_key)), st=
rlen(unittest_key));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* Awkward casts required for MinGW with -O0 only */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(write(certfd, un=
ittest_cert, (unsigned int)strlen(unittest_cert)),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                     strlen(unittest_cert));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(write(keyfd, unittest_key, (unsigned int)strlen(unittest_key)),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                     strlen(u=
nittest_key));</span><br><span>     close(certfd);</span><br><span>     clo=
se(keyfd);</span><br><span>     return 0;</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> static int</span><br><span> cleanup(void **state)</span><br><sp=
an> {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1205?usp=3Demail">change 1205</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1205?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iab9e780d9649d7581e5f6aa4b23=
e72bbed5e145b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1205 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Hce2SKqjgDc=--

