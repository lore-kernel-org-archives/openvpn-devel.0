Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB84CDB46F
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BUAFUCpeCEiD6nUGkXGEqHaVt8YW40lRr0liZOPeUfY=; b=HxmeD32b0WSEF+OLn2hFaM3zTJ
	0dMlKY+v1AGvTEf4XwoBYspgiDu8idvHhOR2MODj9NCr4xaMnx4eOkOeFBpmcid5ovsmpMfLME7gv
	bCVORrkFyhEKSpZQjvOAMAclwyzaQavlehqqKOvoaRtnpEVlVZ5DnlSLy8NOphE11ABA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbecp-0000du-6e;
	Mon, 22 Jun 2026 13:23:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbecm-0000dU-KS
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=B0rblFKJvJiejwd2V0plut6CxywImFZeF3UYmTjodtQ=; b=cbb1ImoZgDDQEYP7WDKlhmgFOW
 Tq0zyMyiFLnfkMZkD90xvXhe5Mj7d98+FKCQh5iG3u6oWdXVuzNP3l91lH5uAlJ+FRtaD+i/gWgp0
 Me7fTDXv8S/dyH0qAd54p889ZGDFH7NOq/+2eT/2GlNBhiEUPAGA9X9gNi5WAt9jlqcw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=B0rblFKJvJiejwd2V0plut6CxywImFZeF3UYmTjodtQ=; b=k
 O/1l2pPuuTAeDFC2MTyAmSRFSo0rXmHE7ay+Uxr1K9q6b6021uvxKieAY8T3/PQl8bup8zOIDTZ1b
 CIkCd9ZMAmf4n07fgSKVZsXERZzSFWQ7E6jgkigxMxvYXOU8hwBtgoulrCqdBkx9RKBbu8a9sniLY
 Cy4mX0mM0fkspgJU=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbeci-0000Zh-PA for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:41 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so34401725e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 06:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782134606; x=1782739406; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B0rblFKJvJiejwd2V0plut6CxywImFZeF3UYmTjodtQ=;
 b=WbZOTJOq5oBE2j2kAnXYAjK+r/tC2LvjDLzYvR0qZYWXphWE7Q1lgqRwxmeFh/NBqy
 1aTHc4ldPhTzrVtY7t+cJ+hXpEVf8uNj0/B1mPMreqlqWyfipdQ3x2WH3rdgqiqXT23n
 IQMj4NzWPZSv/ZV4uePsSDik+6dR9TlCqnKi2QFbdSO/bwl9Vuj2ZaqDAFviwbUfuswM
 g9aHN4jS2AWez9md87lH6SLGpeCYaoXK9BQRHIUfn46kxBSGclRBNPL1UElZG4nDqLF8
 ri8HFmnEQilAKQzayU8A4cjFXHXvPuZdLuOKRfUJ1wXVjlAHV9uadOjvrDX6VAuMN96m
 THjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782134606; x=1782739406;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B0rblFKJvJiejwd2V0plut6CxywImFZeF3UYmTjodtQ=;
 b=DVS8Sj1C8tkYXNtFC0ZXYtMBWLkIPG4IiStychDLUUbDadKbXJbFtHCRiuhzo3c8Vy
 PNE9rQNTKOaQy8jGMfcJJhCsnNz7PbH1w/JiVeFh3DrTBmbUwf1aum444w+9z0GAdf5D
 HAQLj+3NprCUkI1cLEN8vMydSkuBdtgjZn1NM0gVRUZg/QnqGuJLD3p2V6zlPcPyrwW5
 L23BjpXy2jW3Kl8sw+tkz72qQBEFA2RffBAhUdbvj4BKwlxIweC6z/4KmB4+sTDD+MER
 OuOnA4WbumOUt0HC7dsN4855o4d/qD31T7KV7BBlpYICgCQIw1lPmXiGg+HTplQtueQR
 QwoQ==
