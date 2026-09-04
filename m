Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC0DC624D3
	for <openvpn-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/E+lvYqWR1Dkb9M6hI+z+gx68qBq4pPgLpXYNMtpOyQ=; b=UpZHk5Ympx4OWyyaGNAYK0ksrI
	SeJDB3Uugb9b4tTV7UW/Gi9e5jxHu+nwvfPoEk2/Wo0Ek2s3CCLauLFAcI4dek1+B3jJ6K7MJA034
	+BgrAcgna9XP26io2oHFpKQhj0oeyT9Y/1wX8ZnFj2KnGMUgz0GnTlLMgKgD9lEo9rbg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2R93-0005of-Q6;
	Fri, 04 Sep 2026 10:27:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x2R8p-0005nJ-5O
 for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 10:27:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=GuvYtouFCTW0ef039uZdoQBrP+fntNA3kpdKlSuqgmI=; b=d3Y5XxmWUyEhgj0ca5tPF385UW
 MziqmYiX0TNeHOFj2gFGGR9VS7j6ZRzfA+zNBEqPrA0V7Bh718D9PXuebXaAm5drniPawa1H3iZfn
 1LQqwc5gTIQAd0qkvIiKazbFimtW13g9u8UMmQH8mSgfKESiLeB/hYfMNGch3AImecEk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GuvYtouFCTW0ef039uZdoQBrP+fntNA3kpdKlSuqgmI=; b=N
 7DLgXIBy5YMRyH4RqNrPAoPujHPuhKGG8ib8h7qGrP+O+XX9ZcmG5M3ZrCAsicEYeOWtvX6we3dDk
 dWOCTzNXLrK3B2obGodbW4hXFlg4BirA0xBYw2tQJTGaQfWLcu2U/F1xoDC6YNL20I/KNqS6ivwvE
 iHCgG9CtxL3YwUL8=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2R8i-0002YQ-A0 for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 10:27:22 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so718497f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 04 Sep 2026 03:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788517634; x=1789122434; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GuvYtouFCTW0ef039uZdoQBrP+fntNA3kpdKlSuqgmI=;
 b=aNKDt8pGCJe9JaynPjt2HcgD5nvsvtFxnD6veKHgphK+ItWVo+2rYUmxNe4THr3/45
 29ZiCN6/qPlAqzfhoj3IeUoE9zzoprBdbXOSyDE+AOkN/WEq3seOHb6sGjMQxbQMCzDo
 MLDW+h1LxsJWMzQsP2wtkjuIPyofZDB+uS0/8z9capIxGzdWIOvKsHmP4xzmqKdXWig4
 gIBD2Lcmhi5oM28dHP4PC0XFM5guDDlhxrcBKxIqWJRXyHVaMTNBHSMxvRnqkAc43xYR
 Wv5HW7gUMrsaY6pHieAVip5/Jm7CEWV23vW7wMAc5eb93aNNOtvwe+nz/ldeYP514ZqJ
 d4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788517634; x=1789122434;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GuvYtouFCTW0ef039uZdoQBrP+fntNA3kpdKlSuqgmI=;
 b=rFr3+2EYTCOxdmZ6hJE9Vy9hDuO8fGpKHnjbiZtu++lguIqCIb/PHWlRDvaGsf4eag
 Yp24CjE1cmFuw7zxdOM+erU8E1LFzjMhOXLEg2HA372wasIAUBYFkXdzM7858oxOyStC
 wBU1Y4BV7PZxiRFY1x4C4Wem/M/KD1nE8REUUsZ0Ii3KXhBUn7iYNNfKb2s6uTUgIRmG
 faq/YuPch5EPwjJr14FCDeHc/M2gnvjKDOpwojmLvKvVBzOJSCS2+oMxoYbqdUenKygK
 V60oniLLUmHX520YkfGSMaEdFcptwyze/CX5greneps+tK9xGs3KwfIgZOzfxUNLd26/
 wWZw==
