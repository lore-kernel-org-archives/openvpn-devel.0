Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D35A606A33C
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZC+00kPn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Pa+JSC4E;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eTrtvaeG;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bKoOf9sS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jl6XhiuVbeywN4NUjvHzGkh418hanp44whyQ2YFy5pQ=; b=ZC+00kPnjxONZ8M55cfoW+7zN8
	ayV/Cd3SWzVoFoF8Y/MwIqjVHvmFWNh44fEzDtxnp5u4R7+TWKiFbbt7d8RdarYdjV0G5UXLLfMMn
	42zwvmTCKkN2ALJp6QdY+Ka3b0dFg4qtswrPPQObna7iJKT7hHyUu21yyPu3G3dENx+s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOc06-000000002Yh-3eeZ;
	Wed, 04 Nov 2026 14:30:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOc05-000000002Yb-26si
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 14:30:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zJqfSGTjg8RRmeki0TiQHQcEsEuGtkgrvQwNdD7RuxI=; b=Pa+JSC4EciiUIIt/OROHEbVr9F
 JHwFU6qLI4mZ3KxpgTfLoAfUvZfzUANbHLrVIEP43DLA40EXKm+I08/AsNPUw0Yh6N8ujI6lCz5eY
 8CelrgjV3MozXCAHKhJ/zP65LlADwkd/F65mfkf9AX/cwZesBG2GGh4HxqDbryPYzY2Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zJqfSGTjg8RRmeki0TiQHQcEsEuGtkgrvQwNdD7RuxI=; b=eTrtvaeGXrgz31CsU8C1duhNm6
 TYG71ov5va9Vdvl6rF/PlVzSz5f/kOtJIzrEeutuasfH34vgizspYygToAmG3MMYhC+FGleZYeCMy
 HHxkAe1wSe2nlpNfu16x+cp9DzbAKWQYOGSwe/GnPnqF6wB483y7Fn7z6TbjOOdvwhPw=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xObzw-0000000035X-1nNc for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 14:30:05 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso686525f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 06:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793802590; x=1794407390; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zJqfSGTjg8RRmeki0TiQHQcEsEuGtkgrvQwNdD7RuxI=;
 b=bKoOf9sSdl3fuUYtj6jCQ1e7EJfsVYTTawGcz2IEuoQGvV9PiM+KhnHGrNRdune71u
 zVt7zcxTtABOrb2WTbU8A3vmX2+AFkD1/hZprI/8Rr16TTaDMGdgBbwJXctVje5jQsZB
 a+MvLfzLjhgZvWi2+85eTAumSQVDjS/MoR6gG/nP89HRUnJr6JO74iMJ4WQO5zCUfqJB
 4cS4jGZPn8miOr6Z/S7Kvve373UOVSN7JsaJiUnBYXq0etlmGiFqGL294bOWFzhotW5c
 V79fuQ+CVHLmkHShVz9yy/Npjwu/Tsf3Qlp5ANIL4s9VduWq0DmDfoq0FqASMmzFSv71
 7wEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793802590; x=1794407390;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zJqfSGTjg8RRmeki0TiQHQcEsEuGtkgrvQwNdD7RuxI=;
 b=L0kTkXCMemzwRK8EvM1v7oOlYaSV3dpk9MMpX2FmqVSY6kXtEJdzPnsrXfG7XISXAh
 hDoTKUdaqSfcTYAtJkcGZGY4IZy/+HnCNlB4U1DuOBkPQnCFvYrUbL350C/pnbR1k9lD
 TGjhW1OLsqwb08d5hy6f1UiDBmfqmVTTjcWmJhzDyFdE1ppjtQUQwrAO0J9uaiYy6Eix
 8jedbtDNOS78d4QCqH+2CjvfwnCdapvY3+qbgAm26l4PdLCklNep8x98oozidNcUBEF0
 Hq4FPG0HOYfASSNAcn+rX5BZFb0lECF5gNrv4ylMa69Gsu1wXni3x8mfgGcl0sdyNvc+
 89uQ==
X-Gm-Message-State: APuU4Z+7usfjNMDC33CeccP1Rhh5sV17YnzGacyZjWV4JypgnUYzH8If
 X+K2ZbEwIKGbwcG+vDYARrqvWdxY5jI2rMj6mzJV0ZifbCZxCvng7xDdEXbAT77vAzZaCRYZq0V
 H+qhXHijeJDe2Zjm/QYnt9fkN20ElvkqF15PesHZgvXEKCYyrz6WNqryVhxNg8Jpny/dknt5oBj
 F1MKCYEw==
X-Gm-Gg: AYBFou19/vRdGzjjubL0mS23Nc1F38Qq2sBLn8YVRKYyh+uerZ1HFJaT5omEkXAfOMz
 P16YWfCYMFRbx5dIwIo6VUZg+D2WdAEruJSOLu16jku1s49xVQTAPkNzjTh1BiVJSrvZ6pU88bd
 n8DkitvdUWnwY8sApjkOCpeEQ0SqTEyTGoJzoERyQ9u9w2yOZDHvnTCZyhe31q7lwGX63G7Mw61
 b6xtx1pCeVK8vks+OIFzJpXxuikSr8v4BcqgxYymz9GpVFJwF5dtzpCttXkUy+W2IOyW4gRXWaH
 rCzchGQAJvpEI/JB8p5xsyXRoACqQSAvEa/VIroOR6oicAr1YR9VMNkY95BF7qEe3PwsxIYrwVP
 q8Mi9KKPrvNfSd6mIJiu/AICrdNZBzWG7wqPPAQ1iTkO5SXKhe3S6KfJr3r1yyJjJo95N/3qKGi
 eQKEe9I+Wzu24slmB3jP0vOlFnmGhxS6M04AyveVC6ir/OWYd46bScX4+0tGO6AsRDJEq/auODu
 bERwOHdmvrTYsXljgqKxJyAYKG344TPJ6bf9WPatqYefwDepLyrWBMJGFoEIwbTKq+no7PrQKBn
 A86Hg8OSTTMcuoavGRztaUSRk38d5EKlwAoS5SzB4bUxloJ/iVa0MBQIYAA7yIJhH/iZo0eRGXh
 BcTMa7U2J/I/kjCBjPvH9Qiuxr8ZZ6V662MZRbF9N4oqLfd+S6Axn8/pvIhlojbe/mLMK2yUnVp
 9L1d+TDZ2bFxUoJHi0Z7E4FQKvOPoizmw5rV8=
X-Received: by 2002:a05:6000:40c7:b0:48d:f1b3:c02e with SMTP id
 ffacd0b85a97d-48e6e5016f1mr37743448f8f.25.1793802588312; 
 Wed, 04 Nov 2026 06:29:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fea180ee1sm4962889f8f.4.2026.11.04.06.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 06:29:43 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 14:29:40 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: f131316b0e700585165a27cd24f894ec6c9bfb3a
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e436cef8072476b5d6e3ab1a2f37e01fbf1c4dc1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xObzw-0000000035X-1nNc
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add a
 shared TLV codec and use it for early negotiation
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0310661817723645612=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0310661817723645612==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eRXyMXgPZbg="; charset=UTF-8

--eRXyMXgPZbg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
ello Arne Schwabe, Frank Lichtenheld, 

I'd like you to reexamine a change=
=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=
=3Demail

