Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E07F606A323
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ObK09k78;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TzJOx9tI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=esyHSYUB;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Ha6nwt1L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=d86xd481g+5FYmeyvOHM4MXBEu1mVolROQnnboQP41g=; b=ObK09k78bRCkuW5islz4iS//Yz
	e5kd47TU22+o9uUIiid55YP2ZXxZFLEEkHGdOEqiYkUtiiGZCInqFg4J8BOt6RaaAEX4QzOU4plaS
	2Y0tQjqdjBEDdb4b76ZW+1lYOT9+XZtqt2rIxDIBQf3vVWGkvmlFtv20L2vk1PFP3j/o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQKqy-000000006mf-3iyj;
	Mon, 09 Nov 2026 08:35:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQKqw-000000006mW-3vlP
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 08:35:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wulTtop6JSdYiLEScyhr7blzwhybxbjPklnfJlepaAQ=; b=TzJOx9tICQlerHk+mfAGEYC1HX
 DpAJRGit+j0Sd+Z5xkNHEN0+qgNh1IZ825EG0dbcU5a4aC+r82A8/X5OwP6SPj5yulVqnyNM5i/sg
 16JidoZQshHlcCB6Mb3hGZUykNiLaVx15pvOLABuRPF29R7TjQAH45ITyNDU0x3J3LIw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wulTtop6JSdYiLEScyhr7blzwhybxbjPklnfJlepaAQ=; b=esyHSYUBacI0eys4gGkk7yBHaq
 6v4HF5DMHmpbHhELSA+PkmxI4ivQGvpOI/trgCqfnJx94tMBl+KQJkY0NEOkpJjfCeevVCMoGhGWv
 32/sE/qeO0aWDSa+7Br09lGqLg1XBR39onKkfJRhsmN8RA++SclBj4zE2gmLGLk2/dIQ=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQKqs-0000000083T-48Ow for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 08:35:46 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so5766175e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 00:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794213336; x=1794818136; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wulTtop6JSdYiLEScyhr7blzwhybxbjPklnfJlepaAQ=;
 b=Ha6nwt1LlbnbUo/FO6lfwfu8B0cLCpMY5/LWWtGdZji/4v4GT5ZVRtkjgnBHOscXM1
 XJh6iZoVZEutapRZy6uJEMcb4euti5agcN2tr8FEWI6/NJptY50WYk+1YdDgDp9ZplQx
 3gWFK2cheo8r0mBgWPowXyknk5a+7uPBKs+bago8vaXZFv5LyBscVqUq0CodboeQOtIU
 aM0Udpb/NT4stGHnjMhCach2WufZRXOurbcg8iLC5lg3KceOd6JYjDDqH4+LcNc5E1B0
 Bxxzkv5lv4uRmJ8t8JoOxTPEPyKg9wyNoW1QYvPQI+lXUgBSsUCcS+sT3CvKjv1DIbzr
 pb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794213336; x=1794818136;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wulTtop6JSdYiLEScyhr7blzwhybxbjPklnfJlepaAQ=;
 b=lWO9IZWlLUPfD1cCbeggwPYUyC4GI8tNCjrin+t+CO7lpUKlXES7pnYxeA45GR8wy0
 /Sa1wCYyIUIh33lKWh2tQYvyoynaB9vU03MArp8hzrSDoILqqL8arwWJqocI9qVOSXFB
 yIydq1i68v0h0B/pdMBwR0I6Mbvour99NKR/zgtvlHF6bPy5QXcREWoCG1jZzZQUvwwS
 fLaV/J0LuBvhWP4dt4X4o8Iqb+EqicbkAZ9QhYz9anYdJo7t5lRpeDURS4rO/UCouPJX
 8HRbk7+84Z2A1f17UYF4adqR/dMXzsesISOBeUkeElWSfuFzWjsbrtt9aNE7dsjr920I
 OtMA==
X-Gm-Message-State: APuU4Z9grX/Po2g389cp6ONYi/Yi8dpFZrnSrj3cFMZ7pbCt3CF/eo0Q
 dwwyGXDcUqZZhQMrz4muo0FNFeFSupM3FnTbqhHxQQEsHj1rLaumxeTAhBEJF5k2tzkI5pxSj9Z
 qJmODFaVGj5w6WlRk12+7oU9HA7nr8a0pcqaDXr0P59eCOX246C7qpvhkM36qbuBcDUfk
X-Gm-Gg: AYBFou3v2mcwf30fGkB9YY/oKvXQmm/xfauikI7JLteUIy45nTInYZbEv+JHEctI1vT
 4ll+LuCSUDgA2Nd038zrde/aTAfUDd022mwigCCGEVvw1U8ULPVfcC/4F0/oG+AcKLIpMfBw7S4
 5tEeIJEzOh6ylHZd995dBRr4z7Vg2oyVOIUxn2pew/9Auhf8BZAM4EQxA+lNkkgDv2JtVV4LVpP
 /zmeRyqqIpTHRKCXvCpU5+XVEqBJzyGOTlStF7TopCSUV5lxWiJYZFv89LS0B1r3YSXG3wf9xwF
 Iw02/mRHQVV8WApi7Wih4wzIi72pAzMgXTVCcKwX5WLn6po/BCi4UvKskfCemaUHPzpkSkxxyFc
 Tc3g0sLJIgWld4KfAW3ETcssfZMUazRZ0FGUfeKdWxw24o6xrn6/ME9sTFz8mDOkFEy6TyyM7cD
 wdvS+4TY8S/WKSU7hZjS8mq9xR8e9B6kh/CP2yVvU+HlAVM3t4etrGoQtW6dGhNMg7oUP07uogF
 BiNl/H+LKHSs44cCkqzfHRXX1vQCZXSu+D2tdbgmSYs8sPwbom8F0Rmdu30IupW6Jo040cvZwE1
 U/917vFY58cusFoOlGKIEmuDjx3LTLg+pBSu/FsKcxLUq9Filvt+Ez0i38LjyxPneulizQSvt5F
 bUK4L6UAr2GFlqjdS/LfcV25vJ783PrXLimEE2vTNfWUosLpiJOkNL3JXRPlx6YKXUUkbE3pEX/
 U07ozbwMrX8u/+Rnk5LhEWBEaGKPB9QnAzTV4=
X-Received: by 2002:a05:600c:4f4a:b0:4a2:1a:a11d with SMTP id
 5b1f17b1804b1-4b943f76e74mr78732325e9.0.1794213335696; 
 Mon, 09 Nov 2026 00:35:35 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597652ca7sm9186320f8f.39.2026.11.09.00.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 00:35:35 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 08:35:32 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: 54fb8770bb4a471837160155a0766d92cc2e0ec6
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1b7a21a297dc427aa5fc8d0d99b55b2a44b924c4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQKqs-0000000083T-48Ow
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
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5753645354518926655=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5753645354518926655==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Hou9yrgAJT8="; charset=UTF-8

--Hou9yrgAJT8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, Lev Stipakov, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Coj=
ocaru, 

I'd like you to reexamine a change=2E Please visit

    https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail

to look at the new patch=
 set (#6)=2E

The following approvals got outdated and were removed:
Code-R=
eview+1 by R=C4=83zvan Cojocaru


Change subject: control_msg: Add a shared=
 TLV codec and use it for early negotiation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

control_msg: Add a shared TLV codec and use=
 it for early negotiation

Early negotiation in the reset packets is a sequ=
ence of TLVs, and
planned out-of-band and control data messages will use th=
e same TLV
format and type space=2E Add one TLV codec for all of them,
cont=
rol_msg=2Ec/h, and move early negotiation onto it=2E

The codec only handle=
s the framing: reading and writing TLV headers,
writing a 16-bit TLV, and w=
alking a payload TLV by TLV with each value
checked against the payload=2E =
How to treat an unknown type is up to each
message=2E With the optional fla=
g clear the codec writes the same bytes as
the hand-rolled code it replaces=
=2E

In the codec the most significant bit of the type field is the
"option=
al" flag rather than part of the type=2E The old parser compared
the whole =
type word, so 0x8001 did not match the flags TLV and was
skipped as unknown=
; now it matches and is parsed as one=2E

Change-Id: I89c3133e009dc75dc2c10=
c607b3f0a24c04e8146
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M C=
MakeLists=2Etxt
M src/openvpn/Makefile=2Eam
A src/openvpn/control_msg=2Ec
A=
 src/openvpn/control_msg=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_pkt=2E=
c
M src/openvpn/ssl_pkt=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
A test=
s/unit_tests/openvpn/test_control_msg=2Ec
A tests/unit_tests/openvpn/test_c=
ontrol_msg=2Eh
M tests/unit_tests/openvpn/test_pkt=2Ec
11 files changed, 49=
0 insertions(+), 23 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/65/1965/6

diff --git a/CMakeLists=2Etxt b/CMake=
Lists=2Etxt
index 5cf1a30=2E=2E305c26c 100644
--- a/CMakeLists=2Etxt
+++ b/=
CMakeLists=2Etxt
@@ -457,6 +457,8 @@
     src/openvpn/console=2Ec
     src/=
openvpn/console_builtin=2Ec
     src/openvpn/console=2Eh
+    src/openvpn/c=
ontrol_msg=2Ec
+    src/openvpn/control_msg=2Eh
     src/openvpn/crypto=2Ec=

     src/openvpn/crypto=2Eh
     src/openvpn/crypto_backend=2Eh
@@ -896,6 =
+898,8 @@
 
     target_sources(test_pkt PRIVATE
         tests/unit_tests/=
openvpn/mock_win32_execve=2Ec
+        tests/unit_tests/openvpn/test_contro=
l_msg=2Ec
+        src/openvpn/control_msg=2Ec
         src/openvpn/argv=2E=
c
         src/openvpn/base64=2Ec
         src/openvpn/crypto_epoch=2Ec
dif=
f --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index bb310=
53=2E=2Ebe1044d 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Ma=
kefile=2Eam
@@ -57,6 +57,7 @@
 	common=2Eh \
 	comp=2Ec comp=2Eh compstub=
=2Ec \
 	comp-lz4=2Ec comp-lz4=2Eh \
+	control_msg=2Ec control_msg=2Eh \
 	=
crypto=2Ec crypto=2Eh crypto_backend=2Eh \
 	crypto_openssl=2Ec crypto_open=
ssl=2Eh \
 	crypto_mbedtls=2Ec crypto_mbedtls=2Eh \
diff --git a/src/openvp=
n/control_msg=2Ec b/src/openvpn/control_msg=2Ec
new file mode 100644
index =
0000000=2E=2E872191f
--- /dev/null
+++ b/src/openvpn/control_msg=2Ec
@@ -0,=
0 +1,93 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP network=
s
+ *             over a single TCP/UDP port, with support for SSL/TLS-base=
d
+ *             session authentication and key exchange,
+ *             =
packet encryption, packet authentication, and
+ *             packet compre=
ssion=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>=

+ *
+ *  This program is free software; you can redistribute it and/or mod=
ify
+ *  it under the terms of the GNU General Public License version 2
+ *=
  as published by the Free Software Foundation=2E
+ *
+ *  This program is =
distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRAN=
TY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FO=
R A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more=
 details=2E
+ *
+ *  You should have received a copy of the GNU General Pub=
lic License along
+ *  with this program; if not, see <https://www=2Egnu=2E=
org/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#end=
if
+
+#include "syshead=2Eh"
+
+#include "control_msg=2Eh"
+
+bool
+ctrl_ms=
g_tlv_write_header(struct buffer *buf, uint16_t type, bool optional, uint16=
_t value_len)
+{
+    /* the type has 15 bits; the top bit is the optional =
flag */
+    ASSERT(type <=3D CTRL_MSG_TLV_TYPE_MASK);
+
+    /* Write noth=
ing unless the whole TLV fits=2E The header promises that
+     * value_len=
 bytes follow it, so a header written without room for the
+     * value wo=
uld leave a partial TLV in buf=2E */
+    if (!buf_safe(buf, (size_t)CTRL_M=
SG_TLV_HEADER_LEN + value_len))
+    {
+        return false;
+    }
+    u=
int16_t field =3D type;
+    if (optional)
+    {
+        field |=3D CTRL_=
MSG_TLV_OPTIONAL_FLAG;
+    }
+    return buf_write_u16(buf, field) && buf_=
write_u16(buf, value_len);
+}
+
+bool
+ctrl_msg_tlv_write_u16(struct buffer=
 *buf, uint16_t type, bool optional, uint16_t value)
+{
+    return ctrl_ms=
g_tlv_write_header(buf, type, optional, sizeof(uint16_t))
+           && bu=
f_write_u16(buf, value);
+}
+
+bool
+ctrl_msg_tlv_read_header(struct buffer=
 *buf, struct ctrl_msg_tlv_header *hdr)
+{
+    int field =3D buf_read_u16(=
buf);
+    if (field < 0)
+    {
+        return false;
+    }
+    int len=
 =3D buf_read_u16(buf);
+    if (len < 0)
+    {
+        return false;
+  =
  }
+    hdr->type =3D (uint16_t)(field & CTRL_MSG_TLV_TYPE_MASK);
+    hdr=
->optional =3D (field & CTRL_MSG_TLV_OPTIONAL_FLAG) !=3D 0;
+    hdr->value=
_len =3D (uint16_t)len;
+    return true;
+}
+
+bool
+ctrl_msg_tlv_next(str=
uct buffer *buf, struct ctrl_msg_tlv_header *hdr, struct buffer *value)
+{
=
+    if (!ctrl_msg_tlv_read_header(buf, hdr))
+    {
+        return false;=
 /* fewer than 4 bytes left: truncated header */
+    }
+    /* Advance pas=
t the value; fails if buf is shorter than the header claims=2E */
+    cons=
t uint8_t *v =3D buf_read_alloc(buf, hdr->value_len);
+    if (!v)
+    {
+=
        return false;
+    }
+    buf_set_read(value, v, hdr->value_len);
+=
    return true;
+}
diff --git a/src/openvpn/control_msg=2Eh b/src/openvpn/=
control_msg=2Eh
new file mode 100644
index 0000000=2E=2E7d25545
--- /dev/nu=
ll
+++ b/src/openvpn/control_msg=2Eh
@@ -0,0 +1,107 @@
+/*
+ *  OpenVPN -- =
An application to securely tunnel IP networks
+ *             over a single=
 TCP/UDP port, with support for SSL/TLS-based
+ *             session authe=
ntication and key exchange,
+ *             packet encryption, packet authe=
ntication, and
+ *             packet compression=2E
+ *
+ *  Copyright (C)=
 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free =
software; you can redistribute it and/or modify
+ *  it under the terms of =
the GNU General Public License version 2
+ *  as published by the Free Soft=
ware Foundation=2E
+ *
+ *  This program is distributed in the hope that it=
 will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied wa=
rranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See =
the
+ *  GNU General Public License for more details=2E
+ *
+ *  You should=
 have received a copy of the GNU General Public License along
+ *  with thi=
s program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
+=
 * @file
+ * TLV framing shared by the TLV-based control messages of the wi=
re protocol=2E
+ *
+ * Such a message payload is a sequence of TLV entries=
=2E Each TLV starts with a
+ * 4-byte header: a 16-bit field whose most sig=
nificant bit is the "optional"
+ * flag and whose remaining 15 bits are the=
 type, followed by a 16-bit length
+ * giving the size of the value that fo=
llows the header=2E
+ *
+ * All of these messages share one TLV type space,=
 so the TLV types are all
+ * defined here=2E Only the framing is handled h=
ere: what a message does with a
+ * TLV type it does not know, marked optio=
nal or not, is up to its parser=2E
+ */
+
+#ifndef CONTROL_MSG_H
+#define C=
ONTROL_MSG_H
+
+#include "buffer=2Eh"
+
+/* TLV types */
+#define TLV_TYPE_=
EARLY_NEG_FLAGS 0x0001 /* early negotiation, in the reset packets */
+
+/* =
TLV header bit layout of the first 16-bit field */
+/* A TLV header is a 16=
-bit type/optional field plus a 16-bit length */
+#define CTRL_MSG_TLV_HEAD=
ER_LEN 4
+
+#define CTRL_MSG_TLV_OPTIONAL_FLAG 0x8000
+#define CTRL_MSG_TLV=
_TYPE_MASK     0x7fff
+
+/** The header every TLV carries: the 15-bit type =
and optional flag packed into
+ * the first 16-bit field, then the length o=
f the value that follows=2E */
+struct ctrl_msg_tlv_header
+{
+    uint16_t=
 type;      /**< the 15-bit TLV type */
+    bool optional;      /**< value=
 of the optional flag */
+    uint16_t value_len; /**< length of the value =
following the header */
+};
+
+/**
+ * Write a TLV header (type + optional =
flag + value length) to buf=2E
+ * type must fit in the 15 bits of the type=
 field=2E
+ *
+ * Nothing is written unless the header and the value_len by=
tes of value
+ * that follow it both fit, so a failed write never leaves a =
partial TLV
+ * behind=2E
+ *
+ * @return true on success, false if buf has=
 insufficient space=2E
+ */
+bool ctrl_msg_tlv_write_header(struct buffer *=
buf, uint16_t type, bool optional,
+                               uint16_t=
 value_len);
+
+/**
+ * Write a complete TLV whose value is a single 16-bit=
 integer to buf=2E
+ *
+ * @return true on success, false if buf has insuff=
icient space=2E
+ */
+bool ctrl_msg_tlv_write_u16(struct buffer *buf, uint1=
6_t type, bool optional, uint16_t value);
+
+/**
+ * Read a TLV header from=
 buf, advancing past it=2E
+ *
+ * @param buf  buffer positioned at the TLV=
 header
+ * @param hdr  filled with the type, optional flag and value lengt=
h on success
+ * @return true on success, false if there are not enough byt=
es for a header=2E
+ */
+bool ctrl_msg_tlv_read_header(struct buffer *buf, =
struct ctrl_msg_tlv_header *hdr);
+
+/**
+ * Read the next TLV from buf, ad=
vancing past its header and value=2E Call it
+ * while BLEN(buf) > 0 to wal=
k a whole payload=2E
+ *
+ * The length from the header is validated agains=
t buf, so on success the
+ * whole value is present: a header claiming more=
 bytes than buf holds is
+ * rejected=2E
+ *
+ * @param buf    buffer posit=
ioned at a TLV header
+ * @param hdr    filled with the TLV's type, optiona=
l flag and value length
+ * @param value  set to a buffer covering exactly =
the TLV's value; it points
+ *               into buf and owns no storage
+=
 * @return true on success, false if the header or the value is truncated; =
buf
+ *         may then be left partly consumed=2E
+ */
+bool ctrl_msg_tlv=
_next(struct buffer *buf, struct ctrl_msg_tlv_header *hdr, struct buffer *v=
alue);
+
+#endif /* ifndef CONTROL_MSG_H */
diff --git a/src/openvpn/ssl=2E=
c b/src/openvpn/ssl=2Ec
index 12b6119=2E=2E6dae655 100644
--- a/src/openvpn=
/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -52,6 +52,7 @@
 #include "pkcs11=2Eh"=

 #include "route=2Eh"
 #include "tls_crypt=2Eh"
+#include "control_msg=2Eh=
"
 
 #include "crypto_epoch=2Eh"
 #include "ssl=2Eh"
@@ -2645,26 +2646,21 @=
@
 {
     while (buf->len > 0)
     {
-        if (buf_len(buf) < 4)
-     =
   {
-            goto error;
-        }
-        /* read type */
-        =
int type =3D buf_read_u16(buf);
-        int len =3D buf_read_u16(buf);
-  =
      if (type < 0 || len < 0 || buf_len(buf) < len)
+        struct ctrl_m=
sg_tlv_header hdr;
+        struct buffer value;
+        if (!ctrl_msg_tlv=
_next(buf, &hdr, &value))
         {
             goto error;
         }
 
=
-        switch (type)
+        switch (hdr=2Etype)
         {
            =
 case TLV_TYPE_EARLY_NEG_FLAGS:
-                if (len !=3D sizeof(uint16=
_t))
+                if (BLEN(&value) !=3D sizeof(uint16_t))
             =
    {
                     goto error;
                 }
-                =
int flags =3D buf_read_u16(buf);
+                int flags =3D buf_read_u1=
6(&value);
 
                 if (flags & EARLY_NEG_FLAG_RESEND_WKC)
      =
           {
@@ -2683,8 +2679,8 @@
                 break;
 
             d=
efault:
-                /* Skip types we do not parse */
-                =
buf_advance(buf, len);
+                /* Skip types we do not parse, mark=
ed optional or not */
+                break;
         }
     }
     reliab=
le_mark_deleted(ks->rec_reliable, buf);
diff --git a/src/openvpn/ssl_pkt=2E=
c b/src/openvpn/ssl_pkt=2Ec
index f78782f=2E=2Ef4564ef 100644
--- a/src/ope=
nvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -33,6 +33,7 @@
 #include =
"reliable=2Eh"
 #include "siphash=2Eh"
 #include "tls_crypt=2Eh"
+#include =
"control_msg=2Eh"
 
 /*
  * Dependent on hmac size, opcode size, and sessio=
n_id size=2E
@@ -432,9 +433,8 @@
     /* Add indication for tls-crypt-v2 to=
 resend the WKc with the reply */
     if (request_resend_wkc)
     {
-    =
    buf_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS); /* TYPE: flags */
-     =
   buf_write_u16(&buf, sizeof(uint16_t));
-        buf_write_u16(&buf, EARL=
Y_NEG_FLAG_RESEND_WKC);
+        ASSERT(ctrl_msg_tlv_write_u16(&buf, TLV_TY=
PE_EARLY_NEG_FLAGS, false,
+                                      EARLY_NEG=
_FLAG_RESEND_WKC));
     }
 
     /* Add tls-auth/tls-crypt wrapping, this =
might replace buf with
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/s=
sl_pkt=2Eh
index 8203e4a=2E=2E218c6bb 100644
--- a/src/openvpn/ssl_pkt=2Eh
=
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -306,10 +306,8 @@
 #define EARLY_NEG_START=
 0x0f000000
 
 
-/* Early negotiation that part of the server response in t=
he RESET_V2 packet=2E
- * Since clients that announce early negotiation sup=
port will treat the payload
- * of reset packets special and parse it as TL=
V messages=2E
- * as TLV (type, length, value) */
-#define TLV_TYPE_EARLY_N=
EG_FLAGS  0x0001
+/* Early negotiation: clients that announce support for i=
t parse the payload of
+ * the reset packets as TLVs (see control_msg=2Eh)=
=2E Flags carried in the value of
+ * the TLV_TYPE_EARLY_NEG_FLAGS TLV: */
=
 #define EARLY_NEG_FLAG_RESEND_WKC 0x0001
 #endif /* ifndef SSL_PKT_H */
di=
ff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvp=
n/Makefile=2Eam
index 70cf7b2=2E=2E11f92f4 100644
--- a/tests/unit_tests/op=
envpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -164,11=
 +164,15 @@
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_sr=
cdir)/src/openvpn \
 	@TEST_CFLAGS@
 pkt_testdriver_LDFLAGS =3D @TEST_LDFLA=
GS@
-pkt_testdriver_SOURCES =3D test_pkt=2Ec mock_msg=2Ec mock_msg=2Eh mock=
_win32_execve=2Ec test_common=2Eh \
+pkt_testdriver_SOURCES =3D test_pkt=2E=
c \
+	test_control_msg=2Ec test_control_msg=2Eh \
+	mock_msg=2Ec mock_msg=
=2Eh mock_win32_execve=2Ec \
+	test_common=2Eh \
 	$(top_srcdir)/src/compat=
/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/argv=2Ec \
 	$(top_srcdir=
)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
+	$(top=
_srcdir)/src/openvpn/control_msg=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=
=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \
 	$(top_srcdir)/src/o=
penvpn/crypto_mbedtls=2Ec \
diff --git a/tests/unit_tests/openvpn/test_cont=
rol_msg=2Ec b/tests/unit_tests/openvpn/test_control_msg=2Ec
new file mode 1=
00644
index 0000000=2E=2Ea199baf
--- /dev/null
+++ b/tests/unit_tests/openv=
pn/test_control_msg=2Ec
@@ -0,0 +1,179 @@
+/*
+ *  OpenVPN -- An applicatio=
n to securely tunnel IP networks
+ *             over a single TCP/UDP port=
, with support for SSL/TLS-based
+ *             session authentication and=
 key exchange,
+ *             packet encryption, packet authentication, an=
d
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 Op=
enVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you=
 can redistribute it and/or modify
+ *  it under the terms of the GNU Gener=
al Public License version 2
+ *  as published by the Free Software Foundati=
on=2E
+ *
+ *  This program is distributed in the hope that it will be usef=
ul,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *=
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU =
General Public License for more details=2E
+ *
+ *  You should have receive=
d a copy of the GNU General Public License along
+ *  with this program; if=
 not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG=
_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <st=
darg=2Eh>
+#include <stddef=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=
=2Eh>
+
+#include "control_msg=2Eh"
+#include "ssl_pkt=2Eh"
+#include "test=
_common=2Eh"
+#include "test_control_msg=2Eh"
+
+/* The early negotiation f=
lags TLV of a reset packet asking a tls-crypt-v2
+ * client to resend its W=
Kc, as older versions wrote it by hand=2E */
+void
+test_tlv_write_u16_wire=
_format(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct =
buffer buf =3D alloc_buf_gc(16, &gc);
+
+    assert_true(ctrl_msg_tlv_write=
_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false,
+                              =
         EARLY_NEG_FLAG_RESEND_WKC));
+    const uint8_t expected[] =3D { 0=
x00, 0x01, 0x00, 0x02, 0x00, 0x01 };
+    assert_int_equal(BLEN(&buf), size=
of(expected));
+    assert_memory_equal(BPTR(&buf), expected, sizeof(expect=
ed));
+
+    /* the optional flag is the most significant bit of the type f=
ield */
+    buf_clear(&buf);
+    assert_true(ctrl_msg_tlv_write_u16(&buf,=
 TLV_TYPE_EARLY_NEG_FLAGS, true, 0));
+    assert_int_equal(BPTR(&buf)[0], =
0x80);
+    assert_int_equal(BPTR(&buf)[1], 0x01);
+
+    gc_free(&gc);
+}
=
+
+/* A TLV header survives the round trip, the optional flag kept apart fr=
om
+ * the 15-bit type=2E */
+void
+test_tlv_header_roundtrip(void **state)=

+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_=
buf_gc(16, &gc);
+
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x1234,=
 true, 5));
