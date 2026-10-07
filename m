Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FB8CA6004
	for <openvpn-devel@archiver.kernel.org>; Wed,  7 Oct 2026 21:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=alxwAg+nErT4y7xtLA35UnIlyuW8z7CaweWnGDVvi+s=; b=eGYGvEOKx+Ns4rlsTDCxT0btDv
	GvA7JFqVw6Z8E9k1w48z97Y4cL2loRP31ITGNqNiHUV1JsDn253fPsluzSoqrZzijTGWKXbzeIPGB
	n7hWvSnRgqBFX5ocVCH5RVrxNc+pSOQhbaxNO9jtaqEnI93hpy1gqZAWaQK8XTZSlMiU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEZIX-0005gR-BM;
	Wed, 07 Oct 2026 21:35:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEZIV-0005gA-L0
 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 21:35:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9iDQj4qOalRv1WIsenCJk1qQv5GXBVw8uiYhPboT37I=; b=ShQAHN8rNffV3bhZSiJCoPs6Pg
 yv6exsYdx/0Z7fCfCCl2raCaDiKSbFxkgt4ekGg2B1x712AprSWyoZIWkLtfCIybkYIbxL08iYSQf
 iY0X5j5CA5SMA41WQJVBnPxVEbSl2OQCYnu+3O77/uq+WjY5dewB/bkxw0Jdbyu/5frE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9iDQj4qOalRv1WIsenCJk1qQv5GXBVw8uiYhPboT37I=; b=c
 9BW77ixuAA+oIEwjeVREQmwzB5Lnp/V2sXckMDn6MPuA5hKdgs+g5O6f9Fv0ovPs8Gc7LdvD9cWpG
 46+G/FiYxkoc6qv0ZFHkTFJuHrwiQ3v6f3TTpNRXJa3wsYIuWY+z0hjjQkAE2lfhIOP12789d8hrq
 uU9IK+bR7cx4Gh2k=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEZIT-000684-09 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 21:35:36 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a1698ea378so19936635e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 07 Oct 2026 14:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791408926; x=1792013726; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9iDQj4qOalRv1WIsenCJk1qQv5GXBVw8uiYhPboT37I=;
 b=Yjwfo0mZIYbEU+PyZfk2IehuPwD9KMqcdJsxTV1p7AlVcmYidohb+YEmuGL14BdV/O
 DLcABIhsVPgSXAdivqzqhd7DlqMS3ZIc3YsqCr9ymqkRtH9XYUSV71i/ztlb2ZxJAo1f
 1XveHGAjWPfi3AoHzLHBE8+QDjRl/Vp369L1qpboiulYivSYlSPV3bCIjQSMI2xVTFqc
 KcIHFcKtZ9UmMyoNdeon6dxboXz1FPNj1iWgnWLWOeb6gDxxV6cww+G7zrR4RftJ5Vei
 6WaVbVZmGoh1tnup9ZLxMfRCtzGPgB0vIOS5jVcjBJrHt5QmVUgltekuXkMabJp1fwVv
 AsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791408926; x=1792013726;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9iDQj4qOalRv1WIsenCJk1qQv5GXBVw8uiYhPboT37I=;
 b=xulirebw2KKBufWGsn5qUsZ6HGdOhp2A8I6wZp/v/62+08DDIjoONtu7QAqa6xgIpe
 NgCowIr3zahi51lhch4JoXT5IuHwSoi3e51Oe7d0cvllqpUJEe/pS4xu0a0tvnjrnTHN
 XwXAOIwZaErxsMXaNTqtRY8djYXb9prWEdez27F5auHK9zvu1MJ1xgJkhomn+aX2ijE8
 zOejAqk1RdJZ2uZlgUZJf1wUtQRIlfyDKCfXACgqZ8sxSGAK0sCZykR3vqwm3+f/qJmv
 If0sZhHoMnRFle5HmumJJnrVtvfhh6IAPAt4d83aFk7ysv3JnJS97DkcAI7C2iHTERUK
 h9CA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5KfF0OGp+Nb/4Fe1Nq2cz7lvVaDifxApCHF6Z/01fnYm6GhEZ0dZth9P1uj6nvzua9ZsWSjwpVRWDWImw@lists.sourceforge.net
X-Gm-Message-State: AFuF++lJ14AG1I5lEU2xlOGD5vBATXs2dVx2GH/0IpjCSjuJtj5gcwrj
 iEsVzUuRv8LyI5dvr9sZ+MqYSkz+Ur58OvVKFDXd3P2Mes+4HILdTQN9koU2f66+gnCLL2ge5Dw
 RqQFqhGr838YLJLEgZqU281KbRzw5mngPa/FR/u51iCQG+e+l5QAOifaU14zLc+bjFyZA