to look at the new patch set (#3)=2E


Change subject: control_ms=
g: Add a shared TLV codec and use it for early negotiation
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

control_msg: Add a shared TL=
V codec and use it for early negotiation

Early negotiation in the reset pa=
ckets is a sequence of TLVs, and
planned out-of-band and control data messa=
ges will use the same TLV
format and type space=2E Add one TLV codec for al=
l of them,
control_msg=2Ec/h, and move early negotiation onto it=2E

The co=
dec only handles the framing: reading and writing TLV headers,
writing a 16=
-bit TLV, and walking a payload TLV by TLV with each value
checked against =
the payload=2E How to treat an unknown type is up to each
message=2E

The c=
odec splits the top bit of the type field off as the "optional"
flag, which=
 the previous early negotiation parser did not do=2E The flags
TLV is defin=
ed with that bit clear, so the parser only accepts it when
the bit is clear=
 and skips the type word 0x8001 as unknown exactly as
before=2E No function=
al change=2E

Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Signed-o=
ff-by: Lev Stipakov <lev@openvpn=2Enet>
---
M CMakeLists=2Etxt
M src/openvp=
n/Makefile=2Eam
A src/openvpn/control_msg=2Ec
A src/openvpn/control_msg=2Eh=

M src/openvpn/ssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
=
M tests/unit_tests/openvpn/Makefile=2Eam
A tests/unit_tests/openvpn/test_co=
ntrol_msg=2Ec
M tests/unit_tests/openvpn/test_pkt=2Ec
10 files changed, 454=
 insertions(+), 23 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/65/1965/3

diff --git a/CMakeLists=2Etxt b/CMakeL=
ists=2Etxt
index 5cf1a30=2E=2E305c26c 100644
--- a/CMakeLists=2Etxt
+++ b/C=
MakeLists=2Etxt
@@ -457,6 +457,8 @@
     src/openvpn/console=2Ec
     src/o=
penvpn/console_builtin=2Ec
     src/openvpn/console=2Eh
+    src/openvpn/co=
ntrol_msg=2Ec
+    src/openvpn/control_msg=2Eh
     src/openvpn/crypto=2Ec
=
     src/openvpn/crypto=2Eh
     src/openvpn/crypto_backend=2Eh
@@ -896,6 +=
898,8 @@
 
     target_sources(test_pkt PRIVATE
         tests/unit_tests/o=
penvpn/mock_win32_execve=2Ec
+        tests/unit_tests/openvpn/test_control=
_msg=2Ec
+        src/openvpn/control_msg=2Ec
         src/openvpn/argv=2Ec=

         src/openvpn/base64=2Ec
         src/openvpn/crypto_epoch=2Ec
diff=
 --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index bb3105=
3=2E=2Ebe1044d 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Mak=
efile=2Eam
@@ -57,6 +57,7 @@
 	common=2Eh \
 	comp=2Ec comp=2Eh compstub=2E=
c \
 	comp-lz4=2Ec comp-lz4=2Eh \
+	control_msg=2Ec control_msg=2Eh \
 	cry=
pto=2Ec crypto=2Eh crypto_backend=2Eh \
 	crypto_openssl=2Ec crypto_openssl=
=2Eh \
 	crypto_mbedtls=2Ec crypto_mbedtls=2Eh \
diff --git a/src/openvpn/c=
ontrol_msg=2Ec b/src/openvpn/control_msg=2Ec
new file mode 100644
index 000=
0000=2E=2Ee3e4b17
--- /dev/null
+++ b/src/openvpn/control_msg=2Ec
@@ -0,0 +=
1,85 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+=
 *             over a single TCP/UDP port, with support for SSL/TLS-based
+=
 *             session authentication and key exchange,
+ *             pac=
ket encryption, packet authentication, and
+ *             packet compressi=
on=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ =
*
+ *  This program is free software; you can redistribute it and/or modify=

+ *  it under the terms of the GNU General Public License version 2
+ *  a=
s published by the Free Software Foundation=2E
+ *
+ *  This program is dis=
tributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY;=
 without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A=
 PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more de=
tails=2E
+ *
+ *  You should have received a copy of the GNU General Public=
 License along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg=
/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
=
+
+#include "syshead=2Eh"
+
+#include "control_msg=2Eh"
+
+bool
+ctrl_msg_t=
lv_write_header(struct buffer *buf, uint16_t type, bool optional, uint16_t =
value_len)
+{
+    /* the type has 15 bits; the top bit is the optional fla=
g */
+    ASSERT(type <=3D CTRL_MSG_TLV_TYPE_MASK);
+    uint16_t field =3D=
 type;
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
+ctrl_msg_tlv_write_u16(struct buffer *buf, uint16_t t=
ype, bool optional, uint16_t value)
+{
+    return ctrl_msg_tlv_write_heade=
r(buf, type, optional, sizeof(uint16_t))
+           && buf_write_u16(buf, =
value);
+}
+
+bool
+ctrl_msg_tlv_read_header(struct buffer *buf, struct ctr=
l_msg_tlv_header *hdr)
+{
+    int field =3D buf_read_u16(buf);
+    if (fi=
eld < 0)
+    {
+        return false;
+    }
+    int len =3D buf_read_u16=
(buf);
+    if (len < 0)
+    {
+        return false;
+    }
+    hdr->typ=
e =3D (uint16_t)(field & CTRL_MSG_TLV_TYPE_MASK);
+    hdr->optional =3D (f=
ield & CTRL_MSG_TLV_OPTIONAL_FLAG) !=3D 0;
+    hdr->value_len =3D (uint16_=
t)len;
+    return true;
+}
+
+bool
+ctrl_msg_tlv_next(struct buffer *buf, =
struct ctrl_msg_tlv_header *hdr, struct buffer *value)
+{
+    if (!ctrl_ms=
g_tlv_read_header(buf, hdr))
+    {
+        return false; /* fewer than 4 =
bytes left: truncated header */
+    }
+    /* Advance past the value; fail=
s if buf is shorter than the header claims=2E */
+    const uint8_t *v =3D =
buf_read_alloc(buf, hdr->value_len);
+    if (!v)
+    {
+        return fa=
lse;
+    }
+    buf_set_read(value, v, hdr->value_len);
+    return true;
=
+}
diff --git a/src/openvpn/control_msg=2Eh b/src/openvpn/control_msg=2Eh
n=
ew file mode 100644
index 0000000=2E=2E7ba5f4d
--- /dev/null
+++ b/src/open=
vpn/control_msg=2Eh
@@ -0,0 +1,100 @@
+/*
+ *  OpenVPN -- An application to=
 securely tunnel IP networks
+ *             over a single TCP/UDP port, wi=
th support for SSL/TLS-based
+ *             session authentication and key=
 exchange,
+ *             packet encryption, packet authentication, and
+ =
*             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVP=
N Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you can=
 redistribute it and/or modify
+ *  it under the terms of the GNU General P=
ublic License version 2
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
+ * TL=
V framing shared by the TLV-based control messages of the wire protocol=2E
=
+ *
+ * Such a message payload is a sequence of TLV entries=2E Each TLV sta=
rts with a
+ * 4-byte header: a 16-bit field whose most significant bit is =
the "optional"
+ * flag and whose remaining 15 bits are the type, followed =
by a 16-bit length
+ * giving the size of the value that follows the header=
=2E
+ *
+ * All of these messages share one TLV type space, so the TLV type=
s are all
+ * defined here=2E Only the framing is handled here: what a mess=
age does with a
+ * TLV type it does not know, marked optional or not, is u=
p to its parser=2E
+ */
+
+#ifndef CONTROL_MSG_H
+#define CONTROL_MSG_H
+
+=
#include "buffer=2Eh"
+
+/* TLV types */
+#define TLV_TYPE_EARLY_NEG_FLAGS =
0x0001 /* early negotiation, in the reset packets */
+
+/* TLV header bit l=
ayout of the first 16-bit field */
+#define CTRL_MSG_TLV_OPTIONAL_FLAG 0x80=
00
+#define CTRL_MSG_TLV_TYPE_MASK     0x7fff
+
+/* The header every TLV ca=
rries: the 15-bit type and optional flag packed into
+ * the first 16-bit f=
ield, then the length of the value that follows=2E */
+struct ctrl_msg_tlv_=
header
+{
+    uint16_t type;      /**< the 15-bit TLV type */
+    bool op=
tional;      /**< value of the optional flag */
+    uint16_t value_len; /*=
*< length of the value following the header */
+};
+
+/**
+ * Write a TLV h=
eader (type + optional flag + value length) to buf=2E
+ * type must fit in =
the 15 bits of the type field=2E
+ *
+ * @return true on success, false if =
buf has insufficient space=2E
+ */
+bool ctrl_msg_tlv_write_header(struct b=
uffer *buf, uint16_t type, bool optional,
+                               u=
int16_t value_len);
+
+/**
+ * Write a complete TLV whose value is a single=
 16-bit integer to buf=2E
+ *
+ * @return true on success, false if buf has=
 insufficient space=2E
+ */
+bool ctrl_msg_tlv_write_u16(struct buffer *buf=
, uint16_t type, bool optional, uint16_t value);
+
+/**
+ * Read a TLV head=
er from buf, advancing past it=2E
+ *
+ * @param buf  buffer positioned at =
the TLV header
+ * @param hdr  filled with the type, optional flag and valu=
e length on success
+ * @return true on success, false if there are not eno=
ugh bytes for a header=2E
+ */
+bool ctrl_msg_tlv_read_header(struct buffer=
 *buf, struct ctrl_msg_tlv_header *hdr);
+
+/**
+ * Read the next TLV from =
buf, advancing past its header and value=2E Call it
+ * while BLEN(buf) > 0=
 to walk a whole payload=2E
+ *
+ * The length from the header is validated=
 against buf, so on success the
+ * whole value is present: a header claimi=
ng more bytes than buf holds is
+ * rejected=2E
+ *
+ * @param buf    buffe=
r positioned at a TLV header
+ * @param hdr    filled with the TLV's type, =
optional flag and value length
+ * @param value  set to a buffer covering e=
xactly the TLV's value; it points
+ *               into buf and owns no st=
orage
+ * @return true on success, false if the header or the value is trun=
cated; buf
+ *         may then be left partly consumed=2E
+ */
+bool ctrl_=
msg_tlv_next(struct buffer *buf, struct ctrl_msg_tlv_header *hdr, struct bu=
ffer *value);
+
+#endif /* ifndef CONTROL_MSG_H */
diff --git a/src/openvpn=
/ssl=2Ec b/src/openvpn/ssl=2Ec
index 12b6119=2E=2Ee531613 100644
--- a/src/=
openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -52,6 +52,7 @@
 #include "pkcs=
11=2Eh"
 #include "route=2Eh"
 #include "tls_crypt=2Eh"
+#include "control_=
msg=2Eh"
 
 #include "crypto_epoch=2Eh"
 #include "ssl=2Eh"
@@ -2645,26 +26=
46,28 @@
 {
     while (buf->len > 0)
     {
-        if (buf_len(buf) < 4)=

-        {
-            goto error;
-        }
-        /* read type */
- =
       int type =3D buf_read_u16(buf);
-        int len =3D buf_read_u16(bu=
f);
-        if (type < 0 || len < 0 || buf_len(buf) < len)
+        struct=
 ctrl_msg_tlv_header hdr;
+        struct buffer value;
+        if (!ctrl_=
msg_tlv_next(buf, &hdr, &value))
         {
             goto error;
      =
   }
 
-        switch (type)
+        switch (hdr=2Etype)
         {
     =
        case TLV_TYPE_EARLY_NEG_FLAGS:
-                if (len !=3D sizeof=
(uint16_t))
+                /* This TLV is defined with the optional bit c=
lear=2E A type
+                 * word that has the bit set is not this TL=
V, so skip it as
+                 * an unknown type rather than parsing it=
 as the flags=2E */
+                if (hdr=2Eoptional)
+                {=

+                    break;
+                }
+                if (BLEN(&=
value) !=3D sizeof(uint16_t))
                 {
                     goto =
error;
                 }
-                int flags =3D buf_read_u16(buf);=

+                int flags =3D buf_read_u16(&value);
 
                 if=
 (flags & EARLY_NEG_FLAG_RESEND_WKC)
                 {
@@ -2683,8 +2686,8 =
@@
                 break;
 
             default:
-                /* Skip=
 types we do not parse */
-                buf_advance(buf, len);
+        =
        /* Skip types we do not parse, marked optional or not */
+         =
       break;
         }
     }
     reliable_mark_deleted(ks->rec_reliable=
, buf);
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
inde=
x f78782f=2E=2Ef4564ef 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openv=
pn/ssl_pkt=2Ec
@@ -33,6 +33,7 @@
 #include "reliable=2Eh"
 #include "siphas=
h=2Eh"
 #include "tls_crypt=2Eh"
+#include "control_msg=2Eh"
 
 /*
  * Depe=
ndent on hmac size, opcode size, and session_id size=2E
@@ -432,9 +433,8 @@=

     /* Add indication for tls-crypt-v2 to resend the WKc with the reply *=
/
     if (request_resend_wkc)
     {
-        buf_write_u16(&buf, TLV_TYPE=
_EARLY_NEG_FLAGS); /* TYPE: flags */
-        buf_write_u16(&buf, sizeof(ui=
nt16_t));
-        buf_write_u16(&buf, EARLY_NEG_FLAG_RESEND_WKC);
+       =
 ASSERT(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false,
+    =
                                  EARLY_NEG_FLAG_RESEND_WKC));
     }
 
   =
  /* Add tls-auth/tls-crypt wrapping, this might replace buf with
diff --gi=
t a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 8203e4a=2E=2E21=
8c6bb 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@=
 -306,10 +306,8 @@
 #define EARLY_NEG_START 0x0f000000
 
 
-/* Early negoti=
ation that part of the server response in the RESET_V2 packet=2E
- * Since =
clients that announce early negotiation support will treat the payload
- * =
of reset packets special and parse it as TLV messages=2E
- * as TLV (type, =
length, value) */
-#define TLV_TYPE_EARLY_NEG_FLAGS  0x0001
+/* Early negot=
iation: clients that announce support for it parse the payload of
+ * the r=
eset packets as TLVs (see control_msg=2Eh)=2E Flags carried in the value of=

+ * the TLV_TYPE_EARLY_NEG_FLAGS TLV: */
 #define EARLY_NEG_FLAG_RESEND_WK=
C 0x0001
 #endif /* ifndef SSL_PKT_H */
diff --git a/tests/unit_tests/openv=
pn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 70cf7b2=2E=
=2E3f5b987 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/=
unit_tests/openvpn/Makefile=2Eam
@@ -164,11 +164,13 @@
 	-I$(top_srcdir)/in=
clude -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	@TEST_CFLA=
GS@
 pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
-pkt_testdriver_SOURCES =3D =
test_pkt=2Ec mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec test_common=2E=
h \
+pkt_testdriver_SOURCES =3D test_pkt=2Ec test_control_msg=2Ec mock_msg=
=2Ec mock_msg=2Eh mock_win32_execve=2Ec \
+	test_common=2Eh \
 	$(top_srcdi=
r)/src/compat/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/argv=2Ec \
 =
	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=
=2Ec \
+	$(top_srcdir)/src/openvpn/control_msg=2Ec \
 	$(top_srcdir)/src/op=
envpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \
 	$(top_s=
rcdir)/src/openvpn/crypto_mbedtls=2Ec \
diff --git a/tests/unit_tests/openv=
pn/test_control_msg=2Ec b/tests/unit_tests/openvpn/test_control_msg=2Ec
new=
 file mode 100644
index 0000000=2E=2Eea0ae0d
--- /dev/null
+++ b/tests/unit=
_tests/openvpn/test_control_msg=2Ec
@@ -0,0 +1,192 @@
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
+#ifdef=
 HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+=
#include <stdarg=2Eh>
+#include <stddef=2Eh>
+#include <setjmp=2Eh>
+#inclu=
de <cmocka=2Eh>
+
+#include "control_msg=2Eh"
+#include "ssl_pkt=2Eh"
+#inc=
lude "test_common=2Eh"
+
+/* The early negotiation flags TLV of a reset pac=
ket asking a tls-crypt-v2
+ * client to resend its WKc, as older versions w=
rote it by hand=2E */
+static void
+test_tlv_write_u16_wire_format(void **s=
tate)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D a=
lloc_buf_gc(16, &gc);
+
+    assert_true(ctrl_msg_tlv_write_u16(&buf, TLV_T=
YPE_EARLY_NEG_FLAGS, false,
+                                       EARLY_N=
EG_FLAG_RESEND_WKC));
+    const uint8_t expected[] =3D { 0x00, 0x01, 0x00,=
 0x02, 0x00, 0x01 };
+    assert_int_equal(BLEN(&buf), sizeof(expected));
+=
    assert_memory_equal(BPTR(&buf), expected, sizeof(expected));
+
+    /* =
the optional flag is the most significant bit of the type field */
+    buf=
_clear(&buf);
+    assert_true(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_=
NEG_FLAGS, true, 0));
+    assert_int_equal(BPTR(&buf)[0], 0x80);
+    asse=
rt_int_equal(BPTR(&buf)[1], 0x01);
+
+    gc_free(&gc);
+}
+
+/* A TLV head=
er survives the round trip, the optional flag kept apart from
+ * the 15-bi=
t type=2E */
+static void
+test_tlv_header_roundtrip(void **state)
+{
+    =
struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(16=
, &gc);
+
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x1234, true, 5)=
);
+    assert_int_equal(BLEN(&buf), 4);
+
+    struct ctrl_msg_tlv_header =
hdr;
+    assert_true(ctrl_msg_tlv_read_header(&buf, &hdr));
+    assert_in=
t_equal(hdr=2Etype, 0x1234);
+    assert_true(hdr=2Eoptional);
+    assert_=
int_equal(hdr=2Evalue_len, 5);
+    assert_int_equal(BLEN(&buf), 0);
+
+   =
 gc_free(&gc);