+    assert_int_equal(BLEN(&buf), 4);
+
+    struct ctrl_msg_tl=
v_header hdr;
+    assert_true(ctrl_msg_tlv_read_header(&buf, &hdr));
+    =
assert_int_equal(hdr=2Etype, 0x1234);
+    assert_true(hdr=2Eoptional);
+  =
  assert_int_equal(hdr=2Evalue_len, 5);
+    assert_int_equal(BLEN(&buf), 0=
);
+
+    gc_free(&gc);
+}
+
+/* Walking a payload returns each TLV in turn=
, with a value covering exactly
+ * its bytes, and consumes the payload=2E =
*/
+void
+test_tlv_next_walks_payload(void **state)
+{
+    struct gc_arena=
 gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(64, &gc);
+
+    =
assert_true(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 0=
xabcd));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));=

+    assert_true(buf_write_u32(&buf, 0x11223344));
+    assert_true(ctrl_m=
sg_tlv_write_header(&buf, 0x5, false, 0)); /* empty value */
+
+    struct =
ctrl_msg_tlv_header hdr;
+    struct buffer value;
+
+    assert_true(ctrl_=
msg_tlv_next(&buf, &hdr, &value));
+    assert_int_equal(hdr=2Etype, TLV_TY=
PE_EARLY_NEG_FLAGS);
+    assert_false(hdr=2Eoptional);
+    assert_int_equ=
al(BLEN(&value), 2);
+    assert_int_equal(buf_read_u16(&value), 0xabcd);
+=

