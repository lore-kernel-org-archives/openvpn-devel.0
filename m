Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4493C79FBE
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B+mBPQ4HGIBR8lLl5YVHULpLa2ROB8OyX2tfhs7+0Ws=; b=TMpCJ2siYVCzO5GJLK+2hDPGRj
	4yXhr1XwJKy3Wz0LLQeS9z8TXBqSdnUMgwHtJa82n8oOmRdacAzAZmsN+QHX7yNmvesSdqvfCoZ+C
	+b0dg2KSTNK4XNBQlG/7hCrVXNw+WN6K9TTC8zb/D7hT8fBDbBro8pPU1XfN+svzu/C0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4Cid-0006BF-Cv;
	Wed, 09 Sep 2026 07:27:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4CiG-0006AB-Sj
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 07:27:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jTEr6hJrPh1gv21PrwROTstkA0Nqn2esbIgi6y/rpsM=; b=GY23AXWm9t+X5rK44OUBvj1/PJ
 euwp7o+6ssZXMntyh0CiPpRQfuUlCRszatoC1wW0M4DJrS9sUKt0ULPcveU1dNHplO/p2TatvnWp3
 Zm3Zb0bR85lK29OfxVNndRDpmVfzJGv8AkE1+p9X6SZbXSrHiQCBofOfwMSwRlyW/4Wk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jTEr6hJrPh1gv21PrwROTstkA0Nqn2esbIgi6y/rpsM=; b=f
 oRFuvAZc50BQklNdUmVcM9ZqGbjwGfYeYGLFtKZenPaL4FnI2qaVsLoPPxDLu8zqZuq5nrXSWUSxB
 SWabPD3Z4v3Qw+DNUmxXEFFUAB/d/lsyT5Vu0fOsE/V4LAuVwjHSKETHT5nmkgFFw29yqESnsR5S8
 d0vJczB511xrjHO4=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4CiB-0006bh-Vm for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 07:27:21 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so3887865f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 00:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788938829; x=1789543629; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jTEr6hJrPh1gv21PrwROTstkA0Nqn2esbIgi6y/rpsM=;
 b=IqPdwOH+I0SpzEGavXXbRmi2MiOiCgJgwUw/Zj9yHJEIwou5nnGojTEVctgz9sO7bP
 LzCgy0G6gK/L1fsPUMclUUvmh2fYL/5udEMyxRsyTvIsAV0pNWpCHB41UwiOISWnMpEa
 bTNgtTGdTDkLcnFGb5WpXp9+q/4jlo6sfdLOBLkrq3+0JjEkVjfBIn7nOedI1IrUyIfn
 4syTMtFQExXkNO1Ihh0slq8jsNk+AzM/NHXm6uMvYiwPxrZ/j379fN4tyRKfjEX5Kiq6
 ySUqqiaq+AHcvM64FQBxXWqECHT2uixtNAA/ZEn7hu9vnISINeKANRfLQCmCyN2ijtYE
 1MPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788938829; x=1789543629;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jTEr6hJrPh1gv21PrwROTstkA0Nqn2esbIgi6y/rpsM=;
 b=Jr7iLs+6eiSACV6xWZk9BA/TOXXXE4wcX8kF2XM0uuLNJOtAZvGseu3+bhNBqtLxST
 mzs1xn0M8XQMhN9cW74xSNNtLS8yEjSLz+Bw0MGJsi04lD7bZjZeivJV39P7YCwEYSyG
 pmJ4zH6rwQORnRsvcG8mzbArSHmZXGthlsYqlR/J9E6Mf3klsBnStUop7h5pXZ6BQIqp
 FhSfP8yJz79YDPtUDAqEvRDvfhNsYRUg7XzHZKhf9k42dCWeaGA0GBTHdneJW3UB7RP8
 z39VeGX69CELGEI2A4FeckR3dl2oi5luE4gR9Deid1ogL91YySjF09CNF8F5JFLklozE
 4rfA==
X-Gm-Message-State: AFuF++ltQhKn/9k6QpO2Tp76HTyfUvEXHoVe6uf6fNfIAGTXIDu37A3e
 IloMsxv1VRB4Nlx7zpSDGXZzwZQ56WGjG/jZnwlyXzPpy+tlstGuDiNAEEkXMMstV8mxdMpklOa
 eVzqeUmwqKIBmNK2kor/iZnGip3/+KJOu4GKwxKPKEX/+9b2CsyyGqNin6z+TfCL6FbQm
X-Gm-Gg: AYBFou25HnybmAdkxiXffFtNEBc6n9UvumP/oEhB20GmbIl9MYDrqqyVeX4mp0rDmQ/
 +Cc38spiUTn/lRZR4laGqTPbz4F4ESI7glgJiYM8yTUWKH4p/KUpC64xBnPRaX0EienAhE4MY43
 dFYKME9wv1IhUWE2MCCVihNwOxbx8EdatHdxE3q9GjtHs0HlibWmjj4ZloOlDkVTZTjWte5XO4K
 3hg+nlF7k+QUca1i9qBcHVCFYDrX1ZCkBIXxnypUfy+eTDEBZIc56N5AXh8G4AXYSwEB+G7URxg
 4VI3Yqvr2fIosulDF6dkg4QvdZtqsvHz/DVjWW6jU/UkxFC45n5y9SQ13g1LHbG4ajaEAF8RWGd
 KDe5DU2jGTBCOfz4mhHO0gVee1cnO2h1lv8cndlSQ55eUtdyx9H6YeVHy9aALI6znBTffAJYvN+
 T8euhkHdVMuckrI/BA4t1R2BQjASKhm+N7FqyDrwpKS2v+sm3eDjIwYz46s1LbGd8H48TRcZZlz
 JukOuwIjb2hKkskU28r2dluQgQAD+2hPjhZCmmkCZFUyxQzkMYv9OEIpLjHXLPQKcj/8xTqzwSl
 WEyn1COsluoX3PyTODpXfV0UElDNlJsjM7q2+rFmbpBDs1LX0+4KenZ8+ENG6g==
X-Received: by 2002:adf:e198:0:b0:485:b14f:ec44 with SMTP id
 ffacd0b85a97d-485b14fee58mr199839f8f.44.1788938828826; 
 Wed, 09 Sep 2026 00:27:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885be1c1sm41053073f8f.32.2026.09.09.00.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 00:27:08 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 07:27:02 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>,
 ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 8285b3457f16c633f8971cc5725dd4b48e718cf3
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9b7da0e7327c1f345bf58bdf0f14bdf7b625ce89-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4CiB-0006bh-Vm
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
Content-Type: multipart/mixed; boundary="===============3214028957623849449=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3214028957623849449==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="O7bOmxpsoiE="; charset=UTF-8

--O7bOmxpsoiE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici, s=
tipa=2E

Hello flichtenheld, plaisthos, ralf_lici, 

I'd like you to reexam=
ine a change=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1741?usp=3Demail