+}
+
+/* Walking a payload returns each TLV in turn, with a =
value covering exactly
+ * its bytes, and consumes the payload=2E */
+stati=
c void
+test_tlv_next_walks_payload(void **state)
+{
+    struct gc_arena g=
c =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(64, &gc);
+
+    as=
sert_true(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 0xa=
bcd));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+=
    assert_true(buf_write_u32(&buf, 0x11223344));
+    assert_true(ctrl_msg=
_tlv_write_header(&buf, 0x5, false, 0)); /* empty value */
+
+    struct ct=
rl_msg_tlv_header hdr;
+    struct buffer value;
+
+    assert_true(ctrl_ms=
g_tlv_next(&buf, &hdr, &value));
+    assert_int_equal(hdr=2Etype, TLV_TYPE=
_EARLY_NEG_FLAGS);
+    assert_false(hdr=2Eoptional);
+    assert_int_equal=
(BLEN(&value), 2);
+    assert_int_equal(buf_read_u16(&value), 0xabcd);
+
+=
    assert_true(ctrl_msg_tlv_next(&buf, &hdr, &value));
+    assert_int_equ=
al(hdr=2Etype, 0x7ff);
+    assert_true(hdr=2Eoptional);
+    assert_int_eq=
ual(BLEN(&value), 4);
+    assert_int_equal(buf_read_u32(&value, NULL), 0x1=
1223344);
+
+    assert_true(ctrl_msg_tlv_next(&buf, &hdr, &value));
+    a=
ssert_int_equal(hdr=2Etype, 0x5);
+    assert_int_equal(BLEN(&value), 0);
+=

