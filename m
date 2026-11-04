Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D983E606A331
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dSqZ2lKI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TODQtcX2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=emewKKqT;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cq1uK2oq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ssifyWOT6+50hAvXCq/ubpXYZjX70pM3tu0u85vEBXM=; b=dSqZ2lKIzQag+E+PhVSAzmEXet
	UGveeNW5kEITsxfUVlLlsA/3KCVX0bCA6cj2Ys4qqVY3rbtLAz8cU2Gsp4ofFBrIh/y/iOGXnsEJM
	psO9+zSK4jxkxuc6oYVcNbMH+dn5YO0Q5psHoq1jpTyOf1WEsTmzno6zTQSrTnayJS5g=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOdjH-000000003Xp-10mU;
	Wed, 04 Nov 2026 16:20:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOdjF-000000003Xi-41Dr
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:20:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ydpCZ32Pnoi1BymUB/x4J0IHYH5NcrHDSPcGJylj50o=; b=TODQtcX2qmM3WHuSwxHM8a2iei
 RcPVgV80NV88bdGOZQIyHaKlz1OS5ie3eyuG8AKZVwrc6nOOlYEKG8WMu/K8f002TMktc5Y0cMvAa
 qZf0zjLBw+XBdacriTqyFptGe/1kKaFbg7jabjX8PmCKQynx721H6DhATXCcpwz9NZQc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ydpCZ32Pnoi1BymUB/x4J0IHYH5NcrHDSPcGJylj50o=; b=emewKKqTIAJ2ssHT6LL331DrBx
 JQq5btnNmbTFnDMK2r7EVxSDcLqDUzfNqlQc9Bc0zj740pPXJ8LNw6yXf4IUlK3SZSquBX3NpqfUb
 MuidfCQWPrNOLZdiiIZ+waFokApD2D2HjQ/OwbPoZ3wYu1DLFscjKf8kXa/qICHBxEAc=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOdjB-0000000069j-3pJp for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:20:49 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-490d59c3edaso213426f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 08:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793809239; x=1794414039; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ydpCZ32Pnoi1BymUB/x4J0IHYH5NcrHDSPcGJylj50o=;
 b=cq1uK2oqzeYEVEtvjUkNYq100G4DkVvHoXZK3M0c41MDq8eRHhlDk6DADtw4ePcTfA
 SxhVh+63vxc+RgY3ca2lDgOe3vvOtDPl1L/MutNBVaCnYwORkTJ7zmI3ntVc82f46V2Z
 6+HWhMcgONcIKOTV1M3O9eM42g4SAqPgAavyDg789M/mkuagZDgEeWaOkq0rLCjD8EYs
 zDYt6JEjHmSc42/RWn5+uKvhqgpiqsfBuoYb50Q8y1ICrTZF5/ulKQt3ar/YG9Nuxvqp
 qQfPGbnyc1M1Hz174XOiVhCZ5eGnVuQNIuR876/cQI3sogdFYnEd/47Og5UcSt8iUQFI
 yDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793809239; x=1794414039;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ydpCZ32Pnoi1BymUB/x4J0IHYH5NcrHDSPcGJylj50o=;
 b=bx9lI/d/RJb9dUClPFxZdgFdqY3tFaoicBrhed1a5p+mx6pvMmj54dsWmWpD9hg38x
 Ys15slhmckjGhWByrO9NMZDHxMP3GfZQokKfOAmhpHtsaCTaAvNauGnGEZ7l1RIrVQL5
 ySpgo87P+grNH+3ArJBNJqplOHrziBDhJ8LYIjQ60e80ONR9umMiHE9TBYCY6zVb5/1J
 QJMokhi4lTtIyc77rUO2zexmCqkoSVz4WlxRz/KHg3t86p++04ajr8dnTKYUAXBL4uSq
 TIhz6zp6bybDVLoP/pbTLauR35kEd5fok6FKaitlfbbitpzQqGSSsq5HbA9SVuBatNkV
 ICCg==
X-Gm-Message-State: APuU4Z859Bnu92+apNfdotL6dRwfjCDQRfN2ER+eB69OuoCQjyeGQzvw
 U37Vu4miyhaGVINehD8QhTgVqIA73BbdunzVh8nlHVsIlFXNXt7h1xCqyse6U91x2c2jQoEK0J/
 WPtjhgHxeLM6z36YN/9+HHgqH9UGM5xml8sdweJQEeYRfY3c70ZkxihyO5Uxlpy95h99P
X-Gm-Gg: AYBFou21ja22DGyklrnyn0kt97qD0yWsot487LLTpnwX4XAmIBCGKfxpyuoYFe0vY+s
 Wa4jhzdPbb0ugHxiIFB23xI5Lhoa6hR1lqMF7cFrImjStMj6FAjjwFyQ3CaiKV8W7qpQUrMWBMP
 ddRa8Mrw0JyryeIm5YdAxujm9rpQVJ816mdaQ4bo+SoG4+W4EXtFDuRXJGuqJsyUyaBKI42a42D
 kBQETiTzwPrtkexC0ZXNLYyFHCVmRHj0oELnOvs/Il1h7MdX2GwjIr3NCJc4EV7FFND9HzINRAn
 +3dJ48zLlKY+ZGKjrPsCtmnEGa11MXAVl1TpADawZNuvMZVFYMXqpkjwa7lwxJAewlx/vf2dgKa
 gy9AQqWzAbIkbfq9BzOefjsNWfm7SF0DSEXnCsK6/U26r7d8fygMY+pRMLX8+jFPdKcG+q2SYi5
 L/6yZfxOOQxvaztAexzSf40FkRUjuBYYf6+P4UxI8phuuegotPcTEajcPWzMLXvQI9ovjs0eBtj
 syVxMThdDqW1Dn41paUMYBEtEAcTv+BNOd2KaCp/rLOUEPf/vuz5Dwn6cIdFuu+PbB5x8znAkhx
 7Uhp2BjfFI9aZ5fcEjChVE8MwSfDTVMVsKNKK+l8044nhieC516zVpKrHk0Duz2mEt6oL2BMQk9
 t2LfCQnWT1kL0ALODI/vwbp9zSJWuIrPEjfIvJ0YwjJH39+hjVm4OLIHaeBN8pXTJW5QIabLoIS
 6mHuTZFcEFTuChSw==
X-Received: by 2002:a05:6000:1884:b0:48f:8eb6:2320 with SMTP id
 ffacd0b85a97d-48f8eb62377mr11402124f8f.3.1793809238601; 
 Wed, 04 Nov 2026 08:20:38 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fea18175bsm4509297f8f.7.2026.11.04.08.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:20:37 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 16:20:36 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: cdbf85ced0fbcfffe1527f249ed44aeae5f048d4
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fb6055f28f8742d9b958b713ed6207e519c5e058-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOdjB-0000000069j-3pJp
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
Content-Type: multipart/mixed; boundary="===============4743162413297520164=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4743162413297520164==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i6OTljHKBiI="; charset=UTF-8

