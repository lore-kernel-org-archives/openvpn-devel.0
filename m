Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86483CA5FFF
	for <openvpn-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PQodFuiuUcTwjMb8KBPPtPz2lw0kYQ97H8p+7dLmg0Y=; b=M1zhzFD5jcJvd8GPA4hOviXLxu
	RyDX2E5rjIHfAZMxgMrt5iIOUMVZ5sQy7ZMf11mdOLFVdfzcKLbco5Jms3lKw0rMDTJbx4IkkL0Ee
	FmVc+cg+dZrEPyUKf5d9y11T34ui3lcAQACT9FB9xyPjI0xjYjudbAX3JsL2r4OJwqEs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEXtL-0006Ii-1P;
	Wed, 07 Oct 2026 20:05:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEXtK-0006IX-0M
 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 20:05:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=b6tLuZcSYltmp2w5OMcOwx/ud/8huTyBWtrntGqhSDk=; b=VfK5JfL3xTVgz31aoI0ggCq9b8
 ifh7nEpIHteJS8M9Mzi+eyiOSVZogpeHfsDP6igjN15izLbqCEyYyAUbiRTVdNcny76SJi/GGGJtl
 fSzmnIRieXqZOEegJJGORhNo2KTPV6tX1oZ9UA/LWasEWhJ4O5r61ix/o0T4yXXxOz9Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=b6tLuZcSYltmp2w5OMcOwx/ud/8huTyBWtrntGqhSDk=; b=F
 YLEqYtX3xNlKiRwBd0csGuXMsg5DIzqPhDzCwZyY8fGEfYwpyRizdS/1tvezZkWRUgXsH+LwJOxEt
 9/nyBDPFz0NqwBNfz94YYo7i9D3kd+R6mw+0enLcpidQk0FCBA7spwJH3fhANA4eebgml/lA8c66h
 DolxoprL4fMC7cns=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEXtI-0008TW-Dt for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 20:05:30 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a1635f7c89so44862855e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 07 Oct 2026 13:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791403522; x=1792008322; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=b6tLuZcSYltmp2w5OMcOwx/ud/8huTyBWtrntGqhSDk=;
 b=aG28BBN5IDSZjCx2Bc2NRRRa8dQEvHmO8buvOcpfwgzUFea3FiFO1oTDipDBg1/Oo6
 Ye9ae8RBfUnv6s4DndTmDC1vbRH1Mj6q4CoMtdLmaps2BSjtWVF6vjYgf3PvMllrpBTK
 a1o6fobaHLPS6cF3Xhave6jaAj1ZPrmlsTMyS8PWQO3YEyrtgokEpav7AUpSo3EnPE3Q
 nAgNphFNoPWL8RTr3Pii5+SFXBQaWqzS8I2LJ0P/msTElot9AqHoWv4wpw3f8nsjbBJd
 MJ6xKdEIG5JoXU/s9k8/zN8xVSGTrs43sLZJutkrD8QsU79yWyfaFsEolauYxuZyWPkm
 XLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791403522; x=1792008322;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=b6tLuZcSYltmp2w5OMcOwx/ud/8huTyBWtrntGqhSDk=;
 b=HLw/Qo8iA7Pdb425aCOBOaRWW8JaUI/EK9rrYxuC1lYONpqYWA+xL0fSOsbGs64dSe
 JNjIIYEYP4d5rLjI5IOhX1QofnPWVV1DYw4Lx/5WlzZk8p4X3lY9mmfTa5jGTf9fn7jj
 Wpr7GLzZTcu7o/gxbWJQSsQ5aof31A8/eAxLiVICyiusAl7L87UgJ6FSx2WmhtJkjKtA
 gwxrs8vc8TfC16Z5S+QmsmRjSEfR82+maDvvHbxtjuguacmKqB56WO127vdrA7L9Hpbq
 O0rr3CJNCfYVHQD+ZCiZsTmXDO7wAGfvzEjJM4KN7fCkoeoBvBPIqFa4B3pMwieLX2mN
 QYqw==
X-Gm-Message-State: AFuF++kdRbD60X/xIr2Z9A36Y0rY2FJ4u6ilnhzTHHdMXYkqnHq4KKgW
 yOIg4hpt5t8LxdwDjXmx4+yEjRJ3p6BkoY8faBB0xkw7sTSqRZXJC7LPDe0wgnafElWusw+thUS
 UW1GAbkbuEwoLr37r/5tC4coaHZtHUS2Mla9hGyJfIBKDqgAtxRFMPwKiyD+WDT1qtrTF
