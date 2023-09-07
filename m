From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 7 Sep 2023 08:45:05 +0000
References: <gerrit.1683717398000.I6818b153bdeb1eed65870af99b0531e95807fe0f@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ad9791782ef350f0ae650b4f8dec08c96299acf1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MwHpnSXOx00="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--MwHpnSXOx00=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/267?usp=3Demail

to review the following change.


Change subject: Various fixes for -Wconversion errors
......................................................................

Various fixes for -Wconversion errors

These are all fixes I considered "safe". They either

- Have sufficient checks/shifts for a cast to be safe
- Fix the type of a variable without requiring code changes
- Are in non-critical unittest code

v2:
 - add min_size instead of abusing min_int

Change-Id: I6818b153bdeb1eed65870af99b0531e95807fe0f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/buffer.c
M src/openvpn/crypto.c
M src/openvpn/integer.h
M src/openvpn/mss.c
M src/openvpn/otime.c
M src/openvpn/otime.h
M src/openvpn/packet_id.c
M src/openvpn/reliable.c
M src/openvpn/socket.h
M src/openvpn/tls_crypt.c
M src/openvpn/xkey_helper.c
M tests/unit_tests/openvpn/mock_get_random.c
M tests/unit_tests/openvpn/test_crypto.c
M tests/unit_tests/openvpn/test_packet_id.c
M tests/unit_tests/openvpn/test_provider.c
M tests/unit_tests/openvpn/test_tls_crypt.c
16 files changed, 50 insertions(+), 36 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/267/3

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 24f1ef2..a32e7d2 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -352,7 +352,7 @@
         return false;
     }

-    const int size =3D write(fd, BPTR(buf), BLEN(buf));
+    const ssize_t size =3D write(fd, BPTR(buf), BLEN(buf));
     if (size !=3D BLEN(buf))
     {
         msg(M_ERRNO, "Write error on file '%s'", filename);
@@ -889,7 +889,7 @@
         {
             break;
         }
-        line[n++] =3D c;
+        line[n++] =3D (char)c;
     }
     while (c);

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index a77b5a1..3152060 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -26,6 +26,8 @@
 #include "config.h"
 #endif

+#include <inttypes.h>
+
 #include "syshead.h"

 #include "crypto.h"
@@ -1275,8 +1277,8 @@
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
@@ -1538,13 +1540,13 @@
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
index 215c159..30b9ecf 100644
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

 /*
@@ -65,6 +65,19 @@
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
index 816e65b..dbd3681 100644
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
index b28a90f..e751246 100644
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
index c27be89..d795c3c 100644
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
index ef83248..3d6f3ee 100644
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
index e7d4d5f..0e26f98 100644
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
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index bfc1253..a4acc5d 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -1181,7 +1181,7 @@
 }

 /* write a TCP or UDP packet to link */
-static inline int
+static inline size_t
 link_socket_write(struct link_socket *sock,
                   struct buffer *buf,
                   struct link_socket_actual *to)
@@ -1198,7 +1198,7 @@
     else
     {
         ASSERT(0);
-        return -1; /* NOTREACHED */
+        return 0; /* NOTREACHED */
     }
 }

diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 975d31f..f0946cb 100644
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
index 40839f2..fcf8c2e 100644
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
index 58eebc0..d765a4e 100644
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
@@ -160,7 +160,7 @@


     uint8_t out[32];
-    ssl_tls1_PRF(seed, seed_len, secret, secret_len, out, sizeof(out));
+    ssl_tls1_PRF(seed, (int)seed_len, secret, (int)secret_len, out, sizeof=
(out));

     assert_memory_equal(good_prf, out, sizeof(out));
 }
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/o=
penvpn/test_packet_id.c
index 90c67ac..c351858 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -94,7 +94,7 @@
     assert(data->pis.id =3D=3D 1);
     assert(data->pis.time =3D=3D now);
     assert_true(data->test_buf_data.buf_id =3D=3D htonl(1));
-    assert_true(data->test_buf_data.buf_time =3D=3D htonl(now));
+    assert_true(data->test_buf_data.buf_time =3D=3D htonl((uint32_t)now));
 }

 static void
@@ -121,7 +121,7 @@
     assert(data->pis.id =3D=3D 1);
     assert(data->pis.time =3D=3D now);
     assert_true(data->test_buf_data.buf_id =3D=3D htonl(1));
