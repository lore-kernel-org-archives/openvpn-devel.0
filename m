Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A649BC44508
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GOdKUhvBv5lBWI1TKejbGP7zD9za90ozc3KRm7BnTbc=; b=bZAki7asnKZm9SujI34vRtTOB1
	a4hER9o3fu38yled2kiXaml/7wRvJcpFZD7y5Up5kNdi742qmwR57/YEpKJJnCkf2OZvov8ZAFIr/
	EFDdtzpUHZTnd9iUvzM+NCkl/Q5NJnBGEC2BYaSPGIPMUTOoav6hTqSC1N93aodPKyB4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjclV-0003uw-Fw;
	Tue, 14 Jul 2026 13:01:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjclR-0003un-4B
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 13:01:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=VLN9UHRnk0QQatl9Hhx3seEwzt6llIu/1Nqqm7c25+8=; b=nAyim3ZgZZiGYpddfA1ef7Tg9z
 Spc1B1GrXSfMATsWGT5lu6FxTr5OP2wh+6vUSyca3vy3IfNaM1u8sXFWwWQfJRBKzegZ2IEuqRbHZ
 WjAPTf+CyvaRpXErV8+zghMg0yrOzWKu6uPP0zejkD7KPjSYfczJT7wrtoZE2g0LE2bo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VLN9UHRnk0QQatl9Hhx3seEwzt6llIu/1Nqqm7c25+8=; b=I
 xui+Kj7ovQrBHaLqxAv1Ql+fTdiAY1kIe9H0xc5URhzmQYXpr9qZFgJeRjYbwdeoIwk9kg5LG3jg5
 /P5FfGDKwor9RTbGR7TKaBQJoCj02VOf76t7i+k/6uVRb3bMT5Kcg6+US4ZdvQPtFdqupzRPRJ0dt
 yuikcVkODi2ZUTLs=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjclP-00028o-1D for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 13:01:33 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-493bb510ce4so30438845e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 06:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784034079; x=1784638879; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VLN9UHRnk0QQatl9Hhx3seEwzt6llIu/1Nqqm7c25+8=;
 b=Dn7QKrOkJVygOQ8kVmfPkzwrWE8+/P91Kafcrrba7RbZEgRI5mEKMoyzOH0wD+I8FI
 kF+jBQv43WiSGYVb+xfLOIpYIdaBT59SVQLND8+B9g7Brrtuki+bFP7VeZk9kpoUAlxg
 1od8yq8si8n0DyGQRO9ouGGxOjknPDGZkXuqR83GO4HjsEhTZ18rV5nBU90W23g0r6BA
 OuXKQvjaRyd39atRoInAVfNqdO67OGM1vjSVRXsxo+uo0ufw2dZ9ezKmXcHgFaxJSOip
 IGBwWD50XnAA+Bm/gghx/lNrLiMvYq7pwkLwyo2CPROu23uRNpO8BuQLzesjj+cA1ihU
 OUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784034079; x=1784638879;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VLN9UHRnk0QQatl9Hhx3seEwzt6llIu/1Nqqm7c25+8=;
 b=Jww+Sx/ZOv9JHnIYwpha28XdTlgXbtPT5F43Ff9dUd9tpOrYCH5nszeXIgKFrvvFyU
 +/xoY/cAz39DzkuQFetLdXVcrqeOEHVN31wqUUlBTe+Ys5uKIjkL0OVEdSxv9GYejG/k
 kOtINr8p0NbXizHq7L+O1MwgIrA9ZrFZFF798j9I2+0BHWWfUcZuhs0HIxhzzhtQi8eW
 Zh6Nrv4TbZkdrfAIQXqXcvlzfTQkQjiQ6zg3Zt8tL47Acdyg3DVYUu8GI2iZEPRvcmQ4
 rNM491naSQ5xq/6Zvk6yVpaGNqVCAY75TYYdws1f0hRnoL9wyVk3/6tYenvAG+QaZKji
 HDIQ==
X-Gm-Message-State: AOJu0YyJaqRZnymVJm2vqXT4cBYpUl3G6ggCXC2fSoh+/877TEq5Nh57
 xovAKgbua1HCmglu1Z8BA5Qelzdqimzo7WJF4z3xqmYY2g/xoogHamQHp2rrkwisBZwMungH1PP
 46IWBMFkNuAS6ncaJ3boZFL+9fgmJyGM9UHM47q2r1934Ak9vYJ3u+CET2SPvrbnjRt6VF6kpmT
 bNlmj0Xg==
X-Gm-Gg: AfdE7cmi0Os572PFbCCl9TZ4xVDsKVXdlQPMMbrS31HPiko/ln2bCYZ9TelJKeQN2N9
 NQov1ofYtxPx3RcCIGz+cr5tMOCOML1iWCBfqlc1lJ6bKOXe4Jpr2Ssh0Z109C7m3SyFAOvPKU6
 EHTHqJFIiVk4b7lPNQb03pQiZjKFPFr7nBs9GonflggLPfsJD5NvnbOrFGe/oVIxr6LPR3yBxiw
 tQc36KqKj8AFRSlp8AuThHV4szf96B5lqCwaL2rNGYUXUI/Z4okCs17Lj0SZDjbouBSRrvhbY+C
 VQiCiH8Qda+qzF/pSnuBLcZPX4jwAXT4UR9I9zatMmdx7x7WLFV8vJFxPnCW4T+su/ClMc0UCS5
 1M9RoI5HuJQjXQFZgRd424ZTHWWkwwyAfOw35vErFxt8Y2RXqdNFilo8wxUqQXaaD4s9yNmARyz
 MYXNOrCCwQ5JehNk5Uv5qzQu0bofGbo4RYOfVnyraef/gMJewptpG/xonBxywNFZ081AkkyfBEz
 pYVVkGjLCIWfe4Horez0mBF1RDbBlokYavTXOEgJwZeK7bYuMWcmfOOnWZHgQR+vIXnyC4eBsC6
 LF4=