X-Gm-Gg: AYBFou2S/DqVcTU00QH1xv7SHOlAFUNsWgIVOonlDDe9z6IyxtG23LlHKOK8Am1UImP
 JpFciW5nkh1zhtInSo7989CTEwhg6OZNN8C5I35D3tuX7PKxhf1QN1+Ke3iOmX1wOTi7FFdkPap
 9M869fcEPaBYUI5uU7Jd2xF/qEHC8itGp2nvkyPnH96dXyz44EbBkErKgG7uQB4mvqvOyyeD0kL
 k+AeUzvgIP8Zt29uCfur37zY2D8MJUkK04Y5wOxpcSJeBRyRfEiVrVekDRQ3mm74JSGzaH+RvKw
 j3P7uHTr80zyJtRtektiez4mzolH8Z0gP97JIhSnHvSF7vl9NtlKZ3YcovowK+OPxfnsO+UTF0v
 j7eRfECqzSw/BbV3Wte7b6c+Al2Lw7EqnBcel+E+tGn+SYYqUB2KTUpXLKoKJzVfyQpQFZhGuwC
 cYAH6/DVmUa/ScrDB4Jr/eV73+BgLCHiuY25NlU+J/eIksHGYZXWR0TxiVpn4dLWvL/jaVKh9fL
 D46BdLBl3m5+oExYuwhp1y8vtyt4MBqqX5OMbAWbYiDG9QLO9+KUeDBkDSXJXLR/7V5paMe/kJu
 23DhDwAqoGxLCn7NnQ6yRHD1ZodgqhPg9tXGFxOfBzC8tcUpUIqA9vOvL3x3
X-Received: by 2002:a05:600c:3e0b:b0:4a0:c02:938c with SMTP id
 5b1f17b1804b1-4a1804459e5mr59463515e9.25.1791403521598; 
 Wed, 07 Oct 2026 13:05:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d2fba1sm6637492f8f.48.2026.10.07.13.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 13:05:21 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 7 Oct 2026 20:05:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03
X-Gerrit-Change-Number: 1899
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1899?usp=email>
X-Gerrit-Commit: 008a20a3952e077b35db9841d2ff9b75cf564cfd
In-Reply-To: <gerrit.1788765781000.Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03@gerrit.openvpn.net>
References: <gerrit.1788765781000.Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzY1NzgxMDAwLklhZjY4YWJmMGQyNTc1ZWU0Y2QzMGRjNGYzZWY2MjdmNmIyMmVjYjAzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1f966f2666d772b3b894ae46c37cde88586ecb45-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEXtI-0008TW-Dt
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0483276164869211269=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0483276164869211269==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5YjBvWCfLuc="; charset=UTF-8

--5YjBvWCfLuc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru=2E

Hello Arne S=
chwabe, 

I'd like you to reexamine a change=2E Please visit

    https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1899?usp=3Demail

to look at the new patc=
h set (#3)=2E

The change is no longer submittable: checks~ChecksSubmitRule=
 is unsatisfied now=2E


Change subject: reliable: characterize the packet =
id comparisons before rewriting them
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

reliable: characterize the packet id comparisons =
before rewriting them

The comparisons are about to lose their 2^31 horizon=
 helpers=2E Pin the
accepted id set at each site first, by sweeping anchors=
 and offsets across
the 0/2^32 wrap and the 0x80000000 midpoint against ref=
erence
implementations of the current behaviour=2E

reliable_not_replay(), =
reliable_wont_break_sequentiality(), the three scans
for the oldest unackno=
wledged entry and the ASSERT in
reliable_mark_active_incoming() had no cove=
rage at all=2E

The receive path is characterized as the verdict ssl=2Ec pr=
oduces
(drop / ack-only / store) rather than as two predicates, because a r=
eplay is
still acknowledged while a sequentiality break is not=2E Its sweep=
 splits at
2^31: reliable_wont_break_sequentiality() compares in absolute t=
erms, so
above that base its accepted set shifts=2E

Change-Id: Iaf68abf0d2=
575ee4cd30dc4f3ef627f6b22ecb03
Signed-off-by: Razvan Cojocaru <razvanc@mail=
box=2Eorg>
---
M tests/unit_tests/openvpn/test_packet_id=2Ec
1 file changed=
, 348 insertions(+), 2 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/99/1899/3

diff --git a/tests/unit_tests/open=
vpn/test_packet_id=2Ec b/tests/unit_tests/openvpn/test_packet_id=2Ec
index =
dc77553=2E=2Eaabb555 100644
--- a/tests/unit_tests/openvpn/test_packet_id=
=2Ec
+++ b/tests/unit_tests/openvpn/test_packet_id=2Ec
@@ -516,6 +516,344 @=
@
     reliable_free(rel);
 }
 
