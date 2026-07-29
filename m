Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F0BC54F52
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fVhDh1iScwAa1wR4Z9eDR2fm+8seJCTOIWqQXxqjRt8=; b=dTiAJOavtwdkU5j3frsxhS46rT
	QzQpbrSnUsIqTvmEdrQVZImwLbayzNj9K+jlHqdjlFEgpv05J215/9Ff0KFJTevJSthpzscwtieGF
	UC/YvnPUcYj9Xvx9lrqpthsah6N70lM72npGhIIk5Y8pA4C7+uICZi/HNbYkt6KAuED4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp3Jh-0001Fl-Hi;
	Wed, 29 Jul 2026 12:23:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wp3Jd-0001FJ-Du
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=FrCElAajvI5yRFaoOkcfoONcHThAKekBEXDduTUS2AQ=; b=eO3BFAQ2Mdc+UI3wbyBWcpnj7w
 VV4jmUtCBZTYqvEXu7axJaXb1yKZHINRvD1jo77OoqGxzoFU6l2snviNv0leKONmXfLOW2bgqABnp
 dW79fXbNr3ZulN+qDoZA75a96qmBfXboCD0sn6LfxTMC3sLQ1RIvbfH6P97pkcutSJVE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FrCElAajvI5yRFaoOkcfoONcHThAKekBEXDduTUS2AQ=; b=P
 wrBPEh3KWqRnbhDemUBvLlJgq0GclpwV0fh0ETOThLrHt/2a6X9ue0xqRisnnWZIA/i8KiKC7+ozs
 rCENJBgg6OlxF5vnigmKggrKsdifPDfPAn9H22z0Bg/9JmadDt8ucS69TH4csdczud9DKOsDWWD1k
 iT5LXgIIJM57SKxA=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp3Jd-0005L8-1x for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:18 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4955de8797cso5990475e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 05:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785327787; x=1785932587; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FrCElAajvI5yRFaoOkcfoONcHThAKekBEXDduTUS2AQ=;
 b=JIV4u5Waz++FntFB421GHpTYWcqSoA+QWyTi4QIE7kPkbc7xDy+sSV/BmwebQvC9Xg
 zLp4L4N41jPVQ2dVuqvjKJBM0jDRTyL0WKRk0LsUtYdWR3NxWwRxeBWxMULSXyjmTWph
 wjnq1uHwbv8hZcaUeppqekUT9FjHGf1UKukmqKl38NS/Z2+tXkJ366ujQyl8hYSLxv/L
 1ExRk/N7rkhgzHXgobbBt1Y545qUmmnWQIMcccU5KIXFBWIXty2jKiD8R7Na0F1M6ete
 zs4RkgfU82HixbO0LVdg1GpQX9qqYVlqqtTKlkuWAgpL9/hKC3YcI+oAhQ4DrgJltgGd
 wtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785327787; x=1785932587;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FrCElAajvI5yRFaoOkcfoONcHThAKekBEXDduTUS2AQ=;
 b=bCkFTk/bTDiWCJiVTl3MbV4Lg9PKTAYoS8WGW+5+10pnL+RPimxXxmg28BHC32IAkr
 BkHOU+SmdeTQQtBtR8azujlDaatR4g9JpN7x4nAjGQsbGT9qqFMampsagFEYYp5meA3a
 bmybGgWgPpjTd0d9ZSciLuAKIfsfN0g7ki4uWb/QbH+r2ckiKye6rLL7B+paPC/ogWyz
 W2kw1cr4kGiGkW8le8Zvh78Rcxo0lrVXbD+RcMlX3U9HdQxhFh+1axEEJdUFSRf9d7kA
 +PcRgTvCwzD9/9paSYRxPX6AV3YCvrKTKmuWUwXuWZGVnR1eDOOkh092gECUIj+yGerI
 Sitw==
X-Gm-Message-State: AOJu0YyrvkEi3S208Oj48OZu9wAsGiT9+HPtLGCdMQgou0MLGJP2OHwD
 A4DGPdCgF8q0OFJR9E8aWOMo0ioM4nHCDzmhWy+KSS4tpt1+j4SJTLGggOAvVHKfDU8e/IoTyf7
 Mw8G1UnRU8PH60tZM2WxFUw9kYTnI+wmsns4E0LD4PkEu+sXT/ZmxSnnjRYvrDt0SAFxP
