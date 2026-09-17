Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1495AC982C1
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SfYLshv3pmrn4iufdYbj6S0ifY4UnP4qKocQynBG5yY=; b=kgRHSvZbUFnjLovmKfBkQIgkZ9
	0L7yJmo7eaI3PBGqTVQSLw07BjPjKblwhNqfJCxYhekRom4q34jwGiOXSqJVlUnwaobiX2Wzh2YgR
	sWa6JGTC/7vDnbk/bnZwUu7yDmYVQJVwW3QWTx6iE1exi4eZTPm2F00vGvPQtrF6u9WU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x767l-0002Um-Sf;
	Thu, 17 Sep 2026 07:01:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x767i-0002UP-TX
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:01:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KVztPyuzOlzjHaIULWO6eHWkUEpICo4zYLbhY6DKxcA=; b=lgEnPTN0NGbECzjHUjQo7cm1fA
 pJX1Dvy5tD8y7ip916bgfotJDFYDOhPQ14QJPXpAl9nX9LfhodxDvQw2tluM5AWdxI7dbKdP+afy9
 oYTWmQ9A4EzZ+hu+HVAHQ/W1ZoY9L7fG+AyKBxTBohFc3BIjGZe+/DrLBwxjFvXEeJXA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KVztPyuzOlzjHaIULWO6eHWkUEpICo4zYLbhY6DKxcA=; b=Q
 sEdx+yMDXRwmNMcvqdB3lUc/74QZI2+ENYw0BGq9AVkfrJw2g93ICp47gbanKlWp4Twp4Z+kU4V7O
 zEWbhwYshhRc9DD6iEpRrJz8ZW10KXePcS6MwIhSDX5VqfO3XhQHK++1nVM6aWOUyJceYzAm2MQEx
 vsWsRe8mpoPJl76o=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x767b-0006nE-TW for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:01:35 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso4176525e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 00:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789628481; x=1790233281; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KVztPyuzOlzjHaIULWO6eHWkUEpICo4zYLbhY6DKxcA=;
 b=FNr61A40PqSrBhp9tCULOYZWvPKUrSYbiHCnqhcbWr0Ye1MNycWyYwL7SzghWacSQA
 aRj3EQp4Q5Vrjq3JZDTNvI22tKlCcCnqEiag98PorPClNiNIJROj0+6LnldS2zqm1Qur
 9GSv4euUD9Hd8HW6zxBc1FqnS2yO7Gi/TPGJ9y2XdGPvQHc3Ld4er5vXYtD4n81w6Sx5
 9bQYksazLiIcI9g/bEZ+RA/Kpwng6hAF2pnHzjd9D1YT5jw8dLYVNSCLM5QLDXTo9XiY
 NTZUWod7HKqFLE085kLeby2rFMoDchr795hRlpoa7pJzLkngwQF3EE6+nhrpYxd8RcpE
 JB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789628481; x=1790233281;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KVztPyuzOlzjHaIULWO6eHWkUEpICo4zYLbhY6DKxcA=;
 b=OBHfWs7a291kn0R4lZBVd0V9y8OQ+rP5XSjKLKGOmZ2fhWwuBgxqLR7WEYEokmM7iM
 OMUmtNsWoxjGMApzXqx99CzD/NtSmTlDvxVQtOe/EBDSxrlk9IkpE6viKCDl3xIfqkR3
 KZUn9vTtcZfNWociX85QlqmI0/UFABpwejRFxVOmBnMKILGtPOF1/ooYYrmlLji4mR2T
 a+SlQOyIctZ6pP4OwZHVwC59gLNR8b40Hawi6ehLa5BdvPjugcpfS9CUludBDiXypWPW
 NG6GqVZQlxrcD0Ia9a2mDh8f92t/Ztnoag9Wya7L/e8SbcOwOgLYQkO5mNldrjP19a88
 1f9w==
X-Gm-Message-State: AFuF++lAXHTzaHSkWGasLnCIpVoukVH0JXWhvGRhTUtWXZK3XTmhfQv6
 sBRTmpXs++ITQzjDpyLeA4phdG5+90k/rESaqKv/wSJQDR1Wviu2KvD2HL0QRSwdasAjSfbzajY
 IT1qF0vDmsQmCRF4waXNyt8T8Nd3SapWfSeMM64CRcI7tQ4yPU0xi0r8wAj5pYXvWb+ldT1PIeS
 EuIn+nTA==
X-Gm-Gg: AYBFou1Y+R18Qj6g3akkIRtJy27Lp054LULLQ9y2HU1xK8700TH31rF6v3I2227/0JI
 DspV4gffK9ogYs+eGIUWLNuOuAHDBpEtQnx5Qj/OTRVayYGhSDtJ4z/IrD4mhbmjuDg2WmoQXUv
 ZrSpPdrwbSTolf6LWPMyA+5sPGtQwVbZOhGuHFPmQLK8XYG5TUulKxIUUgqaTXqt5hNAhuCAw4h
 zww0/ANNpJLfPBpmcdTHPvt9m48QtAIf2WSSYJNjdeiw4y4ClNbNtVsqDJk6VXUzemuYBgTsehc
 vrijVPsQNAuCEaPPS396elhNTOgUvqpEmUMLDCl/y81ohSN6KDvXeJ2tlecvgf7Pyx5Q+mcAvit
 dAYaMYxDoNs104uBAeivVKuOU7jcthDIguhYC6JnHqunn2gXH+6cl3P1jUYcislzLhjQqMaK/Xs
 HN4LeeP+Df5qib79bygKYH4ABeJm7U9ziM6p1C7U3iPXN6jA9INPxo6eTCNLWZ6RWo/EMbj+LHf
 MHIkoRoryo8uuLyJMuc+/xN890LDPI7dJDjct7u+hYFMvuZ3JMe/02sAke6BxhpuGzcRRDB9zn3
 TVfADz9lMlu0BKxcMXJ9y8LFfUZSNHWoOySl2uF+un5mQkkcqGr+a7uVaQtfAQ==
X-Received: by 2002:a05:600c:46d1:b0:49c:c0d4:53d9 with SMTP id
 5b1f17b1804b1-49eb72fbf26mr61801125e9.14.1789628480497; 
 Thu, 17 Sep 2026 00:01:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd23a815sm54930475e9.14.2026.09.17.00.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:01:19 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 07:01:11 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>,
 ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 5b1e911f450ab09703cf02f50846d58bf66fbaeb
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7ec20df8dd5454d678f65128965da9520460d4c9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x767b-0006nE-TW
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
Content-Type: multipart/mixed; boundary="===============1095909249698535584=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1095909249698535584==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ARgnDrcmB3s="; charset=UTF-8

--ARgnDrcmB3s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ralf_lici, stipa=2E

He=
llo flichtenheld, plaisthos, ralf_lici, 

I'd like you to reexamine a chang=
e=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=
=3Demail

