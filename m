Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C85DC624D6
	for <openvpn-devel@archiver.kernel.org>; Sat,  5 Sep 2026 09:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aAa5CdTRLSL8yGmixd3bpoW83lTpcnBCGOcC+6Xg8fw=; b=Wwr5WNlwwUjgZLeHgTUAXi1R93
	VQNIZMRAI84GKsSWbDXJ8tCdNKEYyfBsnj3nYs4oFnIuYcqWV/yUp1iO+qTHKKwv02g68NZPfVFsn
	xHq6rJMN7Hh0UXsgWFbXmRRxXT9mb80hGOVG0NCw98e0xLoif7oj3mj+Ihl/lgBA1CCQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2mga-0000Lv-5T;
	Sat, 05 Sep 2026 09:27:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x2mgZ-0000Ln-0X
 for openvpn-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 09:27:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=AkfquCGbk08X6o6MYTzMnXltNb9CkPti+Lt/1SgIrX4=; b=TdRkKLK3GSCixxkyk2hiPCduvr
 2Olk89BHKGIpuCcIpYwZ3oDTVxRBd8wWUP1Aw1HoQZlrJw8aK4WM5sAoOkuIl2rHecirw75v9KoH+
 awDHK/jAqhVU5RNF3ZtB2/8bc9KoDGzNKdovdc0VDpu7d4eZVgbrTH2NLO6oWPHoWo0E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AkfquCGbk08X6o6MYTzMnXltNb9CkPti+Lt/1SgIrX4=; b=I
 JnazReKqtuL2Roxaa2nMV5ifmhcno36jNKFLRpOwl38OgmW4e2VC/jAoGsOHM1kcwbGvbKnyzsr95
 f37CfdzB5SH/7jd/5uCnmhviBChjVgsj39afnZI8CAP9AAiY5tqxSEiK8NotYIaAjIeOoDSOkDiY1
 7R41qe/o6uV9NtxU=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2mgX-000236-3k for openvpn-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 09:27:43 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49cd77e0f95so16608705e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 05 Sep 2026 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788600454; x=1789205254; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AkfquCGbk08X6o6MYTzMnXltNb9CkPti+Lt/1SgIrX4=;
 b=YLY7HlUD+nAYXcG1XIEGVakJJSk7nxS5wd1AVu5lTmOe2QITB8UpQjEqNRQmjD3xWK
 cMgOs9dOETs+HPEzWHrEQj0y5iECdMpF5mnqLl0CXjUKbDUWba8xUq47/PQrHigKIJpD
 UXxXDA9AdHdKJviK9w0A7kFskr8+ZHJ/VIK83odz9c3nMe1izdbo/xfY8MU+g38nOLOk
 x55BQPeZxWKcaI1bjkzSq4d1P2LTOYMjkEu13bKjMHhlXQk9zh9znAPqCs6hroMXMMGI
 jWyGIkEKuRG8fyhSRuLTmnzCb7owXHKxDSCD0eyaPovwOCFAnGJFkPNKq4TUgz9xzSMo
 2e3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788600454; x=1789205254;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AkfquCGbk08X6o6MYTzMnXltNb9CkPti+Lt/1SgIrX4=;
 b=ioTmwdKHNuu8/vWK0Ucb9TDfTPRwVfXMrDQCmKHw6gOx5WsnJmC2PkQgqEoVmYUxMv
 9cRKswlo9jsL8z2fDWClOg+kW2G9F+TPUfLZBpX3qEFTT6+Bao+HfczuI56DyRv0pf4B
 KJKa8S6s9g5sgvr+x982EkyJce8gikDg3ZZjLJ88+HFtlpYrtLwMWo+qXBCwE3I2rEu8
 k4QfytXBBmfWgExUIcbPZJ3wWJP9g+CKuW9Z8BQtzjtXVAcZ8u/A//qMnGmMew0JUPWo
 xGX/4ecpT/USwX1An4GhRgyA4d8wLZmkbEK7791tEnJTGCSlA2YytNRehGapplSyWnx1
 N1Eg==
