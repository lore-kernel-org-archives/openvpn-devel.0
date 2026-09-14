Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2E3C88E79
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z+QrPzqU6Ehq615vj47iY9b9ras2sulap0W2TGAC9ZU=; b=D+BXphkCG2leU3t5FikDG53BSW
	ClFuh+fMH14H5lmdBfFB1Kb0r6u0s/UKvRttiUwvdZXzwaK2cPqp7ElcmmzAOemHxf4kZIGcNLTAr
	VfU3u1JF4YvwleyWaWBPBPABnfUnZ5IorUF7MwHCU2+FwfLEX66oUKVxDYD81O73Gddw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x67WL-0000Jf-Tm;
	Mon, 14 Sep 2026 14:18:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x67WJ-0000JX-Rx
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:18:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=diBfHuFQBLsibXJ7LJctPfymOtgSojXTjc62exihQzY=; b=K3Xe0A2OJy0vz8Y7ALWFG/bY64
 odgwYIj/1Pfz9wy17WTi3Pl8f3HucBvwTBuq+cVJ478XgejqiO/yo5Iy4sNer1g+deXbyIRsLBoN+
 /tTNAJQVHMCURQ6Xo5MOOqFtlGNCkg88qgTNgi0hxnlRAHA94bgh/BATBGgMRLdnKt28=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=diBfHuFQBLsibXJ7LJctPfymOtgSojXTjc62exihQzY=; b=i
 LmsRCBBPLCEOu9lRI5kq7XWVvHUuU4Alfi+4+hy7lETZjWxjzk/24sccSGSrU7YrMf88fROhotFqa
 9LZs4DGe2z884Nj5mzfdI6PlPMN+xUQRdt5tv02Eh2hI7BChMCwh1pBO94V0Ck9fUwADCrPzXw8G3
 7ti9hIrJBChtv6ls=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x67WB-0001Rm-Vg for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:18:56 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485984ebf5cso1665259f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 07:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789395521; x=1790000321; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=diBfHuFQBLsibXJ7LJctPfymOtgSojXTjc62exihQzY=;
 b=S5Nif2vpei6TRFGjKAztFflJhmxkvmJQU9ZhJK3/igay1qPjgwzQ1vcH15wTE2XPTW
 WQh3+F/EywUQ8bK2lNSdAezgZNenRjPItpYe98RyYWVBzALeBU1GYYJWkpxJEJudDNxN
 AH6VWB6k22AQQGcBQLkVQSavLOuyFXhgNBZwYy1jWOHQEpUEfDpztBEYOrYW5Aa+zkaB
 Ry2S4i7IlMMPZy7y5samfvssTkwWy03x2N2aAOJzHO44ceFpUl+lN8/UtWQpCI/GHTYg
 HY3ZASTHcJ74k49P4lLAqQVv9auxx3/RsyX+D6S6+0JQaCK/iSNH5r3drNTqhSh081Nt
 QfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395521; x=1790000321;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=diBfHuFQBLsibXJ7LJctPfymOtgSojXTjc62exihQzY=;
 b=SM6PiI4ED4NIt2K3qLkk25ooLp1TflXAOtIb5F+YTzFLhl0aHbpptcbxlPlIrqigr+
 IAkflfi9az03dzmVVGtmPHoSPZSuTvOdUH+EtDRCzFMNLGqaTs+tJSVcuQkKxxrzne8z
 Bjr6lAvgkKED/CRgYM91fng6k+2ogXVuxdKeLbWZrJQ6sDSOuSkB7aIRnqV9py+v/Vfu
 ZXVHFvb3XVnycWgKJOU+QVuD7oQJMaI245JhZMwq2SzO9K3WH6FS+ELlWE43yJCvYYh7
 aEiZFjMGfTnBk2BxxLZJ1UIUIMdg1tO4Ig4KH/wZI9zgOly/GBvChAjfos2oLkz8HZL+
 3MgQ==
X-Gm-Message-State: AFuF++lS4A1sOV4xF6p/NcEACEgi/OyjrGDeNQkxJtDUVLS04EeF4Pku
 VJUUQmCua189y/zQ/mUVgVNnN1isBtamLzTZwuotW+DwGwMytsfutQuGMOtgCQaInMJVsbdhJrT
 SbkIlQLrdKWsFToB4Fh2skPW3Ef5MuOLO8JgmHS5l7yRNAX468XmegnMHmNFQJW+pqwtRE5E44W
 5BFvjJ6Q==
X-Gm-Gg: AYBFou2TxZYy/DOKRR7ySbY6TeJ1w5p6Ok1gytOPFwjmSLR42OIkzJsEU6qScrwSVLg
 pAHRnu4/xyhyUdIKao9CWaXh0LRhYggIsM4tb59KfQz35eDQkSmjZQjkSfcBe/ABUje7wbNrvgG
 u8Nssfqx1nKaZ5fl6RgtHcauA63lZZmTMlcJjpWTsBQpglaQqXDiBE2HMQaWPLRma4HSgEi6h0e
 IPbhOP9anZFfLa2nNOcwvhLo/Nw7bohJpjjvQLPmOnByI46NiGUz0oI0hg5d3bc/kTzs7Fm8+fN
 nQs1PBsgU20tad34G2ynOmnF3IrrLhCnxVL40TbN7Z67asA6xFJnBokp3haGkaZHdtSfHsZ2FdN
 YXOjDzGH+9e/608iTSAAa0Hz0aaFqa5s7JfmCoAo3oP1dd+nK57rz+/GzOoVRcfVGAYeErPp4Bo
 M1DoU684QnwDZgMM39TZO3w8/e45r/c5wWtND52l07VikGlkdDHRLmt7/tVeIr1QsFSQB45NJ1B
 GtxqGI5NBQGTBNgNLd7/Mzm2+BdOl50jqlHiJgKCDtaSKKx0MHoSC+l4EBEAkZk3P289GlatALX
 osdzqRKDIweZf/RL09tq0bF5XVUzHaizhPJjWFe9HMWZHfX4eOR6NNXBPsSinFc=
X-Received: by 2002:a5d:6f10:0:b0:482:e1ce:d45c with SMTP id
 ffacd0b85a97d-48702ab7919mr3452541f8f.21.1789395520637; 
 Mon, 14 Sep 2026 07:18:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e7f5sm27040832f8f.9.2026.09.14.07.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:18:39 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 14:18:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>,
 ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 3f8217314124701400cb9ce525071943a373e780
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8987f67a6d23b46c7bb63974bb39c1b789b2d541-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x67WB-0001Rm-Vg
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3517042527803130535=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3517042527803130535==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MRafbvPIOyQ="; charset=UTF-8

--MRafbvPIOyQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici, s=
tipa=2E

Hello flichtenheld, plaisthos, ralf_lici, 

I'd like you to reexam=
ine a change=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1741?usp=3Demail