X-Gm-Gg: AYBFou3ayHK9pEJGSFKA83mByGCC2tyL8QGj7kQ/866eCF4MxeT3TIFJOR+cLhBcS3e
 qUmcDMlW1qVHCzCjmOYXGRYfAMpzhpKj2EtiFvbtTLzRRjWVZFv2/ylg6OVDFPV8O8IaBDVbZ0C
 QgooV3xRHaMgfVkRLk+Le5F4XgTo6Dfg7Za/cfIY+P/E63sVo2llT0L2O4KPtaEjGfWP2Q2biRv
 e1bvYXzR0X0EMqV9lQRMAW9KCYhZeg0/QWYwaUxRdauXyPaTtjfaD8c8iurJYked4TxhJ6/ZdOO
 oG1KPC71NePRqn+9I7qpSb4I6YTt+inOYZ7bY7zTV3UkbCJR5/QzFYFWFkLJjtwd/axL+g3ERCi
 E5aHqzLQcKvbb3FsUKAawJgA0WJAzSQdr1GhzQkYMUdXVpBaC2vGaK7AyLb+Z3+vBbmO6owL+hQ
 obbzvdQTLF8WqhrEOwIV8wACQwiObOfzOP3d1ctsIPPIgdHH0NGiDDQotVnnkFVZWZIM1tSDmXO
 q0lO0U+0JJiNCZ5bNamrk9abwxpi1DOZkLUjzBdX4FvyApZuEuV+E0fEktSdvHZnNXYuwDqv9BR
 Fcgc5Emjcnh5HzpgdQjei+R9pzi6409U6e+FtqFrN+nVGu3k+o7vPJ8G1fxq
X-Received: by 2002:a05:600c:4e43:b0:4a0:108:3b54 with SMTP id
 5b1f17b1804b1-4a1804557camr53328915e9.32.1791408926231; 
 Wed, 07 Oct 2026 14:35:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1842a3f55sm20664635e9.2.2026.10.07.14.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:35:25 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 7 Oct 2026 21:35:25 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03
X-Gerrit-Change-Number: 1899
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1899?usp=email>
X-Gerrit-Commit: 3a78bd3912607e5a62dad0453d5fc8bc37619073
In-Reply-To: <gerrit.1788765781000.Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03@gerrit.openvpn.net>
References: <gerrit.1788765781000.Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzY1NzgxMDAwLklhZjY4YWJmMGQyNTc1ZWU0Y2QzMGRjNGYzZWY2MjdmNmIyMmVjYjAzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <13f5777b930ab0ad2fe41fbf2156cb45b02060e8-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEZIT-000684-09
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9053758991921046927=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9053758991921046927==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2GPQ8wRuf30="; charset=UTF-8

--2GPQ8wRuf30=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1899?usp=3Demail )

Change subject: reliable: characterize the =
packet id comparisons before rewriting them
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

reliable: characterize the packet id compar=
isons before rewriting them

The comparisons are about to lose their 2^31 h=
orizon helpers=2E Pin the
accepted id set at each site first, by sweeping a=
nchors and offsets across
the 0/2^32 wrap and the 0x80000000 midpoint again=
st reference
implementations of the current behaviour=2E

reliable_not_repl=
ay(), reliable_wont_break_sequentiality(), the three scans
for the oldest u=
nacknowledged entry and the ASSERT in
reliable_mark_active_incoming() had n=
o coverage at all=2E

The receive path is characterized as the verdict ssl=
=2Ec produces
(drop / ack-only / store) rather than as two predicates, beca=
use a replay is
still acknowledged while a sequentiality break is not=2E It=
s sweep splits at
2^31: reliable_wont_break_sequentiality() compares in abs=
olute terms, so
above that base its accepted set shifts=2E

Change-Id: Iaf6=
8abf0d2575ee4cd30dc4f3ef627f6b22ecb03
Signed-off-by: Razvan Cojocaru <razva=
nc@mailbox=2Eorg>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1899
Message-Id: <2026100=
7172007=2E23382-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39760=2Ehtml
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M tests/unit_tests/openvpn/te=
st_packet_id=2Ec
1 file changed, 348 insertions(+), 2 deletions(-)




diff=
 --git a/tests/unit_tests/openvpn/test_packet_id=2Ec b/tests/unit_tests/ope=
nvpn/test_packet_id=2Ec
index dc77553=2E=2Eaabb555 100644
--- a/tests/unit_=
tests/openvpn/test_packet_id=2Ec
+++ b/tests/unit_tests/openvpn/test_packet=
_id=2Ec
@@ -516,6 +516,344 @@
     reliable_free(rel);
 }
 
+/*
+ * Referen=
ce implementations of the packet id comparisons as they behave today=2E
+ *=
 The sweeps below assert reliable=2Ec agrees with them at the anchors swept=
, so
+ * a change to an accepted id set there fails a test=2E Keep them sta=
ndalone:
+ * expressing them in terms of reliable=2Ec would make the sweeps=
 tautologies=2E
+ */
+
+/* "p1 < p2" with the 2^31 horizon, i=2Ee=2E ((int3=
2_t)(p1 - p2) < 0) */
+static bool
+ref_pid_min(packet_id_type p1, packet_i=
d_type p2)
+{
+    return (packet_id_type)(p1 - p2) >=3D 0x80000000u;
+}
+
=
+/* one short of RELIABLE_CAPACITY, which is what the code accepts today */=

