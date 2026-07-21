Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4ECC44532
	for <openvpn-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2gayI1IXaTxEWqU2WGifWaOPEzzz0VipBaG9R4Xah08=; b=LsehRLp/0PbcRi5Jx8X3IPxTad
	fJpBoOO3MZvyrcvmiNWnuLGdSgyfVvI6UaALyM/t1E8NdoIzkJAoKi7TdVZZyY5j6H/aIhG53ax6Z
	KbeMRmkAu4HXMpWqfvkz+sno90a5/l0ZLZ0uecbSSHNpavoHib4xgGH0M3Nym4FUo9oA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wm9hS-0006UD-1Y;
	Tue, 21 Jul 2026 12:35:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wm9hQ-0006U6-VD
 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 12:35:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=pkCHEtCVZrhalgxc9gfCEmSk0sKLiuOioDuPC+AGsMw=; b=dgo+Vw509iSzdaaeir8tLZABnE
 PKZq/9Bo7Ykt56//d3eZnmXsTk7HxXUwLO4VqqWAtHP47qlsj1V3u4HWR6rzN5wZKiTApgBe0YNDp
 xX3kD/HFzNSMEzQJbznDqjPwduOJqkWRiDAxKNqscKYOqhcE0lblp5XJLhTltc9Pd2C4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pkCHEtCVZrhalgxc9gfCEmSk0sKLiuOioDuPC+AGsMw=; b=I
 H20xEDT+kkds1mOwPIXKJJ3J3DhuSnVS/yBkq6AQtzKYxMYdjiVSHfdTLy9XBYDqTi+fqRrBDcGDk
 LtO3+GDnLxDVNMrIRgNXK+j5YTHOl3ruvip6BSlX59RplpcjcmIStiX+5mGBn0yO9SbZjYnEfRjSa
 4igko7//R90paF8g=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wm9hM-0001k9-OU for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 12:35:53 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so1628216f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 21 Jul 2026 05:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784637337; x=1785242137; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pkCHEtCVZrhalgxc9gfCEmSk0sKLiuOioDuPC+AGsMw=;
 b=gfgS03M1dqLNVfuQf6J0JBxfD2A0N6yIjZEmXf4E3Aw0a0hPpneilGuy0Cne4da1Ho
 Kh1us8zTjT1OBNPXmgs95F3P857dUxlKr8qOEOGFn7ZLKANCxunc1xIC2stalGlzd61C
 kRtxg2QDKCSDcpquZfbqvY1ncxxJFKs1I19I7ll80S04lBQs+4habrBQ0+PjMabCe5KS
 88UHz0U7lkt5WJOkxI2yVx25o/bvBSYg89q1xnmjpQa74sj8z5tbR50K8Jmq5FyczuoE
 aI5XqNtDA/XKa023AJ+P1UIMny2cNKHakCFLZwKrhQA2ESOEXLhCfwNuGaXxvlb/TQ3t
 M4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784637337; x=1785242137;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pkCHEtCVZrhalgxc9gfCEmSk0sKLiuOioDuPC+AGsMw=;
 b=ftd/LiegeEJAZH+QidjOWxO5ec/0T4i46HafoDswS8YKx9wOyzLW91jPpX3mlC6P16
 4XcDJ5fV7g5EZPYXQyTzzFOWl30IA30CUIDyac7j7pdy64zpFLF2g654HRWIV19ua9zU
 aAQDaiDwF/f1Op6+1y2lrRa0PAHRDiqBr40RvAv+Unb2IG13nbLkjz7dKIcUta94WceI
 BlMjtjKIYo/XpJSqpKxOZIcqt+g+q9T8g91VdJ7a70uDiAU41SBIWtIuh2HaNHrWLyvd
 hKImrNPCCuPtIS5L0Cb9xBin3Ie198ZXqCCjtNOidoMiRj1eWKCnzYjHmzfdNFwplr0C
 SZ3w==
X-Gm-Message-State: AOJu0YygIn5UNQYX3NSVjYGp6/2yUgO89/FEIU8/nHHedsBIJ1KEaXib
 CzR1aNJ7Rj1qRbvQHrrXQNWBX/ahpeMfN88bUW4yaFV8A/ZmTXtSspiCdMP7g57vcbF8NoZqzk3
 OaWctc2NoLL1Il80+eyk+z5BqXfyKvYQfkCtzh6AglnrzRchquyakRTLiwkpWHDfG2erDeWTBzT
 gcRozEyw==
X-Gm-Gg: AfdE7ckwYsghDx3Ucq2R9EsxFWHI07zgCA8Oetnc91gUYINpMHcZPrX3SJop3jw0j2/
 CE7og6Obs5X4NajQn/ijC4e4ui+Ul0Amlzir8/9MRuBtwYs7qlvYKCU9zcIByS+YA8GeDkmBcKe
 lVQMMw0yFi2lQM7IVwYgPcut9SOdl8mwjD9uFEqrEqRdehb2E1AlHUQuKPNPUdtqXkgxcb723Hx
 9P4G/V/yA5/wNZlHy+aOVtkoCVblxZXtiKeD8bQYMsAh1SLk9i5Tus5AyQZF+yUdwhjarxh0W8+
 TWAylS7lOyzc8XIciDhMx+1gJFkIHcrZrpy1WgEhWkzSgAEZED8upTIb7YXe99zRWr16VkN5DiB
 izUfJuYkS1htR78h5mOmG2sFiCI0KcGMAhG4lfanfa44Jtdrx2nuvKiVxJYQjJbsLsBxVAIVKQ4
 HFT/NxeE77yUHKfQu96W8An3/zAWEW9swAp5sWbVkzwna5BNEIHxzOfVH5myKh0YFedofLlskJf
 ER9ZgicNtu6jmwmjaujXrqPw2DPJ74blieUDNs5Grp0NFJ/73tCJndHBoOK/u07kKvo
X-Received: by 2002:a05:600c:4753:b0:493:bc4b:b8c with SMTP id
 5b1f17b1804b1-4954a413024mr199389005e9.38.1784637336714; 
 Tue, 21 Jul 2026 05:35:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49ce4sm39170525f8f.8.2026.07.21.05.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 05:35:35 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 21 Jul 2026 12:35:24 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 4e332039301865b4061702bc2d6b622d0691ee60
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5dd1bbff4d21b25503121a0b89ee2460de2be4f3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wm9hM-0001k9-OU
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
Content-Type: multipart/mixed; boundary="===============8779008326919429205=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8779008326919429205==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mYrZDn7ZPls="; charset=UTF-8

--mYrZDn7ZPls=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

Hello flichtenhe=
ld, plaisthos, 

I'd like you to reexamine a change=2E Please visit

    ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail

to look at the ne=
w patch set (#8)=2E

The change is no longer submittable: checks~ChecksSubm=
itRule is unsatisfied now=2E


Change subject: oob: Add control message TLV=
 encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

oob: Add control message TLV encoding (P_CONTROL_OOB_V1)

=
Reserve opcode 12 (P_CONTROL_OOB_V1) for out-of-band control messages and
a=
dd encoding/decoding for the SERVER_PROBE / PROBE_REPLY TLVs used for
serve=
r latency checks:

  - probe_parameter (0x200): client timestamp + capabili=
ty flags
  - probe_reply    (0x201): echoed session id, DNS-SRV style prior=
ity and
                            weight, connect_lifetime and behaviour =
flags

Each TLV has a 4-byte header (15-bit type plus an optional flag, the=
n a
16-bit value length)=2E Readers enforce the minimum value length and sk=
ip
trailing bytes they do not understand, so the format stays forward
compa=
tible and multi-TLV framing resynchronises=2E

P_LAST_OPCODE is deliberatel=
y left at 11: opcode 12 is not yet accepted by
tls_pre_decrypt()=2E The leg=
al-opcode range is widened together with the
receive handler in a follow-up=
, which also wires oob=2Ec into the openvpn
build=2E For now the codec is e=
xercised only by the unit tests=2E

See the OOB control message section of =
the OpenVPN wire protocol
specification (openvpn-rfc PR #30)=2E

Change-Id:=
 I1c8d302ac57c5603d622a7be14be369437388268
Signed-off-by: Lev Stipakov <lev=
@openvpn=2Enet>
---
M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
A src/op=
envpn/oob=2Ec
A src/openvpn/oob=2Eh
M src/openvpn/ssl_pkt=2Eh
M tests/unit_=
tests/openvpn/Makefile=2Eam
A tests/unit_tests/openvpn/test_oob=2Ec
7 files=
 changed, 567 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/41/1741/8

diff --git a/CMakeLists=2E=
txt b/CMakeLists=2Etxt
index 7473f15=2E=2Ef9a57ee 100644
--- a/CMakeLists=
=2Etxt
+++ b/CMakeLists=2Etxt
@@ -520,6 +520,8 @@
     src/openvpn/multi_io=
=2Ec
     src/openvpn/occ=2Ec
     src/openvpn/occ=2Eh
+    src/openvpn/oob=
=2Ec
+    src/openvpn/oob=2Eh
     src/openvpn/openvpn=2Ec
     src/openvpn=
/openvpn=2Eh
     src/openvpn/openvpn_win32_resources=2Erc
@@ -667,6 +669,7=
 @@
         "test_mbuf"
         "test_misc"
         "test_ncp"
+        =
"test_oob"
         "test_options_parse"
         "test_packet_id"
        =
 "test_pkt"
@@ -858,6 +861,12 @@
         src/openvpn/session_id=2Ec
      =
   )
 
+    target_sources(test_oob PRIVATE
+        tests/unit_tests/openv=
pn/mock_get_random=2Ec
+        src/openvpn/oob=2Ec
+        src/openvpn/se=
ssion_id=2Ec
+        )
+
     target_sources(test_pkt PRIVATE
         tes=
ts/unit_tests/openvpn/mock_win32_execve=2Ec
         src/openvpn/argv=2Ec
d=
iff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index ff8=
cc54=2E=2Eb4b1b92 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/=
Makefile=2Eam
@@ -106,6 +106,7 @@
 	pkcs11=2Ec pkcs11=2Eh pkcs11_backend=2E=
h \
 	pkcs11_openssl=2Ec \
 	pkcs11_mbedtls=2Ec \
+	oob=2Ec oob=2Eh \
 	ope=
nvpn=2Ec openvpn=2Eh \
 	options=2Ec options=2Eh \
 	options_util=2Ec optio=
ns_util=2Eh \
diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
new fi=
le mode 100644
index 0000000=2E=2Eb01f4ee
--- /dev/null
+++ b/src/openvpn/o=
ob=2Ec
@@ -0,0 +1,168 @@
+/*
+ *  OpenVPN -- An application to securely tun=
nel IP networks
+ *             over a single TCP/UDP port, with support fo=
r SSL/TLS-based
+ *             session authentication and key exchange,
+ =
*             packet encryption, packet authentication, and
+ *            =
 packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@=
openvpn=2Enet>
+ *
+ *  This program is free software; you can redistribute=
 it and/or modify
+ *  it under the terms of the GNU General Public License=
 version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  Th=
is program is distributed in the hope that it will be useful,
+ *  but WITH=
OUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY=
 or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Li=
cense for more details=2E
+ *
+ *  You should have received a copy of the G=
NU General Public License along
+ *  with this program; if not, see <https:=
//www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "con=
fig=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "oob=2Eh"
+
+/**
+ *=
 Consume @p value_len bytes of TLV value, of which @p consumed have already=

+ * been read, ignoring (skipping) any trailing bytes that this version do=
es
+ * not understand=2E
+ *
+ * @param buf        buffer positioned after =
the @p consumed value bytes
+ * @param value_len  the TLV's declared value =
length
+ * @param consumed   number of value bytes already read from @p buf=

+ * @return true on success, false if fewer than @p consumed bytes were
+ =
*         declared or @p buf does not hold the trailing bytes=2E
+ */
+stat=
ic bool
+oob_skip_trailing(struct buffer *buf, uint16_t value_len, int cons=
umed)
+{
+    if (value_len < consumed)
+    {
+        return false;
+    =
}
+    return buf_advance(buf, value_len - consumed);
+}
+
+bool
+oob_msg_w=
rite_header(struct buffer *buf, uint16_t msg_type)
+{
+    return buf_write=
_u16(buf, msg_type);
+}
+
+bool
+oob_msg_read_header(struct buffer *buf, ui=
nt16_t expected_msg_type)
+{
+    int msg_type =3D buf_read_u16(buf);
+    =
return msg_type >=3D 0 && (uint16_t)msg_type =3D=3D expected_msg_type;
+}
+=

+bool
+oob_tlv_write_header(struct buffer *buf, uint16_t type, bool option=
al, uint16_t value_len)
+{
+    uint16_t field =3D type & OOB_TLV_TYPE_MASK=
;
+    if (optional)
+    {
+        field |=3D OOB_TLV_OPTIONAL_FLAG;
+   =
 }
+    return buf_write_u16(buf, field) && buf_write_u16(buf, value_len);
=
+}
+
+bool
+oob_tlv_read_header(struct buffer *buf, uint16_t *type, bool *o=
ptional, uint16_t *value_len)
+{
+    int field =3D buf_read_u16(buf);
+   =
 if (field < 0)
+    {
+        return false;
+    }
+    int len =3D buf_r=
ead_u16(buf);
+    if (len < 0)
+    {
+        return false;
+    }
+    *=
type =3D (uint16_t)(field & OOB_TLV_TYPE_MASK);
+    *optional =3D (field &=
 OOB_TLV_OPTIONAL_FLAG) !=3D 0;
+    *value_len =3D (uint16_t)len;
+    ret=
urn true;
+}
+
+bool
+oob_probe_parameter_write(struct buffer *buf, const s=
truct oob_probe_parameter *p)
+{
+    return oob_tlv_write_header(buf, OOB_=
TLV_PROBE_PARAMETER, false, OOB_PROBE_PARAMETER_LEN)
+           && buf_wri=
te_u64(buf, p->timestamp)
+           && buf_write_u32(buf, p->flags);
+}
+=

+bool
+oob_probe_parameter_read(struct buffer *buf, struct oob_probe_param=
eter *p, uint16_t value_len)
+{
+    if (value_len < OOB_PROBE_PARAMETER_LE=
N)
+    {
+        return false;
+    }
+    /* check each read separately:=
 a successful read sets ok back to true,
+     * so a single check at the e=
nd could mask an earlier failure */
+    bool ok =3D true;
+    p->timestam=
p =3D buf_read_u64(buf, &ok);
+    if (!ok)
+    {
+        return false;
+=
    }
+    p->flags =3D buf_read_u32(buf, &ok);
+    if (!ok)
+    {
+     =
   return false;
+    }
+    return oob_skip_trailing(buf, value_len, OOB_P=
ROBE_PARAMETER_LEN);
+}
+
+bool
+oob_probe_reply_write(struct buffer *buf, =
const struct oob_probe_reply *r)
+{
+    return oob_tlv_write_header(buf, O=
OB_TLV_PROBE_REPLY, false, OOB_PROBE_REPLY_LEN)
+           && session_id_w=
rite(&r->peer_session_id, buf)
+           && buf_write_u16(buf, r->priorit=
y)
+           && buf_write_u16(buf, r->weight)
+           && buf_write_u1=
6(buf, r->connect_lifetime)
+           && buf_write_u32(buf, r->flags)
+  =
         && buf_write_u16(buf, r->max_latency_diff);
+}
+
+bool
+oob_probe_=
reply_read(struct buffer *buf, struct oob_probe_reply *r, uint16_t value_le=
n)
+{
+    if (value_len < OOB_PROBE_REPLY_LEN)
+    {
+        return fals=
e;
+    }
+    if (!session_id_read(&r->peer_session_id, buf))
+    {
+    =
    return false;
+    }
+    int priority =3D buf_read_u16(buf);
+    int =
weight =3D buf_read_u16(buf);
+    int connect_lifetime =3D buf_read_u16(bu=
f);
+    if (priority < 0 || weight < 0 || connect_lifetime < 0)
+    {
+  =
      return false;
+    }
+    bool ok =3D true;
+    r->flags =3D buf_rea=
d_u32(buf, &ok);
+    int max_latency_diff =3D buf_read_u16(buf);
+    if (=
!ok || max_latency_diff < 0)
+    {
+        return false;
+    }
+    r->p=
riority =3D (uint16_t)priority;
+    r->weight =3D (uint16_t)weight;
+    r=
->connect_lifetime =3D (uint16_t)connect_lifetime;
+    r->max_latency_diff=
 =3D (uint16_t)max_latency_diff;
+    return oob_skip_trailing(buf, value_l=
en, OOB_PROBE_REPLY_LEN);
+}
diff --git a/src/openvpn/oob=2Eh b/src/openvpn=
/oob=2Eh
new file mode 100644
index 0000000=2E=2E6880665
--- /dev/null
+++ =
b/src/openvpn/oob=2Eh
@@ -0,0 +1,152 @@
+/*
+ *  OpenVPN -- An application =
to securely tunnel IP networks
+ *             over a single TCP/UDP port, =
with support for SSL/TLS-based
+ *             session authentication and k=
ey exchange,
+ *             packet encryption, packet authentication, and
=
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 Open=
VPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you c=
an redistribute it and/or modify
+ *  it under the terms of the GNU General=
 Public License version 2
+ *  as published by the Free Software Foundation=
=2E
+ *
+ *  This program is distributed in the hope that it will be useful=
,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  =
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Ge=
neral Public License for more details=2E
+ *
+ *  You should have received =
a copy of the GNU General Public License along
+ *  with this program; if n=
ot, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @file
+ * En=
coding/decoding of out-of-band (P_CONTROL_OOB_V1) control messages=2E
+ *
+=
 * An OOB message payload starts with a 16-bit message type (the 0x1xx spac=
e:
+ * SERVER_PROBE, PROBE_REPLY, =2E=2E=2E) followed by a sequence of TLV =
entries=2E
+ *
+ * Each TLV starts with a 4-byte header: a 16-bit field who=
se most significant
+ * bit is the "optional" flag and whose remaining 15 b=
its are the type (the
+ * 0x2xx space), followed by a 16-bit length giving =
the size of the value that
+ * follows the header=2E
+ */
+
+#ifndef OOB_H
=
+#define OOB_H
+
+#include "buffer=2Eh"
+#include "session_id=2Eh"
+
+/* OO=
B message types: the 16-bit value at the start of an OOB payload, before
+ =
* its TLV entries=2E Distinct from the TLV-type space (0x2xx); see the "Mes=
sages"
+ * table in the OOB section of the wire protocol spec=2E */
+#defin=
e OOB_MSG_SERVER_PROBE 0x100
+#define OOB_MSG_PROBE_REPLY  0x101
+
+/* TLV =
header bit layout of the first 16-bit field */
+#define OOB_TLV_OPTIONAL_FL=
AG 0x8000
+#define OOB_TLV_TYPE_MASK     0x7fff
+
+/* TLV types (see the OO=
B control message section of the wire protocol spec) */
+#define OOB_TLV_PR=
OBE_PARAMETER 0x200
+#define OOB_TLV_PROBE_REPLY     0x201
+
+/* Minimum on=
-wire value length (excluding the 4-byte TLV header) of each TLV:
+ * the s=
izes of its fixed fields in wire order (see the structs below)=2E The
+ * v=
alue may be longer for forward compatibility; trailing bytes that are not
+=
 * understood are ignored on read=2E */
+#define OOB_PROBE_PARAMETER_LEN \
=
+    ((uint16_t)(sizeof(uint64_t) /* timestamp */ + sizeof(uint32_t) /* fla=
gs */))
+#define OOB_PROBE_REPLY_LEN                                       =
              \
+    ((uint16_t)(SID_SIZE               /* peer_session_id =
*/                    \
+                + 3 * sizeof(uint16_t) /* priority=
, weight, connect_lifetime */ \
+                + sizeof(uint32_t)     /* =
flags */                              \
+                + sizeof(uint16_t)=
))   /* max_latency_diff */
+
+/* probe parameter TLV (sent by the client i=
n a SERVER_PROBE) */
+struct oob_probe_parameter
+{
+    uint64_t timestamp=
; /**< client clock as a UNIX timestamp */
+    uint32_t flags;     /**< cl=
ient capability flags, currently must be 0 */
+};
+
+/* probe reply TLV (se=
nt by the server in a PROBE_REPLY) */
+struct oob_probe_reply
+{
+    struc=
t session_id peer_session_id; /**< echoes the session id of the request */
=
+    uint16_t priority;                 /**< DNS-SRV style priority (lower =
is preferred) */
+    uint16_t weight;                   /**< DNS-SRV style=
 weight */
+    uint16_t connect_lifetime;         /**< seconds the probe s=
tays valid as a handshake shortcut */
+    uint32_t flags;                 =
   /**< server behaviour flags */
+    uint16_t max_latency_diff;         /=
**< advertised candidate-band margin in ms;
+                              =
          *   0 means "defer to the client's setting" */
+};
+
+/**
+ * Wri=
te an OOB message-type header (the 16-bit message type preceding the
+ * TL=
Vs) to @p buf=2E
+ *
+ * @return true on success, false if @p buf has insuf=
ficient space=2E
+ */
+bool oob_msg_write_header(struct buffer *buf, uint16=
_t msg_type);
+
+/**
+ * Read and verify an OOB message-type header from @p=
 buf, advancing past it=2E
+ *
+ * @param buf                buffer positio=
ned at the OOB message payload
+ * @param expected_msg_type  the message ty=
pe the payload must carry
+ * @return true if a message type was read and e=
quals @p expected_msg_type,
+ *         false on a short buffer or a mismat=
ching type=2E
+ */
+bool oob_msg_read_header(struct buffer *buf, uint16_t e=
xpected_msg_type);
+
+/**
+ * Write a TLV header (type + optional flag + va=
lue length) to @p buf=2E
+ *
+ * @return true on success, false if @p buf h=
as insufficient space=2E
+ */
+bool oob_tlv_write_header(struct buffer *buf=
, uint16_t type, bool optional, uint16_t value_len);
+
+/**
+ * Read a TLV =
header from @p buf, advancing past it=2E
+ *
+ * @param buf        buffer p=
ositioned at the TLV header
+ * @param type       set to the 15-bit TLV typ=
e
+ * @param optional   set to the value of the optional flag
+ * @param va=
lue_len  set to the declared value length
+ * @return true on success, fals=
e if there are not enough bytes for a header=2E
+ */
+bool oob_tlv_read_hea=
der(struct buffer *buf, uint16_t *type, bool *optional, uint16_t *value_len=
);
+
+/**
+ * Write a complete probe parameter TLV (header + value) to @p b=
uf=2E
+ */
+bool oob_probe_parameter_write(struct buffer *buf, const struct=
 oob_probe_parameter *p);
+
+/**
+ * Read a probe parameter TLV value of @p=
 value_len bytes from @p buf=2E
+ *
+ * The TLV header must already have be=
en consumed (e=2Eg=2E via
+ * oob_tlv_read_header())=2E @p value_len bytes =
are always consumed on success,
+ * including any trailing bytes beyond the=
 fields understood here=2E
+ *
+ * @return true on success, false if @p val=
ue_len is too short or @p buf is
+ *         truncated=2E
+ */
+bool oob_pr=
obe_parameter_read(struct buffer *buf, struct oob_probe_parameter *p,
+    =
                          uint16_t value_len);
+
+/**
+ * Write a complete =
probe reply TLV (header + value) to @p buf=2E
+ */
+bool oob_probe_reply_wr=
ite(struct buffer *buf, const struct oob_probe_reply *r);
+
+/**
+ * Read a=
 probe reply TLV value of @p value_len bytes from @p buf=2E See
+ * oob_pro=
be_parameter_read() for the calling convention=2E
+ */
+bool oob_probe_repl=
y_read(struct buffer *buf, struct oob_probe_reply *r, uint16_t value_len);
=
+
+#endif /* OOB_H */
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ss=
l_pkt=2Eh
index 82cb5b1=2E=2E840b6fa 100644
--- a/src/openvpn/ssl_pkt=2Eh
+=
++ b/src/openvpn/ssl_pkt=2Eh
@@ -58,6 +58,17 @@
  * like P_CONTROL_HARD_RES=
ET_CLIENT_V3 */
 #define P_CONTROL_WKC_V1 11
 
+/* Out-of-band control mess=
age that does not belong to an established
+ * control channel session (e=
=2Eg=2E a server probe)=2E Inherently unreliable:
+ * there is no protocol-=
level retransmission=2E
+ *
+ * NOTE: intentionally not yet included in the=
 P_FIRST_OPCODE=2E=2EP_LAST_OPCODE
+ * legal range=2E The range acts as an =
acceptance gate in tls_pre_decrypt();
+ * widening it before an OOB receive=
 handler exists would let OOB packets
+ * be misparsed as established-sessi=
on control packets=2E Bump P_LAST_OPCODE
+ * to 12 in the same change that =
adds the handler=2E */
+#define P_CONTROL_OOB_V1 12
+
 /* define the range =
of legal opcodes
  * Since we do no longer support key-method 1 we consider=

  * the v1 op codes invalid */
@@ -264,6 +275,9 @@
         case P_CONTROL=
_WKC_V1:
             return "P_CONTROL_WKC_V1";
 
+        case P_CONTROL_=
OOB_V1:
+            return "P_CONTROL_OOB_V1";
+
         case P_ACK_V1:
 =
            return "P_ACK_V1";
 
diff --git a/tests/unit_tests/openvpn/Make=
file=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index d861ef9=2E=2E42e98=
44 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tes=
ts/openvpn/Makefile=2Eam
@@ -14,6 +14,7 @@
 	ncp_testdriver \
 	mbuf_testdr=
iver \
 	misc_testdriver \
+	oob_testdriver \
 	options_parse_testdriver \
=
 	packet_id_testdriver \
 	pkt_testdriver \
@@ -150,6 +151,19 @@
 	$(top_sr=
cdir)/src/openvpn/win32-util=2Ec \
 	$(top_srcdir)/src/openvpn/session_id=
=2Ec
 
+oob_testdriver_CFLAGS  =3D \
+	-I$(top_srcdir)/include -I$(top_srcd=
ir)/src/compat -I$(top_srcdir)/src/openvpn \
+	@TEST_CFLAGS@
+oob_testdrive=
r_LDFLAGS =3D @TEST_LDFLAGS@
+oob_testdriver_SOURCES =3D test_oob=2Ec \
+	m=
ock_msg=2Ec mock_msg=2Eh test_common=2Eh \
+	mock_get_random=2Ec \
+	$(top_=
srcdir)/src/openvpn/buffer=2Ec \
+	$(top_srcdir)/src/openvpn/oob=2Ec \
+	$(=
top_srcdir)/src/openvpn/platform=2Ec \
+	$(top_srcdir)/src/openvpn/session_=
id=2Ec \
+	$(top_srcdir)/src/openvpn/win32-util=2Ec
+
 pkt_testdriver_CFLAG=
S  =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdi=
r)/src/openvpn \
 	@TEST_CFLAGS@
diff --git a/tests/unit_tests/openvpn/test=
_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
new file mode 100644
index=
 0000000=2E=2E48dfd6e
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_oob=
=2Ec
@@ -0,0 +1,209 @@
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
+#include "oo=
b=2Eh"
+#include "test_common=2Eh"
+
+/* Write a probe parameter TLV and re=
ad it back; fields must survive the
+ * round trip and the whole buffer mus=
t be consumed=2E */
+static void
+test_probe_parameter_roundtrip(void **sta=
te)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D all=
oc_buf_gc(128, &gc);
+
+    const struct oob_probe_parameter in =3D {
+    =
    =2Etimestamp =3D 0x0123456789abcdefULL,
+        =2Eflags =3D 0,
+    }=
;
+    assert_true(oob_probe_parameter_write(&buf, &in));
+    /* header (4=
) + value (12) */
+    assert_int_equal(BLEN(&buf), 4 + OOB_PROBE_PARAMETER=
_LEN);
+
+    uint16_t type;
+    bool optional;
+    uint16_t value_len;
+=
    assert_true(oob_tlv_read_header(&buf, &type, &optional, &value_len));
+=
    assert_int_equal(type, OOB_TLV_PROBE_PARAMETER);
+    assert_false(opti=
onal);
+    assert_int_equal(value_len, OOB_PROBE_PARAMETER_LEN);
+
+    st=
ruct oob_probe_parameter out =3D { 0 };
+    assert_true(oob_probe_paramete=
r_read(&buf, &out, value_len));
+    assert_true(in=2Etimestamp =3D=3D out=
=2Etimestamp);
+    assert_int_equal(in=2Eflags, out=2Eflags);
+    assert_=
int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* Write a probe reply=
 TLV and read it back=2E */
+static void
+test_probe_reply_roundtrip(void *=
*state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D=
 alloc_buf_gc(128, &gc);
+
+    struct oob_probe_reply in =3D {
+        =
=2Epriority =3D 10,
+        =2Eweight =3D 100,
+        =2Econnect_lifetim=
e =3D 30,
+        =2Eflags =3D 1,
+        =2Emax_latency_diff =3D 25,
+  =
  };
+    memcpy(in=2Epeer_session_id=2Eid, "ABCDEFGH", SID_SIZE);
+
+    a=
ssert_true(oob_probe_reply_write(&buf, &in));
+    assert_int_equal(BLEN(&b=
uf), 4 + OOB_PROBE_REPLY_LEN);
+
+    uint16_t type;
+    bool optional;
+ =
   uint16_t value_len;
+    assert_true(oob_tlv_read_header(&buf, &type, &o=
ptional, &value_len));
+    assert_int_equal(type, OOB_TLV_PROBE_REPLY);
+ =
   assert_int_equal(value_len, OOB_PROBE_REPLY_LEN);
+
+    struct oob_prob=
e_reply out =3D { 0 };
+    assert_true(oob_probe_reply_read(&buf, &out, va=
lue_len));
+    assert_memory_equal(in=2Epeer_session_id=2Eid, out=2Epeer_s=
ession_id=2Eid, SID_SIZE);
+    assert_int_equal(in=2Epriority, out=2Eprior=
ity);
+    assert_int_equal(in=2Eweight, out=2Eweight);
+    assert_int_equ=
al(in=2Econnect_lifetime, out=2Econnect_lifetime);
+    assert_int_equal(in=
=2Eflags, out=2Eflags);
+    assert_int_equal(in=2Emax_latency_diff, out=2E=
max_latency_diff);
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc=
);
+}
+
+/* A TLV with a longer-than-known value must still parse: the know=
n fields are
+ * read and the trailing bytes are skipped (forward compatibi=
lity)=2E */
+static void
+test_probe_parameter_forward_compat(void **state)=

