From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sat, 30 Nov 2024 13:38:17 +0000
In-Reply-To: <gerrit.1731290343000.I2a104decdb1e77a460f7a6976bcd0560b67a07b5@...2715...>
References: <gerrit.1731290343000.I2a104decdb1e77a460f7a6976bcd0560b67a07b5@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., lstipakov@...277...
Message-ID: <1a43162bae565c40473c0536b6ea5fda01e4e08c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vLirbJPP0lg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add methods to
 read/write packet ids for epoch data
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, stipa <lstipakov@...277...>

--vLirbJPP0lg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, stipa.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/803?usp=3Demail

to look at the new patch set (#6).


Change subject: Add methods to read/write packet ids for epoch data
......................................................................

Add methods to read/write packet ids for epoch data

Change-Id: I2a104decdb1e77a460f7a6976bcd0560b67a07b5
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/packet_id.c
M src/openvpn/packet_id.h
M tests/unit_tests/openvpn/test_packet_id.c
3 files changed, 141 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/803/6

diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 117c95f..e3a29f5 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -120,7 +120,8 @@
         int64_t diff;

         /*
-         * If time value increases, start a new sequence number sequence.
+         * If time value increases, start a new sequence list of number
+         * sequence for the new time point.
          */
         if (!CIRC_LIST_SIZE(p->seq_list)
             || pin->time > p->time
@@ -343,6 +344,21 @@
     return true;
 }

+static bool
+packet_id_send_update_epoch(struct packet_id_send *p)
+{
+    if (!p->time)
+    {
+        p->time =3D now;
+    }
+    if (p->id =3D=3D PACKET_ID_EPOCH_MAX)
+    {
+        return false;
+    }
+    p->id++;
+    return true;
+}
+
 bool
 packet_id_write(struct packet_id_send *p, struct buffer *buf, bool long_fo=
rm,
                 bool prepend)
@@ -634,4 +650,46 @@
     gc_free(&gc);
 }

+uint16_t
+packet_id_read_epoch(struct packet_id_net *pin, struct buffer *buf)
+{
+    uint64_t packet_id;
+
+
+    if (!buf_read(buf, &packet_id, sizeof(packet_id)))
+    {
+        return 0;
+    }
+
+    uint64_t id =3D ntohll(packet_id);
+    /* top most 16 bits */
+    uint16_t epoch =3D id >> 48;
+
+    pin->id =3D id & PACKET_ID_MASK;
+    return epoch;
+}
+
+bool
+packet_id_write_epoch(struct packet_id_send *p, uint16_t epoch, struct buf=
fer *buf)
+{
+    if (!packet_id_send_update_epoch(p))
+    {
+        return false;
+    }
+
+    /* First 16 bits of packet id is the epoch
+     *
+     * Next 48 bits are the per-epoch packet id counter. Since we are
+     * writing a big endian counter, the last 6 bytes of the 64 bit
+     * integer contain our counter but the upper two bytes are always 0 */
+
+    uint64_t net_id =3D ((uint64_t) epoch) << 48 | p->id;
+
+    /* convert to network order */
+    net_id =3D htonll(net_id);
+
+    return buf_write(buf, &net_id, sizeof(net_id));
+}
+
+
 #endif /* ifdef ENABLE_DEBUG */
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index d8a3e1a..f6b1463 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -44,7 +44,10 @@
  * These are ephemeral and are never saved to a file.
  */
 typedef uint32_t packet_id_type;
