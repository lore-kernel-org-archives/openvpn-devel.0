From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sun, 1 Dec 2024 13:53:49 +0000
In-Reply-To: <gerrit.1732292955000.I7cdf992eb6031315c4978c6a1fbbecfa723fca91@...2715...>
References: <gerrit.1732292955000.I7cdf992eb6031315c4978c6a1fbbecfa723fca91@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <7fcdee23f988f33804ff6a64e13c525ce636494a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5MEVxQV7rK4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: [TEST-ONLY] Mess
 with internal logic to test epoch data
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5MEVxQV7rK4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/818?usp=3Demail

to look at the new patch set (#3).


Change subject: [TEST-ONLY] Mess with internal logic to test epoch data
......................................................................

[TEST-ONLY] Mess with internal logic to test epoch data

This rotates/invalidates keys extremely quickly and also jumps forward
1-8 keys instead of always one to test that part of the logic.

Change-Id: I7cdf992eb6031315c4978c6a1fbbecfa723fca91
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/crypto.c
M src/openvpn/crypto_epoch.c
M tests/unit_tests/openvpn/test_crypto.c
M tests/unit_tests/openvpn/test_ssl.c
4 files changed, 21 insertions(+), 17 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/818/3

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 9e9fa00..3321d64 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -352,6 +352,9 @@
 int64_t
 cipher_get_aead_limits(const char *ciphername)
 {
+    /* TESTING: Make AEAD key limits really really really small to force
+     * key rollever super quickly */
+    return 256;
     if (!cipher_kt_mode_aead(ciphername))
     {
         return 0;
diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c
index d69f4d5..fc687b5 100644
--- a/src/openvpn/crypto_epoch.c
+++ b/src/openvpn/crypto_epoch.c
@@ -414,8 +414,13 @@
         if (aead_usage_limit_reached(opt->aead_usage_limit, &opt->key_ctx_=
bi.encrypt,
                                      opt->packet_id.send.id))
         {
-            /* Send key limit reached */
-            epoch_iterate_send_key(opt);
+            int forward =3D rand() % 8 + 1;
+            /* Send key limit reached, go one key forward or in this TEST
+             * gremlin mode, 1 to 8 to test the other side future key stuf=
f */
+            for (int i =3D 0; i < forward; i++)
+            {
+                epoch_iterate_send_key(opt);
+            }
         }
         /* draft 8 of the aead usage limit still had but draft 9 complete
          * dropped this statement:
@@ -437,7 +442,13 @@
             /* Receive key limit reached. Increase our own send key to sig=
nal
              * that we want to use a new epoch. Peer should then also move=
 its
              * key but is not required to do this */
-            epoch_iterate_send_key(opt);
+            int forward =3D rand() % 8 + 1;
+            /* gremlin mode, 1 to 8 to test the other side future key stuf=
f */
+            for (int i =3D 0; i < forward; i++)
+            {
+                epoch_iterate_send_key(opt);
+            }
+
         }
     }

diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index 82ca86e..07008c2 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -458,24 +458,14 @@
 void
 crypto_test_aead_limits(void **state)
 {
+#define BROKEN_LIMIT 0x100
     /* if ChaCha20-Poly1305 is not supported by the crypto library or in t=
he
      * current mode (FIPS), this will still return -1 */
-    assert_int_equal(cipher_get_aead_limits("CHACHA20-POLY1305"), 0);
+    assert_int_equal(cipher_get_aead_limits("CHACHA20-POLY1305"), BROKEN_L=
IMIT);

     int64_t aeslimit =3D cipher_get_aead_limits("AES-128-GCM");

-    assert_int_equal(aeslimit, (1ull << 36) - 1);
-
-    /* Check if this matches our exception for 1600 size packets assuming
-     * AEAD_LIMIT_BLOCKSIZE (128 bits/ 16 bytes). Gives us 100 blocks
-     * + 1 for the packet */
-    int64_t L =3D 101;
-    /* 2 ^ 29.34, using the result here to avoid linking to libm */
-    assert_int_equal(aeslimit / L, 680390858);
-
-    /* and for 9000, 2^26.86 */
-    L =3D 563;
-    assert_int_equal(aeslimit / L, 122059461);
+    assert_int_equal(aeslimit, BROKEN_LIMIT);
 }

 void
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index 842c944..0d4d8be 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -398,7 +398,7 @@
         struct epoch_key e1 =3D { .epoch =3D 1, .epoch_key =3D { 0 }};
         memcpy(e1.epoch_key, key2.keys[0].cipher, sizeof(e1.epoch_key));
         co.flags |=3D CO_EPOCH_DATA_KEY_FORMAT;
-        epoch_init_key_ctx(&co, &kt, &e1, &e1, 5);
+        epoch_init_key_ctx(&co, &kt, &e1, &e1, 9);

         /* Do a little of dancing for the epoch_send_key_iterate to test
          * that this works too */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/818?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7cdf992eb6031315c4978c6a1fbbecfa723fca91
Gerrit-Change-Number: 818
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--5MEVxQV7rK4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/818?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">[TEST-ONLY] Mess with internal logic to test epoch data<br><br>This r=
otates/invalidates keys extremely quickly and also jumps forward<br>1-8 key=
s instead of always one to test that part of the logic.<br><br>Change-Id: I=
7cdf992eb6031315c4978c6a1fbbecfa723fca91<br>Signed-off-by: Arne Schwabe &lt=
;arne@...1227...&gt;<br>---<br>M src/openvpn/crypto.c<br>M src/openvpn/cryp=
to_epoch.c<br>M tests/unit_tests/openvpn/test_crypto.c<br>M tests/unit_test=
s/openvpn/test_ssl.c<br>4 files changed, 21 insertions(+), 17 deletions(-)<=
br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/8=
18/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span=
><br><span>index 9e9fa00..3321d64 100644</span><br><span>--- a/src/openvpn/=
crypto.c</span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -352=
,6 +352,9 @@</span><br><span> int64_t</span><br><span> cipher_get_aead_limi=
ts(const char *ciphername)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* TESTING: Make AEAD key limits really reall=
y really small to force</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * key rollever super quickly */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return 256;</span><br><span>     if (!cipher_kt_mo=
de_aead(ciphername))</span><br><span>     {</span><br><span>         return=
 0;</span><br><span>diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/c=
rypto_epoch.c</span><br><span>index d69f4d5..fc687b5 100644</span><br><span=
>--- a/src/openvpn/crypto_epoch.c</span><br><span>+++ b/src/openvpn/crypto_=
epoch.c</span><br><span>@@ -414,8 +414,13 @@</span><br><span>         if (a=
ead_usage_limit_reached(opt-&gt;aead_usage_limit, &amp;opt-&gt;key_ctx_bi.e=
ncrypt,</span><br><span>                                      opt-&gt;packe=
t_id.send.id))</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            /* Send key limit reached */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            epoch_iterate_send_key(o=
pt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            int=
 forward =3D rand() % 8 + 1;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            /* Send key limit reached, go one key forward or in th=
is TEST</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
 * gremlin mode, 1 to 8 to test the other side future key stuff */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            for (int i =3D 0=
; i &lt; forward; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             epoch_iterate_send_key(opt);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span>         }</span><br><s=
pan>         /* draft 8 of the aead usage limit still had but draft 9 compl=
ete</span><br><span>          * dropped this statement:</span><br><span>@@ =
-437,7 +442,13 @@</span><br><span>             /* Receive key limit reached=
. Increase our own send key to signal</span><br><span>              * that =
we want to use a new epoch. Peer should then also move its</span><br><span>=
              * key but is not required to do this */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            epoch_iterate_send_key(opt);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            int forwar=
d =3D rand() % 8 + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            /* gremlin mode, 1 to 8 to test the other side future key stu=
ff */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fo=
r (int i =3D 0; i &lt; forward; i++)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                epoch_iterate_send_key(opt);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>         }</span><br><span> =
    }</span><br><span> </span><br><span>diff --git a/tests/unit_tests/openv=
pn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>i=
ndex 82ca86e..07008c2 100644</span><br><span>--- a/tests/unit_tests/openvpn=
/test_crypto.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_crypto.c=
</span><br><span>@@ -458,24 +458,14 @@</span><br><span> void</span><br><spa=
n> crypto_test_aead_limits(void **state)</span><br><span> {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define BROKEN_LIMIT 0x100</span><b=
r><span>     /* if ChaCha20-Poly1305 is not supported by the crypto library=
 or in the</span><br><span>      * current mode (FIPS), this will still ret=
urn -1 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_i=
nt_equal(cipher_get_aead_limits(&quot;CHACHA20-POLY1305&quot;), 0);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(cipher=
_get_aead_limits(&quot;CHACHA20-POLY1305&quot;), BROKEN_LIMIT);</span><br><=
span> </span><br><span>     int64_t aeslimit =3D cipher_get_aead_limits(&qu=
ot;AES-128-GCM&quot;);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    assert_int_equal(aeslimit, (1ull &lt;&lt; 36) - 1);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* Check if this matches our exception =
for 1600 size packets assuming</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-     * AEAD_LIMIT_BLOCKSIZE (128 bits/ 16 bytes). Gives us 100 blo=
cks</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * + 1 for the=
 packet */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int64_t=
 L =3D 101;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* 2 ^=
 29.34, using the result here to avoid linking to libm */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(aeslimit / L, 6803=
90858);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    /* and for 9000, 2^26.86 */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    L =3D 563;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(aeslimit / =
L, 122059461);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(aeslimit, BROKEN_LIMIT);</span><br><span> }</span><br><span=
> </span><br><span> void</span><br><span>diff --git a/tests/unit_tests/open=
vpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>index =
842c944..0d4d8be 100644</span><br><span>--- a/tests/unit_tests/openvpn/test=
_ssl.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl.c</span><br>=
<span>@@ -398,7 +398,7 @@</span><br><span>         struct epoch_key e1 =3D =
{ .epoch =3D 1, .epoch_key =3D { 0 }};</span><br><span>         memcpy(e1.e=
poch_key, key2.keys[0].cipher, sizeof(e1.epoch_key));</span><br><span>     =
    co.flags |=3D CO_EPOCH_DATA_KEY_FORMAT;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        epoch_init_key_ctx(&amp;co, &amp;kt, &amp;e1,=
 &amp;e1, 5);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  epoch_init_key_ctx(&amp;co, &amp;kt, &amp;e1, &amp;e1, 9);</span><br><spa=
n> </span><br><span>         /* Do a little of dancing for the epoch_send_k=
ey_iterate to test</span><br><span>          * that this works too */</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/818?usp=3Demail">change 818</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/818?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7cdf992eb6031315c4978c6a1fb=
becfa723fca91 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 818 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--5MEVxQV7rK4=--

