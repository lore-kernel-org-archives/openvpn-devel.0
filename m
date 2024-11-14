From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 14 Nov 2024 13:45:07 +0000
In-Reply-To: <gerrit.1731290343000.I9e9433b56dcbaa538d9bed30e50cf74948c647cc@...2715...>
References: <gerrit.1731290343000.I9e9433b56dcbaa538d9bed30e50cf74948c647cc@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <2ff986022dac3951ecb9dc289c722ebd30f20d0e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uMGS7ni8D8A="; charset=UTF-8
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

--uMGS7ni8D8A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/805?usp=3Demail

to look at the new patch set (#3).


Change subject: Rename aead-tag-at-end to aead-epoch
......................................................................

Rename aead-tag-at-end to aead-epoch

Change-Id: I9e9433b56dcbaa538d9bed30e50cf74948c647cc
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M doc/man-sections/client-options.rst
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/push.c
M src/openvpn/ssl.h
M tests/unit_tests/openvpn/test_ssl.c
8 files changed, 18 insertions(+), 13 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/05/805/3

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-=
options.rst
index 5ca85e0..0aee9e2 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -367,6 +367,7 @@
     - bit 7: The client is capable of sending exit notification via contro=
l channel using ``EXIT`` message. Also, the client is accepting the protoco=
l-flags pushed option for the EKM capability
     - bit 8: The client is capable of accepting ``AUTH_FAILED,TEMP`` messa=
ges
     - bit 9: The client is capable of dynamic tls-crypt
+    - bit 10: The client is capable of data epoch keys

   :code:`IV_NCP=3D2`
         Negotiable ciphers, client supports ``--cipher`` pushed by
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index c04ef4f..d3f479f 100644
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
index 1c41443..de94ef1 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -362,9 +362,10 @@
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/805?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9e9433b56dcbaa538d9bed30e50cf74948c647cc
Gerrit-Change-Number: 805
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--uMGS7ni8D8A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/805?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Rename aead-tag-at-end to aead-epoch<br><br>Change-Id: I9e9433b56dcba=
a538d9bed30e50cf74948c647cc<br>Signed-off-by: Arne Schwabe &lt;arne@...1830...=
...&gt;<br>---<br>M doc/man-sections/client-options.rst<br>M src/openvpn/cr=
ypto.c<br>M src/openvpn/crypto.h<br>M src/openvpn/init.c<br>M src/openvpn/o=
ptions.c<br>M src/openvpn/push.c<br>M src/openvpn/ssl.h<br>M tests/unit_tes=
ts/openvpn/test_ssl.c<br>8 files changed, 18 insertions(+), 13 deletions(-)=
<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/05/=
805/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/doc/man-sections/client-options.rst b/doc/man-se=
ctions/client-options.rst</span><br><span>index 5ca85e0..0aee9e2 100644</sp=
an><br><span>--- a/doc/man-sections/client-options.rst</span><br><span>+++ =
b/doc/man-sections/client-options.rst</span><br><span>@@ -367,6 +367,7 @@</=
span><br><span>     - bit 7: The client is capable of sending exit notifica=
tion via control channel using ``EXIT`` message. Also, the client is accept=
ing the protocol-flags pushed option for the EKM capability</span><br><span=
>     - bit 8: The client is capable of accepting ``AUTH_FAILED,TEMP`` mess=
ages</span><br><span>     - bit 9: The client is capable of dynamic tls-cry=
pt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    - bit 10: The=
 client is capable of data epoch keys</span><br><span> </span><br><span>   =
:code:`IV_NCP=3D2`</span><br><span>         Negotiable ciphers, client supp=
orts ``--cipher`` pushed by</span><br><span>diff --git a/src/openvpn/crypto=
.c b/src/openvpn/crypto.c</span><br><span>index c04ef4f..d3f479f 100644</sp=
an><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn/c=
rypto.c</span><br><span>@@ -128,7 +128,7 @@</span><br><span>     dmsg(D_PAC=
KET_CONTENT, &quot;ENCRYPT AD: %s&quot;,</span><br><span>          format_h=
ex(BPTR(&amp;work), BLEN(&amp;work), 0, &amp;gc));</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!(opt-&gt;flags &amp=
; CO_AEAD_TAG_AT_THE_END))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!(opt-&gt;flags &amp; CO_EPOCH_DATA_KEY_FORMAT))</span><br><=
span>     {</span><br><span>         /* Reserve space for authentication ta=
g */</span><br><span>         mac_out =3D buf_write_alloc(&amp;work, mac_le=
n);</span><br><span>@@ -149,7 +149,7 @@</span><br><span>     ASSERT(buf_inc=
_len(&amp;work, outlen));</span><br><span> </span><br><span>     /* if the =
tag is at end the end, allocate it now */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (opt-&gt;flags &amp; CO_AEAD_TAG_AT_THE_END)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (opt-&gt;flags &=
amp; CO_EPOCH_DATA_KEY_FORMAT)</span><br><span>     {</span><br><span>     =
    /* Reserve space for authentication tag */</span><br><span>         mac=
_out =3D buf_write_alloc(&amp;work, mac_len);</span><br><span>@@ -475,7 +47=
5,7 @@</span><br><span>     uint8_t *tag_ptr =3D NULL;</span><br><span>    =
 int data_len =3D 0;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (opt-&gt;flags &amp; CO_AEAD_TAG_AT_THE_END)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (opt-&gt;flags &amp=
; CO_EPOCH_DATA_KEY_FORMAT)</span><br><span>     {</span><br><span>        =
 data_len =3D BLEN(buf) - tag_size;</span><br><span>         tag_ptr =3D BP=
TR(buf) + data_len;</span><br><span>diff --git a/src/openvpn/crypto.h b/src=
/openvpn/crypto.h</span><br><span>index 1c41443..de94ef1 100644</span><br><=
span>--- a/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.h<=
/span><br><span>@@ -362,9 +362,10 @@</span><br><span>     /**&lt; Bit-flag =
indicating that renegotiations are using tls-crypt</span><br><span>      * =
  with a TLS-EKM derived key.</span><br><span>      */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#define CO_AEAD_TAG_AT_THE_END  (1&lt;&lt;=
8)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /**&lt; Bit-fla=
g indicating that the AEAD tag is at the end of the</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     *   packet.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define CO_EPOCH_DATA_KEY_FORMAT  (1&lt;&lt;8)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /**&lt; Bit-fla=
g indicating that the data format using</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * AEAD tag is at the end of the  packet and using =
epoch</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * keys is=
 used.</span><br><span>      */</span><br><span> </span><br><span>     unsi=
gned int flags;         /**&lt; Bit-flags determining behavior of</span><br=
><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span=
>index 9371024..2c831fe 100644</span><br><span>--- a/src/openvpn/init.c</sp=
an><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -2390,9 +2390,9 @@=
</span><br><span>         {</span><br><span>             buf_printf(&amp;ou=
t, &quot; dyn-tls-crypt&quot;);</span><br><span>         }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (o-&gt;imported_protocol_fl=
ags &amp; CO_AEAD_TAG_AT_THE_END)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (o-&gt;imported_protocol_flags &amp; CO_EPOCH_DATA=
_KEY_FORMAT)</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            buf_printf(&amp;out, &quot; aead-tag-end&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_=
printf(&amp;out, &quot; aead-epoch&quot;);</span><br><span>         }</span=
><br><span>     }</span><br><span> </span><br><span>diff --git a/src/openvp=
n/options.c b/src/openvpn/options.c</span><br><span>index 10ee9f6..ec27e7f =
100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/sr=
c/openvpn/options.c</span><br><span>@@ -8692,9 +8692,9 @@</span><br><span> =
                options-&gt;imported_protocol_flags |=3D CO_USE_DYNAMIC_TLS=
_CRYPT;</span><br><span>             }</span><br><span> #endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            else if (streq(p[j], &=
quot;aead-tag-end&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            else if (streq(p[j], &quot;aead-epoch&quot;))</span><br><=
span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              options-&gt;imported_protocol_flags |=3D CO_AEAD_TAG_AT_THE_E=
ND;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
options-&gt;imported_protocol_flags |=3D CO_EPOCH_DATA_KEY_FORMAT;</span><b=
r><span>             }</span><br><span>             else</span><br><span>  =
           {</span><br><span>diff --git a/src/openvpn/push.c b/src/openvpn/=
push.c</span><br><span>index 6c06374..01d3699 100644</span><br><span>--- a/=
src/openvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</span><br><span=
>@@ -689,9 +689,9 @@</span><br><span>         buf_printf(&amp;proto_flags, =
&quot; dyn-tls-crypt&quot;);</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;imported_prot=
ocol_flags &amp; CO_AEAD_TAG_AT_THE_END)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (o-&gt;imported_protocol_flags &amp; CO_EPOCH_D=
ATA_KEY_FORMAT)</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        buf_printf(&amp;proto_flags, &quot; aead-tag-end&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_p=
rintf(&amp;proto_flags, &quot; aead-epoch&quot;);</span><br><span>     }</s=
pan><br><span> </span><br><span>     if (buf_len(&amp;proto_flags) &gt; 0)<=
/span><br><span>diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h</span><b=
r><span>index eea1323..e47a94d 100644</span><br><span>--- a/src/openvpn/ssl=
.h</span><br><span>+++ b/src/openvpn/ssl.h</span><br><span>@@ -107,6 +107,9=
 @@</span><br><span> /** Support to dynamic tls-crypt (renegotiation with T=
LS-EKM derived tls-crypt key) */</span><br><span> #define IV_PROTO_DYN_TLS_=
CRYPT   (1&lt;&lt;9)</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/** Support the extended packet id and epoch format for =
data channel packets */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define IV_PROTO_DATA_EPOCH      (1&lt;&lt;10)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> /** Supports the --dns opt=
ion after all the incompatible changes */</span><br><span> #define IV_PROTO=
_DNS_OPTION_V2   (1&lt;&lt;11)</span><br><span> </span><br><span>diff --git=
 a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.=
c</span><br><span>index caacd9e..845ca56 100644</span><br><span>--- a/tests=
/unit_tests/openvpn/test_ssl.c</span><br><span>+++ b/tests/unit_tests/openv=
pn/test_ssl.c</span><br><span>@@ -404,7 +404,7 @@</span><br><span> run_data=
_channel_with_cipher_end(const char *cipher)</span><br><span> {</span><br><=
span>     struct crypto_options co =3D init_crypto_options(cipher, &quot;no=
ne&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    co.flag=
s |=3D CO_AEAD_TAG_AT_THE_END;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    co.flags |=3D CO_EPOCH_DATA_KEY_FORMAT;</span><br><span>    =
 do_data_channel_round_trip(&amp;co);</span><br><span>     uninit_crypto_op=
tions(&amp;co);</span><br><span> }</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/805?usp=3Demail=
">change 805</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/805?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9e9433b56dcbaa538d9bed30e50=
cf74948c647cc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 805 </div>
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


--uMGS7ni8D8A=--