to look at the new patch set (#13)=2E

The following app=
rovals got outdated and were removed:
Code-Review-1 by ralf_lici


Change s=
ubject: oob: Add control message TLV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add control messa=
ge TLV encoding (P_CONTROL_OOB_V1)

Out-of-band control messages carry cont=
rol data but belong to no session, so a
client can ask a server about itsel=
f before connecting=2E Reserve opcode 12 for
them and add the codec for the=
 two messages the probe needs, SERVER_PROBE and
PROBE_REPLY=2E

The spec us=
es the same TLV framing for all its control messages, not just the
out-of-b=
and ones, so the message-type header, the TLV header and the TLV scan go
in=
to their own control_msg=2Ec/h; oob=2Ec keeps the OOB message and TLV types=
=2E

The scan is strict: a header or value that does not fit in the remaini=
ng
payload, including trailing bytes too few for a header, or an unknown TL=
V not
marked optional rejects the whole message rather than just the TLV=2E=


P_LAST_OPCODE becomes 12, and opcode_valid_in_session() replaces the plai=
n range
check because OOB opcodes are answered statelessly and are never le=
gal on an
established session=2E

See the OOB control message section of th=
e wire protocol specification
(openvpn-rfc PR #30)=2E

Change-Id: I1c8d302a=
c57c5603d622a7be14be369437388268
Signed-off-by: Lev Stipakov <lev@openvpn=
=2Enet>
---
M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
A src/openvpn/co=
ntrol_msg=2Ec
A src/openvpn/control_msg=2Eh
A src/openvpn/oob=2Ec
A src/ope=
nvpn/oob=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/=
ssl_pkt=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
A tests/unit_tests/ope=
nvpn/test_oob=2Ec
11 files changed, 786 insertions(+), 4 deletions(-)


  g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1741/13
=

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 6eb5954=2E=2Efbc69f=
0 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -445,6 +445,8 @@
=
     src/openvpn/console=2Ec
     src/openvpn/console_builtin=2Ec
     src/=
openvpn/console=2Eh
+    src/openvpn/control_msg=2Ec
+    src/openvpn/contr=
ol_msg=2Eh
     src/openvpn/crypto=2Ec
     src/openvpn/crypto=2Eh
     src=
/openvpn/crypto_backend=2Eh
@@ -523,6 +525,8 @@
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
@@ -677,6 +681,7=
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
@@ -881,6 +886,13 @@
         src/openvpn/session_id=2Ec
      =
   )
 
+    target_sources(test_oob PRIVATE
+        tests/unit_tests/openv=
pn/mock_get_random=2Ec
+        src/openvpn/control_msg=2Ec
+        src/op=
envpn/oob=2Ec
+        src/openvpn/session_id=2Ec
+        )
+
     target_=
sources(test_pkt PRIVATE
         tests/unit_tests/openvpn/mock_win32_execv=
e=2Ec
         src/openvpn/argv=2Ec
diff --git a/src/openvpn/Makefile=2Eam =
b/src/openvpn/Makefile=2Eam
index 7fd12b4=2E=2E5e6b4d9 100644
--- a/src/ope=
nvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -53,6 +53,7 @@
 	comm=
on=2Eh \
 	comp=2Ec comp=2Eh compstub=2Ec \
 	comp-lz4=2Ec comp-lz4=2Eh \
+=
	control_msg=2Ec control_msg=2Eh \
 	crypto=2Ec crypto=2Eh crypto_backend=
=2Eh \
 	crypto_openssl=2Ec crypto_openssl=2Eh \
 	crypto_mbedtls_legacy=2E=
c crypto_mbedtls_legacy=2Eh \
@@ -107,6 +108,7 @@
 	pkcs11=2Ec pkcs11=2Eh p=
kcs11_backend=2Eh \
 	pkcs11_openssl=2Ec \
 	pkcs11_mbedtls=2Ec \
+	oob=2Ec=
 oob=2Eh \
 	openvpn=2Ec openvpn=2Eh \
 	options=2Ec options=2Eh \
 	option=
s_show=2Ec options_show=2Eh \
diff --git a/src/openvpn/control_msg=2Ec b/sr=
c/openvpn/control_msg=2Ec
new file mode 100644
index 0000000=2E=2E8d78639
-=
-- /dev/null
+++ b/src/openvpn/control_msg=2Ec
@@ -0,0 +1,107 @@
+/*
+ *  O=
penVPN -- An application to securely tunnel IP networks
+ *             ove=
r a single TCP/UDP port, with support for SSL/TLS-based
+ *             ses=
sion authentication and key exchange,
+ *             packet encryption, pa=
cket authentication, and
+ *             packet compression=2E
+ *
+ *  Cop=
yright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This progra=
m is free software; you can redistribute it and/or modify
+ *  it under the=
 terms of the GNU General Public License version 2
+ *  as published by the=
 Free Software Foundation=2E
+ *
+ *  This program is distributed in the ho=
pe that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the =
implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ *  =
You should have received a copy of the GNU General Public License along
+ *=
  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ *=
/
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshe=
ad=2Eh"
+
+#include "control_msg=2Eh"
+
+bool
+ctrl_msg_read_header(struct =
buffer *buf, uint16_t expected_msg_type)
+{
+    int msg_type =3D buf_read_=
u16(buf);
+    return msg_type >=3D 0 && (uint16_t)msg_type =3D=3D expected=
_msg_type;
+}
+
+bool
+ctrl_msg_tlv_write_header(struct buffer *buf, uint16=
_t type, bool optional, uint16_t value_len)
+{
+    uint16_t field =3D type=
 & CTRL_MSG_TLV_TYPE_MASK;
+    if (optional)
+    {
+        field |=3D CT=
RL_MSG_TLV_OPTIONAL_FLAG;
+    }
+    return buf_write_u16(buf, field) && b=
uf_write_u16(buf, value_len);
+}
+
+bool
+ctrl_msg_tlv_read_header(struct b=
uffer *buf, struct ctrl_msg_tlv_header *hdr)
+{
+    int field =3D buf_read=
_u16(buf);
+    if (field < 0)
+    {
+        return false;
+    }
+    in=
t len =3D buf_read_u16(buf);
+    if (len < 0)
+    {
+        return false=
;
+    }
+    hdr->type =3D (uint16_t)(field & CTRL_MSG_TLV_TYPE_MASK);
+  =
  hdr->optional =3D (field & CTRL_MSG_TLV_OPTIONAL_FLAG) !=3D 0;
+    hdr->=
value_len =3D (uint16_t)len;
+    return true;
+}
+
+bool
+ctrl_msg_find_tl=
v(struct buffer *payload, uint16_t wanted_type, struct buffer *value)
+{
+ =
   struct ctrl_msg_tlv_header hdr;
+    bool found =3D false;
+    while (B=
LEN(payload) > 0)
+    {
+        if (!ctrl_msg_tlv_read_header(payload, &h=
dr))
+        {
+            /* bytes remain but too few for a header: trun=
cated */
+            return false;
+        }
+        /* Take the value o=
ut of payload=2E This validates that the header's
+         * length is rea=
lly there and advances past it in one step, so the TLV
+         * we are l=
ooking for and the ones we skip are bounds-checked alike=2E */
+        uin=
t8_t *v =3D buf_read_alloc(payload, hdr=2Evalue_len);
+        if (!v)
+   =
     {
+            return false;
+        }
+        if (hdr=2Etype =3D=3D=
 wanted_type)
+        {
+            if (!found)
+            {
+         =
       buf_set_read(value, v, hdr=2Evalue_len);
+                found =3D =
true;
+            }
+        }
+        else if (!hdr=2Eoptional)
+       =
 {
+            /* A TLV we do not understand that the sender did not mark =
optional
+             * carries something it requires us to act on, so the=
 message as a
+             * whole is not ours to interpret=2E This is why=
 the scan continues
+             * past the wanted type: such a TLV invali=
dates the message wherever
+             * in the sequence it sits=2E */
+ =
           return false;
+        }
+    }
+    return found;
+}
diff --git=
 a/src/openvpn/control_msg=2Eh b/src/openvpn/control_msg=2Eh
