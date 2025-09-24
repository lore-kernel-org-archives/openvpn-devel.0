From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 24 Sep 2025 13:16:33 +0000
In-Reply-To: <gerrit.1758555758000.Iab9e780d9649d7581e5f6aa4b23e72bbed5e145b@...2715...>
References: <gerrit.1758555758000.Iab9e780d9649d7581e5f6aa4b23e72bbed5e145b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <dff2433aa8c0ce196cbbcd30e028a6f43c0de1c7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KgILovAnH3g="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KgILovAnH3g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1205?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Make unit tests -Wconversion clean
......................................................................

Make unit tests -Wconversion clean

Only trivial problems left after the other patches
have been merged.

Change-Id: Iab9e780d9649d7581e5f6aa4b23e72bbed5e145b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1205
Message-Id: <20250924124154.15963-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59238128/
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_crypto.c
M tests/unit_tests/openvpn/test_ssl.c
2 files changed, 9 insertions(+), 24 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/05/1205/6

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
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--KgILovAnH3g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #6</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1205?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Make unit tests -Wconversion clean<br><br>Only trivi=
al problems left after the other patches<br>have been merged.<br><br>Change=
-Id: Iab9e780d9649d7581e5f6aa4b23e72bbed5e145b<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1205<br>Messa=
ge-Id: &lt;20250924124154.15963-1-gert@...1296...&gt;<br>URL: https://sourc=
eforge.net/p/openvpn/mailman/message/59238128/<br>Signed-off-by: Gert Doeri=
ng &lt;gert@...1296...&gt;<br>---<br>M tests/unit_tests/openvpn/test_crypto=
.c<br>M tests/unit_tests/openvpn/test_ssl.c<br>2 files changed, 9 insertion=
s(+), 24 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/ope=
nvpn refs/changes/05/1205/6</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/t=
est_crypto.c b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>index=
 22e6912..93dfa42 100644</span><br><span>--- a/tests/unit_tests/openvpn/tes=
t_crypto.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_crypto.c</sp=
an><br><span>@@ -674,15 +674,10 @@</span><br><span>     struct crypto_optio=
ns co;</span><br><span> };</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic i=
gnored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> static int</span><br><span> crypto_test_epoch_setup(void **sta=
te)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    int *num_future_keys =3D (int *)*state;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    uint16_t *num_future_keys =3D (uint16_t *)*sta=
te;</span><br><span>     struct epoch_test_state *data =3D calloc(1, sizeof=
(struct epoch_test_state));</span><br><span> </span><br><span>     data-&gt=
;gc =3D gc_new();</span><br><span>@@ -699,10 +694,6 @@</span><br><span>    =
 return 0;</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static int</span><b=
r><span> crypto_test_epoch_teardown(void **state)</span><br><span> {</span>=
<br><span>@@ -906,9 +897,9 @@</span><br><span> int</span><br><span> main(vo=
id)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    int prestate_num13 =3D 13;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    int prestate_num16 =3D 16;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    int prestate_num32 =3D 32;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    uint16_t prestate_num13 =3D 13;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t prestate_num16 =
=3D 16;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t=
 prestate_num32 =3D 32;</span><br><span> </span><br><span>     openvpn_unit=
_test_setup();</span><br><span>     const struct CMUnitTest tests[] =3D {</=
span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/uni=
t_tests/openvpn/test_ssl.c</span><br><span>index ed40a7d..8dc9b66 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br><span>+++=
 b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>@@ -133,11 +133,6 @@=
</span><br><span>     const char *keyfile;</span><br><span> } global_state;=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static int</s=
pan><br><span> init(void **state)</span><br><span> {</span><br><span>@@ -15=
2,17 +147,16 @@</span><br><span>     {</span><br><span>         fail_msg(&q=
uot;make tmpfile for certificate or key data failed (error =3D %d)&quot;, e=
rrno);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    assert_int_equal(write(certfd, unittest_cert, strlen(unittest_c=
ert)), strlen(unittest_cert));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    assert_int_equal(write(keyfd, unittest_key, strlen(unittest_ke=
y)), strlen(unittest_key));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* Awkward casts required for MinGW with -O0 only */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(write(cer=
tfd, unittest_cert, (unsigned int)strlen(unittest_cert)),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                     strlen(unittest_=
cert));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(write(keyfd, unittest_key, (unsigned int)strlen(unittest_key)),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                     s=
trlen(unittest_key));</span><br><span>     close(certfd);</span><br><span> =
    close(keyfd);</span><br><span>     return 0;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined=
(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> static int</span><br><span> cleanup(void **state)</span>=
<br><span> {</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1205?usp=3Demail">change 1205</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:=
//schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1205?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iab9e780d9649d7581e5f6aa4b23=
e72bbed5e145b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1205 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--KgILovAnH3g=--

