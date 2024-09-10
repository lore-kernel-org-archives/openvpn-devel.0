From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 10 Sep 2024 12:53:54 +0000
In-Reply-To: <gerrit.1683717398000.I6818b153bdeb1eed65870af99b0531e95807fe0f@...2715...>
References: <gerrit.1683717398000.I6818b153bdeb1eed65870af99b0531e95807fe0f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4106aa21379b20ae744b3cae36b6eed1fee7a398-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZdOnqG7L68c="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Various fixes for
 -Wconversion errors
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

--ZdOnqG7L68c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#7) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/267?usp=3Demail )


Change subject: Various fixes for -Wconversion errors
......................................................................

Various fixes for -Wconversion errors

These are all fixes I considered "safe". They either

- Have sufficient checks/shifts for a cast to be safe
- Fix the type of a variable without requiring code changes
- Are in non-critical unittest code

v2:
 - add min_size instead of abusing min_int
v6:
 - remove change of return value of link_socket_write.
   Move to separate patch.

Change-Id: I6818b153bdeb1eed65870af99b0531e95807fe0f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne@...1227...>
Message-Id: <20240910122008.23507-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
172.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/buffer.c
M src/openvpn/crypto.c
M src/openvpn/integer.h
M src/openvpn/mss.c
M src/openvpn/otime.c
M src/openvpn/otime.h
M src/openvpn/packet_id.c
M src/openvpn/reliable.c
M src/openvpn/tls_crypt.c
M src/openvpn/xkey_helper.c
M tests/unit_tests/openvpn/mock_get_random.c
M tests/unit_tests/openvpn/test_crypto.c
M tests/unit_tests/openvpn/test_packet_id.c
M tests/unit_tests/openvpn/test_provider.c
M tests/unit_tests/openvpn/test_tls_crypt.c
15 files changed, 48 insertions(+), 34 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/267/7

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index abe6a9c..9ee76aa 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -326,7 +326,7 @@
         return false;
     }

-    const int size =3D write(fd, BPTR(buf), BLEN(buf));
+    const ssize_t size =3D write(fd, BPTR(buf), BLEN(buf));
     if (size !=3D BLEN(buf))
     {
         msg(M_ERRNO, "Write error on file '%s'", filename);
@@ -863,7 +863,7 @@
         {
             break;
         }
-        line[n++] =3D c;
+        line[n++] =3D (char)c;
     }
     while (c);

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index c226727..12ad0b9 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -26,6 +26,8 @@
 #include "config.h"
 #endif

+#include <inttypes.h>
+
 #include "syshead.h"
 #include <string.h>

@@ -1283,8 +1285,8 @@
                     hex_byte[hb_index++] =3D c;
                     if (hb_index =3D=3D 2)
                     {
-                        unsigned int u;
-                        ASSERT(sscanf((const char *)hex_byte, "%x", &u) =
=3D=3D 1);
+                        uint8_t u;
+                        ASSERT(sscanf((const char *)hex_byte, "%" SCNx8, &=
u) =3D=3D 1);
                         *out++ =3D u;
                         hb_index =3D 0;
                         if (++count =3D=3D keylen)
@@ -1546,13 +1548,13 @@
     ASSERT(cipher_kt_key_size(kt->cipher) <=3D MAX_CIPHER_KEY_LENGTH
            && md_kt_size(kt->digest) <=3D MAX_HMAC_KEY_LENGTH);

-    const uint8_t cipher_length =3D cipher_kt_key_size(kt->cipher);
+    const uint8_t cipher_length =3D (uint8_t)cipher_kt_key_size(kt->cipher=
);
     if (!buf_write(buf, &cipher_length, 1))
     {
         return false;
     }

-    uint8_t hmac_length =3D md_kt_size(kt->digest);
+    uint8_t hmac_length =3D (uint8_t)md_kt_size(kt->digest);

     if (!buf_write(buf, &hmac_length, 1))
     {
diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index a1acaf9..34088ab 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -28,12 +28,12 @@

 #ifndef htonll
 #define htonll(x) ((1=3D=3Dhtonl(1)) ? (x) : \
-                   ((uint64_t)htonl((x) & 0xFFFFFFFF) << 32) | htonl((x) >=
> 32))
+                   ((uint64_t)htonl((uint32_t)((x) & 0xFFFFFFFF)) << 32) |=
 htonl((uint32_t)((x) >> 32)))
 #endif

 #ifndef ntohll
 #define ntohll(x) ((1=3D=3Dntohl(1)) ? (x) : \