-#define PACKET_ID_MAX UINT32_MAX
+#define PACKET_ID_MAX        UINT32_MAX
+#define PACKET_ID_EPOCH_MAX  0x0000ffffffffffffull
+/** Maks of the bits that make out the epoch in the packet counter */
+#define PACKET_ID_MASK       0x0000ffffffffffffull
 typedef uint32_t net_time_t;

 /*
@@ -158,7 +161,8 @@
  * includes a timestamp as well.
  *
  * An epoch packet-id is a 16 bit epoch
- * counter plus a 48 per-epoch packet-id
+ * counter plus a 48 per-epoch packet-id.
+ *
  *
  * Long packet-ids are used as IVs for
  * CFB/OFB ciphers and for control channel
@@ -321,4 +325,25 @@
     }
 }

+/**
+ * Writes the packet ID containing both the epoch and the packet id to the
+ * buffer specified by buf.
+ * @param p         packed id send structure to use for the packet id
+ * @param epoch     epoch to write to the packet
+ * @param buf       buffer to write the packet id/epcoh to
+ * @return          false if the packet id space is exhausted and cannot b=
e written
+ */
+bool
+packet_id_write_epoch(struct packet_id_send *p, uint16_t epoch, struct buf=
fer *buf);
+
+/**
+ * Reads the packet ID containing both the epoch and the per-epoch counter
+ * from the buf.  Will return 0 as epoch id if there is any error.
+ * @param p       packet_id struct to popupulate with the on-wire counter
+ * @param buf     buffer to read the packet id from.
+ * @return        0 for an error/invalid id, epoch otherwise
+ */
+uint16_t
+packet_id_read_epoch(struct packet_id_net *p, struct buffer *buf);
+
 #endif /* PACKET_ID_H */
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/o=
penvpn/test_packet_id.c
index d918985..a24580b 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -44,6 +44,7 @@
     } test_buf_data;
     struct buffer test_buf;
     struct packet_id_send pis;
+    struct gc_arena gc;
 };

 static int
@@ -59,6 +60,7 @@

     data->test_buf.data =3D (void *) &data->test_buf_data;
     data->test_buf.capacity =3D sizeof(data->test_buf_data);
+    data->gc =3D gc_new();

     *state =3D data;
     return 0;
@@ -67,6 +69,8 @@
 static int
 test_packet_id_write_teardown(void **state)
 {
+    struct test_packet_id_write_data *data =3D *state;
+    gc_free(&data->gc);
     free(*state);
     return 0;
 }
@@ -209,6 +213,53 @@
     reliable_free(rel);
 }

+static void
+test_packet_id_write_epoch(void **state)
+{
+    struct test_packet_id_write_data *data =3D *state;
+
+    struct buffer buf =3D alloc_buf_gc(128, &data->gc);
+
+    /* test normal writing of packet id to the buffer */
+    assert_true(packet_id_write_epoch(&data->pis, 0x23, &buf));
+
+    assert_int_equal(buf.len, 8);
+    uint8_t expected_header[8] =3D { 0x00, 0x23, 0, 0, 0, 0, 0, 1};
+    assert_memory_equal(BPTR(&buf), expected_header, 8);
+
+    /* too small buffer should error out */
+    struct buffer buf_short =3D alloc_buf_gc(5, &data->gc);
+    assert_false(packet_id_write_epoch(&data->pis, 0xabde, &buf_short));
+
+    /* test a true 48 bit packet id */
+    data->pis.id =3D 0xfa079ab9d2e8;
+    struct buffer buf_48 =3D alloc_buf_gc(128, &data->gc);
+    assert_true(packet_id_write_epoch(&data->pis, 0xfffe, &buf_48));
+    uint8_t expected_header_48[8] =3D { 0xff, 0xfe, 0xfa, 0x07, 0x9a, 0xb9=
, 0xd2, 0xe9};
+    assert_memory_equal(BPTR(&buf_48), expected_header_48, 8);
+
+    /* test writing/checking the 48 bit overflow */
+    data->pis.id =3D 0xfffffffffffe;
+    struct buffer buf_of =3D alloc_buf_gc(128, &data->gc);
+    assert_true(packet_id_write_epoch(&data->pis, 0xf00f, &buf_of));
+    uint8_t expected_header_of[8] =3D { 0xf0, 0x0f, 0xff, 0xff, 0xff, 0xff=
, 0xff, 0xff};
+    assert_memory_equal(BPTR(&buf_of), expected_header_of, 8);
+
+    /* This is go over 2^48 - 1 and should error out. */
+    assert_false(packet_id_write_epoch(&data->pis, 0xf00f, &buf_of));
+
+    /* Now read back the packet ids and check if they are the same as what=
 we
+     * have written */
+    struct packet_id_net pin;
+    assert_int_equal(packet_id_read_epoch(&pin, &buf), 0x23);
+    assert_int_equal(pin.id, 1);
+
+    assert_int_equal(packet_id_read_epoch(&pin, &buf_48), 0xfffe);
+    assert_int_equal(pin.id, 0xfa079ab9d2e9);
+
+    assert_int_equal(packet_id_read_epoch(&pin, &buf_of), 0xf00f);
+    assert_int_equal(pin.id, 0xffffffffffff);
+}

 static void
 test_copy_acks_to_lru(void **state)