X-Gm-Gg: AR+sD116CQ6Ya3b/54IqMebyMS4C3LAWy35bZW/6vdC8eE+ByCoUGeUScLuuoIiqow7
 mnDrBSnY8+a6kwOxTJ6j8DlS0mPXSLjdQg0ImjPBo+IFv9ENPRyzgtPkIy31O2ZoO5WGbknIaSw
 ozs4ybCtf4r8I+JFqlUx17VofUJNk/SQMyAcEGpgCgf7FSkBKBny2hPaiIHTvtrJovG8BTLqV1t
 YZFHJV/DZDL88vD4lszEnfzRiNfXd/GcA+VTxFbx3B0yLaqoskI1g60srwiWNR1/y6VDIcJUFME
 oEU5nbWk17OWzLhYoppHK78EnrgzzSGFRBoUNgI/opl30ljG6vkAm5pWUlwI3MN1UBVSNnyeSGe
 6DnRH/pIzo+aZ82XXfrUpg5pLZtYySSjDS/UDaMzHHdLYF0PfgBRPa/bN/UASdrET9qLms0Fopr
 br2BFYM92YOKKZ0M2KCzbTxRuA9ha3qhdYB6bCRa+aeN9mXdtLipLotwvJiWH5baTZ+p7paxwxY
 VE847xmPWyKgJfjmApsM5hWqFGl1j+jgP6C9AV3slTkvRyYwcehZ95cubejY60FJ5C9tuoXB4KO
 b1CMfV/8fOfrrXcKZIyq8bqRfB5nYJ1eFiQ6t0oQ2xKtQnNTqRnfUmK8G4FPKJkdriOAXyddCg=
 =
X-Received: by 2002:a05:600c:190c:b0:495:495b:9248 with SMTP id
 5b1f17b1804b1-496c653e222mr72746365e9.4.1785327786210; 
 Wed, 29 Jul 2026 05:23:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-497fecfccc7sm32018815e9.12.2026.07.29.05.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:23:05 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 12:22:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: b071e452e7d1711314c2d583ade5ee5d2b21371c
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e7c816b74dcace18a41c2d82544edb04c459e6ce-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wp3Jd-0005L8-1x
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
Content-Type: multipart/mixed; boundary="===============8141231533105380139=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8141231533105380139==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mZYurtwNp64="; charset=UTF-8

--mZYurtwNp64=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, plaisthos, 

I'd like you to reexamine a change=2E Please visit
=

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail

to look at=
 the new patch set (#10)=2E


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
, 739 insertions(+), 4 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/41/1741/10

diff --git a/CMakeLists=2Etxt b/C=
MakeLists=2Etxt
index 7473f15=2E=2Ef4b1b22 100644
--- a/CMakeLists=2Etxt
++=
+ b/CMakeLists=2Etxt
@@ -444,6 +444,8 @@
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
0,6 +522,8 @@
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
@@ -667,6 +671,7 @@
         "test_mbuf"
         "t=
est_misc"
         "test_ncp"
+        "test_oob"
         "test_options_pa=
rse"
         "test_packet_id"
         "test_pkt"
@@ -858,6 +863,13 @@
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
index ff=
8cc54=2E=2Ea67d478 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn=
/Makefile=2Eam
@@ -52,6 +52,7 @@
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
@@ -106,=
6 +107,7 @@
 	pkcs11=2Ec pkcs11=2Eh pkcs11_backend=2Eh \
 	pkcs11_openssl=
=2Ec \
 	pkcs11_mbedtls=2Ec \
+	oob=2Ec oob=2Eh \
 	openvpn=2Ec openvpn=2Eh=
 \
 	options=2Ec options=2Eh \
 	options_util=2Ec options_util=2Eh \
diff -=
-git a/src/openvpn/control_msg=2Ec b/src/openvpn/control_msg=2Ec
new file m=
ode 100644
index 0000000=2E=2E95ff210
--- /dev/null
+++ b/src/openvpn/contr=
ol_msg=2Ec
@@ -0,0 +1,90 @@
+/*
+ *  OpenVPN -- An application to securely =
tunnel IP networks
+ *             over a single TCP/UDP port, with support=
 for SSL/TLS-based
+ *             session authentication and key exchange,=

+ *             packet encryption, packet authentication, and
+ *         =
    packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sal=
es@openvpn=2Enet>
+ *
+ *  This program is free software; you can redistrib=
ute it and/or modify
+ *  it under the terms of the GNU General Public Lice=
nse version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ * =
 This program is distributed in the hope that it will be useful,
+ *  but W=
ITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABIL=
ITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public=
 License for more details=2E
+ *
+ *  You should have received a copy of th=
e GNU General Public License along
+ *  with this program; if not, see <htt=
ps://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "=
config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "control_msg=2Eh"=

+
+bool
+ctrl_msg_read_header(struct buffer *buf, uint16_t expected_msg_ty=
pe)
+{
+    int msg_type =3D buf_read_u16(buf);
+    return msg_type >=3D 0=
 && (uint16_t)msg_type =3D=3D expected_msg_type;
+}
+
+bool
+ctrl_msg_tlv_w=
rite_header(struct buffer *buf, uint16_t type, bool optional, uint16_t valu=
e_len)
+{
+    uint16_t field =3D type & CTRL_MSG_TLV_TYPE_MASK;
+    if (o=
ptional)
+    {
+        field |=3D CTRL_MSG_TLV_OPTIONAL_FLAG;
+    }
+   =
 return buf_write_u16(buf, field) && buf_write_u16(buf, value_len);
+}
+
+b=
ool
+ctrl_msg_tlv_read_header(struct buffer *buf, struct ctrl_msg_tlv_heade=
r *hdr)
+{
+    int field =3D buf_read_u16(buf);
+    if (field < 0)
+    {=

+        return false;
+    }
+    int len =3D buf_read_u16(buf);
+    if =
(len < 0)
+    {
+        return false;
+    }
+    hdr->type =3D (uint16_t=
)(field & CTRL_MSG_TLV_TYPE_MASK);
+    hdr->optional =3D (field & CTRL_MSG=
_TLV_OPTIONAL_FLAG) !=3D 0;
+    hdr->value_len =3D (uint16_t)len;
+    ret=
urn true;
+}
+
+bool
+ctrl_msg_find_tlv(struct buffer *payload, uint16_t wa=
nted_type, struct buffer *value)
+{
+    struct ctrl_msg_tlv_header hdr;
+ =
   while (ctrl_msg_tlv_read_header(payload, &hdr))
+    {
+        /* Take =
the value out of payload=2E This validates that the header's
+         * le=
ngth is really there and advances past it in one step, so the TLV
+        =
 * we are looking for and the ones we skip are bounds-checked alike=2E */
+=
        uint8_t *v =3D buf_read_alloc(payload, hdr=2Evalue_len);
+        i=
f (!v)
+        {
+            return false;
+        }
+        if (hdr=2E=
type =3D=3D wanted_type)
+        {
+            buf_set_read(value, v, hdr=
=2Evalue_len);
+            return true;
+        }
+        /* not the TLV=
 we want: keep scanning */
+    }
+    return false;
+}
diff --git a/src/op=
envpn/control_msg=2Eh b/src/openvpn/control_msg=2Eh
new file mode 100644
in=
dex 0000000=2E=2Ee4c8b54
--- /dev/null
+++ b/src/openvpn/control_msg=2Eh
@@=
 -0,0 +1,101 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP ne=