new file mode =
100644
index 0000000=2E=2Eb98dce5
--- /dev/null
+++ b/src/openvpn/control_m=
sg=2Eh
@@ -0,0 +1,106 @@
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
+/**
+ * @file
+ * Framing shared by=
 the TLV-based control messages of the wire protocol=2E
+ *
+ * Such a mess=
age payload starts with a 16-bit message type, followed by a
+ * sequence o=
f TLV entries=2E Each TLV starts with a 4-byte header: a 16-bit field
+ * w=
hose most significant bit is the "optional" flag and whose remaining 15 bit=
s
+ * are the type, followed by a 16-bit length giving the size of the valu=
e that
+ * follows the header=2E
+ *
+ * The message-type and TLV-type valu=
es themselves are specific to the message
+ * family carried (out-of-band m=
essages define theirs in oob=2Eh), so only the
+ * framing lives here=2E
+ =
*/
+
+#ifndef CONTROL_MSG_H
+#define CONTROL_MSG_H
+
+#include "buffer=2Eh"=

+
+/* TLV header bit layout of the first 16-bit field */
+#define CTRL_MSG=
_TLV_OPTIONAL_FLAG 0x8000
+#define CTRL_MSG_TLV_TYPE_MASK     0x7fff
+
+/* =
The header every TLV carries: the 15-bit type and optional flag packed into=

+ * the first 16-bit field, then the length of the value that follows=2E *=
/
+struct ctrl_msg_tlv_header
+{
+    uint16_t type;      /**< the 15-bit T=
LV type */
+    bool optional;      /**< value of the optional flag */
+   =
 uint16_t value_len; /**< length of the value following the header */
+};
+=

+/**
+ * Read and verify a message-type header from buf, advancing past it=
=2E
+ *
+ * @param buf                buffer positioned at the message payl=
oad
+ * @param expected_msg_type  the message type the payload must carry
+=
 * @return true if a message type was read and equals expected_msg_type,
+ =
*         false on a short buffer or a mismatching type=2E
+ */
+bool ctrl_=
msg_read_header(struct buffer *buf, uint16_t expected_msg_type);
+
+/**
+ *=
 Write a TLV header (type + optional flag + value length) to buf=2E
+ *
+ *=
 @return true on success, false if buf has insufficient space=2E
+ */
+bool=
 ctrl_msg_tlv_write_header(struct buffer *buf, uint16_t type, bool optional=
,
+                               uint16_t value_len);
+
+/**
+ * Read a TL=
V header from buf, advancing past it=2E
+ *
+ * @param buf  buffer position=
ed at the TLV header
+ * @param hdr  filled with the type, optional flag an=
d value length on success
+ * @return true on success, false if there are n=
ot enough bytes for a header=2E
+ */
+bool ctrl_msg_tlv_read_header(struct =
buffer *buf, struct ctrl_msg_tlv_header *hdr);
+
+/**
+ * Scan payload for =
the first TLV of type wanted_type, skipping any other (e=2Eg=2E
+ * future)=
 TLV type that is marked optional=2E
+ *
+ * The whole sequence is walked, =
including the part after the wanted type: a TLV
+ * we do not understand an=
d that is not marked optional invalidates the message
+ * wherever it sits,=
 and rejecting it is the point of the remaining scan=2E
+ *
+ * On success =
value covers exactly the found TLV's value bytes=2E The length from
+ * eac=
h TLV header is validated against payload as the scan goes, so the whole
+ =
* value is guaranteed to be present; a header claiming more bytes than payl=
oad
+ * holds is rejected rather than reported as found=2E payload is consu=
med as it is
+ * read=2E
+ *
+ * @param payload      buffer positioned at a=
 TLV header
+ * @param wanted_type  the TLV type to look for
+ * @param val=
ue        set to a buffer covering the found TLV's value
+ * @return true i=
f the TLV was found, false if it is not present, a TLV header
+ *         o=
r value is malformed or truncated, or a TLV we do not understand is
+ *    =
     not marked optional=2E
+ */
+bool ctrl_msg_find_tlv(struct buffer *pay=
load, uint16_t wanted_type, struct buffer *value);
+
+#endif /* ifndef CONT=
ROL_MSG_H */
diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
new fil=
e mode 100644
index 0000000=2E=2Ec807171
--- /dev/null
+++ b/src/openvpn/oo=
b=2Ec
@@ -0,0 +1,83 @@
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
+#include "oob=2Eh"
+#include "c=
ontrol_msg=2Eh"
+
+bool
+oob_probe_parameter_write(struct buffer *buf, cons=
t struct oob_probe_parameter *p)
+{
+    return ctrl_msg_tlv_write_header(b=
uf, OOB_TLV_PROBE_PARAMETER, false, OOB_PROBE_PARAMETER_LEN)
+           &&=
 buf_write_u64(buf, p->timestamp)
+           && buf_write_u32(buf, p->flag=
s);
+}
+
+bool
+oob_probe_parameter_read(struct buffer *buf, struct oob_pro=
be_parameter *p)
+{
+    /* One bounds check covers the whole value: every =
field read below then fits
+     * by construction (OOB_PROBE_PARAMETER_LEN=
 is the sum of their sizes), so
+     * none of them needs its own error ha=
ndling=2E Trailing bytes this version
+     * does not understand are simpl=
y left unread=2E */
+    if (buf_len(buf) < OOB_PROBE_PARAMETER_LEN)
+    {=

+        return false;
+    }
+    p->timestamp =3D buf_read_u64(buf, NULL=
);
+    p->flags =3D buf_read_u32(buf, NULL);
+    return true;
+}
+
+bool
=
+oob_probe_reply_write(struct buffer *buf, const struct oob_probe_reply *r)=