X-Gm-Message-State: AFuF++kKuHnqJLBlqZ8YGfG3/OfdPyIUcNsMjccKSrFZ/dNLTK/TN9OR
 atOzSRPj6RGkFwJTldVzpnPCAHUmPl0965bo15KYJmmeTsUgWZPM4vLNAJhMml2CHKIT8GkvLWL
 lit4zSknrZjvevM1bcVsCURi9VoYNbQCqSpb/5lLA13+9mEGZkX0Y2ms3tY2RRsFKhxG0
X-Gm-Gg: AYBFou0kFrdnYWXu7r3v/yVWkNcYTCp7NupfT8naxov88tYF15t0NFwNVNUwd49ECbV
 wkG3LWxjPr7pBn1pnmP1ivtbTVNrNVFHrZNB1zUfJft0ehSahM0E14LPl2x1tZbyrPTNY5aul3m
 +cWa9Qe+AhUiMwYY/+hB3PnZz5CixXd3qKRnBc7BZ6XuTJ0rVIei3IWWGoD43O/D9LIAg5fVA0f
 CihgejsYbBmzIDgmVPovZIaOjOqa9mINla4Pujb2j+CrgAoIriW3TIljrBwDMEtbKj+Kv1xaKB4
 mhJcOC8CXIGp8YR/a+XpZ9zI4UQDkWF8ANZdQWOm4tVKTv68mUDZeFD21DeeUrk0zgf5vtT6bIG
 UuA+p2ykHHHhFPHHazIbbAPFMAsc0l+ABlBmDSwbYDXpxB7uJtPlir3ETGXXZa38HW03k2pBTg9
 U4QPwq3tGejbmLEqx8oanbwAaQTQiOwC7u33S/KPO+7fC5NnWSqQx0QHnJB1rnzw2Eg/Qx5Yxfn
 jCSt6iI8GPGOOeyE/bgvUQl0em2Jzu5BljCL4t+ueTIlSk6ms2EFTDcif/xAqtwjUNvsia2iFHw
 Pd/4srOzEtFBUVVOpSWanR2izK2Elbus4cfPC2a1OD8fob5cK3Q=
X-Received: by 2002:adf:e3c5:0:b0:485:1bcc:67f8 with SMTP id
 ffacd0b85a97d-485872adb1cmr6151270f8f.13.1788517633438; 
 Fri, 04 Sep 2026 03:27:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c074asm5155697f8f.23.2026.09.04.03.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 03:27:13 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 4 Sep 2026 10:27:11 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3c6ad247614fb204a279b73e98f8c4704e16da2a
X-Gerrit-Change-Number: 1894
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1894?usp=email>
X-Gerrit-Commit: 975dc2e0f0e17a301c8728f6c135be339f7a9196
In-Reply-To: <gerrit.1788416209000.I3c6ad247614fb204a279b73e98f8c4704e16da2a@gerrit.openvpn.net>
References: <gerrit.1788416209000.I3c6ad247614fb204a279b73e98f8c4704e16da2a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NDE2MjA5MDAwLkkzYzZhZDI0NzYxNGZiMjA0YTI3OWI3M2U5OGY4YzQ3MDRlMTZkYTJhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8f7029a60263cc01b7d29c5ca25d9611242aba91-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x2R8i-0002YQ-A0
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5851631067880479369=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5851631067880479369==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vEV4gHOoKEc="; charset=UTF-8

--vEV4gHOoKEc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