@@ -296,6 +347,10 @@
         cmocka_unit_test_setup_teardown(test_packet_id_write_long_wrap,
                                         test_packet_id_write_setup,
                                         test_packet_id_write_teardown),
+        cmocka_unit_test_setup_teardown(test_packet_id_write_epoch,
+                                        test_packet_id_write_setup,
+                                        test_packet_id_write_teardown),
+
         cmocka_unit_test(test_get_num_output_sequenced_available),
         cmocka_unit_test(test_copy_acks_to_lru)


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/803?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2a104decdb1e77a460f7a6976bcd0560b67a07b5
Gerrit-Change-Number: 803
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--vLirbJPP0lg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, stipa. </p>
<p>plaisthos <strong>uploaded patch set #6</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/803?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Add methods to read/write packet ids for epoch data<br><br>Change-Id:=
 I2a104decdb1e77a460f7a6976bcd0560b67a07b5<br>Signed-off-by: Arne Schwabe &=
lt;arne@...1227...&gt;<br>---<br>M src/openvpn/packet_id.c<br>M src/openvpn=
/packet_id.h<br>M tests/unit_tests/openvpn/test_packet_id.c<br>3 files chan=
ged, 141 insertions(+), 3 deletions(-)<br><br></pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/03/803/6</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/packet_id.c b/src/openvpn/packet_id.c</span><br><span>index 117c95f..e3a2=
9f5 100644</span><br><span>--- a/src/openvpn/packet_id.c</span><br><span>++=
+ b/src/openvpn/packet_id.c</span><br><span>@@ -120,7 +120,8 @@</span><br><=
span>         int64_t diff;</span><br><span> </span><br><span>         /*</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * If time valu=
e increases, start a new sequence number sequence.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * If time value increases, start a =
new sequence list of number</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+         * sequence for the new time point.</span><br><span>       =
   */</span><br><span>         if (!CIRC_LIST_SIZE(p-&gt;seq_list)</span><b=
r><span>             || pin-&gt;time &gt; p-&gt;time</span><br><span>@@ -34=
3,6 +344,21 @@</span><br><span>     return true;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bo=
ol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+packet_id_send_up=
date_epoch(struct packet_id_send *p)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!p-&gt;time)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        p-&gt;=
time =3D now;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (p-&gt;id =3D=
=3D PACKET_ID_EPOCH_MAX)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p-&gt;id++;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> packet=
_id_write(struct packet_id_send *p, struct buffer *buf, bool long_form,</sp=
an><br><span>                 bool prepend)</span><br><span>@@ -634,4 +650,=
46 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+uint16_t</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+packet_id_read_epoch(str=
uct packet_id_net *pin, struct buffer *buf)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    uint64_t packet_id;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_read(buf, &amp;=
packet_id, sizeof(packet_id)))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    uint64_t id =3D ntohll(packet_id);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* top most 16 =
bits */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t=
 epoch =3D id &gt;&gt; 48;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pin-&gt;=