X-Gm-Message-State: AFuF++mhfvsqAFhnZj6TXnjaBb1LVDoXgQRfZVE9BJ9c9w/tLLVnUFNh
 NF6hsdDWuLqFHiJpNRBxrbEFQTl/MSbDWSX5BYGt6wDDi5OwlFarGwN/naqZuW83xE8sXIwwfZv
 /jKiWwWjFO0WqB8tOpJTmV1OT+E6nLtMM4tBkDrBZy9q6QF63zKtSgOZmHmNfPiTPxfEo
X-Gm-Gg: AYBFou3RZletvrDeXvqMhkoumIJsoqiZgfV+AIsMK7X635Upb5+z24Vxgxbr93uGYcY
 sJ7y7qOdVIQ9NbFglRqjr246xITgdzR1WliWtdYDdrsmOjzMBXoTX9W8wZy/8UvYscpKBmVgCms
 mXuTcniAU2j6sDfR7g8BhrReSLEQ+lU7SEUqI4BGz1aYDJo8beato0KuZDM9xR1DLRUQQAQOSKp
 GMCApK7YtsKq7LAT21FpEzmGgwWUPHPUlZrpo7o39DMVtlUz8xepqlJymTpSF50Jb+z/ziuSQzJ
 uGaNfGlisEP38xRgoy3cMM2MJ9pzqcauj6fMomiHlAYu4sL937S3cwg2jqFTtfjQ1ETwgzjEHIX
 s7UtiUxuGeTHK9nckpfJS8X0XnLBFQBFB5gGUbZOnqMvK0iq193G5h9NYkvR32PwuijvQe3rVbS
 ZC+4yUVxcEnBYNyCIFykzidPuWuGq5Ed/zuBjM1sg1GrjV67o2taNzzH8a3ZbXI/PQd0Iya/oGL
 /lpzYjMNaVSKCVmwLDZ1jCAyZEWk4GJkWFXEmvkVnTbCFxpxko3wVPuFMDcEbdRohRr+a86G0gK
 jML0jm7fL4TWsndx8c+gTxKJ7SYNqx9YUzhTtATqhs0OPaV/Vzcd
X-Received: by 2002:a05:600c:4687:b0:49c:ff8a:44cd with SMTP id
 5b1f17b1804b1-49cff8a4cfbmr61563935e9.12.1788600454127; 
 Sat, 05 Sep 2026 02:27:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5533ffbsm201808485e9.3.2026.09.05.02.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 02:27:33 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 5 Sep 2026 09:27:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I3c6ad247614fb204a279b73e98f8c4704e16da2a
X-Gerrit-Change-Number: 1894
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1894?usp=email>
X-Gerrit-Commit: c9b8ca1795957f2e22dad1589479bd32faea4fc1
In-Reply-To: <gerrit.1788416209000.I3c6ad247614fb204a279b73e98f8c4704e16da2a@gerrit.openvpn.net>
References: <gerrit.1788416209000.I3c6ad247614fb204a279b73e98f8c4704e16da2a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NDE2MjA5MDAwLkkzYzZhZDI0NzYxNGZiMjA0YTI3OWI3M2U5OGY4YzQ3MDRlMTZkYTJhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <14d2d3aa88784938142e9a4fd7b184c2cbfbc4dd-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x2mgX-000236-3k
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1366199723723306672=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1366199723723306672==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AOhQSl9zVVQ="; charset=UTF-8

--AOhQSl9zVVQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello plaisthos, razvanc, 

I'd like you to reexamine a change=2E Please vi=
sit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1894?usp=3Demail

