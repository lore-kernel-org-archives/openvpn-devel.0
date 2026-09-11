Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DC5C88E56
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=me5vHatllLvI7ABr9GHEqTSjBiv1QVm1oWMIUipysHM=; b=Lgv8pBejW8tmsM6BadWDwM5Apd
	bkv0LVXdN1cDVe4NgvBqqOpHahv4JG1rZISUG+8yBJ3v0TuGyCm+wFjsWpH9u5TlRuyYUorL2OYTx
	RI5xMaBk2lq22F+cdbLq7r/pto5R3xKe6XSBOYIZ+V8KE92HDXSnSjKGBaqFOK5vdeVY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4xIF-0006T5-P5;
	Fri, 11 Sep 2026 09:11:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4xI8-0006Sl-CQ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 09:11:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ubtor99GD4/Mk15rZksbR3wHIIXE8TJJ7puYlJeJ4vY=; b=TV24Q1PpoE+kQvVe9DT79rNIWc
 hpBgAS3IgJaUinZPSdpmJ9DMxYGz2iaWc5SrIi1T/mTdimbKi2u7MDG5hwHrjw4z2aK/YV+Ap6w8O
 P19z6W95C4zJOpH/uIhmv58CquegZuVYo9LlkkUFXOKfiOATJVbR3aG+AE6GH8Qg1CB0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ubtor99GD4/Mk15rZksbR3wHIIXE8TJJ7puYlJeJ4vY=; b=K
 4uRpite3O3/aW/iytDTtUxfTvSF/fxdnMlpFWLXi+sNXhi8gZdxBUbWfHuavcLIBP3Yv0VwLNNc5a
 huFtjJfcsLH6JiYvwkkQn0xXBibz7yYB0U/TefZhqCNI+fE5f90BpNHo0lMvJ49dzIEQQstKljvaP
 aMxJDCeIZkNQRKzY=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4xHy-0008Cg-WC for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 09:11:28 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso8969135e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 02:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789117872; x=1789722672; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ubtor99GD4/Mk15rZksbR3wHIIXE8TJJ7puYlJeJ4vY=;
 b=Vw/0PmlVETtjRTbmOvhMzm3HEO7pBdPUvAUJygyKK7h0bDVmMzvl5tJFyvSfjs0GBO
 k/8f0SBeggO4xEvz/r2qFz6+GOfWIO+z1eX1ppdvpCmlfeGfuSEnSo6+bjQA8YmpZcoH
 7A6/fo9XFAGcLQwYwEQCC5yryxc/U/aVc+wZqbnc3gXC63waJF6kpGhKkH92fVJhWWCr
 OmgjdiwAt7rvc2U+rT5y+16bTpJ2vU1tr/iexcdmTzgzq91xqJA6088X7gp3UWIC0oZ2
 9ziFSqAPsGmlbpFdaWmzX/599fNTCicGGPWSzeGyBzuVblXGuqxumcZR6zP2NBDam3ac
 qwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117872; x=1789722672;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ubtor99GD4/Mk15rZksbR3wHIIXE8TJJ7puYlJeJ4vY=;
 b=SDus5YXhAxB9i1R6dMOAen27/lXtRTkRCDDAgtpIG88JRg2rGfSWPqIP5uFjkx2o48
 H3WUdhkpikEMDKYAJ5ZbHuUx4i/oNWstbBRuR4AlePiVNlD/subBzTIim7/u2oS24ERG
 xbPWzsKDZP37VpiUU0ZP35mZCF4+4B5RNLeRzNRXO3RGHTf9eaHNyi6VODT09TpwOx2g
 6bG2ehWqq0Em7hfKdh4mK8iUUrmjt8vT+Y/FpqM/soHBkDar4fPXllSanwlBWZbiQFRs
 4edD3RCeXx3mEhfAkJ4roo2gi9ZzausqIqbvx0/f3uqHBkxdytf9EFpVqrhj7s0raUnd
 3b5A==
