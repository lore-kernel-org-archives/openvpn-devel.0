From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 10 Jan 2025 07:19:38 +0000
In-Reply-To: <gerrit.1731290343000.I9e9433b56dcbaa538d9bed30e50cf74948c647cc@...2715...>
References: <gerrit.1731290343000.I9e9433b56dcbaa538d9bed30e50cf74948c647cc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <3f95afa2baba0e85edd875c899d495d995d32d8d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3J1xNDFECFc="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3J1xNDFECFc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#13) to the change originally created b=
y plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/805?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by MaxF


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/05/805/13

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
Gerrit-MessageType: newpatchset

--3J1xNDFECFc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #13</strong> to the change originally c=
reated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/805?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by MaxF</p><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">Rename aead-tag-at-end to aead-epoch<br><br>Since we =
introduce aead at the end and epoch data keys together<br>and only allow th=
e aead tag at the end if epoch data keys are<br>used, we can use just one f=
lag for both of them<br><br>Change-Id: I9e9433b56dcbaa538d9bed30e50cf74948c=
647cc<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: M=
axF &lt;max@...2606...&gt;<br>Message-Id: &lt;20250109212803.11505-1-gert@...220...=
..1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1439...=
ceforge.net/msg30395.html<br>Signed-off-by: Gert Doering &lt;gert@...2132...=
.&gt;<br>---<br>M doc/man-sections/client-options.rst<br>M src/openvpn/cryp=
to.c<br>M src/openvpn/crypto.h<br>M src/openvpn/init.c<br>M src/openvpn/opt=
ions.c<br>M src/openvpn/push.c<br>M src/openvpn/ssl.h<br>M tests/unit_tests=
/openvpn/test_ssl.c<br>8 files changed, 19 insertions(+), 13 deletions(-)<b=
r><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/05/80=
5/13</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/doc/man-sections/client-options.rst b/doc/man-sec=
tions/client-options.rst</span><br><span>index 5ca85e0..0aee9e2 100644</spa=
n><br><span>--- a/doc/man-sections/client-options.rst</span><br><span>+++ b=
/doc/man-sections/client-options.rst</span><br><span>@@ -367,6 +367,7 @@</s=
pan><br><span>     - bit 7: The client is capable of sending exit notificat=
ion via control channel using ``EXIT`` message. Also, the client is accepti=
ng the protocol-flags pushed option for the EKM capability</span><br><span>=
     - bit 8: The client is capable of accepting ``AUTH_FAILED,TEMP`` messa=
ges</span><br><span>     - bit 9: The client is capable of dynamic tls-cryp=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    - bit 10: The =
client is capable of data epoch keys</span><br><span> </span><br><span>   :=
code:`IV_NCP=3D2`</span><br><span>         Negotiable ciphers, client suppo=
rts ``--cipher`` pushed by</span><br><span>diff --git a/src/openvpn/crypto.=
c b/src/openvpn/crypto.c</span><br><span>index b107f88..84ec436 100644</spa=
n><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn/cr=
ypto.c</span><br><span>@@ -127,7 +127,7 @@</span><br><span>     dmsg(D_PACK=
ET_CONTENT, &quot;ENCRYPT AD: %s&quot;,</span><br><span>          format_he=
x(BPTR(&amp;work), BLEN(&amp;work), 0, &amp;gc));</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!(opt-&gt;flags &amp;=
 CO_AEAD_TAG_AT_THE_END))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!(opt-&gt;flags &amp; CO_EPOCH_DATA_KEY_FORMAT))</span><br><s=
