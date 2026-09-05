Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE0FC79F8B
	for <openvpn-devel@archiver.kernel.org>; Sat,  5 Sep 2026 09:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q0B+e3VgTBhQkFRHg3tPQqAthycN0wRrHfC9+1Dwysw=; b=CXzPWay7LoVya5YXA0M5pwXWG7
	sOpF0qjjJfjrM0OwnatKMnFEX67LyRCmob2DFMbzXDOyuudavT5FUItKAJbkDUHWyURN8it0ywq3B
	SraQ6PihkA8+WEBpvHjHAR6shr/dOKyhjOkWRbTD4nBe3/UKnUgvzsmur429kVDorwe8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2mgb-0003E7-3t;
	Sat, 05 Sep 2026 09:27:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x2mgZ-0003E0-AY
 for openvpn-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 09:27:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=N2k2+3w8tZgD4t/jubRrXm2bnUtIOGj6AEXe8+Za7QU=; b=Uk7kEG23fUB10ig5LhhaMp2cvL
 u1/WZhbHUr5NZVswLMjmR9UKsxDTNk2TNJnEiRp7vJhs//m2BkiKm9ik+8C/rHPlKdfvYn+lrVn7P
 Iur702TW22LMc3UxXl/k4CbBOdol2Xp+RZu8pKmP/KXjY3liIE98hGU19HqtKdiaGi/Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=N2k2+3w8tZgD4t/jubRrXm2bnUtIOGj6AEXe8+Za7QU=; b=h
 jXMHrrZP44Or8zuNim6VdYx47YqGAHxamI1YbbTXQl3QeWrltuQeuWuFO4VECvPbDsEEwWgbNtyCS
 RLnxbIXF/nY9anbEBWyGn4WKexzmHhNSf4vwNm5Xxfzkoh8jahFRU/pFH+doQePwPow9GzejdDwnZ
 gMyQ4ZYGVDke7BKs=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2mgX-0001ie-QG for openvpn-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 09:27:43 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49b0dd3c9a0so16406505e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 05 Sep 2026 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788600455; x=1789205255; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=N2k2+3w8tZgD4t/jubRrXm2bnUtIOGj6AEXe8+Za7QU=;
 b=NoW6fQHolOQIa8+Ofbp6U5RtdPmBv+fT+D08tPRZL3O1Mv84BsStfgZQgGQeGXKGyV
 Zss/ZndOTRMaZ7ZO9V/wvIXZcPPUVNVKXkZ/hCnbX+6TFH0YPfx8PvolbICOALENQIi5
 WLN60+A1ZAq9oulyyr3fqvs1pZYpZquUb2EAZpI9K2TYV2FwactN+tRDqg4yWHfz3eN6
 fERenjk3OjvBs6KcYR7iVi/l8ClnXlvUrkSRY8Z+8Ryj1efQyXHiJOLzRvneGAuFGei8
 +SIF6cVa5v/HSC0NPqfQKkauHNzexoA3hXCy5ir4mfXo9Dmxex1B1u6P7CbthAmB6fbm
 4QIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788600455; x=1789205255;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=N2k2+3w8tZgD4t/jubRrXm2bnUtIOGj6AEXe8+Za7QU=;
 b=pKnXWsY0F9wjzHS1LlOgGoFfL/levGcyNqVB8wpCv6l5d64tNSswfR0kghPnuC+iHh
 CgFfSHv/C1cFojW3TJSPhr3obd3Wf6IpSNzVrRypE89YpXYQU+85y+jPRAElrewYEqwC
 6Ry4KKUgYDWHcZuWPxiM8OmstDWPhUej10ecJyTa1tymPi1ThPtyohkbdU58bBQiAZez
 D2NEx4w9O2GS3efAONytYCaLYvMrLxmUf8XQKZUrXQCTS37vRA3E9+vArUbVh8vVRaA5
 oVQhsWNHN+1KdWwy6W1XhZML+u6j4T9+Cvhlk5lZKuHYVGwbZIeT8GOX76WaXhAfsrQS
 /BNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByQnoVqduXMlrf7HZ1lpm6dZSH8pP3dyMPFfIDrN5A8WVaH6trn33XnoMTVsCs1wfeIKI51iyPrZYu+Xu3h@lists.sourceforge.net
