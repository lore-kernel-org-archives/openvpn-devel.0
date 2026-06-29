Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92D1C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Uux+/iEOw06Q+U8nB7kI57C+EZIAgQBjYZYLbNF9nRk=; b=lCDPZZRPduRYFn
	Uufx9E4jhA8aB/38DmzenhGch1tiQUg8py2vgidSWwnA9oQ9iqNwAoafVG91Z8rPHcNQ2o9gePI/0
	0zOkhQ1Uv6SoEG5pbSkHDtrM4m0iJa1ibnysPhmc95Fsrvo+Od3HVxiiQV3d/NgMgv3A6QAf0L34R
	HDQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1we6tV-0002HJ-Pp;
	Mon, 29 Jun 2026 07:59:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1we6tU-0002H2-69
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NdVZU5GkyGxDCNymGuvvCkzzqrLTcmm8UwNQCogRdCA=; b=c5bDhWAqTLPGwHLbmITMGNsm5T
 iX8Gh6JAksJZtnDdPTkMPCmbWSDV2Gg9Q2fGdrGOrdxf/zjJXqra5OWQ3Iint/eIbN5alGOfjbJXa
 fl+VWuJnxZch4IyhRGCvnGtpH7mCbUu7S5BdXRZvdMDFIvTt8T+y6ac0rFM66xqvMdKs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NdVZU5GkyGxDCNymGuvvCkzzqrLTcmm8UwNQCogRdCA=; b=h
 6prIm+2ekiJsv+dfxw9Q2Oa/Z7pqUm6l5iVYfCUGqBnPCgyuIdsXsafKZTtkUR8T9uI5YvXMCrLQa
 VtKJ+67bbgsTqPJDuGxkkGP2v/6IyBidqJcqtpkQkoTwxwVlERWu8PmrM0U9W97jz2pmwiHQukRSZ
 LrKsiq8khi1xccdA=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1we6tR-0008Mz-4D for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:04 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-470174001a0so1156731f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 00:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782719930; x=1783324730; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NdVZU5GkyGxDCNymGuvvCkzzqrLTcmm8UwNQCogRdCA=;
 b=GXSOIitFLhpQ4LGqVQQe4QYcmVHM6fF9j5H7ogm6J/JW2SvmMDbR7BBQaqAB/1Cace
 Jx4MPPDt3ffFdDPm8LAued3ZYvj79sb2ArxaKrG4Mpc5FZGis1yo8hIZEp5p4YGgIwnI
 zbcp73t5TMq0fvwU9g/w8a6k0AU62YQxi2tlJGrrSFHoKagogLK8G8YC+ierdoNvFcsC
 hQiHvvBWjQIhPOBD1YTancGtyeaFhvvAGRnVWX9gVelqXjLHzvpCu/6agi7bPnqSwN26
 t3K0aAd1vQ2MT3VUVgCO4GseaYRm8yMM3vSKPuHiLin4bKcIj01igFC08vWfS3GcaNyZ
 kCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782719930; x=1783324730;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NdVZU5GkyGxDCNymGuvvCkzzqrLTcmm8UwNQCogRdCA=;
 b=pR2xKVePZsfP251FhE5+EZyajM/YjLQqqRbyEqSiK5up8cinKSGdfdKbCqan80YtfQ
 Zgo3ygxOPhz7QsppdGXx6cbCOATsPrRwAQEFhd45ZT19sj5ZnxRZ+IgwkZOVR61oV5dU
 Tdu0h1NS8OA6O3XGDKqvehVQxoM3YOMM9NBko5+A1+bAzHce4EEGr2K10Yy6YWdf9JlU
 lTHoOh2tuIDX2SmiiI/rbGKyAGmFx1cSxyqVqwsc6u7v2ZirH7EA8ZG+E5BrLt7xYAUK
 TLpvVlq3QR9yhEEjq6Hyzv7IHIa7ZOHeDSLZcUysYzVK0EbQ/M4oJ9yO4PofPBIjLExB
 dsWQ==
X-Gm-Message-State: AOJu0YwrsfPVRcaFnXacxKU6JC7oVs5BAzFmCCGYM1UJGo316lzWfjmv
 LgItIUGp9vq1Jelg6UPx0+h3KUzDqkpHJ5efv4kkBUAbxQnzezuZGKaORdxT96/MbMPZZ2OQyVT
 vOiYqzKsCQqxXHBO/1DSKHVQJfd8TPORBQjOUyCWcuxHewvBsc4g/b2dgUHfVl9l1xX64qEFobq
 60SutDrQ==
X-Gm-Gg: AfdE7cm8ZEUIDDyCXHg9+6prRiren8S37xcOgFMV/oad5nOSfZO2QXM3dSRAmxflYOB
 7kbgVb5ig9VoUX6rK7JbcyG9GedU9yNHoQd1tVYL+SAZl6pTMe/3vS12H3NIz2xomtN9Wal0ce3
 xUGibkPt1bbmTusTdk+t/M9QQAeBDvezx7Ww70XmvzQBkadiep/f3u+vHg2t1rbY/Un4PlI5hOe
 EWzXCCwQ9a93YEa3AmmLTco5meQ50Sk1Cd85/ODSufVg0wK15fNtNCCDIfk9szkhRI1kqH3bPPs
 yvkUWOwojftRyGRFCWLND9oEXr5E854tB6S3IqDF+64Eu9RUve4P4lKwBhgBXrDNwWN8+5Pu7p5
 /iWUhuiPmwuUClzMugbkiHq9CQ9fCuH3BBfYjsC+PMzABHZARQBt03s/Q8/AJmSy9y9NGnbSL5U
 I74Mutq9GtFv1h7ry76LPhm/mL/PDIor/RIl3V/CTJNVv29z9VDtR+LnzvWzFiKUq0kzYW0IAQ1
 yxYJ63W4Z3B/707EPMfq7Gvzvwa0xrtk0eihxFgh07BARksKUQzREGaiBEDa6JBj/akxcexTdH2
 RKE=
X-Received: by 2002:a05:6000:2893:b0:460:1a36:deac with SMTP id
 ffacd0b85a97d-46dc0d0e9famr25393713f8f.24.1782719929509; 
 Mon, 29 Jun 2026 00:58:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46f9db29a94sm26629451f8f.22.2026.06.29.00.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 00:58:49 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 07:58:48 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 2ff2cd48f827716f0eb8e58c4396eec027284068
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fe2925839b16c0a7999b7d619886228a8776f862-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1we6tR-0008Mz-4D
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add control
 message TLV encoding (P_CONTROL_OOB_V1)
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
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2229974522724920197=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2229974522724920197==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="utvIiVMdw5o="; charset=UTF-8

--utvIiVMdw5o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1741?usp=3Demail

to review the following change=2E


Chang=
e subject: oob: Add control message TLV encoding (P_CONTROL_OOB_V1)
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add control me=
ssage TLV encoding (P_CONTROL_OOB_V1)

