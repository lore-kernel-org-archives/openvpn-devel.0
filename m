Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A8DC54F4D
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E0mltiS5ZS2buH0Iia3lrUdZ3I3rXcvv8uQPx1mgyqQ=; b=J4QunGc8kzREazOqf6A3uJPlKA
	xrnx+qCBP6PWXEYYeBSCGg0Oa/wy5it6mwZdgX/WecKhhodWDVxTucDm+H07ekRU/aO6pkVR283Nv
	hoRpLszDCuxeOqHdxasU7/SerggasOOwii7uVKvRpgGTbGg2AMaLqv+ooM+emlfieDXY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wojLR-0001ie-FG;
	Tue, 28 Jul 2026 15:03:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wojLP-0001iV-Vp
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:03:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=fsq+h6prBQQhVz9VKOT1gcbJugv8GXfVJY9zpOrnu2A=; b=ZjTPsc8bS4xYdmJ7IAnfT4AHxJ
 m+UCc0pErCMuAwNeCvUswIGsIU6oxRzNPvk/l/oerp7pv9CbMn/d3S3AmUEU8221W9PXBTS0JAVW4
 s58qcifnc7trIFjTrmDu++pdC7clXMD8nUm86TTa3yNkjSdqPeImIdssUYs2sATs71+Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fsq+h6prBQQhVz9VKOT1gcbJugv8GXfVJY9zpOrnu2A=; b=d
 nNukJ6w2JACzCbS7+4mZla956+VsEUVXs/F5C5R8doO/KOskeNkBS3ThR488Cxcx5CzZ510LQyZLc
 YKKJikcSHCP3w6Z4tTfiFk3DQmi/MgR7VX2BsCDo1GGsOtoGTd6pQorXXllmsdL45MJZV3e1M5AfT
 Pu/v84CkeueyZBcg=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wojLO-0000Pu-GI for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:03:47 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4956242332dso34840225e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 08:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785251016; x=1785855816; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fsq+h6prBQQhVz9VKOT1gcbJugv8GXfVJY9zpOrnu2A=;
 b=EcOilBHxFNA8gxhHj60GhVowWNqlUSpHNHhOX92ulzf+RCWm/c62aP2zGnP0VrhBS8
 JjLsgmPldAHfkARzvvHQLRlgU/LPOTjqZw2+j8L3Hmtua8zz6w/phi9BGTIzrSlDgI6u
 fxryqFyyfhgvDf/1HwDrPZvFUGlA2ShJSJMjp92SwOTs8i+p7oekC8NYpExIaQCESjKS
 dhdj1q1zsq933R9t70GRiHbQkFt4xPbf7oUkK8tjHFyxGhytn8IQ19m/9WSdkPdrMC/A
 FjNIlYfD3Ics9qYtEzYkmtA8u/wgl6Tq7lcsJr3KhlnRWvqKO7Us1nYMPJZ0V1KPsPF4
 tyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251016; x=1785855816;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fsq+h6prBQQhVz9VKOT1gcbJugv8GXfVJY9zpOrnu2A=;
 b=pgXlv2I+DlaBmg/vXk7HecvAmMasKKmzTFHCwjQwc/+swJdbayQ5wr2VZlEgtys50g
 y2YoZAewY1kacvIP+TcZb3mcl64+iudNtdacudoKzeYQ5Hjh1QUX0yWmVe8JDGsLbIJD
 7Y+InRTihppRt+Gah26k5NP5/mbs6rCLn4MBSRimUU4T7sVb9D+f3Q5fdNbDUNz5yrE2
 fKf0pLdd7Et7j1si864h8mZnlOxn1UPNFnWEZNNBmtlKuZ44KDAVKlfElwuDE5FcOFBs
 T+vBLPR3y2aoSqUveuO5B2Q/Vg6AiUlfLcBN3R5h1h1HtusQvPRGBXJOANtfcCSd2HOm
 vcOA==
X-Gm-Message-State: AOJu0Ywyc8HiaxRRPRGBTKEVuvDuu0dwLAJhVjviD7BE/wMJlVYW+rjY
 yn09x3UYPjZ6JqX5hCCy5YgTU6GhPOYrsBYSudYqVyTZfYlXUzW8coIzY7/BnOBUsrpaDXYB7jV
 zOTEZUdYbrumw1mr/C9JPhKYMSNCHqMh3MxaJ2UtmPWjlN+37CUW9jsE0QjhZeS915DYK
X-Gm-Gg: AR+sD1181DlJAb7r37EW+bT4F4graXkmbwwJVE0t1J1isPQotOMcT+D0lc1GQTukHz/
 NXTyt8UvCAIHm1C+KFg8HJP6gt7b+8JsQwWvLIiaCDVHcAuRIJb4jntEtE+r91GWRYHhVhvQaB/
 8ZH4sLWtcmX1kvVP0Ct/f3d512Fm64NAgW0oTShspJzgFq64+AW+A1Flf70PcZNudfC4p0NtWCU
 pz/lfTwqNCiiwEl4ggmkQUbX6OLTn63GJLTyas9GMpgxMyqt8Gk46OF63rt6cC4lJ3JBHlFsg7a
 20apl1Yv0WTt3FVOVepEQr1s3xg5WgI51mI3ejXfcGByIlevsz/h43A/x3n2LdzhwbwQHFRSn2g
 28M2HusycG+jThfGfisrWAbrcWI8BuGT/CyiZVP8tJD17mbKyd5tDgaxkVgbyhEK1rCv3AzBo9d
 Ut60v7kth9WEaIMVTYcT4tGuFhzTMgdp4osG25kkWHGzKMBAnh+XNKfnnZiFRYi96F1ZJOWsx5+
 2O0NiZGdB1TBB8slVuhtOuuWm794y6/oeOefetDYki+9rzF0CvE8KeAdowNOdoBl4Od
X-Received: by 2002:a05:600c:6992:b0:493:a438:7f98 with SMTP id
 5b1f17b1804b1-496c6590745mr30253505e9.18.1785251015309; 
 Tue, 28 Jul 2026 08:03:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f864305f5sm58368630f8f.17.2026.07.28.08.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:03:34 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 15:03:23 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: a86807f8ff487d67889bf8747327e6311aeba99f
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d8237ce85e734f5c60426e411f92b3ceba65ef3b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wojLO-0000Pu-GI
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
Content-Type: multipart/mixed; boundary="===============5517807741114305553=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5517807741114305553==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Maknr33Z7BQ="; charset=UTF-8

--Maknr33Z7BQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, stipa=2E

Hello flichte=
nheld, plaisthos, 

I'd like you to reexamine a change=2E Please visit

   =
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail

to look at the=
 new patch set (#9)=2E

The following approvals got outdated and were remov=
ed:
Code-Review+2 by flichtenheld


Change subject: oob: Add control messag=
e TLV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

oob: Add control message TLV encoding (P_CONTROL_OOB=
_V1)

Add opcode 12 for out-of-band control messages and the TLV codec for =
the
SERVER_PROBE and PROBE_REPLY used by server latency checks=2E

The fram=
ing is not OOB-specific, so it goes into its own control_msg=2Ec/h;
oob=2Ec=
 keeps the OOB message and TLV types=2E

P_LAST_OPCODE becomes 12, and opco=
de_valid_in_session() replaces the plain
range check because OOB opcodes ar=
e answered statelessly and are never legal
on an established session=2E

Ch=
ange-Id: I1c8d302ac57c5603d622a7be14be369437388268
Signed-off-by: Lev Stipa=
kov <lev@openvpn=2Enet>
---
M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
=
A src/openvpn/control_msg=2Ec
A src/openvpn/control_msg=2Eh
A src/openvpn/o=
ob=2Ec
A src/openvpn/oob=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_pkt=2E=
c
M src/openvpn/ssl_pkt=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
A test=
s/unit_tests/openvpn/test_oob=2Ec
11 files changed, 739 insertions(+), 4 de=
letions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/41/1741/9

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 7473=
f15=2E=2Ef4b1b22 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -4=
44,6 +444,8 @@
     src/openvpn/console=2Ec
     src/openvpn/console_builti=
n=2Ec
     src/openvpn/console=2Eh
+    src/openvpn/control_msg=2Ec
+    sr=
c/openvpn/control_msg=2Eh
     src/openvpn/crypto=2Ec
     src/openvpn/cryp=
to=2Eh
     src/openvpn/crypto_backend=2Eh
@@ -520,6 +522,8 @@
     src/ope=
nvpn/multi_io=2Ec
     src/openvpn/occ=2Ec
     src/openvpn/occ=2Eh
+    sr=
c/openvpn/oob=2Ec
+    src/openvpn/oob=2Eh
     src/openvpn/openvpn=2Ec
   =
  src/openvpn/openvpn=2Eh
     src/openvpn/openvpn_win32_resources=2Erc
@@ =
-667,6 +671,7 @@
         "test_mbuf"
         "test_misc"
         "test_n=
cp"
+        "test_oob"
         "test_options_parse"
         "test_packet=
_id"
         "test_pkt"
@@ -858,6 +863,13 @@
         src/openvpn/session_=
id=2Ec
         )
 
