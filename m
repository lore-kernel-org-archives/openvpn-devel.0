Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AA6C79F89
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 08:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yifV6Z2UTAfUQM1ybQxEg0VF1389WmAFbdseTNJupPo=; b=LJiM0zXR1GMCprQ9gXPoWOW0Qs
	iVp0MngfJpeHQ392JeZsWreSpnx2FZFqIbIjwDQ7hzGyqDE9umYyLt2p3ZyEWd7ap9nFtrqeBEDqx
	9GJR+UwiLzwTsopx1W2st1q7TDnvhlbKUeIsXE0bOctQUYSq46OVQ/bUphYHb5WFzNYI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3UM4-0006Zg-VB;
	Mon, 07 Sep 2026 08:05:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3ULn-0006ZO-As
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 08:05:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+h+tCGe2lNpSJqvmxwxR4xHTKVmC5Uf40zdkeCoXGYg=; b=L5M0ROOuBNjqmTrMbFqgS1s1Um
 gsUDXJbku9f7IKIj+knKmO2wUEn51jW92oJiVI+QxWL/mEpDLWa4PvI8fDmaaJTFqJYi3kIwaxYYi
 dpAiM0GLQ7sp+VFTMSrfGx+zycargvdEVkNcMdUvcaG9887vj4y44N2JkAXh1TMLF2pA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+h+tCGe2lNpSJqvmxwxR4xHTKVmC5Uf40zdkeCoXGYg=; b=G
 1e9++C3PHxoPjJn8OMmY5nOPUnSxpTmDxyjq7NMB2wi10OtWOwxPHXeiLuOazbUcgIJJOicXbbZn7
 UIUyD6JEfA+24mAHuoayFBGHhy2wPSkz/QyVc0827JLtpqwrSudeWYCR7OOZPyDbkh4JLH8aqlqHk
 UmWnoHiBl/bugSKk=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3ULl-0004f0-5U for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 08:05:11 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48589798dbbso2615485f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 01:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788768302; x=1789373102; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+h+tCGe2lNpSJqvmxwxR4xHTKVmC5Uf40zdkeCoXGYg=;
 b=LMyM00qi3JMGrCuAmyZCTZltcBQbnl9xk2F+BI9nPqRe+bJwNG6/ba8LRDBDIBWb0z
 Awd5zOPKX1TQx1Kshou1/JVwrJ8E/P1NadYSgxiLB6JnhqQNWLyvjbhVAISQIOSkuV1L
 nPhJQY2+ATiJ3l5/BYn7Hn8VXNxvBrhBtdkHq4DYQVwyPxYuMaDNPH24UNSahiuolEtd
 UtQmlL24DN/W6xWj2ajDMSqA81D8xoxumXdnOA6Q1t2t/cg5k8WTt4uOdPiNKe4WiA8H
 iYp/ERG0+HBChkGeG1LKmh1QkxlPHiKWrWylbb7zpjgGfwSYb1YCOuCIqr4BPNAjUp9q
 rzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788768302; x=1789373102;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+h+tCGe2lNpSJqvmxwxR4xHTKVmC5Uf40zdkeCoXGYg=;
 b=QSzH1g99fR5GvbsZ9cu1wTOzL0zoVGWC3H3yVw+1U/g9PGpHiH8n/Uz+Jd8uW0uLXC
 u2eolyywSigx3/FYCpho5Hf2DjEYgGjqV1jlkIpiX/jKqI/02uZunOX2SHdGhiib8SNV
 HrtFnl1YwGZ8M9H+34gIhKHSfSmmnYcfzgLlz7KOgIzbTfIH5SVBBTn4pi/Vk+ND/5xf
 5TgtXJEjsjJTDtkd5QELc1On7gbvBDfai9D9GeoWQqj583XgBcFLMJFvDOZYbQwbTNds
 C9ws5pgGP2CxFXfeUM94Rp7Chtis8hl+22wrJhu3lpnLRPkZ0Rariq0eavVShosbn12a
 /5Dw==
X-Gm-Message-State: AFuF++kpubFnbo5N0fXefYcK5BleptYZEOqaRezRMtqQb6Z6Q9FA6ghe
 ohcVMiz0Gcyl6k7Ye/NlkJiZY8I7v5pofZ+LU7gTOUc66qH5j4ysYoB+JLIihz2czA+8h4gq5Vf
 unx5PYQnAV0tQFxEpZnt6lKopPNYElr0/FShWGldd1ClizX/VuNMBJm8Ct/hfPmBnK4798ZsU1u
 TCm2CWlw==
