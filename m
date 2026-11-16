Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA21606A323
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VY50G9zh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NEjMFIrW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JFcXjEF9;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Cdsddja7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3NWE1LBhKg47fdQZ9YpmTPiR/o6pRRpNkvDi9QE439A=; b=VY50G9zha3gKufFs8j9FjgaPtY
	ravocYe4CoERt/+JBVq7JJZHGtwVquM0QbA0zAgQKmHJhbtNPL3pWicZDExShvp4uKyO+NtsZJNbu
	KSsz8UCqJUdMG6F1utI0lSJioj8yh7gbJqIqhVT0EYAOn9p1bKuRgKyV0TLb82LMaHMQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSxms-000000001xa-0Tbs;
	Mon, 16 Nov 2026 14:34:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSxmT-000000001wt-14af
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:34:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NeoHFVNVbwonL7k9qEObcL7L6kMDOlvZu/MWpV2KIVA=; b=NEjMFIrWCZPybnF888uqspZQuj
 Em+b/J25veID2p86oka3quGbWsB9i9Nu1D5BETcIPSr01hrb287ekA0LLxcZNJ4ykv9r7xnfZj+Pl
 f2tkuGIqJnr4eGfyjntUd952n29n7xhX/cdaSo6ZNsR2dIvkuLb7QCmnfZKDHWWVI1q4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NeoHFVNVbwonL7k9qEObcL7L6kMDOlvZu/MWpV2KIVA=; b=JFcXjEF9C6R/AX5QDjCt91VGnj
 r8s75Wzn0u6iAXtyMDMlHrotkS6DSA3lakhnNvKE0Yj5VergAM5kP6Nk/t3xpqi692mMWyOCtlP+W
 9zNun/UpVMBeFnNjoV9AP0tWSINzy76/bWfQYTGtUG6CsATDhiP7wjaa5vQ6cFlfiX2c=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSxmA-0000000064S-1N58 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:33:48 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4bb61185057so14117905e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 06:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794839616; x=1795444416; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NeoHFVNVbwonL7k9qEObcL7L6kMDOlvZu/MWpV2KIVA=;
 b=Cdsddja7Jrfij1dsUZI2/jKWjXGZ5rQTp9jy7+Mia/4hFXs7ExLLv49ORFKyDzCqgt
 m9neajBrbmnzYUh7YlW7unrIHK3v//OA6NODhG8Z+NlB66WdmhtqDjyflyqfTdbr8mDv
 WydvLPyqTBGsHv96Lqt5hzIVqPZM/QfaCj6JhQgpDbdFMGAE8j/6wv7rsBtZ7l/Bsu6i
 dgEgE+fi0M948o90/poPnROsvBzZiyG9ZlMhaGI5sIVAx9aR63uwXrI+nGtAi1Y6Zc+E
 AmzYot4SrAmvtUVCyDTtXO779mjlXULQqzNsHjDHa2lIzkodnWZyymxD5laY+q5kjVww
 yf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794839616; x=1795444416;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NeoHFVNVbwonL7k9qEObcL7L6kMDOlvZu/MWpV2KIVA=;
 b=bVzPphya4aQ6d9ZD4fIzI35D+451GChJ1y68YAlNnxKbSD6gvjU7Z7Z5OX7MqHcRKY
 QAUCSf43Z6jtQ12AVZw6FUvsoxzt+1AvuTZPg3JZSauXALzVV+w5C47Yops0CO7PZ7Sa
 IUFNq9WpbHv9aaHf0tQYUXMphluEgr2QgVgRXLG0KU9RFy91CvFNRrwrvJ7fNdkVLPyb
 KH7pv3vWrEr+6KuGJbRBqaGnvIHKCpFKhRouVnXj/LKbq0/R9OC4Vbjyphec1HJRLWVs
 97re1YNzlnykgSjdMNd4rVKfwzC5Fx+FwvhPBIqLV4U98rZaGwcWXMLNLntOjlWP1cMc
 E46w==
X-Gm-Message-State: APuU4Z/dYSIc9Mm3NuiL5FzNr/zCf5BqZJZIBtfR000yaNj2f8H9GG0h
 H2y0iZQwRfVHYHGnFeYUAZxqMJ7D/aBzF7NPAL1Ep+K4tB+7OwF7S3Osp7vHif4YvLqbkHApfx8
 IQOXrq4SMNMjwRgkI+xJPGhCwcm8wy9ek/ay9smeSrZwMGnTTk6KzD6R8lf4wq+IZqDv5
X-Gm-Gg: AYBFou2B9FGj2/FwmwCq/H7nw0lDQJaen9AxIoUmbMI1UZZaT4vldGGx6h8tv9EkXx9
 I2Z9BjpWqynRiSh3V/7dXQJv5jA4XQWH+ufx3qVm1VwBW3RnbxBb1ID00sboM2nejhHWwMjpxin
 MMv+wOpLzCsy6MuHtqVHHMLDXFh2U1G3NsQ1vsJCV6V4EjhA1sepzgFbNA+emu6/pW8yfUmHpnA
 Rdth74Tou9ebhzixoReqaBOa8Z/ImckM6Hdak61Pyhx9Q+CWr60ks2LdH52dMJsnCqVl0OeSjCm
 /2FLbiHgTm7qk1KVHaG0lN4P9R4hN2UbGqY5HPM62wP7cFT11j8bJHtMhaUq/bvpS8zOeWODDq3
 25P7X9J2pQ5m41KHXzCKkc5do9HqixS0nHb1ZgOqk/xQUEANoI2tW5U33f+UfIBaHxCxmBDUZN8
 wWooX/nur3QeyRZEF7E7Vl437q3xTYo8nNoC0lNsro3eRuRi8TRk26Ja0tZVNwzmIhwEA27qxQ5
 6Jme8dmxEJweTbn1tLDoj1MferDbSBX2caHULfAgJDX4Q3FhMMKF8aoxH32LMR4d55JumtJWNfI
 uPLatrgyhsQJXbx22DTEPcXFfcfZe3lyihf2fkbbbTqmNcN72ZSVT46J1NKsmag1Pod/I2LShcR
 l0KR88pmWbo9aRxlG5YROFQ/Dpuh1u1d7/tNmtcrwrCM7WWp4VZJ/n5W3zUWlynIk/J/3OiLU0Q
 e8Kdnqlf7YFt80zcU=
X-Received: by 2002:a05:600c:6548:b0:4b0:c1ae:829 with SMTP id
 5b1f17b1804b1-4bb55a8d621mr167540035e9.30.1794839615225; 
 Mon, 16 Nov 2026 06:33:35 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb6fb45a32sm72114405e9.1.2026.11.16.06.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:33:34 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 14:33:32 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Steffan Karger <steffan@karger.me>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: 9c8fabfb154d8e55b56aef80ed34175a48cf2504
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c3c7f6f514543d7da2e391225b101be25de9dd60-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSxmA-0000000064S-1N58
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com, steffan@karger.me
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2838743398858937780=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2838743398858937780==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1IPvUacIAXU="; charset=UTF-8

--1IPvUacIAXU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov, R=C4=83zvan Cojocaru, Steffan Karger=2E

Hello Arne Schwabe, Fran=
k Lichtenheld, R=C4=83zvan Cojocaru, Steffan Karger, 

I'd like you to reex=
amine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1965?usp=3Demail