--i6OTljHKBiI=
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
 set (#5)=2E

The following approvals got outdated and were removed:
Code-R=
eview-1 by R=C4=83zvan Cojocaru


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
message=2E

The codec splits the=
 top bit of the type field off as the "optional"
flag, which the previous e=
arly negotiation parser did not do=2E The flags
TLV is defined with that bi=
t clear, so the parser only accepts it when
the bit is clear and skips the =
type word 0x8001 as unknown exactly as
before=2E No functional change=2E

C=
hange-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Signed-off-by: Lev Stip=
akov <lev@openvpn=2Enet>
---
M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam=

A src/openvpn/control_msg=2Ec
A src/openvpn/control_msg=2Eh
M src/openvpn/=
ssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M tests/unit_te=
sts/openvpn/Makefile=2Eam
A tests/unit_tests/openvpn/test_control_msg=2Ec
A=
 tests/unit_tests/openvpn/test_control_msg=2Eh
M tests/unit_tests/openvpn/t=
est_pkt=2Ec
11 files changed, 498 insertions(+), 23 deletions(-)


  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/65/1965/5

diff =
--git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 5cf1a30=2E=2E305c26c 1006=
44
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -457,6 +457,8 @@
     s=
rc/openvpn/console=2Ec
     src/openvpn/console_builtin=2Ec
     src/openvp=
n/console=2Eh
+    src/openvpn/control_msg=2Ec
+    src/openvpn/control_msg=
=2Eh
     src/openvpn/crypto=2Ec
     src/openvpn/crypto=2Eh
     src/openv=
pn/crypto_backend=2Eh
@@ -896,6 +898,8 @@
 
     target_sources(test_pkt PR=
IVATE
         tests/unit_tests/openvpn/mock_win32_execve=2Ec
+        test=
s/unit_tests/openvpn/test_control_msg=2Ec
+        src/openvpn/control_msg=
=2Ec
         src/openvpn/argv=2Ec
         src/openvpn/base64=2Ec
        =
 src/openvpn/crypto_epoch=2Ec
diff --git a/src/openvpn/Makefile=2Eam b/src/=
openvpn/Makefile=2Eam
index bb31053=2E=2Ebe1044d 100644
--- a/src/openvpn/M=
akefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -57,6 +57,7 @@
 	common=2Eh=
 \
 	comp=2Ec comp=2Eh compstub=2Ec \
 	comp-lz4=2Ec comp-lz4=2Eh \
+	contr=
ol_msg=2Ec control_msg=2Eh \
 	crypto=2Ec crypto=2Eh crypto_backend=2Eh \
 =
	crypto_openssl=2Ec crypto_openssl=2Eh \
 	crypto_mbedtls=2Ec crypto_mbedtl=
s=2Eh \
diff --git a/src/openvpn/control_msg=2Ec b/src/openvpn/control_msg=
=2Ec
new file mode 100644
index 0000000=2E=2E872191f
--- /dev/null
+++ b/sr=
c/openvpn/control_msg=2Ec
@@ -0,0 +1,93 @@
+/*
+ *  OpenVPN -- An applicati=
on to securely tunnel IP networks
+ *             over a single TCP/UDP por=
t, with support for SSL/TLS-based
+ *             session authentication an=
d key exchange,
+ *             packet encryption, packet authentication, a=
nd
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 O=
penVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; yo=
u can redistribute it and/or modify
+ *  it under the terms of the GNU Gene=
ral Public License version 2
+ *  as published by the Free Software Foundat=
ion=2E
+ *
+ *  This program is distributed in the hope that it will be use=
ful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ =
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU=
 General Public License for more details=2E
+ *
+ *  You should have receiv=
ed a copy of the GNU General Public License along
+ *  with this program; i=
f not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFI=
G_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "c=
ontrol_msg=2Eh"
+
+bool
+ctrl_msg_tlv_write_header(struct buffer *buf, uint=
16_t type, bool optional, uint16_t value_len)
+{
+    /* the type has 15 bi=
ts; the top bit is the optional flag */
+    ASSERT(type <=3D CTRL_MSG_TLV_=
TYPE_MASK);
+
+    /* Write nothing unless the whole TLV fits=2E The header=
 promises that
+     * value_len bytes follow it, so a header written witho=
ut room for the
+     * value would leave a partial TLV in buf=2E */
+    i=
f (!buf_safe(buf, (size_t)CTRL_MSG_TLV_HEADER_LEN + value_len))
+    {
+   =
     return false;
+    }
+    uint16_t field =3D type;
+    if (optional)
=
+    {
+        field |=3D CTRL_MSG_TLV_OPTIONAL_FLAG;
+    }
+    return b=
uf_write_u16(buf, field) && buf_write_u16(buf, value_len);
+}
+
+bool
+ctrl=
_msg_tlv_write_u16(struct buffer *buf, uint16_t type, bool optional, uint16=
_t value)
+{
+    return ctrl_msg_tlv_write_header(buf, type, optional, siz=
eof(uint16_t))
+           && buf_write_u16(buf, value);
+}
+
+bool
+ctrl_m=
sg_tlv_read_header(struct buffer *buf, struct ctrl_msg_tlv_header *hdr)
+{
=
+    int field =3D buf_read_u16(buf);
+    if (field < 0)
+    {
+        r=
eturn false;
+    }
+    int len =3D buf_read_u16(buf);
+    if (len < 0)
+=
    {
+        return false;
+    }
+    hdr->type =3D (uint16_t)(field & C=
TRL_MSG_TLV_TYPE_MASK);
+    hdr->optional =3D (field & CTRL_MSG_TLV_OPTION=
AL_FLAG) !=3D 0;
+    hdr->value_len =3D (uint16_t)len;
+    return true;
+=
}
+
+bool
+ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_msg_tlv_header=
 *hdr, struct buffer *value)
+{
+    if (!ctrl_msg_tlv_read_header(buf, hdr=
))
+    {
+        return false; /* fewer than 4 bytes left: truncated head=
er */
+    }
+    /* Advance past the value; fails if buf is shorter than t=
he header claims=2E */
+    const uint8_t *v =3D buf_read_alloc(buf, hdr->v=
alue_len);
+    if (!v)
+    {
+        return false;
+    }
+    buf_set_r=
ead(value, v, hdr->value_len);
+    return true;
+}
diff --git a/src/openvp=
n/control_msg=2Eh b/src/openvpn/control_msg=2Eh
new file mode 100644
index =
0000000=2E=2E7d25545
--- /dev/null
+++ b/src/openvpn/control_msg=2Eh
@@ -0,=
0 +1,107 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networ=
ks
+ *             over a single TCP/UDP port, with support for SSL/TLS-bas=
ed
+ *             session authentication and key exchange,
+ *            =
 packet encryption, packet authentication, and
+ *             packet compr=
ession=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet=
>
+ *
+ *  This program is free software; you can redistribute it and/or mo=
dify
+ *  it under the terms of the GNU General Public License version 2
+ =
*  as published by the Free Software Foundation=2E
+ *
+ *  This program is=
 distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRA=
NTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS F=
OR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for mor=
e details=2E
+ *
+ *  You should have received a copy of the GNU General Pu=
blic License along
+ *  with this program; if not, see <https://www=2Egnu=
=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @file
+ * TLV framing shared by the TL=
V-based control messages of the wire protocol=2E
+ *
+ * Such a message pay=
load is a sequence of TLV entries=2E Each TLV starts with a
+ * 4-byte head=
er: a 16-bit field whose most significant bit is the "optional"
+ * flag an=
d whose remaining 15 bits are the type, followed by a 16-bit length
+ * giv=
ing the size of the value that follows the header=2E
+ *
+ * All of these m=
essages share one TLV type space, so the TLV types are all
+ * defined here=
=2E Only the framing is handled here: what a message does with a
+ * TLV ty=
pe it does not know, marked optional or not, is up to its parser=2E
+ */
+
=
+#ifndef CONTROL_MSG_H
+#define CONTROL_MSG_H
+
+#include "buffer=2Eh"
+
+/=
* TLV types */
+#define TLV_TYPE_EARLY_NEG_FLAGS 0x0001 /* early negotiatio=
n, in the reset packets */
+
+/* TLV header bit layout of the first 16-bit =
field */
+/* A TLV header is a 16-bit type/optional field plus a 16-bit len=
gth */
+#define CTRL_MSG_TLV_HEADER_LEN 4
+
+#define CTRL_MSG_TLV_OPTIONAL_=
FLAG 0x8000
+#define CTRL_MSG_TLV_TYPE_MASK     0x7fff
+
+/** The header ev=
ery TLV carries: the 15-bit type and optional flag packed into
+ * the firs=
t 16-bit field, then the length of the value that follows=2E */
+struct ctr=
l_msg_tlv_header
+{
+    uint16_t type;      /**< the 15-bit TLV type */
+ =
   bool optional;      /**< value of the optional flag */
+    uint16_t val=
ue_len; /**< length of the value following the header */
+};
+
+/**
+ * Wri=
te a TLV header (type + optional flag + value length) to buf=2E
+ * type mu=
st fit in the 15 bits of the type field=2E
+ *
+ * Nothing is written unles=
s the header and the value_len bytes of value
+ * that follow it both fit, =
so a failed write never leaves a partial TLV
+ * behind=2E
+ *
+ * @return =
true on success, false if buf has insufficient space=2E
+ */
+bool ctrl_msg=
_tlv_write_header(struct buffer *buf, uint16_t type, bool optional,
+      =
                         uint16_t value_len);