+    assert_true(ctrl_msg_tlv_next(&buf, &hdr, &value));
+    assert_int_e=
qual(hdr=2Etype, 0x7ff);
+    assert_true(hdr=2Eoptional);
+    assert_int_=
equal(BLEN(&value), 4);
+    assert_int_equal(buf_read_u32(&value, NULL), 0=
x11223344);
+
+    assert_true(ctrl_msg_tlv_next(&buf, &hdr, &value));
+   =
 assert_int_equal(hdr=2Etype, 0x5);
+    assert_int_equal(BLEN(&value), 0);=

+
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* A TL=
V header claiming more value bytes than the payload holds is rejected,
+ * =
rather than read past the end of the payload=2E */
+void
+test_tlv_next_val=
ue_truncated(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    st=
ruct buffer buf =3D alloc_buf_gc(64, &gc);
+
+    assert_true(ctrl_msg_tlv_=
write_header(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 8));
+    assert_true(b=
uf_write_u32(&buf, 0));
+
+    struct ctrl_msg_tlv_header hdr;
+    struct =
buffer value;
+    assert_false(ctrl_msg_tlv_next(&buf, &hdr, &value));
+
+=
    gc_free(&gc);
+}
+
+/* Reading a TLV header must fail when the buffer h=
olds less data than a
+ * complete 4-byte header, rather than read past the=
 available data=2E */