+    target_sources(test_oob PRIVATE
+        tests/uni=
t_tests/openvpn/mock_get_random=2Ec
+        src/openvpn/control_msg=2Ec
+ =
       src/openvpn/oob=2Ec
+        src/openvpn/session_id=2Ec
+        )
+=

     target_sources(test_pkt PRIVATE
         tests/unit_tests/openvpn/moc=
k_win32_execve=2Ec
         src/openvpn/argv=2Ec
diff --git a/src/openvpn/M=
akefile=2Eam b/src/openvpn/Makefile=2Eam
index ff8cc54=2E=2Ea67d478 100644
=
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -52,6 +5=
2,7 @@
 	common=2Eh \
 	comp=2Ec comp=2Eh compstub=2Ec \
 	comp-lz4=2Ec com=
p-lz4=2Eh \
+	control_msg=2Ec control_msg=2Eh \
 	crypto=2Ec crypto=2Eh cry=
pto_backend=2Eh \
 	crypto_openssl=2Ec crypto_openssl=2Eh \
 	crypto_mbedtl=
s_legacy=2Ec crypto_mbedtls_legacy=2Eh \
@@ -106,6 +107,7 @@
 	pkcs11=2Ec p=
kcs11=2Eh pkcs11_backend=2Eh \
 	pkcs11_openssl=2Ec \
 	pkcs11_mbedtls=2Ec =
\
+	oob=2Ec oob=2Eh \
 	openvpn=2Ec openvpn=2Eh \
 	options=2Ec options=2Eh=
 \
 	options_util=2Ec options_util=2Eh \
diff --git a/src/openvpn/control_m=
sg=2Ec b/src/openvpn/control_msg=2Ec
new file mode 100644
index 0000000=2E=
=2E95ff210
--- /dev/null
+++ b/src/openvpn/control_msg=2Ec
@@ -0,0 +1,90 @@=

+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *     =
        over a single TCP/UDP port, with support for SSL/TLS-based
+ *     =
        session authentication and key exchange,
+ *             packet enc=
ryption, packet authentication, and
+ *             packet compression=2E
+=
 *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  =
This program is free software; you can redistribute it and/or modify
+ *  i=
t under the terms of the GNU General Public License version 2
+ *  as publi=
shed by the Free Software Foundation=2E
+ *
+ *  This program is distribute=
d in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; withou=
t even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTIC=
ULAR PURPOSE=2E  See the
+ *  GNU General Public License for more details=
=2E
+ *
+ *  You should have received a copy of the GNU General Public Lice=
nse along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/lice=
nses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#i=
nclude "syshead=2Eh"
+
+#include "control_msg=2Eh"
+
+bool
+ctrl_msg_read_h=
eader(struct buffer *buf, uint16_t expected_msg_type)
+{
+    int msg_type =
=3D buf_read_u16(buf);
+    return msg_type >=3D 0 && (uint16_t)msg_type =
=3D=3D expected_msg_type;
+}
+
+bool
+ctrl_msg_tlv_write_header(struct buff=
er *buf, uint16_t type, bool optional, uint16_t value_len)
+{
+    uint16_t=
 field =3D type & CTRL_MSG_TLV_TYPE_MASK;
+    if (optional)
+    {
+      =
  field |=3D CTRL_MSG_TLV_OPTIONAL_FLAG;
+    }
+    return buf_write_u16(b=
uf, field) && buf_write_u16(buf, value_len);
+}
+
+bool
+ctrl_msg_tlv_read_=
header(struct buffer *buf, struct ctrl_msg_tlv_header *hdr)
+{
+    int fie=
ld =3D buf_read_u16(buf);
+    if (field < 0)
+    {
+        return false;=

+    }
+    int len =3D buf_read_u16(buf);
+    if (len < 0)
+    {
+     =
   return false;
+    }
+    hdr->type =3D (uint16_t)(field & CTRL_MSG_TLV_=
TYPE_MASK);
+    hdr->optional =3D (field & CTRL_MSG_TLV_OPTIONAL_FLAG) !=
=3D 0;
+    hdr->value_len =3D (uint16_t)len;
+    return true;
+}
+
+bool
=
+ctrl_msg_find_tlv(struct buffer *payload, uint16_t wanted_type, struct buf=
fer *value)
+{
+    struct ctrl_msg_tlv_header hdr;
+    while (ctrl_msg_tl=
v_read_header(payload, &hdr))
+    {
+        /* Take the value out of payl=
oad=2E This validates that the header's
+         * length is really there =
and advances past it in one step, so the TLV
+         * we are looking for=
 and the ones we skip are bounds-checked alike=2E */
+        uint8_t *v =
=3D buf_read_alloc(payload, hdr=2Evalue_len);
+        if (!v)
+        {
+=
            return false;
+        }
+        if (hdr=2Etype =3D=3D wanted_=
type)
+        {
+            buf_set_read(value, v, hdr=2Evalue_len);
+   =
         return true;
+        }
+        /* not the TLV we want: keep scan=
ning */
+    }
+    return false;
+}
diff --git a/src/openvpn/control_msg=
=2Eh b/src/openvpn/control_msg=2Eh
new file mode 100644
index 0000000=2E=2E=
e4c8b54
--- /dev/null
+++ b/src/openvpn/control_msg=2Eh
@@ -0,0 +1,101 @@
+=
/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *       =
      over a single TCP/UDP port, with support for SSL/TLS-based
+ *       =
      session authentication and key exchange,
+ *             packet encry=
ption, packet authentication, and
+ *             packet compression=2E
+ *=

+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  Th=
is program is free software; you can redistribute it and/or modify
+ *  it =
under the terms of the GNU General Public License version 2
+ *  as publish=
ed by the Free Software Foundation=2E
+ *
+ *  This program is distributed =
in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without =
even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICUL=
AR PURPOSE=2E  See the
+ *  GNU General Public License for more details=2E
=
+ *
+ *  You should have received a copy of the GNU General Public License =
along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses=
/>=2E
+ */
+
+/**
+ * @file
+ * Framing shared by the TLV-based control mes=
sages of the wire protocol=2E
+ *
+ * Such a message payload starts with a =
16-bit message type, followed by a
+ * sequence of TLV entries=2E Each TLV =
starts with a 4-byte header: a 16-bit field
+ * whose most significant bit =
is the "optional" flag and whose remaining 15 bits
+ * are the type, follow=
ed by a 16-bit length giving the size of the value that
+ * follows the hea=
der=2E
+ *
+ * The message-type and TLV-type values themselves are specific=
 to the message
+ * family carried (out-of-band messages define theirs in o=
ob=2Eh), so only the
+ * framing lives here=2E
+ */
+
+#ifndef CONTROL_MSG_=
H
+#define CONTROL_MSG_H
+
+#include "buffer=2Eh"
+
+/* TLV header bit layo=
ut of the first 16-bit field */
+#define CTRL_MSG_TLV_OPTIONAL_FLAG 0x8000
=
+#define CTRL_MSG_TLV_TYPE_MASK     0x7fff
+
+/* The header every TLV carri=
es: the 15-bit type and optional flag packed into
+ * the first 16-bit fiel=
d, then the length of the value that follows=2E */
+struct ctrl_msg_tlv_hea=
der
+{
+    uint16_t type;      /**< the 15-bit TLV type */
+    bool optio=
nal;      /**< value of the optional flag */
+    uint16_t value_len; /**< =
length of the value following the header */
+};
+
+/**
+ * Read and verify =
a message-type header from buf, advancing past it=2E
+ *
+ * @param buf    =
            buffer positioned at the message payload
+ * @param expected_ms=
g_type  the message type the payload must carry
+ * @return true if a messa=
ge type was read and equals expected_msg_type,
+ *         false on a short=
 buffer or a mismatching type=2E
+ */
+bool ctrl_msg_read_header(struct buf=
fer *buf, uint16_t expected_msg_type);
+
+/**
+ * Write a TLV header (type =
+ optional flag + value length) to buf=2E
+ *
+ * @return true on success, =
false if buf has insufficient space=2E
+ */
+bool ctrl_msg_tlv_write_header=
(struct buffer *buf, uint16_t type, bool optional,
+                       =
        uint16_t value_len);
+
+/**
+ * Read a TLV header from buf, advanci=
ng past it=2E
+ *
+ * @param buf  buffer positioned at the TLV header
+ * @=
param hdr  filled with the type, optional flag and value length on success
=
+ * @return true on success, false if there are not enough bytes for a head=
er=2E
+ */
+bool ctrl_msg_tlv_read_header(struct buffer *buf, struct ctrl_m=
sg_tlv_header *hdr);
+
+/**
+ * Scan payload for the first TLV of type want=
ed_type, skipping any other (e=2Eg=2E
+ * future) TLV types=2E
+ *
+ * On s=
uccess value covers exactly the found TLV's value bytes=2E The length from
=
+ * each TLV header is validated against payload as the scan goes, so the w=
hole
+ * value is guaranteed to be present; a header claiming more bytes th=
an payload
+ * holds is rejected rather than reported as found=2E payload i=
s consumed as it is
+ * read=2E
+ *
+ * @param payload      buffer position=
ed at a TLV header
+ * @param wanted_type  the TLV type to look for
+ * @pa=
ram value        set to a buffer covering the found TLV's value
+ * @return=
 true if the TLV was found, false if it is not present or a TLV
+ *        =
 header or value is malformed or truncated=2E
+ */
+bool ctrl_msg_find_tlv(=
struct buffer *payload, uint16_t wanted_type, struct buffer *value);
+
+#en=
dif /* ifndef CONTROL_MSG_H */
diff --git a/src/openvpn/oob=2Ec b/src/openv=
pn/oob=2Ec
new file mode 100644
index 0000000=2E=2Ec807171
--- /dev/null
++=
+ b/src/openvpn/oob=2Ec
@@ -0,0 +1,83 @@
+/*
+ *  OpenVPN -- An application=
 to securely tunnel IP networks
+ *             over a single TCP/UDP port,=
 with support for SSL/TLS-based
+ *             session authentication and =
key exchange,
+ *             packet encryption, packet authentication, and=

+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 Ope=
nVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you =
can redistribute it and/or modify
+ *  it under the terms of the GNU Genera=
l Public License version 2
+ *  as published by the Free Software Foundatio=
n=2E
+ *
+ *  This program is distributed in the hope that it will be usefu=
l,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * =
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU G=
eneral Public License for more details=2E
+ *
+ *  You should have received=
 a copy of the GNU General Public License along
+ *  with this program; if =
not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_=
H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "oob=
=2Eh"
+#include "control_msg=2Eh"
+
+bool
+oob_probe_parameter_write(struct=
 buffer *buf, const struct oob_probe_parameter *p)
+{
+    return ctrl_msg_=
tlv_write_header(buf, OOB_TLV_PROBE_PARAMETER, false, OOB_PROBE_PARAMETER_L=
EN)
+           && buf_write_u64(buf, p->timestamp)
+           && buf_writ=
e_u32(buf, p->flags);
+}
+
+bool
+oob_probe_parameter_read(struct buffer *b=
uf, struct oob_probe_parameter *p)
+{
+    /* One bounds check covers the w=
hole value: every field read below then fits
+     * by construction (OOB_P=
ROBE_PARAMETER_LEN is the sum of their sizes), so
+     * none of them need=
s its own error handling=2E Trailing bytes this version
+     * does not un=
derstand are simply left unread=2E */
+    if (buf_len(buf) < OOB_PROBE_PAR=
AMETER_LEN)
+    {
+        return false;
+    }
+    p->timestamp =3D buf_=
read_u64(buf, NULL);
+    p->flags =3D buf_read_u32(buf, NULL);
+    return=
 true;
+}
+
+bool
+oob_probe_reply_write(struct buffer *buf, const struct o=
ob_probe_reply *r)
+{
+    return ctrl_msg_tlv_write_header(buf, OOB_TLV_PR=
OBE_REPLY, false, OOB_PROBE_REPLY_LEN)
+           && session_id_write(&r->=
peer_session_id, buf)
+           && buf_write_u16(buf, r->priority)
+     =
      && buf_write_u16(buf, r->weight)
+           && buf_write_u16(buf, r-=
>max_latency_diff)
+           && buf_write_u16(buf, r->connect_lifetime)
+=
           && buf_write_u32(buf, r->flags);
+}
+
+bool
+oob_probe_reply_rea=
d(struct buffer *buf, struct oob_probe_reply *r)
+{
+    /* One bounds chec=
k for the whole value, as in oob_probe_parameter_read()=2E */
+    if (buf_=
len(buf) < OOB_PROBE_REPLY_LEN)
+    {
+        return false;
+    }
+    s=
ession_id_read(&r->peer_session_id, buf);
+    r->priority =3D (uint16_t)bu=
f_read_u16(buf);
+    r->weight =3D (uint16_t)buf_read_u16(buf);
+    r->ma=
x_latency_diff =3D (uint16_t)buf_read_u16(buf);
+    r->connect_lifetime =
=3D (uint16_t)buf_read_u16(buf);
+    r->flags =3D buf_read_u32(buf, NULL);=

+    return true;
+}
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2E=
h
new file mode 100644
index 0000000=2E=2E0a9a4bb
--- /dev/null
+++ b/src/o=
penvpn/oob=2Eh
@@ -0,0 +1,110 @@
+/*
+ *  OpenVPN -- An application to secu=
rely tunnel IP networks
+ *             over a single TCP/UDP port, with su=
pport for SSL/TLS-based
+ *             session authentication and key exch=
ange,
+ *             packet encryption, packet authentication, and
+ *    =
         packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc=
 <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you can redi=
stribute it and/or modify
+ *  it under the terms of the GNU General Public=
 License version 2
+ *  as published by the Free Software Foundation=2E
+ *=

+ *  This program is distributed in the hope that it will be useful,
+ *  =
but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHAN=
TABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General P=
ublic License for more details=2E
+ *
+ *  You should have received a copy =
of the GNU General Public License along
+ *  with this program; if not, see=
 <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @file
+ * Encoding/=
decoding of out-of-band (P_CONTROL_OOB_V1) control messages=2E
+ *
+ * An O=
OB message payload starts with a 16-bit message type (the 0x1xx space:
+ * =
SERVER_PROBE, PROBE_REPLY, =2E=2E=2E) followed by a sequence of TLV entries=
 in the
+ * 0x2xx type space=2E The framing itself is shared with the other=
 TLV-based
+ * control messages of the wire protocol and lives in control_m=
sg=2Eh; this file
+ * defines the OOB message and TLV types, their values, =
and the OOB-specific
+ * decisions taken on them=2E
+ */
+
+#ifndef OOB_H
+=
#define OOB_H
+
+#include "buffer=2Eh"
+#include "session_id=2Eh"
+
+/* OOB=
 message types: the 16-bit value at the start of an OOB payload, before
+ *=
 its TLV entries=2E Distinct from the TLV-type space (0x2xx); see the "Mess=
ages"
+ * table in the OOB section of the wire protocol spec=2E */
+#define=
 OOB_MSG_SERVER_PROBE 0x100
