Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70F1C43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RciFQVLB1xs3Ii+razhBdKsbvvpaL0RCEcTchD7g/Kg=; b=ZaSaKjBBlRJZokzWDDnEjWVFvb
	B7DTVM/AeWpnks4X89fx68vdLpgA6S6IxtUrWljyMszn6vuw1/fqlGlbKVUgVf7yc6sXgTcOsYW+T
	9asBg6tVH3udFuui+OJOlpjF0twQuv3nTXonG7IouF5AA4rwt6Em+6nlZ665hq0gPXho=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whr3v-0007WW-FF;
	Thu, 09 Jul 2026 15:53:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1whr3t-0007WH-Pz
 for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:53:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0BMmT8gbF921v5p0rVyjL/U4YE01iApVvupzYLiPx3I=; b=dS27/Oz9rKHJPWIjHst92UIHzj
 CqV8VevoTzlVFlWW72PgRvRtM9reeVBdZZc48xe1Z0DL8kQlLw1owfTF2Ubq9AF8qVnfiuk59VsfD
 c4PdoiN71K0e6lFnb8mt0Db1ywmocpfvYabuqT6nYLhUaQ7hLqHL7NMNWs5vTGGvIJDw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0BMmT8gbF921v5p0rVyjL/U4YE01iApVvupzYLiPx3I=; b=Q
 5G8E7UaB6QE+CVLm8cxcT3v1jQJ7pWfsIUPCfuc5pq6wIe0K+eiRgmgs+p3DAL1iZo68Jzj+VQDiH
 ZE5qhoH/zTvdVxPiQqQ9tSn171mU5lXohdrCgMEMt32KL90AInQ7vYlZ1fKf7YIdQ2vYTgAvAQ8Fo
 8qn+6cfm92JZwOOU=;