+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* A TLV =
header claiming more value bytes than the payload holds is rejected,
+ * ra=
ther than read past the end of the payload=2E */
+static void
+test_tlv_nex=
t_value_truncated(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+ =
   struct buffer buf =3D alloc_buf_gc(64, &gc);
+
+    assert_true(ctrl_msg=
_tlv_write_header(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 8));
+    assert_t=
rue(buf_write_u32(&buf, 0));
+
+    struct ctrl_msg_tlv_header hdr;
+    st=
ruct buffer value;
+    assert_false(ctrl_msg_tlv_next(&buf, &hdr, &value))=
;
+
+    gc_free(&gc);
+}
+
+/* Reading a TLV header must fail when the buf=
fer holds less data than a
+ * complete 4-byte header, rather than read pas=
t the available data=2E */
+static void
+test_tlv_header_truncated(void **s=
tate)
+{
+    struct gc_arena gc =3D gc_new();
+    const uint8_t bytes[] =
=3D { 0x00, 0x01, 0x00 };
+
+    /* 0 to 3 bytes: none, part of the type fi=
eld, the type field, and the type
+     * field with half of the length */
=
+    for (size_t n =3D 0; n <=3D sizeof(bytes); n++)
+    {
+        struct=
 buffer buf =3D alloc_buf_gc(16, &gc);
+        assert_true(buf_write(&buf,=
 bytes, n));
+        struct buffer copy =3D buf;
+
+        struct ctrl_ms=
g_tlv_header hdr;
+        struct buffer value;
+        assert_false(ctrl_=
msg_tlv_read_header(&buf, &hdr));
+        assert_false(ctrl_msg_tlv_next(&=
copy, &hdr, &value));
+    }
+
+    gc_free(&gc);
+}
+
+/* Writing fails, r=
ather than writes a partial TLV, when buf is too small=2E */
+static void
+=
test_tlv_write_no_room(void **state)
+{
+    struct gc_arena gc =3D gc_new(=
);
+
+    struct buffer buf =3D alloc_buf_gc(3, &gc);
+    assert_false(ctr=
l_msg_tlv_write_header(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 2));
+
+    /=
* room for the header but not the value */
+    buf =3D alloc_buf_gc(5, &gc=
);
+    assert_false(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS,=
 false, 1));
