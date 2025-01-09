From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 9 Jan 2025 21:38:15 +0000
In-Reply-To: <gerrit.1731290343000.I2a104decdb1e77a460f7a6976bcd0560b67a07b5@...2715...>
References: <gerrit.1731290343000.I2a104decdb1e77a460f7a6976bcd0560b67a07b5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606..., lstipakov@...277...
Message-ID: <fee264637ddf3a2f6fdd73543e2333174ed5c288-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ujAzCLXyDHg="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, stipa <lstipakov@...277...>

--ujAzCLXyDHg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#13) to the change originally created b=
y plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/803?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by MaxF


Change subject: Add methods to read/write packet ids for epoch data
......................................................................

Add methods to read/write packet ids for epoch data

Change-Id: I2a104decdb1e77a460f7a6976bcd0560b67a07b5
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: MaxF <max@...2606...>
Message-Id: <20250109175528.22033-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
389.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/packet_id.c
M src/openvpn/packet_id.h
M tests/unit_tests/openvpn/test_packet_id.c
3 files changed, 141 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/803/13

diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 117c95f..0806e99 100644
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
@@ -634,4 +650,44 @@
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
+    /* Highest 16 bits of packet id is the epoch.
+     *
+     * The lower 48 bits are the per-epoch packet id counter. */
+    uint64_t net_id =3D ((uint64_t) epoch) << 48 | p->id;
+
+    /* convert to network order. This ensures that the highest bytes
+     * also become the first ones on the wire*/
+    net_id =3D htonll(net_id);
+
+    return buf_write(buf, &net_id, sizeof(net_id));
+}
+
+
 #endif /* ifdef ENABLE_DEBUG */
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index d8a3e1a..c05ac9a 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -44,7 +44,11 @@
  * These are ephemeral and are never saved to a file.
  */
 typedef uint32_t packet_id_type;