to loo=
k at the new patch set (#4)=2E

The following approvals got outdated and we=
re removed:
Code-Review+2 by razvanc


Change subject: reliable: add unit t=
ests for ACK and backoff DoS hardening
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

reliable: add unit tests for ACK and backoff DoS =
hardening

Add regression coverage for the reliability-layer denial-of-serv=
ice fix
to test_packet_id, which already links reliable=2Ec:

 - the retran=
smission timeout must stay positive and bounded no matter how
   often the =
fast-retransmit path is forced, so it can no longer overflow;
 - reliable_s=
end_purge() must ignore ACKs for packet IDs that could never
   have been i=
n flight (out of the send window, or wrapped-around), so a
   peer cannot i=
nflate n_acks and force early retransmits;
 - a legitimate ACK for a real h=
igher packet ID still removes that entry
   and counts towards fast retrans=
mit (positive control)=2E

These tests fail on the unfixed code and pass wi=
th the fix=2E

Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
Acked-by: Ra=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1894
Change-Id: I3c6ad247614fb204a279b73e98f8c4704e16da2=
a
Message-Id: <20260904160848=2E5553-1-gert@greenie=2Emuc=2Ede>
URL: https:=
//www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38948=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M tests/u=
nit_tests/openvpn/test_packet_id=2Ec
1 file changed, 148 insertions(+), 1 d=
eletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/94/1894/4

diff --git a/tests/unit_tests/openvpn/test_packet_id=2Ec b/=
tests/unit_tests/openvpn/test_packet_id=2Ec
index a5d50de=2E=2Edc77553 1006=
44
--- a/tests/unit_tests/openvpn/test_packet_id=2Ec
+++ b/tests/unit_tests=
/openvpn/test_packet_id=2Ec
@@ -372,6 +372,150 @@
 }
 
 