X-Gm-Message-State: AFuF++nKZ21MWDOQLOwIvxf7sIt4vwqRCjFRj/6ThSB4ZPxPhVALahCd
 T4FkIC5qguXf+5fUBQJ+qBKPYpjktxCKq8K56t8GqNTltoDehyCzGUgnnbgMdm84XN4DSaQ0994
 OI8Bz3kzbtKtoUvfbqbFM3jy0Onpm3GOy/+KThN9oyQk1SRUiFDQLf3L4ICd40TvncYO+
X-Gm-Gg: AYBFou3OHqxItYnnp6uJxm3dlhVMap5rTTHPpX8q/vKhxMYc3COWBBuD/CQmWRJ1pem
 JXfW4saTdv/Lltoo35LpT1utrueG1kYVBjggQXjBJkd4SK6QEx0BFvq7TEpFhYBEGZUlylGcC1b
 l/4Woix79FJLNW6wkxVtM5GStPkCKBeNOG2DZub4gJFW2dNRNKmBeYwxHohqapDtz2IMQHQnhVS
 twgjy8C7MORQUiS6n7RDuB7L6p9O3ah0P2qDJOAB4pkYDEz7hBP00tmTr6h3nzzZ04E6wFIy3uD
 cpwwnR3JL9qGxiiCcI6u2NrHeG1EhdziAu70VvBKSaR0CqaTFTqkR9OFxf2d0oDw6wipnI6CBXj
 HGt1tEalEsMQrWoCET7JjRTmmlvlOoNqsfDRJUd/usMaWPNfkLtFRxqFpi7c44RNRhWd0t29Aff
 4C4n7CnMV1N09Od7uoc6kNhuhk4SeI1o6Zvj4uzjqbgxcadWVnO5r9lyG21/xTdGvI76NtY5V1w
 jr7u7+Vqu0zzY18bq+dH8OWwPKI1nKN5oMCG7OtNAbPrLdvH40+41HSUZ6n6I+OHraiCV2foM4j
 5HDMYeZDafIeVNpjsXkczenyXetW3TxLNwLy9MwPhiDqeYBJh+8SE05DqY6Nvg==
X-Received: by 2002:a05:600c:8b23:b0:49b:9202:6f80 with SMTP id
 5b1f17b1804b1-49e619805b5mr34704695e9.6.1789117871832; 
 Fri, 11 Sep 2026 02:11:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c38e3asm153588655e9.9.2026.09.11.02.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:11:11 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 09:11:03 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>,
 ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 3bac555932e1cfb6ad53d746980a72e377391c83
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f3c7ed46a9fa778c582e5b0c6c88eb64b2f2eee0-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4xHy-0008Cg-WC
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
Content-Type: multipart/mixed; boundary="===============3787890358099140663=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3787890358099140663==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YGV0E54rGJU="; charset=UTF-8

--YGV0E54rGJU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici, s=
tipa=2E

Hello flichtenheld, plaisthos, ralf_lici, 

I'd like you to reexam=
ine a change=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1741?usp=3Demail