+
+/**
+ * Write a complete T=
LV whose value is a single 16-bit integer to buf=2E
+ *
+ * @return true on=
 success, false if buf has insufficient space=2E
+ */
+bool ctrl_msg_tlv_wr=
ite_u16(struct buffer *buf, uint16_t type, bool optional, uint16_t value);
=
+
+/**
+ * Read a TLV header from buf, advancing past it=2E
+ *
+ * @param =
buf  buffer positioned at the TLV header
+ * @param hdr  filled with the ty=
pe, optional flag and value length on success
+ * @return true on success, =
false if there are not enough bytes for a header=2E
+ */
+bool ctrl_msg_tlv=
_read_header(struct buffer *buf, struct ctrl_msg_tlv_header *hdr);
+
+/**
+=
 * Read the next TLV from buf, advancing past its header and value=2E Call =
it
+ * while BLEN(buf) > 0 to walk a whole payload=2E
+ *
+ * The length fr=
om the header is validated against buf, so on success the
+ * whole value i=
s present: a header claiming more bytes than buf holds is
+ * rejected=2E
+=
 *
+ * @param buf    buffer positioned at a TLV header
+ * @param hdr    fi=
lled with the TLV's type, optional flag and value length
+ * @param value  =
set to a buffer covering exactly the TLV's value; it points
+ *            =
   into buf and owns no storage
+ * @return true on success, false if the h=
eader or the value is truncated; buf
+ *         may then be left partly co=
nsumed=2E
+ */
+bool ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_msg_=
tlv_header *hdr, struct buffer *value);
+
+#endif /* ifndef CONTROL_MSG_H *=
/
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 12b6119=2E=
=2Ee531613 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -5=
2,6 +52,7 @@
 #include "pkcs11=2Eh"
 #include "route=2Eh"
 #include "tls_cr=
ypt=2Eh"
+#include "control_msg=2Eh"
 
 #include "crypto_epoch=2Eh"
 #inclu=
de "ssl=2Eh"
@@ -2645,26 +2646,28 @@
 {
     while (buf->len > 0)
     {
- =
       if (buf_len(buf) < 4)
-        {
-            goto error;
-        }=

-        /* read type */
-        int type =3D buf_read_u16(buf);
-       =
 int len =3D buf_read_u16(buf);
-        if (type < 0 || len < 0 || buf_len=
(buf) < len)
+        struct ctrl_msg_tlv_header hdr;
+        struct buffe=
r value;
+        if (!ctrl_msg_tlv_next(buf, &hdr, &value))
         {
   =
          goto error;
         }
 
-        switch (type)
+        switch (=
hdr=2Etype)
         {
             case TLV_TYPE_EARLY_NEG_FLAGS:
-       =
         if (len !=3D sizeof(uint16_t))
+                /* This TLV is def=
ined with the optional bit clear=2E A type
+                 * word that ha=
s the bit set is not this TLV, so skip it as
+                 * an unknown=
 type rather than parsing it as the flags=2E */
+                if (hdr=2E=
optional)
+                {
+                    break;
+                }=

+                if (BLEN(&value) !=3D sizeof(uint16_t))
                 =
{
                     goto error;
                 }
-                int =
flags =3D buf_read_u16(buf);
+                int flags =3D buf_read_u16(&v=
alue);
 
                 if (flags & EARLY_NEG_FLAG_RESEND_WKC)
          =
       {
@@ -2683,8 +2686,8 @@
                 break;
 
             defau=
lt:
-                /* Skip types we do not parse */
-                buf_=
advance(buf, len);
+                /* Skip types we do not parse, marked o=
ptional or not */
+                break;
         }
     }
     reliable_m=
ark_deleted(ks->rec_reliable, buf);
diff --git a/src/openvpn/ssl_pkt=2Ec b/=
src/openvpn/ssl_pkt=2Ec
index f78782f=2E=2Ef4564ef 100644
--- a/src/openvpn=
/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -33,6 +33,7 @@
 #include "rel=
iable=2Eh"
 #include "siphash=2Eh"
 #include "tls_crypt=2Eh"
+#include "con=
trol_msg=2Eh"
 
 /*
  * Dependent on hmac size, opcode size, and session_id=
 size=2E
@@ -432,9 +433,8 @@
     /* Add indication for tls-crypt-v2 to res=
end the WKc with the reply */
     if (request_resend_wkc)
     {
-        =
buf_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS); /* TYPE: flags */
-        b=
uf_write_u16(&buf, sizeof(uint16_t));
-        buf_write_u16(&buf, EARLY_NE=
G_FLAG_RESEND_WKC);
+        ASSERT(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_E=
ARLY_NEG_FLAGS, false,
+                                      EARLY_NEG_FLA=
G_RESEND_WKC));
     }
 
     /* Add tls-auth/tls-crypt wrapping, this migh=
t replace buf with
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_p=
kt=2Eh
index 8203e4a=2E=2E218c6bb 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ =
b/src/openvpn/ssl_pkt=2Eh
@@ -306,10 +306,8 @@
 #define EARLY_NEG_START 0x0=
f000000
 
 
-/* Early negotiation that part of the server response in the R=
ESET_V2 packet=2E
- * Since clients that announce early negotiation support=
 will treat the payload
- * of reset packets special and parse it as TLV me=
ssages=2E
- * as TLV (type, length, value) */
-#define TLV_TYPE_EARLY_NEG_F=
LAGS  0x0001
+/* Early negotiation: clients that announce support for it pa=
rse the payload of
+ * the reset packets as TLVs (see control_msg=2Eh)=2E F=
lags carried in the value of
+ * the TLV_TYPE_EARLY_NEG_FLAGS TLV: */
 #def=
ine EARLY_NEG_FLAG_RESEND_WKC 0x0001
 #endif /* ifndef SSL_PKT_H */
diff --=
git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Mak=
efile=2Eam
index 70cf7b2=2E=2E11f92f4 100644
--- a/tests/unit_tests/openvpn=
/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -164,11 +164=
,15 @@
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)=
/src/openvpn \
 	@TEST_CFLAGS@
 pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
-=
pkt_testdriver_SOURCES =3D test_pkt=2Ec mock_msg=2Ec mock_msg=2Eh mock_win3=
2_execve=2Ec test_common=2Eh \
+pkt_testdriver_SOURCES =3D test_pkt=2Ec \
+=
	test_control_msg=2Ec test_control_msg=2Eh \
+	mock_msg=2Ec mock_msg=2Eh mo=
ck_win32_execve=2Ec \
+	test_common=2Eh \
 	$(top_srcdir)/src/compat/compat=
-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/argv=2Ec \
 	$(top_srcdir)/src/o=
penvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
+	$(top_srcdir=
)/src/openvpn/control_msg=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
 	=
$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \
 	$(top_srcdir)/src/openvpn/cr=