X-Gm-Gg: AYBFou3bv+6b0CIEXNPoBoKA95gE5iddThXKchEJ4tNdxBfhwXF5xbBVp5417vyOLUl
 fH1CjqgRgxZOCrkTCI5f7egjxNt3rYuDL9BnFITw4zLy7Ia63VW6uwKIf8sqkC2tLZe2VsqC31U
 /04SpjfLgvpar0KXfUDXIXLPSM2n+ROEN3o7xnJnz1ltIkvtL7b6MaN84sEYVmV20Vk68kzF2N8
 deIMh4FelrQ4Nzg55ySb4btHKEnVhA8cxPjU+GwRivf0UuoUf4eXCabF85asWEa+7QTrXsF29gK
 TzmBYlayeJgG/IFRc60Eh+B2s0eXC2sK9JZ6XwTNjqtmEmD4odK8VDvIY38FL2zKzM96SRHonrw
 6VWrWb3Y2VcO96zUQkw0gFMlq4axW6VycJ7Tbj6mVemKLNrDSIsmPJCbnY+mHV77u52t9nQBrMu
 Tp/EosqLab9b6ktdO4UjnNmkbozJuHbYA0e4MORLRDuINMFBLi6OX98WzTEXMZ3PM4+RO9PeykG
 q3X/z3+ZVnOmY2n6O7/x6r3LR8VUIp44Ea8w61dEYXsphunkin0lsvkagMSspDtE8EwUFNysMXN
 GkmsQ0p6TyugutkAPkpoqDdMxn+H16dQLuersTfQIMjcKMvttFc=
X-Received: by 2002:a05:6000:260f:b0:485:8be8:b2ba with SMTP id
 ffacd0b85a97d-4858be8b4bcmr20975059f8f.49.1788768302318; 
 Mon, 07 Sep 2026 01:05:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883acd33sm25570209f8f.18.2026.09.07.01.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 01:05:01 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 08:05:00 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03
X-Gerrit-Change-Number: 1899
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1899?usp=email>
X-Gerrit-Commit: ff9790a5c419a1cc6430aac7aec65764b9151485
In-Reply-To: <gerrit.1788765781000.Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03@gerrit.openvpn.net>
References: <gerrit.1788765781000.Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzY1NzgxMDAwLklhZjY4YWJmMGQyNTc1ZWU0Y2QzMGRjNGYzZWY2MjdmNmIyMmVjYjAzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0253cd66dfdbfd044ea5bb93abb466c7c810003f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3ULl-0004f0-5U
Subject: [Openvpn-devel] [L] Change in openvpn[master]: reliable:
 characterize the packet id comparisons before rewriting them
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2908998574968004581=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2908998574968004581==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EPAZCuGCZ24="; charset=UTF-8

--EPAZCuGCZ24=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1899?usp=3Demail

to look at the new patch set (#2)=2E

=

Change subject: reliable: characterize the packet id comparisons before re=
writing them
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


reliable: characterize the packet id comparisons before rewriting them

T=
he comparisons are about to lose their 2^31 horizon helpers=2E Pin the
acce=
pted id set at each site first, by sweeping anchors and offsets across
the =
0/2^32 wrap and the 0x80000000 midpoint against reference
implementations o=
f the current behaviour=2E

reliable_not_replay(), reliable_wont_break_sequ=
entiality(), the three scans
for the oldest unacknowledged entry and the AS=
SERT in
reliable_mark_active_incoming() had no coverage at all=2E

The rece=
ive path is characterized as the verdict ssl=2Ec produces
(drop / ack-only =
/ store) rather than as two predicates, because a replay is
still acknowled=
ged while a sequentiality break is not=2E Its sweep splits at
2^31: reliabl=
e_wont_break_sequentiality() compares in absolute terms, so
above that base=
 its accepted set shifts=2E

Change-Id: Iaf68abf0d2575ee4cd30dc4f3ef627f6b2=
2ecb03
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M tests/u=
nit_tests/openvpn/test_packet_id=2Ec
1 file changed, 348 insertions(+), 2 d=
eletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/99/1899/2

diff --git a/tests/unit_tests/openvpn/test_packet_id=2Ec b=
/tests/unit_tests/openvpn/test_packet_id=2Ec
index dc77553=2E=2Eaabb555 100=
644
--- a/tests/unit_tests/openvpn/test_packet_id=2Ec
+++ b/tests/unit_test=
s/openvpn/test_packet_id=2Ec
@@ -516,6 +516,344 @@
     reliable_free(rel);=

 }
 
+/*
+ * Reference implementations of the packet id comparisons as the=
y behave today=2E
+ * The sweeps below assert reliable=2Ec agrees with them=
 at the anchors swept, so
+ * a change to an accepted id set there fails a =
test=2E Keep them standalone:
+ * expressing them in terms of reliable=2Ec =
would make the sweeps tautologies=2E
+ */
+
+/* "p1 < p2" with the 2^31 hor=
izon, i=2Ee=2E ((int32_t)(p1 - p2) < 0) */
+static bool
+ref_pid_min(packet=
_id_type p1, packet_id_type p2)
+{
+    return (packet_id_type)(p1 - p2) >=
=3D 0x80000000u;
+}
+
+/* one short of RELIABLE_CAPACITY, which is what the=
 code accepts today */
+#define CHARACTERIZED_SEND_WINDOW 11
+
+/* TLS_RELI=
ABLE_N_SEND_BUFFERS and P_CONTROL_V1, from ssl_pkt=2Eh, which this
+ * test=
 binary does not pull in */