to look at the new patch set (#14)=2E

The following app=
rovals got outdated and were removed:
Code-Review+1 by ralf_lici


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


P_LAST_OPCODE becomes 12, and opcode_valid_in_session() replaces the
plai=
n range check because OOB opcodes are answered statelessly and are
never le=
gal on an established session=2E

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
11 files changed, 824 insertions(+), 4 deletions(-)


  g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1741/14
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
index 0000000=2E=2E70f529e0
--- /dev/null
+++ b/test=
s/unit_tests/openvpn/test_oob=2Ec
@@ -0,0 +1,340 @@
+/*
+ *  OpenVPN -- An =
application to securely tunnel IP networks
+ *             over a single TC=
P/UDP port, with support for SSL/TLS-based
+ *             session authenti=
cation and key exchange,
+ *             packet encryption, packet authenti=
cation, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 20=
02-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free sof=
tware; you can redistribute it and/or modify
+ *  it under the terms of the=
 GNU General Public License version 2
+ *  as published by the Free Softwar=
e Foundation=2E
+ *
+ *  This program is distributed in the hope that it wi=
ll be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warra=
nty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the=

+ *  GNU General Public License for more details=2E
+ *
+ *  You should ha=
ve received a copy of the GNU General Public License along
+ *  with this p=
rogram; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef H=
AVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#i=
nclude <stdarg=2Eh>
+#include <stddef=2Eh>
+#include <setjmp=2Eh>
+#include=
 <cmocka=2Eh>
+
+#include "control_msg=2Eh"
+#include "oob=2Eh"
+#include "=
test_common=2Eh"
+
+/* Write a probe parameter TLV and read it back; fields=
 must survive the
+ * round trip and the whole buffer must be consumed=2E *=
/
+static void
+test_probe_parameter_roundtrip(void **state)
+{
+    struct=
 gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc=
);
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

+/* An unknown TLV marked optional after the wanted one is skipped, and th=
e
+ * wanted value is still the one returned=2E */
+static void
+test_find_=
tlv_skips_optional_after_wanted(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+    struc=
t buffer value;
+
+    const struct oob_probe_parameter in =3D { =2Etimesta=
mp =3D 7, =2Eflags =3D 0 };
+    assert_true(oob_probe_parameter_write(&buf=
, &in));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));=

+    assert_true(buf_write_u32(&buf, 0));
+
+    assert_true(ctrl_msg_find=
_tlv(&buf, OOB_TLV_PROBE_PARAMETER, &value));
+    assert_int_equal(BLEN(&v=
alue), OOB_PROBE_PARAMETER_LEN);
+    struct oob_probe_parameter out =3D { =
0 };
+    assert_true(oob_probe_parameter_read(&value, &out));
+    assert_=
true(out=2Etimestamp =3D=3D 7);
+
+    gc_free(&gc);
+}
+
+/* An empty payl=
oad holds no TLV=2E */
+static void
+test_find_tlv_empty_payload(void **sta=
te)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D all=
oc_buf_gc(16, &gc);
+    struct buffer value;
+
+    assert_false(ctrl_msg_=
find_tlv(&buf, OOB_TLV_PROBE_PARAMETER, &value));
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
+        cmocka_unit_test(test_find_tlv_ski=
ps_optional_after_wanted),
+        cmocka_unit_test(test_find_tlv_empty_pa=
yload),
+        cmocka_unit_test(test_tlv_header_truncated),
+    };
+
+  =
  return cmocka_run_group_tests_name("oob tests", tests, NULL, NULL);
+}

-=
- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c8d302ac57c5603d6=
22a7be14be369437388268
Gerrit-Change-Number: 1741
Gerrit-PatchSet: 14
Gerri=
t-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention=
: stipa <lstipakov@gmail=2Ecom>

--YGV0E54rGJU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici, stipa=2E </p>
<p>=
stipa <strong>uploaded patch set #14</strong> to this change=2E</p><p><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Re=
view+1 by ralf_lici</p><pre class=3D"blocks" style=3D"font-family: monospac=
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
ather than just the<br>TLV=2E<br><br>P_LAST_OPCODE becomes 12, and opcode_v=
alid_in_session() replaces the<br>plain range check because OOB opcodes are=
 answered statelessly and are<br>never legal on an established session=2E<b=