+void
+test_tlv_header_truncated(void **state)
+{
+  =
  struct gc_arena gc =3D gc_new();
+    const uint8_t bytes[] =3D { 0x00, 0=
x01, 0x00 };
+
+    /* 0 to 3 bytes: none, part of the type field, the type=
 field, and the type
+     * field with half of the length */
+    for (siz=
e_t n =3D 0; n <=3D sizeof(bytes); n++)
+    {
+        struct buffer buf =
=3D alloc_buf_gc(16, &gc);
+        assert_true(buf_write(&buf, bytes, n));=

+        struct buffer copy =3D buf;
+
+        struct ctrl_msg_tlv_header=
 hdr;
+        struct buffer value;
+        assert_false(ctrl_msg_tlv_read=
_header(&buf, &hdr));
+        assert_false(ctrl_msg_tlv_next(&copy, &hdr, =
&value));
+    }
+
+    gc_free(&gc);
+}
+
+/* Writing fails, rather than w=
rites a partial TLV, when buf is too small=2E */
+void
+test_tlv_write_no_r=
oom(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+
+    struct bu=
ffer buf =3D alloc_buf_gc(3, &gc);
+    assert_false(ctrl_msg_tlv_write_hea=
der(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 2));
+    assert_int_equal(BLEN(=
&buf), 0);
+
+    /* room for the header but not the value */
+    buf =3D =
alloc_buf_gc(5, &gc);
+    assert_false(ctrl_msg_tlv_write_u16(&buf, TLV_TY=
PE_EARLY_NEG_FLAGS, false, 1));
+    assert_int_equal(BLEN(&buf), 0);
+
+  =
  gc_free(&gc);
+}
diff --git a/tests/unit_tests/openvpn/test_control_msg=
=2Eh b/tests/unit_tests/openvpn/test_control_msg=2Eh
new file mode 100644
i=
ndex 0000000=2E=2Eef7a030
--- /dev/null
+++ b/tests/unit_tests/openvpn/test=
_control_msg=2Eh
@@ -0,0 +1,37 @@
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
+#ifndef TEST_CONTROL_MSG_H=

+#define TEST_CONTROL_MSG_H
+
+void test_tlv_write_u16_wire_format(void **=
state);
+
+void test_tlv_header_roundtrip(void **state);
+
+void test_tlv_n=
ext_walks_payload(void **state);
+
+void test_tlv_next_value_truncated(void=
 **state);
+
+void test_tlv_header_truncated(void **state);
+
+void test_tl=
v_write_no_room(void **state);
+#endif
diff --git a/tests/unit_tests/openvp=
n/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index fbbb40f=2E=2E7=
dc07aa 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_=
tests/openvpn/test_pkt=2Ec
@@ -37,12 +37,14 @@
 #include "crypto=2Eh"
 #inc=
lude "options=2Eh"
 #include "ssl_backend=2Eh"
+#include "control_msg=2Eh"
=
 #include "ssl_pkt=2Eh"
 #include "tls_crypt=2Eh"
 
 #include "mss=2Eh"
 #i=
nclude "reliable=2Eh"
 #include "siphash=2Eh"
+#include "test_control_msg=
=2Eh"
 
 int
 parse_line(const char *line, char **p, const int n, const cha=
r *file, const int line_num,
@@ -655,6 +657,45 @@
     free_buf(&tas=2Ework=
buf);
 }
 