+#define CHAR_N_SEND_BUFFERS    6
+#define CHAR=
_OPCODE_CONTROL_V1 4
+
+static bool
+ref_pid_in_send_window(const struct re=
liable *rel, packet_id_type pid)
+{
+    const packet_id_type dist =3D (pac=
ket_id_type)(rel->packet_id - pid);
+
+    return dist >=3D 1 && dist <=3D =
CHARACTERIZED_SEND_WINDOW;
+}
+
+static bool
+ref_wont_break_sequentiality(=
const struct reliable *rel, packet_id_type id)
+{
+    const packet_id_type=
 base =3D rel->packet_id;
+    const packet_id_type extent =3D (packet_id_t=
ype)rel->size;
+
+    /* char_anchors and char_anchors_high stay clear of t=
he overflow, where
+     * reliable_pid_in_range2() used a 0x80000000 bias =
instead */
+    assert_true(base + extent >=3D base);
+
+    return id < ba=
se + extent;
+}
+
+static bool
+ref_not_replay(const struct reliable *rel, =
packet_id_type id)
+{
+    if (ref_pid_min(id, rel->packet_id))
+    {
+   =
     return false;
+    }
+
+    for (int i =3D 0; i < rel->size; ++i)
+   =
 {
+        if (rel->array[i]=2Eactive && rel->array[i]=2Epacket_id =3D=3D =
id)
+        {
+            return false;
+        }
+    }
+
+    return t=
rue;
+}
+
+/* The receive path verdict as ssl=2Ec produces it: stored only =
if both checks
+ * pass, a replay still ACKed, a sequentiality break droppe=
d without an ACK=2E */
+enum recv_verdict
+{
+    RECV_DROP,
+    RECV_ACK_=
ONLY,
+    RECV_STORE
+};
+
+static enum recv_verdict
+recv_filter(const st=
ruct reliable *rel, packet_id_type id)
+{
+    if (!reliable_wont_break_seq=
uentiality(rel, id))
+    {
+        return RECV_DROP;
+    }
+
+    return=
 reliable_not_replay(rel, id) ? RECV_STORE : RECV_ACK_ONLY;
+}
+
+static en=
um recv_verdict
+ref_recv_filter(const struct reliable *rel, packet_id_type=
 id)
+{
+    if (!ref_wont_break_sequentiality(rel, id))
+    {
+        re=
turn RECV_DROP;
+    }
+
+    return ref_not_replay(rel, id) ? RECV_STORE :=
 RECV_ACK_ONLY;
+}
+
+/* Anchors for rel->packet_id=2E reliable_wont_break_=
sequentiality() compares id
+ * against rel->packet_id + rel->size in absol=
ute terms, so its accepted set
+ * depends on where rel->packet_id sits: up=
 to 2^31 that leaves the composite
+ * verdict unchanged, above it it does =
not, hence the split=2E Bases past
+ * 0xFFFFFFF3 are excluded, rel->packet=
_id + rel->size overflowing there=2E */
+static const packet_id_type char_a=
nchors[] =3D {
+    0x00000000,
+    0x00000001,
+    0x00000005,
+    0x00=
00000B,
+    0x0000000C,
+    0x0000000D,
+    0x000001F4,
+    0x7FFFFFF4,=

+    0x7FFFFFFF,
+    0x80000000,
+};
+
+static const packet_id_type char_=
anchors_high[] =3D {
+    0x80000001,
+    0x8000000C,
+    0xFFFFFFF0,
+  =
  0xFFFFFFF3,
+};
+
+/* offsets applied below and above each anchor */
+sta=
tic const packet_id_type char_offsets[] =3D {
+    0,
+    1,
+    2,
+    =
10,
+    11,
+    12,
+    13,
+    14,
+    100,
+    0x3FFFFFFF,
+    0x4=
0000000,
+    0x7FFFFFFE,
+    0x7FFFFFFF,
+    0x80000000,
+    0x80000001=
,
+    0x80000002,
+    0xFFFFFFF4,
+    0xFFFFFFFE,
+    0xFFFFFFFF,
+};
+=

+static void
+sweep_recv_filter(const packet_id_type *anchors, size_t n_an=
chors,
+                  enum recv_verdict (*oracle)(const struct reliable=
 *, packet_id_type))