to look at the new patch set (#16)=2E


Change subject: oob: Add =
control message TLV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add control message TLV encoding (P=
_CONTROL_OOB_V1)

Out-of-band control messages carry control data but belon=
g to no
session, so a client can ask a server about itself before connectin=
g=2E
Reserve opcode 12 for them and add the codec for the two messages the
=
probe needs, SERVER_PROBE and PROBE_REPLY=2E

The spec uses the same TLV fr=
aming for all its control messages, not
just the out-of-band ones, so the m=
essage-type header, the TLV header
and the TLV scan go into their own contr=
ol_msg=2Ec/h; oob=2Ec keeps the OOB
message and TLV types=2E

The scan is s=
trict: a header or value that does not fit in the remaining
payload, includ=
ing trailing bytes too few for a header, or an unknown
TLV not marked optio=
nal rejects the whole message rather than just the
TLV=2E

P_LAST_OPCODE be=
comes 12, and opcode_valid_in_session() replaces the
plain range check beca=
use OOB opcodes are answered statelessly and are
never legal on an establis=
hed session=2E

See the OOB control message section of the wire protocol sp=
ecification
(openvpn-rfc PR #30)=2E

Change-Id: I1c8d302ac57c5603d622a7be14=
be369437388268
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M CMakeL=
ists=2Etxt
M src/openvpn/Makefile=2Eam
A src/openvpn/control_msg=2Ec
A src/=
openvpn/control_msg=2Eh
A src/openvpn/oob=2Ec
A src/openvpn/oob=2Eh
M src/o=
penvpn/ssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M tests/=
unit_tests/openvpn/Makefile=2Eam
A tests/unit_tests/openvpn/test_oob=2Ec
11=
 files changed, 796 insertions(+), 4 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1741/16

diff --git a/CMakeL=
ists=2Etxt b/CMakeLists=2Etxt
index 6eb5954=2E=2Efbc69f0 100644
--- a/CMake=
Lists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -445,6 +445,8 @@
     src/openvpn/con=
sole=2Ec
     src/openvpn/console_builtin=2Ec
     src/openvpn/console=2Eh
=
+    src/openvpn/control_msg=2Ec
+    src/openvpn/control_msg=2Eh
     src/=
openvpn/crypto=2Ec
     src/openvpn/crypto=2Eh
     src/openvpn/crypto_back=
end=2Eh
@@ -523,6 +525,8 @@
     src/openvpn/multi_io=2Ec
     src/openvpn/=
occ=2Ec
     src/openvpn/occ=2Eh
+    src/openvpn/oob=2Ec
+    src/openvpn/=
oob=2Eh
     src/openvpn/openvpn=2Ec
     src/openvpn/openvpn=2Eh
     src/=
openvpn/openvpn_win32_resources=2Erc
@@ -677,6 +681,7 @@
         "test_mbu=
f"
         "test_misc"
         "test_ncp"
+        "test_oob"
         "t=
est_options_parse"
         "test_packet_id"
         "test_pkt"
@@ -881,6 =
+886,13 @@
         src/openvpn/session_id=2Ec
         )
 
+    target_sou=
rces(test_oob PRIVATE
+        tests/unit_tests/openvpn/mock_get_random=2Ec=

+        src/openvpn/control_msg=2Ec
+        src/openvpn/oob=2Ec
+       =
 src/openvpn/session_id=2Ec
+        )
+
     target_sources(test_pkt PRIVA=
TE
         tests/unit_tests/openvpn/mock_win32_execve=2Ec
         src/ope=
nvpn/argv=2Ec
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=
=2Eam
index 7fd12b4=2E=2E5e6b4d9 100644
--- a/src/openvpn/Makefile=2Eam
+++=
 b/src/openvpn/Makefile=2Eam
@@ -53,6 +53,7 @@
 	common=2Eh \
 	comp=2Ec co=
mp=2Eh compstub=2Ec \
 	comp-lz4=2Ec comp-lz4=2Eh \
+	control_msg=2Ec contr=
ol_msg=2Eh \
 	crypto=2Ec crypto=2Eh crypto_backend=2Eh \
 	crypto_openssl=
=2Ec crypto_openssl=2Eh \
 	crypto_mbedtls_legacy=2Ec crypto_mbedtls_legacy=
=2Eh \
@@ -107,6 +108,7 @@
 	pkcs11=2Ec pkcs11=2Eh pkcs11_backend=2Eh \
 	p=
kcs11_openssl=2Ec \
 	pkcs11_mbedtls=2Ec \
+	oob=2Ec oob=2Eh \
 	openvpn=2E=
c openvpn=2Eh \
 	options=2Ec options=2Eh \
 	options_show=2Ec options_show=
=2Eh \
diff --git a/src/openvpn/control_msg=2Ec b/src/openvpn/control_msg=
=2Ec
new file mode 100644
index 0000000=2E=2E81f2aef
--- /dev/null
+++ b/sr=
c/openvpn/control_msg=2Ec
@@ -0,0 +1,106 @@
+/*
+ *  OpenVPN -- An applicat=
ion to securely tunnel IP networks
+ *             over a single TCP/UDP po=
rt, with support for SSL/TLS-based
+ *             session authentication a=
nd key exchange,
+ *             packet encryption, packet authentication, =
and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 =
OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; y=
ou can redistribute it and/or modify
+ *  it under the terms of the GNU Gen=
eral Public License version 2
+ *  as published by the Free Software Founda=
tion=2E
+ *
+ *  This program is distributed in the hope that it will be us=
eful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+=
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GN=
U General Public License for more details=2E
+ *
+ *  You should have recei=
ved a copy of the GNU General Public License along
+ *  with this program; =
if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONF=
IG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "=
control_msg=2Eh"
+
+bool
+ctrl_msg_read_header(struct buffer *buf, uint16_t=
 expected_msg_type)
+{
+    int msg_type =3D buf_read_u16(buf);
+    return=
 msg_type >=3D 0 && (uint16_t)msg_type =3D=3D expected_msg_type;
+}
+
+bool=

+ctrl_msg_tlv_write_header(struct buffer *buf, uint16_t type, bool optiona=
l, uint16_t value_len)
+{
+    uint16_t field =3D type & CTRL_MSG_TLV_TYPE_=
MASK;
+    if (optional)
+    {
+        field |=3D CTRL_MSG_TLV_OPTIONAL_F=
LAG;
+    }
+    return buf_write_u16(buf, field) && buf_write_u16(buf, val=
ue_len);
+}
+
+bool
+ctrl_msg_tlv_read_header(struct buffer *buf, struct ct=
rl_msg_tlv_header *hdr)
+{
+    int field =3D buf_read_u16(buf);
+    if (f=
ield < 0)
+    {
+        return false;
+    }
+    int len =3D buf_read_u1=
6(buf);
+    if (len < 0)
+    {
+        return false;
+    }
+    hdr->ty=
pe =3D (uint16_t)(field & CTRL_MSG_TLV_TYPE_MASK);
+    hdr->optional =3D (=
field & CTRL_MSG_TLV_OPTIONAL_FLAG) !=3D 0;
+    hdr->value_len =3D (uint16=
_t)len;
+    return true;
+}
+
+bool
+ctrl_msg_find_tlv(struct buffer *payl=
oad, uint16_t wanted_type, struct buffer *value)
+{
+    struct ctrl_msg_tl=
v_header hdr;
+    bool found =3D false;
+    while (BLEN(payload) > 0)
+  =
  {
+        if (!ctrl_msg_tlv_read_header(payload, &hdr))
+        {
+    =
        return false; /* fewer than 4 bytes left: truncated header */
+    =
    }
+        /* Take the value out of payload=2E This validates that the =
header's
+         * length is really there and advances past it in one ste=
p, so the TLV
+         * we are looking for and the ones we skip are bound=
s-checked alike=2E */
+        uint8_t *v =3D buf_read_alloc(payload, hdr=
=2Evalue_len);
+        if (!v)
+        {
+            return false;
+    =
    }
+        if (hdr=2Etype =3D=3D wanted_type)
+        {
+            i=
f (!found)
+            {
+                buf_set_read(value, v, hdr=2Eval=
ue_len);
+                found =3D true;
+            }
+        }
+      =
  else if (!hdr=2Eoptional)
+        {
+            /* A TLV we do not unde=
rstand that the sender did not mark optional
+             * carries someth=
ing it requires us to act on, so the message as a
+             * whole is =
not ours to interpret=2E This is why the scan continues
+             * pas=
t the wanted type: such a TLV invalidates the message wherever
+           =
  * in the sequence it sits=2E */
+            return false;
+        }
+  =
  }
+    return found;
+}
diff --git a/src/openvpn/control_msg=2Eh b/src/op=
envpn/control_msg=2Eh
new file mode 100644
index 0000000=2E=2E827178b
--- /=
dev/null
+++ b/src/openvpn/control_msg=2Eh
@@ -0,0 +1,107 @@
+/*
+ *  OpenV=
PN -- An application to securely tunnel IP networks
+ *             over a =
single TCP/UDP port, with support for SSL/TLS-based
+ *             session=
 authentication and key exchange,
+ *             packet encryption, packet=
 authentication, and
+ *             packet compression=2E
+ *
+ *  Copyrig=
ht (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is=
 free software; you can redistribute it and/or modify
+ *  it under the ter=
ms of the GNU General Public License version 2
+ *  as published by the Fre=
e Software Foundation=2E
+ *
+ *  This program is distributed in the hope t=
hat it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the impl=
ied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E=
  See the
+ *  GNU General Public License for more details=2E
+ *
+ *  You =
should have received a copy of the GNU General Public License along
+ *  wi=
th this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
=
+/**
+ * @file
+ * Framing shared by the TLV-based control messages of the =
wire protocol=2E
+ *
+ * Such a message payload starts with a 16-bit messag=
e type, followed by a
+ * sequence of TLV entries=2E Each TLV starts with a=
 4-byte header: a 16-bit field
+ * whose most significant bit is the "optio=
nal" flag and whose remaining 15 bits
+ * are the type, followed by a 16-bi=
t length giving the size of the value that
+ * follows the header=2E
+ *
+ =
* The message-type and TLV-type values themselves are specific to the messa=
ge
+ * family carried (out-of-band messages define theirs in oob=2Eh), so o=
nly the
+ * framing lives here=2E
+ */
+
+#ifndef CONTROL_MSG_H
+#define CO=
NTROL_MSG_H
+
+#include "buffer=2Eh"
+
+/* TLV header bit layout of the fir=
st 16-bit field */
+#define CTRL_MSG_TLV_OPTIONAL_FLAG 0x8000
+#define CTRL=
_MSG_TLV_TYPE_MASK     0x7fff
+
+/* The header every TLV carries: the 15-bi=
t type and optional flag packed into
+ * the first 16-bit field, then the l=
ength of the value that follows=2E */
+struct ctrl_msg_tlv_header
+{
+    u=
int16_t type;      /**< the 15-bit TLV type */
+    bool optional;      /**=
< value of the optional flag */
+    uint16_t value_len; /**< length of the=
 value following the header */
+};
+
+/**
+ * Read and verify a message-typ=
e header from buf, advancing past it=2E
+ *
+ * @param buf                b=
uffer positioned at the message payload
+ * @param expected_msg_type  the m=
essage type the payload must carry
+ * @return true if a message type was r=
ead and equals expected_msg_type,
+ *         false on a short buffer or a =
mismatching type=2E
+ */
+bool ctrl_msg_read_header(struct buffer *buf, uin=
t16_t expected_msg_type);
+
+/**
+ * Write a TLV header (type + optional fl=
ag + value length) to buf=2E
+ *
+ * @return true on success, false if buf =
has insufficient space=2E
+ */
+bool ctrl_msg_tlv_write_header(struct buffe=
r *buf, uint16_t type, bool optional,
+                               uint1=
6_t value_len);
+
+/**
+ * Read a TLV header from buf, advancing past it=2E=

+ *
+ * @param buf  buffer positioned at the TLV header
+ * @param hdr  fi=
lled with the type, optional flag and value length on success
+ * @return t=
rue on success, false if there are not enough bytes for a header=2E
+ */
+b=
ool ctrl_msg_tlv_read_header(struct buffer *buf, struct ctrl_msg_tlv_header=
 *hdr);