ypto_mbedtls=2Ec \
diff --git a/tests/unit_tests/openvpn/test_control_msg=
=2Ec b/tests/unit_tests/openvpn/test_control_msg=2Ec
new file mode 100644
i=
ndex 0000000=2E=2Ea199baf
--- /dev/null
+++ b/tests/unit_tests/openvpn/test=
_control_msg=2Ec
@@ -0,0 +1,179 @@
+/*
+ *  OpenVPN -- An application to se=
curely tunnel IP networks
+ *             over a single TCP/UDP port, with =
support for SSL/TLS-based
+ *             session authentication and key ex=
change,
+ *             packet encryption, packet authentication, and
+ *  =
           packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN I=
nc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you can re=
distribute it and/or modify
+ *  it under the terms of the GNU General Publ=
ic License version 2
+ *  as published by the Free Software Foundation=2E
+=
 *
+ *  This program is distributed in the hope that it will be useful,
+ *=
  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCH=
ANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General=
 Public License for more details=2E
+ *
+ *  You should have received a cop=
y of the GNU General Public License along
+ *  with this program; if not, s=
ee <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#in=
clude "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdarg=2E=
h>
+#include <stddef=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+=
#include "control_msg=2Eh"
+#include "ssl_pkt=2Eh"
+#include "test_common=
=2Eh"
+#include "test_control_msg=2Eh"
+
+/* The early negotiation flags TL=
V of a reset packet asking a tls-crypt-v2
+ * client to resend its WKc, as =
older versions wrote it by hand=2E */
+void
+test_tlv_write_u16_wire_format=
(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer =
buf =3D alloc_buf_gc(16, &gc);
+
+    assert_true(ctrl_msg_tlv_write_u16(&b=
uf, TLV_TYPE_EARLY_NEG_FLAGS, false,
+                                     =
  EARLY_NEG_FLAG_RESEND_WKC));
+    const uint8_t expected[] =3D { 0x00, 0x=
01, 0x00, 0x02, 0x00, 0x01 };
+    assert_int_equal(BLEN(&buf), sizeof(expe=
cted));
+    assert_memory_equal(BPTR(&buf), expected, sizeof(expected));
+=

+    /* the optional flag is the most significant bit of the type field */=

+    buf_clear(&buf);
+    assert_true(ctrl_msg_tlv_write_u16(&buf, TLV_TY=
PE_EARLY_NEG_FLAGS, true, 0));
+    assert_int_equal(BPTR(&buf)[0], 0x80);
=
+    assert_int_equal(BPTR(&buf)[1], 0x01);
+
+    gc_free(&gc);
+}
+
+/* A=
 TLV header survives the round trip, the optional flag kept apart from
+ * =
the 15-bit type=2E */
+void
+test_tlv_header_roundtrip(void **state)
+{
+  =
  struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(=
16, &gc);
+
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x1234, true, =
5));
+    assert_int_equal(BLEN(&buf), 4);
+
+    struct ctrl_msg_tlv_heade=
r hdr;
+    assert_true(ctrl_msg_tlv_read_header(&buf, &hdr));
+    assert_=
int_equal(hdr=2Etype, 0x1234);
+    assert_true(hdr=2Eoptional);
+    asser=
t_int_equal(hdr=2Evalue_len, 5);
+    assert_int_equal(BLEN(&buf), 0);
+
+ =
   gc_free(&gc);
+}
+
+/* Walking a payload returns each TLV in turn, with =
a value covering exactly
+ * its bytes, and consumes the payload=2E */
+voi=
d
+test_tlv_next_walks_payload(void **state)
+{
+    struct gc_arena gc =3D=
 gc_new();
+    struct buffer buf =3D alloc_buf_gc(64, &gc);
+
+    assert_=
true(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 0xabcd))=
;
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    a=
ssert_true(buf_write_u32(&buf, 0x11223344));
+    assert_true(ctrl_msg_tlv_=
write_header(&buf, 0x5, false, 0)); /* empty value */
+
+    struct ctrl_ms=
g_tlv_header hdr;
+    struct buffer value;
+
+    assert_true(ctrl_msg_tlv=
_next(&buf, &hdr, &value));
+    assert_int_equal(hdr=2Etype, TLV_TYPE_EARL=
Y_NEG_FLAGS);
+    assert_false(hdr=2Eoptional);
+    assert_int_equal(BLEN=
(&value), 2);
+    assert_int_equal(buf_read_u16(&value), 0xabcd);
+
+    a=
ssert_true(ctrl_msg_tlv_next(&buf, &hdr, &value));
+    assert_int_equal(hd=
r=2Etype, 0x7ff);
+    assert_true(hdr=2Eoptional);
+    assert_int_equal(B=
LEN(&value), 4);
+    assert_int_equal(buf_read_u32(&value, NULL), 0x112233=
44);
+
+    assert_true(ctrl_msg_tlv_next(&buf, &hdr, &value));
+    assert=
_int_equal(hdr=2Etype, 0x5);
+    assert_int_equal(BLEN(&value), 0);
+
+   =
 assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* A TLV heade=
r claiming more value bytes than the payload holds is rejected,
+ * rather =
than read past the end of the payload=2E */
+void
+test_tlv_next_value_trun=
cated(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct bu=
ffer buf =3D alloc_buf_gc(64, &gc);
+
+    assert_true(ctrl_msg_tlv_write_h=
eader(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 8));
+    assert_true(buf_writ=
e_u32(&buf, 0));
+
+    struct ctrl_msg_tlv_header hdr;
+    struct buffer =
value;
+    assert_false(ctrl_msg_tlv_next(&buf, &hdr, &value));
+
+    gc_=
free(&gc);
+}
+
+/* Reading a TLV header must fail when the buffer holds le=
ss data than a
+ * complete 4-byte header, rather than read past the availa=
ble data=2E */
+void
+test_tlv_header_truncated(void **state)
+{
+    struc=
t gc_arena gc =3D gc_new();
+    const uint8_t bytes[] =3D { 0x00, 0x01, 0x=
00 };
+
+    /* 0 to 3 bytes: none, part of the type field, the type field,=
 and the type
+     * field with half of the length */
+    for (size_t n =
=3D 0; n <=3D sizeof(bytes); n++)
+    {
+        struct buffer buf =3D all=
oc_buf_gc(16, &gc);
+        assert_true(buf_write(&buf, bytes, n));
+     =
   struct buffer copy =3D buf;
+
+        struct ctrl_msg_tlv_header hdr;
+=
        struct buffer value;
+        assert_false(ctrl_msg_tlv_read_header=
(&buf, &hdr));
+        assert_false(ctrl_msg_tlv_next(&copy, &hdr, &value)=
);
+    }
+
+    gc_free(&gc);
+}
+
+/* Writing fails, rather than writes a=
 partial TLV, when buf is too small=2E */
+void
+test_tlv_write_no_room(voi=
d **state)
+{
+    struct gc_arena gc =3D gc_new();
+
+    struct buffer bu=
f =3D alloc_buf_gc(3, &gc);
+    assert_false(ctrl_msg_tlv_write_header(&bu=
f, TLV_TYPE_EARLY_NEG_FLAGS, false, 2));
+    assert_int_equal(BLEN(&buf), =
0);
+
+    /* room for the header but not the value */
+    buf =3D alloc_b=
uf_gc(5, &gc);
+    assert_false(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARL=
Y_NEG_FLAGS, false, 1));
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_fr=
ee(&gc);
+}
diff --git a/tests/unit_tests/openvpn/test_control_msg=2Eh b/te=
sts/unit_tests/openvpn/test_control_msg=2Eh
new file mode 100644
index 0000=
000=2E=2Eef7a030
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_control_=
msg=2Eh
@@ -0,0 +1,37 @@
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
+#ifndef TEST_CONTROL_MSG_H
+#define=
 TEST_CONTROL_MSG_H