+#define CHARACTERIZED_SEND_WINDOW 11
+
+/* TLS_RELIABLE_N_SEND_BUFFERS an=
d P_CONTROL_V1, from ssl_pkt=2Eh, which this
+ * test binary does not pull =
in */
+#define CHAR_N_SEND_BUFFERS    6
+#define CHAR_OPCODE_CONTROL_V1 4
+=

+static bool
+ref_pid_in_send_window(const struct reliable *rel, packet_id=
_type pid)
+{
+    const packet_id_type dist =3D (packet_id_type)(rel->pack=
et_id - pid);
+
+    return dist >=3D 1 && dist <=3D CHARACTERIZED_SEND_WIN=
DOW;
+}
+
+static bool
+ref_wont_break_sequentiality(const struct reliable =
*rel, packet_id_type id)
+{
+    const packet_id_type base =3D rel->packet_=
id;
+    const packet_id_type extent =3D (packet_id_type)rel->size;
+
+    =
/* char_anchors and char_anchors_high stay clear of the overflow, where
+  =
   * reliable_pid_in_range2() used a 0x80000000 bias instead */
+    assert=
_true(base + extent >=3D base);
+
+    return id < base + extent;
+}
+
+sta=
tic bool
+ref_not_replay(const struct reliable *rel, packet_id_type id)
+{
=
+    if (ref_pid_min(id, rel->packet_id))
+    {
+        return false;
+  =
  }
+
+    for (int i =3D 0; i < rel->size; ++i)
+    {
+        if (rel->a=
rray[i]=2Eactive && rel->array[i]=2Epacket_id =3D=3D id)
+        {
+      =
      return false;
+        }
+    }
+
+    return true;
+}
+
+/* The rece=
ive path verdict as ssl=2Ec produces it: stored only if both checks
+ * pas=
s, a replay still ACKed, a sequentiality break dropped without an ACK=2E */=

+enum recv_verdict
+{
+    RECV_DROP,
+    RECV_ACK_ONLY,
+    RECV_STORE
=
+};
+
+static enum recv_verdict
+recv_filter(const struct reliable *rel, pa=
cket_id_type id)
+{
+    if (!reliable_wont_break_sequentiality(rel, id))
+=
    {
+        return RECV_DROP;
+    }
+
+    return reliable_not_replay(r=
el, id) ? RECV_STORE : RECV_ACK_ONLY;
+}
+
+static enum recv_verdict
+ref_r=
ecv_filter(const struct reliable *rel, packet_id_type id)
+{
+    if (!ref_=
wont_break_sequentiality(rel, id))
+    {
+        return RECV_DROP;
+    }=

+
+    return ref_not_replay(rel, id) ? RECV_STORE : RECV_ACK_ONLY;
+}
+
+=
/* Anchors for rel->packet_id=2E reliable_wont_break_sequentiality() compar=
es id
+ * against rel->packet_id + rel->size in absolute terms, so its acce=
pted set
+ * depends on where rel->packet_id sits: up to 2^31 that leaves t=
he composite
+ * verdict unchanged, above it it does not, hence the split=
=2E Bases past
+ * 0xFFFFFFF3 are excluded, rel->packet_id + rel->size over=
flowing there=2E */
+static const packet_id_type char_anchors[] =3D {
+    =
0x00000000,
+    0x00000001,
+    0x00000005,
+    0x0000000B,
+    0x00000=
00C,
+    0x0000000D,
+    0x000001F4,
+    0x7FFFFFF4,
+    0x7FFFFFFF,
+ =
   0x80000000,
+};
+
+static const packet_id_type char_anchors_high[] =3D {=

+    0x80000001,
+    0x8000000C,
+    0xFFFFFFF0,
+    0xFFFFFFF3,
+};
+
=
+/* offsets applied below and above each anchor */
+static const packet_id_=
type char_offsets[] =3D {
+    0,
+    1,
+    2,
+    10,
+    11,
+    12=
,
+    13,
+    14,
+    100,
+    0x3FFFFFFF,
+    0x40000000,
+    0x7FFF=
FFFE,
+    0x7FFFFFFF,
+    0x80000000,
+    0x80000001,
+    0x80000002,
+=
    0xFFFFFFF4,
+    0xFFFFFFFE,
+    0xFFFFFFFF,
+};
+
+static void
+sweep=
_recv_filter(const packet_id_type *anchors, size_t n_anchors,
+            =
      enum recv_verdict (*oracle)(const struct reliable *, packet_id_type))=

