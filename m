Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74B4C55174
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 06:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pwmdYWQy1a7WpYj2Jcl48XKjHVOgl4l/JqmBCqyC3sM=; b=StCEHS/EfduRwwcKi0LItoKjrC
	hKxX/9bxev0UinNjpMD12/tLYLCz/B1yGWCtyrk1xfhP4vPLZoz2B+9Kq6QN/W87IncCrgCXBwXUy
	zgLnUYu99e0SWTr0VYbFQw/nsbmen/IKAPoSHG6ZF9jNqxsvbnRSJ1IqozYzb/yZnGZo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsan6-0004FY-8V;
	Sat, 08 Aug 2026 06:44:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsan5-0004FO-En
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 06:44:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=s6uhHYWBAiTfGccf4o5NcgpLtLzs9XMxlmpTP+LKEbo=; b=eeiqbYxwxo6L3ff1lIY2NQyRjf
 o/laZ0QYso+End56ht8S6D2o++CflGZ8QPxGqNdE95XkfXQV8E6aK1qq3/r0eZy4VOeWwa5RmwyCa
 OYBfd5X4GUj0vtEydyFJf7a2I3PFklhjnrf7NETyXuFyFMvP0LpibXM/cwAubr0YdErg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=s6uhHYWBAiTfGccf4o5NcgpLtLzs9XMxlmpTP+LKEbo=; b=b
 RfP4mfnTeJnKzKHKVHksuEHEuwGoDrB0sghH43LHxt5h6RqWdrhVQdJdZltxzzY2XsCVY77cK0OJb
 ZBm+oh41Zq/JRo/BDfd4JYVJpkZrrzpQfg9hQtXyUoW63socGUo16XkemRyON+FhaL0d/1N9qrIGF
 BnXw3BIrBdrskYfk=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsan3-0006oI-4o for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 06:44:19 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso101141f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 23:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786171450; x=1786776250; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=s6uhHYWBAiTfGccf4o5NcgpLtLzs9XMxlmpTP+LKEbo=;
 b=RNyA2hOHshszFNdGQedK5fhgfIux0xWXZnV9VK9YxFHPQEo0NEWoyynQMrmo+f3qeZ
 v6Q+z3WKtwWCVUyCCFhqhJ0m0jiji7OPjPwpYPPyN4XvzcxV62+OqSDvyv8UUcoyCZ4m
 loUYOLzIn/sEKLDBYPqdXi/88p3PIjm5mxavwaNDbv6V1qmi/m2PrnzHf7htDmcb3XOC
 riLR3sh0Gt+EqE3oGyFuEW/n01HSFGvFDLByU0bEPssYs1+WZL4lQH7gdEXQAcGOux0P
 ngG00vgnKIoakFmrOO0467RSZMBz0q08/2AcudnYNNLdGnbVNPrunWdicWTO88CviPZ1
 p6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786171450; x=1786776250;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=s6uhHYWBAiTfGccf4o5NcgpLtLzs9XMxlmpTP+LKEbo=;
 b=pEZGBLB6ZaW+CN84X062udByBMbHfAzZcSo98emCkHAXf/WUdr5dk14PQ5CzwJacGg
 GPx8Wxcj7l9Tn63N0vclOvj7+96sU9sOk9RV7trbo5zYA+GWPex4DDj6UcTcd6rvWuzr
 JvZ4CNrNAjzJBi8XDtZa7qwg91dEiNoYOh0Ddp7kYGhASNMGfx1CVEhfGWGZoXXfZsai
 TRQ9MgWDL13W513QY8l9EOZJgStQUSW1To6oknHUSbpzRw2wdjZxr1DplHtaZIWmr8Kl
 3Bfatp5l6NsSkS5KXX4jW63gn6wfLjSVekzQu49YOrXaa3O6S7cU4/zv9L32dxPNcDNN
 vK+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqDXklt9q7msLGEOq9WfVSkE5MSHhrsBGB3u5s+iVn+FpqG3EYG8P+yUS4XesqMHPcL4xPCnrceIjxGi01@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz14MrWoESwKoRicNJnBJIyo7xyMpleWDUPJEzD27LqOJZsLrab
 p89T8Sknlnalyq6NRwmK6PmQlWPovnAGX2Fn8kTS8NnjQEc5HbOYPld1qxv/e/QyVyyV4acSA6w
 m5G498RFBrQGyqLn16T3JTWccRhPSxR/Jrpu8tTwTd2ZXB8aLzx193oymn/q1gDoQXCXR
X-Gm-Gg: AR+sD133SbzHPBY0LKLtnhFKcjdCO+krls0D+QQVtf7W9YPfnffwovQlgP6gGwSIfV1
 u8Z0z9uB1CR/weRHtoOJzc7sG7SCoNi7Fe6dIZ/poNutzGu3SbNcV8YgeI82tAIf75g7z3C768I
 c9XQP1vzQUbmEF1+2rcMZzdPhat8A9xpX8yYATyMCh5h7IGkx5wz8hHVmOb59uk0Evtk5or8L22
 68dCEuNlKFRKvC/VcZKb5nIi3jk1GPQ72bjg2KjdGQ3kEh2S7xAxaaoFLDxVZVrPYYlZEucOCEE
 LU5UhhiPkhZeCFRnA8UhCaYQWVdC+MvXBbi2kdH/7TAqeROkJbFy8TSVKFW5pOyKUhfpou/tlzt
 f45TRuVo1Oi23nsXpQ8paXCBUowEeTyVLbt76pdvrhczGYs/e97YFW9QXPv7BpZM8EhPjp1z5O7
 0kgaDm6kDsGaH4mAXw1CyovKUmazNtEDQLlxnkYVxygNwq/59O0vrFi11zqwzX0QSQzu5zGqn0d
 Il4jmPJ+Ge9MAunwzAUq3FOjCTR/DHFI3LPMAvkg9K7Vzj+9N1DQw/SCfvY0UzGvaH8K8hTEk6U
 3aj8NbyMILxwgsJv02pvc8eHFMZfeC1mbs3YkBMQb1ctU32eazs=
