Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612FBC4453A
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 10:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h+A2+F2dRrNcFhTwjUx8MEp4ZvvF+Kgf5UVS0Z3LXMY=; b=ZJzGx/3A6fxXj+U6kwK6W60uUP
	6YEOOOHUa8Q7TR1gGBfta9wLhecDibyjP6NxSic7kjN8k6/qjnKSTIIQ7rBo+7u7mK3CCO+vSlJ7J
	wyP3/3gDp53mRzdJv8I9VZlWuC0e5NY3a64SQ3ZA+5MMfvA5Oz5W5+8247xGo5dRjF1A=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmUCo-0006z1-OL;
	Wed, 22 Jul 2026 10:29:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmUCn-0006yu-D4
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 10:29:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=DMdxC2Dbyf0mX8h/7PrpEWh9LyOpU1mf0ggXrICqIGQ=; b=Fxs7yCQDqFxOw8UeGqT84dPtEH
 D+qApSElywsoxSHWPK+b5XJwvQ5Pf3ddARSniMBjYoxScK3S0mVCCCeGZfhQbkCrlaaPOb3USCVhB
 37qtQuxtFKuTBgWc4708qha9fmTy6RtOGQYGSwGa/+MI9yCtomusGWUq6BpHWesgzy4c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DMdxC2Dbyf0mX8h/7PrpEWh9LyOpU1mf0ggXrICqIGQ=; b=X
 W6XmnZAVQU5WppJLVv/bJs/1t4pvazt1BuaQNn2uLX61tlua6up6ogaUncg9CeH9gmrwHqQXoR0QS
 aaycmSuB5v1fTGLRo62lDpef+BfeehhYVRwdl0z5fCXUovprV7zrtkQwEmiToJFNUuaF+TzGAFdwi
 ug4PMifzEoyvrfH0=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmUCh-0007mt-Hx for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 10:29:34 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-495437bb891so49795285e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 03:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784716160; x=1785320960; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DMdxC2Dbyf0mX8h/7PrpEWh9LyOpU1mf0ggXrICqIGQ=;
 b=AnUgfVKWUMIFpDAfMHwcCP8LUFZOsU4s9IInXaYiGOhLrmpI1WUfaWOiX0jCJvd26x
 kDoJ2XP8bvtcs25STH0JLmjXWiLC6sbhD4K+tjjtlYFbgBISfikA+Nr8t7KMwk95x1Up
 jO4THaPnhtv4uIceulw9SydEe9lfyVG5OVVATsKr6uR2+7fj63NLDAOV9FEkPB9y/Sdj
 CetukLBks6lAjzKLODvhELMMo6t0tEqFfvylL5BUUJ+wPjyr2b4I4rPq0GAEwWuQjXUK
 eUd2Fwi1LLEiFJJbGg5OBxDfXZFRHCHMlbnoH47JL2iWmocgN1DvPH7aaWJtJNdI7Ue7
 LByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784716160; x=1785320960;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DMdxC2Dbyf0mX8h/7PrpEWh9LyOpU1mf0ggXrICqIGQ=;
 b=mSgRyg7SgOKZlgjnM+JU+aRM7fCBV/2kUe1uQzo2Br1vLyNAPI8G4VR8kjjfNZTkyX
 mj5MuvES3xfzCf1iE80CzScqGU8MDeOSwLW6KeILty2ZKWb/a+iL2WohuToHRtJCWkFA
 dF/zW5MnkN1eKIidMYweN9XWFrs4x/dFW8o+dhCX8qBLqw/8ACc5Ig/H2oVB7hqUBDms
 7BixLIWbY3HrjGlDiCTxWlt09a9jaST39g98bZSHHTwo2MPSCVglhP6jb7U70ugoOpPC
 lPeGZj/DjVmy7woCFei+NihvLB5Hat3fFfV3dg8n7rgfhu2bGe9C7R1epk62yxIKmB2C
 KcrA==
X-Gm-Message-State: AOJu0Yz3yoOh7ThNcJntsei4jtvqimvjonuB8dUMNn2evrhdfLaigLdl
 B3ef/RRKIvMn8Ug3k/EOZF802XTo7RrmO3cznkmW27tyv8IHrADReHYPaxEE1nwBDDZo+Vjbu31
 a4oA2yFRcwvB7HbZMixp4nTGc1D067jCaIMcRksy4HECZL9YwtsOW2uZjna3Hbxc+8MXn9sVx1Z
 ycKpLTCQ==