stipa has upload=
ed a new patch set (#3) to the change originally created by cron2=2E ( http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1894?usp=3Demail )

The following app=
rovals got outdated and were removed:
Code-Review+2 by cron2, Code-Review-1=
 by plaisthos

The change is no longer submittable: Code-Review and checks~=
ChecksSubmitRule are unsatisfied now=2E


Change subject: reliable: add uni=
t tests for ACK and backoff DoS hardening
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

reliable: add unit tests for ACK and backoff D=
oS hardening

Add regression coverage for the reliability-layer denial-of-s=
ervice fix
to test_packet_id, which already links reliable=2Ec:

 - the ret=
ransmission timeout must stay positive and bounded no matter how
   often t=
he fast-retransmit path is forced, so it can no longer overflow;
 - reliabl=
e_send_purge() must ignore ACKs for packet IDs that could never
   have bee=
n in flight (out of the send window, or wrapped-around), so a
   peer canno=
t inflate n_acks and force early retransmits;
 - a legitimate ACK for a rea=
l higher packet ID still removes that entry
   and counts towards fast retr=
ansmit (positive control)=2E

These tests fail on the unfixed code and pass=
 with the fix=2E

Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
Change-Id=
: I3c6ad247614fb204a279b73e98f8c4704e16da2a
---
M tests/unit_tests/openvpn/=
test_packet_id=2Ec
1 file changed, 148 insertions(+), 1 deletion(-)


  git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/94/1894/3

di=
ff --git a/tests/unit_tests/openvpn/test_packet_id=2Ec b/tests/unit_tests/o=
penvpn/test_packet_id=2Ec
index a5d50de=2E=2Edc77553 100644
--- a/tests/uni=
t_tests/openvpn/test_packet_id=2Ec
+++ b/tests/unit_tests/openvpn/test_pack=
et_id=2Ec
@@ -372,6 +372,150 @@
 }
 
 
+/* The fix keeps the timeout well b=
elow this; the broken code grows past it=2E
+ * A plain number, so the test=
 builds with or without the fix=2E */
