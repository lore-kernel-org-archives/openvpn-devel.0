Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C793C982D7
	for <openvpn-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rIt0GEacxYW1syqqYuOpptPlu1yc+TsmC68cIM9ElOI=; b=CeQYhTW4eOAud8/2wl7sWxQnUh
	r7uO/Pp87cCs0vCU+pe36TNH8wHuvR4aKeftOhiUj0O7BFuPWrNiyhkRtaFiM61PHo8SVGqgxbXMQ
	H9WnZR18tlf9n0r1swDDtsKM8o4KVOfipiRv9D53nXNZU5H/PSbbcwe5BL++5xWsPiHU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7U0r-0006UC-FS;
	Fri, 18 Sep 2026 08:32:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7U0q-0006U6-8n
 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 08:32:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=kFLUSH+1bNS8y//PvtinaSoltqC+y0GApR3D7gbfNSA=; b=iE2ZqN6G4bnlPhvRxWrnLVFkCX
 FxTv3zN8NzQVy/9+gb5kUodHUqOlju+w6ueXJ7h0QveEGUH5Bz9SW5d1sydUtltjmcW/oOJnFhR3r
 mbU4Zye+Ds2+nSMQ1VpUj2vtTiTaMMNSUf2l3kNK4/3Aq8B0rLEpse1C180gBZlWDGeU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kFLUSH+1bNS8y//PvtinaSoltqC+y0GApR3D7gbfNSA=; b=Z
 5gQc6mEjeEyvngaEvZ44GV1sBxjIR0peE2Mx6chaSbME07ZE3bJnH5iRyBpnGD1fnyzgp6kwYYKrV
 nvka+FhF9c3wH8NIGEqok/JqoXqvT0x9NbUeWAjxDGhWGTYA/VX9+DUrlWj3nrQen1KVgQhpYMV6N
 QI9VFFLK2Nbii6T0=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7U0h-0003Nm-Gr for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 08:32:04 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912e2406so2369095e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 18 Sep 2026 01:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789720309; x=1790325109; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kFLUSH+1bNS8y//PvtinaSoltqC+y0GApR3D7gbfNSA=;
 b=VOp0o2fJdW0fmdRQwXy5MCvJ5+aDdMbEuSrwAabfZk/eIQSSNM+vJjNwjO84i3lcXM
 cO3JkLCqKDqNpFW5ZeVuZPjcrMuEos9bbVnz6L3VwSB5fvLkHn/+PNGtRayudw7wn+cT
 EsbeO8Gwr6Nsj2uT/u8G7AEhOXDLOS9FgmTYPMmjaZEnmYAooI7M+ctmIpNQ0gQkizX5
 G1nYt9CA16DnJ3RPJ+24nEool3OtssVzGwkXW26ZWpaEGMt6mSWDJewrItlKVYR/CSyN
 6xnd2Wo0FupxNuadKodxJN/CN0vWVHIrbvWyRb27f7XSgebd+GK3O8dW5YFFSy/QEagU
 p5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789720309; x=1790325109;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kFLUSH+1bNS8y//PvtinaSoltqC+y0GApR3D7gbfNSA=;
 b=Fqzasgm95KhF9o9o0rA3jjIlI35/P0v1FEY6gXSi/XOrxOrC07u/75Qp2YGkBsLHgC
 3i7or6OmIlu/YgH7u4cnW2LUW4dUdmn9YxqrhtGzKr1eGlzu/IuYiL5CJs7kwEu9b/9S
 jc6YNxCp91uj1n5z4lPhdOccUjc2bkFd5MEh4fFvDu/H7JVGWXCPiVT4J/hFq76JdfMT
 P0qmrgjjMDo8MJMzkF4mi9AfGUR/k/MQa8hGCc9KFTGSJwr9ZsZbqVHIgNj/gz+x7X9/
 9T0XsQI/7iGB5ak0cQcOe9fpBYi+UhFJPHC4aMgqZxZVeHdxXFJhL+r64ozwCxMa6BXq
 Quxg==
X-Gm-Message-State: AFuF++nANuBebBAIWy4UAFCWAPKDQmTdsbjKRBLCp5nZraBtmZdu3w4q
 NKUoZPjOC36Lqz/U75TKH8TyK0SiEKPVR6UJOoJ0kXaSlC+PKn1ivDZUk65RzRHRMXEUHtC1khZ
 +EKbRIzkAMbtXq+u5DWprkYvmrA6zVVz7TAm6FqojhYQfzaAEmy+mOGAncAP+cPvq2MwoU3Ve8g
 ZAzGn+rQ==
X-Gm-Gg: AYBFou1VLHTGQbAsMd5LGEt61QRgGDCec3vH/LBMPTxLNKv40Hzme2SVMOTk6Kh/6S7
 PDPSg2rZwzjk8rn7tci2Fo6+8j9XtPswOyeMgZKuAa8BoEFcvNmmPkOnPO9YfwmCVOy66EHD1b0
 pJJzb7+h0aEngb5VehdiWue29rxY5GH77FZ7tEYDuyimVgLlczi2eJokYGtY9GSCmnpyLRIVXVS
 BFx13nhbgHr6xMorX58w/lfcgCt//1SS26DA5QQer4Qzl2/xyDmjAae7dgH7CjZTiXNsc0HZu8A
 atVvk/PXQv0oYhQeo0IIkgo2iYEHgkdLGSvJvyUs+UK8czL0LboTFnMtxK+SQP+vK0Cp7ebIfZ2
 fPuxh0Acs/nzYRt6ZEGxxrHY5cT+cgooLJDPR9mw7rWq8BsTVTmnxPjh1cgvuPMCQrbiRL2qqN5
 W4AH7l1rAMWw/USK+Fp7AHy3Cau/oIcKvJFMwy4kxnDc+pPIlAYXG4TLEUL1VRrA4/QRbPaXJa+
 WjMIMduZ07SNOhzb3JxPHARKeV8ZZVIja7wln+zNczCPZRTzoyK5n4aIIOOa5vOIqQV+XgOipEi
 3WdlPFZViYwNlx/JqT0fquuR5YS7Z4B4jotFAOWNhIBd+z5LCGAfZ8BiJOm5I7cb+cxPll0=
X-Received: by 2002:a05:600c:83c9:b0:49c:f13e:e4d with SMTP id
 5b1f17b1804b1-49fc4ff402cmr23357535e9.10.1789720308089; 
 Fri, 18 Sep 2026 01:31:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd24034esm167274585e9.15.2026.09.18.01.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 01:31:47 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 18 Sep 2026 08:31:39 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>,
 ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 17
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: ffa8097cbd669f623a93dd9b368ffb776ae60d2e
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <aab5947f59de9584c317fc899570ac8f7e843de5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7U0h-0003Nm-Gr
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
Content-Type: multipart/mixed; boundary="===============5942944057437733405=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5942944057437733405==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oHoBjJkZabg="; charset=UTF-8

--oHoBjJkZabg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici, s=
tipa=2E

Hello flichtenheld, plaisthos, ralf_lici, 

I'd like you to reexam=
ine a change=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1741?usp=3Demail