tworks
+ *             over a single TCP/UDP port, with support for SSL/TLS=
-based
+ *             session authentication and key exchange,
+ *        =
     packet encryption, packet authentication, and
+ *             packet c=
ompression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=
=2Enet>
+ *
+ *  This program is free software; you can redistribute it and=
/or modify
+ *  it under the terms of the GNU General Public License versio=
n 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This prog=
ram is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY=
 WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FIT=
NESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License f=
or more details=2E
+ *
+ *  You should have received a copy of the GNU Gene=
ral Public License along
+ *  with this program; if not, see <https://www=
=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @file
+ * Framing shared by the =
TLV-based control messages of the wire protocol=2E
+ *
+ * Such a message p=
ayload starts with a 16-bit message type, followed by a
+ * sequence of TLV=
 entries=2E Each TLV starts with a 4-byte header: a 16-bit field
+ * whose =
most significant bit is the "optional" flag and whose remaining 15 bits
+ *=
 are the type, followed by a 16-bit length giving the size of the value tha=
t
+ * follows the header=2E
+ *
+ * The message-type and TLV-type values th=
emselves are specific to the message
+ * family carried (out-of-band messag=
es define theirs in oob=2Eh), so only the
+ * framing lives here=2E
+ */
+
=
+#ifndef CONTROL_MSG_H
+#define CONTROL_MSG_H
+
+#include "buffer=2Eh"
+
+/=
* TLV header bit layout of the first 16-bit field */
+#define CTRL_MSG_TLV_=
OPTIONAL_FLAG 0x8000
+#define CTRL_MSG_TLV_TYPE_MASK     0x7fff
+
+/* The h=
eader every TLV carries: the 15-bit type and optional flag packed into
+ * =
the first 16-bit field, then the length of the value that follows=2E */
+st=
ruct ctrl_msg_tlv_header
+{
+    uint16_t type;      /**< the 15-bit TLV ty=
pe */
+    bool optional;      /**< value of the optional flag */
+    uint=
16_t value_len; /**< length of the value following the header */
+};
+
+/**=

+ * Read and verify a message-type header from buf, advancing past it=2E
+=
 *
+ * @param buf                buffer positioned at the message payload
+=
 * @param expected_msg_type  the message type the payload must carry
+ * @r=
eturn true if a message type was read and equals expected_msg_type,
+ *    =
     false on a short buffer or a mismatching type=2E
+ */
+bool ctrl_msg_r=
ead_header(struct buffer *buf, uint16_t expected_msg_type);
+
+/**
+ * Writ=
e a TLV header (type + optional flag + value length) to buf=2E
+ *
+ * @ret=
urn true on success, false if buf has insufficient space=2E
+ */
+bool ctrl=
_msg_tlv_write_header(struct buffer *buf, uint16_t type, bool optional,
+  =
                             uint16_t value_len);