+
+    gc_free(&gc);
+}
+
+/* The TLV codec tests run as a gro=
up of pkt_testdriver; see test_pkt=2Ec=2E */
+int
+run_control_msg_tests(vo=
id)
+{
+    const struct CMUnitTest tests[] =3D {
+        cmocka_unit_test=
(test_tlv_write_u16_wire_format),
+        cmocka_unit_test(test_tlv_header=
_roundtrip),
+        cmocka_unit_test(test_tlv_next_walks_payload),
+     =
   cmocka_unit_test(test_tlv_next_value_truncated),
+        cmocka_unit_te=
st(test_tlv_header_truncated),
+        cmocka_unit_test(test_tlv_write_no_=
room),
+    };
+
+    return cmocka_run_group_tests_name("control message T=
LV tests", tests, NULL, NULL);
+}
diff --git a/tests/unit_tests/openvpn/tes=
t_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index fbbb40f=2E=2Ecaa710=
e 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests=
/openvpn/test_pkt=2Ec
@@ -37,6 +37,7 @@
 #include "crypto=2Eh"
 #include "o=
ptions=2Eh"
 #include "ssl_backend=2Eh"
+#include "control_msg=2Eh"
 #inclu=
de "ssl_pkt=2Eh"
 #include "tls_crypt=2Eh"
 
@@ -44,6 +45,8 @@
 #include "r=
eliable=2Eh"
 #include "siphash=2Eh"
 
+int run_control_msg_tests(void); /*=
 test_control_msg=2Ec */
+
 int
 parse_line(const char *line, char **p, con=
st int n, const char *file, const int line_num,
            msglvl_t msglev=
el, struct gc_arena *gc)
@@ -655,6 +658,46 @@
     free_buf(&tas=2Eworkbuf)=
;
 }
 
+/* A reset reply asking a tls-crypt-v2 client to resend its WKc end=
s in the
+ * early negotiation flags TLV, the bytes older versions wrote by=
 hand, and the
+ * TLV parses back=2E */
+static void
+test_generate_reset_=
packet_resend_wkc(void **ut_state)
+{
+    struct tls_auth_standalone tas =
=3D { 0 };
+
+    struct session_id client_id =3D { { 0, 1, 2, 3, 4, 5, 6, =
7 } };
+    struct session_id server_id =3D { { 8, 9, 0, 9, 8, 7, 6, 2 } };=

+
+    tas=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;
+    struct frame frame =
=3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, 0 };
+ =
   tas=2Eframe =3D frame;
+    tas=2Eworkbuf =3D alloc_buf(1600);
+
+    ui=
nt8_t header =3D 0 | (P_CONTROL_HARD_RESET_SERVER_V2 << P_OPCODE_SHIFT);
+
=
+    struct buffer plain =3D
+        tls_reset_standalone(&tas=2Etls_wrap,=
 &tas, &client_id, &server_id, header, false);
+    const int plain_len =3D=
 BLEN(&plain);
+    struct buffer buf =3D
+        tls_reset_standalone(&ta=
s=2Etls_wrap, &tas, &client_id, &server_id, header, true);
+
+    const uin=
t8_t tlv[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };
+    assert_int_equa=
l(BLEN(&buf), plain_len + (int)sizeof(tlv));
+    assert_memory_equal(BPTR(=
&buf) + plain_len, tlv, sizeof(tlv));
+
+    struct buffer payload =3D buf;=

+    assert_true(buf_advance(&payload, plain_len));
+    struct ctrl_msg_t=
lv_header hdr;
+    struct buffer value;
+    assert_true(ctrl_msg_tlv_next=
(&payload, &hdr, &value));
+    assert_int_equal(hdr=2Etype, TLV_TYPE_EARLY=
_NEG_FLAGS);
+    assert_int_equal(buf_read_u16(&value), EARLY_NEG_FLAG_RES=
END_WKC);
+    assert_int_equal(BLEN(&payload), 0);
+
+    free_buf(&tas=2E=
workbuf);
+}
+
 static void
 test_generate_reset_packet_tls_auth(void **ut_=
state)
 {
@@ -791,10 +834,13 @@
         cmocka_unit_test(test_verify_hmac_=
tls_auth),
         cmocka_unit_test(test_verify_hmac_none_out_of_range_ack=
),
         cmocka_unit_test(test_generate_reset_packet_plain),
+        cm=
ocka_unit_test(test_generate_reset_packet_resend_wkc),
         cmocka_unit=
_test(test_generate_reset_packet_tls_auth),
         cmocka_unit_test(test_=
wkc_not_appended_without_key),
         cmocka_unit_test(test_extract_contr=
ol_message)
     };
 
-    return cmocka_run_group_tests_name("pkt tests", =
tests, NULL, NULL);
+    int failed =3D cmocka_run_group_tests_name("pkt te=
sts", tests, NULL, NULL);
+    failed +=3D run_control_msg_tests();
+    re=
turn failed ? 1 : 0;
 }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1965?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Gerrit-Change-Number: 19=
65
Gerrit-PatchSet: 3
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Ge=
rrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>

--eRXyMXgPZbg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Lev Stipak=
ov <strong>uploaded patch set #3</strong> to this change=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail">View Chang=
e</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">control_msg: Add a shared TLV codec and use it for e=
arly negotiation<br><br>Early negotiation in the reset packets is a sequenc=
e of TLVs, and<br>planned out-of-band and control data messages will use th=
e same TLV<br>format and type space=2E Add one TLV codec for all of them,<b=
r>control_msg=2Ec/h, and move early negotiation onto it=2E<br><br>The codec=
 only handles the framing: reading and writing TLV headers,<br>writing a 16=