-#define PACKET_ID_MAX UINT32_MAX
+#define PACKET_ID_MAX        UINT32_MAX
+#define PACKET_ID_EPOCH_MAX  0x0000ffffffffffffull
+/** Mask of the bits that contain the 48-bit of the per-epoch packet
+ * counter in the packet id*/
+#define PACKET_ID_MASK       0x0000ffffffffffffull
 typedef uint32_t net_time_t;

 /*
@@ -158,7 +162,8 @@
  * includes a timestamp as well.
  *
  * An epoch packet-id is a 16 bit epoch
- * counter plus a 48 per-epoch packet-id
+ * counter plus a 48 per-epoch packet-id.
+ *
  *
  * Long packet-ids are used as IVs for
  * CFB/OFB ciphers and for control channel
@@ -321,4 +326,25 @@
     }
 }

+/**
+ * Writes the packet ID containing both the epoch and the packet id to the
+ * buffer specified by buf.
+ * @param p         packet id send structure to use for the packet id
+ * @param epoch     epoch to write to the packet
+ * @param buf       buffer to write the packet id/epoch to
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
+ * @param p       packet_id struct to populate with the on-wire counter
+ * @param buf     buffer to read the packet id from.
+ * @return        0 for an error/invalid id, epoch otherwise
+ */
+uint16_t
+packet_id_read_epoch(struct packet_id_net *p, struct buffer *buf);
+
 #endif /* PACKET_ID_H */
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/o=
penvpn/test_packet_id.c
index d918985..312a6b3d 100644
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
@@ -209,6 +213,54 @@
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
+    /* test writing/checking the 48 bit per epoch packet counter
+     * overflow */
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
@@ -296,6 +348,10 @@
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
Gerrit-PatchSet: 13
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--ujAzCLXyDHg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #13</strong> to the change originally c=
reated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/803?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by MaxF</p><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">Add methods to read/write packet ids for epoch data<b=
r><br>Change-Id: I2a104decdb1e77a460f7a6976bcd0560b67a07b5<br>Signed-off-by=
: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: MaxF &lt;max@...2606...=
&gt;<br>Message-Id: &lt;20250109175528.22033-1-gert@...1296...&gt;<br>URL: =
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30389.h=
tml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/=
openvpn/packet_id.c<br>M src/openvpn/packet_id.h<br>M tests/unit_tests/open=
vpn/test_packet_id.c<br>3 files changed, 141 insertions(+), 3 deletions(-)<=
br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/8=
03/13</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.=
c</span><br><span>index 117c95f..0806e99 100644</span><br><span>--- a/src/o=
penvpn/packet_id.c</span><br><span>+++ b/src/openvpn/packet_id.c</span><br>=
<span>@@ -120,7 +120,8 @@</span><br><span>         int64_t diff;</span><br>=
<span> </span><br><span>         /*</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-         * If time value increases, start a new sequence numb=
er sequence.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
  * If time value increases, start a new sequence list of number</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+         * sequence for the ne=
w time point.</span><br><span>          */</span><br><span>         if (!CI=
RC_LIST_SIZE(p-&gt;seq_list)</span><br><span>             || pin-&gt;time &=
gt; p-&gt;time</span><br><span>@@ -343,6 +344,21 @@</span><br><span>     re=
turn true;</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+packet_id_send_update_epoch(struct packet_id_send *p)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!p-&gt;time)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        p-&gt;time =3D now;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (p-&gt;id =3D=3D PACKET_ID_EPOCH_MAX)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    p-&gt;id++;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> bool</span><br><span> packet_id_write(struct packet_id_send *p, st=
ruct buffer *buf, bool long_form,</span><br><span>                 bool pre=
pend)</span><br><span>@@ -634,4 +650,44 @@</span><br><span>     gc_free(&am=
p;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+uint16_t</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+packet_id_read_epoch(struct packet_id_net *pin, struct buffer =
*buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    uint64_t packet_id;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!buf_read(buf, &amp;packet_id, sizeof(packet_id)))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    uint64_t id =3D ntohll(packet_id);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* top most 16 bits */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    uint16_t epoch =3D id &gt;&gt; 48;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    pin-&gt;id =3D id &amp; PACKET_ID_MASK;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return epoch;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pac=
ket_id_write_epoch(struct packet_id_send *p, uint16_t epoch, struct buffer =
*buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!packet_id_send_update_e=
poch(p))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* Highest 16 bits of packet id is the epoch.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * The lower 48 bits are the per-ep=
och packet id counter. */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    uint64_t net_id =3D ((uint64_t) epoch) &lt;&lt; 48 | p-&gt;id;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* convert to network order. This ens=
ures that the highest bytes</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * also become the first ones on the wire*/</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    net_id =3D htonll(net_id);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return buf_write(buf, &amp;net_id, sizeof(n=
et_id));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifdef ENABLE_DEBUG *=
/</span><br><span>diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet=
_id.h</span><br><span>index d8a3e1a..c05ac9a 100644</span><br><span>--- a/s=
rc/openvpn/packet_id.h</span><br><span>+++ b/src/openvpn/packet_id.h</span>=
<br><span>@@ -44,7 +44,11 @@</span><br><span>  * These are ephemeral and ar=
e never saved to a file.</span><br><span>  */</span><br><span> typedef uint=
32_t packet_id_type;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define PACKET_ID_MAX UINT32_MAX</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define PACKET_ID_MAX        UINT32_MAX</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define PACKET_ID_EPOCH_MAX  0x0000ffffff=
ffffffull</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Mask o=
f the bits that contain the 48-bit of the per-epoch packet</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * counter in the packet id*/</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define PACKET_ID_MASK    =
   0x0000ffffffffffffull</span><br><span> typedef uint32_t net_time_t;</spa=
n><br><span> </span><br><span> /*</span><br><span>@@ -158,7 +162,8 @@</span=
><br><span>  * includes a timestamp as well.</span><br><span>  *</span><br>=
<span>  * An epoch packet-id is a 16 bit epoch</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * counter plus a 48 per-epoch packet-id</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * counter plus a 48 per-epoc=
h packet-id.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span>  *</span><br><span>  * Long packet-ids are used as IVs for</sp=
an><br><span>  * CFB/OFB ciphers and for control channel</span><br><span>@@=
 -321,4 +326,25 @@</span><br><span>     }</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Writes the packet ID containi=
ng both the epoch and the packet id to the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * buffer specified by buf.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param p         packet id send structure=
 to use for the packet id</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param epoch     epoch to write to the packet</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param buf       buffer to write the =
packet id/epoch to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @return          false if the packet id space is exhausted and cannot be =
written</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+packet_id_write_epoch(struct packet_id_se=
nd *p, uint16_t epoch, struct buffer *buf);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Reads th=
e packet ID containing both the epoch and the per-epoch counter</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * from the buf.  Will return 0=
 as epoch id if there is any error.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param p       packet_id struct to populate with the on-=
wire counter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am buf     buffer to read the packet id from.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @return        0 for an error/invalid id, epoc=
h otherwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+uint16_t</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+packet_id_read_epoch(struct packet_=
id_net *p, struct buffer *buf);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> #endif /* PACKET_ID_H */</span><br><span>diff=
 --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openv=
pn/test_packet_id.c</span><br><span>index d918985..312a6b3d 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/test_packet_id.c</span><br><span>+++=
 b/tests/unit_tests/openvpn/test_packet_id.c</span><br><span>@@ -44,6 +44,7=
 @@</span><br><span>     } test_buf_data;</span><br><span>     struct buffe=