X-Gm-Message-State: AFuF++n+3xzLjaHXCH0cAoVIOicC2u6r+wPy+U2kKz3SrDxMxX7Zaqg9
 58D4YNjJ8PT8E/UE7zxmLntJCAVc1xorISZ+AcV6Jv93HlPc47NO7um5Mt4NlZ+fxdtFPQyc/bC
 MvXOckLhZZNyhImSwBUQnZAyvWYFP9fHv96JpEF1aFeOK+SBo7fAViJkSkU6jdHZti9su
X-Gm-Gg: AYBFou0Al9EGkeYgmO5T3PK/ESD2gI9CbpExaGgKM7FlwGftHwmQckT3MOG4IYxNvyL
 rYvScaumsMH7eBZoiDH4Dg7o79BQE6sTXAD5XNqDyzKrvzlzzaPuZJoF7uLSCEJWbLwnCDu/v+d
 LEPXQlHIJl7s9wH2UGxQNK21pb4Sjri7B4Ape5AGcbG6oY2CEG8BVhde3sFyYUtgbl2SaHQoNJy
 di8Zwps583chT/4J1CEtj1g/DNTTKbE8jvZUXVcNefpg7UPQTuPUWWvKqN1wMAGwxw/73yVpFul
 oVuWdJj1E0NUM+SIMNYT5pG/SsCKToNzvqkqj5+Co7FGfAZwJQWdVvcxgRFusQXOrHW1SeK+4+M
 /aDQg39zGOLedTd3VfEIbzQfc/Z+HcOkNiM/F1VG4HJ5WSgPod1A5KSxI3un3DVzmZfrD6/KAtH
 lCAcipAO/ZTU7XM6Wyt00uGeN5mQimtqAw2I6BxWZffpCQo8qVVTTpp45vRB8l/OS6WyaZ011bN
 5sggJujkJjALnqle/n/lgwqsvad+DL/NUoZSAxmibicf74oZ3LCOEtsDv8DOMMqsT3i1QytPCpJ
 lpAo0BXRhSR1RvJVtxo0Iwu2CZu0exazh1+JkSIERwpQtIZEl0Q=
X-Received: by 2002:a05:600c:3496:b0:499:b65d:1250 with SMTP id
 5b1f17b1804b1-49cf7fe62admr202676105e9.2.1788600455045; 
 Sat, 05 Sep 2026 02:27:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c6ba4sm14092566f8f.25.2026.09.05.02.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 02:27:34 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 5 Sep 2026 09:27:34 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I3c6ad247614fb204a279b73e98f8c4704e16da2a
X-Gerrit-Change-Number: 1894
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1894?usp=email>
X-Gerrit-Commit: c9b8ca1795957f2e22dad1589479bd32faea4fc1
In-Reply-To: <gerrit.1788416209000.I3c6ad247614fb204a279b73e98f8c4704e16da2a@gerrit.openvpn.net>
References: <gerrit.1788416209000.I3c6ad247614fb204a279b73e98f8c4704e16da2a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NDE2MjA5MDAwLkkzYzZhZDI0NzYxNGZiMjA0YTI3OWI3M2U5OGY4YzQ3MDRlMTZkYTJhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <14d2d3aa88784938142e9a4fd7b184c2cbfbc4dd-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x2mgX-0001ie-QG
Subject: [Openvpn-devel] [M] Change in openvpn[master]: reliable: add unit
 tests for ACK and backoff DoS hardening
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4208551260947743352=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4208551260947743352==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yA62SifLVOo="; charset=UTF-8

--yA62SifLVOo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1894?usp=3Demail )

Change subject: reliable: add unit tests for ACK an=
d backoff DoS hardening
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

reliable: add unit tests for ACK and backoff DoS hardening

Add =
regression coverage for the reliability-layer denial-of-service fix
to test=
_packet_id, which already links reliable=2Ec:

 - the retransmission timeou=
t must stay positive and bounded no matter how
   often the fast-retransmit=
 path is forced, so it can no longer overflow;
 - reliable_send_purge() mus=