+
+void test_tlv_write_u16_wire_format(void **state);
+=

+void test_tlv_header_roundtrip(void **state);
+
+void test_tlv_next_walks=
_payload(void **state);
+
+void test_tlv_next_value_truncated(void **state)=
;
+
+void test_tlv_header_truncated(void **state);
+
+void test_tlv_write_n=
o_room(void **state);
+#endif
diff --git a/tests/unit_tests/openvpn/test_pk=
t=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index fbbb40f=2E=2E990a317 10=
0644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/ope=
nvpn/test_pkt=2Ec
@@ -37,12 +37,14 @@
 #include "crypto=2Eh"
 #include "opt=
ions=2Eh"
 #include "ssl_backend=2Eh"
+#include "control_msg=2Eh"
 #include=
 "ssl_pkt=2Eh"
 #include "tls_crypt=2Eh"
 
 #include "mss=2Eh"
 #include "r=
eliable=2Eh"
 #include "siphash=2Eh"
+#include "test_control_msg=2Eh"
 
 in=
t
 parse_line(const char *line, char **p, const int n, const char *file, co=
nst int line_num,
@@ -655,6 +657,46 @@
     free_buf(&tas=2Eworkbuf);
 }
 
=
+/* A reset reply asking a tls-crypt-v2 client to resend its WKc ends in th=
e
+ * early negotiation flags TLV, the bytes older versions wrote by hand, =
and the
+ * TLV parses back=2E */
+static void
+test_generate_reset_packet_=
resend_wkc(void **ut_state)
+{
+    struct tls_auth_standalone tas =3D { 0 =
};
+
+    struct session_id client_id =3D { { 0, 1, 2, 3, 4, 5, 6, 7 } };
+=
    struct session_id server_id =3D { { 8, 9, 0, 9, 8, 7, 6, 2 } };
+
+    =
tas=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;
+    struct frame frame =3D { =2Eb=
uf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, 0 };
+    tas=2Ef=
rame =3D frame;
+    tas=2Eworkbuf =3D alloc_buf(1600);
+
+    uint8_t head=
er =3D 0 | (P_CONTROL_HARD_RESET_SERVER_V2 << P_OPCODE_SHIFT);
+
+    struc=
t buffer plain =3D
+        tls_reset_standalone(&tas=2Etls_wrap, &tas, &cl=
ient_id, &server_id, header, false);
+    const int plain_len =3D BLEN(&pla=
in);
+    struct buffer buf =3D
+        tls_reset_standalone(&tas=2Etls_wr=
ap, &tas, &client_id, &server_id, header, true);
+
+    const uint8_t tlv[]=
 =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };
+    assert_int_equal(BLEN(&bu=
f), plain_len + (int)sizeof(tlv));
+    assert_memory_equal(BPTR(&buf) + pl=
ain_len, tlv, sizeof(tlv));
+
+    struct buffer payload =3D buf;
+    asse=
rt_true(buf_advance(&payload, plain_len));
+    struct ctrl_msg_tlv_header =
hdr;
+    struct buffer value;
+    assert_true(ctrl_msg_tlv_next(&payload,=
 &hdr, &value));
+    assert_int_equal(hdr=2Etype, TLV_TYPE_EARLY_NEG_FLAGS=
);
+    assert_int_equal(buf_read_u16(&value), EARLY_NEG_FLAG_RESEND_WKC);
=
+    assert_int_equal(BLEN(&payload), 0);
+
+    free_buf(&tas=2Eworkbuf);
=
+}
+
 static void
 test_generate_reset_packet_tls_auth(void **ut_state)
 {
=
@@ -791,9 +833,16 @@
         cmocka_unit_test(test_verify_hmac_tls_auth),
=
         cmocka_unit_test(test_verify_hmac_none_out_of_range_ack),
        =
 cmocka_unit_test(test_generate_reset_packet_plain),
+        cmocka_unit_t=
est(test_generate_reset_packet_resend_wkc),
         cmocka_unit_test(test_=
generate_reset_packet_tls_auth),
         cmocka_unit_test(test_wkc_not_app=
ended_without_key),
-        cmocka_unit_test(test_extract_control_message)=

+        cmocka_unit_test(test_extract_control_message),
+        cmocka_u=
nit_test(test_tlv_write_u16_wire_format),
+        cmocka_unit_test(test_tl=
v_header_roundtrip),
+        cmocka_unit_test(test_tlv_next_walks_payload)=
,
+        cmocka_unit_test(test_tlv_next_value_truncated),
+        cmocka=
_unit_test(test_tlv_header_truncated),
+        cmocka_unit_test(test_tlv_w=
rite_no_room)
     };
 
     return cmocka_run_group_tests_name("pkt tests"=
, tests, NULL, NULL);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1965?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Gerrit-Change-Number: 1965=

Gerrit-PatchSet: 5
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerr=
it-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Lev Stipakov <lstipakov@gmail=2Ecom=
>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Att=
ention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--i6OTljHKBiI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, Lev Stipakov, R=C4=83zvan Cojocaru=
=2E </p>
<p>Lev Stipakov <strong>uploaded patch set #5</strong> to this cha=
nge=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=
=3Demail">View Change</a></p><p>The following approvals got outdated and we=
re removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">control_=
msg: Add a shared TLV codec and use it for early negotiation<br><br>Early n=
egotiation in the reset packets is a sequence of TLVs, and<br>planned out-o=
f-band and control data messages will use the same TLV<br>format and type s=
pace=2E Add one TLV codec for all of them,<br>control_msg=2Ec/h, and move e=
arly negotiation onto it=2E<br><br>The codec only handles the framing: read=
ing and writing TLV headers,<br>writing a 16-bit TLV, and walking a payload=
 TLV by TLV with each value<br>checked against the payload=2E How to treat =
an unknown type is up to each<br>message=2E<br><br>The codec splits the top=
 bit of the type field off as the &quot;optional&quot;<br>flag, which the p=
revious early negotiation parser did not do=2E The flags<br>TLV is defined =
with that bit clear, so the parser only accepts it when<br>the bit is clear=
 and skips the type word 0x8001 as unknown exactly as<br>before=2E No funct=
ional change=2E<br><br>Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146=
<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M CMake=
Lists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>A src/openvpn/control_msg=2Ec=
<br>A src/openvpn/control_msg=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn=
/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>M tests/unit_tests/openvpn/Mak=
efile=2Eam<br>A tests/unit_tests/openvpn/test_control_msg=2Ec<br>A tests/un=
it_tests/openvpn/test_control_msg=2Eh<br>M tests/unit_tests/openvpn/test_pk=
t=2Ec<br>11 files changed, 498 insertions(+), 23 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/65/1965/5</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</spa=
n><br><span>index 5cf1a30=2E=2E305c26c 100644</span><br><span>--- a/CMakeLi=
sts=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -457,6 =
+457,8 @@</span><br><span>     src/openvpn/console=2Ec</span><br><span>    =
 src/openvpn/console_builtin=2Ec</span><br><span>     src/openvpn/console=