+{
+    for (size_t a =3D 0; a < n_anchors; a++)
+    =
{
+        for (size_t o =3D 0; o < SIZE(char_offsets); o++)
+        {
+  =
          /* probe both below and above the anchor */
+            const pa=
cket_id_type ids[] =3D {
+                (packet_id_type)(anchors[a] - cha=
r_offsets[o]),
+                (packet_id_type)(anchors[a] + char_offsets[=
o]),
+            };
+
+            for (size_t i =3D 0; i < SIZE(ids); i++=
)
+            {
+                struct reliable rel =3D { 0 };
+         =
       rel=2Esize =3D RELIABLE_CAPACITY;
+                rel=2Epacket_id =
=3D anchors[a];
+
+                assert_int_equal(oracle(&rel, ids[i]), r=
ecv_filter(&rel, ids[i]));
+
+                /* with the id already in a r=
eceive slot it can only be
+                 * acknowledged or dropped, nev=
er stored again */
+                rel=2Earray[3]=2Eactive =3D true;
+    =
            rel=2Earray[3]=2Epacket_id =3D ids[i];
+
+                asser=
t_int_equal(oracle(&rel, ids[i]), recv_filter(&rel, ids[i]));
+            =
    assert_int_not_equal(RECV_STORE, recv_filter(&rel, ids[i]));
+         =
   }
+        }
+    }
+}
+
+/* bases at or below 2^31, where old and new a=
gree; never to change */
+static void
+test_recv_filter_characterization(vo=
id **state)
+{
+    sweep_recv_filter(char_anchors, SIZE(char_anchors), ref=
_recv_filter);
+}
+
+/* bases above 2^31, where they diverge, kept apart so=
 a change confined
+ * there touches one test */
+static void
+test_recv_fi=
lter_high_base(void **state)
+{
+    sweep_recv_filter(char_anchors_high, S=
IZE(char_anchors_high), ref_recv_filter);
+}
+
+static void
+sweep_send_win=
dow(const packet_id_type *anchors, size_t n_anchors)
+{
+    for (size_t a =
=3D 0; a < n_anchors; a++)
+    {
+        for (size_t o =3D 0; o < SIZE(ch=
ar_offsets); o++)
+        {
+            const packet_id_type ids[] =3D {
=
+                (packet_id_type)(anchors[a] - char_offsets[o]),
+         =
       (packet_id_type)(anchors[a] + char_offsets[o]),
+            };
+
+ =
           for (size_t i =3D 0; i < SIZE(ids); i++)
+            {
+       =
         struct reliable rel =3D { 0 };
+                rel=2Esize =3D CHA=
R_N_SEND_BUFFERS;
+                rel=2Epacket_id =3D anchors[a];
+
+     =
           assert_int_equal(ref_pid_in_send_window(&rel, ids[i]),
+        =
                         validate_packet_id_window(&rel, ids[i]) !=3D 0);
+=
            }
+        }
+    }
+}
+
+/* a pure distance test, so identical=
 at every base */
+static void
+test_send_window_characterization(void **st=
ate)
+{
+    sweep_send_window(char_anchors, SIZE(char_anchors));
+    swee=
p_send_window(char_anchors_high, SIZE(char_anchors_high));
+}
+
+/* reliabl=
e_send() picks the oldest eligible entry, across the wrap and the
+ * signe=
d midpoint */
+static void
+test_reliable_send_picks_oldest(void **state)
+=
{
+    now =3D 1000;
+
+    struct reliable rel =3D { 0 };
+    rel=2Esize =
=3D CHAR_N_SEND_BUFFERS;
+    rel=2Einitial_timeout =3D 2;
+    rel=2Epacke=
t_id =3D 3;
+
+    /* 6, 2 and 1 below rel->packet_id; the first sits exact=
ly on the window
+     * edge, where rel->size still admits it */
+    cons=
t packet_id_type wrapped[] =3D { 0xFFFFFFFD, 1, 2 };
+
+    for (size_t i =
=3D 0; i < SIZE(wrapped); i++)
+    {
+        rel=2Earray[i]=2Eactive =3D =
true;
+        rel=2Earray[i]=2Epacket_id =3D wrapped[i];
+        rel=2Ear=
ray[i]=2Etimeout =3D 2;
+        rel=2Earray[i]=2Enext_try =3D 0;
+    }
+
=
+    int opcode =3D 0;
+    assert_ptr_equal(&rel=2Earray[0]=2Ebuf, reliabl=
e_send(&rel, &opcode));
+
+    /* same across the signed midpoint */
+    s=
truct reliable rel2 =3D { 0 };
+    rel2=2Esize =3D CHAR_N_SEND_BUFFERS;
+ =
   rel2=2Einitial_timeout =3D 2;
+    rel2=2Epacket_id =3D 0x80000002;
+
+ =
   const packet_id_type midpoint[] =3D { 0x7FFFFFFF, 0x80000000, 0x80000001=
 };
+
+    for (size_t i =3D 0; i < SIZE(midpoint); i++)
+    {
+        re=
l2=2Earray[i]=2Eactive =3D true;
+        rel2=2Earray[i]=2Epacket_id =3D m=
idpoint[i];
+        rel2=2Earray[i]=2Etimeout =3D 2;
+        rel2=2Earray=
[i]=2Enext_try =3D 0;
+    }
+
+    assert_ptr_equal(&rel2=2Earray[0]=2Ebuf=
, reliable_send(&rel2, &opcode));
+}
+
+/* reliable_get_buf_output_sequence=
d() stops issuing ids once rel->packet_id is
+ * a full window ahead of the=
 oldest unacknowledged one */