t ignore ACKs for packet IDs that could never
   have been in flight (out o=
f the send window, or wrapped-around), so a
   peer cannot inflate n_acks a=
nd force early retransmits;
 - a legitimate ACK for a real higher packet ID=
 still removes that entry
   and counts towards fast retransmit (positive c=
ontrol)=2E

These tests fail on the unfixed code and pass with the fix=2E

=
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
Acked-by: Razvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1894
Change-Id: I3c6ad247614fb204a279b73e98f8c4704e16da2a
Message-Id: <2=
0260904160848=2E5553-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-arc=
hive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38948=2Ehtml
Signed-o=
ff-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M tests/unit_tests/openvp=
n/test_packet_id=2Ec
1 file changed, 148 insertions(+), 1 deletion(-)




d=
iff --git a/tests/unit_tests/openvpn/test_packet_id=2Ec b/tests/unit_tests/=
openvpn/test_packet_id=2Ec
index a5d50de=2E=2Edc77553 100644
--- a/tests/un=
it_tests/openvpn/test_packet_id=2Ec
+++ b/tests/unit_tests/openvpn/test_pac=
ket_id=2Ec
@@ -372,6 +372,150 @@
 }
 
 
+/* The fix keeps the timeout well =
below this; the broken code grows past it=2E
+ * A plain number, so the tes=
t builds with or without the fix=2E */
+#define SANE_TIMEOUT_BOUND (10 * 10=
00 * 1000)
+
+static struct reliable *
+test_reliable_new(void)
+{
+    str=
uct reliable *rel =3D malloc(sizeof(struct reliable));
+    assert_non_null=
(rel);
+    /* reliable_init() zeroes everything, so each test only sets th=
e
+     * fields it actually needs=2E */
+    reliable_init(rel, 100, 50, 8=
, false);
+    rel->initial_timeout =3D 2;
+    return rel;
+}
+
+/*
+ * Ea=
ch retransmit doubles the timeout=2E If a peer keeps forcing retransmits,
+=
 * the broken code doubles it forever: after about 30 rounds it overflows a=
nd
+ * turns zero or negative, and then the packet is resent nonstop (the f=
lood)=2E
+ * The fix caps the doubling=2E This test forces many retransmits=
 and checks the
+ * timeout never overflows or grows without limit=2E
+ */
=
+static void
+test_reliable_backoff_is_bounded(void **state)
+{
+    (void)=
state;
+    now =3D 1000;
+
+    struct reliable *rel =3D test_reliable_new=
();
+
+    struct reliable_entry *e =3D &rel->array[0];
+    e->active =3D =
true;
+    e->packet_id =3D 1;
+    e->timeout =3D rel->initial_timeout;
+ =
   rel->packet_id =3D 2;
+
+    for (int i =3D 0; i < 40; ++i)
+    {
+    =
    /* make the packet due for a fast retransmit */
+        e->n_acks =3D =
N_ACK_RETRANSMIT;
+
+        int opcode;
+        struct buffer *buf =3D re=
liable_send(rel, &opcode);
+        /* our one active packet is the one pic=
ked to send */
+        assert_ptr_equal(buf, &e->buf);
+
+        /* a zer=
o or negative timeout would resend with no delay (the flood) */
+        as=
sert_true(e->timeout > 0);
+        /* the timeout must stop growing, not d=
ouble forever */
+        assert_true(e->timeout <=3D SANE_TIMEOUT_BOUND);
=
+    }
+
+    reliable_free(rel);
+}
+
+/*
+ * An ACK should only count if =
it is for a packet we actually sent=2E If the
+ * broken code accepts ACKs =
for packets that were never sent, a peer can force
+ * early retransmits at=
 will (which then feeds the timeout overflow above)=2E
+ * These two cases =
send such bogus ACKs and check they are ignored=2E
+ */
+static void
+test_=
reliable_purge_ignores_forged_acks(void **state)
+{
+    (void)state;
+
+  =
  /* Case (a): an ACK for pid 0x40000000, which we never sent (we only sent=

+     * 0 and 1)=2E The old "e->packet_id < pid" check treats it as newer =
and
+     * counts it=2E It should be ignored=2E */
+    {
+        struct =
reliable *rel =3D test_reliable_new();
+        struct reliable_entry *e =
=3D &rel->array[0];
+        e->active =3D true;
+        e->packet_id =3D =
1;
+        rel->packet_id =3D 2; /* only pids 0 and 1 were ever sent */
+
=
+        struct reliable_ack ack =3D { =2Elen =3D 1, =2Epacket_id =3D { 0x4=
0000000 } };
+        reliable_send_purge(rel, &ack);
+
+        /* the bog=
us ACK must not be counted */
+        assert_int_equal(e->n_acks, 0);
+   =
     /* and must not drop our real packet */
+        assert_true(e->active=
);
+        reliable_free(rel);
+    }
+
+    /* Case (b): an ACK for pid 0=
xFFFFFFFF=2E It is inside the send window, so
+     * it passes the window =
check, but ids wrap around and 0xFFFFFFFF is really
+     * older than our =
pid 1=2E A plain "<" thinks it is newer and counts it; the
+     * wraparou=
nd-aware comparison must not=2E */
+    {
+        struct reliable *rel =3D=
 test_reliable_new();
+        struct reliable_entry *e =3D &rel->array[0];=

+        e->active =3D true;
+        e->packet_id =3D 1;
+        rel->pa=
cket_id =3D 2;
+
+        struct reliable_ack ack =3D { =2Elen =3D 1, =2Epa=
cket_id =3D { 0xFFFFFFFF } };
+        reliable_send_purge(rel, &ack);
+
+ =
       /* the bogus ACK must not be counted */
+        assert_int_equal(e-=
>n_acks, 0);
+        /* and must not drop our real packet */
+        asse=
rt_true(e->active);
+        reliable_free(rel);
+    }
+}
+
+/*
+ * Sanity=
 check: a real ACK must still work=2E Acknowledging a higher packet
+ * sho=
uld drop that packet and count once towards resending the older one=2E
+ * =
The fix must not break this=2E
+ */
+static void
+test_reliable_purge_legit=
imate_ack(void **state)
+{
+    (void)state;
+
+    struct reliable *rel =
=3D test_reliable_new();
+
+    struct reliable_entry *e0 =3D &rel->array[0=
];
+    e0->active =3D true;
+    e0->packet_id =3D 1;
+
+    struct reliab=
le_entry *e1 =3D &rel->array[1];
+    e1->active =3D true;
+    e1->packet_=
id =3D 2;
+
+    rel->packet_id =3D 3; /* pids 0,1,2 sent; 1 and 2 still wa=
iting */
+
+    struct reliable_ack ack =3D { =2Elen =3D 1, =2Epacket_id =
=3D { 2 } };
+    reliable_send_purge(rel, &ack);
+
+    /* packet 2 was ac=
ked, so it is dropped */
+    assert_false(e1->active);
+    /* packet 1 is=
 older, so it gets one ACK towards an early resend */
+    assert_int_equal=
(e0->n_acks, 1);
+    /* packet 1 was not acked, so it stays */
+    assert=
_true(e0->active);
+
+    reliable_free(rel);
+}
+
 int
 main(void)
 {
@@ -=
394,7 +538,10 @@
 
         cmocka_unit_test(test_get_num_output_sequenced_=
available),
         cmocka_unit_test(test_copy_acks_to_lru),
-        cmoc=
ka_unit_test(test_packet_id_window)
+        cmocka_unit_test(test_packet_i=
d_window),
+        cmocka_unit_test(test_reliable_backoff_is_bounded),
+  =
      cmocka_unit_test(test_reliable_purge_ignores_forged_acks),
+        c=
mocka_unit_test(test_reliable_purge_legitimate_ack)
 
     };
 