X-Gm-Message-State: AOJu0YwysYRGRTmrgZBs0KPKIFj99PTOo1BP2IExcwzI9gI8/fATaOsB
 UWHHVeKRpJwE5scqOUSMjx2q9q9/7RPfp9GzMtcG6EbxRp/AbpWn8WlwKJ04I3QJOGy7k+qj2dn
 297zG2rV9pngzkpU9o3LD3Lo8JtaeLnI7WQUGDngq52RSI/PoTqMUY7yOxRIO0VNrNlQSJteH0N
 h/q3CHtA==
X-Gm-Gg: AfdE7claB0BjYSAGRInUxILtecVB7KoIdj0pwUwZ7XZcCeNBDNJarCY75EJ2JKdUIOT
 v6LRvu8vW2rBHpG/8PyZlgix6+w9/Lf7+bdaebXCpL0ELIdvDRXusrIJq8xOGfxb2LOkshojquz
 qckgML9DgnxAkPJjkWqVITfF7h/+Rlix4NJrTUt2hzNv3TojW84OvhFaR6rRi9MV0vg0Vlq/o1g
 1Lk11geNxZ5SI0/3jUM9EigXyAxEmtdzNhIF5cpxNis5bav6xieNGwNuK8wJr48q1My1nMnDWiW
 MCKZG9xy/o1w8XNkMhbwT/D/k2F0ECMw186zUgnNcZJjspaTC7rOePFmpAYh6+97T7Wcrbf42vE
 yNu73bwWV6FWIpfL93Q/tT/8C/X+uRwaDCPqprJ2CLikQEJlz3A4ngISJceFmSxUTGjEPngGp3E
 jSull5F/4u2eDG/IA3nQLDz4T6fx8VxIHlgFubxRLK7OjG2o4OiCWY6m9qspFZD8fTTUfHbzw6y
 uMS+UVvNAcxvVKuVoDIozyKDXjmcMkJTBbdbBQge8c5JjVQS7IwlHyfKYPyO9cJN+0duFjl/AZp
 dcw=
X-Received: by 2002:a7b:cc98:0:b0:490:9d1b:f086 with SMTP id
 5b1f17b1804b1-4923f33c6d2mr146315415e9.14.1782134604255; 
 Mon, 22 Jun 2026 06:23:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240f054e3sm300750585e9.2.2026.06.22.06.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:23:23 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 13:23:08 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
X-Gerrit-Change-Number: 31
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/31?usp=email>
X-Gerrit-Commit: e89e56e52799706561d27c108ddb0a2630562b7d
In-Reply-To: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwOWFhMjdjYWExYTNhYWIwZDFiZTYxMThiMjZkNTRhMWMxYmY3YWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d326441bbb0e914ede8a7c01181c49863c380ac9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbeci-0000Zh-PA
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
Content-Type: multipart/mixed; boundary="===============7214159498571438816=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7214159498571438816==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PLMYCnXQPTA="; charset=UTF-8

--PLMYCnXQPTA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/31?usp=3Demail