to look at the new patch set (#15)=2E


Change subject: =
oob: Add control message TLV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add control message TLV en=
coding (P_CONTROL_OOB_V1)

Out-of-band control messages carry control data but belong to no
session, so a client can ask a server about itself before connecting=2E
Reserve opcode 12 for them and add the codec for the two messages the
probe needs, SERVER_PROBE and PROBE_REPLY=2E

The spec uses the same TLV framing for all its control messages, not
just the out-of-band ones, so the message-type header, the TLV header
and the TLV scan go into their own control_msg=2Ec/h; oob=2Ec keeps the OO=
B
message and TLV types=2E

The scan is strict: a header or value that does not fit in the remaining
payload, including trailing bytes too few for a header, or an unknown
TLV not marked optional rejects the whole message rather than just the
TLV=2E

P_LAST_OPCODE becomes 12, and opcode_valid_in_session() replaces the
plain range check because OOB opcodes are answered statelessly and are
never legal on an established session=2E

See the OOB control message section of the wire protocol specification
(openvpn-rfc PR #30)=2E

Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M CMakeLists=2Etxt
M s=
rc/openvpn/Makefile=2Eam
A src/openvpn/control_msg=2Ec
A src/openvpn/contro=
l_msg=2Eh
A src/openvpn/oob=2Ec
A src/openvpn/oob=2Eh
M src/openvpn/ssl=2Ec=

M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M tests/unit_tests/ope=
nvpn/Makefile=2Eam
A tests/unit_tests/openvpn/test_oob=2Ec
11 files changed=
, 824 insertions(+), 4 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/41/1741/15

diff --git a/CMakeLists=2Etxt b/C=
MakeLists=2Etxt
index 6eb5954=2E=2Efbc69f0 100644
--- a/CMakeLists=2Etxt
++=
+ b/CMakeLists=2Etxt
@@ -445,6 +445,8 @@
     src/openvpn/console=2Ec
     =
src/openvpn/console_builtin=2Ec
     src/openvpn/console=2Eh
+    src/openv=
pn/control_msg=2Ec
+    src/openvpn/control_msg=2Eh
     src/openvpn/crypto=
=2Ec
     src/openvpn/crypto=2Eh
     src/openvpn/crypto_backend=2Eh
@@ -52=
3,6 +525,8 @@
     src/openvpn/multi_io=2Ec
     src/openvpn/occ=2Ec
     s=
rc/openvpn/occ=2Eh
+    src/openvpn/oob=2Ec
+    src/openvpn/oob=2Eh
     s=
rc/openvpn/openvpn=2Ec
     src/openvpn/openvpn=2Eh
     src/openvpn/openvp=
n_win32_resources=2Erc
@@ -677,6 +681,7 @@
         "test_mbuf"
         "t=
est_misc"
         "test_ncp"
+        "test_oob"
         "test_options_pa=
rse"
         "test_packet_id"
         "test_pkt"
@@ -881,6 +886,13 @@
   =
      src/openvpn/session_id=2Ec
         )
 
+    target_sources(test_oob =
PRIVATE
+        tests/unit_tests/openvpn/mock_get_random=2Ec
+        src/=
openvpn/control_msg=2Ec
+        src/openvpn/oob=2Ec
+        src/openvpn/s=
ession_id=2Ec
+        )
+
     target_sources(test_pkt PRIVATE
         te=
sts/unit_tests/openvpn/mock_win32_execve=2Ec
         src/openvpn/argv=2Ec
=
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 7f=
d12b4=2E=2E5e6b4d9 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn=
/Makefile=2Eam
@@ -53,6 +53,7 @@
 	common=2Eh \
 	comp=2Ec comp=2Eh compstu=
b=2Ec \
 	comp-lz4=2Ec comp-lz4=2Eh \
+	control_msg=2Ec control_msg=2Eh \
 =
	crypto=2Ec crypto=2Eh crypto_backend=2Eh \
 	crypto_openssl=2Ec crypto_ope=
nssl=2Eh \
 	crypto_mbedtls_legacy=2Ec crypto_mbedtls_legacy=2Eh \
@@ -107,=
6 +108,7 @@
 	pkcs11=2Ec pkcs11=2Eh pkcs11_backend=2Eh \
 	pkcs11_openssl=
=2Ec \
 	pkcs11_mbedtls=2Ec \
+	oob=2Ec oob=2Eh \
 	openvpn=2Ec openvpn=2Eh=
 \
 	options=2Ec options=2Eh \
 	options_show=2Ec options_show=2Eh \
diff -=
-git a/src/openvpn/control_msg=2Ec b/src/openvpn/control_msg=2Ec
new file m=
ode 100644
index 0000000=2E=2E8d78639
--- /dev/null
+++ b/src/openvpn/contr=
ol_msg=2Ec
@@ -0,0 +1,107 @@
+/*
+ *  OpenVPN -- An application to securely=
 tunnel IP networks
+ *             over a single TCP/UDP port, with suppor=
t for SSL/TLS-based
+ *             session authentication and key exchange=
,
+ *             packet encryption, packet authentication, and
+ *        =
     packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sa=
les@openvpn=2Enet>
+ *
+ *  This program is free software; you can redistri=
bute it and/or modify
+ *  it under the terms of the GNU General Public Lic=
ense version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *=
  This program is distributed in the hope that it will be useful,
+ *  but =
WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABI=
LITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Publi=
c License for more details=2E
+ *
+ *  You should have received a copy of t=
he GNU General Public License along
+ *  with this program; if not, see <ht=
tps://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include =
"config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "control_msg=2Eh=
"
+
+bool
+ctrl_msg_read_header(struct buffer *buf, uint16_t expected_msg_t=
ype)
+{
+    int msg_type =3D buf_read_u16(buf);
+    return msg_type >=3D =
0 && (uint16_t)msg_type =3D=3D expected_msg_type;
+}
+
+bool
+ctrl_msg_tlv_=
write_header(struct buffer *buf, uint16_t type, bool optional, uint16_t val=
ue_len)
+{
+    uint16_t field =3D type & CTRL_MSG_TLV_TYPE_MASK;
+    if (=
optional)
+    {
+        field |=3D CTRL_MSG_TLV_OPTIONAL_FLAG;
+    }
+  =
  return buf_write_u16(buf, field) && buf_write_u16(buf, value_len);
+}
+
+=
bool
+ctrl_msg_tlv_read_header(struct buffer *buf, struct ctrl_msg_tlv_head=
er *hdr)
+{
+    int field =3D buf_read_u16(buf);
+    if (field < 0)
+    =
{
+        return false;
+    }
+    int len =3D buf_read_u16(buf);
+    if=
 (len < 0)
+    {
+        return false;
+    }
+    hdr->type =3D (uint16_=
t)(field & CTRL_MSG_TLV_TYPE_MASK);
+    hdr->optional =3D (field & CTRL_MS=
G_TLV_OPTIONAL_FLAG) !=3D 0;
+    hdr->value_len =3D (uint16_t)len;
+    re=
turn true;
+}
+
+bool
+ctrl_msg_find_tlv(struct buffer *payload, uint16_t w=
anted_type, struct buffer *value)
+{
+    struct ctrl_msg_tlv_header hdr;
+=
    bool found =3D false;
+    while (BLEN(payload) > 0)
+    {
+        if=
 (!ctrl_msg_tlv_read_header(payload, &hdr))
+        {
+            /* byte=
s remain but too few for a header: truncated */
+            return false;
=
+        }
+        /* Take the value out of payload=2E This validates that=
 the header's
+         * length is really there and advances past it in on=
e step, so the TLV
+         * we are looking for and the ones we skip are =
bounds-checked alike=2E */
+        uint8_t *v =3D buf_read_alloc(payload, =
hdr=2Evalue_len);
+        if (!v)
+        {
+            return false;
+ =
       }
+        if (hdr=2Etype =3D=3D wanted_type)
+        {
+          =
  if (!found)
+            {
+                buf_set_read(value, v, hdr=2E=
value_len);
+                found =3D true;
+            }
+        }
+   =
     else if (!hdr=2Eoptional)
+        {
+            /* A TLV we do not u=
nderstand that the sender did not mark optional
+             * carries som=
ething it requires us to act on, so the message as a
+             * whole =
is not ours to interpret=2E This is why the scan continues
+             * =
past the wanted type: such a TLV invalidates the message wherever
+        =
     * in the sequence it sits=2E */
+            return false;
+        }
=
+    }
+    return found;
+}
diff --git a/src/openvpn/control_msg=2Eh b/src=
/openvpn/control_msg=2Eh
new file mode 100644
index 0000000=2E=2Eb98dce5
--=
- /dev/null
+++ b/src/openvpn/control_msg=2Eh
@@ -0,0 +1,106 @@
+/*
+ *  Op=
enVPN -- An application to securely tunnel IP networks
+ *             over=
 a single TCP/UDP port, with support for SSL/TLS-based
+ *             sess=
ion authentication and key exchange,
+ *             packet encryption, pac=
ket authentication, and
+ *             packet compression=2E
+ *
+ *  Copy=
right (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program=
 is free software; you can redistribute it and/or modify
+ *  it under the =
terms of the GNU General Public License version 2
+ *  as published by the =
Free Software Foundation=2E
+ *
+ *  This program is distributed in the hop=
e that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the i=
mplied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ *  Y=
ou should have received a copy of the GNU General Public License along
+ * =
 with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */=

+
+/**
+ * @file
+ * Framing shared by the TLV-based control messages of t=
he wire protocol=2E
+ *
+ * Such a message payload starts with a 16-bit mes=
sage type, followed by a
+ * sequence of TLV entries=2E Each TLV starts wit=
h a 4-byte header: a 16-bit field
+ * whose most significant bit is the "op=
tional" flag and whose remaining 15 bits
+ * are the type, followed by a 16=
-bit length giving the size of the value that
+ * follows the header=2E
+ *=

+ * The message-type and TLV-type values themselves are specific to the me=
ssage
+ * family carried (out-of-band messages define theirs in oob=2Eh), s=
o only the
+ * framing lives here=2E
+ */
+
+#ifndef CONTROL_MSG_H
+#define=
 CONTROL_MSG_H
+
+#include "buffer=2Eh"
+
+/* TLV header bit layout of the =
first 16-bit field */
+#define CTRL_MSG_TLV_OPTIONAL_FLAG 0x8000
+#define C=
TRL_MSG_TLV_TYPE_MASK     0x7fff
+
+/* The header every TLV carries: the 15=
-bit type and optional flag packed into
+ * the first 16-bit field, then th=
e length of the value that follows=2E */
+struct ctrl_msg_tlv_header
+{
+  =
  uint16_t type;      /**< the 15-bit TLV type */
+    bool optional;      =
/**< value of the optional flag */
+    uint16_t value_len; /**< length of =
the value following the header */
+};
+
+/**
+ * Read and verify a message-=
type header from buf, advancing past it=2E
+ *
+ * @param buf              =
  buffer positioned at the message payload
+ * @param expected_msg_type  th=
e message type the payload must carry
+ * @return true if a message type wa=
s read and equals expected_msg_type,
+ *         false on a short buffer or=
 a mismatching type=2E
+ */
+bool ctrl_msg_read_header(struct buffer *buf, =
uint16_t expected_msg_type);
+
+/**
+ * Write a TLV header (type + optional=
 flag + value length) to buf=2E
+ *
+ * @return true on success, false if b=
uf has insufficient space=2E
+ */
+bool ctrl_msg_tlv_write_header(struct bu=
ffer *buf, uint16_t type, bool optional,
+                               ui=
nt16_t value_len);
+
+/**
+ * Read a TLV header from buf, advancing past it=
=2E
+ *
+ * @param buf  buffer positioned at the TLV header
+ * @param hdr =
 filled with the type, optional flag and value length on success
+ * @retur=
n true on success, false if there are not enough bytes for a header=2E
+ */=

+bool ctrl_msg_tlv_read_header(struct buffer *buf, struct ctrl_msg_tlv_hea=
der *hdr);
+
+/**
+ * Scan payload for the first TLV of type wanted_type, s=
kipping any other (e=2Eg=2E
+ * future) TLV type that is marked optional=2E=

+ *
+ * The whole sequence is walked, including the part after the wanted =
type: a TLV
+ * we do not understand and that is not marked optional invali=
dates the message
+ * wherever it sits, and rejecting it is the point of th=
e remaining scan=2E
+ *
+ * On success value covers exactly the found TLV's=
 value bytes=2E The length from
+ * each TLV header is validated against pa=
yload as the scan goes, so the whole
+ * value is guaranteed to be present;=
 a header claiming more bytes than payload
+ * holds is rejected rather tha=
n reported as found=2E payload is consumed as it is
+ * read=2E
+ *
+ * @pa=
ram payload      buffer positioned at a TLV header
+ * @param wanted_type  =
the TLV type to look for
+ * @param value        set to a buffer covering t=
he found TLV's value
+ * @return true if the TLV was found, false if it is =
not present, a TLV header
+ *         or value is malformed or truncated, o=
r a TLV we do not understand is
+ *         not marked optional=2E
+ */
+bo=
ol ctrl_msg_find_tlv(struct buffer *payload, uint16_t wanted_type, struct b=
uffer *value);
+
+#endif /* ifndef CONTROL_MSG_H */
diff --git a/src/openvp=
n/oob=2Ec b/src/openvpn/oob=2Ec
new file mode 100644
index 0000000=2E=2Ec80=
7171
--- /dev/null
+++ b/src/openvpn/oob=2Ec
@@ -0,0 +1,83 @@
+/*
+ *  Open=
VPN -- An application to securely tunnel IP networks
+ *             over a=
 single TCP/UDP port, with support for SSL/TLS-based
+ *             sessio=
n authentication and key exchange,
+ *             packet encryption, packe=
t authentication, and
+ *             packet compression=2E
+ *
+ *  Copyri=
ght (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program i=
s free software; you can redistribute it and/or modify
+ *  it under the te=
rms of the GNU General Public License version 2
+ *  as published by the Fr=
ee Software Foundation=2E
+ *
+ *  This program is distributed in the hope =
that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the imp=
lied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ *  Y=
ou should have received a copy of the GNU General Public License along
+ * =
 with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */=