+static void
+test_get_buf_output_sequenced_b=
oundary(void **state)
+{
+    struct reliable *rel =3D test_reliable_new();=

+
+    rel->array[0]=2Eactive =3D true;
+    rel->array[0]=2Epacket_id =3D=
 100;
+
+    /* distance 7 < size 8: still allowed */
+    rel->packet_id =
=3D 107;
+    assert_non_null(reliable_get_buf_output_sequenced(rel));
+
+ =
   /* distance 8 =3D=3D size 8: refused */
+    rel->packet_id =3D 108;
+  =
  assert_null(reliable_get_buf_output_sequenced(rel));
+
+    /* same bound=
ary across the wrap */
+    rel->array[0]=2Epacket_id =3D 0xFFFFFFFC;
+    =
rel->packet_id =3D 3;
+    assert_non_null(reliable_get_buf_output_sequence=
d(rel));
+
+    rel->packet_id =3D 4;
+    assert_null(reliable_get_buf_out=
put_sequenced(rel));
+
+    reliable_free(rel);
+}
+
+/* Ids at or just ahe=
ad of rel->packet_id are accepted */
+static void
+test_mark_active_incomin=
g_accepts_window(void **state)
+{
+    struct reliable rel =3D { 0 };
+    =
rel=2Esize =3D RELIABLE_CAPACITY;
+    rel=2Epacket_id =3D 10;
+
+    relia=
ble_mark_active_incoming(&rel, &rel=2Earray[0]=2Ebuf, 10, CHAR_OPCODE_CONTR=
OL_V1);
+    assert_true(rel=2Earray[0]=2Eactive);
+    assert_int_equal(10=
, rel=2Earray[0]=2Epacket_id);
+
+    reliable_mark_active_incoming(&rel, &=
rel=2Earray[1]=2Ebuf, 10 + RELIABLE_CAPACITY - 1,
+                        =
          CHAR_OPCODE_CONTROL_V1);
+    assert_true(rel=2Earray[1]=2Eactive=
);
+}
+
+/* Ids below rel->packet_id abort=2E The far-ahead case is left un=
pinned: callers
+ * cannot produce it, and the bound may legitimately tight=
en=2E
+ *
+ * NOTE: expect_assert_failure() does not work with MSVC=2E It c=
atches the ASSERT
+ * by longjmp()ing out of assert_failed(), and MSVC's lo=
ngjmp() unwinds the
+ * intervening frames through RtlUnwindEx() instead of=
 just restoring the
+ * registers, which faults=2E */
+#ifndef _MSC_VER
+st=
atic void
+test_mark_active_incoming_rejects_past_ids(void **state)
+{
+   =
 struct reliable rel =3D { 0 };
+    rel=2Esize =3D RELIABLE_CAPACITY;
+   =
 rel=2Epacket_id =3D 10;
+
+    expect_assert_failure(
+        reliable_ma=
rk_active_incoming(&rel, &rel=2Earray[0]=2Ebuf, 5, CHAR_OPCODE_CONTROL_V1))=
;
+    expect_assert_failure(
+        reliable_mark_active_incoming(&rel, =
&rel=2Earray[1]=2Ebuf, 0xFFFFFFFF, CHAR_OPCODE_CONTROL_V1));
+}
+#endif /* =
ifndef _MSC_VER */
+
+
 int
 main(void)
 {
@@ -541,8 +879,16 @@
         cm=
ocka_unit_test(test_packet_id_window),
         cmocka_unit_test(test_relia=
ble_backoff_is_bounded),
         cmocka_unit_test(test_reliable_purge_igno=
res_forged_acks),
-        cmocka_unit_test(test_reliable_purge_legitimate_=
ack)
-
+        cmocka_unit_test(test_reliable_purge_legitimate_ack),
+    =
    cmocka_unit_test(test_recv_filter_characterization),
+        cmocka_un=
it_test(test_recv_filter_high_base),
+        cmocka_unit_test(test_send_wi=
ndow_characterization),
+        cmocka_unit_test(test_reliable_send_picks_=
oldest),
+        cmocka_unit_test(test_get_buf_output_sequenced_boundary),=

+        cmocka_unit_test(test_mark_active_incoming_accepts_window),
+#ifn=
def _MSC_VER
+        cmocka_unit_test(test_mark_active_incoming_rejects_pa=
st_ids),
+#endif
     };
 
     return cmocka_run_group_tests_name("packet_=
id tests", tests, NULL, NULL);

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1899?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03
Gerrit-Change-Numb=
er: 1899
Gerrit-PatchSet: 2
Gerrit-Owner: razvanc <razvanc@mailbox=2Eorg>
G=
errit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos =
<arne-openvpn@rfc2549=2Eorg>

--EPAZCuGCZ24=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>razvanc <strong>uploaded patch s=
et #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1899?usp=3Demail">View Change</a></p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">relia=
ble: characterize the packet id comparisons before rewriting them<br><br>Th=
e comparisons are about to lose their 2^31 horizon helpers=2E Pin the<br>ac=
cepted id set at each site first, by sweeping anchors and offsets across<br=
>the 0/2^32 wrap and the 0x80000000 midpoint against reference<br>implement=
ations of the current behaviour=2E<br><br>reliable_not_replay(), reliable_w=
ont_break_sequentiality(), the three scans<br>for the oldest unacknowledged=
 entry and the ASSERT in<br>reliable_mark_active_incoming() had no coverage=
 at all=2E<br><br>The receive path is characterized as the verdict ssl=2Ec =
produces<br>(drop / ack-only / store) rather than as two predicates, becaus=
e a replay is<br>still acknowledged while a sequentiality break is not=2E I=
ts sweep splits at<br>2^31: reliable_wont_break_sequentiality() compares in=
 absolute terms, so<br>above that base its accepted set shifts=2E<br><br>Ch=
ange-Id: Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03<br>Signed-off-by: Razvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M tests/unit_tests/openvp=
n/test_packet_id=2Ec<br>1 file changed, 348 insertions(+), 2 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/99/1899/2</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/tes=
t_packet_id=2Ec b/tests/unit_tests/openvpn/test_packet_id=2Ec</span><br><sp=
an>index dc77553=2E=2Eaabb555 100644</span><br><span>--- a/tests/unit_tests=
/openvpn/test_packet_id=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/=
test_packet_id=2Ec</span><br><span>@@ -516,6 +516,344 @@</span><br><span>  =
   reliable_free(rel);</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Reference implementations of the packet id compar=
isons as they behave today=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * The sweeps below assert reliable=2Ec agrees with them at the a=
nchors swept, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
a change to an accepted id set there fails a test=2E Keep them standalone:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * expressing them i=
n terms of reliable=2Ec would make the sweeps tautologies=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/* &quot;p1 &lt; p2&quot; with the 2^31 horizon, i=2Ee=2E ((int32_t)(=
p1 - p2) &lt; 0) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ref_pid_=
min(packet_id_type p1, packet_id_type p2)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return (packet_id_type)(p1 - p2) &gt;=3D 0x80000000u;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* one short of RELIABLE_CAPACITY, which is what the code accepts toda=
y */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CHARACT=
ERIZED_SEND_WINDOW 11</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* TLS_RELIABLE_N=
_SEND_BUFFERS and P_CONTROL_V1, from ssl_pkt=2Eh, which this</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * test binary does not pull in */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CHAR_N_SEND=
_BUFFERS    6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e CHAR_OPCODE_CONTROL_V1 4</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ref_pid_in_send_wind=
ow(const struct reliable *rel, packet_id_type pid)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const packet_id_type dist =3D (packet_id_type)(rel-&gt;pac=
ket_id - pid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return dist &gt;=3D =
1 &amp;&amp; dist &lt;=3D CHARACTERIZED_SEND_WINDOW;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ref_wont_br=
eak_sequentiality(const struct reliable *rel, packet_id_type id)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const packet_id_type base =3D rel-&gt;packet=
_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const packe=
t_id_type extent =3D (packet_id_type)rel-&gt;size;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* char_anchors and char_anchors_high stay clear of the ove=
rflow, where</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
reliable_pid_in_range2() used a 0x80000000 bias instead */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(base + extent &gt;=
=3D base);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return id &lt; base + ex=
tent;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ref_not_replay(const struct reliable *rel, packet_id_type i=
d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (ref_pid_min(id, rel-&gt;pac=
ket_id))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (rel-&gt;array[i]=2Eactive &am=
p;&amp; rel-&gt;array[i]=2Epacket_id =3D=3D id)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            return false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* The receive path verdict as ssl=2Ec produces it: stored =
only if both checks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * pass, a replay still ACKed, a sequentiality break dropped without an ACK=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum recv_ver=
dict</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    RECV_DROP,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    RECV_ACK_ONLY,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    RECV_STORE</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c enum recv_verdict</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
recv_filter(const struct reliable *rel, packet_id_type id)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (!reliable_wont_break_sequentiality(rel, id))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return RECV_DROP;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return reliable_not_replay(rel, id) ? RECV_STORE : RECV_=
ACK_ONLY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static enum recv_verdict</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ref_recv_filter(const struct reliable *re=
l, packet_id_type id)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ref_won=
t_break_sequentiality(rel, id))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return RECV_DROP;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return ref_not_replay(rel=
, id) ? RECV_STORE : RECV_ACK_ONLY;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Anchors for rel-&g=
t;packet_id=2E reliable_wont_break_sequentiality() compares id</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * against rel-&gt;packet_id + r=
el-&gt;size in absolute terms, so its accepted set</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * depends on where rel-&gt;packet_id sits: =
up to 2^31 that leaves the composite</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * verdict unchanged, above it it does not, hence the spli=
t=2E Bases past</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * 0=
xFFFFFFF3 are excluded, rel-&gt;packet_id + rel-&gt;size overflowing there=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const =
packet_id_type char_anchors[] =3D {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    0x00000000,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    0x00000001,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    0x00000005,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    0x0000000B,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    0x0000000C,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
0x0000000D,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x00=
0001F4,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x7FFFFF=
F4,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x7FFFFFFF,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x80000000,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static const packet_id_type char_anchors_high[] =3D {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    0x80000001,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    0x8000000C,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    0xFFFFFFF0,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    0xFFFFFFF3,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
 offsets applied below and above each anchor */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static const packet_id_type char_offsets[] =3D =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    1,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    2,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    10,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    11,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    12=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    13,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    14,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    100,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    0x3FFFFFFF,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    0x40000000,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    0x7FFFFFFE,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    0x7FFFFFFF,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    0x80000000,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    0x80000001,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   0x80000002,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0=
xFFFFFFF4,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0xFFF=
FFFFE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0xFFFFFFF=
F,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+sweep_recv_filter(const packet_id_type *anchors, size_t n_anc=
hors,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
    enum recv_verdict (*oracle)(const struct reliable *, packet_id_type))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    for (size_t a =3D 0; a &lt; n_ancho=
rs; a++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (size_t o =3D=
 0; o &lt; SIZE(char_offsets); o++)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            /* probe both below and above the anchor */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            const packet_id_type =
ids[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        (packet_id_type)(anchors[a] - char_offsets[o]),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                (packet_id_type)(anchor=
s[a] + char_offsets[o]),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            for (si=
ze_t i =3D 0; i &lt; SIZE(ids); i++)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                struct reliable rel =3D { 0 };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                rel=2Esize =3D RELIAB=
LE_CAPACITY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         rel=2Epacket_id =3D anchors[a];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                assert_int_equal(oracle(&amp;rel, ids[i]), recv_filter(&a=
mp;rel, ids[i]));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* wi=
th the id already in a receive slot it can only be</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                 * acknowledged or dropped, =
never stored again */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                rel=2Earray[3]=2Eactive =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                rel=2Earray[3]=2Epacket_i=
d =3D ids[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                assert_in=
t_equal(oracle(&amp;rel, ids[i]), recv_filter(&amp;rel, ids[i]));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                assert_int_no=
t_equal(RECV_STORE, recv_filter(&amp;rel, ids[i]));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* bases at or below 2^31, where =
old and new agree; never to change */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+test_recv_filter_characterization(void **state)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    sweep_recv_filter(char_anchors, SIZE(char_anchors),=
 ref_recv_filter);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* bases above 2^31, where they diverg=
e, kept apart so a change confined</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * there touches one test */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+test_recv_filter_high_base(void **state)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    sweep_recv_filter(char_anchors_high, SIZE(char_ancho=
rs_high), ref_recv_filter);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+sweep_send_window(const packet_id_typ=
e *anchors, size_t n_anchors)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for =
(size_t a =3D 0; a &lt; n_anchors; a++)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        for (size_t o =3D 0; o &lt; SIZE(char_offsets); o++)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            const packet_id_type ids[]=
 =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   (packet_id_type)(anchors[a] - char_offsets[o]),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                (packet_id_type)(anchors[a] =
+ char_offsets[o]),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            for (size_t =
i =3D 0; i &lt; SIZE(ids); i++)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                struct reliable rel =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                rel=2Esize =3D CHAR_N_SEN=
D_BUFFERS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       rel=2Epacket_id =3D anchors[a];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                assert_int_equal(ref_pid_in_send_window(&amp;rel, ids[i]),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
             validate_packet_id_window(&amp;rel, ids[i]) !=3D 0);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* a pure distance te=
st, so identical at every base */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+test_send_window_characterization(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    sweep_send_window(char_anchors, SIZE(char_anchors));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    sweep_send_window(=
char_anchors_high, SIZE(char_anchors_high));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* reliable_=
send() picks the oldest eligible entry, across the wrap and the</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * signed midpoint */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_reliable_send_picks_oldest(void =
**state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    now =3D 1000;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct reliable rel =3D { 0 };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    rel=2Esize =3D CHAR_N_SEND_BUFF=
ERS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Einiti=
al_timeout =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  rel=2Epacket_id =3D 3;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* 6, 2 an=
d 1 below rel-&gt;packet_id; the first sits exactly on the window</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * edge, where rel-&gt;si=
ze still admits it */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const packet_id_type wrapped[] =3D { 0xFFFFFFFD, 1, 2 };</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; SIZE(wrapped); i++)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        rel=2Earray[i]=2Eactive =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
l=2Earray[i]=2Epacket_id =3D wrapped[i];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        rel=2Earray[i]=2Etimeout =3D 2;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        rel=2Earray[i]=2Enext_try =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int opcode =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(&amp;rel=2Earray[0]=2Eb=
uf, reliable_send(&amp;rel, &amp;opcode));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* same across the signed midpoint */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct reliable rel2 =3D { 0 };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    rel2=2Esize =3D CHAR_N_SEND_B=
UFFERS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel2=2Ei=
nitial_timeout =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    rel2=2Epacket_id =3D 0x80000002;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const packet_id_type midpoint[] =3D { 0x7FFFFFFF, 0x80000000, 0x8000000=
1 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; SI=
ZE(midpoint); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        rel2=2E=
array[i]=2Eactive =3D true;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        rel2=2Earray[i]=2Epacket_id =3D midpoint[i];</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        rel2=2Earray[i]=2Etimeout =
=3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        rel2=
=2Earray[i]=2Enext_try =3D 0;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(&a=
mp;rel2=2Earray[0]=2Ebuf, reliable_send(&amp;rel2, &amp;opcode));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* reliable_get_buf_output_sequenced() stops issuing ids once rel-=
&gt;packet_id is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
a full window ahead of the oldest unacknowledged one */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+test_get_buf_output_sequenced_boundary(void **s=
tate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct reliable *rel =3D tes=
t_reliable_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel-&gt;array[0]=
=2Eactive =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    rel-&gt;array[0]=2Epacket_id =3D 100;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* distance 7 &lt; size 8: still allowed */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    rel-&gt;packet_id =3D 107;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(reliable_get_=
buf_output_sequenced(rel));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* dist=
ance 8 =3D=3D size 8: refused */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    rel-&gt;packet_id =3D 108;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_null(reliable_get_buf_output_sequenced(r=
el));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* same boundary across the w=
rap */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel-&gt;a=
rray[0]=2Epacket_id =3D 0xFFFFFFFC;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    rel-&gt;packet_id =3D 3;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_non_null(reliable_get_buf_output_sequen=
ced(rel));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    rel-&gt;packet_id =3D 4;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(rel=
iable_get_buf_output_sequenced(rel));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   reliable_free(rel);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* Ids at or just ahead of rel-&gt=
;packet_id are accepted */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
est_mark_active_incoming_accepts_window(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct reliable rel =3D { 0 };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    rel=2Esize =3D RELIABLE_CAPACITY;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Epacket_id =3D 10=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    reliable_mark_active_incoming(&am=
p;rel, &amp;rel=2Earray[0]=2Ebuf, 10, CHAR_OPCODE_CONTROL_V1);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(rel=2Earray[0]=
=2Eactive);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(10, rel=2Earray[0]=2Epacket_id);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    reliable_mark_active_incoming(&amp;rel, &amp;rel=2Earray[1]=2Ebu=
f, 10 + RELIABLE_CAPACITY - 1,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                  CHAR_OPCODE_CONTROL_V1);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(rel=2Earr=
ay[1]=2Eactive);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* Ids below rel-&gt;packet_id abort=2E =
The far-ahead case is left unpinned: callers</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * cannot produce it, and the bound may legitimate=
ly tighten=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * NOTE: expect_assert_=
failure() does not work with MSVC=2E It catches the ASSERT</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * by longjmp()ing out of assert_fai=
led(), and MSVC&#39;s longjmp() unwinds the</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * intervening frames through RtlUnwindEx() instead=
 of just restoring the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * registers, which faults=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#ifndef _MSC_VER</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+test_mark_active_incoming_rejects_past_ids(void **state)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct reliable rel =3D { 0 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    rel=2Esize =3D RELIABLE_CAPACITY=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Epacket_i=
d =3D 10;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    expect_assert_failure(</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        reliable_mark_=
active_incoming(&amp;rel, &amp;rel=2Earray[0]=2Ebuf, 5, CHAR_OPCODE_CONTROL=
_V1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_as=
sert_failure(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  reliable_mark_active_incoming(&amp;rel, &amp;rel=2Earray[1]=2Ebuf, 0xFFFF=
FFFF, CHAR_OPCODE_CONTROL_V1));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
 /* ifndef _MSC_VER */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> int</span><br><span> main(void)</span><br><span> {</span><br><span>@@ -54=
1,8 +879,16 @@</span><br><span>         cmocka_unit_test(test_packet_id_win=
dow),</span><br><span>         cmocka_unit_test(test_reliable_backoff_is_bo=
unded),</span><br><span>         cmocka_unit_test(test_reliable_purge_ignor=
es_forged_acks),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   cmocka_unit_test(test_reliable_purge_legitimate_ack)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        cmocka_unit_test(test_reliable_purge_legitimate_ack)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_uni=
t_test(test_recv_filter_characterization),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        cmocka_unit_test(test_recv_filter_high_base)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_uni=
t_test(test_send_window_characterization),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        cmocka_unit_test(test_reliable_send_picks_ol=
dest),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmock=
a_unit_test(test_get_buf_output_sequenced_boundary),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_mark_active=
_incoming_accepts_window),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#ifndef _MSC_VER</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmocka_unit_test(test_mark_active_incoming_rejects_past_ids),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n>     };</span><br><span> </span><br><span>     return cmocka_run_group_te=
sts_name(&quot;packet_id tests&quot;, tests, NULL, NULL);</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1899?usp=3Demail">change 1899</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1899?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Iaf68abf0d2575ee4cd30dc4f3ef627f6b2=
2ecb03 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1899 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=


</body></html>
--EPAZCuGCZ24=--


--===============2908998574968004581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2908998574968004581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2908998574968004581==--