to look at the new patch set (#8)=2E

The following a=
pprovals got outdated and were removed:
Code-Review+1 by R=C4=83zvan Cojoca=
ru, Code-Review-1 by Steffan Karger


Change subject: control_msg: Add a sh=
ared TLV codec and use it for early negotiation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

control_msg: Add a shared TLV codec and =
use it for early negotiation

Early negotiation in the reset packets is a s=
equence of TLVs, and
planned out-of-band and control data messages will use=
 the same TLV
format and type space=2E Add one TLV codec for all of them,
c=
ontrol_msg=2Ec/h, and move early negotiation onto it=2E

The codec only han=
dles the framing: reading and writing TLV headers,
writing a 16-bit TLV, an=
d walking a payload TLV by TLV with each value
checked against the payload=
=2E How to treat an unknown type is up to each
message=2E With the optional=
 flag clear the codec writes the same bytes as
the hand-rolled code it repl=
aces=2E

In the codec the most significant bit of the type field is the
"op=
tional" flag rather than part of the type=2E The old parser compared
the wh=
ole type word, so 0x8001 did not match the flags TLV and was
skipped as unk=
nown; now it matches and is parsed as one=2E

Change-Id: I89c3133e009dc75dc=
2c10c607b3f0a24c04e8146
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---=

M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
A src/openvpn/control_msg=
=2Ec
A src/openvpn/control_msg=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_=
pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
=
A tests/unit_tests/openvpn/test_control_msg=2Ec
A tests/unit_tests/openvpn/=
test_control_msg=2Eh
M tests/unit_tests/openvpn/test_pkt=2Ec
11 files chang=
ed, 493 insertions(+), 23 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/65/1965/8

diff --git a/CMakeLists=2Etxt =
b/CMakeLists=2Etxt
index 5cf1a30=2E=2E305c26c 100644
--- a/CMakeLists=2Etxt=

+++ b/CMakeLists=2Etxt
@@ -457,6 +457,8 @@
     src/openvpn/console=2Ec
  =
   src/openvpn/console_builtin=2Ec
     src/openvpn/console=2Eh
+    src/op=
envpn/control_msg=2Ec
+    src/openvpn/control_msg=2Eh
     src/openvpn/cry=
pto=2Ec
     src/openvpn/crypto=2Eh
     src/openvpn/crypto_backend=2Eh
@@ =
-896,6 +898,8 @@
 
     target_sources(test_pkt PRIVATE
         tests/unit=
_tests/openvpn/mock_win32_execve=2Ec
+        tests/unit_tests/openvpn/test=
_control_msg=2Ec
+        src/openvpn/control_msg=2Ec
         src/openvpn/=
argv=2Ec
         src/openvpn/base64=2Ec
         src/openvpn/crypto_epoch=
=2Ec
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
ind=
ex bb31053=2E=2Ebe1044d 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/op=
envpn/Makefile=2Eam
@@ -57,6 +57,7 @@
 	common=2Eh \
 	comp=2Ec comp=2Eh co=
mpstub=2Ec \
 	comp-lz4=2Ec comp-lz4=2Eh \
+	control_msg=2Ec control_msg=2E=
h \
 	crypto=2Ec crypto=2Eh crypto_backend=2Eh \
 	crypto_openssl=2Ec crypt=
o_openssl=2Eh \
 	crypto_mbedtls=2Ec crypto_mbedtls=2Eh \
diff --git a/src/=
openvpn/control_msg=2Ec b/src/openvpn/control_msg=2Ec
new file mode 100644
=
index 0000000=2E=2Ee14355c
--- /dev/null
+++ b/src/openvpn/control_msg=2Ec
=
@@ -0,0 +1,93 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP n=
etworks
+ *             over a single TCP/UDP port, with support for SSL/TL=
S-based
+ *             session authentication and key exchange,
+ *       =
      packet encryption, packet authentication, and
+ *             packet =
compression=2E
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
+#ifdef HAVE_CONFIG_H
+#include "config=
=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "control_msg=2Eh"
+
+bo=
ol
+ctrl_msg_tlv_write_header(struct buffer *buf, uint16_t type, bool optio=
nal, uint16_t value_len)
+{
+    /* the type has 15 bits; the top bit is th=
e optional flag */
+    ASSERT(type <=3D CTRL_MSG_TLV_TYPE_MASK);
+
+    /*=
 Write nothing unless the whole TLV fits=2E The header promises that
+     =
* value_len bytes follow it, so a header written without room for the
+    =
 * value would leave a partial TLV in buf=2E */
+    if (!buf_safe(buf, (si=
ze_t)CTRL_MSG_TLV_HEADER_LEN + value_len))
+    {
+        return false;
+ =
   }
+    uint16_t field =3D type;
+    if (optional)
+    {
+        field=
 |=3D CTRL_MSG_TLV_OPTIONAL_FLAG;
+    }
+    return buf_write_u16(buf, fie=
ld) && buf_write_u16(buf, value_len);
+}
+
+bool
+ctrl_msg_tlv_write_u16(st=
ruct buffer *buf, uint16_t type, bool optional, uint16_t value)
+{
+    ret=
urn ctrl_msg_tlv_write_header(buf, type, optional, sizeof(uint16_t))
+     =
      && buf_write_u16(buf, value);
+}
+
+bool
+ctrl_msg_tlv_peek_header(co=
nst struct buffer *buf, struct ctrl_msg_tlv_header *hdr)
+{
+    if (BLEN(b=
uf) < CTRL_MSG_TLV_HEADER_LEN)
+    {
+        return false; /* fewer than =
4 bytes left: truncated header */
+    }
+    /* read from a copy, so that =
buf is left where it was */
+    struct buffer tmp =3D *buf;
+    uint16_t =
field =3D (uint16_t)buf_read_u16(&tmp);
+    hdr->value_len =3D (uint16_t)b=
uf_read_u16(&tmp);
+    hdr->type =3D field & CTRL_MSG_TLV_TYPE_MASK;
+    =
hdr->optional =3D (field & CTRL_MSG_TLV_OPTIONAL_FLAG) !=3D 0;
+    return =
true;
+}
+
+bool
+ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_msg_tlv=
_header *hdr, struct buffer *value)
+{
+    if (!ctrl_msg_tlv_peek_header(b=
uf, hdr))
+    {
+        return false;
+    }
+    /* Consume nothing unle=
ss the whole TLV is there, so that a value shorter
+     * than the header =
claims leaves buf untouched=2E */
+    if (BLEN(buf) < CTRL_MSG_TLV_HEADER_=
LEN + hdr->value_len)
+    {
+        return false;
+    }
+    ASSERT(buf_=
advance(buf, CTRL_MSG_TLV_HEADER_LEN));
+    const uint8_t *v =3D buf_read_=
alloc(buf, hdr->value_len);
+    ASSERT(v);
+    buf_set_read(value, v, hdr=
->value_len);
+    return true;
+}
diff --git a/src/openvpn/control_msg=2Eh=
 b/src/openvpn/control_msg=2Eh
new file mode 100644
index 0000000=2E=2E9257=
2cb
--- /dev/null
+++ b/src/openvpn/control_msg=2Eh
@@ -0,0 +1,108 @@
+/*
+=
 *  OpenVPN -- An application to securely tunnel IP networks
+ *           =
  over a single TCP/UDP port, with support for SSL/TLS-based
+ *           =
  session authentication and key exchange,
+ *             packet encryptio=
n, packet authentication, and
+ *             packet compression=2E
+ *
+ *=
  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This p=
rogram is free software; you can redistribute it and/or modify
+ *  it unde=
r the terms of the GNU General Public License version 2
+ *  as published b=
y the Free Software Foundation=2E
+ *
+ *  This program is distributed in t=
he hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even=
 the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR P=
URPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
=
+ *  You should have received a copy of the GNU General Public License alon=
g
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=
=2E
+ */
+
+/**
+ * @file
+ * TLV framing shared by the TLV-based control m=
essages of the wire protocol=2E
+ *
+ * Such a message payload is a sequenc=
e of TLV entries=2E Each TLV starts with a
+ * 4-byte header: a 16-bit fiel=
d whose most significant bit is the "optional"
+ * flag and whose remaining=
 15 bits are the type, followed by a 16-bit length
+ * giving the size of t=
he value that follows the header=2E
+ *
+ * All of these messages share one=
 TLV type space, so the TLV types are all
+ * defined here=2E Only the fram=
ing is handled here: what a message does with a
+ * TLV type it does not kn=
ow, marked optional or not, is up to its parser=2E
+ */
+
+#ifndef CONTROL_=
MSG_H
+#define CONTROL_MSG_H
+
+#include "buffer=2Eh"
+
+/* TLV types */
+#=
define TLV_TYPE_EARLY_NEG_FLAGS 0x0001 /* early negotiation, in the reset p=
ackets */
+
+/* A TLV header is a 16-bit type/optional field plus a 16-bit =
length */
+#define CTRL_MSG_TLV_HEADER_LEN 4
+
+/* bit layout of the first =
16-bit field */
+#define CTRL_MSG_TLV_OPTIONAL_FLAG 0x8000
+#define CTRL_MS=
G_TLV_TYPE_MASK     0x7fff
+
+/** The header every TLV carries: the 15-bit =
type and optional flag packed into
+ * the first 16-bit field, then the len=
gth of the value that follows=2E */
+struct ctrl_msg_tlv_header
+{
+    uin=
t16_t type;      /**< the 15-bit TLV type */
+    bool optional;      /**< =
value of the optional flag */
+    uint16_t value_len; /**< length of the v=
alue following the header */
+};
+
+/**
+ * Write a TLV header (type + opti=
onal flag + value length) to buf=2E
+ * type must fit in the 15 bits of the=
 type field=2E
+ *
+ * Nothing is written unless the header and the value_l=
en bytes of value
+ * that follow it both fit, so a failed write never leav=
es a partial TLV
+ * behind=2E
+ *
+ * @return true on success, false if bu=
f has insufficient space=2E
+ */
+bool ctrl_msg_tlv_write_header(struct buf=
fer *buf, uint16_t type, bool optional,
+                               uin=
t16_t value_len);
+
+/**
+ * Write a complete TLV whose value is a single 1=
6-bit integer to buf=2E
+ *
+ * @return true on success, false if buf has i=
nsufficient space=2E
+ */
+bool ctrl_msg_tlv_write_u16(struct buffer *buf, =
uint16_t type, bool optional, uint16_t value);
+
+/**
+ * Read a TLV header=
 from buf without consuming it=2E
+ *
+ * @param buf  buffer positioned at =
the TLV header
+ * @param hdr  filled with the type, optional flag and valu=
e length on success
+ * @return true on success, false if there are not eno=
ugh bytes for a header=2E
+ */
+bool ctrl_msg_tlv_peek_header(const struct =
buffer *buf, struct ctrl_msg_tlv_header *hdr);
+
+/**
+ * Read the next TLV=
 from buf, advancing past its header and value=2E Call it
+ * while BLEN(bu=
f) > 0 to walk a whole payload=2E
+ *
+ * The length from the header is val=
idated against buf, so on success the
+ * whole value is present: a header =
claiming more bytes than buf holds is
+ * rejected=2E Nothing is consumed u=
nless the whole TLV is there, so a failed
+ * read never leaves a partial T=
LV behind=2E
+ *
+ * @param buf    buffer positioned at a TLV header
+ * @p=
aram hdr    filled with the TLV's type, optional flag and value length
+ * =
@param value  set to a buffer covering exactly the TLV's value; it points
+=
 *               into buf and owns no storage
+ * @return true on success, =
false if the header or the value is truncated,
+ *         with buf left un=
touched=2E
+ */
+bool ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_msg=
_tlv_header *hdr, struct buffer *value);
+
+#endif /* ifndef CONTROL_MSG_H =
*/
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 420daef=2E=
=2E9a72614 100644
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
@@ -2644,26 +2645,21 @@
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
+                if (BLEN(&value) !=
=3D sizeof(uint16_t))
                 {
                     goto error;
 =
                }