+#define SANE_TIMEOUT_BOUND (10 * 100=
0 * 1000)
+
+static struct reliable *
+test_reliable_new(void)
+{
+    stru=
ct reliable *rel =3D malloc(sizeof(struct reliable));
+    assert_non_null(=
rel);
+    /* reliable_init() zeroes everything, so each test only sets the=

+     * fields it actually needs=2E */
+    reliable_init(rel, 100, 50, 8,=
 false);
+    rel->initial_timeout =3D 2;
+    return rel;
+}
+
+/*
+ * Eac=
h retransmit doubles the timeout=2E If a peer keeps forcing retransmits,
+ =
* the broken code doubles it forever: after about 30 rounds it overflows an=
d
+ * turns zero or negative, and then the packet is resent nonstop (the fl=
ood)=2E
+ * The fix caps the doubling=2E This test forces many retransmits =
and checks the
+ * timeout never overflows or grows without limit=2E
+ */
+=
static void
+test_reliable_backoff_is_bounded(void **state)
+{
+    (void)s=
tate;
+    now =3D 1000;
+
+    struct reliable *rel =3D test_reliable_new(=
);
+
+    struct reliable_entry *e =3D &rel->array[0];
+    e->active =3D t=
rue;
+    e->packet_id =3D 1;
+    e->timeout =3D rel->initial_timeout;
+  =
  rel->packet_id =3D 2;
+
+    for (int i =3D 0; i < 40; ++i)
+    {
+     =
   /* make the packet due for a fast retransmit */
+        e->n_acks =3D N=
_ACK_RETRANSMIT;
+
+        int opcode;
+        struct buffer *buf =3D rel=
iable_send(rel, &opcode);
+        /* our one active packet is the one pick=
ed to send */
+        assert_ptr_equal(buf, &e->buf);
+
+        /* a zero=
 or negative timeout would resend with no delay (the flood) */
+        ass=
ert_true(e->timeout > 0);
+        /* the timeout must stop growing, not do=
uble forever */
+        assert_true(e->timeout <=3D SANE_TIMEOUT_BOUND);
+=
    }
+
+    reliable_free(rel);
+}
+
+/*
+ * An ACK should only count if i=
t is for a packet we actually sent=2E If the
+ * broken code accepts ACKs f=
or packets that were never sent, a peer can force
+ * early retransmits at =
will (which then feeds the timeout overflow above)=2E
+ * These two cases s=
end such bogus ACKs and check they are ignored=2E
+ */
+static void
+test_r=
eliable_purge_ignores_forged_acks(void **state)
+{
+    (void)state;
+
+   =
 /* Case (a): an ACK for pid 0x40000000, which we never sent (we only sent
=
+     * 0 and 1)=2E The old "e->packet_id < pid" check treats it as newer a=
nd
+     * counts it=2E It should be ignored=2E */
+    {
+        struct r=
eliable *rel =3D test_reliable_new();
+        struct reliable_entry *e =3D=
 &rel->array[0];
+        e->active =3D true;
+        e->packet_id =3D 1;
=
+        rel->packet_id =3D 2; /* only pids 0 and 1 were ever sent */
+
+  =
      struct reliable_ack ack =3D { =2Elen =3D 1, =2Epacket_id =3D { 0x4000=
0000 } };
+        reliable_send_purge(rel, &ack);
+
+        /* the bogus =
ACK must not be counted */
+        assert_int_equal(e->n_acks, 0);
+      =
  /* and must not drop our real packet */
+        assert_true(e->active);
=
+        reliable_free(rel);
+    }
+
+    /* Case (b): an ACK for pid 0xFF=
FFFFFF=2E It is inside the send window, so
+     * it passes the window che=
ck, but ids wrap around and 0xFFFFFFFF is really
+     * older than our pid=
 1=2E A plain "<" thinks it is newer and counts it; the
+     * wraparound-=
aware comparison must not=2E */
+    {
+        struct reliable *rel =3D te=
st_reliable_new();
+        struct reliable_entry *e =3D &rel->array[0];
+ =
       e->active =3D true;
+        e->packet_id =3D 1;
+        rel->packe=
t_id =3D 2;
+
+        struct reliable_ack ack =3D { =2Elen =3D 1, =2Epacke=
t_id =3D { 0xFFFFFFFF } };
+        reliable_send_purge(rel, &ack);
+
+    =
    /* the bogus ACK must not be counted */
+        assert_int_equal(e->n_=
acks, 0);
+        /* and must not drop our real packet */
+        assert_=
true(e->active);
+        reliable_free(rel);
+    }
+}
+
+/*
+ * Sanity ch=
eck: a real ACK must still work=2E Acknowledging a higher packet
+ * should=
 drop that packet and count once towards resending the older one=2E
+ * The=
 fix must not break this=2E
+ */
+static void
+test_reliable_purge_legitima=
te_ack(void **state)
+{
+    (void)state;
+
+    struct reliable *rel =3D t=
est_reliable_new();
+
+    struct reliable_entry *e0 =3D &rel->array[0];
+ =
   e0->active =3D true;
+    e0->packet_id =3D 1;
+
+    struct reliable_en=
try *e1 =3D &rel->array[1];
+    e1->active =3D true;
+    e1->packet_id =
=3D 2;
+
+    rel->packet_id =3D 3; /* pids 0,1,2 sent; 1 and 2 still waiti=
ng */
+
+    struct reliable_ack ack =3D { =2Elen =3D 1, =2Epacket_id =3D {=
 2 } };
+    reliable_send_purge(rel, &ack);
+
+    /* packet 2 was acked, =
so it is dropped */
+    assert_false(e1->active);
+    /* packet 1 is olde=
r, so it gets one ACK towards an early resend */
+    assert_int_equal(e0->=
n_acks, 1);
+    /* packet 1 was not acked, so it stays */
+    assert_true=
(e0->active);
+
+    reliable_free(rel);
+}
+
 int
 main(void)
 {
@@ -394,7=
 +538,10 @@
 
         cmocka_unit_test(test_get_num_output_sequenced_avail=
able),
         cmocka_unit_test(test_copy_acks_to_lru),
-        cmocka_un=
it_test(test_packet_id_window)
+        cmocka_unit_test(test_packet_id_win=
dow),
+        cmocka_unit_test(test_reliable_backoff_is_bounded),
+       =
 cmocka_unit_test(test_reliable_purge_ignores_forged_acks),
+        cmocka=
_unit_test(test_reliable_purge_legitimate_ack)
 
     };
 

-- 
To view, vi=
sit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1894?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I3c6ad247614fb204a279b73e98f8c470=
4e16da2a
Gerrit-Change-Number: 1894
Gerrit-PatchSet: 3
Gerrit-Owner: cron2 =
<gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
=
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=
=2Ede>

