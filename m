From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 11 Nov 2024 02:00:05 +0000
References: <gerrit.1731290343000.I9e9433b56dcbaa538d9bed30e50cf74948c647cc@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <1dd11ecfdbe24eff158a3ab357bfd4ba3d22cec2-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DYbN2SvTVlc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Rename
 aead-tag-at-end to aead-epoch
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

--DYbN2SvTVlc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/805?usp=3Demail

to review the following change.


Change subject: Rename aead-tag-at-end to aead-epoch
......................................................................

Rename aead-tag-at-end to aead-epoch

Change-Id: I9e9433b56dcbaa538d9bed30e50cf74948c647cc
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/push.c
M src/openvpn/ssl.h
M tests/unit_tests/openvpn/test_ssl.c
7 files changed, 17 insertions(+), 13 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/05/805/1

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index dc23ffc..996830c 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -128,7 +128,7 @@
     dmsg(D_PACKET_CONTENT, "ENCRYPT AD: %s",
          format_hex(BPTR(&work), BLEN(&work), 0, &gc));

-    if (!(opt->flags & CO_AEAD_TAG_AT_THE_END))
+    if (!(opt->flags & CO_EPOCH_DATA_KEY_FORMAT))
     {
         /* Reserve space for authentication tag */
         mac_out =3D buf_write_alloc(&work, mac_len);
@@ -149,7 +149,7 @@
     ASSERT(buf_inc_len(&work, outlen));

     /* if the tag is at end the end, allocate it now */
-    if (opt->flags & CO_AEAD_TAG_AT_THE_END)
+    if (opt->flags & CO_EPOCH_DATA_KEY_FORMAT)
     {
         /* Reserve space for authentication tag */
         mac_out =3D buf_write_alloc(&work, mac_len);
@@ -475,7 +475,7 @@
     uint8_t *tag_ptr =3D NULL;
     int data_len =3D 0;

-    if (opt->flags & CO_AEAD_TAG_AT_THE_END)
+    if (opt->flags & CO_EPOCH_DATA_KEY_FORMAT)
     {
         data_len =3D BLEN(buf) - tag_size;
         tag_ptr =3D BPTR(buf) + data_len;
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index abba30c..933bc2f 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -359,9 +359,10 @@
     /**< Bit-flag indicating that renegotiations are using tls-crypt
      *   with a TLS-EKM derived key.
      */
-#define CO_AEAD_TAG_AT_THE_END  (1<<8)
-    /**< Bit-flag indicating that the AEAD tag is at the end of the
-     *   packet.
+#define CO_EPOCH_DATA_KEY_FORMAT  (1<<8)
+    /**< Bit-flag indicating that the data format using
+     * AEAD tag is at the end of the  packet and using epoch
+     * keys is used.
      */

     unsigned int flags;         /**< Bit-flags determining behavior of
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9371024..2c831fe 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2390,9 +2390,9 @@
         {
             buf_printf(&out, " dyn-tls-crypt");
         }
-        if (o->imported_protocol_flags & CO_AEAD_TAG_AT_THE_END)
+        if (o->imported_protocol_flags & CO_EPOCH_DATA_KEY_FORMAT)
         {
-            buf_printf(&out, " aead-tag-end");
+            buf_printf(&out, " aead-epoch");
         }
     }

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 10ee9f6..ec27e7f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8692,9 +8692,9 @@
                 options->imported_protocol_flags |=3D CO_USE_DYNAMIC_TLS_C=
RYPT;
             }
 #endif
-            else if (streq(p[j], "aead-tag-end"))
+            else if (streq(p[j], "aead-epoch"))
             {
-                options->imported_protocol_flags |=3D CO_AEAD_TAG_AT_THE_E=
ND;
+                options->imported_protocol_flags |=3D CO_EPOCH_DATA_KEY_FO=
RMAT;
             }
             else
             {
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 6c06374..01d3699 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -689,9 +689,9 @@
         buf_printf(&proto_flags, " dyn-tls-crypt");
     }

-    if (o->imported_protocol_flags & CO_AEAD_TAG_AT_THE_END)
+    if (o->imported_protocol_flags & CO_EPOCH_DATA_KEY_FORMAT)
     {
-        buf_printf(&proto_flags, " aead-tag-end");
+        buf_printf(&proto_flags, " aead-epoch");
     }

     if (buf_len(&proto_flags) > 0)
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index eea1323..e47a94d 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -107,6 +107,9 @@
 /** Support to dynamic tls-crypt (renegotiation with TLS-EKM derived tls-c=
rypt key) */
 #define IV_PROTO_DYN_TLS_CRYPT   (1<<9)

+/** Support the extended packet id and epoch format for data channel packe=
ts */
+#define IV_PROTO_DATA_EPOCH      (1<<10)
+
 /** Supports the --dns option after all the incompatible changes */
 #define IV_PROTO_DNS_OPTION_V2   (1<<11)

diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index caacd9e..845ca56 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -404,7 +404,7 @@
 run_data_channel_with_cipher_end(const char *cipher)
 {
     struct crypto_options co =3D init_crypto_options(cipher, "none");
-    co.flags |=3D CO_AEAD_TAG_AT_THE_END;
+    co.flags |=3D CO_EPOCH_DATA_KEY_FORMAT;
     do_data_channel_round_trip(&co);
     uninit_crypto_options(&co);
 }

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/805?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9e9433b56dcbaa538d9bed30e50cf74948c647cc
Gerrit-Change-Number: 805
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--DYbN2SvTVlc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/805?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Rename aead-tag-at-end to aead-epoch<br><br>Change-Id: I9e943=
3b56dcbaa538d9bed30e50cf74948c647cc<br>Signed-off-by: Arne Schwabe &lt;arne=
@...1227...&gt;<br>---<br>M src/openvpn/crypto.c<br>M src/openvpn/crypto.h<=
br>M src/openvpn/init.c<br>M src/openvpn/options.c<br>M src/openvpn/push.c<=
br>M src/openvpn/ssl.h<br>M tests/unit_tests/openvpn/test_ssl.c<br>7 files =
changed, 17 insertions(+), 13 deletions(-)<br><br></pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.=
openvpn.net:29418/openvpn refs/changes/05/805/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/crypto.c b/src/openvpn/crypto.c</span><br><span>index dc23ffc..996830=
c 100644</span><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/s=
rc/openvpn/crypto.c</span><br><span>@@ -128,7 +128,7 @@</span><br><span>   =
  dmsg(D_PACKET_CONTENT, &quot;ENCRYPT AD: %s&quot;,</span><br><span>      =
    format_hex(BPTR(&amp;work), BLEN(&amp;work), 0, &amp;gc));</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!(opt-&g=
t;flags &amp; CO_AEAD_TAG_AT_THE_END))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (!(opt-&gt;flags &amp; CO_EPOCH_DATA_KEY_FORMAT))=
</span><br><span>     {</span><br><span>         /* Reserve space for authe=
ntication tag */</span><br><span>         mac_out =3D buf_write_alloc(&amp;=
work, mac_len);</span><br><span>@@ -149,7 +149,7 @@</span><br><span>     AS=
SERT(buf_inc_len(&amp;work, outlen));</span><br><span> </span><br><span>   =
  /* if the tag is at end the end, allocate it now */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (opt-&gt;flags &amp; CO_AEAD_TAG_AT_=
THE_END)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (opt=
-&gt;flags &amp; CO_EPOCH_DATA_KEY_FORMAT)</span><br><span>     {</span><br=
><span>         /* Reserve space for authentication tag */</span><br><span>=
         mac_out =3D buf_write_alloc(&amp;work, mac_len);</span><br><span>@=
@ -475,7 +475,7 @@</span><br><span>     uint8_t *tag_ptr =3D NULL;</span><b=
r><span>     int data_len =3D 0;</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (opt-&gt;flags &amp; CO_AEAD_TAG_AT_THE=
_END)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (opt-&g=
t;flags &amp; CO_EPOCH_DATA_KEY_FORMAT)</span><br><span>     {</span><br><s=
pan>         data_len =3D BLEN(buf) - tag_size;</span><br><span>         ta=
g_ptr =3D BPTR(buf) + data_len;</span><br><span>diff --git a/src/openvpn/cr=
ypto.h b/src/openvpn/crypto.h</span><br><span>index abba30c..933bc2f 100644=
</span><br><span>--- a/src/openvpn/crypto.h</span><br><span>+++ b/src/openv=
pn/crypto.h</span><br><span>@@ -359,9 +359,10 @@</span><br><span>     /**&l=
t; Bit-flag indicating that renegotiations are using tls-crypt</span><br><s=
pan>      *   with a TLS-EKM derived key.</span><br><span>      */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define CO_AEAD_TAG_AT_THE_END=
  (1&lt;&lt;8)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /**=
&lt; Bit-flag indicating that the AEAD tag is at the end of the</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-     *   packet.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define CO_EPOCH_DATA_KEY_FORMAT  (1=
&lt;&lt;8)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /**&l=
t; Bit-flag indicating that the data format using</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * AEAD tag is at the end of the  packet =
and using epoch</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * keys is used.</span><br><span>      */</span><br><span> </span><br><span=
>     unsigned int flags;         /**&lt; Bit-flags determining behavior of=
</span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span=
><br><span>index 9371024..2c831fe 100644</span><br><span>--- a/src/openvpn/=
init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -2390,9 =
+2390,9 @@</span><br><span>         {</span><br><span>             buf_prin=
tf(&amp;out, &quot; dyn-tls-crypt&quot;);</span><br><span>         }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (o-&gt;imported_p=
rotocol_flags &amp; CO_AEAD_TAG_AT_THE_END)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (o-&gt;imported_protocol_flags &amp; CO_=
EPOCH_DATA_KEY_FORMAT)</span><br><span>         {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quot; aead-ta=
g-end&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      buf_printf(&amp;out, &quot; aead-epoch&quot;);</span><br><span>      =
   }</span><br><span>     }</span><br><span> </span><br><span>diff --git a/=
src/openvpn/options.c b/src/openvpn/options.c</span><br><span>index 10ee9f6=
..ec27e7f 100644</span><br><span>--- a/src/openvpn/options.c</span><br><spa=
n>+++ b/src/openvpn/options.c</span><br><span>@@ -8692,9 +8692,9 @@</span><=
br><span>                 options-&gt;imported_protocol_flags |=3D CO_USE_D=
YNAMIC_TLS_CRYPT;</span><br><span>             }</span><br><span> #endif</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            else if (str=
eq(p[j], &quot;aead-tag-end&quot;))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            else if (streq(p[j], &quot;aead-epoch&quot;))</=
span><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                options-&gt;imported_protocol_flags |=3D CO_AEAD_TA=
G_AT_THE_END;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          options-&gt;imported_protocol_flags |=3D CO_EPOCH_DATA_KEY_FORMAT=
;</span><br><span>             }</span><br><span>             else</span><b=
r><span>             {</span><br><span>diff --git a/src/openvpn/push.c b/sr=
c/openvpn/push.c</span><br><span>index 6c06374..01d3699 100644</span><br><s=
pan>--- a/src/openvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</span=
><br><span>@@ -689,9 +689,9 @@</span><br><span>         buf_printf(&amp;pro=
to_flags, &quot; dyn-tls-crypt&quot;);</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;imp=
orted_protocol_flags &amp; CO_AEAD_TAG_AT_THE_END)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (o-&gt;imported_protocol_flags &amp; =
CO_EPOCH_DATA_KEY_FORMAT)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        buf_printf(&amp;proto_flags, &quot; aead=
-tag-end&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     buf_printf(&amp;proto_flags, &quot; aead-epoch&quot;);</span><br><span=
>     }</span><br><span> </span><br><span>     if (buf_len(&amp;proto_flags=
) &gt; 0)</span><br><span>diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.=
h</span><br><span>index eea1323..e47a94d 100644</span><br><span>--- a/src/o=
penvpn/ssl.h</span><br><span>+++ b/src/openvpn/ssl.h</span><br><span>@@ -10=
7,6 +107,9 @@</span><br><span> /** Support to dynamic tls-crypt (renegotiat=
ion with TLS-EKM derived tls-crypt key) */</span><br><span> #define IV_PROT=
O_DYN_TLS_CRYPT   (1&lt;&lt;9)</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/** Support the extended packet id and epoch f=
ormat for data channel packets */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define IV_PROTO_DATA_EPOCH      (1&lt;&lt;10)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /** Supports the=
 --dns option after all the incompatible changes */</span><br><span> #defin=
e IV_PROTO_DNS_OPTION_V2   (1&lt;&lt;11)</span><br><span> </span><br><span>=
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c</span><br><span>index caacd9e..845ca56 100644</span><br><span>-=
-- a/tests/unit_tests/openvpn/test_ssl.c</span><br><span>+++ b/tests/unit_t=
ests/openvpn/test_ssl.c</span><br><span>@@ -404,7 +404,7 @@</span><br><span=
> run_data_channel_with_cipher_end(const char *cipher)</span><br><span> {</=
span><br><span>     struct crypto_options co =3D init_crypto_options(cipher=
, &quot;none&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   co.flags |=3D CO_AEAD_TAG_AT_THE_END;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    co.flags |=3D CO_EPOCH_DATA_KEY_FORMAT;</span><br>=
<span>     do_data_channel_round_trip(&amp;co);</span><br><span>     uninit=
_crypto_options(&amp;co);</span><br><span> }</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/805?u=
sp=3Demail">change 805</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/805?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9e9433b56dcbaa538d9bed30e50=
cf74948c647cc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 805 </div>
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


--DYbN2SvTVlc=--