+{
+    return ctrl_msg_tlv_write_header(buf, OOB_TLV_PROBE_REPLY, false, =
OOB_PROBE_REPLY_LEN)
+           && session_id_write(&r->peer_session_id, b=
uf)
+           && buf_write_u16(buf, r->priority)
+           && buf_write=
_u16(buf, r->weight)
+           && buf_write_u16(buf, r->max_latency_diff)=

+           && buf_write_u16(buf, r->connect_lifetime)
+           && buf_=
write_u32(buf, r->flags);
+}
+
+bool
+oob_probe_reply_read(struct buffer *b=
uf, struct oob_probe_reply *r)
+{
+    /* One bounds check for the whole va=
lue, as in oob_probe_parameter_read()=2E */
+    if (buf_len(buf) < OOB_PRO=
BE_REPLY_LEN)
+    {
+        return false;
+    }
+    session_id_read(&r-=
>peer_session_id, buf);
+    r->priority =3D (uint16_t)buf_read_u16(buf);
+=
    r->weight =3D (uint16_t)buf_read_u16(buf);
+    r->max_latency_diff =3D=
 (uint16_t)buf_read_u16(buf);
+    r->connect_lifetime =3D (uint16_t)buf_re=
ad_u16(buf);
+    r->flags =3D buf_read_u32(buf, NULL);
+    return true;
+=
}
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
new file mode 1006=
44
index 0000000=2E=2Ec5396b3
--- /dev/null
+++ b/src/openvpn/oob=2Eh
@@ -0=
,0 +1,110 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP netwo=
rks
+ *             over a single TCP/UDP port, with support for SSL/TLS-ba=
sed
+ *             session authentication and key exchange,
+ *           =
  packet encryption, packet authentication, and
+ *             packet comp=
ression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Ene=
t>
+ *
+ *  This program is free software; you can redistribute it and/or m=
odify
+ *  it under the terms of the GNU General Public License version 2
+=
 *  as published by the Free Software Foundation=2E
+ *
+ *  This program i=
s distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARR=
ANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS =
FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for mo=
re details=2E
+ *
+ *  You should have received a copy of the GNU General P=
ublic License along
+ *  with this program; if not, see <https://www=2Egnu=
=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @file
+ * Encoding/decoding of out-of-=
band (P_CONTROL_OOB_V1) control messages=2E
+ *
+ * An OOB message payload =
starts with a 16-bit message type (the 0x1xx space:
+ * SERVER_PROBE, PROBE=
_REPLY, =2E=2E=2E) followed by a sequence of TLV entries in the
+ * 0x2xx t=
ype space=2E The framing itself is shared with the other TLV-based
+ * cont=
rol messages of the wire protocol and lives in control_msg=2Eh; this file
+=
 * defines the OOB message and TLV types, their values, and the OOB-specifi=
c
+ * decisions taken on them=2E
+ */
+
+#ifndef OOB_H
+#define OOB_H
+
+#i=
nclude "buffer=2Eh"
+#include "session_id=2Eh"
+
+/* OOB message types: the=
 16-bit value at the start of an OOB payload, before
+ * its TLV entries=2E=
 Distinct from the TLV-type space (0x2xx); see the "Messages"
+ * table in =
the OOB section of the wire protocol spec=2E */
+#define OOB_MSG_SERVER_PRO=
BE 0x100
+#define OOB_MSG_PROBE_REPLY  0x101
+
+/* TLV types (see the OOB c=
ontrol message section of the wire protocol spec) */
+#define OOB_TLV_PROBE=
_PARAMETER 0x200
+#define OOB_TLV_PROBE_REPLY     0x201
+
+/* Minimum on-wi=
re value length (excluding the 4-byte TLV header) of each TLV:
+ * the size=
s of its fixed fields in wire order (see the structs below)=2E The
+ * valu=
e may be longer for forward compatibility; trailing bytes that are not
+ * =
understood are ignored on read=2E */
+#define OOB_PROBE_PARAMETER_LEN \
+  =
  ((uint16_t)(sizeof(uint64_t) /* timestamp */ + sizeof(uint32_t) /* flags =
*/))
+#define OOB_PROBE_REPLY_LEN                                   \
+    =
((uint16_t)(SID_SIZE               /* peer_session_id */  \
+              =
  + 4 * sizeof(uint16_t) /* priority, weight,   \
+                        =
                * max_latency_diff,   \
+                                  =
      * connect_lifetime */ \
+                + sizeof(uint32_t)))   /* fl=
ags */
+
+/* probe parameter TLV (sent by the client in a SERVER_PROBE) */
=
+struct oob_probe_parameter
+{
+    uint64_t timestamp; /**< client clock a=
s a UNIX timestamp */
+    uint32_t flags;     /**< client capability flags=
, currently must be 0 */
+};
+
+/* probe reply TLV (sent by the server in a=
 PROBE_REPLY) */
+struct oob_probe_reply
+{
+    struct session_id peer_ses=
sion_id; /**< echoes the session id of the request */
+    uint16_t priorit=
y;                 /**< DNS-SRV style priority (lower is preferred) */
+   =
 uint16_t weight;                   /**< DNS-SRV style weight */
+    uint1=
6_t max_latency_diff;         /**< advertised candidate-band margin in ms;
=
+                                        *   used unless the client configu=
red its own */
+    uint16_t connect_lifetime;         /**< seconds the rep=
ly stays valid as the handshake reset */
+    uint32_t flags;              =
      /**< server behaviour flags */
+};
+
+/**
+ * Write a complete probe =
parameter TLV (header + value) to buf=2E
+ */
+bool oob_probe_parameter_wri=
te(struct buffer *buf, const struct oob_probe_parameter *p);
+
+/**
+ * Rea=
d a probe parameter TLV value from buf=2E
+ *
+ * buf must cover exactly th=
e TLV's value, as returned by ctrl_msg_find_tlv()=2E
+ * Trailing bytes bey=
ond the fields understood here are ignored, so a longer
+ * value from a fu=
ture version still parses=2E
+ *
+ * @return true on success, false if buf =
is shorter than the mandatory fields=2E
+ */
+bool oob_probe_parameter_read=
(struct buffer *buf, struct oob_probe_parameter *p);
+
+/**
+ * Write a com=
plete probe reply TLV (header + value) to buf=2E
+ */
+bool oob_probe_reply=
_write(struct buffer *buf, const struct oob_probe_reply *r);
+
+/**
+ * Rea=
d a probe reply TLV value from buf=2E See oob_probe_parameter_read() for th=
e
+ * calling convention=2E
+ */
+bool oob_probe_reply_read(struct buffer *=
buf, struct oob_probe_reply *r);
+
+#endif /* OOB_H */
diff --git a/src/ope=
nvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 5f5d1f9=2E=2Ec8fc465 100644
--- a/=
src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -3676,7 +3676,7 @@
     st=
