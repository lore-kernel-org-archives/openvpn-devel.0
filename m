Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6CCCA5FFF
	for <openvpn-devel@archiver.kernel.org>; Wed,  7 Oct 2026 21:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VU7n7pBXTUAE0pkLrZCrNwU9K34pZ67xSA+dVKJsz+A=; b=kfDhSo68dMm0lfSFDOrv/MAiW2
	Cx0xCG0UobjFgUdVkAEr5SKDRFvdhf3S3RdK/gJ+f+SSTtKoqZ7Ruo7ROrvupDM2f7e+l98e1B39q
	7xjkny4ALXyzZe5RM5ypKthsBp5crz1/gG4HCebKywG+id6Z6eYsQWbcA0DaMhIcwwBw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEZIZ-00039d-Dh;
	Wed, 07 Oct 2026 21:35:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEZIY-00039W-95
 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 21:35:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Y3VuM11pRwjlQdEOkrndRW7Ex1ni+n5IeY3jtHTHuPg=; b=OWGsaaYJ4vxnpkvERTdcUciDvQ
 kx4pAwoaiICX5irMciUQ0C1mYkC1axYuHtz0qx/IKKG9VwOAAncRefc2q0t0DYS6MvQlS5kkIVwtV
 /AHd4u0x0GVrFS15OzZuB1m69szd6eFAk0WxsYYiltC8ht0Maq2MoVzLMfaI/pkU7L+c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Y3VuM11pRwjlQdEOkrndRW7Ex1ni+n5IeY3jtHTHuPg=; b=h
 RTXqX6/1ItjUBXIVl8c9SqBiyJmrXqOJrum3+ge7aB7o3ahPTYHvGS/09p57hufbFSeTof+e1Aojn
 kdS0aRt+nQWySyvJrzQLiFb6gR4hMOa0Y6mIqFoVPj+XS1bGF/CbdwE7DmLDgW/TWw2oMd1+uSanE
 M0YSODqqB7tHcM10=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEZIS-00022N-Ip for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 21:35:35 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a020e65269so18203625e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 07 Oct 2026 14:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791408926; x=1792013726; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y3VuM11pRwjlQdEOkrndRW7Ex1ni+n5IeY3jtHTHuPg=;
 b=dAC9IZsfgIWp/EkTOUrod+G/AD7zxKgGpAyado/pdFQviARED2eSz88f/MEujGSEkZ
 +krTM1j4JZa4BBSXT7Fdst4RRU3z+MwM/8M7zUI5ViNI7bSnqjlPDVFzhHAh/tRaDNpn
 OEiUegaG6W77uU7dJ+pQIEjlK8Nloakx92Nd38aVHjLESdcKNS9VD/SpfTnUwcDMeHVA
 Dxi7eWQsIuiUdpm139hsq1dnjqTh+pt+t1/YeqSK7Xo41is8n/y2wRPsbpXBxb1hvbR8
 TDCndF1UhBOQuMh9RA395cObhXmNh/nqqAT/mA8hMtmbChGXpBqXPNwmnHckY7YKsOB8
 7tAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791408926; x=1792013726;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Y3VuM11pRwjlQdEOkrndRW7Ex1ni+n5IeY3jtHTHuPg=;
 b=uzSyzfAZ9ElqwlIr/FCEVhR4ZtDLDOiUVEb/dI9LdUDsu2smN9dAzF5r14NtHAJ1dz
 0uTbkIDcAapC9ckrFoEolRsBDtWBVMArUuVoL6LTXr21ikkZw15dpq3lbqYSg2mCd72S
 QkPb5v2YXPvt3wgLY41IUFewvdHl5UPDdizH0whOR9w0Zc0RJr5TqY9bKNliRm6Dh/wa
 RZPCS8PnlD/7oSYTwsnxJxK1qqQ9Bw1XCFOL1pByzX2/1FXFZBR/7PDNYC40dL54GC92
 Ft15CQHHcGssrQg3qhfYUBg8bOl5dNiENRQWM05MlZCfeDIjmQqTJ7gIuy5TNOIeGyX2
 VQaw==