X-Gm-Gg: AR+sD10A6ELpq3/FgH7CZbfRspJEys4YjKSlVZZ/wQMcerkFJCzZbWBdreO2pBLkvd2
 XMxGOF+lD/scFeEZGK8clUapnKS1xlQZ2mEj8QKvE7McPhOQyV7CukwLDS5m0LUEyEDbj5PRsef
 b0Gb0qJZ9Yau99cKPdYLwL7JliJa0Q5BD7k4Pkl7cOYFlp+Iv2kQD1cYlSd7eC/Lvry5pZi99wv
 sBfXSdpSIgdSfucEsfVDEwO6dAQqJ5IyEL/fLLzFeifo7KeZEZHHzrpAvGRs0nTngW2qJDbQg56
 ARc1sCUjcgcRpeFbL9kbKAVZM8PW+yLy2PF5dJe9PQT7RK3NHpbQs32DiP3x4jyh4NnJOI+TZep
 ICDRQq3otfMOt+hKePZYZGFK0rcl8zrrO+6FrJwQaQDpeF0mwI0cxJ7ul+hkNumg9XG/sTZ6+6B
 qQE/8YXzYcf7h8eB6fiiJmPwkBaxztGVUhKozfGFyZUhVZpQNu5EIA87D086LKcil22Zv1g/OYF
 WRNZcSFGG5cL+p+R5YhXvpsjKmtyCDjvDKT/gXBb7bzmbc/Zs072O2jAHMC9dJNeZXG
X-Received: by 2002:a05:600c:1f8d:b0:493:ecf5:89fd with SMTP id
 5b1f17b1804b1-4956a51ba79mr34102485e9.17.1784716159636; 
 Wed, 22 Jul 2026 03:29:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a63e3a8sm66802485e9.12.2026.07.22.03.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 03:29:19 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 10:29:13 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
X-Gerrit-Change-Number: 31
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/31?usp=email>
X-Gerrit-Commit: 8c05e8eee38d3fd7354a415ca2a7ebd328afc619
In-Reply-To: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwOWFhMjdjYWExYTNhYWIwZDFiZTYxMThiMjZkNTRhMWMxYmY3YWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5bebe467e87348fa1d2f879db1fe482b920de286-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmUCh-0007mt-Hx
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
Content-Type: multipart/mixed; boundary="===============2668526237532391113=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2668526237532391113==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MhbxW9fhPHo="; charset=UTF-8

--MhbxW9fhPHo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/31?usp=3Demail

to look at the new patch set (#18)=
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
 files changed, 277 insertions(+), 8 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/31/31/18

diff --git a/CMakeLis=
ts=2Etxt b/CMakeLists=2Etxt
index 7473f15=2E=2E25c3ea5 100644
--- a/CMakeLi=
sts=2Etxt
+++ b/CMakeLists=2Etxt
@@ -572,6 +572,9 @@
     src/openvpn/shape=
r=2Eh
     src/openvpn/sig=2Ec
     src/openvpn/sig=2Eh
+    src/openvpn/si=
phash=2Eh
+    src/openvpn/siphash_openssl=2Ec
+    src/openvpn/siphash_ref=
erence=2Ec
     src/openvpn/socket=2Ec
     src/openvpn/socket=2Eh
     src=
/openvpn/socket_util=2Ec
@@ -792,8 +795,12 @@
         src/openvpn/packet_i=
d=2Ec
         src/openvpn/mtu=2Ec
         src/openvpn/mss=2Ec
+        sr=
c/openvpn/siphash_reference=2Ec
+        src/openvpn/siphash_openssl=2Ec
  =
       )
 