+/* A reset reply asking a tls-crypt-v2 client to resend its WKc=
 ends in the
+ * early negotiation flags TLV, and that TLV parses back=2E *=
/
+static void
+test_generate_reset_packet_resend_wkc(void **ut_state)
+{
+=
    struct tls_auth_standalone tas =3D { 0 };
+
+    struct session_id clie=
nt_id =3D { { 0, 1, 2, 3, 4, 5, 6, 7 } };
+    struct session_id server_id =
=3D { { 8, 9, 0, 9, 8, 7, 6, 2 } };
+
+    tas=2Etls_wrap=2Emode =3D TLS_WR=
AP_NONE;
+    struct frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =
=2Epayload_size =3D 1400 }, 0 };
+    tas=2Eframe =3D frame;
+    tas=2Ewor=
kbuf =3D alloc_buf(1600);
+
+    uint8_t header =3D 0 | (P_CONTROL_HARD_RES=
ET_SERVER_V2 << P_OPCODE_SHIFT);
+
+    struct buffer plain =3D
+        tl=
s_reset_standalone(&tas=2Etls_wrap, &tas, &client_id, &server_id, header, f=
alse);
+    const int plain_len =3D BLEN(&plain);
+    struct buffer buf =
=3D
+        tls_reset_standalone(&tas=2Etls_wrap, &tas, &client_id, &serve=
r_id, header, true);
+
+    const uint8_t tlv[] =3D { 0x00, 0x01, 0x00, 0x0=
2, 0x00, 0x01 };
+    assert_int_equal(BLEN(&buf), plain_len + (int)sizeof(=
tlv));
+    assert_memory_equal(BPTR(&buf) + plain_len, tlv, sizeof(tlv));
=
+
+    struct buffer payload =3D buf;
+    assert_true(buf_advance(&payload=
, plain_len));
+    struct ctrl_msg_tlv_header hdr;
+    struct buffer valu=
e;
+    assert_true(ctrl_msg_tlv_next(&payload, &hdr, &value));
+    assert=
_int_equal(hdr=2Etype, TLV_TYPE_EARLY_NEG_FLAGS);
+    assert_int_equal(buf=
_read_u16(&value), EARLY_NEG_FLAG_RESEND_WKC);
+    assert_int_equal(BLEN(&=
payload), 0);
+
+    free_buf(&tas=2Eworkbuf);
+}
+
 static void
 test_gene=
rate_reset_packet_tls_auth(void **ut_state)
 {
@@ -791,9 +832,16 @@
       =
  cmocka_unit_test(test_verify_hmac_tls_auth),
         cmocka_unit_test(te=
st_verify_hmac_none_out_of_range_ack),
         cmocka_unit_test(test_gener=
ate_reset_packet_plain),
+        cmocka_unit_test(test_generate_reset_pack=
et_resend_wkc),
         cmocka_unit_test(test_generate_reset_packet_tls_au=
th),
         cmocka_unit_test(test_wkc_not_appended_without_key),
-       =
 cmocka_unit_test(test_extract_control_message)
+        cmocka_unit_test(t=
est_extract_control_message),
+        cmocka_unit_test(test_tlv_write_u16_=
wire_format),
+        cmocka_unit_test(test_tlv_header_roundtrip),
+      =
  cmocka_unit_test(test_tlv_next_walks_payload),
+        cmocka_unit_test(=
test_tlv_next_value_truncated),
+        cmocka_unit_test(test_tlv_header_t=
runcated),
+        cmocka_unit_test(test_tlv_write_no_room)
     };
 
    =
 return cmocka_run_group_tests_name("pkt tests", tests, NULL, NULL);

-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I89c3133e009dc75dc2c1=
0c607b3f0a24c04e8146
Gerrit-Change-Number: 1965
Gerrit-PatchSet: 6
Gerrit-O=
wner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>

--Hou9yrgAJT8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, Lev Stipakov, R=C4=83zvan Cojocaru=
=2E </p>
<p>Lev Stipakov <strong>uploaded patch set #6</strong> to this cha=
nge=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=
=3Demail">View Change</a></p><p>The following approvals got outdated and we=
re removed:
Code-Review+1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">control_=
msg: Add a shared TLV codec and use it for early negotiation<br><br>Early n=
egotiation in the reset packets is a sequence of TLVs, and<br>planned out-o=
f-band and control data messages will use the same TLV<br>format and type s=
pace=2E Add one TLV codec for all of them,<br>control_msg=2Ec/h, and move e=
arly negotiation onto it=2E<br><br>The codec only handles the framing: read=
ing and writing TLV headers,<br>writing a 16-bit TLV, and walking a payload=
 TLV by TLV with each value<br>checked against the payload=2E How to treat =
an unknown type is up to each<br>message=2E With the optional flag clear th=
e codec writes the same bytes as<br>the hand-rolled code it replaces=2E<br>=
<br>In the codec the most significant bit of the type field is the<br>&quot=
;optional&quot; flag rather than part of the type=2E The old parser compare=
d<br>the whole type word, so 0x8001 did not match the flags TLV and was<br>=
skipped as unknown; now it matches and is parsed as one=2E<br><br>Change-Id=
: I89c3133e009dc75dc2c10c607b3f0a24c04e8146<br>Signed-off-by: Lev Stipakov =
&lt;lev@openvpn=2Enet&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Mak=
efile=2Eam<br>A src/openvpn/control_msg=2Ec<br>A src/openvpn/control_msg=2E=
h<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ss=
l_pkt=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests/unit_tests=
/openvpn/test_control_msg=2Ec<br>A tests/unit_tests/openvpn/test_control_ms=
g=2Eh<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>11 files changed, 490 i=
nsertions(+), 23 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/65/1965/6</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 5cf1a30=2E=2E3=
05c26c 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/=
CMakeLists=2Etxt</span><br><span>@@ -457,6 +457,8 @@</span><br><span>     s=
rc/openvpn/console=2Ec</span><br><span>     src/openvpn/console_builtin=2Ec=
</span><br><span>     src/openvpn/console=2Eh</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    src/openvpn/control_msg=2Ec</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/control_msg=2Eh</span=
><br><span>     src/openvpn/crypto=2Ec</span><br><span>     src/openvpn/cry=
pto=2Eh</span><br><span>     src/openvpn/crypto_backend=2Eh</span><br><span=
>@@ -896,6 +898,8 @@</span><br><span> </span><br><span>     target_sources(=
test_pkt PRIVATE</span><br><span>         tests/unit_tests/openvpn/mock_win=
32_execve=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  tests/unit_tests/openvpn/test_control_msg=2Ec</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        src/openvpn/control_msg=2Ec</span><br><=
span>         src/openvpn/argv=2Ec</span><br><span>         src/openvpn/bas=
e64=2Ec</span><br><span>         src/openvpn/crypto_epoch=2Ec</span><br><sp=
an>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span=
><br><span>index bb31053=2E=2Ebe1044d 100644</span><br><span>--- a/src/open=
vpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br=
><span>@@ -57,6 +57,7 @@</span><br><span> 	common=2Eh \</span><br><span> 	c=
omp=2Ec comp=2Eh compstub=2Ec \</span><br><span> 	comp-lz4=2Ec comp-lz4=2Eh=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	control_msg=2Ec =
control_msg=2Eh \</span><br><span> 	crypto=2Ec crypto=2Eh crypto_backend=2E=
h \</span><br><span> 	crypto_openssl=2Ec crypto_openssl=2Eh \</span><br><sp=
an> 	crypto_mbedtls=2Ec crypto_mbedtls=2Eh \</span><br><span>diff --git a/s=
rc/openvpn/control_msg=2Ec b/src/openvpn/control_msg=2Ec</span><br><span>ne=
w file mode 100644</span><br><span>index 0000000=2E=2E872191f</span><br><sp=
an>--- /dev/null</span><br><span>+++ b/src/openvpn/control_msg=2Ec</span><b=
r><span>@@ -0,0 +1,93 @@</span><br><span style=3D"color: hsl(120, 100%, 40%=
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
lude &quot;control_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_write_he=
ader(struct buffer *buf, uint16_t type, bool optional, uint16_t value_len)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* the type has 15 bits; the top b=
it is the optional flag */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ASSERT(type &lt;=3D CTRL_MSG_TLV_TYPE_MASK);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* Write nothing unless the whole TLV fits=2E The head=
er promises that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * value_len bytes follow it, so a header written without room for the</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * value would leav=
e a partial TLV in buf=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!buf_safe(buf, (size_t)CTRL_MSG_TLV_HEADER_LEN + value_len=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint16_t field =3D type;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (optional)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        field |=3D CTRL_MSG_TLV_OPTIONAL_FLAG;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return buf_write_u16(buf, field=
) &amp;&amp; buf_write_u16(buf, value_len);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_write_u16(struc=
t buffer *buf, uint16_t type, bool optional, uint16_t value)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return ctrl_msg_tlv_write_header(buf, type, opti=
onal, sizeof(uint16_t))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+           &amp;&amp; buf_write_u16(buf, value);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_read_=
header(struct buffer *buf, struct ctrl_msg_tlv_header *hdr)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    int field =3D buf_read_u16(buf);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (field &lt; 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int len =3D buf_read_u16(buf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (len &lt; 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    hdr-&gt;type =3D (uint16_t)(field &amp; CTRL_MSG_TLV_TYPE_MASK);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt;optional =
=3D (field &amp; CTRL_MSG_TLV_OPTIONAL_FLAG) !=3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt;value_len =3D (uint16_t)len;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_msg_tlv_header *hdr, stru=
ct buffer *value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ctrl_msg_tl=
v_read_header(buf, hdr))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn false; /* fewer than 4 bytes left: truncated header */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* Advance past the value; fails if buf is s=
horter than the header claims=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const uint8_t *v =3D buf_read_alloc(buf, hdr-&gt;value_=
len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!v)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    buf_set_read(value, v, hdr-&gt;value_len);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff -=
-git a/src/openvpn/control_msg=2Eh b/src/openvpn/control_msg=2Eh</span><br>=
<span>new file mode 100644</span><br><span>index 0000000=2E=2E7d25545</span=
><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/control_msg=2Eh<=
/span><br><span>@@ -0,0 +1,107 @@</span><br><span style=3D"color: hsl(120, =
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
">+ * TLV framing shared by the TLV-based control messages of the wire prot=
ocol=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Such a message payload is =
a sequence of TLV entries=2E Each TLV starts with a</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * 4-byte header: a 16-bit field whose mo=
st significant bit is the &quot;optional&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * flag and whose remaining 15 bits are the type=
, followed by a 16-bit length</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * giving the size of the value that follows the header=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * All of these messages share one TLV ty=
pe space, so the TLV types are all</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * defined here=2E Only the framing is handled here: what a =
message does with a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * TLV type it does not know, marked optional or not, is up to its parser=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifndef CONTROL_MSG_H</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define CONTROL_MSG_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* TLV types */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine TLV_TYPE_EARLY_NEG_FLAGS 0x0001 /* early negotiation, in the reset pa=
ckets */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* TLV header bit layout of th=
e first 16-bit field */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* A TLV header is a 16-bit type/optional field plus a 16-bit length */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CTRL_MSG_TL=
V_HEADER_LEN 4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CTRL_MSG_TLV_OPT=
IONAL_FLAG 0x8000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine CTRL_MSG_TLV_TYPE_MASK     0x7fff</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/** The header every TLV carries: the 15-bit type and optional flag packed=
 into</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the first 1=
6-bit field, then the length of the value that follows=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+struct ctrl_msg_tlv_header</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    uint16_t type;      /**&lt; the 15-bit TL=
V type */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool o=
ptional;      /**&lt; value of the optional flag */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint16_t value_len; /**&lt; length of=
 the value following the header */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Write a TLV header (type + optiona=
l flag + value length) to buf=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * type must fit in the 15 bits of the type field=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Nothing is written unless the header and th=
e value_len bytes of value</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * that follow it both fit, so a failed write never leaves a partial=
 TLV</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * behind=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false if bu=
f has insufficient space=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ctr=
l_msg_tlv_write_header(struct buffer *buf, uint16_t type, bool optional,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
         uint16_t value_len);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a complete TLV w=
hose value is a single 16-bit integer to buf=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @return true on success, false if buf has insufficient space=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_write_u16(stru=
ct buffer *buf, uint16_t type, bool optional, uint16_t value);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Read a TLV header from buf, advancing past it=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param buf  buffer positioned at the TLV header</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param hdr  filled=
 with the type, optional flag and value length on success</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false if =
there are not enough bytes for a header=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+bool ctrl_msg_tlv_read_header(struct buffer *buf, struct ctrl_msg_tl=
v_header *hdr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Read the next TLV from buf, advancin=
g past its header and value=2E Call it</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * while BLEN(buf) &gt; 0 to walk a whole payload=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * The length from the header is validat=
ed against buf, so on success the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * whole value is present: a header claiming more bytes than =
buf holds is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reje=
cted=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf    buffer posit=
ioned at a TLV header</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param hdr    filled with the TLV&#39;s type, optional flag and value =
length</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param val=
ue  set to a buffer covering exactly the TLV&#39;s value; it points</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *               into buf a=
nd owns no storage</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @return true on success, false if the header or the value is truncated; b=
uf</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         may th=
en be left partly consumed=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool c=
trl_msg_tlv_next(struct buffer *buf, struct ctrl_msg_tlv_header *hdr, struc=
t buffer *value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef CONT=
ROL_MSG_H */</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn=
/ssl=2Ec</span><br><span>index 12b6119=2E=2E6dae655 100644</span><br><span>=
--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><=
br><span>@@ -52,6 +52,7 @@</span><br><span> #include &quot;pkcs11=2Eh&quot;=
</span><br><span> #include &quot;route=2Eh&quot;</span><br><span> #include =
&quot;tls_crypt=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;control_msg=2Eh&quot;</span><br><span> </span><br><spa=
n> #include &quot;crypto_epoch=2Eh&quot;</span><br><span> #include &quot;ss=
l=2Eh&quot;</span><br><span>@@ -2645,26 +2646,21 @@</span><br><span> {</spa=
n><br><span>     while (buf-&gt;len &gt; 0)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (buf_len(buf) &lt; =
4)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            goto error;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        /* read type */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        int type =3D buf_read_u16(buf);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int len =3D b=
uf_read_u16(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (type &lt; 0 || len &lt; 0 || buf_len(buf) &lt; len)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        struct ctrl_msg_tlv_header =
hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct =
buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (!ctrl_msg_tlv_next(buf, &amp;hdr, &amp;value))</span><br><span>      =
   {</span><br><span>             goto error;</span><br><span>         }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  switch (type)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    switch (hdr=2Etype)</span><br><span>         {</span><br><span>        =
     case TLV_TYPE_EARLY_NEG_FLAGS:</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                if (len !=3D sizeof(uint16_t))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                if (BLEN(&amp;valu=
e) !=3D sizeof(uint16_t))</span><br><span>                 {</span><br><spa=
n>                     goto error;</span><br><span>                 }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                int flags =
=3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                int flags =3D buf_read_u16(&amp;value);</span><br><span>=
 </span><br><span>                 if (flags &amp; EARLY_NEG_FLAG_RESEND_WK=
C)</span><br><span>                 {</span><br><span>@@ -2683,8 +2679,8 @@=
</span><br><span>                 break;</span><br><span> </span><br><span>=
             default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                /* Skip types we do not parse */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                buf_advance(buf, len);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                /* Skip types=
 we do not parse, marked optional or not */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                break;</span><br><span>         }</=
span><br><span>     }</span><br><span>     reliable_mark_deleted(ks-&gt;rec=
_reliable, buf);</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src=
/openvpn/ssl_pkt=2Ec</span><br><span>index f78782f=2E=2Ef4564ef 100644</spa=
n><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn=
/ssl_pkt=2Ec</span><br><span>@@ -33,6 +33,7 @@</span><br><span> #include &q=
uot;reliable=2Eh&quot;</span><br><span> #include &quot;siphash=2Eh&quot;</s=
pan><br><span> #include &quot;tls_crypt=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><b=
r><span> </span><br><span> /*</span><br><span>  * Dependent on hmac size, o=
pcode size, and session_id size=2E</span><br><span>@@ -432,9 +433,8 @@</spa=
n><br><span>     /* Add indication for tls-crypt-v2 to resend the WKc with =
the reply */</span><br><span>     if (request_resend_wkc)</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_writ=
e_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS); /* TYPE: flags */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        buf_write_u16(&amp;buf, size=
of(uint16_t));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
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
70cf7b2=2E=2E11f92f4 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam<=
/span><br><span>@@ -164,11 +164,15 @@</span><br><span> 	-I$(top_srcdir)/inc=
lude -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><sp=
an> 	@TEST_CFLAGS@</span><br><span> pkt_testdriver_LDFLAGS =3D @TEST_LDFLAG=
S@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pkt_testdriver_SOUR=
CES =3D test_pkt=2Ec mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec test_c=
ommon=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pkt_test=
driver_SOURCES =3D test_pkt=2Ec \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	test_control_msg=2Ec test_control_msg=2Eh \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	mock_msg=2Ec mock_msg=2Eh mock_win3=
2_execve=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	test=
_common=2Eh \</span><br><span> 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec=
 \</span><br><span> 	$(top_srcdir)/src/openvpn/argv=2Ec \</span><br><span> =
	$(top_srcdir)/src/openvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src=
/openvpn/buffer=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	$(top_srcdir)/src/openvpn/control_msg=2Ec \</span><br><span> 	$(top_srcd=
ir)/src/openvpn/crypto=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/cr=
ypto_epoch=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls=
=2Ec \</span><br><span>diff --git a/tests/unit_tests/openvpn/test_control_m=
sg=2Ec b/tests/unit_tests/openvpn/test_control_msg=2Ec</span><br><span>new =
file mode 100644</span><br><span>index 0000000=2E=2Ea199baf</span><br><span=
>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_control_=
msg=2Ec</span><br><span>@@ -0,0 +1,179 @@</span><br><span style=3D"color: h=
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
%, 40%);">+#include &lt;stdarg=2Eh&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &lt;stddef=2Eh&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_pkt=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_c=
ommon=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;test_control_msg=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* The early negotiation flags TLV of a reset packet asking a tls-crypt-v2</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * client to resend i=
ts WKc, as older versions wrote it by hand=2E */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+test_tlv_write_u16_wire_format(void **state)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_g=
c(16, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_ms=
g_tlv_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                    =
   EARLY_NEG_FLAG_RESEND_WKC));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const uint8_t expected[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00=
, 0x01 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(BLEN(&amp;buf), sizeof(expected));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf), expected,=
 sizeof(expected));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the optional=
 flag is the most significant bit of the type field */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    buf_clear(&amp;buf);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_=
u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, true, 0));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(BPTR(&amp;buf)[0], 0x80=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(BPTR(&amp;buf)[1], 0x01);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fr=
ee(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* A TLV header survives the round trip, the=
 optional flag kept apart from</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * the 15-bit type=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+test_tlv_header_roundtrip(void **state)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(16, &amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header=
(&amp;buf, 0x1234, true, 5));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(BLEN(&amp;buf), 4);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_read_header(&amp;b=
uf, &amp;hdr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(hdr=2Etype, 0x1234);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(hdr=2Eoptional);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Evalue_len, 5);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(B=
LEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* Walking a payload returns each TLV in turn, with a v=
alue covering exactly</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * its bytes, and consumes the payload=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+test_tlv_next_walks_payload(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(64=
, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tl=
v_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 0xabcd));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_w=
rite_header(&amp;buf, 0x7ff, true, 4));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0x11223344));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_=
msg_tlv_write_header(&amp;buf, 0x5, false, 0)); /* empty value */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_header hdr;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_next(&amp;buf, &a=
mp;hdr, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(hdr=2Etype, TLV_TYPE_EARLY_NEG_FLAGS);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(hdr=2Eoptional);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(BLEN(&amp;value), 2);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(buf_read_u16(&amp;value), 0xabcd);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_next(&amp;buf, &amp;hdr, =
&amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(hdr=2Etype, 0x7ff);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(hdr=2Eoptional);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), 4);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(buf=
_read_u32(&amp;value, NULL), 0x11223344);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(ctrl_msg_tlv_next(&amp;buf, &amp;hdr, &amp;value));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=
=2Etype, 0x5);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(BLEN(&amp;value), 0);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* A TLV header claiming more valu=
e bytes than the payload holds is rejected,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * rather than read past the end of the payload=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+test_tlv_next_value_truncated(vo=
id **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D=
 gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t buffer buf =3D alloc_buf_gc(64, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, TLV_TYPE_EARLY_NEG=
_FLAGS, false, 8));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(buf_write_u32(&amp;buf, 0));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer value;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_tlv_next(&amp;buf, &am=
p;hdr, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Reading a TLV header must fail when the buffer hol=
ds less data than a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * complete 4-byte header, rather than read past the available data=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+test_tlv_header_truncated(void **sta=
te)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t=
 bytes[] =3D { 0x00, 0x01, 0x00 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* 0 to 3 bytes: none, part of the type field, the type field, and the type=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * field with h=
alf of the length */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    for (size_t n =3D 0; n &lt;=3D sizeof(bytes); n++)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        struct buffer buf =3D alloc_buf_gc(16, &amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_t=
rue(buf_write(&amp;buf, bytes, n));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        struct buffer copy =3D buf;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        struct ctrl_msg_tlv_header hdr;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        struct buffer value;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        assert_false(ctrl_msg_t=
lv_read_header(&amp;buf, &amp;hdr));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        assert_false(ctrl_msg_tlv_next(&amp;copy, &amp;hdr=
, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Writing fails, rather than writes a partial TLV, when buf is too smal=
l=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+test_tlv_write_no_room(void=
 **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D g=
c_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D allo=
c_buf_gc(3, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_false(ctrl_msg_tlv_write_header(&amp;buf, TLV_TYPE_EARLY_NEG_F=
LAGS, false, 2));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* room for the header but not the value */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    buf =3D alloc_buf_gc(5, &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_tlv=
_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 1));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf),=
 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/t=
ests/unit_tests/openvpn/test_control_msg=2Eh b/tests/unit_tests/openvpn/tes=
t_control_msg=2Eh</span><br><span>new file mode 100644</span><br><span>inde=
x 0000000=2E=2Eef7a030</span><br><span>--- /dev/null</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_control_msg=2Eh</span><br><span>@@ -0,0 +1,37=
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
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
ifndef TEST_CONTROL_MSG_H</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define TEST_CONTROL_MSG_H</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void t=
est_tlv_write_u16_wire_format(void **state);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void test_tlv_header_roundtrip(void **state);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void test_tlv_next_walks_payload(void **state);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void test_tlv_next_value_truncated(void **state);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void test_tlv_header_truncated(void **st=
ate);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void test_tlv_write_no_room(void =
**state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/uni=
t_tests/openvpn/test_pkt=2Ec</span><br><span>index fbbb40f=2E=2E7dc07aa 100=
644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><=
span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -37,12 =
+37,14 @@</span><br><span> #include &quot;crypto=2Eh&quot;</span><br><span>=
 #include &quot;options=2Eh&quot;</span><br><span> #include &quot;ssl_backe=
nd=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;control_msg=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&q=
uot;</span><br><span> #include &quot;tls_crypt=2Eh&quot;</span><br><span> <=
/span><br><span> #include &quot;mss=2Eh&quot;</span><br><span> #include &qu=
ot;reliable=2Eh&quot;</span><br><span> #include &quot;siphash=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_con=
trol_msg=2Eh&quot;</span><br><span> </span><br><span> int</span><br><span> =
parse_line(const char *line, char **p, const int n, const char *file, const=
 int line_num,</span><br><span>@@ -655,6 +657,45 @@</span><br><span>     fr=
ee_buf(&amp;tas=2Eworkbuf);</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* A reset reply asking a tls-=
crypt-v2 client to resend its WKc ends in the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * early negotiation flags TLV, and that TLV pars=
es back=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_generate_=
reset_packet_resend_wkc(void **ut_state)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct tls_auth_standalone tas =3D { 0 };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct session_id client_id =3D { { 0, 1, 2, 3, 4, 5, 6, 7 } =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct sessio=
n_id server_id =3D { { 8, 9, 0, 9, 8, 7, 6, 2 } };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    tas=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct frame frame =3D { =2Ebuf =
=3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, 0 };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    tas=2Eframe =3D frame;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    tas=2Eworkbuf =3D alloc_=
buf(1600);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t header =3D 0 | (=
P_CONTROL_HARD_RESET_SERVER_V2 &lt;&lt; P_OPCODE_SHIFT);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct buffer plain =3D</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        tls_reset_standalone(&amp;tas=2Etls_wrap,=
 &amp;tas, &amp;client_id, &amp;server_id, header, false);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const int plain_len =3D BLEN(&am=
p;plain);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 buffer buf =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    tls_reset_standalone(&amp;tas=2Etls_wrap, &amp;tas, &amp;client_id, &am=
p;server_id, header, true);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const u=
int8_t tlv[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), p=
lain_len + (int)sizeof(tlv));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_memory_equal(BPTR(&amp;buf) + plain_len, tlv, sizeof(t=
lv));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct buffer payload =3D buf=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(bu=
f_advance(&amp;payload, plain_len));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct ctrl_msg_tlv_header hdr;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_next(&a=
mp;payload, &amp;hdr, &amp;value));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(hdr=2Etype, TLV_TYPE_EARLY_NEG_FLAGS);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(buf_read_u16(&amp;value), EARLY_NEG_FLAG_RESEND_WKC);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;payload)=
, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;tas=2Eworkbuf);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><=
br><span> test_generate_reset_packet_tls_auth(void **ut_state)</span><br><s=
pan> {</span><br><span>@@ -791,9 +832,16 @@</span><br><span>         cmocka=
_unit_test(test_verify_hmac_tls_auth),</span><br><span>         cmocka_unit=
_test(test_verify_hmac_none_out_of_range_ack),</span><br><span>         cmo=
cka_unit_test(test_generate_reset_packet_plain),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_generate_reset_p=
acket_resend_wkc),</span><br><span>         cmocka_unit_test(test_generate_=
reset_packet_tls_auth),</span><br><span>         cmocka_unit_test(test_wkc_=
not_appended_without_key),</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        cmocka_unit_test(test_extract_control_message)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_extra=
ct_control_message),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        cmocka_unit_test(test_tlv_write_u16_wire_format),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_tlv_he=
ader_roundtrip),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     cmocka_unit_test(test_tlv_next_walks_payload),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_tlv_next_va=
lue_truncated),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    cmocka_unit_test(test_tlv_header_truncated),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_tlv_write_no_roo=
m)</span><br><span>     };</span><br><span> </span><br><span>     return cm=
ocka_run_group_tests_name(&quot;pkt tests&quot;, tests, NULL, NULL);</span>=
<br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1965?usp=3Demail">change 1965</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1965?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c0=
4e8146 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1965 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Fra=
nk Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--Hou9yrgAJT8=--


--===============5753645354518926655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5753645354518926655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5753645354518926655==--