+/*
+ * Reference implementations of the pa=
cket id comparisons as they behave today=2E
+ * The sweeps below assert rel=
iable=2Ec agrees with them at the anchors swept, so
+ * a change to an acce=
pted id set there fails a test=2E Keep them standalone:
+ * expressing them=
 in terms of reliable=2Ec would make the sweeps tautologies=2E
+ */
+
+/* "=
p1 < p2" with the 2^31 horizon, i=2Ee=2E ((int32_t)(p1 - p2) < 0) */
+stati=
c bool
+ref_pid_min(packet_id_type p1, packet_id_type p2)
+{
+    return (p=
acket_id_type)(p1 - p2) >=3D 0x80000000u;
+}
+
+/* one short of RELIABLE_CA=
PACITY, which is what the code accepts today */
+#define CHARACTERIZED_SEND=
_WINDOW 11
+
+/* TLS_RELIABLE_N_SEND_BUFFERS and P_CONTROL_V1, from ssl_pkt=
=2Eh, which this
+ * test binary does not pull in */
+#define CHAR_N_SEND_B=
UFFERS    6
+#define CHAR_OPCODE_CONTROL_V1 4
+
+static bool
+ref_pid_in_se=
nd_window(const struct reliable *rel, packet_id_type pid)
+{
+    const pac=
ket_id_type dist =3D (packet_id_type)(rel->packet_id - pid);
+
+    return =
dist >=3D 1 && dist <=3D CHARACTERIZED_SEND_WINDOW;
+}
+
+static bool
+ref_=
wont_break_sequentiality(const struct reliable *rel, packet_id_type id)
+{
=
+    const packet_id_type base =3D rel->packet_id;
+    const packet_id_typ=
e extent =3D (packet_id_type)rel->size;
+
+    /* char_anchors and char_anc=
hors_high stay clear of the overflow, where
+     * reliable_pid_in_range2(=
) used a 0x80000000 bias instead */
+    assert_true(base + extent >=3D bas=
e);
+
+    return id < base + extent;
+}
+
+static bool
+ref_not_replay(con=
st struct reliable *rel, packet_id_type id)
+{
+    if (ref_pid_min(id, rel=
->packet_id))
+    {
+        return false;
+    }
+
+    for (int i =3D 0;=
 i < rel->size; ++i)
+    {
+        if (rel->array[i]=2Eactive && rel->arr=
ay[i]=2Epacket_id =3D=3D id)
+        {
+            return false;
+       =
 }
+    }
+
+    return true;
+}
+
+/* The receive path verdict as ssl=2Ec =
produces it: stored only if both checks
+ * pass, a replay still ACKed, a s=
equentiality break dropped without an ACK=2E */
+enum recv_verdict
+{
+    =
RECV_DROP,
+    RECV_ACK_ONLY,
+    RECV_STORE
+};
+
+static enum recv_verd=
ict
+recv_filter(const struct reliable *rel, packet_id_type id)
+{
+    if =
(!reliable_wont_break_sequentiality(rel, id))
+    {
+        return RECV_D=
ROP;
+    }
+
+    return reliable_not_replay(rel, id) ? RECV_STORE : RECV_=
ACK_ONLY;
+}
+
+static enum recv_verdict
+ref_recv_filter(const struct reli=
able *rel, packet_id_type id)
+{
+    if (!ref_wont_break_sequentiality(rel=
, id))
+    {
+        return RECV_DROP;
+    }
+
+    return ref_not_repla=
y(rel, id) ? RECV_STORE : RECV_ACK_ONLY;
+}
+
+/* Anchors for rel->packet_i=
d=2E reliable_wont_break_sequentiality() compares id
+ * against rel->packe=
t_id + rel->size in absolute terms, so its accepted set
+ * depends on wher=
e rel->packet_id sits: up to 2^31 that leaves the composite
+ * verdict unc=
hanged, above it it does not, hence the split=2E Bases past
+ * 0xFFFFFFF3 =
are excluded, rel->packet_id + rel->size overflowing there=2E */
+static co=
nst packet_id_type char_anchors[] =3D {
+    0x00000000,
+    0x00000001,
+=
    0x00000005,
+    0x0000000B,
+    0x0000000C,
+    0x0000000D,
+    0x0=
00001F4,
+    0x7FFFFFF4,
+    0x7FFFFFFF,
+    0x80000000,
+};
+
+static c=
onst packet_id_type char_anchors_high[] =3D {
+    0x80000001,
+    0x80000=
00C,
+    0xFFFFFFF0,
+    0xFFFFFFF3,
+};
+
+/* offsets applied below and =
above each anchor */
+static const packet_id_type char_offsets[] =3D {
+   =
 0,
+    1,
+    2,
+    10,
+    11,
+    12,
+    13,
+    14,
+    100,
=
+    0x3FFFFFFF,
+    0x40000000,
+    0x7FFFFFFE,
+    0x7FFFFFFF,
+    0x=
80000000,
+    0x80000001,
+    0x80000002,
+    0xFFFFFFF4,
+    0xFFFFFFF=
E,
+    0xFFFFFFFF,
+};
+
+static void
+sweep_recv_filter(const packet_id_t=
ype *anchors, size_t n_anchors,
+                  enum recv_verdict (*orac=
le)(const struct reliable *, packet_id_type))
+{
+    for (size_t a =3D 0; =
a < n_anchors; a++)
+    {
+        for (size_t o =3D 0; o < SIZE(char_offs=
ets); o++)
+        {
+            /* probe both below and above the anchor=
 */
+            const packet_id_type ids[] =3D {
+                (packet_=
id_type)(anchors[a] - char_offsets[o]),
+                (packet_id_type)(a=
nchors[a] + char_offsets[o]),
+            };
+
+            for (size_t i =
=3D 0; i < SIZE(ids); i++)
+            {
+                struct reliable =
rel =3D { 0 };
+                rel=2Esize =3D RELIABLE_CAPACITY;
+        =
        rel=2Epacket_id =3D anchors[a];
+
+                assert_int_equal=
(oracle(&rel, ids[i]), recv_filter(&rel, ids[i]));
+
+                /* wi=
th the id already in a receive slot it can only be
+                 * ackn=
owledged or dropped, never stored again */
+                rel=2Earray[3]=
=2Eactive =3D true;
+                rel=2Earray[3]=2Epacket_id =3D ids[i];=

+
+                assert_int_equal(oracle(&rel, ids[i]), recv_filter(&rel=
, ids[i]));
+                assert_int_not_equal(RECV_STORE, recv_filter(&=
rel, ids[i]));
+            }
+        }
+    }
+}
+
+/* bases at or below =
2^31, where old and new agree; never to change */
+static void
+test_recv_f=
ilter_characterization(void **state)
+{
+    sweep_recv_filter(char_anchors=
, SIZE(char_anchors), ref_recv_filter);
+}
+
+/* bases above 2^31, where th=
ey diverge, kept apart so a change confined
+ * there touches one test */
+=
static void
+test_recv_filter_high_base(void **state)
+{
+    sweep_recv_fi=
lter(char_anchors_high, SIZE(char_anchors_high), ref_recv_filter);
+}
+
+st=
atic void
+sweep_send_window(const packet_id_type *anchors, size_t n_anchor=
s)
+{
+    for (size_t a =3D 0; a < n_anchors; a++)
+    {
+        for (si=
ze_t o =3D 0; o < SIZE(char_offsets); o++)
+        {
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
       rel=2Esize =3D CHAR_N_SEND_BUFFERS;
+                rel=2Epacket_id=
 =3D anchors[a];
+
+                assert_int_equal(ref_pid_in_send_window=
(&rel, ids[i]),
+                                 validate_packet_id_window=
(&rel, ids[i]) !=3D 0);
+            }
+        }
+    }
+}
+
+/* a pure di=
stance test, so identical at every base */
+static void
+test_send_window_c=
haracterization(void **state)
+{
+    sweep_send_window(char_anchors, SIZE(=
char_anchors));
+    sweep_send_window(char_anchors_high, SIZE(char_anchors=
_high));
+}
+
+/* reliable_send() picks the oldest eligible entry, across t=
he wrap and the
+ * signed midpoint */
+static void
+test_reliable_send_pic=
ks_oldest(void **state)
+{
+    now =3D 1000;
+
+    struct reliable rel =
=3D { 0 };
+    rel=2Esize =3D CHAR_N_SEND_BUFFERS;
+    rel=2Einitial_time=
out =3D 2;
+    rel=2Epacket_id =3D 3;
+
+    /* 6, 2 and 1 below rel->pack=
et_id; the first sits exactly on the window
+     * edge, where rel->size s=
till admits it */
+    const packet_id_type wrapped[] =3D { 0xFFFFFFFD, 1, =
2 };
+
+    for (size_t i =3D 0; i < SIZE(wrapped); i++)
+    {
+        re=
l=2Earray[i]=2Eactive =3D true;
+        rel=2Earray[i]=2Epacket_id =3D wra=
pped[i];
+        rel=2Earray[i]=2Etimeout =3D 2;
+        rel=2Earray[i]=
=2Enext_try =3D 0;
+    }
+
+    int opcode =3D 0;
+    assert_ptr_equal(&r=
el=2Earray[0]=2Ebuf, reliable_send(&rel, &opcode));
+
+    /* same across t=
he signed midpoint */
+    struct reliable rel2 =3D { 0 };
+    rel2=2Esize=
 =3D CHAR_N_SEND_BUFFERS;
+    rel2=2Einitial_timeout =3D 2;
+    rel2=2Epa=
cket_id =3D 0x80000002;
+
+    const packet_id_type midpoint[] =3D { 0x7FFF=
FFFF, 0x80000000, 0x80000001 };
+
+    for (size_t i =3D 0; i < SIZE(midpoi=
nt); i++)
+    {
+        rel2=2Earray[i]=2Eactive =3D true;
+        rel2=
=2Earray[i]=2Epacket_id =3D midpoint[i];
+        rel2=2Earray[i]=2Etimeout=
 =3D 2;
+        rel2=2Earray[i]=2Enext_try =3D 0;
+    }
+
+    assert_ptr=
_equal(&rel2=2Earray[0]=2Ebuf, reliable_send(&rel2, &opcode));
+}
+
+/* rel=
iable_get_buf_output_sequenced() stops issuing ids once rel->packet_id is
+=
 * a full window ahead of the oldest unacknowledged one */
