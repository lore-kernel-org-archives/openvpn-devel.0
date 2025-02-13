From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 13 Feb 2025 21:27:29 +0000
In-Reply-To: <gerrit.1737027245000.I15c7cfdddb06d4530d669b222a3c65db5169b29a@...2715...>
References: <gerrit.1737027245000.I15c7cfdddb06d4530d669b222a3c65db5169b29a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <cff50d135218ac3c1011c926d0e455d577b282ca-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RVB+PB0o4kg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extend the unit test
 for data channel packets with aead limit tests
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

--RVB+PB0o4kg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/86=
8?usp=3Demail )

Change subject: Extend the unit test for data channel packets with aead lim=
it tests
......................................................................

Extend the unit test for data channel packets with aead limit tests

Change-Id: I15c7cfdddb06d4530d669b222a3c65db5169b29a
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: MaxF <max@...2606...>
Message-Id: <20250213193942.26423-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
864.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_ssl.c
1 file changed, 101 insertions(+), 2 deletions(-)




diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index 486e298..c383034 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -363,14 +363,108 @@
         /* compare */
         assert_int_equal(buf.len, src.len);
         assert_memory_equal(BPTR(&src), BPTR(&buf), i);
-
     }
     gc_free(&gc);
 }

+static void
+encrypt_one_packet(struct crypto_options *co, int len)
+{
+    struct frame frame;
+    init_frame_parameters(&frame);
+
+    struct gc_arena gc =3D gc_new();
+    struct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc=
);
+    struct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc=
);
+    struct buffer work =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
+    struct buffer buf =3D clear_buf();
+    struct buffer src =3D alloc_buf_gc(frame.buf.payload_size, &gc);
+    void *buf_p;
+
+    ASSERT(buf_init(&work, frame.buf.headroom));
+
+    /*
+     * Load src with random data.
+     */
+    ASSERT(buf_init(&src, 0));
+    ASSERT(len <=3D src.capacity);
+    src.len =3D len;
+    ASSERT(rand_bytes(BPTR(&src), BLEN(&src)));
+
+    /* copy source to input buf */
+    buf =3D work;
+    buf_p =3D buf_write_alloc(&buf, BLEN(&src));
+    ASSERT(buf_p);
+    memcpy(buf_p, BPTR(&src), BLEN(&src));
+
+    ASSERT(buf_init(&encrypt_workspace, frame.buf.headroom));
+    openvpn_encrypt(&buf, encrypt_workspace, co);
+
+    /* decrypt */
+    openvpn_decrypt(&buf, decrypt_workspace, co, &frame, BPTR(&buf));
+
+    /* compare */
+    assert_int_equal(buf.len, src.len);
+    assert_memory_equal(BPTR(&src), BPTR(&buf), len);
+
+    gc_free(&gc);
+}
=20