=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn=
/control_msg=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 src/openvpn/control_msg=2Eh</span><br><span>     src/openvpn/crypto=2Ec</s=
pan><br><span>     src/openvpn/crypto=2Eh</span><br><span>     src/openvpn/=
crypto_backend=2Eh</span><br><span>@@ -896,6 +898,8 @@</span><br><span> </s=
pan><br><span>     target_sources(test_pkt PRIVATE</span><br><span>        =
 tests/unit_tests/openvpn/mock_win32_execve=2Ec</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/test_control_m=
sg=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/o=
penvpn/control_msg=2Ec</span><br><span>         src/openvpn/argv=2Ec</span>=
<br><span>         src/openvpn/base64=2Ec</span><br><span>         src/open=
vpn/crypto_epoch=2Ec</span><br><span>diff --git a/src/openvpn/Makefile=2Eam=
 b/src/openvpn/Makefile=2Eam</span><br><span>index bb31053=2E=2Ebe1044d 100=
644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/s=
rc/openvpn/Makefile=2Eam</span><br><span>@@ -57,6 +57,7 @@</span><br><span>=
 	common=2Eh \</span><br><span> 	comp=2Ec comp=2Eh compstub=2Ec \</span><br=
><span> 	comp-lz4=2Ec comp-lz4=2Eh \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	control_msg=2Ec control_msg=2Eh \</span><br><span> 	crypt=
o=2Ec crypto=2Eh crypto_backend=2Eh \</span><br><span> 	crypto_openssl=2Ec =
crypto_openssl=2Eh \</span><br><span> 	crypto_mbedtls=2Ec crypto_mbedtls=2E=
h \</span><br><span>diff --git a/src/openvpn/control_msg=2Ec b/src/openvpn/=
control_msg=2Ec</span><br><span>new file mode 100644</span><br><span>index =
0000000=2E=2E872191f</span><br><span>--- /dev/null</span><br><span>+++ b/sr=
c/openvpn/control_msg=2Ec</span><br><span>@@ -0,0 +1,93 @@</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP n=
etworks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   over a single TCP/UDP port, with support for SSL/TLS-based</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             session authentica=
tion and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *             packet encryption, packet authentication, and</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compressi=
on=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 Ope=
nVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  This program is free software; you can redistribute it and/or modify</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms=
 of the GNU General Public License version 2</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed i=
n the hope that it will be useful,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warra=
nty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTA=
BILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more =
details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have receiv=
ed a copy of the GNU General Public License along</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https:=
//www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;conf=
ig=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ctrl_msg_tlv_write_header(struct buffer *buf, uint16_t type, b=
ool optional, uint16_t value_len)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* the type has 15 bits; the top bit is the optional flag */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(type &lt;=3D CTRL_MSG_T=
LV_TYPE_MASK);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Write nothing unl=
ess the whole TLV fits=2E The header promises that</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * value_len bytes follow it, so a heade=
r written without room for the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * value would leave a partial TLV in buf=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_safe(buf, (size_t)C=
TRL_MSG_TLV_HEADER_LEN + value_len))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint1=
6_t field =3D type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (optional)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        field |=
=3D CTRL_MSG_TLV_OPTIONAL_FLAG;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return buf_write_u16(buf, field) &amp;&amp; buf_write_u16(buf, value_len)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ctrl_msg_tlv_write_u16(struct buffer *buf, uint16_t type, bool optiona=
l, uint16_t value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ctrl_msg=
_tlv_write_header(buf, type, optional, sizeof(uint16_t))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16(bu=
f, value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ctrl_msg_tlv_read_header(struct buffer *buf, struct ctrl_msg_=
tlv_header *hdr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int field =3D buf=
_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (field &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return f=
alse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int len =3D buf_read_u16=
(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (len &=
lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt;type =3D (uint16_t)(field &=
amp; CTRL_MSG_TLV_TYPE_MASK);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    hdr-&gt;optional =3D (field &amp; CTRL_MSG_TLV_OPTIONAL_FLAG)=
 !=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt=
;value_len =3D (uint16_t)len;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_next(struct buffer *buf, struct =
ctrl_msg_tlv_header *hdr, struct buffer *value)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (!ctrl_msg_tlv_read_header(buf, hdr))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return false; /* fewer than 4 bytes left: trun=
cated header */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Advance pas=
t the value; fails if buf is shorter than the header claims=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *v =3D buf_=
read_alloc(buf, hdr-&gt;value_len);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!v)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(v=
alue, v, hdr-&gt;value_len);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span>diff --git a/src/openvpn/control_msg=2Eh b/src/open=
vpn/control_msg=2Eh</span><br><span>new file mode 100644</span><br><span>in=
dex 0000000=2E=2E7d25545</span><br><span>--- /dev/null</span><br><span>+++ =
b/src/openvpn/control_msg=2Eh</span><br><span>@@ -0,0 +1,107 @@</span><br><=
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
=3D"color: hsl(120, 100%, 40%);">+ * TLV framing shared by the TLV-based co=
ntrol messages of the wire protocol=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Such a message payload is a sequence of TLV entries=2E Each TLV starts=
 with a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * 4-byte he=
ader: a 16-bit field whose most significant bit is the &quot;optional&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * flag and whose r=
emaining 15 bits are the type, followed by a 16-bit length</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * giving the size of the value that=
 follows the header=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * All of thes=
e messages share one TLV type space, so the TLV types are all</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * defined here=2E Only the frami=
ng is handled here: what a message does with a</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * TLV type it does not know, marked optional or=
 not, is up to its parser=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef CONTROL_MSG_H</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CONTROL_MSG_H</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* TLV types */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define TLV_TYPE_EARLY_NEG_FLAGS 0x0001 /* early neg=
otiation, in the reset packets */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* TL=
V header bit layout of the first 16-bit field */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* A TLV header is a 16-bit type/optional fiel=
d plus a 16-bit length */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define CTRL_MSG_TLV_HEADER_LEN 4</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define CTRL_MSG_TLV_OPTIONAL_FLAG 0x8000</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define CTRL_MSG_TLV_TYPE_MASK     0x7fff</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/** The header every TLV carries: the 15-bit type=
 and optional flag packed into</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * the first 16-bit field, then the length of the value that fol=
lows=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct ct=
rl_msg_tlv_header</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t type;  =
    /**&lt; the 15-bit TLV type */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    bool optional;      /**&lt; value of the optional flag *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t value=
_len; /**&lt; length of the value following the header */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a TLV=
 header (type + optional flag + value length) to buf=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * type must fit in the 15 bits of the =
type field=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Nothing is written u=
nless the header and the value_len bytes of value</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * that follow it both fit, so a failed write=
 never leaves a partial TLV</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * behind=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true =
on success, false if buf has insufficient space=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool ctrl_msg_tlv_write_header(struct buffer *buf, uint16_t =
type, bool optional,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                               uint16_t value_len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Write a complete TLV whose value is a single 16-bit integer to buf=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false if buf=
 has insufficient space=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ctrl=
_msg_tlv_write_u16(struct buffer *buf, uint16_t type, bool optional, uint16=
_t value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Read a TLV header from buf, advancing pas=
t it=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf  buffer positio=
ned at the TLV header</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param hdr  filled with the type, optional flag and value length on su=
ccess</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return tru=
e on success, false if there are not enough bytes for a header=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_read_header(struct buffer *=
buf, struct ctrl_msg_tlv_header *hdr);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read the next=
 TLV from buf, advancing past its header and value=2E Call it</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * while BLEN(buf) &gt; 0 to walk=
 a whole payload=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The length fro=
m the header is validated against buf, so on success the</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * whole value is present: a header cl=
aiming more bytes than buf holds is</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * rejected=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram buf    buffer positioned at a TLV header</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param hdr    filled with the TLV&#39;s type, o=
ptional flag and value length</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param value  set to a buffer covering exactly the TLV&#39;s v=
alue; it points</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
             into buf and owns no storage</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @return true on success, false if the header or th=
e value is truncated; buf</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *         may then be left partly consumed=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+bool ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_ms=
g_tlv_header *hdr, struct buffer *value);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif /* ifndef CONTROL_MSG_H */</span><br><span>diff --git a/src/openv=
pn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 12b6119=2E=2Ee531613=
 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src=
/openvpn/ssl=2Ec</span><br><span>@@ -52,6 +52,7 @@</span><br><span> #includ=
e &quot;pkcs11=2Eh&quot;</span><br><span> #include &quot;route=2Eh&quot;</s=
pan><br><span> #include &quot;tls_crypt=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><b=
r><span> </span><br><span> #include &quot;crypto_epoch=2Eh&quot;</span><br>=
<span> #include &quot;ssl=2Eh&quot;</span><br><span>@@ -2645,26 +2646,28 @@=
</span><br><span> {</span><br><span>     while (buf-&gt;len &gt; 0)</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (buf_len(buf) &lt; 4)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     goto error;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* read t=
ype */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int typ=
e =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        int len =3D buf_read_u16(buf);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (type &lt; 0 || len &lt; 0 || buf_len(buf) &=
lt; len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        str=
uct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        struct buffer value;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (!ctrl_msg_tlv_next(buf, &amp;hdr, &amp;value)=
)</span><br><span>         {</span><br><span>             goto error;</span=
><br><span>         }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        switch (type)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        switch (hdr=2Etype)</span><br><span>         {<=
/span><br><span>             case TLV_TYPE_EARLY_NEG_FLAGS:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                if (len !=3D sizeof(u=
int16_t))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      /* This TLV is defined with the optional bit clear=2E A type</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                 * word that=
 has the bit set is not this TLV, so skip it as</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                 * an unknown type rather than =
parsing it as the flags=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                if (hdr=2Eoptional)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    break;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                if (BLEN(&amp;value) !=3D size=
of(uint16_t))</span><br><span>                 {</span><br><span>          =
           goto error;</span><br><span>                 }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                int flags =3D buf_read_=
u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      int flags =3D buf_read_u16(&amp;value);</span><br><span> </span><br><=
span>                 if (flags &amp; EARLY_NEG_FLAG_RESEND_WKC)</span><br>=
<span>                 {</span><br><span>@@ -2683,8 +2686,8 @@</span><br><s=
pan>                 break;</span><br><span> </span><br><span>             =
default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   /* Skip types we do not parse */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                buf_advance(buf, len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                /* Skip types we do not p=
arse, marked optional or not */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                break;</span><br><span>         }</span><br><sp=
an>     }</span><br><span>     reliable_mark_deleted(ks-&gt;rec_reliable, b=
uf);</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl=
_pkt=2Ec</span><br><span>index f78782f=2E=2Ef4564ef 100644</span><br><span>=
--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec=
</span><br><span>@@ -33,6 +33,7 @@</span><br><span> #include &quot;reliable=
=2Eh&quot;</span><br><span> #include &quot;siphash=2Eh&quot;</span><br><spa=
n> #include &quot;tls_crypt=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><span> </s=
pan><br><span> /*</span><br><span>  * Dependent on hmac size, opcode size, =
and session_id size=2E</span><br><span>@@ -432,9 +433,8 @@</span><br><span>=
     /* Add indication for tls-crypt-v2 to resend the WKc with the reply */=
</span><br><span>     if (request_resend_wkc)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_write_u16(&amp;b=
uf, TLV_TYPE_EARLY_NEG_FLAGS); /* TYPE: flags */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        buf_write_u16(&amp;buf, sizeof(uint16_t)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_write_u=
16(&amp;buf, EARLY_NEG_FLAG_RESEND_WKC);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        ASSERT(ctrl_msg_tlv_write_u16(&amp;buf, TLV_TY=
PE_EARLY_NEG_FLAGS, false,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                      EARLY_NEG_FLAG_RESEND_WKC));</=
span><br><span>     }</span><br><span> </span><br><span>     /* Add tls-aut=
h/tls-crypt wrapping, this might replace buf with</span><br><span>diff --gi=
t a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index=
 8203e4a=2E=2E218c6bb 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh<=
/span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -306,10 +3=
06,8 @@</span><br><span> #define EARLY_NEG_START 0x0f000000</span><br><span=
> </span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
* Early negotiation that part of the server response in the RESET_V2 packet=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Since clients t=
hat announce early negotiation support will treat the payload</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * of reset packets special and par=
se it as TLV messages=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * as TLV (type, length, value) */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define TLV_TYPE_EARLY_NEG_FLAGS  0x0001</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* Early negotiation: clients that ann=
ounce support for it parse the payload of</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * the reset packets as TLVs (see control_msg=2Eh)=2E=
 Flags carried in the value of</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * the TLV_TYPE_EARLY_NEG_FLAGS TLV: */</span><br><span> #define=
 EARLY_NEG_FLAG_RESEND_WKC 0x0001</span><br><span> #endif /* ifndef SSL_PKT=
_H */</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b=
/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 70cf7b2=2E=2E=
11f92f4 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam=
</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><sp=
an>@@ -164,11 +164,15 @@</span><br><span> 	-I$(top_srcdir)/include -I$(top_=
srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span> 	@TEST_CF=
LAGS@</span><br><span> pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-pkt_testdriver_SOURCES =3D test_=
pkt=2Ec mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec test_common=2Eh \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+pkt_testdriver_SOURCE=
S =3D test_pkt=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	test_control_msg=2Ec test_control_msg=2Eh \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	test_common=2Eh \=
</span><br><span> 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br>=
<span> 	$(top_srcdir)/src/openvpn/argv=2Ec \</span><br><span> 	$(top_srcdir=
)/src/openvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buff=
er=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcd=
ir)/src/openvpn/control_msg=2Ec \</span><br><span> 	$(top_srcdir)/src/openv=
pn/crypto=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch=2E=
c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \</span>=
<br><span>diff --git a/tests/unit_tests/openvpn/test_control_msg=2Ec b/test=
s/unit_tests/openvpn/test_control_msg=2Ec</span><br><span>new file mode 100=
644</span><br><span>index 0000000=2E=2Ea199baf</span><br><span>--- /dev/nul=
l</span><br><span>+++ b/tests/unit_tests/openvpn/test_control_msg=2Ec</span=
><br><span>@@ -0,0 +1,179 @@</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Open=
VPN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port=
, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             session authentication and key exchange,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encr=
yption, packet authentication, and</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet compression=2E</span><br><span style=
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
or: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &lt;stdarg=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &lt;stddef=2Eh&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_pkt=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;test_control_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The=
 early negotiation flags TLV of a reset packet asking a tls-crypt-v2</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * client to resend its WK=
c, as older versions wrote it by hand=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+test_tlv_write_u16_wire_format(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(16=
, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tl=
v_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                       E=
ARLY_NEG_FLAG_RESEND_WKC));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const uint8_t expected[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x=
01 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(BLEN(&amp;buf), sizeof(expected));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf), expected, siz=
eof(expected));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the optional fla=
g is the most significant bit of the type field */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    buf_clear(&amp;buf);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_u16(=
&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, true, 0));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(BPTR(&amp;buf)[0], 0x80);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
BPTR(&amp;buf)[1], 0x01);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* A TLV header survives the round trip, the opt=
ional flag kept apart from</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * the 15-bit type=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tes=
t_tlv_header_roundtrip(void **state)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(16, &amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&am=
p;buf, 0x1234, true, 5));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(BLEN(&amp;buf), 4);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_read_header(&amp;buf, =
&amp;hdr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(hdr=2Etype, 0x1234);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(hdr=2Eoptional);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Evalue_len, 5);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(=
&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* Walking a payload returns each TLV in turn, with a value=
 covering exactly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 its bytes, and consumes the payload=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+test_tlv_next_walks_payload(void **state)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(64, &am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_wri=
te_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 0xabcd));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_=
header(&amp;buf, 0x7ff, true, 4));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0x11223344));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_t=
lv_write_header(&amp;buf, 0x5, false, 0)); /* empty value */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct ctrl_msg_tlv_header hdr;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_next(&amp;buf, &amp;hd=
r, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(hdr=2Etype, TLV_TYPE_EARLY_NEG_FLAGS);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_false(hdr=2Eoptional);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLE=
N(&amp;value), 2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(buf_read_u16(&amp;value), 0xabcd);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(ctrl_msg_tlv_next(&amp;buf, &amp;hdr, &amp;=
value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(hdr=2Etype, 0x7ff);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(hdr=2Eoptional);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), 4);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(buf_read=
_u32(&amp;value, NULL), 0x11223344);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(ctrl_msg_tlv_next(&amp;buf, &amp;hdr, &amp;value));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Ety=
pe, 0x5);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(BLEN(&amp;value), 0);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* A TLV header claiming more value byt=
es than the payload holds is rejected,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * rather than read past the end of the payload=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_tlv_next_value_truncated(void **=
state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_n=
ew();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buf=
fer buf =3D alloc_buf_gc(64, &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(ctrl_msg_tlv_write_header(&amp;buf, TLV_TYPE_EARLY_NEG_FLAG=
S, false, 8));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(buf_write_u32(&amp;buf, 0));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct buffer value;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_false(ctrl_msg_tlv_next(&amp;buf, &amp;hdr=
, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* Reading a TLV header must fail when the buffer holds le=
ss data than a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * co=
mplete 4-byte header, rather than read past the available data=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_tlv_header_truncated(void **state)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t byte=
s[] =3D { 0x00, 0x01, 0x00 };</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* 0 =
to 3 bytes: none, part of the type field, the type field, and the type</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * field with half o=
f the length */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
for (size_t n =3D 0; n &lt;=3D sizeof(bytes); n++)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        struct buffer buf =3D alloc_buf_gc(16, &amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_true(b=
uf_write(&amp;buf, bytes, n));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        struct buffer copy =3D buf;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct buffer value;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        assert_false(ctrl_msg_tlv_read=
_header(&amp;buf, &amp;hdr));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        assert_false(ctrl_msg_tlv_next(&amp;copy, &amp;hdr, &amp;=
value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Writing fails, rather than writes a partial TLV, when buf is too small=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+test_tlv_write_no_room(void **sta=
te)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_=
gc(3, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_false(ctrl_msg_tlv_write_header(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, =
false, 2));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 room for the header but not the value */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    buf =3D alloc_buf_gc(5, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_tlv_write=
_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 1));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/tests/=
unit_tests/openvpn/test_control_msg=2Eh b/tests/unit_tests/openvpn/test_con=
trol_msg=2Eh</span><br><span>new file mode 100644</span><br><span>index 000=
0000=2E=2Eef7a030</span><br><span>--- /dev/null</span><br><span>+++ b/tests=
/unit_tests/openvpn/test_control_msg=2Eh</span><br><span>@@ -0,0 +1,37 @@</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to secur=
ely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *             over a single TCP/UDP port, with support for SSL/TLS-base=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             ses=
sion authentication and key exchange,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *             packet encryption, packet authentication, =
and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             p=
acket compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C=
) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=
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
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnd=
ef TEST_CONTROL_MSG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define TEST_CONTROL_MSG_H</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_=
tlv_write_u16_wire_format(void **state);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+void test_tlv_header_roundtrip(void **state);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void test_tlv_next_walks_payload(void **state);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void test_tlv_next_value_truncated(void **state);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void test_tlv_header_truncated(void **state);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void test_tlv_write_no_room(void **stat=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_test=
s/openvpn/test_pkt=2Ec</span><br><span>index fbbb40f=2E=2E990a317 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+=
++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -37,12 +37,14=
 @@</span><br><span> #include &quot;crypto=2Eh&quot;</span><br><span> #incl=
ude &quot;options=2Eh&quot;</span><br><span> #include &quot;ssl_backend=2Eh=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;control_msg=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&quot;</=
span><br><span> #include &quot;tls_crypt=2Eh&quot;</span><br><span> </span>=
<br><span> #include &quot;mss=2Eh&quot;</span><br><span> #include &quot;rel=
iable=2Eh&quot;</span><br><span> #include &quot;siphash=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_control_m=
sg=2Eh&quot;</span><br><span> </span><br><span> int</span><br><span> parse_=
line(const char *line, char **p, const int n, const char *file, const int l=
ine_num,</span><br><span>@@ -655,6 +657,46 @@</span><br><span>     free_buf=
(&amp;tas=2Eworkbuf);</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* A reset reply asking a tls-crypt-=
v2 client to resend its WKc ends in the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * early negotiation flags TLV, the bytes older version=
s wrote by hand, and the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * TLV parses back=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+test_generate_reset_packet_resend_wkc(void **ut_state)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct tls_auth_standalone tas =3D { 0 };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct session_id client_id =3D { { 0, 1, 2, =
3, 4, 5, 6, 7 } };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct session_id server_id =3D { { 8, 9, 0, 9, 8, 7, 6, 2 } };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    tas=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct frame frame=
 =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, 0 };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas=2Eframe =3D f=
rame;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas=2Ework=
buf =3D alloc_buf(1600);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t he=
ader =3D 0 | (P_CONTROL_HARD_RESET_SERVER_V2 &lt;&lt; P_OPCODE_SHIFT);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer plain =3D</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        tls_reset_standalone(&amp=
;tas=2Etls_wrap, &amp;tas, &amp;client_id, &amp;server_id, header, false);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int plain_=
len =3D BLEN(&amp;plain);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct buffer buf =3D</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        tls_reset_standalone(&amp;tas=2Etls_wrap, &amp;tas, &am=
p;client_id, &amp;server_id, header, true);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const uint8_t tlv[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(B=
LEN(&amp;buf), plain_len + (int)sizeof(tlv));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf) + plain_le=
n, tlv, sizeof(tlv));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer=
 payload =3D buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(buf_advance(&amp;payload, plain_len));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_header hdr;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl=
_msg_tlv_next(&amp;payload, &amp;hdr, &amp;value));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, TLV_TYPE=
_EARLY_NEG_FLAGS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(buf_read_u16(&amp;value), EARLY_NEG_FLAG_RESEND_WKC);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
BLEN(&amp;payload), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&a=
mp;tas=2Eworkbuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> s=
tatic void</span><br><span> test_generate_reset_packet_tls_auth(void **ut_s=
tate)</span><br><span> {</span><br><span>@@ -791,9 +833,16 @@</span><br><sp=
an>         cmocka_unit_test(test_verify_hmac_tls_auth),</span><br><span>  =
       cmocka_unit_test(test_verify_hmac_none_out_of_range_ack),</span><br>=
<span>         cmocka_unit_test(test_generate_reset_packet_plain),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(tes=
t_generate_reset_packet_resend_wkc),</span><br><span>         cmocka_unit_t=
est(test_generate_reset_packet_tls_auth),</span><br><span>         cmocka_u=
nit_test(test_wkc_not_appended_without_key),</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        cmocka_unit_test(test_extract_control_messag=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_un=
it_test(test_extract_control_message),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        cmocka_unit_test(test_tlv_write_u16_wire_format)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_uni=
t_test(test_tlv_header_roundtrip),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        cmocka_unit_test(test_tlv_next_walks_payload),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(=
test_tlv_next_value_truncated),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        cmocka_unit_test(test_tlv_header_truncated),</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_=
tlv_write_no_room)</span><br><span>     };</span><br><span> </span><br><spa=
n>     return cmocka_run_group_tests_name(&quot;pkt tests&quot;, tests, NUL=
L, NULL);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1965?usp=3Demail">change 1965</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> G=
errit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I89c3133e009dc75dc2c10=
c607b3f0a24c04e8146 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1965 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;r=
azvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html=
>
--i6OTljHKBiI=--


--===============4743162413297520164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4743162413297520164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4743162413297520164==--