-                   ((uint64_t)ntohl((x) & 0xFFFFFFFF) << 32) | ntohl((x) >=
> 32))
+                   ((uint64_t)ntohl((uint32_t)((x) & 0xFFFFFFFF)) << 32) |=
 ntohl((uint32_t)((x) >> 32)))
 #endif

 static inline int
@@ -72,6 +72,19 @@
     }
 }

+static inline size_t
+min_size(size_t x, size_t y)
+{
+    if (x < y)
+    {
+        return x;
+    }
+    else
+    {
+        return y;
+    }
+}
+
 static inline int
 max_int(int x, int y)
 {
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 635557c..ebdec25 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -165,7 +165,7 @@
         return;
     }

-    for (olen =3D hlen - sizeof(struct openvpn_tcphdr),
+    for (olen =3D hlen - (int) sizeof(struct openvpn_tcphdr),
          opt =3D (uint8_t *)(tc + 1);
          olen > 1;
          olen -=3D optlen, opt +=3D optlen)
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index 3cde574..d77c99e 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -105,7 +105,7 @@
 /* format a time_t as ascii, or use current time if 0 */

 const char *
-time_string(time_t t, int usec, bool show_usec, struct gc_arena *gc)
+time_string(time_t t, long usec, bool show_usec, struct gc_arena *gc)
 {
     struct buffer out =3D alloc_buf_gc(64, gc);
     struct timeval tv;
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index c37673e..9543732 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -43,7 +43,7 @@
 bool frequency_limit_event_allowed(struct frequency_limit *f);

 /* format a time_t as ascii, or use current time if 0 */
-const char *time_string(time_t t, int usec, bool show_usec, struct gc_aren=
a *gc);
+const char *time_string(time_t t, long usec, bool show_usec, struct gc_are=
na *gc);

 /* struct timeval functions */

diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index be28999..fb962e4 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -588,14 +588,14 @@
         }
         else
         {
-            diff =3D (int) prev_now - v;
+            diff =3D (int)(prev_now - v);
             if (diff < 0)
             {
                 c =3D 'N';
             }
             else if (diff < 10)
             {
-                c =3D '0' + diff;
+                c =3D (char)('0' + diff);
             }
             else
             {
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index a789990..019ec18 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -257,8 +257,7 @@
                    struct buffer *buf,
                    const struct session_id *sid, int max, bool prepend)
 {
-    int i, j;
-    uint8_t n;
+    int i, j, n;
     struct buffer sub;

     n =3D ack->len;
@@ -270,9 +269,9 @@
     copy_acks_to_mru(ack, ack_mru, n);

     /* Number of acks we can resend that still fit into the packet */
-    uint8_t total_acks =3D min_int(max, ack_mru->len);
+    uint8_t total_acks =3D (uint8_t)min_int(max, ack_mru->len);

-    sub =3D buf_sub(buf, ACK_SIZE(total_acks), prepend);
+    sub =3D buf_sub(buf, (int)ACK_SIZE(total_acks), prepend);
     if (!BDEF(&sub))
     {
         goto error;
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 90fe6e9..b8894db 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -634,7 +634,7 @@
     memcpy(&net_len, BEND(&wrapped_client_key) - sizeof(net_len),
            sizeof(net_len));

-    size_t wkc_len =3D ntohs(net_len);
+    uint16_t wkc_len =3D ntohs(net_len);
     if (!buf_advance(&wrapped_client_key, BLEN(&wrapped_client_key) - wkc_=
len))
     {
         msg(D_TLS_ERRORS, "Can not locate tls-crypt-v2 client key");
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index b68fb43..10cdc0b 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -292,7 +292,7 @@
  * @return              false on error, true  on success
  *
  * On return enc_len is  set to actual size of the result.
- * enc is NULL or enc_len is not enough to store the result, it is set
+ * If enc is NULL or enc_len is not enough to store the result, it is set
  * to the required size and false is returned.
  */
 bool
@@ -337,8 +337,8 @@
                         MAKE_DI(sha512), MAKE_DI(sha224), MAKE_DI(sha512_2=
24),
                         MAKE_DI(sha512_256), {0, NULL, 0}};

-    int out_len =3D 0;
-    int ret =3D 0;
+    size_t out_len =3D 0;
+    bool ret =3D false;

     int nid =3D OBJ_sn2nid(mdname);
     if (nid =3D=3D NID_undef)
@@ -354,7 +354,7 @@

     if (tbslen !=3D EVP_MD_size(EVP_get_digestbyname(mdname)))
     {
-        msg(M_WARN, "Error: encode_pkcs11: invalid input length <%d>", (in=
t)tbslen);
+        msg(M_WARN, "Error: encode_pkcs11: invalid input length <%zu>", tb=
slen);
         goto done;
     }

@@ -383,13 +383,13 @@

     out_len =3D tbslen + di->sz;

-    if (enc && (out_len <=3D (int) *enc_len))
+    if (enc && (out_len <=3D *enc_len))
     {
         /* combine header and digest */
         memcpy(enc, di->header, di->sz);
         memcpy(enc + di->sz, tbs, tbslen);
-        dmsg(D_XKEY, "encode_pkcs1: digest length =3D %d encoded length =
=3D %d",
-             (int) tbslen, (int) out_len);
+        dmsg(D_XKEY, "encode_pkcs1: digest length =3D %zu encoded length =
=3D %zu",
+             tbslen, out_len);
         ret =3D true;
     }

diff --git a/tests/unit_tests/openvpn/mock_get_random.c b/tests/unit_tests/=
openvpn/mock_get_random.c
index 787b5e3..dfc7287 100644
--- a/tests/unit_tests/openvpn/mock_get_random.c
+++ b/tests/unit_tests/openvpn/mock_get_random.c
@@ -41,6 +41,6 @@
 {
     for (int i =3D 0; i < len; i++)
     {
-        output[i] =3D rand();
+        output[i] =3D (uint8_t)rand();
     }
 }
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index 9d3ea1a..fdc8fbd 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -97,8 +97,8 @@

     for (int i =3D 0; i < strlen(ciphername); i++)
     {
-        upper[i] =3D toupper(ciphername[i]);
-        lower[i] =3D tolower(ciphername[i]);
+        upper[i] =3D (char)toupper((unsigned char)ciphername[i]);
+        lower[i] =3D (char)tolower((unsigned char)ciphername[i]);
         if (rand() & 0x1)
         {
             random_case[i] =3D upper[i];
@@ -155,7 +155,7 @@


     uint8_t out[32];
-    bool ret =3D ssl_tls1_PRF(seed, seed_len, secret, secret_len, out, siz=
eof(out));
+    bool ret =3D ssl_tls1_PRF(seed, (int)seed_len, secret, (int)secret_len=
, out, sizeof(out));

 #if defined(LIBRESSL_VERSION_NUMBER) || defined(ENABLE_CRYPTO_WOLFSSL)
     /* No TLS1 PRF support in these libraries */
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/o=
penvpn/test_packet_id.c
index ff3f788..a3567bc 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -93,7 +93,7 @@
     assert(data->pis.id =3D=3D 1);
     assert(data->pis.time =3D=3D now);
     assert_true(data->test_buf_data.buf_id =3D=3D htonl(1));
-    assert_true(data->test_buf_data.buf_time =3D=3D htonl(now));
+    assert_true(data->test_buf_data.buf_time =3D=3D htonl((uint32_t)now));
 }

 static void
@@ -120,7 +120,7 @@
     assert(data->pis.id =3D=3D 1);
     assert(data->pis.time =3D=3D now);
     assert_true(data->test_buf_data.buf_id =3D=3D htonl(1));
-    assert_true(data->test_buf_data.buf_time =3D=3D htonl(now));
+    assert_true(data->test_buf_data.buf_time =3D=3D htonl((uint32_t)now));
 }

 static void
@@ -151,7 +151,7 @@
     assert(data->pis.id =3D=3D 1);
     assert(data->pis.time =3D=3D now);
     assert_true(data->test_buf_data.buf_id =3D=3D htonl(1));
-    assert_true(data->test_buf_data.buf_time =3D=3D htonl(now));
+    assert_true(data->test_buf_data.buf_time =3D=3D htonl((uint32_t)now));
 }

 static void
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/op=
envpn/test_provider.c
index cfe9ac3..b92412d 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -368,7 +368,7 @@
     }

     /* return a predefined string as sig */
-    memcpy(sig, good_sig, min_int(sizeof(good_sig), *siglen));
+    memcpy(sig, good_sig, min_size(sizeof(good_sig), *siglen));

     return 1;
 }
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/o=
penvpn/test_tls_crypt.c
index a01fbe5..4f12f88 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -137,7 +137,7 @@
 {
     for (int i =3D 0; i < len; i++)
     {
-        output[i] =3D i;
+        output[i] =3D (uint8_t)i;
     }
     return true;
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/267?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6818b153bdeb1eed65870af99b0531e95807fe0f
Gerrit-Change-Number: 267
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--ZdOnqG7L68c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #7</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/267?usp=3Demail">View Change</a></p><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">Various fixes for -Wconversion errors<b=
r><br>These are all fixes I considered &quot;safe&quot;. They either<br><br=
>- Have sufficient checks/shifts for a cast to be safe<br>- Fix the type of=
 a variable without requiring code changes<br>- Are in non-critical unittes=
t code<br><br>v2:<br> - add min_size instead of abusing min_int<br>v6:<br> =
- remove change of return value of link_socket_write.<br>   Move to separat=
e patch.<br><br>Change-Id: I6818b153bdeb1eed65870af99b0531e95807fe0f<br>Sig=
ned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Sc=
hwabe &lt;arne@...1227...&gt;<br>Message-Id: &lt;20240910122008.23507-1-ger=
t@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1096...=
ourceforge.net/msg29172.html<br>Signed-off-by: Gert Doering &lt;gert@...1826...=
6...&gt;<br>---<br>M src/openvpn/buffer.c<br>M src/openvpn/crypto.c<br>M sr=
c/openvpn/integer.h<br>M src/openvpn/mss.c<br>M src/openvpn/otime.c<br>M sr=
c/openvpn/otime.h<br>M src/openvpn/packet_id.c<br>M src/openvpn/reliable.c<=
br>M src/openvpn/tls_crypt.c<br>M src/openvpn/xkey_helper.c<br>M tests/unit=
_tests/openvpn/mock_get_random.c<br>M tests/unit_tests/openvpn/test_crypto.=
c<br>M tests/unit_tests/openvpn/test_packet_id.c<br>M tests/unit_tests/open=
vpn/test_provider.c<br>M tests/unit_tests/openvpn/test_tls_crypt.c<br>15 fi=
les changed, 48 insertions(+), 34 deletions(-)<br><br></pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit.openvpn.net:29418/openvpn refs/changes/67/267/7</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/sr=
c/openvpn/buffer.c b/src/openvpn/buffer.c</span><br><span>index abe6a9c..9e=
e76aa 100644</span><br><span>--- a/src/openvpn/buffer.c</span><br><span>+++=
 b/src/openvpn/buffer.c</span><br><span>@@ -326,7 +326,7 @@</span><br><span=
>         return false;</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const int size =3D write(fd,=
 BPTR(buf), BLEN(buf));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const ssize_t size =3D write(fd, BPTR(buf), BLEN(buf));</span><br><=
span>     if (size !=3D BLEN(buf))</span><br><span>     {</span><br><span> =
        msg(M_ERRNO, &quot;Write error on file &#39;%s&#39;&quot;, filename=
);</span><br><span>@@ -863,7 +863,7 @@</span><br><span>         {</span><br=
><span>             break;</span><br><span>         }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        line[n++] =3D c;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        line[n++] =3D (char)c;</span><=
br><span>     }</span><br><span>     while (c);</span><br><span> </span><br=
><span>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><=
span>index c226727..12ad0b9 100644</span><br><span>--- a/src/openvpn/crypto=
.c</span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -26,6 +26,=
8 @@</span><br><span> #include &quot;config.h&quot;</span><br><span> #endif=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &lt;inttypes.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> #include &quot;syshead.h&quot;</span><br><span> #i=
nclude &lt;string.h&gt;</span><br><span> </span><br><span>@@ -1283,8 +1285,=
8 @@</span><br><span>                     hex_byte[hb_index++] =3D c;</span=
><br><span>                     if (hb_index =3D=3D 2)</span><br><span>    =
                 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                     unsigned int u;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                        ASSERT(sscanf((const char *)hex_byte=
, &quot;%x&quot;, &amp;u) =3D=3D 1);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                        uint8_t u;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        ASSERT(sscanf((co=
nst char *)hex_byte, &quot;%&quot; SCNx8, &amp;u) =3D=3D 1);</span><br><spa=
n>                         *out++ =3D u;</span><br><span>                  =
       hb_index =3D 0;</span><br><span>                         if (++count=
 =3D=3D keylen)</span><br><span>@@ -1546,13 +1548,13 @@</span><br><span>   =
  ASSERT(cipher_kt_key_size(kt-&gt;cipher) &lt;=3D MAX_CIPHER_KEY_LENGTH</s=
pan><br><span>            &amp;&amp; md_kt_size(kt-&gt;digest) &lt;=3D MAX_=
HMAC_KEY_LENGTH);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    const uint8_t cipher_length =3D cipher_kt_key_size(kt-&gt=
;cipher);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
uint8_t cipher_length =3D (uint8_t)cipher_kt_key_size(kt-&gt;cipher);</span=
><br><span>     if (!buf_write(buf, &amp;cipher_length, 1))</span><br><span=
>     {</span><br><span>         return false;</span><br><span>     }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8=
_t hmac_length =3D md_kt_size(kt-&gt;digest);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    uint8_t hmac_length =3D (uint8_t)md_kt_size(k=
t-&gt;digest);</span><br><span> </span><br><span>     if (!buf_write(buf, &=
amp;hmac_length, 1))</span><br><span>     {</span><br><span>diff --git a/sr=
c/openvpn/integer.h b/src/openvpn/integer.h</span><br><span>index a1acaf9..=
34088ab 100644</span><br><span>--- a/src/openvpn/integer.h</span><br><span>=
+++ b/src/openvpn/integer.h</span><br><span>@@ -28,12 +28,12 @@</span><br><=
span> </span><br><span> #ifndef htonll</span><br><span> #define htonll(x) (=
(1=3D=3Dhtonl(1)) ? (x) : \</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                   ((uint64_t)htonl((x) &amp; 0xFFFFFFFF) &lt;&lt; 32=
) | htonl((x) &gt;&gt; 32))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                   ((uint64_t)htonl((uint32_t)((x) &amp; 0xFFFFFFFF=
)) &lt;&lt; 32) | htonl((uint32_t)((x) &gt;&gt; 32)))</span><br><span> #end=
if</span><br><span> </span><br><span> #ifndef ntohll</span><br><span> #defi=
ne ntohll(x) ((1=3D=3Dntohl(1)) ? (x) : \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                   ((uint64_t)ntohl((x) &amp; 0xFFFFFFF=
F) &lt;&lt; 32) | ntohl((x) &gt;&gt; 32))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                   ((uint64_t)ntohl((uint32_t)((x) &a=
mp; 0xFFFFFFFF)) &lt;&lt; 32) | ntohl((uint32_t)((x) &gt;&gt; 32)))</span><=
br><span> #endif</span><br><span> </span><br><span> static inline int</span=
><br><span>@@ -72,6 +72,19 @@</span><br><span>     }</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c inline size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+min_=
size(size_t x, size_t y)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (x &lt=
; y)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return x;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return y;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static inli=
ne int</span><br><span> max_int(int x, int y)</span><br><span> {</span><br>=
<span>diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c</span><br><span>in=
dex 635557c..ebdec25 100644</span><br><span>--- a/src/openvpn/mss.c</span><=
br><span>+++ b/src/openvpn/mss.c</span><br><span>@@ -165,7 +165,7 @@</span>=
<br><span>         return;</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    for (olen =3D hlen - size=
of(struct openvpn_tcphdr),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    for (olen =3D hlen - (int) sizeof(struct openvpn_tcphdr),</span>=
<br><span>          opt =3D (uint8_t *)(tc + 1);</span><br><span>          =
olen &gt; 1;</span><br><span>          olen -=3D optlen, opt +=3D optlen)</=
span><br><span>diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c</span=
><br><span>index 3cde574..d77c99e 100644</span><br><span>--- a/src/openvpn/=
otime.c</span><br><span>+++ b/src/openvpn/otime.c</span><br><span>@@ -105,7=
 +105,7 @@</span><br><span> /* format a time_t as ascii, or use current tim=
e if 0 */</span><br><span> </span><br><span> const char *</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-time_string(time_t t, int usec, bool sh=
ow_usec, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+time_string(time_t t, long usec, bool show_usec, struct gc_arena =
*gc)</span><br><span> {</span><br><span>     struct buffer out =3D alloc_bu=
f_gc(64, gc);</span><br><span>     struct timeval tv;</span><br><span>diff =
--git a/src/openvpn/otime.h b/src/openvpn/otime.h</span><br><span>index c37=
673e..9543732 100644</span><br><span>--- a/src/openvpn/otime.h</span><br><s=
pan>+++ b/src/openvpn/otime.h</span><br><span>@@ -43,7 +43,7 @@</span><br><=
span> bool frequency_limit_event_allowed(struct frequency_limit *f);</span>=
<br><span> </span><br><span> /* format a time_t as ascii, or use current ti=
me if 0 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-const char =
*time_string(time_t t, int usec, bool show_usec, struct gc_arena *gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *time_string(=
time_t t, long usec, bool show_usec, struct gc_arena *gc);</span><br><span>=
 </span><br><span> /* struct timeval functions */</span><br><span> </span><=
br><span>diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c</sp=
an><br><span>index be28999..fb962e4 100644</span><br><span>--- a/src/openvp=
n/packet_id.c</span><br><span>+++ b/src/openvpn/packet_id.c</span><br><span=
>@@ -588,14 +588,14 @@</span><br><span>         }</span><br><span>         =
else</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            diff =3D (int) prev_now - v;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            diff =3D (int)(prev_now - v);</s=
pan><br><span>             if (diff &lt; 0)</span><br><span>             {<=
/span><br><span>                 c =3D &#39;N&#39;;</span><br><span>       =
      }</span><br><span>             else if (diff &lt; 10)</span><br><span=
>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          c =3D &#39;0&#39; + diff;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                c =3D (char)(&#39;0&#39; + diff);</span><br=
><span>             }</span><br><span>             else</span><br><span>   =
          {</span><br><span>diff --git a/src/openvpn/reliable.c b/src/openv=
pn/reliable.c</span><br><span>index a789990..019ec18 100644</span><br><span=
>--- a/src/openvpn/reliable.c</span><br><span>+++ b/src/openvpn/reliable.c<=
/span><br><span>@@ -257,8 +257,7 @@</span><br><span>                    str=
uct buffer *buf,</span><br><span>                    const struct session_i=
d *sid, int max, bool prepend)</span><br><span> {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    int i, j;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    uint8_t n;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int i, j, n;</span><br><span>     struct buffer sub;</sp=
an><br><span> </span><br><span>     n =3D ack-&gt;len;</span><br><span>@@ -=
270,9 +269,9 @@</span><br><span>     copy_acks_to_mru(ack, ack_mru, n);</sp=
an><br><span> </span><br><span>     /* Number of acks we can resend that st=
ill fit into the packet */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    uint8_t total_acks =3D min_int(max, ack_mru-&gt;len);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    uint8_t total_acks =3D (uint=
8_t)min_int(max, ack_mru-&gt;len);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    sub =3D buf_sub(buf, ACK_SIZE(total_ack=
s), prepend);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    su=
b =3D buf_sub(buf, (int)ACK_SIZE(total_acks), prepend);</span><br><span>   =
  if (!BDEF(&amp;sub))</span><br><span>     {</span><br><span>         goto=
 error;</span><br><span>diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/=
tls_crypt.c</span><br><span>index 90fe6e9..b8894db 100644</span><br><span>-=
-- a/src/openvpn/tls_crypt.c</span><br><span>+++ b/src/openvpn/tls_crypt.c<=
/span><br><span>@@ -634,7 +634,7 @@</span><br><span>     memcpy(&amp;net_le=
n, BEND(&amp;wrapped_client_key) - sizeof(net_len),</span><br><span>       =
     sizeof(net_len));</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    size_t wkc_len =3D ntohs(net_len);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    uint16_t wkc_len =3D ntohs(net_le=
n);</span><br><span>     if (!buf_advance(&amp;wrapped_client_key, BLEN(&am=
p;wrapped_client_key) - wkc_len))</span><br><span>     {</span><br><span>  =
       msg(D_TLS_ERRORS, &quot;Can not locate tls-crypt-v2 client key&quot;=
);</span><br><span>diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xke=
y_helper.c</span><br><span>index b68fb43..10cdc0b 100644</span><br><span>--=
- a/src/openvpn/xkey_helper.c</span><br><span>+++ b/src/openvpn/xkey_helper=
.c</span><br><span>@@ -292,7 +292,7 @@</span><br><span>  * @return         =
     false on error, true  on success</span><br><span>  *</span><br><span> =
 * On return enc_len is  set to actual size of the result.</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * enc is NULL or enc_len is not enoug=
h to store the result, it is set</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * If enc is NULL or enc_len is not enough to store the result=
, it is set</span><br><span>  * to the required size and false is returned.=
</span><br><span>  */</span><br><span> bool</span><br><span>@@ -337,8 +337,=
8 @@</span><br><span>                         MAKE_DI(sha512), MAKE_DI(sha2=
24), MAKE_DI(sha512_224),</span><br><span>                         MAKE_DI(=
sha512_256), {0, NULL, 0}};</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    int out_len =3D 0;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    int ret =3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    size_t out_len =3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    bool ret =3D false;</span><br><span> </sp=
an><br><span>     int nid =3D OBJ_sn2nid(mdname);</span><br><span>     if (=
nid =3D=3D NID_undef)</span><br><span>@@ -354,7 +354,7 @@</span><br><span> =
</span><br><span>     if (tbslen !=3D EVP_MD_size(EVP_get_digestbyname(mdna=
me)))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        msg(M_WARN, &quot;Error: encode_pkcs11: invalid input length=
 &lt;%d&gt;&quot;, (int)tbslen);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(M_WARN, &quot;Error: encode_pkcs11: invalid input =
length &lt;%zu&gt;&quot;, tbslen);</span><br><span>         goto done;</spa=
n><br><span>     }</span><br><span> </span><br><span>@@ -383,13 +383,13 @@<=
/span><br><span> </span><br><span>     out_len =3D tbslen + di-&gt;sz;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
enc &amp;&amp; (out_len &lt;=3D (int) *enc_len))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (enc &amp;&amp; (out_len &lt;=3D *enc_l=
en))</span><br><span>     {</span><br><span>         /* combine header and =
digest */</span><br><span>         memcpy(enc, di-&gt;header, di-&gt;sz);</=
span><br><span>         memcpy(enc + di-&gt;sz, tbs, tbslen);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        dmsg(D_XKEY, &quot;encode_p=
kcs1: digest length =3D %d encoded length =3D %d&quot;,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-             (int) tbslen, (int) out_len)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dmsg(D_XKE=
Y, &quot;encode_pkcs1: digest length =3D %zu encoded length =3D %zu&quot;,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+             tbslen,=
 out_len);</span><br><span>         ret =3D true;</span><br><span>     }</s=
pan><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/mock_=
get_random.c b/tests/unit_tests/openvpn/mock_get_random.c</span><br><span>i=
ndex 787b5e3..dfc7287 100644</span><br><span>--- a/tests/unit_tests/openvpn=
/mock_get_random.c</span><br><span>+++ b/tests/unit_tests/openvpn/mock_get_=
random.c</span><br><span>@@ -41,6 +41,6 @@</span><br><span> {</span><br><sp=
an>     for (int i =3D 0; i &lt; len; i++)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        output[i] =3D rand();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        output[i] =3D=
 (uint8_t)rand();</span><br><span>     }</span><br><span> }</span><br><span=
>diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/ope=
nvpn/test_crypto.c</span><br><span>index 9d3ea1a..fdc8fbd 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/test_crypto.c</span><br><span>+++ b/te=
sts/unit_tests/openvpn/test_crypto.c</span><br><span>@@ -97,8 +97,8 @@</spa=
n><br><span> </span><br><span>     for (int i =3D 0; i &lt; strlen(cipherna=
me); i++)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        upper[i] =3D toupper(ciphername[i]);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        lower[i] =3D tolower(ciphername[i=
]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        upper[i]=
 =3D (char)toupper((unsigned char)ciphername[i]);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        lower[i] =3D (char)tolower((unsigned =
char)ciphername[i]);</span><br><span>         if (rand() &amp; 0x1)</span><=
br><span>         {</span><br><span>             random_case[i] =3D upper[i=
];</span><br><span>@@ -155,7 +155,7 @@</span><br><span> </span><br><span> <=
/span><br><span>     uint8_t out[32];</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    bool ret =3D ssl_tls1_PRF(seed, seed_len, secret, secre=
t_len, out, sizeof(out));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    bool ret =3D ssl_tls1_PRF(seed, (int)seed_len, secret, (int)secre=
t_len, out, sizeof(out));</span><br><span> </span><br><span> #if defined(LI=
BRESSL_VERSION_NUMBER) || defined(ENABLE_CRYPTO_WOLFSSL)</span><br><span>  =
   /* No TLS1 PRF support in these libraries */</span><br><span>diff --git =
a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test=
_packet_id.c</span><br><span>index ff3f788..a3567bc 100644</span><br><span>=
--- a/tests/unit_tests/openvpn/test_packet_id.c</span><br><span>+++ b/tests=
/unit_tests/openvpn/test_packet_id.c</span><br><span>@@ -93,7 +93,7 @@</spa=
n><br><span>     assert(data-&gt;pis.id =3D=3D 1);</span><br><span>     ass=
ert(data-&gt;pis.time =3D=3D now);</span><br><span>     assert_true(data-&g=
t;test_buf_data.buf_id =3D=3D htonl(1));</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    assert_true(data-&gt;test_buf_data.buf_time =3D=3D h=
tonl(now));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(data-&gt;test_buf_data.buf_time =3D=3D htonl((uint32_t)now));</span=
><br><span> }</span><br><span> </span><br><span> static void</span><br><spa=
n>@@ -120,7 +120,7 @@</span><br><span>     assert(data-&gt;pis.id =3D=3D 1)=
;</span><br><span>     assert(data-&gt;pis.time =3D=3D now);</span><br><spa=
n>     assert_true(data-&gt;test_buf_data.buf_id =3D=3D htonl(1));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(data-&gt;test_=
buf_data.buf_time =3D=3D htonl(now));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(data-&gt;test_buf_data.buf_time =3D=3D ht=
onl((uint32_t)now));</span><br><span> }</span><br><span> </span><br><span> =
static void</span><br><span>@@ -151,7 +151,7 @@</span><br><span>     assert=
(data-&gt;pis.id =3D=3D 1);</span><br><span>     assert(data-&gt;pis.time =
=3D=3D now);</span><br><span>     assert_true(data-&gt;test_buf_data.buf_id=
 =3D=3D htonl(1));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 assert_true(data-&gt;test_buf_data.buf_time =3D=3D htonl(now));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(data-&gt;test_=
buf_data.buf_time =3D=3D htonl((uint32_t)now));</span><br><span> }</span><b=
r><span> </span><br><span> static void</span><br><span>diff --git a/tests/u=
nit_tests/openvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.=
c</span><br><span>index cfe9ac3..b92412d 100644</span><br><span>--- a/tests=
/unit_tests/openvpn/test_provider.c</span><br><span>+++ b/tests/unit_tests/=
openvpn/test_provider.c</span><br><span>@@ -368,7 +368,7 @@</span><br><span=
>     }</span><br><span> </span><br><span>     /* return a predefined strin=
g as sig */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    memcpy=
(sig, good_sig, min_int(sizeof(good_sig), *siglen));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    memcpy(sig, good_sig, min_size(sizeof=
(good_sig), *siglen));</span><br><span> </span><br><span>     return 1;</sp=
an><br><span> }</span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><span>ind=
ex a01fbe5..4f12f88 100644</span><br><span>--- a/tests/unit_tests/openvpn/t=
est_tls_crypt.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_tls_cry=
pt.c</span><br><span>@@ -137,7 +137,7 @@</span><br><span> {</span><br><span=
>     for (int i =3D 0; i &lt; len; i++)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        output[i] =3D i;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        output[i] =3D (uint8=
_t)i;</span><br><span>     }</span><br><span>     return true;</span><br><s=
pan> }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/267?usp=3Demail">change 267</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/267?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6818b153bdeb1eed65870af99b0=
531e95807fe0f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 267 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--ZdOnqG7L68c=--