Reserve opcode 12 (P_CONTROL_OOB_V1)=
 for out-of-band control messages and
add encoding/decoding for the SERVER_=
PROBE / PROBE_REPLY TLVs used for
server latency checks:

  - probe_paramet=
er (0x200): client timestamp + capability flags
  - probe_reply    (0x201):=
 echoed session id, DNS-SRV style priority and
                            =
weight, connect_lifetime and behaviour flags

Each TLV has a 4-byte header =
(15-bit type plus an optional flag, then a
16-bit value length)=2E Readers =
enforce the minimum value length and skip
trailing bytes they do not unders=
tand, so the format stays forward
compatible and multi-TLV framing resynchr=
onises=2E

P_LAST_OPCODE is deliberately left at 11: opcode 12 is not yet a=
ccepted by
tls_pre_decrypt()=2E The legal-opcode range is widened together =
with the
receive handler in a follow-up, which also wires oob=2Ec into the =
openvpn
build=2E For now the codec is exercised only by the unit tests=2E

=
See the OOB control message section of the OpenVPN wire protocol
specificat=
ion (openvpn-rfc PR #30)=2E

Change-Id: I1c8d302ac57c5603d622a7be14be369437=
388268
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M CMakeLists=2Et=
xt
A src/openvpn/oob=2Ec
A src/openvpn/oob=2Eh
M src/openvpn/ssl_pkt=2Eh
M =
tests/unit_tests/openvpn/Makefile=2Eam
A tests/unit_tests/openvpn/test_oob=
=2Ec
6 files changed, 524 insertions(+), 0 deletions(-)



  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1741/1

diff --git a/=
CMakeLists=2Etxt b/CMakeLists=2Etxt
index 8de836a=2E=2Ed2b88c0 100644
--- a=
/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -665,6 +665,7 @@
         "test=
_mbuf"
         "test_misc"
         "test_ncp"
+        "test_oob"
       =
  "test_options_parse"
         "test_packet_id"
         "test_pkt"
@@ -85=
5,6 +856,12 @@
         src/openvpn/session_id=2Ec
         )
 
+    target=
_sources(test_oob PRIVATE
+        tests/unit_tests/openvpn/mock_get_random=
=2Ec
+        src/openvpn/oob=2Ec
+        src/openvpn/session_id=2Ec
+    =
    )