+#define OOB_MSG_PROBE_REPLY  0x101
+
+/* TLV t=
ypes (see the OOB control message section of the wire protocol spec) */
+#d=
efine OOB_TLV_PROBE_PARAMETER 0x200
+#define OOB_TLV_PROBE_REPLY     0x201
=
+
+/* Minimum on-wire value length (excluding the 4-byte TLV header) of eac=
h TLV:
+ * the sizes of its fixed fields in wire order (see the structs bel=
ow)=2E The
+ * value may be longer for forward compatibility; trailing byte=
s that are not
+ * understood are ignored on read=2E */
+#define OOB_PROBE_=
PARAMETER_LEN \
+    ((uint16_t)(sizeof(uint64_t) /* timestamp */ + sizeof(=
uint32_t) /* flags */))
+#define OOB_PROBE_REPLY_LEN                       =
            \
+    ((uint16_t)(SID_SIZE               /* peer_session_id */=
  \
+                + 4 * sizeof(uint16_t) /* priority, weight,   \
+     =
                                   * max_latency_diff,   \
+               =
                         * connect_lifetime */ \
+                + sizeof(=
uint32_t)))   /* flags */
+
+/* probe parameter TLV (sent by the client in =
a SERVER_PROBE) */
+struct oob_probe_parameter
+{
+    uint64_t timestamp; =
/**< client clock as a UNIX timestamp */
+    uint32_t flags;     /**< clie=
nt capability flags, currently must be 0 */
+};
+
+/* probe reply TLV (sent=
 by the server in a PROBE_REPLY) */