-struct crypto_options
+static void
+check_aead_limits(struct crypto_options *co, bool chachapoly)
+{
+
+    /* Check that we correctly react when we have a nearing AEAD limits */
+
+    /* manually increase the send counter to be past
+     * the GCM usage limit */
+    co->key_ctx_bi.encrypt.plaintext_blocks =3D 0x1ull << 40;
+
+
+    bool epoch =3D (co->flags & CO_EPOCH_DATA_KEY_FORMAT);
+
+    int expected_epoch =3D epoch ? 4 : 0;
+
+    /* Ensure that we are still on the initial key (our init_crypto_options
+     * unit test method iterates the initial key to 4) or that it is 0 when
+     * epoch is not in use
+     */
+    assert_int_equal(co->key_ctx_bi.encrypt.epoch, expected_epoch);
+
+    encrypt_one_packet(co, 1000);
+
+    /* either epoch key has been updated or warning is enabled */
+    if (epoch && !chachapoly)
+    {
+        expected_epoch++;
+    }
+
+    assert_int_equal(co->key_ctx_bi.encrypt.epoch, expected_epoch);
+
+    if (!epoch)
+    {
+        /* Check always against the GCM usage limit here to see if that
+         * check works */
+        assert_true(aead_usage_limit_reached((1ull << 36),
+                                             &co->key_ctx_bi.encrypt,
+                                             co->packet_id.send.id));
+        return;
+    }
+
+    /* Move to the end of the epoch data key send PID range, ChachaPoly
+     * should now also move to a new epoch data key */
+    co->packet_id.send.id =3D PACKET_ID_EPOCH_MAX;
+
+    encrypt_one_packet(co, 1000);
+    encrypt_one_packet(co, 1000);
+
+    expected_epoch++;
+    assert_int_equal(co->key_ctx_bi.encrypt.epoch, expected_epoch);
+}
+
+
+static struct crypto_options
 init_crypto_options(const char *cipher, const char *auth, bool epoch,
                     struct key2 *statickey)
 {
@@ -428,16 +522,21 @@
 static void
 run_data_channel_with_cipher_epoch(const char *cipher)
 {
+    bool ischacha =3D !strcmp(cipher, "ChaCha20-Poly1305");
+
     struct crypto_options co =3D init_crypto_options(cipher, "none", true,=
 NULL);
     do_data_channel_round_trip(&co);
+    check_aead_limits(&co, ischacha);
     uninit_crypto_options(&co);
 }

 static void
 run_data_channel_with_cipher(const char *cipher, const char *auth)
 {
+    bool ischacha =3D !strcmp(cipher, "ChaCha20-Poly1305");
     struct crypto_options co =3D init_crypto_options(cipher, auth, false, =
NULL);
     do_data_channel_round_trip(&co);
+    check_aead_limits(&co, ischacha);
     uninit_crypto_options(&co);
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/868?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I15c7cfdddb06d4530d669b222a3c65db5169b29a
Gerrit-Change-Number: 868
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--RVB+PB0o4kg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/868?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Extend the unit test for data channel packets =
with aead limit tests<br><br>Change-Id: I15c7cfdddb06d4530d669b222a3c65db51=
69b29a<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: =
MaxF &lt;max@...2606...&gt;<br>Message-Id: &lt;20250213193942.26423-1-gert@=
...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1885...=
rceforge.net/msg30864.html<br>Signed-off-by: Gert Doering &lt;gert@...1725...=
..&gt;<br>---<br>M tests/unit_tests/openvpn/test_ssl.c<br>1 file changed, 1=
01 insertions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/open=
vpn/test_ssl.c</span><br><span>index 486e298..c383034 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_ssl.c</span><br><span>@@ -363,14 +363,108 @@</span><br=
><span>         /* compare */</span><br><span>         assert_int_equal(buf=
.len, src.len);</span><br><span>         assert_memory_equal(BPTR(&amp;src)=
, BPTR(&amp;buf), i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span>     }</span><br><span>     gc_free(&amp;gc);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enc=
rypt_one_packet(struct crypto_options *co, int len)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct frame frame;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    init_frame_parameters(&amp;frame);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct buffer encrypt_workspace =
=3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct buffer decrypt_workspace =3D alloc_=
buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer work =3D alloc_buf_gc(BUF_SIZE(&amp;fr=
ame), &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct buffer buf =3D clear_buf();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct buffer src =3D alloc_buf_gc(frame.buf.payload_siz=
e, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    voi=
d *buf_p;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_init(&amp;work=
, frame.buf.headroom));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * Load src with random =
data.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_init(&amp;s=
rc, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(=
len &lt;=3D src.capacity);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    src.len =3D len;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ASSERT(rand_bytes(BPTR(&amp;src), BLEN(&amp;src)));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* copy source to input buf */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    buf =3D work;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    buf_p =3D buf_write_alloc(&amp;bu=
f, BLEN(&amp;src));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ASSERT(buf_p);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   memcpy(buf_p, BPTR(&amp;src), BLEN(&amp;src));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ASSERT(buf_init(&amp;encrypt_workspace, frame.buf.headroom))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_encryp=
t(&amp;buf, encrypt_workspace, co);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* decrypt */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o=
penvpn_decrypt(&amp;buf, decrypt_workspace, co, &amp;frame, BPTR(&amp;buf))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* compare */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(buf.len, src.len);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_e=
qual(BPTR(&amp;src), BPTR(&amp;buf), len);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span> </span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-struct crypto_options</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+check_aead_limits(struct crypto_options *co, bool chachapol=
y)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* Check that we correctly react when we have a ne=
aring AEAD limits */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* manually in=
crease the send counter to be past</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * the GCM usage limit */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    co-&gt;key_ctx_bi.encrypt.plaintext_blocks =3D=
 0x1ull &lt;&lt; 40;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    bool epoch =3D (co-&gt;flags &amp=
; CO_EPOCH_DATA_KEY_FORMAT);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ex=
pected_epoch =3D epoch ? 4 : 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
Ensure that we are still on the initial key (our init_crypto_options</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * unit test method it=
erates the initial key to 4) or that it is 0 when</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * epoch is not in use</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;key_ctx_bi.encrypt.epo=
ch, expected_epoch);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    encrypt_one_pa=
cket(co, 1000);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* either epoch key=
 has been updated or warning is enabled */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (epoch &amp;&amp; !chachapoly)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        expected_epoch++;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(co-&gt;key_ctx_bi.encrypt.epoch, expected_epoch);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!epoch)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* Check always against the GCM usage limit here to=
 see if that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
  * check works */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       assert_true(aead_usage_limit_reached((1ull &lt;&lt; 36),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
              &amp;co-&gt;key_ctx_bi.encrypt,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                             co-&=
gt;packet_id.send.id));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* Move to the end of the epo=
ch data key send PID range, ChachaPoly</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * should now also move to a new epoch data key */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co-&gt;packet_id.=
send.id =3D PACKET_ID_EPOCH_MAX;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    en=
crypt_one_packet(co, 1000);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    encrypt_one_packet(co, 1000);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    expected_epoch++;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(co-&gt;key_ctx_bi.encrypt.epoch, expected_epoch);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static struct crypto_options</span><br><span> init_crypto_options(const cha=
r *cipher, const char *auth, bool epoch,</span><br><span>                  =
   struct key2 *statickey)</span><br><span> {</span><br><span>@@ -428,16 +5=
22,21 @@</span><br><span> static void</span><br><span> run_data_channel_wit=
h_cipher_epoch(const char *cipher)</span><br><span> {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool ischacha =3D !strcmp(cipher, &qu=
ot;ChaCha20-Poly1305&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span>     struct crypto_options co =3D init_crypto_opt=
ions(cipher, &quot;none&quot;, true, NULL);</span><br><span>     do_data_ch=
annel_round_trip(&amp;co);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    check_aead_limits(&amp;co, ischacha);</span><br><span>     unini=
t_crypto_options(&amp;co);</span><br><span> }</span><br><span> </span><br><=
span> static void</span><br><span> run_data_channel_with_cipher(const char =
*cipher, const char *auth)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    bool ischacha =3D !strcmp(cipher, &quot;ChaCh=
a20-Poly1305&quot;);</span><br><span>     struct crypto_options co =3D init=
_crypto_options(cipher, auth, false, NULL);</span><br><span>     do_data_ch=
annel_round_trip(&amp;co);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    check_aead_limits(&amp;co, ischacha);</span><br><span>     unini=
t_crypto_options(&amp;co);</span><br><span> }</span><br><span> </span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/868?usp=3Demail">change 868</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/868=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I15c7cfdddb06d4530d669b222a3=
c65db5169b29a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 868 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--RVB+PB0o4kg=--

