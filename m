From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 3 Feb 2025 18:19:12 +0000
In-Reply-To: <gerrit.1737027245000.I15c7cfdddb06d4530d669b222a3c65db5169b29a@...2715...>
References: <gerrit.1737027245000.I15c7cfdddb06d4530d669b222a3c65db5169b29a@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., max@...2606...
Message-ID: <3c01be8c334daa350fa2ebddae8712bea6fd0f6a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yerTjTXsdeA="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, MaxF <max@...2606...>

--yerTjTXsdeA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/868?usp=3Demail

to look at the new patch set (#3).


Change subject: Extend the unit test for data channel packets with aead lim=
it tests
......................................................................

Extend the unit test for data channel packets with aead limit tests

Change-Id: I15c7cfdddb06d4530d669b222a3c65db5169b29a
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M tests/unit_tests/openvpn/test_ssl.c
1 file changed, 100 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/68/868/3

diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index 842c944..f2aee79 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -365,9 +365,104 @@
         assert_memory_equal(BPTR(&src), BPTR(&buf), i);

     }
+
+
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
+    ASSERT(buf_init(&encrypt_workspace, frame.buf.headroom)); \
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
+
+
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
+    /* Ensure that we are still on the initial key (unit test uses 4)
+     * or that it is 0 when epoch is not in use */
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


 struct crypto_options
@@ -428,16 +523,21 @@
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
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: MaxF <max@...2606...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--yerTjTXsdeA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/868?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Extend the unit test for data channel packets with aead limit tests<b=
r><br>Change-Id: I15c7cfdddb06d4530d669b222a3c65db5169b29a<br>Signed-off-by=
: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M tests/unit_tests/openvpn=
/test_ssl.c<br>1 file changed, 100 insertions(+), 0 deletions(-)<br><br></p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/68/868/3</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/open=
vpn/test_ssl.c</span><br><span>index 842c944..f2aee79 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_ssl.c</span><br><span>@@ -365,9 +365,104 @@</span><br>=
<span>         assert_memory_equal(BPTR(&amp;src), BPTR(&amp;buf), i);</spa=
n><br><span> </span><br><span>     }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+encrypt_one_packet(struct cr=
ypto_options *co, int len)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
frame frame;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ini=
t_frame_parameters(&amp;frame);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&am=
p;frame), &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), =
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 buffer work =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D clear_b=
uf();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buf=
fer src =3D alloc_buf_gc(frame.buf.payload_size, &amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    void *buf_p;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ASSERT(buf_init(&amp;work, frame.buf.headroom));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * Load src with random data.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ASSERT(buf_init(&amp;src, 0));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ASSERT(len &lt;=3D src.capacity);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src.len =3D len;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(rand_byt=
es(BPTR(&amp;src), BLEN(&amp;src)));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* copy source to input buf */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    buf =3D work;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    buf_p =3D buf_write_alloc(&amp;buf, BLEN(&amp;src));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_p);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(buf_p, BPTR(&amp;=
src), BLEN(&amp;src));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_i=
nit(&amp;encrypt_workspace, frame.buf.headroom)); \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    openvpn_encrypt(&amp;buf, encrypt_wor=
kspace, co);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* decrypt */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_decrypt(&amp;buf=
, decrypt_workspace, co, &amp;frame, BPTR(&amp;buf));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* compare */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(buf.len, src.len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;src), B=
PTR(&amp;buf), len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check=
_aead_limits(struct crypto_options *co, bool chachapoly)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* Check that we correctly react when we have a nearing AEAD limits */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* manually increase the send count=
er to be past</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 the GCM usage limit */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    co-&gt;key_ctx_bi.encrypt.plaintext_blocks =3D 0x1ull &lt;&lt; 40;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    bool epoch =3D (co-&gt;flags &amp; CO_EPOCH_DATA_KEY_F=
ORMAT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int expected_epoch =3D epoc=
h ? 4 : 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* Ensure that we are st=
ill on the initial key (unit test uses 4)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * or that it is 0 when epoch is not in use */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(c=
o-&gt;key_ctx_bi.encrypt.epoch, expected_epoch);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    encrypt_one_packet(co, 1000);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* either epoch key has been updated or warning is enabled */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (epoch &amp;&amp;=
 !chachapoly)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        expected_epo=
ch++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;key_ctx_bi.encrypt.=
epoch, expected_epoch);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!epoch)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        /* Check always against t=
he GCM usage limit here to see if that</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+         * check works */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        assert_true(aead_usage_limit_reached((1ull=
 &lt;&lt; 36),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                        &amp;co-&gt;key_ctx_bi.encrypt,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
                      co-&gt;packet_id.send.id));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
Move to the end of the epoch data key send PID range, ChachaPoly</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * should now also move to=
 a new epoch data key */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    co-&gt;packet_id.send.id =3D PACKET_ID_EPOCH_MAX;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    encrypt_one_packet(co, 1000);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    encrypt_one_packet(co, 1000);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    expected_epoch++;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(co-&gt;key_ctx_bi.encry=
pt.epoch, expected_epoch);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span> </span><br><span> </span><br><span> struct crypto=
_options</span><br><span>@@ -428,16 +523,21 @@</span><br><span> static void=
</span><br><span> run_data_channel_with_cipher_epoch(const char *cipher)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 bool ischacha =3D !strcmp(cipher, &quot;ChaCha20-Poly1305&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     struct=
 crypto_options co =3D init_crypto_options(cipher, &quot;none&quot;, true, =
NULL);</span><br><span>     do_data_channel_round_trip(&amp;co);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    check_aead_limits(&amp;co,=
 ischacha);</span><br><span>     uninit_crypto_options(&amp;co);</span><br>=
<span> }</span><br><span> </span><br><span> static void</span><br><span> ru=
n_data_channel_with_cipher(const char *cipher, const char *auth)</span><br>=
<span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool is=
chacha =3D !strcmp(cipher, &quot;ChaCha20-Poly1305&quot;);</span><br><span>=
     struct crypto_options co =3D init_crypto_options(cipher, auth, false, =
NULL);</span><br><span>     do_data_channel_round_trip(&amp;co);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    check_aead_limits(&amp;co,=
 ischacha);</span><br><span>     uninit_crypto_options(&amp;co);</span><br>=
<span> }</span><br><span> </span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/868?usp=3Demail">change=
 868</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/868?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I15c7cfdddb06d4530d669b222a3=
c65db5169b29a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 868 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: MaxF &lt;max@...2606...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--yerTjTXsdeA=--