id =3D id &amp; PACKET_ID_MASK;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return epoch;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+packet_id_write_epoch(struct packet_id_se=
nd *p, uint16_t epoch, struct buffer *buf)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!packet_id_send_update_epoch(p))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* First 16 bit=
s of packet id is the epoch</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* Next 48 bits are the per-epoch packet id counter. Since we are</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * writing a big endian co=
unter, the last 6 bytes of the 64 bit</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * integer contain our counter but the upper two byte=
s are always 0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t net_id =
=3D ((uint64_t) epoch) &lt;&lt; 48 | p-&gt;id;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* convert to network order */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    net_id =3D htonll(net_id);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return buf_write(buf, &amp;net_id, sizeof(net_id));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> #endif /* ifdef ENABLE_DEBUG */</span><br>=
<span>diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h</span>=
<br><span>index d8a3e1a..f6b1463 100644</span><br><span>--- a/src/openvpn/p=
acket_id.h</span><br><span>+++ b/src/openvpn/packet_id.h</span><br><span>@@=
 -44,7 +44,10 @@</span><br><span>  * These are ephemeral and are never save=
d to a file.</span><br><span>  */</span><br><span> typedef uint32_t packet_=
id_type;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PACKE=
T_ID_MAX UINT32_MAX</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define PACKET_ID_MAX        UINT32_MAX</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define PACKET_ID_EPOCH_MAX  0x0000ffffffffffffull</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Maks of the bits tha=
t make out the epoch in the packet counter */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define PACKET_ID_MASK       0x0000fffffffffffful=
l</span><br><span> typedef uint32_t net_time_t;</span><br><span> </span><br=
><span> /*</span><br><span>@@ -158,7 +161,8 @@</span><br><span>  * includes=
 a timestamp as well.</span><br><span>  *</span><br><span>  * An epoch pack=
et-id is a 16 bit epoch</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * counter plus a 48 per-epoch packet-id</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * counter plus a 48 per-epoch packet-id.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span>  *</span><=
br><span>  * Long packet-ids are used as IVs for</span><br><span>  * CFB/OF=
B ciphers and for control channel</span><br><span>@@ -321,4 +325,25 @@</spa=
n><br><span>     }</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Writes the packet ID containing both the epoch and t=
he packet id to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * buffer specified by buf.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param p         packed id send structure to use for the packet =
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param epoch  =
   epoch to write to the packet</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param buf       buffer to write the packet id/epcoh to</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return          fals=
e if the packet id space is exhausted and cannot be written</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+packet_id_write_epoch(struct packet_id_send *p, uint16_t epoch, st=
ruct buffer *buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Reads the packet ID containing bo=
th the epoch and the per-epoch counter</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * from the buf.  Will return 0 as epoch id if there is =
any error.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 p       packet_id struct to popupulate with the on-wire counter</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf     buffer to re=
ad the packet id from.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @return        0 for an error/invalid id, epoch otherwise</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+uint16_t</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+packet_id_read_epoch(struct packet_id_net *p, struct buffe=
r *buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> #endif /* PACKET_ID_H */</span><br><span>diff --git a/tests/unit_tes=
ts/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c</sp=
an><br><span>index d918985..a24580b 100644</span><br><span>--- a/tests/unit=
_tests/openvpn/test_packet_id.c</span><br><span>+++ b/tests/unit_tests/open=
vpn/test_packet_id.c</span><br><span>@@ -44,6 +44,7 @@</span><br><span>    =
 } test_buf_data;</span><br><span>     struct buffer test_buf;</span><br><s=
pan>     struct packet_id_send pis;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc;</span><br><span> };</span><br><span=
> </span><br><span> static int</span><br><span>@@ -59,6 +60,7 @@</span><br>=
<span> </span><br><span>     data-&gt;test_buf.data =3D (void *) &amp;data-=
&gt;test_buf_data;</span><br><span>     data-&gt;test_buf.capacity =3D size=
of(data-&gt;test_buf_data);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    data-&gt;gc =3D gc_new();</span><br><span> </span><br><span>   =
  *state =3D data;</span><br><span>     return 0;</span><br><span>@@ -67,6 =