+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshea=
d=2Eh"
+
+#include "oob=2Eh"
+#include "control_msg=2Eh"
+
+bool
+oob_probe=
_parameter_write(struct buffer *buf, const struct oob_probe_parameter *p)
+=
{
+    return ctrl_msg_tlv_write_header(buf, OOB_TLV_PROBE_PARAMETER, false=
, OOB_PROBE_PARAMETER_LEN)
+           && buf_write_u64(buf, p->timestamp)
=
+           && buf_write_u32(buf, p->flags);
+}
+
+bool
+oob_probe_paramete=
r_read(struct buffer *buf, struct oob_probe_parameter *p)
+{
+    /* One bo=
unds check covers the whole value: every field read below then fits
+     *=
 by construction (OOB_PROBE_PARAMETER_LEN is the sum of their sizes), so
+ =
    * none of them needs its own error handling=2E Trailing bytes this vers=
ion
+     * does not understand are simply left unread=2E */
+    if (buf_l=
en(buf) < OOB_PROBE_PARAMETER_LEN)
+    {
+        return false;
+    }
+  =
  p->timestamp =3D buf_read_u64(buf, NULL);
+    p->flags =3D buf_read_u32(=
buf, NULL);
+    return true;
+}
+
+bool
+oob_probe_reply_write(struct buff=
er *buf, const struct oob_probe_reply *r)
+{
+    return ctrl_msg_tlv_write=
_header(buf, OOB_TLV_PROBE_REPLY, false, OOB_PROBE_REPLY_LEN)
+           &=
& session_id_write(&r->peer_session_id, buf)
+           && buf_write_u16(b=
uf, r->priority)
+           && buf_write_u16(buf, r->weight)
+           &=
& buf_write_u16(buf, r->max_latency_diff)
+           && buf_write_u16(buf,=
 r->connect_lifetime)
+           && buf_write_u32(buf, r->flags);
+}
+
+bo=
ol
+oob_probe_reply_read(struct buffer *buf, struct oob_probe_reply *r)
+{
=
+    /* One bounds check for the whole value, as in oob_probe_parameter_rea=
d()=2E */
+    if (buf_len(buf) < OOB_PROBE_REPLY_LEN)
+    {
+        retu=
rn false;
+    }
+    session_id_read(&r->peer_session_id, buf);
+    r->pr=
iority =3D (uint16_t)buf_read_u16(buf);
+    r->weight =3D (uint16_t)buf_re=
ad_u16(buf);
+    r->max_latency_diff =3D (uint16_t)buf_read_u16(buf);
+   =
 r->connect_lifetime =3D (uint16_t)buf_read_u16(buf);
+    r->flags =3D buf=
_read_u32(buf, NULL);
+    return true;
+}
diff --git a/src/openvpn/oob=2Eh=
 b/src/openvpn/oob=2Eh
new file mode 100644
index 0000000=2E=2Ec5396b3
--- =
/dev/null
+++ b/src/openvpn/oob=2Eh
@@ -0,0 +1,110 @@
+/*
+ *  OpenVPN -- A=
n application to securely tunnel IP networks
+ *             over a single =
TCP/UDP port, with support for SSL/TLS-based
+ *             session authen=
tication and key exchange,
+ *             packet encryption, packet authen=
tication, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) =
2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free s=
oftware; you can redistribute it and/or modify
+ *  it under the terms of t=
he GNU General Public License version 2
+ *  as published by the Free Softw=
are Foundation=2E
+ *
+ *  This program is distributed in the hope that it =
will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied war=
ranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See t=
he
+ *  GNU General Public License for more details=2E
+ *
+ *  You should =
have received a copy of the GNU General Public License along
+ *  with this=
 program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
+ =
* @file
+ * Encoding/decoding of out-of-band (P_CONTROL_OOB_V1) control mes=
sages=2E
+ *
+ * An OOB message payload starts with a 16-bit message type (=
the 0x1xx space:
+ * SERVER_PROBE, PROBE_REPLY, =2E=2E=2E) followed by a se=
quence of TLV entries in the
+ * 0x2xx type space=2E The framing itself is =
shared with the other TLV-based
+ * control messages of the wire protocol a=
nd lives in control_msg=2Eh; this file
+ * defines the OOB message and TLV =
types, their values, and the OOB-specific
+ * decisions taken on them=2E
+ =
*/
+
+#ifndef OOB_H
+#define OOB_H
+
+#include "buffer=2Eh"
+#include "sess=
ion_id=2Eh"
+
+/* OOB message types: the 16-bit value at the start of an OO=
B payload, before
+ * its TLV entries=2E Distinct from the TLV-type space (=
0x2xx); see the "Messages"
+ * table in the OOB section of the wire protoco=
l spec=2E */
+#define OOB_MSG_SERVER_PROBE 0x100
+#define OOB_MSG_PROBE_REP=
LY  0x101
+
+/* TLV types (see the OOB control message section of the wire =
protocol spec) */
+#define OOB_TLV_PROBE_PARAMETER 0x200
+#define OOB_TLV_P=
ROBE_REPLY     0x201
+
+/* Minimum on-wire value length (excluding the 4-by=
te TLV header) of each TLV:
+ * the sizes of its fixed fields in wire order=
 (see the structs below)=2E The
+ * value may be longer for forward compati=
bility; trailing bytes that are not
+ * understood are ignored on read=2E *=
/
+#define OOB_PROBE_PARAMETER_LEN \
+    ((uint16_t)(sizeof(uint64_t) /* t=
imestamp */ + sizeof(uint32_t) /* flags */))
+#define OOB_PROBE_REPLY_LEN  =
                                 \
+    ((uint16_t)(SID_SIZE               =
/* peer_session_id */  \
+                + 4 * sizeof(uint16_t) /* priorit=
y, weight,   \
+                                        * max_latency_diff,=
   \
+                                        * connect_lifetime */ \
+    =
            + sizeof(uint32_t)))   /* flags */