--vEV4gHOoKEc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p>stipa <strong>uploaded pa=
tch set #3</strong> to the change originally created by cron2=2E</p><p><a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1894?usp=3Demail">View Cha=
nge</a></p><p>The following approvals got outdated and were removed:
Code-R=
eview+2 by cron2, Code-Review-1 by plaisthos</p><p>The change is no longer =
submittable: Code-Review and checks~ChecksSubmitRule are unsatisfied now=2E=
</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">reliable: add unit tests for ACK and backoff DoS hardenin=
g<br><br>Add regression coverage for the reliability-layer denial-of-servic=
e fix<br>to test_packet_id, which already links reliable=2Ec:<br><br> - the=
 retransmission timeout must stay positive and bounded no matter how<br>   =
often the fast-retransmit path is forced, so it can no longer overflow;<br>=
 - reliable_send_purge() must ignore ACKs for packet IDs that could never<b=
r>   have been in flight (out of the send window, or wrapped-around), so a<=
br>   peer cannot inflate n_acks and force early retransmits;<br> - a legit=
imate ACK for a real higher packet ID still removes that entry<br>   and co=
unts towards fast retransmit (positive control)=2E<br><br>These tests fail =
on the unfixed code and pass with the fix=2E<br><br>Signed-off-by: Lev Stip=
akov &lt;lev@openvpn=2Enet&gt;<br>Change-Id: I3c6ad247614fb204a279b73e98f8c=
4704e16da2a<br>---<br>M tests/unit_tests/openvpn/test_packet_id=2Ec<br>1 fi=
le changed, 148 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/94/1894/3</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/tests/unit_tests/openvpn/test_packet_id=2Ec b/tests/unit_=
tests/openvpn/test_packet_id=2Ec</span><br><span>index a5d50de=2E=2Edc77553=
 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_packet_id=2Ec</=
