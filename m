From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 22 Nov 2024 16:29:27 +0000
References: <gerrit.1732292955000.I7cdf992eb6031315c4978c6a1fbbecfa723fca91@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <ca950beab19ac06092980dfb504aec2f821fa4bc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XCHrnby7wOk="; charset=UTF-8
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

--XCHrnby7wOk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/818?usp=3Demail

to review the following change.


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
M tests/unit_tests/openvpn/test_ssl.c
3 files changed, 18 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/818/1

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 9166707..e990d80 100644
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
index 4a9a338..3df56ba 100644
--- a/src/openvpn/crypto_epoch.c
+++ b/src/openvpn/crypto_epoch.c
@@ -413,8 +413,13 @@
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
@@ -436,7 +441,13 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--XCHrnby7wOk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/818?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">[TEST-ONLY] Mess with internal logic to test epoch data<br><b=
r>This rotates/invalidates keys extremely quickly and also jumps forward<br=
>1-8 keys instead of always one to test that part of the logic.<br><br>Chan=
ge-Id: I7cdf992eb6031315c4978c6a1fbbecfa723fca91<br>Signed-off-by: Arne Sch=
wabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/crypto.c<br>M src/open=
vpn/crypto_epoch.c<br>M tests/unit_tests/openvpn/test_ssl.c<br>3 files chan=
ged, 18 insertions(+), 4 deletions(-)<br><br></pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openv=
pn.net:29418/openvpn refs/changes/18/818/1</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn=
/crypto.c b/src/openvpn/crypto.c</span><br><span>index 9166707..e990d80 100=
644</span><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/op=
envpn/crypto.c</span><br><span>@@ -352,6 +352,9 @@</span><br><span> int64_t=
</span><br><span> cipher_get_aead_limits(const char *ciphername)</span><br>=
<span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* TEST=
ING: Make AEAD key limits really really really small to force</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * key rollever super quickly=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 256;<=
/span><br><span>     if (!cipher_kt_mode_aead(ciphername))</span><br><span>=
     {</span><br><span>         return 0;</span><br><span>diff --git a/src/=
openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c</span><br><span>index 4=
a9a338..3df56ba 100644</span><br><span>--- a/src/openvpn/crypto_epoch.c</sp=
an><br><span>+++ b/src/openvpn/crypto_epoch.c</span><br><span>@@ -413,8 +41=
3,13 @@</span><br><span>         if (aead_usage_limit_reached(opt-&gt;aead_=
usage_limit, &amp;opt-&gt;key_ctx_bi.encrypt,</span><br><span>             =
                         opt-&gt;packet_id.send.id))</span><br><span>      =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Se=
nd key limit reached */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            epoch_iterate_send_key(opt);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            int forward =3D rand() % 8 + 1;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            /* Send key limi=
t reached, go one key forward or in this TEST</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+             * gremlin mode, 1 to 8 to test the o=
ther side future key stuff */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            for (int i =3D 0; i &lt; forward; i++)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                epoch_iterate_send_key(o=
pt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span>         }</span><br><span>         /* draft 8 of the aead u=
sage limit still had but draft 9 complete</span><br><span>          * dropp=
ed this statement:</span><br><span>@@ -436,7 +441,13 @@</span><br><span>   =
          /* Receive key limit reached. Increase our own send key to signal=
</span><br><span>              * that we want to use a new epoch. Peer shou=
ld then also move its</span><br><span>              * key but is not requir=
ed to do this */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       epoch_iterate_send_key(opt);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            int forward =3D rand() % 8 + 1;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            /* gremlin mode, 1 to 8=
 to test the other side future key stuff */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            for (int i =3D 0; i &lt; forward; i++)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                epoch_iter=
ate_send_key(opt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>         }</span><br><span>     }</span><br><span> </span><br><sp=
an>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/open=
vpn/test_ssl.c</span><br><span>index 842c944..0d4d8be 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_ssl.c</span><br><span>@@ -398,7 +398,7 @@</span><br><s=
pan>         struct epoch_key e1 =3D { .epoch =3D 1, .epoch_key =3D { 0 }};=
</span><br><span>         memcpy(e1.epoch_key, key2.keys[0].cipher, sizeof(=
e1.epoch_key));</span><br><span>         co.flags |=3D CO_EPOCH_DATA_KEY_FO=
RMAT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        epoch_in=
it_key_ctx(&amp;co, &amp;kt, &amp;e1, &amp;e1, 5);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        epoch_init_key_ctx(&amp;co, &amp;kt,=
 &amp;e1, &amp;e1, 9);</span><br><span> </span><br><span>         /* Do a l=
ittle of dancing for the epoch_send_key_iterate to test</span><br><span>   =
       * that this works too */</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/818?usp=3Demail">c=
hange 818</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/818?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7cdf992eb6031315c4978c6a1fb=
becfa723fca91 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 818 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--XCHrnby7wOk=--

