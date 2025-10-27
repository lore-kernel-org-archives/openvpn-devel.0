From: "mrbff (Code Review)" <gerrit@...515...>
Date: Mon, 27 Oct 2025 16:06:42 +0000
References: <gerrit.1761581200000.Idba419681fe3ccc4e6e2f6ce7592332dcff62cd9@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f847fec5229d2e441bc5b65656a634d0d4876edc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YHBTXOYziIE="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: PUSH_UPDATE server:
 added new unit tests and improved documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YHBTXOYziIE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1316?usp=3Demail

to review the following change.


Change subject: PUSH_UPDATE server: added new unit tests and improved docum=
entation
......................................................................

PUSH_UPDATE server: added new unit tests and improved documentation

Change-Id: Idba419681fe3ccc4e6e2f6ce7592332dcff62cd9
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/push_util.c
M tests/unit_tests/openvpn/test_push_update_msg.c
2 files changed, 76 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/16/1316/1

diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 552679a..d23b96d 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -270,6 +270,9 @@
      * we want to send exceeds that size we have to split it into smaller =
messages */
     ASSERT(push_bundle_size > extra);
     const size_t safe_cap =3D push_bundle_size - extra;
+    /* the number of messages will be the total message length (just the i=
nner message, the options,
+     * excluding `PUSH_UPDATE,` string and possible `,push-continuation n`=
 string) divided by safe_cap,
+     * plus 1 if there is a remainder */
     size_t msgs_num =3D (strlen(msg) / safe_cap) + ((strlen(msg) % safe_ca=
p) !=3D 0);
     struct buffer *msgs =3D gc_malloc((msgs_num + 1) * sizeof(struct buffe=
r), true, &gc);

diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_t=
ests/openvpn/test_push_update_msg.c
index 516e94c..83c27bb 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -136,10 +136,19 @@
 bool
 send_control_channel_string(struct context *c, const char *str, msglvl_t m=
sglevel)
 {
-    if (res && res[i] && strcmp(res[i], str))
+    if (res && res[i])
     {
-        printf("\n\nexpected: %s\n\n  actual: %s\n\n", res[i], str);
-        return false;
+        size_t res_len =3D strlen(res[i]);
+        size_t str_len =3D strlen(str);
+        if (res_len !=3D str_len || strcmp(res[i], str))
+        {
+            if (res_len !=3D str_len)
+            {
+                printf("\n\nexpected_size: %lu\n  actual_size: %lu", res_l=
en, str_len);
+            }
+            printf("\n\nexpected: %s\n\n  actual: %s\n\n", res[i], str);
+            return false;
+        }
     }
     i++;
     return true;
@@ -339,6 +348,23 @@
     "PUSH_UPDATE,,"
 };

+char *r11[] =3D {
+    "PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-continuation 2",
+    "PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-continuation 2",
+    "PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-continuation 2",
+    "PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-continuation 2",
+    "PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-cont=
inuation 1"
+};
+
+char *r12[] =3D {
+    "PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,,,,,,a,push-continuation 2",
+    "PUSH_UPDATE,abc,push-continuation 1"
+};
+
+char *r13[] =3D {
+    "PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,,,,,,a,"
+};
+

 const char *msg0 =3D "redirect-gateway local,route 192.168.1.0 255.255.255=
.0";
 const char *msg1 =3D "-dhcp-option,blablalalalalalalalalalalalalf, lalalal=
alalalalalalalalalalaf,"
@@ -365,6 +391,16 @@
                     "daisy damage damp dance danger daring dash daughter d=
awn day deal debate debris decade december decide decline"
                     "decorate decrease deer defense define defy degree del=
ay deliver demand demise denial";

+const char *msg11 =3D "a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,"
+                    "a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,"
+                    "a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,"
+                    "a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,"
+                    "a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a";
+
+const char *msg12 =3D "a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,,,,,,a,abc";
+
+const char *msg13 =3D "a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,,,,,,a,";
+
 #define PUSH_BUNDLE_SIZE_TEST 184

 static void
@@ -476,6 +512,36 @@
     assert_int_equal(send_push_update(m, &cid, msg10, UPT_BY_CID, PUSH_BUN=
DLE_SIZE_TEST), -EINVAL);
 }