-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1894?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I3c6ad247614fb204a279b73e98f8c470=
4e16da2a
Gerrit-Change-Number: 1894
Gerrit-PatchSet: 4
Gerrit-Owner: cron2 =
<gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
=
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ra=
zvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--yA62SifLVOo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1894?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">reliable: add unit tests for ACK and backo=
ff DoS hardening<br><br>Add regression coverage for the reliability-layer d=
enial-of-service fix<br>to test_packet_id, which already links reliable=2Ec=
:<br><br> - the retransmission timeout must stay positive and bounded no ma=
tter how<br>   often the fast-retransmit path is forced, so it can no longe=
r overflow;<br> - reliable_send_purge() must ignore ACKs for packet IDs tha=
t could never<br>   have been in flight (out of the send window, or wrapped=
-around), so a<br>   peer cannot inflate n_acks and force early retransmits=
;<br> - a legitimate ACK for a real higher packet ID still removes that ent=
ry<br>   and counts towards fast retransmit (positive control)=2E<br><br>Th=
ese tests fail on the unfixed code and pass with the fix=2E<br><br>Signed-o=
ff-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>Acked-by: Razvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1894<br>Change-Id: I3c6ad247614fb204a279b73e98f8c4704e16da2a<b=
r>Message-Id: &lt;20260904160848=2E5553-1-gert@greenie=2Emuc=2Ede&gt;<br>UR=
L: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet=
/msg38948=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede=
&gt;<br>---<br>M tests/unit_tests/openvpn/test_packet_id=2Ec<br>1 file chan=
ged, 148 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/tests/u=
nit_tests/openvpn/test_packet_id=2Ec b/tests/unit_tests/openvpn/test_packet=
_id=2Ec</span><br><span>index a5d50de=2E=2Edc77553 100644</span><br><span>-=
-- a/tests/unit_tests/openvpn/test_packet_id=2Ec</span><br><span>+++ b/test=
s/unit_tests/openvpn/test_packet_id=2Ec</span><br><span>@@ -372,6 +372,150 =
@@</span><br><span> }</span><br><span> </span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* The fix keeps the timeout well bel=
ow this; the broken code grows past it=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * A plain number, so the test builds with or without=
 the fix=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne SANE_TIMEOUT_BOUND (10 * 1000 * 1000)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static struct reliable *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+test_reliable_new(void)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct reliable *rel =3D malloc(sizeof(struct reliable));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(rel);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* reliable_init() zeroes ever=