X-Gm-Message-State: AFuF++l11Xm172PH5rMftGFs5DZctd68CH9jgOlsrqEHQwMYO+0ykruc
 t+dUt33l3ThemcPTIwdPlgMC7Br0MgRBgAXeFZe6UIo9YNyJQQoIF50p7Re+Yu2CRN74nJvkn0w
 OsuN81gdzLc/GRFXO5fBWPmcISx7tLoXrZR2HJKW8Z0OOsf3/QAmKZBpOI08lMQLE95KR
X-Gm-Gg: AYBFou0gU+RNQiZ60MUnJX2K6++KIvZBEc2qOQDRBdA4U5I5+p6S+nL93wPKbYUcxiB
 S8vS7SXvct5nYuid2vB1jVQe71b5aV4q7yAJKbjiQyWZp+RrLa8o95OHtBwZUMuOKK8CHQOpIAY
 07H9UNsLZ3FI1HLAYagwUOStm2iqbt+VuSNaakpDm6eXYcm0Y3JTfBk04vEbSzIQs6YALeHEbp3
 8PH2elxtavHIv3bZjHTa2sVFsqy2eJqHHyUmP/DW/y+oNS3V2QnW38Xveo20P0cpNR9Rfn4uvyb
 nuOgqg+D/xfJ7Xz6Gkl1neLMeh0hiHjYp4hIr8SNFezwtTecWlEqVVcDAS7jtT0I8ZAqi9o7Xt7
 GOi9PxRq62LLUgW0GAsx+QjxpJuOHCVFOCqz8c37CohKuByGaQ+kGIQ+/LE/kwohuxkM/QotRIU
 vYh0YHtKnAjpPjgX+BLOmiWR7qRyfn1uwLixWoya7AKAupOauYR1ObmF/oO4PAXrLGUz9ZHV2yd
 d1GLkod37egTd2TYYTWuvv/DS4HxUQxuHQUZGBXhcL7W5fSbkgm8B3BnN6f9XNFXaV1WN8R1lkE
 SaazAumZrcsFatFZ7IQP0Lit7sWSACk/Dv17AO2WqJRV23gKLToc6/KydiTC
X-Received: by 2002:a05:600c:19c7:b0:4a1:70f0:ac2 with SMTP id
 5b1f17b1804b1-4a180648d69mr62462435e9.24.1791408925419; 
 Wed, 07 Oct 2026 14:35:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f486b6fsm71256795e9.1.2026.10.07.14.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:35:24 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 7 Oct 2026 21:35:21 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03
X-Gerrit-Change-Number: 1899
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1899?usp=email>
X-Gerrit-Commit: 3a78bd3912607e5a62dad0453d5fc8bc37619073
In-Reply-To: <gerrit.1788765781000.Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03@gerrit.openvpn.net>
References: <gerrit.1788765781000.Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzY1NzgxMDAwLklhZjY4YWJmMGQyNTc1ZWU0Y2QzMGRjNGYzZWY2MjdmNmIyMmVjYjAzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <13f5777b930ab0ad2fe41fbf2156cb45b02060e8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEZIS-00022N-Ip
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5643900111815328807=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5643900111815328807==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FAfunVK4H/8="; charset=UTF-8

--FAfunVK4H/8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#4) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1899?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Arne Schwabe


Change subject: reliable: characterize th=
e packet id comparisons before rewriting them
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

reliable: characterize the packet id com=
parisons before rewriting them

The comparisons are about to lose their 2^3=
1 horizon helpers=2E Pin the
accepted id set at each site first, by sweepin=
g anchors and offsets across
the 0/2^32 wrap and the 0x80000000 midpoint ag=
ainst reference
implementations of the current behaviour=2E

reliable_not_r=
eplay(), reliable_wont_break_sequentiality(), the three scans
for the oldes=
t unacknowledged entry and the ASSERT in
reliable_mark_active_incoming() ha=
d no coverage at all=2E

The receive path is characterized as the verdict s=
sl=2Ec produces
(drop / ack-only / store) rather than as two predicates, be=
cause a replay is
still acknowledged while a sequentiality break is not=2E =
Its sweep splits at
2^31: reliable_wont_break_sequentiality() compares in a=
bsolute terms, so
above that base its accepted set shifts=2E