to look at the new patch set (#17)=2E

The following app=
rovals got outdated and were removed:
Code-Review-1 by plaisthos


Change s=
ubject: oob: Add control message TLV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add control messa=
ge TLV encoding (P_CONTROL_OOB_V1)

Out-of-band control messages carry cont=
rol data but belong to no
session, so a client can ask a server about itsel=
f before connecting=2E
Reserve opcode 12 for them and add the codec for the=
 two messages the
probe needs, SERVER_PROBE and PROBE_REPLY=2E

The spec us=
es the same TLV framing for all its control messages, not
just the out-of-b=
and ones, so the message-type header, the TLV header
and the TLV scan go in=
to their own control_msg=2Ec/h; oob=2Ec keeps the OOB
message and TLV types=
=2E

The scan is strict: a header or value that does not fit in the remaini=
ng
payload, including trailing bytes too few for a header, or an unknown
TL=
V not marked optional rejects the whole message rather than just the
TLV=2E=


P_LAST_OPCODE becomes 12=2E tls_pre_decrypt() rejects the OOB opcodes
exp=
licitly: they are not part of the reliable control channel (no
control mess=
age id, no ACK array), so do_pre_decrypt_check() answers
them statelessly i=
nstead=2E

See "Out of band and control data messages" and "[OPCODE ID 12]
=
CONTROL_OOB_V1" in the wire protocol specification
(openvpn-rfc, openvpn-wi=
re-protocol=2Exml)=2E

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
M tests/unit_tes=
ts/openvpn/test_pkt=2Ec
12 files changed, 791 insertions(+), 6 deletions(-)=



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/17=
41/17

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 6eb5954=2E=2E=
72680b2 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -445,6 +445=
,8 @@
     src/openvpn/console=2Ec
     src/openvpn/console_builtin=2Ec
   =
  src/openvpn/console=2Eh
+    src/openvpn/control_msg=2Ec
+    src/openvpn=
/control_msg=2Eh
     src/openvpn/crypto=2Ec
     src/openvpn/crypto=2Eh
  =
   src/openvpn/crypto_backend=2Eh
@@ -523,6 +525,8 @@
     src/openvpn/mult=
i_io=2Ec
     src/openvpn/occ=2Ec
     src/openvpn/occ=2Eh
+    src/openvpn=
/oob=2Ec
+    src/openvpn/oob=2Eh
     src/openvpn/openvpn=2Ec
     src/ope=
nvpn/openvpn=2Eh
     src/openvpn/openvpn_win32_resources=2Erc
@@ -883,6 +8=
87,9 @@
 
     target_sources(test_pkt PRIVATE
         tests/unit_tests/op=
envpn/mock_win32_execve=2Ec
+        tests/unit_tests/openvpn/test_oob=2Ec
=
+        src/openvpn/control_msg=2Ec
+        src/openvpn/oob=2Ec
         =
src/openvpn/argv=2Ec
         src/openvpn/base64=2Ec
         src/openvpn/c=
rypto_epoch=2Ec
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefi=
le=2Eam
index 7fd12b4=2E=2E5e6b4d9 100644
--- a/src/openvpn/Makefile=2Eam
+=
++ b/src/openvpn/Makefile=2Eam
@@ -53,6 +53,7 @@
 	common=2Eh \
 	comp=2Ec =
comp=2Eh compstub=2Ec \
 	comp-lz4=2Ec comp-lz4=2Eh \
+	control_msg=2Ec con=
trol_msg=2Eh \
 	crypto=2Ec crypto=2Eh crypto_backend=2Eh \
 	crypto_openss=
l=2Ec crypto_openssl=2Eh \
 	crypto_mbedtls_legacy=2Ec crypto_mbedtls_legac=
y=2Eh \
@@ -107,6 +108,7 @@
 	pkcs11=2Ec pkcs11=2Eh pkcs11_backend=2Eh \
 	=
pkcs11_openssl=2Ec \
 	pkcs11_mbedtls=2Ec \
+	oob=2Ec oob=2Eh \
 	openvpn=
=2Ec openvpn=2Eh \
 	options=2Ec options=2Eh \
 	options_show=2Ec options_s=
how=2Eh \
diff --git a/src/openvpn/control_msg=2Ec b/src/openvpn/control_ms=
g=2Ec
new file mode 100644
index 0000000=2E=2E35c2e77
--- /dev/null
+++ b/s=
rc/openvpn/control_msg=2Ec
@@ -0,0 +1,105 @@
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
+#ifdef HAVE_CON=
FIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include =
"control_msg=2Eh"
+
+bool
+ctrl_msg_read_header(struct buffer *buf, uint16_=
t expected_msg_type)
+{
+    int msg_type =3D buf_read_u16(buf);
+    retur=
n msg_type >=3D 0 && (uint16_t)msg_type =3D=3D expected_msg_type;
+}
+
+boo=
l
+ctrl_msg_tlv_write_header(struct buffer *buf, uint16_t type, bool option=
al, uint16_t value_len)
+{
+    uint16_t field =3D type & CTRL_MSG_TLV_TYPE=
_MASK;
+    if (optional)
+    {
+        field |=3D CTRL_MSG_TLV_OPTIONAL_=
FLAG;
+    }
+    return buf_write_u16(buf, field) && buf_write_u16(buf, va=
lue_len);
+}
+
+bool
+ctrl_msg_tlv_read_header(struct buffer *buf, struct c=
trl_msg_tlv_header *hdr)
+{
+    int field =3D buf_read_u16(buf);
+    if (=
field < 0)
+    {
+        return false;
+    }
+    int len =3D buf_read_u=
16(buf);
+    if (len < 0)
+    {
+        return false;
+    }
+    hdr->t=
ype =3D (uint16_t)(field & CTRL_MSG_TLV_TYPE_MASK);
+    hdr->optional =3D =
(field & CTRL_MSG_TLV_OPTIONAL_FLAG) !=3D 0;
+    hdr->value_len =3D (uint1=
6_t)len;
+    return true;
+}
+
+bool
+ctrl_msg_find_tlv(struct buffer *pay=
load, uint16_t wanted_type, struct buffer *value)
+{
+    struct ctrl_msg_t=
lv_header hdr;
+    bool found =3D false;
+    while (BLEN(payload) > 0)
+ =
   {
+        if (!ctrl_msg_tlv_read_header(payload, &hdr))
+        {
+   =
         return false; /* fewer than 4 bytes left: truncated header */
+   =
     }
+        /* Advance past the value; fails if the payload is shorter =
than the
+         * header claims=2E */
+        uint8_t *v =3D buf_read_a=
lloc(payload, hdr=2Evalue_len);
+        if (!v)
+        {
+            re=
turn false;
+        }
+        if (hdr=2Etype =3D=3D wanted_type)
+       =
 {
+            if (!found)
+            {
+                buf_set_read(va=
lue, v, hdr=2Evalue_len);
+                found =3D true;
+            }
+=
        }
+        else if (!hdr=2Eoptional)
+        {
+            /* A T=
LV we do not understand that the sender did not mark optional
+            =
 * carries something it requires us to act on, so the message as a
+       =
      * whole is not ours to interpret=2E This is why the scan continues
+ =
            * past the wanted type: such a TLV invalidates the message wher=
ever
+             * in the sequence it sits=2E */
+            return fals=
e;
+        }
+    }
+    return found;
+}
diff --git a/src/openvpn/control=
_msg=2Eh b/src/openvpn/control_msg=2Eh
new file mode 100644
index 0000000=
=2E=2E0ead9a5
--- /dev/null
+++ b/src/openvpn/control_msg=2Eh
@@ -0,0 +1,10=
9 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ * =
            over a single TCP/UDP port, with support for SSL/TLS-based
+ * =
            session authentication and key exchange,
+ *             packet=
 encryption, packet authentication, and
+ *             packet compression=
=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
=
+ *  This program is free software; you can redistribute it and/or modify
+=
 *  it under the terms of the GNU General Public License version 2
+ *  as =
published by the Free Software Foundation=2E
+ *
+ *  This program is distr=
ibuted in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; w=
ithout even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A P=
ARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more deta=
ils=2E
+ *
+ *  You should have received a copy of the GNU General Public L=
icense along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/l=
icenses/>=2E
+ */
+
+/**
+ * @file
+ * Framing shared by the TLV-based cont=
rol messages of the wire protocol=2E
+ *
+ * Such a message payload starts =
with a 16-bit message type, followed by a
+ * sequence of TLV entries=2E Ea=
ch TLV starts with a 4-byte header: a 16-bit field
+ * whose most significa=
nt bit is the "optional" flag and whose remaining 15 bits
+ * are the type,=
 followed by a 16-bit length giving the size of the value that
+ * follows =
the header=2E
+ *
+ * The message-type and TLV-type values themselves are s=
pecific to the message
+ * family carried (out-of-band messages define thei=
rs in oob=2Eh), so only the
+ * framing lives here=2E
+ */
+
+#ifndef CONTR=
OL_MSG_H
+#define CONTROL_MSG_H
+
+#include "buffer=2Eh"
+
+/* TLV header b=
it layout of the first 16-bit field */
+#define CTRL_MSG_TLV_OPTIONAL_FLAG =
0x8000
+#define CTRL_MSG_TLV_TYPE_MASK     0x7fff
+
+/* The header every TL=
V carries: the 15-bit type and optional flag packed into
+ * the first 16-b=
it field, then the length of the value that follows=2E */
+struct ctrl_msg_=
tlv_header
+{
+    uint16_t type;      /**< the 15-bit TLV type */
+    boo=
l optional;      /**< value of the optional flag */
+    uint16_t value_len=
; /**< length of the value following the header */
+};
+
+/**
+ * Read and =
verify a message-type header from buf, advancing past it=2E
+ *
+ * @param =
buf                buffer positioned at the message payload
+ * @param expe=
cted_msg_type  the message type the payload must carry
+ * @return true if =
a message type was read and equals expected_msg_type,
+ *         false on =
a short buffer or a mismatching type=2E
+ */
+bool ctrl_msg_read_header(str=
uct buffer *buf, uint16_t expected_msg_type);
+
+/**
+ * Write a TLV header=
 (type + optional flag + value length) to buf=2E
+ *
+ * @return true on su=
ccess, false if buf has insufficient space=2E
+ */
+bool ctrl_msg_tlv_write=
_header(struct buffer *buf, uint16_t type, bool optional,
+                =
               uint16_t value_len);
+
+/**
+ * Read a TLV header from buf, =
advancing past it=2E
+ *
+ * @param buf  buffer positioned at the TLV heade=
r
+ * @param hdr  filled with the type, optional flag and value length on s=
uccess
+ * @return true on success, false if there are not enough bytes for=
 a header=2E
+ */
+bool ctrl_msg_tlv_read_header(struct buffer *buf, struct=
 ctrl_msg_tlv_header *hdr);
+
+/**
+ * Scan payload for the TLV of type wan=
ted_type, skipping any other (e=2Eg=2E
+ * future) TLV type that is marked =
optional=2E
+ *
+ * This is for messages that carry exactly one mandatory T=
LV, which matches the
+ * currently supported OOB messages: any other TLV t=
hat is not marked optional
+ * invalidates the message wherever it is prese=
nt, so the whole sequence is
+ * walked=2E A message with several mandatory=
 TLVs would need a scan that knows
+ * all of them=2E
+ *
+ * On success va=
lue covers exactly the found TLV's value bytes=2E The length from
+ * each =
TLV header is validated against payload as the scan goes, so the whole
+ * =
value is guaranteed to be present; a header claiming more bytes than payloa=
d
+ * holds is rejected rather than reported as found=2E payload is consume=
d as it is
+ * read=2E
+ *
+ * @param payload      buffer positioned at a T=
LV header
+ * @param wanted_type  the TLV type to look for
+ * @param value=
        set to a buffer covering the found TLV's value; it points
+ *      =
               into payload and owns no storage
+ * @return true if the TLV=
 was found, false if it is not present, a TLV header
+ *         or value i=
s malformed or truncated, or a TLV we do not understand is
+ *         not =
marked optional=2E
+ */
+bool ctrl_msg_find_tlv(struct buffer *payload, uin=
t16_t wanted_type, struct buffer *value);
+
+#endif /* ifndef CONTROL_MSG_H=
 */
diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
new file mode 10=
0644
index 0000000=2E=2Ec807171
--- /dev/null
+++ b/src/openvpn/oob=2Ec
@@ =
-0,0 +1,83 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP netw=
orks
+ *             over a single TCP/UDP port, with support for SSL/TLS-b=
ased
+ *             session authentication and key exchange,
+ *          =
   packet encryption, packet authentication, and
+ *             packet com=
pression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2En=
et>
+ *
+ *  This program is free software; you can redistribute it and/or =
modify
+ *  it under the terms of the GNU General Public License version 2
=
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This program =
is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WAR=
RANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS=
 FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for m=
ore details=2E
+ *
+ *  You should have received a copy of the GNU General =
Public License along
+ *  with this program; if not, see <https://www=2Egnu=
=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#=
endif
+
+#include "syshead=2Eh"
+
+#include "oob=2Eh"
+#include "control_ms=
g=2Eh"
+
+bool
+oob_probe_parameter_write(struct buffer *buf, const struct =
oob_probe_parameter *p)
+{
+    return ctrl_msg_tlv_write_header(buf, OOB_T=
LV_PROBE_PARAMETER, false, OOB_PROBE_PARAMETER_LEN)
+           && buf_writ=
e_u64(buf, p->timestamp)
+           && buf_write_u32(buf, p->flags);
+}
+
=
+bool
+oob_probe_parameter_read(struct buffer *buf, struct oob_probe_parame=
ter *p)
+{
+    /* One bounds check covers the whole value: every field rea=
d below then fits
+     * by construction (OOB_PROBE_PARAMETER_LEN is the s=
um of their sizes), so
+     * none of them needs its own error handling=2E=
 Trailing bytes this version
+     * does not understand are simply left un=
read=2E */
+    if (buf_len(buf) < OOB_PROBE_PARAMETER_LEN)
+    {
+       =
 return false;
+    }
+    p->timestamp =3D buf_read_u64(buf, NULL);
+    p=
->flags =3D buf_read_u32(buf, NULL);
+    return true;
+}
+
+bool
+oob_prob=
e_reply_write(struct buffer *buf, const struct oob_probe_reply *r)
+{
+    =
return ctrl_msg_tlv_write_header(buf, OOB_TLV_PROBE_REPLY, false, OOB_PROBE=
_REPLY_LEN)
+           && session_id_write(&r->peer_session_id, buf)
+    =
       && buf_write_u16(buf, r->priority)
+           && buf_write_u16(buf,=
 r->weight)
+           && buf_write_u16(buf, r->max_latency_diff)
+       =
    && buf_write_u16(buf, r->connect_lifetime)
+           && buf_write_u32=
(buf, r->flags);
+}
+
+bool
+oob_probe_reply_read(struct buffer *buf, struc=
t oob_probe_reply *r)
+{
+    /* One bounds check for the whole value, as i=
n oob_probe_parameter_read()=2E */
+    if (buf_len(buf) < OOB_PROBE_REPLY_=
LEN)
+    {
+        return false;
+    }
+    session_id_read(&r->peer_ses=
sion_id, buf);
+    r->priority =3D (uint16_t)buf_read_u16(buf);
+    r->we=
ight =3D (uint16_t)buf_read_u16(buf);
+    r->max_latency_diff =3D (uint16_=
t)buf_read_u16(buf);
+    r->connect_lifetime =3D (uint16_t)buf_read_u16(bu=
f);
+    r->flags =3D buf_read_u32(buf, NULL);
+    return true;
+}
diff --=
git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
new file mode 100644
index =
0000000=2E=2Ec5396b3
--- /dev/null
+++ b/src/openvpn/oob=2Eh
@@ -0,0 +1,110=
 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *  =
           over a single TCP/UDP port, with support for SSL/TLS-based
+ *  =
           session authentication and key exchange,
+ *             packet =
encryption, packet authentication, and
+ *             packet compression=
=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
=
+ *  This program is free software; you can redistribute it and/or modify
+=
 *  it under the terms of the GNU General Public License version 2
+ *  as =
published by the Free Software Foundation=2E
+ *
+ *  This program is distr=
ibuted in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; w=
ithout even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A P=
ARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more deta=
ils=2E
+ *
+ *  You should have received a copy of the GNU General Public L=
icense along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/l=
icenses/>=2E
+ */
+
+/**
+ * @file
+ * Encoding/decoding of out-of-band (P_=
CONTROL_OOB_V1) control messages=2E
+ *
+ * An OOB message payload starts w=
ith a 16-bit message type (the 0x1xx space:
+ * SERVER_PROBE, PROBE_REPLY, =
=2E=2E=2E) followed by a sequence of TLV entries in the
+ * 0x2xx type spac=
e=2E The framing itself is shared with the other TLV-based
+ * control mess=
ages of the wire protocol and lives in control_msg=2Eh; this file
+ * defin=
es the OOB message and TLV types, their values, and the OOB-specific
+ * de=
cisions taken on them=2E
+ */
+
+#ifndef OOB_H
+#define OOB_H
+
+#include "=
buffer=2Eh"
+#include "session_id=2Eh"
+
+/* OOB message types: the 16-bit =
value at the start of an OOB payload, before
+ * its TLV entries=2E Distinc=
t from the TLV-type space (0x2xx); see the "Messages"
+ * table in the OOB =
section of the wire protocol spec=2E */
+#define OOB_MSG_SERVER_PROBE 0x100=

+#define OOB_MSG_PROBE_REPLY  0x101
+
+/* TLV types (see the OOB control m=
essage section of the wire protocol spec) */
+#define OOB_TLV_PROBE_PARAMET=
ER 0x200
+#define OOB_TLV_PROBE_REPLY     0x201
+
+/* Minimum on-wire value=
 length (excluding the 4-byte TLV header) of each TLV:
+ * the sizes of its=
 fixed fields in wire order (see the structs below)=2E The
+ * value may be=
 longer for forward compatibility; trailing bytes that are not
+ * understo=
od are ignored on read=2E */
+#define OOB_PROBE_PARAMETER_LEN \
+    ((uint=
16_t)(sizeof(uint64_t) /* timestamp */ + sizeof(uint32_t) /* flags */))
+#d=
efine OOB_PROBE_REPLY_LEN                                   \
+    ((uint16=
_t)(SID_SIZE               /* peer_session_id */  \
+                + 4 * =
sizeof(uint16_t) /* priority, weight,   \
+                                =
        * max_latency_diff,   \
+                                        * =
connect_lifetime */ \
+                + sizeof(uint32_t)))   /* flags */
+=

+/* probe parameter TLV (sent by the client in a SERVER_PROBE) */
+struct =
oob_probe_parameter
+{
+    uint64_t timestamp; /**< client clock as a UNIX=
 timestamp */
+    uint32_t flags;     /**< client capability flags, curren=
tly must be 0 */
+};
+
+/* probe reply TLV (sent by the server in a PROBE_R=
EPLY) */
+struct oob_probe_reply
+{
+    struct session_id peer_session_id;=
 /**< echoes the session id of the request */
+    uint16_t priority;      =
           /**< DNS-SRV style priority (lower is preferred) */
+    uint16_=
t weight;                   /**< DNS-SRV style weight */
+    uint16_t max_=
latency_diff;         /**< advertised candidate-band margin in ms;
+       =
                                 *   used unless the client configured its =
own */
+    uint16_t connect_lifetime;         /**< seconds the reply stays=
 valid as the handshake reset */
+    uint32_t flags;                    /*=
*< server behaviour flags */
+};
+
+/**
+ * Write a complete probe paramete=
r TLV (header + value) to buf=2E
+ */
+bool oob_probe_parameter_write(struc=
t buffer *buf, const struct oob_probe_parameter *p);
+
+/**
+ * Read a prob=
e parameter TLV value from buf=2E
+ *
+ * buf must cover exactly the TLV's =
value, as returned by ctrl_msg_find_tlv()=2E
+ * Trailing bytes beyond the =
fields understood here are ignored, so a longer
+ * value from a future ver=
sion still parses=2E
+ *
+ * @return true on success, false if buf is short=
er than the mandatory fields=2E
+ */
+bool oob_probe_parameter_read(struct =
buffer *buf, struct oob_probe_parameter *p);
+
+/**
+ * Write a complete pr=
obe reply TLV (header + value) to buf=2E
+ */
+bool oob_probe_reply_write(s=
truct buffer *buf, const struct oob_probe_reply *r);
+
+/**
+ * Read a prob=
e reply TLV value from buf=2E See oob_probe_parameter_read() for the
+ * ca=
lling convention=2E
+ */
+bool oob_probe_reply_read(struct buffer *buf, str=
uct oob_probe_reply *r);
+
+#endif /* OOB_H */
diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec
index 76150d4=2E=2Ea6a67a2 100644
--- a/src/open=
vpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -3705,8 +3705,10 @@
     bool new_=
link =3D false;
     struct session_id sid; /* remote session ID */
 
-    =
/* verify legal opcode */
-    if (op < P_FIRST_OPCODE || op > P_LAST_OPCOD=
E)
+    /* verify legal opcode=2E An out-of-band packet has no control mess=
age id and
+     * no ACK array, which is what we parse next; do_pre_decryp=
t_check() answers
+     * those=2E */
+    if (op < P_FIRST_OPCODE || op > =
P_LAST_OPCODE || opcode_is_oob(op))
     {
         if (op =3D=3D P_CONTROL=
_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)
        =
 {
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index 90b=
2aec=2E=2Ebfcbf31 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ss=
l_pkt=2Ec
@@ -168,6 +168,9 @@
 {
     ASSERT(ks->key_id >=3D 0 && ks->key_i=
d <=3D P_KEY_ID_MASK);
     ASSERT(opcode >=3D 0 && opcode <=3D P_LAST_OPCO=
DE);
+    /* OOB packets carry no message id or ACK array; tls_wrap_oob_sta=
ndalone()
+     * builds them */
+    ASSERT(!opcode_is_oob(opcode));
     =
uint8_t header =3D (uint8_t)(ks->key_id | (opcode << P_OPCODE_SHIFT));
 
  =
   /* Workaround for Softether servers=2E Softether has a bug that it only
=
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 03e893=
0=2E=2Ef631308 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_p=
kt=2Eh
@@ -58,11 +58,25 @@
  * like P_CONTROL_HARD_RESET_CLIENT_V3 */
 #def=
ine P_CONTROL_WKC_V1 11
 
-/* define the range of legal opcodes
+/* Out-of-=
band control message, e=2Eg=2E a server probe=2E Not part of the reliable
+=
 * control channel: no control message id and no ACK array, just TLVs after=
 the
+ * session id=2E Answered statelessly in do_pre_decrypt_check(), neve=
r handled by
+ * tls_pre_decrypt()=2E */
+#define P_CONTROL_OOB_V1 12
+
+/*=
 define the range of defined opcodes, in- and out-of-band
  * Since we do n=
o longer support key-method 1 we consider
  * the v1 op codes invalid */
 #=
define P_FIRST_OPCODE 3
-#define P_LAST_OPCODE  11
+#define P_LAST_OPCODE  =
12
+
+/* OOB opcodes are not part of the reliable control channel: no contr=
ol message
+ * id and no ACK array=2E */
+static inline bool
+opcode_is_oob=
(int op)
+{
+    return op =3D=3D P_CONTROL_OOB_V1;
+}
 
 /*
  * Define num=
ber of buffers for send and receive in the reliability layer=2E
@@ -256,6 +=
270,9 @@
         case P_CONTROL_WKC_V1:
             return "P_CONTROL_WKC=
_V1";
 
+        case P_CONTROL_OOB_V1:
+            return "P_CONTROL_OOB_=
V1";
+
         case P_ACK_V1:
             return "P_ACK_V1";
 
diff --git=
 a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefi=
le=2Eam
index 5954902=2E=2Ee6c8fb5 100644
--- a/tests/unit_tests/openvpn/Ma=
kefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -157,10 +157,13=
 @@
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/sr=
c/openvpn \
 	@TEST_CFLAGS@
 pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
-pkt=
_testdriver_SOURCES =3D test_pkt=2Ec mock_msg=2Ec mock_msg=2Eh mock_win32_e=
xecve=2Ec test_common=2Eh \
+pkt_testdriver_SOURCES =3D test_pkt=2Ec test_o=
ob=2Ec mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec \
+	test_common=2Eh =
\
 	$(top_srcdir)/src/openvpn/argv=2Ec \
 	$(top_srcdir)/src/openvpn/base64=
=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
+	$(top_srcdir)/src/openvpn=
/control_msg=2Ec \
+	$(top_srcdir)/src/openvpn/oob=2Ec \
 	$(top_srcdir)/sr=
c/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \
 	$(t=
op_srcdir)/src/openvpn/crypto_mbedtls=2Ec \
diff --git a/tests/unit_tests/o=
penvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
new file mode 1=
00644
index 0000000=2E=2Ef81158e
--- /dev/null
+++ b/tests/unit_tests/openv=
pn/test_oob=2Ec
@@ -0,0 +1,340 @@
+/*
+ *  OpenVPN -- An application to sec=
urely tunnel IP networks
+ *             over a single TCP/UDP port, with s=
upport for SSL/TLS-based
+ *             session authentication and key exc=
hange,
+ *             packet encryption, packet authentication, and
+ *   =
          packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN In=
c <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you can red=
istribute it and/or modify
+ *  it under the terms of the GNU General Publi=
c License version 2
+ *  as published by the Free Software Foundation=2E
+ =
*
+ *  This program is distributed in the hope that it will be useful,
+ * =
 but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHA=
NTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General =
Public License for more details=2E
+ *
+ *  You should have received a copy=
 of the GNU General Public License along
+ *  with this program; if not, se=
e <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#inc=
lude "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdarg=2Eh=
>
+#include <stddef=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#=
include "control_msg=2Eh"
+#include "oob=2Eh"
+#include "test_common=2Eh"
+=

+/* Write a probe parameter TLV and read it back; fields must survive the
=
+ * round trip and the whole buffer must be consumed=2E */
+static void
+te=
st_probe_parameter_roundtrip(void **state)
+{
+    struct gc_arena gc =3D g=
c_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const st=
ruct oob_probe_parameter in =3D {
+        =2Etimestamp =3D 0x0123456789abc=
defULL,
+        =2Eflags =3D 0,
+    };
+    assert_true(oob_probe_paramet=
er_write(&buf, &in));
+    /* header (4) + value (12) */
+    assert_int_eq=
ual(BLEN(&buf), 4 + OOB_PROBE_PARAMETER_LEN);
+
+    /* the header codec, r=
ead from a copy so the scan below still sees it */
+    struct buffer peek =
=3D buf;
+    struct ctrl_msg_tlv_header hdr;
+    assert_true(ctrl_msg_tlv=
_read_header(&peek, &hdr));
+    assert_int_equal(hdr=2Etype, OOB_TLV_PROBE=
_PARAMETER);
+    assert_false(hdr=2Eoptional);
+    assert_int_equal(hdr=
=2Evalue_len, OOB_PROBE_PARAMETER_LEN);
+
+    struct buffer value;
+    as=
sert_true(ctrl_msg_find_tlv(&buf, OOB_TLV_PROBE_PARAMETER, &value));
+    a=
ssert_int_equal(BLEN(&value), OOB_PROBE_PARAMETER_LEN);
+
+    struct oob_p=
robe_parameter out =3D { 0 };
+    assert_true(oob_probe_parameter_read(&va=
lue, &out));
+    assert_true(in=2Etimestamp =3D=3D out=2Etimestamp);
+    =
assert_int_equal(in=2Eflags, out=2Eflags);
+    /* the scan consumed header=
 and value alike */
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&g=
c);
+}
+
+/* Write a probe reply TLV and read it back=2E */
+static void
+t=
est_probe_reply_roundtrip(void **state)
+{
+    struct gc_arena gc =3D gc_n=
ew();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    struct oob_=
probe_reply in =3D {
+        =2Epriority =3D 10,
+        =2Eweight =3D 10=
0,
+        =2Econnect_lifetime =3D 30,
+        =2Eflags =3D 1,
+        =
=2Emax_latency_diff =3D 25,
+    };
+    memcpy(in=2Epeer_session_id=2Eid, =
"ABCDEFGH", SID_SIZE);
+
+    assert_true(oob_probe_reply_write(&buf, &in))=
;
+    assert_int_equal(BLEN(&buf), 4 + OOB_PROBE_REPLY_LEN);
+
+    struct=
 buffer peek =3D buf;
+    struct ctrl_msg_tlv_header hdr;
+    assert_true=
(ctrl_msg_tlv_read_header(&peek, &hdr));
+    assert_int_equal(hdr=2Etype, =
OOB_TLV_PROBE_REPLY);
+    assert_int_equal(hdr=2Evalue_len, OOB_PROBE_REPL=
Y_LEN);
+
+    struct buffer value;
+    assert_true(ctrl_msg_find_tlv(&buf=
, OOB_TLV_PROBE_REPLY, &value));
+
+    struct oob_probe_reply out =3D { 0 =
};
+    assert_true(oob_probe_reply_read(&value, &out));
+    assert_memory=
_equal(in=2Epeer_session_id=2Eid, out=2Epeer_session_id=2Eid, SID_SIZE);
+ =
   assert_int_equal(in=2Epriority, out=2Epriority);
+    assert_int_equal(i=
n=2Eweight, out=2Eweight);
+    assert_int_equal(in=2Econnect_lifetime, out=
=2Econnect_lifetime);
+    assert_int_equal(in=2Eflags, out=2Eflags);
+    =
assert_int_equal(in=2Emax_latency_diff, out=2Emax_latency_diff);
+    asser=
t_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* The probe reply w=
ire format is locked to the spec's field order
+ * (priority, weight, max_l=
atency_diff, connect_lifetime, flags), big-endian=2E */
+static void
+test_=
probe_reply_wire_format(void **state)
+{
+    struct gc_arena gc =3D gc_new=
();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    struct oob_pr=
obe_reply in =3D {
+        =2Epriority =3D 10,
+        =2Eweight =3D 100,=

+        =2Econnect_lifetime =3D 30,
+        =2Eflags =3D 1,
+        =2E=
max_latency_diff =3D 25,
+    };
+    memcpy(in=2Epeer_session_id=2Eid, "AB=
CDEFGH", SID_SIZE);
+
+    assert_true(oob_probe_reply_write(&buf, &in));
+=

+    const uint8_t expected[] =3D {
+        0x02,
+        0x01, /* TLV t=
ype 0x201 (not optional) */
+        0x00,
+        0x14, /* TLV value leng=
th =3D 20 */
+        'A',
+        'B',
+        'C',
+        'D',
+     =
   'E',
+        'F',
+        'G',
+        'H',  /* peer_session_id */
+ =
       0x00,
+        0x0a, /* priority =3D 10 */
+        0x00,
+        0=
x64, /* weight =3D 100 */
+        0x00,
+        0x19, /* max_latency_diff=
 =3D 25 */
+        0x00,
+        0x1e, /* connect_lifetime =3D 30 */
+   =
     0x00,
+        0x00,
+        0x00,
+        0x01, /* flags =3D 1 */
+=
    };
+    assert_int_equal(BLEN(&buf), sizeof(expected));
+    assert_mem=
ory_equal(BPTR(&buf), expected, sizeof(expected));
+
+    gc_free(&gc);
+}
=
+
+/* A TLV with a longer-than-known value must still parse: the known fiel=
ds are
+ * read and the trailing bytes are skipped (forward compatibility)=
=2E */
+static void
+test_probe_parameter_forward_compat(void **state)
+{
+=
    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_g=
c(128, &gc);
+
+    const uint16_t extended_len =3D OOB_PROBE_PARAMETER_LEN=
 + 4;
+    assert_true(ctrl_msg_tlv_write_header(&buf, OOB_TLV_PROBE_PARAME=
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
+    struct buffer value;
+    assert_true(ctrl_msg_find_tl=
v(&buf, OOB_TLV_PROBE_PARAMETER, &value));
+    assert_int_equal(BLEN(&valu=
e), extended_len);
+
+    struct oob_probe_parameter out =3D { 0 };
+    as=
sert_true(oob_probe_parameter_read(&value, &out));
+    assert_true(out=2Et=
imestamp =3D=3D 0xdeadbeefULL);
+    assert_int_equal(out=2Eflags, 0);
+   =
 /* the unknown trailing field must have been consumed from the payload */
=
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* A value=
 shorter than the mandatory fields must be rejected, even when it
+ * holds=
 enough bytes for some of the individual fields to read successfully=2E */
=
+static void
+test_probe_parameter_too_short(void **state)
+{
+    struct g=
c_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);=

+
+    /* 4 of the 12 mandatory value bytes: too short for the timestamp, =
but
+     * enough for a u32 read to succeed on its own */
+    assert_true=
(buf_write_u32(&buf, 0xdeadbeef));
+
+    struct oob_probe_parameter out =
=3D { 0 };
+    assert_false(oob_probe_parameter_read(&buf, &out));
+
+    =
gc_free(&gc);
+}
+
+/* A TLV header claiming more value bytes than the payl=
oad holds must be
+ * rejected by the scan rather than reported as found --=
 for the TLV being
+ * looked for as much as for one that would merely be s=
kipped=2E */
+static void
+test_find_tlv_value_truncated(void **state)
+{
+=
    struct gc_arena gc =3D gc_new();
+    struct buffer value;
+
+    /* th=
e wanted TLV declares 12 value bytes, only 4 are present */
+    struct buf=
fer buf =3D alloc_buf_gc(128, &gc);
+    assert_true(ctrl_msg_tlv_write_hea=
der(&buf, OOB_TLV_PROBE_PARAMETER, false,
+                                =
          OOB_PROBE_PARAMETER_LEN));
+    assert_true(buf_write_u32(&buf, 0=
xdeadbeef));
+    assert_false(ctrl_msg_find_tlv(&buf, OOB_TLV_PROBE_PARAME=
TER, &value));
+
+    /* same defect on a TLV that would be skipped: the sc=
an must not walk past
+     * the end of the payload looking for the next h=
eader */
+    struct buffer buf2 =3D alloc_buf_gc(128, &gc);
+    assert_tr=
ue(ctrl_msg_tlv_write_header(&buf2, 0x7ff, false, 64));
+    assert_true(bu=
f_write_u32(&buf2, 0));
+    assert_false(ctrl_msg_find_tlv(&buf2, OOB_TLV_=
PROBE_PARAMETER, &value));
+
+    gc_free(&gc);
+}
+
+/* Bytes left over af=
ter the last TLV that are too few for a header make the
+ * message malform=
ed, even when the wanted TLV was already found=2E */
+static void
+test_fin=
d_tlv_trailing_bytes(void **state)
+{
+    struct gc_arena gc =3D gc_new();=

+    struct buffer value;
+
+    /* 1 to 3 bytes: less than a 4-byte TLV h=
eader */
+    for (int trailing =3D 1; trailing <=3D 3; trailing++)
+    {
=
+        struct buffer buf =3D alloc_buf_gc(128, &gc);
+        const struc=
t oob_probe_parameter in =3D { =2Etimestamp =3D 1, =2Eflags =3D 0 };
+     =
   assert_true(oob_probe_parameter_write(&buf, &in));
+        for (int i =
=3D 0; i < trailing; i++)
+        {
+            assert_true(buf_write_u8(=
&buf, 0));
+        }
+        assert_false(ctrl_msg_find_tlv(&buf, OOB_TLV=
_PROBE_PARAMETER, &value));
+    }
+
+    gc_free(&gc);
+}
+
+/* An unknown=
 TLV marked optional after the wanted one is skipped, and the
+ * wanted va=
lue is still the one returned=2E */
+static void
+test_find_tlv_skips_optio=
nal_after_wanted(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+  =
  struct buffer buf =3D alloc_buf_gc(128, &gc);
+    struct buffer value;
+=

+    const struct oob_probe_parameter in =3D { =2Etimestamp =3D 7, =2Eflag=
s =3D 0 };
+    assert_true(oob_probe_parameter_write(&buf, &in));
+    ass=
ert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    assert_true=
(buf_write_u32(&buf, 0));
+
+    assert_true(ctrl_msg_find_tlv(&buf, OOB_TL=
V_PROBE_PARAMETER, &value));
+    assert_int_equal(BLEN(&value), OOB_PROBE_=
PARAMETER_LEN);
+    struct oob_probe_parameter out =3D { 0 };
+    assert_=
true(oob_probe_parameter_read(&value, &out));
+    assert_true(out=2Etimest=
amp =3D=3D 7);
+
+    gc_free(&gc);
+}
+
+/* An empty payload holds no TLV=
=2E */
+static void
+test_find_tlv_empty_payload(void **state)
+{
+    stru=
ct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(16, &g=
c);
+    struct buffer value;
+
+    assert_false(ctrl_msg_find_tlv(&buf, O=
OB_TLV_PROBE_PARAMETER, &value));
+
+    gc_free(&gc);
+}
+
+/* Reading a T=
LV header must fail when the buffer holds less data than a
+ * complete 4-b=
yte header (empty, or only the type field), rather than read
+ * past the a=
vailable data=2E */
+static void
+test_tlv_header_truncated(void **state)
+=
{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_bu=
f_gc(128, &gc);
+
+    struct ctrl_msg_tlv_header hdr;
+
+    /* empty buff=
er */
+    assert_false(ctrl_msg_tlv_read_header(&buf, &hdr));
+
+    /* on=
ly the type field present, no length */
+    assert_true(buf_write_u16(&buf=
, OOB_TLV_PROBE_PARAMETER));
+    assert_false(ctrl_msg_tlv_read_header(&bu=
f, &hdr));
+
+    gc_free(&gc);
+}
+
+/* The OOB tests run as a second grou=
p of pkt_testdriver; see test_pkt=2Ec=2E */
+int
+run_oob_tests(void)
+{
+ =
   const struct CMUnitTest tests[] =3D {
+        cmocka_unit_test(test_pro=
be_parameter_roundtrip),
+        cmocka_unit_test(test_probe_reply_roundtr=
ip),
+        cmocka_unit_test(test_probe_reply_wire_format),
+        cmoc=
ka_unit_test(test_probe_parameter_forward_compat),
+        cmocka_unit_tes=
t(test_probe_parameter_too_short),
+        cmocka_unit_test(test_find_tlv_=
value_truncated),
+        cmocka_unit_test(test_find_tlv_trailing_bytes),
=
+        cmocka_unit_test(test_find_tlv_skips_optional_after_wanted),
+    =
    cmocka_unit_test(test_find_tlv_empty_payload),
+        cmocka_unit_tes=
t(test_tlv_header_truncated),
+    };
+
+    return cmocka_run_group_tests_=
name("oob tests", tests, NULL, NULL);
+}
diff --git a/tests/unit_tests/open=
vpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index a732c2b=2E=
=2E390b3f6 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/u=
nit_tests/openvpn/test_pkt=2Ec
@@ -44,6 +44,8 @@
 #include "reliable=2Eh"
 =
#include "siphash=2Eh"
 
+int run_oob_tests(void); /* test_oob=2Ec */
+
 in=
t
 parse_line(const char *line, char **p, const int n, const char *file, co=
nst int line_num,
            msglvl_t msglevel, struct gc_arena *gc)
@@ -7=
48,5 +750,7 @@
         cmocka_unit_test(test_extract_control_message)
    =
 };
 
-    return cmocka_run_group_tests_name("pkt tests", tests, NULL, NUL=
L);
+    int failed =3D cmocka_run_group_tests_name("pkt tests", tests, NUL=
L, NULL);
+    failed +=3D run_oob_tests();
+    return failed ? 1 : 0;
 }
=

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c8d302ac57c56=
03d622a7be14be369437388268
Gerrit-Change-Number: 1741
Gerrit-PatchSet: 17
G=
errit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attent=
ion: stipa <lstipakov@gmail=2Ecom>

--oHoBjJkZabg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici, stipa=2E </p>
<p>=
stipa <strong>uploaded patch set #17</strong> to this change=2E</p><p><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Re=
view-1 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">oob: Add control message TLV encoding =
(P_CONTROL_OOB_V1)<br><br>Out-of-band control messages carry control data b=
ut belong to no<br>session, so a client can ask a server about itself befor=
e connecting=2E<br>Reserve opcode 12 for them and add the codec for the two=
 messages the<br>probe needs, SERVER_PROBE and PROBE_REPLY=2E<br><br>The sp=
ec uses the same TLV framing for all its control messages, not<br>just the =
out-of-band ones, so the message-type header, the TLV header<br>and the TLV=
 scan go into their own control_msg=2Ec/h; oob=2Ec keeps the OOB<br>message=
 and TLV types=2E<br><br>The scan is strict: a header or value that does no=
t fit in the remaining<br>payload, including trailing bytes too few for a h=
eader, or an unknown<br>TLV not marked optional rejects the whole message r=
ather than just the<br>TLV=2E<br><br>P_LAST_OPCODE becomes 12=2E tls_pre_de=
crypt() rejects the OOB opcodes<br>explicitly: they are not part of the rel=
iable control channel (no<br>control message id, no ACK array), so do_pre_d=
ecrypt_check() answers<br>them statelessly instead=2E<br><br>See &quot;Out =
of band and control data messages&quot; and &quot;[OPCODE ID 12]<br>CONTROL=
_OOB_V1&quot; in the wire protocol specification<br>(openvpn-rfc, openvpn-w=
ire-protocol=2Exml)=2E<br><br>Change-Id: I1c8d302ac57c5603d622a7be14be36943=
7388268<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>=
M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>A src/openvpn/control_=
msg=2Ec<br>A src/openvpn/control_msg=2Eh<br>A src/openvpn/oob=2Ec<br>A src/=
openvpn/oob=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M =
src/openvpn/ssl_pkt=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A te=
sts/unit_tests/openvpn/test_oob=2Ec<br>M tests/unit_tests/openvpn/test_pkt=
=2Ec<br>12 files changed, 791 insertions(+), 6 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/41/1741/17</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span=
><br><span>index 6eb5954=2E=2E72680b2 100644</span><br><span>--- a/CMakeLis=
ts=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -445,6 +=
445,8 @@</span><br><span>     src/openvpn/console=2Ec</span><br><span>     =
src/openvpn/console_builtin=2Ec</span><br><span>     src/openvpn/console=2E=
h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/co=
ntrol_msg=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sr=
c/openvpn/control_msg=2Eh</span><br><span>     src/openvpn/crypto=2Ec</span=
><br><span>     src/openvpn/crypto=2Eh</span><br><span>     src/openvpn/cry=
pto_backend=2Eh</span><br><span>@@ -523,6 +525,8 @@</span><br><span>     sr=
c/openvpn/multi_io=2Ec</span><br><span>     src/openvpn/occ=2Ec</span><br><=
span>     src/openvpn/occ=2Eh</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    src/openvpn/oob=2Ec</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    src/openvpn/oob=2Eh</span><br><span>     src/openvpn/open=
vpn=2Ec</span><br><span>     src/openvpn/openvpn=2Eh</span><br><span>     s=
rc/openvpn/openvpn_win32_resources=2Erc</span><br><span>@@ -883,6 +887,9 @@=
</span><br><span> </span><br><span>     target_sources(test_pkt PRIVATE</sp=
an><br><span>         tests/unit_tests/openvpn/mock_win32_execve=2Ec</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/o=
penvpn/test_oob=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        src/openvpn/control_msg=2Ec</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        src/openvpn/oob=2Ec</span><br><span>         src/op=
envpn/argv=2Ec</span><br><span>         src/openvpn/base64=2Ec</span><br><s=
pan>         src/openvpn/crypto_epoch=2Ec</span><br><span>diff --git a/src/=
openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index 7fd=
12b4=2E=2E5e6b4d9 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</s=
pan><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -53,6 +53,=
7 @@</span><br><span> 	common=2Eh \</span><br><span> 	comp=2Ec comp=2Eh com=
pstub=2Ec \</span><br><span> 	comp-lz4=2Ec comp-lz4=2Eh \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	control_msg=2Ec control_msg=2Eh \</s=
pan><br><span> 	crypto=2Ec crypto=2Eh crypto_backend=2Eh \</span><br><span>=
 	crypto_openssl=2Ec crypto_openssl=2Eh \</span><br><span> 	crypto_mbedtls_=
legacy=2Ec crypto_mbedtls_legacy=2Eh \</span><br><span>@@ -107,6 +108,7 @@<=
/span><br><span> 	pkcs11=2Ec pkcs11=2Eh pkcs11_backend=2Eh \</span><br><spa=
n> 	pkcs11_openssl=2Ec \</span><br><span> 	pkcs11_mbedtls=2Ec \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	oob=2Ec oob=2Eh \</span><br><s=
pan> 	openvpn=2Ec openvpn=2Eh \</span><br><span> 	options=2Ec options=2Eh \=
</span><br><span> 	options_show=2Ec options_show=2Eh \</span><br><span>diff=
 --git a/src/openvpn/control_msg=2Ec b/src/openvpn/control_msg=2Ec</span><b=
r><span>new file mode 100644</span><br><span>index 0000000=2E=2E35c2e77</sp=
an><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/control_msg=2E=
c</span><br><span>@@ -0,0 +1,105 @@</span><br><span style=3D"color: hsl(120=
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
);">+#include &quot;control_msg=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_rea=
d_header(struct buffer *buf, uint16_t expected_msg_type)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    int msg_type =3D buf_read_u16(buf);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return msg_type &gt;=3D 0 &amp;&=
amp; (uint16_t)msg_type =3D=3D expected_msg_type;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_write_hea=
der(struct buffer *buf, uint16_t type, bool optional, uint16_t value_len)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    uint16_t field =3D type &amp; CTRL_=
MSG_TLV_TYPE_MASK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (optional)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        field |=
=3D CTRL_MSG_TLV_OPTIONAL_FLAG;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return buf_write_u16(buf, field) &amp;&amp; buf_write_u16(buf, value_len)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ctrl_msg_tlv_read_header(struct buffer *buf, struct ctrl_msg_tlv_heade=
r *hdr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int field =3D buf_read_u16=
(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (field=
 &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int len =3D buf_read_u16(buf);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (len &lt; 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    hdr-&gt;type =3D (uint16_t)(field &amp; CTRL=
_MSG_TLV_TYPE_MASK);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    hdr-&gt;optional =3D (field &amp; CTRL_MSG_TLV_OPTIONAL_FLAG) !=3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt;value_le=
n =3D (uint16_t)len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ctrl_msg_find_tlv(struct buffer *payload, uint16_t wan=
ted_type, struct buffer *value)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    bool found =3D false;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    while (BLEN(payload) &gt; 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!ctrl_msg_tlv_read_header(payload, &amp;hdr))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            return false; /* few=
er than 4 bytes left: truncated header */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* Advance past the value; fails if the payload is shor=
ter than the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
  * header claims=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        uint8_t *v =3D buf_read_alloc(payload, hdr=2Evalue_len);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!v)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (hdr=2Etype =3D=3D wanted_type)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            if (!found)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                buf_set_read(valu=
e, v, hdr=2Evalue_len);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                found =3D true;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        else if (!hdr=2Eoptional)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            /* A TLV we do not understand that the sender did not mark =
optional</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
  * carries something it requires us to act on, so the message as a</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+             * whole is not=
 ours to interpret=2E This is why the scan continues</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             * past the wanted type: such=
 a TLV invalidates the message wherever</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+             * in the sequence it sits=2E */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            return false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return found;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/control=
_msg=2Eh b/src/openvpn/control_msg=2Eh</span><br><span>new file mode 100644=
</span><br><span>index 0000000=2E=2E0ead9a5</span><br><span>--- /dev/null</=
span><br><span>+++ b/src/openvpn/control_msg=2Eh</span><br><span>@@ -0,0 +1=
,109 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application=
 to securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *             over a single TCP/UDP port, with support for SSL=
/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
      session authentication and key exchange,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             packet encryption, packet authent=
ication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
        packet compression=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Cop=
yright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  This program is free software; you can redistri=
bute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  it under the terms of the GNU General Public License version 2</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Fr=
ee Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This pr=
ogram is distributed in the hope that it will be useful,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without =
even the implied warranty of</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Pu=
blic License for more details=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
You should have received a copy of the GNU General Public License along</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; =
if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @file</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Framing shared by the =
TLV-based control messages of the wire protocol=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Such a message payload starts with a 16-bit message type, =
followed by a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * seq=
uence of TLV entries=2E Each TLV starts with a 4-byte header: a 16-bit fiel=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * whose most sign=
ificant bit is the &quot;optional&quot; flag and whose remaining 15 bits</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * are the type, follo=
wed by a 16-bit length giving the size of the value that</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * follows the header=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * The message-type and TLV-type values themselves=
 are specific to the message</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * family carried (out-of-band messages define theirs in oob=2Eh),=
 so only the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * fram=
ing lives here=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#ifndef CONTROL_MSG_H</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define CONTROL_MSG_H</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* TLV header bit layout of the first 16-bit field */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CTRL_MSG_TLV_OPTI=
ONAL_FLAG 0x8000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine CTRL_MSG_TLV_TYPE_MASK     0x7fff</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* The header every TLV carries: the 15-bit type and optional flag packed i=
nto</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the first 16-=
bit field, then the length of the value that follows=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+struct ctrl_msg_tlv_header</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    uint16_t type;      /**&lt; the 15-bit TLV =
type */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool opt=
ional;      /**&lt; value of the optional flag */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    uint16_t value_len; /**&lt; length of the=
 value following the header */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Read and verify a message-type header =
from buf, advancing past it=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram buf                buffer positioned at the message payload</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param expected_msg_type  th=
e message type the payload must carry</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @return true if a message type was read and equals exp=
ected_msg_type,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
       false on a short buffer or a mismatching type=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+bool ctrl_msg_read_header(struct buffer *buf, uint16_t =
expected_msg_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Write a TLV header (type + optio=
nal flag + value length) to buf=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @return true on success, false if buf has insufficient space=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_write_header(struct buffer *=
buf, uint16_t type, bool optional,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                               uint16_t value_len);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Read a TLV header from buf, advancing past it=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param buf  buffer positioned at the TLV head=
er</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param hdr  fi=
lled with the type, optional flag and value length on success</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false=
 if there are not enough bytes for a header=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bool ctrl_msg_tlv_read_header(struct buffer *buf, struct ctrl_ms=
g_tlv_header *hdr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Scan payload for the TLV of type=
 wanted_type, skipping any other (e=2Eg=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * future) TLV type that is marked optional=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * This is for messages that carry exactl=
y one mandatory TLV, which matches the</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * currently supported OOB messages: any other TLV that =
is not marked optional</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * invalidates the message wherever it is present, so the whole sequence=
 is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * walked=2E A m=
essage with several mandatory TLVs would need a scan that knows</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * all of them=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * On success value covers exactly the found TLV&#=
39;s value bytes=2E The length from</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * each TLV header is validated against payload as the scan=
 goes, so the whole</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * value is guaranteed to be present; a header claiming more bytes than pay=
load</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * holds is rej=
ected rather than reported as found=2E payload is consumed as it is</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * read=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param payload      buffer positioned at a TLV hea=
der</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param wanted=
_type  the TLV type to look for</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param value        set to a buffer covering the found TLV&#=
39;s value; it points</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *                     into payload and owns no storage</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @return true if the TLV was found,=
 false if it is not present, a TLV header</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *         or value is malformed or truncated, or a T=
LV we do not understand is</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *         not marked optional=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+bool ctrl_msg_find_tlv(struct buffer *payload, uint16_t wanted_type, s=
truct buffer *value);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef =
CONTROL_MSG_H */</span><br><span>diff --git a/src/openvpn/oob=2Ec b/src/ope=
nvpn/oob=2Ec</span><br><span>new file mode 100644</span><br><span>index 000=
0000=2E=2Ec807171</span><br><span>--- /dev/null</span><br><span>+++ b/src/o=
penvpn/oob=2Ec</span><br><span>@@ -0,0 +1,83 @@</span><br><span style=3D"co=
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
120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+oob_probe_parameter_write(struct buffer *buf, const struct oob_p=
robe_parameter *p)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ctrl_msg=
_tlv_write_header(buf, OOB_TLV_PROBE_PARAMETER, false, OOB_PROBE_PARAMETER_=
LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp=
;&amp; buf_write_u64(buf, p-&gt;timestamp)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u32(buf, p-&gt;flags=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+oob_probe_parameter_read(struct buffer *buf, struct oob_probe_paramet=
er *p)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* One bounds check covers =
the whole value: every field read below then fits</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * by construction (OOB_PROBE_PARAMETER_L=
EN is the sum of their sizes), so</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * none of them needs its own error handling=2E Trailing =
bytes this version</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * does not understand are simply left unread=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(buf) &lt; OOB_PROBE_PARA=
METER_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    p-&gt;timestamp =3D buf_read_u6=
4(buf, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p-=
&gt;flags =3D buf_read_u32(buf, NULL);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+oob_probe_reply_write(struct buffer =
*buf, const struct oob_probe_reply *r)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return ctrl_msg_tlv_write_header(buf, OOB_TLV_PROBE_REPLY, false, OOB_=
PROBE_REPLY_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
        &amp;&amp; session_id_write(&amp;r-&gt;peer_session_id, buf)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_=
write_u16(buf, r-&gt;priority)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+           &amp;&amp; buf_write_u16(buf, r-&gt;weight)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_wri=
te_u16(buf, r-&gt;max_latency_diff)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+           &amp;&amp; buf_write_u16(buf, r-&gt;connect_life=
time)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &am=
p;&amp; buf_write_u32(buf, r-&gt;flags);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_reply_read(struct buf=
fer *buf, struct oob_probe_reply *r)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* One bounds check for the whole value, as in oob_probe_parameter_read(=
)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_=
len(buf) &lt; OOB_PROBE_REPLY_LEN)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    session=
_id_read(&amp;r-&gt;peer_session_id, buf);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    r-&gt;priority =3D (uint16_t)buf_read_u16(buf);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;weight =3D=
 (uint16_t)buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    r-&gt;max_latency_diff =3D (uint16_t)buf_read_u16(buf);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;connect_lifetim=
e =3D (uint16_t)buf_read_u16(buf);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    r-&gt;flags =3D buf_read_u32(buf, NULL);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/ope=
nvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>new file mode 100644</sp=
an><br><span>index 0000000=2E=2Ec5396b3</span><br><span>--- /dev/null</span=
><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -0,0 +1,110 @@</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely=
 tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             over a single TCP/UDP port, with support for SSL/TLS-based</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sessio=
n authentication and key exchange,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet encryption, packet authentication, and=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pack=
et compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2=
002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  This program is free software; you can redistribute it and/=
or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it und=
er the terms of the GNU General Public License version 2</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software =
Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is dis=
tributed in the hope that it will be useful,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the imp=
lied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License=
 for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should h=
ave received a copy of the GNU General Public License along</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see =
&lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Encoding/decoding of out-of-band (=
P_CONTROL_OOB_V1) control messages=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * An OOB message payload starts with a 16-bit message type (the 0x1xx spa=
ce:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * SERVER_PROBE,=
 PROBE_REPLY, =2E=2E=2E) followed by a sequence of TLV entries in the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * 0x2xx type space=2E Th=
e framing itself is shared with the other TLV-based</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * control messages of the wire protocol =
and lives in control_msg=2Eh; this file</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * defines the OOB message and TLV types, their values,=
 and the OOB-specific</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * decisions taken on them=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef OOB_H</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_H</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span style=
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
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* TLV types=
 (see the OOB control message section of the wire protocol spec) */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_TLV_PROBE_PARAM=
ETER 0x200</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define O=
OB_TLV_PROBE_REPLY     0x201</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Minimum=
 on-wire value length (excluding the 4-byte TLV header) of each TLV:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * the sizes of its fixed =
fields in wire order (see the structs below)=2E The</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * value may be longer for forward compat=
ibility; trailing bytes that are not</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * understood are ignored on read=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define OOB_PROBE_PARAMETER_LEN \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ((uint16_t)(sizeof(u=
int64_t) /* timestamp */ + sizeof(uint32_t) /* flags */))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define OOB_PROBE_REPLY_LEN          =
                         \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ((uint16_t)(SID_SIZE               /* peer_session_id */  \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                + 4 * si=
zeof(uint16_t) /* priority, weight,   \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                        * max_latency_d=
iff,   \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                             * connect_lifetime */ \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                + sizeof(uint32_t)))   /*=
 flags */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* probe parameter TLV (sent =
by the client in a SERVER_PROBE) */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+struct oob_probe_parameter</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    uint64_t timestamp; /**&lt; client clock as a UNIX timestamp */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t flags;   =
  /**&lt; client capability flags, currently must be 0 */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* probe reply TLV (sent by the server in a PROBE_REPLY) */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+struct oob_probe_reply</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct session_id peer_session_id; /**&lt; e=
choes the session id of the request */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    uint16_t priority;                 /**&lt; DNS-SRV s=
tyle priority (lower is preferred) */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    uint16_t weight;                   /**&lt; DNS-SRV st=
yle weight */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ui=
nt16_t max_latency_diff;         /**&lt; advertised candidate-band margin i=
n ms;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                          *   used unless the client configured its own */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t connect=
_lifetime;         /**&lt; seconds the reply stays valid as the handshake r=
eset */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t=
 flags;                    /**&lt; server behaviour flags */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a =
complete probe parameter TLV (header + value) to buf=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+bool oob_probe_parameter_write(struct buffer *buf, cons=
t struct oob_probe_parameter *p);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read a probe param=
eter TLV value from buf=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * buf mus=
t cover exactly the TLV&#39;s value, as returned by ctrl_msg_find_tlv()=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Trailing bytes be=
yond the fields understood here are ignored, so a longer</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * value from a future version still p=
arses=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, =
false if buf is shorter than the mandatory fields=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+bool oob_probe_parameter_read(struct buffer *buf, struct =
oob_probe_parameter *p);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Write a complete probe repl=
y TLV (header + value) to buf=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l oob_probe_reply_write(struct buffer *buf, const struct oob_probe_reply *r=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Read a probe reply TLV value from buf=2E See oob_=
probe_parameter_read() for the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * calling convention=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
bool oob_probe_reply_read(struct buffer *buf, struct oob_probe_reply *r);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif /* OOB_H */</span><br><span>diff =
--git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 761=
50d4=2E=2Ea6a67a2 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><b=
r><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -3705,8 +3705,10 @@</s=
pan><br><span>     bool new_link =3D false;</span><br><span>     struct ses=
sion_id sid; /* remote session ID */</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    /* verify legal opcode */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (op &lt; P_FIRST_OPCODE || =
op &gt; P_LAST_OPCODE)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* verify legal opcode=2E An out-of-band packet has no control messa=
ge id and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * no =
ACK array, which is what we parse next; do_pre_decrypt_check() answers</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * those=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (op &lt; P_FIRST_O=
PCODE || op &gt; P_LAST_OPCODE || opcode_is_oob(op))</span><br><span>     {=
</span><br><span>         if (op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V1 || o=
p =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)</span><br><span>         {</span><=
br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</sp=
an><br><span>index 90b2aec=2E=2Ebfcbf31 100644</span><br><span>--- a/src/op=
envpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><=
span>@@ -168,6 +168,9 @@</span><br><span> {</span><br><span>     ASSERT(ks-=
&gt;key_id &gt;=3D 0 &amp;&amp; ks-&gt;key_id &lt;=3D P_KEY_ID_MASK);</span=
><br><span>     ASSERT(opcode &gt;=3D 0 &amp;&amp; opcode &lt;=3D P_LAST_OP=
CODE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* OOB pa=
ckets carry no message id or ACK array; tls_wrap_oob_standalone()</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * builds them */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(!opcode_is_oob(o=
pcode));</span><br><span>     uint8_t header =3D (uint8_t)(ks-&gt;key_id | =
(opcode &lt;&lt; P_OPCODE_SHIFT));</span><br><span> </span><br><span>     /=
* Workaround for Softether servers=2E Softether has a bug that it only</spa=
n><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh<=
/span><br><span>index 03e8930=2E=2Ef631308 100644</span><br><span>--- a/src=
/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><b=
r><span>@@ -58,11 +58,25 @@</span><br><span>  * like P_CONTROL_HARD_RESET_C=
LIENT_V3 */</span><br><span> #define P_CONTROL_WKC_V1 11</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* define the range of=
 legal opcodes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Ou=
t-of-band control message, e=2Eg=2E a server probe=2E Not part of the relia=
ble</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * control chann=
el: no control message id and no ACK array, just TLVs after the</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * session id=2E Answered state=
lessly in do_pre_decrypt_check(), never handled by</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * tls_pre_decrypt()=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define P_CONTROL_OOB_V1 12</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* define the range of defined opcodes, in- and =
out-of-band</span><br><span>  * Since we do no longer support key-method 1 =
we consider</span><br><span>  * the v1 op codes invalid */</span><br><span>=
 #define P_FIRST_OPCODE 3</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define P_LAST_OPCODE  11</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define P_LAST_OPCODE  12</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
OOB opcodes are not part of the reliable control channel: no control messag=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * id and no ACK a=
rray=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static in=
line bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+opcode_is_=
oob(int op)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return op =3D=3D P_CON=
TROL_OOB_V1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span> </span><br><span> /*</span><br><span>  * Define number of buffe=
rs for send and receive in the reliability layer=2E</span><br><span>@@ -256=
,6 +270,9 @@</span><br><span>         case P_CONTROL_WKC_V1:</span><br><spa=
n>             return &quot;P_CONTROL_WKC_V1&quot;;</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        case P_CONTROL_OO=
B_V1:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            re=
turn &quot;P_CONTROL_OOB_V1&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span>         case P_ACK_V1:</span><br><span>   =
          return &quot;P_ACK_V1&quot;;</span><br><span> </span><br><span>di=
ff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvp=
n/Makefile=2Eam</span><br><span>index 5954902=2E=2Ee6c8fb5 100644</span><br=
><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/t=
ests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -157,10 +157,13 @@=
</span><br><span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(t=
op_srcdir)/src/openvpn \</span><br><span> 	@TEST_CFLAGS@</span><br><span> p=
kt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-pkt_testdriver_SOURCES =3D test_pkt=2Ec mock_msg=2Ec moc=
k_msg=2Eh mock_win32_execve=2Ec test_common=2Eh \</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+pkt_testdriver_SOURCES =3D test_pkt=2Ec test_=
oob=2Ec mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	test_common=2Eh \</span><br><span> 	=
$(top_srcdir)/src/openvpn/argv=2Ec \</span><br><span> 	$(top_srcdir)/src/op=
envpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/=
openvpn/control_msg=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	$(top_srcdir)/src/openvpn/oob=2Ec \</span><br><span> 	$(top_srcdir)/=
src/openvpn/crypto=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=
_epoch=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec=
 \</span><br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tes=
ts/unit_tests/openvpn/test_oob=2Ec</span><br><span>new file mode 100644</sp=
an><br><span>index 0000000=2E=2Ef81158e</span><br><span>--- /dev/null</span=
><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>@@ -=
0,0 +1,340 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</sp=
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
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;std=
arg=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &lt;stddef=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &lt;setjmp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;control_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &quot;oob=2Eh&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;test_common=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* Write a probe parameter TLV and read it back; field=
s must survive the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* round trip and the whole buffer must be consumed=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+test_probe_parameter_roundtrip(void **state)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st struct oob_probe_parameter in =3D {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        =2Etimestamp =3D 0x0123456789abcdefULL,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D 0,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_parameter_w=
rite(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* header (4) + value (12) */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 4 + OOB_PROBE_PARA=
METER_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the header codec, re=
ad from a copy so the scan below still sees it */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct buffer peek =3D buf;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_header hd=
r;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(c=
trl_msg_tlv_read_header(&amp;peek, &amp;hdr));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, OOB_TLV_PROBE_P=
ARAMETER);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_false(hdr=2Eoptional);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(hdr=2Evalue_len, OOB_PROBE_PARAMETER_LEN);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_find_tlv(&amp;b=
uf, OOB_TLV_PROBE_PARAMETER, &amp;value));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), OOB_PROBE_PAR=
AMETER_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_param=
eter out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(oob_probe_parameter_read(&amp;value, &amp;out));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(in=2Etimestamp=
 =3D=3D out=2Etimestamp);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(in=2Eflags, out=2Eflags);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* the scan consumed header and value=
 alike */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Write a probe reply TLV and read it ba=
ck=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_ro=
undtrip(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_ar=
ena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct oob_probe_reply in =3D {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        =2Epriority =3D 10,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        =2Eweight =3D 100,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Econnect_lifetim=
e =3D 30,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
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
=3D"color: hsl(120, 100%, 40%);">+/* The OOB tests run as a second group of=
 pkt_testdriver; see test_pkt=2Ec=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+run_oob_tests(void)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const stru=
ct CMUnitTest tests[] =3D {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cmocka_unit_test(test_probe_parameter_roundtrip),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test=
_probe_reply_roundtrip),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        cmocka_unit_test(test_probe_reply_wire_format),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_prob=
e_parameter_forward_compat),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_probe_parameter_too_short),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(tes=
t_find_tlv_value_truncated),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_find_tlv_trailing_bytes),</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_=
find_tlv_skips_optional_after_wanted),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        cmocka_unit_test(test_find_tlv_empty_payload),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_t=
est(test_tlv_header_truncated),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return cmocka_ru=
n_group_tests_name(&quot;oob tests&quot;, tests, NULL, NULL);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/te=
sts/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec=
</span><br><span>index a732c2b=2E=2E390b3f6 100644</span><br><span>--- a/te=
sts/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/tests/unit_tests/=
openvpn/test_pkt=2Ec</span><br><span>@@ -44,6 +44,8 @@</span><br><span> #in=
clude &quot;reliable=2Eh&quot;</span><br><span> #include &quot;siphash=2Eh&=
quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+int run_oob_tests(void); /* test_oob=2Ec */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> parse_li=
ne(const char *line, char **p, const int n, const char *file, const int lin=
e_num,</span><br><span>            msglvl_t msglevel, struct gc_arena *gc)<=
/span><br><span>@@ -748,5 +750,7 @@</span><br><span>         cmocka_unit_te=
st(test_extract_control_message)</span><br><span>     };</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return cmocka_run_=
group_tests_name(&quot;pkt tests&quot;, tests, NULL, NULL);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    int failed =3D cmocka_run_group=
_tests_name(&quot;pkt tests&quot;, tests, NULL, NULL);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    failed +=3D run_oob_tests();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return failed ? 1 : 0;<=
/span><br><span> }</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">change 17=
41</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I1c8d302ac57c5603d622a7be14be369437388268 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1741 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 17 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt=
;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mande=
lbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></htm=
l>
--oHoBjJkZabg=--


--===============5942944057437733405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5942944057437733405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5942944057437733405==--