r><br>See the OOB control message section of the wire protocol specificatio=
n<br>(openvpn-rfc PR #30)=2E<br><br>Change-Id: I1c8d302ac57c5603d622a7be14b=
e369437388268<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>-=
--<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>A src/openvpn/co=
ntrol_msg=2Ec<br>A src/openvpn/control_msg=2Eh<br>A src/openvpn/oob=2Ec<br>=
A src/openvpn/oob=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec=
<br>M src/openvpn/ssl_pkt=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<b=
r>A tests/unit_tests/openvpn/test_oob=2Ec<br>11 files changed, 824 insertio=
ns(+), 4 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/41/1741/14</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMak=
eLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 6eb5954=2E=2Efbc69f0 =
100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLi=
sts=2Etxt</span><br><span>@@ -445,6 +445,8 @@</span><br><span>     src/open=
vpn/console=2Ec</span><br><span>     src/openvpn/console_builtin=2Ec</span>=
<br><span>     src/openvpn/console=2Eh</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    src/openvpn/control_msg=2Ec</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    src/openvpn/control_msg=2Eh</span><br><s=
pan>     src/openvpn/crypto=2Ec</span><br><span>     src/openvpn/crypto=2Eh=
</span><br><span>     src/openvpn/crypto_backend=2Eh</span><br><span>@@ -52=
3,6 +525,8 @@</span><br><span>     src/openvpn/multi_io=2Ec</span><br><span=
>     src/openvpn/occ=2Ec</span><br><span>     src/openvpn/occ=2Eh</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/oob=2Ec</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/oob=2Eh<=
/span><br><span>     src/openvpn/openvpn=2Ec</span><br><span>     src/openv=
pn/openvpn=2Eh</span><br><span>     src/openvpn/openvpn_win32_resources=2Er=
c</span><br><span>@@ -677,6 +681,7 @@</span><br><span>         &quot;test_m=
buf&quot;</span><br><span>         &quot;test_misc&quot;</span><br><span>  =
       &quot;test_ncp&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        &quot;test_oob&quot;</span><br><span>         &quot;test_op=
tions_parse&quot;</span><br><span>         &quot;test_packet_id&quot;</span=
><br><span>         &quot;test_pkt&quot;</span><br><span>@@ -881,6 +886,13 =
@@</span><br><span>         src/openvpn/session_id=2Ec</span><br><span>    =
     )</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    target_sources(test_oob PRIVATE</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        tests/unit_tests/openvpn/mock_get_random=2Ec</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/c=
ontrol_msg=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   src/openvpn/oob=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        src/openvpn/session_id=2Ec</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        )</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span>     target_sources(test_pkt PRIVATE</span><br><sp=
an>         tests/unit_tests/openvpn/mock_win32_execve=2Ec</span><br><span>=
         src/openvpn/argv=2Ec</span><br><span>diff --git a/src/openvpn/Make=
file=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index 7fd12b4=2E=2E5e=
6b4d9 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><spa=
n>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -53,6 +53,7 @@</span><=
br><span> 	common=2Eh \</span><br><span> 	comp=2Ec comp=2Eh compstub=2Ec \<=
/span><br><span> 	comp-lz4=2Ec comp-lz4=2Eh \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	control_msg=2Ec control_msg=2Eh \</span><br><spa=
n> 	crypto=2Ec crypto=2Eh crypto_backend=2Eh \</span><br><span> 	crypto_ope=
nssl=2Ec crypto_openssl=2Eh \</span><br><span> 	crypto_mbedtls_legacy=2Ec c=
rypto_mbedtls_legacy=2Eh \</span><br><span>@@ -107,6 +108,7 @@</span><br><s=
pan> 	pkcs11=2Ec pkcs11=2Eh pkcs11_backend=2Eh \</span><br><span> 	pkcs11_o=
penssl=2Ec \</span><br><span> 	pkcs11_mbedtls=2Ec \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	oob=2Ec oob=2Eh \</span><br><span> 	open=
vpn=2Ec openvpn=2Eh \</span><br><span> 	options=2Ec options=2Eh \</span><br=
><span> 	options_show=2Ec options_show=2Eh \</span><br><span>diff --git a/s=
rc/openvpn/control_msg=2Ec b/src/openvpn/control_msg=2Ec</span><br><span>ne=
w file mode 100644</span><br><span>index 0000000=2E=2E8d78639</span><br><sp=
an>--- /dev/null</span><br><span>+++ b/src/openvpn/control_msg=2Ec</span><b=
r><span>@@ -0,0 +1,107 @@</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN=
 -- An application to securely tunnel IP networks</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, wi=
th support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             session authentication and key exchange,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encrypti=
on, packet authentication, and</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             packet compression=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software=
; you can redistribute it and/or modify</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Licens=
e version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as p=
ublished by the Free Software Foundation=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  This program is distributed in the hope that it will be useful,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY =
WARRANTY; without even the implied warranty of</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR =
PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  GNU General Public License for more details=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  You should have received a copy of the GNU General Public=
 License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  w=
ith this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;control_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_read_header(=
struct buffer *buf, uint16_t expected_msg_type)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int msg_type =3D buf_read_u16(buf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return msg_type &gt;=3D 0 &amp;&amp; (uin=
t16_t)msg_type =3D=3D expected_msg_type;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_write_header(struc=
t buffer *buf, uint16_t type, bool optional, uint16_t value_len)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    uint16_t field =3D type &amp; CTRL_MSG_TLV_T=
YPE_MASK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (op=
tional)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        field |=3D CTRL_MS=
G_TLV_OPTIONAL_FLAG;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return bu=
f_write_u16(buf, field) &amp;&amp; buf_write_u16(buf, value_len);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_m=
sg_tlv_read_header(struct buffer *buf, struct ctrl_msg_tlv_header *hdr)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int field =3D buf_read_u16(buf);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (field &lt; 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    int len =3D buf_read_u16(buf);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (len &lt; 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    hdr-&gt;type =3D (uint16_t)(field &amp; CTRL_MSG_TLV_TY=
PE_MASK);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hdr-&g=
t;optional =3D (field &amp; CTRL_MSG_TLV_OPTIONAL_FLAG) !=3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt;value_len =3D (uint=
16_t)len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ctrl_msg_find_tlv(struct buffer *payload, uint16_t wanted_type, s=
truct buffer *value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_m=
sg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   bool found =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    while (BLEN(payload) &gt; 0)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (!ctrl_msg_tlv_read_header(payload, &amp;hdr))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* bytes remain but too few f=
or a header: truncated */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            return false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* Take the value out of payload=2E This validates that the heade=
r&#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * l=
ength is really there and advances past it in one step, so the TLV</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+         * we are looking fo=
r and the ones we skip are bounds-checked alike=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uint8_t *v =3D buf_read_alloc(pay=
load, hdr=2Evalue_len);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (!v)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (hd=
r=2Etype =3D=3D wanted_type)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (!found)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             buf_set_read(value, v, hdr=2Evalue_len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                found =3D true;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        else if (!hdr=2Eoptional)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* A TLV we do not understand=
 that the sender did not mark optional</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+             * carries something it requires us to act o=
n, so the message as a</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+             * whole is not ours to interpret=2E This is why the scan co=
ntinues</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
 * past the wanted type: such a TLV invalidates the message wherever</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+             * in the sequ=
ence it sits=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           return false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return found;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>dif=
f --git a/src/openvpn/control_msg=2Eh b/src/openvpn/control_msg=2Eh</span><=
br><span>new file mode 100644</span><br><span>index 0000000=2E=2Eb98dce5</s=
pan><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/control_msg=
=2Eh</span><br><span>@@ -0,0 +1,106 @@</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP=
/UDP port, with support for SSL/TLS-based</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *             session authentication and key exchang=
e,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pa=
cket encryption, packet authentication, and</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@o=
penvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is =
free software; you can redistribute it and/or modify</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General=
 Public License version 2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  as published by the Free Software Foundation=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  This program is distributed in the hope that it wi=
ll be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  bu=
t WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR=
 A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  GNU General Public License for more details=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU =
General Public License along</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/lic=
enses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Framing shared by the TLV-based control messages of the wire prot=
ocol=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Such a message payload sta=
rts with a 16-bit message type, followed by a</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * sequence of TLV entries=2E Each TLV starts wit=
h a 4-byte header: a 16-bit field</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * whose most significant bit is the &quot;optional&quot; fla=
g and whose remaining 15 bits</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * are the type, followed by a 16-bit length giving the size of t=
he value that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * fol=
lows the header=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The message-typ=
e and TLV-type values themselves are specific to the message</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * family carried (out-of-band mes=
sages define theirs in oob=2Eh), so only the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * framing lives here=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnd=
ef CONTROL_MSG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine CONTROL_MSG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffe=
r=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* TLV header bit layout of=
 the first 16-bit field */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define CTRL_MSG_TLV_OPTIONAL_FLAG 0x8000</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define CTRL_MSG_TLV_TYPE_MASK     0x7fff</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* The header every TLV carries: the 15-b=
it type and optional flag packed into</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * the first 16-bit field, then the length of the value t=
hat follows=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
ruct ctrl_msg_tlv_header</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t =
type;      /**&lt; the 15-bit TLV type */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    bool optional;      /**&lt; value of the optional=
 flag */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_=
t value_len; /**&lt; length of the value following the header */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read=
 and verify a message-type header from buf, advancing past it=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param buf                buffer positioned =
at the message payload</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param expected_msg_type  the message type the payload must carry</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if a me=
ssage type was read and equals expected_msg_type,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *         false on a short buffer or a misma=
tching type=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_read_he=
ader(struct buffer *buf, uint16_t expected_msg_type);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Write a TLV header (type + optional flag + value length) to buf=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false if buf =
has insufficient space=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_=
msg_tlv_write_header(struct buffer *buf, uint16_t type, bool optional,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
       uint16_t value_len);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read a TLV header from b=
uf, advancing past it=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param bu=
f  buffer positioned at the TLV header</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param hdr  filled with the type, optional flag and v=
alue length on success</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @return true on success, false if there are not enough bytes for a he=
ader=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_read_heade=
r(struct buffer *buf, struct ctrl_msg_tlv_header *hdr);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Scan payload for the first TLV of type wanted_type, skipping any other =
(e=2Eg=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * future)=
 TLV type that is marked optional=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * The whole sequence is walked, including the part after the wanted type: =
a TLV</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * we do not u=
nderstand and that is not marked optional invalidates the message</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * wherever it sits, and reje=
cting it is the point of the remaining scan=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * On success value covers exactly the found TLV&#39;s value byte=
s=2E The length from</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * each TLV header is validated against payload as the scan goes, so the w=
hole</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * value is gua=
ranteed to be present; a header claiming more bytes than payload</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * holds is rejected rather th=
an reported as found=2E payload is consumed as it is</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * read=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param payload      buffer positioned at a TLV header</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param wanted_type  the TLV=
 type to look for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param value        set to a buffer covering the found TLV&#39;s value</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if the =
TLV was found, false if it is not present, a TLV header</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *         or value is malformed or tru=
ncated, or a TLV we do not understand is</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *         not marked optional=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+bool ctrl_msg_find_tlv(struct buffer *payload, uint16_t =
wanted_type, struct buffer *value);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif /* ifndef CONTROL_MSG_H */</span><br><span>diff --git a/src/openvpn/oob=
=2Ec b/src/openvpn/oob=2Ec</span><br><span>new file mode 100644</span><br><=
span>index 0000000=2E=2Ec807171</span><br><span>--- /dev/null</span><br><sp=
an>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -0,0 +1,83 @@</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel I=
P networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
      over a single TCP/UDP port, with support for SSL/TLS-based</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *             session authent=
ication and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *             packet encryption, packet authentication, and</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compre=
ssion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 =
OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  This program is free software; you can redistribute it and/or modify=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the te=
rms of the GNU General Public License version 2</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundatio=
n=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed =
in the hope that it will be useful,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warr=
anty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANT=
ABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more=
 details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have recei=
ved a copy of the GNU General Public License along</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https=
://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_=
H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;con=
fig=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+oob_probe_parameter_write(struct buffer *buf, const =
struct oob_probe_parameter *p)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn ctrl_msg_tlv_write_header(buf, OOB_TLV_PROBE_PARAMETER, false, OOB_PROB=
E_PARAMETER_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
        &amp;&amp; buf_write_u64(buf, p-&gt;timestamp)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u32(buf,=
 p-&gt;flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
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
ile mode 100644</span><br><span>index 0000000=2E=2Ec5396b3</span><br><span>=
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
>+                                        *   used unless the client config=
ured its own */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
uint16_t connect_lifetime;         /**&lt; seconds the reply stays valid as=
 the handshake reset */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    uint32_t flags;                    /**&lt; server behaviour flags *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Write a complete probe parameter TLV (header + value) to buf=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool oob_probe_parameter_write(struct b=
uffer *buf, const struct oob_probe_parameter *p);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Re=
ad a probe parameter TLV value from buf=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * buf must cover exactly the TLV&#39;s value, as returned by ctrl_ms=
g_find_tlv()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * T=
railing bytes beyond the fields understood here are ignored, so a longer</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * value from a future=
 version still parses=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return t=
rue on success, false if buf is shorter than the mandatory fields=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
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
w file mode 100644</span><br><span>index 0000000=2E=2E70f529e0</span><br><s=
pan>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=
=2Ec</span><br><span>@@ -0,0 +1,340 @@</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP=
/UDP port, with support for SSL/TLS-based</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *             session authentication and key exchang=
e,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pa=
cket encryption, packet authentication, and</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@o=
penvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is =
free software; you can redistribute it and/or modify</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General=
 Public License version 2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  as published by the Free Software Foundation=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  This program is distributed in the hope that it wi=
ll be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  bu=
t WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR=
 A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  GNU General Public License for more details=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU =
General Public License along</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/lic=
enses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &lt;stdarg=2Eh&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &lt;stddef=2Eh&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* Write a probe parameter T=
LV and read it back; fields must survive the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * round trip and the whole buffer must be consume=
d=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_parameter=
_roundtrip(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc=
_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const struct oob_probe_parameter in =3D {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        =2Etimestamp =3D 0x012=
3456789abcdefULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      =2Eflags =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(oob_probe_parameter_write(&amp;buf, &amp;in));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* header (4) + value (12) */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&=
amp;buf), 4 + OOB_PROBE_PARAMETER_LEN);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* the header codec, read from a copy so the scan below still sees it =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer=
 peek =3D buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(ctrl_msg_tlv_read_header(&amp;peek, &amp;hdr));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(hdr=2Etype, OOB_TLV_PROBE_PARAMETER);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_false(hdr=2Eoptional);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Evalue_len, OOB=
_PROBE_PARAMETER_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffe=
r value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(ctrl_msg_find_tlv(&amp;buf, OOB_TLV_PROBE_PARAMETER, &amp;value));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BL=
EN(&amp;value), OOB_PROBE_PARAMETER_LEN);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct oob_probe_parameter out =3D { 0 };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_true(oob_probe_parameter_read(&amp;=
value, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(in=2Etimestamp =3D=3D out=2Etimestamp);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Eflags, out=2Ef=
lags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the sc=
an consumed header and value alike */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Write a prob=
e reply TLV and read it back=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+test_probe_reply_roundtrip(void **state)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply in =3D=
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Epriori=
ty =3D 10,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
=2Eweight =3D 100,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       =2Econnect_lifetime =3D 30,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        =2Eflags =3D 1,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        =2Emax_latency_diff =3D 25,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    memcpy(in=2Epeer_session_id=2Eid, &quot;ABCDEFGH&=
quot;, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_p=
robe_reply_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 4 + OOB_PROBE_REPLY_=
LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct buffer peek =3D buf;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_t=
lv_header hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(ctrl_msg_tlv_read_header(&amp;peek, &amp;hdr));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, OOB=
_TLV_PROBE_REPLY);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(hdr=2Evalue_len, OOB_PROBE_REPLY_LEN);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer value;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_find_tlv(&amp;buf, OOB_TL=
V_PROBE_REPLY, &amp;value));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 oob_probe_reply out =3D { 0 };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(oob_probe_reply_read(&amp;value, &amp;out));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equa=
l(in=2Epeer_session_id=2Eid, out=2Epeer_session_id=2Eid, SID_SIZE);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Ep=
riority, out=2Epriority);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(in=2Eweight, out=2Eweight);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Econnect_lifeti=
me, out=2Econnect_lifetime);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_int_equal(in=2Eflags, out=2Eflags);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Emax_latency_d=
iff, out=2Emax_latency_diff);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The probe reply wire=
 format is locked to the spec&#39;s field order</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * (priority, weight, max_latency_diff, connect=
_lifetime, flags), big-endian=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+test_probe_reply_wire_format(void **state)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply in =
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
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Bytes l=
eft over after the last TLV that are too few for a header make the</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * message malformed, even w=
hen the wanted TLV was already found=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_find_tlv_trailing_bytes(void **state)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* 1 to 3 bytes: less than a 4-byte TLV header *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int trail=
ing =3D 1; trailing &lt;=3D 3; trailing++)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        const struct oob_pro=
be_parameter in =3D { =2Etimestamp =3D 1, =2Eflags =3D 0 };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        assert_true(oob_probe_param=
eter_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        for (int i =3D 0; i &lt; trailing; i++)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            assert_true(buf_write_u8(&amp;buf=
, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_false(ct=
rl_msg_find_tlv(&amp;buf, OOB_TLV_PROBE_PARAMETER, &amp;value));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* An unknown TLV marke=
d optional after the wanted one is skipped, and the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * wanted value is still the one returned=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_find_tlv_skips_o=
ptional_after_wanted(void **state)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_parameter in =
=3D { =2Etimestamp =3D 7, =2Eflags =3D 0 };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(oob_probe_parameter_write(&amp;buf,=
 &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, true, 4));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&am=
p;buf, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_fi=
nd_tlv(&amp;buf, OOB_TLV_PROBE_PARAMETER, &amp;value));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), =
OOB_PROBE_PARAMETER_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct oob_probe_parameter out =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_parameter_read(=
&amp;value, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(out=2Etimestamp =3D=3D 7);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* An empty payload holds n=
o TLV=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_find_tlv_em=
pty_payload(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct g=
c_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct buffer buf =3D alloc_buf_gc(16, &amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_find_tlv(&amp;buf, OOB_TL=
V_PROBE_PARAMETER, &amp;value));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc=
_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Reading a TLV header must fail when th=
e buffer holds less data than a</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * complete 4-byte header (empty, or only the type field), rath=
er than read</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * past=
 the available data=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+te=
st_tlv_header_truncated(void **state)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_header hdr;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* empty buffer */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_tlv_read_header=
(&amp;buf, &amp;hdr));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* only the =
type field present, no length */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(buf_write_u16(&amp;buf, OOB_TLV_PROBE_PARAMETE=
R));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fals=
e(ctrl_msg_tlv_read_header(&amp;buf, &amp;hdr));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+main(void)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    openvpn_unit_test_setup();</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const struct CMUnitTest tests[] =3D {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe=
_parameter_roundtrip),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cmocka_unit_test(test_probe_reply_roundtrip),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_re=
ply_wire_format),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      cmocka_unit_test(test_probe_parameter_forward_compat),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_prob=
e_parameter_too_short),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmocka_unit_test(test_find_tlv_value_truncated),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_find=
_tlv_trailing_bytes),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        cmocka_unit_test(test_find_tlv_skips_optional_after_wanted),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test=
(test_find_tlv_empty_payload),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(test_tlv_header_truncated),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return cmocka_run_group_tests_name(&quot;oob tests&quot;, t=
ests, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">change 1741</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c8d302ac57c5603=
d622a7be14be369437388268 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1741 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 14 </div>=

<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: sti=
pa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--YGV0E54rGJU=--


--===============3787890358099140663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3787890358099140663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3787890358099140663==--