Change-Id: Ia=
f68abf0d2575ee4cd30dc4f3ef627f6b22ecb03
Signed-off-by: Razvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1899
Message-Id: <20261=
007172007=2E23382-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archiv=
e=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39760=2Ehtml
Signed-off-=
by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M tests/unit_tests/openvpn/t=
est_packet_id=2Ec
1 file changed, 348 insertions(+), 2 deletions(-)


  git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/99/1899/4

di=
ff --git a/tests/unit_tests/openvpn/test_packet_id=2Ec b/tests/unit_tests/o=
penvpn/test_packet_id=2Ec
index dc77553=2E=2Eaabb555 100644
--- a/tests/uni=
t_tests/openvpn/test_packet_id=2Ec
+++ b/tests/unit_tests/openvpn/test_pack=
et_id=2Ec
@@ -516,6 +516,344 @@
     reliable_free(rel);
 }
 
+/*
+ * Refer=
ence implementations of the packet id comparisons as they behave today=2E
+=
 * The sweeps below assert reliable=2Ec agrees with them at the anchors swe=
pt, so
+ * a change to an accepted id set there fails a test=2E Keep them s=
tandalone:
+ * expressing them in terms of reliable=2Ec would make the swee=
ps tautologies=2E
+ */
+
+/* "p1 < p2" with the 2^31 horizon, i=2Ee=2E ((in=
t32_t)(p1 - p2) < 0) */
+static bool
+ref_pid_min(packet_id_type p1, packet=
_id_type p2)
+{
+    return (packet_id_type)(p1 - p2) >=3D 0x80000000u;
+}
=
+
+/* one short of RELIABLE_CAPACITY, which is what the code accepts today =
*/
+#define CHARACTERIZED_SEND_WINDOW 11
+
+/* TLS_RELIABLE_N_SEND_BUFFERS =
and P_CONTROL_V1, from ssl_pkt=2Eh, which this
+ * test binary does not pul=
l in */
+#define CHAR_N_SEND_BUFFERS    6
+#define CHAR_OPCODE_CONTROL_V1 4=

+
+static bool
+ref_pid_in_send_window(const struct reliable *rel, packet_=
id_type pid)
+{
+    const packet_id_type dist =3D (packet_id_type)(rel->pa=
cket_id - pid);
+
+    return dist >=3D 1 && dist <=3D CHARACTERIZED_SEND_W=
INDOW;
+}
+
+static bool
+ref_wont_break_sequentiality(const struct reliabl=
e *rel, packet_id_type id)
+{
+    const packet_id_type base =3D rel->packe=
t_id;
+    const packet_id_type extent =3D (packet_id_type)rel->size;
+
+  =
  /* char_anchors and char_anchors_high stay clear of the overflow, where
+=
     * reliable_pid_in_range2() used a 0x80000000 bias instead */
+    asse=
rt_true(base + extent >=3D base);
+
+    return id < base + extent;
+}
+
+s=
tatic bool
+ref_not_replay(const struct reliable *rel, packet_id_type id)
+=
{
+    if (ref_pid_min(id, rel->packet_id))
+    {
+        return false;
+=
    }
+
+    for (int i =3D 0; i < rel->size; ++i)
+    {
+        if (rel-=
>array[i]=2Eactive && rel->array[i]=2Epacket_id =3D=3D id)
+        {
+    =
        return false;
+        }
+    }
+
+    return true;
+}
+
+/* The re=
ceive path verdict as ssl=2Ec produces it: stored only if both checks
+ * p=
ass, a replay still ACKed, a sequentiality break dropped without an ACK=2E =
*/
+enum recv_verdict
+{
+    RECV_DROP,
+    RECV_ACK_ONLY,
+    RECV_STOR=
E
+};
+
+static enum recv_verdict
+recv_filter(const struct reliable *rel, =
packet_id_type id)
+{
+    if (!reliable_wont_break_sequentiality(rel, id))=

+    {
+        return RECV_DROP;
+    }
+
+    return reliable_not_replay=
(rel, id) ? RECV_STORE : RECV_ACK_ONLY;
+}
+
+static enum recv_verdict
+ref=
_recv_filter(const struct reliable *rel, packet_id_type id)
+{
+    if (!re=
f_wont_break_sequentiality(rel, id))
+    {
+        return RECV_DROP;
+   =
 }
+
+    return ref_not_replay(rel, id) ? RECV_STORE : RECV_ACK_ONLY;
+}
+=