+{
+    for (size_t a =3D 0; a < n_anchors; a++)
+    {
+        for (size=
_t o =3D 0; o < SIZE(char_offsets); o++)
+        {
+            /* probe b=
oth below and above the anchor */
+            const packet_id_type ids[] =
=3D {
+                (packet_id_type)(anchors[a] - char_offsets[o]),
+   =
             (packet_id_type)(anchors[a] + char_offsets[o]),
+            }=
;
+
+            for (size_t i =3D 0; i < SIZE(ids); i++)
+            {
+ =
               struct reliable rel =3D { 0 };
+                rel=2Esize =
=3D RELIABLE_CAPACITY;
+                rel=2Epacket_id =3D anchors[a];
+
+=
                assert_int_equal(oracle(&rel, ids[i]), recv_filter(&rel, id=
s[i]));
+
+                /* with the id already in a receive slot it can =
only be
+                 * acknowledged or dropped, never stored again */
=
+                rel=2Earray[3]=2Eactive =3D true;
+                rel=2Ea=
rray[3]=2Epacket_id =3D ids[i];
+
+                assert_int_equal(oracle(=
&rel, ids[i]), recv_filter(&rel, ids[i]));
+                assert_int_not_=
equal(RECV_STORE, recv_filter(&rel, ids[i]));
+            }
+        }
+  =
  }
+}
+
+/* bases at or below 2^31, where old and new agree; never to chan=
ge */
+static void
+test_recv_filter_characterization(void **state)
+{
+   =
 sweep_recv_filter(char_anchors, SIZE(char_anchors), ref_recv_filter);
+}
+=

+/* bases above 2^31, where they diverge, kept apart so a change confined
=
+ * there touches one test */
+static void
+test_recv_filter_high_base(void=
 **state)