Received: from mail-ed1-f51.google.com ([209.85.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1whr3q-0001g6-Rd for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:53:18 +0000
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-698ab9aae16so3767444a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 09 Jul 2026 08:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783612388; x=1784217188; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0BMmT8gbF921v5p0rVyjL/U4YE01iApVvupzYLiPx3I=;
 b=NFPnP+eCPlDbuSRn7tgbkHxGRE1+X4ZASfV+MbUFeGrQMqjyJae96wNk3y3sYlDQ3B
 dGfHYBdzeSRuBW+KkPVWtruKInFlgVyeOyigNQ7MP569pqvlqXXHrMLi+7z3Sb4koKcn
 EnKm+IOfTG+2uGfRiKwRuid0p5AHY9r/NMTofiHhSeTi3ZSTEDlHsdSVep6DsVxnknCI
 J2KAvchrT9AsmPI7CApyIZvsIBujdBN/Jw9aZogcplsRLSKXZhyDIF/63m8xqHfpY5C4
 dSApeH215VVQWYyxnmX6MDQU0MJeqUWnnijCv2kiVgJKh4YTis75a5zDjWBxlpnhrqvD
 rBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783612388; x=1784217188;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0BMmT8gbF921v5p0rVyjL/U4YE01iApVvupzYLiPx3I=;
 b=ByPLlnhqP+SBefqq1SLMi5T4GjuoeceTs3ErM41FtOjD3zumkICSM3lmbVrfqNCq5O
 iyTI/OoPpFKJHn0GNN9jRqwPkPt4ecJDKs+glxua9zhE8J9ouuAbVYlpX1VAxV1hXW6d
 CWcmevCA4RwvG18jPwsbURe1/UudBJlJvvkkdhfjaejzNO08VYawklvXO17u4KgCJ/X/
 FJz6TrQMbdqMozHE5UbT/c2j6hoQmMnZIICYVrBLrGjzGWSuvxOx0xtXfXvcjFCCSBLN
 0WziAtRJp2NDWoTZ2r5HXBMkdsCAvYiiNaY6HrFHAu/AiTp2kBteRBgVpW3XIgMcO24m
 hnDw==
X-Gm-Message-State: AOJu0YwZgtnL6EUR5gzM3JKBWncKF0ACyiQ5kmQ26T7xGGbkwaj84Jlk
 Gej/T+niEEVX+b2Z8QRiOUSpX1hV+I7l+lCrH5Tv5dv/MluwhKO6pogQALEVE1rYiemwWTzw+Je
 Qmgj1detA6rQhhW6fqiBShvu9v5viaEe81OpSka129KxkWquQ7bXGmAT9s1qYCAMK/fklecxy5B
 GPTsW+Aw==
X-Gm-Gg: AfdE7cmh0I1x5XDeQK5CfVRLrenYkO1wz3Z2WImQybaxJicfTKBpCQF8qz7lExaHYmK
 moXz4lIgM6xPMZ9nIceqwdCMGi/q+X+MzJGCmpuP1A3eiiBJehvZ4X8EDb43NhSCPwMeCLFVfJm
 TXN70V0GlihZdGFaLn1Yi2svuAkQ7BNRarifUSbmBf3nkzqv5IkTTh4ECKyW+i2ELeqJLIwXonF
 DMwWJDWNhx31ENMdYh24qCvMb0TU2pgRLMrGaAcpUNe1VLXbBuDJfcLbwmwQb0oPfOr2JkVrJq+
 rtbEAQAFnnnKoMNlXyfHhpJFX9m4YhahtlOf4H6zHzCtwdSAMeId8XupvYOZ9anhljr2gWFJdOu
 4PUQn1dUNR/yinDHFpjfGGW3UkVpfpiLKbZ0KNPJQoDW8uRFdoWfKJDPrIIofLkfBGr/hPs/92l
 N5Y8/Cyw1MJNF3EWKh1RUg7TjKFlJWTVlt+i3N5Ng0/2F2ipFnDtQ+sZohBPUyLi4qdW8TFGS6y
 rejIWYo5u/TbBGKnvMe8KDQChSzuJAMAnwaxSGU8tkIohKVHEmsjW1AiIwUx/XQUIb3KMPIzHHe
 Rc8=
X-Received: by 2002:a05:600c:3515:b0:493:bc92:2a2f with SMTP id
 5b1f17b1804b1-493e6894936mr75538405e9.1.1783604851287; 
 Thu, 09 Jul 2026 06:47:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f3b85sm104198095e9.2.2026.07.09.06.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 06:47:30 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 9 Jul 2026 13:47:21 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 225628306ecc72d5b7b06c16d88ac5f271e56b89
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <af01b6e8cb5339dccfc147bf5ceace8275df2670-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1whr3q-0001g6-Rd
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
Content-Type: multipart/mixed; boundary="===============5625345121493448936=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5625345121493448936==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QDuqoNoUhig="; charset=UTF-8

--QDuqoNoUhig=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

He=
llo flichtenheld, plaisthos, 

I'd like you to reexamine a change=2E Please=
 visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail

to =
look at the new patch set (#4)=2E

The following approvals got outdated and=
 were removed:
Code-Review-1 by flichtenheld


Change subject: oob: Add con=
trol message TLV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add control message TLV encoding (P_CO=
NTROL_OOB_V1)

Reserve opcode 12 (P_CONTROL_OOB_V1) for out-of-band control=
 messages and
add encoding/decoding for the SERVER_PROBE / PROBE_REPLY TLVs=
 used for
server latency checks:

  - probe_parameter (0x200): client times=
tamp + capability flags
  - probe_reply    (0x201): echoed session id, DNS-=
SRV style priority and
                            weight, connect_lifetime=
 and behaviour flags

Each TLV has a 4-byte header (15-bit type plus an opt=
ional flag, then a
16-bit value length)=2E Readers enforce the minimum valu=
e length and skip
trailing bytes they do not understand, so the format stay=
s forward
compatible and multi-TLV framing resynchronises=2E

P_LAST_OPCODE=
 is deliberately left at 11: opcode 12 is not yet accepted by
tls_pre_decry=
pt()=2E The legal-opcode range is widened together with the
receive handler=
 in a follow-up, which also wires oob=2Ec into the openvpn
build=2E For now=
 the codec is exercised only by the unit tests=2E

See the OOB control mess=
age section of the OpenVPN wire protocol
specification (openvpn-rfc PR #30)=
=2E

Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Signed-off-by: Le=
v Stipakov <lev@openvpn=2Enet>
---
M CMakeLists=2Etxt
M src/openvpn/Makefil=
e=2Eam
A src/openvpn/oob=2Ec
A src/openvpn/oob=2Eh
M src/openvpn/ssl_pkt=2E=
h
M tests/unit_tests/openvpn/Makefile=2Eam
A tests/unit_tests/openvpn/test_=
oob=2Ec
7 files changed, 567 insertions(+), 0 deletions(-)


  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1741/4

diff --git =
a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 8de836a=2E=2E608e39e4 100644
--=
- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -518,6 +518,8 @@
     src/op=
envpn/multi_io=2Ec
     src/openvpn/occ=2Ec
     src/openvpn/occ=2Eh
+    s=
rc/openvpn/oob=2Ec
+    src/openvpn/oob=2Eh
     src/openvpn/openvpn=2Ec
  =
   src/openvpn/openvpn=2Eh
     src/openvpn/openvpn_win32_resources=2Erc
@@=
 -665,6 +667,7 @@
         "test_mbuf"
         "test_misc"
         "test_=
ncp"
+        "test_oob"
         "test_options_parse"
         "test_packe=
t_id"
         "test_pkt"
@@ -855,6 +858,12 @@
         src/openvpn/session=
_id=2Ec
         )
 
+    target_sources(test_oob PRIVATE
+        tests/un=
it_tests/openvpn/mock_get_random=2Ec
+        src/openvpn/oob=2Ec
+        =
src/openvpn/session_id=2Ec
+        )
+
     target_sources(test_pkt PRIVAT=
E
         tests/unit_tests/openvpn/mock_win32_execve=2Ec
         src/open=
vpn/argv=2Ec
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=
=2Eam
index ff8cc54=2E=2Eb4b1b92 100644
--- a/src/openvpn/Makefile=2Eam
+++=
 b/src/openvpn/Makefile=2Eam
@@ -106,6 +106,7 @@
 	pkcs11=2Ec pkcs11=2Eh pk=
cs11_backend=2Eh \
 	pkcs11_openssl=2Ec \
 	pkcs11_mbedtls=2Ec \
+	oob=2Ec =
oob=2Eh \
 	openvpn=2Ec openvpn=2Eh \
 	options=2Ec options=2Eh \
 	options=
_util=2Ec options_util=2Eh \
diff --git a/src/openvpn/oob=2Ec b/src/openvpn=
/oob=2Ec
new file mode 100644
index 0000000=2E=2Eb01f4ee
--- /dev/null
+++ =
b/src/openvpn/oob=2Ec
@@ -0,0 +1,168 @@
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
+#ifdef HAVE_CONFIG_H=

+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "oob=
=2Eh"
+
+/**
+ * Consume @p value_len bytes of TLV value, of which @p consu=
med have already
+ * been read, ignoring (skipping) any trailing bytes that=
 this version does
+ * not understand=2E
+ *
+ * @param buf        buffer p=
ositioned after the @p consumed value bytes
+ * @param value_len  the TLV's=
 declared value length
+ * @param consumed   number of value bytes already =
read from @p buf
+ * @return true on success, false if fewer than @p consum=
ed bytes were
+ *         declared or @p buf does not hold the trailing byt=
es=2E
+ */
+static bool
+oob_skip_trailing(struct buffer *buf, uint16_t val=
ue_len, int consumed)
+{
+    if (value_len < consumed)
+    {
+        ret=
urn false;
+    }
+    return buf_advance(buf, value_len - consumed);
+}
+
=
+bool
+oob_msg_write_header(struct buffer *buf, uint16_t msg_type)
+{
+    =
return buf_write_u16(buf, msg_type);
+}
+
+bool
+oob_msg_read_header(struct=
 buffer *buf, uint16_t expected_msg_type)
+{
+    int msg_type =3D buf_read=
_u16(buf);
+    return msg_type >=3D 0 && (uint16_t)msg_type =3D=3D expecte=
d_msg_type;
+}
+
+bool
+oob_tlv_write_header(struct buffer *buf, uint16_t t=
ype, bool optional, uint16_t value_len)
+{
+    uint16_t field =3D type & O=
OB_TLV_TYPE_MASK;
+    if (optional)
+    {
+        field |=3D OOB_TLV_OPT=
IONAL_FLAG;
+    }
+    return buf_write_u16(buf, field) && buf_write_u16(b=
uf, value_len);
+}
+
+bool
+oob_tlv_read_header(struct buffer *buf, uint16_=
t *type, bool *optional, uint16_t *value_len)
+{
+    int field =3D buf_rea=
d_u16(buf);
+    if (field < 0)
+    {
+        return false;
+    }
+    i=
nt len =3D buf_read_u16(buf);
+    if (len < 0)
+    {
+        return fals=
e;
+    }
+    *type =3D (uint16_t)(field & OOB_TLV_TYPE_MASK);
+    *optio=
nal =3D (field & OOB_TLV_OPTIONAL_FLAG) !=3D 0;
+    *value_len =3D (uint16=
_t)len;
+    return true;
+}
+
+bool
+oob_probe_parameter_write(struct buff=
er *buf, const struct oob_probe_parameter *p)
+{
+    return oob_tlv_write_=
header(buf, OOB_TLV_PROBE_PARAMETER, false, OOB_PROBE_PARAMETER_LEN)
+     =
      && buf_write_u64(buf, p->timestamp)
+           && buf_write_u32(buf,=
 p->flags);
+}
+
+bool
+oob_probe_parameter_read(struct buffer *buf, struct=
 oob_probe_parameter *p, uint16_t value_len)
+{
+    if (value_len < OOB_PR=
OBE_PARAMETER_LEN)
+    {
+        return false;
+    }
+    /* check each =
read separately: a successful read sets ok back to true,
+     * so a singl=
e check at the end could mask an earlier failure */
+    bool ok =3D true;
=
+    p->timestamp =3D buf_read_u64(buf, &ok);
+    if (!ok)
+    {
+       =
 return false;
+    }
+    p->flags =3D buf_read_u32(buf, &ok);
+    if (!o=
k)
+    {
+        return false;
+    }
+    return oob_skip_trailing(buf, =
value_len, OOB_PROBE_PARAMETER_LEN);
+}
+
+bool
+oob_probe_reply_write(stru=
ct buffer *buf, const struct oob_probe_reply *r)
+{
+    return oob_tlv_wri=
te_header(buf, OOB_TLV_PROBE_REPLY, false, OOB_PROBE_REPLY_LEN)
+          =
 && session_id_write(&r->peer_session_id, buf)
+           && buf_write_u16=
(buf, r->priority)
+           && buf_write_u16(buf, r->weight)
+          =
 && buf_write_u16(buf, r->connect_lifetime)
+           && buf_write_u32(bu=
f, r->flags)
+           && buf_write_u16(buf, r->max_latency_diff);
+}
+
+=
bool
+oob_probe_reply_read(struct buffer *buf, struct oob_probe_reply *r, u=
int16_t value_len)
+{
+    if (value_len < OOB_PROBE_REPLY_LEN)
+    {
+   =
     return false;
+    }
+    if (!session_id_read(&r->peer_session_id, bu=
f))
+    {
+        return false;
+    }
+    int priority =3D buf_read_u16=
(buf);
+    int weight =3D buf_read_u16(buf);
+    int connect_lifetime =3D=
 buf_read_u16(buf);
+    if (priority < 0 || weight < 0 || connect_lifetime=
 < 0)
+    {
+        return false;
+    }
+    bool ok =3D true;
+    r->f=
lags =3D buf_read_u32(buf, &ok);
+    int max_latency_diff =3D buf_read_u16=
(buf);
+    if (!ok || max_latency_diff < 0)
+    {
+        return false;
=
+    }
+    r->priority =3D (uint16_t)priority;
+    r->weight =3D (uint16_=
t)weight;
+    r->connect_lifetime =3D (uint16_t)connect_lifetime;
+    r->=
max_latency_diff =3D (uint16_t)max_latency_diff;
+    return oob_skip_trail=
ing(buf, value_len, OOB_PROBE_REPLY_LEN);
+}
diff --git a/src/openvpn/oob=
=2Eh b/src/openvpn/oob=2Eh
new file mode 100644
index 0000000=2E=2E6880665
=
--- /dev/null
+++ b/src/openvpn/oob=2Eh
@@ -0,0 +1,152 @@
+/*
+ *  OpenVPN =
-- An application to securely tunnel IP networks
+ *             over a sin=
gle TCP/UDP port, with support for SSL/TLS-based
+ *             session au=
thentication and key exchange,
+ *             packet encryption, packet au=
thentication, and
+ *             packet compression=2E
+ *
+ *  Copyright =
(C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is fr=
ee software; you can redistribute it and/or modify
+ *  it under the terms =
of the GNU General Public License version 2
+ *  as published by the Free S=
oftware Foundation=2E
+ *
+ *  This program is distributed in the hope that=
 it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied=
 warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  S=
ee the
+ *  GNU General Public License for more details=2E
+ *
+ *  You sho=
uld have received a copy of the GNU General Public License along
+ *  with =
this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/*=
*
+ * @file
+ * Encoding/decoding of out-of-band (P_CONTROL_OOB_V1) control=
 messages=2E
+ *
+ * An OOB message payload starts with a 16-bit message ty=
pe (the 0x1xx space:
+ * SERVER_PROBE, PROBE_REPLY, =2E=2E=2E) followed by =
a sequence of TLV entries=2E
+ *
+ * Each TLV starts with a 4-byte header: =
a 16-bit field whose most significant
+ * bit is the "optional" flag and wh=
ose remaining 15 bits are the type (the
+ * 0x2xx space), followed by a 16-=
bit length giving the size of the value that
+ * follows the header=2E
+ */=

+
+#ifndef OOB_H
+#define OOB_H
+
+#include "buffer=2Eh"
+#include "sessio=
n_id=2Eh"
+
+/* OOB message types: the 16-bit value at the start of an OOB =
payload, before
+ * its TLV entries=2E Distinct from the TLV-type space (0x=
2xx); see the "Messages"
+ * table in the OOB section of the wire protocol =
spec=2E */
+#define OOB_MSG_SERVER_PROBE 0x100
+#define OOB_MSG_PROBE_REPLY=
  0x101
+
+/* TLV header bit layout of the first 16-bit field */
+#define O=
OB_TLV_OPTIONAL_FLAG 0x8000
+#define OOB_TLV_TYPE_MASK     0x7fff
+
+/* TLV=
 types (see the OOB control message section of the wire protocol spec) */
+=
#define OOB_TLV_PROBE_PARAMETER 0x200
+#define OOB_TLV_PROBE_REPLY     0x20=
1
+
+/* Minimum on-wire value length (excluding the 4-byte TLV header) of e=
ach TLV:
+ * the sizes of its fixed fields in wire order (see the structs b=
elow)=2E The
+ * value may be longer for forward compatibility; trailing by=
tes that are not
+ * understood are ignored on read=2E */
+#define OOB_PROB=
E_PARAMETER_LEN \
+    ((uint16_t)(sizeof(uint64_t) /* timestamp */ + sizeo=
f(uint32_t) /* flags */))
+#define OOB_PROBE_REPLY_LEN                     =
                                \
+    ((uint16_t)(SID_SIZE               /=
* peer_session_id */                    \
+                + 3 * sizeof(uin=
t16_t) /* priority, weight, connect_lifetime */ \
+                + sizeof=
(uint32_t)     /* flags */                              \
+                =
+ sizeof(uint16_t)))   /* max_latency_diff */
+
+/* probe parameter TLV (se=
nt by the client in a SERVER_PROBE) */
+struct oob_probe_parameter
+{
+    =
uint64_t timestamp; /**< client clock as a UNIX timestamp */
+    uint32_t =
flags;     /**< client capability flags, currently must be 0 */
+};
+
+/* p=
robe reply TLV (sent by the server in a PROBE_REPLY) */
+struct oob_probe_r=
eply
+{
+    struct session_id peer_session_id; /**< echoes the session id =
of the request */
+    uint16_t priority;                 /**< DNS-SRV styl=
e priority (lower is preferred) */
+    uint16_t weight;                   =
/**< DNS-SRV style weight */
+    uint16_t connect_lifetime;         /**< s=
econds the probe stays valid as a handshake shortcut */
+    uint32_t flags=
;                    /**< server behaviour flags */
+    uint16_t max_laten=
cy_diff;         /**< advertised candidate-band margin in ms;
+            =
                            *   0 means "defer to the client's setting" */
=
+};
+
+/**
+ * Write an OOB message-type header (the 16-bit message type pr=
eceding the
+ * TLVs) to @p buf=2E
+ *
+ * @return true on success, false i=
f @p buf has insufficient space=2E
+ */
+bool oob_msg_write_header(struct b=
uffer *buf, uint16_t msg_type);
+
+/**
+ * Read and verify an OOB message-t=
ype header from @p buf, advancing past it=2E
+ *
+ * @param buf            =
    buffer positioned at the OOB message payload
+ * @param expected_msg_ty=
pe  the message type the payload must carry
+ * @return true if a message t=
ype was read and equals @p expected_msg_type,
+ *         false on a short =
buffer or a mismatching type=2E
+ */
+bool oob_msg_read_header(struct buffe=
r *buf, uint16_t expected_msg_type);
+
+/**
+ * Write a TLV header (type + =
optional flag + value length) to @p buf=2E
+ *
+ * @return true on success,=
 false if @p buf has insufficient space=2E
+ */
+bool oob_tlv_write_header(=
struct buffer *buf, uint16_t type, bool optional, uint16_t value_len);
+
+/=
**
+ * Read a TLV header from @p buf, advancing past it=2E
+ *
+ * @param b=
uf        buffer positioned at the TLV header
+ * @param type       set to =
the 15-bit TLV type
+ * @param optional   set to the value of the optional =
flag
+ * @param value_len  set to the declared value length
+ * @return tru=
e on success, false if there are not enough bytes for a header=2E
+ */
+boo=
l oob_tlv_read_header(struct buffer *buf, uint16_t *type, bool *optional, u=
int16_t *value_len);
+
+/**
+ * Write a complete probe parameter TLV (heade=
r + value) to @p buf=2E
+ */
+bool oob_probe_parameter_write(struct buffer =
*buf, const struct oob_probe_parameter *p);
+
+/**
+ * Read a probe paramet=
er TLV value of @p value_len bytes from @p buf=2E
+ *
+ * The TLV header mu=
st already have been consumed (e=2Eg=2E via
+ * oob_tlv_read_header())=2E @=
p value_len bytes are always consumed on success,
+ * including any trailin=
g bytes beyond the fields understood here=2E
+ *
+ * @return true on succes=
s, false if @p value_len is too short or @p buf is
+ *         truncated=2E=

+ */
+bool oob_probe_parameter_read(struct buffer *buf, struct oob_probe_p=
arameter *p,
+                              uint16_t value_len);
+
+/**
+ *=
 Write a complete probe reply TLV (header + value) to @p buf=2E
+ */
+bool =
oob_probe_reply_write(struct buffer *buf, const struct oob_probe_reply *r);=

+
+/**
+ * Read a probe reply TLV value of @p value_len bytes from @p buf=
=2E See
+ * oob_probe_parameter_read() for the calling convention=2E
+ */
+=
bool oob_probe_reply_read(struct buffer *buf, struct oob_probe_reply *r, ui=
nt16_t value_len);
+
+#endif /* OOB_H */
diff --git a/src/openvpn/ssl_pkt=
=2Eh b/src/openvpn/ssl_pkt=2Eh
index ac9d4be=2E=2E0dab524 100644
--- a/src/=
openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -58,6 +58,17 @@
  * li=
ke P_CONTROL_HARD_RESET_CLIENT_V3 */
 #define P_CONTROL_WKC_V1 11
 
+/* Out=
-of-band control message that does not belong to an established
+ * control=
 channel session (e=2Eg=2E a server probe)=2E Inherently unreliable:
+ * th=
ere is no protocol-level retransmission=2E
+ *
+ * NOTE: intentionally not =
yet included in the P_FIRST_OPCODE=2E=2EP_LAST_OPCODE
+ * legal range=2E Th=
e range acts as an acceptance gate in tls_pre_decrypt();
+ * widening it be=
fore an OOB receive handler exists would let OOB packets
+ * be misparsed a=
s established-session control packets=2E Bump P_LAST_OPCODE
+ * to 12 in th=
e same change that adds the handler=2E */
+#define P_CONTROL_OOB_V1 12
+
 /=
* define the range of legal opcodes
  * Since we do no longer support key-m=
ethod 1 we consider
  * the v1 op codes invalid */
@@ -266,6 +277,9 @@
    =
     case P_CONTROL_WKC_V1:
             return "P_CONTROL_WKC_V1";
 
+    =
    case P_CONTROL_OOB_V1:
+            return "P_CONTROL_OOB_V1";
+
      =
   case P_ACK_V1:
             return "P_ACK_V1";
 
diff --git a/tests/unit=
_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index=
 1128eb4=2E=2E7174aa8 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+=
++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -14,6 +14,7 @@
 	ncp_testdri=
ver \
 	mbuf_testdriver \
 	misc_testdriver \
+	oob_testdriver \
 	options_=
parse_testdriver \
 	packet_id_testdriver \
 	pkt_testdriver \
@@ -149,6 +1=
50,19 @@
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
 	$(top_srcdir)/src/o=
penvpn/session_id=2Ec
 
+oob_testdriver_CFLAGS  =3D \
+	-I$(top_srcdir)/inc=
lude -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	@TEST_CFLAG=
S@
+oob_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
+oob_testdriver_SOURCES =3D t=
est_oob=2Ec \
+	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \
+	mock_get_rand=
om=2Ec \
+	$(top_srcdir)/src/openvpn/buffer=2Ec \
+	$(top_srcdir)/src/openv=
pn/oob=2Ec \
+	$(top_srcdir)/src/openvpn/platform=2Ec \
+	$(top_srcdir)/src=
/openvpn/session_id=2Ec \
+	$(top_srcdir)/src/openvpn/win32-util=2Ec
+
 pkt=
_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/com=
pat -I$(top_srcdir)/src/openvpn \
 	@TEST_CFLAGS@
diff --git a/tests/unit_t=
ests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
new file =
mode 100644
index 0000000=2E=2E48dfd6e
--- /dev/null
+++ b/tests/unit_tests=
/openvpn/test_oob=2Ec
@@ -0,0 +1,209 @@
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
+#ifdef HAVE_CONFIG_H=

+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stda=
rg=2Eh>
+#include <stddef=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh=
>
+
+#include "oob=2Eh"
+#include "test_common=2Eh"
+
+/* Write a probe par=
ameter TLV and read it back; fields must survive the
+ * round trip and the=
 whole buffer must be consumed=2E */
+static void
+test_probe_parameter_rou=
ndtrip(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct b=
uffer buf =3D alloc_buf_gc(128, &gc);
+
+    const struct oob_probe_paramet=
er in =3D {
+        =2Etimestamp =3D 0x0123456789abcdefULL,
+        =2Efl=
ags =3D 0,
+    };
+    assert_true(oob_probe_parameter_write(&buf, &in));
=
+    /* header (4) + value (12) */
+    assert_int_equal(BLEN(&buf), 4 + OO=
B_PROBE_PARAMETER_LEN);
+
+    uint16_t type;
+    bool optional;
+    uint=
16_t value_len;
+    assert_true(oob_tlv_read_header(&buf, &type, &optional=
, &value_len));
+    assert_int_equal(type, OOB_TLV_PROBE_PARAMETER);
+    =
assert_false(optional);
+    assert_int_equal(value_len, OOB_PROBE_PARAMETE=
R_LEN);
+
+    struct oob_probe_parameter out =3D { 0 };
+    assert_true(o=
ob_probe_parameter_read(&buf, &out, value_len));
+    assert_true(in=2Etime=
stamp =3D=3D out=2Etimestamp);
+    assert_int_equal(in=2Eflags, out=2Eflag=
s);
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* Wri=
te a probe reply TLV and read it back=2E */
+static void
+test_probe_reply_=
roundtrip(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struc=
t buffer buf =3D alloc_buf_gc(128, &gc);
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
+    assert_in=
t_equal(BLEN(&buf), 4 + OOB_PROBE_REPLY_LEN);
+
+    uint16_t type;
+    bo=
ol optional;
+    uint16_t value_len;
+    assert_true(oob_tlv_read_header(=
&buf, &type, &optional, &value_len));
+    assert_int_equal(type, OOB_TLV_P=
ROBE_REPLY);
+    assert_int_equal(value_len, OOB_PROBE_REPLY_LEN);
+
+    =
struct oob_probe_reply out =3D { 0 };
+    assert_true(oob_probe_reply_read=
(&buf, &out, value_len));
+    assert_memory_equal(in=2Epeer_session_id=2Ei=
d, out=2Epeer_session_id=2Eid, SID_SIZE);
+    assert_int_equal(in=2Epriori=
ty, out=2Epriority);
+    assert_int_equal(in=2Eweight, out=2Eweight);
+   =
 assert_int_equal(in=2Econnect_lifetime, out=2Econnect_lifetime);
+    asse=
rt_int_equal(in=2Eflags, out=2Eflags);
+    assert_int_equal(in=2Emax_laten=
cy_diff, out=2Emax_latency_diff);
+    assert_int_equal(BLEN(&buf), 0);
+
+=
    gc_free(&gc);
+}
+
+/* A TLV with a longer-than-known value must still =
parse: the known fields are
+ * read and the trailing bytes are skipped (fo=
rward compatibility)=2E */
+static void
+test_probe_parameter_forward_compa=
t(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer=
 buf =3D alloc_buf_gc(128, &gc);
+
+    const uint16_t extended_len =3D OOB=
_PROBE_PARAMETER_LEN + 4;
+    assert_true(oob_tlv_write_header(&buf, OOB_T=
LV_PROBE_PARAMETER, false, extended_len));
+    assert_true(buf_write_u32(&=
buf, 0));          /* timestamp high */
+    assert_true(buf_write_u32(&buf=
, 0xdeadbeef)); /* timestamp low */
+    assert_true(buf_write_u32(&buf, 0)=
);          /* flags */
+    assert_true(buf_write_u32(&buf, 0x11223344)); =
/* unknown trailing field */
+
+    uint16_t type;
+    bool optional;
+   =
 uint16_t value_len;
+    assert_true(oob_tlv_read_header(&buf, &type, &opt=
ional, &value_len));
+    assert_int_equal(value_len, extended_len);
+
+   =
 struct oob_probe_parameter out =3D { 0 };
+    assert_true(oob_probe_param=
eter_read(&buf, &out, value_len));
+    assert_true(out=2Etimestamp =3D=3D =
0xdeadbeefULL);
+    assert_int_equal(out=2Eflags, 0);
+    /* the unknown =
trailing field must have been consumed */
+    assert_int_equal(BLEN(&buf),=
 0);
+
+    gc_free(&gc);
+}
+
+/* A declared value length shorter than the=
 mandatory minimum must be rejected=2E */
+static void
+test_probe_paramete=
r_too_short(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    str=
uct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    struct oob_probe_paramete=
r out =3D { 0 };
+    assert_false(oob_probe_parameter_read(&buf, &out, OOB=
_PROBE_PARAMETER_LEN - 1));
+
+    gc_free(&gc);
+}
+
+/* A buffer holding =
fewer value bytes than the declared length must be
+ * rejected: a failed t=
imestamp (u64) read must not be masked by a subsequent
+ * successful flags=
 (u32) read=2E */
+static void
+test_probe_parameter_truncated_buffer(void =
**state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =
=3D alloc_buf_gc(128, &gc);
+
+    /* only 4 of the declared OOB_PROBE_PARA=
METER_LEN value bytes present:
+     * too short for the timestamp, but eno=
ugh for a u32 read to succeed */
+    assert_true(buf_write_u32(&buf, 0xdea=
dbeef));
+
+    struct oob_probe_parameter out =3D { 0 };
+    assert_false=
(oob_probe_parameter_read(&buf, &out, OOB_PROBE_PARAMETER_LEN));
+
+    gc_=
free(&gc);
+}
+
+/* Reading a TLV header must fail when the buffer holds le=
ss data than a
+ * complete 4-byte header (empty, or only the type field), =
rather than read
+ * past the available data=2E */
+static void
+test_tlv_h=
eader_truncated(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+   =
 struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    uint16_t type;
+    b=
ool optional;
+    uint16_t value_len;
+
+    /* empty buffer */
+    asser=
t_false(oob_tlv_read_header(&buf, &type, &optional, &value_len));
+
+    /*=
 only the type field present, no length */
+    assert_true(buf_write_u16(&=
buf, OOB_TLV_PROBE_PARAMETER));
+    assert_false(oob_tlv_read_header(&buf,=
 &type, &optional, &value_len));
+
+    gc_free(&gc);
+}
+
+int
+main(void)=

+{
+    openvpn_unit_test_setup();
+    const struct CMUnitTest tests[] =
=3D {
+        cmocka_unit_test(test_probe_parameter_roundtrip),
+        c=
mocka_unit_test(test_probe_reply_roundtrip),
+        cmocka_unit_test(test=
_probe_parameter_forward_compat),
+        cmocka_unit_test(test_probe_para=
meter_too_short),
+        cmocka_unit_test(test_probe_parameter_truncated_=
buffer),
+        cmocka_unit_test(test_tlv_header_truncated),
+    };
+
+ =
   return cmocka_run_group_tests_name("oob tests", tests, NULL, NULL);
+}

=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c8d302ac57c5603d=
622a7be14be369437388268
Gerrit-Change-Number: 1741
Gerrit-PatchSet: 4
Gerri=
t-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2E=
com>

--QDuqoNoUhig=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>stipa <stro=
ng>uploaded patch set #4</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><p=
>The following approvals got outdated and were removed:
Code-Review-1 by fl=
ichtenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">oob: Add control message TLV encoding (P_CONTRO=
L_OOB_V1)<br><br>Reserve opcode 12 (P_CONTROL_OOB_V1) for out-of-band contr=
ol messages and<br>add encoding/decoding for the SERVER_PROBE / PROBE_REPLY=
 TLVs used for<br>server latency checks:<br><br>  - probe_parameter (0x200)=
: client timestamp + capability flags<br>  - probe_reply    (0x201): echoed=
 session id, DNS-SRV style priority and<br>                            weig=
ht, connect_lifetime and behaviour flags<br><br>Each TLV has a 4-byte heade=
r (15-bit type plus an optional flag, then a<br>16-bit value length)=2E Rea=
ders enforce the minimum value length and skip<br>trailing bytes they do no=
t understand, so the format stays forward<br>compatible and multi-TLV frami=
ng resynchronises=2E<br><br>P_LAST_OPCODE is deliberately left at 11: opcod=
e 12 is not yet accepted by<br>tls_pre_decrypt()=2E The legal-opcode range =
is widened together with the<br>receive handler in a follow-up, which also =
wires oob=2Ec into the openvpn<br>build=2E For now the codec is exercised o=
nly by the unit tests=2E<br><br>See the OOB control message section of the =
OpenVPN wire protocol<br>specification (openvpn-rfc PR #30)=2E<br><br>Chang=
e-Id: I1c8d302ac57c5603d622a7be14be369437388268<br>Signed-off-by: Lev Stipa=
kov &lt;lev@openvpn=2Enet&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn=
/Makefile=2Eam<br>A src/openvpn/oob=2Ec<br>A src/openvpn/oob=2Eh<br>M src/o=
penvpn/ssl_pkt=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests/u=
nit_tests/openvpn/test_oob=2Ec<br>7 files changed, 567 insertions(+), 0 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/41/1741/4</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt =
b/CMakeLists=2Etxt</span><br><span>index 8de836a=2E=2E608e39e4 100644</span=
><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</s=
pan><br><span>@@ -518,6 +518,8 @@</span><br><span>     src/openvpn/multi_io=
=2Ec</span><br><span>     src/openvpn/occ=2Ec</span><br><span>     src/open=
vpn/occ=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/=
openvpn/oob=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
src/openvpn/oob=2Eh</span><br><span>     src/openvpn/openvpn=2Ec</span><br>=
<span>     src/openvpn/openvpn=2Eh</span><br><span>     src/openvpn/openvpn=
_win32_resources=2Erc</span><br><span>@@ -665,6 +667,7 @@</span><br><span> =
        &quot;test_mbuf&quot;</span><br><span>         &quot;test_misc&quot=
;</span><br><span>         &quot;test_ncp&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        &quot;test_oob&quot;</span><br><span>  =
       &quot;test_options_parse&quot;</span><br><span>         &quot;test_p=
acket_id&quot;</span><br><span>         &quot;test_pkt&quot;</span><br><spa=
n>@@ -855,6 +858,12 @@</span><br><span>         src/openvpn/session_id=2Ec<=
/span><br><span>         )</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    target_sources(test_oob PRIVATE</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/m=
ock_get_random=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       src/openvpn/oob=2Ec</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        src/openvpn/session_id=2Ec</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        )</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span>     target_sources(test_pkt PRIVATE</span><br=
><span>         tests/unit_tests/openvpn/mock_win32_execve=2Ec</span><br><s=
pan>         src/openvpn/argv=2Ec</span><br><span>diff --git a/src/openvpn/=
Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index ff8cc54=2E=
=2Eb4b1b92 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br=
><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -106,6 +106,7 @@<=
/span><br><span> 	pkcs11=2Ec pkcs11=2Eh pkcs11_backend=2Eh \</span><br><spa=
n> 	pkcs11_openssl=2Ec \</span><br><span> 	pkcs11_mbedtls=2Ec \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	oob=2Ec oob=2Eh \</span><br><s=
pan> 	openvpn=2Ec openvpn=2Eh \</span><br><span> 	options=2Ec options=2Eh \=
</span><br><span> 	options_util=2Ec options_util=2Eh \</span><br><span>diff=
 --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br><span>new file=
 mode 100644</span><br><span>index 0000000=2E=2Eb01f4ee</span><br><span>---=
 /dev/null</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -0,=
0 +1,168 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An applica=
tion to securely tunnel IP networks</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             over a single TCP/UDP port, with support for=
 SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          session authentication and key exchange,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             packet encryption, packet aut=
hentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            packet compression=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  This program is free software; you can redi=
stribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  it under the terms of the GNU General Public License version 2</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by th=
e Free Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Thi=
s program is distributed in the hope that it will be useful,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; with=
out even the implied warranty of</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  Se=
e the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU Genera=
l Public License for more details=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  You should have received a copy of the GNU General Public License along=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progr=
am; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Consume @p value_len bytes of TLV value, =
of which @p consumed have already</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * been read, ignoring (skipping) any trailing bytes that thi=
s version does</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * no=
t understand=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf        =
buffer positioned after the @p consumed value bytes</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param value_len  the TLV&#39;s declar=
ed value length</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param consumed   number of value bytes already read from @p buf</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, fal=
se if fewer than @p consumed bytes were</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *         declared or @p buf does not hold the trailin=
g bytes=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+oob_skip_trailing(struct buffer *=
buf, uint16_t value_len, int consumed)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (value_len &lt; consumed)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return b=
uf_advance(buf, value_len - consumed);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+oob_msg_write_header(struct buffe=
r *buf, uint16_t msg_type)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
buf_write_u16(buf, msg_type);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+oob_msg_read_header(struct buffer *buf, u=
int16_t expected_msg_type)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int msg=
_type =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return msg_type &gt;=3D 0 &amp;&amp; (uint16_t)msg_type =3D=3D=
 expected_msg_type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+oob_tlv_write_header(struct buffer *buf, uint16_t ty=
pe, bool optional, uint16_t value_len)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    uint16_t field =3D type &amp; OOB_TLV_TYPE_MASK;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (optional)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        field |=3D OOB_TLV_OPTIONAL_FLAG;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return buf_write_u16(buf, field) &amp;&amp;=
 buf_write_u16(buf, value_len);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+oob_tlv_read_header(struct buffer *buf, =
uint16_t *type, bool *optional, uint16_t *value_len)</span><br><span style=
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
   *type =3D (uint16_t)(field &amp; OOB_TLV_TYPE_MASK);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    *optional =3D (field &amp; OOB_TLV_=
OPTIONAL_FLAG) !=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    *value_len =3D (uint16_t)len;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+oob_probe_parameter_write(struct buffe=
r *buf, const struct oob_probe_parameter *p)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return oob_tlv_write_header(buf, OOB_TLV_PROBE_PARAMETER, false,=
 OOB_PROBE_PARAMETER_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+           &amp;&amp; buf_write_u64(buf, p-&gt;timestamp)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write=
_u32(buf, p-&gt;flags);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+oob_probe_parameter_read(struct buffer *buf, str=
uct oob_probe_parameter *p, uint16_t value_len)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (value_len &lt; OOB_PROBE_PARAMETER_LEN)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* check each read separately: a successful read sets ok ba=
ck to true,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * s=
o a single check at the end could mask an earlier failure */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    bool ok =3D true;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    p-&gt;timestamp =3D buf_read=
_u64(buf, &amp;ok);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (!ok)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    p-&gt;flags =3D buf_read_u32(=
buf, &amp;ok);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!ok)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return oob_skip_trailing(buf, valu=
e_len, OOB_PROBE_PARAMETER_LEN);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+oob_probe_reply_write(struct buffer *bu=
f, const struct oob_probe_reply *r)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return oob_tlv_write_header(buf, OOB_TLV_PROBE_REPLY, false, OOB_PROBE_RE=
PLY_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
&amp;&amp; session_id_write(&amp;r-&gt;peer_session_id, buf)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u1=
6(buf, r-&gt;priority)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+           &amp;&amp; buf_write_u16(buf, r-&gt;weight)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16(b=
uf, r-&gt;connect_lifetime)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+           &amp;&amp; buf_write_u32(buf, r-&gt;flags)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u=
16(buf, r-&gt;max_latency_diff);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+oob_probe_reply_read(struct buffer *buf=
, struct oob_probe_reply *r, uint16_t value_len)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (value_len &lt; OOB_PROBE_REPLY_LEN)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!session_id_read(&amp;r-&gt;peer_session_id, buf))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
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
<span>index 0000000=2E=2E6880665</span><br><span>--- /dev/null</span><br><s=
pan>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -0,0 +1,152 @@</span><br><=
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
eader=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#ifndef OOB_H</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define OOB_H</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;session_id=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* OOB message types: the 16-bit value at the start of an OOB payloa=
d, before</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * its TLV=
 entries=2E Distinct from the TLV-type space (0x2xx); see the &quot;Message=
s&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * table in =
the OOB section of the wire protocol spec=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define OOB_MSG_SERVER_PROBE 0x100</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define OOB_MSG_PROBE_REPLY  0x1=
01</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* TLV header bit layout of the firs=
t 16-bit field */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine OOB_TLV_OPTIONAL_FLAG 0x8000</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define OOB_TLV_TYPE_MASK     0x7fff</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* TLV types (see the OOB control message section of the wir=
e protocol spec) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define OOB_TLV_PROBE_PARAMETER 0x200</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define OOB_TLV_PROBE_REPLY     0x201</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* Minimum on-wire value length (excluding the 4-byte TLV =
header) of each TLV:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * the sizes of its fixed fields in wire order (see the structs below)=2E =
The</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * value may be =
longer for forward compatibility; trailing bytes that are not</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * understood are ignored on read=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_P=
ROBE_PARAMETER_LEN \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ((uint16_t)(sizeof(uint64_t) /* timestamp */ + sizeof(uint32_t) /* fla=
gs */))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_=
PROBE_REPLY_LEN                                                     \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ((uint16_t)(SID_SIZE =
              /* peer_session_id */                    \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                + 3 * sizeof(uint16_t)=
 /* priority, weight, connect_lifetime */ \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                + sizeof(uint32_t)     /* flags */ =
                             \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                + sizeof(uint16_t)))   /* max_latency_diff */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* probe parameter TLV (sent by the clien=
t in a SERVER_PROBE) */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+struct oob_probe_parameter</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uin=
t64_t timestamp; /**&lt; client clock as a UNIX timestamp */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    uint32_t flags;     /**&lt; cl=
ient capability flags, currently must be 0 */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* probe r=
eply TLV (sent by the server in a PROBE_REPLY) */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+struct oob_probe_reply</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct session_id peer_session_id; /**&lt; echoes the s=
ession id of the request */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    uint16_t priority;                 /**&lt; DNS-SRV style priori=
ty (lower is preferred) */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    uint16_t weight;                   /**&lt; DNS-SRV style weight =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t conn=
ect_lifetime;         /**&lt; seconds the probe stays valid as a handshake =
shortcut */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint=
32_t flags;                    /**&lt; server behaviour flags */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t max_latency_diff;=
         /**&lt; advertised candidate-band margin in ms;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                      =
  *   0 means &quot;defer to the client&#39;s setting&quot; */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write =
an OOB message-type header (the 16-bit message type preceding the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * TLVs) to @p buf=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @return true on success, false if @p buf =
has insufficient space=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_m=
sg_write_header(struct buffer *buf, uint16_t msg_type);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Read and verify an OOB message-type header from @p buf, advancing past =
it=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf                bu=
ffer positioned at the OOB message payload</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param expected_msg_type  the message type the pa=
yload must carry</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@return true if a message type was read and equals @p expected_msg_type,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         false on a =
short buffer or a mismatching type=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+bool oob_msg_read_header(struct buffer *buf, uint16_t expected_msg_type);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Write a TLV header (type + optional flag + value le=
ngth) to @p buf=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on=
 success, false if @p buf has insufficient space=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+bool oob_tlv_write_header(struct buffer *buf, uint16_t ty=
pe, bool optional, uint16_t value_len);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read a TLV h=
eader from @p buf, advancing past it=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param buf        buffer positioned at the TLV header</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param type       set to the 15-=
bit TLV type</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am optional   set to the value of the optional flag</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param value_len  set to the declared =
value length</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @ret=
urn true on success, false if there are not enough bytes for a header=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+bool oob_tlv_read_header(struct buffer=
 *buf, uint16_t *type, bool *optional, uint16_t *value_len);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Write a complete probe parameter TLV (header + value) to @p buf=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool oob_probe_parameter_write(stru=
ct buffer *buf, const struct oob_probe_parameter *p);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Read a probe parameter TLV value of @p value_len bytes from @p buf=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * The TLV header must already have been=
 consumed (e=2Eg=2E via</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * oob_tlv_read_header())=2E @p value_len bytes are always consumed on =
success,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * includin=
g any trailing bytes beyond the fields understood here=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @return true on success, false if @p value_len is t=
oo short or @p buf is</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *         truncated=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_p=
robe_parameter_read(struct buffer *buf, struct oob_probe_parameter *p,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
      uint16_t value_len);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a complete probe re=
ply TLV (header + value) to @p buf=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+bool oob_probe_reply_write(struct buffer *buf, const struct oob_probe_rep=
ly *r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Read a probe reply TLV value of @p value_len=
 bytes from @p buf=2E See</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * oob_probe_parameter_read() for the calling convention=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bool oob_probe_reply_read(struct buffer *buf,=
 struct oob_probe_reply *r, uint16_t value_len);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif /* OOB_H */</span><br><span>diff --git a/src/openvpn/ssl_p=
kt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index ac9d4be=2E=2E0dab524=
 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b=
/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -58,6 +58,17 @@</span><br><span=
>  * like P_CONTROL_HARD_RESET_CLIENT_V3 */</span><br><span> #define P_CONT=
ROL_WKC_V1 11</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* Out-of-band control message that does not belong to an estab=
lished</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * control ch=
annel session (e=2Eg=2E a server probe)=2E Inherently unreliable:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * there is no protocol-level=
 retransmission=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * NOTE: intention=
ally not yet included in the P_FIRST_OPCODE=2E=2EP_LAST_OPCODE</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * legal range=2E The range acts=
 as an acceptance gate in tls_pre_decrypt();</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * widening it before an OOB receive handler exist=
s would let OOB packets</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * be misparsed as established-session control packets=2E Bump P_LAST_O=
PCODE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to 12 in th=
e same change that adds the handler=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define P_CONTROL_OOB_V1 12</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> /* define the range of lega=
l opcodes</span><br><span>  * Since we do no longer support key-method 1 we=
 consider</span><br><span>  * the v1 op codes invalid */</span><br><span>@@=
 -266,6 +277,9 @@</span><br><span>         case P_CONTROL_WKC_V1:</span><br=
><span>             return &quot;P_CONTROL_WKC_V1&quot;;</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case P_CONTR=
OL_OOB_V1:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   return &quot;P_CONTROL_OOB_V1&quot;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>         case P_ACK_V1:</span><br><spa=
n>             return &quot;P_ACK_V1&quot;;</span><br><span> </span><br><sp=
an>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/o=
penvpn/Makefile=2Eam</span><br><span>index 1128eb4=2E=2E7174aa8 100644</spa=
n><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>++=
+ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -14,6 +14,7 @=
@</span><br><span> 	ncp_testdriver \</span><br><span> 	mbuf_testdriver \</s=
pan><br><span> 	misc_testdriver \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	oob_testdriver \</span><br><span> 	options_parse_testdriver =
\</span><br><span> 	packet_id_testdriver \</span><br><span> 	pkt_testdriver=
 \</span><br><span>@@ -149,6 +150,19 @@</span><br><span> 	$(top_srcdir)/src=
/openvpn/win32-util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/sessi=
on_id=2Ec</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+oob_testdriver_CFLAGS  =3D \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(to=
p_srcdir)/src/openvpn \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	@TEST_CFLAGS@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+o=
ob_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+oob_testdriver_SOURCES =3D test_oob=2Ec \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	mock_msg=2Ec mock_msg=2Eh test_=
common=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_g=
et_random=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(t=
op_srcdir)/src/openvpn/buffer=2Ec \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	$(top_srcdir)/src/openvpn/oob=2Ec \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/platform=2Ec \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/=
openvpn/session_id=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	$(top_srcdir)/src/openvpn/win32-util=2Ec</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> pkt_testdriver_CFLAGS  =3D \</=
span><br><span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top=
_srcdir)/src/openvpn \</span><br><span> 	@TEST_CFLAGS@</span><br><span>diff=
 --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/t=
est_oob=2Ec</span><br><span>new file mode 100644</span><br><span>index 0000=
000=2E=2E48dfd6e</span><br><span>--- /dev/null</span><br><span>+++ b/tests/=
unit_tests/openvpn/test_oob=2Ec</span><br><span>@@ -0,0 +1,209 @@</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunn=
el IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          over a single TCP/UDP port, with support for SSL/TLS-based</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             session aut=
hentication and key exchange,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *             packet encryption, packet authentication, and</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet co=
mpression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2=
026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  This program is free software; you can redistribute it and/or mo=
dify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under th=
e terms of the GNU General Public License version 2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Fou=
ndation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distri=
buted in the hope that it will be useful,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implie=
d warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  ME=
RCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License fo=
r more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have=
 received a copy of the GNU General Public License along</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt=
;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_C=
ONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdarg=2Eh&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stddef=2Eh&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=2E=
h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;c=
mocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;t=
est_common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Write a probe p=
arameter TLV and read it back; fields must survive the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * round trip and the whole buffer must =
be consumed=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe=
_parameter_roundtrip(void **state)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const struct oob_probe_parameter in =3D {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Etimestamp=
 =3D 0x0123456789abcdefULL,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        =2Eflags =3D 0,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(oob_probe_parameter_write(&amp;buf, &amp;in));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* header (4) + value (12) */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(BLEN(&amp;buf), 4 + OOB_PROBE_PARAMETER_LEN);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    uint16_t type;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    bool optional;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    uint16_t value_len;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(oob_tlv_read_header(&amp;buf, &amp;type, &amp;op=
tional, &amp;value_len));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(type, OOB_TLV_PROBE_PARAMETER);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_false(optional);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(value_l=
en, OOB_PROBE_PARAMETER_LEN);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t oob_probe_parameter out =3D { 0 };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(oob_probe_parameter_read(&amp;buf, &amp;ou=
t, value_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(in=2Etimestamp =3D=3D out=2Etimestamp);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Eflags, out=2Efl=
ags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(=
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* Write a probe reply TLV and read it back=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_roundtri=
p(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc=
 =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct oob_probe_reply in =3D {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        =2Epriority =3D 10,</span><br><span style=
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
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A buffer holding =
fewer value bytes than the declared length must be</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * rejected: a failed timestamp (u64) read m=
ust not be masked by a subsequent</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * successful flags (u32) read=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+test_probe_parameter_truncated_buffer(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf=
 =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 only 4 of the declared OOB_PROBE_PARAMETER_LEN value bytes present:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * too short for the t=
imestamp, but enough for a u32 read to succeed */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0xdea=
dbeef));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_parameter=
 out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_false(oob_probe_parameter_read(&amp;buf, &amp;out, OOB_PROBE_PARAMET=
ER_LEN));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* Reading a TLV header must fail when the buffer holds less dat=
a than a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * complete=
 4-byte header (empty, or only the type field), rather than read</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * past the available data=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+test_tlv_header_truncated=
(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    uint16_t type;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    bool optional;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    uint16_t value_len;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* e=
mpty buffer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_false(oob_tlv_read_header(&amp;buf, &amp;type, &amp;optional, &amp;va=
lue_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* only the type field p=
resent, no length */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_true(buf_write_u16(&amp;buf, OOB_TLV_PROBE_PARAMETER));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_tlv_re=
ad_header(&amp;buf, &amp;type, &amp;optional, &amp;value_len));</span><br><=
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
st(test_probe_parameter_forward_compat),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        cmocka_unit_test(test_probe_parameter_too_shor=
t),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_u=
nit_test(test_probe_parameter_truncated_buffer),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_tlv_header_trunc=
ated),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return cmocka_run_group_tests_name(&quot;=
oob tests&quot;, tests, NULL, NULL);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span></span><br></pre><p>To view, visit <a hr=
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
it-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;=
lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipak=
ov@gmail=2Ecom&gt; </div>

</body></html>
--QDuqoNoUhig=--


--===============5625345121493448936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5625345121493448936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5625345121493448936==--

