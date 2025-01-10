From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 10 Jan 2025 07:19:41 +0000
In-Reply-To: <gerrit.1731290343000.I9e9433b56dcbaa538d9bed30e50cf74948c647cc@...2715...>
References: <gerrit.1731290343000.I9e9433b56dcbaa538d9bed30e50cf74948c647cc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <3f95afa2baba0e85edd875c899d495d995d32d8d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ieS0eZakgXE="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: MaxF <max@...2606...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ieS0eZakgXE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/80=
5?usp=3Demail )

Change subject: Rename aead-tag-at-end to aead-epoch
......................................................................

Rename aead-tag-at-end to aead-epoch

Since we introduce aead at the end and epoch data keys together
and only allow the aead tag at the end if epoch data keys are
used, we can use just one flag for both of them

Change-Id: I9e9433b56dcbaa538d9bed30e50cf74948c647cc
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: MaxF <max@...2606...>
Message-Id: <20250109212803.11505-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
395.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/client-options.rst
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/push.c
M src/openvpn/ssl.h
M tests/unit_tests/openvpn/test_ssl.c
8 files changed, 19 insertions(+), 13 deletions(-)




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
index b107f88..84ec436 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -127,7 +127,7 @@
     dmsg(D_PACKET_CONTENT, "ENCRYPT AD: %s",
          format_hex(BPTR(&work), BLEN(&work), 0, &gc));