+{
+    sweep_recv_filter(char_anchors_high, SIZE(char_anchors_hi=
gh), ref_recv_filter);
+}
+
+static void
+sweep_send_window(const packet_id=
_type *anchors, size_t n_anchors)
+{
+    for (size_t a =3D 0; a < n_anchor=
s; a++)
+    {
+        for (size_t o =3D 0; o < SIZE(char_offsets); o++)
+=
        {
+            const packet_id_type ids[] =3D {
+                (p=
acket_id_type)(anchors[a] - char_offsets[o]),
+                (packet_id_t=
ype)(anchors[a] + char_offsets[o]),
+            };
+
+            for (siz=
e_t i =3D 0; i < SIZE(ids); i++)
+            {
+                struct rel=
iable rel =3D { 0 };
+                rel=2Esize =3D CHAR_N_SEND_BUFFERS;
+=
                rel=2Epacket_id =3D anchors[a];
+
+                assert_i=
nt_equal(ref_pid_in_send_window(&rel, ids[i]),
+                           =
      validate_packet_id_window(&rel, ids[i]) !=3D 0);
+            }
+    =
    }
+    }
+}
+
+/* a pure distance test, so identical at every base */
+=
static void
+test_send_window_characterization(void **state)
+{
+    sweep_=
send_window(char_anchors, SIZE(char_anchors));
+    sweep_send_window(char_=
anchors_high, SIZE(char_anchors_high));
+}
+
+/* reliable_send() picks the =
oldest eligible entry, across the wrap and the
+ * signed midpoint */
+stat=
ic void
+test_reliable_send_picks_oldest(void **state)
+{
+    now =3D 1000=
;
+
+    struct reliable rel =3D { 0 };
+    rel=2Esize =3D CHAR_N_SEND_BUF=
FERS;
+    rel=2Einitial_timeout =3D 2;
+    rel=2Epacket_id =3D 3;
+
+    =
/* 6, 2 and 1 below rel->packet_id; the first sits exactly on the window
+ =
    * edge, where rel->size still admits it */
+    const packet_id_type wr=
apped[] =3D { 0xFFFFFFFD, 1, 2 };
+
+    for (size_t i =3D 0; i < SIZE(wrap=
ped); i++)
+    {
+        rel=2Earray[i]=2Eactive =3D true;
+        rel=
=2Earray[i]=2Epacket_id =3D wrapped[i];
+        rel=2Earray[i]=2Etimeout =
=3D 2;
+        rel=2Earray[i]=2Enext_try =3D 0;
+    }
+
+    int opcode =
=3D 0;
+    assert_ptr_equal(&rel=2Earray[0]=2Ebuf, reliable_send(&rel, &op=
code));
+
+    /* same across the signed midpoint */
+    struct reliable r=
el2 =3D { 0 };
+    rel2=2Esize =3D CHAR_N_SEND_BUFFERS;
+    rel2=2Einitia=
l_timeout =3D 2;
+    rel2=2Epacket_id =3D 0x80000002;
+
+    const packet_=
id_type midpoint[] =3D { 0x7FFFFFFF, 0x80000000, 0x80000001 };
+
+    for (=
size_t i =3D 0; i < SIZE(midpoint); i++)
+    {
+        rel2=2Earray[i]=2E=
active =3D true;
+        rel2=2Earray[i]=2Epacket_id =3D midpoint[i];
+   =
     rel2=2Earray[i]=2Etimeout =3D 2;
+        rel2=2Earray[i]=2Enext_try =
=3D 0;
+    }
+
+    assert_ptr_equal(&rel2=2Earray[0]=2Ebuf, reliable_send=
(&rel2, &opcode));
+}
+
+/* reliable_get_buf_output_sequenced() stops issui=
ng ids once rel->packet_id is
+ * a full window ahead of the oldest unackno=
wledged one */
+static void
+test_get_buf_output_sequenced_boundary(void **=
state)
+{
+    struct reliable *rel =3D test_reliable_new();
+
+    rel->ar=
ray[0]=2Eactive =3D true;
+    rel->array[0]=2Epacket_id =3D 100;
+
+    /*=
 distance 7 < size 8: still allowed */
+    rel->packet_id =3D 107;
+    as=
sert_non_null(reliable_get_buf_output_sequenced(rel));
+
+    /* distance 8=
 =3D=3D size 8: refused */
+    rel->packet_id =3D 108;
+    assert_null(re=
liable_get_buf_output_sequenced(rel));
+
+    /* same boundary across the w=
rap */
+    rel->array[0]=2Epacket_id =3D 0xFFFFFFFC;
+    rel->packet_id =
=3D 3;
+    assert_non_null(reliable_get_buf_output_sequenced(rel));
+
+   =
 rel->packet_id =3D 4;
+    assert_null(reliable_get_buf_output_sequenced(r=
el));
+
+    reliable_free(rel);
+}
+
+/* Ids at or just ahead of rel->pack=
et_id are accepted */
+static void
+test_mark_active_incoming_accepts_windo=
w(void **state)
+{
+    struct reliable rel =3D { 0 };
+    rel=2Esize =3D =
RELIABLE_CAPACITY;
+    rel=2Epacket_id =3D 10;
+
+    reliable_mark_active=
_incoming(&rel, &rel=2Earray[0]=2Ebuf, 10, CHAR_OPCODE_CONTROL_V1);
+    as=
sert_true(rel=2Earray[0]=2Eactive);
+    assert_int_equal(10, rel=2Earray[0=
]=2Epacket_id);
+
+    reliable_mark_active_incoming(&rel, &rel=2Earray[1]=
=2Ebuf, 10 + RELIABLE_CAPACITY - 1,
+                                  CHAR=
_OPCODE_CONTROL_V1);
+    assert_true(rel=2Earray[1]=2Eactive);
+}
+
+/* Id=
s below rel->packet_id abort=2E The far-ahead case is left unpinned: caller=
s
+ * cannot produce it, and the bound may legitimately tighten=2E
+ *
+ * =
NOTE: expect_assert_failure() does not work with MSVC=2E It catches the ASS=
ERT
+ * by longjmp()ing out of assert_failed(), and MSVC's longjmp() unwind=
s the
+ * intervening frames through RtlUnwindEx() instead of just restorin=
g the
+ * registers, which faults=2E */
+#ifndef _MSC_VER
+static void
+tes=
t_mark_active_incoming_rejects_past_ids(void **state)
+{
+    struct reliab=
le rel =3D { 0 };
+    rel=2Esize =3D RELIABLE_CAPACITY;
+    rel=2Epacket_=
id =3D 10;
+
+    expect_assert_failure(
+        reliable_mark_active_inco=
ming(&rel, &rel=2Earray[0]=2Ebuf, 5, CHAR_OPCODE_CONTROL_V1));
+    expect_=
assert_failure(
+        reliable_mark_active_incoming(&rel, &rel=2Earray[1=
]=2Ebuf, 0xFFFFFFFF, CHAR_OPCODE_CONTROL_V1));
+}
+#endif /* ifndef _MSC_VE=
R */
+
+
 int
 main(void)
 {
@@ -541,8 +879,16 @@
         cmocka_unit_test=
(test_packet_id_window),
         cmocka_unit_test(test_reliable_backoff_is=
_bounded),
         cmocka_unit_test(test_reliable_purge_ignores_forged_ack=
s),
-        cmocka_unit_test(test_reliable_purge_legitimate_ack)
-
+      =
  cmocka_unit_test(test_reliable_purge_legitimate_ack),
+        cmocka_uni=
t_test(test_recv_filter_characterization),
+        cmocka_unit_test(test_r=
ecv_filter_high_base),
+        cmocka_unit_test(test_send_window_character=
ization),
+        cmocka_unit_test(test_reliable_send_picks_oldest),
+    =
    cmocka_unit_test(test_get_buf_output_sequenced_boundary),
+        cmoc=
ka_unit_test(test_mark_active_incoming_accepts_window),
+#ifndef _MSC_VER
+=
        cmocka_unit_test(test_mark_active_incoming_rejects_past_ids),
+#end=
if
     };
 
     return cmocka_run_group_tests_name("packet_id tests", tes=
ts, NULL, NULL);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1899?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaf=
68abf0d2575ee4cd30dc4f3ef627f6b22ecb03
Gerrit-Change-Number: 1899
Gerrit-Pa=
tchSet: 4
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>