+
     target_sources(test_pkt PRIVATE
         tests/unit_tests/open=
vpn/mock_win32_execve=2Ec
         src/openvpn/argv=2Ec
diff --git a/src/op=
envpn/oob=2Ec b/src/openvpn/oob=2Ec
new file mode 100644
index 0000000=2E=
=2E9f123e2
--- /dev/null
+++ b/src/openvpn/oob=2Ec
@@ -0,0 +1,154 @@
+/*
+ =
*  OpenVPN -- An application to securely tunnel IP networks
+ *            =
 over a single TCP/UDP port, with support for SSL/TLS-based
+ *            =
 session authentication and key exchange,
+ *             packet encryption=
, packet authentication, and
+ *             packet compression=2E
+ *
+ * =
 Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This pr=
ogram is free software; you can redistribute it and/or modify
+ *  it under=
 the terms of the GNU General Public License version 2
+ *  as published by=
 the Free Software Foundation=2E
+ *
+ *  This program is distributed in th=
e hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even =
the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PU=
RPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+=
 *  You should have received a copy of the GNU General Public License along=

+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E=

+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "s=
yshead=2Eh"
+
+#include "oob=2Eh"
+
+/* Consume @p value_len bytes of TLV v=
alue, of which @p consumed have already
+ * been read, ignoring (skipping) =
any trailing bytes that this version does not
+ * understand=2E Fails if fe=
wer than @p consumed bytes were declared=2E */
+static bool
+oob_skip_trail=
ing(struct buffer *buf, uint16_t value_len, int consumed)
+{
+    if (value=
_len < consumed)
+    {
+        return false;
+    }
+    return buf_advan=
ce(buf, value_len - consumed);
+}
+
+bool
+oob_msg_write_header(struct buff=
er *buf, uint16_t msg_type)
+{
+    return buf_write_u16(buf, msg_type);
+}=

+
+bool
+oob_msg_read_header(struct buffer *buf, uint16_t expected_msg_typ=
e)
+{
+    int msg_type =3D buf_read_u16(buf);
+    return msg_type >=3D 0 =
&& (uint16_t)msg_type =3D=3D expected_msg_type;
+}
+
+bool
+oob_tlv_write_h=
eader(struct buffer *buf, uint16_t type, bool optional, uint16_t value_len)=

+{
+    uint16_t field =3D type & OOB_TLV_TYPE_MASK;
+    if (optional)
+ =
   {
+        field |=3D OOB_TLV_OPTIONAL_FLAG;
+    }
+    return buf_writ=
e_u16(buf, field) && buf_write_u16(buf, value_len);
+}
+
+bool
+oob_tlv_rea=
d_header(struct buffer *buf, uint16_t *type, bool *optional, uint16_t *valu=
e_len)
+{
+    int field =3D buf_read_u16(buf);
+    if (field < 0)
+    {
=
+        return false;
+    }
+    int len =3D buf_read_u16(buf);
+    if (=
len < 0)
+    {
+        return false;
+    }
+    *type =3D (uint16_t)(fie=
ld & OOB_TLV_TYPE_MASK);
+    *optional =3D (field & OOB_TLV_OPTIONAL_FLAG)=
 !=3D 0;
+    *value_len =3D (uint16_t)len;
+    return true;
+}
+
+bool
+o=
ob_probe_parameter_write(struct buffer *buf, const struct oob_probe_paramet=
er *p)
+{
+    return oob_tlv_write_header(buf, OOB_TLV_PROBE_PARAMETER, fa=
lse, OOB_PROBE_PARAMETER_LEN)
+           && buf_write_u64(buf, p->timestam=
p)
+           && buf_write_u32(buf, p->flags);
+}
+
+bool
+oob_probe_param=
eter_read(struct buffer *buf, struct oob_probe_parameter *p, uint16_t value=
_len)
+{
+    if (value_len < OOB_PROBE_PARAMETER_LEN)
+    {
+        retu=
rn false;
+    }
+    bool ok =3D true;
+    p->timestamp =3D buf_read_u64(=
buf, &ok);
+    p->flags =3D buf_read_u32(buf, &ok);
+    if (!ok)
+    {
+=
        return false;
+    }
+    return oob_skip_trailing(buf, value_len, =
OOB_PROBE_PARAMETER_LEN);
+}
+
+bool
+oob_probe_reply_write(struct buffer *=
buf, const struct oob_probe_reply *r)
+{
+    return oob_tlv_write_header(b=
uf, OOB_TLV_PROBE_REPLY, false, OOB_PROBE_REPLY_LEN)
+           && session=
_id_write(&r->peer_session_id, buf)
+           && buf_write_u16(buf, r->pr=
iority)
+           && buf_write_u16(buf, r->weight)
+           && buf_wri=
te_u16(buf, r->connect_lifetime)
+           && buf_write_u32(buf, r->flags=
)
+           && buf_write_u16(buf, r->max_latency_diff);
+}
+
+bool
+oob_p=
robe_reply_read(struct buffer *buf, struct oob_probe_reply *r, uint16_t val=
ue_len)
+{
+    if (value_len < OOB_PROBE_REPLY_LEN)
+    {
+        return=
 false;
+    }
+    if (!session_id_read(&r->peer_session_id, buf))
+    {
=
+        return false;
+    }
+    int priority =3D buf_read_u16(buf);
+   =
 int weight =3D buf_read_u16(buf);
+    int connect_lifetime =3D buf_read_u=
16(buf);
+    if (priority < 0 || weight < 0 || connect_lifetime < 0)
+    =
{
+        return false;
+    }
+    bool ok =3D true;
+    r->flags =3D bu=
f_read_u32(buf, &ok);
+    int max_latency_diff =3D buf_read_u16(buf);
+   =
 if (!ok || max_latency_diff < 0)
+    {
+        return false;
+    }
+   =
 r->priority =3D (uint16_t)priority;
+    r->weight =3D (uint16_t)weight;
+=
    r->connect_lifetime =3D (uint16_t)connect_lifetime;
+    r->max_latency=
_diff =3D (uint16_t)max_latency_diff;
+    return oob_skip_trailing(buf, va=
lue_len, OOB_PROBE_REPLY_LEN);
+}
diff --git a/src/openvpn/oob=2Eh b/src/op=
envpn/oob=2Eh
new file mode 100644
index 0000000=2E=2Ec32a7db
--- /dev/null=

+++ b/src/openvpn/oob=2Eh
@@ -0,0 +1,147 @@
+/*
+ *  OpenVPN -- An applica=
tion to securely tunnel IP networks
+ *             over a single TCP/UDP p=
ort, with support for SSL/TLS-based
+ *             session authentication =
and key exchange,
+ *             packet encryption, packet authentication,=
 and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026=
 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; =
you can redistribute it and/or modify
+ *  it under the terms of the GNU Ge=
neral Public License version 2
+ *  as published by the Free Software Found=
ation=2E
+ *
+ *  This program is distributed in the hope that it will be u=
seful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
=
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  G=
NU General Public License for more details=2E
+ *
+ *  You should have rece=
ived a copy of the GNU General Public License along
+ *  with this program;=
 if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @file
+=
 * Encoding/decoding of out-of-band (P_CONTROL_OOB_V1) control messages=2E
=
+ *
+ * An OOB message payload starts with a 16-bit message type (the 0x1xx=
 space:
+ * SERVER_PROBE, PROBE_REPLY, =2E=2E=2E) followed by a sequence of=
 TLV entries=2E
+ *
+ * Each TLV starts with a 4-byte header: a 16-bit fiel=
d whose most significant
+ * bit is the "optional" flag and whose remaining=
 15 bits are the type (the
+ * 0x2xx space), followed by a 16-bit length gi=
ving the size of the value that
+ * follows the header=2E
+ *
+ * This slic=
e implements the SERVER_PROBE / PROBE_REPLY pair used for server
+ * latenc=
y checks=2E Other message/TLV types are added as the feature grows=2E
+ */
=
+
+#ifndef OOB_H
+#define OOB_H
+
+#include "buffer=2Eh"
+#include "session=
_id=2Eh"
+
+/* OOB message types: the 16-bit value at the start of an OOB p=
ayload, before
+ * its TLV entries=2E Distinct from the TLV-type space (0x2=
xx); see the "Messages"
+ * table in the OOB section of the wire protocol s=
pec=2E */
+#define OOB_MSG_SERVER_PROBE 0x100
+#define OOB_MSG_PROBE_REPLY =
 0x101
+
+/* TLV header bit layout of the first 16-bit field */
+#define OO=
B_TLV_OPTIONAL_FLAG 0x8000
+#define OOB_TLV_TYPE_MASK     0x7fff
+
+/* TLV =
types (see the OOB control message section of the wire protocol spec) */
+#=
define OOB_TLV_PROBE_PARAMETER 0x200
+#define OOB_TLV_PROBE_REPLY     0x201=

+
+/* Minimum on-wire value length (excluding the 4-byte TLV header) of ea=
ch TLV=2E
+ * The value may be longer for forward compatibility; trailing b=
ytes that are
+ * not understood are ignored on read=2E */
+#define OOB_PRO=
BE_PARAMETER_LEN 12
+#define OOB_PROBE_REPLY_LEN     20
+
+/* probe paramet=
er TLV (sent by the client in a SERVER_PROBE) */
+struct oob_probe_paramete=
r
+{
+    uint64_t timestamp; /**< client clock as a UNIX timestamp */
+   =
 uint32_t flags;     /**< client capability flags, currently must be 0 */
+=
};
+
+/* probe reply TLV (sent by the server in a PROBE_REPLY) */
+struct o=
ob_probe_reply
+{
+    struct session_id peer_session_id; /**< echoes the s=
ession id of the request */
+    uint16_t priority;                 /**< DN=
S-SRV style priority (lower is preferred) */
+    uint16_t weight;         =
          /**< DNS-SRV style weight */
+    uint16_t connect_lifetime;     =
    /**< seconds the probe stays valid as a handshake shortcut */
+    uint=
32_t flags;                    /**< server behaviour flags */
+    uint16_t=
 max_latency_diff;         /**< advertised candidate-band margin in ms;
+  =
                                      *   0 means "defer to the client's se=
tting" */
+};
+
+/**
+ * Write an OOB message-type header (the 16-bit messa=
ge type preceding the
+ * TLVs) to @p buf=2E
+ *
+ * @return true on succes=
s, false if @p buf has insufficient space=2E
+ */
+bool oob_msg_write_heade=
r(struct buffer *buf, uint16_t msg_type);
+
+/**
+ * Read and verify an OOB=
 message-type header from @p buf, advancing past it=2E
+ *
+ * @param expec=
ted_msg_type  the message type the payload must carry
+ * @return true if a=
 message type was read and equals @p expected_msg_type,
+ *         false o=
n a short buffer or a mismatching type=2E
+ */
+bool oob_msg_read_header(st=
ruct buffer *buf, uint16_t expected_msg_type);
+
+/**
+ * Write a TLV heade=
r (type + optional flag + value length) to @p buf=2E
+ *
+ * @return true o=
n success, false if @p buf has insufficient space=2E
+ */
+bool oob_tlv_wri=
te_header(struct buffer *buf, uint16_t type, bool optional, uint16_t value_=
len);
+
+/**
+ * Read a TLV header from @p buf, advancing past it=2E
+ *
+ =
* @param type       set to the 15-bit TLV type
+ * @param optional   set to=
 the value of the optional flag
+ * @param value_len  set to the declared v=
alue length
+ * @return true on success, false if there are not enough byte=
s for a header=2E
+ */
+bool oob_tlv_read_header(struct buffer *buf, uint16=
_t *type, bool *optional, uint16_t *value_len);
+
+/**
+ * Write a complete=
 probe parameter TLV (header + value) to @p buf=2E
+ */
+bool oob_probe_par=
ameter_write(struct buffer *buf, const struct oob_probe_parameter *p);
+
+/=
**
+ * Read a probe parameter TLV value of @p value_len bytes from @p buf=
=2E
+ *
+ * The TLV header must already have been consumed (e=2Eg=2E via
+ =
* oob_tlv_read_header())=2E @p value_len bytes are always consumed on succe=
ss,
+ * including any trailing bytes beyond the fields understood here=2E
+=
 *
+ * @return true on success, false if @p value_len is too short or @p bu=
f is
+ *         truncated=2E
+ */
+bool oob_probe_parameter_read(struct bu=
ffer *buf, struct oob_probe_parameter *p,
+                              ui=
nt16_t value_len);
+
+/**
+ * Write a complete probe reply TLV (header + va=
lue) to @p buf=2E
+ */
+bool oob_probe_reply_write(struct buffer *buf, cons=
t struct oob_probe_reply *r);
+
+/**
+ * Read a probe reply TLV value of @p=
 value_len bytes from @p buf=2E See
+ * oob_probe_parameter_read() for the =
calling convention=2E
+ */
+bool oob_probe_reply_read(struct buffer *buf, s=
truct oob_probe_reply *r, uint16_t value_len);
+
+#endif /* OOB_H */
diff -=
-git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index ac9d4be=2E=
=2E0dab524 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=
=2Eh
@@ -58,6 +58,17 @@
  * like P_CONTROL_HARD_RESET_CLIENT_V3 */
 #define=
 P_CONTROL_WKC_V1 11
 
+/* Out-of-band control message that does not belong=
 to an established
+ * control channel session (e=2Eg=2E a server probe)=2E=
 Inherently unreliable:
+ * there is no protocol-level retransmission=2E
+ =
*
+ * NOTE: intentionally not yet included in the P_FIRST_OPCODE=2E=2EP_LAS=
T_OPCODE
+ * legal range=2E The range acts as an acceptance gate in tls_pre=
_decrypt();
+ * widening it before an OOB receive handler exists would let =
OOB packets
+ * be misparsed as established-session control packets=2E Bump=
 P_LAST_OPCODE
+ * to 12 in the same change that adds the handler=2E */
+#d=
efine P_CONTROL_OOB_V1 12
+
 /* define the range of legal opcodes
  * Since=
 we do no longer support key-method 1 we consider
  * the v1 op codes inval=
id */
@@ -266,6 +277,9 @@
         case P_CONTROL_WKC_V1:
             retu=
rn "P_CONTROL_WKC_V1";
 
+        case P_CONTROL_OOB_V1:
+            retur=
n "P_CONTROL_OOB_V1";
+
         case P_ACK_V1:
             return "P_ACK_=
V1";
 
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tes=
ts/openvpn/Makefile=2Eam
index 1128eb4=2E=2E7174aa8 100644
--- a/tests/unit=
_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@=
@ -14,6 +14,7 @@
 	ncp_testdriver \
 	mbuf_testdriver \
 	misc_testdriver \=

+	oob_testdriver \
 	options_parse_testdriver \
 	packet_id_testdriver \
 =
	pkt_testdriver \
@@ -149,6 +150,19 @@
 	$(top_srcdir)/src/openvpn/win32-ut=
il=2Ec \
 	$(top_srcdir)/src/openvpn/session_id=2Ec
 
+oob_testdriver_CFLAG=
S  =3D \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdi=
r)/src/openvpn \
+	@TEST_CFLAGS@
+oob_testdriver_LDFLAGS =3D @TEST_LDFLAGS@=