+
+/**
+ * Read a TLV hea=
der from buf, advancing past it=2E
+ *
+ * @param buf  buffer positioned at=
 the TLV header
+ * @param hdr  filled with the type, optional flag and val=
ue length on success
+ * @return true on success, false if there are not en=
ough bytes for a header=2E
+ */
+bool ctrl_msg_tlv_read_header(struct buffe=
r *buf, struct ctrl_msg_tlv_header *hdr);
+
+/**
+ * Scan payload for the f=
irst TLV of type wanted_type, skipping any other (e=2Eg=2E
+ * future) TLV =
types=2E
+ *
+ * On success value covers exactly the found TLV's value byte=
s=2E The length from
+ * each TLV header is validated against payload as th=
e scan goes, so the whole
+ * value is guaranteed to be present; a header c=
laiming more bytes than payload
+ * holds is rejected rather than reported =
as found=2E payload is consumed as it is
+ * read=2E
+ *
+ * @param payload=
      buffer positioned at a TLV header
+ * @param wanted_type  the TLV typ=
e to look for
+ * @param value        set to a buffer covering the found TL=
V's value
+ * @return true if the TLV was found, false if it is not present=
 or a TLV
+ *         header or value is malformed or truncated=2E
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

index 60df7ce=2E=2E9e1a6aa 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/open=
vpn/ssl=2Ec
@@ -3616,7 +3616,7 @@
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
index f8444451=2E=2E0d882d9 100644
--- a/src/openvpn/ssl_pkt=
=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -166,7 +166,7 @@
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
index 82cb5b1=2E=2E25e50bf 100644
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
@@ -264,6 +306,9 =
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
index d861ef9=2E=2E611097a 100644
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
50,6 +151,20 @@
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
0
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

--mZYurtwNp64=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>stipa <strong>uplo=
aded patch set #10</strong> to this change=2E</p><p><a href=3D"http://gerri=
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
1 files changed, 739 insertions(+), 4 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/174=
1/10</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><sp=
an>index 7473f15=2E=2Ef4b1b22 100644</span><br><span>--- a/CMakeLists=2Etxt=
</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -444,6 +444,8 @@=
</span><br><span>     src/openvpn/console=2Ec</span><br><span>     src/open=
vpn/console_builtin=2Ec</span><br><span>     src/openvpn/console=2Eh</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/control_ms=
g=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvp=
n/control_msg=2Eh</span><br><span>     src/openvpn/crypto=2Ec</span><br><sp=
an>     src/openvpn/crypto=2Eh</span><br><span>     src/openvpn/crypto_back=
end=2Eh</span><br><span>@@ -520,6 +522,8 @@</span><br><span>     src/openvp=
n/multi_io=2Ec</span><br><span>     src/openvpn/occ=2Ec</span><br><span>   =
  src/openvpn/occ=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    src/openvpn/oob=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    src/openvpn/oob=2Eh</span><br><span>     src/openvpn/openvpn=2Ec<=
/span><br><span>     src/openvpn/openvpn=2Eh</span><br><span>     src/openv=
pn/openvpn_win32_resources=2Erc</span><br><span>@@ -667,6 +671,7 @@</span><=
br><span>         &quot;test_mbuf&quot;</span><br><span>         &quot;test=
_misc&quot;</span><br><span>         &quot;test_ncp&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        &quot;test_oob&quot;</span><b=
r><span>         &quot;test_options_parse&quot;</span><br><span>         &q=
uot;test_packet_id&quot;</span><br><span>         &quot;test_pkt&quot;</spa=
n><br><span>@@ -858,6 +863,13 @@</span><br><span>         src/openvpn/sessi=
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
<br><span>index ff8cc54=2E=2Ea67d478 100644</span><br><span>--- a/src/openv=
pn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br>=
<span>@@ -52,6 +52,7 @@</span><br><span> 	common=2Eh \</span><br><span> 	co=
mp=2Ec comp=2Eh compstub=2Ec \</span><br><span> 	comp-lz4=2Ec comp-lz4=2Eh =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	control_msg=2Ec c=
ontrol_msg=2Eh \</span><br><span> 	crypto=2Ec crypto=2Eh crypto_backend=2Eh=
 \</span><br><span> 	crypto_openssl=2Ec crypto_openssl=2Eh \</span><br><spa=
n> 	crypto_mbedtls_legacy=2Ec crypto_mbedtls_legacy=2Eh \</span><br><span>@=
@ -106,6 +107,7 @@</span><br><span> 	pkcs11=2Ec pkcs11=2Eh pkcs11_backend=
=2Eh \</span><br><span> 	pkcs11_openssl=2Ec \</span><br><span> 	pkcs11_mbed=
tls=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	oob=2Ec o=
ob=2Eh \</span><br><span> 	openvpn=2Ec openvpn=2Eh \</span><br><span> 	opti=
ons=2Ec options=2Eh \</span><br><span> 	options_util=2Ec options_util=2Eh \=
</span><br><span>diff --git a/src/openvpn/control_msg=2Ec b/src/openvpn/con=
trol_msg=2Ec</span><br><span>new file mode 100644</span><br><span>index 000=
0000=2E=2E95ff210</span><br><span>--- /dev/null</span><br><span>+++ b/src/o=
penvpn/control_msg=2Ec</span><br><span>@@ -0,0 +1,90 @@</span><br><span sty=
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
=3D"color: hsl(120, 100%, 40%);">+    while (ctrl_msg_tlv_read_header(paylo=
ad, &amp;hdr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Take the=
 value out of payload=2E This validates that the header&#39;s</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+         * length is really there=
 and advances past it in one step, so the TLV</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         * we are looking for and the ones we ski=
p are bounds-checked alike=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        uint8_t *v =3D buf_read_alloc(payload, hdr=2Evalue_len=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!v)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            return false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (hdr=2Etype =3D=3D wante=
d_type)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_set_re=
ad(value, v, hdr=2Evalue_len);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            return true;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        /* not the TLV we want: keep scanning */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/control_msg=
=2Eh b/src/openvpn/control_msg=2Eh</span><br><span>new file mode 100644</sp=
an><br><span>index 0000000=2E=2Ee4c8b54</span><br><span>--- /dev/null</span=
><br><span>+++ b/src/openvpn/control_msg=2Eh</span><br><span>@@ -0,0 +1,101=
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
r><span style=3D"color: hsl(120, 100%, 40%);">+ * Framing shared by the TLV=
-based control messages of the wire protocol=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Such a message payload starts with a 16-bit message type, fol=
lowed by a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * sequen=
ce of TLV entries=2E Each TLV starts with a 4-byte header: a 16-bit field</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * whose most signifi=
cant bit is the &quot;optional&quot; flag and whose remaining 15 bits</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * are the type, followed=
 by a 16-bit length giving the size of the value that</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * follows the header=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * The message-type and TLV-type values themselves ar=