+    target_compile_definitions(test_crypto PRIVATE PREFER_OPENS=
SL_SIPHASH)
+
     target_sources(test_ssl PRIVATE
             tests/unit_=
tests/openvpn/mock_management=2Ec
             tests/unit_tests/openvpn/moc=
k_ssl_dependencies=2Ec
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn=
/Makefile=2Eam
index ff8cc54=2E=2E08c8250 100644
--- a/src/openvpn/Makefile=
=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -128,6 +128,8 @@
 	session_id=2Ec =
session_id=2Eh \
 	shaper=2Ec shaper=2Eh \
 	sig=2Ec sig=2Eh \
+	siphash_re=
ference=2Ec siphash=2Eh \
+	siphash_openssl=2Ec \
 	socket=2Ec socket=2Eh \=

 	socket_util=2Ec socket_util=2Eh \
 	socks=2Ec socks=2Eh \
diff --git a/s=
rc/openvpn/siphash=2Eh b/src/openvpn/siphash=2Eh
index ef61110=2E=2E07b087e=
 100644
--- a/src/openvpn/siphash=2Eh
+++ b/src/openvpn/siphash=2Eh
@@ -18,=
12 +18,67 @@
 #ifndef SIPHASH_H
 #define SIPHASH_H
 
-#include <inttypes=2E=
h>
+#include <stdint=2Eh>
+#include <stdio=2Eh>
+#include <stdbool=2Eh>
 
 =
/* siphash always uses 128-bit keys */
 #define SIPHASH_KEY_SIZE 16
 
-int =
siphash(const void *in, size_t inlen, const void *k, uint8_t *out,
-       =
     size_t outlen);
+/* Prototypes for an implementation of SIPHASH in a c=
rypto library */
 
-#endif
+/**
+ * Calculates SIPHASH using the crypto lib=
rary function=2E
+ */
+int
+siphash_cryptolib(void *sip_context, const void=
 *in, size_t inlen,
+                  const void *k, uint8_t *out, size_t =
outlen);
+
+/**
+ * Calculates SIPHASH using the reference implementation
+=
 */
+int
+siphash_reference(const void *in, size_t inlen, const void *k,
+ =
                 uint8_t *out, size_t outlen);
+
+/**
+ *
+ * @param hash_s=
ize the size of the output hash size
+ * @return initialised context for si=
phash
+ */
+void *
+siphash_cryptolib_init(size_t hash_size);
+
+/**
+ * Fr=
ee the siphash context used for the crypto library
+ * @param sip_context
+=
 */
+void
+siphash_cryptolib_uninit(void *sip_context);
+
+/**
+ * Returns =
if the crypto library is available (and should be used)
+ *
+ * This return=
s if there is a crypto library version of Siphash24 is
+ * available and sh=
ould be used (OpenSSL 3/4 version is quite slow, so
+ * we prefer the refer=
ence implementation)
+ *
+ */
+bool
+siphash_cryptolib_available(void *sip_=
context);
+
+static inline int
+siphash(void *ctx, const void *in, size_t i=
nlen, const void *k,
+        uint8_t *out, size_t outlen)
+{
+    if (siph=
ash_cryptolib_available(ctx))
+    {
+        return siphash_cryptolib(ctx,=
 in, inlen, k, out, outlen);
+    }
+    else
+    {
+        return siphas=
h_reference(in, inlen, k, out, outlen);
+    }
+}
+
+#endif /* ifndef SIPHA=
SH_H */
\ No newline at end of file
diff --git a/src/openvpn/siphash_openss=
l=2Ec b/src/openvpn/siphash_openssl=2Ec
new file mode 100644
index 0000000=
=2E=2E214b3f4
--- /dev/null
+++ b/src/openvpn/siphash_openssl=2Ec
@@ -0,0 +=
1,145 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
=
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
=
+ *             session authentication and key exchange,
+ *             pa=
cket encryption, packet authentication, and
+ *             packet compress=
ion=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+=
 *  Copyright (C) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *  This prog=
ram is free software; you can redistribute it and/or modify
+ *  it under t=
he terms of the GNU General Public License version 2
+ *  as published by t=
he Free Software Foundation=2E
+ *
+ *  This program is distributed in the =
hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even th=
e implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ *=
  You should have received a copy of the GNU General Public License along
+=
 *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+=
 */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "sip=
hash=2Eh"
+
+#ifdef ENABLE_CRYPTO_OPENSSL
+#include <openssl/opensslv=2Eh>
=
+#endif
+
+/* OpenSSL siphash is currently 2-3 times slower than the refere=
nce
+ * implementation, so only enable it when PREFER_OPENSSL_SIPHASH is de=
fined
+ * for now */
+#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION=
_NUMBER >=3D 0x30000000L && defined(PREFER_OPENSSL_SIPHASH)
+#include <open=
ssl/evp=2Eh>
+#include "crypto_openssl=2Eh"
+#include "crypto_backend=2Eh"
=
+
+struct siphash_context
+{
+    EVP_MAC *mac;
+    EVP_MAC_CTX *ctx;
+   =
 size_t size;
+    OSSL_PARAM params[3];
+};
+
+/*
+ *  Computes a SipHash =
value
+ * in: pointer to input data (read-only)
+ *  inlen: input data leng=
th in bytes (any size_t value)
+ * k: pointer to the key data (read-only), =
must be 16 bytes
+ * out: pointer to output data (write-only), outlen bytes=
 must be allocated
+ *  outlen: length of the output in bytes, must be 8 or=
 16
+ */
+int
+siphash_cryptolib(void *sip_context, const void *in, const s=
ize_t inlen,
+                  const void *k, uint8_t *out, const size_t o=
utlen)
+{
+    struct siphash_context *sip =3D sip_context;
+
+
+    sip->p=
arams[1] =3D OSSL_PARAM_construct_octet_string("key", (void *)k,
+         =
                                              SIPHASH_KEY_SIZE);
+    if (!=
EVP_MAC_init(sip->ctx, NULL, 0, sip->params))
+    {
+        crypto_msg(M_=
FATAL, "EVP_MAC_init failed");
+    }
+    EVP_MAC_update(sip->ctx, in, inl=
en);
+
+    size_t outl =3D 0;
+    EVP_MAC_final(sip->ctx, out, &outl, out=
len);
+    return 0;
+}
+
+void *
+siphash_cryptolib_init(size_t hash_size)=

+{
+    struct siphash_context *sip;
+    ALLOC_OBJ(sip, struct siphash_co=
ntext);
+
+    sip->mac =3D EVP_MAC_fetch(NULL, "SIPHASH", NULL);
+    if (=
!sip->mac)
+    {
+        /* Our OpenSSL library does not support SIPHASH =
*/
+        return sip;
+    }
+    sip->ctx =3D EVP_MAC_CTX_new(sip->mac);=

+
+    /* OpenSSL will truly hold a pointer to an int in that parameter */=

+    sip->size =3D hash_size;
+    sip->params[0] =3D OSSL_PARAM_construct=
_size_t("size", &sip->size);
+    /* params[1] will hold the key that chang=
es which each invocation */
+    sip->params[2] =3D OSSL_PARAM_construct_en=
d();
+    return sip;
+}
+
+bool
+siphash_cryptolib_available(void *sip_con=
text)
+{
+    struct siphash_context *sip =3D sip_context;
+
+    return (b=
ool)(sip->mac);
+}
+
+void
+siphash_cryptolib_uninit(void *sip_context)
+{
=
+    struct siphash_context *sip =3D sip_context;
+    EVP_MAC_CTX_free(sip=
->ctx);
+    EVP_MAC_free(sip->mac);
+    free(sip_context);
+}
+
+#else
+/=
* for now, we only have one implementation of SIPHASH in a libray, so put t=
he
+ * dummy functions also here */
+int
+siphash_cryptolib(void *sip_conte=
xt, const void *in, const size_t inlen,
+                  const void *k, u=
int8_t *out, const size_t outlen)
+{
+    return -1;
+}
+
+bool
+siphash_cr=
yptolib_available(void *sip_context)
+{
+    return false;
+}
+
+void *
+si=
phash_cryptolib_init(size_t hash_size)
+{
+    return NULL;
+}
+
+void
+sip=
hash_cryptolib_uninit(void *sip_context)
+{
+}
+
+
+#endif /* if defined(EN=
ABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >=3D 0x30000000L */
diff --g=
it a/src/openvpn/siphash_reference=2Ec b/src/openvpn/siphash_reference=2Ec
=
index b21a86e=2E=2Ea06599f 100644
--- a/src/openvpn/siphash_reference=2Ec
+=
++ b/src/openvpn/siphash_reference=2Ec
@@ -100,8 +100,8 @@
  *  outlen: len=
gth of the output in bytes, must be 8 or 16
  */
 int
-siphash(const void *=
in, const size_t inlen, const void *k, uint8_t *out,
-        const size_t =
outlen)
+siphash_reference(const void *in, const size_t inlen, const void *=
k,
+                  uint8_t *out, const size_t outlen)
 {
     const unsi=
gned char *ni =3D (const unsigned char *)in;
     const unsigned char *kk =
=3D (const unsigned char *)k;
diff --git a/tests/unit_tests/openvpn/Makefil=
e=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index d861ef9=2E=2E9e1e216 =
100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/=
openvpn/Makefile=2Eam
@@ -84,7 +84,9 @@
 	$(top_srcdir)/src/openvpn/platfor=
m=2Ec \
 	$(top_srcdir)/src/openvpn/mtu=2Ec \
 	$(top_srcdir)/src/openvpn/w=
in32-util=2Ec \
-	$(top_srcdir)/src/openvpn/mss=2Ec
+	$(top_srcdir)/src/ope=
nvpn/mss=2Ec \
+	$(top_srcdir)/src/openvpn/siphash_openssl=2Ec \
+	$(top_sr=
cdir)/src/openvpn/siphash_reference=2Ec
 
 dhcp_testdriver_CFLAGS  =3D -I$(=
top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@ -DDHCP_UNI=
T_TEST
 dhcp_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/open=
vpn
@@ -97,6 +99,7 @@
 
 ssl_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/inc=
lude -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	-DPREFER_OP=
ENSSL_SIPHASH \
 	@TEST_CFLAGS@
 ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ =
 $(OPTIONAL_CRYPTO_LIBS)
 ssl_testdriver_SOURCES =3D test_ssl=2Ec \
diff --=
git a/tests/unit_tests/openvpn/test_crypto=2Ec b/tests/unit_tests/openvpn/t=
est_crypto=2Ec
index cb4eaa2=2E=2Eaad17f7 100644
--- a/tests/unit_tests/ope=
nvpn/test_crypto=2Ec
+++ b/tests/unit_tests/openvpn/test_crypto=2Ec
@@ -31,=
12 +31,14 @@
 #include <stdarg=2Eh>
 #include <string=2Eh>
 #include <setjm=
p=2Eh>
+#include <inttypes=2Eh>
 #include <cmocka=2Eh>
 
 #include "crypto=
=2Eh"
 #include "crypto_epoch=2Eh"
 #include "options=2Eh"
 #include "ssl_b=
ackend=2Eh"
+#include "siphash=2Eh"
 
 #include "mss=2Eh"
 #include "test_c=
ommon=2Eh"
@@ -923,6 +925,59 @@
     assert_memory_equal(key_parameters=2Eh=
mac, exp_impl_iv, sizeof(exp_impl_iv));
 }
 
+/* Use a define here since so=
me c compilers don't like array initialisation
+ * with an integer */
+#def=
ine UT_SIPHASH_HASH_SIZE 16
+
+static void
+test_siphash(void **state)
+{
+=
    const char *message =3D "Look behind you, a Three-Headed Monkey!";
+
+ =
   uint8_t out[UT_SIPHASH_HASH_SIZE] =3D { 0 };
+    const uint8_t key[SIPH=
ASH_KEY_SIZE] =3D { 0x11, 0x22, 0x33, 0x44, 0x55, 0x66 };
+
+    siphash_re=
ference(message, strlen(message), key, out, UT_SIPHASH_HASH_SIZE);
+
+    c=
onst uint8_t expected_out[UT_SIPHASH_HASH_SIZE] =3D { 0x3e, 0xea, 0x95, 0xb=
2, 0x6d, 0x5c, 0x4e, 0xfa,
+                                               =
          0x20, 0x47, 0x65, 0x7e, 0xdd, 0xcd, 0x62, 0x51 };
+    assert_mem=
ory_equal(out, expected_out, UT_SIPHASH_HASH_SIZE);
+}
+
+static void
+test=
_siphash_openssl(void **state)
+{
+    void *sipctx =3D siphash_cryptolib_i=
nit(UT_SIPHASH_HASH_SIZE);
+
+    if (!siphash_cryptolib_available(sipctx))=

+    {
+        siphash_cryptolib_uninit(sipctx);
+        skip();
+    }
=
+
+    const char *message =3D "Look behind you, a Three-Headed Monkey!";
+=

+    uint8_t out[UT_SIPHASH_HASH_SIZE] =3D { 0 };
+    const uint8_t key[S=
IPHASH_KEY_SIZE] =3D { 0x11, 0x22, 0x33, 0x44, 0x55, 0x66 };
+
+
+    const=
 uint8_t expected_out[UT_SIPHASH_HASH_SIZE] =3D { 0x3e, 0xea, 0x95, 0xb2, 0=
x6d, 0x5c, 0x4e, 0xfa,
+                                                   =
      0x20, 0x47, 0x65, 0x7e, 0xdd, 0xcd, 0x62, 0x51 };
+
+
+    siphash_cr=
yptolib(sipctx, message, strlen(message), key, out,
+                      =
UT_SIPHASH_HASH_SIZE);
+    assert_memory_equal(out, expected_out, UT_SIPHA=
SH_HASH_SIZE);
+
+    /* check that calling the function twice is safe */
+=
    siphash_cryptolib(sipctx, message, strlen(message), key, out,
+        =
              UT_SIPHASH_HASH_SIZE);
+    assert_memory_equal(out, expected=
_out, UT_SIPHASH_HASH_SIZE);
+
+    siphash_cryptolib_uninit(sipctx);
+}
+
=
+
 int
 main(void)
 {
@@ -960,7 +1015,9 @@
         cmocka_unit_test_presta=
te_setup_teardown(crypto_test_epoch_edge,
                                 =
                 crypto_test_epoch_setup,
                                 =
                 crypto_test_epoch_teardown, &prestate_num13),
-        cmo=
cka_unit_test(epoch_test_derive_data_key)
+        cmocka_unit_test(epoch_t=
est_derive_data_key),
+        cmocka_unit_test(test_siphash),
+        cmo=
cka_unit_test(test_siphash_openssl)
     };
 
     return cmocka_run_group_=
tests_name("crypto tests", tests, NULL, NULL);

-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
Gerri=
t-Change-Number: 31
Gerrit-PatchSet: 18
Gerrit-Owner: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: flichtenheld <frank@lichtenheld=2Ecom>

--MhbxW9fhPHo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #18</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
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
penvpn/test_crypto=2Ec<br>7 files changed, 277 insertions(+), 8 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/31/31/18</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLi=
sts=2Etxt</span><br><span>index 7473f15=2E=2E25c3ea5 100644</span><br><span=
>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><s=
pan>@@ -572,6 +572,9 @@</span><br><span>     src/openvpn/shaper=2Eh</span><=
br><span>     src/openvpn/sig=2Ec</span><br><span>     src/openvpn/sig=2Eh<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/siph=
ash=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/open=
vpn/siphash_openssl=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    src/openvpn/siphash_reference=2Ec</span><br><span>     src/openvpn/=
socket=2Ec</span><br><span>     src/openvpn/socket=2Eh</span><br><span>    =
 src/openvpn/socket_util=2Ec</span><br><span>@@ -792,8 +795,12 @@</span><br=
><span>         src/openvpn/packet_id=2Ec</span><br><span>         src/open=
vpn/mtu=2Ec</span><br><span>         src/openvpn/mss=2Ec</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/siphash_reference=
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
/siphash=2Eh b/src/openvpn/siphash=2Eh</span><br><span>index ef61110=2E=2E0=
7b087e 100644</span><br><span>--- a/src/openvpn/siphash=2Eh</span><br><span=
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
_available(ctx))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return si=
phash_cryptolib(ctx, in, inlen, k, out, outlen);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn siphash_reference(in, inlen, k, out, outlen);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef SIP=
HASH_H */</span><br><span>\ No newline at end of file</span><br><span>diff =
--git a/src/openvpn/siphash_openssl=2Ec b/src/openvpn/siphash_openssl=2Ec</=
span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E214b=
3f4</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/siphash=
_openssl=2Ec</span><br><span>@@ -0,0 +1,145 @@</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a si=
ngle TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *             session authentication and key=
 exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
      packet encryption, packet authentication, and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &=
lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  Copyright (C) 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
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
lude &quot;siphash=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENA=
BLE_CRYPTO_OPENSSL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &lt;openssl/opensslv=2Eh&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* OpenSSL siph=
ash is currently 2-3 times slower than the reference</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * implementation, so only enable it when=
 PREFER_OPENSSL_SIPHASH is defined</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * for now */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; OPENSSL_VERSION_NUMB=
ER &gt;=3D 0x30000000L &amp;&amp; defined(PREFER_OPENSSL_SIPHASH)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;openssl/evp=2Eh&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;c=
rypto_openssl=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;crypto_backend=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+struct siphash_context</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP_MA=
C *mac;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_=
CTX *ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t=
 size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OSSL_PARA=
M params[3];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Computes a SipHash value</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * in: pointer to input data (read-only)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  inlen: input data length=
 in bytes (any size_t value)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * k: pointer to the key data (read-only), must be 16 bytes</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * out: pointer to output =
data (write-only), outlen bytes must be allocated</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  outlen: length of the output in bytes, mu=
st be 8 or 16</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib(void *sip_context, c=
onst void *in, const size_t inlen,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                  const void *k, uint8_t *out, const size_t =
outlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct siphash_context *si=
p =3D sip_context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;params[1] =3D OSSL_PARAM_co=
nstruct_octet_string(&quot;key&quot;, (void *)k,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                              =
         SIPHASH_KEY_SIZE);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (!EVP_MAC_init(sip-&gt;ctx, NULL, 0, sip-&gt;params))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        crypto_msg(M_FATAL, &quot;EVP_MA=
C_init failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_=
update(sip-&gt;ctx, in, inlen);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    siz=
e_t outl =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
EVP_MAC_final(sip-&gt;ctx, out, &amp;outl, outlen);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib_init=
(size_t hash_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct siphash_=
context *sip;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    AL=
LOC_OBJ(sip, struct siphash_context);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   sip-&gt;mac =3D EVP_MAC_fetch(NULL, &quot;SIPHASH&quot;, NULL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!sip-&gt;mac)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        /* Our OpenSSL library does not =
support SIPHASH */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return sip;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;ctx=
 =3D EVP_MAC_CTX_new(sip-&gt;mac);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* OpenSSL will truly hold a pointer to an int in that parameter */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;size =3D hash_s=
ize;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;par=
ams[0] =3D OSSL_PARAM_construct_size_t(&quot;size&quot;, &amp;sip-&gt;size)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* params[1] w=
ill hold the key that changes which each invocation */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;params[2] =3D OSSL_PARAM_con=
struct_end();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn sip;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+siphash_cryptolib_available(void *sip_context)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct siphash_context *sip =3D sip_context;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return (bool)(sip-&gt;mac);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphas=
h_cryptolib_uninit(void *sip_context)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct siphash_context *sip =3D sip_context;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    EVP_MAC_CTX_free(sip-&gt;ctx);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_free(sip-&gt;mac);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(sip_context=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* for now, we only have one implementation of SIPHASH in a libray, =
so put the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * dummy =
functions also here */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_crypt=
olib(void *sip_context, const void *in, const size_t inlen,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                  const void *k, ui=
nt8_t *out, const size_t outlen)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+siphash_cryptolib_available(void *sip_context)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return false;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib_init(size_t =
hash_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash=
_cryptolib_uninit(void *sip_context)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif /* if defined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; OP=
ENSSL_VERSION_NUMBER &gt;=3D 0x30000000L */</span><br><span>diff --git a/sr=
c/openvpn/siphash_reference=2Ec b/src/openvpn/siphash_reference=2Ec</span><=
br><span>index b21a86e=2E=2Ea06599f 100644</span><br><span>--- a/src/openvp=
n/siphash_reference=2Ec</span><br><span>+++ b/src/openvpn/siphash_reference=
=2Ec</span><br><span>@@ -100,8 +100,8 @@</span><br><span>  *  outlen: lengt=
h of the output in bytes, must be 8 or 16</span><br><span>  */</span><br><s=
pan> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-siphash(const=
 void *in, const size_t inlen, const void *k, uint8_t *out,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        const size_t outlen)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+siphash_reference(const void=
 *in, const size_t inlen, const void *k,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                  uint8_t *out, const size_t outlen)</=
span><br><span> {</span><br><span>     const unsigned char *ni =3D (const u=
nsigned char *)in;</span><br><span>     const unsigned char *kk =3D (const =
unsigned char *)k;</span><br><span>diff --git a/tests/unit_tests/openvpn/Ma=
kefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index =
d861ef9=2E=2E9e1e216 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam<=
/span><br><span>@@ -84,7 +84,9 @@</span><br><span> 	$(top_srcdir)/src/openv=
pn/platform=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/mtu=2Ec \</sp=
an><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/mss=2Ec</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openv=
pn/mss=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_=
srcdir)/src/openvpn/siphash_openssl=2Ec \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec</spa=
n><br><span> </span><br><span> dhcp_testdriver_CFLAGS  =3D -I$(top_srcdir)/=
src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@ -DDHCP_UNIT_TEST</span=
><br><span> dhcp_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/=
openvpn</span><br><span>@@ -97,6 +99,7 @@</span><br><span> </span><br><span=
> ssl_testdriver_CFLAGS  =3D \</span><br><span> 	-I$(top_srcdir)/include -I=
$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	-DPREFER_OPENSSL_SIPHASH \</span><br><s=
pan> 	@TEST_CFLAGS@</span><br><span> ssl_testdriver_LDFLAGS =3D @TEST_LDFLA=
GS@  $(OPTIONAL_CRYPTO_LIBS)</span><br><span> ssl_testdriver_SOURCES =3D te=
st_ssl=2Ec \</span><br><span>diff --git a/tests/unit_tests/openvpn/test_cry=
pto=2Ec b/tests/unit_tests/openvpn/test_crypto=2Ec</span><br><span>index cb=
4eaa2=2E=2Eaad17f7 100644</span><br><span>--- a/tests/unit_tests/openvpn/te=
st_crypto=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_crypto=2E=
c</span><br><span>@@ -31,12 +31,14 @@</span><br><span> #include &lt;stdarg=
=2Eh&gt;</span><br><span> #include &lt;string=2Eh&gt;</span><br><span> #inc=
lude &lt;setjmp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &lt;inttypes=2Eh&gt;</span><br><span> #include &lt;cmocka=2Eh&=
gt;</span><br><span> </span><br><span> #include &quot;crypto=2Eh&quot;</spa=
n><br><span> #include &quot;crypto_epoch=2Eh&quot;</span><br><span> #includ=
e &quot;options=2Eh&quot;</span><br><span> #include &quot;ssl_backend=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
siphash=2Eh&quot;</span><br><span> </span><br><span> #include &quot;mss=2Eh=
&quot;</span><br><span> #include &quot;test_common=2Eh&quot;</span><br><spa=
n>@@ -923,6 +925,59 @@</span><br><span>     assert_memory_equal(key_paramet=
ers=2Ehmac, exp_impl_iv, sizeof(exp_impl_iv));</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Use a de=
fine here since some c compilers don&#39;t like array initialisation</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * with an integer */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define UT_SIPHASH_HASH_=
SIZE 16</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+test_siphash(void **state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const char *message =3D &quot;Look behind you,=
 a Three-Headed Monkey!&quot;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint=
8_t out[UT_SIPHASH_HASH_SIZE] =3D { 0 };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const uint8_t key[SIPHASH_KEY_SIZE] =3D { 0x11, 0x=
22, 0x33, 0x44, 0x55, 0x66 };</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sipha=
sh_reference(message, strlen(message), key, out, UT_SIPHASH_HASH_SIZE);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const uint8_t expected_out[UT_SIPHASH=
_HASH_SIZE] =3D { 0x3e, 0xea, 0x95, 0xb2, 0x6d, 0x5c, 0x4e, 0xfa,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
                            0x20, 0x47, 0x65, 0x7e, 0xdd, 0xcd, 0x62, 0x51 =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory=
_equal(out, expected_out, UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_siphash_ope=
nssl(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    void *sipctx =
=3D siphash_cryptolib_init(UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!siphash_cryptolib_available(sipctx))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        siphash_cryptolib_uninit(sipctx);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        skip();</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const char *message =3D &quot;Look behind you, a Three-Headed M=
onkey!&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t out[UT_SIPHAS=
H_HASH_SIZE] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const uint8_t key[SIPHASH_KEY_SIZE] =3D { 0x11, 0x22, 0x33, 0x44, 0=
x55, 0x66 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const uint8_t expected_out[UT_SIPHASH_HAS=
H_SIZE] =3D { 0x3e, 0xea, 0x95, 0xb2, 0x6d, 0x5c, 0x4e, 0xfa,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
                        0x20, 0x47, 0x65, 0x7e, 0xdd, 0xcd, 0x62, 0x51 };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    siphash_cryptolib(sipctx, message, strlen(message), key=
, out,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
         UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_memory_equal(out, expected_out, UT_SIPHASH_HASH_SIZE=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* check that calling the functi=
on twice is safe */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    siphash_cryptolib(sipctx, message, strlen(message), key, out,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                      UT_SIPH=
ASH_HASH_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_memory_equal(out, expected_out, UT_SIPHASH_HASH_SIZE);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    siphash_cryptolib_uninit(sipctx);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> int</span><br><span> main(void)</span><br><span> {</s=
pan><br><span>@@ -960,7 +1015,9 @@</span><br><span>         cmocka_unit_tes=
t_prestate_setup_teardown(crypto_test_epoch_edge,</span><br><span>         =
                                         crypto_test_epoch_setup,</span><br=
><span>                                                  crypto_test_epoch_=
teardown, &amp;prestate_num13),</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        cmocka_unit_test(epoch_test_derive_data_key)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(epoch_t=
est_derive_data_key),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        cmocka_unit_test(test_siphash),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cmocka_unit_test(test_siphash_openssl)</span>=
<br><span>     };</span><br><span> </span><br><span>     return cmocka_run_=
group_tests_name(&quot;crypto tests&quot;, tests, NULL, NULL);</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/31?usp=3Demail">change 31</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messa=
geType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1=
c1bf7aa0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 31 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 18 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>

</body></html>
--MhbxW9fhPHo=--


--===============2668526237532391113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2668526237532391113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2668526237532391113==--