-                int flags =3D buf_read_u16(buf);
+      =
          int flags =3D buf_read_u16(&value);
 
                 if (flags =
& EARLY_NEG_FLAG_RESEND_WKC)
                 {
@@ -2682,8 +2678,8 @@
     =
            break;
 
             default:
-                /* Skip types w=
e do not parse */
-                buf_advance(buf, len);
+                =
/* Skip types we do not parse, marked optional or not */
+                b=
reak;
         }
     }
     reliable_mark_deleted(ks->rec_reliable, buf);
=
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index f78782=
f=2E=2Ef4564ef 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_p=
kt=2Ec
@@ -33,6 +33,7 @@
 #include "reliable=2Eh"
 #include "siphash=2Eh"
 =
#include "tls_crypt=2Eh"
+#include "control_msg=2Eh"
 
 /*
  * Dependent on=
 hmac size, opcode size, and session_id size=2E
@@ -432,9 +433,8 @@
     /*=
 Add indication for tls-crypt-v2 to resend the WKc with the reply */
     i=
f (request_resend_wkc)
     {
-        buf_write_u16(&buf, TLV_TYPE_EARLY_N=
EG_FLAGS); /* TYPE: flags */
-        buf_write_u16(&buf, sizeof(uint16_t))=
;
-        buf_write_u16(&buf, EARLY_NEG_FLAG_RESEND_WKC);
+        ASSERT(=
ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false,
+            =
                          EARLY_NEG_FLAG_RESEND_WKC));
     }
 
     /* Add=
 tls-auth/tls-crypt wrapping, this might replace buf with
diff --git a/src/=
openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 8203e4a=2E=2E218c6bb 10=
0644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -306,10=
 +306,8 @@
 #define EARLY_NEG_START 0x0f000000
 
 
-/* Early negotiation th=
at part of the server response in the RESET_V2 packet=2E
- * Since clients =
that announce early negotiation support will treat the payload
- * of reset=
 packets special and parse it as TLV messages=2E
- * as TLV (type, length, =
value) */
-#define TLV_TYPE_EARLY_NEG_FLAGS  0x0001
+/* Early negotiation: =
clients that announce support for it parse the payload of
+ * the reset pac=
kets as TLVs (see control_msg=2Eh)=2E Flags carried in the value of
+ * the=
 TLV_TYPE_EARLY_NEG_FLAGS TLV: */
 #define EARLY_NEG_FLAG_RESEND_WKC 0x0001=

 #endif /* ifndef SSL_PKT_H */
diff --git a/tests/unit_tests/openvpn/Makef=
ile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 70cf7b2=2E=2E11f92f=
4 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_test=
s/openvpn/Makefile=2Eam
@@ -164,11 +164,15 @@
 	-I$(top_srcdir)/include -I$=
(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	@TEST_CFLAGS@
 pkt_=
testdriver_LDFLAGS =3D @TEST_LDFLAGS@
-pkt_testdriver_SOURCES =3D test_pkt=
=2Ec mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec test_common=2Eh \
+pkt=
_testdriver_SOURCES =3D test_pkt=2Ec \
+	test_control_msg=2Ec test_control_=
msg=2Eh \
+	mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec \
+	test_common=
=2Eh \
 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/=
openvpn/argv=2Ec \
 	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)=
/src/openvpn/buffer=2Ec \
+	$(top_srcdir)/src/openvpn/control_msg=2Ec \
 	$=