e specific to the message</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * family carried (out-of-band messages define theirs in oob=2Eh), so=
 only the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * framing=
 lives here=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifndef CONTROL_MSG_H</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define CONTROL_MSG_H</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* TLV header bit layout of the first 16-bit field */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define CTRL_MSG_TLV_OPTIO=
NAL_FLAG 0x8000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine CTRL_MSG_TLV_TYPE_MASK     0x7fff</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* The header every TLV carries: the 15-bit type and optional flag packed in=
to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the first 16-b=
it field, then the length of the value that follows=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+struct ctrl_msg_tlv_header</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    uint16_t type;      /**&lt; the 15-bit TLV t=
ype */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool opti=
onal;      /**&lt; value of the optional flag */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    uint16_t value_len; /**&lt; length of the =
value following the header */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
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
 style=3D"color: hsl(120, 100%, 40%);">+ * Scan payload for the first TLV o=
f type wanted_type, skipping any other (e=2Eg=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * future) TLV types=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * On success value covers exactly the found TLV&#39;s val=
ue bytes=2E The length from</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * each TLV header is validated against payload as the scan goes, s=
o the whole</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * value=
 is guaranteed to be present; a header claiming more bytes than payload</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * holds is rejected ra=
ther than reported as found=2E payload is consumed as it is</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * read=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param payload      buffer positioned at a TLV header</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param wanted_type  t=
he TLV type to look for</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param value        set to a buffer covering the found TLV&#39;s val=
ue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true i=
f the TLV was found, false if it is not present or a TLV</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *         header or value is malforme=
d or truncated=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_find=
_tlv(struct buffer *payload, uint16_t wanted_type, struct buffer *value);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef CONTROL_MSG_H */</span>=
<br><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br>=
<span>new file mode 100644</span><br><span>index 0000000=2E=2Ec807171</span=
><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/oob=2Ec</span><b=
r><span>@@ -0,0 +1,83 @@</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN =
-- An application to securely tunnel IP networks</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, wit=
h support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             session authentication and key exchange,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryptio=
n, packet authentication, and</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *             packet compression=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software;=
 you can redistribute it and/or modify</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  it under the terms of the GNU General Public License=
 version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as pu=