+/* Anchors for rel->packet_id=2E reliable_wont_break_sequentiality() comp=
ares id
+ * against rel->packet_id + rel->size in absolute terms, so its ac=
cepted set
+ * depends on where rel->packet_id sits: up to 2^31 that leaves=
 the composite
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
 newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03
Gerrit-Change-Number: 1899
Gerr=
it-PatchSet: 4
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--FAfunVK4H/8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #4</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1899?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Arne Schwabe</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">rel=
iable: characterize the packet id comparisons before rewriting them<br><br>=
The comparisons are about to lose their 2^31 horizon helpers=2E Pin the<br>=
accepted id set at each site first, by sweeping anchors and offsets across<=
br>the 0/2^32 wrap and the 0x80000000 midpoint against reference<br>impleme=
ntations of the current behaviour=2E<br><br>reliable_not_replay(), reliable=
_wont_break_sequentiality(), the three scans<br>for the oldest unacknowledg=
ed entry and the ASSERT in<br>reliable_mark_active_incoming() had no covera=
ge at all=2E<br><br>The receive path is characterized as the verdict ssl=2E=
c produces<br>(drop / ack-only / store) rather than as two predicates, beca=
use a replay is<br>still acknowledged while a sequentiality break is not=2E=
 Its sweep splits at<br>2^31: reliable_wont_break_sequentiality() compares =
in absolute terms, so<br>above that base its accepted set shifts=2E<br><br>=
Change-Id: Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03<br>Signed-off-by: Razv=
an Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1899<br>Message-Id: &lt;20261007172007=2E23382-1-gert@greenie=2E=
muc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg39760=2Ehtml<br>Signed-off-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>---<br>M tests/unit_tests/openvpn/test_packet_i=
d=2Ec<br>1 file changed, 348 insertions(+), 2 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/99/1899/4</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/test_packet_id=2Ec=
 b/tests/unit_tests/openvpn/test_packet_id=2Ec</span><br><span>index dc7755=
3=2E=2Eaabb555 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_p=
acket_id=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_packet_id=
=2Ec</span><br><span>@@ -516,6 +516,344 @@</span><br><span>     reliable_fr=
ee(rel);</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Reference implementations of the packet id comparisons as they =
behave today=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * T=
he sweeps below assert reliable=2Ec agrees with them at the anchors swept, =
so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * a change to an=
 accepted id set there fails a test=2E Keep them standalone:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * expressing them in terms of rel=
iable=2Ec would make the sweeps tautologies=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* &quot=
;p1 &lt; p2&quot; with the 2^31 horizon, i=2Ee=2E ((int32_t)(p1 - p2) &lt; =
0) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ref_pid_min(packet_id_=
type p1, packet_id_type p2)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 (packet_id_type)(p1 - p2) &gt;=3D 0x80000000u;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* one sh=
ort of RELIABLE_CAPACITY, which is what the code accepts today */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define CHARACTERIZED_SEND_WI=
NDOW 11</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* TLS_RELIABLE_N_SEND_BUFFERS =
and P_CONTROL_V1, from ssl_pkt=2Eh, which this</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * test binary does not pull in */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define CHAR_N_SEND_BUFFERS    6<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CHAR_OPCODE_=
CONTROL_V1 4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ref_pid_in_send_window(const struc=
t reliable *rel, packet_id_type pid)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const packet_id_type dist =3D (packet_id_type)(rel-&gt;packet_id - pid);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return dist &gt;=3D 1 &amp;&amp; d=
ist &lt;=3D CHARACTERIZED_SEND_WINDOW;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ref_wont_break_sequentiali=
ty(const struct reliable *rel, packet_id_type id)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const packet_id_type base =3D rel-&gt;packet_id;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const packet_id_type exten=
t =3D (packet_id_type)rel-&gt;size;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* char_anchors and char_anchors_high stay clear of the overflow, where</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * reliable_pid_in=
_range2() used a 0x80000000 bias instead */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(base + extent &gt;=3D base);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return id &lt; base + extent;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+r=
ef_not_replay(const struct reliable *rel, packet_id_type id)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (ref_pid_min(id, rel-&gt;packet_id))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (rel-&gt;array[i]=2Eactive &amp;&amp; rel-&gt;a=
rray[i]=2Epacket_id =3D=3D id)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* The receive path verdict as ssl=2Ec produces it: stored only if both chec=
ks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * pass, a replay=
 still ACKed, a sequentiality break dropped without an ACK=2E */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+enum recv_verdict</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    RECV_DROP,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    RECV_ACK_ONLY,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    RECV_STORE</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static enum recv_verdi=