X-Received: by 2002:a05:6000:298e:20b0:47f:7c4c:8144 with SMTP id
 ffacd0b85a97d-48130e9564fmr4532928f8f.10.1786171450334; 
 Fri, 07 Aug 2026 23:44:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48002145679sm11864460f8f.3.2026.08.07.23.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 23:44:09 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 8 Aug 2026 06:44:09 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 31
X-Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
X-Gerrit-Change-Number: 31
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/31?usp=email>
X-Gerrit-Commit: f129a7807408b1cb2975e47e99f594c587ba4576
In-Reply-To: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwOWFhMjdjYWExYTNhYWIwZDFiZTYxMThiMjZkNTRhMWMxYmY3YWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5d427ddbde81b99c3684076369221171ffeeb9bb-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsan3-0006oI-4o
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Use OpenSSL's
 SIPHASH implementation to double check our implementation
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0557043600205324713=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0557043600205324713==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FWTSqfcS90k="; charset=UTF-8

--FWTSqfcS90k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/31?usp=3Demail )

Change subject: Use OpenSSL's SIPHASH implementation =
to double check our implementation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Use OpenSSL's SIPHASH implementation to double check=
 our implementation

OpenSSL library is currently slower than the reference=
 implementation
(about 1=2E5x to 2x depending of the compiler)=2E

The Open=
SSL API for using the SIPHASH MAC is different enough from using
normal HMA=
C or Digest that we already implement that combining them into
one API does=
 not make sense=2E

SIPHASH is only available on OpenSSL 3=2E1 and later=2E=
 We still check for
support on 3=2E0 and later as the whole API to allow us=
ing the SIPHASH alrady
exists in OpenSSL 3=2E0=2E Some of the later OpenSSL=
 3=2E0=2Ex might get support
for it=2E Theoretically, a provider can be loa=
ded in OpenSSL 3=2E0 that
implements SIPHASH=2E

With OpenSSL's implementat=
ion being slower, we currently only use it to
check that our reference impl=
ementation and the OpenSSL implementation
yield the same result in unit tes=
ts

Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
Signed-off-by: Arn=
e Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31
Message=
-Id: <20260806153230=2E65971-1-frank@lichtenheld=2Ecom>
URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38180=2Ehtml
=
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=2Etx=
t
M src/openvpn/Makefile=2Eam
M src/openvpn/siphash=2Eh
M src/openvpn/sipha=
sh_reference=2Ec
M tests/unit_tests/openvpn/Makefile=2Eam
A tests/unit_test=
s/openvpn/siphash_openssl=2Ec
A tests/unit_tests/openvpn/siphash_openssl=2E=
h
M tests/unit_tests/openvpn/test_crypto=2Ec
8 files changed, 305 insertion=
s(+), 8 deletions(-)




diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
i=
ndex 74c080e=2E=2E3ff2734 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2E=
txt
@@ -572,6 +572,8 @@
     src/openvpn/shaper=2Eh
     src/openvpn/sig=2E=
c
     src/openvpn/sig=2Eh
+    src/openvpn/siphash=2Eh
+    src/openvpn/si=
phash_reference=2Ec
     src/openvpn/socket=2Ec
     src/openvpn/socket=2Eh=

     src/openvpn/socket_util=2Ec
@@ -784,6 +786,7 @@
         )
 
     tar=