to look at the new patch set (#14)=
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
 files changed, 270 insertions(+), 11 deletions(-)


  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/31/31/14

diff --git a/CMakeLi=
sts=2Etxt b/CMakeLists=2Etxt
index c18df2b=2E=2E794a4a7 100644
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
index ef61110=2E=2E973596=
b 100644
--- a/src/openvpn/siphash=2Eh
+++ b/src/openvpn/siphash=2Eh
@@ -18=
,12 +18,55 @@
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
+void
+s=
iphash_cryptolib_uninit(void *sip_context);
+
+bool
+siphash_cryptolib_avai=
lable(void *sip_context);
+
+static inline int
+siphash(void *ctx, const vo=
id *in, size_t inlen, const void *k,
+        uint8_t *out, size_t outlen)
=
+{
+    if (siphash_cryptolib_available(ctx) && false)
+    {
+        retu=
rn siphash_cryptolib(ctx, in, inlen, k, out, outlen);
+    }
+    else
+   =
 {
+        return siphash_reference(in, inlen, k, out, outlen);
+    }
+}
=
+
+#endif /* ifndef SIPHASH_H */
\ No newline at end of file
diff --git a/s=
rc/openvpn/siphash_openssl=2Ec b/src/openvpn/siphash_openssl=2Ec
new file m=
ode 100644
index 0000000=2E=2Ebb42a38
--- /dev/null
+++ b/src/openvpn/sipha=
sh_openssl=2Ec
@@ -0,0 +1,150 @@
+/*
+ *  OpenVPN -- An application to secu=
rely tunnel IP networks
+ *             over a single TCP/UDP port, with su=
pport for SSL/TLS-based
+ *             session authentication and key exch=
ange,
+ *             packet encryption, packet authentication, and
+ *    =
         packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc=
 <sales@openvpn=2Enet>
+ *  Copyright (C) 2026 Arne Schwabe <arne@rfc2549=
=2Eorg>
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
+#elif defined(_MSC_VER)
+#include "config-msvc=2Eh"
+#endif
+
+#incl=
ude "syshead=2Eh"
+
+#include "siphash=2Eh"
+#include "buffer=2Eh"
+
+
+#if=
def ENABLE_CRYPTO_OPENSSL
+#include <openssl/opensslv=2Eh>
+#endif
+
+/* Op=
enSSL siphash is currently 2-3 times slower than the reference
+ * implemen=
tation, so only enable it when PREFER_OPENSSL_SIPHASH is defined
+ * for no=
w */
+#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >=3D 0x3=
0000000L && defined(PREFER_OPENSSL_SIPHASH)
+#include <openssl/evp=2Eh>
+#i=
nclude "crypto_openssl=2Eh"
+
+struct siphash_context
+{
+    EVP_MAC *mac;=

+    EVP_MAC_CTX *ctx;
+    size_t size;
+    OSSL_PARAM params[3];
+};
+
=
+/*
+ *  Computes a SipHash value
+ * in: pointer to input data (read-only)=

+ *  inlen: input data length in bytes (any size_t value)
+ * k: pointer t=
o the key data (read-only), must be 16 bytes
+ * out: pointer to output dat=
a (write-only), outlen bytes must be allocated
+ *  outlen: length of the o=
utput in bytes, must be 8 or 16
+ */
+int
+siphash_cryptolib(void *sip_cont=
ext, const void *in, const size_t inlen,
+                  const void *k, =
uint8_t *out, const size_t outlen)
+{
+    struct siphash_context *sip =3D =
sip_context;
+
+
+    sip->params[1] =3D OSSL_PARAM_construct_octet_string(=
"key", (void *)k,
+                                                       S=
IPHASH_KEY_SIZE);
+    if (!EVP_MAC_init(sip->ctx, NULL, 0, sip->params))
+=
    {
+        crypto_msg(M_FATAL, "EVP_MAC_init failed");
+    }
+    EVP_=
MAC_update(sip->ctx, in, inlen);
+
+    size_t outl =3D 0;
+    EVP_MAC_fin=
al(sip->ctx, out, &outl, outlen);
+    return 0;
+}
+
+void *
+siphash_cryp=
tolib_init(size_t hash_size)
+{
+    struct siphash_context *sip;
+    ALLO=
C_OBJ(sip, struct siphash_context);
+
+    sip->mac =3D EVP_MAC_fetch(NULL,=
 "SIPHASH", NULL);
+    if (!sip->mac)
+    {
+        /* Our OpenSSL libra=
ry does not support SIPHASH */
+        return sip;
+    }
+    sip->ctx =
=3D EVP_MAC_CTX_new(sip->mac);
+
+    /* OpenSSL will truly hold a pointer =
to an int in that parameter */
+    sip->size =3D hash_size;
+    sip->para=
ms[0] =3D OSSL_PARAM_construct_size_t("size", &sip->size);
+    /* params[1=
] will hold the key that changes which each invocation */
+    sip->params[=
2] =3D OSSL_PARAM_construct_end();
+    return sip;
+}
+
+bool
+siphash_cry=
ptolib_available(void *sip_context)
+{
+    struct siphash_context *sip =3D=
 sip_context;
+
+    return (bool)(sip->mac);
+}
+
+void
+siphash_cryptolib=
_uninit(void *sip_context)
+{
+    struct siphash_context *sip =3D sip_cont=
ext;
+    EVP_MAC_CTX_free(sip->ctx);
+    EVP_MAC_free(sip->mac);
+    fre=
e(sip_context);
+}
+
+#else
+/* for now, we only have one implementation of=
 SIPHASH in a libray, so put the
+ * dummy functions also here */
+int
+sip=
hash_cryptolib(void *sip_context, const void *in, const size_t inlen,
+    =
              const void *k, uint8_t *out, const size_t outlen)
+{
+    ret=
urn -1;
+}
+
+bool
+siphash_cryptolib_available(void *sip_context)
+{
+    =
return false;
+}
+
+void *
+siphash_cryptolib_init(size_t hash_size)
+{
+  =
  return NULL;
+}
+
+void
+siphash_cryptolib_uninit(void *sip_context)
+{
+=
}
+
+
+#endif /* if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBE=
R >=3D 0x30000000L */
diff --git a/src/openvpn/siphash_reference=2Ec b/src/=
openvpn/siphash_reference=2Ec
index b21a86e=2E=2Ea06599f 100644
--- a/src/o=
penvpn/siphash_reference=2Ec
+++ b/src/openvpn/siphash_reference=2Ec
@@ -10=
0,8 +100,8 @@
  *  outlen: length of the output in bytes, must be 8 or 16
 =
 */
 int
-siphash(const void *in, const size_t inlen, const void *k, uint8_=
t *out,
-        const size_t outlen)
+siphash_reference(const void *in, co=
nst size_t inlen, const void *k,
+                  uint8_t *out, const siz=
e_t outlen)
 {
     const unsigned char *ni =3D (const unsigned char *)in;
=
     const unsigned char *kk =3D (const unsigned char *)k;
diff --git a/tes=
ts/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Ea=
m
index 1128eb4=2E=2E4ed113a 100644
--- a/tests/unit_tests/openvpn/Makefile=
=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -84,7 +84,9 @@
 	$(to=
p_srcdir)/src/openvpn/platform=2Ec \
 	$(top_srcdir)/src/openvpn/mtu=2Ec \
=
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
-	$(top_srcdir)/src/openvpn/ms=
s=2Ec
+	$(top_srcdir)/src/openvpn/mss=2Ec \
+	$(top_srcdir)/src/openvpn/sip=
hash_openssl=2Ec \
+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec
 
 dhc=
p_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/co=
mpat @TEST_CFLAGS@ -DDHCP_UNIT_TEST
 dhcp_testdriver_LDFLAGS =3D @TEST_LDFL=
AGS@ -L$(top_srcdir)/src/openvpn
@@ -97,6 +99,7 @@
 
 ssl_testdriver_CFLAGS=
  =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir=
)/src/openvpn \
+	-DPREFER_OPENSSL_SIPHASH \
 	@TEST_CFLAGS@
 ssl_testdrive=
r_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
 ssl_testdriver_SOURC=
ES =3D test_ssl=2Ec \
diff --git a/tests/unit_tests/openvpn/test_crypto=2Ec=
 b/tests/unit_tests/openvpn/test_crypto=2Ec
index cb4eaa2=2E=2Ee528f26 1006=
44
--- a/tests/unit_tests/openvpn/test_crypto=2Ec
+++ b/tests/unit_tests/op=
envpn/test_crypto=2Ec
@@ -31,12 +31,14 @@
 #include <stdarg=2Eh>
 #include =
<string=2Eh>
 #include <setjmp=2Eh>
+#include <inttypes=2Eh>
 #include <cmo=
cka=2Eh>
 
 #include "crypto=2Eh"
 #include "crypto_epoch=2Eh"
 #include "o=
ptions=2Eh"
 #include "ssl_backend=2Eh"
+#include "siphash=2Eh"
 
 #include=
 "mss=2Eh"
 #include "test_common=2Eh"
@@ -923,6 +925,59 @@
     assert_mem=
ory_equal(key_parameters=2Ehmac, exp_impl_iv, sizeof(exp_impl_iv));
 }
 