X-Received: by 2002:a05:600c:83c6:b0:495:3a61:b67e with SMTP id
 5b1f17b1804b1-4953a61b766mr6254615e9.23.1784034078974; 
 Tue, 14 Jul 2026 06:01:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2a2e499sm373367365e9.0.2026.07.14.06.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 06:01:17 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 13:01:06 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 17
X-Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
X-Gerrit-Change-Number: 31
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/31?usp=email>
X-Gerrit-Commit: d25ee55822a9d23aaa20648ed86b0d14607f3e0e
In-Reply-To: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwOWFhMjdjYWExYTNhYWIwZDFiZTYxMThiMjZkNTRhMWMxYmY3YWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <518a861771696c9ab2b304c5f1852edc821424d3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjclP-00028o-1D
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Allow to use
 OpenSSL's SIPHASH implementation when available
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7447809403429812788=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7447809403429812788==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hNEMLIcXRv4="; charset=UTF-8

--hNEMLIcXRv4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/31?usp=3Demail

to look at the new patch set (#17)=
=2E


Change subject: Allow to use OpenSSL's SIPHASH implementation when av=
ailable
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Allo=
w to use OpenSSL's SIPHASH implementation when available

OpenSSL library i=
s currently slower than the reference implementation
(about 1=2E5x to 2x de=
pending of the compiler)=2E

The OpenSSL API for using the SIPHASH MAC is d=
ifferent enough from using
normal HMAC or Digest that we already implement =
that combining them into
one API does not make sense=2E

SIPHASH is only av=
ailable on OpenSSL 3=2E1 and later=2E We still check for
support on 3=2E0 a=
nd later as the whole API to allow using the SIPHASH alrady
exists in OpenS=
SL 3=2E0=2E Some of the later OpenSSL 3=2E0=2Ex might get support
for it=2E=
 Theoretically, a provider can be loaded in OpenSSL 3=2E0 that
implements S=
IPHASH=2E

With OpenSSL's implementation being slower, we currently only us=
e it to
check that our reference implementation and the OpenSSL implementat=
ion
yield the same result in unit tests

Change-Id: I09aa27caa1a3aab0d1be61=
18b26d54a1c1bf7aa0
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M C=
MakeLists=2Etxt
M src/openvpn/Makefile=2Eam
M src/openvpn/siphash=2Eh
A src=
/openvpn/siphash_openssl=2Ec
M src/openvpn/siphash_reference=2Ec
M tests/un=
it_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/test_crypto=2Ec
7=
 files changed, 282 insertions(+), 11 deletions(-)


  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/31/31/17

diff --git a/CMakeLi=
sts=2Etxt b/CMakeLists=2Etxt
index 4779d69=2E=2Edb05073 100644
--- a/CMakeL=
ists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -562,6 +562,9 @@
     src/openvpn/shap=
er=2Eh
     src/openvpn/sig=2Ec
     src/openvpn/sig=2Eh
+    src/openvpn/s=
iphash=2Eh
+    src/openvpn/siphash_openssl=2Ec
+    src/openvpn/siphash_re=
ference=2Ec
     src/openvpn/socket=2Ec
     src/openvpn/socket=2Eh
     sr=
c/openvpn/socket_util=2Ec
@@ -780,8 +783,12 @@
         src/openvpn/packet_=
id=2Ec
         src/openvpn/mtu=2Ec
         src/openvpn/mss=2Ec
+        s=
rc/openvpn/siphash_reference=2Ec
+        src/openvpn/siphash_openssl=2Ec
 =
        )
 