+static void
+te=
st_get_buf_output_sequenced_boundary(void **state)
+{
+    struct reliable =
*rel =3D test_reliable_new();
+
+    rel->array[0]=2Eactive =3D true;
+    =
rel->array[0]=2Epacket_id =3D 100;
+
+    /* distance 7 < size 8: still all=
owed */
+    rel->packet_id =3D 107;
+    assert_non_null(reliable_get_buf_=
output_sequenced(rel));
+
+    /* distance 8 =3D=3D size 8: refused */
+   =
 rel->packet_id =3D 108;
+    assert_null(reliable_get_buf_output_sequenced=
(rel));
+
+    /* same boundary across the wrap */
+    rel->array[0]=2Epac=
ket_id =3D 0xFFFFFFFC;
+    rel->packet_id =3D 3;
+    assert_non_null(reli=
able_get_buf_output_sequenced(rel));
+
+    rel->packet_id =3D 4;
+    asse=
rt_null(reliable_get_buf_output_sequenced(rel));
+
+    reliable_free(rel);=

+}
+
+/* Ids at or just ahead of rel->packet_id are accepted */
+static vo=
id
+test_mark_active_incoming_accepts_window(void **state)
+{
+    struct r=
eliable rel =3D { 0 };
+    rel=2Esize =3D RELIABLE_CAPACITY;
+    rel=2Epa=
cket_id =3D 10;
+
+    reliable_mark_active_incoming(&rel, &rel=2Earray[0]=
=2Ebuf, 10, CHAR_OPCODE_CONTROL_V1);
+    assert_true(rel=2Earray[0]=2Eacti=
ve);
+    assert_int_equal(10, rel=2Earray[0]=2Epacket_id);
+
+    reliable=
_mark_active_incoming(&rel, &rel=2Earray[1]=2Ebuf, 10 + RELIABLE_CAPACITY -=
 1,
+                                  CHAR_OPCODE_CONTROL_V1);
+    assert=
_true(rel=2Earray[1]=2Eactive);
+}
+
+/* Ids below rel->packet_id abort=2E =
The far-ahead case is left unpinned: callers
+ * cannot produce it, and the=
 bound may legitimately tighten=2E
+ *
+ * NOTE: expect_assert_failure() do=
es not work with MSVC=2E It catches the ASSERT
+ * by longjmp()ing out of a=
ssert_failed(), and MSVC's longjmp() unwinds the
+ * intervening frames thr=
ough RtlUnwindEx() instead of just restoring the
+ * registers, which fault=
s=2E */
+#ifndef _MSC_VER
+static void
+test_mark_active_incoming_rejects_p=
ast_ids(void **state)
+{
+    struct reliable rel =3D { 0 };
+    rel=2Esiz=
e =3D RELIABLE_CAPACITY;
+    rel=2Epacket_id =3D 10;
+
+    expect_assert_=
failure(
+        reliable_mark_active_incoming(&rel, &rel=2Earray[0]=2Ebuf=
, 5, CHAR_OPCODE_CONTROL_V1));
+    expect_assert_failure(
+        reliabl=
e_mark_active_incoming(&rel, &rel=2Earray[1]=2Ebuf, 0xFFFFFFFF, CHAR_OPCODE=
_CONTROL_V1));
+}
+#endif /* ifndef _MSC_VER */
+
+
 int
 main(void)
 {
@@ =
-541,8 +879,16 @@
         cmocka_unit_test(test_packet_id_window),
       =
  cmocka_unit_test(test_reliable_backoff_is_bounded),
         cmocka_unit_=
test(test_reliable_purge_ignores_forged_acks),
-        cmocka_unit_test(te=
st_reliable_purge_legitimate_ack)
-
+        cmocka_unit_test(test_reliable=
_purge_legitimate_ack),
+        cmocka_unit_test(test_recv_filter_characte=
rization),
+        cmocka_unit_test(test_recv_filter_high_base),
+        =
cmocka_unit_test(test_send_window_characterization),
+        cmocka_unit_t=
est(test_reliable_send_picks_oldest),
+        cmocka_unit_test(test_get_bu=
f_output_sequenced_boundary),
+        cmocka_unit_test(test_mark_active_in=
coming_accepts_window),
+#ifndef _MSC_VER
+        cmocka_unit_test(test_ma=
rk_active_incoming_rejects_past_ids),
+#endif
     };
 
     return cmocka_=