+struct oob_probe_reply
+{
+    struct =
session_id peer_session_id; /**< echoes the session id of the request */
+ =
   uint16_t priority;                 /**< DNS-SRV style priority (lower is=
 preferred) */
+    uint16_t weight;                   /**< DNS-SRV style w=
eight */
+    uint16_t max_latency_diff;         /**< advertised candidate-=
band margin in ms;
+                                        *   0 means "de=
fer to the client's setting" */
+    uint16_t connect_lifetime;         /**=
< seconds the reply stays valid as the handshake reset */
+    uint32_t fla=
gs;                    /**< server behaviour flags */
+};
+
+/**
+ * Write =
a complete probe parameter TLV (header + value) to buf=2E
+ */
+bool oob_pr=
obe_parameter_write(struct buffer *buf, const struct oob_probe_parameter *p=
);
+
+/**
+ * Read a probe parameter TLV value from buf=2E
+ *
+ * buf must=
 cover exactly the TLV's value, as returned by ctrl_msg_find_tlv()=2E
+ * T=
railing bytes beyond the fields understood here are ignored, so a longer
+ =
* value from a future version still parses=2E
+ *
+ * @return true on succe=
ss, false if buf is shorter than the mandatory fields=2E
+ */
+bool oob_pro=
be_parameter_read(struct buffer *buf, struct oob_probe_parameter *p);
+
+/*=
*
+ * Write a complete probe reply TLV (header + value) to buf=2E
+ */
+boo=
l oob_probe_reply_write(struct buffer *buf, const struct oob_probe_reply *r=
);
+
+/**
+ * Read a probe reply TLV value from buf=2E See oob_probe_parame=
ter_read() for the
+ * calling convention=2E
+ */
+bool oob_probe_reply_rea=
d(struct buffer *buf, struct oob_probe_reply *r);
+
+#endif /* OOB_H */
dif=
f --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 60df7ce=2E=2E9e1a=
6aa 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -3616,7 +=
3616,7 @@
     struct session_id sid; /* remote session ID */
 
     /* ver=
ify legal opcode */
-    if (op < P_FIRST_OPCODE || op > P_LAST_OPCODE)
+  =
  if (!opcode_valid_in_session(op))
     {
         if (op =3D=3D P_CONTROL=
_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)
        =
 {
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index f84=
44451=2E=2E0d882d9 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/s=
sl_pkt=2Ec
@@ -166,7 +166,7 @@
                    bool prepend_ack)
 {
   =
  ASSERT(ks->key_id >=3D 0 && ks->key_id <=3D P_KEY_ID_MASK);
-    ASSERT(o=
pcode >=3D 0 && opcode <=3D P_LAST_OPCODE);
+    ASSERT(opcode_valid_in_ses=
sion(opcode));
     uint8_t header =3D (uint8_t)(ks->key_id | (opcode << P_=
OPCODE_SHIFT));
 
     /* Workaround for Softether servers=2E Softether has=
 a bug that it only
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_=
pkt=2Eh
index 82cb5b1=2E=2E25e50bf 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++=
 b/src/openvpn/ssl_pkt=2Eh
@@ -58,11 +58,53 @@
  * like P_CONTROL_HARD_RESE=
T_CLIENT_V3 */
 #define P_CONTROL_WKC_V1 11
 
-/* define the range of legal=
 opcodes
+/* Out-of-band control message that does not belong to an establi=
shed
+ * control channel session (e=2Eg=2E a server probe)=2E Inherently un=
reliable:
+ * there is no protocol-level retransmission=2E
+ *
+ * It is no=
t legal on an established session; see opcode_valid_in_session()
+ * below=
=2E */
+#define P_CONTROL_OOB_V1 12
+
+/* define the range of defined opcod=
es, in- and out-of-band=2E Note this is not
+ * the set of opcodes legal on=
 an established session; see
+ * opcode_valid_in_session()=2E
  * Since we =
do no longer support key-method 1 we consider
  * the v1 op codes invalid *=
/
 #define P_FIRST_OPCODE 3
-#define P_LAST_OPCODE  11
+#define P_LAST_OPCO=
DE  12
+
+static inline bool
+opcode_is_oob(int op)
+{
+    return op =3D=
=3D P_CONTROL_OOB_V1;
+}
+
+/**
+ * Return true if op may occur on an estab=
lished control-channel session=2E
+ *
+ * Out-of-band opcodes may not=2E Th=
ey are answered statelessly on the
+ * new-connection path, and being rejec=
ted here is a permanent property rather
+ * than a handler that is still mi=
ssing:
+ *
+ *  - an OOB message carries its TLV payload directly, with no =
reliability or
+ *    ACK fields (see tls_wrap_oob_standalone()), whereas t=
he established-session
+ *    path parses an ACK array and a control packet=
-id before anything else=2E The
+ *    payload is chosen by the sender and =
session ids are plaintext on the wire,
+ *    so those bytes can be crafted=
 into a valid ACK array, forging ACKs into a
+ *    live control channel an=
d stalling a handshake or rekey=2E
+ *  - nothing on that path parses an OO=
B payload, so there is nothing to gain by
+ *    accepting one=2E
+ *
+ * T=
his cannot be expressed as an opcode range: the inband CONTROL_DATA_V1 of t=
he
+ * wire protocol is legal on an established session, so the OOB opcodes=
 sit
+ * between legal ones=2E
+ */
+static inline bool
+opcode_valid_in_se=
ssion(int op)
+{
+    return op >=3D P_FIRST_OPCODE && op <=3D P_LAST_OPCOD=
E && !opcode_is_oob(op);
+}
 
 /*
  * Define number of buffers for send and=
 receive in the reliability layer=2E
@@ -264,6 +306,9 @@
         case P_CO=
NTROL_WKC_V1:
             return "P_CONTROL_WKC_V1";
 
+        case P_CON=
TROL_OOB_V1:
+            return "P_CONTROL_OOB_V1";
+
         case P_ACK_=
V1:
             return "P_ACK_V1";
 
diff --git a/tests/unit_tests/openvpn=
/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index d861ef9=2E=2E=
611097a 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/uni=
t_tests/openvpn/Makefile=2Eam
@@ -14,6 +14,7 @@
 	ncp_testdriver \
 	mbuf_t=
estdriver \
 	misc_testdriver \
+	oob_testdriver \
 	options_parse_testdriv=
er \
 	packet_id_testdriver \
 	pkt_testdriver \
@@ -150,6 +151,20 @@
 	$(t=
op_srcdir)/src/openvpn/win32-util=2Ec \
 	$(top_srcdir)/src/openvpn/session=
_id=2Ec
 
+oob_testdriver_CFLAGS  =3D \
+	-I$(top_srcdir)/include -I$(top_s=
rcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	@TEST_CFLAGS@
+oob_testdr=
iver_LDFLAGS =3D @TEST_LDFLAGS@
+oob_testdriver_SOURCES =3D test_oob=2Ec \
=
+	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \
+	mock_get_random=2Ec \
+	$(t=
op_srcdir)/src/openvpn/buffer=2Ec \
+	$(top_srcdir)/src/openvpn/control_msg=
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
index 0000000=2E=2Eaa4eb23
--- =
/dev/null
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -0,0 +1,277 @@
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
+#include "control_msg=2Eh"
+#include "=
oob=2Eh"
+#include "test_common=2Eh"
+
+/* Write a probe parameter TLV and =
read it back; fields must survive the
+ * round trip and the whole buffer m=
ust be consumed=2E */
+static void
+test_probe_parameter_roundtrip(void **s=
tate)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D a=
lloc_buf_gc(128, &gc);
+
+    const struct oob_probe_parameter in =3D {
+  =
      =2Etimestamp =3D 0x0123456789abcdefULL,
+        =2Eflags =3D 0,
+   =
 };
+    assert_true(oob_probe_parameter_write(&buf, &in));
+    /* header =
(4) + value (12) */
+    assert_int_equal(BLEN(&buf), 4 + OOB_PROBE_PARAMET=
ER_LEN);
+
+    /* the header codec, read from a copy so the scan below sti=
ll sees it */
+    struct buffer peek =3D buf;
+    struct ctrl_msg_tlv_hea=
der hdr;
+    assert_true(ctrl_msg_tlv_read_header(&peek, &hdr));
+    asse=
rt_int_equal(hdr=2Etype, OOB_TLV_PROBE_PARAMETER);
+    assert_false(hdr=2E=
optional);
+    assert_int_equal(hdr=2Evalue_len, OOB_PROBE_PARAMETER_LEN);=

+
+    struct buffer value;
+    assert_true(ctrl_msg_find_tlv(&buf, OOB_T=
LV_PROBE_PARAMETER, &value));
+    assert_int_equal(BLEN(&value), OOB_PROBE=
_PARAMETER_LEN);
+
+    struct oob_probe_parameter out =3D { 0 };
+    asse=
rt_true(oob_probe_parameter_read(&value, &out));
+    assert_true(in=2Etime=
stamp =3D=3D out=2Etimestamp);
+    assert_int_equal(in=2Eflags, out=2Eflag=
s);
+    /* the scan consumed header and value alike */
+    assert_int_equ=
al(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* Write a probe reply TLV an=
d read it back=2E */
+static void
+test_probe_reply_roundtrip(void **state)=

+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_=
buf_gc(128, &gc);
+
+    struct oob_probe_reply in =3D {
+        =2Epriori=
ty =3D 10,
+        =2Eweight =3D 100,
+        =2Econnect_lifetime =3D 30,=

+        =2Eflags =3D 1,
+        =2Emax_latency_diff =3D 25,
+    };
+   =
 memcpy(in=2Epeer_session_id=2Eid, "ABCDEFGH", SID_SIZE);
+
+    assert_tru=
e(oob_probe_reply_write(&buf, &in));
+    assert_int_equal(BLEN(&buf), 4 + =
OOB_PROBE_REPLY_LEN);
+
+    struct buffer peek =3D buf;
+    struct ctrl_m=
sg_tlv_header hdr;
+    assert_true(ctrl_msg_tlv_read_header(&peek, &hdr));=

+    assert_int_equal(hdr=2Etype, OOB_TLV_PROBE_REPLY);
+    assert_int_eq=
ual(hdr=2Evalue_len, OOB_PROBE_REPLY_LEN);
+
+    struct buffer value;
+   =
 assert_true(ctrl_msg_find_tlv(&buf, OOB_TLV_PROBE_REPLY, &value));
+
+    =
struct oob_probe_reply out =3D { 0 };
+    assert_true(oob_probe_reply_read=
(&value, &out));
+    assert_memory_equal(in=2Epeer_session_id=2Eid, out=2E=
peer_session_id=2Eid, SID_SIZE);
+    assert_int_equal(in=2Epriority, out=
=2Epriority);
+    assert_int_equal(in=2Eweight, out=2Eweight);
+    assert=
_int_equal(in=2Econnect_lifetime, out=2Econnect_lifetime);
+    assert_int_=
equal(in=2Eflags, out=2Eflags);
+    assert_int_equal(in=2Emax_latency_diff=
, out=2Emax_latency_diff);
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_=
free(&gc);
+}
+
+/* The probe reply wire format is locked to the spec's fie=
ld order
+ * (priority, weight, max_latency_diff, connect_lifetime, flags),=
 big-endian=2E */
+static void
+test_probe_reply_wire_format(void **state)
=
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_b=
uf_gc(128, &gc);
+
+    struct oob_probe_reply in =3D {
+        =2Epriorit=
y =3D 10,
+        =2Eweight =3D 100,
+        =2Econnect_lifetime =3D 30,
=
+        =2Eflags =3D 1,
+        =2Emax_latency_diff =3D 25,
+    };
+    =
memcpy(in=2Epeer_session_id=2Eid, "ABCDEFGH", SID_SIZE);
+
+    assert_true=
(oob_probe_reply_write(&buf, &in));
+
+    const uint8_t expected[] =3D {
+=
        0x02,
+        0x01, /* TLV type 0x201 (not optional) */
+        0=
x00,
+        0x14, /* TLV value length =3D 20 */
+        'A',
+        'B=
',
+        'C',
+        'D',
+        'E',
+        'F',
+        'G',
+ =
       'H',  /* peer_session_id */
+        0x00,
+        0x0a, /* priorit=
y =3D 10 */
+        0x00,
+        0x64, /* weight =3D 100 */
+        0x0=
0,
+        0x19, /* max_latency_diff =3D 25 */
+        0x00,
+        0x1=
e, /* connect_lifetime =3D 30 */
+        0x00,
+        0x00,
+        0x0=
0,
+        0x01, /* flags =3D 1 */
+    };
+    assert_int_equal(BLEN(&buf=
), sizeof(expected));
+    assert_memory_equal(BPTR(&buf), expected, sizeof=
(expected));
+
+    gc_free(&gc);
+}
+
+/* A TLV with a longer-than-known v=
alue must still parse: the known fields are
+ * read and the trailing bytes=
 are skipped (forward compatibility)=2E */
+static void
+test_probe_paramet=
er_forward_compat(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+ =
   struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const uint16_t exte=
nded_len =3D OOB_PROBE_PARAMETER_LEN + 4;
+    assert_true(ctrl_msg_tlv_wri=
te_header(&buf, OOB_TLV_PROBE_PARAMETER, false, extended_len));
+    assert=
_true(buf_write_u32(&buf, 0));          /* timestamp high */
+    assert_tr=
ue(buf_write_u32(&buf, 0xdeadbeef)); /* timestamp low */
+    assert_true(b=
uf_write_u32(&buf, 0));          /* flags */
+    assert_true(buf_write_u32=
(&buf, 0x11223344)); /* unknown trailing field */
+
+    struct buffer valu=
e;
+    assert_true(ctrl_msg_find_tlv(&buf, OOB_TLV_PROBE_PARAMETER, &value=
));
+    assert_int_equal(BLEN(&value), extended_len);
+
+    struct oob_pr=
obe_parameter out =3D { 0 };
+    assert_true(oob_probe_parameter_read(&val=
ue, &out));
+    assert_true(out=2Etimestamp =3D=3D 0xdeadbeefULL);
+    as=
sert_int_equal(out=2Eflags, 0);
+    /* the unknown trailing field must hav=
e been consumed from the payload */
+    assert_int_equal(BLEN(&buf), 0);
+=

+    gc_free(&gc);
+}
+
+/* A value shorter than the mandatory fields must=
 be rejected, even when it
+ * holds enough bytes for some of the individua=
l fields to read successfully=2E */
+static void
+test_probe_parameter_too_=
short(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct bu=
ffer buf =3D alloc_buf_gc(128, &gc);
+
+    /* 4 of the 12 mandatory value =
bytes: too short for the timestamp, but
+     * enough for a u32 read to su=
cceed on its own */
+    assert_true(buf_write_u32(&buf, 0xdeadbeef));
+
+ =
   struct oob_probe_parameter out =3D { 0 };
+    assert_false(oob_probe_pa=
rameter_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* A TLV header claim=
ing more value bytes than the payload holds must be
+ * rejected by the sca=
n rather than reported as found -- for the TLV being
+ * looked for as much=
 as for one that would merely be skipped=2E */
+static void
+test_find_tlv_=
value_truncated(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+   =
 struct buffer value;
+
+    /* the wanted TLV declares 12 value bytes, onl=
y 4 are present */
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+    =
assert_true(ctrl_msg_tlv_write_header(&buf, OOB_TLV_PROBE_PARAMETER, false,=

+                                          OOB_PROBE_PARAMETER_LEN));
+   =
 assert_true(buf_write_u32(&buf, 0xdeadbeef));
+    assert_false(ctrl_msg_f=
ind_tlv(&buf, OOB_TLV_PROBE_PARAMETER, &value));
+
+    /* same defect on a=
 TLV that would be skipped: the scan must not walk past
+     * the end of =
the payload looking for the next header */
+    struct buffer buf2 =3D allo=
c_buf_gc(128, &gc);
+    assert_true(ctrl_msg_tlv_write_header(&buf2, 0x7ff=
, false, 64));
+    assert_true(buf_write_u32(&buf2, 0));
+    assert_false=
(ctrl_msg_find_tlv(&buf2, OOB_TLV_PROBE_PARAMETER, &value));
+
+    gc_free=
(&gc);
+}
+
+/* Reading a TLV header must fail when the buffer holds less d=
ata than a
+ * complete 4-byte header (empty, or only the type field), rath=
er than read
+ * past the available data=2E */
+static void
+test_tlv_heade=
r_truncated(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    str=
uct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    struct ctrl_msg_tlv_heade=
r hdr;
+
+    /* empty buffer */
+    assert_false(ctrl_msg_tlv_read_header=
(&buf, &hdr));
+
+    /* only the type field present, no length */
+    ass=
ert_true(buf_write_u16(&buf, OOB_TLV_PROBE_PARAMETER));
+    assert_false(c=
trl_msg_tlv_read_header(&buf, &hdr));
+
+    gc_free(&gc);
+}
+
+int
+main(=
void)
+{
+    openvpn_unit_test_setup();
+    const struct CMUnitTest tests=
[] =3D {
+        cmocka_unit_test(test_probe_parameter_roundtrip),
+      =
  cmocka_unit_test(test_probe_reply_roundtrip),
+        cmocka_unit_test(t=
est_probe_reply_wire_format),
+        cmocka_unit_test(test_probe_paramete=
r_forward_compat),
+        cmocka_unit_test(test_probe_parameter_too_short=
),
+        cmocka_unit_test(test_find_tlv_value_truncated),
+        cmock=
a_unit_test(test_tlv_header_truncated),
+    };
+
+    return cmocka_run_gr=
oup_tests_name("oob tests", tests, NULL, NULL);
+}

-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268=

Gerrit-Change-Number: 1741
Gerrit-PatchSet: 9
Gerrit-Owner: stipa <lstipak=
ov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--Maknr33Z7BQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, stipa=2E </p>
<p>stipa <strong>uploaded=
 patch set #9</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><p>The follow=
ing approvals got outdated and were removed:
Code-Review+2 by flichtenheld<=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">oob: Add control message TLV encoding (P_CONTROL_OOB_V1)<b=
r><br>Add opcode 12 for out-of-band control messages and the TLV codec for =
the<br>SERVER_PROBE and PROBE_REPLY used by server latency checks=2E<br><br=
>The framing is not OOB-specific, so it goes into its own control_msg=2Ec/h=
;<br>oob=2Ec keeps the OOB message and TLV types=2E<br><br>P_LAST_OPCODE be=
comes 12, and opcode_valid_in_session() replaces the plain<br>range check b=
ecause OOB opcodes are answered statelessly and are never legal<br>on an es=
tablished session=2E<br><br>Change-Id: I1c8d302ac57c5603d622a7be14be3694373=
88268<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M =
CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>A src/openvpn/control_ms=
g=2Ec<br>A src/openvpn/control_msg=2Eh<br>A src/openvpn/oob=2Ec<br>A src/op=
envpn/oob=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M sr=
c/openvpn/ssl_pkt=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A test=
s/unit_tests/openvpn/test_oob=2Ec<br>11 files changed, 739 insertions(+), 4=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/41/1741/9</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2E=
txt b/CMakeLists=2Etxt</span><br><span>index 7473f15=2E=2Ef4b1b22 100644</s=
pan><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt=
</span><br><span>@@ -444,6 +444,8 @@</span><br><span>     src/openvpn/conso=
le=2Ec</span><br><span>     src/openvpn/console_builtin=2Ec</span><br><span=
>     src/openvpn/console=2Eh</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    src/openvpn/control_msg=2Ec</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    src/openvpn/control_msg=2Eh</span><br><span>     =
src/openvpn/crypto=2Ec</span><br><span>     src/openvpn/crypto=2Eh</span><b=
r><span>     src/openvpn/crypto_backend=2Eh</span><br><span>@@ -520,6 +522,=
8 @@</span><br><span>     src/openvpn/multi_io=2Ec</span><br><span>     src=
/openvpn/occ=2Ec</span><br><span>     src/openvpn/occ=2Eh</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/oob=2Ec</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/oob=2Eh</span><br=
><span>     src/openvpn/openvpn=2Ec</span><br><span>     src/openvpn/openvp=
n=2Eh</span><br><span>     src/openvpn/openvpn_win32_resources=2Erc</span><=
br><span>@@ -667,6 +671,7 @@</span><br><span>         &quot;test_mbuf&quot;=
</span><br><span>         &quot;test_misc&quot;</span><br><span>         &q=
uot;test_ncp&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       &quot;test_oob&quot;</span><br><span>         &quot;test_options_par=
se&quot;</span><br><span>         &quot;test_packet_id&quot;</span><br><spa=
n>         &quot;test_pkt&quot;</span><br><span>@@ -858,6 +863,13 @@</span>=
<br><span>         src/openvpn/session_id=2Ec</span><br><span>         )</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
target_sources(test_oob PRIVATE</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        tests/unit_tests/openvpn/mock_get_random=2Ec</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/control_ms=
g=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/op=
envpn/oob=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  src/openvpn/session_id=2Ec</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span>     target_sources(test_pkt PRIVATE</span><br><span>      =
   tests/unit_tests/openvpn/mock_win32_execve=2Ec</span><br><span>         =
src/openvpn/argv=2Ec</span><br><span>diff --git a/src/openvpn/Makefile=2Eam=
 b/src/openvpn/Makefile=2Eam</span><br><span>index ff8cc54=2E=2Ea67d478 100=
644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/s=
rc/openvpn/Makefile=2Eam</span><br><span>@@ -52,6 +52,7 @@</span><br><span>=
 	common=2Eh \</span><br><span> 	comp=2Ec comp=2Eh compstub=2Ec \</span><br=
><span> 	comp-lz4=2Ec comp-lz4=2Eh \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	control_msg=2Ec control_msg=2Eh \</span><br><span> 	crypt=
o=2Ec crypto=2Eh crypto_backend=2Eh \</span><br><span> 	crypto_openssl=2Ec =
crypto_openssl=2Eh \</span><br><span> 	crypto_mbedtls_legacy=2Ec crypto_mbe=
dtls_legacy=2Eh \</span><br><span>@@ -106,6 +107,7 @@</span><br><span> 	pkc=
s11=2Ec pkcs11=2Eh pkcs11_backend=2Eh \</span><br><span> 	pkcs11_openssl=2E=
c \</span><br><span> 	pkcs11_mbedtls=2Ec \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	oob=2Ec oob=2Eh \</span><br><span> 	openvpn=2Ec ope=
nvpn=2Eh \</span><br><span> 	options=2Ec options=2Eh \</span><br><span> 	op=
tions_util=2Ec options_util=2Eh \</span><br><span>diff --git a/src/openvpn/=
control_msg=2Ec b/src/openvpn/control_msg=2Ec</span><br><span>new file mode=
 100644</span><br><span>index 0000000=2E=2E95ff210</span><br><span>--- /dev=
/null</span><br><span>+++ b/src/openvpn/control_msg=2Ec</span><br><span>@@ =
-0,0 +1,90 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</sp=
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
eader hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while=
 (ctrl_msg_tlv_read_header(payload, &amp;hdr))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        /* Take the value out of payload=2E This validates tha=
t the header&#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        * length is really there and advances past it in one step, so the T=
LV</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * we are=
 looking for and the ones we skip are bounds-checked alike=2E */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        uint8_t *v =3D buf_rea=
d_alloc(payload, hdr=2Evalue_len);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!v)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (hdr=2Etype =3D=3D wanted_type)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            buf_set_read(value, v, hdr=2Evalue_len);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            return true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        /* not the TLV we want: keep =
scanning */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff -=
-git a/src/openvpn/control_msg=2Eh b/src/openvpn/control_msg=2Eh</span><br>=
<span>new file mode 100644</span><br><span>index 0000000=2E=2Ee4c8b54</span=
><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/control_msg=2Eh<=
/span><br><span>@@ -0,0 +1,101 @@</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 OpenVPN -- An application to securely tunnel IP networks</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP =
port, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             session authentication and key exchange,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet =
encryption, packet authentication, and</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             packet compression=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvp=
n=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free =
software; you can redistribute it and/or modify</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Publi=
c License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  as published by the Free Software Foundation=2E</span><br><span style=
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
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Framing shared by the TLV-based control messages of the wire protocol=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Such a message payload starts =
with a 16-bit message type, followed by a</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * sequence of TLV entries=2E Each TLV starts with a =
4-byte header: a 16-bit field</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * whose most significant bit is the &quot;optional&quot; flag an=
d whose remaining 15 bits</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * are the type, followed by a 16-bit length giving the size of the v=
alue that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * follows=
 the header=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The message-type an=
d TLV-type values themselves are specific to the message</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * family carried (out-of-band message=
s define theirs in oob=2Eh), so only the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * framing lives here=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef C=
ONTROL_MSG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 CONTROL_MSG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* TLV header bit layout of the=
 first 16-bit field */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define CTRL_MSG_TLV_OPTIONAL_FLAG 0x8000</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define CTRL_MSG_TLV_TYPE_MASK     0x7fff</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* The header every TLV carries: the 15-bit typ=
e and optional flag packed into</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * the first 16-bit field, then the length of the value that fo=
llows=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct c=
trl_msg_tlv_header</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t type; =
     /**&lt; the 15-bit TLV type */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    bool optional;      /**&lt; value of the optional flag =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t valu=
e_len; /**&lt; length of the value following the header */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read and v=
erify a message-type header from buf, advancing past it=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param buf                buffer positioned at the=
 message payload</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param expected_msg_type  the message type the payload must carry</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if a message =
type was read and equals expected_msg_type,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *         false on a short buffer or a mismatching=
 type=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_read_header(s=
truct buffer *buf, uint16_t expected_msg_type);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Writ=
e a TLV header (type + optional flag + value length) to buf=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @return true on success, false if buf has insu=
fficient space=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_=
write_header(struct buffer *buf, uint16_t type, bool optional,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                               u=
int16_t value_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Read a TLV header from buf, adva=
ncing past it=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf  buffe=
r positioned at the TLV header</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param hdr  filled with the type, optional flag and value len=
gth on success</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @r=
eturn true on success, false if there are not enough bytes for a header=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_read_header(struct=
 buffer *buf, struct ctrl_msg_tlv_header *hdr);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Scan=
 payload for the first TLV of type wanted_type, skipping any other (e=2Eg=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * future) TLV t=
ypes=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * On success value covers ex=
actly the found TLV&#39;s value bytes=2E The length from</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * each TLV header is validated agains=
t payload as the scan goes, so the whole</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * value is guaranteed to be present; a header claimin=
g more bytes than payload</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * holds is rejected rather than reported as found=2E payload is cons=
umed as it is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rea=
d=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param payload      buffer po=
sitioned at a TLV header</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param wanted_type  the TLV type to look for</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param value        set to a buffer co=
vering the found TLV&#39;s value</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @return true if the TLV was found, false if it is not prese=
nt or a TLV</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      =
   header or value is malformed or truncated=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+bool ctrl_msg_find_tlv(struct buffer *payload, uint16_t wanted_=
type, struct buffer *value);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* =
ifndef CONTROL_MSG_H */</span><br><span>diff --git a/src/openvpn/oob=2Ec b/=
src/openvpn/oob=2Ec</span><br><span>new file mode 100644</span><br><span>in=
dex 0000000=2E=2Ec807171</span><br><span>--- /dev/null</span><br><span>+++ =
b/src/openvpn/oob=2Ec</span><br><span>@@ -0,0 +1,83 @@</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP netwo=
rks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             o=
ver a single TCP/UDP port, with support for SSL/TLS-based</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             session authentication=
 and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*             packet encryption, packet authentication, and</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=
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
lor: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+oob_probe_parameter_write(struct buffer *buf, const str=
uct oob_probe_parameter *p)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 ctrl_msg_tlv_write_header(buf, OOB_TLV_PROBE_PARAMETER, false, OOB_PROBE_P=
ARAMETER_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
     &amp;&amp; buf_write_u64(buf, p-&gt;timestamp)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u32(buf, =
p-&gt;flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+oob_probe_parameter_read(struct buffer *buf, struct oob_=
probe_parameter *p)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* One bounds =
check covers the whole value: every field read below then fits</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * by construction (OOB_PROB=
E_PARAMETER_LEN is the sum of their sizes), so</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * none of them needs its own error handling=
=2E Trailing bytes this version</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * does not understand are simply left unread=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(buf) &lt; O=
OB_PROBE_PARAMETER_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    p-&gt;timestamp =
=3D buf_read_u64(buf, NULL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    p-&gt;flags =3D buf_read_u32(buf, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_reply_write=
(struct buffer *buf, const struct oob_probe_reply *r)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return ctrl_msg_tlv_write_header(buf, OOB_TLV_PROBE_REP=
LY, false, OOB_PROBE_REPLY_LEN)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+           &amp;&amp; session_id_write(&amp;r-&gt;peer_session_=
id, buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
&amp;&amp; buf_write_u16(buf, r-&gt;priority)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16(buf, r-&gt;we=
ight)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &am=
p;&amp; buf_write_u16(buf, r-&gt;max_latency_diff)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16(buf, r-&=
gt;connect_lifetime)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+           &amp;&amp; buf_write_u32(buf, r-&gt;flags);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
ool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_reply_=
read(struct buffer *buf, struct oob_probe_reply *r)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* One bounds check for the whole value, as in oob_prob=
e_parameter_read()=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (buf_len(buf) &lt; OOB_PROBE_REPLY_LEN)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    session_id_read(&amp;r-&gt;peer_session_id, buf);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;priority =3D (uint16_t)=
buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   r-&gt;weight =3D (uint16_t)buf_read_u16(buf);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    r-&gt;max_latency_diff =3D (uint16_t)buf_r=
ead_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-=
&gt;connect_lifetime =3D (uint16_t)buf_read_u16(buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    r-&gt;flags =3D buf_read_u32(buf, NUL=
L);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>d=
iff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>new f=
ile mode 100644</span><br><span>index 0000000=2E=2E0a9a4bb</span><br><span>=
--- /dev/null</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ =
-0,0 +1,110 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An appl=
ication to securely tunnel IP networks</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             over a single TCP/UDP port, with support =
for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
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
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @fil=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Encoding/decodi=
ng of out-of-band (P_CONTROL_OOB_V1) control messages=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * An OOB message payload starts with a 16-bit message =
type (the 0x1xx space:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * SERVER_PROBE, PROBE_REPLY, =2E=2E=2E) followed by a sequence of TLV e=
ntries in the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * 0x2=
xx type space=2E The framing itself is shared with the other TLV-based</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * control messages of t=
he wire protocol and lives in control_msg=2Eh; this file</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * defines the OOB message and TLV typ=
es, their values, and the OOB-specific</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * decisions taken on them=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnde=
f OOB_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_=
H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;session_id=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* OOB message types: the 16=
-bit value at the start of an OOB payload, before</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * its TLV entries=2E Distinct from the TLV-t=
ype space (0x2xx); see the &quot;Messages&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * table in the OOB section of the wire protoco=
l spec=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 OOB_MSG_SERVER_PROBE 0x100</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define OOB_MSG_PROBE_REPLY  0x101</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* TLV types (see the OOB control message section of the wire protocol =
spec) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB=
_TLV_PROBE_PARAMETER 0x200</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define OOB_TLV_PROBE_REPLY     0x201</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/* Minimum on-wire value length (excluding the 4-byte TLV header) of =
each TLV:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the siz=
es of its fixed fields in wire order (see the structs below)=2E The</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * value may be longer for =
forward compatibility; trailing bytes that are not</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * understood are ignored on read=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_PROBE_PARAME=
TER_LEN \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ((uint=
16_t)(sizeof(uint64_t) /* timestamp */ + sizeof(uint32_t) /* flags */))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_PROBE_REPLY=
_LEN                                   \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ((uint16_t)(SID_SIZE               /* peer_session=
_id */  \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      + 4 * sizeof(uint16_t) /* priority, weight,   \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                        *=
 max_latency_diff,   \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                        * connect_lifetime */ \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                + sizeof(uin=
t32_t)))   /* flags */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* probe paramet=
er TLV (sent by the client in a SERVER_PROBE) */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+struct oob_probe_parameter</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    uint64_t timestamp; /**&lt; client clock as a UNIX ti=
mestamp */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint3=
2_t flags;     /**&lt; client capability flags, currently must be 0 */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* probe reply TLV (sent by the server in a PROBE_REPLY) */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct oob_probe_rep=
ly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct session_id peer_session_=
id; /**&lt; echoes the session id of the request */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint16_t priority;                 /*=
*&lt; DNS-SRV style priority (lower is preferred) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint16_t weight;                   /*=
*&lt; DNS-SRV style weight */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    uint16_t max_latency_diff;         /**&lt; advertised candida=
te-band margin in ms;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                        *   0 means &quot;defer to the cl=
ient&#39;s setting&quot; */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    uint16_t connect_lifetime;         /**&lt; seconds the reply st=
ays valid as the handshake reset */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    uint32_t flags;                    /**&lt; server behav=
iour flags */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Write a complete probe parameter TLV (header + value) =
to buf=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_probe_parameter_w=
rite(struct buffer *buf, const struct oob_probe_parameter *p);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Read a probe parameter TLV value from buf=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * buf must cover exactly the TLV&#39;s value, as return=
ed by ctrl_msg_find_tlv()=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Trailing bytes beyond the fields understood here are ignored, s=
o a longer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * value =
from a future version still parses=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @return true on success, false if buf is shorter than the mandatory fie=
lds=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_probe_parameter_read=
(struct buffer *buf, struct oob_probe_parameter *p);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Write a complete probe reply TLV (header + value) to buf=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+bool oob_probe_reply_write(struct buffer *buf, co=
nst struct oob_probe_reply *r);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read a probe reply T=
LV value from buf=2E See oob_probe_parameter_read() for the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * calling convention=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+bool oob_probe_reply_read(struct buffer *buf, =
struct oob_probe_reply *r);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* O=
OB_H */</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=
=2Ec</span><br><span>index 60df7ce=2E=2E9e1a6aa 100644</span><br><span>--- =
a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><=
span>@@ -3616,7 +3616,7 @@</span><br><span>     struct session_id sid; /* r=
emote session ID */</span><br><span> </span><br><span>     /* verify legal =
opcode */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (op &=
lt; P_FIRST_OPCODE || op &gt; P_LAST_OPCODE)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!opcode_valid_in_session(op))</span><br><s=
pan>     {</span><br><span>         if (op =3D=3D P_CONTROL_HARD_RESET_CLIE=
NT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)</span><br><span>        =
 {</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_p=
kt=2Ec</span><br><span>index f8444451=2E=2E0d882d9 100644</span><br><span>-=
-- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec<=
/span><br><span>@@ -166,7 +166,7 @@</span><br><span>                    boo=
l prepend_ack)</span><br><span> {</span><br><span>     ASSERT(ks-&gt;key_id=
 &gt;=3D 0 &amp;&amp; ks-&gt;key_id &lt;=3D P_KEY_ID_MASK);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(opcode &gt;=3D 0 &amp;&amp=
; opcode &lt;=3D P_LAST_OPCODE);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    ASSERT(opcode_valid_in_session(opcode));</span><br><span> =
    uint8_t header =3D (uint8_t)(ks-&gt;key_id | (opcode &lt;&lt; P_OPCODE_=
SHIFT));</span><br><span> </span><br><span>     /* Workaround for Softether=
 servers=2E Softether has a bug that it only</span><br><span>diff --git a/s=
rc/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index 82cb=
5b1=2E=2E25e50bf 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span=
><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -58,11 +58,53 @=
@</span><br><span>  * like P_CONTROL_HARD_RESET_CLIENT_V3 */</span><br><spa=
n> #define P_CONTROL_WKC_V1 11</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-/* define the range of legal opcodes</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* Out-of-band control message =
that does not belong to an established</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * control channel session (e=2Eg=2E a server probe)=2E =
Inherently unreliable:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * there is no protocol-level retransmission=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * It is not legal on an established session; see opcode_vali=
d_in_session()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * be=
low=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define P_=
CONTROL_OOB_V1 12</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* define the range o=
f defined opcodes, in- and out-of-band=2E Note this is not</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * the set of opcodes legal on an es=
tablished session; see</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * opcode_valid_in_session()=2E</span><br><span>  * Since we do no longe=
r support key-method 1 we consider</span><br><span>  * the v1 op codes inva=
lid */</span><br><span> #define P_FIRST_OPCODE 3</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define P_LAST_OPCODE  11</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define P_LAST_OPCODE  12</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static inline bool</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+opcode_is_oob(int op)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return op =3D=3D P_CONTROL_OOB_V1;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Return true if op may occur=
 on an established control-channel session=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Out-of-band opcodes may not=2E They are answered statelessly on=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * new-connecti=
on path, and being rejected here is a permanent property rather</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * than a handler that is still=
 missing:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  - an OOB message carrie=
s its TLV payload directly, with no reliability or</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *    ACK fields (see tls_wrap_oob_standalon=
e()), whereas the established-session</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *    path parses an ACK array and a control packet-id be=
fore anything else=2E The</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *    payload is chosen by the sender and session ids are plaintext o=
n the wire,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    so=
 those bytes can be crafted into a valid ACK array, forging ACKs into a</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    live control chan=
nel and stalling a handshake or rekey=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  - nothing on that path parses an OOB payload, so t=
here is nothing to gain by</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *    accepting one=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This=
 cannot be expressed as an opcode range: the inband CONTROL_DATA_V1 of the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * wire protocol is =
legal on an established session, so the OOB opcodes sit</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * between legal ones=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static inline bool</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+opcode_valid_in_session(int op)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return op &gt;=3D P_FIRST_OPCODE &amp;&amp; op &lt;=
=3D P_LAST_OPCODE &amp;&amp; !opcode_is_oob(op);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> /*</span>=
<br><span>  * Define number of buffers for send and receive in the reliabil=
ity layer=2E</span><br><span>@@ -264,6 +306,9 @@</span><br><span>         c=
ase P_CONTROL_WKC_V1:</span><br><span>             return &quot;P_CONTROL_W=
KC_V1&quot;;</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        case P_CONTROL_OOB_V1:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            return &quot;P_CONTROL_OOB_V1&quot;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>       =
  case P_ACK_V1:</span><br><span>             return &quot;P_ACK_V1&quot;;<=
/span><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/Mak=
efile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index d=
861ef9=2E=2E611097a 100644</span><br><span>--- a/tests/unit_tests/openvpn/M=
akefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</=
span><br><span>@@ -14,6 +14,7 @@</span><br><span> 	ncp_testdriver \</span><=
br><span> 	mbuf_testdriver \</span><br><span> 	misc_testdriver \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	oob_testdriver \</span><br><s=
pan> 	options_parse_testdriver \</span><br><span> 	packet_id_testdriver \</=
span><br><span> 	pkt_testdriver \</span><br><span>@@ -150,6 +151,20 @@</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><br><span> 	=
$(top_srcdir)/src/openvpn/session_id=2Ec</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+oob_testdriver_CFLAGS  =3D \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdir)/include -I=
$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	@TEST_CFLAGS@</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+oob_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_testdriver_SOURCES =
=3D test_oob=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	mock_get_random=2Ec \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/c=
ontrol_msg=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(=
top_srcdir)/src/openvpn/oob=2Ec \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/session_id=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir=
)/src/openvpn/win32-util=2Ec</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> pkt_testdriver_CFLAGS  =3D \</span><br><span> 	-=
I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openv=
pn \</span><br><span> 	@TEST_CFLAGS@</span><br><span>diff --git a/tests/uni=
t_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span>=
<br><span>new file mode 100644</span><br><span>index 0000000=2E=2Eaa4eb23</=
span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn=
/test_oob=2Ec</span><br><span>@@ -0,0 +1,277 @@</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a s=
ingle TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             session authentication and ke=
y exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      =
       packet encryption, packet authentication, and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &=
lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This p=
rogram is free software; you can redistribute it and/or modify</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GN=
U General Public License version 2</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  as published by the Free Software Foundation=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope t=
hat it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FI=
TNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of=
 the GNU General Public License along</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=
=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &lt;stdarg=2Eh&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &lt;stddef=2Eh&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
test_common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Write a probe =
parameter TLV and read it back; fields must survive the</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * round trip and the whole buffer must=
 be consumed=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_prob=
e_parameter_roundtrip(void **state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const struct oob_probe_parameter in =3D {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Etimestam=
p =3D 0x0123456789abcdefULL,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        =2Eflags =3D 0,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(oob_probe_parameter_write(&amp;buf, &amp;in));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* header (4) + value (12) *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(BLEN(&amp;buf), 4 + OOB_PROBE_PARAMETER_LEN);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* the header codec, read from a copy so the scan below still=
 sees it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct buffer peek =3D buf;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_read_header(&amp;peek, &am=
p;hdr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(hdr=2Etype, OOB_TLV_PROBE_PARAMETER);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_false(hdr=2Eoptional);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Evalue_=
len, OOB_PROBE_PARAMETER_LEN);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(ctrl_msg_find_tlv(&amp;buf, OOB_TLV_PROBE_PARAMETER, &amp;valu=
e));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(BLEN(&amp;value), OOB_PROBE_PARAMETER_LEN);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct oob_probe_parameter out =3D { 0 };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_parameter_re=
ad(&amp;value, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_true(in=2Etimestamp =3D=3D out=2Etimestamp);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Eflags,=
 out=2Eflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* the scan consumed header and value alike */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Writ=
e a probe reply TLV and read it back=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_probe_reply_roundtrip(void **state)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(1=
28, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_repl=
y in =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
=2Epriority =3D 10,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        =2Eweight =3D 100,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        =2Econnect_lifetime =3D 30,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        =2Eflags =3D 1,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        =2Emax_latency_diff =3D 25,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    memcpy(in=2Epeer_session_id=2Eid, &quot;A=
BCDEFGH&quot;, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(oob_probe_reply_write(&amp;buf, &amp;in));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 4 + OOB_PROB=
E_REPLY_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer peek =
=3D buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(ctrl_msg_tlv_read_header(&amp;peek, &amp;hdr));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=
=2Etype, OOB_TLV_PROBE_REPLY);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(hdr=2Evalue_len, OOB_PROBE_REPLY_LEN);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_find_tlv(&a=
mp;buf, OOB_TLV_PROBE_REPLY, &amp;value));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct oob_probe_reply out =3D { 0 };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_true(oob_probe_reply_read(&amp;value, =
&amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_memory_equal(in=2Epeer_session_id=2Eid, out=2Epeer_session_id=2Eid, SID_=
SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(in=2Epriority, out=2Epriority);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(in=2Eweight, out=2Eweight);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2E=
connect_lifetime, out=2Econnect_lifetime);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(in=2Eflags, out=2Eflags);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=
=2Emax_latency_diff, out=2Emax_latency_diff);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The =
probe reply wire format is locked to the spec&#39;s field order</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * (priority, weight, max_laten=
cy_diff, connect_lifetime, flags), big-endian=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_probe_reply_wire_format(void **state)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D a=
lloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct o=
ob_probe_reply in =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        =2Epriority =3D 10,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        =2Eweight =3D 100,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        =2Econnect_lifetime =3D 30,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D 1,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        =2Emax_latency_diff =3D 25,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    memcpy(in=2Epeer_session_id=
=2Eid, &quot;ABCDEFGH&quot;, SID_SIZE);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_true(oob_probe_reply_write(&amp;buf, &amp;in));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const uint8_t expected[] =3D {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        0x02,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        0x01, /* TLV type 0x201 (not optional=
) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x00,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x14, /* TLV =
value length =3D 20 */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        &#39;A&#39;,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        &#39;B&#39;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        &#39;C&#39;,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        &#39;D&#39;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        &#39;E&#39;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        &#39;F&#39;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        &#39;G&#39;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        &#39;H&#39;,  /* peer_session_id */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        0x00,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        0x0a, /* priority =3D 10 */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        0x00,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        0x64, /* weight =3D 100 */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x00,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        0x19, /* max_latency=
_diff =3D 25 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x=
1e, /* connect_lifetime =3D 30 */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        0x00,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    0x01, /* flags =3D 1 */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(BLEN(&amp;buf), sizeof(expected));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf), expe=
cted, sizeof(expected));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* A TLV with a longer-than-known value must stil=
l parse: the known fields are</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * read and the trailing bytes are skipped (forward compatibility=
)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_parameter=
_forward_compat(void **state)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const uint16_t extended_len =3D OOB_PROBE_PARAM=
ETER_LEN + 4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_true(ctrl_msg_tlv_write_header(&amp;buf, OOB_TLV_PROBE_PARAMETER, fals=
e, extended_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(buf_write_u32(&amp;buf, 0));          /* timestamp high */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_w=
rite_u32(&amp;buf, 0xdeadbeef)); /* timestamp low */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0=
));          /* flags */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(buf_write_u32(&amp;buf, 0x11223344)); /* unknown trail=
ing field */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_=
msg_find_tlv(&amp;buf, OOB_TLV_PROBE_PARAMETER, &amp;value));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;va=
lue), extended_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_pro=
be_parameter out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(oob_probe_parameter_read(&amp;value, &amp;out));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(out=2E=
timestamp =3D=3D 0xdeadbeefULL);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(out=2Eflags, 0);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* the unknown trailing field must have =
been consumed from the payload */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A value shorter =
than the mandatory fields must be rejected, even when it</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * holds enough bytes for some of the =
individual fields to read successfully=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+test_probe_parameter_too_short(void **state)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_bu=
f_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* 4 of the 12 =
mandatory value bytes: too short for the timestamp, but</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * enough for a u32 read to succeed=
 on its own */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(buf_write_u32(&amp;buf, 0xdeadbeef));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct oob_probe_parameter out =3D { 0 };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_probe_parameter_re=
ad(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* A TLV header claiming more value bytes than th=
e payload holds must be</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * rejected by the scan rather than reported as found -- for the TLV be=
ing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * looked for as=
 much as for one that would merely be skipped=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_find_tlv_value_truncated(void **state)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* the wanted TLV declares 12 valu=
e bytes, only 4 are present */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_w=
rite_header(&amp;buf, OOB_TLV_PROBE_PARAMETER, false,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
 OOB_PROBE_PARAMETER_LEN));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(buf_write_u32(&amp;buf, 0xdeadbeef));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_find_tl=
v(&amp;buf, OOB_TLV_PROBE_PARAMETER, &amp;value));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* same defect on a TLV that would be skipped: the scan mus=
t not walk past</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * the end of the payload looking for the next header */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf2 =3D alloc_buf_g=
c(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(ctrl_msg_tlv_write_header(&amp;buf2, 0x7ff, false, 64));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write=
_u32(&amp;buf2, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_false(ctrl_msg_find_tlv(&amp;buf2, OOB_TLV_PROBE_PARAMETER, &am=
p;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* Reading a TLV header must fail when the buffer holds less da=
ta than a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * complet=
e 4-byte header (empty, or only the type field), rather than read</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * past the available data=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+test_tlv_header_truncate=
d(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc=
 =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* empty buffer */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_false(ctrl_msg_tlv_read_header(&amp;buf, &amp;hdr));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* only the type field present, no l=
ength */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(buf_write_u16(&amp;buf, OOB_TLV_PROBE_PARAMETER));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_tlv_read_head=
er(&amp;buf, &amp;hdr));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+main(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_=
test_setup();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst struct CMUnitTest tests[] =3D {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        cmocka_unit_test(test_probe_parameter_roundtrip),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_t=
est(test_probe_reply_roundtrip),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        cmocka_unit_test(test_probe_reply_wire_format),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(t=
est_probe_parameter_forward_compat),</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        cmocka_unit_test(test_probe_parameter_too_short),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_=
test(test_find_tlv_value_truncated),</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        cmocka_unit_test(test_tlv_header_truncated),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return cmocka_run_group_tests_name(&quot;oob tests&qu=
ot;, tests, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">change 1741</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c8d302ac5=
7c5603d622a7be14be369437388268 </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 1741 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></ht=
ml>
--Maknr33Z7BQ=--


--===============5517807741114305553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5517807741114305553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5517807741114305553==--