+oob_testdriver_SOURCES =3D test_oob=2Ec \
+	mock_msg=2Ec mock_msg=2Eh tes=
t_common=2Eh \
+	mock_get_random=2Ec \
+	$(top_srcdir)/src/openvpn/buffer=
=2Ec \
+	$(top_srcdir)/src/openvpn/oob=2Ec \
+	$(top_srcdir)/src/openvpn/pl=
atform=2Ec \
+	$(top_srcdir)/src/openvpn/session_id=2Ec \
+	$(top_srcdir)/s=
rc/openvpn/win32-util=2Ec
+
 pkt_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)=
/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	@TEST_C=
FLAGS@
diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_test=
s/openvpn/test_oob=2Ec
new file mode 100644
index 0000000=2E=2E40dcaf9
--- =
/dev/null
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -0,0 +1,188 @@
+/*=

+ *  OpenVPN -- An application to securely tunnel IP networks
+ *         =
    over a single TCP/UDP port, with support for SSL/TLS-based
+ *         =
    session authentication and key exchange,
+ *             packet encrypt=
ion, packet authentication, and
+ *             packet compression=2E
+ *
+=
 *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This=
 program is free software; you can redistribute it and/or modify
+ *  it un=
der the terms of the GNU General Public License version 2
+ *  as published=
 by the Free Software Foundation=2E
+ *
+ *  This program is distributed in=
 the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without ev=
en the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR=
 PURPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+ =
*
+ *  You should have received a copy of the GNU General Public License al=
ong
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=
=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include=
 "syshead=2Eh"
+
+#include <stdarg=2Eh>
+#include <stddef=2Eh>
+#include <s=
etjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "oob=2Eh"
+#include "test_com=
mon=2Eh"
+
+/* Write a probe parameter TLV and read it back; fields must su=
rvive the
+ * round trip and the whole buffer must be consumed=2E */
+stati=
c void
+test_probe_parameter_roundtrip(void **state)
+{
+    struct gc_aren=
a gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+  =
  const struct oob_probe_parameter in =3D {
+        =2Etimestamp =3D 0x012=
3456789abcdefULL,
+        =2Eflags =3D 0,
+    };
+    assert_true(oob_pro=
be_parameter_write(&buf, &in));
+    /* header (4) + value (12) */
+    ass=
ert_int_equal(BLEN(&buf), 4 + OOB_PROBE_PARAMETER_LEN);
+
+    uint16_t typ=
e;
+    bool optional;
+    uint16_t value_len;
+    assert_true(oob_tlv_re=
ad_header(&buf, &type, &optional, &value_len));
+    assert_int_equal(type,=
 OOB_TLV_PROBE_PARAMETER);
+    assert_false(optional);
+    assert_int_equ=
al(value_len, OOB_PROBE_PARAMETER_LEN);
+
+    struct oob_probe_parameter o=
ut =3D { 0 };
+    assert_true(oob_probe_parameter_read(&buf, &out, value_l=
en));
+    assert_true(in=2Etimestamp =3D=3D out=2Etimestamp);
+    assert_=
int_equal(in=2Eflags, out=2Eflags);
+    assert_int_equal(BLEN(&buf), 0);
+=

+    gc_free(&gc);
+}
+
+/* Write a probe reply TLV and read it back=2E */=