+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_=
buf_gc(128, &gc);
+
+    const uint16_t extended_len =3D OOB_PROBE_PARAMETE=
R_LEN + 4;
+    assert_true(oob_tlv_write_header(&buf, OOB_TLV_PROBE_PARAME=
TER, false, extended_len));
+    assert_true(buf_write_u32(&buf, 0));      =
    /* timestamp high */
+    assert_true(buf_write_u32(&buf, 0xdeadbeef));=
 /* timestamp low */
+    assert_true(buf_write_u32(&buf, 0));          /* =
flags */
+    assert_true(buf_write_u32(&buf, 0x11223344)); /* unknown trai=
ling field */
+
+    uint16_t type;
+    bool optional;
+    uint16_t value=
_len;
+    assert_true(oob_tlv_read_header(&buf, &type, &optional, &value_l=
en));
+    assert_int_equal(value_len, extended_len);
+
+    struct oob_pro=
be_parameter out =3D { 0 };
+    assert_true(oob_probe_parameter_read(&buf,=
 &out, value_len));
+    assert_true(out=2Etimestamp =3D=3D 0xdeadbeefULL);=

+    assert_int_equal(out=2Eflags, 0);
+    /* the unknown trailing field =
must have been consumed */
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_=
free(&gc);
+}
+
+/* A declared value length shorter than the mandatory mini=
mum must be rejected=2E */
+static void
+test_probe_parameter_too_short(voi=
d **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =
=3D alloc_buf_gc(128, &gc);
+
+    struct oob_probe_parameter out =3D { 0 }=
;
+    assert_false(oob_probe_parameter_read(&buf, &out, OOB_PROBE_PARAMETE=
R_LEN - 1));
+
+    gc_free(&gc);
+}
+
+/* A buffer holding fewer value byt=
es than the declared length must be
+ * rejected: a failed timestamp (u64) =
read must not be masked by a subsequent
+ * successful flags (u32) read=2E =
*/
+static void
+test_probe_parameter_truncated_buffer(void **state)
+{
+  =
  struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(=
128, &gc);
+
+    /* only 4 of the declared OOB_PROBE_PARAMETER_LEN value b=
ytes present:
+     * too short for the timestamp, but enough for a u32 rea=
d to succeed */
+    assert_true(buf_write_u32(&buf, 0xdeadbeef));
+
+    s=
truct oob_probe_parameter out =3D { 0 };
+    assert_false(oob_probe_parame=
ter_read(&buf, &out, OOB_PROBE_PARAMETER_LEN));
+
+    gc_free(&gc);
+}
+
+=
/* Reading a TLV header must fail when the buffer holds less data than a
+ =
* complete 4-byte header (empty, or only the type field), rather than read
=
+ * past the available data=2E */
+static void
+test_tlv_header_truncated(v=
oid **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer bu=
f =3D alloc_buf_gc(128, &gc);
+
+    uint16_t type;
+    bool optional;
+  =
  uint16_t value_len;
+
+    /* empty buffer */
+    assert_false(oob_tlv_r=
ead_header(&buf, &type, &optional, &value_len));
+
+    /* only the type fi=
eld present, no length */
+    assert_true(buf_write_u16(&buf, OOB_TLV_PROB=
E_PARAMETER));
+    assert_false(oob_tlv_read_header(&buf, &type, &optional=
, &value_len));
+
+    gc_free(&gc);
+}
+
+int
+main(void)
+{
+    openvpn_=
unit_test_setup();
+    const struct CMUnitTest tests[] =3D {
+        cmoc=
ka_unit_test(test_probe_parameter_roundtrip),
+        cmocka_unit_test(tes=
t_probe_reply_roundtrip),
+        cmocka_unit_test(test_probe_parameter_fo=
rward_compat),
+        cmocka_unit_test(test_probe_parameter_too_short),
+=
        cmocka_unit_test(test_probe_parameter_truncated_buffer),
+        c=
mocka_unit_test(test_tlv_header_truncated),
+    };
+
+    return cmocka_ru=
n_group_tests_name("oob tests", tests, NULL, NULL);
+}