+static void
+test_send_push_msg11(void **state)
+{
+    i =3D 0;
+    res =3D r11;
+    struct multi_context *m =3D *state;
+    const unsigned long cid =3D 0;
+    assert_int_equal(send_push_update(m, &cid, msg11, UPT_BY_CID, PUSH_BUN=
DLE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg12(void **state)
+{
+    i =3D 0;
+    res =3D r12;
+    struct multi_context *m =3D *state;
+    const unsigned long cid =3D 0;
+    assert_int_equal(send_push_update(m, &cid, msg12, UPT_BY_CID, PUSH_BUN=
DLE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg13(void **state)
+{
+    i =3D 0;
+    res =3D r13;
+    struct multi_context *m =3D *state;
+    const unsigned long cid =3D 0;
+    assert_int_equal(send_push_update(m, &cid, msg13, UPT_BY_CID, PUSH_BUN=
DLE_SIZE_TEST), 1);
+}
+
 #undef PUSH_BUNDLE_SIZE_TEST

 static int
@@ -545,7 +611,10 @@
         cmocka_unit_test_setup_teardown(test_send_push_msg7, setup2, teard=
own2),
         cmocka_unit_test_setup_teardown(test_send_push_msg8, setup2, teard=
own2),
         cmocka_unit_test_setup_teardown(test_send_push_msg9, setup2, teard=
own2),
-        cmocka_unit_test_setup_teardown(test_send_push_msg10, setup2, tear=
down2)
+        cmocka_unit_test_setup_teardown(test_send_push_msg10, setup2, tear=
down2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg11, setup2, tear=
down2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg12, setup2, tear=
down2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg13, setup2, tear=
down2)
 #endif
     };


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1316?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idba419681fe3ccc4e6e2f6ce7592332dcff62cd9
Gerrit-Change-Number: 1316
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--YHBTXOYziIE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>mrbff would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1316?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">PUSH_UPDATE server: added new unit tests an=
d improved documentation<br><br>Change-Id: Idba419681fe3ccc4e6e2f6ce7592332=
dcff62cd9<br>Signed-off-by: Marco Baffo &lt;marco@...2726...&gt;<br>---<br>=
M src/openvpn/push_util.c<br>M tests/unit_tests/openvpn/test_push_update_ms=
g.c<br>2 files changed, 76 insertions(+), 4 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/16/13=
16/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c=
</span><br><span>index 552679a..d23b96d 100644</span><br><span>--- a/src/op=
envpn/push_util.c</span><br><span>+++ b/src/openvpn/push_util.c</span><br><=
span>@@ -270,6 +270,9 @@</span><br><span>      * we want to send exceeds th=
at size we have to split it into smaller messages */</span><br><span>     A=
SSERT(push_bundle_size &gt; extra);</span><br><span>     const size_t safe_=
cap =3D push_bundle_size - extra;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /* the number of messages will be the total message lengt=
h (just the inner message, the options,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * excluding `PUSH_UPDATE,` string and possible `,p=
ush-continuation n` string) divided by safe_cap,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * plus 1 if there is a remainder */</span=
><br><span>     size_t msgs_num =3D (strlen(msg) / safe_cap) + ((strlen(msg=
) % safe_cap) !=3D 0);</span><br><span>     struct buffer *msgs =3D gc_mall=
oc((msgs_num + 1) * sizeof(struct buffer), true, &amp;gc);</span><br><span>=
 </span><br><span>diff --git a/tests/unit_tests/openvpn/test_push_update_ms=
g.c b/tests/unit_tests/openvpn/test_push_update_msg.c</span><br><span>index=
 516e94c..83c27bb 100644</span><br><span>--- a/tests/unit_tests/openvpn/tes=
t_push_update_msg.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_pus=
h_update_msg.c</span><br><span>@@ -136,10 +136,19 @@</span><br><span> bool<=
/span><br><span> send_control_channel_string(struct context *c, const char =
*str, msglvl_t msglevel)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (res &amp;&amp; res[i] &amp;&amp; strcmp(res[i=
], str))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (res=
 &amp;&amp; res[i])</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        printf(&quot;\n\nexpected: %s\n\n  actual: %s\=
n\n&quot;, res[i], str);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        size_t res_len =3D strlen(res[i]);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        size_t str_len =3D strlen(str);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (res_len !=3D st=
r_len || strcmp(res[i], str))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            if (res_len !=3D str_len)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                printf(&quot;\n\nexpected_size: %lu\n  actual_s=
ize: %lu&quot;, res_len, str_len);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            printf(&quot;\n\nexpected: %s\n\n  actual: %s\n\n&quot=
;, res[i], str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span>     }</span><br><span>     i++;</span><br><sp=
an>     return true;</span><br><span>@@ -339,6 +348,23 @@</span><br><span> =
    &quot;PUSH_UPDATE,,&quot;</span><br><span> };</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+char *r11[] =3D {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,=
a,a,a,push-continuation 2&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &quot;PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,=
a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-continuation 2&quot;,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDAT=
E,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,push-continuation 2&quot;,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-continuation =
2&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;P=
USH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,push-continuatio=
n 1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+char *r12[] =3D {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &quot;PUSH_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,=
a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,,,,,,a,push-continuat=
ion 2&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &qu=
ot;PUSH_UPDATE,abc,push-continuation 1&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char *r13[]=
 =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PUS=
H_UPDATE,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,=
a,a,a,a,a,a,a,,,,,,a,&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> </span><br><span> const char *msg0 =3D &quot;redirect-gateway loca=
l,route 192.168.1.0 255.255.255.0&quot;;</span><br><span> const char *msg1 =
=3D &quot;-dhcp-option,blablalalalalalalalalalalalalf, lalalalalalalalalala=
lalalalaf,&quot;</span><br><span>@@ -365,6 +391,16 @@</span><br><span>     =
                &quot;daisy damage damp dance danger daring dash daughter d=
awn day deal debate debris decade december decide decline&quot;</span><br><=
span>                     &quot;decorate decrease deer defense define defy =
degree delay deliver demand demise denial&quot;;</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+const char *msg11 =3D &quot;=
a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            &quot;a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    &quot;a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    &quot;a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;a,a=
,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,=
a&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+const char *msg12 =3D &quot;a,=
a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,,,,,,a,abc&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *msg13 =
=3D &quot;a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a=
,a,a,a,a,a,a,a,,,,,,a,&quot;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> #define PUSH_BUNDLE_SIZE_TEST 184</span><br><sp=
an> </span><br><span> static void</span><br><span>@@ -476,6 +512,36 @@</spa=
n><br><span>     assert_int_equal(send_push_update(m, &amp;cid, msg10, UPT_=
BY_CID, PUSH_BUNDLE_SIZE_TEST), -EINVAL);</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+test_send_push_msg11(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    i =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    res =3D r11;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct multi_context *m =3D *stat=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const unsigne=
d long cid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(send_push_update(m, &amp;cid, msg11, UPT_BY_CID, PUSH_BU=
NDLE_SIZE_TEST), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+test_send_push_msg12(void **state)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    i =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    res =3D r12;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct multi_context *m =3D *state;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const unsigned long cid =3D 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(s=
end_push_update(m, &amp;cid, msg12, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+test_send_push_msg13(void **state)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    res =3D r13;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct multi_context *m =3D *state;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const unsigned long cid =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(send_push_update(m, =
&amp;cid, msg13, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> #undef PUSH_BUNDLE_SIZE_TEST</span><br=
><span> </span><br><span> static int</span><br><span>@@ -545,7 +611,10 @@</=
span><br><span>         cmocka_unit_test_setup_teardown(test_send_push_msg7=
, setup2, teardown2),</span><br><span>         cmocka_unit_test_setup_teard=
own(test_send_push_msg8, setup2, teardown2),</span><br><span>         cmock=
a_unit_test_setup_teardown(test_send_push_msg9, setup2, teardown2),</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_test_setu=
p_teardown(test_send_push_msg10, setup2, teardown2)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_teardown(t=
est_send_push_msg10, setup2, teardown2),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        cmocka_unit_test_setup_teardown(test_send_push=
_msg11, setup2, teardown2),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cmocka_unit_test_setup_teardown(test_send_push_msg12, setup=
2, teardown2),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   cmocka_unit_test_setup_teardown(test_send_push_msg13, setup2, teardown2)=
</span><br><span> #endif</span><br><span>     };</span><br><span> </span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1316?usp=3Demail">change 1316</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1316?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idba419681fe3ccc4e6e2f6ce759=
2332dcff62cd9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1316 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--YHBTXOYziIE=--