blished by the Free Software Foundation=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  This program is distributed in the hope that it will be useful,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY W=
ARRANTY; without even the implied warranty of</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR P=
URPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  GNU General Public License for more details=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  You should have received a copy of the GNU General Public =
License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  wi=
th this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;oob=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;control_msg=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_pa=
rameter_write(struct buffer *buf, const struct oob_probe_parameter *p)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return ctrl_msg_tlv_write_header(buf,=
 OOB_TLV_PROBE_PARAMETER, false, OOB_PROBE_PARAMETER_LEN)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u64(b=
uf, p-&gt;timestamp)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+           &amp;&amp; buf_write_u32(buf, p-&gt;flags);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
ool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_parame=
ter_read(struct buffer *buf, struct oob_probe_parameter *p)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* One bounds check covers the whole value: every=
 field read below then fits</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * by construction (OOB_PROBE_PARAMETER_LEN is the sum of their=
 sizes), so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * n=
one of them needs its own error handling=2E Trailing bytes this version</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * does not underst=
and are simply left unread=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (buf_len(buf) &lt; OOB_PROBE_PARAMETER_LEN)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    p-&gt;timestamp =3D buf_read_u64(buf, NULL);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    p-&gt;flags =3D buf_re=
ad_u32(buf, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+oob_probe_reply_write(struct buffer *buf, const struct o=
ob_probe_reply *r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ctrl_msg=
_tlv_write_header(buf, OOB_TLV_PROBE_REPLY, false, OOB_PROBE_REPLY_LEN)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; s=
ession_id_write(&amp;r-&gt;peer_session_id, buf)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16(buf, r-&gt=
;priority)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
  &amp;&amp; buf_write_u16(buf, r-&gt;weight)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16(buf, r-&gt;ma=
x_latency_diff)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
       &amp;&amp; buf_write_u16(buf, r-&gt;connect_lifetime)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u3=
2(buf, r-&gt;flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+oob_probe_reply_read(struct buffer *buf, struct oob=
_probe_reply *r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* One bounds che=
ck for the whole value, as in oob_probe_parameter_read()=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(buf) &lt; OOB_PR=
OBE_REPLY_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fals=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    session_id_read(&amp;r-&gt;=
peer_session_id, buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    r-&gt;priority =3D (uint16_t)buf_read_u16(buf);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    r-&gt;weight =3D (uint16_t)buf_read_=
u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;=
max_latency_diff =3D (uint16_t)buf_read_u16(buf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    r-&gt;connect_lifetime =3D (uint16_t)buf_=
read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
-&gt;flags =3D buf_read_u32(buf, NULL);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/o=
penvpn/oob=2Eh</span><br><span>new file mode 100644</span><br><span>index 0=
000000=2E=2E0a9a4bb</span><br><span>--- /dev/null</span><br><span>+++ b/src=
/openvpn/oob=2Eh</span><br><span>@@ -0,0 +1,110 @@</span><br><span style=3D=
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
=2E=2E=2E) followed by a sequence of TLV entries in the</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * 0x2xx type space=2E The framing itse=
lf is shared with the other TLV-based</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * control messages of the wire protocol and lives in con=
trol_msg=2Eh; this file</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * defines the OOB message and TLV types, their values, and the OOB-spe=
cific</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * decisions t=
aken on them=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#ifndef OOB_H</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define OOB_H</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;session_id=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* OOB message types: the 16-bit value at the start of an OO=
B payload, before</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 its TLV entries=2E Distinct from the TLV-type space (0x2xx); see the &quot=
;Messages&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * t=
able in the OOB section of the wire protocol spec=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define OOB_MSG_SERVER_PROBE 0x100</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_MSG_PROBE_RE=
PLY  0x101</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* TLV types (see the OOB co=
ntrol message section of the wire protocol spec) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define OOB_TLV_PROBE_PARAMETER 0x200</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_TLV_PROBE_R=
EPLY     0x201</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Minimum on-wire value=
 length (excluding the 4-byte TLV header) of each TLV:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * the sizes of its fixed fields in wire=
 order (see the structs below)=2E The</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * value may be longer for forward compatibility; trailin=
g bytes that are not</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * understood are ignored on read=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define OOB_PROBE_PARAMETER_LEN \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    ((uint16_t)(sizeof(uint64_t) /* time=
stamp */ + sizeof(uint32_t) /* flags */))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define OOB_PROBE_REPLY_LEN                          =
         \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ((uin=
t16_t)(SID_SIZE               /* peer_session_id */  \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                + 4 * sizeof(uint16_t) /=
* priority, weight,   \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                        * max_latency_diff,   \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
             * connect_lifetime */ \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                + sizeof(uint32_t)))   /* flags */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* probe parameter TLV (sent by the client in =
a SERVER_PROBE) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
truct oob_probe_parameter</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t=
 timestamp; /**&lt; client clock as a UNIX timestamp */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    uint32_t flags;     /**&lt; client =
capability flags, currently must be 0 */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* probe reply =
TLV (sent by the server in a PROBE_REPLY) */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+struct oob_probe_reply</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct session_id peer_session_id; /**&lt; echoes the session=
 id of the request */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    uint16_t priority;                 /**&lt; DNS-SRV style priority (lo=
wer is preferred) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    uint16_t weight;                   /**&lt; DNS-SRV style weight */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t max_latenc=
y_diff;         /**&lt; advertised candidate-band margin in ms;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
         *   0 means &quot;defer to the client&#39;s setting&quot; */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t connect_life=
time;         /**&lt; seconds the reply stays valid as the handshake reset =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t flag=
s;                    /**&lt; server behaviour flags */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a compl=
ete probe parameter TLV (header + value) to buf=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool oob_probe_parameter_write(struct buffer *buf, const str=
uct oob_probe_parameter *p);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read a probe parameter =
TLV value from buf=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * buf must cov=
er exactly the TLV&#39;s value, as returned by ctrl_msg_find_tlv()=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Trailing bytes beyond =
the fields understood here are ignored, so a longer</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * value from a future version still pars=
es=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, fal=
se if buf is shorter than the mandatory fields=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+bool oob_probe_parameter_read(struct buffer *buf, struct oob_=
probe_parameter *p);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Write a complete probe reply TL=
V (header + value) to buf=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oo=
b_probe_reply_write(struct buffer *buf, const struct oob_probe_reply *r);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Read a probe reply TLV value from buf=2E See oob_prob=
e_parameter_read() for the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * calling convention=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool=
 oob_probe_reply_read(struct buffer *buf, struct oob_probe_reply *r);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif /* OOB_H */</span><br><span>diff --gi=
t a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 60df7ce=
=2E=2E9e1a6aa 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><s=
pan>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -3616,7 +3616,7 @@</span><=
br><span>     struct session_id sid; /* remote session ID */</span><br><spa=
n> </span><br><span>     /* verify legal opcode */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (op &lt; P_FIRST_OPCODE || op &gt; P_LA=
ST_OPCODE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!=
opcode_valid_in_session(op))</span><br><span>     {</span><br><span>       =
  if (op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_=
RESET_SERVER_V1)</span><br><span>         {</span><br><span>diff --git a/sr=
c/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>index f8444=
451=2E=2E0d882d9 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span=
><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -166,7 +166,7 @=
@</span><br><span>                    bool prepend_ack)</span><br><span> {<=
/span><br><span>     ASSERT(ks-&gt;key_id &gt;=3D 0 &amp;&amp; ks-&gt;key_i=
d &lt;=3D P_KEY_ID_MASK);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    ASSERT(opcode &gt;=3D 0 &amp;&amp; opcode &lt;=3D P_LAST_OPCODE);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(opcode_val=
id_in_session(opcode));</span><br><span>     uint8_t header =3D (uint8_t)(k=
s-&gt;key_id | (opcode &lt;&lt; P_OPCODE_SHIFT));</span><br><span> </span><=
br><span>     /* Workaround for Softether servers=2E Softether has a bug th=
at it only</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openv=
pn/ssl_pkt=2Eh</span><br><span>index 82cb5b1=2E=2E25e50bf 100644</span><br>=
<span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_p=
kt=2Eh</span><br><span>@@ -58,11 +58,53 @@</span><br><span>  * like P_CONTR=
OL_HARD_RESET_CLIENT_V3 */</span><br><span> #define P_CONTROL_WKC_V1 11</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* defi=
ne the range of legal opcodes</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* Out-of-band control message that does not belong to an establi=
shed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * control chan=
nel session (e=2Eg=2E a server probe)=2E Inherently unreliable:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * there is no protocol-level r=
etransmission=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * It is not legal o=
n an established session; see opcode_valid_in_session()</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * below=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define P_CONTROL_OOB_V1 12</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* define the range of defined opcodes, in- and out-of-=
band=2E Note this is not</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * the set of opcodes legal on an established session; see</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * opcode_valid_in_session()=2E=
</span><br><span>  * Since we do no longer support key-method 1 we consider=
</span><br><span>  * the v1 op codes invalid */</span><br><span> #define P_=
FIRST_OPCODE 3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 P_LAST_OPCODE  11</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define P_LAST_OPCODE  12</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline =
bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+opcode_is_oob(i=
nt op)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return op =3D=3D P_CONTROL_=
OOB_V1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * Return true if op may occur on an established control-channel =
session=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Out-of-band opcodes may=
 not=2E They are answered statelessly on the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * new-connection path, and being rejected here is=
 a permanent property rather</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * than a handler that is still missing:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  - an OOB message carries its TLV payload directly, with no=
 reliability or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
  ACK fields (see tls_wrap_oob_standalone()), whereas the established-sessi=
on</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    path parses=
 an ACK array and a control packet-id before anything else=2E The</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *    payload is chosen by th=
e sender and session ids are plaintext on the wire,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *    so those bytes can be crafted into =
a valid ACK array, forging ACKs into a</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *    live control channel and stalling a handshake or r=
ekey=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  - nothin=
g on that path parses an OOB payload, so there is nothing to gain by</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *    accepting one=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * This cannot be expressed as an opcode=
 range: the inband CONTROL_DATA_V1 of the</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * wire protocol is legal on an established session, =
so the OOB opcodes sit</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * between legal ones=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static i=
nline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+opcode_va=
lid_in_session(int op)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return op &=
gt;=3D P_FIRST_OPCODE &amp;&amp; op &lt;=3D P_LAST_OPCODE &amp;&amp; !opcod=
e_is_oob(op);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span> </span><br><span> /*</span><br><span>  * Define number of buff=
ers for send and receive in the reliability layer=2E</span><br><span>@@ -26=
4,6 +306,9 @@</span><br><span>         case P_CONTROL_WKC_V1:</span><br><sp=
an>             return &quot;P_CONTROL_WKC_V1&quot;;</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        case P_CONTROL_O=
OB_V1:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            r=
eturn &quot;P_CONTROL_OOB_V1&quot;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span>         case P_ACK_V1:</span><br><span>  =
           return &quot;P_ACK_V1&quot;;</span><br><span> </span><br><span>d=
iff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openv=
pn/Makefile=2Eam</span><br><span>index d861ef9=2E=2E611097a 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/=
tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -14,6 +14,7 @@</s=
pan><br><span> 	ncp_testdriver \</span><br><span> 	mbuf_testdriver \</span>=
<br><span> 	misc_testdriver \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	oob_testdriver \</span><br><span> 	options_parse_testdriver \</s=
pan><br><span> 	packet_id_testdriver \</span><br><span> 	pkt_testdriver \</=
span><br><span>@@ -150,6 +151,20 @@</span><br><span> 	$(top_srcdir)/src/ope=
nvpn/win32-util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/session_i=
d=2Ec</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+oob_testdriver_CFLAGS  =3D \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_sr=
cdir)/src/openvpn \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	@TEST_CFLAGS@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_t=
estdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+oob_testdriver_SOURCES =3D test_oob=2Ec \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	mock_msg=2Ec mock_msg=2Eh test_comm=
on=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_get_r=
andom=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_s=
rcdir)/src/openvpn/buffer=2Ec \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	$(top_srcdir)/src/openvpn/control_msg=2Ec \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/oob=2Ec \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/op=
envpn/platform=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	$(top_srcdir)/src/openvpn/session_id=2Ec \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/win32-util=2Ec</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> pkt_testdr=
iver_CFLAGS  =3D \</span><br><span> 	-I$(top_srcdir)/include -I$(top_srcdir=
)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span> 	@TEST_CFLAGS@<=
/span><br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/=
unit_tests/openvpn/test_oob=2Ec</span><br><span>new file mode 100644</span>=
<br><span>index 0000000=2E=2Eaa4eb23</span><br><span>--- /dev/null</span><b=
r><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>@@ -0,0=
 +1,277 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span>=
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
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdarg=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &l=
t;stddef=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &lt;setjmp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;control_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;oob=2Eh&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;test_common=2Eh&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* Write a probe parameter TLV and read it back; fields m=
ust survive the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * r=
ound trip and the whole buffer must be consumed=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_probe_parameter_roundtrip(void **state)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
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
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Reading a TLV header m=
ust fail when the buffer holds less data than a</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * complete 4-byte header (empty, or only the t=
ype field), rather than read</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * past the available data=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+test_tlv_header_truncated(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(12=
8, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_he=
ader hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* empty buffer */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_=
tlv_read_header(&amp;buf, &amp;hdr));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* only the type field present, no length */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(buf_write_u16(&amp;buf, OOB_TLV=
_PROBE_PARAMETER));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_false(ctrl_msg_tlv_read_header(&amp;buf, &amp;hdr));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+main(void)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    openvpn_unit_test_setup();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct CMUnitTest tests[] =3D {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit=
_test(test_probe_parameter_roundtrip),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        cmocka_unit_test(test_probe_reply_roundtrip),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_te=
st(test_probe_reply_wire_format),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        cmocka_unit_test(test_probe_parameter_forward_compat)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_uni=
t_test(test_probe_parameter_too_short),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        cmocka_unit_test(test_find_tlv_value_truncated)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_uni=
t_test(test_tlv_header_truncated),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return cmocka=
_run_group_tests_name(&quot;oob tests&quot;, tests, NULL, NULL);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1741?usp=3Demail">change 1741</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1741?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpa=
tchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1741 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none">=
 Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--mZYurtwNp64=--


--===============8141231533105380139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8141231533105380139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8141231533105380139==--