+static void
+test_probe_reply_roundtrip(void **state)
+{
+    struct gc_a=
rena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
=
+    struct oob_probe_reply in =3D {
+        =2Epriority =3D 10,
+        =
=2Eweight =3D 100,
+        =2Econnect_lifetime =3D 30,
+        =2Eflags =
=3D 1,
+        =2Emax_latency_diff =3D 25,
+    };
+    memcpy(in=2Epeer_s=
ession_id=2Eid, "ABCDEFGH", SID_SIZE);
+
+    assert_true(oob_probe_reply_w=
rite(&buf, &in));
+    assert_int_equal(BLEN(&buf), 4 + OOB_PROBE_REPLY_LEN=
);
+
+    uint16_t type;
+    bool optional;
+    uint16_t value_len;
+    =
assert_true(oob_tlv_read_header(&buf, &type, &optional, &value_len));
+    =
assert_int_equal(type, OOB_TLV_PROBE_REPLY);
+    assert_int_equal(value_le=
n, OOB_PROBE_REPLY_LEN);
+
+    struct oob_probe_reply out =3D { 0 };
+    =
assert_true(oob_probe_reply_read(&buf, &out, value_len));
+    assert_memor=
y_equal(in=2Epeer_session_id=2Eid, out=2Epeer_session_id=2Eid, SID_SIZE);
+=
    assert_int_equal(in=2Epriority, out=2Epriority);
+    assert_int_equal(=
in=2Eweight, out=2Eweight);
+    assert_int_equal(in=2Econnect_lifetime, ou=
t=2Econnect_lifetime);
+    assert_int_equal(in=2Eflags, out=2Eflags);
+   =
 assert_int_equal(in=2Emax_latency_diff, out=2Emax_latency_diff);
+    asse=
rt_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* A TLV with a lon=
ger-than-known value must still parse: the known fields are
+ * read and th=
e trailing bytes are skipped (forward compatibility)=2E */
+static void
+te=
st_probe_parameter_forward_compat(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    con=
st uint16_t extended_len =3D OOB_PROBE_PARAMETER_LEN + 4;
+    assert_true(=
oob_tlv_write_header(&buf, OOB_TLV_PROBE_PARAMETER, false, extended_len));
=
+    assert_true(buf_write_u32(&buf, 0));          /* timestamp high */
+  =
  assert_true(buf_write_u32(&buf, 0xdeadbeef)); /* timestamp low */
+    as=
sert_true(buf_write_u32(&buf, 0));          /* flags */
+    assert_true(bu=
f_write_u32(&buf, 0x11223344)); /* unknown trailing field */
+
+    uint16_=
t type;
+    bool optional;
+    uint16_t value_len;
+    assert_true(oob_t=
lv_read_header(&buf, &type, &optional, &value_len));
+    assert_int_equal(=
value_len, extended_len);
+
+    struct oob_probe_parameter out =3D { 0 };
=
+    assert_true(oob_probe_parameter_read(&buf, &out, value_len));
+    ass=
ert_true(out=2Etimestamp =3D=3D 0xdeadbeefULL);
+    assert_int_equal(out=
=2Eflags, 0);
+    /* the unknown trailing field must have been consumed */=

+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* A decl=
ared value length shorter than the mandatory minimum must be rejected=2E */=

+static void
+test_probe_parameter_too_short(void **state)
+{
+    struct =
gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc)=
;
+
+    struct oob_probe_parameter out =3D { 0 };
+    assert_false(oob_pr=
obe_parameter_read(&buf, &out, OOB_PROBE_PARAMETER_LEN - 1));
+
+    gc_fre=
e(&gc);
+}
+
+/* Reading a header from a buffer that is too small must fail=
 rather than read
+ * past the end=2E */
+static void
+test_tlv_header_trun=
cated(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct bu=
ffer buf =3D alloc_buf_gc(128, &gc);
+
+    uint16_t type;
+    bool option=
al;
+    uint16_t value_len;
+
+    /* empty buffer */
+    assert_false(oo=
b_tlv_read_header(&buf, &type, &optional, &value_len));
+
+    /* only the =
type field present, no length */
+    assert_true(buf_write_u16(&buf, OOB_T=
LV_PROBE_PARAMETER));
+    assert_false(oob_tlv_read_header(&buf, &type, &o=
ptional, &value_len));
+
+    gc_free(&gc);
+}
+
+int
+main(void)
+{
+    o=
penvpn_unit_test_setup();
+    const struct CMUnitTest tests[] =3D {
+     =
   cmocka_unit_test(test_probe_parameter_roundtrip),
+        cmocka_unit_t=
est(test_probe_reply_roundtrip),
+        cmocka_unit_test(test_probe_param=
eter_forward_compat),
+        cmocka_unit_test(test_probe_parameter_too_sh=
ort),
+        cmocka_unit_test(test_tlv_header_truncated),
+    };
+
+    =
return cmocka_run_group_tests_name("oob tests", tests, NULL, NULL);
+}

-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c8d302ac57c5603d622a7=
be14be369437388268
Gerrit-Change-Number: 1741
Gerrit-PatchSet: 1
Gerrit-Own=
er: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--utvIiVMdw5o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oo=
b: Add control message TLV encoding (P_CONTROL_OOB_V1)<br><br>Reserve opcod=
e 12 (P_CONTROL_OOB_V1) for out-of-band control messages and<br>add encodin=
g/decoding for the SERVER_PROBE / PROBE_REPLY TLVs used for<br>server laten=
cy checks:<br><br>  - probe_parameter (0x200): client timestamp + capabilit=
y flags<br>  - probe_reply    (0x201): echoed session id, DNS-SRV style pri=
ority and<br>                            weight, connect_lifetime and behav=
iour flags<br><br>Each TLV has a 4-byte header (15-bit type plus an optiona=
l flag, then a<br>16-bit value length)=2E Readers enforce the minimum value=
 length and skip<br>trailing bytes they do not understand, so the format st=
ays forward<br>compatible and multi-TLV framing resynchronises=2E<br><br>P_=
LAST_OPCODE is deliberately left at 11: opcode 12 is not yet accepted by<br=
>tls_pre_decrypt()=2E The legal-opcode range is widened together with the<b=
r>receive handler in a follow-up, which also wires oob=2Ec into the openvpn=
<br>build=2E For now the codec is exercised only by the unit tests=2E<br><b=
r>See the OOB control message section of the OpenVPN wire protocol<br>speci=
fication (openvpn-rfc PR #30)=2E<br><br>Change-Id: I1c8d302ac57c5603d622a7b=
e14be369437388268<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<=
br>---<br>M CMakeLists=2Etxt<br>A src/openvpn/oob=2Ec<br>A src/openvpn/oob=
=2Eh<br>M src/openvpn/ssl_pkt=2Eh<br>M tests/unit_tests/openvpn/Makefile=2E=
am<br>A tests/unit_tests/openvpn/test_oob=2Ec<br>6 files changed, 524 inser=
tions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1741/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 8de836a=2E=2Ed2b8=
8c0 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMa=
keLists=2Etxt</span><br><span>@@ -665,6 +665,7 @@</span><br><span>         =
&quot;test_mbuf&quot;</span><br><span>         &quot;test_misc&quot;</span>=
<br><span>         &quot;test_ncp&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        &quot;test_oob&quot;</span><br><span>         &=
quot;test_options_parse&quot;</span><br><span>         &quot;test_packet_id=
&quot;</span><br><span>         &quot;test_pkt&quot;</span><br><span>@@ -85=
5,6 +856,12 @@</span><br><span>         src/openvpn/session_id=2Ec</span><b=
r><span>         )</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    target_sources(test_oob PRIVATE</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/mock_get=
_random=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
src/openvpn/oob=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        src/openvpn/session_id=2Ec</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        )</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span>     target_sources(test_pkt PRIVATE</span><br><span>=
         tests/unit_tests/openvpn/mock_win32_execve=2Ec</span><br><span>   =
      src/openvpn/argv=2Ec</span><br><span>diff --git a/src/openvpn/oob=2Ec=
 b/src/openvpn/oob=2Ec</span><br><span>new file mode 100644</span><br><span=
>index 0000000=2E=2E9f123e2</span><br><span>--- /dev/null</span><br><span>+=
++ b/src/openvpn/oob=2Ec</span><br><span>@@ -0,0 +1,154 @@</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP n=
etworks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   over a single TCP/UDP port, with support for SSL/TLS-based</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             session authentica=
tion and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *             packet encryption, packet authentication, and</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compressi=
on=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 Ope=
nVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  This program is free software; you can redistribute it and/or modify</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms=
 of the GNU General Public License version 2</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed i=
n the hope that it will be useful,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warra=
nty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTA=
BILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more =
details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have receiv=
ed a copy of the GNU General Public License along</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https:=
//www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;conf=
ig=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* Consume @p value_len bytes of TLV value, of which @p=
 consumed have already</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * been read, ignoring (skipping) any trailing bytes that this version d=
oes not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * understan=
d=2E Fails if fewer than @p consumed bytes were declared=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+oob_skip_trailing(struct buffer *buf, ui=
nt16_t value_len, int consumed)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (value_len &lt; consumed)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_adva=
nce(buf, value_len - consumed);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+oob_msg_write_header(struct buffer *buf,=
 uint16_t msg_type)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_wri=
te_u16(buf, msg_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+oob_msg_read_header(struct buffer *buf, uint16_t =
expected_msg_type)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int msg_type =
=3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return msg_type &gt;=3D 0 &amp;&amp; (uint16_t)msg_type =3D=3D expec=
ted_msg_type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+oob_tlv_write_header(struct buffer *buf, uint16_t type, =
bool optional, uint16_t value_len)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 uint16_t field =3D type &amp; OOB_TLV_TYPE_MASK;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (optional)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        field |=3D OOB_TLV_OPTIONAL_FLAG;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return buf_write_u16(buf, field) &amp;&amp; buf_w=
rite_u16(buf, value_len);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+oob_tlv_read_header(struct buffer *buf, uint16=
_t *type, bool *optional, uint16_t *value_len)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int field =3D buf_read_u16(buf);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (field &lt; 0)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int len =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (len &lt; 0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *type=
 =3D (uint16_t)(field &amp; OOB_TLV_TYPE_MASK);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    *optional =3D (field &amp; OOB_TLV_OPTIONAL=
_FLAG) !=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *=
value_len =3D (uint16_t)len;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+oob_probe_parameter_write(struct buffer *buf, =
const struct oob_probe_parameter *p)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return oob_tlv_write_header(buf, OOB_TLV_PROBE_PARAMETER, false, OOB_PRO=
BE_PARAMETER_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
         &amp;&amp; buf_write_u64(buf, p-&gt;timestamp)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u32(buf=
, p-&gt;flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+oob_probe_parameter_read(struct buffer *buf, struct oob_=
probe_parameter *p, uint16_t value_len)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (value_len &lt; OOB_PROBE_PARAMETER_LEN)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    bool ok =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    p-&gt;timestamp =3D buf_read_u64(buf, &amp;ok);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    p-&gt;flags =3D buf_read_u32(buf,=
 &amp;ok);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!=
ok)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return oob_skip_trailing(buf, value_l=
en, OOB_PROBE_PARAMETER_LEN);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+oob_probe_reply_write(struct buffer *buf,=
 const struct oob_probe_reply *r)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return oob_tlv_write_header(buf, OOB_TLV_PROBE_REPLY, false, OOB_PROBE_REPL=
Y_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &a=
mp;&amp; session_id_write(&amp;r-&gt;peer_session_id, buf)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16(=
buf, r-&gt;priority)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+           &amp;&amp; buf_write_u16(buf, r-&gt;weight)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16(buf=
, r-&gt;connect_lifetime)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+           &amp;&amp; buf_write_u32(buf, r-&gt;flags)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16=
(buf, r-&gt;max_latency_diff);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+oob_probe_reply_read(struct buffer *buf, =
struct oob_probe_reply *r, uint16_t value_len)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (value_len &lt; OOB_PROBE_REPLY_LEN)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (!session_id_read(&amp;r-&gt;peer_session_id, buf))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    int priority =3D buf_read_u16(buf);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int weight =3D buf_read_u16(b=
uf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int connect=
_lifetime =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (priority &lt; 0 || weight &lt; 0 || connect_lifetime &=
lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    bool ok =3D true;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    r-&gt;flags =3D buf_read_u32(buf,=
 &amp;ok);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int m=
ax_latency_diff =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (!ok || max_latency_diff &lt; 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    r-&gt;priority =3D (uint16_t)priority;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    r-&gt;weight =3D (uint16_t)weight;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;connect_li=
fetime =3D (uint16_t)connect_lifetime;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    r-&gt;max_latency_diff =3D (uint16_t)max_latency_dif=
f;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return oob_sk=
ip_trailing(buf, value_len, OOB_PROBE_REPLY_LEN);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/oo=
b=2Eh b/src/openvpn/oob=2Eh</span><br><span>new file mode 100644</span><br>=
<span>index 0000000=2E=2Ec32a7db</span><br><span>--- /dev/null</span><br><s=
pan>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -0,0 +1,147 @@</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel=
 IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
        over a single TCP/UDP port, with support for SSL/TLS-based</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *             session authe=
ntication and key exchange,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             packet encryption, packet authentication, and</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet comp=
ression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-202=
6 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  This program is free software; you can redistribute it and/or modi=
fy</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the =
terms of the GNU General Public License version 2</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundat=
ion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distribute=
d in the hope that it will be useful,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied wa=
rranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHA=
NTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for mo=
re details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have rec=
eived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;ht=
tps://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Encoding/decoding of out-of-band (P_CO=
NTROL_OOB_V1) control messages=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
An OOB message payload starts with a 16-bit message type (the 0x1xx space:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * SERVER_PROBE, PRO=
BE_REPLY, =2E=2E=2E) followed by a sequence of TLV entries=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * Each TLV starts with a 4-byte header: a 16-bit =
field whose most significant</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * bit is the &quot;optional&quot; flag and whose remaining 15 bit=
s are the type (the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * 0x2xx space), followed by a 16-bit length giving the size of the value t=
hat</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * follows the h=
eader=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * This slice implements the=
 SERVER_PROBE / PROBE_REPLY pair used for server</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * latency checks=2E Other message/TLV types a=
re added as the feature grows=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef OOB_H</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_H</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;session_id=2Eh&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* OOB message types: the 16-bit value at th=
e start of an OOB payload, before</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * its TLV entries=2E Distinct from the TLV-type space (0x2xx=
); see the &quot;Messages&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * table in the OOB section of the wire protocol spec=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_MSG_SERVER_=
PROBE 0x100</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
OOB_MSG_PROBE_REPLY  0x101</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* TLV heade=
r bit layout of the first 16-bit field */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define OOB_TLV_OPTIONAL_FLAG 0x8000</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define OOB_TLV_TYPE_MASK     0x7fff=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* TLV types (see the OOB control mess=
age section of the wire protocol spec) */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define OOB_TLV_PROBE_PARAMETER 0x200</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define OOB_TLV_PROBE_REPLY     0x2=
01</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* Minimum on-wire value length (exc=
luding the 4-byte TLV header) of each TLV=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * The value may be longer for forward compatibili=
ty; trailing bytes that are</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * not understood are ignored on read=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define OOB_PROBE_PARAMETER_LEN 12</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_PROBE_REPLY_LE=
N     20</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* probe parameter TLV (sent b=
y the client in a SERVER_PROBE) */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+struct oob_probe_parameter</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    uint64_t timestamp; /**&lt; client clock as a UNIX timestamp */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t flags;    =
 /**&lt; client capability flags, currently must be 0 */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* probe reply TLV (sent by the server in a PROBE_REPLY) */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+struct oob_probe_reply</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct session_id peer_session_id; /**&lt; ec=
hoes the session id of the request */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    uint16_t priority;                 /**&lt; DNS-SRV st=
yle priority (lower is preferred) */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    uint16_t weight;                   /**&lt; DNS-SRV sty=
le weight */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uin=
t16_t connect_lifetime;         /**&lt; seconds the probe stays valid as a =
handshake shortcut */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    uint32_t flags;                    /**&lt; server behaviour flags */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t max_lat=
ency_diff;         /**&lt; advertised candidate-band margin in ms;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
            *   0 means &quot;defer to the client&#39;s setting&quot; */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Write an OOB message-type header (the 16-bit message type preceding the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * TLVs) to @p buf=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false=
 if @p buf has insufficient space=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+bool oob_msg_write_header(struct buffer *buf, uint16_t msg_type);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Read and verify an OOB message-type header from @p buf, adva=
ncing past it=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param expected_m=
sg_type  the message type the payload must carry</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @return true if a message type was read and=
 equals @p expected_msg_type,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *         false on a short buffer or a mismatching type=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool oob_msg_read_header(struct buffer *b=
uf, uint16_t expected_msg_type);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a TLV header =
(type + optional flag + value length) to @p buf=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @return true on success, false if @p buf has insufficient =
space=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_tlv_write_header(s=
truct buffer *buf, uint16_t type, bool optional, uint16_t value_len);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * Read a TLV header from @p buf, advancing past it=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param type       set to the 15-bit TL=
V type</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param opt=
ional   set to the value of the optional flag</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param value_len  set to the declared value le=
ngth</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true=
 on success, false if there are not enough bytes for a header=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+bool oob_tlv_read_header(struct buffer *buf, u=
int16_t *type, bool *optional, uint16_t *value_len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Write a complete probe parameter TLV (header + value) to @p buf=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool oob_probe_parameter_write(struct buf=
fer *buf, const struct oob_probe_parameter *p);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read=
 a probe parameter TLV value of @p value_len bytes from @p buf=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * The TLV header must already have been consu=
med (e=2Eg=2E via</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 oob_tlv_read_header())=2E @p value_len bytes are always consumed on succes=
s,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * including any =
trailing bytes beyond the fields understood here=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return true on success, false if @p value_len is too s=
hort or @p buf is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
         truncated=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_probe=
_parameter_read(struct buffer *buf, struct oob_probe_parameter *p,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
  uint16_t value_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Write a complete probe reply =
TLV (header + value) to @p buf=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bo=
ol oob_probe_reply_write(struct buffer *buf, const struct oob_probe_reply *=
r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Read a probe reply TLV value of @p value_len byt=
es from @p buf=2E See</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * oob_probe_parameter_read() for the calling convention=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+bool oob_probe_reply_read(struct buffer *buf, str=
uct oob_probe_reply *r, uint16_t value_len);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif /* OOB_H */</span><br><span>diff --git a/src/openvpn/ssl_pkt=
=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index ac9d4be=2E=2E0dab524 1=
00644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/s=
rc/openvpn/ssl_pkt=2Eh</span><br><span>@@ -58,6 +58,17 @@</span><br><span> =
 * like P_CONTROL_HARD_RESET_CLIENT_V3 */</span><br><span> #define P_CONTRO=
L_WKC_V1 11</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* Out-of-band control message that does not belong to an establi=
shed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * control chan=
nel session (e=2Eg=2E a server probe)=2E Inherently unreliable:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * there is no protocol-level r=
etransmission=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * NOTE: intentional=
ly not yet included in the P_FIRST_OPCODE=2E=2EP_LAST_OPCODE</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * legal range=2E The range acts a=
s an acceptance gate in tls_pre_decrypt();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * widening it before an OOB receive handler exists =
would let OOB packets</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * be misparsed as established-session control packets=2E Bump P_LAST_OPC=
ODE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to 12 in the =
same change that adds the handler=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define P_CONTROL_OOB_V1 12</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> /* define the range of legal =
opcodes</span><br><span>  * Since we do no longer support key-method 1 we c=
onsider</span><br><span>  * the v1 op codes invalid */</span><br><span>@@ -=
266,6 +277,9 @@</span><br><span>         case P_CONTROL_WKC_V1:</span><br><=
span>             return &quot;P_CONTROL_WKC_V1&quot;;</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        case P_CONTROL=
_OOB_V1:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 return &quot;P_CONTROL_OOB_V1&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span>         case P_ACK_V1:</span><br><span>=
             return &quot;P_ACK_V1&quot;;</span><br><span> </span><br><span=
>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/ope=
nvpn/Makefile=2Eam</span><br><span>index 1128eb4=2E=2E7174aa8 100644</span>=
<br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ =
b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -14,6 +14,7 @@<=
/span><br><span> 	ncp_testdriver \</span><br><span> 	mbuf_testdriver \</spa=
n><br><span> 	misc_testdriver \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	oob_testdriver \</span><br><span> 	options_parse_testdriver \<=
/span><br><span> 	packet_id_testdriver \</span><br><span> 	pkt_testdriver \=
</span><br><span>@@ -149,6 +150,19 @@</span><br><span> 	$(top_srcdir)/src/o=
penvpn/win32-util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/session=
_id=2Ec</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+oob_testdriver_CFLAGS  =3D \</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_=
srcdir)/src/openvpn \</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	@TEST_CFLAGS@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob=
_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+oob_testdriver_SOURCES =3D test_oob=2Ec \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	mock_msg=2Ec mock_msg=2Eh test_co=
mmon=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_get=
_random=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top=
_srcdir)/src/openvpn/buffer=2Ec \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	$(top_srcdir)/src/openvpn/oob=2Ec \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/platform=2Ec \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/ope=
nvpn/session_id=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	$(top_srcdir)/src/openvpn/win32-util=2Ec</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> pkt_testdriver_CFLAGS  =3D \</spa=
n><br><span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_sr=
cdir)/src/openvpn \</span><br><span> 	@TEST_CFLAGS@</span><br><span>diff --=
git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test=
_oob=2Ec</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2E40dcaf9</span><br><span>--- /dev/null</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_oob=2Ec</span><br><span>@@ -0,0 +1,188 @@</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel =
IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      =
       over a single TCP/UDP port, with support for SSL/TLS-based</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *             session authen=
tication and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *             packet encryption, packet authentication, and</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compr=
ession=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026=
 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  This program is free software; you can redistribute it and/or modif=
y</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the t=
erms of the GNU General Public License version 2</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundati=
on=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed=
 in the hope that it will be useful,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied war=
ranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHAN=
TABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for mor=
e details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have rece=
ived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;ht=
tps://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONF=
IG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdarg=2Eh&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stddef=2Eh&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmoc=
ka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test=
_common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Write a probe para=
meter TLV and read it back; fields must survive the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * round trip and the whole buffer must b=
e consumed=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_=
parameter_roundtrip(void **state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const struct oob_probe_parameter in =3D {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Etimestamp =
=3D 0x0123456789abcdefULL,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        =2Eflags =3D 0,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(oob_probe_parameter_write(&amp;buf, &amp;in));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* header (4) + value (12) */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(BLEN(&amp;buf), 4 + OOB_PROBE_PARAMETER_LEN);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    uint16_t type;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    bool optional;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    uint16_t value_len;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(oob_tlv_read_header(&amp;buf, &amp;type, &amp;opt=
ional, &amp;value_len));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(type, OOB_TLV_PROBE_PARAMETER);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_false(optional);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(value_le=
n, OOB_PROBE_PARAMETER_LEN);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 oob_probe_parameter out =3D { 0 };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(oob_probe_parameter_read(&amp;buf, &amp;out=
, value_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(in=2Etimestamp =3D=3D out=2Etimestamp);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Eflags, out=2Eflags=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* Write a probe reply TLV and read it back=2E */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_roundtrip(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct oob_probe_reply in =3D {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        =2Epriority =3D 10,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        =2Eweight =3D 100,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        =2Econnect_lifetime =3D 30=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =
=3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Ema=
x_latency_diff =3D 25,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy=
(in=2Epeer_session_id=2Eid, &quot;ABCDEFGH&quot;, SID_SIZE);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(oob_probe_reply_write(&amp;buf, &amp;=
in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(BLEN(&amp;buf), 4 + OOB_PROBE_REPLY_LEN);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    uint16_t type;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    bool optional;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    uint16_t value_len;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(oob_tlv_read_header(&amp;buf, &amp;type, &amp;o=
ptional, &amp;value_len));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(type, OOB_TLV_PROBE_REPLY);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(value_len, OOB_PRO=
BE_REPLY_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_rep=
ly out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(oob_probe_reply_read(&amp;buf, &amp;out, value_len));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(in=
=2Epeer_session_id=2Eid, out=2Epeer_session_id=2Eid, SID_SIZE);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Eprior=
ity, out=2Epriority);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(in=2Eweight, out=2Eweight);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Econnect_lifetime, =
out=2Econnect_lifetime);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(in=2Eflags, out=2Eflags);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Emax_latency_dif=
f, out=2Emax_latency_diff);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A TLV with a longer-th=
an-known value must still parse: the known fields are</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * read and the trailing bytes are skippe=
d (forward compatibility)=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+test_probe_parameter_forward_compat(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(12=
8, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint16_t extende=
d_len =3D OOB_PROBE_PARAMETER_LEN + 4;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(oob_tlv_write_header(&amp;buf, OOB_TLV_P=
ROBE_PARAMETER, false, extended_len));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0));          /*=
 timestamp high */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(buf_write_u32(&amp;buf, 0xdeadbeef)); /* timestamp low */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_wr=
ite_u32(&amp;buf, 0));          /* flags */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0x11223344)=
); /* unknown trailing field */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uin=
t16_t type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool=
 optional;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint1=
6_t value_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(oob_tlv_read_header(&amp;buf, &amp;type, &amp;optional, &amp;val=
ue_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(value_len, extended_len);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct oob_probe_parameter out =3D { 0 };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(oob_probe_parameter_read(&amp;buf, =
&amp;out, value_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(out=2Etimestamp =3D=3D 0xdeadbeefULL);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Eflags, 0);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the unknown =
trailing field must have been consumed */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A declar=
ed value length shorter than the mandatory minimum must be rejected=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_parameter_too_shor=
t(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc=
 =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct oob_probe_parameter out =3D { 0 };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_probe_parameter_re=
ad(&amp;buf, &amp;out, OOB_PROBE_PARAMETER_LEN - 1));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Reading a header =
from a buffer that is too small must fail rather than read</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * past the end=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_tlv_header_truncated(void **state)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uin=
t16_t type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool=
 optional;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint1=
6_t value_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* empty buffer */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_=
tlv_read_header(&amp;buf, &amp;type, &amp;optional, &amp;value_len));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* only the type field present, no lengt=
h */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(buf_write_u16(&amp;buf, OOB_TLV_PROBE_PARAMETER));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_tlv_read_header(&amp=
;buf, &amp;type, &amp;optional, &amp;value_len));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+main(void)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    openvpn_unit_test_setup();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const struct CMUnitTest tests[] =3D {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_prob=
e_parameter_roundtrip),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmocka_unit_test(test_probe_reply_roundtrip),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_p=
arameter_forward_compat),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        cmocka_unit_test(test_probe_parameter_too_short),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_t=
lv_header_truncated),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return cmocka_run_group_te=
sts_name(&quot;oob tests&quot;, tests, NULL, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=
=3Demail">change 1741</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1741?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1741 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--utvIiVMdw5o=--


--===============2229974522724920197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2229974522724920197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2229974522724920197==--

