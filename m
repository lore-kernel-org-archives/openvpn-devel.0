Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7AFC61DD7
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3xiPTuToY5kR0SjNQwODLuBjIYrsdLHiB50SHQjVDao=; b=kH+bxlCEp8t58JD+QoZGkfiLNK
	qXGF9GSdCJuK2FqlyCaROMqeRLv02UTex4W+bksmYdA7R58frWnehXE8zQTvfCmLJCKBtAo7RT5Tl
	6PfSb5bXaTAd9zdZhpsGqy2OfTSUvnDbnYnlZBmfedQr+LEcj3i+wpmH2JNQUzWzoefI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzw3a-0002rG-3j;
	Fri, 28 Aug 2026 12:51:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzw3S-0002qq-4P
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:51:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=DAiUUsXqmnCd5y2smL8z9/+rhLQYex+yJVvRNn6EdlA=; b=TpdYhqU4qvtEPOxLdhqOy7ELJ7
 4lLYNFOXmn/FnaifTv0Tk1bZnWnepLJmJGErrhTdVLBaXC0++36896asxotz6y2vBdYc0LPbp4t9o
 kdVjddFZ6oBQOrlHsQuhWzl8IhxPeYUmuwpfUJffZUOHBIFZbapzhvIb1vBLm+1QIkIs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DAiUUsXqmnCd5y2smL8z9/+rhLQYex+yJVvRNn6EdlA=; b=R
 PNbzPhJPtjFrZFCgyNvL7QjL7KT1kMsNMbw6FQrV424VE2EiFpm2L5y0GLQn/e2K2PjIY3BWQERtP
 l8COlWh7xbDyMJU9GnJDbxFI940QMPdb4+49g+emInQj0QyjUzTYMQx4PfxEEduUvOeSe+pH3vejd
 RgRNavAatVClyqSU=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzw39-0003Fb-KH for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:51:31 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49b0dd3c9a0so6422775e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 05:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787921469; x=1788526269; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DAiUUsXqmnCd5y2smL8z9/+rhLQYex+yJVvRNn6EdlA=;
 b=P5Dj3XnChZtPpWPrSPX43vey4+q2onvesuvohlaptUWRxb6x2XIHd4hDAGnYdOPJvQ
 5EcL+39dDizzcO4s06c4WgxvroxWEWOr8o4eytvg57Z3Zql2TEUfD8nXZzR/dkGvRHRs
 CNLyvmHovNtZqGhR522/q64U4QFOxaGb67befX4v5SuG9J8eAE/H2+cCHZdrlTabNLYK
 MQOgIFsqVxhVpI4fRFIzR5dt5ezeVxL9oZAStd7W1CFSSHcb+g+W2440Roe13JHaaARj
 Gu+tZTKqT094IlhFpuBnx5NY05FTN4YyzVFpdk9EVUZScODvQta+/vtT0Lsx5cSOobQH
 2zFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787921469; x=1788526269;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DAiUUsXqmnCd5y2smL8z9/+rhLQYex+yJVvRNn6EdlA=;
 b=ByK/x7rO/SRNbvZiZS5uejtOJO7G6rCM+uwf+S/bgVQXQgXvb3CdoBFAlLva87AeY8
 FiFeUr0DCL72ZjHRaFuD8lwiTFWMLpvxn5ipKodfUB2cqmt47xv0TsChtWev/IprARae
 5SJxnXKnoaVOCCh8pjh4yWSjseZRXh/9iKlXVZztG3DKBJQoZLVDnwmSdvniKye6fXiX
 JntLK/7T09ON3ncm1Ahyy8Q9Ipq5VUTnrGx3dzwmGM107iV1eaZnIw2iPKYWTAwrrkZm
 9UrlZwsepfh8oZNrXTHGxoX3S4hnu8/yRfToyjjEN22Cp+Css3lzHcwPqrn0t19YuTtV
 8LNg==
X-Gm-Message-State: AFuF++kIFLFNTLHNScDeIy+lO8vR3VXA4uJ8/+eK/jFjUPvEDXta2O7g
 mrsydTWbNAtK+KYkXyypGUbImMu0ySaO35TGLUDSZ0bYqYpjAbftTpY2gwDtZutfIJgp/rw0iVk
 KC9ay40BcBa4OaagfhI2neKJr7mwoFVUb2+c2OkVGmbXKzPqkF+kPG16MJDoIau2bkSyi
X-Gm-Gg: AR+sD13HN9Vk92OK0qMBfohmPWJCa4tJMMgLJAhrc98um2m5T2neiTwfCWGOo91+7tA
 LsX2fsefMAMUnYEyGVlcyy4ztDDsE9ldBphOefcj0md/XvasKIVQEqcip98DVEbuvJM+IzXTD+E
 RKkf0s7Um6DReQkEL4Uob3z0Wi9fPj3k/iIwbGnrjbCUisY+Ej5SZ1LrkpmAXYcllovwzVYy9mb
 yfQZ7Zy19xf2gv9rO9m9e5UiFrgIqapKmI6q+qOKS9yyUL6DpVQrPq6iDE6Ya4aEOrfxYgwrtbH
 MZqbFZYdfOIWJW505XQsB9UuLRulrGoD408JbCUrK4b7VlU7jfniCWRKgP0LuQALl/52VYa1Z05
 pa6x9zzgQOB2qdzN0S1oZFptZWLqAKPX06D2TYKyCmrQkuAzc+/2HqZlWszFD0G4JnMLlKU0QFQ
 9QDIKR07pLiyDIRCZ53I/ji6IMVHCug72mCwGOh0BvZfstHM49SBZxwwvLLSIuiiUeO3WeEYhYH
 oSeb4soFYa0Km6zSITjRcS6xhee/JBsHnk41Mcv5K2wKwKnQ4xGVbVveraPT/+DgZLCIMT43Jov
 dyPDRXpcyi4emsdk2xgTL8hBB+F/QnXTut6Em5iO/uHCgv8qygtU