-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be36943738=
8268
Gerrit-Change-Number: 1741
Gerrit-PatchSet: 8
Gerrit-Owner: stipa <lst=
ipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>=

Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ec=
om>

--mYrZDn7ZPls=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>stipa <strong>uploaded pa=
tch set #8</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><p>The change is=
 no longer submittable: checks~ChecksSubmitRule is unsatisfied now=2E</p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">oob: Add control message TLV encoding (P_CONTROL_OOB_V1)<br><br=
>Reserve opcode 12 (P_CONTROL_OOB_V1) for out-of-band control messages and<=
br>add encoding/decoding for the SERVER_PROBE / PROBE_REPLY TLVs used for<b=
r>server latency checks:<br><br>  - probe_parameter (0x200): client timesta=
mp + capability flags<br>  - probe_reply    (0x201): echoed session id, DNS=
-SRV style priority and<br>                            weight, connect_life=
time and behaviour flags<br><br>Each TLV has a 4-byte header (15-bit type p=
lus an optional flag, then a<br>16-bit value length)=2E Readers enforce the=
 minimum value length and skip<br>trailing bytes they do not understand, so=
 the format stays forward<br>compatible and multi-TLV framing resynchronise=
s=2E<br><br>P_LAST_OPCODE is deliberately left at 11: opcode 12 is not yet =
accepted by<br>tls_pre_decrypt()=2E The legal-opcode range is widened toget=
her with the<br>receive handler in a follow-up, which also wires oob=2Ec in=
to the openvpn<br>build=2E For now the codec is exercised only by the unit =
tests=2E<br><br>See the OOB control message section of the OpenVPN wire pro=
tocol<br>specification (openvpn-rfc PR #30)=2E<br><br>Change-Id: I1c8d302ac=
57c5603d622a7be14be369437388268<br>Signed-off-by: Lev Stipakov &lt;lev@open=
vpn=2Enet&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<b=
r>A src/openvpn/oob=2Ec<br>A src/openvpn/oob=2Eh<br>M src/openvpn/ssl_pkt=
=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests/unit_tests/open=
vpn/test_oob=2Ec<br>7 files changed, 567 insertions(+), 0 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/41/1741/8</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=
=2Etxt</span><br><span>index 7473f15=2E=2Ef9a57ee 100644</span><br><span>--=
- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span=
>@@ -520,6 +520,8 @@</span><br><span>     src/openvpn/multi_io=2Ec</span><b=
r><span>     src/openvpn/occ=2Ec</span><br><span>     src/openvpn/occ=2Eh</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/oob=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn=
/oob=2Eh</span><br><span>     src/openvpn/openvpn=2Ec</span><br><span>     =
src/openvpn/openvpn=2Eh</span><br><span>     src/openvpn/openvpn_win32_reso=
urces=2Erc</span><br><span>@@ -667,6 +669,7 @@</span><br><span>         &qu=
ot;test_mbuf&quot;</span><br><span>         &quot;test_misc&quot;</span><br=
><span>         &quot;test_ncp&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        &quot;test_oob&quot;</span><br><span>         &quo=
t;test_options_parse&quot;</span><br><span>         &quot;test_packet_id&qu=
ot;</span><br><span>         &quot;test_pkt&quot;</span><br><span>@@ -858,6=
 +861,12 @@</span><br><span>         src/openvpn/session_id=2Ec</span><br><=
span>         )</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    target_sources(test_oob PRIVATE</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/mock_get_ran=
dom=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/=
openvpn/oob=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    src/openvpn/session_id=2Ec</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        )</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span>     target_sources(test_pkt PRIVATE</span><br><span>    =
     tests/unit_tests/openvpn/mock_win32_execve=2Ec</span><br><span>       =
  src/openvpn/argv=2Ec</span><br><span>diff --git a/src/openvpn/Makefile=2E=
am b/src/openvpn/Makefile=2Eam</span><br><span>index ff8cc54=2E=2Eb4b1b92 1=
00644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b=
/src/openvpn/Makefile=2Eam</span><br><span>@@ -106,6 +106,7 @@</span><br><s=
pan> 	pkcs11=2Ec pkcs11=2Eh pkcs11_backend=2Eh \</span><br><span> 	pkcs11_o=
penssl=2Ec \</span><br><span> 	pkcs11_mbedtls=2Ec \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	oob=2Ec oob=2Eh \</span><br><span> 	open=
vpn=2Ec openvpn=2Eh \</span><br><span> 	options=2Ec options=2Eh \</span><br=
><span> 	options_util=2Ec options_util=2Eh \</span><br><span>diff --git a/s=
rc/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br><span>new file mode 1006=
44</span><br><span>index 0000000=2E=2Eb01f4ee</span><br><span>--- /dev/null=
</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -0,0 +1,168 @=
@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to se=
curely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *             over a single TCP/UDP port, with support for SSL/TLS-b=
ased</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
session authentication and key exchange,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             packet encryption, packet authenticatio=
n, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *           =
  packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright=
 (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  This program is free software; you can redistribute i=
t and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
it under the terms of the GNU General Public License version 2</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Sof=
tware Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program =
is distributed in the hope that it will be useful,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even t=
he implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public L=
icense for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You sh=
ould have received a copy of the GNU General Public License along</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not=
, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifd=
ef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Consume @p value_len bytes of TLV value, of which @=
p consumed have already</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * been read, ignoring (skipping) any trailing bytes that this version =
does</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * not understa=
nd=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf        buffer pos=
itioned after the @p consumed value bytes</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param value_len  the TLV&#39;s declared value len=
gth</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param consum=
ed   number of value bytes already read from @p buf</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false if fewe=
r than @p consumed bytes were</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *         declared or @p buf does not hold the trailing bytes=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+oob_skip_trailing(struct buffer *buf, uin=
t16_t value_len, int consumed)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(value_len &lt; consumed)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_advan=
ce(buf, value_len - consumed);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+oob_msg_write_header(struct buffer *buf, =
uint16_t msg_type)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_writ=
e_u16(buf, msg_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+oob_msg_read_header(struct buffer *buf, uint16_t e=
xpected_msg_type)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int msg_type =3D=
 buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return msg_type &gt;=3D 0 &amp;&amp; (uint16_t)msg_type =3D=3D expected=
_msg_type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+oob_tlv_write_header(struct buffer *buf, uint16_t type, bool =
optional, uint16_t value_len)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint=
16_t field =3D type &amp; OOB_TLV_TYPE_MASK;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (optional)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        field |=3D OOB_TLV_OPTIONAL_FLAG;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return buf_write_u16(buf, field) &amp;&amp; buf_write_=
u16(buf, value_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+oob_tlv_read_header(struct buffer *buf, uint16_t *t=
ype, bool *optional, uint16_t *value_len)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    int field =3D buf_read_u16(buf);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (field &lt; 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 int len =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (len &lt; 0)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *type =3D =
(uint16_t)(field &amp; OOB_TLV_TYPE_MASK);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    *optional =3D (field &amp; OOB_TLV_OPTIONAL_FLAG=
) !=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *value=
_len =3D (uint16_t)len;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+oob_probe_parameter_write(struct buffer *buf, const=
 struct oob_probe_parameter *p)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn oob_tlv_write_header(buf, OOB_TLV_PROBE_PARAMETER, false, OOB_PROBE_PA=
RAMETER_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
    &amp;&amp; buf_write_u64(buf, p-&gt;timestamp)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u32(buf, p-&=
gt;flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+oob_probe_parameter_read(struct buffer *buf, struct oob_probe=
_parameter *p, uint16_t value_len)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (value_len &lt; OOB_PROBE_PARAMETER_LEN)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* check each read separately: a successful read sets ok back to true,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * so a single ch=
eck at the end could mask an earlier failure */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    bool ok =3D true;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    p-&gt;timestamp =3D buf_read_u64(buf, &am=
p;ok);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ok)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    p-&gt;flags =3D buf_read_u32(buf, &amp;ok)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ok)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return oob_skip_trailing(buf, value_len, OOB_PR=
OBE_PARAMETER_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+oob_probe_reply_write(struct buffer *buf, const stru=
ct oob_probe_reply *r)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return oob_=
tlv_write_header(buf, OOB_TLV_PROBE_REPLY, false, OOB_PROBE_REPLY_LEN)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; se=
ssion_id_write(&amp;r-&gt;peer_session_id, buf)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16(buf, r-&gt;=
priority)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
 &amp;&amp; buf_write_u16(buf, r-&gt;weight)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16(buf, r-&gt;con=
nect_lifetime)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
      &amp;&amp; buf_write_u32(buf, r-&gt;flags)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16(buf, r-&gt=
;max_latency_diff);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+oob_probe_reply_read(struct buffer *buf, struct oob_=
probe_reply *r, uint16_t value_len)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (value_len &lt; OOB_PROBE_REPLY_LEN)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!session_id_read(&amp;r-&gt;peer_session_id, buf))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int priority =3D buf_read_u16(buf);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int weight =3D buf_read_u16(buf);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int connect_lifetime =3D=
 buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (priority &lt; 0 || weight &lt; 0 || connect_lifetime &lt; 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    bool ok =3D true;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    r-&gt;flags =3D buf_read_u32(buf, &amp;ok);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int max_latency_di=
ff =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!ok || max_latency_diff &lt; 0)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    r-&gt;priority =3D (uint16_t)priority;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    r-&gt;weight =3D (uint16_t)weight;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;connect_lifetime =3D (u=
int16_t)connect_lifetime;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    r-&gt;max_latency_diff =3D (uint16_t)max_latency_diff;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return oob_skip_trailing(b=
uf, value_len, OOB_PROBE_REPLY_LEN);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/o=
penvpn/oob=2Eh</span><br><span>new file mode 100644</span><br><span>index 0=
000000=2E=2E6880665</span><br><span>--- /dev/null</span><br><span>+++ b/src=
/openvpn/oob=2Eh</span><br><span>@@ -0,0 +1,152 @@</span><br><span style=3D=
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
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Encoding/decoding of out-of-band (P_CONTROL_OOB_V=
1) control messages=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * An OOB mess=
age payload starts with a 16-bit message type (the 0x1xx space:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * SERVER_PROBE, PROBE_REPLY, =
=2E=2E=2E) followed by a sequence of TLV entries=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * Each TLV starts with a 4-byte header: a 16-bit field wh=
ose most significant</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * bit is the &quot;optional&quot; flag and whose remaining 15 bits are th=
e type (the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * 0x2xx=
 space), followed by a 16-bit length giving the size of the value that</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * follows the header=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifndef OOB_H</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define OOB_H</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;session_id=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* OOB message types: the 16-bit value at the start of an OOB payload, befor=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * its TLV entries=
=2E Distinct from the TLV-type space (0x2xx); see the &quot;Messages&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * table in the OOB =
section of the wire protocol spec=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define OOB_MSG_SERVER_PROBE 0x100</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define OOB_MSG_PROBE_REPLY  0x101</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* TLV header bit layout of the first 16-bit=
 field */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OO=
B_TLV_OPTIONAL_FLAG 0x8000</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define OOB_TLV_TYPE_MASK     0x7fff</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* TLV types (see the OOB control message section of the wire protocol=
 spec) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OO=
B_TLV_PROBE_PARAMETER 0x200</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define OOB_TLV_PROBE_REPLY     0x201</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* Minimum on-wire value length (excluding the 4-byte TLV header) of=
 each TLV:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the si=
zes of its fixed fields in wire order (see the structs below)=2E The</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * value may be longer for=
 forward compatibility; trailing bytes that are not</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * understood are ignored on read=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_PROBE_PAR=
AMETER_LEN \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ((u=
int16_t)(sizeof(uint64_t) /* timestamp */ + sizeof(uint32_t) /* flags */))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_PROBE_RE=
PLY_LEN                                                     \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ((uint16_t)(SID_SIZE         =
      /* peer_session_id */                    \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                + 3 * sizeof(uint16_t) /* prio=
rity, weight, connect_lifetime */ \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                + sizeof(uint32_t)     /* flags */         =
                     \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                + sizeof(uint16_t)))   /* max_latency_diff */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* probe parameter TLV (sent by the client in a S=
ERVER_PROBE) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stru=
ct oob_probe_parameter</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t ti=
mestamp; /**&lt; client clock as a UNIX timestamp */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint32_t flags;     /**&lt; client ca=
pability flags, currently must be 0 */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* probe reply TL=
V (sent by the server in a PROBE_REPLY) */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+struct oob_probe_reply</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct session_id peer_session_id; /**&lt; echoes the session i=
d of the request */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    uint16_t priority;                 /**&lt; DNS-SRV style priority (lowe=
r is preferred) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   uint16_t weight;                   /**&lt; DNS-SRV style weight */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t connect_life=
time;         /**&lt; seconds the probe stays valid as a handshake shortcut=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t fla=
gs;                    /**&lt; server behaviour flags */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    uint16_t max_latency_diff;        =
 /**&lt; advertised candidate-band margin in ms;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                        *   0 =
means &quot;defer to the client&#39;s setting&quot; */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write an OOB m=
essage-type header (the 16-bit message type preceding the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * TLVs) to @p buf=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @return true on success, false if @p buf has insu=
fficient space=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_msg_write=
_header(struct buffer *buf, uint16_t msg_type);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read=
 and verify an OOB message-type header from @p buf, advancing past it=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param buf                buffer pos=
itioned at the OOB message payload</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param expected_msg_type  the message type the payload mu=
st carry</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return =
true if a message type was read and equals @p expected_msg_type,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *         false on a short bu=
ffer or a mismatching type=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool o=
ob_msg_read_header(struct buffer *buf, uint16_t expected_msg_type);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Write a TLV header (type + optional flag + value length) to=
 @p buf=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success=
, false if @p buf has insufficient space=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bool oob_tlv_write_header(struct buffer *buf, uint16_t type, bool o=
ptional, uint16_t value_len);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read a TLV header from=
 @p buf, advancing past it=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am buf        buffer positioned at the TLV header</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param type       set to the 15-bit TLV ty=
pe</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param optiona=
l   set to the value of the optional flag</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param value_len  set to the declared value length=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on =
success, false if there are not enough bytes for a header=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+bool oob_tlv_read_header(struct buffer *buf, uint1=
6_t *type, bool *optional, uint16_t *value_len);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Wri=
te a complete probe parameter TLV (header + value) to @p buf=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+bool oob_probe_parameter_write(struct buffer *b=
uf, const struct oob_probe_parameter *p);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read a pro=
be parameter TLV value of @p value_len bytes from @p buf=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * The TLV header must already have been consumed (e=
=2Eg=2E via</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * oob_t=
lv_read_header())=2E @p value_len bytes are always consumed on success,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * including any traili=
ng bytes beyond the fields understood here=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @return true on success, false if @p value_len is too short or =
@p buf is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
 truncated=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_probe_paramet=
er_read(struct buffer *buf, struct oob_probe_parameter *p,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                              uint16=
_t value_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Write a complete probe reply TLV (hea=
der + value) to @p buf=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_p=
robe_reply_write(struct buffer *buf, const struct oob_probe_reply *r);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Read a probe reply TLV value of @p value_len bytes fro=
m @p buf=2E See</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * o=
ob_probe_parameter_read() for the calling convention=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+bool oob_probe_reply_read(struct buffer *buf, struct oo=
b_probe_reply *r, uint16_t value_len);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif /* OOB_H */</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/s=
rc/openvpn/ssl_pkt=2Eh</span><br><span>index 82cb5b1=2E=2E840b6fa 100644</s=
pan><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openv=
pn/ssl_pkt=2Eh</span><br><span>@@ -58,6 +58,17 @@</span><br><span>  * like =
P_CONTROL_HARD_RESET_CLIENT_V3 */</span><br><span> #define P_CONTROL_WKC_V1=
 11</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Out-of-band control message that does not belong to an established</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * control channel sess=
ion (e=2Eg=2E a server probe)=2E Inherently unreliable:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * there is no protocol-level retransmi=
ssion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * NOTE: intentionally not y=
et included in the P_FIRST_OPCODE=2E=2EP_LAST_OPCODE</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * legal range=2E The range acts as an ac=
ceptance gate in tls_pre_decrypt();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * widening it before an OOB receive handler exists would l=
et OOB packets</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * be=
 misparsed as established-session control packets=2E Bump P_LAST_OPCODE</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to 12 in the same ch=
ange that adds the handler=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define P_CONTROL_OOB_V1 12</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /* define the range of legal opcodes=
</span><br><span>  * Since we do no longer support key-method 1 we consider=
</span><br><span>  * the v1 op codes invalid */</span><br><span>@@ -264,6 +=
275,9 @@</span><br><span>         case P_CONTROL_WKC_V1:</span><br><span>  =
           return &quot;P_CONTROL_WKC_V1&quot;;</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        case P_CONTROL_OOB_V1=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return=
 &quot;P_CONTROL_OOB_V1&quot;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span>         case P_ACK_V1:</span><br><span>       =
      return &quot;P_ACK_V1&quot;;</span><br><span> </span><br><span>diff -=
-git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Ma=
kefile=2Eam</span><br><span>index d861ef9=2E=2E42e9844 100644</span><br><sp=
an>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests=
/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -14,6 +14,7 @@</span><=
br><span> 	ncp_testdriver \</span><br><span> 	mbuf_testdriver \</span><br><=
span> 	misc_testdriver \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	oob_testdriver \</span><br><span> 	options_parse_testdriver \</span><=
br><span> 	packet_id_testdriver \</span><br><span> 	pkt_testdriver \</span>=
<br><span>@@ -150,6 +151,19 @@</span><br><span> 	$(top_srcdir)/src/openvpn/=
win32-util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/session_id=2Ec=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+o=
ob_testdriver_CFLAGS  =3D \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)=
/src/openvpn \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	@TES=
T_CFLAGS@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_testdr=
iver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+oob_testdriver_SOURCES =3D test_oob=2Ec \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	mock_msg=2Ec mock_msg=2Eh test_common=2E=
h \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_get_random=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir=
)/src/openvpn/buffer=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	$(top_srcdir)/src/openvpn/oob=2Ec \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/se=
ssion_id=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(to=
p_srcdir)/src/openvpn/win32-util=2Ec</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> pkt_testdriver_CFLAGS  =3D \</span><br><=
span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/s=
rc/openvpn \</span><br><span> 	@TEST_CFLAGS@</span><br><span>diff --git a/t=
ests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2E=
c</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E4=
8dfd6e</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests=
/openvpn/test_oob=2Ec</span><br><span>@@ -0,0 +1,209 @@</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP netw=
orks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
over a single TCP/UDP port, with support for SSL/TLS-based</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             session authenticatio=
n and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             packet encryption, packet authentication, and</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=
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
lor: hsl(120, 100%, 40%);">+#include &lt;stdarg=2Eh&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &lt;stddef=2Eh&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_commo=
n=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* Write a probe parameter =
TLV and read it back; fields must survive the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * round trip and the whole buffer must be consum=
ed=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_paramete=
r_roundtrip(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct g=
c_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const struct oob_probe_parameter in =3D {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        =2Etimestamp =3D 0x01=
23456789abcdefULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       =2Eflags =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(oob_probe_parameter_write(&amp;buf, &amp;in));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* header (4) + value (12) */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&=
amp;buf), 4 + OOB_PROBE_PARAMETER_LEN);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    uint16_t type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    bool optional;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   uint16_t value_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(oob_tlv_read_header(&amp;buf, &amp;type, &amp;optional, =
&amp;value_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(type, OOB_TLV_PROBE_PARAMETER);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_false(optional);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(value_len, OOB_=
PROBE_PARAMETER_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_pr=
obe_parameter out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(oob_probe_parameter_read(&amp;buf, &amp;out, value=
_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(in=2Etimestamp =3D=3D out=2Etimestamp);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(in=2Eflags, out=2Eflags);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLE=
N(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* Write a probe reply TLV and read it back=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_roundtrip(void **s=
tate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buff=
er buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct oob_probe_reply in =3D {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        =2Epriority =3D 10,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        =2Eweight =3D 100,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        =2Econnect_lifetime =3D 30,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D 1,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Emax_latency_d=
iff =3D 25,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(in=2Epeer_=
session_id=2Eid, &quot;ABCDEFGH&quot;, SID_SIZE);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(oob_probe_reply_write(&amp;buf, &amp;in));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN=
(&amp;buf), 4 + OOB_PROBE_REPLY_LEN);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   uint16_t type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  bool optional;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 uint16_t value_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_true(oob_tlv_read_header(&amp;buf, &amp;type, &amp;optional, &a=
mp;value_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(type, OOB_TLV_PROBE_REPLY);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(value_len, OOB_PROBE_REPLY_LE=
N);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply out =3D =
{ 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(oob_probe_reply_read(&amp;buf, &amp;out, value_len));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(in=2Epeer_sess=
ion_id=2Eid, out=2Epeer_session_id=2Eid, SID_SIZE);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Epriority, out=
=2Epriority);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(in=2Eweight, out=2Eweight);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(in=2Econnect_lifetime, out=2Eco=
nnect_lifetime);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(in=2Eflags, out=2Eflags);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(in=2Emax_latency_diff, out=2Em=
ax_latency_diff);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/* A TLV with a longer-than-known v=
alue must still parse: the known fields are</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * read and the trailing bytes are skipped (forward=
 compatibility)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_p=
robe_parameter_forward_compat(void **state)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const uint16_t extended_len =3D O=
OB_PROBE_PARAMETER_LEN + 4;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(oob_tlv_write_header(&amp;buf, OOB_TLV_PROBE_PARAME=
TER, false, extended_len));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(buf_write_u32(&amp;buf, 0));          /* timestamp =
high */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(buf_write_u32(&amp;buf, 0xdeadbeef)); /* timestamp low */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&am=
p;buf, 0));          /* flags */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0x11223344)); /* unkno=
wn trailing field */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t type;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool optional;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t value_l=
en;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(=
oob_tlv_read_header(&amp;buf, &amp;type, &amp;optional, &amp;value_len));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
value_len, extended_len);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oo=
b_probe_parameter out =3D { 0 };</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(oob_probe_parameter_read(&amp;buf, &amp;out, v=
alue_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(out=2Etimestamp =3D=3D 0xdeadbeefULL);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Eflags, 0);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* the unknown trailing fi=
eld must have been consumed */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A declared value =
length shorter than the mandatory minimum must be rejected=2E */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+test_probe_parameter_too_short(void **=
state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_n=
ew();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buf=
fer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct oob_probe_parameter out =3D { 0 };</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_false(oob_probe_parameter_read(&amp;b=
uf, &amp;out, OOB_PROBE_PARAMETER_LEN - 1));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* A buffer holding fewer val=
ue bytes than the declared length must be</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * rejected: a failed timestamp (u64) read must not b=
e masked by a subsequent</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * successful flags (u32) read=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+test_probe_parameter_truncated_buffer(void **state)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D allo=
c_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* only 4 o=
f the declared OOB_PROBE_PARAMETER_LEN value bytes present:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * too short for the timestamp,=
 but enough for a u32 read to succeed */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0xdeadbeef));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_parameter out =3D =
{ 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fa=
lse(oob_probe_parameter_read(&amp;buf, &amp;out, OOB_PROBE_PARAMETER_LEN));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Reading a TLV header must fail when the buffer holds less data than a<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * complete 4-byte h=
eader (empty, or only the type field), rather than read</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * past the available data=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+test_tlv_header_truncated(void **s=
tate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buff=
er buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    uint16_t type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   bool optional;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  uint16_t value_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* empty buff=
er */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fal=
se(oob_tlv_read_header(&amp;buf, &amp;type, &amp;optional, &amp;value_len))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* only the type field present, n=
o length */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(buf_write_u16(&amp;buf, OOB_TLV_PROBE_PARAMETER));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_tlv_read_header=
(&amp;buf, &amp;type, &amp;optional, &amp;value_len));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+main(void)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    openvpn_unit_test_setup();</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const struct CMUnitTest tests[] =3D {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test=
_probe_parameter_roundtrip),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_probe_reply_roundtrip),</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_pr=
obe_parameter_forward_compat),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(test_probe_parameter_too_short),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(t=
est_probe_parameter_truncated_buffer),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        cmocka_unit_test(test_tlv_header_truncated),</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return cmocka_run_group_tests_name(&quot;oob tests&=
quot;, tests, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">change 1741</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c8d302a=
c57c5603d622a7be14be369437388268 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1741 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8=
 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></ht=
ml>
--mYrZDn7ZPls=--


--===============8779008326919429205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8779008326919429205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8779008326919429205==--