(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_ep=
och=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \
diff --git a/tes=
ts/unit_tests/openvpn/test_control_msg=2Ec b/tests/unit_tests/openvpn/test_=
control_msg=2Ec
new file mode 100644
index 0000000=2E=2Ead4c565
--- /dev/nu=
ll
+++ b/tests/unit_tests/openvpn/test_control_msg=2Ec
@@ -0,0 +1,181 @@
+/=
*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *        =
     over a single TCP/UDP port, with support for SSL/TLS-based
+ *        =
     session authentication and key exchange,
+ *             packet encryp=
tion, packet authentication, and
+ *             packet compression=2E
+ *
=
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  Thi=
s program is free software; you can redistribute it and/or modify
+ *  it u=
nder the terms of the GNU General Public License version 2
+ *  as publishe=
d by the Free Software Foundation=2E
+ *
+ *  This program is distributed i=
n the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without e=
ven the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULA=
R PURPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+=
 *
+ *  You should have received a copy of the GNU General Public License a=
long
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/=
>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#includ=
e "syshead=2Eh"
+
+#include <stdarg=2Eh>
+#include <stddef=2Eh>
+#include <=
setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "control_msg=2Eh"
+#include =
"ssl_pkt=2Eh"
+#include "test_common=2Eh"
+#include "test_control_msg=2Eh"
=
+
+/* The early negotiation flags TLV of a reset packet asking a tls-crypt-=
v2
+ * client to resend its WKc=2E */
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
+    assert_true(ctrl_msg_tlv_peek_header(&buf, &hdr));
+    assert_=
int_equal(hdr=2Etype, 0x1234);
+    assert_true(hdr=2Eoptional);
+    asser=
t_int_equal(hdr=2Evalue_len, 5);
+    assert_int_equal(BLEN(&buf), CTRL_MSG=
_TLV_HEADER_LEN); /* peek consumes nothing */
+
+    gc_free(&gc);
+}
+
+/*=
 Walking a payload returns each TLV in turn, with a value covering exactly
=
+ * its bytes, and consumes the payload=2E */
+void
+test_tlv_next_walks_pa=
yload(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct bu=
ffer buf =3D alloc_buf_gc(64, &gc);
+
+    assert_true(ctrl_msg_tlv_write_u=
16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 0xabcd));
+    assert_true(ctrl_m=
sg_tlv_write_header(&buf, 0x7ff, true, 4));
+    assert_true(buf_write_u32(=
&buf, 0x11223344));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x5, f=
alse, 0)); /* empty value */
+
+    struct ctrl_msg_tlv_header hdr;
+    st=
ruct buffer value;
+
+    assert_true(ctrl_msg_tlv_next(&buf, &hdr, &value)=
);
+    assert_int_equal(hdr=2Etype, TLV_TYPE_EARLY_NEG_FLAGS);
+    assert=
_false(hdr=2Eoptional);
+    assert_int_equal(BLEN(&value), 2);
+    assert=
_int_equal(buf_read_u16(&value), 0xabcd);
+
+    assert_true(ctrl_msg_tlv_n=
ext(&buf, &hdr, &value));
+    assert_int_equal(hdr=2Etype, 0x7ff);
+    as=
sert_true(hdr=2Eoptional);
+    assert_int_equal(BLEN(&value), 4);
+    ass=
ert_int_equal(buf_read_u32(&value, NULL), 0x11223344);
+
+    assert_true(c=
trl_msg_tlv_next(&buf, &hdr, &value));
+    assert_int_equal(hdr=2Etype, 0x=
5);
+    assert_int_equal(BLEN(&value), 0);
+
+    assert_int_equal(BLEN(&b=
uf), 0);
+
+    gc_free(&gc);
+}
+
+/* A TLV header claiming more value byt=
es than the payload holds is rejected,
+ * rather than read past the end of=
 the payload, and leaves buf untouched=2E */
+void
+test_tlv_next_value_tru=
ncated(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct b=
uffer buf =3D alloc_buf_gc(64, &gc);
+
+    assert_true(ctrl_msg_tlv_write_=
header(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 8));
+    assert_true(buf_wri=
te_u32(&buf, 0));
+
+    struct ctrl_msg_tlv_header hdr;
+    struct buffer=
 value;
+    assert_false(ctrl_msg_tlv_next(&buf, &hdr, &value));
+    asse=
rt_int_equal(BLEN(&buf), CTRL_MSG_TLV_HEADER_LEN + sizeof(uint32_t));
+
+  =
  gc_free(&gc);
+}
+
+/* Reading a TLV header must fail, rather than read p=
ast the available data,
+ * when the buffer holds less than a complete 4-by=
te header, and must leave
+ * buf untouched=2E */
+void
+test_tlv_header_tr=
uncated(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    const u=
int8_t bytes[] =3D { 0x00, 0x01, 0x00 };
+
+    /* 0 to 3 bytes: none, part=
 of the type field, the type field, and the type
+     * field with half of=
 the length */
+    for (size_t n =3D 0; n <=3D sizeof(bytes); n++)
+    {
=
+        struct buffer buf =3D alloc_buf_gc(16, &gc);
+        assert_true(=
buf_write(&buf, bytes, n));
+
+        struct ctrl_msg_tlv_header hdr;
+   =
     struct buffer value;
+        assert_false(ctrl_msg_tlv_peek_header(&b=
uf, &hdr));
+        assert_false(ctrl_msg_tlv_next(&buf, &hdr, &value));
+=
        assert_int_equal(BLEN(&buf), n);
+    }
+
+    gc_free(&gc);
+}
+
+=
/* Writing fails, rather than writes a partial TLV, when buf is too small=
=2E */
+void
+test_tlv_write_no_room(void **state)
+{
+    struct gc_arena =
gc =3D gc_new();
+
+    struct buffer buf =3D alloc_buf_gc(3, &gc);
+    as=
sert_false(ctrl_msg_tlv_write_header(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false,=
 2));
+    assert_int_equal(BLEN(&buf), 0);
+
+    /* room for the header b=
ut not the value */
+    buf =3D alloc_buf_gc(5, &gc);
+    assert_false(ct=
rl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 1));
+    asser=
t_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
diff --git a/tests/unit=
_tests/openvpn/test_control_msg=2Eh b/tests/unit_tests/openvpn/test_control=
_msg=2Eh
new file mode 100644
index 0000000=2E=2Eef7a030
--- /dev/null
+++ =
b/tests/unit_tests/openvpn/test_control_msg=2Eh
@@ -0,0 +1,37 @@
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
+#ifndef TEST_CONTROL_MSG_H
+#define TEST_CONTROL_MSG_H
+
+void test_tl=
v_write_u16_wire_format(void **state);
+
+void test_tlv_header_roundtrip(vo=
id **state);
+
+void test_tlv_next_walks_payload(void **state);
+
+void tes=
t_tlv_next_value_truncated(void **state);
+
+void test_tlv_header_truncated=
(void **state);
+
+void test_tlv_write_no_room(void **state);
+#endif
diff =
--git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/te=
st_pkt=2Ec
index fbbb40f=2E=2E7dc07aa 100644
--- a/tests/unit_tests/openvpn=
/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -37,12 +37,14 =
@@
 #include "crypto=2Eh"
 #include "options=2Eh"
 #include "ssl_backend=2E=
h"
+#include "control_msg=2Eh"
 #include "ssl_pkt=2Eh"
 #include "tls_crypt=
=2Eh"
 
 #include "mss=2Eh"
 #include "reliable=2Eh"
 #include "siphash=2Eh=
"
+#include "test_control_msg=2Eh"
 
 int
 parse_line(const char *line, cha=
r **p, const int n, const char *file, const int line_num,
@@ -655,6 +657,45=
 @@
     free_buf(&tas=2Eworkbuf);
 }
 