ruct session_id sid; /* remote session ID */
 
     /* verify legal opcode =
*/
-    if (op < P_FIRST_OPCODE || op > P_LAST_OPCODE)
+    if (!opcode_val=
id_in_session(op))
     {
         if (op =3D=3D P_CONTROL_HARD_RESET_CLIEN=
T_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)
         {
diff --git a/s=
rc/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index 6a6d9f9=2E=2E39cb648=
 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -167=
,7 +167,7 @@
                    bool prepend_ack)
 {
     ASSERT(ks->key_i=
d >=3D 0 && ks->key_id <=3D P_KEY_ID_MASK);
-    ASSERT(opcode >=3D 0 && op=
code <=3D P_LAST_OPCODE);
+    ASSERT(opcode_valid_in_session(opcode));
   =
  uint8_t header =3D (uint8_t)(ks->key_id | (opcode << P_OPCODE_SHIFT));
 
=
     /* Workaround for Softether servers=2E Softether has a bug that it onl=
y
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 03e8=
930=2E=2Ed46b8c5 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl=
_pkt=2Eh
@@ -58,11 +58,53 @@
  * like P_CONTROL_HARD_RESET_CLIENT_V3 */
 #d=
efine P_CONTROL_WKC_V1 11
 
-/* define the range of legal opcodes
+/* Out-o=
f-band control message that does not belong to an established
+ * control c=
hannel session (e=2Eg=2E a server probe)=2E Inherently unreliable:
+ * ther=
e is no protocol-level retransmission=2E
+ *
+ * It is not legal on an esta=
blished session; see opcode_valid_in_session()
+ * below=2E */
+#define P_C=
ONTROL_OOB_V1 12
+
+/* define the range of defined opcodes, in- and out-of-=
band=2E Note this is not
+ * the set of opcodes legal on an established ses=
sion; see
+ * opcode_valid_in_session()=2E
  * Since we do no longer suppor=
t key-method 1 we consider
  * the v1 op codes invalid */
 #define P_FIRST_=
OPCODE 3
-#define P_LAST_OPCODE  11
+#define P_LAST_OPCODE  12
+
+static in=
line bool
+opcode_is_oob(int op)
+{
+    return op =3D=3D P_CONTROL_OOB_V1;=

+}
+
+/**
+ * Return true if op may occur on an established control-channe=
l session=2E
+ *
+ * Out-of-band opcodes may not=2E They are answered state=
lessly on the
+ * new-connection path, and being rejected here is a permane=
nt property rather
+ * than a handler that is still missing:
+ *
+ *  - an =
OOB message carries its TLV payload directly, with no reliability or
+ *   =
 ACK fields (see tls_wrap_oob_standalone()), whereas the established-sessio=
n
+ *    path parses an ACK array and a control packet-id before anything e=
lse=2E The
+ *    payload is chosen by the sender and session ids are plain=
text on the wire,
+ *    so those bytes can be crafted into a valid ACK arr=
ay, forging ACKs into a
+ *    live control channel and stalling a handshak=
e or rekey=2E
+ *  - nothing on that path parses an OOB payload, so there i=
s nothing to gain by
+ *    accepting one=2E
+ *
+ * This cannot be express=
ed as an opcode range: the inband CONTROL_DATA_V1 of the
+ * wire protocol =
is legal on an established session, so the OOB opcodes sit
+ * between lega=
l ones=2E
+ */
+static inline bool
+opcode_valid_in_session(int op)
+{
+   =
 return op >=3D P_FIRST_OPCODE && op <=3D P_LAST_OPCODE && !opcode_is_oob(o=
p);
+}
 
 /*
  * Define number of buffers for send and receive in the relia=
bility layer=2E
@@ -256,6 +298,9 @@
         case P_CONTROL_WKC_V1:
       =
      return "P_CONTROL_WKC_V1";
 
+        case P_CONTROL_OOB_V1:
+       =
     return "P_CONTROL_OOB_V1";
+
         case P_ACK_V1:
             retu=
rn "P_ACK_V1";
 
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/test=
s/unit_tests/openvpn/Makefile=2Eam
index 5954902=2E=2E9f6b865 100644
--- a/=
tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makef=
ile=2Eam
@@ -14,6 +14,7 @@
 	ncp_testdriver \
 	mbuf_testdriver \
 	misc_te=
stdriver \
+	oob_testdriver \
 	options_parse_testdriver \
 	packet_id_test=
driver \
 	pkt_testdriver \
@@ -153,6 +154,20 @@
 	$(top_srcdir)/src/openvp=
n/win32-util=2Ec \
 	$(top_srcdir)/src/openvpn/session_id=2Ec
 
+oob_testdr=
iver_CFLAGS  =3D \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$=
(top_srcdir)/src/openvpn \
+	@TEST_CFLAGS@
+oob_testdriver_LDFLAGS =3D @TES=
T_LDFLAGS@
+oob_testdriver_SOURCES =3D test_oob=2Ec \
+	mock_msg=2Ec mock_m=
sg=2Eh test_common=2Eh \
+	mock_get_random=2Ec \
+	$(top_srcdir)/src/openvp=
n/buffer=2Ec \
+	$(top_srcdir)/src/openvpn/control_msg=2Ec \
+	$(top_srcdir=
)/src/openvpn/oob=2Ec \
+	$(top_srcdir)/src/openvpn/platform=2Ec \
+	$(top_=
srcdir)/src/openvpn/session_id=2Ec \
+	$(top_srcdir)/src/openvpn/win32-util=
=2Ec
+
 pkt_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I$(top_srcd=
ir)/src/compat -I$(top_srcdir)/src/openvpn \
 	@TEST_CFLAGS@
diff --git a/t=
ests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2E=
c
new file mode 100644
index 0000000=2E=2E7664639
--- /dev/null
+++ b/tests=
/unit_tests/openvpn/test_oob=2Ec
@@ -0,0 +1,302 @@
+/*
+ *  OpenVPN -- An a=
pplication to securely tunnel IP networks
+ *             over a single TCP=
/UDP port, with support for SSL/TLS-based
+ *             session authentic=
ation and key exchange,
+ *             packet encryption, packet authentic=
ation, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 200=
2-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free soft=
ware; you can redistribute it and/or modify
+ *  it under the terms of the =
GNU General Public License version 2
+ *  as published by the Free Software=
 Foundation=2E
+ *
+ *  This program is distributed in the hope that it wil=
l be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warran=
ty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
=
+ *  GNU General Public License for more details=2E
+ *
+ *  You should hav=
e received a copy of the GNU General Public License along
+ *  with this pr=
ogram; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HA=
VE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#in=
clude <stdarg=2Eh>
+#include <stddef=2Eh>
+#include <setjmp=2Eh>
+#include =
<cmocka=2Eh>
+
+#include "control_msg=2Eh"
+#include "oob=2Eh"
+#include "t=
est_common=2Eh"
+
+/* Write a probe parameter TLV and read it back; fields =
must survive the
+ * round trip and the whole buffer must be consumed=2E */=

+static void
+test_probe_parameter_roundtrip(void **state)
+{
+    struct =
gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc)=
;
+
+    const struct oob_probe_parameter in =3D {
+        =2Etimestamp =
=3D 0x0123456789abcdefULL,
+        =2Eflags =3D 0,
+    };
+    assert_tru=
e(oob_probe_parameter_write(&buf, &in));
+    /* header (4) + value (12) */=

+    assert_int_equal(BLEN(&buf), 4 + OOB_PROBE_PARAMETER_LEN);
+
+    /* =
the header codec, read from a copy so the scan below still sees it */
+    =
struct buffer peek =3D buf;
+    struct ctrl_msg_tlv_header hdr;
+    asser=
t_true(ctrl_msg_tlv_read_header(&peek, &hdr));
+    assert_int_equal(hdr=2E=
type, OOB_TLV_PROBE_PARAMETER);
+    assert_false(hdr=2Eoptional);
+    ass=
ert_int_equal(hdr=2Evalue_len, OOB_PROBE_PARAMETER_LEN);
+
+    struct buff=
er value;
+    assert_true(ctrl_msg_find_tlv(&buf, OOB_TLV_PROBE_PARAMETER,=
 &value));
+    assert_int_equal(BLEN(&value), OOB_PROBE_PARAMETER_LEN);
+
=
+    struct oob_probe_parameter out =3D { 0 };
+    assert_true(oob_probe_p=
arameter_read(&value, &out));
+    assert_true(in=2Etimestamp =3D=3D out=2E=
timestamp);
+    assert_int_equal(in=2Eflags, out=2Eflags);
+    /* the sca=
n consumed header and value alike */
+    assert_int_equal(BLEN(&buf), 0);
=
+
+    gc_free(&gc);
+}
+
+/* Write a probe reply TLV and read it back=2E *=
/
+static void
+test_probe_reply_roundtrip(void **state)
+{
+    struct gc_=
arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+=

+    struct oob_probe_reply in =3D {
+        =2Epriority =3D 10,
+       =
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
+    struct buffer peek =3D buf;
+    struct ctrl_msg_tlv_header hdr;
=
+    assert_true(ctrl_msg_tlv_read_header(&peek, &hdr));
+    assert_int_eq=
ual(hdr=2Etype, OOB_TLV_PROBE_REPLY);
+    assert_int_equal(hdr=2Evalue_len=
, OOB_PROBE_REPLY_LEN);
+
+    struct buffer value;
+    assert_true(ctrl_m=
sg_find_tlv(&buf, OOB_TLV_PROBE_REPLY, &value));
+
+    struct oob_probe_re=
ply out =3D { 0 };
+    assert_true(oob_probe_reply_read(&value, &out));
+ =
   assert_memory_equal(in=2Epeer_session_id=2Eid, out=2Epeer_session_id=2Ei=
d, SID_SIZE);
+    assert_int_equal(in=2Epriority, out=2Epriority);
+    as=
sert_int_equal(in=2Eweight, out=2Eweight);
+    assert_int_equal(in=2Econne=
ct_lifetime, out=2Econnect_lifetime);
+    assert_int_equal(in=2Eflags, out=
=2Eflags);
+    assert_int_equal(in=2Emax_latency_diff, out=2Emax_latency_d=
iff);
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* T=
he probe reply wire format is locked to the spec's field order
+ * (priorit=
y, weight, max_latency_diff, connect_lifetime, flags), big-endian=2E */
+st=
atic void
+test_probe_reply_wire_format(void **state)
+{
+    struct gc_are=
na gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+ =
   struct oob_probe_reply in =3D {
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
+
+    const uint8_t expected[] =3D {
+        0x02,
+   =
     0x01, /* TLV type 0x201 (not optional) */
+        0x00,
+        0x14=
, /* TLV value length =3D 20 */
+        'A',
+        'B',
+        'C',
+=
        'D',
+        'E',
+        'F',
+        'G',
+        'H',  /* pe=
er_session_id */
+        0x00,
+        0x0a, /* priority =3D 10 */
+     =
   0x00,
+        0x64, /* weight =3D 100 */
+        0x00,
+        0x19, =
/* max_latency_diff =3D 25 */
+        0x00,
+        0x1e, /* connect_life=
time =3D 30 */
+        0x00,
+        0x00,
+        0x00,
+        0x01, =
/* flags =3D 1 */
+    };
+    assert_int_equal(BLEN(&buf), sizeof(expected=
));
+    assert_memory_equal(BPTR(&buf), expected, sizeof(expected));
+
+  =
  gc_free(&gc);
+}
+
+/* A TLV with a longer-than-known value must still pa=
rse: the known fields are
+ * read and the trailing bytes are skipped (forw=
ard compatibility)=2E */
+static void
+test_probe_parameter_forward_compat(=
void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer b=
uf =3D alloc_buf_gc(128, &gc);
+
+    const uint16_t extended_len =3D OOB_P=
ROBE_PARAMETER_LEN + 4;
+    assert_true(ctrl_msg_tlv_write_header(&buf, OO=
B_TLV_PROBE_PARAMETER, false, extended_len));
+    assert_true(buf_write_u3=
2(&buf, 0));          /* timestamp high */
+    assert_true(buf_write_u32(&=
buf, 0xdeadbeef)); /* timestamp low */
+    assert_true(buf_write_u32(&buf,=
 0));          /* flags */
+    assert_true(buf_write_u32(&buf, 0x11223344)=
); /* unknown trailing field */
+
+    struct buffer value;
+    assert_tru=
e(ctrl_msg_find_tlv(&buf, OOB_TLV_PROBE_PARAMETER, &value));
+    assert_in=
t_equal(BLEN(&value), extended_len);
+
+    struct oob_probe_parameter out =
=3D { 0 };
+    assert_true(oob_probe_parameter_read(&value, &out));
+    a=
ssert_true(out=2Etimestamp =3D=3D 0xdeadbeefULL);
+    assert_int_equal(out=
=2Eflags, 0);
+    /* the unknown trailing field must have been consumed fr=
om the payload */
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc)=
;
+}
+
+/* A value shorter than the mandatory fields must be rejected, even=
 when it
+ * holds enough bytes for some of the individual fields to read s=
uccessfully=2E */
+static void
+test_probe_parameter_too_short(void **state=
)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc=
_buf_gc(128, &gc);
+
+    /* 4 of the 12 mandatory value bytes: too short f=
or the timestamp, but
+     * enough for a u32 read to succeed on its own *=
/
+    assert_true(buf_write_u32(&buf, 0xdeadbeef));
+
+    struct oob_prob=
e_parameter out =3D { 0 };
+    assert_false(oob_probe_parameter_read(&buf,=
 &out));
+
+    gc_free(&gc);
+}
+
+/* A TLV header claiming more value byt=
es than the payload holds must be
+ * rejected by the scan rather than repo=
rted as found -- for the TLV being
+ * looked for as much as for one that w=
ould merely be skipped=2E */
+static void
+test_find_tlv_value_truncated(vo=
id **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer val=
ue;
+
+    /* the wanted TLV declares 12 value bytes, only 4 are present */=

+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+    assert_true(ctrl_m=
sg_tlv_write_header(&buf, OOB_TLV_PROBE_PARAMETER, false,
+                =
                          OOB_PROBE_PARAMETER_LEN));
+    assert_true(buf_w=
rite_u32(&buf, 0xdeadbeef));
+    assert_false(ctrl_msg_find_tlv(&buf, OOB_=
TLV_PROBE_PARAMETER, &value));
+
+    /* same defect on a TLV that would be=
 skipped: the scan must not walk past
+     * the end of the payload lookin=
g for the next header */
+    struct buffer buf2 =3D alloc_buf_gc(128, &gc)=
;
+    assert_true(ctrl_msg_tlv_write_header(&buf2, 0x7ff, false, 64));
+  =
  assert_true(buf_write_u32(&buf2, 0));
+    assert_false(ctrl_msg_find_tlv=
(&buf2, OOB_TLV_PROBE_PARAMETER, &value));
+
+    gc_free(&gc);
+}
+
+/* By=
tes left over after the last TLV that are too few for a header make the
+ *=
 message malformed, even when the wanted TLV was already found=2E */
+stati=
c void
+test_find_tlv_trailing_bytes(void **state)
+{
+    struct gc_arena =
gc =3D gc_new();
+    struct buffer value;
+
+    /* 1 to 3 bytes: less tha=
n a 4-byte TLV header */
+    for (int trailing =3D 1; trailing <=3D 3; tra=
iling++)
+    {
+        struct buffer buf =3D alloc_buf_gc(128, &gc);
+   =
     const struct oob_probe_parameter in =3D { =2Etimestamp =3D 1, =2Eflags=
 =3D 0 };
+        assert_true(oob_probe_parameter_write(&buf, &in));
+    =
    for (int i =3D 0; i < trailing; i++)
+        {
+            assert_tru=
e(buf_write_u8(&buf, 0));
+        }
+        assert_false(ctrl_msg_find_tl=
v(&buf, OOB_TLV_PROBE_PARAMETER, &value));
+    }
+
+    gc_free(&gc);
+}
+=

+/* Reading a TLV header must fail when the buffer holds less data than a
=
+ * complete 4-byte header (empty, or only the type field), rather than rea=
d
+ * past the available data=2E */
+static void
+test_tlv_header_truncated=
(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer =
buf =3D alloc_buf_gc(128, &gc);
+
+    struct ctrl_msg_tlv_header hdr;
+
+ =
   /* empty buffer */
+    assert_false(ctrl_msg_tlv_read_header(&buf, &hdr=
));
+
+    /* only the type field present, no length */
+    assert_true(bu=
f_write_u16(&buf, OOB_TLV_PROBE_PARAMETER));
+    assert_false(ctrl_msg_tlv=
_read_header(&buf, &hdr));
+
+    gc_free(&gc);
+}
+
+int
+main(void)
+{
+ =
   openvpn_unit_test_setup();
+    const struct CMUnitTest tests[] =3D {
+ =
       cmocka_unit_test(test_probe_parameter_roundtrip),
+        cmocka_un=
it_test(test_probe_reply_roundtrip),
+        cmocka_unit_test(test_probe_r=
eply_wire_format),
+        cmocka_unit_test(test_probe_parameter_forward_c=
ompat),
+        cmocka_unit_test(test_probe_parameter_too_short),
+       =
 cmocka_unit_test(test_find_tlv_value_truncated),
+        cmocka_unit_test=
(test_find_tlv_trailing_bytes),
+        cmocka_unit_test(test_tlv_header_t=
runcated),
+    };
+
+    return cmocka_run_group_tests_name("oob tests", t=
ests, NULL, NULL);
+}

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1741?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I1c8d302ac57c5603d622a7be14be369437388268
Gerrit-Change-Number: 1741
G=
errit-PatchSet: 13
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Revie=
wer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Attention: ralf_lici <ralf@mandelbit=
=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--O7bOmxpsoiE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici, stipa=2E </p>
<p>=
stipa <strong>uploaded patch set #13</strong> to this change=2E</p><p><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Re=
view-1 by ralf_lici</p><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">oob: Add control message TLV encoding =
(P_CONTROL_OOB_V1)<br><br>Out-of-band control messages carry control data b=
ut belong to no session, so a<br>client can ask a server about itself befor=
e connecting=2E Reserve opcode 12 for<br>them and add the codec for the two=
 messages the probe needs, SERVER_PROBE and<br>PROBE_REPLY=2E<br><br>The sp=
ec uses the same TLV framing for all its control messages, not just the<br>=
out-of-band ones, so the message-type header, the TLV header and the TLV sc=
an go<br>into their own control_msg=2Ec/h; oob=2Ec keeps the OOB message an=
d TLV types=2E<br><br>The scan is strict: a header or value that does not f=
it in the remaining<br>payload, including trailing bytes too few for a head=
er, or an unknown TLV not<br>marked optional rejects the whole message rath=
er than just the TLV=2E<br><br>P_LAST_OPCODE becomes 12, and opcode_valid_i=
n_session() replaces the plain range<br>check because OOB opcodes are answe=
red statelessly and are never legal on an<br>established session=2E<br><br>=
See the OOB control message section of the wire protocol specification<br>(=
openvpn-rfc PR #30)=2E<br><br>Change-Id: I1c8d302ac57c5603d622a7be14be36943=
7388268<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>=
M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>A src/openvpn/control_=
msg=2Ec<br>A src/openvpn/control_msg=2Eh<br>A src/openvpn/oob=2Ec<br>A src/=
openvpn/oob=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M =
src/openvpn/ssl_pkt=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A te=
sts/unit_tests/openvpn/test_oob=2Ec<br>11 files changed, 786 insertions(+),=
 4 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/41/1741/13</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeList=
s=2Etxt b/CMakeLists=2Etxt</span><br><span>index 6eb5954=2E=2Efbc69f0 10064=
4</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=
=2Etxt</span><br><span>@@ -445,6 +445,8 @@</span><br><span>     src/openvpn=
/console=2Ec</span><br><span>     src/openvpn/console_builtin=2Ec</span><br=
><span>     src/openvpn/console=2Eh</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    src/openvpn/control_msg=2Ec</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    src/openvpn/control_msg=2Eh</span><br><span=
>     src/openvpn/crypto=2Ec</span><br><span>     src/openvpn/crypto=2Eh</s=
pan><br><span>     src/openvpn/crypto_backend=2Eh</span><br><span>@@ -523,6=
 +525,8 @@</span><br><span>     src/openvpn/multi_io=2Ec</span><br><span>  =
   src/openvpn/occ=2Ec</span><br><span>     src/openvpn/occ=2Eh</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/oob=2Ec</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/oob=2Eh</sp=
an><br><span>     src/openvpn/openvpn=2Ec</span><br><span>     src/openvpn/=
openvpn=2Eh</span><br><span>     src/openvpn/openvpn_win32_resources=2Erc</=
span><br><span>@@ -677,6 +681,7 @@</span><br><span>         &quot;test_mbuf=
&quot;</span><br><span>         &quot;test_misc&quot;</span><br><span>     =
    &quot;test_ncp&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        &quot;test_oob&quot;</span><br><span>         &quot;test_optio=
ns_parse&quot;</span><br><span>         &quot;test_packet_id&quot;</span><b=
r><span>         &quot;test_pkt&quot;</span><br><span>@@ -881,6 +886,13 @@<=
/span><br><span>         src/openvpn/session_id=2Ec</span><br><span>       =
  )</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    target_sources(test_oob PRIVATE</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        tests/unit_tests/openvpn/mock_get_random=2Ec</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/cont=
rol_msg=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
src/openvpn/oob=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        src/openvpn/session_id=2Ec</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        )</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span>     target_sources(test_pkt PRIVATE</span><br><span>=
         tests/unit_tests/openvpn/mock_win32_execve=2Ec</span><br><span>   =
      src/openvpn/argv=2Ec</span><br><span>diff --git a/src/openvpn/Makefil=
e=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index 7fd12b4=2E=2E5e6b4=
d9 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+=
++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -53,6 +53,7 @@</span><br>=
<span> 	common=2Eh \</span><br><span> 	comp=2Ec comp=2Eh compstub=2Ec \</sp=
an><br><span> 	comp-lz4=2Ec comp-lz4=2Eh \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	control_msg=2Ec control_msg=2Eh \</span><br><span> =
	crypto=2Ec crypto=2Eh crypto_backend=2Eh \</span><br><span> 	crypto_openss=
l=2Ec crypto_openssl=2Eh \</span><br><span> 	crypto_mbedtls_legacy=2Ec cryp=
to_mbedtls_legacy=2Eh \</span><br><span>@@ -107,6 +108,7 @@</span><br><span=
> 	pkcs11=2Ec pkcs11=2Eh pkcs11_backend=2Eh \</span><br><span> 	pkcs11_open=
ssl=2Ec \</span><br><span> 	pkcs11_mbedtls=2Ec \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	oob=2Ec oob=2Eh \</span><br><span> 	openvpn=
=2Ec openvpn=2Eh \</span><br><span> 	options=2Ec options=2Eh \</span><br><s=
pan> 	options_show=2Ec options_show=2Eh \</span><br><span>diff --git a/src/=
openvpn/control_msg=2Ec b/src/openvpn/control_msg=2Ec</span><br><span>new f=
ile mode 100644</span><br><span>index 0000000=2E=2E8d78639</span><br><span>=
--- /dev/null</span><br><span>+++ b/src/openvpn/control_msg=2Ec</span><br><=
span>@@ -0,0 +1,107 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN --=
 An application to securely tunnel IP networks</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with =
support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *             session authentication and key exchange,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption,=
 packet authentication, and</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             packet compression=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; y=
ou can redistribute it and/or modify</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  it under the terms of the GNU General Public License v=
ersion 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publ=
ished by the Free Software Foundation=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  This program is distributed in the hope that it will be useful,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WAR=
RANTY; without even the implied warranty of</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PUR=
POSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 GNU General Public License for more details=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  You should have received a copy of the GNU General Public Li=
cense along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with=
 this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;control_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_read_header(stru=
ct buffer *buf, uint16_t expected_msg_type)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int msg_type =3D buf_read_u16(buf);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return msg_type &gt;=3D 0 &amp;&amp; (uint16_=
t)msg_type =3D=3D expected_msg_type;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_write_header(struct bu=
ffer *buf, uint16_t type, bool optional, uint16_t value_len)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    uint16_t field =3D type &amp; CTRL_MSG_TLV_TYPE_=
MASK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (option=
al)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        field |=3D CTRL_MSG_TL=
V_OPTIONAL_FLAG;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_wr=
ite_u16(buf, field) &amp;&amp; buf_write_u16(buf, value_len);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_t=
lv_read_header(struct buffer *buf, struct ctrl_msg_tlv_header *hdr)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    int field =3D buf_read_u16(buf);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (field &lt; 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int len =3D buf_read_u16(buf);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (len &lt; 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    hdr-&gt;type =3D (uint16_t)(field &amp; CTRL_MSG_TLV_TYPE_M=
ASK);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt;op=
tional =3D (field &amp; CTRL_MSG_TLV_OPTIONAL_FLAG) !=3D 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt;value_len =3D (uint16_t=
)len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return tru=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ctrl_msg_find_tlv(struct buffer *payload, uint16_t wanted_type, struc=
t buffer *value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_t=
lv_header hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
ool found =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    while (BLEN(payload) &gt; 0)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (!ctrl_msg_tlv_read_header(payload, &amp;hdr))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            /* bytes remain but too few for a h=
eader: truncated */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            return false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* Take the value out of payload=2E This validates that the header&#39;=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * length =
is really there and advances past it in one step, so the TLV</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+         * we are looking for and =
the ones we skip are bounds-checked alike=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        uint8_t *v =3D buf_read_alloc(payload, =
hdr=2Evalue_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (!v)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retu=
rn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (hdr=2Ety=
pe =3D=3D wanted_type)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     if (!found)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       buf_set_read(value, v, hdr=2Evalue_len);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                found =3D true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        else if (!hdr=2Eoptional)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            /* A TLV we do not understand that =
the sender did not mark optional</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+             * carries something it requires us to act on, so =
the message as a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
          * whole is not ours to interpret=2E This is why the scan continue=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * pas=
t the wanted type: such a TLV invalidates the message wherever</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+             * in the sequence i=
t sits=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return found;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --gi=
t a/src/openvpn/control_msg=2Eh b/src/openvpn/control_msg=2Eh</span><br><sp=
an>new file mode 100644</span><br><span>index 0000000=2E=2Eb98dce5</span><b=
r><span>--- /dev/null</span><br><span>+++ b/src/openvpn/control_msg=2Eh</sp=
an><br><span>@@ -0,0 +1,106 @@</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Op=
enVPN -- An application to securely tunnel IP networks</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP por=
t, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *             session authentication and key exchange,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet enc=
ryption, packet authentication, and</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             packet compression=2E</span><br><span style=
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
5f5d1f9=2E=2Ec8fc465 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span=
><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -3676,7 +3676,7 @@<=
/span><br><span>     struct session_id sid; /* remote session ID */</span><=
br><span> </span><br><span>     /* verify legal opcode */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (op &lt; P_FIRST_OPCODE || op &g=
t; P_LAST_OPCODE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (!opcode_valid_in_session(op))</span><br><span>     {</span><br><span>=
         if (op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTRO=
L_HARD_RESET_SERVER_V1)</span><br><span>         {</span><br><span>diff --g=
it a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>inde=
x 6a6d9f9=2E=2E39cb648 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec=
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
44</span><br><span>index 0000000=2E=2E7664639</span><br><span>--- /dev/null=
</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><spa=
n>@@ -0,0 +1,302 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An=
 application to securely tunnel IP networks</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with sup=
port for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *             session authentication and key exchange,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, pa=
cket authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             packet compression=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you =
can redistribute it and/or modify</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  it under the terms of the GNU General Public License vers=
ion 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publish=
ed by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  This program is distributed in the hope that it will be useful,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRAN=
TY; without even the implied warranty of</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GN=
U General Public License for more details=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  You should have received a copy of the GNU General Public Licen=
se along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with th=
is program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
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
n style=3D"color: hsl(120, 100%, 40%);">+/* Reading a TLV header must fail =
when the buffer holds less data than a</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * complete 4-byte header (empty, or only the type field=
), rather than read</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * past the available data=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+test_tlv_header_truncated(void **state)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_header hdr;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* empty buffer */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_tlv_read_h=
eader(&amp;buf, &amp;hdr));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* only=
 the type field present, no length */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(buf_write_u16(&amp;buf, OOB_TLV_PROBE_PAR=
AMETER));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_false(ctrl_msg_tlv_read_header(&amp;buf, &amp;hdr));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+main(void)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    openvpn_unit_test_setup();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const struct CMUnitTest tests[] =3D {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_=
probe_parameter_roundtrip),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cmocka_unit_test(test_probe_reply_roundtrip),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_pro=
be_reply_wire_format),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cmocka_unit_test(test_probe_parameter_forward_compat),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test=
_probe_parameter_too_short),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_find_tlv_value_truncated),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test=
_find_tlv_trailing_bytes),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        cmocka_unit_test(test_tlv_header_truncated),</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return cmocka_run_group_tests_name(&quot;oob tests&quot;, tests=
, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1741?usp=3Demail">change 1741</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c8d302ac57c5603d=
622a7be14be369437388268 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1741 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
=
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@man=
delbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stip=
a &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--O7bOmxpsoiE=--


--===============3214028957623849449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3214028957623849449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3214028957623849449==--