run_group_tests_name("packet_id tests", tests, NULL, NULL);

-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1899?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaf68abf0d2575ee4cd30dc4f3ef62=
7f6b22ecb03
Gerrit-Change-Number: 1899
Gerrit-PatchSet: 3
Gerrit-Owner: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>

--5YjBvWCfLuc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru=2E </p>
<p>R=C4=83zvan Cojocaru =
<strong>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1899?usp=3Demail">View Change</a>=
</p><p>The change is no longer submittable: checks~ChecksSubmitRule is unsa=
tisfied now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">reliable: characterize the packet id compar=
isons before rewriting them<br><br>The comparisons are about to lose their =
2^31 horizon helpers=2E Pin the<br>accepted id set at each site first, by s=
weeping anchors and offsets across<br>the 0/2^32 wrap and the 0x80000000 mi=
dpoint against reference<br>implementations of the current behaviour=2E<br>=
<br>reliable_not_replay(), reliable_wont_break_sequentiality(), the three s=
cans<br>for the oldest unacknowledged entry and the ASSERT in<br>reliable_m=
ark_active_incoming() had no coverage at all=2E<br><br>The receive path is =
characterized as the verdict ssl=2Ec produces<br>(drop / ack-only / store) =
rather than as two predicates, because a replay is<br>still acknowledged wh=
ile a sequentiality break is not=2E Its sweep splits at<br>2^31: reliable_w=
ont_break_sequentiality() compares in absolute terms, so<br>above that base=
 its accepted set shifts=2E<br><br>Change-Id: Iaf68abf0d2575ee4cd30dc4f3ef6=