-    assert_true(data->test_buf_data.buf_time =3D=3D htonl(now));
+    assert_true(data->test_buf_data.buf_time =3D=3D htonl((uint32_t)now));
 }

 static void
@@ -152,7 +152,7 @@
     assert(data->pis.id =3D=3D 1);
     assert(data->pis.time =3D=3D now);
     assert_true(data->test_buf_data.buf_id =3D=3D htonl(1));
-    assert_true(data->test_buf_data.buf_time =3D=3D htonl(now));
+    assert_true(data->test_buf_data.buf_time =3D=3D htonl((uint32_t)now));
 }

 static void
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/op=
envpn/test_provider.c
index 335fca2..5e57f33 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -365,7 +365,7 @@
     }

     /* return a predefined string as sig */
-    memcpy(sig, good_sig, min_int(sizeof(good_sig), *siglen));
+    memcpy(sig, good_sig, min_size(sizeof(good_sig), *siglen));

     return 1;
 }
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/o=
penvpn/test_tls_crypt.c
index ed7c794..3b885ab 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -138,7 +138,7 @@
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
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--MwHpnSXOx00=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/267?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Various fixes for -Wconversion errors<br><br>These are all fi=
xes I considered &quot;safe&quot;. They either<br><br>- Have sufficient che=
cks/shifts for a cast to be safe<br>- Fix the type of a variable without re=
quiring code changes<br>- Are in non-critical unittest code<br><br>v2:<br> =
- add min_size instead of abusing min_int<br><br>Change-Id: I6818b153bdeb1e=
ed65870af99b0531e95807fe0f<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1186...=
.2641...&gt;<br>---<br>M src/openvpn/buffer.c<br>M src/openvpn/crypto.c<br>=
M src/openvpn/integer.h<br>M src/openvpn/mss.c<br>M src/openvpn/otime.c<br>=
M src/openvpn/otime.h<br>M src/openvpn/packet_id.c<br>M src/openvpn/reliabl=
e.c<br>M src/openvpn/socket.h<br>M src/openvpn/tls_crypt.c<br>M src/openvpn=
/xkey_helper.c<br>M tests/unit_tests/openvpn/mock_get_random.c<br>M tests/u=
nit_tests/openvpn/test_crypto.c<br>M tests/unit_tests/openvpn/test_packet_i=
d.c<br>M tests/unit_tests/openvpn/test_provider.c<br>M tests/unit_tests/ope=
nvpn/test_tls_crypt.c<br>16 files changed, 50 insertions(+), 36 deletions(-=
)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67=
/267/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</sp=
an><br><span>index 24f1ef2..a32e7d2 100644</span><br><span>--- a/src/openvp=
n/buffer.c</span><br><span>+++ b/src/openvpn/buffer.c</span><br><span>@@ -3=
52,7 +352,7 @@</span><br><span>         return false;</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  const int size =3D write(fd, BPTR(buf), BLEN(buf));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const ssize_t size =3D write(fd, BPTR=
(buf), BLEN(buf));</span><br><span>     if (size !=3D BLEN(buf))</span><br>=
<span>     {</span><br><span>         msg(M_ERRNO, &quot;Write error on fil=
e &#39;%s&#39;&quot;, filename);</span><br><span>@@ -889,7 +889,7 @@</span>=
<br><span>         {</span><br><span>             break;</span><br><span>  =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        line[=
n++] =3D c;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
line[n++] =3D (char)c;</span><br><span>     }</span><br><span>     while (c=
);</span><br><span> </span><br><span>diff --git a/src/openvpn/crypto.c b/sr=
c/openvpn/crypto.c</span><br><span>index a77b5a1..3152060 100644</span><br>=
<span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn/crypto.c=
</span><br><span>@@ -26,6 +26,8 @@</span><br><span> #include &quot;config.h=
&quot;</span><br><span> #endif</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &lt;inttypes.h&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #include &quot;syshe=
ad.h&quot;</span><br><span> </span><br><span> #include &quot;crypto.h&quot;=
</span><br><span>@@ -1275,8 +1277,8 @@</span><br><span>                    =
 hex_byte[hb_index++] =3D c;</span><br><span>                     if (hb_in=
dex =3D=3D 2)</span><br><span>                     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        unsigned int u;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                        A=
SSERT(sscanf((const char *)hex_byte, &quot;%x&quot;, &amp;u) =3D=3D 1);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
 uint8_t u;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                ASSERT(sscanf((const char *)hex_byte, &quot;%&quot; SCNx8, =
&amp;u) =3D=3D 1);</span><br><span>                         *out++ =3D u;</=
span><br><span>                         hb_index =3D 0;</span><br><span>   =
                      if (++count =3D=3D keylen)</span><br><span>@@ -1538,1=
3 +1540,13 @@</span><br><span>     ASSERT(cipher_kt_key_size(kt-&gt;cipher)=
 &lt;=3D MAX_CIPHER_KEY_LENGTH</span><br><span>            &amp;&amp; md_kt=
_size(kt-&gt;digest) &lt;=3D MAX_HMAC_KEY_LENGTH);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    const uint8_t cipher_len=
gth =3D cipher_kt_key_size(kt-&gt;cipher);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const uint8_t cipher_length =3D (uint8_t)cipher_=
kt_key_size(kt-&gt;cipher);</span><br><span>     if (!buf_write(buf, &amp;c=
ipher_length, 1))</span><br><span>     {</span><br><span>         return fa=
lse;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    uint8_t hmac_length =3D md_kt_size(kt-&gt;diges=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t hmac=
_length =3D (uint8_t)md_kt_size(kt-&gt;digest);</span><br><span> </span><br=
><span>     if (!buf_write(buf, &amp;hmac_length, 1))</span><br><span>     =
{</span><br><span>diff --git a/src/openvpn/integer.h b/src/openvpn/integer.=
h</span><br><span>index 215c159..30b9ecf 100644</span><br><span>--- a/src/o=
penvpn/integer.h</span><br><span>+++ b/src/openvpn/integer.h</span><br><spa=
n>@@ -28,12 +28,12 @@</span><br><span> </span><br><span> #ifndef htonll</sp=
an><br><span> #define htonll(x) ((1=3D=3Dhtonl(1)) ? (x) : \</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                   ((uint64_t)htonl(=
(x) &amp; 0xFFFFFFFF) &lt;&lt; 32) | htonl((x) &gt;&gt; 32))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                   ((uint64_t)hton=
l((uint32_t)((x) &amp; 0xFFFFFFFF)) &lt;&lt; 32) | htonl((uint32_t)((x) &gt=
;&gt; 32)))</span><br><span> #endif</span><br><span> </span><br><span> #ifn=
def ntohll</span><br><span> #define ntohll(x) ((1=3D=3Dntohl(1)) ? (x) : \<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   ((u=
int64_t)ntohl((x) &amp; 0xFFFFFFFF) &lt;&lt; 32) | ntohl((x) &gt;&gt; 32))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   (=
(uint64_t)ntohl((uint32_t)((x) &amp; 0xFFFFFFFF)) &lt;&lt; 32) | ntohl((uin=
t32_t)((x) &gt;&gt; 32)))</span><br><span> #endif</span><br><span> </span><=
br><span> /*</span><br><span>@@ -65,6 +65,19 @@</span><br><span>     }</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static inline size_t</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+min_size(size_t x, size_t y)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (x &lt; y)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn x;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return y;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> static inline int</span><br><span> max_int(int x, int y)</span><br><=
span> {</span><br><span>diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c<=
/span><br><span>index 816e65b..dbd3681 100644</span><br><span>--- a/src/ope=
nvpn/mss.c</span><br><span>+++ b/src/openvpn/mss.c</span><br><span>@@ -165,=
7 +165,7 @@</span><br><span>         return;</span><br><span>     }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (ol=
en =3D hlen - sizeof(struct openvpn_tcphdr),</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    for (olen =3D hlen - (int) sizeof(struct openv=
pn_tcphdr),</span><br><span>          opt =3D (uint8_t *)(tc + 1);</span><b=
r><span>          olen &gt; 1;</span><br><span>          olen -=3D optlen, =
opt +=3D optlen)</span><br><span>diff --git a/src/openvpn/otime.c b/src/ope=
nvpn/otime.c</span><br><span>index b28a90f..e751246 100644</span><br><span>=
--- a/src/openvpn/otime.c</span><br><span>+++ b/src/openvpn/otime.c</span><=
br><span>@@ -105,7 +105,7 @@</span><br><span> /* format a time_t as ascii, =
or use current time if 0 */</span><br><span> </span><br><span> const char *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-time_string(time_t t,=
 int usec, bool show_usec, struct gc_arena *gc)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+time_string(time_t t, long usec, bool show_usec=
, struct gc_arena *gc)</span><br><span> {</span><br><span>     struct buffe=
r out =3D alloc_buf_gc(64, gc);</span><br><span>     struct timeval tv;</sp=
an><br><span>diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h</span><=
br><span>index c27be89..d795c3c 100644</span><br><span>--- a/src/openvpn/ot=
ime.h</span><br><span>+++ b/src/openvpn/otime.h</span><br><span>@@ -43,7 +4=
3,7 @@</span><br><span> bool frequency_limit_event_allowed(struct frequency=
_limit *f);</span><br><span> </span><br><span> /* format a time_t as ascii,=
 or use current time if 0 */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-const char *time_string(time_t t, int usec, bool show_usec, struct g=
c_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const =
char *time_string(time_t t, long usec, bool show_usec, struct gc_arena *gc)=
;</span><br><span> </span><br><span> /* struct timeval functions */</span><=
br><span> </span><br><span>diff --git a/src/openvpn/packet_id.c b/src/openv=
pn/packet_id.c</span><br><span>index ef83248..3d6f3ee 100644</span><br><spa=
n>--- a/src/openvpn/packet_id.c</span><br><span>+++ b/src/openvpn/packet_id=
.c</span><br><span>@@ -588,14 +588,14 @@</span><br><span>         }</span><=
br><span>         else</span><br><span>         {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            diff =3D (int) prev_now - v;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            diff =3D (int)=
(prev_now - v);</span><br><span>             if (diff &lt; 0)</span><br><sp=
an>             {</span><br><span>                 c =3D &#39;N&#39;;</span=
><br><span>             }</span><br><span>             else if (diff &lt; 1=
0)</span><br><span>             {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                c =3D &#39;0&#39; + diff;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                c =3D (char)(&#39;0&#39; =
+ diff);</span><br><span>             }</span><br><span>             else</=
span><br><span>             {</span><br><span>diff --git a/src/openvpn/reli=
able.c b/src/openvpn/reliable.c</span><br><span>index e7d4d5f..0e26f98 1006=
44</span><br><span>--- a/src/openvpn/reliable.c</span><br><span>+++ b/src/o=
penvpn/reliable.c</span><br><span>@@ -257,8 +257,7 @@</span><br><span>     =
               struct buffer *buf,</span><br><span>                    cons=
t struct session_id *sid, int max, bool prepend)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    int i, j;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    uint8_t n;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int i, j, n;</span><br><span>     str=
uct buffer sub;</span><br><span> </span><br><span>     n =3D ack-&gt;len;</=
span><br><span>@@ -270,9 +269,9 @@</span><br><span>     copy_acks_to_mru(ac=
k, ack_mru, n);</span><br><span> </span><br><span>     /* Number of acks we=
 can resend that still fit into the packet */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    uint8_t total_acks =3D min_int(max, ack_mru-&gt=
;len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t t=
otal_acks =3D (uint8_t)min_int(max, ack_mru-&gt;len);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    sub =3D buf_sub(buf, =
ACK_SIZE(total_acks), prepend);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    sub =3D buf_sub(buf, (int)ACK_SIZE(total_acks), prepend);</=
span><br><span>     if (!BDEF(&amp;sub))</span><br><span>     {</span><br><=
span>         goto error;</span><br><span>diff --git a/src/openvpn/socket.h=
 b/src/openvpn/socket.h</span><br><span>index bfc1253..a4acc5d 100644</span=
><br><span>--- a/src/openvpn/socket.h</span><br><span>+++ b/src/openvpn/soc=
ket.h</span><br><span>@@ -1181,7 +1181,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> /* write a TCP or UDP packet to link */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static inline size_t</span><br><span=
> link_socket_write(struct link_socket *sock,</span><br><span>             =
      struct buffer *buf,</span><br><span>                   struct link_so=
cket_actual *to)</span><br><span>@@ -1198,7 +1198,7 @@</span><br><span>    =
 else</span><br><span>     {</span><br><span>         ASSERT(0);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        return -1; /* NOTREACHED=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0=
; /* NOTREACHED */</span><br><span>     }</span><br><span> }</span><br><spa=
n> </span><br><span>diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_=
crypt.c</span><br><span>index 975d31f..f0946cb 100644</span><br><span>--- a=
/src/openvpn/tls_crypt.c</span><br><span>+++ b/src/openvpn/tls_crypt.c</spa=
n><br><span>@@ -634,7 +634,7 @@</span><br><span>     memcpy(&amp;net_len, B=
END(&amp;wrapped_client_key) - sizeof(net_len),</span><br><span>           =
 sizeof(net_len));</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    size_t wkc_len =3D ntohs(net_len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint16_t wkc_len =3D ntohs(net_len);<=
/span><br><span>     if (!buf_advance(&amp;wrapped_client_key, BLEN(&amp;wr=
apped_client_key) - wkc_len))</span><br><span>     {</span><br><span>      =
   msg(D_TLS_ERRORS, &quot;Can not locate tls-crypt-v2 client key&quot;);</=
span><br><span>diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_he=
lper.c</span><br><span>index 40839f2..fcf8c2e 100644</span><br><span>--- a/=
src/openvpn/xkey_helper.c</span><br><span>+++ b/src/openvpn/xkey_helper.c</=
span><br><span>@@ -292,7 +292,7 @@</span><br><span>  * @return             =
 false on error, true  on success</span><br><span>  *</span><br><span>  * O=
n return enc_len is  set to actual size of the result.</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * enc is NULL or enc_len is not enough to=
 store the result, it is set</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * If enc is NULL or enc_len is not enough to store the result, it=
 is set</span><br><span>  * to the required size and false is returned.</sp=
an><br><span>  */</span><br><span> bool</span><br><span>@@ -337,8 +337,8 @@=
</span><br><span>                         MAKE_DI(sha512), MAKE_DI(sha224),=
 MAKE_DI(sha512_224),</span><br><span>                         MAKE_DI(sha5=
12_256), {0, NULL, 0}};</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    int out_len =3D 0;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int ret =3D 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    size_t out_len =3D 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    bool ret =3D false;</span><br><span> </span><=
br><span>     int nid =3D OBJ_sn2nid(mdname);</span><br><span>     if (nid =
=3D=3D NID_undef)</span><br><span>@@ -354,7 +354,7 @@</span><br><span> </sp=
an><br><span>     if (tbslen !=3D EVP_MD_size(EVP_get_digestbyname(mdname))=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        msg(M_WARN, &quot;Error: encode_pkcs11: invalid input length &lt=
;%d&gt;&quot;, (int)tbslen);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(M_WARN, &quot;Error: encode_pkcs11: invalid input leng=
th &lt;%zu&gt;&quot;, tbslen);</span><br><span>         goto done;</span><b=
r><span>     }</span><br><span> </span><br><span>@@ -383,13 +383,13 @@</spa=
n><br><span> </span><br><span>     out_len =3D tbslen + di-&gt;sz;</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (enc =
&amp;&amp; (out_len &lt;=3D (int) *enc_len))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (enc &amp;&amp; (out_len &lt;=3D *enc_len))=
</span><br><span>     {</span><br><span>         /* combine header and dige=
st */</span><br><span>         memcpy(enc, di-&gt;header, di-&gt;sz);</span=
><br><span>         memcpy(enc + di-&gt;sz, tbs, tbslen);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        dmsg(D_XKEY, &quot;encode_pkcs1=
: digest length =3D %d encoded length =3D %d&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-             (int) tbslen, (int) out_len);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dmsg(D_XKEY,=
 &quot;encode_pkcs1: digest length =3D %zu encoded length =3D %zu&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+             tbslen, o=
ut_len);</span><br><span>         ret =3D true;</span><br><span>     }</spa=
n><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/mock_ge=
t_random.c b/tests/unit_tests/openvpn/mock_get_random.c</span><br><span>ind=
ex 787b5e3..dfc7287 100644</span><br><span>--- a/tests/unit_tests/openvpn/m=
ock_get_random.c</span><br><span>+++ b/tests/unit_tests/openvpn/mock_get_ra=
ndom.c</span><br><span>@@ -41,6 +41,6 @@</span><br><span> {</span><br><span=
>     for (int i =3D 0; i &lt; len; i++)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        output[i] =3D rand();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        output[i] =3D (=
uint8_t)rand();</span><br><span>     }</span><br><span> }</span><br><span>d=
iff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openv=
pn/test_crypto.c</span><br><span>index 58eebc0..d765a4e 100644</span><br><s=
pan>--- a/tests/unit_tests/openvpn/test_crypto.c</span><br><span>+++ b/test=
s/unit_tests/openvpn/test_crypto.c</span><br><span>@@ -97,8 +97,8 @@</span>=
<br><span> </span><br><span>     for (int i =3D 0; i &lt; strlen(ciphername=
); i++)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        upper[i] =3D toupper(ciphername[i]);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        lower[i] =3D tolower(ciphername[i])=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        upper[i] =
=3D (char)toupper((unsigned char)ciphername[i]);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        lower[i] =3D (char)tolower((unsigned c=
har)ciphername[i]);</span><br><span>         if (rand() &amp; 0x1)</span><b=
r><span>         {</span><br><span>             random_case[i] =3D upper[i]=
;</span><br><span>@@ -160,7 +160,7 @@</span><br><span> </span><br><span> </=
span><br><span>     uint8_t out[32];</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    ssl_tls1_PRF(seed, seed_len, secret, secret_len, out, si=
zeof(out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ssl_=
tls1_PRF(seed, (int)seed_len, secret, (int)secret_len, out, sizeof(out));</=
span><br><span> </span><br><span>     assert_memory_equal(good_prf, out, si=
zeof(out));</span><br><span> }</span><br><span>diff --git a/tests/unit_test=
s/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c</spa=
n><br><span>index 90c67ac..c351858 100644</span><br><span>--- a/tests/unit_=
tests/openvpn/test_packet_id.c</span><br><span>+++ b/tests/unit_tests/openv=
pn/test_packet_id.c</span><br><span>@@ -94,7 +94,7 @@</span><br><span>     =
assert(data-&gt;pis.id =3D=3D 1);</span><br><span>     assert(data-&gt;pis.=
time =3D=3D now);</span><br><span>     assert_true(data-&gt;test_buf_data.b=
uf_id =3D=3D htonl(1));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    assert_true(data-&gt;test_buf_data.buf_time =3D=3D htonl(now));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(data-&gt;=
test_buf_data.buf_time =3D=3D htonl((uint32_t)now));</span><br><span> }</sp=
an><br><span> </span><br><span> static void</span><br><span>@@ -121,7 +121,=
7 @@</span><br><span>     assert(data-&gt;pis.id =3D=3D 1);</span><br><span=
>     assert(data-&gt;pis.time =3D=3D now);</span><br><span>     assert_tru=
e(data-&gt;test_buf_data.buf_id =3D=3D htonl(1));</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    assert_true(data-&gt;test_buf_data.buf_time=
 =3D=3D htonl(now));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_true(data-&gt;test_buf_data.buf_time =3D=3D htonl((uint32_t)now=
));</span><br><span> }</span><br><span> </span><br><span> static void</span=
><br><span>@@ -152,7 +152,7 @@</span><br><span>     assert(data-&gt;pis.id =
=3D=3D 1);</span><br><span>     assert(data-&gt;pis.time =3D=3D now);</span=
><br><span>     assert_true(data-&gt;test_buf_data.buf_id =3D=3D htonl(1));=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(data-=
&gt;test_buf_data.buf_time =3D=3D htonl(now));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(data-&gt;test_buf_data.buf_time =
=3D=3D htonl((uint32_t)now));</span><br><span> }</span><br><span> </span><b=
r><span> static void</span><br><span>diff --git a/tests/unit_tests/openvpn/=
test_provider.c b/tests/unit_tests/openvpn/test_provider.c</span><br><span>=
index 335fca2..5e57f33 100644</span><br><span>--- a/tests/unit_tests/openvp=
n/test_provider.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_provi=
der.c</span><br><span>@@ -365,7 +365,7 @@</span><br><span>     }</span><br>=
<span> </span><br><span>     /* return a predefined string as sig */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    memcpy(sig, good_sig, mi=
n_int(sizeof(good_sig), *siglen));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    memcpy(sig, good_sig, min_size(sizeof(good_sig), *siglen=
));</span><br><span> </span><br><span>     return 1;</span><br><span> }</sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests=
/unit_tests/openvpn/test_tls_crypt.c</span><br><span>index ed7c794..3b885ab=
 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_tls_crypt.c</sp=
an><br><span>+++ b/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><spa=
n>@@ -138,7 +138,7 @@</span><br><span> {</span><br><span>     for (int i =
=3D 0; i &lt; len; i++)</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        output[i] =3D i;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        output[i] =3D (uint8_t)i;</span><br><=
span>     }</span><br><span>     return true;</span><br><span> }</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/267?usp=3Demail">change 267</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/26=
7?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6818b153bdeb1eed65870af99b0=
531e95807fe0f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 267 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--MwHpnSXOx00=--