+/=
* Use a define here since some c compilers don't like array initialisation
=
+ * with an integer */
+#define UT_SIPHASH_HASH_SIZE 16
+
+static void
+tes=
t_siphash(void **state)
+{
+    const char *message =3D "Look behind you, a=
 Three-Headed Monkey!";
+
+    uint8_t out[UT_SIPHASH_HASH_SIZE] =3D { 0 };=

+    const uint8_t key[SIPHASH_KEY_SIZE] =3D { 0x11, 0x22, 0x33, 0x44, 0x5=
5, 0x66 };
+
+    siphash_reference(message, strlen(message), key, out, UT_=
SIPHASH_HASH_SIZE);
+
+    const uint8_t expected_out[UT_SIPHASH_HASH_SIZE]=
 =3D { 0x3e, 0xea, 0x95, 0xb2, 0x6d, 0x5c, 0x4e, 0xfa,
+                   =
                                      0x20, 0x47, 0x65, 0x7e, 0xdd, 0xcd, 0=
x62, 0x51 };
+    assert_memory_equal(out, expected_out, UT_SIPHASH_HASH_SI=
ZE);
+}
+
+static void
+test_siphash_openssl(void **state)
+{
+    void *si=
pctx =3D siphash_cryptolib_init(UT_SIPHASH_HASH_SIZE);
+
+    if (!siphash_=
cryptolib_available(sipctx))
+    {
+        siphash_cryptolib_uninit(sipct=
x);
+        skip();
+    }
+
+    const char *message =3D "Look behind you=
, a Three-Headed Monkey!";
+
+    uint8_t out[UT_SIPHASH_HASH_SIZE] =3D { 0=
 };
+    const uint8_t key[SIPHASH_KEY_SIZE] =3D { 0x11, 0x22, 0x33, 0x44, =
0x55, 0x66 };
+
+
+    const uint8_t expected_out[UT_SIPHASH_HASH_SIZE] =3D=
 { 0x3e, 0xea, 0x95, 0xb2, 0x6d, 0x5c, 0x4e, 0xfa,
+                       =
                                  0x20, 0x47, 0x65, 0x7e, 0xdd, 0xcd, 0x62,=
 0x51 };
+
+
+    siphash_cryptolib(sipctx, message, strlen(message), key, =
out,
+                      UT_SIPHASH_HASH_SIZE);
+    assert_memory_equal=
(out, expected_out, UT_SIPHASH_HASH_SIZE);
+
+    /* check that calling the=
 function twice is safe */
+    siphash_cryptolib(sipctx, message, strlen(m=
essage), key, out,
+                      UT_SIPHASH_HASH_SIZE);
+    asser=
t_memory_equal(out, expected_out, UT_SIPHASH_HASH_SIZE);
+
+    siphash_cry=
ptolib_uninit(sipctx);
+}
+
+
 int
 main(void)
 {
@@ -957,10 +1012,9 @@
   =
      cmocka_unit_test_prestate_setup_teardown(crypto_test_epoch_key_overfl=
ow,
                                                  crypto_test_epoch_set=
up,
                                                  crypto_test_epoch_tea=
rdown, &prestate_num32),
-        cmocka_unit_test_prestate_setup_teardown(=
crypto_test_epoch_edge,
-                                                 c=
rypto_test_epoch_setup,
-                                                 c=
rypto_test_epoch_teardown, &prestate_num13),
-        cmocka_unit_test(epoc=
h_test_derive_data_key)
+        cmocka_unit_test(epoch_test_derive_data_ke=
y),
+        cmocka_unit_test(test_siphash),
+        cmocka_unit_test(test=
_siphash_openssl)
     };
 
     return cmocka_run_group_tests_name("crypto=
 tests", tests, NULL, NULL);

-- 
To view, visit http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/31?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
Gerrit-Change-Number: 3=
1
Gerrit-PatchSet: 14
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenh=
eld <frank@lichtenheld=2Ecom>

--PLMYCnXQPTA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #14</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
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
penvpn/test_crypto=2Ec<br>7 files changed, 270 insertions(+), 11 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/31/31/14</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeL=
ists=2Etxt</span><br><span>index c18df2b=2E=2E794a4a7 100644</span><br><spa=
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
/siphash=2Eh b/src/openvpn/siphash=2Eh</span><br><span>index ef61110=2E=2E9=
73596b 100644</span><br><span>--- a/src/openvpn/siphash=2Eh</span><br><span=
>+++ b/src/openvpn/siphash=2Eh</span><br><span>@@ -18,12 +18,55 @@</span><b=
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
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib_uninit(v=
oid *sip_context);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib_available(void *s=
ip_context);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static inline int</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+siphash(void *ctx, const voi=
d *in, size_t inlen, const void *k,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        uint8_t *out, size_t outlen)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (siphash_cryptolib_available(ctx) &amp;&amp; false)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return siphash_cryptolib(c=
tx, in, inlen, k, out, outlen);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return siphash_refe=
rence(in, inlen, k, out, outlen);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef SIPHASH_H */</span><=
br><span>\ No newline at end of file</span><br><span>diff --git a/src/openv=
pn/siphash_openssl=2Ec b/src/openvpn/siphash_openssl=2Ec</span><br><span>ne=
w file mode 100644</span><br><span>index 0000000=2E=2Ebb42a38</span><br><sp=
an>--- /dev/null</span><br><span>+++ b/src/openvpn/siphash_openssl=2Ec</spa=
n><br><span>@@ -0,0 +1,150 @@</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Ope=
nVPN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port=
, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             session authentication and key exchange,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encr=
yption, packet authentication, and</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet compression=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=
=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyr=
ight (C) 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=
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
40%);">+#elif defined(_MSC_VER)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;config-msvc=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;siphash=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_CRYPTO_O=
PENSSL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;=
openssl/opensslv=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* OpenSSL siphash is curre=
ntly 2-3 times slower than the reference</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * implementation, so only enable it when PREFER_OPENS=
SL_SIPHASH is defined</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * for now */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
defined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; OPENSSL_VERSION_NUMBER &gt;=3D 0x=
30000000L &amp;&amp; defined(PREFER_OPENSSL_SIPHASH)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;openssl/evp=2Eh&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto_openss=
l=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+struct siphash_context</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC *mac;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_CTX *ctx;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    size_t size;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OSSL_PARAM params[3];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Computes =
a SipHash value</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * i=
n: pointer to input data (read-only)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  inlen: input data length in bytes (any size_t value)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * k: pointer to the =
key data (read-only), must be 16 bytes</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * out: pointer to output data (write-only), outlen byte=
s must be allocated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  outlen: length of the output in bytes, must be 8 or 16</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+siphash_cryptolib(void *sip_context, const void *in, const size_t in=
len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
   const void *k, uint8_t *out, const size_t outlen)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct siphash_context *sip =3D sip_context;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    sip-&gt;params[1] =3D OSSL_PARAM_construct_octet_string(&quot;ke=
y&quot;, (void *)k,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                                       SIPHASH_KEY_SIZE);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!EVP_MAC_init=
(sip-&gt;ctx, NULL, 0, sip-&gt;params))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        crypto_msg(M_FATAL, &quot;EVP_MAC_init failed&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_update(sip-&gt;ctx, in, inlen=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    size_t outl =3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_final(sip-&gt;ctx, ou=
t, &amp;outl, outlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+siphash_cryptolib_init(size_t hash_size)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct siphash_context *sip;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ(sip, struct siphash_con=
text);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;mac =3D EVP_MAC_fetc=
h(NULL, &quot;SIPHASH&quot;, NULL);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!sip-&gt;mac)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /* Our OpenSSL library does not support SIPHASH */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return sip;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    sip-&gt;ctx =3D EVP_MAC_CTX_new(sip-&gt;ma=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* OpenSSL will truly hold a po=
inter to an int in that parameter */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    sip-&gt;size =3D hash_size;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    sip-&gt;params[0] =3D OSSL_PARAM_construct=
_size_t(&quot;size&quot;, &amp;sip-&gt;size);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* params[1] will hold the key that changes w=
hich each invocation */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    sip-&gt;params[2] =3D OSSL_PARAM_construct_end();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return sip;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib_=
available(void *sip_context)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t siphash_context *sip =3D sip_context;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return (bool)(sip-&gt;mac);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib_uninit(void *sip_cont=
ext)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct siphash_context *sip =
=3D sip_context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 EVP_MAC_CTX_free(sip-&gt;ctx);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    EVP_MAC_free(sip-&gt;mac);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    free(sip_context);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* for now, we only have =
one implementation of SIPHASH in a libray, so put the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * dummy functions also here */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+siphash_cryptolib(void *sip_context, const vo=
id *in, const size_t inlen,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                  const void *k, uint8_t *out, const size_t outlen)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return -1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib_=
available(void *sip_context)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+siphash_cryptolib_init(size_t hash_size)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib_uninit(void *sip_con=
text)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if =
defined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; OPENSSL_VERSION_NUMBER &gt;=3D 0x=
30000000L */</span><br><span>diff --git a/src/openvpn/siphash_reference=2Ec=
 b/src/openvpn/siphash_reference=2Ec</span><br><span>index b21a86e=2E=2Ea06=
599f 100644</span><br><span>--- a/src/openvpn/siphash_reference=2Ec</span><=
br><span>+++ b/src/openvpn/siphash_reference=2Ec</span><br><span>@@ -100,8 =
+100,8 @@</span><br><span>  *  outlen: length of the output in bytes, must =
be 8 or 16</span><br><span>  */</span><br><span> int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-siphash(const void *in, const size_t inlen,=
 const void *k, uint8_t *out,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        const size_t outlen)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+siphash_reference(const void *in, const size_t inlen, cons=
t void *k,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
         uint8_t *out, const size_t outlen)</span><br><span> {</span><br><s=
pan>     const unsigned char *ni =3D (const unsigned char *)in;</span><br><=
span>     const unsigned char *kk =3D (const unsigned char *)k;</span><br><=
span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests=
/openvpn/Makefile=2Eam</span><br><span>index 1128eb4=2E=2E4ed113a 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>=
+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -84,7 +84,9=
 @@</span><br><span> 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><s=
pan> 	$(top_srcdir)/src/openvpn/mtu=2Ec \</span><br><span> 	$(top_srcdir)/s=
rc/openvpn/win32-util=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	$(top_srcdir)/src/openvpn/mss=2Ec</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/mss=2Ec \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash_op=
enssl=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_s=
rcdir)/src/openvpn/siphash_reference=2Ec</span><br><span> </span><br><span>=
 dhcp_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/sr=
c/compat @TEST_CFLAGS@ -DDHCP_UNIT_TEST</span><br><span> dhcp_testdriver_LD=
FLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn</span><br><span>@@ -97=
,6 +99,7 @@</span><br><span> </span><br><span> ssl_testdriver_CFLAGS  =3D \=
</span><br><span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(t=
op_srcdir)/src/openvpn \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	-DPREFER_OPENSSL_SIPHASH \</span><br><span> 	@TEST_CFLAGS@</span><br>=
<span> ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)</=
span><br><span> ssl_testdriver_SOURCES =3D test_ssl=2Ec \</span><br><span>d=
iff --git a/tests/unit_tests/openvpn/test_crypto=2Ec b/tests/unit_tests/ope=
nvpn/test_crypto=2Ec</span><br><span>index cb4eaa2=2E=2Ee528f26 100644</spa=
n><br><span>--- a/tests/unit_tests/openvpn/test_crypto=2Ec</span><br><span>=
+++ b/tests/unit_tests/openvpn/test_crypto=2Ec</span><br><span>@@ -31,12 +3=
1,14 @@</span><br><span> #include &lt;stdarg=2Eh&gt;</span><br><span> #incl=
ude &lt;string=2Eh&gt;</span><br><span> #include &lt;setjmp=2Eh&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;inttypes=2Eh&g=
t;</span><br><span> #include &lt;cmocka=2Eh&gt;</span><br><span> </span><br=
><span> #include &quot;crypto=2Eh&quot;</span><br><span> #include &quot;cry=
pto_epoch=2Eh&quot;</span><br><span> #include &quot;options=2Eh&quot;</span=
><br><span> #include &quot;ssl_backend=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&quot;</span><br><sp=
an> </span><br><span> #include &quot;mss=2Eh&quot;</span><br><span> #includ=
e &quot;test_common=2Eh&quot;</span><br><span>@@ -923,6 +925,59 @@</span><b=
r><span>     assert_memory_equal(key_parameters=2Ehmac, exp_impl_iv, sizeof=
(exp_impl_iv));</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Use a define here since some c compile=
rs don&#39;t like array initialisation</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * with an integer */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define UT_SIPHASH_HASH_SIZE 16</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+test_siphash(void **state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const char *message =3D &quot;Look behind you, a Three-Headed Monkey!&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    uint8_t out[UT_SIPHASH_HASH_SIZE]=
 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t uint8_t key[SIPHASH_KEY_SIZE] =3D { 0x11, 0x22, 0x33, 0x44, 0x55, 0x66 };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    siphash_reference(message, strlen(=
message), key, out, UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const uint8_t expected_out[UT_SIPHASH_HASH_SIZE] =3D { 0x3e, 0xea, =
0x95, 0xb2, 0x6d, 0x5c, 0x4e, 0xfa,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                                         0x=
20, 0x47, 0x65, 0x7e, 0xdd, 0xcd, 0x62, 0x51 };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_memory_equal(out, expected_out, UT_S=
IPHASH_HASH_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+test_siphash_openssl(void **state)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    void *sipctx =3D siphash_cryptolib_init(UT_SI=
PHASH_HASH_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!siphash_cryp=
tolib_available(sipctx))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
iphash_cryptolib_uninit(sipctx);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        skip();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *message =
=3D &quot;Look behind you, a Three-Headed Monkey!&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    uint8_t out[UT_SIPHASH_HASH_SIZE] =3D { 0 };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t key[SIPHAS=
H_KEY_SIZE] =3D { 0x11, 0x22, 0x33, 0x44, 0x55, 0x66 };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const uint8_t expected_out[UT_SIPHASH_HASH_SIZE] =3D { 0x3e, 0xea, 0x95, =
0xb2, 0x6d, 0x5c, 0x4e, 0xfa,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                                         0x20, 0x=
47, 0x65, 0x7e, 0xdd, 0xcd, 0x62, 0x51 };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    siphash_cryp=
tolib(sipctx, message, strlen(message), key, out,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                      UT_SIPHASH_HASH_SIZE);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_eq=
ual(out, expected_out, UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* check that calling the function twice is safe */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    siphash_cryptolib(sipctx, me=
ssage, strlen(message), key, out,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                      UT_SIPHASH_HASH_SIZE);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(out, expecte=
d_out, UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sipha=
sh_cryptolib_uninit(sipctx);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span>=
<br><span> main(void)</span><br><span> {</span><br><span>@@ -957,10 +1012,9=
 @@</span><br><span>         cmocka_unit_test_prestate_setup_teardown(crypt=
o_test_epoch_key_overflow,</span><br><span>                                =
                  crypto_test_epoch_setup,</span><br><span>                =
                                  crypto_test_epoch_teardown, &amp;prestate=
_num32),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cmock=
a_unit_test_prestate_setup_teardown(crypto_test_epoch_edge,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                     =
            crypto_test_epoch_setup,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                                                 crypto_test=
_epoch_teardown, &amp;prestate_num13),</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        cmocka_unit_test(epoch_test_derive_data_key)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(=
epoch_test_derive_data_key),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_siphash),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_siphash_openssl)=
</span><br><span>     };</span><br><span> </span><br><span>     return cmoc=
ka_run_group_tests_name(&quot;crypto tests&quot;, tests, NULL, NULL);</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/31?usp=3Demail">change 31</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-=
MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26=
d54a1c1bf7aa0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 31 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 14 </div>
<div style=
=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>

</body></html>
--PLMYCnXQPTA=--


--===============7214159498571438816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7214159498571438816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7214159498571438816==--