+/* A reset reply asking a tls-cryp=
t-v2 client to resend its WKc ends in the
+ * early negotiation flags TLV, =
and that TLV parses back=2E */
+static void
+test_generate_reset_packet_res=
end_wkc(void **ut_state)
+{
+    struct tls_auth_standalone tas =3D { 0 };
=
+
+    struct session_id client_id =3D { { 0, 1, 2, 3, 4, 5, 6, 7 } };
+   =
 struct session_id server_id =3D { { 8, 9, 0, 9, 8, 7, 6, 2 } };
+
+    tas=
=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;
+    struct frame frame =3D { =2Ebuf =
=3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, 0 };
+    tas=2Efram=
e =3D frame;
+    tas=2Eworkbuf =3D alloc_buf(1600);
+
+    uint8_t header =
=3D 0 | (P_CONTROL_HARD_RESET_SERVER_V2 << P_OPCODE_SHIFT);
+
+    struct b=
uffer plain =3D
+        tls_reset_standalone(&tas=2Etls_wrap, &tas, &clien=
t_id, &server_id, header, false);
+    const int plain_len =3D BLEN(&plain)=
;
+    struct buffer buf =3D
+        tls_reset_standalone(&tas=2Etls_wrap,=
 &tas, &client_id, &server_id, header, true);
+
+    const uint8_t tlv[] =
=3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };
+    assert_int_equal(BLEN(&buf=
), plain_len + (int)sizeof(tlv));
+    assert_memory_equal(BPTR(&buf) + pla=
in_len, tlv, sizeof(tlv));
+
+    struct buffer payload =3D buf;
+    asser=
t_true(buf_advance(&payload, plain_len));
+    struct ctrl_msg_tlv_header h=
dr;
+    struct buffer value;
+    assert_true(ctrl_msg_tlv_next(&payload, =
&hdr, &value));
+    assert_int_equal(hdr=2Etype, TLV_TYPE_EARLY_NEG_FLAGS)=
;
+    assert_int_equal(buf_read_u16(&value), EARLY_NEG_FLAG_RESEND_WKC);
+=
    assert_int_equal(BLEN(&payload), 0);
+
+    free_buf(&tas=2Eworkbuf);
+=
}
+
 static void
 test_generate_reset_packet_tls_auth(void **ut_state)
 {
@=
@ -791,9 +832,16 @@
         cmocka_unit_test(test_verify_hmac_tls_auth),
 =
        cmocka_unit_test(test_verify_hmac_none_out_of_range_ack),
         =
cmocka_unit_test(test_generate_reset_packet_plain),
+        cmocka_unit_te=
st(test_generate_reset_packet_resend_wkc),
         cmocka_unit_test(test_g=
enerate_reset_packet_tls_auth),
         cmocka_unit_test(test_wkc_not_appe=
nded_without_key),
-        cmocka_unit_test(test_extract_control_message)
=
+        cmocka_unit_test(test_extract_control_message),
+        cmocka_un=
it_test(test_tlv_write_u16_wire_format),
+        cmocka_unit_test(test_tlv=
_header_roundtrip),
+        cmocka_unit_test(test_tlv_next_walks_payload),=

+        cmocka_unit_test(test_tlv_next_value_truncated),
+        cmocka_=
unit_test(test_tlv_header_truncated),
+        cmocka_unit_test(test_tlv_wr=
ite_no_room)
     };
 
     return cmocka_run_group_tests_name("pkt tests",=
 tests, NULL, NULL);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1965?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Gerrit-Change-Number: 1965
=
Gerrit-PatchSet: 8
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Fran=
k Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Steffan Karger <steffan@karger=
=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
G=
errit-Attention: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Steffan Karge=
r <steffan@karger=2Eme>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--1IPvUacIAXU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov, R=C4=
=83zvan Cojocaru, Steffan Karger=2E </p>
<p>Lev Stipakov <strong>uploaded p=
atch set #8</strong> to this change=2E</p><p><a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1965?usp=3Demail">View Change</a></p><p>The followi=
ng approvals got outdated and were removed:
Code-Review+1 by R=C4=83zvan Co=
jocaru, Code-Review-1 by Steffan Karger</p><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">control_msg: Add a=
 shared TLV codec and use it for early negotiation<br><br>Early negotiation=
 in the reset packets is a sequence of TLVs, and<br>planned out-of-band and=
 control data messages will use the same TLV<br>format and type space=2E Ad=
d one TLV codec for all of them,<br>control_msg=2Ec/h, and move early negot=
iation onto it=2E<br><br>The codec only handles the framing: reading and wr=
iting TLV headers,<br>writing a 16-bit TLV, and walking a payload TLV by TL=
V with each value<br>checked against the payload=2E How to treat an unknown=
 type is up to each<br>message=2E With the optional flag clear the codec wr=
ites the same bytes as<br>the hand-rolled code it replaces=2E<br><br>In the=
 codec the most significant bit of the type field is the<br>&quot;optional&=
quot; flag rather than part of the type=2E The old parser compared<br>the w=
hole type word, so 0x8001 did not match the flags TLV and was<br>skipped as=
 unknown; now it matches and is parsed as one=2E<br><br>Change-Id: I89c3133=