ct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+recv_filter(const=
 struct reliable *rel, packet_id_type id)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!reliable_wont_break_sequentiality(rel, id))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return RECV_DROP;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return reliable_not_replay(rel, id) ? RECV_STORE : RECV_ACK_ONLY;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static enum recv_verdict</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ref_recv_filter(const struct reliable *rel, packet_id_type id=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!ref_wont_break_sequentialit=
y(rel, id))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return RECV_DR=
OP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return ref_not_replay(rel, id) ? RECV_STORE :=
 RECV_ACK_ONLY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Anchors for rel-&gt;packet_id=2E relia=
ble_wont_break_sequentiality() compares id</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * against rel-&gt;packet_id + rel-&gt;size in absol=
ute terms, so its accepted set</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * depends on where rel-&gt;packet_id sits: up to 2^31 that leav=
es the composite</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
verdict unchanged, above it it does not, hence the split=2E Bases past</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * 0xFFFFFFF3 are exclud=
ed, rel-&gt;packet_id + rel-&gt;size overflowing there=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static const packet_id_type char_a=
nchors[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0=
x00000000,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x000=
00001,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x0000000=
5,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x0000000B,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x0000000C,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x0000000D,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    0x000001F4,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    0x7FFFFFF4,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    0x7FFFFFFF,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    0x80000000,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 const packet_id_type char_anchors_high[] =3D {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    0x80000001,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    0x8000000C,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    0xFFFFFFF0,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    0xFFFFFFF3,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* offsets applied below=
 and above each anchor */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static const packet_id_type char_offsets[] =3D {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    0,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    1,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    2,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
10,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    11,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    12,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    13,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    14,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    100,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    0x3FFFFFFF,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
0x40000000,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x7F=
FFFFFE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x7FFFFF=
FF,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x80000000,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x80000001,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x80000002,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    0xFFFFFFF4,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    0xFFFFFFFE,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    0xFFFFFFFF,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sweep_rec=
v_filter(const packet_id_type *anchors, size_t n_anchors,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                  enum recv_verdict (=
*oracle)(const struct reliable *, packet_id_type))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    for (size_t a =3D 0; a &lt; n_anchors; a++)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        for (size_t o =3D 0; o &lt; SIZE(char_of=
fsets); o++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* pr=
obe both below and above the anchor */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            const packet_id_type ids[] =3D {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                (packet_id_type=
)(anchors[a] - char_offsets[o]),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                (packet_id_type)(anchors[a] + char_offsets[o])=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            for (size_t i =3D 0; i &lt; S=
IZE(ids); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     struct reliable rel =3D { 0 };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                rel=2Esize =3D RELIABLE_CAPACITY;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                rel=2Epacket_=
id =3D anchors[a];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                asse=
rt_int_equal(oracle(&amp;rel, ids[i]), recv_filter(&amp;rel, ids[i]));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                /* with the id already in=
 a receive slot it can only be</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                 * acknowledged or dropped, never stored again *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                re=
l=2Earray[3]=2Eactive =3D true;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                rel=2Earray[3]=2Epacket_id =3D ids[i];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                assert_int_equal(oracle(&amp;re=
l, ids[i]), recv_filter(&amp;rel, ids[i]));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                assert_int_not_equal(RECV_STORE, re=
cv_filter(&amp;rel, ids[i]));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* bases at or below 2^31, where old and new agree; never=
 to change */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_recv_filt=
er_characterization(void **state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
sweep_recv_filter(char_anchors, SIZE(char_anchors), ref_recv_filter);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* bases above 2^31, where they diverge, kept apart so a cha=
nge confined</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ther=
e touches one test */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_r=
ecv_filter_high_base(void **state)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 sweep_recv_filter(char_anchors_high, SIZE(char_anchors_high), ref_recv_fil=
ter);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+sweep_send_window(const packet_id_type *anchors, size_t n_a=
nchors)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t a =3D 0; a &lt=
; n_anchors; a++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (siz=
e_t o =3D 0; o &lt; SIZE(char_offsets); o++)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            const packet_id_type ids[] =3D {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                (packet_id_type)(an=
chors[a] - char_offsets[o]),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                (packet_id_type)(anchors[a] + char_offsets[o]),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            for (size_t i =3D 0; i &lt; SIZE(i=
ds); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
struct reliable rel =3D { 0 };</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                rel=2Esize =3D CHAR_N_SEND_BUFFERS;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                rel=2Epacket_id =
=3D anchors[a];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                assert_=
int_equal(ref_pid_in_send_window(&amp;rel, ids[i]),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                 validate=
_packet_id_window(&amp;rel, ids[i]) !=3D 0);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* a pure distance test, so identical at =
every base */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_send_wind=
ow_characterization(void **state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
sweep_send_window(char_anchors, SIZE(char_anchors));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    sweep_send_window(char_anchors_high, =
SIZE(char_anchors_high));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* reliable_send() picks the ol=
dest eligible entry, across the wrap and the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * signed midpoint */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_reliable_send_picks_oldest(void **state)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    now =3D 1000;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct reliable rel =3D { 0 };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    rel=2Esize =3D CHAR_N_SEND_BUFFERS;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    rel=2Einitial_timeout =3D 2;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Epacket_id =
=3D 3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* 6, 2 and 1 below rel-&gt;=
packet_id; the first sits exactly on the window</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * edge, where rel-&gt;size still admits it=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const packet=
_id_type wrapped[] =3D { 0xFFFFFFFD, 1, 2 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    for (size_t i =3D 0; i &lt; SIZE(wrapped); i++)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        rel=2Earray[i]=2Eactive =3D true;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        rel=2Earray[i]=2Epack=
et_id =3D wrapped[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        rel=2Earray[i]=2Etimeout =3D 2;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        rel=2Earray[i]=2Enext_try =3D 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int opcode =3D 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_ptr_equal(&amp;rel=2Earray[0]=2Ebuf, reliable_send(&=
amp;rel, &amp;opcode));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* same acr=
oss the signed midpoint */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct reliable rel2 =3D { 0 };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    rel2=2Esize =3D CHAR_N_SEND_BUFFERS;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    rel2=2Einitial_timeout =3D =
2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel2=2Epacket=
_id =3D 0x80000002;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const packet_id=
_type midpoint[] =3D { 0x7FFFFFFF, 0x80000000, 0x80000001 };</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; SIZE(midpoint); i++)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        rel2=2Earray[i]=2Eactive =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
l2=2Earray[i]=2Epacket_id =3D midpoint[i];</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        rel2=2Earray[i]=2Etimeout =3D 2;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        rel2=2Earray[i]=2Enext_=
try =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(&amp;rel2=2Earray[0]=
=2Ebuf, reliable_send(&amp;rel2, &amp;opcode));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* reliab=
le_get_buf_output_sequenced() stops issuing ids once rel-&gt;packet_id is</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * a full window ahea=
d of the oldest unacknowledged one */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+test_get_buf_output_sequenced_boundary(void **state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct reliable *rel =3D test_reliable_new();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    rel-&gt;array[0]=2Eactive =3D true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel-&gt;array[0=
]=2Epacket_id =3D 100;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* distance =
7 &lt; size 8: still allowed */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    rel-&gt;packet_id =3D 107;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_non_null(reliable_get_buf_output_sequence=
d(rel));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* distance 8 =3D=3D size =
8: refused */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
l-&gt;packet_id =3D 108;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_null(reliable_get_buf_output_sequenced(rel));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* same boundary across the wrap */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    rel-&gt;array[0]=2Epacket_id=
 =3D 0xFFFFFFFC;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 rel-&gt;packet_id =3D 3;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_non_null(reliable_get_buf_output_sequenced(rel));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    rel-&gt;packet_id =3D 4;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_null(reliable_get_buf_outpu=
t_sequenced(rel));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reliable_free(re=
l);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Ids at or just ahead of rel-&gt;packet_id are acce=
pted */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_mark_active_inc=
oming_accepts_window(void **state)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct reliable rel =3D { 0 };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    rel=2Esize =3D RELIABLE_CAPACITY;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    rel=2Epacket_id =3D 10;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    reliable_mark_active_incoming(&amp;rel, &amp;rel=2Ea=
rray[0]=2Ebuf, 10, CHAR_OPCODE_CONTROL_V1);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(rel=2Earray[0]=2Eactive);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(10, rel=
=2Earray[0]=2Epacket_id);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reliable_=
mark_active_incoming(&amp;rel, &amp;rel=2Earray[1]=2Ebuf, 10 + RELIABLE_CAP=
ACITY - 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                         CHAR_OPCODE_CONTROL_V1);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_true(rel=2Earray[1]=2Eactive);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Ids below rel-&gt;packet_id abort=2E The far-ahead case i=
s left unpinned: callers</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * cannot produce it, and the bound may legitimately tighten=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * NOTE: expect_assert_failure() does not=
 work with MSVC=2E It catches the ASSERT</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * by longjmp()ing out of assert_failed(), and MSVC&#3=
9;s longjmp() unwinds the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * intervening frames through RtlUnwindEx() instead of just restoring=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * registers, w=
hich faults=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
fndef _MSC_VER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_mark_act=
ive_incoming_rejects_past_ids(void **state)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct reliable rel =3D { 0 };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    rel=2Esize =3D RELIABLE_CAPACITY;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    rel=2Epacket_id =3D 10;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    expect_assert_failure(</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        reliable_mark_active_incoming(&a=
mp;rel, &amp;rel=2Earray[0]=2Ebuf, 5, CHAR_OPCODE_CONTROL_V1));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    expect_assert_failure(</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        reliable_mark_ac=
tive_incoming(&amp;rel, &amp;rel=2Earray[1]=2Ebuf, 0xFFFFFFFF, CHAR_OPCODE_=
CONTROL_V1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef _MSC_VE=
R */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><s=
pan> main(void)</span><br><span> {</span><br><span>@@ -541,8 +879,16 @@</sp=
an><br><span>         cmocka_unit_test(test_packet_id_window),</span><br><s=
pan>         cmocka_unit_test(test_reliable_backoff_is_bounded),</span><br>=
<span>         cmocka_unit_test(test_reliable_purge_ignores_forged_acks),</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_tes=
t(test_reliable_purge_legitimate_ack)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     cmocka_unit_test(test_reliable_purge_legitimate_ack),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_recv_f=
ilter_characterization),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        cmocka_unit_test(test_recv_filter_high_base),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_send_w=
indow_characterization),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        cmocka_unit_test(test_reliable_send_picks_oldest),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_g=
et_buf_output_sequenced_boundary),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        cmocka_unit_test(test_mark_active_incoming_accepts_w=
indow),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef _MSC=
_VER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_=
unit_test(test_mark_active_incoming_rejects_past_ids),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>     };</span><br=
><span> </span><br><span>     return cmocka_run_group_tests_name(&quot;pack=
et_id tests&quot;, tests, NULL, NULL);</span><br></pre><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1899?usp=3Demail">chang=
e 1899</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1899?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1899 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>

</body></html>
--FAfunVK4H/8=--


--===============5643900111815328807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5643900111815328807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5643900111815328807==--