r test_buf;</span><br><span>     struct packet_id_send pis;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc;</span><br><=
span> };</span><br><span> </span><br><span> static int</span><br><span>@@ -=
59,6 +60,7 @@</span><br><span> </span><br><span>     data-&gt;test_buf.data=
 =3D (void *) &amp;data-&gt;test_buf_data;</span><br><span>     data-&gt;te=
st_buf.capacity =3D sizeof(data-&gt;test_buf_data);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    data-&gt;gc =3D gc_new();</span><br><=
span> </span><br><span>     *state =3D data;</span><br><span>     return 0;=
</span><br><span>@@ -67,6 +69,8 @@</span><br><span> static int</span><br><s=
pan> test_packet_id_write_teardown(void **state)</span><br><span> {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct test_packet_id_w=
rite_data *data =3D *state;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    gc_free(&amp;data-&gt;gc);</span><br><span>     free(*state);</=
span><br><span>     return 0;</span><br><span> }</span><br><span>@@ -209,6 =
+213,54 @@</span><br><span>     reliable_free(rel);</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_packet_id=
_write_epoch(void **state)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
test_packet_id_write_data *data =3D *state;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;data-&gt;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* test normal writing of packet id to the=
 buffer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_true(packet_id_write_epoch(&amp;data-&gt;pis, 0x23, &amp;buf));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(buf.len, 8);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    uint8_t expected_header[8] =3D=
 { 0x00, 0x23, 0, 0, 0, 0, 0, 1};</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf), expected_header, 8);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* too small buffer should error ou=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buff=
er buf_short =3D alloc_buf_gc(5, &amp;data-&gt;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(packet_id_write_epoch(&a=
mp;data-&gt;pis, 0xabde, &amp;buf_short));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* test a true 48 bit packet id */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    data-&gt;pis.id =3D 0xfa079ab9d2e8;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf_48 =3D all=
oc_buf_gc(128, &amp;data-&gt;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(packet_id_write_epoch(&amp;data-&gt;pis, 0xff=
fe, &amp;buf_48));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   uint8_t expected_header_48[8] =3D { 0xff, 0xfe, 0xfa, 0x07, 0x9a, 0xb9, =
0xd2, 0xe9};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_memory_equal(BPTR(&amp;buf_48), expected_header_48, 8);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* test writing/checking the 48 bit per epoch pack=
et counter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ov=
erflow */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    data-&=
gt;pis.id =3D 0xfffffffffffe;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct buffer buf_of =3D alloc_buf_gc(128, &amp;data-&gt;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(pac=
ket_id_write_epoch(&amp;data-&gt;pis, 0xf00f, &amp;buf_of));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    uint8_t expected_header_of[8] =
=3D { 0xf0, 0x0f, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff};</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf_of=
), expected_header_of, 8);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* This =
is go over 2^48 - 1 and should error out. */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_false(packet_id_write_epoch(&amp;data-&=
gt;pis, 0xf00f, &amp;buf_of));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* N=
ow read back the packet ids and check if they are the same as what we</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * have written */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct packet_id_n=
et pin;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(packet_id_read_epoch(&amp;pin, &amp;buf), 0x23);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(pin.id, 1);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(packet_id_read_epoch=
(&amp;pin, &amp;buf_48), 0xfffe);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(pin.id, 0xfa079ab9d2e9);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(packet_id_read_epoch(&amp;pin, &a=
mp;buf_of), 0xf00f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(pin.id, 0xffffffffffff);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> static void=
</span><br><span> test_copy_acks_to_lru(void **state)</span><br><span>@@ -2=
96,6 +348,10 @@</span><br><span>         cmocka_unit_test_setup_teardown(te=
st_packet_id_write_long_wrap,</span><br><span>                             =
            test_packet_id_write_setup,</span><br><span>                   =
                      test_packet_id_write_teardown),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_teardown(t=
est_packet_id_write_epoch,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                        test_packet_id_write_setup,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                    test_packet_id_write_teardown),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         cmocka_unit_tes=
t(test_get_num_output_sequenced_available),</span><br><span>         cmocka=
_unit_test(test_copy_acks_to_lru)</span><br><span> </span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/803?usp=3Demail">change 803</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/803?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2a104decdb1e77a460f7a6976bc=
d0560b67a07b5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 803 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--ujAzCLXyDHg=--