--2GPQ8wRuf30=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1899?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">reliable: characterize the packet =
id comparisons before rewriting them<br><br>The comparisons are about to lo=
se their 2^31 horizon helpers=2E Pin the<br>accepted id set at each site fi=
rst, by sweeping anchors and offsets across<br>the 0/2^32 wrap and the 0x80=
000000 midpoint against reference<br>implementations of the current behavio=
ur=2E<br><br>reliable_not_replay(), reliable_wont_break_sequentiality(), th=
e three scans<br>for the oldest unacknowledged entry and the ASSERT in<br>r=
eliable_mark_active_incoming() had no coverage at all=2E<br><br>The receive=
 path is characterized as the verdict ssl=2Ec produces<br>(drop / ack-only =
/ store) rather than as two predicates, because a replay is<br>still acknow=
ledged while a sequentiality break is not=2E Its sweep splits at<br>2^31: r=
eliable_wont_break_sequentiality() compares in absolute terms, so<br>above =
that base its accepted set shifts=2E<br><br>Change-Id: Iaf68abf0d2575ee4cd3=
0dc4f3ef627f6b22ecb03<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1899<br>Message-Id: =
&lt;20261007172007=2E23382-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://ww=
w=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39760=2Eh=
tml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<b=
r>M tests/unit_tests/openvpn/test_packet_id=2Ec<br>1 file changed, 348 inse=
rtions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/tests/unit_tests/op=
envpn/test_packet_id=2Ec b/tests/unit_tests/openvpn/test_packet_id=2Ec</spa=
n><br><span>index dc77553=2E=2Eaabb555 100644</span><br><span>--- a/tests/u=
nit_tests/openvpn/test_packet_id=2Ec</span><br><span>+++ b/tests/unit_tests=
/openvpn/test_packet_id=2Ec</span><br><span>@@ -516,6 +516,344 @@</span><br=
><span>     reliable_free(rel);</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Reference implementations of the packe=
t id comparisons as they behave today=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * The sweeps below assert reliable=2Ec agrees with th=
em at the anchors swept, so</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * a change to an accepted id set there fails a test=2E Keep them s=
tandalone:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * expres=
sing them in terms of reliable=2Ec would make the sweeps tautologies=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* &quot;p1 &lt; p2&quot; with the 2^31 horizon, i=2Ee=2E =
((int32_t)(p1 - p2) &lt; 0) */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ref_pid_min(packet_id_type p1, packet_id_type p2)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return (packet_id_type)(p1 - p2) &gt;=3D 0x80000000u;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* one short of RELIABLE_CAPACITY, which is what the code =
accepts today */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine CHARACTERIZED_SEND_WINDOW 11</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* TL=
S_RELIABLE_N_SEND_BUFFERS and P_CONTROL_V1, from ssl_pkt=2Eh, which this</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * test binary does no=
t pull in */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 CHAR_N_SEND_BUFFERS    6</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define CHAR_OPCODE_CONTROL_V1 4</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ref_pid_=
in_send_window(const struct reliable *rel, packet_id_type pid)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const packet_id_type dist =3D (packet_id_type)=
(rel-&gt;packet_id - pid);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return d=
ist &gt;=3D 1 &amp;&amp; dist &lt;=3D CHARACTERIZED_SEND_WINDOW;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
ref_wont_break_sequentiality(const struct reliable *rel, packet_id_type id)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const packet_id_type base =3D rel=
-&gt;packet_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const packet_id_type extent =3D (packet_id_type)rel-&gt;size;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* char_anchors and char_anchors_high stay clear=
 of the overflow, where</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * reliable_pid_in_range2() used a 0x80000000 bias instead */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(base + ex=
tent &gt;=3D base);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return id &lt; =
base + extent;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ref_not_replay(const struct reliable *rel, packet=
_id_type id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ref_pid_min(id, r=
el-&gt;packet_id))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return =
false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; rel-&gt;size; ++i=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (rel-&gt;array[i]=2Ea=
ctive &amp;&amp; rel-&gt;array[i]=2Epacket_id =3D=3D id)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* The receive path verdict as ssl=2Ec produces i=
t: stored only if both checks</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * pass, a replay still ACKed, a sequentiality break dropped with=
out an ACK=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enu=
m recv_verdict</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    RECV_DROP,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    RECV_ACK_ONLY,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    RECV_STORE</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static enum recv_verdict</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+recv_filter(const struct reliable *rel, packet_id_type id)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!reliable_wont_break_sequentiality(r=
el, id))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return RECV_DROP;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return reliable_not_replay(rel, id) ? RECV_STORE=
 : RECV_ACK_ONLY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static enum recv_verdict</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ref_recv_filter(const struct relia=
ble *rel, packet_id_type id)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!=
ref_wont_break_sequentiality(rel, id))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return RECV_DROP;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ref_not_rep=
lay(rel, id) ? RECV_STORE : RECV_ACK_ONLY;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Anchors for=
 rel-&gt;packet_id=2E reliable_wont_break_sequentiality() compares id</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * against rel-&gt;packet=
_id + rel-&gt;size in absolute terms, so its accepted set</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * depends on where rel-&gt;packet_id=
 sits: up to 2^31 that leaves the composite</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * verdict unchanged, above it it does not, hence t=
he split=2E Bases past</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * 0xFFFFFFF3 are excluded, rel-&gt;packet_id + rel-&gt;size overflowing=
 there=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