+
+/* probe parameter TLV (s=
ent by the client in a SERVER_PROBE) */
+struct oob_probe_parameter
+{
+   =
 uint64_t timestamp; /**< client clock as a UNIX timestamp */
+    uint32_t=
 flags;     /**< client capability flags, currently must be 0 */
+};
+
+/* =
probe reply TLV (sent by the server in a PROBE_REPLY) */
+struct oob_probe_=
reply
+{
+    struct session_id peer_session_id; /**< echoes the session id=
 of the request */
+    uint16_t priority;                 /**< DNS-SRV sty=
le priority (lower is preferred) */
+    uint16_t weight;                  =
 /**< DNS-SRV style weight */
+    uint16_t max_latency_diff;         /**< =
advertised candidate-band margin in ms;
+                                  =
      *   used unless the client configured its own */
+    uint16_t connec=
t_lifetime;         /**< seconds the reply stays valid as the handshake res=
et */
+    uint32_t flags;                    /**< server behaviour flags *=
/
+};
+
+/**
+ * Write a complete probe parameter TLV (header + value) to b=
uf=2E
+ */
+bool oob_probe_parameter_write(struct buffer *buf, const struct=
 oob_probe_parameter *p);
+
+/**
+ * Read a probe parameter TLV value from =
buf=2E
+ *
+ * buf must cover exactly the TLV's value, as returned by ctrl_=
msg_find_tlv()=2E
+ * Trailing bytes beyond the fields understood here are =
ignored, so a longer
+ * value from a future version still parses=2E
+ *
+ =
* @return true on success, false if buf is shorter than the mandatory field=
s=2E
+ */
+bool oob_probe_parameter_read(struct buffer *buf, struct oob_pro=
be_parameter *p);
+
+/**
+ * Write a complete probe reply TLV (header + val=
ue) to buf=2E
+ */
+bool oob_probe_reply_write(struct buffer *buf, const st=
ruct oob_probe_reply *r);
+
+/**
+ * Read a probe reply TLV value from buf=
=2E See oob_probe_parameter_read() for the
+ * calling convention=2E
+ */
+=
bool oob_probe_reply_read(struct buffer *buf, struct oob_probe_reply *r);
+=

+#endif /* OOB_H */
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec=

index 76150d4=2E=2E7184a2c 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/open=
vpn/ssl=2Ec
@@ -3706,7 +3706,7 @@
     struct session_id sid; /* remote ses=
sion ID */
 
     /* verify legal opcode */
-    if (op < P_FIRST_OPCODE ||=
 op > P_LAST_OPCODE)
+    if (!opcode_valid_in_session(op))
     {
        =
 if (op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_R=
ESET_SERVER_V1)
         {
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openv=
pn/ssl_pkt=2Ec
index 90b2aec=2E=2Ee87f9e2 100644
--- a/src/openvpn/ssl_pkt=
=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -167,7 +167,7 @@
                    =
bool prepend_ack)
 {
     ASSERT(ks->key_id >=3D 0 && ks->key_id <=3D P_KEY=
_ID_MASK);
-    ASSERT(opcode >=3D 0 && opcode <=3D P_LAST_OPCODE);
+    AS=
SERT(opcode_valid_in_session(opcode));
     uint8_t header =3D (uint8_t)(ks=
->key_id | (opcode << P_OPCODE_SHIFT));
 
     /* Workaround for Softether =
servers=2E Softether has a bug that it only
diff --git a/src/openvpn/ssl_pk=
t=2Eh b/src/openvpn/ssl_pkt=2Eh
index 03e8930=2E=2Ed46b8c5 100644
--- a/src=
/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -58,11 +58,53 @@
  * =
like P_CONTROL_HARD_RESET_CLIENT_V3 */
 #define P_CONTROL_WKC_V1 11
 
-/* d=
efine the range of legal opcodes
+/* Out-of-band control message that does =
not belong to an established
+ * control channel session (e=2Eg=2E a server=
 probe)=2E Inherently unreliable:
+ * there is no protocol-level retransmis=
sion=2E
+ *
+ * It is not legal on an established session; see opcode_valid=
_in_session()
+ * below=2E */
+#define P_CONTROL_OOB_V1 12
+
+/* define the=
 range of defined opcodes, in- and out-of-band=2E Note this is not
+ * the =
set of opcodes legal on an established session; see
+ * opcode_valid_in_ses=
sion()=2E
  * Since we do no longer support key-method 1 we consider
  * th=
e v1 op codes invalid */
 #define P_FIRST_OPCODE 3
-#define P_LAST_OPCODE  =
11
+#define P_LAST_OPCODE  12
+
+static inline bool
+opcode_is_oob(int op)
=
+{
+    return op =3D=3D P_CONTROL_OOB_V1;
+}
+
+/**
+ * Return true if op =
may occur on an established control-channel session=2E
+ *
+ * Out-of-band =
opcodes may not=2E They are answered statelessly on the
+ * new-connection =
path, and being rejected here is a permanent property rather
+ * than a han=
dler that is still missing:
+ *
+ *  - an OOB message carries its TLV paylo=
ad directly, with no reliability or
+ *    ACK fields (see tls_wrap_oob_sta=
ndalone()), whereas the established-session
+ *    path parses an ACK array=
 and a control packet-id before anything else=2E The
+ *    payload is chos=
en by the sender and session ids are plaintext on the wire,
+ *    so those=
 bytes can be crafted into a valid ACK array, forging ACKs into a
+ *    li=
ve control channel and stalling a handshake or rekey=2E
+ *  - nothing on t=
hat path parses an OOB payload, so there is nothing to gain by
+ *    accep=
ting one=2E
+ *
+ * This cannot be expressed as an opcode range: the inband=
 CONTROL_DATA_V1 of the
+ * wire protocol is legal on an established sessio=
n, so the OOB opcodes sit
+ * between legal ones=2E
+ */
+static inline boo=
l
+opcode_valid_in_session(int op)
+{
+    return op >=3D P_FIRST_OPCODE &&=
 op <=3D P_LAST_OPCODE && !opcode_is_oob(op);
+}
 
 /*
  * Define number of=
 buffers for send and receive in the reliability layer=2E
@@ -256,6 +298,9 =
@@
         case P_CONTROL_WKC_V1:
             return "P_CONTROL_WKC_V1";
=
 
+        case P_CONTROL_OOB_V1:
+            return "P_CONTROL_OOB_V1";
+=

         case P_ACK_V1:
             return "P_ACK_V1";
 
diff --git a/tes=
ts/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Ea=
m
index 5954902=2E=2E9f6b865 100644
--- a/tests/unit_tests/openvpn/Makefile=
=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -14,6 +14,7 @@
 	ncp_=
testdriver \
 	mbuf_testdriver \
 	misc_testdriver \
+	oob_testdriver \
 	o=
ptions_parse_testdriver \
 	packet_id_testdriver \
 	pkt_testdriver \
@@ -1=
53,6 +154,20 @@
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
 	$(top_srcdir=
)/src/openvpn/session_id=2Ec
 
+oob_testdriver_CFLAGS  =3D \
+	-I$(top_srcd=
ir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	@TES=
T_CFLAGS@
+oob_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
+oob_testdriver_SOURCE=
S =3D test_oob=2Ec \
+	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \
+	mock_g=
et_random=2Ec \
+	$(top_srcdir)/src/openvpn/buffer=2Ec \
+	$(top_srcdir)/sr=
c/openvpn/control_msg=2Ec \
+	$(top_srcdir)/src/openvpn/oob=2Ec \
+	$(top_s=
rcdir)/src/openvpn/platform=2Ec \
+	$(top_srcdir)/src/openvpn/session_id=2E=
c \
+	$(top_srcdir)/src/openvpn/win32-util=2Ec
+
 pkt_testdriver_CFLAGS  =
=3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/=
src/openvpn \
 	@TEST_CFLAGS@
diff --git a/tests/unit_tests/openvpn/test_oo=
b=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
new file mode 100644
index 00=
00000=2E=2E70f529e0
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_oob=
=2Ec
@@ -0,0 +1,340 @@
+/*
+ *  OpenVPN -- An application to securely tunne=
l IP networks
+ *             over a single TCP/UDP port, with support for =
SSL/TLS-based
+ *             session authentication and key exchange,
+ * =
            packet encryption, packet authentication, and
+ *             p=
acket compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@op=
envpn=2Enet>
+ *
+ *  This program is free software; you can redistribute i=
t and/or modify
+ *  it under the terms of the GNU General Public License v=
ersion 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This=
 program is distributed in the hope that it will be useful,
+ *  but WITHOU=
T ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Lice=
nse for more details=2E
+ *
+ *  You should have received a copy of the GNU=
 General Public License along
+ *  with this program; if not, see <https://=
www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "confi=
g=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdarg=2Eh>
+#include=
 <stddef=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "co=
ntrol_msg=2Eh"
+#include "oob=2Eh"
+#include "test_common=2Eh"
+
+/* Write =
a probe parameter TLV and read it back; fields must survive the
+ * round t=
rip and the whole buffer must be consumed=2E */
+static void
+test_probe_pa=
rameter_roundtrip(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+ =
   struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const struct oob_pr=
obe_parameter in =3D {
+        =2Etimestamp =3D 0x0123456789abcdefULL,
+  =
      =2Eflags =3D 0,
+    };
+    assert_true(oob_probe_parameter_write(&b=
uf, &in));
+    /* header (4) + value (12) */
+    assert_int_equal(BLEN(&b=
uf), 4 + OOB_PROBE_PARAMETER_LEN);
+
+    /* the header codec, read from a =
copy so the scan below still sees it */
+    struct buffer peek =3D buf;
+ =
   struct ctrl_msg_tlv_header hdr;
+    assert_true(ctrl_msg_tlv_read_heade=
r(&peek, &hdr));
+    assert_int_equal(hdr=2Etype, OOB_TLV_PROBE_PARAMETER)=
;
+    assert_false(hdr=2Eoptional);
+    assert_int_equal(hdr=2Evalue_len,=
 OOB_PROBE_PARAMETER_LEN);
+
+    struct buffer value;
+    assert_true(ctr=
l_msg_find_tlv(&buf, OOB_TLV_PROBE_PARAMETER, &value));
+    assert_int_equ=
al(BLEN(&value), OOB_PROBE_PARAMETER_LEN);
+
+    struct oob_probe_paramete=
r out =3D { 0 };
+    assert_true(oob_probe_parameter_read(&value, &out));
=
+    assert_true(in=2Etimestamp =3D=3D out=2Etimestamp);
+    assert_int_eq=
ual(in=2Eflags, out=2Eflags);
+    /* the scan consumed header and value al=
ike */
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* =
Write a probe reply TLV and read it back=2E */
+static void
+test_probe_rep=
ly_roundtrip(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    st=
ruct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    struct oob_probe_reply i=
n =3D {
+        =2Epriority =3D 10,
+        =2Eweight =3D 100,
+        =
=2Econnect_lifetime =3D 30,
+        =2Eflags =3D 1,
+        =2Emax_latenc=
y_diff =3D 25,
+    };
+    memcpy(in=2Epeer_session_id=2Eid, "ABCDEFGH", S=
ID_SIZE);
+
+    assert_true(oob_probe_reply_write(&buf, &in));
+    assert=
_int_equal(BLEN(&buf), 4 + OOB_PROBE_REPLY_LEN);
+
+    struct buffer peek =
=3D buf;
+    struct ctrl_msg_tlv_header hdr;
+    assert_true(ctrl_msg_tlv=
_read_header(&peek, &hdr));
+    assert_int_equal(hdr=2Etype, OOB_TLV_PROBE=
_REPLY);
+    assert_int_equal(hdr=2Evalue_len, OOB_PROBE_REPLY_LEN);
+
+  =
  struct buffer value;
+    assert_true(ctrl_msg_find_tlv(&buf, OOB_TLV_PRO=
BE_REPLY, &value));
+
+    struct oob_probe_reply out =3D { 0 };
+    asser=
t_true(oob_probe_reply_read(&value, &out));
+    assert_memory_equal(in=2Ep=
eer_session_id=2Eid, out=2Epeer_session_id=2Eid, SID_SIZE);
+    assert_int=
_equal(in=2Epriority, out=2Epriority);
+    assert_int_equal(in=2Eweight, o=
ut=2Eweight);
+    assert_int_equal(in=2Econnect_lifetime, out=2Econnect_li=
fetime);
+    assert_int_equal(in=2Eflags, out=2Eflags);
+    assert_int_eq=
ual(in=2Emax_latency_diff, out=2Emax_latency_diff);
+    assert_int_equal(B=
LEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* The probe reply wire format is=
 locked to the spec's field order
+ * (priority, weight, max_latency_diff, =
connect_lifetime, flags), big-endian=2E */
+static void
+test_probe_reply_w=
ire_format(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    stru=
ct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    struct oob_probe_reply in =
=3D {
+        =2Epriority =3D 10,
+        =2Eweight =3D 100,
+        =2E=
connect_lifetime =3D 30,
+        =2Eflags =3D 1,
+        =2Emax_latency_d=
iff =3D 25,
+    };
+    memcpy(in=2Epeer_session_id=2Eid, "ABCDEFGH", SID_=
SIZE);
+
+    assert_true(oob_probe_reply_write(&buf, &in));
+
+    const u=
int8_t expected[] =3D {
+        0x02,
+        0x01, /* TLV type 0x201 (no=
t optional) */
+        0x00,
+        0x14, /* TLV value length =3D 20 */
=
+        'A',
+        'B',
+        'C',
+        'D',
+        'E',
+    =
    'F',
+        'G',
+        'H',  /* peer_session_id */
+        0x00,
=
+        0x0a, /* priority =3D 10 */
+        0x00,
+        0x64, /* weigh=
t =3D 100 */
+        0x00,
+        0x19, /* max_latency_diff =3D 25 */
+ =
       0x00,
+        0x1e, /* connect_lifetime =3D 30 */
+        0x00,
+ =
       0x00,
+        0x00,
+        0x01, /* flags =3D 1 */
+    };
+    a=
ssert_int_equal(BLEN(&buf), sizeof(expected));
+    assert_memory_equal(BPT=
R(&buf), expected, sizeof(expected));
+
+    gc_free(&gc);
+}
+
+/* A TLV w=
ith a longer-than-known value must still parse: the known fields are
+ * re=
ad and the trailing bytes are skipped (forward compatibility)=2E */
+static=
 void
+test_probe_parameter_forward_compat(void **state)
+{
+    struct gc_=
arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+=

+    const uint16_t extended_len =3D OOB_PROBE_PARAMETER_LEN + 4;
+    ass=
ert_true(ctrl_msg_tlv_write_header(&buf, OOB_TLV_PROBE_PARAMETER, false, ex=
tended_len));
+    assert_true(buf_write_u32(&buf, 0));          /* timesta=
mp high */
+    assert_true(buf_write_u32(&buf, 0xdeadbeef)); /* timestamp =
low */
+    assert_true(buf_write_u32(&buf, 0));          /* flags */
+    =
assert_true(buf_write_u32(&buf, 0x11223344)); /* unknown trailing field */
=
+
+    struct buffer value;
+    assert_true(ctrl_msg_find_tlv(&buf, OOB_TL=
V_PROBE_PARAMETER, &value));
+    assert_int_equal(BLEN(&value), extended_l=
en);
+
+    struct oob_probe_parameter out =3D { 0 };
+    assert_true(oob_=
probe_parameter_read(&value, &out));
+    assert_true(out=2Etimestamp =3D=
=3D 0xdeadbeefULL);
+    assert_int_equal(out=2Eflags, 0);
+    /* the unkn=
own trailing field must have been consumed from the payload */
+    assert_=
int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* A value shorter tha=
n the mandatory fields must be rejected, even when it
+ * holds enough byte=
s for some of the individual fields to read successfully=2E */
+static void=

+test_probe_parameter_too_short(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    /* =
4 of the 12 mandatory value bytes: too short for the timestamp, but
+     *=
 enough for a u32 read to succeed on its own */
+    assert_true(buf_write_=
u32(&buf, 0xdeadbeef));
+
+    struct oob_probe_parameter out =3D { 0 };
+ =
   assert_false(oob_probe_parameter_read(&buf, &out));
+
+    gc_free(&gc);=

+}
+
+/* A TLV header claiming more value bytes than the payload holds mus=
t be
+ * rejected by the scan rather than reported as found -- for the TLV =
being
+ * looked for as much as for one that would merely be skipped=2E */
=
+static void
+test_find_tlv_value_truncated(void **state)
+{
+    struct gc=
_arena gc =3D gc_new();
+    struct buffer value;
+
+    /* the wanted TLV =
declares 12 value bytes, only 4 are present */
+    struct buffer buf =3D a=
lloc_buf_gc(128, &gc);
+    assert_true(ctrl_msg_tlv_write_header(&buf, OOB=
_TLV_PROBE_PARAMETER, false,
+                                          OOB=
_PROBE_PARAMETER_LEN));
+    assert_true(buf_write_u32(&buf, 0xdeadbeef));
=
+    assert_false(ctrl_msg_find_tlv(&buf, OOB_TLV_PROBE_PARAMETER, &value))=
;
+
+    /* same defect on a TLV that would be skipped: the scan must not w=
alk past
+     * the end of the payload looking for the next header */
+   =
 struct buffer buf2 =3D alloc_buf_gc(128, &gc);
+    assert_true(ctrl_msg_t=
lv_write_header(&buf2, 0x7ff, false, 64));
+    assert_true(buf_write_u32(&=
buf2, 0));
+    assert_false(ctrl_msg_find_tlv(&buf2, OOB_TLV_PROBE_PARAMET=
ER, &value));
+
+    gc_free(&gc);
+}
+
+/* Bytes left over after the last =
TLV that are too few for a header make the
+ * message malformed, even when=
 the wanted TLV was already found=2E */
+static void
+test_find_tlv_trailin=
g_bytes(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct =
buffer value;
+
+    /* 1 to 3 bytes: less than a 4-byte TLV header */
+   =
 for (int trailing =3D 1; trailing <=3D 3; trailing++)
+    {
+        stru=
ct buffer buf =3D alloc_buf_gc(128, &gc);
+        const struct oob_probe_p=
arameter in =3D { =2Etimestamp =3D 1, =2Eflags =3D 0 };
+        assert_tru=
e(oob_probe_parameter_write(&buf, &in));
+        for (int i =3D 0; i < tra=
iling; i++)
+        {
+            assert_true(buf_write_u8(&buf, 0));
+  =
      }
+        assert_false(ctrl_msg_find_tlv(&buf, OOB_TLV_PROBE_PARAMET=
ER, &value));
+    }
+
+    gc_free(&gc);
+}
+
+/* An unknown TLV marked op=
tional after the wanted one is skipped, and the
+ * wanted value is still t=
he one returned=2E */
+static void
+test_find_tlv_skips_optional_after_want=
ed(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffe=
r buf =3D alloc_buf_gc(128, &gc);
+    struct buffer value;
+
+    const st=
ruct oob_probe_parameter in =3D { =2Etimestamp =3D 7, =2Eflags =3D 0 };
+  =
  assert_true(oob_probe_parameter_write(&buf, &in));
+    assert_true(ctrl_=
msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    assert_true(buf_write_u32=
(&buf, 0));
+
+    assert_true(ctrl_msg_find_tlv(&buf, OOB_TLV_PROBE_PARAME=
TER, &value));
+    assert_int_equal(BLEN(&value), OOB_PROBE_PARAMETER_LEN)=
;
+    struct oob_probe_parameter out =3D { 0 };
+    assert_true(oob_probe=
_parameter_read(&value, &out));
+    assert_true(out=2Etimestamp =3D=3D 7);=

+
+    gc_free(&gc);
+}
+
+/* An empty payload holds no TLV=2E */
+static =
void
+test_find_tlv_empty_payload(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(16, &gc);
+    struct=
 buffer value;
+
+    assert_false(ctrl_msg_find_tlv(&buf, OOB_TLV_PROBE_PA=
RAMETER, &value));
+
+    gc_free(&gc);
+}
+
+/* Reading a TLV header must =
fail when the buffer holds less data than a
+ * complete 4-byte header (emp=
ty, or only the type field), rather than read
+ * past the available data=
=2E */
+static void
+test_tlv_header_truncated(void **state)
+{
+    struct=
 gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc=
);
+
+    struct ctrl_msg_tlv_header hdr;
+
+    /* empty buffer */
+    as=
sert_false(ctrl_msg_tlv_read_header(&buf, &hdr));
+
+    /* only the type f=
ield present, no length */
+    assert_true(buf_write_u16(&buf, OOB_TLV_PRO=
BE_PARAMETER));
+    assert_false(ctrl_msg_tlv_read_header(&buf, &hdr));
+
=
+    gc_free(&gc);
+}
+
+int
+main(void)
+{
+    openvpn_unit_test_setup();=

+    const struct CMUnitTest tests[] =3D {
+        cmocka_unit_test(test_=
probe_parameter_roundtrip),
+        cmocka_unit_test(test_probe_reply_roun=
dtrip),
+        cmocka_unit_test(test_probe_reply_wire_format),
+        c=
mocka_unit_test(test_probe_parameter_forward_compat),
+        cmocka_unit_=
test(test_probe_parameter_too_short),
+        cmocka_unit_test(test_find_t=
lv_value_truncated),
+        cmocka_unit_test(test_find_tlv_trailing_bytes=
),
+        cmocka_unit_test(test_find_tlv_skips_optional_after_wanted),
+ =
       cmocka_unit_test(test_find_tlv_empty_payload),
+        cmocka_unit_=
test(test_tlv_header_truncated),
+    };
+
+    return cmocka_run_group_tes=
ts_name("oob tests", tests, NULL, NULL);
+}

-- 
To view, visit http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Gerrit=
-Change-Number: 1741
Gerrit-PatchSet: 15
Gerrit-Owner: stipa <lstipakov@gma=
il=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Re=
viewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <=
ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: ralf=
_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom=
>

--MRafbvPIOyQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici, stipa=2E </p>
<p>=
stipa <strong>uploaded patch set #15</strong> to this change=2E</p><p><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">oob: Add control message TLV encoding (P_CONTROL_OO=
B_V1)<br><br>Out-of-band control messages carry control data but belong to =
no<br>session, so a client can ask a server about itself before connecting=
=2E<br>Reserve opcode 12 for them and add the codec for the two messages th=
e<br>probe needs, SERVER_PROBE and PROBE_REPLY=2E<br><br>The spec uses the =
same TLV framing for all its control messages, not<br>just the out-of-band =
ones, so the message-type header, the TLV header<br>and the TLV scan go int=
o their own control_msg=2Ec/h; oob=2Ec keeps the OOB<br>message and TLV typ=
es=2E<br><br>The scan is strict: a header or value that does not fit in the=
 remaining<br>payload, including trailing bytes too few for a header, or an=
 unknown<br>TLV not marked optional rejects the whole message rather than j=
ust the<br>TLV=2E<br><br>P_LAST_OPCODE becomes 12, and opcode_valid_in_sess=
ion() replaces the<br>plain range check because OOB opcodes are answered st=
atelessly and are<br>never legal on an established session=2E<br><br>See th=
e OOB control message section of the wire protocol specification<br>(openvp=
n-rfc PR #30)=2E<br><br>Change-Id: I1c8d302ac57c5603d622a7be14be36943738826=
8<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M CMak=
eLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>A src/openvpn/control_msg=2E=
c<br>A src/openvpn/control_msg=2Eh<br>A src/openvpn/oob=2Ec<br>A src/openvp=
n/oob=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/op=
envpn/ssl_pkt=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests/un=
it_tests/openvpn/test_oob=2Ec<br>11 files changed, 824 insertions(+), 4 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/41/1741/15</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt=
 b/CMakeLists=2Etxt</span><br><span>index 6eb5954=2E=2Efbc69f0 100644</span=
><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</s=
pan><br><span>@@ -445,6 +445,8 @@</span><br><span>     src/openvpn/console=
=2Ec</span><br><span>     src/openvpn/console_builtin=2Ec</span><br><span> =
    src/openvpn/console=2Eh</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    src/openvpn/control_msg=2Ec</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    src/openvpn/control_msg=2Eh</span><br><span>     sr=
c/openvpn/crypto=2Ec</span><br><span>     src/openvpn/crypto=2Eh</span><br>=
<span>     src/openvpn/crypto_backend=2Eh</span><br><span>@@ -523,6 +525,8 =
@@</span><br><span>     src/openvpn/multi_io=2Ec</span><br><span>     src/o=
penvpn/occ=2Ec</span><br><span>     src/openvpn/occ=2Eh</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/oob=2Ec</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/oob=2Eh</span><br><=
span>     src/openvpn/openvpn=2Ec</span><br><span>     src/openvpn/openvpn=
=2Eh</span><br><span>     src/openvpn/openvpn_win32_resources=2Erc</span><b=
r><span>@@ -677,6 +681,7 @@</span><br><span>         &quot;test_mbuf&quot;<=
/span><br><span>         &quot;test_misc&quot;</span><br><span>         &qu=
ot;test_ncp&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      &quot;test_oob&quot;</span><br><span>         &quot;test_options_pars=
e&quot;</span><br><span>         &quot;test_packet_id&quot;</span><br><span=
>         &quot;test_pkt&quot;</span><br><span>@@ -881,6 +886,13 @@</span><=
br><span>         src/openvpn/session_id=2Ec</span><br><span>         )</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    t=
arget_sources(test_oob PRIVATE</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        tests/unit_tests/openvpn/mock_get_random=2Ec</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/control_msg=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/ope=
nvpn/oob=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 src/openvpn/session_id=2Ec</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     target_sources(test_pkt PRIVATE</span><br><span>       =
  tests/unit_tests/openvpn/mock_win32_execve=2Ec</span><br><span>         s=
rc/openvpn/argv=2Ec</span><br><span>diff --git a/src/openvpn/Makefile=2Eam =
b/src/openvpn/Makefile=2Eam</span><br><span>index 7fd12b4=2E=2E5e6b4d9 1006=
44</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/sr=
c/openvpn/Makefile=2Eam</span><br><span>@@ -53,6 +53,7 @@</span><br><span> =
	common=2Eh \</span><br><span> 	comp=2Ec comp=2Eh compstub=2Ec \</span><br>=
<span> 	comp-lz4=2Ec comp-lz4=2Eh \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	control_msg=2Ec control_msg=2Eh \</span><br><span> 	crypto=
=2Ec crypto=2Eh crypto_backend=2Eh \</span><br><span> 	crypto_openssl=2Ec c=
rypto_openssl=2Eh \</span><br><span> 	crypto_mbedtls_legacy=2Ec crypto_mbed=
tls_legacy=2Eh \</span><br><span>@@ -107,6 +108,7 @@</span><br><span> 	pkcs=
11=2Ec pkcs11=2Eh pkcs11_backend=2Eh \</span><br><span> 	pkcs11_openssl=2Ec=
 \</span><br><span> 	pkcs11_mbedtls=2Ec \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	oob=2Ec oob=2Eh \</span><br><span> 	openvpn=2Ec open=
vpn=2Eh \</span><br><span> 	options=2Ec options=2Eh \</span><br><span> 	opt=
ions_show=2Ec options_show=2Eh \</span><br><span>diff --git a/src/openvpn/c=
ontrol_msg=2Ec b/src/openvpn/control_msg=2Ec</span><br><span>new file mode =
100644</span><br><span>index 0000000=2E=2E8d78639</span><br><span>--- /dev/=
null</span><br><span>+++ b/src/openvpn/control_msg=2Ec</span><br><span>@@ -=
0,0 +1,107 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An appli=
cation to securely tunnel IP networks</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *             over a single TCP/UDP port, with support f=
or SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            session authentication and key exchange,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, packet =
authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             packet compression=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  This program is free software; you can r=
edistribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  it under the terms of the GNU General Public License version 2=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by=
 the Free Software Foundation=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
This program is distributed in the hope that it will be useful,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; w=
ithout even the implied warranty of</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E =
 See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU Gen=
eral Public License for more details=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  You should have received a copy of the GNU General Public License al=
ong</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this pr=
ogram; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;c=
ontrol_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_read_header(struct buffe=
r *buf, uint16_t expected_msg_type)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  int msg_type =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return msg_type &gt;=3D 0 &amp;&amp; (uint16_t)msg_ty=
pe =3D=3D expected_msg_type;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_write_header(struct buffer *=
buf, uint16_t type, bool optional, uint16_t value_len)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    uint16_t field =3D type &amp; CTRL_MSG_TLV_TYPE_MASK;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (optional)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        field |=3D CTRL_MSG_TLV_OPTI=
ONAL_FLAG;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_write_u1=
6(buf, field) &amp;&amp; buf_write_u16(buf, value_len);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
ool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_rea=
d_header(struct buffer *buf, struct ctrl_msg_tlv_header *hdr)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int field =3D buf_read_u16(buf);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (field &lt; 0)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    int len =3D buf_read_u16(buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (len &lt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    hdr-&gt;type =3D (uint16_t)(field &amp; CTRL_MSG_TLV_TYPE_MASK)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt;option=
al =3D (field &amp; CTRL_MSG_TLV_OPTIONAL_FLAG) !=3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt;value_len =3D (uint16_t)len=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ctrl_msg_find_tlv(struct buffer *payload, uint16_t wanted_type, struct bu=
ffer *value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_h=
eader hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool =
found =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 while (BLEN(payload) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (!ctrl_msg_tlv_read_header(payload, &amp;hdr))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            /* bytes remain but too few for a heade=
r: truncated */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
/* Take the value out of payload=2E This validates that the header&#39;s</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * length is r=
eally there and advances past it in one step, so the TLV</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+         * we are looking for and the =
ones we skip are bounds-checked alike=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        uint8_t *v =3D buf_read_alloc(payload, hdr=
=2Evalue_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (!v)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return =
false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (hdr=2Etype =
=3D=3D wanted_type)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (!found)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    buf_set_read(value, v, hdr=2Evalue_len);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                found =3D true;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        else if (!hdr=2Eoptional)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            /* A TLV we do not understand that the=
 sender did not mark optional</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+             * carries something it requires us to act on, so the=
 message as a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
       * whole is not ours to interpret=2E This is why the scan continues</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * past t=
he wanted type: such a TLV invalidates the message wherever</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+             * in the sequence it s=
its=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return found;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a=
/src/openvpn/control_msg=2Eh b/src/openvpn/control_msg=2Eh</span><br><span>=
new file mode 100644</span><br><span>index 0000000=2E=2Eb98dce5</span><br><=
span>--- /dev/null</span><br><span>+++ b/src/openvpn/control_msg=2Eh</span>=
<br><span>@@ -0,0 +1,106 @@</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenV=
PN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port=
, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             session authentication and key exchange,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encr=
yption, packet authentication, and</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet compression=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=
=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free s=
oftware; you can redistribute it and/or modify</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public=
 License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  as published by the Free Software Foundation=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  This program is distributed in the hope that it will be u=
seful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PART=
ICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  GNU General Public License for more details=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  You should have received a copy of the GNU General=
 Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&=
gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Framing shared by the TLV-based control messages of the wire protocol=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Such a message payload starts wit=
h a 16-bit message type, followed by a</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * sequence of TLV entries=2E Each TLV starts with a 4-b=
yte header: a 16-bit field</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * whose most significant bit is the &quot;optional&quot; flag and w=
hose remaining 15 bits</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * are the type, followed by a 16-bit length giving the size of the valu=
e that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * follows th=
e header=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The message-type and T=
LV-type values themselves are specific to the message</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * family carried (out-of-band messages d=
efine theirs in oob=2Eh), so only the</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * framing lives here=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef CONT=
ROL_MSG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CO=
NTROL_MSG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* TLV header bit layout of the fi=
rst 16-bit field */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define CTRL_MSG_TLV_OPTIONAL_FLAG 0x8000</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define CTRL_MSG_TLV_TYPE_MASK     0x7fff</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* The header every TLV carries: the 15-bit type a=
nd optional flag packed into</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * the first 16-bit field, then the length of the value that follo=
ws=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct ctrl=
_msg_tlv_header</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t type;    =
  /**&lt; the 15-bit TLV type */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    bool optional;      /**&lt; value of the optional flag */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t value_l=
en; /**&lt; length of the value following the header */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read and veri=
fy a message-type header from buf, advancing past it=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param buf                buffer positioned at the me=
ssage payload</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram expected_msg_type  the message type the payload must carry</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @return true if a message typ=
e was read and equals expected_msg_type,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *         false on a short buffer or a mismatching ty=
pe=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_read_header(stru=
ct buffer *buf, uint16_t expected_msg_type);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a=
 TLV header (type + optional flag + value length) to buf=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @return true on success, false if buf has insuffi=
cient space=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_wri=
te_header(struct buffer *buf, uint16_t type, bool optional,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                               uint=
16_t value_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Read a TLV header from buf, advanci=
ng past it=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf  buffer p=
ositioned at the TLV header</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param hdr  filled with the type, optional flag and value length=
 on success</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retu=
rn true on success, false if there are not enough bytes for a header=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_read_header(struct bu=
ffer *buf, struct ctrl_msg_tlv_header *hdr);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Scan pa=
yload for the first TLV of type wanted_type, skipping any other (e=2Eg=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * future) TLV type t=
hat is marked optional=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The whol=
e sequence is walked, including the part after the wanted type: a TLV</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * we do not understand a=
nd that is not marked optional invalidates the message</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * wherever it sits, and rejecting it is=
 the point of the remaining scan=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* On success value covers exactly the found TLV&#39;s value bytes=2E The le=
ngth from</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * each TL=
V header is validated against payload as the scan goes, so the whole</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * value is guaranteed to =
be present; a header claiming more bytes than payload</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * holds is rejected rather than reported=
 as found=2E payload is consumed as it is</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * read=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param payload      buffer positioned at a TLV header</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param wanted_type  the TLV type to lo=
ok for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param val=
ue        set to a buffer covering the found TLV&#39;s value</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @return true if the TLV was fou=
nd, false if it is not present, a TLV header</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *         or value is malformed or truncated, or =
a TLV we do not understand is</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *         not marked optional=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bool ctrl_msg_find_tlv(struct buffer *payload, uint16_t wanted_type=
, struct buffer *value);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifnd=
ef CONTROL_MSG_H */</span><br><span>diff --git a/src/openvpn/oob=2Ec b/src/=
openvpn/oob=2Ec</span><br><span>new file mode 100644</span><br><span>index =
0000000=2E=2Ec807171</span><br><span>--- /dev/null</span><br><span>+++ b/sr=
c/openvpn/oob=2Ec</span><br><span>@@ -0,0 +1,83 @@</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over =
a single TCP/UDP port, with support for SSL/TLS-based</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             session authentication and=
 key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          packet encryption, packet authentication, and</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc=
 &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This=
 program is free software; you can redistribute it and/or modify</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the =
GNU General Public License version 2</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  as published by the Free Software Foundation=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the ho=
pe that it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a co=
py of the GNU General Public License along</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=
=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+oob_probe_parameter_write(struct buffer *buf, const stru=
ct oob_probe_parameter *p)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
ctrl_msg_tlv_write_header(buf, OOB_TLV_PROBE_PARAMETER, false, OOB_PROBE_PA=
RAMETER_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
    &amp;&amp; buf_write_u64(buf, p-&gt;timestamp)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u32(buf, p-&=
gt;flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+oob_probe_parameter_read(struct buffer *buf, struct oob_probe=
_parameter *p)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* One bounds check=
 covers the whole value: every field read below then fits</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * by construction (OOB_PROBE_PAR=
AMETER_LEN is the sum of their sizes), so</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * none of them needs its own error handling=2E T=
railing bytes this version</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * does not understand are simply left unread=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(buf) &lt; OOB_PR=
OBE_PARAMETER_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return =
false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    p-&gt;timestamp =3D buf=
_read_u64(buf, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    p-&gt;flags =3D buf_read_u32(buf, NULL);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_reply_write(struct=
 buffer *buf, const struct oob_probe_reply *r)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return ctrl_msg_tlv_write_header(buf, OOB_TLV_PROBE_REPLY, fal=
se, OOB_PROBE_REPLY_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+           &amp;&amp; session_id_write(&amp;r-&gt;peer_session_id, buf=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&a=
mp; buf_write_u16(buf, r-&gt;priority)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+           &amp;&amp; buf_write_u16(buf, r-&gt;weight)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp;=
 buf_write_u16(buf, r-&gt;max_latency_diff)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16(buf, r-&gt;conn=
ect_lifetime)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
     &amp;&amp; buf_write_u32(buf, r-&gt;flags);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_reply_read(st=
ruct buffer *buf, struct oob_probe_reply *r)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* One bounds check for the whole value, as in oob_probe_paramet=
er_read()=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (buf_len(buf) &lt; OOB_PROBE_REPLY_LEN)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 session_id_read(&amp;r-&gt;peer_session_id, buf);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    r-&gt;priority =3D (uint16_t)buf_read_u1=
6(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;we=
ight =3D (uint16_t)buf_read_u16(buf);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    r-&gt;max_latency_diff =3D (uint16_t)buf_read_u16(buf=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;connect=
_lifetime =3D (uint16_t)buf_read_u16(buf);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    r-&gt;flags =3D buf_read_u32(buf, NULL);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a=
/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>new file mode 10=
0644</span><br><span>index 0000000=2E=2Ec5396b3</span><br><span>--- /dev/nu=
ll</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -0,0 +1,110=
 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to =
securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             over a single TCP/UDP port, with support for SSL/TLS=
-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *           =
  session authentication and key exchange,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             packet encryption, packet authenticat=
ion, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyrig=
ht (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  This program is free software; you can redistribute=
 it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  it under the terms of the GNU General Public License version 2</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free S=
oftware Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This progra=
m is distributed in the hope that it will be useful,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without eve=
n the implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Publi=
c License for more details=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You=
 should have received a copy of the GNU General Public License along</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if =
not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @file</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * Encoding/decoding of out-=
of-band (P_CONTROL_OOB_V1) control messages=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * An OOB message payload starts with a 16-bit message type (the =
0x1xx space:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * SERV=
ER_PROBE, PROBE_REPLY, =2E=2E=2E) followed by a sequence of TLV entries in =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * 0x2xx type sp=
ace=2E The framing itself is shared with the other TLV-based</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * control messages of the wire pr=
otocol and lives in control_msg=2Eh; this file</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * defines the OOB message and TLV types, their =
values, and the OOB-specific</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * decisions taken on them=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef OOB_H</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_H</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;session_id=2Eh&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* OOB message types: the 16-bit value=
 at the start of an OOB payload, before</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * its TLV entries=2E Distinct from the TLV-type space =
(0x2xx); see the &quot;Messages&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * table in the OOB section of the wire protocol spec=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_MSG_S=
ERVER_PROBE 0x100</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine OOB_MSG_PROBE_REPLY  0x101</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* TLV=
 types (see the OOB control message section of the wire protocol spec) */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_TLV_PROBE=
_PARAMETER 0x200</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine OOB_TLV_PROBE_REPLY     0x201</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* M=
inimum on-wire value length (excluding the 4-byte TLV header) of each TLV:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the sizes of its =
fixed fields in wire order (see the structs below)=2E The</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * value may be longer for forward co=
mpatibility; trailing bytes that are not</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * understood are ignored on read=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define OOB_PROBE_PARAMETER_LEN \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ((uint16_t)(size=
of(uint64_t) /* timestamp */ + sizeof(uint32_t) /* flags */))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define OOB_PROBE_REPLY_LEN      =
                             \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ((uint16_t)(SID_SIZE               /* peer_session_id */  \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                + 4 =
* sizeof(uint16_t) /* priority, weight,   \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                        * max_laten=
cy_diff,   \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                                 * connect_lifetime */ \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                + sizeof(uint32_t)))  =
 /* flags */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* probe parameter TLV (se=
nt by the client in a SERVER_PROBE) */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+struct oob_probe_parameter</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    uint64_t timestamp; /**&lt; client clock as a UNIX timestamp */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t flags;=
     /**&lt; client capability flags, currently must be 0 */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* probe reply TLV (sent by the server in a PROBE_REPLY) */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+struct oob_probe_reply</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct session_id peer_session_id; /**&lt=
; echoes the session id of the request */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    uint16_t priority;                 /**&lt; DNS-SR=
V style priority (lower is preferred) */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    uint16_t weight;                   /**&lt; DNS-SRV=
 style weight */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 uint16_t max_latency_diff;         /**&lt; advertised candidate-band margi=
n in ms;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                             *   used unless the client configured its own =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t conn=
ect_lifetime;         /**&lt; seconds the reply stays valid as the handshak=
e reset */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint3=
2_t flags;                    /**&lt; server behaviour flags */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write=
 a complete probe parameter TLV (header + value) to buf=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+bool oob_probe_parameter_write(struct buffer *buf, c=
onst struct oob_probe_parameter *p);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read a probe pa=
rameter TLV value from buf=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * buf =
must cover exactly the TLV&#39;s value, as returned by ctrl_msg_find_tlv()=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Trailing byte=
s beyond the fields understood here are ignored, so a longer</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * value from a future version sti=
ll parses=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on succe=
ss, false if buf is shorter than the mandatory fields=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bool oob_probe_parameter_read(struct buffer *buf, stru=
ct oob_probe_parameter *p);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a complete probe r=
eply TLV (header + value) to buf=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
bool oob_probe_reply_write(struct buffer *buf, const struct oob_probe_reply=
 *r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Read a probe reply TLV value from buf=2E See o=
ob_probe_parameter_read() for the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * calling convention=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+bool oob_probe_reply_read(struct buffer *buf, struct oob_probe_reply *r)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif /* OOB_H */</span><br><span>di=
ff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index =
76150d4=2E=2E7184a2c 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span=
><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -3706,7 +3706,7 @@<=
/span><br><span>     struct session_id sid; /* remote session ID */</span><=
br><span> </span><br><span>     /* verify legal opcode */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (op &lt; P_FIRST_OPCODE || op &g=
t; P_LAST_OPCODE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (!opcode_valid_in_session(op))</span><br><span>     {</span><br><span>=
         if (op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTRO=
L_HARD_RESET_SERVER_V1)</span><br><span>         {</span><br><span>diff --g=
it a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>inde=
x 90b2aec=2E=2Ee87f9e2 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec=
</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -167,7 +1=
67,7 @@</span><br><span>                    bool prepend_ack)</span><br><sp=
an> {</span><br><span>     ASSERT(ks-&gt;key_id &gt;=3D 0 &amp;&amp; ks-&gt=
;key_id &lt;=3D P_KEY_ID_MASK);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    ASSERT(opcode &gt;=3D 0 &amp;&amp; opcode &lt;=3D P_LAST_OPCO=
DE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(opco=
de_valid_in_session(opcode));</span><br><span>     uint8_t header =3D (uint=
8_t)(ks-&gt;key_id | (opcode &lt;&lt; P_OPCODE_SHIFT));</span><br><span> </=
span><br><span>     /* Workaround for Softether servers=2E Softether has a =
bug that it only</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src=
/openvpn/ssl_pkt=2Eh</span><br><span>index 03e8930=2E=2Ed46b8c5 100644</spa=
n><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn=
/ssl_pkt=2Eh</span><br><span>@@ -58,11 +58,53 @@</span><br><span>  * like P=
_CONTROL_HARD_RESET_CLIENT_V3 */</span><br><span> #define P_CONTROL_WKC_V1 =
11</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
* define the range of legal opcodes</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* Out-of-band control message that does not belong to an e=
stablished</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * contro=
l channel session (e=2Eg=2E a server probe)=2E Inherently unreliable:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * there is no protocol-l=
evel retransmission=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * It is not l=
egal on an established session; see opcode_valid_in_session()</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * below=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define P_CONTROL_OOB_V1 12</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* define the range of defined opcodes, in- and o=
ut-of-band=2E Note this is not</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * the set of opcodes legal on an established session; see</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * opcode_valid_in_sessio=
n()=2E</span><br><span>  * Since we do no longer support key-method 1 we co=
nsider</span><br><span>  * the v1 op codes invalid */</span><br><span> #def=
ine P_FIRST_OPCODE 3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define P_LAST_OPCODE  11</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define P_LAST_OPCODE  12</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static i=
nline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+opcode_is=
_oob(int op)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return op =3D=3D P_CO=
NTROL_OOB_V1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Return true if op may occur on an established control-=
channel session=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Out-of-band opc=
odes may not=2E They are answered statelessly on the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * new-connection path, and being rejecte=
d here is a permanent property rather</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * than a handler that is still missing:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  - an OOB message carries its TLV payload directly=
, with no reliability or</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *    ACK fields (see tls_wrap_oob_standalone()), whereas the establis=
hed-session</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    pa=
th parses an ACK array and a control packet-id before anything else=2E The<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    payload is cho=
sen by the sender and session ids are plaintext on the wire,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *    so those bytes can be crafte=
d into a valid ACK array, forging ACKs into a</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *    live control channel and stalling a handsha=
ke or rekey=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  -=
 nothing on that path parses an OOB payload, so there is nothing to gain by=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    accepting one=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * This cannot be expressed as an=
 opcode range: the inband CONTROL_DATA_V1 of the</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * wire protocol is legal on an established se=
ssion, so the OOB opcodes sit</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * between legal ones=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic inline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+op=
code_valid_in_session(int op)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn op &gt;=3D P_FIRST_OPCODE &amp;&amp; op &lt;=3D P_LAST_OPCODE &amp;&amp;=
 !opcode_is_oob(op);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span> </span><br><span> /*</span><br><span>  * Define number =
of buffers for send and receive in the reliability layer=2E</span><br><span=
>@@ -256,6 +298,9 @@</span><br><span>         case P_CONTROL_WKC_V1:</span>=
<br><span>             return &quot;P_CONTROL_WKC_V1&quot;;</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case P_CO=
NTROL_OOB_V1:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      return &quot;P_CONTROL_OOB_V1&quot;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span>         case P_ACK_V1:</span><br><=
span>             return &quot;P_ACK_V1&quot;;</span><br><span> </span><br>=
<span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_test=
s/openvpn/Makefile=2Eam</span><br><span>index 5954902=2E=2E9f6b865 100644</=
span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span=
>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -14,6 +14,=
7 @@</span><br><span> 	ncp_testdriver \</span><br><span> 	mbuf_testdriver \=
</span><br><span> 	misc_testdriver \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	oob_testdriver \</span><br><span> 	options_parse_testdriv=
er \</span><br><span> 	packet_id_testdriver \</span><br><span> 	pkt_testdri=
ver \</span><br><span>@@ -153,6 +154,20 @@</span><br><span> 	$(top_srcdir)/=
src/openvpn/win32-util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/se=
ssion_id=2Ec</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+oob_testdriver_CFLAGS  =3D \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$=
(top_srcdir)/src/openvpn \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	@TEST_CFLAGS@</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+oob_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+oob_testdriver_SOURCES =3D test_oob=2Ec \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg=2Ec mock_msg=2Eh te=
st_common=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	moc=
k_get_random=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/control_msg=2Ec \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/oob=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir=
)/src/openvpn/platform=2Ec \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	$(top_srcdir)/src/openvpn/session_id=2Ec \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/win32-util=2Ec=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> p=
kt_testdriver_CFLAGS  =3D \</span><br><span> 	-I$(top_srcdir)/include -I$(t=
op_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span> 	@TEST=
_CFLAGS@</span><br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec=
 b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>new file mode 1006=
44</span><br><span>index 0000000=2E=2E70f529e0</span><br><span>--- /dev/nul=
l</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><sp=
an>@@ -0,0 +1,340 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- A=
n application to securely tunnel IP networks</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with su=
pport for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             session authentication and key exchange,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, p=
acket authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *             packet compression=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you=
 can redistribute it and/or modify</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  it under the terms of the GNU General Public License ver=
sion 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publis=
hed by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  This program is distributed in the hope that it will be useful,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRA=
NTY; without even the implied warranty of</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPO=
SE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  G=
NU General Public License for more details=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  You should have received a copy of the GNU General Public Lice=
nse along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with t=
his program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
lt;stdarg=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &lt;stddef=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &lt;setjmp=2Eh&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;control_msg=2Eh&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;test_common=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* Write a probe parameter TLV and read it back;=
 fields must survive the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * round trip and the whole buffer must be consumed=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+test_probe_parameter_roundtrip(void **st=
ate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new=
();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffe=
r buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const struct oob_probe_parameter in =3D {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        =2Etimestamp =3D 0x0123456789abcdefULL,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D 0=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_param=
eter_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* header (4) + value (12) */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 4 + OOB_PROB=
E_PARAMETER_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the header cod=
ec, read from a copy so the scan below still sees it */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct buffer peek =3D buf;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_hea=
der hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(ctrl_msg_tlv_read_header(&amp;peek, &amp;hdr));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, OOB_TLV_=
PROBE_PARAMETER);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_false(hdr=2Eoptional);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(hdr=2Evalue_len, OOB_PROBE_PARAMETER_LEN);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_find_tlv=
(&amp;buf, OOB_TLV_PROBE_PARAMETER, &amp;value));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), OOB_PR=
OBE_PARAMETER_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_prob=
e_parameter out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_true(oob_probe_parameter_read(&amp;value, &amp;out));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(in=2Eti=
mestamp =3D=3D out=2Etimestamp);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(in=2Eflags, out=2Eflags);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* the scan consumed header and=
 value alike */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* Write a probe reply TLV and read i=
t back=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_repl=
y_roundtrip(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct g=
c_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct oob_probe_reply in =3D {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        =2Epriority =3D 10,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        =2Eweight =3D 100,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Econnect_lifet=
ime =3D 30,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
=2Eflags =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    =2Emax_latency_diff =3D 25,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   memcpy(in=2Epeer_session_id=2Eid, &quot;ABCDEFGH&quot;, SID_SIZE);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_reply_write(&amp;b=
uf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(BLEN(&amp;buf), 4 + OOB_PROBE_REPLY_LEN);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer peek =3D buf;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_header hdr;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv=
_read_header(&amp;peek, &amp;hdr));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(hdr=2Etype, OOB_TLV_PROBE_REPLY);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=
=2Evalue_len, OOB_PROBE_REPLY_LEN);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(ctrl_msg_find_tlv(&amp;buf, OOB_TLV_PROBE_REPLY, &amp;val=
ue));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply out =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_true(oob_probe_reply_read(&amp;value, &amp;out));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(in=2Epeer_session=
_id=2Eid, out=2Epeer_session_id=2Eid, SID_SIZE);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Epriority, out=2Eprio=
rity);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(in=2Eweight, out=2Eweight);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(in=2Econnect_lifetime, out=2Econnect_l=
ifetime);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(in=2Eflags, out=2Eflags);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_int_equal(in=2Emax_latency_diff, out=2Emax_late=
ncy_diff);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_=
free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* The probe reply wire format is locked =
to the spec&#39;s field order</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * (priority, weight, max_latency_diff, connect_lifetime, flags),=
 big-endian=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe=
_reply_wire_format(void **state)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct oob_probe_reply in =3D {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        =2Epriority =3D 10,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eweight =3D 10=
0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Econnec=
t_lifetime =3D 30,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       =2Eflags =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        =2Emax_latency_diff =3D 25,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    memcpy(in=2Epeer_session_id=2Eid, &quot;ABCDEFGH&quot;, SID_SIZE)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_reply_write=
(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t=
 expected[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      0x02,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
0x01, /* TLV type 0x201 (not optional) */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        0x00,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        0x14, /* TLV value length =3D 20 */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        &#39;A&#39;,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        &#39;B&#39;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        &#39;C&#39;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        &#39;D&#39;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        &#39;E&#39;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        &#39;F&#39;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        &#39;G&#39;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        &#39;H&#39;,  /* pee=
r_session_id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x=
0a, /* priority =3D 10 */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        0x64, /* weight =3D 100 */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        0x00,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        0x19, /* max_latency_diff =3D 25 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        0x00,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        0x1e, /* connect_lifetime =3D 30 */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x00,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        0x00,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        0x00,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        0x01, /* flags =3D 1 */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), size=
of(expected));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_memory_equal(BPTR(&amp;buf), expected, sizeof(expected));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A TLV w=
ith a longer-than-known value must still parse: the known fields are</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * read and the trailing b=
ytes are skipped (forward compatibility)=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_probe_parameter_forward_compat(void **state)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D a=
lloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ui=
nt16_t extended_len =3D OOB_PROBE_PARAMETER_LEN + 4;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header=
(&amp;buf, OOB_TLV_PROBE_PARAMETER, false, extended_len));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;b=
uf, 0));          /* timestamp high */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0xdeadbeef)); /*=
 timestamp low */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(buf_write_u32(&amp;buf, 0));          /* flags */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&=
amp;buf, 0x11223344)); /* unknown trailing field */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct buffer value;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(ctrl_msg_find_tlv(&amp;buf, OOB_TLV_PRO=
BE_PARAMETER, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(BLEN(&amp;value), extended_len);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct oob_probe_parameter out =3D { 0 };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_=
parameter_read(&amp;value, &amp;out));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(out=2Etimestamp =3D=3D 0xdeadbeefULL);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
out=2Eflags, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* the unknown trailing field must have been consumed from the payload */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* A value shorter than the mandatory fields must be =
rejected, even when it</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * holds enough bytes for some of the individual fields to read successf=
ully=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_parame=
ter_too_short(void **state)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* 4 of the 12 mandatory value bytes: too short f=
or the timestamp, but</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * enough for a u32 read to succeed on its own */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf,=
 0xdeadbeef));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_par=
ameter out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_false(oob_probe_parameter_read(&amp;buf, &amp;out));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A TLV=
 header claiming more value bytes than the payload holds must be</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * rejected by the scan rather=
 than reported as found -- for the TLV being</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * looked for as much as for one that would merely=
 be skipped=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_find_=
tlv_value_truncated(void **state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct buffer value;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* the wanted TLV declares 12 value bytes, only 4 are present */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D a=
lloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, OOB_TLV_PROBE_PA=
RAMETER, false,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                                      OOB_PROBE_PARAMETER_LEN));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(=
&amp;buf, 0xdeadbeef));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_false(ctrl_msg_find_tlv(&amp;buf, OOB_TLV_PROBE_PARAMETER, &=
amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* same defect on a TL=
V that would be skipped: the scan must not walk past</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * the end of the payload looking for=
 the next header */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct buffer buf2 =3D alloc_buf_gc(128, &amp;gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_heade=
r(&amp;buf2, 0x7ff, false, 64));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(buf_write_u32(&amp;buf2, 0));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_find_tlv(&=
amp;buf2, OOB_TLV_PROBE_PARAMETER, &amp;value));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Bytes left over after =
the last TLV that are too few for a header make the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * message malformed, even when the wante=
d TLV was already found=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+test_find_tlv_trailing_bytes(void **state)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* 1 to 3 bytes: less than a 4-byte TLV header */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    for (int trailing =3D 1; tr=
ailing &lt;=3D 3; trailing++)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const struct oob_probe_parameter =
in =3D { =2Etimestamp =3D 1, =2Eflags =3D 0 };</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        assert_true(oob_probe_parameter_write(&a=
mp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       for (int i =3D 0; i &lt; trailing; i++)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            assert_true(buf_write_u8(&amp;buf, 0));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        assert_false(ctrl_msg_find_t=
lv(&amp;buf, OOB_TLV_PROBE_PARAMETER, &amp;value));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* An unknown TLV marked optional =
after the wanted one is skipped, and the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * wanted value is still the one returned=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+test_find_tlv_skips_optional_after=
_wanted(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_ar=
ena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const struct oob_probe_parameter in =3D { =2Etimes=
tamp =3D 7, =2Eflags =3D 0 };</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(oob_probe_parameter_write(&amp;buf, &amp;in));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_m=
sg_tlv_write_header(&amp;buf, 0x7ff, true, 4));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_find_tlv(&amp;bu=
f, OOB_TLV_PROBE_PARAMETER, &amp;value));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), OOB_PROBE_PARA=
METER_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct oob_probe_parameter out =3D { 0 };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(oob_probe_parameter_read(&amp;value, &amp=
;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(out=2Etimestamp =3D=3D 7);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* An empty payload holds no TLV=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+test_find_tlv_empty_payload(vo=
id **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D=
 gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t buffer buf =3D alloc_buf_gc(16, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_false(ctrl_msg_find_tlv(&amp;buf, OOB_TLV_PROBE_PARAME=
TER, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* Reading a TLV header must fail when the buffer holds=
 less data than a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 complete 4-byte header (empty, or only the type field), rather than read</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * past the available=
 data=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_tlv_header_=
truncated(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_=
arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct ctrl_msg_tlv_header hdr;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* empty buffer */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_false(ctrl_msg_tlv_read_header(&amp;buf, &amp;=
hdr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* only the type field prese=
nt, no length */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(buf_write_u16(&amp;buf, OOB_TLV_PROBE_PARAMETER));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_tlv_r=
ead_header(&amp;buf, &amp;hdr));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc=
_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+main(void)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openv=
pn_unit_test_setup();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const struct CMUnitTest tests[] =3D {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_parameter_round=
trip),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmock=
a_unit_test(test_probe_reply_roundtrip),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        cmocka_unit_test(test_probe_reply_wire_format)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_uni=
t_test(test_probe_parameter_forward_compat),</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_parameter_too_=
short),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmoc=
ka_unit_test(test_find_tlv_value_truncated),</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_find_tlv_trailing_by=
tes),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka=
_unit_test(test_find_tlv_skips_optional_after_wanted),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_find_tlv_e=
mpty_payload),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   cmocka_unit_test(test_tlv_header_truncated),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return cmocka_run_group_tests_name(&quot;oob tests&quot;, tests, NULL, NULL=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1741?usp=3Demail">change 1741</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be36=
9437388268 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1741 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 15 </div>
<div style=3D=
"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipak=
ov@gmail=2Ecom&gt; </div>

</body></html>
--MRafbvPIOyQ=--


--===============3517042527803130535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3517042527803130535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3517042527803130535==--