get_sources(test_crypto PRIVATE
+        tests/unit_tests/openvpn/siphash_o=
penssl=2Ec
         src/openvpn/crypto_mbedtls=2Ec
         src/openvpn/cry=
pto_openssl=2Ec
         src/openvpn/crypto_epoch=2Ec
@@ -792,6 +795,7 @@
 =
        src/openvpn/packet_id=2Ec
         src/openvpn/mtu=2Ec
         src=
/openvpn/mss=2Ec
+        src/openvpn/siphash_reference=2Ec
         )
 
  =
   target_sources(test_ssl PRIVATE
diff --git a/src/openvpn/Makefile=2Eam b=
/src/openvpn/Makefile=2Eam
index ff8cc54=2E=2E1f77384 100644
--- a/src/open=
vpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -128,6 +128,7 @@
 	ses=
sion_id=2Ec session_id=2Eh \
 	shaper=2Ec shaper=2Eh \
 	sig=2Ec sig=2Eh \
=
+	siphash_reference=2Ec siphash=2Eh \
 	socket=2Ec socket=2Eh \
 	socket_ut=
il=2Ec socket_util=2Eh \
 	socks=2Ec socks=2Eh \
diff --git a/src/openvpn/s=
iphash=2Eh b/src/openvpn/siphash=2Eh
index ef61110=2E=2Ebddddc3 100644
--- =
a/src/openvpn/siphash=2Eh
+++ b/src/openvpn/siphash=2Eh
@@ -18,12 +18,26 @@=

 #ifndef SIPHASH_H
 #define SIPHASH_H
 
-#include <inttypes=2Eh>
+#include=
 <stdint=2Eh>
+#include <stdio=2Eh>
+#include <stdbool=2Eh>
 
 /* siphash a=
lways uses 128-bit keys */
 #define SIPHASH_KEY_SIZE 16
 
-int siphash(cons=
t void *in, size_t inlen, const void *k, uint8_t *out,
-            size_t =
outlen);
+/**
+ * Calculates SIPHASH using the reference implementation
+ *=
/
+int
+siphash_reference(const void *in, size_t inlen, const void *k,
+   =
               uint8_t *out, size_t outlen);
 
-#endif
+
+static inline int=

+siphash(const void *in, size_t inlen, const void *k,
+        uint8_t *ou=
t, size_t outlen)
+{
+    return siphash_reference(in, inlen, k, out, outle=
n);
+}
+
+#endif /* ifndef SIPHASH_H */
\ No newline at end of file
diff --=
git a/src/openvpn/siphash_reference=2Ec b/src/openvpn/siphash_reference=2Ec=

index b21a86e=2E=2Ead19a51 100644
--- a/src/openvpn/siphash_reference=2Ec
=
+++ b/src/openvpn/siphash_reference=2Ec
@@ -100,8 +100,8 @@
  *  outlen: le=
ngth of the output in bytes, must be 8 or 16
  */
 int
-siphash(const void =
*in, const size_t inlen, const void *k, uint8_t *out,
-        const size_t=
 outlen)
+siphash_reference(const void *in, const size_t inlen, const void =
*k, uint8_t *out,
+                  const size_t outlen)
 {
     const uns=
igned char *ni =3D (const unsigned char *)in;
     const unsigned char *kk =
=3D (const unsigned char *)k;
diff --git a/tests/unit_tests/openvpn/Makefil=
e=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 4a76269=2E=2E9174ed0 =
100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/=
openvpn/Makefile=2Eam
@@ -73,6 +73,7 @@
 crypto_testdriver_LDFLAGS =3D @TES=
T_LDFLAGS@
 crypto_testdriver_SOURCES =3D test_crypto=2Ec \
 	mock_msg=2Ec =
mock_msg=2Eh test_common=2Eh \
+	siphash_openssl=2Ec siphash_openssl=2Eh \
=
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=
=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \
@@ -84,7 +85,8 @@
 =
	$(top_srcdir)/src/openvpn/platform=2Ec \
 	$(top_srcdir)/src/openvpn/mtu=
=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
-	$(top_srcdir)/src/ope=
nvpn/mss=2Ec
+	$(top_srcdir)/src/openvpn/mss=2Ec \
+	$(top_srcdir)/src/open=
vpn/siphash_reference=2Ec
 
 dhcp_testdriver_CFLAGS  =3D -I$(top_srcdir)/sr=
c/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@ -DDHCP_UNIT_TEST
 dhcp_t=
estdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn
diff --git=
 a/tests/unit_tests/openvpn/siphash_openssl=2Ec b/tests/unit_tests/openvpn/=
siphash_openssl=2Ec
new file mode 100644
index 0000000=2E=2Ec301f2d
--- /de=
v/null
+++ b/tests/unit_tests/openvpn/siphash_openssl=2Ec
@@ -0,0 +1,144 @@=

+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *     =
        over a single TCP/UDP port, with support for SSL/TLS-based
+ *     =
        session authentication and key exchange,
+ *             packet enc=
ryption, packet authentication, and
+ *             packet compression=2E
+=
 *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copy=
right (C) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *  This program is f=
ree software; you can redistribute it and/or modify
+ *  it under the terms=
 of the GNU General Public License version 2
+ *  as published by the Free =
Software Foundation=2E
+ *
+ *  This program is distributed in the hope tha=
t it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implie=
d warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  =
See the
+ *  GNU General Public License for more details=2E
+ *
+ *  You sh=
ould have received a copy of the GNU General Public License along
+ *  with=
 this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#=
ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "siphash=2Eh=
"
+
+#ifdef ENABLE_CRYPTO_OPENSSL
+#include <openssl/opensslv=2Eh>
+#endif
=
+
+/* OpenSSL siphash is currently 2-3 times slower than the reference
+ * =
implementation, so we only use it for unit testing that our implementation
=
+ * and OpenSSL agree */
+#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VER=
SION_NUMBER >=3D 0x30000000L
+#include <openssl/evp=2Eh>
+#include "crypto_=
openssl=2Eh"
+#include "crypto_backend=2Eh"
+#include "buffer=2Eh"
+
+struc=
t siphash_context
+{
+    EVP_MAC *mac;
+    EVP_MAC_CTX *ctx;
+    size_t =
size;
+    OSSL_PARAM params[3];
+};
+
+/*
+ *  Computes a SipHash value
+ =
* in: pointer to input data (read-only)
+ *  inlen: input data length in by=
tes (any size_t value)
+ * k: pointer to the key data (read-only), must be =
16 bytes
+ * out: pointer to output data (write-only), outlen bytes must be=
 allocated
+ *  outlen: length of the output in bytes, must be 8 or 16
+ */=

+int
+siphash_openssl(void *sip_context, const void *in, const size_t inle=
n,
+                const void *k, uint8_t *out, const size_t outlen)
+{
+ =
   struct siphash_context *sip =3D sip_context;
+
+
+    sip->params[1] =3D=
 OSSL_PARAM_construct_octet_string("key", (void *)k,
+                     =
                                  SIPHASH_KEY_SIZE);
+    if (!EVP_MAC_init=
(sip->ctx, NULL, 0, sip->params))
+    {
+        crypto_msg(M_FATAL, "EVP_=
MAC_init failed");
+    }
+    EVP_MAC_update(sip->ctx, in, inlen);
+
+    =
size_t outl =3D 0;
+    EVP_MAC_final(sip->ctx, out, &outl, outlen);
+    r=
eturn 0;
+}
+
+void *
+siphash_openssl_init(size_t hash_size)
+{
+    struc=
t siphash_context *sip;
+    ALLOC_OBJ(sip, struct siphash_context);
+
+   =
 sip->mac =3D EVP_MAC_fetch(NULL, "SIPHASH", NULL);
+    if (!sip->mac)
+  =
  {
+        /* Our OpenSSL library does not support SIPHASH */
+        re=
turn sip;
+    }
+    sip->ctx =3D EVP_MAC_CTX_new(sip->mac);
+
+    /* Ope=
nSSL will truly hold a pointer to an int in that parameter */
+    sip->siz=
e =3D hash_size;
+    sip->params[0] =3D OSSL_PARAM_construct_size_t("size"=
, &sip->size);
+    /* params[1] will hold the key that changes which each =
invocation */
+    sip->params[2] =3D OSSL_PARAM_construct_end();
+    retu=
rn sip;
+}
+
+bool
+siphash_openssl_available(void *sip_context)
+{
+    st=
ruct siphash_context *sip =3D sip_context;
+
+    return (bool)(sip->mac);
=
+}
+
+void
+siphash_openssl_uninit(void *sip_context)
+{
+    struct siphas=
h_context *sip =3D sip_context;
+    EVP_MAC_CTX_free(sip->ctx);
+    EVP_M=
AC_free(sip->mac);
+    free(sip_context);
+}
+#else
+/* Do avoid a lot mor=
e ifdefs in the test we put dummy functions here */
+int
+siphash_openssl(v=
oid *sip_context, const void *in, const size_t inlen,
+                cons=
t void *k, uint8_t *out, const size_t outlen)
+{
+    return -1;
+}
+
+bool=

+siphash_openssl_available(void *sip_context)
+{
+    return false;
+}
+
+=
void *
+siphash_openssl_init(size_t hash_size)
+{
+    return NULL;
+}
+
+v=
oid
+siphash_openssl_uninit(void *sip_context)
+{
+}
+
+
+#endif /* if defi=
ned(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >=3D 0x30000000L */
di=
ff --git a/tests/unit_tests/openvpn/siphash_openssl=2Eh b/tests/unit_tests/=
openvpn/siphash_openssl=2Eh
new file mode 100644
index 0000000=2E=2E0f1d329=

--- /dev/null
+++ b/tests/unit_tests/openvpn/siphash_openssl=2Eh
@@ -0,0 +=
1,64 @@
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
+#ifndef SIPHASH_OPENSSL_H
+#define SIPHASH_OPENSSL_H
+=

+#include <stdint=2Eh>
+#include <stdio=2Eh>
+#include <stdbool=2Eh>
+
+
+=
/* Prototypes for an implementation of SIPHASH in a crypto library */
+/**
=
+ *
+ * @param hash_size the size of the output hash size
+ * @return initi=
alised context for siphash
+ */
+void *
+siphash_openssl_init(size_t hash_s=
ize);
+
+
+/**
+ * Calculates SIPHASH using the crypto library function=2E
=
+ */
+int
+siphash_openssl(void *sip_context, const void *in, size_t inlen,=

+                const void *k, uint8_t *out, size_t outlen);
+
+/**
+ * F=
ree the siphash context used for the crypto library
+ * @param sip_context
=
+ */
+void
+siphash_openssl_uninit(void *sip_context);
+
+/**
+ * Returns i=
f the crypto library is available (and should be used)
+ *
+ * This returns=
 if there is a crypto library version of Siphash24 is
+ * available and sho=
uld be used (OpenSSL 3/4 version is quite slow, so
+ * we prefer the refere=
nce implementation)
+ *
+ */
+bool
+siphash_openssl_available(void *sip_con=
text);
+#endif /* ifndef SIPHASH_OPENSSL_H */
\ No newline at end of file
d=
iff --git a/tests/unit_tests/openvpn/test_crypto=2Ec b/tests/unit_tests/ope=
nvpn/test_crypto=2Ec
index cb4eaa2=2E=2E77cf295 100644
--- a/tests/unit_tes=
ts/openvpn/test_crypto=2Ec
+++ b/tests/unit_tests/openvpn/test_crypto=2Ec
@=
@ -31,12 +31,15 @@
 #include <stdarg=2Eh>
 #include <string=2Eh>
 #include =
<setjmp=2Eh>
+#include <inttypes=2Eh>
 #include <cmocka=2Eh>
 
 #include "c=
rypto=2Eh"
 #include "crypto_epoch=2Eh"
 #include "options=2Eh"
 #include "=
ssl_backend=2Eh"
+#include "siphash=2Eh"
+#include "siphash_openssl=2Eh"
 
=
 #include "mss=2Eh"
 #include "test_common=2Eh"
@@ -923,6 +926,69 @@
     a=
ssert_memory_equal(key_parameters=2Ehmac, exp_impl_iv, sizeof(exp_impl_iv))=
;
 }
 
+/* Use a define here since some c compilers don't like array initia=
lisation
+ * with an integer */
+#define UT_SIPHASH_HASH_SIZE 16
+
+static =
const char *ut_message =3D "Look behind you, a Three-Headed Monkey!";
+stat=
ic const uint8_t ut_key[SIPHASH_KEY_SIZE] =3D { 0x11, 0x22, 0x33, 0x44, 0x5=
5, 0x66 };
+const uint8_t expected_hash[UT_SIPHASH_HASH_SIZE] =3D { 0x3e, 0=
xea, 0x95, 0xb2, 0x6d, 0x5c, 0x4e, 0xfa,
+                                 =
                     0x20, 0x47, 0x65, 0x7e, 0xdd, 0xcd, 0x62, 0x51 };
+
+s=
tatic void
+test_siphash(void **state)
+{
+    uint8_t out[UT_SIPHASH_HASH_=
SIZE] =3D { 0 };
+    siphash_reference(ut_message, strlen(ut_message), ut_=
key, out, UT_SIPHASH_HASH_SIZE);
+    assert_memory_equal(out, expected_has=
h, UT_SIPHASH_HASH_SIZE);
+}
+
+static void
+test_siphash_openssl(void **st=
ate)
+{
+    void *sipctx =3D siphash_openssl_init(UT_SIPHASH_HASH_SIZE);
+=

+    if (!siphash_openssl_available(sipctx))
+    {
+        siphash_opens=
sl_uninit(sipctx);
+        skip();
+    }
+
+    uint8_t out[UT_SIPHASH_HA=
SH_SIZE] =3D { 0 };
+
+    siphash_openssl(sipctx, ut_message, strlen(ut_me=
ssage), ut_key, out,
+                    UT_SIPHASH_HASH_SIZE);
+    asser=
t_memory_equal(out, expected_hash, UT_SIPHASH_HASH_SIZE);
+
+    /* check t=
hat calling the function twice is safe */
+    siphash_openssl(sipctx, ut_m=
essage, strlen(ut_message), ut_key, out,
+                    UT_SIPHASH_HA=
SH_SIZE);
+    assert_memory_equal(out, expected_hash, UT_SIPHASH_HASH_SIZE=
);
+
+    /* Test a few random strings and ensure that our implementation b=
ehave the
+     * same */
+    for (int i =3D 0; i < 1000; i++)
+    {
+   =
     size_t len =3D random() % 1000u;
+        uint8_t buf[1024] =3D { 0 };=

+        uint8_t key[SIPHASH_KEY_SIZE] =3D { 0 };
+
+        assert_true(r=
and_bytes(buf, (int)len));
+        assert_true(rand_bytes(key, sizeof(key)=
));
+
+
+        siphash_openssl(sipctx, buf, len, key, out, UT_SIPHASH_HAS=
H_SIZE);
+
+        uint8_t outref[UT_SIPHASH_HASH_SIZE] =3D { 0 };
+      =
  siphash_reference(buf, len, key, outref, UT_SIPHASH_HASH_SIZE);
+
+      =
  assert_memory_equal(out, outref, UT_SIPHASH_HASH_SIZE);
+    }
+
+    sip=
hash_openssl_uninit(sipctx);
+}
+
+
 int
 main(void)
 {
@@ -960,7 +1026,9 @=
@
         cmocka_unit_test_prestate_setup_teardown(crypto_test_epoch_edge,=

                                                  crypto_test_epoch_setup,=

                                                  crypto_test_epoch_teardo=
wn, &prestate_num13),
-        cmocka_unit_test(epoch_test_derive_data_key)=

+        cmocka_unit_test(epoch_test_derive_data_key),
+        cmocka_uni=
t_test(test_siphash),
+        cmocka_unit_test(test_siphash_openssl)
     =
};
 
     return cmocka_run_group_tests_name("crypto tests", tests, NULL, N=
ULL);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I09aa27caa1a3aab0=
d1be6118b26d54a1c1bf7aa0
Gerrit-Change-Number: 31
Gerrit-PatchSet: 31
Gerri=
t-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--FWTSqfcS90k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/31?usp=3Demail">View Change</a></p><div style=3D"white-space=
:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">Use OpenSSL&#39;s SIPHASH implementation to =
double check our implementation<br><br>OpenSSL library is currently slower =
than the reference implementation<br>(about 1=2E5x to 2x depending of the c=
ompiler)=2E<br><br>The OpenSSL API for using the SIPHASH MAC is different e=
nough from using<br>normal HMAC or Digest that we already implement that co=
mbining them into<br>one API does not make sense=2E<br><br>SIPHASH is only =
available on OpenSSL 3=2E1 and later=2E We still check for<br>support on 3=
=2E0 and later as the whole API to allow using the SIPHASH alrady<br>exists=
 in OpenSSL 3=2E0=2E Some of the later OpenSSL 3=2E0=2Ex might get support<=
br>for it=2E Theoretically, a provider can be loaded in OpenSSL 3=2E0 that<=
br>implements SIPHASH=2E<br><br>With OpenSSL&#39;s implementation being slo=
wer, we currently only use it to<br>check that our reference implementation=
 and the OpenSSL implementation<br>yield the same result in unit tests<br><=
br>Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0<br>Signed-off-by: A=
rne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/31<br>Message-Id: &lt;20260806153230=2E65971-1-frank@lichtenheld=
=2Ecom&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Es=
ourceforge=2Enet/msg38180=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gr=
eenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=
=2Eam<br>M src/openvpn/siphash=2Eh<br>M src/openvpn/siphash_reference=2Ec<b=
r>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests/unit_tests/openvpn/si=
phash_openssl=2Ec<br>A tests/unit_tests/openvpn/siphash_openssl=2Eh<br>M te=
sts/unit_tests/openvpn/test_crypto=2Ec<br>8 files changed, 305 insertions(+=
), 8 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLis=
ts=2Etxt</span><br><span>index 74c080e=2E=2E3ff2734 100644</span><br><span>=
--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><sp=
an>@@ -572,6 +572,8 @@</span><br><span>     src/openvpn/shaper=2Eh</span><b=
r><span>     src/openvpn/sig=2Ec</span><br><span>     src/openvpn/sig=2Eh</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/sipha=
sh=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openv=
pn/siphash_reference=2Ec</span><br><span>     src/openvpn/socket=2Ec</span>=
<br><span>     src/openvpn/socket=2Eh</span><br><span>     src/openvpn/sock=
et_util=2Ec</span><br><span>@@ -784,6 +786,7 @@</span><br><span>         )<=
/span><br><span> </span><br><span>     target_sources(test_crypto PRIVATE</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_te=
sts/openvpn/siphash_openssl=2Ec</span><br><span>         src/openvpn/crypto=
_mbedtls=2Ec</span><br><span>         src/openvpn/crypto_openssl=2Ec</span>=
<br><span>         src/openvpn/crypto_epoch=2Ec</span><br><span>@@ -792,6 +=
795,7 @@</span><br><span>         src/openvpn/packet_id=2Ec</span><br><span=
>         src/openvpn/mtu=2Ec</span><br><span>         src/openvpn/mss=2Ec<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/=
siphash_reference=2Ec</span><br><span>         )</span><br><span> </span><b=
r><span>     target_sources(test_ssl PRIVATE</span><br><span>diff --git a/s=
rc/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index =
ff8cc54=2E=2E1f77384 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam=
</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -128,6 =
+128,7 @@</span><br><span> 	session_id=2Ec session_id=2Eh \</span><br><span=
> 	shaper=2Ec shaper=2Eh \</span><br><span> 	sig=2Ec sig=2Eh \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	siphash_reference=2Ec siphash=
=2Eh \</span><br><span> 	socket=2Ec socket=2Eh \</span><br><span> 	socket_u=
til=2Ec socket_util=2Eh \</span><br><span> 	socks=2Ec socks=2Eh \</span><br=
><span>diff --git a/src/openvpn/siphash=2Eh b/src/openvpn/siphash=2Eh</span=
><br><span>index ef61110=2E=2Ebddddc3 100644</span><br><span>--- a/src/open=
vpn/siphash=2Eh</span><br><span>+++ b/src/openvpn/siphash=2Eh</span><br><sp=
an>@@ -18,12 +18,26 @@</span><br><span> #ifndef SIPHASH_H</span><br><span> =
#define SIPHASH_H</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#include &lt;inttypes=2Eh&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &lt;stdint=2Eh&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdio=2Eh&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdbool=2Eh&gt;</span=
><br><span> </span><br><span> /* siphash always uses 128-bit keys */</span>=
<br><span> #define SIPHASH_KEY_SIZE 16</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-int siphash(const void *in, size_t inlen=
, const void *k, uint8_t *out,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            size_t outlen);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Calculates SIPHASH using the reference implementation</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+siphash_reference(const void *in, size_t inlen, const void *k,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                  uint8_t =
*out, size_t outlen);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline =
int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash(const vo=
id *in, size_t inlen, const void *k,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        uint8_t *out, size_t outlen)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return siphash_reference(in, inlen, k, out, outlen);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif /* ifndef SIPHASH_H */</span><br><span>\ No newline =
at end of file</span><br><span>diff --git a/src/openvpn/siphash_reference=
=2Ec b/src/openvpn/siphash_reference=2Ec</span><br><span>index b21a86e=2E=
=2Ead19a51 100644</span><br><span>--- a/src/openvpn/siphash_reference=2Ec</=
span><br><span>+++ b/src/openvpn/siphash_reference=2Ec</span><br><span>@@ -=
100,8 +100,8 @@</span><br><span>  *  outlen: length of the output in bytes,=
 must be 8 or 16</span><br><span>  */</span><br><span> int</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-siphash(const void *in, const size_t i=
nlen, const void *k, uint8_t *out,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        const size_t outlen)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+siphash_reference(const void *in, const size_t inlen,=
 const void *k, uint8_t *out,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                  const size_t outlen)</span><br><span> {</span><=
br><span>     const unsigned char *ni =3D (const unsigned char *)in;</span>=
<br><span>     const unsigned char *kk =3D (const unsigned char *)k;</span>=
<br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_=
tests/openvpn/Makefile=2Eam</span><br><span>index 4a76269=2E=2E9174ed0 1006=
44</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><=
span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -73,6 =
+73,7 @@</span><br><span> crypto_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</spa=
n><br><span> crypto_testdriver_SOURCES =3D test_crypto=2Ec \</span><br><spa=
n> 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	siphash_openssl=2Ec siphash_openssl=2Eh \</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(to=
p_srcdir)/src/openvpn/crypto=2Ec \</span><br><span> 	$(top_srcdir)/src/open=
vpn/crypto_mbedtls=2Ec \</span><br><span>@@ -84,7 +85,8 @@</span><br><span>=
 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><span> 	$(top_srcdir)/=
src/openvpn/mtu=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-uti=
l=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)=
/src/openvpn/mss=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	$(top_srcdir)/src/openvpn/mss=2Ec \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec</span><b=
r><span> </span><br><span> dhcp_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/=
openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@ -DDHCP_UNIT_TEST</span><br=
><span> dhcp_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/open=
vpn</span><br><span>diff --git a/tests/unit_tests/openvpn/siphash_openssl=
=2Ec b/tests/unit_tests/openvpn/siphash_openssl=2Ec</span><br><span>new fil=
e mode 100644</span><br><span>index 0000000=2E=2Ec301f2d</span><br><span>--=
- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/siphash_openssl=
=2Ec</span><br><span>@@ -0,0 +1,144 @@</span><br><span style=3D"color: hsl(=
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
penvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 Copyright (C) 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  This program is free software; you can redistrib=
ute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  it under the terms of the GNU General Public License version 2</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Fre=
e Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This pro=
gram is distributed in the hope that it will be useful,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without e=
ven the implied warranty of</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Pub=
lic License for more details=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Y=
ou should have received a copy of the GNU General Public License along</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; i=
f not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sip=
hash=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_CRYPTO_OPE=
NSSL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;op=
enssl/opensslv=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* OpenSSL siphash is current=
ly 2-3 times slower than the reference</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * implementation, so we only use it for unit testing th=
at our implementation</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * and OpenSSL agree */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; OPENSSL_VERSION_NUMBER =
&gt;=3D 0x30000000L</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &lt;openssl/evp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &quot;crypto_openssl=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto_backend=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+struct siphash_context</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
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
0%);">+siphash_openssl(void *sip_context, const void *in, const size_t inle=
n,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                c=
onst void *k, uint8_t *out, const size_t outlen)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct siphash_context *sip =3D sip_context;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    sip-&gt;params[1] =3D OSSL_PARAM_construct_octet_string(&quot;key&quo=
t;, (void *)k,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                                  SIPHASH_KEY_SIZE);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!EVP_MAC_init(sip-=
&gt;ctx, NULL, 0, sip-&gt;params))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        crypto_msg(M_FATAL, &quot;EVP_MAC_init failed&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    EVP_MAC_update(sip-&gt;ctx, in, inlen);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    size_t outl =3D 0;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_final(sip-&gt;ctx, out, &a=
mp;outl, outlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+siphash_openssl_init(size_t hash_size)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct siphash_context *sip;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ(sip, struct siphash_context);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;mac =3D EVP_MAC_fetch(NULL,=
 &quot;SIPHASH&quot;, NULL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!sip-&gt;mac)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* Our OpenSSL library does not support SIPHASH */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return sip;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    sip-&gt;ctx =3D EVP_MAC_CTX_new(sip-&gt;mac);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* OpenSSL will truly hold a pointer =
to an int in that parameter */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    sip-&gt;size =3D hash_size;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    sip-&gt;params[0] =3D OSSL_PARAM_construct_size_=
t(&quot;size&quot;, &amp;sip-&gt;size);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* params[1] will hold the key that changes which e=
ach invocation */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  sip-&gt;params[2] =3D OSSL_PARAM_construct_end();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return sip;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_openssl_availa=
ble(void *sip_context)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct siph=
ash_context *sip =3D sip_context;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn (bool)(sip-&gt;mac);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+siphash_openssl_uninit(void *sip_context)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct siphash_context *sip =3D sip_c=
ontext;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_=
CTX_free(sip-&gt;ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    EVP_MAC_free(sip-&gt;mac);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    free(sip_context);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Do avoid a l=
ot more ifdefs in the test we put dummy functions here */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+siphash_openssl(void *sip_context, const void *in, co=
nst size_t inlen,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              const void *k, uint8_t *out, const size_t outlen)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return -1;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+siphash_openssl_available(void =
*sip_context)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
iphash_openssl_init(size_t hash_size)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+siphash_openssl_uninit(void *sip_context)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(ENABLE_CRYP=
TO_OPENSSL) &amp;&amp; OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L */</span>=
<br><span>diff --git a/tests/unit_tests/openvpn/siphash_openssl=2Eh b/tests=
/unit_tests/openvpn/siphash_openssl=2Eh</span><br><span>new file mode 10064=
4</span><br><span>index 0000000=2E=2E0f1d329</span><br><span>--- /dev/null<=
/span><br><span>+++ b/tests/unit_tests/openvpn/siphash_openssl=2Eh</span><b=
r><span>@@ -0,0 +1,64 @@</span><br><span style=3D"color: hsl(120, 100%, 40%=
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
tyle=3D"color: hsl(120, 100%, 40%);">+#ifndef SIPHASH_OPENSSL_H</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define SIPHASH_OPENSSL_H</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &lt;stdint=2Eh&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdio=2Eh&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdbool=2Eh&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* Prototypes for an implementation of SIPHASH in a crypto=
 library */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param hash_size the size of the outpu=
t hash size</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retu=
rn initialised context for siphash</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_openss=
l_init(size_t hash_size);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Calculates SIPHASH using the crypto library f=
unction=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+siphash_openssl(void *sip_context, const =
void *in, size_t inlen,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                const void *k, uint8_t *out, size_t outlen);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * Free the siphash context used for the crypto library</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param sip_context</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+siphash_openssl_uninit(void *sip_context);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Returns if the crypto library is available (and should be used)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * This returns if there is a crypto l=
ibrary version of Siphash24 is</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * available and should be used (OpenSSL 3/4 version is quite sl=
ow, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * we prefer =
the reference implementation)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+siphash_openssl_available(void *sip_co=
ntext);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if=
ndef SIPHASH_OPENSSL_H */</span><br><span>\ No newline at end of file</span=
><br><span>diff --git a/tests/unit_tests/openvpn/test_crypto=2Ec b/tests/un=
it_tests/openvpn/test_crypto=2Ec</span><br><span>index cb4eaa2=2E=2E77cf295=
 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_crypto=2Ec</spa=
n><br><span>+++ b/tests/unit_tests/openvpn/test_crypto=2Ec</span><br><span>=
@@ -31,12 +31,15 @@</span><br><span> #include &lt;stdarg=2Eh&gt;</span><br>=
<span> #include &lt;string=2Eh&gt;</span><br><span> #include &lt;setjmp=2Eh=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;in=
ttypes=2Eh&gt;</span><br><span> #include &lt;cmocka=2Eh&gt;</span><br><span=
> </span><br><span> #include &quot;crypto=2Eh&quot;</span><br><span> #inclu=
de &quot;crypto_epoch=2Eh&quot;</span><br><span> #include &quot;options=2Eh=
&quot;</span><br><span> #include &quot;ssl_backend=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphas=
h_openssl=2Eh&quot;</span><br><span> </span><br><span> #include &quot;mss=
=2Eh&quot;</span><br><span> #include &quot;test_common=2Eh&quot;</span><br>=
<span>@@ -923,6 +926,69 @@</span><br><span>     assert_memory_equal(key_par=
ameters=2Ehmac, exp_impl_iv, sizeof(exp_impl_iv));</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Use =
a define here since some c compilers don&#39;t like array initialisation</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * with an integer */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define UT_SIPHASH_H=
ASH_SIZE 16</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static const char *ut_messa=
ge =3D &quot;Look behind you, a Three-Headed Monkey!&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static const uint8_t ut_key[SIPHASH=
_KEY_SIZE] =3D { 0x11, 0x22, 0x33, 0x44, 0x55, 0x66 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+const uint8_t expected_hash[UT_SIPHASH_H=
ASH_SIZE] =3D { 0x3e, 0xea, 0x95, 0xb2, 0x6d, 0x5c, 0x4e, 0xfa,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
                       0x20, 0x47, 0x65, 0x7e, 0xdd, 0xcd, 0x62, 0x51 };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_siphash(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    uint8_t out[UT_SIPHASH_HASH_SIZE] =3D { 0 };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    siphash_reference(ut_messa=
ge, strlen(ut_message), ut_key, out, UT_SIPHASH_HASH_SIZE);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(out, expect=
ed_hash, UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+test_siphash_openssl(void **state=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    void *sipctx =3D siphash_openssl=
_init(UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!s=
iphash_openssl_available(sipctx))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        siphash_openssl_uninit(sipctx);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        skip();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t out[U=
T_SIPHASH_HASH_SIZE] =3D { 0 };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sip=
hash_openssl(sipctx, ut_message, strlen(ut_message), ut_key, out,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    UT_SIPHAS=
H_HASH_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_memory_equal(out, expected_hash, UT_SIPHASH_HASH_SIZE);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* check that calling the function twice is safe =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    siphash_opens=
sl(sipctx, ut_message, strlen(ut_message), ut_key, out,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    UT_SIPHASH_HASH_SIZ=
E);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memor=
y_equal(out, expected_hash, UT_SIPHASH_HASH_SIZE);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* Test a few random strings and ensure that our implementa=
tion behave the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * same */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (=
int i =3D 0; i &lt; 1000; i++)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     size_t len =3D random() % 1000u;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        uint8_t buf[1024] =3D { 0 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        uint8_t key[SIPHASH_KEY_SIZE] =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        assert_true(rand_byt=
es(buf, (int)len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        assert_true(rand_bytes(key, sizeof(key)));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 siphash_openssl(sipctx, buf, len, key, out, UT_SIPHASH_HASH_SIZE);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        uint8_t outref[UT_SIPHASH_HASH_SIZE] =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
iphash_reference(buf, len, key, outref, UT_SIPHASH_HASH_SIZE);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        assert_memory_equal(out, outref, UT_SIPHASH=
_HASH_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    siphash_openssl_uninit(sipctx);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> int</span><br><span> main(void)</span><br>=
<span> {</span><br><span>@@ -960,7 +1026,9 @@</span><br><span>         cmoc=
ka_unit_test_prestate_setup_teardown(crypto_test_epoch_edge,</span><br><spa=
n>                                                  crypto_test_epoch_setup=
,</span><br><span>                                                  crypto_=
test_epoch_teardown, &amp;prestate_num13),</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        cmocka_unit_test(epoch_test_derive_data_key)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_t=
est(epoch_test_derive_data_key),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        cmocka_unit_test(test_siphash),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_siphash_ope=
nssl)</span><br><span>     };</span><br><span> </span><br><span>     return=
 cmocka_run_group_tests_name(&quot;crypto tests&quot;, tests, NULL, NULL);<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail">change 31</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> G=
errit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b2=
6d54a1c1bf7aa0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 31=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 31 </div>
<div style=
=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body>=
</html>
--FWTSqfcS90k=--


--===============0557043600205324713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0557043600205324713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0557043600205324713==--