pan>     {</span><br><span>         /* Reserve space for authentication tag=
 */</span><br><span>         mac_out =3D buf_write_alloc(&amp;work, mac_len=
);</span><br><span>@@ -148,7 +148,7 @@</span><br><span>     ASSERT(buf_inc_=
len(&amp;work, outlen));</span><br><span> </span><br><span>     /* if the t=
ag is at end the end, allocate it now */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (opt-&gt;flags &amp; CO_AEAD_TAG_AT_THE_END)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (opt-&gt;flags &a=
mp; CO_EPOCH_DATA_KEY_FORMAT)</span><br><span>     {</span><br><span>      =
   /* Reserve space for authentication tag */</span><br><span>         mac_=
out =3D buf_write_alloc(&amp;work, mac_len);</span><br><span>@@ -479,7 +479=
,7 @@</span><br><span>     uint8_t *tag_ptr =3D NULL;</span><br><span>     =
int data_len =3D 0;</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (opt-&gt;flags &amp; CO_AEAD_TAG_AT_THE_END)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (opt-&gt;flags &amp;=
 CO_EPOCH_DATA_KEY_FORMAT)</span><br><span>     {</span><br><span>         =
data_len =3D BLEN(buf) - tag_size;</span><br><span>         tag_ptr =3D BPT=
R(buf) + data_len;</span><br><span>diff --git a/src/openvpn/crypto.h b/src/=
openvpn/crypto.h</span><br><span>index a98dca0..5ceb523 100644</span><br><s=
pan>--- a/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.h</=
span><br><span>@@ -373,9 +373,11 @@</span><br><span>     /**&lt; Bit-flag i=
ndicating that renegotiations are using tls-crypt</span><br><span>      *  =
 with a TLS-EKM derived key.</span><br><span>      */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define CO_AEAD_TAG_AT_THE_END  (1&lt;&lt;8=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /**&lt; Bit-flag=
 indicating that the AEAD tag is at the end of the</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-     *   packet.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define CO_EPOCH_DATA_KEY_FORMAT  (1&lt;&lt;8)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /**&lt; Bit-flag i=
ndicating the epoch the data format. This format</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * has the AEAD tag at the end of the pack=
et and is using a longer</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * 64-bit packet id that is split into a 16 bit epoch and 48 bit</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * epoch counter<=
/span><br><span>      */</span><br><span> </span><br><span>     unsigned in=
t flags;         /**&lt; Bit-flags determining behavior of</span><br><span>=
diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index =
2bd5518..9d1048c 100644</span><br><span>--- a/src/openvpn/init.c</span><br>=
<span>+++ b/src/openvpn/init.c</span><br><span>@@ -2407,9 +2407,9 @@</span>=
<br><span>         {</span><br><span>             buf_printf(&amp;out, &quo=
t; dyn-tls-crypt&quot;);</span><br><span>         }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (o-&gt;imported_protocol_flags &=
amp; CO_AEAD_TAG_AT_THE_END)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (o-&gt;imported_protocol_flags &amp; CO_EPOCH_DATA_KEY_=
FORMAT)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            buf_printf(&amp;out, &quot; aead-tag-end&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_print=
f(&amp;out, &quot; aead-epoch&quot;);</span><br><span>         }</span><br>=
<span>     }</span><br><span> </span><br><span>diff --git a/src/openvpn/opt=
ions.c b/src/openvpn/options.c</span><br><span>index 1c35d67..eb0d9b5 10064=
4</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/ope=
nvpn/options.c</span><br><span>@@ -8659,9 +8659,9 @@</span><br><span>      =
           options-&gt;imported_protocol_flags |=3D CO_USE_DYNAMIC_TLS_CRYP=
T;</span><br><span>             }</span><br><span> #endif</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            else if (streq(p[j], &quot;=
aead-tag-end&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            else if (streq(p[j], &quot;aead-epoch&quot;))</span><br><span>=
             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         options-&gt;imported_protocol_flags |=3D CO_AEAD_TAG_AT_THE_END;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                optio=
ns-&gt;imported_protocol_flags |=3D CO_EPOCH_DATA_KEY_FORMAT;</span><br><sp=
an>             }</span><br><span>             else</span><br><span>       =
      {</span><br><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.=
c</span><br><span>index de44eb2..a7cd3bf 100644</span><br><span>--- a/src/o=
penvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -=
689,9 +689,9 @@</span><br><span>         buf_printf(&amp;proto_flags, &quot=
; dyn-tls-crypt&quot;);</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;imported_protocol_=
flags &amp; CO_AEAD_TAG_AT_THE_END)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (o-&gt;imported_protocol_flags &amp; CO_EPOCH_DATA_K=
EY_FORMAT)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        buf_printf(&amp;proto_flags, &quot; aead-tag-end&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf=
(&amp;proto_flags, &quot; aead-epoch&quot;);</span><br><span>     }</span><=
br><span> </span><br><span>     if (buf_len(&amp;proto_flags) &gt; 0)</span=
><br><span>diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h</span><br><sp=
an>index 3561c41..c32cb6c 100644</span><br><span>--- a/src/openvpn/ssl.h</s=
pan><br><span>+++ b/src/openvpn/ssl.h</span><br><span>@@ -108,6 +108,9 @@</=
span><br><span> /** Support to dynamic tls-crypt (renegotiation with TLS-EK=
M derived tls-crypt key) */</span><br><span> #define IV_PROTO_DYN_TLS_CRYPT=
   (1&lt;&lt;9)</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/** Support the extended packet id and epoch format for data =
channel packets */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define IV_PROTO_DATA_EPOCH      (1&lt;&lt;10)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> /** Supports the --dns option a=
fter all the incompatible changes */</span><br><span> #define IV_PROTO_DNS_=
OPTION_V2   (1&lt;&lt;11)</span><br><span> </span><br><span>diff --git a/te=
sts/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c</sp=
an><br><span>index caacd9e..845ca56 100644</span><br><span>--- a/tests/unit=
_tests/openvpn/test_ssl.c</span><br><span>+++ b/tests/unit_tests/openvpn/te=
st_ssl.c</span><br><span>@@ -404,7 +404,7 @@</span><br><span> run_data_chan=
nel_with_cipher_end(const char *cipher)</span><br><span> {</span><br><span>=
     struct crypto_options co =3D init_crypto_options(cipher, &quot;none&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    co.flags |=
=3D CO_AEAD_TAG_AT_THE_END;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    co.flags |=3D CO_EPOCH_DATA_KEY_FORMAT;</span><br><span>     do=
_data_channel_round_trip(&amp;co);</span><br><span>     uninit_crypto_optio=
ns(&amp;co);</span><br><span> }</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/805?usp=3Demail">c=
hange 805</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/805?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--3J1xNDFECFc=--