X-Received: by 2002:a05:600c:4513:b0:49a:252d:52f5 with SMTP id
 5b1f17b1804b1-49b91c487a6mr97759965e9.11.1787921468291; 
 Fri, 28 Aug 2026 05:51:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b494228bfsm127989965e9.2.2026.08.28.05.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:51:07 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 12:51:00 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: b401b0989fda78f36449073f3b64df9900d21bc5
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4940f7ea298fc9b58f532460d7ecf6822385e0cf-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzw39-0003Fb-KH
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7100853498547641514=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7100853498547641514==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HjFreasUlF0="; charset=UTF-8

--HjFreasUlF0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, plaisthos, 

I'd like you to reexamine a change=2E Please visit
=

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail

to look at=
 the new patch set (#12)=2E


Change subject: oob: Add control message TLV =
encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

oob: Add control message TLV encoding (P_CONTROL_OOB_V1)

=
Out-of-band control messages carry control data but belong to no session, s=
o a
client can ask a server about itself before connecting=2E Reserve opcod=
e 12 for
them and add the codec for the two messages the probe needs, SERVE=
R_PROBE and
PROBE_REPLY=2E

The spec uses the same TLV framing for all its =
control messages, not just the
out-of-band ones, so the message-type header=
, the TLV header and the TLV scan go
into their own control_msg=2Ec/h; oob=
=2Ec keeps the OOB message and TLV types=2E

P_LAST_OPCODE becomes 12, and =
opcode_valid_in_session() replaces the plain range
check because OOB opcode=
s are answered statelessly and are never legal on an
established session=2E=


See the OOB control message section of the wire protocol specification
(o=
penvpn-rfc PR #30)=2E

Change-Id: I1c8d302ac57c5603d622a7be14be369437388268=

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
, 756 insertions(+), 4 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/41/1741/12

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
index 0000000=2E=2E6d3b3bf
--- /dev/null
+++ b/src/openvpn/contr=
ol_msg=2Ec
@@ -0,0 +1,102 @@
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
+    while (ctrl_msg_tlv_read_header(payload, &hd=
r))
+    {
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
index 0000000=2E=2E0a9a4bb
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
      *   0 means "defer to the client's setting" */
+    uint16_t connect_=
lifetime;         /**< seconds the reply stays valid as the handshake reset=
 */
+    uint32_t flags;                    /**< server behaviour flags */
=
+};
+
+/**
+ * Write a complete probe parameter TLV (header + value) to buf=
=2E
+ */
+bool oob_probe_parameter_write(struct buffer *buf, const struct o=
ob_probe_parameter *p);
+
+/**
+ * Read a probe parameter TLV value from bu=
f=2E
+ *
+ * buf must cover exactly the TLV's value, as returned by ctrl_ms=
g_find_tlv()=2E
+ * Trailing bytes beyond the fields understood here are ig=
nored, so a longer
+ * value from a future version still parses=2E
+ *
+ * =
@return true on success, false if buf is shorter than the mandatory fields=
=2E
+ */
+bool oob_probe_parameter_read(struct buffer *buf, struct oob_prob=
e_parameter *p);
+
+/**
+ * Write a complete probe reply TLV (header + valu=
e) to buf=2E
+ */
+bool oob_probe_reply_write(struct buffer *buf, const str=
uct oob_probe_reply *r);
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

index 5f5d1f9=2E=2Ec8fc465 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/open=
vpn/ssl=2Ec
@@ -3676,7 +3676,7 @@
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
index 6a6d9f9=2E=2E39cb648 100644
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
00000=2E=2Eaa4eb23
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_oob=2E=
c
@@ -0,0 +1,277 @@
+/*
+ *  OpenVPN -- An application to securely tunnel I=
P networks
+ *             over a single TCP/UDP port, with support for SSL=
/TLS-based
+ *             session authentication and key exchange,
+ *    =
         packet encryption, packet authentication, and
+ *             pack=
et compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openv=
pn=2Enet>
+ *
+ *  This program is free software; you can redistribute it a=
nd/or modify
+ *  it under the terms of the GNU General Public License vers=
ion 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This pr=
ogram is distributed in the hope that it will be useful,
+ *  but WITHOUT A=
NY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or F=
ITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License=
 for more details=2E
+ *
+ *  You should have received a copy of the GNU Ge=
neral Public License along
+ *  with this program; if not, see <https://www=
=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=
=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdarg=2Eh>
+#include =
<stddef=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "con=
trol_msg=2Eh"
+#include "oob=2Eh"
+#include "test_common=2Eh"
+
+/* Write a=
 probe parameter TLV and read it back; fields must survive the
+ * round tr=
ip and the whole buffer must be consumed=2E */
+static void
+test_probe_par=
ameter_roundtrip(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+  =
  struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const struct oob_pro=
be_parameter in =3D {
+        =2Etimestamp =3D 0x0123456789abcdefULL,
+   =
     =2Eflags =3D 0,
+    };
+    assert_true(oob_probe_parameter_write(&bu=
f, &in));
+    /* header (4) + value (12) */
+    assert_int_equal(BLEN(&bu=
f), 4 + OOB_PROBE_PARAMETER_LEN);
+
+    /* the header codec, read from a c=
opy so the scan below still sees it */
+    struct buffer peek =3D buf;
+  =
  struct ctrl_msg_tlv_header hdr;
+    assert_true(ctrl_msg_tlv_read_header=
(&peek, &hdr));
+    assert_int_equal(hdr=2Etype, OOB_TLV_PROBE_PARAMETER);=

+    assert_false(hdr=2Eoptional);
+    assert_int_equal(hdr=2Evalue_len, =
OOB_PROBE_PARAMETER_LEN);
+
+    struct buffer value;
+    assert_true(ctrl=
_msg_find_tlv(&buf, OOB_TLV_PROBE_PARAMETER, &value));
+    assert_int_equa=
l(BLEN(&value), OOB_PROBE_PARAMETER_LEN);
+
+    struct oob_probe_parameter=
 out =3D { 0 };
+    assert_true(oob_probe_parameter_read(&value, &out));
+=
    assert_true(in=2Etimestamp =3D=3D out=2Etimestamp);
+    assert_int_equ=
al(in=2Eflags, out=2Eflags);
+    /* the scan consumed header and value ali=
ke */
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* W=
rite a probe reply TLV and read it back=2E */
+static void
+test_probe_repl=
y_roundtrip(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    str=
uct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    struct oob_probe_reply in=
 =3D {
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
+/* Reading a TLV header must fail =
when the buffer holds less data than a
+ * complete 4-byte header (empty, o=
r only the type field), rather than read
+ * past the available data=2E */
=
+static void
+test_tlv_header_truncated(void **state)
+{
+    struct gc_are=
na gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+ =
   struct ctrl_msg_tlv_header hdr;
+
+    /* empty buffer */
+    assert_fa=
lse(ctrl_msg_tlv_read_header(&buf, &hdr));
+
+    /* only the type field pr=
esent, no length */
+    assert_true(buf_write_u16(&buf, OOB_TLV_PROBE_PARA=
METER));
+    assert_false(ctrl_msg_tlv_read_header(&buf, &hdr));
+
+    gc=
_free(&gc);
+}
+
+int
+main(void)
+{
+    openvpn_unit_test_setup();
+    c=
onst struct CMUnitTest tests[] =3D {
+        cmocka_unit_test(test_probe_p=
arameter_roundtrip),
+        cmocka_unit_test(test_probe_reply_roundtrip),=

+        cmocka_unit_test(test_probe_reply_wire_format),
+        cmocka_u=
nit_test(test_probe_parameter_forward_compat),
+        cmocka_unit_test(te=
st_probe_parameter_too_short),
+        cmocka_unit_test(test_find_tlv_valu=
e_truncated),
+        cmocka_unit_test(test_tlv_header_truncated),
+    };=

+
+    return cmocka_run_group_tests_name("oob tests", tests, NULL, NULL);=

+}

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c8d302ac57=
c5603d622a7be14be369437388268
Gerrit-Change-Number: 1741
Gerrit-PatchSet: 1=
2
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
flichtenheld <frank@lichtenheld=2Ecom>

--HjFreasUlF0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>stipa <strong>uplo=
aded patch set #12</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">oob: Add control message TLV encoding (P_CONTROL_OOB_V1)<br><br>Out-o=
f-band control messages carry control data but belong to no session, so a<b=
r>client can ask a server about itself before connecting=2E Reserve opcode =
12 for<br>them and add the codec for the two messages the probe needs, SERV=
ER_PROBE and<br>PROBE_REPLY=2E<br><br>The spec uses the same TLV framing fo=
r all its control messages, not just the<br>out-of-band ones, so the messag=
e-type header, the TLV header and the TLV scan go<br>into their own control=
_msg=2Ec/h; oob=2Ec keeps the OOB message and TLV types=2E<br><br>P_LAST_OP=
CODE becomes 12, and opcode_valid_in_session() replaces the plain range<br>=
check because OOB opcodes are answered statelessly and are never legal on a=
n<br>established session=2E<br><br>See the OOB control message section of t=
he wire protocol specification<br>(openvpn-rfc PR #30)=2E<br><br>Change-Id:=
 I1c8d302ac57c5603d622a7be14be369437388268<br>Signed-off-by: Lev Stipakov &=
lt;lev@openvpn=2Enet&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Make=
file=2Eam<br>A src/openvpn/control_msg=2Ec<br>A src/openvpn/control_msg=2Eh=
<br>A src/openvpn/oob=2Ec<br>A src/openvpn/oob=2Eh<br>M src/openvpn/ssl=2Ec=
<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>M tests/unit_=
tests/openvpn/Makefile=2Eam<br>A tests/unit_tests/openvpn/test_oob=2Ec<br>1=
1 files changed, 756 insertions(+), 4 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/174=
1/12</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><sp=
an>index 6eb5954=2E=2Efbc69f0 100644</span><br><span>--- a/CMakeLists=2Etxt=
</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -445,6 +445,8 @@=
</span><br><span>     src/openvpn/console=2Ec</span><br><span>     src/open=
vpn/console_builtin=2Ec</span><br><span>     src/openvpn/console=2Eh</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/control_ms=
g=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvp=
n/control_msg=2Eh</span><br><span>     src/openvpn/crypto=2Ec</span><br><sp=
an>     src/openvpn/crypto=2Eh</span><br><span>     src/openvpn/crypto_back=
end=2Eh</span><br><span>@@ -523,6 +525,8 @@</span><br><span>     src/openvp=
n/multi_io=2Ec</span><br><span>     src/openvpn/occ=2Ec</span><br><span>   =
  src/openvpn/occ=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    src/openvpn/oob=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    src/openvpn/oob=2Eh</span><br><span>     src/openvpn/openvpn=2Ec<=
/span><br><span>     src/openvpn/openvpn=2Eh</span><br><span>     src/openv=
pn/openvpn_win32_resources=2Erc</span><br><span>@@ -677,6 +681,7 @@</span><=
br><span>         &quot;test_mbuf&quot;</span><br><span>         &quot;test=
_misc&quot;</span><br><span>         &quot;test_ncp&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        &quot;test_oob&quot;</span><b=
r><span>         &quot;test_options_parse&quot;</span><br><span>         &q=
uot;test_packet_id&quot;</span><br><span>         &quot;test_pkt&quot;</spa=
n><br><span>@@ -881,6 +886,13 @@</span><br><span>         src/openvpn/sessi=
on_id=2Ec</span><br><span>         )</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    target_sources(test_oob PRIVATE</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests=
/openvpn/mock_get_random=2Ec</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        src/openvpn/control_msg=2Ec</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        src/openvpn/oob=2Ec</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/session_id=2Ec</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        )</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     target_sources=
(test_pkt PRIVATE</span><br><span>         tests/unit_tests/openvpn/mock_wi=
n32_execve=2Ec</span><br><span>         src/openvpn/argv=2Ec</span><br><spa=
n>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span>=
<br><span>index 7fd12b4=2E=2E5e6b4d9 100644</span><br><span>--- a/src/openv=
pn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br>=
<span>@@ -53,6 +53,7 @@</span><br><span> 	common=2Eh \</span><br><span> 	co=
mp=2Ec comp=2Eh compstub=2Ec \</span><br><span> 	comp-lz4=2Ec comp-lz4=2Eh =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	control_msg=2Ec c=
ontrol_msg=2Eh \</span><br><span> 	crypto=2Ec crypto=2Eh crypto_backend=2Eh=
 \</span><br><span> 	crypto_openssl=2Ec crypto_openssl=2Eh \</span><br><spa=
n> 	crypto_mbedtls_legacy=2Ec crypto_mbedtls_legacy=2Eh \</span><br><span>@=
@ -107,6 +108,7 @@</span><br><span> 	pkcs11=2Ec pkcs11=2Eh pkcs11_backend=
=2Eh \</span><br><span> 	pkcs11_openssl=2Ec \</span><br><span> 	pkcs11_mbed=
tls=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	oob=2Ec o=
ob=2Eh \</span><br><span> 	openvpn=2Ec openvpn=2Eh \</span><br><span> 	opti=
ons=2Ec options=2Eh \</span><br><span> 	options_show=2Ec options_show=2Eh \=
</span><br><span>diff --git a/src/openvpn/control_msg=2Ec b/src/openvpn/con=
trol_msg=2Ec</span><br><span>new file mode 100644</span><br><span>index 000=
0000=2E=2E6d3b3bf</span><br><span>--- /dev/null</span><br><span>+++ b/src/o=
penvpn/control_msg=2Ec</span><br><span>@@ -0,0 +1,102 @@</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP net=
works</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 over a single TCP/UDP port, with support for SSL/TLS-based</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *             session authenticati=
on and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *             packet encryption, packet authentication, and</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenV=
PN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  This program is free software; you can redistribute it and/or modify</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms o=
f the GNU General Public License version 2</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in th=
e hope that it will be useful,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty =
of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILI=
TY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more deta=
ils=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a=
 copy of the GNU General Public License along</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://ww=
w=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ctrl_msg_read_header(struct buffer *buf, uint16_t expected_msg_t=
ype)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int msg_type =3D buf_read_u16=
(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ms=
g_type &gt;=3D 0 &amp;&amp; (uint16_t)msg_type =3D=3D expected_msg_type;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ctrl_msg_tlv_write_header(struct buffer *buf, uint16_t type, bool optional=
, uint16_t value_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t fie=
ld =3D type &amp; CTRL_MSG_TLV_TYPE_MASK;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (optional)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        field |=3D CTRL_MSG_TLV_OPTIONAL_FLAG;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return buf_write_u16(buf, field) &amp;&amp; buf_wri=
te_u16(buf, value_len);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ctrl_msg_tlv_read_header(struct buffer *buf, str=
uct ctrl_msg_tlv_header *hdr)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
field =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (field &lt; 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int len =3D=
 buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (len &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt;type =3D (uint=
16_t)(field &amp; CTRL_MSG_TLV_TYPE_MASK);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    hdr-&gt;optional =3D (field &amp; CTRL_MSG_TLV_O=
PTIONAL_FLAG) !=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    hdr-&gt;value_len =3D (uint16_t)len;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_find_tlv(struct buffer =
*payload, uint16_t wanted_type, struct buffer *value)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct ctrl_msg_tlv_header hdr;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool found =3D false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    while (ctrl_msg_tlv_read_header=
(payload, &amp;hdr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Ta=
ke the value out of payload=2E This validates that the header&#39;s</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+         * length is really=
 there and advances past it in one step, so the TLV</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * we are looking for and the one=
s we skip are bounds-checked alike=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        uint8_t *v =3D buf_read_alloc(payload, hdr=2Ev=
alue_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (!v)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            return fals=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (hdr=2Etype =3D=
=3D wanted_type)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (!found)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 buf_set_read(value, v, hdr=2Evalue_len);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                found =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        else if (!hdr=2Eoptional)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            /* A TLV we do not understand that the =
sender did not mark optional</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+             * carries something it requires us to act on, so the =
message as a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
      * whole is not ours to interpret=2E This is why the scan continues</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+             * past th=
e wanted type: such a TLV invalidates the message wherever</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+             * in the sequence it si=
ts=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return found;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/=
src/openvpn/control_msg=2Eh b/src/openvpn/control_msg=2Eh</span><br><span>n=
ew file mode 100644</span><br><span>index 0000000=2E=2Eb98dce5</span><br><s=
pan>--- /dev/null</span><br><span>+++ b/src/openvpn/control_msg=2Eh</span><=
br><span>@@ -0,0 +1,106 @@</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVP=
N -- An application to securely tunnel IP networks</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, w=
ith support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *             session authentication and key exchange,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encrypt=
ion, packet authentication, and</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *             packet compression=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free softwar=
e; you can redistribute it and/or modify</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Licen=
se version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as =
published by the Free Software Foundation=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  This program is distributed in the hope that it will be useful,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY=
 WARRANTY; without even the implied warranty of</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR=
 PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  GNU General Public License for more details=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Framing shared by the TLV-based control messages of the wire protocol=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Such a message payload starts with a=
 16-bit message type, followed by a</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * sequence of TLV entries=2E Each TLV starts with a 4-byte=
 header: a 16-bit field</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * whose most significant bit is the &quot;optional&quot; flag and whos=
e remaining 15 bits</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * are the type, followed by a 16-bit length giving the size of the value t=
hat</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * follows the h=
eader=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * The message-type and TLV-=
type values themselves are specific to the message</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * family carried (out-of-band messages defi=
ne theirs in oob=2Eh), so only the</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * framing lives here=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef CONTROL=
_MSG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CONTR=
OL_MSG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* TLV header bit layout of the first=
 16-bit field */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine CTRL_MSG_TLV_OPTIONAL_FLAG 0x8000</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define CTRL_MSG_TLV_TYPE_MASK     0x7fff</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* The header every TLV carries: the 15-bit type and =
optional flag packed into</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * the first 16-bit field, then the length of the value that follows=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct ctrl_m=
sg_tlv_header</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t type;      =
/**&lt; the 15-bit TLV type */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    bool optional;      /**&lt; value of the optional flag */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t value_len=
; /**&lt; length of the value following the header */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read and verify=
 a message-type header from buf, advancing past it=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param buf                buffer positioned at the mess=
age payload</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m expected_msg_type  the message type the payload must carry</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @return true if a message type =
was read and equals expected_msg_type,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *         false on a short buffer or a mismatching type=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_read_header(struct=
 buffer *buf, uint16_t expected_msg_type);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a T=
LV header (type + optional flag + value length) to buf=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @return true on success, false if buf has insuffici=
ent space=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_write=
_header(struct buffer *buf, uint16_t type, bool optional,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                               uint16=
_t value_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Read a TLV header from buf, advancing=
 past it=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf  buffer pos=
itioned at the TLV header</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param hdr  filled with the type, optional flag and value length o=
n success</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return=
 true on success, false if there are not enough bytes for a header=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_read_header(struct buff=
er *buf, struct ctrl_msg_tlv_header *hdr);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Scan payl=
oad for the first TLV of type wanted_type, skipping any other (e=2Eg=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * future) TLV type tha=
t is marked optional=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The whole =
sequence is walked, including the part after the wanted type: a TLV</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * we do not understand and=
 that is not marked optional invalidates the message</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * wherever it sits, and rejecting it is =
the point of the remaining scan=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 On success value covers exactly the found TLV&#39;s value bytes=2E The len=
gth from</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * each TLV=
 header is validated against payload as the scan goes, so the whole</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * value is guaranteed to b=
e present; a header claiming more bytes than payload</span><br><span style=
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
0644</span><br><span>index 0000000=2E=2E0a9a4bb</span><br><span>--- /dev/nu=
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
                             *   0 means &quot;defer to the client&#39;s se=
tting&quot; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    u=
int16_t connect_lifetime;         /**&lt; seconds the reply stays valid as =
the handshake reset */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    uint32_t flags;                    /**&lt; server behaviour flags */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Write a complete probe parameter TLV (header + value) to buf=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+bool oob_probe_parameter_write(struct bu=
ffer *buf, const struct oob_probe_parameter *p);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Rea=
d a probe parameter TLV value from buf=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * buf must cover exactly the TLV&#39;s value, as returned by ctrl_msg=
_find_tlv()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Tr=
ailing bytes beyond the fields understood here are ignored, so a longer</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * value from a future =
version still parses=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return tr=
ue on success, false if buf is shorter than the mandatory fields=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool oob_probe_parameter_read(struct buff=
er *buf, struct oob_probe_parameter *p);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a com=
plete probe reply TLV (header + value) to buf=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+bool oob_probe_reply_write(struct buffer *buf, const struct oo=
b_probe_reply *r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Read a probe reply TLV value from=
 buf=2E See oob_probe_parameter_read() for the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * calling convention=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+bool oob_probe_reply_read(struct buffer *buf, struct oob_=
probe_reply *r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* OOB_H */</sp=
an><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><=
br><span>index 5f5d1f9=2E=2Ec8fc465 100644</span><br><span>--- a/src/openvp=
n/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -367=
6,7 +3676,7 @@</span><br><span>     struct session_id sid; /* remote sessio=
n ID */</span><br><span> </span><br><span>     /* verify legal opcode */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (op &lt; P_FIRST_=
OPCODE || op &gt; P_LAST_OPCODE)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (!opcode_valid_in_session(op))</span><br><span>     {</=
span><br><span>         if (op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V1 || op =
=3D=3D P_CONTROL_HARD_RESET_SERVER_V1)</span><br><span>         {</span><br=
><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span=
><br><span>index 6a6d9f9=2E=2E39cb648 100644</span><br><span>--- a/src/open=
vpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><sp=
an>@@ -167,7 +167,7 @@</span><br><span>                    bool prepend_ack=
)</span><br><span> {</span><br><span>     ASSERT(ks-&gt;key_id &gt;=3D 0 &a=
mp;&amp; ks-&gt;key_id &lt;=3D P_KEY_ID_MASK);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    ASSERT(opcode &gt;=3D 0 &amp;&amp; opcode &lt;=
=3D P_LAST_OPCODE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ASSERT(opcode_valid_in_session(opcode));</span><br><span>     uint8_t h=
eader =3D (uint8_t)(ks-&gt;key_id | (opcode &lt;&lt; P_OPCODE_SHIFT));</spa=
n><br><span> </span><br><span>     /* Workaround for Softether servers=2E S=
oftether has a bug that it only</span><br><span>diff --git a/src/openvpn/ss=
l_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index 03e8930=2E=2Ed46b=
8c5 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>++=
+ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -58,11 +58,53 @@</span><br><=
span>  * like P_CONTROL_HARD_RESET_CLIENT_V3 */</span><br><span> #define P_=
CONTROL_WKC_V1 11</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-/* define the range of legal opcodes</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* Out-of-band control message that does not=
 belong to an established</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * control channel session (e=2Eg=2E a server probe)=2E Inherently un=
reliable:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * there i=
s no protocol-level retransmission=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * It is not legal on an established session; see opcode_valid_in_session(=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * below=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define P_CONTROL_OOB_V=
1 12</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* define the range of defined opc=
odes, in- and out-of-band=2E Note this is not</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * the set of opcodes legal on an established ses=
sion; see</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * opcode_=
valid_in_session()=2E</span><br><span>  * Since we do no longer support key=
-method 1 we consider</span><br><span>  * the v1 op codes invalid */</span>=
<br><span> #define P_FIRST_OPCODE 3</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define P_LAST_OPCODE  11</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define P_LAST_OPCODE  12</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static inline bool</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+opcode_is_oob(int op)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 op =3D=3D P_CONTROL_OOB_V1;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Return true if op may occur on an establi=
shed control-channel session=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Ou=
t-of-band opcodes may not=2E They are answered statelessly on the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * new-connection path, and b=
eing rejected here is a permanent property rather</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * than a handler that is still missing:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  - an OOB message carries its TLV payl=
oad directly, with no reliability or</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *    ACK fields (see tls_wrap_oob_standalone()), whereas =
the established-session</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *    path parses an ACK array and a control packet-id before anything =
else=2E The</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    pa=
yload is chosen by the sender and session ids are plaintext on the wire,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    so those bytes c=
an be crafted into a valid ACK array, forging ACKs into a</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *    live control channel and stalli=
ng a handshake or rekey=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  - nothing on that path parses an OOB payload, so there is nothin=
g to gain by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    a=
ccepting one=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This cannot be exp=
ressed as an opcode range: the inband CONTROL_DATA_V1 of the</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * wire protocol is legal on an es=
tablished session, so the OOB opcodes sit</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * between legal ones=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static inline bool</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+opcode_valid_in_session(int op)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return op &gt;=3D P_FIRST_OPCODE &amp;&amp; op &lt;=3D P_LAST_OPCOD=
E &amp;&amp; !opcode_is_oob(op);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span> </span><br><span> /*</span><br><span>  * De=
fine number of buffers for send and receive in the reliability layer=2E</sp=
an><br><span>@@ -256,6 +298,9 @@</span><br><span>         case P_CONTROL_WK=
C_V1:</span><br><span>             return &quot;P_CONTROL_WKC_V1&quot;;</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   case P_CONTROL_OOB_V1:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            return &quot;P_CONTROL_OOB_V1&quot;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         case P_ACK_V1:=
</span><br><span>             return &quot;P_ACK_V1&quot;;</span><br><span>=
 </span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tes=
ts/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 5954902=2E=2E9f6b=
865 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</sp=
an><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@=
@ -14,6 +14,7 @@</span><br><span> 	ncp_testdriver \</span><br><span> 	mbuf_=
testdriver \</span><br><span> 	misc_testdriver \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	oob_testdriver \</span><br><span> 	options_pa=
rse_testdriver \</span><br><span> 	packet_id_testdriver \</span><br><span> =
	pkt_testdriver \</span><br><span>@@ -153,6 +154,20 @@</span><br><span> 	$(=
top_srcdir)/src/openvpn/win32-util=2Ec \</span><br><span> 	$(top_srcdir)/sr=
c/openvpn/session_id=2Ec</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+oob_testdriver_CFLAGS  =3D \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdir)/include -I$(top_srcdir)/=
src/compat -I$(top_srcdir)/src/openvpn \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	@TEST_CFLAGS@</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+oob_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+oob_testdriver_SOURCES =3D test_oob=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg=2Ec=
 mock_msg=2Eh test_common=2Eh \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	mock_get_random=2Ec \</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/control_msg=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir=
)/src/openvpn/oob=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/session_id=2Ec \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvp=
n/win32-util=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> pkt_testdriver_CFLAGS  =3D \</span><br><span> 	-I$(top_srcdi=
r)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><=
br><span> 	@TEST_CFLAGS@</span><br><span>diff --git a/tests/unit_tests/open=
vpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>ne=
w file mode 100644</span><br><span>index 0000000=2E=2Eaa4eb23</span><br><sp=
an>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2E=
c</span><br><span>@@ -0,0 +1,277 @@</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  OpenVPN -- An application to securely tunnel IP networks</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UD=
P port, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             session authentication and key exchange,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packe=
t encryption, packet authentication, and</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             packet compression=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@open=
vpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is fre=
e software; you can redistribute it and/or modify</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Pub=
lic License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  as published by the Free Software Foundation=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is distributed in the hope that it will b=
e useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WI=
THOUT ANY WARRANTY; without even the implied warranty of</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A P=
ARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  GNU General Public License for more details=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU Gene=
ral Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/license=
s/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &lt;stdarg=2Eh&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &lt;stddef=2Eh&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common=2Eh&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* Write a probe parameter TLV an=
d read it back; fields must survive the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * round trip and the whole buffer must be consumed=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_parameter_roun=
dtrip(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_aren=
a gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const struct oob_probe_parameter in =3D {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        =2Etimestamp =3D 0x0123456=
789abcdefULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  =2Eflags =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(oob_probe_parameter_write(&amp;buf, &amp;in));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* header (4) + value (12) */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;bu=
f), 4 + OOB_PROBE_PARAMETER_LEN);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* the header codec, read from a copy so the scan below still sees it */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer peek =
=3D buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(ctrl_msg_tlv_read_header(&amp;peek, &amp;hdr));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=
=2Etype, OOB_TLV_PROBE_PARAMETER);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_false(hdr=2Eoptional);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Evalue_len, OOB_PROB=
E_PARAMETER_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer val=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(=
ctrl_msg_find_tlv(&amp;buf, OOB_TLV_PROBE_PARAMETER, &amp;value));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&a=
mp;value), OOB_PROBE_PARAMETER_LEN);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct oob_probe_parameter out =3D { 0 };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(oob_probe_parameter_read(&amp;value=
, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_true(in=2Etimestamp =3D=3D out=2Etimestamp);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Eflags, out=2Eflags)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the scan co=
nsumed header and value alike */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Write a probe rep=
ly TLV and read it back=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+test_probe_reply_roundtrip(void **state)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply in =3D {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Epriority =
=3D 10,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Ew=
eight =3D 100,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   =2Econnect_lifetime =3D 30,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        =2Eflags =3D 1,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        =2Emax_latency_diff =3D 25,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    memcpy(in=2Epeer_session_id=2Eid, &quot;ABCDEFGH&quot=
;, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe=
_reply_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 4 + OOB_PROBE_REPLY_LEN)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct buffer peek =3D buf;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_h=
eader hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_true(ctrl_msg_tlv_read_header(&amp;peek, &amp;hdr));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, OOB_TLV=
_PROBE_REPLY);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(hdr=2Evalue_len, OOB_PROBE_REPLY_LEN);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct buffer value;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_true(ctrl_msg_find_tlv(&amp;buf, OOB_TLV_PR=
OBE_REPLY, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob=
_probe_reply out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(oob_probe_reply_read(&amp;value, &amp;out));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(in=
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
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The probe reply wire f=
ormat is locked to the spec&#39;s field order</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * (priority, weight, max_latency_diff, connect_l=
ifetime, flags), big-endian=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+test_probe_reply_wire_format(void **state)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply in =
=3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Epri=
ority =3D 10,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  =2Eweight =3D 100,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        =2Econnect_lifetime =3D 30,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        =2Eflags =3D 1,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        =2Emax_latency_diff =3D 25,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    memcpy(in=2Epeer_session_id=2Eid, &quot;ABCDEFG=
H&quot;, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob=
_probe_reply_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const uint8_t expected[] =3D {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        0x02,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        0x01, /* TLV type 0x201 (not optional) */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        0x00,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        0x14, /* TLV value length =3D 20 =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &#39;A&#3=
9;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &#39;B&#=
39;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &#39;C&=
#39;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &#39;D=
&#39;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &#39;=
E&#39;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &#39=
;F&#39;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &#3=
9;G&#39;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &#=
39;H&#39;,  /* peer_session_id */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        0x00,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        0x0a, /* priority =3D 10 */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        0x00,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        0x64, /* weight =3D 100 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        0x00,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        0x19, /* max_latency_diff =3D 25 */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x00,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        0x1e, /* connect_life=
time =3D 30 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x0=
0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x00,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x01, /* flags =
=3D 1 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLE=
N(&amp;buf), sizeof(expected));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_memory_equal(BPTR(&amp;buf), expected, sizeof(expect=
ed));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* A TLV with a longer-than-known value must still parse: the known =
fields are</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * read a=
nd the trailing bytes are skipped (forward compatibility)=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+test_probe_parameter_forward_compat(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D =
gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const uint16_t extended_len =3D OOB_PROBE_PARAMETER_LEN + 4;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_=
tlv_write_header(&amp;buf, OOB_TLV_PROBE_PARAMETER, false, extended_len));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_=
write_u32(&amp;buf, 0));          /* timestamp high */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, =
0xdeadbeef)); /* timestamp low */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0));          /* flag=
s */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(buf_write_u32(&amp;buf, 0x11223344)); /* unknown trailing field */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_find_tlv(&amp;bu=
f, OOB_TLV_PROBE_PARAMETER, &amp;value));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), extended_len);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_parameter out =3D=
 { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(oob_probe_parameter_read(&amp;value, &amp;out));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(out=2Etimestamp =3D=3D 0x=
deadbeefULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(out=2Eflags, 0);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* the unknown trailing field must have been consumed from =
the payload */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* A value shorter than the mandatory =
fields must be rejected, even when it</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * holds enough bytes for some of the individual fields t=
o read successfully=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+te=
st_probe_parameter_too_short(void **state)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* 4 of the 12 mandatory value byt=
es: too short for the timestamp, but</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * enough for a u32 read to succeed on its own */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_writ=
e_u32(&amp;buf, 0xdeadbeef));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t oob_probe_parameter out =3D { 0 };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_false(oob_probe_parameter_read(&amp;buf, &amp;o=
ut));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* A TLV header claiming more value bytes than the payload holds mus=
t be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rejected by =
the scan rather than reported as found -- for the TLV being</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * looked for as much as for one th=
at would merely be skipped=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+test_find_tlv_value_truncated(void **state)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* the wanted TLV declares 12 value bytes, only 4 are pr=
esent */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, =
OOB_TLV_PROBE_PARAMETER, false,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                          OOB_PROBE_PARAMETER_L=
EN));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(buf_write_u32(&amp;buf, 0xdeadbeef));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_false(ctrl_msg_find_tlv(&amp;buf, OOB_TLV_PR=
OBE_PARAMETER, &amp;value));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* sam=
e defect on a TLV that would be skipped: the scan must not walk past</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * the end of the payl=
oad looking for the next header */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct buffer buf2 =3D alloc_buf_gc(128, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_=
tlv_write_header(&amp;buf2, 0x7ff, false, 64));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf2, 0));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl=
_msg_find_tlv(&amp;buf2, OOB_TLV_PROBE_PARAMETER, &amp;value));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Reading=
 a TLV header must fail when the buffer holds less data than a</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * complete 4-byte header (empty=
, or only the type field), rather than read</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * past the available data=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+test_tlv_header_truncated(void **state)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D a=
lloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct c=
trl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* empty bu=
ffer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_f=
alse(ctrl_msg_tlv_read_header(&amp;buf, &amp;hdr));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* only the type field present, no length */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u16(&=
amp;buf, OOB_TLV_PROBE_PARAMETER));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_false(ctrl_msg_tlv_read_header(&amp;buf, &amp;hd=
r));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+main(void)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_test_setup();</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct CMUnitTes=
t tests[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    cmocka_unit_test(test_probe_parameter_roundtrip),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_reply=
_roundtrip),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 cmocka_unit_test(test_probe_reply_wire_format),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_parameter_=
forward_compat),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     cmocka_unit_test(test_probe_parameter_too_short),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_find_tlv_v=
alue_truncated),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     cmocka_unit_test(test_tlv_header_truncated),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return cmocka_run_group_tests_name(&quot;oob tests&quot;, tests, NULL, NU=
LL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1741?usp=3Demail">change 1741</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
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
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D=
"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--HjFreasUlF0=--


--===============7100853498547641514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7100853498547641514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7100853498547641514==--