+
+/**
+ * Scan payload for the TLV of type wanted_type, skipping a=
ny other (e=2Eg=2E
+ * future) TLV type that is marked optional=2E
+ *
+ * =
This is for messages that carry exactly one mandatory TLV, which is every
+=
 * OOB message so far: any other TLV that is not marked optional invalidate=
s
+ * the message wherever it sits, so the whole sequence is walked=2E A me=
ssage
+ * with several mandatory TLVs would need a scan that knows all of t=
hem=2E
+ *
+ * On success value covers exactly the found TLV's value bytes=
=2E The length from
+ * each TLV header is validated against payload as the=
 scan goes, so the whole
+ * value is guaranteed to be present; a header cl=
aiming more bytes than payload
+ * holds is rejected rather than reported a=
s found=2E payload is consumed as it is
+ * read=2E
+ *
+ * @param payload =
     buffer positioned at a TLV header
+ * @param wanted_type  the TLV type=
 to look for
+ * @param value        set to a buffer covering the found TLV=
's value
+ * @return true if the TLV was found, false if it is not present,=
 a TLV header
+ *         or value is malformed or truncated, or a TLV we d=
o not understand is
+ *         not marked optional=2E
+ */
+bool ctrl_msg_=
find_tlv(struct buffer *payload, uint16_t wanted_type, struct buffer *value=
);
+
+#endif /* ifndef CONTROL_MSG_H */
diff --git a/src/openvpn/oob=2Ec b/=
src/openvpn/oob=2Ec
new file mode 100644
index 0000000=2E=2Ec807171
--- /de=
v/null
+++ b/src/openvpn/oob=2Ec
@@ -0,0 +1,83 @@
+/*
+ *  OpenVPN -- An ap=
plication to securely tunnel IP networks
+ *             over a single TCP/=
UDP port, with support for SSL/TLS-based
+ *             session authentica=
tion and key exchange,
+ *             packet encryption, packet authentica=
tion, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002=
-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free softw=
are; you can redistribute it and/or modify
+ *  it under the terms of the G=
NU General Public License version 2
+ *  as published by the Free Software =
Foundation=2E
+ *
+ *  This program is distributed in the hope that it will=
 be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warrant=
y of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+=
 *  GNU General Public License for more details=2E
+ *
+ *  You should have=
 received a copy of the GNU General Public License along
+ *  with this pro=
gram; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAV=
E_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#inc=
lude "oob=2Eh"
+#include "control_msg=2Eh"
+
+bool
+oob_probe_parameter_wri=
te(struct buffer *buf, const struct oob_probe_parameter *p)
+{
+    return =
ctrl_msg_tlv_write_header(buf, OOB_TLV_PROBE_PARAMETER, false, OOB_PROBE_PA=
RAMETER_LEN)
+           && buf_write_u64(buf, p->timestamp)
+           &&=
 buf_write_u32(buf, p->flags);
+}
+
+bool
+oob_probe_parameter_read(struct =
buffer *buf, struct oob_probe_parameter *p)
+{
+    /* One bounds check cov=
ers the whole value: every field read below then fits
+     * by constructi=
on (OOB_PROBE_PARAMETER_LEN is the sum of their sizes), so
+     * none of =
them needs its own error handling=2E Trailing bytes this version
+     * do=
es not understand are simply left unread=2E */
+    if (buf_len(buf) < OOB_=
PROBE_PARAMETER_LEN)
+    {
+        return false;
+    }
+    p->timestamp=
 =3D buf_read_u64(buf, NULL);
+    p->flags =3D buf_read_u32(buf, NULL);
+ =
   return true;
+}
+
+bool
+oob_probe_reply_write(struct buffer *buf, const=
 struct oob_probe_reply *r)
+{
+    return ctrl_msg_tlv_write_header(buf, O=
OB_TLV_PROBE_REPLY, false, OOB_PROBE_REPLY_LEN)
+           && session_id_w=
rite(&r->peer_session_id, buf)
+           && buf_write_u16(buf, r->priorit=
y)
+           && buf_write_u16(buf, r->weight)
+           && buf_write_u1=
6(buf, r->max_latency_diff)
+           && buf_write_u16(buf, r->connect_li=
fetime)
+           && buf_write_u32(buf, r->flags);
+}
+
+bool
+oob_probe_=
reply_read(struct buffer *buf, struct oob_probe_reply *r)
+{
+    /* One bo=
unds check for the whole value, as in oob_probe_parameter_read()=2E */
+   =
 if (buf_len(buf) < OOB_PROBE_REPLY_LEN)
+    {
+        return false;
+   =
 }
+    session_id_read(&r->peer_session_id, buf);
+    r->priority =3D (ui=
nt16_t)buf_read_u16(buf);
+    r->weight =3D (uint16_t)buf_read_u16(buf);
+=
    r->max_latency_diff =3D (uint16_t)buf_read_u16(buf);
+    r->connect_li=
fetime =3D (uint16_t)buf_read_u16(buf);
+    r->flags =3D buf_read_u32(buf,=
 NULL);
+    return true;
+}
diff --git a/src/openvpn/oob=2Eh b/src/openvpn=
/oob=2Eh
new file mode 100644
index 0000000=2E=2Ec5396b3
--- /dev/null
+++ =
b/src/openvpn/oob=2Eh
@@ -0,0 +1,110 @@
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
entries in the
+ * 0x2xx type space=2E The framing itself is shared with th=
e other TLV-based
+ * control messages of the wire protocol and lives in co=
ntrol_msg=2Eh; this file
+ * defines the OOB message and TLV types, their v=
alues, and the OOB-specific
+ * decisions taken on them=2E
+ */
+
+#ifndef =
OOB_H
+#define OOB_H
+
+#include "buffer=2Eh"
+#include "session_id=2Eh"
+
=
+/* OOB message types: the 16-bit value at the start of an OOB payload, bef=
ore
+ * its TLV entries=2E Distinct from the TLV-type space (0x2xx); see th=
e "Messages"
+ * table in the OOB section of the wire protocol spec=2E */
+=
#define OOB_MSG_SERVER_PROBE 0x100
+#define OOB_MSG_PROBE_REPLY  0x101
+
+/=
* TLV types (see the OOB control message section of the wire protocol spec)=
 */
+#define OOB_TLV_PROBE_PARAMETER 0x200
+#define OOB_TLV_PROBE_REPLY    =
 0x201
+
+/* Minimum on-wire value length (excluding the 4-byte TLV header)=
 of each TLV:
+ * the sizes of its fixed fields in wire order (see the stru=
cts below)=2E The
+ * value may be longer for forward compatibility; traili=
ng bytes that are not
+ * understood are ignored on read=2E */
+#define OOB=
_PROBE_PARAMETER_LEN \
+    ((uint16_t)(sizeof(uint64_t) /* timestamp */ + =
sizeof(uint32_t) /* flags */))
+#define OOB_PROBE_REPLY_LEN                =
                   \
+    ((uint16_t)(SID_SIZE               /* peer_sessio=
n_id */  \
+                + 4 * sizeof(uint16_t) /* priority, weight,   \=

+                                        * max_latency_diff,   \
+        =
                                * connect_lifetime */ \
+                + =
sizeof(uint32_t)))   /* flags */
+
+/* probe parameter TLV (sent by the cli=
ent in a SERVER_PROBE) */
+struct oob_probe_parameter
+{
+    uint64_t time=
stamp; /**< client clock as a UNIX timestamp */
+    uint32_t flags;     /*=
*< client capability flags, currently must be 0 */
+};
+
+/* probe reply TL=
V (sent by the server in a PROBE_REPLY) */
+struct oob_probe_reply
+{
+    =
struct session_id peer_session_id; /**< echoes the session id of the reques=
t */
+    uint16_t priority;                 /**< DNS-SRV style priority (l=
ower is preferred) */
+    uint16_t weight;                   /**< DNS-SRV =
style weight */
+    uint16_t max_latency_diff;         /**< advertised can=
didate-band margin in ms;
+                                        *   used=
 unless the client configured its own */
+    uint16_t connect_lifetime;   =
      /**< seconds the reply stays valid as the handshake reset */
+    uin=
t32_t flags;                    /**< server behaviour flags */
+};
+
+/**
+=
 * Write a complete probe parameter TLV (header + value) to buf=2E
+ */
+bo=
ol oob_probe_parameter_write(struct buffer *buf, const struct oob_probe_par=
ameter *p);
+
+/**
+ * Read a probe parameter TLV value from buf=2E
+ *
+ *=
 buf must cover exactly the TLV's value, as returned by ctrl_msg_find_tlv()=
=2E
+ * Trailing bytes beyond the fields understood here are ignored, so a =
longer
+ * value from a future version still parses=2E
+ *
+ * @return true=
 on success, false if buf is shorter than the mandatory fields=2E
+ */
+boo=
l oob_probe_parameter_read(struct buffer *buf, struct oob_probe_parameter *=
p);
+
+/**
+ * Write a complete probe reply TLV (header + value) to buf=2E
=
+ */
+bool oob_probe_reply_write(struct buffer *buf, const struct oob_probe=
_reply *r);
+
+/**
+ * Read a probe reply TLV value from buf=2E See oob_pro=
be_parameter_read() for the
+ * calling convention=2E
+ */
+bool oob_probe_=
reply_read(struct buffer *buf, struct oob_probe_reply *r);
+
+#endif /* OOB=
_H */
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 76150d4=
=2E=2Ef0cd720 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@=
 -3705,8 +3705,9 @@
     bool new_link =3D false;
     struct session_id si=
d; /* remote session ID */
 