27f6b22ecb03<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
;<br>---<br>M tests/unit_tests/openvpn/test_packet_id=2Ec<br>1 file changed=
, 348 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/99/1899/3</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/tests/unit_tests/openvpn/test_packet_id=2Ec b/tests/unit_tests/ope=
nvpn/test_packet_id=2Ec</span><br><span>index dc77553=2E=2Eaabb555 100644</=
span><br><span>--- a/tests/unit_tests/openvpn/test_packet_id=2Ec</span><br>=
<span>+++ b/tests/unit_tests/openvpn/test_packet_id=2Ec</span><br><span>@@ =
-516,6 +516,344 @@</span><br><span>     reliable_free(rel);</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Reference im=
plementations of the packet id comparisons as they behave today=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * The sweeps below assert r=
eliable=2Ec agrees with them at the anchors swept, so</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * a change to an accepted id set there f=
ails a test=2E Keep them standalone:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * expressing them in terms of reliable=2Ec would make the=
 sweeps tautologies=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* &quot;p1 &lt; p2&quot; with t=
he 2^31 horizon, i=2Ee=2E ((int32_t)(p1 - p2) &lt; 0) */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ref_pid_min(packet_id_type p1, packet_id_type =
p2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return (packet_id_type)(p1 - p=
2) &gt;=3D 0x80000000u;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* one short of RELIABLE_CAPACITY=
, which is what the code accepts today */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define CHARACTERIZED_SEND_WINDOW 11</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* TLS_RELIABLE_N_SEND_BUFFERS and P_CONTROL_V1, from s=
sl_pkt=2Eh, which this</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * test binary does not pull in */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define CHAR_N_SEND_BUFFERS    6</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define CHAR_OPCODE_CONTROL_V1 4</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ref_pid_in_send_window(const struct reliable *rel, packet_=
id_type pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const packet_id_type =
dist =3D (packet_id_type)(rel-&gt;packet_id - pid);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return dist &gt;=3D 1 &amp;&amp; dist &lt;=3D CHARACTERI=
ZED_SEND_WINDOW;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ref_wont_break_sequentiality(const struct reliab=
le *rel, packet_id_type id)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
packet_id_type base =3D rel-&gt;packet_id;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const packet_id_type extent =3D (packet_id_type)=
rel-&gt;size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* char_anchors and c=
har_anchors_high stay clear of the overflow, where</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * reliable_pid_in_range2() used a 0x800=
00000 bias instead */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(base + extent &gt;=3D base);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return id &lt; base + extent;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ref_not_replay(const st=
ruct reliable *rel, packet_id_type id)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (ref_pid_min(id, rel-&gt;packet_id))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0=
; i &lt; rel-&gt;size; ++i)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (rel-&gt;array[i]=2Eactive &amp;&amp; rel-&gt;array[i]=2Epacket_id =3D=
=3D id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            return fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The receive path verd=
ict as ssl=2Ec produces it: stored only if both checks</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * pass, a replay still ACKed, a sequent=
iality break dropped without an ACK=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+enum recv_verdict</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    RECV_DROP,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 RECV_ACK_ONLY,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
RECV_STORE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static enum recv_verdict</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+recv_filter(const struct reliable *rel, =
packet_id_type id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!reliable_w=
ont_break_sequentiality(rel, id))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return RECV_DROP;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return reliable_not_rep=
lay(rel, id) ? RECV_STORE : RECV_ACK_ONLY;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static enum re=
cv_verdict</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ref_recv_=
filter(const struct reliable *rel, packet_id_type id)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!ref_wont_break_sequentiality(rel, id))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return RECV_DROP;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return ref_not_replay(rel, id) ? RECV_STORE : RECV_ACK_ONLY;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* Anchors for rel-&gt;packet_id=2E reliable_wont_break_sequenti=
ality() compares id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * against rel-&gt;packet_id + rel-&gt;size in absolute terms, so its accep=
ted set</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * depends o=
n where rel-&gt;packet_id sits: up to 2^31 that leaves the composite</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * verdict unchanged, abov=
e it it does not, hence the split=2E Bases past</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * 0xFFFFFFF3 are excluded, rel-&gt;packet_id +=
 rel-&gt;size overflowing there=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static const packet_id_type char_anchors[] =3D {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    0x00000000,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    0x00000001,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    0x00000005,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    0x0000000B,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    0x0000000C,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    0x0000000D,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    0x000001F4,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    0x7FFFFFF4,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    0x7FFFFFFF,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    0x80000000,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static const packet_id_type c=
har_anchors_high[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    0x80000001,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    0x8000000C,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 0xFFFFFFF0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0xF=
FFFFFF3,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* offsets applied below and above each anchor =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const pack=
et_id_type char_offsets[] =3D {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    2,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    10,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    11,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    12,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    13,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    14,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    100,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x3FFFFFFF,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    0x40000000,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    0x7FFFFFFE,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    0x7FFFFFFF,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    0x80000000,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    0x80000001,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    0x80000002,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    0xFFFFFFF4,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    0xFFFFFFFE,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    0xFFFFFFFF,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+sweep_recv_filter(const packet=
_id_type *anchors, size_t n_anchors,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                  enum recv_verdict (*oracle)(const struct=
 reliable *, packet_id_type))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for =
(size_t a =3D 0; a &lt; n_anchors; a++)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        for (size_t o =3D 0; o &lt; SIZE(char_offsets); o++)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            /* probe both below and ab=
ove the anchor */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          const packet_id_type ids[] =3D {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                (packet_id_type)(anchors[a] - char_o=
ffsets[o]),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        (packet_id_type)(anchors[a] + char_offsets[o]),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            for (size_t i =3D 0; i &lt; SIZE(ids); i++)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                struct reliable r=
el =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          rel=2Esize =3D RELIABLE_CAPACITY;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                rel=2Epacket_id =3D anchors[a];</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                assert_int_equal(oracle(&=
amp;rel, ids[i]), recv_filter(&amp;rel, ids[i]));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                /* with the id already in a receive slot it can =
only be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
     * acknowledged or dropped, never stored again */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                rel=2Earray[3]=2Eactive =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      rel=2Earray[3]=2Epacket_id =3D ids[i];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                assert_int_equal(oracle(&amp;rel, ids[i]), recv_filte=
r(&amp;rel, ids[i]));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                assert_int_not_equal(RECV_STORE, recv_filter(&amp;rel, id=
s[i]));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
bases at or below 2^31, where old and new agree; never to change */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+test_recv_filter_characterization(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    sweep_recv_filter(cha=
r_anchors, SIZE(char_anchors), ref_recv_filter);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* bases=
 above 2^31, where they diverge, kept apart so a change confined</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * there touches one test */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+test_recv_filter_high_base(vo=
id **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    sweep_recv_filter(char=
_anchors_high, SIZE(char_anchors_high), ref_recv_filter);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sweep_s=
end_window(const packet_id_type *anchors, size_t n_anchors)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    for (size_t a =3D 0; a &lt; n_anchors; a++)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        for (size_t o =3D 0; o &lt; SIZ=
E(char_offsets); o++)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    const packet_id_type ids[] =3D {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                (packet_id_type)(anchors[a] - char_offsets=
[o]),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  (packet_id_type)(anchors[a] + char_offsets[o]),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            for (size_t i =3D 0; i &lt; SIZE(ids); i++)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                struct reliable rel =3D=
 { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    rel=2Esize =3D CHAR_N_SEND_BUFFERS;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                rel=2Epacket_id =3D anchors[a];</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                assert_int_equal(ref_pid_in_se=
nd_window(&amp;rel, ids[i]),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                 validate_packet_id_window(&amp;re=
l, ids[i]) !=3D 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* a pure distance test, so identical at every base */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+test_send_window_characterization(void *=
*state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    sweep_send_window(char_anc=
hors, SIZE(char_anchors));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    sweep_send_window(char_anchors_high, SIZE(char_anchors_high));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* reliable_send() picks the oldest eligible entry, across=
 the wrap and the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 signed midpoint */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_rel=
iable_send_picks_oldest(void **state)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    now =3D 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct reliable r=
el =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
l=2Esize =3D CHAR_N_SEND_BUFFERS;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    rel=2Einitial_timeout =3D 2;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    rel=2Epacket_id =3D 3;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* 6, 2 and 1 below rel-&gt;packet_id; the first sits ex=
actly on the window</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * edge, where rel-&gt;size still admits it */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const packet_id_type wrapped[] =3D { 0xF=
FFFFFFD, 1, 2 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D =
0; i &lt; SIZE(wrapped); i++)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    rel=2Earray[i]=2Eactive =3D true;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        rel=2Earray[i]=2Epacket_id =3D wrapped[i];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        rel=2Earray[i]=2Et=
imeout =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  rel=2Earray[i]=2Enext_try =3D 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int opcode =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_e=
qual(&amp;rel=2Earray[0]=2Ebuf, reliable_send(&amp;rel, &amp;opcode));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* same across the signed midpoint */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct reliable=
 rel2 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 rel2=2Esize =3D CHAR_N_SEND_BUFFERS;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    rel2=2Einitial_timeout =3D 2;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    rel2=2Epacket_id =3D 0x80000002;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const packet_id_type midpoint[] =3D {=
 0x7FFFFFFF, 0x80000000, 0x80000001 };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    for (size_t i =3D 0; i &lt; SIZE(midpoint); i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        rel2=2Earray[i]=2Eactive =3D true;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        rel2=2Earray[i]=2Epacket=
_id =3D midpoint[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        rel2=2Earray[i]=2Etimeout =3D 2;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        rel2=2Earray[i]=2Enext_try =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_ptr_equal(&amp;rel2=2Earray[0]=2Ebuf, reliable_send(&=
amp;rel2, &amp;opcode));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* reliable_get_buf_output_seque=
nced() stops issuing ids once rel-&gt;packet_id is</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * a full window ahead of the oldest unackno=
wledged one */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_get_buf_=
output_sequenced_boundary(void **state)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct reliable *rel =3D test_reliable_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    rel-&gt;array[0]=2Eactive =3D true;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    rel-&gt;array[0]=2Epacket_id =3D 100=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* distance 7 &lt; size 8: still =
allowed */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel-&=
gt;packet_id =3D 107;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_non_null(reliable_get_buf_output_sequenced(rel));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* distance 8 =3D=3D size 8: refused */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    rel-&gt;packet_id =3D 1=
08;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(=
reliable_get_buf_output_sequenced(rel));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* same boundary across the wrap */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    rel-&gt;array[0]=2Epacket_id =3D 0xFFFFFFFC;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel-&gt;packet_id =
=3D 3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_no=
n_null(reliable_get_buf_output_sequenced(rel));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    rel-&gt;packet_id =3D 4;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_null(reliable_get_buf_output_sequenced(rel));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    reliable_free(rel);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Ids at or just ahead of rel-&gt;packet_id are accepted */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+test_mark_active_incoming_accepts_windo=
w(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct reliable re=
l =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=
=2Esize =3D RELIABLE_CAPACITY;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    rel=2Epacket_id =3D 10;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    reliable_mark_active_incoming(&amp;rel, &amp;rel=2Earray[0]=2Ebuf, 10, =
CHAR_OPCODE_CONTROL_V1);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(rel=2Earray[0]=2Eactive);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(10, rel=2Earray[0]=2Epacket=
_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    reliable_mark_active_incoming=
(&amp;rel, &amp;rel=2Earray[1]=2Ebuf, 10 + RELIABLE_CAPACITY - 1,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
     CHAR_OPCODE_CONTROL_V1);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(rel=2Earray[1]=2Eactive);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Ids below rel-&gt;packet_id abort=2E The far-ahead case is left unpinned: c=
allers</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * cannot pro=
duce it, and the bound may legitimately tighten=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * NOTE: expect_assert_failure() does not work with MSVC=2E I=
t catches the ASSERT</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * by longjmp()ing out of assert_failed(), and MSVC&#39;s longjmp() unwind=
s the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * intervening=
 frames through RtlUnwindEx() instead of just restoring the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * registers, which faults=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef _MSC_VER</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+test_mark_active_incoming_rejects=
_past_ids(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct rel=
iable rel =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    rel=2Esize =3D RELIABLE_CAPACITY;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    rel=2Epacket_id =3D 10;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    expect_assert_failure(</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        reliable_mark_active_incoming(&amp;rel, &amp;rel=2Ea=
rray[0]=2Ebuf, 5, CHAR_OPCODE_CONTROL_V1));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    expect_assert_failure(</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        reliable_mark_active_incoming(&amp;r=
el, &amp;rel=2Earray[1]=2Ebuf, 0xFFFFFFFF, CHAR_OPCODE_CONTROL_V1));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif /* ifndef _MSC_VER */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> int</span><br><span> main(void)</spa=
n><br><span> {</span><br><span>@@ -541,8 +879,16 @@</span><br><span>       =
  cmocka_unit_test(test_packet_id_window),</span><br><span>         cmocka_=
unit_test(test_reliable_backoff_is_bounded),</span><br><span>         cmock=
a_unit_test(test_reliable_purge_ignores_forged_acks),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_test(test_reliable_purg=
e_legitimate_ack)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_tes=
t(test_reliable_purge_legitimate_ack),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        cmocka_unit_test(test_recv_filter_characterizati=
on),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_=
unit_test(test_recv_filter_high_base),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        cmocka_unit_test(test_send_window_characterizati=
on),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_=
unit_test(test_reliable_send_picks_oldest),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        cmocka_unit_test(test_get_buf_output_sequen=
ced_boundary),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   cmocka_unit_test(test_mark_active_incoming_accepts_window),</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#ifndef _MSC_VER</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_mark_=
active_incoming_rejects_past_ids),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span>     };</span><br><span> </span><br><=
span>     return cmocka_run_group_tests_name(&quot;packet_id tests&quot;, t=
ests, NULL, NULL);</span><br></pre><p>To view, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1899?usp=3Demail">change 1899</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1899?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iaf68abf0d257=
5ee4cd30dc4f3ef627f6b22ecb03 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1899 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--5YjBvWCfLuc=--


--===============0483276164869211269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0483276164869211269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0483276164869211269==--