+    target_compile_definitions(test_crypto PRIVATE PREFER_OPEN=
SSL_SIPHASH)
+
     target_sources(test_ssl PRIVATE
             tests/unit=
_tests/openvpn/mock_management=2Ec
             tests/unit_tests/openvpn/mo=
ck_ssl_dependencies=2Ec
diff --git a/src/openvpn/Makefile=2Eam b/src/openvp=
n/Makefile=2Eam
index ff8cc54=2E=2E08c8250 100644
--- a/src/openvpn/Makefil=
e=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -128,6 +128,8 @@
 	session_id=2Ec=
 session_id=2Eh \
 	shaper=2Ec shaper=2Eh \
 	sig=2Ec sig=2Eh \
+	siphash_r=
eference=2Ec siphash=2Eh \
+	siphash_openssl=2Ec \
 	socket=2Ec socket=2Eh =
\
 	socket_util=2Ec socket_util=2Eh \
 	socks=2Ec socks=2Eh \
diff --git a/=
src/openvpn/siphash=2Eh b/src/openvpn/siphash=2Eh
index ef61110=2E=2E6d2e13=
4 100644
--- a/src/openvpn/siphash=2Eh
+++ b/src/openvpn/siphash=2Eh
@@ -18=
,12 +18,67 @@
 #ifndef SIPHASH_H
 #define SIPHASH_H
 
-#include <inttypes=
=2Eh>
+#include <stdint=2Eh>
+#include <stdio=2Eh>
+#include <stdbool=2Eh>
=
 
 /* siphash always uses 128-bit keys */
 #define SIPHASH_KEY_SIZE 16
 
-i=
nt siphash(const void *in, size_t inlen, const void *k, uint8_t *out,
-    =
        size_t outlen);
+/* Prototypes for an implementation of SIPHASH in =
a crypto library */
 
-#endif
+/**
+ * Calculates SIPHASH using the crypto =
library function=2E
+ */
+int
+siphash_cryptolib(void *sip_context, const v=
oid *in, size_t inlen,
+                  const void *k, uint8_t *out, size=
_t outlen);
+
+/**
+ * Calculates SIPHASH using the reference implementatio=
n
+ */
+int
+siphash_reference(const void *in, size_t inlen, const void *k,=

+                  uint8_t *out, size_t outlen);
+
+/**
+ *
+ * @param has=
h_size the size of the output hash size
+ * @return initialised context for=
 siphash
+ */
+void *
+siphash_cryptolib_init(size_t hash_size);
+
+/**
+ *=
 Free the siphash context used for the crypto library
+ * @param sip_contex=
t
+ */
+void
+siphash_cryptolib_uninit(void *sip_context);
+
+/**
+ * Retur=
ns if the crypto library is available (and should be used)
+ *
+ * This ret=
urns if there is a crypto library version of Siphash24 is
+ * available and=
 should be used (OpenSSL 3/4 version is quite slow, so
+ * we prefer the re=
ference implementation)
+ *
+ */
+bool
+siphash_cryptolib_available(void *s=
ip_context);
+
+static inline int
+siphash(void *ctx, const void *in, size_=
t inlen, const void *k,
+        uint8_t *out, size_t outlen)
+{
+    if (s=
iphash_cryptolib_available(ctx) && false)
+    {
+        return siphash_cr=
yptolib(ctx, in, inlen, k, out, outlen);
+    }
+    else
+    {
+        r=
eturn siphash_reference(in, inlen, k, out, outlen);
+    }
+}
+
+#endif /* =
ifndef SIPHASH_H */
\ No newline at end of file
diff --git a/src/openvpn/si=
phash_openssl=2Ec b/src/openvpn/siphash_openssl=2Ec
new file mode 100644
in=
dex 0000000=2E=2Ebb42a38
--- /dev/null
+++ b/src/openvpn/siphash_openssl=2E=
c
@@ -0,0 +1,150 @@
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
+ *  Copyright (C) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *=
  This program is free software; you can redistribute it and/or modify
+ * =
 it under the terms of the GNU General Public License version 2
+ *  as pub=
lished by the Free Software Foundation=2E
+ *
+ *  This program is distribu=
ted in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; with=
out even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PART=
ICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more details=
=2E
+ *
+ *  You should have received a copy of the GNU General Public Lice=
nse along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/lice=
nses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#elif define=
d(_MSC_VER)
+#include "config-msvc=2Eh"
+#endif
+
+#include "syshead=2Eh"
+=

+#include "siphash=2Eh"
+#include "buffer=2Eh"
+
+
+#ifdef ENABLE_CRYPTO_O=
PENSSL
+#include <openssl/opensslv=2Eh>
+#endif
+
+/* OpenSSL siphash is cu=
rrently 2-3 times slower than the reference
+ * implementation, so only ena=
ble it when PREFER_OPENSSL_SIPHASH is defined
+ * for now */
+#if defined(E=
NABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >=3D 0x30000000L && defined=
(PREFER_OPENSSL_SIPHASH)
+#include <openssl/evp=2Eh>
+#include "crypto_open=
ssl=2Eh"
+
+struct siphash_context
+{
+    EVP_MAC *mac;
+    EVP_MAC_CTX *=
ctx;
+    size_t size;
+    OSSL_PARAM params[3];
+};
+
+/*
+ *  Computes a=
 SipHash value
+ * in: pointer to input data (read-only)
+ *  inlen: input =
data length in bytes (any size_t value)
+ * k: pointer to the key data (rea=
d-only), must be 16 bytes
+ * out: pointer to output data (write-only), out=
len bytes must be allocated
+ *  outlen: length of the output in bytes, mus=
t be 8 or 16
+ */
+int
+siphash_cryptolib(void *sip_context, const void *in=
, const size_t inlen,
+                  const void *k, uint8_t *out, const=
 size_t outlen)
+{
+    struct siphash_context *sip =3D sip_context;
+
+
+ =
   sip->params[1] =3D OSSL_PARAM_construct_octet_string("key", (void *)k,
+=
                                                       SIPHASH_KEY_SIZE);
+=
    if (!EVP_MAC_init(sip->ctx, NULL, 0, sip->params))
+    {
+        cryp=
to_msg(M_FATAL, "EVP_MAC_init failed");
+    }
+    EVP_MAC_update(sip->ctx=
, in, inlen);
+
+    size_t outl =3D 0;
+    EVP_MAC_final(sip->ctx, out, &=
outl, outlen);
+    return 0;
+}
+
+void *
+siphash_cryptolib_init(size_t h=
ash_size)
+{
+    struct siphash_context *sip;
+    ALLOC_OBJ(sip, struct s=
iphash_context);
+
+    sip->mac =3D EVP_MAC_fetch(NULL, "SIPHASH", NULL);
=
+    if (!sip->mac)
+    {
+        /* Our OpenSSL library does not support=
 SIPHASH */
+        return sip;
+    }
+    sip->ctx =3D EVP_MAC_CTX_new(s=
ip->mac);
+
+    /* OpenSSL will truly hold a pointer to an int in that par=
ameter */
+    sip->size =3D hash_size;
+    sip->params[0] =3D OSSL_PARAM_=
construct_size_t("size", &sip->size);
+    /* params[1] will hold the key t=
hat changes which each invocation */
+    sip->params[2] =3D OSSL_PARAM_con=
struct_end();
+    return sip;
+}
+
+bool
+siphash_cryptolib_available(void=
 *sip_context)
+{
+    struct siphash_context *sip =3D sip_context;
+
+    =
return (bool)(sip->mac);
+}
+
+void
+siphash_cryptolib_uninit(void *sip_con=
text)
+{
+    struct siphash_context *sip =3D sip_context;
+    EVP_MAC_CTX=
_free(sip->ctx);
+    EVP_MAC_free(sip->mac);
+    free(sip_context);
+}
+
=
+#else
+/* for now, we only have one implementation of SIPHASH in a libray,=
 so put the
+ * dummy functions also here */
+int
+siphash_cryptolib(void *=
sip_context, const void *in, const size_t inlen,
+                  const v=
oid *k, uint8_t *out, const size_t outlen)
+{
+    return -1;
+}
+
+bool
+s=
iphash_cryptolib_available(void *sip_context)
+{
+    return false;
+}
+
+v=
oid *
+siphash_cryptolib_init(size_t hash_size)
+{
+    return NULL;
+}
+
+=
void
+siphash_cryptolib_uninit(void *sip_context)
+{
+}
+
+
+#endif /* if d=
efined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >=3D 0x30000000L */=

diff --git a/src/openvpn/siphash_reference=2Ec b/src/openvpn/siphash_refer=
ence=2Ec
index b21a86e=2E=2Ea06599f 100644
--- a/src/openvpn/siphash_refere=
nce=2Ec
+++ b/src/openvpn/siphash_reference=2Ec
@@ -100,8 +100,8 @@
  *  ou=
tlen: length of the output in bytes, must be 8 or 16
  */
 int
-siphash(con=
st void *in, const size_t inlen, const void *k, uint8_t *out,
-        cons=
t size_t outlen)
+siphash_reference(const void *in, const size_t inlen, con=
st void *k,
+                  uint8_t *out, const size_t outlen)
 {
     c=
onst unsigned char *ni =3D (const unsigned char *)in;
     const unsigned c=
har *kk =3D (const unsigned char *)k;
diff --git a/tests/unit_tests/openvpn=
/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 1128eb4=2E=2E=
4ed113a 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/uni=
t_tests/openvpn/Makefile=2Eam
@@ -84,7 +84,9 @@
 	$(top_srcdir)/src/openvpn=
/platform=2Ec \
 	$(top_srcdir)/src/openvpn/mtu=2Ec \
 	$(top_srcdir)/src/o=
penvpn/win32-util=2Ec \
-	$(top_srcdir)/src/openvpn/mss=2Ec
+	$(top_srcdir)=
/src/openvpn/mss=2Ec \
+	$(top_srcdir)/src/openvpn/siphash_openssl=2Ec \
+	=
$(top_srcdir)/src/openvpn/siphash_reference=2Ec
 
 dhcp_testdriver_CFLAGS  =
=3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@ -D=
DHCP_UNIT_TEST
 dhcp_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/=
src/openvpn
@@ -97,6 +99,7 @@
 
 ssl_testdriver_CFLAGS  =3D \
 	-I$(top_src=
dir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	-DP=
REFER_OPENSSL_SIPHASH \
 	@TEST_CFLAGS@
 ssl_testdriver_LDFLAGS =3D @TEST_L=
DFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
 ssl_testdriver_SOURCES =3D test_ssl=2Ec \=

diff --git a/tests/unit_tests/openvpn/test_crypto=2Ec b/tests/unit_tests/o=
penvpn/test_crypto=2Ec
index cb4eaa2=2E=2Ee528f26 100644
--- a/tests/unit_t=
ests/openvpn/test_crypto=2Ec
+++ b/tests/unit_tests/openvpn/test_crypto=2Ec=

@@ -31,12 +31,14 @@
 #include <stdarg=2Eh>
 #include <string=2Eh>
 #includ=
e <setjmp=2Eh>
+#include <inttypes=2Eh>
 #include <cmocka=2Eh>
 
 #include =
"crypto=2Eh"
 #include "crypto_epoch=2Eh"
 #include "options=2Eh"
 #include=
 "ssl_backend=2Eh"
+#include "siphash=2Eh"
 
 #include "mss=2Eh"
 #include =
"test_common=2Eh"
@@ -923,6 +925,59 @@
     assert_memory_equal(key_paramet=
ers=2Ehmac, exp_impl_iv, sizeof(exp_impl_iv));
 }
 
+/* Use a define here s=
ince some c compilers don't like array initialisation
+ * with an integer *=
/
+#define UT_SIPHASH_HASH_SIZE 16
+
+static void
+test_siphash(void **stat=
e)
+{
+    const char *message =3D "Look behind you, a Three-Headed Monkey!=
";
+
+    uint8_t out[UT_SIPHASH_HASH_SIZE] =3D { 0 };
+    const uint8_t k=
ey[SIPHASH_KEY_SIZE] =3D { 0x11, 0x22, 0x33, 0x44, 0x55, 0x66 };
+
+    sip=
hash_reference(message, strlen(message), key, out, UT_SIPHASH_HASH_SIZE);
+=

+    const uint8_t expected_out[UT_SIPHASH_HASH_SIZE] =3D { 0x3e, 0xea, 0x=
95, 0xb2, 0x6d, 0x5c, 0x4e, 0xfa,
+                                        =
                 0x20, 0x47, 0x65, 0x7e, 0xdd, 0xcd, 0x62, 0x51 };
+    ass=
ert_memory_equal(out, expected_out, UT_SIPHASH_HASH_SIZE);
+}
+
+static voi=
d
+test_siphash_openssl(void **state)
+{
+    void *sipctx =3D siphash_cryp=
tolib_init(UT_SIPHASH_HASH_SIZE);
+
+    if (!siphash_cryptolib_available(s=
ipctx))
+    {
+        siphash_cryptolib_uninit(sipctx);
+        skip();
=
+    }
+
+    const char *message =3D "Look behind you, a Three-Headed Monk=
ey!";
+
+    uint8_t out[UT_SIPHASH_HASH_SIZE] =3D { 0 };
+    const uint8_=
t key[SIPHASH_KEY_SIZE] =3D { 0x11, 0x22, 0x33, 0x44, 0x55, 0x66 };
+
+
+  =
  const uint8_t expected_out[UT_SIPHASH_HASH_SIZE] =3D { 0x3e, 0xea, 0x95, =
0xb2, 0x6d, 0x5c, 0x4e, 0xfa,
+                                            =
             0x20, 0x47, 0x65, 0x7e, 0xdd, 0xcd, 0x62, 0x51 };
+
+
+    sip=
hash_cryptolib(sipctx, message, strlen(message), key, out,
+               =
       UT_SIPHASH_HASH_SIZE);
+    assert_memory_equal(out, expected_out, U=
T_SIPHASH_HASH_SIZE);
+
+    /* check that calling the function twice is sa=
fe */
+    siphash_cryptolib(sipctx, message, strlen(message), key, out,
+ =
                     UT_SIPHASH_HASH_SIZE);
+    assert_memory_equal(out, e=
xpected_out, UT_SIPHASH_HASH_SIZE);
+
+    siphash_cryptolib_uninit(sipctx)=
;
+}
+
+
 int
 main(void)
 {
@@ -957,10 +1012,9 @@
         cmocka_unit_tes=
t_prestate_setup_teardown(crypto_test_epoch_key_overflow,
                 =
                                 crypto_test_epoch_setup,
                 =
                                 crypto_test_epoch_teardown, &prestate_num3=
2),
-        cmocka_unit_test_prestate_setup_teardown(crypto_test_epoch_edg=
e,
-                                                 crypto_test_epoch_setu=
p,
-                                                 crypto_test_epoch_tear=
down, &prestate_num13),
-        cmocka_unit_test(epoch_test_derive_data_ke=
y)
+        cmocka_unit_test(epoch_test_derive_data_key),
+        cmocka_u=
nit_test(test_siphash),
+        cmocka_unit_test(test_siphash_openssl)
   =
  };
 
     return cmocka_run_group_tests_name("crypto tests", tests, NULL,=
 NULL);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I09aa27caa1=
a3aab0d1be6118b26d54a1c1bf7aa0
Gerrit-Change-Number: 31
Gerrit-PatchSet: 17=

Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenhel=
d=2Ecom>

--hNEMLIcXRv4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #17</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/31?usp=3Demail">View Change</a></p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">All=
ow to use OpenSSL&#39;s SIPHASH implementation when available<br><br>OpenSS=
L library is currently slower than the reference implementation<br>(about 1=
=2E5x to 2x depending of the compiler)=2E<br><br>The OpenSSL API for using =
the SIPHASH MAC is different enough from using<br>normal HMAC or Digest tha=
t we already implement that combining them into<br>one API does not make se=
nse=2E<br><br>SIPHASH is only available on OpenSSL 3=2E1 and later=2E We st=
ill check for<br>support on 3=2E0 and later as the whole API to allow using=
 the SIPHASH alrady<br>exists in OpenSSL 3=2E0=2E Some of the later OpenSSL=
 3=2E0=2Ex might get support<br>for it=2E Theoretically, a provider can be =
loaded in OpenSSL 3=2E0 that<br>implements SIPHASH=2E<br><br>With OpenSSL&#=
39;s implementation being slower, we currently only use it to<br>check that=
 our reference implementation and the OpenSSL implementation<br>yield the s=
ame result in unit tests<br><br>Change-Id: I09aa27caa1a3aab0d1be6118b26d54a=
1c1bf7aa0<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<=
br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>M src/openvpn/sipha=
sh=2Eh<br>A src/openvpn/siphash_openssl=2Ec<br>M src/openvpn/siphash_refere=
nce=2Ec<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/o=
penvpn/test_crypto=2Ec<br>7 files changed, 282 insertions(+), 11 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/31/31/17</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeL=
ists=2Etxt</span><br><span>index 4779d69=2E=2Edb05073 100644</span><br><spa=
n>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><=
span>@@ -562,6 +562,9 @@</span><br><span>     src/openvpn/shaper=2Eh</span>=
<br><span>     src/openvpn/sig=2Ec</span><br><span>     src/openvpn/sig=2Eh=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/sip=
hash=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/ope=
nvpn/siphash_openssl=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    src/openvpn/siphash_reference=2Ec</span><br><span>     src/openvpn=
/socket=2Ec</span><br><span>     src/openvpn/socket=2Eh</span><br><span>   =
  src/openvpn/socket_util=2Ec</span><br><span>@@ -780,8 +783,12 @@</span><b=
r><span>         src/openvpn/packet_id=2Ec</span><br><span>         src/ope=
nvpn/mtu=2Ec</span><br><span>         src/openvpn/mss=2Ec</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/siphash_reference=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/ope=
nvpn/siphash_openssl=2Ec</span><br><span>         )</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    target_compile_defini=
tions(test_crypto PRIVATE PREFER_OPENSSL_SIPHASH)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>     target_sources(test_ssl=
 PRIVATE</span><br><span>             tests/unit_tests/openvpn/mock_managem=
ent=2Ec</span><br><span>             tests/unit_tests/openvpn/mock_ssl_depe=
ndencies=2Ec</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/o=
penvpn/Makefile=2Eam</span><br><span>index ff8cc54=2E=2E08c8250 100644</spa=
n><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openv=
pn/Makefile=2Eam</span><br><span>@@ -128,6 +128,8 @@</span><br><span> 	sess=
ion_id=2Ec session_id=2Eh \</span><br><span> 	shaper=2Ec shaper=2Eh \</span=
><br><span> 	sig=2Ec sig=2Eh \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	siphash_reference=2Ec siphash=2Eh \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	siphash_openssl=2Ec \</span><br><span> 	socket=
=2Ec socket=2Eh \</span><br><span> 	socket_util=2Ec socket_util=2Eh \</span=
><br><span> 	socks=2Ec socks=2Eh \</span><br><span>diff --git a/src/openvpn=
/siphash=2Eh b/src/openvpn/siphash=2Eh</span><br><span>index ef61110=2E=2E6=
d2e134 100644</span><br><span>--- a/src/openvpn/siphash=2Eh</span><br><span=
>+++ b/src/openvpn/siphash=2Eh</span><br><span>@@ -18,12 +18,67 @@</span><b=
r><span> #ifndef SIPHASH_H</span><br><span> #define SIPHASH_H</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;intt=
ypes=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &lt;stdint=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &lt;stdio=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &lt;stdbool=2Eh&gt;</span><br><span> </span><br><span> /* =
siphash always uses 128-bit keys */</span><br><span> #define SIPHASH_KEY_SI=
ZE 16</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-int siphash(const void *in, size_t inlen, const void *k, uint8_t *out,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            size_t outle=
n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Prototypes fo=
r an implementation of SIPHASH in a crypto library */</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Calculates SIPHASH using the crypto library functio=
n=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+siphash_cryptolib(void *sip_context, const void=
 *in, size_t inlen,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                  const void *k, uint8_t *out, size_t outlen);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Calculates SIPHASH using the reference implementation</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+siphash_reference(const void *in, size_t inlen, const void *k,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  u=
int8_t *out, size_t outlen);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param hash_size the size of the outpu=
t hash size</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retu=
rn initialised context for siphash</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_crypto=
lib_init(size_t hash_size);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Free the siphash context=
 used for the crypto library</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param sip_context</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib_un=
init(void *sip_context);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Returns if the crypto libra=
ry is available (and should be used)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * This returns if there is a crypto library version of Siphash24 is</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * available and should be=
 used (OpenSSL 3/4 version is quite slow, so</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * we prefer the reference implementation)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
siphash_cryptolib_available(void *sip_context);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static inline int</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+siphash(void *ctx, const void *in, size_t inlen, const void *k,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint8_t *out, si=
ze_t outlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (siphash_cryptolib=
_available(ctx) &amp;&amp; false)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return siphash_cryptolib(ctx, in, inlen, k, out, outlen);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return siphash_reference(in, inlen, k, out, outlen);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif /* ifndef SIPHASH_H */</span><br><span>\ No newline at end of file</s=
pan><br><span>diff --git a/src/openvpn/siphash_openssl=2Ec b/src/openvpn/si=
phash_openssl=2Ec</span><br><span>new file mode 100644</span><br><span>inde=
x 0000000=2E=2Ebb42a38</span><br><span>--- /dev/null</span><br><span>+++ b/=
src/openvpn/siphash_openssl=2Ec</span><br><span>@@ -0,0 +1,150 @@</span><br=
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
 hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 Arne Schwabe &lt;arne@rfc254=
9=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
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
color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#elif defined(_MSC_VER)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config-msvc=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifdef ENABLE_CRYPTO_OPENSSL</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &lt;openssl/opensslv=2Eh&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* OpenSSL siphash is currently 2-3 times slower than the referen=
ce</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * implementation=
, so only enable it when PREFER_OPENSSL_SIPHASH is defined</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * for now */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_CRYPTO_OPENSSL) &amp;&=
amp; OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L &amp;&amp; defined(PREFER_O=
PENSSL_SIPHASH)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &lt;openssl/evp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;crypto_openssl=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+struct siphash_context</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    E=
VP_MAC *mac;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP=
_MAC_CTX *ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
ize_t size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OSSL=
_PARAM params[3];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  Computes a SipHash value</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * in: pointer to input data (read-only)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  inlen: input data len=
gth in bytes (any size_t value)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * k: pointer to the key data (read-only), must be 16 bytes</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * out: pointer to outp=
ut data (write-only), outlen bytes must be allocated</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  outlen: length of the output in bytes=
, must be 8 or 16</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib(void *sip_contex=
t, const void *in, const size_t inlen,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                  const void *k, uint8_t *out, const siz=
e_t outlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct siphash_context=
 *sip =3D sip_context;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;params[1] =3D OSSL_PARA=
M_construct_octet_string(&quot;key&quot;, (void *)k,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
              SIPHASH_KEY_SIZE);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (!EVP_MAC_init(sip-&gt;ctx, NULL, 0, sip-&gt;params))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        crypto_msg(M_FATAL, &quot;E=
VP_MAC_init failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP=
_MAC_update(sip-&gt;ctx, in, inlen);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  size_t outl =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    EVP_MAC_final(sip-&gt;ctx, out, &amp;outl, outlen);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib_i=
nit(size_t hash_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct sipha=
sh_context *sip;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ALLOC_OBJ(sip, struct siphash_context);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    sip-&gt;mac =3D EVP_MAC_fetch(NULL, &quot;SIPHASH&quot;, NULL);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!sip-&gt;mac)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        /* Our OpenSSL library does n=
ot support SIPHASH */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return sip;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;=
ctx =3D EVP_MAC_CTX_new(sip-&gt;mac);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* OpenSSL will truly hold a pointer to an int in that parameter */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;size =3D has=
h_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;=
params[0] =3D OSSL_PARAM_construct_size_t(&quot;size&quot;, &amp;sip-&gt;si=
ze);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* params[1=
] will hold the key that changes which each invocation */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;params[2] =3D OSSL_PARAM_=
construct_end();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return sip;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+siphash_cryptolib_available(void *sip_context)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct siphash_context *sip =3D sip_context;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return (bool)(sip-&gt;mac);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sipha=
sh_cryptolib_uninit(void *sip_context)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct siphash_context *sip =3D sip_context;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    EVP_MAC_CTX_free(sip-&gt;ctx);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_free(sip-&gt;mac);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(sip_contex=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* for now, we only have one implementation of SIPHASH in a libray,=
 so put the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * dummy=
 functions also here */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_cryp=
tolib(void *sip_context, const void *in, const size_t inlen,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                  const void *k, u=
int8_t *out, const size_t outlen)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+siphash_cryptolib_available(void *sip_context)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return false;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib_init(size_t=
 hash_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphas=
h_cryptolib_uninit(void *sip_context)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif /* if defined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; O=
PENSSL_VERSION_NUMBER &gt;=3D 0x30000000L */</span><br><span>diff --git a/s=
rc/openvpn/siphash_reference=2Ec b/src/openvpn/siphash_reference=2Ec</span>=
<br><span>index b21a86e=2E=2Ea06599f 100644</span><br><span>--- a/src/openv=
pn/siphash_reference=2Ec</span><br><span>+++ b/src/openvpn/siphash_referenc=
e=2Ec</span><br><span>@@ -100,8 +100,8 @@</span><br><span>  *  outlen: leng=
th of the output in bytes, must be 8 or 16</span><br><span>  */</span><br><=
span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-siphash(cons=
t void *in, const size_t inlen, const void *k, uint8_t *out,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        const size_t outlen)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_reference(const voi=
d *in, const size_t inlen, const void *k,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                  uint8_t *out, const size_t outlen)<=
/span><br><span> {</span><br><span>     const unsigned char *ni =3D (const =
unsigned char *)in;</span><br><span>     const unsigned char *kk =3D (const=
 unsigned char *)k;</span><br><span>diff --git a/tests/unit_tests/openvpn/M=
akefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index=
 1128eb4=2E=2E4ed113a 100644</span><br><span>--- a/tests/unit_tests/openvpn=
/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam=
</span><br><span>@@ -84,7 +84,9 @@</span><br><span> 	$(top_srcdir)/src/open=
vpn/platform=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/mtu=2Ec \</s=
pan><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/mss=2Ec</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/open=
vpn/mss=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top=
_srcdir)/src/openvpn/siphash_openssl=2Ec \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec</sp=
an><br><span> </span><br><span> dhcp_testdriver_CFLAGS  =3D -I$(top_srcdir)=
/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@ -DDHCP_UNIT_TEST</spa=
n><br><span> dhcp_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src=
/openvpn</span><br><span>@@ -97,6 +99,7 @@</span><br><span> </span><br><spa=
n> ssl_testdriver_CFLAGS  =3D \</span><br><span> 	-I$(top_srcdir)/include -=
I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+	-DPREFER_OPENSSL_SIPHASH \</span><br><=
span> 	@TEST_CFLAGS@</span><br><span> ssl_testdriver_LDFLAGS =3D @TEST_LDFL=
AGS@  $(OPTIONAL_CRYPTO_LIBS)</span><br><span> ssl_testdriver_SOURCES =3D t=
est_ssl=2Ec \</span><br><span>diff --git a/tests/unit_tests/openvpn/test_cr=
ypto=2Ec b/tests/unit_tests/openvpn/test_crypto=2Ec</span><br><span>index c=
b4eaa2=2E=2Ee528f26 100644</span><br><span>--- a/tests/unit_tests/openvpn/t=
est_crypto=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_crypto=
=2Ec</span><br><span>@@ -31,12 +31,14 @@</span><br><span> #include &lt;stda=
rg=2Eh&gt;</span><br><span> #include &lt;string=2Eh&gt;</span><br><span> #i=
nclude &lt;setjmp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &lt;inttypes=2Eh&gt;</span><br><span> #include &lt;cmocka=2E=
h&gt;</span><br><span> </span><br><span> #include &quot;crypto=2Eh&quot;</s=
pan><br><span> #include &quot;crypto_epoch=2Eh&quot;</span><br><span> #incl=
ude &quot;options=2Eh&quot;</span><br><span> #include &quot;ssl_backend=2Eh=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;siphash=2Eh&quot;</span><br><span> </span><br><span> #include &quot;mss=
=2Eh&quot;</span><br><span> #include &quot;test_common=2Eh&quot;</span><br>=
<span>@@ -923,6 +925,59 @@</span><br><span>     assert_memory_equal(key_par=
ameters=2Ehmac, exp_impl_iv, sizeof(exp_impl_iv));</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Use =
a define here since some c compilers don&#39;t like array initialisation</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * with an integer */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define UT_SIPHASH_H=
ASH_SIZE 16</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+test_siphash(void **state)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const char *message =3D &quot;Look behind =
you, a Three-Headed Monkey!&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
uint8_t out[UT_SIPHASH_HASH_SIZE] =3D { 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const uint8_t key[SIPHASH_KEY_SIZE] =3D { 0x11=
, 0x22, 0x33, 0x44, 0x55, 0x66 };</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
iphash_reference(message, strlen(message), key, out, UT_SIPHASH_HASH_SIZE);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const uint8_t expected_out[UT_SIPH=
ASH_HASH_SIZE] =3D { 0x3e, 0xea, 0x95, 0xb2, 0x6d, 0x5c, 0x4e, 0xfa,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
                               0x20, 0x47, 0x65, 0x7e, 0xdd, 0xcd, 0x62, 0x=
51 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_mem=
ory_equal(out, expected_out, UT_SIPHASH_HASH_SIZE);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_siphas=
h_openssl(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    void *sipc=
tx =3D siphash_cryptolib_init(UT_SIPHASH_HASH_SIZE);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!siphash_cryptolib_available(sipctx))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        siphash_cryptolib_uninit(sipctx);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        skip();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const char *message =3D &quot;Look behind you, a Three-Head=
ed Monkey!&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t out[UT_SI=
PHASH_HASH_SIZE] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const uint8_t key[SIPHASH_KEY_SIZE] =3D { 0x11, 0x22, 0x33, 0x4=
4, 0x55, 0x66 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const uint8_t expected_out[UT_SIPHASH=
_HASH_SIZE] =3D { 0x3e, 0xea, 0x95, 0xb2, 0x6d, 0x5c, 0x4e, 0xfa,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
                            0x20, 0x47, 0x65, 0x7e, 0xdd, 0xcd, 0x62, 0x51 =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    siphash_cryptolib(sipctx, message, strlen(message),=
 key, out,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
             UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_memory_equal(out, expected_out, UT_SIPHASH_HASH_=
SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* check that calling the fu=
nction twice is safe */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    siphash_cryptolib(sipctx, message, strlen(message), key, out,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                      UT_=
SIPHASH_HASH_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_memory_equal(out, expected_out, UT_SIPHASH_HASH_SIZE);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    siphash_cryptolib_uninit(sipctx);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> int</span><br><span> main(void)</span><br><span> =
{</span><br><span>@@ -957,10 +1012,9 @@</span><br><span>         cmocka_uni=
t_test_prestate_setup_teardown(crypto_test_epoch_key_overflow,</span><br><s=
pan>                                                  crypto_test_epoch_set=
up,</span><br><span>                                                  crypt=
o_test_epoch_teardown, &amp;prestate_num32),</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        cmocka_unit_test_prestate_setup_teardown(cry=
pto_test_epoch_edge,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                                crypto_test_epoch_setup,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
                         crypto_test_epoch_teardown, &amp;prestate_num13),<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_te=
st(epoch_test_derive_data_key)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(epoch_test_derive_data_key),</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_=
siphash),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cm=
ocka_unit_test(test_siphash_openssl)</span><br><span>     };</span><br><spa=
n> </span><br><span>     return cmocka_run_group_tests_name(&quot;crypto te=
sts&quot;, tests, NULL, NULL);</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail"=
>change 31</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

=
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 31 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 17 </div>
<div style=3D"display:none"> Gerrit-Owner: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: fl=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--hNEMLIcXRv4=--


--===============7447809403429812788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7447809403429812788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7447809403429812788==--