e009dc75dc2c10c607b3f0a24c04e8146<br>Signed-off-by: Lev Stipakov &lt;lev@op=
envpn=2Enet&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam=
<br>A src/openvpn/control_msg=2Ec<br>A src/openvpn/control_msg=2Eh<br>M src=
/openvpn/ssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<=
br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests/unit_tests/openvpn/t=
est_control_msg=2Ec<br>A tests/unit_tests/openvpn/test_control_msg=2Eh<br>M=
 tests/unit_tests/openvpn/test_pkt=2Ec<br>11 files changed, 493 insertions(=
+), 23 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/65/1965/8</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLi=
sts=2Etxt b/CMakeLists=2Etxt</span><br><span>index 5cf1a30=2E=2E305c26c 100=
644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=
=2Etxt</span><br><span>@@ -457,6 +457,8 @@</span><br><span>     src/openvpn=
/console=2Ec</span><br><span>     src/openvpn/console_builtin=2Ec</span><br=
><span>     src/openvpn/console=2Eh</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    src/openvpn/control_msg=2Ec</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    src/openvpn/control_msg=2Eh</span><br><span=
>     src/openvpn/crypto=2Ec</span><br><span>     src/openvpn/crypto=2Eh</s=
pan><br><span>     src/openvpn/crypto_backend=2Eh</span><br><span>@@ -896,6=
 +898,8 @@</span><br><span> </span><br><span>     target_sources(test_pkt P=
RIVATE</span><br><span>         tests/unit_tests/openvpn/mock_win32_execve=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tests/u=
nit_tests/openvpn/test_control_msg=2Ec</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        src/openvpn/control_msg=2Ec</span><br><span>    =
     src/openvpn/argv=2Ec</span><br><span>         src/openvpn/base64=2Ec</=
span><br><span>         src/openvpn/crypto_epoch=2Ec</span><br><span>diff -=
-git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><spa=
n>index bb31053=2E=2Ebe1044d 100644</span><br><span>--- a/src/openvpn/Makef=
ile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@=
 -57,6 +57,7 @@</span><br><span> 	common=2Eh \</span><br><span> 	comp=2Ec c=
omp=2Eh compstub=2Ec \</span><br><span> 	comp-lz4=2Ec comp-lz4=2Eh \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	control_msg=2Ec control_m=
sg=2Eh \</span><br><span> 	crypto=2Ec crypto=2Eh crypto_backend=2Eh \</span=
><br><span> 	crypto_openssl=2Ec crypto_openssl=2Eh \</span><br><span> 	cryp=
to_mbedtls=2Ec crypto_mbedtls=2Eh \</span><br><span>diff --git a/src/openvp=
n/control_msg=2Ec b/src/openvpn/control_msg=2Ec</span><br><span>new file mo=
de 100644</span><br><span>index 0000000=2E=2Ee14355c</span><br><span>--- /d=
ev/null</span><br><span>+++ b/src/openvpn/control_msg=2Ec</span><br><span>@=
@ -0,0 +1,93 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An app=
lication to securely tunnel IP networks</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *             over a single TCP/UDP port, with support=
 for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*             session authentication and key exchange,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, packet=
 authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *             packet compression=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you ca=
n redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  it under the terms of the GNU General Public License versio=
n 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published=
 by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  This program is distributed in the hope that it will be useful,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY=
; without even the implied warranty of</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU=
 General Public License for more details=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;control_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_write_header(s=
truct buffer *buf, uint16_t type, bool optional, uint16_t value_len)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* the type has 15 bits; the top bit is =
the optional flag */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ASSERT(type &lt;=3D CTRL_MSG_TLV_TYPE_MASK);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* Write nothing unless the whole TLV fits=2E The header pro=
mises that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * va=
lue_len bytes follow it, so a header written without room for the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * value would leave a pa=
rtial TLV in buf=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!buf_safe(buf, (size_t)CTRL_MSG_TLV_HEADER_LEN + value_len))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    uint16_t field =3D type;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (optional)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        field |=3D CTRL_MSG_TLV_OPTIONAL_FLAG;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return buf_write_u16(buf, field) &amp=
;&amp; buf_write_u16(buf, value_len);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_write_u16(struct buff=
er *buf, uint16_t type, bool optional, uint16_t value)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return ctrl_msg_tlv_write_header(buf, type, optional, =
sizeof(uint16_t))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
         &amp;&amp; buf_write_u16(buf, value);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_peek_header(=
const struct buffer *buf, struct ctrl_msg_tlv_header *hdr)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (BLEN(buf) &lt; CTRL_MSG_TLV_HEADER_LEN)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return false; /* fewer than 4 by=
tes left: truncated header */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* read from a copy, so that buf is left where it was */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct buffer tmp =3D *buf;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t field =3D (ui=
nt16_t)buf_read_u16(&amp;tmp);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    hdr-&gt;value_len =3D (uint16_t)buf_read_u16(&amp;tmp);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt;type =3D fie=
ld &amp; CTRL_MSG_TLV_TYPE_MASK;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    hdr-&gt;optional =3D (field &amp; CTRL_MSG_TLV_OPTIONAL_FL=
AG) !=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_msg_tlv_heade=
r *hdr, struct buffer *value)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!ctrl_msg_tlv_peek_header(buf, hdr))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Co=
nsume nothing unless the whole TLV is there, so that a value shorter</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * than the header cla=
ims leaves buf untouched=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (BLEN(buf) &lt; CTRL_MSG_TLV_HEADER_LEN + hdr-&gt;value_l=
en)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_advance(buf, CTRL_MSG_TLV_=
HEADER_LEN));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst uint8_t *v =3D buf_read_alloc(buf, hdr-&gt;value_len);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(v);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(value, v, hdr-&gt;value_=
len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return tru=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
>diff --git a/src/openvpn/control_msg=2Eh b/src/openvpn/control_msg=2Eh</sp=
an><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E92572c=
b</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/control_m=
sg=2Eh</span><br><span>@@ -0,0 +1,108 @@</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  OpenVPN -- An application to securely tunnel IP networks</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *             over a single T=
CP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             session authentication and key excha=
nge,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
packet encryption, packet authentication, and</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales=
@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program i=
s free software; you can redistribute it and/or modify</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU Genera=
l Public License version 2</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  as published by the Free Software Foundation=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  This program is distributed in the hope that it w=
ill be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  b=
ut WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FO=
R A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  GNU General Public License for more details=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU=
 General Public License along</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/li=
censes/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * TLV framing shared by the TLV-based control messages of the wire=
 protocol=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Such a message payloa=
d is a sequence of TLV entries=2E Each TLV starts with a</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * 4-byte header: a 16-bit field whose=
 most significant bit is the &quot;optional&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * flag and whose remaining 15 bits are the t=
ype, followed by a 16-bit length</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * giving the size of the value that follows the header=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * All of these messages share one TLV t=
ype space, so the TLV types are all</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * defined here=2E Only the framing is handled here: what a=
 message does with a</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * TLV type it does not know, marked optional or not, is up to its parser=
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
<span style=3D"color: hsl(120, 100%, 40%);">+/* A TLV header is a 16-bit ty=
pe/optional field plus a 16-bit length */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define CTRL_MSG_TLV_HEADER_LEN 4</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* bit layout of the first 16-bit field */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define CTRL_MSG_TLV_OPTIONAL_FLAG =
0x8000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CTRL_=
MSG_TLV_TYPE_MASK     0x7fff</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** The he=
ader every TLV carries: the 15-bit type and optional flag packed into</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the first 16-bit field=
, then the length of the value that follows=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+struct ctrl_msg_tlv_header</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    uint16_t type;      /**&lt; the 15-bit TLV type */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool optional;   =
   /**&lt; value of the optional flag */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    uint16_t value_len; /**&lt; length of the value fo=
llowing the header */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * Write a TLV header (type + optional flag + valu=
e length) to buf=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * type must fit in the 15 bits of the type field=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * Nothing is written unless the header and the value_len =
bytes of value</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * th=
at follow it both fit, so a failed write never leaves a partial TLV</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * behind=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @return true on success, false if buf has insuff=
icient space=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_wr=
ite_header(struct buffer *buf, uint16_t type, bool optional,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                               uin=
t16_t value_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Write a complete TLV whose value i=
s a single 16-bit integer to buf=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @return true on success, false if buf has insufficient space=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_write_u16(struct buffer *bu=
f, uint16_t type, bool optional, uint16_t value);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Re=
ad a TLV header from buf without consuming it=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param buf  buffer positioned at the TLV header</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param hdr  filled with the t=
ype, optional flag and value length on success</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @return true on success, false if there are n=
ot enough bytes for a header=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool=
 ctrl_msg_tlv_peek_header(const struct buffer *buf, struct ctrl_msg_tlv_hea=
der *hdr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Read the next TLV from buf, advancing pas=
t its header and value=2E Call it</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * while BLEN(buf) &gt; 0 to walk a whole payload=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * The length from the header is validated ag=
ainst buf, so on success the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * whole value is present: a header claiming more bytes than buf h=
olds is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rejected=
=2E Nothing is consumed unless the whole TLV is there, so a failed</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * read never leaves a parti=
al TLV behind=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf    buf=
fer positioned at a TLV header</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param hdr    filled with the TLV&#39;s type, optional flag a=
nd value length</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param value  set to a buffer covering exactly the TLV&#39;s value; it point=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *               i=
nto buf and owns no storage</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @return true on success, false if the header or the value is tru=
ncated,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         w=
ith buf left untouched=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_=
msg_tlv_next(struct buffer *buf, struct ctrl_msg_tlv_header *hdr, struct bu=
ffer *value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef CONTROL_=
MSG_H */</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=
=2Ec</span><br><span>index 420daef=2E=2E9a72614 100644</span><br><span>--- =
a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><=
span>@@ -52,6 +52,7 @@</span><br><span> #include &quot;pkcs11=2Eh&quot;</sp=
an><br><span> #include &quot;route=2Eh&quot;</span><br><span> #include &quo=
t;tls_crypt=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;control_msg=2Eh&quot;</span><br><span> </span><br><span> #=
include &quot;crypto_epoch=2Eh&quot;</span><br><span> #include &quot;ssl=2E=
h&quot;</span><br><span>@@ -2644,26 +2645,21 @@</span><br><span> {</span><b=
r><span>     while (buf-&gt;len &gt; 0)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (buf_len(buf) &lt; 4)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            goto error;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /* read type */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        int type =3D buf_read_u16(buf);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int len =3D buf=
_read_u16(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (type &lt; 0 || len &lt; 0 || buf_len(buf) &lt; len)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        struct ctrl_msg_tlv_header hd=
r;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct bu=
ffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (!ctrl_msg_tlv_next(buf, &amp;hdr, &amp;value))</span><br><span>        =
 {</span><br><span>             goto error;</span><br><span>         }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
switch (type)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  switch (hdr=2Etype)</span><br><span>         {</span><br><span>          =
   case TLV_TYPE_EARLY_NEG_FLAGS:</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                if (len !=3D sizeof(uint16_t))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                if (BLEN(&amp;value)=
 !=3D sizeof(uint16_t))</span><br><span>                 {</span><br><span>=
                     goto error;</span><br><span>                 }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                int flags =3D=
 buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                int flags =3D buf_read_u16(&amp;value);</span><br><span> </=
span><br><span>                 if (flags &amp; EARLY_NEG_FLAG_RESEND_WKC)<=
/span><br><span>                 {</span><br><span>@@ -2682,8 +2678,8 @@</s=
pan><br><span>                 break;</span><br><span> </span><br><span>   =
          default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             /* Skip types we do not parse */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                buf_advance(buf, len);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                /* Skip types we=
 do not parse, marked optional or not */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                break;</span><br><span>         }</spa=
n><br><span>     }</span><br><span>     reliable_mark_deleted(ks-&gt;rec_re=
liable, buf);</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/op=
envpn/ssl_pkt=2Ec</span><br><span>index f78782f=2E=2Ef4564ef 100644</span><=
br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ss=
l_pkt=2Ec</span><br><span>@@ -33,6 +33,7 @@</span><br><span> #include &quot=
;reliable=2Eh&quot;</span><br><span> #include &quot;siphash=2Eh&quot;</span=
><br><span> #include &quot;tls_crypt=2Eh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><=
span> </span><br><span> /*</span><br><span>  * Dependent on hmac size, opco=
de size, and session_id size=2E</span><br><span>@@ -432,9 +433,8 @@</span><=
br><span>     /* Add indication for tls-crypt-v2 to resend the WKc with the=
 reply */</span><br><span>     if (request_resend_wkc)</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_write_u=
16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS); /* TYPE: flags */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        buf_write_u16(&amp;buf, sizeof(=
uint16_t));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        bu=
f_write_u16(&amp;buf, EARLY_NEG_FLAG_RESEND_WKC);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        ASSERT(ctrl_msg_tlv_write_u16(&amp;bu=
f, TLV_TYPE_EARLY_NEG_FLAGS, false,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                      EARLY_NEG_FLAG_RESEND=
_WKC));</span><br><span>     }</span><br><span> </span><br><span>     /* Ad=
d tls-auth/tls-crypt wrapping, this might replace buf with</span><br><span>=
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><s=
pan>index 8203e4a=2E=2E218c6bb 100644</span><br><span>--- a/src/openvpn/ssl=
_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -=
306,10 +306,8 @@</span><br><span> #define EARLY_NEG_START 0x0f000000</span>=
<br><span> </span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/* Early negotiation that part of the server response in the RESET_=
V2 packet=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Since =
clients that announce early negotiation support will treat the payload</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * of reset packets specia=
l and parse it as TLV messages=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * as TLV (type, length, value) */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define TLV_TYPE_EARLY_NEG_FLAGS  0x0001</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* Early negotiation: clients=
 that announce support for it parse the payload of</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * the reset packets as TLVs (see control_ms=
g=2Eh)=2E Flags carried in the value of</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * the TLV_TYPE_EARLY_NEG_FLAGS TLV: */</span><br><span=
> #define EARLY_NEG_FLAG_RESEND_WKC 0x0001</span><br><span> #endif /* ifnde=
f SSL_PKT_H */</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefi=
le=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 70cf=
7b2=2E=2E11f92f4 100644</span><br><span>--- a/tests/unit_tests/openvpn/Make=
file=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</spa=
n><br><span>@@ -164,11 +164,15 @@</span><br><span> 	-I$(top_srcdir)/include=
 -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span> =
	@TEST_CFLAGS@</span><br><span> pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-pkt_testdriver_SOURCES =
=3D test_pkt=2Ec mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec test_commo=
n=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pkt_testdriv=
er_SOURCES =3D test_pkt=2Ec \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	test_control_msg=2Ec test_control_msg=2Eh \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	mock_msg=2Ec mock_msg=2Eh mock_win32_ex=
ecve=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	test_com=
mon=2Eh \</span><br><span> 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</=
span><br><span> 	$(top_srcdir)/src/openvpn/argv=2Ec \</span><br><span> 	$(t=
op_srcdir)/src/openvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/ope=
nvpn/buffer=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$=
(top_srcdir)/src/openvpn/control_msg=2Ec \</span><br><span> 	$(top_srcdir)/=
src/openvpn/crypto=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=
_epoch=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec=
 \</span><br><span>diff --git a/tests/unit_tests/openvpn/test_control_msg=
=2Ec b/tests/unit_tests/openvpn/test_control_msg=2Ec</span><br><span>new fi=
le mode 100644</span><br><span>index 0000000=2E=2Ead4c565</span><br><span>-=
-- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_control_ms=
g=2Ec</span><br><span>@@ -0,0 +1,181 @@</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             over a single TC=
P/UDP port, with support for SSL/TLS-based</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             session authentication and key exchan=
ge,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             p=
acket encryption, packet authentication, and</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@=
openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is=
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
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_pkt=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_co=
mmon=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;test_control_msg=2Eh&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
 The early negotiation flags TLV of a reset packet asking a tls-crypt-v2</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * client to resend it=
s WKc=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+test_tlv_write_u16_wire=
_format(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_ar=
ena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct buffer buf =3D alloc_buf_gc(16, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_u16(&amp;buf, TLV_TYPE_EA=
RLY_NEG_FLAGS, false,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                       EARLY_NEG_FLAG_RESEND_WKC));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t expecte=
d[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), sizeof(exp=
ected));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
memory_equal(BPTR(&amp;buf), expected, sizeof(expected));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* the optional flag is the most significant bit of =
the type field */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  buf_clear(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(ctrl_msg_tlv_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAG=
S, true, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(BPTR(&amp;buf)[0], 0x80);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(BPTR(&amp;buf)[1], 0x01);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A T=
LV header survives the round trip, the optional flag kept apart from</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * the 15-bit type=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+test_tlv_header_roundtrip(void **sta=
te)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer=
 buf =3D alloc_buf_gc(16, &amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x1234, true, 5));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&=
amp;buf), 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_h=
eader hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_true(ctrl_msg_tlv_peek_header(&amp;buf, &amp;hdr));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, 0x1234);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(hdr=
=2Eoptional);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(hdr=2Evalue_len, 5);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), CTRL_MSG_TLV_HEADER_LE=
N); /* peek consumes nothing */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_=
free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Walking a payload returns each TLV in =
turn, with a value covering exactly</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * its bytes, and consumes the payload=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_tlv_next_walks_payload(void **state)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D al=
loc_buf_gc(64, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(ctrl_msg_tlv_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 0xabcd)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(c=
trl_msg_tlv_write_header(&amp;buf, 0x7ff, true, 4));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0=
x11223344));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x5, false, 0)); /* empty valu=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_header hdr=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_nex=
t(&amp;buf, &amp;hdr, &amp;value));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(hdr=2Etype, TLV_TYPE_EARLY_NEG_FLAGS);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(hd=
r=2Eoptional);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(BLEN(&amp;value), 2);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(buf_read_u16(&amp;value), 0xabcd);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_next(&amp;b=
uf, &amp;hdr, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(hdr=2Etype, 0x7ff);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_true(hdr=2Eoptional);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;va=
lue), 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(buf_read_u32(&amp;value, NULL), 0x11223344);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(ctrl_msg_tlv_next(&amp;buf, &amp;hdr, &amp=
;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(hdr=2Etype, 0x5);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_int_equal(BLEN(&amp;value), 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A TLV header cl=
aiming more value bytes than the payload holds is rejected,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * rather than read past the end of=
 the payload, and leaves buf untouched=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+test_tlv_next_value_truncated(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(64=
, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tl=
v_write_header(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 8));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&a=
mp;buf, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_he=
ader hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_false(ctrl_msg_tlv_next(&amp;buf, &amp;hdr, &amp;value));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;=
buf), CTRL_MSG_TLV_HEADER_LEN + sizeof(uint32_t));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Reading a TLV header=
 must fail, rather than read past the available data,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * when the buffer holds less than a comp=
lete 4-byte header, and must leave</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * buf untouched=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+test_tlv_header_truncated(void **state)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const uint8_t bytes[] =3D { 0x00, 0x01, 0x00 };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* 0 to 3 bytes: none, part of the t=
ype field, the type field, and the type</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * field with half of the length */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    for (size_t n =3D 0; n &lt;=3D =
sizeof(bytes); n++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct=
 buffer buf =3D alloc_buf_gc(16, &amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        assert_true(buf_write(&amp;buf, bytes, n));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        struct ctrl_msg_tlv_header hdr;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct buff=
er value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        as=
sert_false(ctrl_msg_tlv_peek_header(&amp;buf, &amp;hdr));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        assert_false(ctrl_msg_tlv_nex=
t(&amp;buf, &amp;hdr, &amp;value));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        assert_int_equal(BLEN(&amp;buf), n);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* Writing fails, rather th=
an writes a partial TLV, when buf is too small=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_tlv_write_no_room(void **state)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(3, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_t=
lv_write_header(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 2));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;=
buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* room for the header bu=
t not the value */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   buf =3D alloc_buf_gc(5, &amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_false(ctrl_msg_tlv_write_u16(&amp;buf, TLV_TYPE=
_EARLY_NEG_FLAGS, false, 1));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
control_msg=2Eh b/tests/unit_tests/openvpn/test_control_msg=2Eh</span><br><=
span>new file mode 100644</span><br><span>index 0000000=2E=2Eef7a030</span>=
<br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test=
_control_msg=2Eh</span><br><span>@@ -0,0 +1,37 @@</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a=
 single TCP/UDP port, with support for SSL/TLS-based</span><br><span style=
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
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef TEST_CONTROL_MSG_=
H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TEST_CONTR=
OL_MSG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void test_tlv_write_u16_wire_f=
ormat(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_tlv_head=
er_roundtrip(void **state);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_t=
lv_next_walks_payload(void **state);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id test_tlv_next_value_truncated(void **state);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void test_tlv_header_truncated(void **state);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void test_tlv_write_no_room(void **state);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/=
tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=
=2Ec</span><br><span>index fbbb40f=2E=2E7dc07aa 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/tests/unit_te=
sts/openvpn/test_pkt=2Ec</span><br><span>@@ -37,12 +37,14 @@</span><br><spa=
n> #include &quot;crypto=2Eh&quot;</span><br><span> #include &quot;options=
=2Eh&quot;</span><br><span> #include &quot;ssl_backend=2Eh&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh=
&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&quot;</span><br><span> #=
include &quot;tls_crypt=2Eh&quot;</span><br><span> </span><br><span> #inclu=
de &quot;mss=2Eh&quot;</span><br><span> #include &quot;reliable=2Eh&quot;</=
span><br><span> #include &quot;siphash=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;test_control_msg=2Eh&quot;</spa=
n><br><span> </span><br><span> int</span><br><span> parse_line(const char *=
line, char **p, const int n, const char *file, const int line_num,</span><b=
r><span>@@ -655,6 +657,45 @@</span><br><span>     free_buf(&amp;tas=2Eworkb=
uf);</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* A reset reply asking a tls-crypt-v2 client to rese=
nd its WKc ends in the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * early negotiation flags TLV, and that TLV parses back=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_generate_reset_packet_resend_wkc=
(void **ut_state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_=
standalone tas =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct se=
ssion_id client_id =3D { { 0, 1, 2, 3, 4, 5, 6, 7 } };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct session_id server_id =3D { { =
8, 9, 0, 9, 8, 7, 6, 2 } };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas=2Et=
ls_wrap=2Emode =3D TLS_WRAP_NONE;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200=
, =2Epayload_size =3D 1400 }, 0 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    tas=2Eframe =3D frame;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    tas=2Eworkbuf =3D alloc_buf(1600);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    uint8_t header =3D 0 | (P_CONTROL_HARD_RESET_SERV=
ER_V2 &lt;&lt; P_OPCODE_SHIFT);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct buffer plain =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        tls_reset_standalone(&amp;tas=2Etls_wrap, &amp;tas, &amp;client_id=
, &amp;server_id, header, false);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const int plain_len =3D BLEN(&amp;plain);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        tls_reset_standalone(=
&amp;tas=2Etls_wrap, &amp;tas, &amp;client_id, &amp;server_id, header, true=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t tlv[] =3D { 0x00, =
0x01, 0x00, 0x02, 0x00, 0x01 };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(BLEN(&amp;buf), plain_len + (int)sizeof(tl=
v));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memo=
ry_equal(BPTR(&amp;buf) + plain_len, tlv, sizeof(tlv));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct buffer payload =3D buf;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_advance(&amp;payload,=
 plain_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct buffer value;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(ctrl_msg_tlv_next(&amp;payload, &amp;hdr, &a=
mp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(hdr=2Etype, TLV_TYPE_EARLY_NEG_FLAGS);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(buf_read_u16(&amp;va=
lue), EARLY_NEG_FLAG_RESEND_WKC);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(BLEN(&amp;payload), 0);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    free_buf(&amp;tas=2Eworkbuf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> static void</span><br><span> test_generat=
e_reset_packet_tls_auth(void **ut_state)</span><br><span> {</span><br><span=
>@@ -791,9 +832,16 @@</span><br><span>         cmocka_unit_test(test_verify=
_hmac_tls_auth),</span><br><span>         cmocka_unit_test(test_verify_hmac=
_none_out_of_range_ack),</span><br><span>         cmocka_unit_test(test_gen=
erate_reset_packet_plain),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        cmocka_unit_test(test_generate_reset_packet_resend_wkc),</sp=
an><br><span>         cmocka_unit_test(test_generate_reset_packet_tls_auth)=
,</span><br><span>         cmocka_unit_test(test_wkc_not_appended_without_k=
ey),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cmocka_un=
it_test(test_extract_control_message)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        cmocka_unit_test(test_extract_control_message),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_t=
est(test_tlv_write_u16_wire_format),</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        cmocka_unit_test(test_tlv_header_roundtrip),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(=
test_tlv_next_walks_payload),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        cmocka_unit_test(test_tlv_next_value_truncated),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(tes=
t_tlv_header_truncated),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        cmocka_unit_test(test_tlv_write_no_room)</span><br><span>     =
};</span><br><span> </span><br><span>     return cmocka_run_group_tests_nam=
e(&quot;pkt tests&quot;, tests, NULL, NULL);</span><br></pre><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail"=
>change 1965</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
65?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146 </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 1965 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: Le=
v Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Steffan Karger=
 &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>

</body></html>
--1IPvUacIAXU=--


--===============2838743398858937780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2838743398858937780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2838743398858937780==--