+69,8 @@</span><br><span> static int</span><br><span> test_packet_id_write_=
teardown(void **state)</span><br><span> {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct test_packet_id_write_data *data =3D *state=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;d=
ata-&gt;gc);</span><br><span>     free(*state);</span><br><span>     return=
 0;</span><br><span> }</span><br><span>@@ -209,6 +213,53 @@</span><br><span=
>     reliable_free(rel);</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+test_packet_id_write_epoch(void **state)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct test_packet_id_write_data =
*data =3D *state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf=
 =3D alloc_buf_gc(128, &amp;data-&gt;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* test normal writing of packet id to the buffer */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(packet_id_write_epo=
ch(&amp;data-&gt;pis, 0x23, &amp;buf));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(buf.len, 8);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    uint8_t expected_header[8] =3D { 0x00, 0x23, 0, 0, 0, 0,=
 0, 1};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_m=
emory_equal(BPTR(&amp;buf), expected_header, 8);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* too small buffer should error out */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf_short =3D alloc_buf=
_gc(5, &amp;data-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_false(packet_id_write_epoch(&amp;data-&gt;pis, 0xabde, &am=
p;buf_short));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* test a true 48 bi=
t packet id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    d=
ata-&gt;pis.id =3D 0xfa079ab9d2e8;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct buffer buf_48 =3D alloc_buf_gc(128, &amp;data-&gt=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(packet_id_write_epoch(&amp;data-&gt;pis, 0xfffe, &amp;buf_48));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t expected_header_4=
8[8] =3D { 0xff, 0xfe, 0xfa, 0x07, 0x9a, 0xb9, 0xd2, 0xe9};</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;b=
uf_48), expected_header_48, 8);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
test writing/checking the 48 bit overflow */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    data-&gt;pis.id =3D 0xfffffffffffe;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf_of =3D a=
lloc_buf_gc(128, &amp;data-&gt;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(packet_id_write_epoch(&amp;data-&gt;pis, 0x=
f00f, &amp;buf_of));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    uint8_t expected_header_of[8] =3D { 0xf0, 0x0f, 0xff, 0xff, 0xff, 0xff=
, 0xff, 0xff};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_memory_equal(BPTR(&amp;buf_of), expected_header_of, 8);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* This is go over 2^48 - 1 and should error out=
. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fals=
e(packet_id_write_epoch(&amp;data-&gt;pis, 0xf00f, &amp;buf_of));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* Now read back the packet ids and check if=
 they are the same as what we</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * have written */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct packet_id_net pin;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(packet_id_read_epoch(&amp;pin, =
&amp;buf), 0x23);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(pin.id, 1);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(packet_id_read_epoch(&amp;pin, &amp;buf_48), 0xfffe);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(pin.id,=
 0xfa079ab9d2e9);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
packet_id_read_epoch(&amp;pin, &amp;buf_of), 0xf00f);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(pin.id, 0xffffffffff=
ff);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an> </span><br><span> static void</span><br><span> test_copy_acks_to_lru(vo=
id **state)</span><br><span>@@ -296,6 +347,10 @@</span><br><span>         c=
mocka_unit_test_setup_teardown(test_packet_id_write_long_wrap,</span><br><s=
pan>                                         test_packet_id_write_setup,</s=
pan><br><span>                                         test_packet_id_write=
_teardown),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cmocka_unit_test_setup_teardown(test_packet_id_write_epoch,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                   =
     test_packet_id_write_setup,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                                        test_packet_id_write_t=
eardown),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>         cmocka_unit_test(test_get_num_output_sequenced_available),<=
/span><br><span>         cmocka_unit_test(test_copy_acks_to_lru)</span><br>=
<span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/803?usp=3Demail">change 803</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/803?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2a104decdb1e77a460f7a6976bc=
d0560b67a07b5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 803 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--vLirbJPP0lg=--