-    /* verify legal opcode */
-    if (op < P=
_FIRST_OPCODE || op > P_LAST_OPCODE)
+    /* verify legal opcode=2E An out-=
of-band packet has no reliability header,
+     * which is what we parse ne=
xt; do_pre_decrypt_check() answers those=2E */
+    if (op < P_FIRST_OPCODE=
 || op > P_LAST_OPCODE || opcode_is_oob(op))
     {
         if (op =3D=3D =
P_CONTROL_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)=

         {
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
=
index 90b2aec=2E=2E4e6b98b 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/o=
penvpn/ssl_pkt=2Ec
@@ -168,6 +168,7 @@
 {
     ASSERT(ks->key_id >=3D 0 && =
ks->key_id <=3D P_KEY_ID_MASK);
     ASSERT(opcode >=3D 0 && opcode <=3D P_=
LAST_OPCODE);
+    ASSERT(!opcode_is_oob(opcode)); /* those are built by tl=
s_wrap_oob_standalone() */
     uint8_t header =3D (uint8_t)(ks->key_id | (=
opcode << P_OPCODE_SHIFT));
 
     /* Workaround for Softether servers=2E S=
oftether has a bug that it only
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/=
openvpn/ssl_pkt=2Eh
index 03e8930=2E=2Ed8d4b5e 100644
--- a/src/openvpn/ssl=
_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -58,11 +58,23 @@
  * like P_CONTR=
OL_HARD_RESET_CLIENT_V3 */
 #define P_CONTROL_WKC_V1 11
 
-/* define the ra=
nge of legal opcodes
+/* Out-of-band control message, e=2Eg=2E a server pro=
be: no reliability header
+ * (ACK array, packet id), just TLVs after the s=
ession id=2E Answered statelessly
+ * in do_pre_decrypt_check(), never hand=
led by tls_pre_decrypt()=2E */
+#define P_CONTROL_OOB_V1 12
+
+/* define th=
e range of defined opcodes, in- and out-of-band
  * Since we do no longer s=
upport key-method 1 we consider
  * the v1 op codes invalid */
 #define P_F=
IRST_OPCODE 3
-#define P_LAST_OPCODE  11
+#define P_LAST_OPCODE  12
+
+/* t=
he out-of-band opcodes, which carry no reliability header */
+static inline=
 bool
+opcode_is_oob(int op)
+{
+    return op =3D=3D P_CONTROL_OOB_V1;
+}
=
 
 /*
  * Define number of buffers for send and receive in the reliability =
layer=2E
@@ -256,6 +268,9 @@
         case P_CONTROL_WKC_V1:
             r=
eturn "P_CONTROL_WKC_V1";
 
+        case P_CONTROL_OOB_V1:
+            re=
turn "P_CONTROL_OOB_V1";
+
         case P_ACK_V1:
             return "P_A=
CK_V1";
 
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_=
tests/openvpn/Makefile=2Eam
index 5954902=2E=2E9f6b865 100644
--- a/tests/u=
nit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Ea=
m
@@ -14,6 +14,7 @@
 	ncp_testdriver \
 	mbuf_testdriver \
 	misc_testdrive=
r \
+	oob_testdriver \
 	options_parse_testdriver \
 	packet_id_testdriver =
\
 	pkt_testdriver \
@@ -153,6 +154,20 @@
 	$(top_srcdir)/src/openvpn/win32=
-util=2Ec \
 	$(top_srcdir)/src/openvpn/session_id=2Ec
 
+oob_testdriver_CF=
LAGS  =3D \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_sr=
cdir)/src/openvpn \
+	@TEST_CFLAGS@
+oob_testdriver_LDFLAGS =3D @TEST_LDFLA=
GS@
+oob_testdriver_SOURCES =3D test_oob=2Ec \
+	mock_msg=2Ec mock_msg=2Eh =
test_common=2Eh \
+	mock_get_random=2Ec \
+	$(top_srcdir)/src/openvpn/buffe=
r=2Ec \
+	$(top_srcdir)/src/openvpn/control_msg=2Ec \
+	$(top_srcdir)/src/o=
penvpn/oob=2Ec \
+	$(top_srcdir)/src/openvpn/platform=2Ec \
+	$(top_srcdir)=
/src/openvpn/session_id=2Ec \
+	$(top_srcdir)/src/openvpn/win32-util=2Ec
+
=
 pkt_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src=
/compat -I$(top_srcdir)/src/openvpn \
 	@TEST_CFLAGS@
diff --git a/tests/un=
it_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
new f=
ile mode 100644
index 0000000=2E=2E70f529e0
--- /dev/null
+++ b/tests/unit_=
tests/openvpn/test_oob=2Ec
@@ -0,0 +1,340 @@
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
<stdarg=2Eh>
+#include <stddef=2Eh>
+#include <setjmp=2Eh>
+#include <cmock=
a=2Eh>
+
+#include "control_msg=2Eh"
+#include "oob=2Eh"
+#include "test_co=
mmon=2Eh"
+
+/* Write a probe parameter TLV and read it back; fields must s=
urvive the
+ * round trip and the whole buffer must be consumed=2E */
+stat=
ic void
+test_probe_parameter_roundtrip(void **state)
+{
+    struct gc_are=
na gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+ =
   const struct oob_probe_parameter in =3D {
+        =2Etimestamp =3D 0x01=
23456789abcdefULL,
+        =2Eflags =3D 0,
+    };
+    assert_true(oob_pr=
obe_parameter_write(&buf, &in));
+    /* header (4) + value (12) */
+    as=
sert_int_equal(BLEN(&buf), 4 + OOB_PROBE_PARAMETER_LEN);
+
+    /* the head=
er codec, read from a copy so the scan below still sees it */
+    struct b=
uffer peek =3D buf;
+    struct ctrl_msg_tlv_header hdr;
+    assert_true(c=
trl_msg_tlv_read_header(&peek, &hdr));
+    assert_int_equal(hdr=2Etype, OO=
B_TLV_PROBE_PARAMETER);
+    assert_false(hdr=2Eoptional);
+    assert_int_=
equal(hdr=2Evalue_len, OOB_PROBE_PARAMETER_LEN);
+
+    struct buffer value=
;
+    assert_true(ctrl_msg_find_tlv(&buf, OOB_TLV_PROBE_PARAMETER, &value)=
);
+    assert_int_equal(BLEN(&value), OOB_PROBE_PARAMETER_LEN);
+
+    str=
uct oob_probe_parameter out =3D { 0 };
+    assert_true(oob_probe_parameter=
_read(&value, &out));
+    assert_true(in=2Etimestamp =3D=3D out=2Etimestam=
p);
+    assert_int_equal(in=2Eflags, out=2Eflags);
+    /* the scan consum=
ed header and value alike */
+    assert_int_equal(BLEN(&buf), 0);
+
+    g=
c_free(&gc);
+}
+
+/* Write a probe reply TLV and read it back=2E */
+stati=
c void
+test_probe_reply_roundtrip(void **state)
+{
+    struct gc_arena gc=
 =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    st=
ruct oob_probe_reply in =3D {
+        =2Epriority =3D 10,
+        =2Eweig=
ht =3D 100,
+        =2Econnect_lifetime =3D 30,
+        =2Eflags =3D 1,
+=
        =2Emax_latency_diff =3D 25,
+    };
+    memcpy(in=2Epeer_session_i=
d=2Eid, "ABCDEFGH", SID_SIZE);
+
+    assert_true(oob_probe_reply_write(&bu=
f, &in));
+    assert_int_equal(BLEN(&buf), 4 + OOB_PROBE_REPLY_LEN);
+
+  =
  struct buffer peek =3D buf;
+    struct ctrl_msg_tlv_header hdr;
+    ass=
ert_true(ctrl_msg_tlv_read_header(&peek, &hdr));
+    assert_int_equal(hdr=
=2Etype, OOB_TLV_PROBE_REPLY);
+    assert_int_equal(hdr=2Evalue_len, OOB_P=
ROBE_REPLY_LEN);
+
+    struct buffer value;
+    assert_true(ctrl_msg_find=
_tlv(&buf, OOB_TLV_PROBE_REPLY, &value));
+
+    struct oob_probe_reply out=
 =3D { 0 };
+    assert_true(oob_probe_reply_read(&value, &out));
+    asse=
rt_memory_equal(in=2Epeer_session_id=2Eid, out=2Epeer_session_id=2Eid, SID_=
SIZE);
+    assert_int_equal(in=2Epriority, out=2Epriority);
+    assert_in=
t_equal(in=2Eweight, out=2Eweight);
+    assert_int_equal(in=2Econnect_life=
time, out=2Econnect_lifetime);
+    assert_int_equal(in=2Eflags, out=2Eflag=
s);
+    assert_int_equal(in=2Emax_latency_diff, out=2Emax_latency_diff);
+=
    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* The prob=
e reply wire format is locked to the spec's field order
+ * (priority, weig=
ht, max_latency_diff, connect_lifetime, flags), big-endian=2E */
+static vo=
id
+test_probe_reply_wire_format(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    str=
uct oob_probe_reply in =3D {
+        =2Epriority =3D 10,
+        =2Eweigh=
t =3D 100,
+        =2Econnect_lifetime =3D 30,
+        =2Eflags =3D 1,
+ =
       =2Emax_latency_diff =3D 25,
+    };
+    memcpy(in=2Epeer_session_id=
=2Eid, "ABCDEFGH", SID_SIZE);
+
+    assert_true(oob_probe_reply_write(&buf=
, &in));
+
+    const uint8_t expected[] =3D {
+        0x02,
+        0x01=
, /* TLV type 0x201 (not optional) */
+        0x00,
+        0x14, /* TLV =
value length =3D 20 */
+        'A',
+        'B',
+        'C',
+        '=
D',
+        'E',
+        'F',
+        'G',
+        'H',  /* peer_sessio=
n_id */
+        0x00,
+        0x0a, /* priority =3D 10 */
+        0x00,
=
+        0x64, /* weight =3D 100 */
+        0x00,
+        0x19, /* max_la=
tency_diff =3D 25 */
+        0x00,
+        0x1e, /* connect_lifetime =3D =
30 */
+        0x00,
+        0x00,
+        0x00,
+        0x01, /* flags =
=3D 1 */
+    };
+    assert_int_equal(BLEN(&buf), sizeof(expected));
+    =
assert_memory_equal(BPTR(&buf), expected, sizeof(expected));
+
+    gc_free=
(&gc);
+}
+
+/* A TLV with a longer-than-known value must still parse: the =
known fields are
+ * read and the trailing bytes are skipped (forward compa=
tibility)=2E */
+static void
+test_probe_parameter_forward_compat(void **st=
ate)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D al=
loc_buf_gc(128, &gc);
+
+    const uint16_t extended_len =3D OOB_PROBE_PARA=
METER_LEN + 4;
+    assert_true(ctrl_msg_tlv_write_header(&buf, OOB_TLV_PRO=
BE_PARAMETER, false, extended_len));
+    assert_true(buf_write_u32(&buf, 0=
));          /* timestamp high */
+    assert_true(buf_write_u32(&buf, 0xde=
adbeef)); /* timestamp low */
+    assert_true(buf_write_u32(&buf, 0));    =
      /* flags */
+    assert_true(buf_write_u32(&buf, 0x11223344)); /* unk=
nown trailing field */
+
+    struct buffer value;
+    assert_true(ctrl_ms=
g_find_tlv(&buf, OOB_TLV_PROBE_PARAMETER, &value));
+    assert_int_equal(B=
LEN(&value), extended_len);
+
+    struct oob_probe_parameter out =3D { 0 }=
;
+    assert_true(oob_probe_parameter_read(&value, &out));
+    assert_tru=
e(out=2Etimestamp =3D=3D 0xdeadbeefULL);
+    assert_int_equal(out=2Eflags,=
 0);
+    /* the unknown trailing field must have been consumed from the pa=
yload */
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/=
* A value shorter than the mandatory fields must be rejected, even when it
=
+ * holds enough bytes for some of the individual fields to read successful=
ly=2E */
+static void
+test_probe_parameter_too_short(void **state)
+{
+   =
 struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(1=
28, &gc);
+
+    /* 4 of the 12 mandatory value bytes: too short for the ti=
mestamp, but
+     * enough for a u32 read to succeed on its own */
+    as=
sert_true(buf_write_u32(&buf, 0xdeadbeef));
+
+    struct oob_probe_paramet=
er out =3D { 0 };
+    assert_false(oob_probe_parameter_read(&buf, &out));
=
+
+    gc_free(&gc);
+}
+
+/* A TLV header claiming more value bytes than t=
he payload holds must be
+ * rejected by the scan rather than reported as f=
ound -- for the TLV being
+ * looked for as much as for one that would mere=
ly be skipped=2E */
+static void
+test_find_tlv_value_truncated(void **stat=
e)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer value;
+
+  =
  /* the wanted TLV declares 12 value bytes, only 4 are present */
+    str=
uct buffer buf =3D alloc_buf_gc(128, &gc);
+    assert_true(ctrl_msg_tlv_wr=
ite_header(&buf, OOB_TLV_PROBE_PARAMETER, false,
+                         =
                 OOB_PROBE_PARAMETER_LEN));
+    assert_true(buf_write_u32(=
&buf, 0xdeadbeef));
+    assert_false(ctrl_msg_find_tlv(&buf, OOB_TLV_PROBE=
_PARAMETER, &value));
+
+    /* same defect on a TLV that would be skipped:=
 the scan must not walk past
+     * the end of the payload looking for the=
 next header */
+    struct buffer buf2 =3D alloc_buf_gc(128, &gc);
+    as=
sert_true(ctrl_msg_tlv_write_header(&buf2, 0x7ff, false, 64));
+    assert_=
true(buf_write_u32(&buf2, 0));
+    assert_false(ctrl_msg_find_tlv(&buf2, O=
OB_TLV_PROBE_PARAMETER, &value));
+
+    gc_free(&gc);
+}
+
+/* Bytes left =
over after the last TLV that are too few for a header make the
+ * message =
malformed, even when the wanted TLV was already found=2E */
+static void
+t=
est_find_tlv_trailing_bytes(void **state)
+{
+    struct gc_arena gc =3D gc=
_new();
+    struct buffer value;
+
+    /* 1 to 3 bytes: less than a 4-byt=
e TLV header */
+    for (int trailing =3D 1; trailing <=3D 3; trailing++)
=
+    {
+        struct buffer buf =3D alloc_buf_gc(128, &gc);
+        cons=
t struct oob_probe_parameter in =3D { =2Etimestamp =3D 1, =2Eflags =3D 0 };=

+        assert_true(oob_probe_parameter_write(&buf, &in));
+        for (=
int i =3D 0; i < trailing; i++)
+        {
+            assert_true(buf_wri=
te_u8(&buf, 0));
+        }
+        assert_false(ctrl_msg_find_tlv(&buf, O=
OB_TLV_PROBE_PARAMETER, &value));
+    }
+
+    gc_free(&gc);
+}
+
+/* An u=
nknown TLV marked optional after the wanted one is skipped, and the
+ * wan=
ted value is still the one returned=2E */
+static void
+test_find_tlv_skips=
_optional_after_wanted(void **state)
+{
+    struct gc_arena gc =3D gc_new(=
);
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+    struct buffer va=
lue;
+
+    const struct oob_probe_parameter in =3D { =2Etimestamp =3D 7, =
=2Eflags =3D 0 };
+    assert_true(oob_probe_parameter_write(&buf, &in));
+=
    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    asse=
rt_true(buf_write_u32(&buf, 0));
+
+    assert_true(ctrl_msg_find_tlv(&buf,=
 OOB_TLV_PROBE_PARAMETER, &value));
+    assert_int_equal(BLEN(&value), OOB=
_PROBE_PARAMETER_LEN);
+    struct oob_probe_parameter out =3D { 0 };
+    =
assert_true(oob_probe_parameter_read(&value, &out));
+    assert_true(out=
=2Etimestamp =3D=3D 7);
+
+    gc_free(&gc);
+}
+
+/* An empty payload hold=
s no TLV=2E */
+static void
+test_find_tlv_empty_payload(void **state)
+{
+=
    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_g=
c(16, &gc);
+    struct buffer value;
+
+    assert_false(ctrl_msg_find_tlv=
(&buf, OOB_TLV_PROBE_PARAMETER, &value));
+
+    gc_free(&gc);
+}
+
+/* Rea=
ding a TLV header must fail when the buffer holds less data than a
+ * comp=
lete 4-byte header (empty, or only the type field), rather than read
+ * pa=
st the available data=2E */
+static void
+test_tlv_header_truncated(void **=
state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D =
alloc_buf_gc(128, &gc);
+
+    struct ctrl_msg_tlv_header hdr;
+
+    /* em=
pty buffer */
+    assert_false(ctrl_msg_tlv_read_header(&buf, &hdr));
+
+ =
   /* only the type field present, no length */
+    assert_true(buf_write_=
u16(&buf, OOB_TLV_PROBE_PARAMETER));
+    assert_false(ctrl_msg_tlv_read_he=
ader(&buf, &hdr));
+
+    gc_free(&gc);
+}
+
+int
+main(void)
+{
+    openv=
pn_unit_test_setup();
+    const struct CMUnitTest tests[] =3D {
+        c=
mocka_unit_test(test_probe_parameter_roundtrip),
+        cmocka_unit_test(=
test_probe_reply_roundtrip),
+        cmocka_unit_test(test_probe_reply_wir=
e_format),
+        cmocka_unit_test(test_probe_parameter_forward_compat),
=
+        cmocka_unit_test(test_probe_parameter_too_short),
+        cmocka_=
unit_test(test_find_tlv_value_truncated),
+        cmocka_unit_test(test_fi=
nd_tlv_trailing_bytes),
+        cmocka_unit_test(test_find_tlv_skips_optio=
nal_after_wanted),
+        cmocka_unit_test(test_find_tlv_empty_payload),
=
+        cmocka_unit_test(test_tlv_header_truncated),
+    };
+
+    return=
 cmocka_run_group_tests_name("oob tests", tests, NULL, NULL);
+}

-- 
To vi=
ew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c8d302ac57c5603d622a7be=
14be369437388268
Gerrit-Change-Number: 1741
Gerrit-PatchSet: 16
Gerrit-Owne=
r: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerri=
t-Attention: stipa <lstipakov@gmail=2Ecom>

--ARgnDrcmB3s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ralf_lici, stipa=2E </p>
<p>stipa <stro=
ng>uploaded patch set #16</strong> to this change=2E</p><p><a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">oob: Add control message TLV encoding (P_CONTROL_OOB_V1)<br><b=
r>Out-of-band control messages carry control data but belong to no<br>sessi=
on, so a client can ask a server about itself before connecting=2E<br>Reser=
ve opcode 12 for them and add the codec for the two messages the<br>probe n=
eeds, SERVER_PROBE and PROBE_REPLY=2E<br><br>The spec uses the same TLV fra=
ming for all its control messages, not<br>just the out-of-band ones, so the=
 message-type header, the TLV header<br>and the TLV scan go into their own =
control_msg=2Ec/h; oob=2Ec keeps the OOB<br>message and TLV types=2E<br><br=
>The scan is strict: a header or value that does not fit in the remaining<b=
r>payload, including trailing bytes too few for a header, or an unknown<br>=
TLV not marked optional rejects the whole message rather than just the<br>T=
LV=2E<br><br>P_LAST_OPCODE becomes 12, and opcode_valid_in_session() replac=
es the<br>plain range check because OOB opcodes are answered statelessly an=
d are<br>never legal on an established session=2E<br><br>See the OOB contro=
l message section of the wire protocol specification<br>(openvpn-rfc PR #30=
)=2E<br><br>Change-Id: I1c8d302ac57c5603d622a7be14be369437388268<br>Signed-=
off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M CMakeLists=2Etxt=
<br>M src/openvpn/Makefile=2Eam<br>A src/openvpn/control_msg=2Ec<br>A src/o=
penvpn/control_msg=2Eh<br>A src/openvpn/oob=2Ec<br>A src/openvpn/oob=2Eh<br=
>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pk=
t=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests/unit_tests/ope=
nvpn/test_oob=2Ec<br>11 files changed, 796 insertions(+), 4 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/41/1741/16</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeList=
s=2Etxt</span><br><span>index 6eb5954=2E=2Efbc69f0 100644</span><br><span>-=
-- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><spa=
n>@@ -445,6 +445,8 @@</span><br><span>     src/openvpn/console=2Ec</span><b=
r><span>     src/openvpn/console_builtin=2Ec</span><br><span>     src/openv=
pn/console=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
rc/openvpn/control_msg=2Ec</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    src/openvpn/control_msg=2Eh</span><br><span>     src/openvpn/cry=
pto=2Ec</span><br><span>     src/openvpn/crypto=2Eh</span><br><span>     sr=
c/openvpn/crypto_backend=2Eh</span><br><span>@@ -523,6 +525,8 @@</span><br>=
<span>     src/openvpn/multi_io=2Ec</span><br><span>     src/openvpn/occ=2E=
c</span><br><span>     src/openvpn/occ=2Eh</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    src/openvpn/oob=2Ec</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    src/openvpn/oob=2Eh</span><br><span>     src=
/openvpn/openvpn=2Ec</span><br><span>     src/openvpn/openvpn=2Eh</span><br=
><span>     src/openvpn/openvpn_win32_resources=2Erc</span><br><span>@@ -67=
7,6 +681,7 @@</span><br><span>         &quot;test_mbuf&quot;</span><br><spa=
n>         &quot;test_misc&quot;</span><br><span>         &quot;test_ncp&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;te=
st_oob&quot;</span><br><span>         &quot;test_options_parse&quot;</span>=
<br><span>         &quot;test_packet_id&quot;</span><br><span>         &quo=
t;test_pkt&quot;</span><br><span>@@ -881,6 +886,13 @@</span><br><span>     =
    src/openvpn/session_id=2Ec</span><br><span>         )</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    target_sources(=
test_oob PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     tests/unit_tests/openvpn/mock_get_random=2Ec</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        src/openvpn/control_msg=2Ec</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/oob=2Ec</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/s=
ession_id=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>     target_sources(test_pkt PRIVATE</span><br><span>         tests/unit_t=
ests/openvpn/mock_win32_execve=2Ec</span><br><span>         src/openvpn/arg=
v=2Ec</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/=
Makefile=2Eam</span><br><span>index 7fd12b4=2E=2E5e6b4d9 100644</span><br><=
span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Make=
file=2Eam</span><br><span>@@ -53,6 +53,7 @@</span><br><span> 	common=2Eh \<=
/span><br><span> 	comp=2Ec comp=2Eh compstub=2Ec \</span><br><span> 	comp-l=
z4=2Ec comp-lz4=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	control_msg=2Ec control_msg=2Eh \</span><br><span> 	crypto=2Ec crypto=2E=
h crypto_backend=2Eh \</span><br><span> 	crypto_openssl=2Ec crypto_openssl=
=2Eh \</span><br><span> 	crypto_mbedtls_legacy=2Ec crypto_mbedtls_legacy=2E=
h \</span><br><span>@@ -107,6 +108,7 @@</span><br><span> 	pkcs11=2Ec pkcs11=
=2Eh pkcs11_backend=2Eh \</span><br><span> 	pkcs11_openssl=2Ec \</span><br>=
<span> 	pkcs11_mbedtls=2Ec \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	oob=2Ec oob=2Eh \</span><br><span> 	openvpn=2Ec openvpn=2Eh \</sp=
an><br><span> 	options=2Ec options=2Eh \</span><br><span> 	options_show=2Ec=
 options_show=2Eh \</span><br><span>diff --git a/src/openvpn/control_msg=2E=
c b/src/openvpn/control_msg=2Ec</span><br><span>new file mode 100644</span>=
<br><span>index 0000000=2E=2E81f2aef</span><br><span>--- /dev/null</span><b=
r><span>+++ b/src/openvpn/control_msg=2Ec</span><br><span>@@ -0,0 +1,106 @@=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to sec=
urely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             over a single TCP/UDP port, with support for SSL/TLS-ba=
sed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             s=
ession authentication and key exchange,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *             packet encryption, packet authentication=
, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright =
(C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is free software; you can redistribute it=
 and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  i=
t under the terms of the GNU General Public License version 2</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Soft=
ware Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program i=
s distributed in the hope that it will be useful,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even th=
e implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Li=
cense for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You sho=
uld have received a copy of the GNU General Public License along</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not,=
 see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifde=
f HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;control_msg=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_read_header(struct buffer *buf, =
uint16_t expected_msg_type)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ms=
g_type =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return msg_type &gt;=3D 0 &amp;&amp; (uint16_t)msg_type =3D=
=3D expected_msg_type;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ctrl_msg_tlv_write_header(struct buffer *buf, uin=
t16_t type, bool optional, uint16_t value_len)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    uint16_t field =3D type &amp; CTRL_MSG_TLV_TYPE_MASK;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (optional)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        field |=3D CTRL_MSG_TLV_OPTIONAL_FLA=
G;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return buf_write_u16(buf, f=
ield) &amp;&amp; buf_write_u16(buf, value_len);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_read_header=
(struct buffer *buf, struct ctrl_msg_tlv_header *hdr)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int field =3D buf_read_u16(buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (field &lt; 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int len =3D buf_read_u16(buf);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (len &lt; 0)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   hdr-&gt;type =3D (uint16_t)(field &amp; CTRL_MSG_TLV_TYPE_MASK);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt;optional =3D (f=
ield &amp; CTRL_MSG_TLV_OPTIONAL_FLAG) !=3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    hdr-&gt;value_len =3D (uint16_t)len;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_ms=
g_find_tlv(struct buffer *payload, uint16_t wanted_type, struct buffer *val=
ue)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_header hdr=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool found =3D=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (B=
LEN(payload) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!=
ctrl_msg_tlv_read_header(payload, &amp;hdr))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            return false; /* fewer than 4 bytes left: trunca=
ted header */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Take =
the value out of payload=2E This validates that the header&#39;s</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+         * length is really th=
ere and advances past it in one step, so the TLV</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+         * we are looking for and the ones we =
skip are bounds-checked alike=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        uint8_t *v =3D buf_read_alloc(payload, hdr=2Evalue_=
len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!v=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            return false;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (hdr=2Etype =3D=3D wa=
nted_type)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!fo=
und)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                buf_s=
et_read(value, v, hdr=2Evalue_len);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                found =3D true;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        else if (!hdr=2Eoptional)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            /* A TLV we do not understand that the sender d=
id not mark optional</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+             * carries something it requires us to act on, so the message =
as a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * =
whole is not ours to interpret=2E This is why the scan continues</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+             * past the wanted=
 type: such a TLV invalidates the message wherever</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+             * in the sequence it sits=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return =
false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return found;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/open=
vpn/control_msg=2Eh b/src/openvpn/control_msg=2Eh</span><br><span>new file =
mode 100644</span><br><span>index 0000000=2E=2E827178b</span><br><span>--- =
/dev/null</span><br><span>+++ b/src/openvpn/control_msg=2Eh</span><br><span=
>@@ -0,0 +1,107 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An =
application to securely tunnel IP networks</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with supp=
ort for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             session authentication and key exchange,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, pac=
ket authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             packet compression=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you c=
an redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  it under the terms of the GNU General Public License versi=
on 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publishe=
d by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  This program is distributed in the hope that it will be useful,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANT=
Y; without even the implied warranty of</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU=
 General Public License for more details=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Framing s=
hared by the TLV-based control messages of the wire protocol=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Such a message payload starts with a 16-bit m=
essage type, followed by a</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * sequence of TLV entries=2E Each TLV starts with a 4-byte header: =
a 16-bit field</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * wh=
ose most significant bit is the &quot;optional&quot; flag and whose remaini=
ng 15 bits</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * are th=
e type, followed by a 16-bit length giving the size of the value that</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * follows the header=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * The message-type and TLV-type valu=
es themselves are specific to the message</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * family carried (out-of-band messages define theirs=
 in oob=2Eh), so only the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * framing lives here=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef CONTROL_MSG_H</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CONTROL_MSG_H<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* TLV header bit layout of the first 16-bit f=
ield */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CTRL=
_MSG_TLV_OPTIONAL_FLAG 0x8000</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define CTRL_MSG_TLV_TYPE_MASK     0x7fff</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* The header every TLV carries: the 15-bit type and optiona=
l flag packed into</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* the first 16-bit field, then the length of the value that follows=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct ctrl_msg_tlv_h=
eader</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    uint16_t type;      /**&lt; =
the 15-bit TLV type */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    bool optional;      /**&lt; value of the optional flag */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t value_len; /**&lt=
; length of the value following the header */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read and verify a messa=
ge-type header from buf, advancing past it=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param buf                buffer positioned at the message payl=
oad</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param expect=
ed_msg_type  the message type the payload must carry</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return true if a message type was rea=
d and equals expected_msg_type,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *         false on a short buffer or a mismatching type=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_read_header(struct buffer=
 *buf, uint16_t expected_msg_type);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a TLV head=
er (type + optional flag + value length) to buf=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @return true on success, false if buf has insufficient spa=
ce=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_write_header=
(struct buffer *buf, uint16_t type, bool optional,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                               uint16_t valu=
e_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Read a TLV header from buf, advancing past i=
t=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param buf  buffer positioned=
 at the TLV header</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param hdr  filled with the type, optional flag and value length on succe=
ss</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true o=
n success, false if there are not enough bytes for a header=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_read_header(struct buffer *buf=
, struct ctrl_msg_tlv_header *hdr);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Scan payload for=
 the TLV of type wanted_type, skipping any other (e=2Eg=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * future) TLV type that is marked o=
ptional=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * This is for messages th=
at carry exactly one mandatory TLV, which is every</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * OOB message so far: any other TLV that is=
 not marked optional invalidates</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * the message wherever it sits, so the whole sequence is walk=
ed=2E A message</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * w=
ith several mandatory TLVs would need a scan that knows all of them=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * On success value covers exactly the fo=
und TLV&#39;s value bytes=2E The length from</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * each TLV header is validated against payload as=
 the scan goes, so the whole</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * value is guaranteed to be present; a header claiming more bytes=
 than payload</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * hol=
ds is rejected rather than reported as found=2E payload is consumed as it i=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * read=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param payload      buffer positioned at =
a TLV header</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am wanted_type  the TLV type to look for</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param value        set to a buffer covering the fo=
und TLV&#39;s value</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @return true if the TLV was found, false if it is not present, a TLV hea=
der</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         or va=
lue is malformed or truncated, or a TLV we do not understand is</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *         not marked optional=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_find_tlv(struct bu=
ffer *payload, uint16_t wanted_type, struct buffer *value);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif /* ifndef CONTROL_MSG_H */</span><br><span>diff=
 --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br><span>new file=
 mode 100644</span><br><span>index 0000000=2E=2Ec807171</span><br><span>---=
 /dev/null</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -0,=
0 +1,83 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An applicat=
ion to securely tunnel IP networks</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             over a single TCP/UDP port, with support for =
SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
         session authentication and key exchange,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *             packet encryption, packet auth=
entication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
           packet compression=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  This program is free software; you can redis=
tribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  it under the terms of the GNU General Public License version 2</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the=
 Free Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This=
 program is distributed in the hope that it will be useful,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; witho=
ut even the implied warranty of</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General=
 Public License for more details=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  You should have received a copy of the GNU General Public License along<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progra=
m; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;control_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_parameter_write(=
struct buffer *buf, const struct oob_probe_parameter *p)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return ctrl_msg_tlv_write_header(buf, OOB_TLV_PROBE_=
PARAMETER, false, OOB_PROBE_PARAMETER_LEN)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u64(buf, p-&gt;times=
tamp)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &am=
p;&amp; buf_write_u32(buf, p-&gt;flags);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_parameter_read(struct=
 buffer *buf, struct oob_probe_parameter *p)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* One bounds check covers the whole value: every field read bel=
ow then fits</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
by construction (OOB_PROBE_PARAMETER_LEN is the sum of their sizes), so</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * none of them nee=
ds its own error handling=2E Trailing bytes this version</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * does not understand are simply =
left unread=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (buf_len(buf) &lt; OOB_PROBE_PARAMETER_LEN)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    p-&gt;timestamp =3D buf_read_u64(buf, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    p-&gt;flags =3D buf_read_u32(buf, NUL=
L);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+oob_probe_reply_write(struct buffer *buf, const struct oob_probe_reply =
*r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return ctrl_msg_tlv_write_head=
er(buf, OOB_TLV_PROBE_REPLY, false, OOB_PROBE_REPLY_LEN)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; session_id_write=
(&amp;r-&gt;peer_session_id, buf)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+           &amp;&amp; buf_write_u16(buf, r-&gt;priority)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; bu=
f_write_u16(buf, r-&gt;weight)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+           &amp;&amp; buf_write_u16(buf, r-&gt;max_latency_diff)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&am=
p; buf_write_u16(buf, r-&gt;connect_lifetime)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u32(buf, r-&gt;fl=
ags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+oob_probe_reply_read(struct buffer *buf, struct oob_probe_reply *r=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* One bounds check for the whol=
e value, as in oob_probe_parameter_read()=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (buf_len(buf) &lt; OOB_PROBE_REPLY_LEN)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    session_id_read(&amp;r-&gt;peer_session_id=
, buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;pr=
iority =3D (uint16_t)buf_read_u16(buf);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    r-&gt;weight =3D (uint16_t)buf_read_u16(buf);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;max_latency_dif=
f =3D (uint16_t)buf_read_u16(buf);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    r-&gt;connect_lifetime =3D (uint16_t)buf_read_u16(buf);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;flags =3D =
buf_read_u32(buf, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh<=
/span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2Ec53=
96b3</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/oob=2E=
h</span><br><span>@@ -0,0 +1,110 @@</span><br><span style=3D"color: hsl(120=
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
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Encoding/decoding of out-of-band (P_CONTROL_OOB_V1) control messages=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * An OOB message payload starts =
with a 16-bit message type (the 0x1xx space:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * SERVER_PROBE, PROBE_REPLY, =2E=2E=2E) followed =
by a sequence of TLV entries in the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * 0x2xx type space=2E The framing itself is shared with th=
e other TLV-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 control messages of the wire protocol and lives in control_msg=2Eh; this f=
ile</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * defines the O=
OB message and TLV types, their values, and the OOB-specific</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * decisions taken on them=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#ifndef OOB_H</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define OOB_H</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;session_id=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* OOB=
 message types: the 16-bit value at the start of an OOB payload, before</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * its TLV entries=2E D=
istinct from the TLV-type space (0x2xx); see the &quot;Messages&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * table in the OOB secti=
on of the wire protocol spec=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define OOB_MSG_SERVER_PROBE 0x100</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define OOB_MSG_PROBE_REPLY  0x101</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* TLV types (see the OOB control message section=
 of the wire protocol spec) */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define OOB_TLV_PROBE_PARAMETER 0x200</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define OOB_TLV_PROBE_REPLY     0x201</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* Minimum on-wire value length (excluding the =
4-byte TLV header) of each TLV:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * the sizes of its fixed fields in wire order (see the structs=
 below)=2E The</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * va=
lue may be longer for forward compatibility; trailing bytes that are not</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * understood are igno=
red on read=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine OOB_PROBE_PARAMETER_LEN \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ((uint16_t)(sizeof(uint64_t) /* timestamp */ + sizeof(uint3=
2_t) /* flags */))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define OOB_PROBE_REPLY_LEN                                   \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ((uint16_t)(SID_SIZE        =
       /* peer_session_id */  \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                + 4 * sizeof(uint16_t) /* priority, weight,   \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                     * max_latency_diff,   \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                        * connect_=
lifetime */ \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          + sizeof(uint32_t)))   /* flags */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/* probe parameter TLV (sent by the client in a SERVER_PROBE) */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+struct oob_probe_paramet=
er</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    uint64_t timestamp; /**&lt; cli=
ent clock as a UNIX timestamp */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    uint32_t flags;     /**&lt; client capability flags, curre=
ntly must be 0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* probe reply TLV (sent by the server=
 in a PROBE_REPLY) */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+struct oob_probe_reply</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct se=
ssion_id peer_session_id; /**&lt; echoes the session id of the request */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t priority=
;                 /**&lt; DNS-SRV style priority (lower is preferred) */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t weight;  =
                 /**&lt; DNS-SRV style weight */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    uint16_t max_latency_diff;         /**&lt;=
 advertised candidate-band margin in ms;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                        *   used unles=
s the client configured its own */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    uint16_t connect_lifetime;         /**&lt; seconds the r=
eply stays valid as the handshake reset */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    uint32_t flags;                    /**&lt; serve=
r behaviour flags */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Write a complete probe parameter TLV (header + v=
alue) to buf=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_probe_param=
eter_write(struct buffer *buf, const struct oob_probe_parameter *p);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Read a probe parameter TLV value from buf=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * buf must cover exactly the TLV&#39;s value, as =
returned by ctrl_msg_find_tlv()=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * Trailing bytes beyond the fields understood here are igno=
red, so a longer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
value from a future version still parses=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @return true on success, false if buf is shorter than the mandato=
ry fields=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_probe_paramete=
r_read(struct buffer *buf, struct oob_probe_parameter *p);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Write a complete probe reply TLV (header + value) to buf=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+bool oob_probe_reply_write(struct buffer *bu=
f, const struct oob_probe_reply *r);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read a probe re=
ply TLV value from buf=2E See oob_probe_parameter_read() for the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * calling convention=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool oob_probe_reply_read(struct buffer *=
buf, struct oob_probe_reply *r);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
 /* OOB_H */</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn=
/ssl=2Ec</span><br><span>index 76150d4=2E=2Ef0cd720 100644</span><br><span>=
--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><=
br><span>@@ -3705,8 +3705,9 @@</span><br><span>     bool new_link =3D false=
;</span><br><span>     struct session_id sid; /* remote session ID */</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* ve=
rify legal opcode */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (op &lt; P_FIRST_OPCODE || op &gt; P_LAST_OPCODE)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* verify legal opcode=2E An out-of=
-band packet has no reliability header,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * which is what we parse next; do_pre_decrypt_chec=
k() answers those=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (op &lt; P_FIRST_OPCODE || op &gt; P_LAST_OPCODE || opcode_is_oo=
b(op))</span><br><span>     {</span><br><span>         if (op =3D=3D P_CONT=
ROL_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)</span=
><br><span>         {</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec =
b/src/openvpn/ssl_pkt=2Ec</span><br><span>index 90b2aec=2E=2E4e6b98b 100644=
</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/op=
envpn/ssl_pkt=2Ec</span><br><span>@@ -168,6 +168,7 @@</span><br><span> {</s=
pan><br><span>     ASSERT(ks-&gt;key_id &gt;=3D 0 &amp;&amp; ks-&gt;key_id =
&lt;=3D P_KEY_ID_MASK);</span><br><span>     ASSERT(opcode &gt;=3D 0 &amp;&=
amp; opcode &lt;=3D P_LAST_OPCODE);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ASSERT(!opcode_is_oob(opcode)); /* those are built by t=
ls_wrap_oob_standalone() */</span><br><span>     uint8_t header =3D (uint8_=
t)(ks-&gt;key_id | (opcode &lt;&lt; P_OPCODE_SHIFT));</span><br><span> </sp=
an><br><span>     /* Workaround for Softether servers=2E Softether has a bu=
g that it only</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/o=
penvpn/ssl_pkt=2Eh</span><br><span>index 03e8930=2E=2Ed8d4b5e 100644</span>=
<br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/s=
sl_pkt=2Eh</span><br><span>@@ -58,11 +58,23 @@</span><br><span>  * like P_C=
ONTROL_HARD_RESET_CLIENT_V3 */</span><br><span> #define P_CONTROL_WKC_V1 11=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* =
define the range of legal opcodes</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/* Out-of-band control message, e=2Eg=2E a server probe: no r=
eliability header</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 (ACK array, packet id), just TLVs after the session id=2E Answered statele=
ssly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * in do_pre_de=
crypt_check(), never handled by tls_pre_decrypt()=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define P_CONTROL_OOB_V1 12</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* define the range of defined opcodes, in- and ou=
t-of-band</span><br><span>  * Since we do no longer support key-method 1 we=
 consider</span><br><span>  * the v1 op codes invalid */</span><br><span> #=
define P_FIRST_OPCODE 3</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define P_LAST_OPCODE  11</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define P_LAST_OPCODE  12</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* th=
e out-of-band opcodes, which carry no reliability header */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+opcode_is_oob(int op)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return op =3D=3D P_CONTROL_OOB_V1;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><sp=
an> /*</span><br><span>  * Define number of buffers for send and receive in=
 the reliability layer=2E</span><br><span>@@ -256,6 +268,9 @@</span><br><sp=
an>         case P_CONTROL_WKC_V1:</span><br><span>             return &quo=
t;P_CONTROL_WKC_V1&quot;;</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        case P_CONTROL_OOB_V1:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            return &quot;P_CONTROL_OOB_V=
1&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span>         case P_ACK_V1:</span><br><span>             return &quot;P_A=
CK_V1&quot;;</span><br><span> </span><br><span>diff --git a/tests/unit_test=
s/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br>=
<span>index 5954902=2E=2E9f6b865 100644</span><br><span>--- a/tests/unit_te=
sts/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Ma=
kefile=2Eam</span><br><span>@@ -14,6 +14,7 @@</span><br><span> 	ncp_testdri=
ver \</span><br><span> 	mbuf_testdriver \</span><br><span> 	misc_testdriver=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	oob_testdriver \=
</span><br><span> 	options_parse_testdriver \</span><br><span> 	packet_id_t=
estdriver \</span><br><span> 	pkt_testdriver \</span><br><span>@@ -153,6 +1=
54,20 @@</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span=
><br><span> 	$(top_srcdir)/src/openvpn/session_id=2Ec</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_testdriver_CFLAGS  =
=3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdi=
r)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	@TEST_CFLAGS@</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+oob_testdriver_LDFLAGS =3D @TEST=
_LDFLAGS@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_testdr=
iver_SOURCES =3D test_oob=2Ec \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	mock_get_random=2Ec \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/buffer=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir=
)/src/openvpn/control_msg=2Ec \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	$(top_srcdir)/src/openvpn/oob=2Ec \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/platform=2Ec \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openv=
pn/session_id=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	$(top_srcdir)/src/openvpn/win32-util=2Ec</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> pkt_testdriver_CFLAGS  =3D \</span>=
<br><span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcd=
ir)/src/openvpn \</span><br><span> 	@TEST_CFLAGS@</span><br><span>diff --gi=
t a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_o=
ob=2Ec</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2E70f529e0</span><br><span>--- /dev/null</span><br><span>+++ b/tests/un=
it_tests/openvpn/test_oob=2Ec</span><br><span>@@ -0,0 +1,340 @@</span><br><=
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
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;control_msg=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;oob=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;test_common=2Eh&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
 Write a probe parameter TLV and read it back; fields must survive the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * round trip and the wh=
ole buffer must be consumed=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+test_probe_parameter_roundtrip(void **state)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_par=
ameter in =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    =2Etimestamp =3D 0x0123456789abcdefULL,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        =2Eflags =3D 0,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(oob_probe_parameter_write(&amp;buf, &amp;in)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* header (4)=
 + value (12) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(BLEN(&amp;buf), 4 + OOB_PROBE_PARAMETER_LEN);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* the header codec, read from a copy so the s=
can below still sees it */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct buffer peek =3D buf;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct ctrl_msg_tlv_header hdr;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_read_header=
(&amp;peek, &amp;hdr));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(hdr=2Etype, OOB_TLV_PROBE_PARAMETER);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_false(hdr=2Eoptional)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(hdr=2Evalue_len, OOB_PROBE_PARAMETER_LEN);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct buffer value;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(ctrl_msg_find_tlv(&amp;buf, OOB_TLV_PROBE_PARAM=
ETER, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(BLEN(&amp;value), OOB_PROBE_PARAMETER_LEN);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct oob_probe_parameter out =3D { 0 };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_pro=
be_parameter_read(&amp;value, &amp;out));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(in=2Etimestamp =3D=3D out=2Etimestamp=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(in=2Eflags, out=2Eflags);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* the scan consumed header and value alike */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf=
), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* Write a probe reply TLV and read it back=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+test_probe_reply_roundtrip(void **state)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct oob_probe_reply in =3D {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        =2Epriority =3D 10,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        =2Eweight =3D 100,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        =2Econnect_lifetime =3D 30,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D 1,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        =2Emax_latency_diff =3D=
 25,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(in=2Epeer_session=
_id=2Eid, &quot;ABCDEFGH&quot;, SID_SIZE);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(oob_probe_reply_write(&amp;buf, &amp;in));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;b=
uf), 4 + OOB_PROBE_REPLY_LEN);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct buffer peek =3D buf;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_read_header(&amp;peek, &am=
p;hdr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(hdr=2Etype, OOB_TLV_PROBE_REPLY);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Evalue_len, OOB_PROBE_REP=
LY_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_=
find_tlv(&amp;buf, OOB_TLV_PROBE_REPLY, &amp;value));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct oob_probe_reply out =3D { 0 };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_reply_read(&=
amp;value, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_memory_equal(in=2Epeer_session_id=2Eid, out=2Epeer_session_id=
=2Eid, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(in=2Epriority, out=2Epriority);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Eweight, out=2Eweig=
ht);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(in=2Econnect_lifetime, out=2Econnect_lifetime);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Eflags, out=2Efl=
ags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(in=2Emax_latency_diff, out=2Emax_latency_diff);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* The probe reply wire format is locked to the spec&#39;s field order</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (priority, weight, =
max_latency_diff, connect_lifetime, flags), big-endian=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_wire_format(void **state=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer b=
uf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct oob_probe_reply in =3D {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        =2Epriority =3D 10,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        =2Eweight =3D 100,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        =2Econnect_lifetime =3D 30,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D 1,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        =2Emax_latency_diff =
=3D 25,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(in=2Epeer_sess=
ion_id=2Eid, &quot;ABCDEFGH&quot;, SID_SIZE);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_true(oob_probe_reply_write(&amp;buf, &amp;in));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const uint8_t expected[] =3D {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        0x02,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        0x01, /* TLV type 0x201 (not op=
tional) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0=
x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x14, /=
* TLV value length =3D 20 */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        &#39;A&#39;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        &#39;B&#39;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        &#39;C&#39;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        &#39;D&#39;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        &#39;E&#39;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        &#39;F&#39;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        &#39;G&#39;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        &#39;H&#39;,  /* peer_session_id */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        0x00,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        0x0a, /* priority =3D 10 */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x00,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        0x64, /* weight =3D 100=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x00,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x19, /* max_l=
atency_diff =3D 25 */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    0x1e, /* connect_lifetime =3D 30 */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        0x00,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        0x00,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        0x01, /* flags =3D 1 */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(BLEN(&amp;buf), sizeof(expected));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf)=
, expected, sizeof(expected));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* A TLV with a longer-than-known value m=
ust still parse: the known fields are</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * read and the trailing bytes are skipped (forward compa=
tibility)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_p=
arameter_forward_compat(void **state)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const uint16_t extended_len =3D OOB_P=
ROBE_PARAMETER_LEN + 4;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, OOB_TLV_PROBE_PARAM=
ETER, false, extended_len));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(buf_write_u32(&amp;buf, 0));          /* timestamp=
 high */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(buf_write_u32(&amp;buf, 0xdeadbeef)); /* timestamp low */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&a=
mp;buf, 0));          /* flags */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0x11223344)); /* unkn=
own trailing field */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer=
 value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(ctrl_msg_find_tlv(&amp;buf, OOB_TLV_PROBE_PARAMETER, &amp;value));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLE=
N(&amp;value), extended_len);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t oob_probe_parameter out =3D { 0 };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(oob_probe_parameter_read(&amp;value, &amp;=
out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(out=2Etimestamp =3D=3D 0xdeadbeefULL);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(out=2Eflags, 0);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* the unknown trailing field m=
ust have been consumed from the payload */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A value=
 shorter than the mandatory fields must be rejected, even when it</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * holds enough bytes for som=
e of the individual fields to read successfully=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_probe_parameter_too_short(void **state)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
4 of the 12 mandatory value bytes: too short for the timestamp, but</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * enough for a u32 rea=
d to succeed on its own */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_true(buf_write_u32(&amp;buf, 0xdeadbeef));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct oob_probe_parameter out =3D { 0 };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_probe_=
parameter_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* A TLV header claiming more value b=
ytes than the payload holds must be</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * rejected by the scan rather than reported as found -- fo=
r the TLV being</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * l=
ooked for as much as for one that would merely be skipped=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+test_find_tlv_value_truncated(void **st=
ate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new=
();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffe=
r value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* the wanted TLV declares=
 12 value bytes, only 4 are present */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_m=
sg_tlv_write_header(&amp;buf, OOB_TLV_PROBE_PARAMETER, false,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
         OOB_PROBE_PARAMETER_LEN));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0xdeadbeef));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg=
_find_tlv(&amp;buf, OOB_TLV_PROBE_PARAMETER, &amp;value));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* same defect on a TLV that would be skipped: the =
scan must not walk past</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * the end of the payload looking for the next header */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf2 =3D all=
oc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf2, 0x7ff, false, 64)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(b=
uf_write_u32(&amp;buf2, 0));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_false(ctrl_msg_find_tlv(&amp;buf2, OOB_TLV_PROBE_PARAME=
TER, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* Bytes left over after the last TLV that are too few =
for a header make the</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * message malformed, even when the wanted TLV was already found=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+test_find_tlv_trailing_bytes(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* 1 to 3 bytes:=
 less than a 4-byte TLV header */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    for (int trailing =3D 1; trailing &lt;=3D 3; trailing++)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        struct buffer buf =3D allo=
c_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        const struct oob_probe_parameter in =3D { =2Etimestamp =3D 1, =
=2Eflags =3D 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      assert_true(oob_probe_parameter_write(&amp;buf, &amp;in));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &l=
t; trailing; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
assert_true(buf_write_u8(&amp;buf, 0));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        assert_false(ctrl_msg_find_tlv(&amp;buf, OOB_TLV_PROBE_PA=
RAMETER, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* An unknown TLV marked optional after the wanted one is skipped=
, and the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * wanted =
value is still the one returned=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+test_find_tlv_skips_optional_after_wanted(void **state)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D allo=
c_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct buffer value;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
struct oob_probe_parameter in =3D { =2Etimestamp =3D 7, =2Eflags =3D 0 };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_p=
robe_parameter_write(&amp;buf, &amp;in));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0=
x7ff, true, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(buf_write_u32(&amp;buf, 0));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(ctrl_msg_find_tlv(&amp;buf, OOB_TLV_PROBE_PARAMETER, &am=
p;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(BLEN(&amp;value), OOB_PROBE_PARAMETER_LEN);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_parameter out =3D =
{ 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(oob_probe_parameter_read(&amp;value, &amp;out));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(out=2Etimestamp =3D=3D 7)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* An empty payload holds no TLV=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+test_find_tlv_empty_payload(void **state)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(1=
6, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl=
_msg_find_tlv(&amp;buf, OOB_TLV_PROBE_PARAMETER, &amp;value));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Reading =
a TLV header must fail when the buffer holds less data than a</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * complete 4-byte header (empty,=
 or only the type field), rather than read</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * past the available data=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+test_tlv_header_truncated(void **state)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D al=
loc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ct=
rl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* empty buf=
fer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fa=
lse(ctrl_msg_tlv_read_header(&amp;buf, &amp;hdr));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* only the type field present, no length */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u16(&amp=
;buf, OOB_TLV_PROBE_PARAMETER));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_false(ctrl_msg_tlv_read_header(&amp;buf, &amp;hdr))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+main(void)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_test_setup();</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const struct CMUnitTest t=
ests[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 cmocka_unit_test(test_probe_parameter_roundtrip),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_reply_ro=
undtrip),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cm=
ocka_unit_test(test_probe_reply_wire_format),</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_parameter_for=
ward_compat),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  cmocka_unit_test(test_probe_parameter_too_short),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_find_tlv_va=
lue_truncated),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    cmocka_unit_test(test_find_tlv_trailing_bytes),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_find_tlv_sk=
ips_optional_after_wanted),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cmocka_unit_test(test_find_tlv_empty_payload),</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_tl=
v_header_truncated),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return cmocka_run_group_tes=
ts_name(&quot;oob tests&quot;, tests, NULL, NULL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Dem=
ail">change 1741</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1741?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1741 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 16 </div>
<div style=3D"display:none"> Gerrit-Owner=
: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &=
lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici =
&lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--ARgnDrcmB3s=--


--===============1095909249698535584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1095909249698535584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1095909249698535584==--