const packet_id_type char_anchors[] =3D {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    0x00000000,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    0x00000001,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    0x00000005,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    0x0000000B,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    0x0000000C,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    0x0000000D,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  0x000001F4,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x=
7FFFFFF4,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x7FFF=
FFFF,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x80000000=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static const packet_id_type char_anchors_high[] =3D {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x80000001,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x8000000C,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    0xFFFFFFF0,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    0xFFFFFFF3,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* offsets applied below and above each anchor */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static const packet_id_type char_offsets[=
] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    1,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    2,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    10,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    11,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    12,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    13,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    14,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    100,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    0x3FFFFFFF,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    0x40000000,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    0x7FFFFFFE,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    0x7FFFFFFF,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    0x80000000,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    0x80000001,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    0x80000002,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    0xFFFFFFF4,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
0xFFFFFFFE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0xFF=
FFFFFF,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+sweep_recv_filter(const packet_id_type *anchors, size_t =
n_anchors,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
         enum recv_verdict (*oracle)(const struct reliable *, packet_id_typ=
e))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    for (size_t a =3D 0; a &lt; n_=
anchors; a++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (size_t =
o =3D 0; o &lt; SIZE(char_offsets); o++)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            /* probe both below and above the anchor */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            const packet_id_=
type ids[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             (packet_id_type)(anchors[a] - char_offsets[o]),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                (packet_id_type)(a=
nchors[a] + char_offsets[o]),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            };</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fo=
r (size_t i =3D 0; i &lt; SIZE(ids); i++)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                struct reliable rel =3D { 0 };</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                rel=2Esize =3D R=
ELIABLE_CAPACITY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              rel=2Epacket_id =3D anchors[a];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                assert_int_equal(oracle(&amp;rel, ids[i]), recv_filt=
er(&amp;rel, ids[i]));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
/* with the id already in a receive slot it can only be</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                 * acknowledged or drop=
ped, never stored again */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                rel=2Earray[3]=2Eactive =3D true;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                rel=2Earray[3]=2Epacke=
t_id =3D ids[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                assert=
_int_equal(oracle(&amp;rel, ids[i]), recv_filter(&amp;rel, ids[i]));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                assert_int=
_not_equal(RECV_STORE, recv_filter(&amp;rel, ids[i]));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* bases at or below 2^31, where=
 old and new agree; never to change */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+test_recv_filter_characterization(void **state)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    sweep_recv_filter(char_anchors, SIZE(char_anchors)=
, ref_recv_filter);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* bases above 2^31, where they diver=
ge, kept apart so a change confined</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * there touches one test */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+test_recv_filter_high_base(void **state)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    sweep_recv_filter(char_anchors_high, SIZE(char_anch=
ors_high), ref_recv_filter);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+sweep_send_window(const packet_id_ty=
pe *anchors, size_t n_anchors)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for=
 (size_t a =3D 0; a &lt; n_anchors; a++)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        for (size_t o =3D 0; o &lt; SIZE(char_offsets); o++)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            const packet_id_type ids[=
] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    (packet_id_type)(anchors[a] - char_offsets[o]),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                (packet_id_type)(anchors[=
a] + char_offsets[o]),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            for (size=
_t i =3D 0; i &lt; SIZE(ids); i++)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                struct reliable rel =3D { 0 };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                rel=2Esize =3D CHAR_N_S=
END_BUFFERS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         rel=2Epacket_id =3D anchors[a];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                assert_int_equal(ref_pid_in_send_window(&amp;rel, ids[i])=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
               validate_packet_id_window(&amp;rel, ids[i]) !=3D 0);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* a pure distanc=
e test, so identical at every base */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+test_send_window_characterization(void **state)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    sweep_send_window(char_anchors, SIZE(char_anchors))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sweep_send_win=
dow(char_anchors_high, SIZE(char_anchors_high));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* relia=
ble_send() picks the oldest eligible entry, across the wrap and the</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * signed midpoint */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+test_reliable_send_picks_oldest(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    now =3D 1000;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct reliable rel =3D { 0 };</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Esize =3D CHAR_N_SEND_=
BUFFERS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Ei=
nitial_timeout =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    rel=2Epacket_id =3D 3;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* 6, =
2 and 1 below rel-&gt;packet_id; the first sits exactly on the window</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * edge, where rel-&g=
t;size still admits it */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const packet_id_type wrapped[] =3D { 0xFFFFFFFD, 1, 2 };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; SIZE(wrapped); =
i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        rel=2Earray[i]=2Eacti=
ve =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 rel=2Earray[i]=2Epacket_id =3D wrapped[i];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        rel=2Earray[i]=2Etimeout =3D 2;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        rel=2Earray[i]=2Enext_t=
ry =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int opcode =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(&amp;rel=2Earray[0=
]=2Ebuf, reliable_send(&amp;rel, &amp;opcode));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* same across the signed midpoint */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct reliable rel2 =3D { 0 };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    rel2=2Esize =3D CHAR_N_S=
END_BUFFERS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=
2=2Einitial_timeout =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    rel2=2Epacket_id =3D 0x80000002;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const packet_id_type midpoint[] =3D { 0x7FFFFFFF, 0x80000000, 0x80=
000001 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &l=
t; SIZE(midpoint); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
l2=2Earray[i]=2Eactive =3D true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        rel2=2Earray[i]=2Epacket_id =3D midpoint[i];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        rel2=2Earray[i]=2Etim=
eout =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
rel2=2Earray[i]=2Enext_try =3D 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equa=
l(&amp;rel2=2Earray[0]=2Ebuf, reliable_send(&amp;rel2, &amp;opcode));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* reliable_get_buf_output_sequenced() stops issuing ids onc=
e rel-&gt;packet_id is</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * a full window ahead of the oldest unacknowledged one */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_get_buf_output_sequenced_boundary(vo=
id **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct reliable *rel =
=3D test_reliable_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel-&gt;ar=
ray[0]=2Eactive =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    rel-&gt;array[0]=2Epacket_id =3D 100;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* distance 7 &lt; size 8: still allowed */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    rel-&gt;packet_id =3D 107;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(reliabl=
e_get_buf_output_sequenced(rel));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* distance 8 =3D=3D size 8: refused */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    rel-&gt;packet_id =3D 108;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_null(reliable_get_buf_output_seque=
nced(rel));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* same boundary across=
 the wrap */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=
-&gt;array[0]=2Epacket_id =3D 0xFFFFFFFC;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    rel-&gt;packet_id =3D 3;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_non_null(reliable_get_buf_output_=
sequenced(rel));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel-&gt;packet_id =
=3D 4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_nu=
ll(reliable_get_buf_output_sequenced(rel));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    reliable_free(rel);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* Ids at or just ahead of r=
el-&gt;packet_id are accepted */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+test_mark_active_incoming_accepts_window(void **state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct reliable rel =3D { 0 };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    rel=2Esize =3D RELIABLE_CAPACITY;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Epacket_id =
=3D 10;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    reliable_mark_active_incomi=
ng(&amp;rel, &amp;rel=2Earray[0]=2Ebuf, 10, CHAR_OPCODE_CONTROL_V1);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(rel=2Earra=
y[0]=2Eactive);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(10, rel=2Earray[0]=2Epacket_id);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    reliable_mark_active_incoming(&amp;rel, &amp;rel=2Earray[1]=
=2Ebuf, 10 + RELIABLE_CAPACITY - 1,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                  CHAR_OPCODE_CONTROL_V1);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(rel=
=2Earray[1]=2Eactive);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* Ids below rel-&gt;packet_id abo=
rt=2E The far-ahead case is left unpinned: callers</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * cannot produce it, and the bound may legi=
timately tighten=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * NOTE: expect_a=
ssert_failure() does not work with MSVC=2E It catches the ASSERT</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * by longjmp()ing out of asse=
rt_failed(), and MSVC&#39;s longjmp() unwinds the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * intervening frames through RtlUnwindEx() i=
nstead of just restoring the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * registers, which faults=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#ifndef _MSC_VER</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+test_mark_active_incoming_rejects_past_ids(void **state)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct reliable rel =3D { 0 };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Esize =3D RELIABLE_CA=
PACITY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Epa=
cket_id =3D 10;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_assert_failu=
re(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        reliable=
_mark_active_incoming(&amp;rel, &amp;rel=2Earray[0]=2Ebuf, 5, CHAR_OPCODE_C=
ONTROL_V1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    exp=
ect_assert_failure(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        reliable_mark_active_incoming(&amp;rel, &amp;rel=2Earray[1]=2Ebuf, =
0xFFFFFFFF, CHAR_OPCODE_CONTROL_V1));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif /* ifndef _MSC_VER */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> int</span><br><span> main(void)</span><br><span> {</span><br><span>=
@@ -541,8 +879,16 @@</span><br><span>         cmocka_unit_test(test_packet_=
id_window),</span><br><span>         cmocka_unit_test(test_reliable_backoff=
_is_bounded),</span><br><span>         cmocka_unit_test(test_reliable_purge=
_ignores_forged_acks),</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        cmocka_unit_test(test_reliable_purge_legitimate_ack)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        cmocka_unit_test(test_reliable_purge_legitimat=
e_ack),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmoc=
ka_unit_test(test_recv_filter_characterization),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_recv_filter_high=
_base),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmoc=
ka_unit_test(test_send_window_characterization),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_reliable_send_pi=
cks_oldest),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 cmocka_unit_test(test_get_buf_output_sequenced_boundary),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_mark_a=
ctive_incoming_accepts_window),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#ifndef _MSC_VER</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_mark_active_incoming_rejects_past_id=
s),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span>     };</span><br><span> </span><br><span>     return cmocka_run_gro=
up_tests_name(&quot;packet_id tests&quot;, tests, NULL, NULL);</span><br></=
pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1899?usp=3Demail">change 1899</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1899?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1899 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> =
Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--2GPQ8wRuf30=--


--===============9053758991921046927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9053758991921046927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9053758991921046927==--