ything, so each test only sets the</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * fields it actually needs=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    reliable_init(rel, 100, 50, 8, false)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel-&gt;initia=
l_timeout =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return rel;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Each retransmit doubles the timeout=2E If a peer keeps for=
cing retransmits,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 the broken code doubles it forever: after about 30 rounds it overflows and=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * turns zero or ne=
gative, and then the packet is resent nonstop (the flood)=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * The fix caps the doubling=2E Th=
is test forces many retransmits and checks the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * timeout never overflows or grows without limi=
t=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+test_reliable_backoff_is_bounded(void *=
*state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    (void)state;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    now =3D 1000;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct reliable *rel =3D test_reliable_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct reliable_entry *e =3D &amp;rel=
-&gt;array[0];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
-&gt;active =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    e-&gt;packet_id =3D 1;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    e-&gt;timeout =3D rel-&gt;initial_timeout;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    rel-&gt;packet_id =3D 2;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 40; ++i)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* make the packet due for a fast ret=
ransmit */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
-&gt;n_acks =3D N_ACK_RETRANSMIT;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   int opcode;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   struct buffer *buf =3D reliable_send(rel, &amp;opcode);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* our one active packet is =
the one picked to send */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        assert_ptr_equal(buf, &amp;e-&gt;buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* a zero or negative timeout would resend with no d=
elay (the flood) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        assert_true(e-&gt;timeout &gt; 0);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        /* the timeout must stop growing, not double=
 forever */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
assert_true(e-&gt;timeout &lt;=3D SANE_TIMEOUT_BOUND);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    reliable_free(rel);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * An ACK should only count if it is for a packe=
t we actually sent=2E If the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * broken code accepts ACKs for packets that were never sent, a pe=
er can force</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * earl=
y retransmits at will (which then feeds the timeout overflow above)=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * These two cases send =
such bogus ACKs and check they are ignored=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+test_reliable_purge_ignores_forged_acks(void **state)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    (void)state;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Case (a): an ACK for pid 0x40000000, which we never sent (we only sent</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * 0 and 1)=2E Th=
e old &quot;e-&gt;packet_id &lt; pid&quot; check treats it as newer and</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * counts it=2E It =
should be ignored=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        st=
ruct reliable *rel =3D test_reliable_new();</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        struct reliable_entry *e =3D &amp;rel-&gt;a=
rray[0];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e-&=
gt;active =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        e-&gt;packet_id =3D 1;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        rel-&gt;packet_id =3D 2; /* only pids 0 and 1 were ever =
sent */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        struct reliable_ack ack=
 =3D { =2Elen =3D 1, =2Epacket_id =3D { 0x40000000 } };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        reliable_send_purge(rel, &amp;a=
ck);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        /* the bogus ACK must not =
be counted */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  assert_int_equal(e-&gt;n_acks, 0);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        /* and must not drop our real packet */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        assert_true(e-&gt;acti=
ve);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        reliabl=
e_free(rel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* Case (b): an ACK for pid 0xFFFFFF=
FF=2E It is inside the send window, so</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * it passes the window check, but ids wrap around a=
nd 0xFFFFFFFF is really</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * older than our pid 1=2E A plain &quot;&lt;&quot; thinks it is ne=
wer and counts it; the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * wraparound-aware comparison must not=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        struct reliable *rel =3D test_reliable_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct reliab=
le_entry *e =3D &amp;rel-&gt;array[0];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        e-&gt;active =3D true;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        e-&gt;packet_id =3D 1;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        rel-&gt;packet_id =3D 2;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        struct reliable_ack ack =3D { =
=2Elen =3D 1, =2Epacket_id =3D { 0xFFFFFFFF } };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        reliable_send_purge(rel, &amp;ack);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* the bogus ACK must not be coun=
ted */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        asser=
t_int_equal(e-&gt;n_acks, 0);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        /* and must not drop our real packet */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        assert_true(e-&gt;active);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        reliable_free(=
rel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Sani=
ty check: a real ACK must still work=2E Acknowledging a higher packet</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * should drop that packe=
t and count once towards resending the older one=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * The fix must not break this=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_reliable_purge_legitimate_ack(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    (void)state;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct reliable *rel =3D test_reliable_new();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct reliable_entry *e0 =3D &amp;rel-&gt;ar=
ray[0];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e0-&gt;a=
ctive =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
e0-&gt;packet_id =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct reli=
able_entry *e1 =3D &amp;rel-&gt;array[1];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    e1-&gt;active =3D true;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    e1-&gt;packet_id =3D 2;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    rel-&gt;packet_id =3D 3; /* pids 0,1,2 sent; 1 and 2=
 still waiting */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct reliable_a=
ck ack =3D { =2Elen =3D 1, =2Epacket_id =3D { 2 } };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    reliable_send_purge(rel, &amp;ack);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* packet 2 was acked, so it is drop=
ped */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fa=
lse(e1-&gt;active);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* packet 1 is older, so it gets one ACK towards an early resend */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(e0=
-&gt;n_acks, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* packet 1 was not acked, so it stays */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(e0-&gt;active);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    reliable_free(rel);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> int</span><br><span> main(void)</span><br><span> {</spa=
n><br><span>@@ -394,7 +538,10 @@</span><br><span> </span><br><span>        =
 cmocka_unit_test(test_get_num_output_sequenced_available),</span><br><span=
>         cmocka_unit_test(test_copy_acks_to_lru),</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        cmocka_unit_test(test_packet_id_window=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_uni=
t_test(test_packet_id_window),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(test_reliable_backoff_is_bounded),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test=
(test_reliable_purge_ignores_forged_acks),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        cmocka_unit_test(test_reliable_purge_legitim=
ate_ack)</span><br><span> </span><br><span>     };</span><br><span> </span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1894?usp=3Demail">change 1894</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1894?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I3c6ad247614fb204a279b73e98f8=
c4704e16da2a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1894=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=
=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Em=
uc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--yA62SifLVOo=--


--===============4208551260947743352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4208551260947743352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4208551260947743352==--