-    if (!(opt->flags & CO_AEAD_TAG_AT_THE_END))
+    if (!(opt->flags & CO_EPOCH_DATA_KEY_FORMAT))
     {
         /* Reserve space for authentication tag */
         mac_out =3D buf_write_alloc(&work, mac_len);
@@ -148,7 +148,7 @@
     ASSERT(buf_inc_len(&work, outlen));

     /* if the tag is at end the end, allocate it now */
-    if (opt->flags & CO_AEAD_TAG_AT_THE_END)
+    if (opt->flags & CO_EPOCH_DATA_KEY_FORMAT)
     {
         /* Reserve space for authentication tag */
         mac_out =3D buf_write_alloc(&work, mac_len);
@@ -479,7 +479,7 @@
     uint8_t *tag_ptr =3D NULL;
     int data_len =3D 0;

-    if (opt->flags & CO_AEAD_TAG_AT_THE_END)
+    if (opt->flags & CO_EPOCH_DATA_KEY_FORMAT)
     {
         data_len =3D BLEN(buf) - tag_size;
         tag_ptr =3D BPTR(buf) + data_len;
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index a98dca0..5ceb523 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -373,9 +373,11 @@
     /**< Bit-flag indicating that renegotiations are using tls-crypt
      *   with a TLS-EKM derived key.
      */
-#define CO_AEAD_TAG_AT_THE_END  (1<<8)
-    /**< Bit-flag indicating that the AEAD tag is at the end of the
-     *   packet.
+#define CO_EPOCH_DATA_KEY_FORMAT  (1<<8)
+    /**< Bit-flag indicating the epoch the data format. This format
+     * has the AEAD tag at the end of the packet and is using a longer
+     * 64-bit packet id that is split into a 16 bit epoch and 48 bit
+     * epoch counter
      */

     unsigned int flags;         /**< Bit-flags determining behavior of
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2bd5518..9d1048c 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2407,9 +2407,9 @@
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
index 1c35d67..eb0d9b5 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8659,9 +8659,9 @@
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
index de44eb2..a7cd3bf 100644
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
index 3561c41..c32cb6c 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -108,6 +108,9 @@
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
Gerrit-PatchSet: 13
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--ieS0eZakgXE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/805?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Rename aead-tag-at-end to aead-epoch<br><br>Si=
nce we introduce aead at the end and epoch data keys together<br>and only a=
llow the aead tag at the end if epoch data keys are<br>used, we can use jus=
t one flag for both of them<br><br>Change-Id: I9e9433b56dcbaa538d9bed30e50c=
f74948c647cc<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acke=
d-by: MaxF &lt;max@...2606...&gt;<br>Message-Id: &lt;20250109212803.11505-1=
-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1484...=
ts.sourceforge.net/msg30395.html<br>Signed-off-by: Gert Doering &lt;gert@...1186...=
.1296...&gt;<br>---<br>M doc/man-sections/client-options.rst<br>M src/openv=
pn/crypto.c<br>M src/openvpn/crypto.h<br>M src/openvpn/init.c<br>M src/open=
vpn/options.c<br>M src/openvpn/push.c<br>M src/openvpn/ssl.h<br>M tests/uni=
t_tests/openvpn/test_ssl.c<br>8 files changed, 19 insertions(+), 13 deletio=
ns(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/clie=
nt-options.rst</span><br><span>index 5ca85e0..0aee9e2 100644</span><br><spa=
n>--- a/doc/man-sections/client-options.rst</span><br><span>+++ b/doc/man-s=
ections/client-options.rst</span><br><span>@@ -367,6 +367,7 @@</span><br><s=
pan>     - bit 7: The client is capable of sending exit notification via co=
ntrol channel using ``EXIT`` message. Also, the client is accepting the pro=
tocol-flags pushed option for the EKM capability</span><br><span>     - bit=
 8: The client is capable of accepting ``AUTH_FAILED,TEMP`` messages</span>=
<br><span>     - bit 9: The client is capable of dynamic tls-crypt</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    - bit 10: The client is =
capable of data epoch keys</span><br><span> </span><br><span>   :code:`IV_N=
CP=3D2`</span><br><span>         Negotiable ciphers, client supports ``--ci=
pher`` pushed by</span><br><span>diff --git a/src/openvpn/crypto.c b/src/op=
envpn/crypto.c</span><br><span>index b107f88..84ec436 100644</span><br><spa=
n>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn/crypto.c</sp=
an><br><span>@@ -127,7 +127,7 @@</span><br><span>     dmsg(D_PACKET_CONTENT=
, &quot;ENCRYPT AD: %s&quot;,</span><br><span>          format_hex(BPTR(&am=
p;work), BLEN(&amp;work), 0, &amp;gc));</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (!(opt-&gt;flags &amp; CO_AEAD_T=
AG_AT_THE_END))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!(opt-&gt;flags &amp; CO_EPOCH_DATA_KEY_FORMAT))</span><br><span>     {=
</span><br><span>         /* Reserve space for authentication tag */</span>=
<br><span>         mac_out =3D buf_write_alloc(&amp;work, mac_len);</span><=
br><span>@@ -148,7 +148,7 @@</span><br><span>     ASSERT(buf_inc_len(&amp;w=
ork, outlen));</span><br><span> </span><br><span>     /* if the tag is at e=
nd the end, allocate it now */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (opt-&gt;flags &amp; CO_AEAD_TAG_AT_THE_END)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (opt-&gt;flags &amp; CO_EPO=
CH_DATA_KEY_FORMAT)</span><br><span>     {</span><br><span>         /* Rese=
rve space for authentication tag */</span><br><span>         mac_out =3D bu=
f_write_alloc(&amp;work, mac_len);</span><br><span>@@ -479,7 +479,7 @@</spa=
n><br><span>     uint8_t *tag_ptr =3D NULL;</span><br><span>     int data_l=
en =3D 0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (opt-&gt;flags &amp; CO_AEAD_TAG_AT_THE_END)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (opt-&gt;flags &amp; CO_EPOCH_=
DATA_KEY_FORMAT)</span><br><span>     {</span><br><span>         data_len =
=3D BLEN(buf) - tag_size;</span><br><span>         tag_ptr =3D BPTR(buf) + =
data_len;</span><br><span>diff --git a/src/openvpn/crypto.h b/src/openvpn/c=
rypto.h</span><br><span>index a98dca0..5ceb523 100644</span><br><span>--- a=
/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.h</span><br>=
<span>@@ -373,9 +373,11 @@</span><br><span>     /**&lt; Bit-flag indicating=
 that renegotiations are using tls-crypt</span><br><span>      *   with a T=
LS-EKM derived key.</span><br><span>      */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define CO_AEAD_TAG_AT_THE_END  (1&lt;&lt;8)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    /**&lt; Bit-flag indicati=
ng that the AEAD tag is at the end of the</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-     *   packet.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define CO_EPOCH_DATA_KEY_FORMAT  (1&lt;&lt;8)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /**&lt; Bit-flag indicating=
 the epoch the data format. This format</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * has the AEAD tag at the end of the packet and is=
 using a longer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * 64-bit packet id that is split into a 16 bit epoch and 48 bit</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * epoch counter</span><br=
><span>      */</span><br><span> </span><br><span>     unsigned int flags; =
        /**&lt; Bit-flags determining behavior of</span><br><span>diff --gi=
t a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index 2bd5518..=
9d1048c 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++=
 b/src/openvpn/init.c</span><br><span>@@ -2407,9 +2407,9 @@</span><br><span=
>         {</span><br><span>             buf_printf(&amp;out, &quot; dyn-tl=
s-crypt&quot;);</span><br><span>         }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (o-&gt;imported_protocol_flags &amp; CO_AEA=
D_TAG_AT_THE_END)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (o-&gt;imported_protocol_flags &amp; CO_EPOCH_DATA_KEY_FORMAT)</sp=
an><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            buf_printf(&amp;out, &quot; aead-tag-end&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;out,=
 &quot; aead-epoch&quot;);</span><br><span>         }</span><br><span>     =
}</span><br><span> </span><br><span>diff --git a/src/openvpn/options.c b/sr=
c/openvpn/options.c</span><br><span>index 1c35d67..eb0d9b5 100644</span><br=
><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/option=
s.c</span><br><span>@@ -8659,9 +8659,9 @@</span><br><span>                 =
options-&gt;imported_protocol_flags |=3D CO_USE_DYNAMIC_TLS_CRYPT;</span><b=
r><span>             }</span><br><span> #endif</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            else if (streq(p[j], &quot;aead-tag-en=
d&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  else if (streq(p[j], &quot;aead-epoch&quot;))</span><br><span>           =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                op=
tions-&gt;imported_protocol_flags |=3D CO_AEAD_TAG_AT_THE_END;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                options-&gt;impo=
rted_protocol_flags |=3D CO_EPOCH_DATA_KEY_FORMAT;</span><br><span>        =
     }</span><br><span>             else</span><br><span>             {</sp=
an><br><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br=
><span>index de44eb2..a7cd3bf 100644</span><br><span>--- a/src/openvpn/push=
.c</span><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -689,9 +689,=
9 @@</span><br><span>         buf_printf(&amp;proto_flags, &quot; dyn-tls-c=
rypt&quot;);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;imported_protocol_flags &amp;=
 CO_AEAD_TAG_AT_THE_END)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (o-&gt;imported_protocol_flags &amp; CO_EPOCH_DATA_KEY_FORMAT)<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        buf_printf(&amp;proto_flags, &quot; aead-tag-end&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;proto=
_flags, &quot; aead-epoch&quot;);</span><br><span>     }</span><br><span> <=
/span><br><span>     if (buf_len(&amp;proto_flags) &gt; 0)</span><br><span>=
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h</span><br><span>index 35=
61c41..c32cb6c 100644</span><br><span>--- a/src/openvpn/ssl.h</span><br><sp=
an>+++ b/src/openvpn/ssl.h</span><br><span>@@ -108,6 +108,9 @@</span><br><s=
pan> /** Support to dynamic tls-crypt (renegotiation with TLS-EKM derived t=
ls-crypt key) */</span><br><span> #define IV_PROTO_DYN_TLS_CRYPT   (1&lt;&l=
t;9)</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/** Support the extended packet id and epoch format for data channel pac=
kets */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IV_P=
ROTO_DATA_EPOCH      (1&lt;&lt;10)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> /** Supports the --dns option after all th=
e incompatible changes */</span><br><span> #define IV_PROTO_DNS_OPTION_V2  =
 (1&lt;&lt;11)</span><br><span> </span><br><span>diff --git a/tests/unit_te=
sts/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c</span><br><spa=
n>index caacd9e..845ca56 100644</span><br><span>--- a/tests/unit_tests/open=
vpn/test_ssl.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl.c</s=
pan><br><span>@@ -404,7 +404,7 @@</span><br><span> run_data_channel_with_ci=
pher_end(const char *cipher)</span><br><span> {</span><br><span>     struct=
 crypto_options co =3D init_crypto_options(cipher, &quot;none&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    co.flags |=3D CO_AEAD_T=
AG_AT_THE_END;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
o.flags |=3D CO_EPOCH_DATA_KEY_FORMAT;</span><br><span>     do_data_channel=
_round_trip(&amp;co);</span><br><span>     uninit_crypto_options(&amp;co);<=
/span><br><span> }</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/805?usp=3Demail">change 805</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/805?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9e9433b56dcbaa538d9bed30e50=
cf74948c647cc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 805 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--ieS0eZakgXE=--