-bit TLV, and walking a payload TLV by TLV with each value<br>checked again=
st the payload=2E How to treat an unknown type is up to each<br>message=2E<=
br><br>The codec splits the top bit of the type field off as the &quot;opti=
onal&quot;<br>flag, which the previous early negotiation parser did not do=
=2E The flags<br>TLV is defined with that bit clear, so the parser only acc=
epts it when<br>the bit is clear and skips the type word 0x8001 as unknown =
exactly as<br>before=2E No functional change=2E<br><br>Change-Id: I89c3133e=
009dc75dc2c10c607b3f0a24c04e8146<br>Signed-off-by: Lev Stipakov &lt;lev@ope=
nvpn=2Enet&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<=
br>A src/openvpn/control_msg=2Ec<br>A src/openvpn/control_msg=2Eh<br>M src/=
openvpn/ssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<b=
r>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests/unit_tests/openvpn/te=
st_control_msg=2Ec<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>10 files c=
hanged, 454 insertions(+), 23 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/65/1965/3</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 5=
cf1a30=2E=2E305c26c 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br=
><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -457,6 +457,8 @@</span><br=
><span>     src/openvpn/console=2Ec</span><br><span>     src/openvpn/consol=
e_builtin=2Ec</span><br><span>     src/openvpn/console=2Eh</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/control_msg=2Ec</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/control_=
msg=2Eh</span><br><span>     src/openvpn/crypto=2Ec</span><br><span>     sr=
c/openvpn/crypto=2Eh</span><br><span>     src/openvpn/crypto_backend=2Eh</s=
pan><br><span>@@ -896,6 +898,8 @@</span><br><span> </span><br><span>     ta=
rget_sources(test_pkt PRIVATE</span><br><span>         tests/unit_tests/ope=
nvpn/mock_win32_execve=2Ec</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        tests/unit_tests/openvpn/test_control_msg=2Ec</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/control_msg=2E=
c</span><br><span>         src/openvpn/argv=2Ec</span><br><span>         sr=
c/openvpn/base64=2Ec</span><br><span>         src/openvpn/crypto_epoch=2Ec<=
/span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefi=
le=2Eam</span><br><span>index bb31053=2E=2Ebe1044d 100644</span><br><span>-=
-- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=
=2Eam</span><br><span>@@ -57,6 +57,7 @@</span><br><span> 	common=2Eh \</spa=
n><br><span> 	comp=2Ec comp=2Eh compstub=2Ec \</span><br><span> 	comp-lz4=
=2Ec comp-lz4=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	control_msg=2Ec control_msg=2Eh \</span><br><span> 	crypto=2Ec crypto=2Eh =
crypto_backend=2Eh \</span><br><span> 	crypto_openssl=2Ec crypto_openssl=2E=
h \</span><br><span> 	crypto_mbedtls=2Ec crypto_mbedtls=2Eh \</span><br><sp=
an>diff --git a/src/openvpn/control_msg=2Ec b/src/openvpn/control_msg=2Ec</=
span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2Ee3e4=
b17</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/control=
_msg=2Ec</span><br><span>@@ -0,0 +1,85 @@</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  OpenVPN -- An application to securely tunnel IP networks</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a single =
TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             session authentication and key exch=
ange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 packet encryption, packet authentication, and</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sale=
s@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program =
is free software; you can redistribute it and/or modify</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU Gener=
al Public License version 2</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  as published by the Free Software Foundation=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that it =
will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
but WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS F=
OR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  GNU General Public License for more details=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GN=
U General Public License along</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/l=
icenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_m=
sg_tlv_write_header(struct buffer *buf, uint16_t type, bool optional, uint1=
6_t value_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the type has 15 =
bits; the top bit is the optional flag */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ASSERT(type &lt;=3D CTRL_MSG_TLV_TYPE_MASK);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t field =3D t=
ype;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (optiona=
l)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        field |=3D CTRL_MSG_TLV=
_OPTIONAL_FLAG;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_wri=
te_u16(buf, field) &amp;&amp; buf_write_u16(buf, value_len);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tl=
v_write_u16(struct buffer *buf, uint16_t type, bool optional, uint16_t valu=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return ctrl_msg_tlv_write_heade=
r(buf, type, optional, sizeof(uint16_t))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+           &amp;&amp; buf_write_u16(buf, value);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
ctrl_msg_tlv_read_header(struct buffer *buf, struct ctrl_msg_tlv_header *hd=
r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    int field =3D buf_read_u16(buf)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (field &lt;=
 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int len =3D buf_read_u16(buf);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (len &lt; 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    hdr-&gt;type =3D (uint16_t)(field &amp; CTRL_MSG=
_TLV_TYPE_MASK);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 hdr-&gt;optional =3D (field &amp; CTRL_MSG_TLV_OPTIONAL_FLAG) !=3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt;value_len =
=3D (uint16_t)len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_msg_tl=
v_header *hdr, struct buffer *value)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!ctrl_msg_tlv_read_header(buf, hdr))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return false; /* fewer than 4 bytes left: truncated heade=
r */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* Advance past the value=
; fails if buf is shorter than the header claims=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *v =3D buf_read_alloc(=
buf, hdr-&gt;value_len);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!v)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(value, v, hd=
r-&gt;value_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span>diff --git a/src/openvpn/control_msg=2Eh b/src/openvpn/control=
_msg=2Eh</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2E7ba5f4d</span><br><span>--- /dev/null</span><br><span>+++ b/src/openv=
pn/control_msg=2Eh</span><br><span>@@ -0,0 +1,100 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networ=
ks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             ov=
er a single TCP/UDP port, with support for SSL/TLS-based</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *             session authentication =
and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
             packet encryption, packet authentication, and</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN =
Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  T=
his program is free software; you can redistribute it and/or modify</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of t=
he GNU General Public License version 2</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  as published by the Free Software Foundation=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the h=
ope that it will be useful,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY =
or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a co=
py of the GNU General Public License along</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=
=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * TLV framing shared by the TLV-based control messa=
ges of the wire protocol=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Such a=
 message payload is a sequence of TLV entries=2E Each TLV starts with a</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * 4-byte header: a 16-=
bit field whose most significant bit is the &quot;optional&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * flag and whose remaining 15=
 bits are the type, followed by a 16-bit length</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * giving the size of the value that follows th=
e header=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * All of these messages =
share one TLV type space, so the TLV types are all</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * defined here=2E Only the framing is handl=
ed here: what a message does with a</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * TLV type it does not know, marked optional or not, is up=
 to its parser=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#ifndef CONTROL_MSG_H</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define CONTROL_MSG_H</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* TLV types */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define TLV_TYPE_EARLY_NEG_FLAGS 0x0001 /* early negotiation, i=
n the reset packets */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* TLV header bi=
t layout of the first 16-bit field */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define CTRL_MSG_TLV_OPTIONAL_FLAG 0x8000</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define CTRL_MSG_TLV_TYPE_MASK     =
0x7fff</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* The header every TLV carries:=
 the 15-bit type and optional flag packed into</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * the first 16-bit field, then the length of th=
e value that follows=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+struct ctrl_msg_tlv_header</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
uint16_t type;      /**&lt; the 15-bit TLV type */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    bool optional;      /**&lt; value of the=
 optional flag */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  uint16_t value_len; /**&lt; length of the value following the header */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Write a TLV header (type + optional flag + value length) to buf=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * type must fit in the=
 15 bits of the type field=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @ret=
urn true on success, false if buf has insufficient space=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_write_header(struct buffer *buf, =
uint16_t type, bool optional,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                               uint16_t value_len);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Write a complete TLV whose value is a single 16-bit integer to bu=
f=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, fals=
e if buf has insufficient space=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
ool ctrl_msg_tlv_write_u16(struct buffer *buf, uint16_t type, bool optional=
, uint16_t value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Read a TLV header from buf, advan=
cing past it=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf  buffer=
 positioned at the TLV header</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param hdr  filled with the type, optional flag and value leng=
th on success</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @re=
turn true on success, false if there are not enough bytes for a header=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_read_header(struct =
buffer *buf, struct ctrl_msg_tlv_header *hdr);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read =
the next TLV from buf, advancing past its header and value=2E Call it</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * while BLEN(buf) &gt; 0=
 to walk a whole payload=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The le=
ngth from the header is validated against buf, so on success the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * whole value is present: a h=
eader claiming more bytes than buf holds is</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * rejected=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param buf    buffer positioned at a TLV header</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param hdr    filled with the TLV&#39;=
s type, optional flag and value length</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param value  set to a buffer covering exactly the TL=
V&#39;s value; it points</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *               into buf and owns no storage</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @return true on success, false if the hea=
der or the value is truncated; buf</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *         may then be left partly consumed=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_next(struct buffer *buf, struct=
 ctrl_msg_tlv_header *hdr, struct buffer *value);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif /* ifndef CONTROL_MSG_H */</span><br><span>diff --git a/s=
rc/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 12b6119=2E=
=2Ee531613 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span=
>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -52,6 +52,7 @@</span><br><spa=
n> #include &quot;pkcs11=2Eh&quot;</span><br><span> #include &quot;route=2E=
h&quot;</span><br><span> #include &quot;tls_crypt=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot=
;</span><br><span> </span><br><span> #include &quot;crypto_epoch=2Eh&quot;<=
/span><br><span> #include &quot;ssl=2Eh&quot;</span><br><span>@@ -2645,26 +=
2646,28 @@</span><br><span> {</span><br><span>     while (buf-&gt;len &gt; =
0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (buf_len(buf) &lt; 4)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            goto error;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 /* read type */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   int type =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        int len =3D buf_read_u16(buf);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (type &lt; 0 || len &lt; 0 || bu=
f_len(buf) &lt; len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        struct buffer value;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (!ctrl_msg_tlv_next(buf, &amp;hdr,=
 &amp;value))</span><br><span>         {</span><br><span>             goto =
error;</span><br><span>         }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        switch (type)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        switch (hdr=2Etype)</span><br><sp=
an>         {</span><br><span>             case TLV_TYPE_EARLY_NEG_FLAGS:</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (len=
 !=3D sizeof(uint16_t))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                /* This TLV is defined with the optional bit clear=2E A=
 type</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
   * word that has the bit set is not this TLV, so skip it as</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                 * an unknown typ=
e rather than parsing it as the flags=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                if (hdr=2Eoptional)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    break;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                if (BLEN(&amp;va=
lue) !=3D sizeof(uint16_t))</span><br><span>                 {</span><br><s=
pan>                     goto error;</span><br><span>                 }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                int flags=
 =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                int flags =3D buf_read_u16(&amp;value);</span><br><span=
> </span><br><span>                 if (flags &amp; EARLY_NEG_FLAG_RESEND_W=
KC)</span><br><span>                 {</span><br><span>@@ -2683,8 +2686,8 @=
@</span><br><span>                 break;</span><br><span> </span><br><span=
>             default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                /* Skip types we do not parse */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                buf_advance(buf, len);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                /* Skip type=
s we do not parse, marked optional or not */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                break;</span><br><span>         }<=
/span><br><span>     }</span><br><span>     reliable_mark_deleted(ks-&gt;re=
c_reliable, buf);</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/sr=
c/openvpn/ssl_pkt=2Ec</span><br><span>index f78782f=2E=2Ef4564ef 100644</sp=
an><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvp=
n/ssl_pkt=2Ec</span><br><span>@@ -33,6 +33,7 @@</span><br><span> #include &=
quot;reliable=2Eh&quot;</span><br><span> #include &quot;siphash=2Eh&quot;</=
span><br><span> #include &quot;tls_crypt=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><=
br><span> </span><br><span> /*</span><br><span>  * Dependent on hmac size, =
opcode size, and session_id size=2E</span><br><span>@@ -432,9 +433,8 @@</sp=
an><br><span>     /* Add indication for tls-crypt-v2 to resend the WKc with=
 the reply */</span><br><span>     if (request_resend_wkc)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_wri=
te_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS); /* TYPE: flags */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        buf_write_u16(&amp;buf, siz=
eof(uint16_t));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  buf_write_u16(&amp;buf, EARLY_NEG_FLAG_RESEND_WKC);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ASSERT(ctrl_msg_tlv_write_u16(&am=
p;buf, TLV_TYPE_EARLY_NEG_FLAGS, false,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                      EARLY_NEG_FLAG_RE=
SEND_WKC));</span><br><span>     }</span><br><span> </span><br><span>     /=
* Add tls-auth/tls-crypt wrapping, this might replace buf with</span><br><s=
pan>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><b=
r><span>index 8203e4a=2E=2E218c6bb 100644</span><br><span>--- a/src/openvpn=
/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>=
@@ -306,10 +306,8 @@</span><br><span> #define EARLY_NEG_START 0x0f000000</s=
pan><br><span> </span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-/* Early negotiation that part of the server response in the RE=
SET_V2 packet=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Si=
nce clients that announce early negotiation support will treat the payload<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * of reset packets sp=
ecial and parse it as TLV messages=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * as TLV (type, length, value) */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define TLV_TYPE_EARLY_NEG_FLAGS  0x0001</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Early negotiation: cli=
ents that announce support for it parse the payload of</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * the reset packets as TLVs (see contro=
l_msg=2Eh)=2E Flags carried in the value of</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * the TLV_TYPE_EARLY_NEG_FLAGS TLV: */</span><br><=
span> #define EARLY_NEG_FLAG_RESEND_WKC 0x0001</span><br><span> #endif /* i=
fndef SSL_PKT_H */</span><br><span>diff --git a/tests/unit_tests/openvpn/Ma=
kefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index =
70cf7b2=2E=2E3f5b987 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam<=
/span><br><span>@@ -164,11 +164,13 @@</span><br><span> 	-I$(top_srcdir)/inc=
lude -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><sp=
an> 	@TEST_CFLAGS@</span><br><span> pkt_testdriver_LDFLAGS =3D @TEST_LDFLAG=
S@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pkt_testdriver_SOUR=
CES =3D test_pkt=2Ec mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec test_c=
ommon=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pkt_test=
driver_SOURCES =3D test_pkt=2Ec test_control_msg=2Ec mock_msg=2Ec mock_msg=
=2Eh mock_win32_execve=2Ec \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	test_common=2Eh \</span><br><span> 	$(top_srcdir)/src/compat/comp=
at-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/argv=2Ec \</sp=
an><br><span> 	$(top_srcdir)/src/openvpn/base64=2Ec \</span><br><span> 	$(t=
op_srcdir)/src/openvpn/buffer=2Ec \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	$(top_srcdir)/src/openvpn/control_msg=2Ec \</span><br><spa=
n> 	$(top_srcdir)/src/openvpn/crypto=2Ec \</span><br><span> 	$(top_srcdir)/=
src/openvpn/crypto_epoch=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/=
crypto_mbedtls=2Ec \</span><br><span>diff --git a/tests/unit_tests/openvpn/=
test_control_msg=2Ec b/tests/unit_tests/openvpn/test_control_msg=2Ec</span>=
<br><span>new file mode 100644</span><br><span>index 0000000=2E=2Eea0ae0d</=
span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn=
/test_control_msg=2Ec</span><br><span>@@ -0,0 +1,192 @@</span><br><span sty=
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
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ss=
l_pkt=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;test_common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The=
 early negotiation flags TLV of a reset packet asking a tls-crypt-v2</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * client to resend its WK=
c, as older versions wrote it by hand=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+test_tlv_write_u16_wire_format(void **state)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf=
_gc(16, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_=
msg_tlv_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
     EARLY_NEG_FLAG_RESEND_WKC));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const uint8_t expected[] =3D { 0x00, 0x01, 0x00, 0x02, 0x=
00, 0x01 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(BLEN(&amp;buf), sizeof(expected));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf), expecte=
d, sizeof(expected));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the option=
al flag is the most significant bit of the type field */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    buf_clear(&amp;buf);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_writ=
e_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, true, 0));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BPTR(&amp;buf)[0], 0=
x80);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(BPTR(&amp;buf)[1], 0x01);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc=
_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* A TLV header survives the round trip, =
the optional flag kept apart from</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * the 15-bit type=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+test_tlv_header_roundtrip(void **state)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(16, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_wr=
ite_header(&amp;buf, 0x1234, true, 5));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 4);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct ctrl_msg_tlv_header hdr;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_read_hea=
der(&amp;buf, &amp;hdr));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(hdr=2Etype, 0x1234);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(hdr=2Eoptional);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Evalue_l=
en, 5);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fre=
e(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* Walking a payload returns each TLV in turn=
, with a value covering exactly</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * its bytes, and consumes the payload=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+test_tlv_next_walks_payload(void **state)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(64, &amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(ctrl_msg_tlv_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 0=
xabcd));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, true, 4));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;b=
uf, 0x11223344));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x5, false, 0)); /* empty=
 value */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_heade=
r hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bu=
ffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tl=
v_next(&amp;buf, &amp;hdr, &amp;value));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, TLV_TYPE_EARLY_NEG_FL=
AGS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fal=
se(hdr=2Eoptional);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(BLEN(&amp;value), 2);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(buf_read_u16(&amp;value), 0xabc=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_next(&=
amp;buf, &amp;hdr, &amp;value));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(hdr=2Etype, 0x7ff);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(hdr=2Eoptional);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&a=
mp;value), 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(buf_read_u32(&amp;value, NULL), 0x11223344);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_next(&amp;buf, &amp;hdr,=
 &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(hdr=2Etype, 0x5);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(BLEN(&amp;value), 0);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A TLV header=
 claiming more value bytes than the payload holds is rejected,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * rather than read past the end=
 of the payload=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_t=
lv_next_value_truncated(void **state)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(64, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&a=
mp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 8));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_header hdr;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctr=
l_msg_tlv_next(&amp;buf, &amp;hdr, &amp;value));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Reading a TLV header m=
ust fail when the buffer holds less data than a</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * complete 4-byte header, rather than read pas=
t the available data=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
est_tlv_header_truncated(void **state)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const uint8_t bytes[] =3D { 0x00, 0x01, 0x00 };</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* 0 to 3 bytes: none, part of the type =
field, the type field, and the type</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * field with half of the length */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    for (size_t n =3D 0; n &lt;=3D size=
of(bytes); n++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct buf=
fer buf =3D alloc_buf_gc(16, &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        assert_true(buf_write(&amp;buf, bytes, n));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct buffer co=
py =3D buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        struct ctrl_msg_tlv=
_header hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 struct buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        assert_false(ctrl_msg_tlv_read_header(&amp;buf, &amp;hdr));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_false(ctrl=
_msg_tlv_next(&amp;copy, &amp;hdr, &amp;value));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* Writing fails, rather than writes a =
partial TLV, when buf is too small=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+test_tlv_write_no_room(void **state)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct buffer buf =3D alloc_buf_gc(3, &amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_tlv_wri=
te_header(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 2));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* room for the header but not the value */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    buf =3D alloc_buf_gc(5, =
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_false(ctrl_msg_tlv_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 1)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* The TLV codec tests run as a group of pkt_testdriver; see test_pkt=
=2Ec=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+run_control_msg_tests(voi=
d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const struct CMUnitTest tests[]=
 =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmock=
a_unit_test(test_tlv_write_u16_wire_format),</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_tlv_header_roundtrip=
),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_un=
it_test(test_tlv_next_walks_payload),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        cmocka_unit_test(test_tlv_next_value_truncated),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_=
test(test_tlv_header_truncated),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        cmocka_unit_test(test_tlv_write_no_room),</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return cmocka_run_group_tests_name(&quot;control message TLV=
 tests&quot;, tests, NULL, NULL);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>index fbbb4=
0f=2E=2Ecaa710e 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_=
pkt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><=
br><span>@@ -37,6 +37,7 @@</span><br><span> #include &quot;crypto=2Eh&quot;=
</span><br><span> #include &quot;options=2Eh&quot;</span><br><span> #includ=
e &quot;ssl_backend=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><span> #include &q=
uot;ssl_pkt=2Eh&quot;</span><br><span> #include &quot;tls_crypt=2Eh&quot;</=
span><br><span> </span><br><span>@@ -44,6 +45,8 @@</span><br><span> #includ=
e &quot;reliable=2Eh&quot;</span><br><span> #include &quot;siphash=2Eh&quot=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
int run_control_msg_tests(void); /* test_control_msg=2Ec */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><sp=
an> parse_line(const char *line, char **p, const int n, const char *file, c=
onst int line_num,</span><br><span>            msglvl_t msglevel, struct gc=
_arena *gc)</span><br><span>@@ -655,6 +658,46 @@</span><br><span>     free_=
buf(&amp;tas=2Eworkbuf);</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* A reset reply asking a tls-cry=
pt-v2 client to resend its WKc ends in the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * early negotiation flags TLV, the bytes older vers=
ions wrote by hand, and the</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * TLV parses back=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+test_generate_reset_packet_resend_wkc(void **ut_state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct tls_auth_standalone tas =3D { 0 };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct session_id client_id =3D { { 0, 1, =
2, 3, 4, 5, 6, 7 } };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct session_id server_id =3D { { 8, 9, 0, 9, 8, 7, 6, 2 } };</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    tas=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct frame fr=
ame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, 0 }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas=2Eframe =
=3D frame;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas=
=2Eworkbuf =3D alloc_buf(1600);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uin=
t8_t header =3D 0 | (P_CONTROL_HARD_RESET_SERVER_V2 &lt;&lt; P_OPCODE_SHIFT=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct buffer plain =3D</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        tls_reset_standalone=
(&amp;tas=2Etls_wrap, &amp;tas, &amp;client_id, &amp;server_id, header, fal=
se);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int p=
lain_len =3D BLEN(&amp;plain);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct buffer buf =3D</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        tls_reset_standalone(&amp;tas=2Etls_wrap, &amp;tas=
, &amp;client_id, &amp;server_id, header, true);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const uint8_t tlv[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(BLEN(&amp;buf), plain_len + (int)sizeof(tlv));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf) + pla=
in_len, tlv, sizeof(tlv));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct b=
uffer payload =3D buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(buf_advance(&amp;payload, plain_len));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_header hdr;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer val=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(=
ctrl_msg_tlv_next(&amp;payload, &amp;hdr, &amp;value));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, TLV_TY=
PE_EARLY_NEG_FLAGS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(buf_read_u16(&amp;value), EARLY_NEG_FLAG_RESEND_WKC);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(BLEN(&amp;payload), 0);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(=
&amp;tas=2Eworkbuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 static void</span><br><span> test_generate_reset_packet_tls_auth(void **ut=
_state)</span><br><span> {</span><br><span>@@ -791,10 +834,13 @@</span><br>=
<span>         cmocka_unit_test(test_verify_hmac_tls_auth),</span><br><span=
>         cmocka_unit_test(test_verify_hmac_none_out_of_range_ack),</span><=
br><span>         cmocka_unit_test(test_generate_reset_packet_plain),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(=
test_generate_reset_packet_resend_wkc),</span><br><span>         cmocka_uni=
t_test(test_generate_reset_packet_tls_auth),</span><br><span>         cmock=
a_unit_test(test_wkc_not_appended_without_key),</span><br><span>         cm=
ocka_unit_test(test_extract_control_message)</span><br><span>     };</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return=
 cmocka_run_group_tests_name(&quot;pkt tests&quot;, tests, NULL, NULL);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    int failed =3D cmoc=
ka_run_group_tests_name(&quot;pkt tests&quot;, tests, NULL, NULL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    failed +=3D run_control_=
msg_tests();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn failed ? 1 : 0;</span><br><span> }</span><br></pre><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail">chang=
e 1965</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1965 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stip=
akov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--eRXyMXgPZbg=--


--===============0310661817723645612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0310661817723645612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0310661817723645612==--