span><br><span>+++ b/tests/unit_tests/openvpn/test_packet_id=2Ec</span><br>=
<span>@@ -372,6 +372,150 @@</span><br><span> }</span><br><span> </span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The fix k=
eeps the timeout well below this; the broken code grows past it=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * A plain number, so the te=
st builds with or without the fix=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define SANE_TIMEOUT_BOUND (10 * 1000 * 1000)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static struct reliable *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_reliable_new(void)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct reliable *rel =3D malloc(sizeof(struct relia=
ble));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_no=
n_null(rel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
reliable_init() zeroes everything, so each test only sets the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * fields it actually needs=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reliable_=
init(rel, 100, 50, 8, false);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    rel-&gt;initial_timeout =3D 2;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return rel;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Each retransmit doubles the ti=
meout=2E If a peer keeps forcing retransmits,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * the broken code doubles it forever: after abou=
t 30 rounds it overflows and</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * turns zero or negative, and then the packet is resent nonstop (=
the flood)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The=
 fix caps the doubling=2E This test forces many retransmits and checks the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * timeout never ove=
rflows or grows without limit=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_reliab=
le_backoff_is_bounded(void **state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  (void)state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    n=
ow =3D 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct reliable *rel =
=3D test_reliable_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct rel=
iable_entry *e =3D &amp;rel-&gt;array[0];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    e-&gt;active =3D true;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    e-&gt;packet_id =3D 1;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    e-&gt;timeout =3D rel-&gt;initial_t=
imeout;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel-&gt;=
packet_id =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; =
i &lt; 40; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* make th=
e packet due for a fast retransmit */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        e-&gt;n_acks =3D N_ACK_RETRANSMIT;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        int opcode;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        struct buffer *buf =3D reliable_send(rel, &am=
p;opcode);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /=
* our one active packet is the one picked to send */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        assert_ptr_equal(buf, &amp;e-&gt;=
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        /* a zero or negative tim=
eout would resend with no delay (the flood) */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        assert_true(e-&gt;timeout &gt; 0);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* the timeout mu=
st stop growing, not double forever */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        assert_true(e-&gt;timeout &lt;=3D SANE_TIMEOUT_B=
OUND);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    reliable_free(rel);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * An ACK should onl=
y count if it is for a packet we actually sent=2E If the</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * broken code accepts ACKs for packet=
s that were never sent, a peer can force</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * early retransmits at will (which then feeds the tim=
eout overflow above)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * These two cases send such bogus ACKs and check they are ignored=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+test_reliable_purge_ignores_forged_acks(void =
**state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    (void)state;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* Case (a): an ACK for pid 0x40000000, which w=
e never sent (we only sent</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * 0 and 1)=2E The old &quot;e-&gt;packet_id &lt; pid&quot; chec=
k treats it as newer and</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * counts it=2E It should be ignored=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        struct reliable *rel =3D test_reliable_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct reliab=
le_entry *e =3D &amp;rel-&gt;array[0];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        e-&gt;active =3D true;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        e-&gt;packet_id =3D 1;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        rel-&gt;packet_id =3D 2; /=
* only pids 0 and 1 were ever sent */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       struct reliable_ack ack =3D { =2Elen =3D 1, =2Epacket_id =3D { 0x400=
00000 } };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eliable_send_purge(rel, &amp;ack);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* the bogus ACK must not be counted */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        assert_int_equal(e-&gt;n_acks, 0);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        /* and must not drop=
 our real packet */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        assert_true(e-&gt;active);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        reliable_free(rel);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Cas=
e (b): an ACK for pid 0xFFFFFFFF=2E It is inside the send window, so</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * it passes the windo=
w check, but ids wrap around and 0xFFFFFFFF is really</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * older than our pid 1=2E A plain &q=
uot;&lt;&quot; thinks it is newer and counts it; the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * wraparound-aware comparison must n=
ot=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct reliable *=
rel =3D test_reliable_new();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        struct reliable_entry *e =3D &amp;rel-&gt;array[0];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        e-&gt;active =3D t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e-&gt;p=
acket_id =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    rel-&gt;packet_id =3D 2;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        st=
ruct reliable_ack ack =3D { =2Elen =3D 1, =2Epacket_id =3D { 0xFFFFFFFF } }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        reliable_s=
end_purge(rel, &amp;ack);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* th=
e bogus ACK must not be counted */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        assert_int_equal(e-&gt;n_acks, 0);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        /* and must not drop our real=
 packet */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        a=
ssert_true(e-&gt;active);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        reliable_free(rel);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Sanity check: a real ACK must still work=2E Acknowl=
edging a higher packet</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * should drop that packet and count once towards resending the older on=
e=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The fix must=
 not break this=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+test_reliable_purge_legit=
imate_ack(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (void)stat=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct reliable *rel =3D test_re=
liable_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct reliable_entry=
 *e0 =3D &amp;rel-&gt;array[0];</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    e0-&gt;active =3D true;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    e0-&gt;packet_id =3D 1;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct reliable_entry *e1 =3D &amp;rel-&gt;array[1];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    e1-&gt;active =3D true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e1-&gt;packet_id =
=3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    rel-&gt;packet_id =3D 3; /* =
pids 0,1,2 sent; 1 and 2 still waiting */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct reliable_ack ack =3D { =2Elen =3D 1, =2Epacket_id =3D { 2 } }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reliable_send_=
purge(rel, &amp;ack);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* packet 2 w=
as acked, so it is dropped */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_false(e1-&gt;active);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* packet 1 is older, so it gets one ACK towards=
 an early resend */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(e0-&gt;n_acks, 1);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* packet 1 was not acked, so it stays */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(e0-&gt;active=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    reliable_free(rel);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> main(void)<=
/span><br><span> {</span><br><span>@@ -394,7 +538,10 @@</span><br><span> </=
span><br><span>         cmocka_unit_test(test_get_num_output_sequenced_avai=
lable),</span><br><span>         cmocka_unit_test(test_copy_acks_to_lru),</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_tes=
t(test_packet_id_window)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        cmocka_unit_test(test_packet_id_window),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_reliable_ba=
ckoff_is_bounded),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       cmocka_unit_test(test_reliable_purge_ignores_forged_acks),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test=
_reliable_purge_legitimate_ack)</span><br><span> </span><br><span>     };</=
span><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1894?usp=3Demail">change 1894=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1894?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
3c6ad247614fb204a279b73e98f8c4704e16da2a </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1894 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@g=
reenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body=
></html>
--vEV4gHOoKEc=--


--===============5851631067880479369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5851631067880479369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5851631067880479369==--