+/* The fix keeps =
the timeout well below this; the broken code grows past it=2E
+ * A plain n=
umber, so the test builds with or without the fix=2E */
+#define SANE_TIMEO=
UT_BOUND (10 * 1000 * 1000)
+
+static struct reliable *
+test_reliable_new(=
void)
+{
+    struct reliable *rel =3D malloc(sizeof(struct reliable));
+  =
  assert_non_null(rel);
+    /* reliable_init() zeroes everything, so each =
test only sets the
+     * fields it actually needs=2E */
+    reliable_ini=
t(rel, 100, 50, 8, false);
+    rel->initial_timeout =3D 2;
+    return rel=
;
+}
+
+/*
+ * Each retransmit doubles the timeout=2E If a peer keeps forci=
ng retransmits,
+ * the broken code doubles it forever: after about 30 roun=
ds it overflows and
+ * turns zero or negative, and then the packet is rese=
nt nonstop (the flood)=2E
+ * The fix caps the doubling=2E This test forces=
 many retransmits and checks the
+ * timeout never overflows or grows witho=
ut limit=2E
+ */
+static void
+test_reliable_backoff_is_bounded(void **stat=
e)
+{
+    (void)state;
+    now =3D 1000;
+
+    struct reliable *rel =3D =
test_reliable_new();
+
+    struct reliable_entry *e =3D &rel->array[0];
+ =
   e->active =3D true;
+    e->packet_id =3D 1;
+    e->timeout =3D rel->in=
itial_timeout;
+    rel->packet_id =3D 2;
+
+    for (int i =3D 0; i < 40; =
++i)
+    {
+        /* make the packet due for a fast retransmit */
+     =
   e->n_acks =3D N_ACK_RETRANSMIT;
+
+        int opcode;
+        struct b=
uffer *buf =3D reliable_send(rel, &opcode);
+        /* our one active pack=
et is the one picked to send */
+        assert_ptr_equal(buf, &e->buf);
+
=
+        /* a zero or negative timeout would resend with no delay (the floo=
d) */
+        assert_true(e->timeout > 0);
+        /* the timeout must st=
op growing, not double forever */
+        assert_true(e->timeout <=3D SANE=
_TIMEOUT_BOUND);
+    }
+
+    reliable_free(rel);
+}
+
+/*
+ * An ACK shou=
ld only count if it is for a packet we actually sent=2E If the
+ * broken c=
ode accepts ACKs for packets that were never sent, a peer can force
+ * ear=
ly retransmits at will (which then feeds the timeout overflow above)=2E
+ *=
 These two cases send such bogus ACKs and check they are ignored=2E
+ */
+s=
tatic void
+test_reliable_purge_ignores_forged_acks(void **state)
+{
+    (=
void)state;
+
+    /* Case (a): an ACK for pid 0x40000000, which we never s=
ent (we only sent
+     * 0 and 1)=2E The old "e->packet_id < pid" check tr=
eats it as newer and
+     * counts it=2E It should be ignored=2E */
+    {=

+        struct reliable *rel =3D test_reliable_new();
+        struct rel=
iable_entry *e =3D &rel->array[0];
+        e->active =3D true;
+        e-=
>packet_id =3D 1;
+        rel->packet_id =3D 2; /* only pids 0 and 1 were =
ever sent */
+
+        struct reliable_ack ack =3D { =2Elen =3D 1, =2Epack=
et_id =3D { 0x40000000 } };
+        reliable_send_purge(rel, &ack);
+
+   =
     /* the bogus ACK must not be counted */
+        assert_int_equal(e->n=
_acks, 0);
+        /* and must not drop our real packet */
+        assert=
_true(e->active);
+        reliable_free(rel);
+    }
+
+    /* Case (b): a=
n ACK for pid 0xFFFFFFFF=2E It is inside the send window, so
+     * it pas=
ses the window check, but ids wrap around and 0xFFFFFFFF is really
+     * =
older than our pid 1=2E A plain "<" thinks it is newer and counts it; the
+=
     * wraparound-aware comparison must not=2E */
+    {
+        struct re=
liable *rel =3D test_reliable_new();
+        struct reliable_entry *e =3D =
&rel->array[0];
+        e->active =3D true;
+        e->packet_id =3D 1;
+=
        rel->packet_id =3D 2;
+
+        struct reliable_ack ack =3D { =2El=
en =3D 1, =2Epacket_id =3D { 0xFFFFFFFF } };
+        reliable_send_purge(r=
el, &ack);
+
+        /* the bogus ACK must not be counted */
+        asse=
rt_int_equal(e->n_acks, 0);
+        /* and must not drop our real packet *=
/
+        assert_true(e->active);
+        reliable_free(rel);
+    }
+}
+=

+/*
+ * Sanity check: a real ACK must still work=2E Acknowledging a higher=
 packet
+ * should drop that packet and count once towards resending the ol=
der one=2E
+ * The fix must not break this=2E
+ */
+static void
+test_relia=
ble_purge_legitimate_ack(void **state)
+{
+    (void)state;
+
+    struct r=
eliable *rel =3D test_reliable_new();
+
+    struct reliable_entry *e0 =3D =
&rel->array[0];
+    e0->active =3D true;
+    e0->packet_id =3D 1;
+
+    =
struct reliable_entry *e1 =3D &rel->array[1];
+    e1->active =3D true;
+  =
  e1->packet_id =3D 2;
+
+    rel->packet_id =3D 3; /* pids 0,1,2 sent; 1 a=
nd 2 still waiting */
+
+    struct reliable_ack ack =3D { =2Elen =3D 1, =
=2Epacket_id =3D { 2 } };
+    reliable_send_purge(rel, &ack);
+
+    /* pa=
cket 2 was acked, so it is dropped */
+    assert_false(e1->active);
+    /=
* packet 1 is older, so it gets one ACK towards an early resend */
+    ass=
ert_int_equal(e0->n_acks, 1);
+    /* packet 1 was not acked, so it stays *=
/
+    assert_true(e0->active);
+
+    reliable_free(rel);
+}
+
 int
 main(=
void)
 {
@@ -394,7 +538,10 @@
 
         cmocka_unit_test(test_get_num_outp=
ut_sequenced_available),
         cmocka_unit_test(test_copy_acks_to_lru),
=
-        cmocka_unit_test(test_packet_id_window)
+        cmocka_unit_test(=
test_packet_id_window),
+        cmocka_unit_test(test_reliable_backoff_is_=
bounded),
+        cmocka_unit_test(test_reliable_purge_ignores_forged_acks=
),
+        cmocka_unit_test(test_reliable_purge_legitimate_ack)
 
     };
=
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1894?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3c6ad247614fb2=
04a279b73e98f8c4704e16da2a
Gerrit-Change-Number: 1894
Gerrit-PatchSet: 4
Ge=
rrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: cron2 <gert@gr=
eenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>

--AOhQSl9zVVQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1894?usp=3Demail">View Change</a></p><p>The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by razvanc<=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">reliable: add unit tests for ACK and backoff DoS hardening=
<br><br>Add regression coverage for the reliability-layer denial-of-service=
 fix<br>to test_packet_id, which already links reliable=2Ec:<br><br> - the =
retransmission timeout must stay positive and bounded no matter how<br>   o=
ften the fast-retransmit path is forced, so it can no longer overflow;<br> =
- reliable_send_purge() must ignore ACKs for packet IDs that could never<br=
>   have been in flight (out of the send window, or wrapped-around), so a<b=
r>   peer cannot inflate n_acks and force early retransmits;<br> - a legiti=
mate ACK for a real higher packet ID still removes that entry<br>   and cou=
nts towards fast retransmit (positive control)=2E<br><br>These tests fail o=
n the unfixed code and pass with the fix=2E<br><br>Signed-off-by: Lev Stipa=
kov &lt;lev@openvpn=2Enet&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/189=
4<br>Change-Id: I3c6ad247614fb204a279b73e98f8c4704e16da2a<br>Message-Id: &l=
t;20260904160848=2E5553-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38948=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M tests/unit_tests/openvpn/test_packet_id=2Ec<br>1 file changed, 148 inser=
tions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/94/1894/4</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/tes=
ts/unit_tests/openvpn/test_packet_id=2Ec b/tests/unit_tests/openvpn/test_pa=
cket_id=2Ec</span><br><span>index a5d50de=2E=2Edc77553 100644</span><br><sp=
an>--- a/tests/unit_tests/openvpn/test_packet_id=2Ec</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_packet_id=2Ec</span><br><span>@@ -372,6 +372,=
150 @@</span><br><span> }</span><br><span> </span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* The fix keeps the timeout well=
 below this; the broken code grows past it=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * A plain number, so the test builds with or wit=
hout the fix=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define SANE_TIMEOUT_BOUND (10 * 1000 * 1000)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static struct reliable *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+test_reliable_new(void)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct reliable *rel =3D malloc(sizeof(struct reliable));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(rel);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* reliable_init() zeroes =
everything, so each test only sets the</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * fields it actually needs=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    reliable_init(rel, 100, 50, 8, fal=
se);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel-&gt;ini=
tial_timeout =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return rel;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * Each retransmit doubles the timeout=2E If a peer keeps =
forcing retransmits,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * the broken code doubles it forever: after about 30 rounds it overflows =
and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * turns zero or=
 negative, and then the packet is resent nonstop (the flood)=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * The fix caps the doubling=2E=
 This test forces many retransmits and checks the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * timeout never overflows or grows without l=
imit=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+test_reliable_backoff_is_bounded(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    (void)state;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    now =3D 1000;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct reliable *rel =3D test_reliable_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct reliable_entry *e =3D &amp;re=
l-&gt;array[0];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
e-&gt;active =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    e-&gt;packet_id =3D 1;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    e-&gt;timeout =3D rel-&gt;initial_timeout;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    rel-&gt;packet_id =3D 2;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 40; ++i)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        /* make the packet due for a fast re=
transmit */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
e-&gt;n_acks =3D N_ACK_RETRANSMIT;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    int opcode;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    struct buffer *buf =3D reliable_send(rel, &amp;opcode);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        /* our one active packet is=
 the one picked to send */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        assert_ptr_equal(buf, &amp;e-&gt;buf);</span><br><span style=
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
rit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: I3c6ad247614fb204a279b73=
e98f8c4704e16da2a </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 1894 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div st=
yle=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>

</body></html>
--AOhQSl9zVVQ=--


--===============1366199723723306672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1366199723723306672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1366199723723306672==--

