Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2322CC53215
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yDlj2Um+A9pACKO1FlPNB2fKIwHj/hcm/j8xezODomY=; b=aNoRFFp8lpcEs3mCjJpSiioJur
	ZskXifPhNfh9xXKx/RLkGaqPOw5EDWVgLoJZhUAHNp6iXFI46HhtpTdOr+2WTaET1Q8MC6o7DalqM
	erBBQ6n4LTIU2tMRuNC3AJZktI4IstWuPBGgb3gyJcuGmJFAO/sCyvjWK2+JYe5o9yc8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnIKq-0007Gv-Ih;
	Fri, 24 Jul 2026 16:01:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnIKo-0007Go-5l
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:01:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HOsKR9cfXqY/hUM81yJm+hEIZnGwJeBVz87q1pIJWRw=; b=MPTPZyo24bOuYvyGao3UuWDx2t
 z2UdlFyt7ybmE0phub1dSUb2xj3TfdmfiALjQCWHAe8XAdZmL+vEpLuAmVEuZCzP5l4fMtdVo2XHS
 CDZaog1b44u1EVQb4dII3JB/wy7kgE/OLLP5NiRK3CGcmfoBUaykivf7z/ZUapLDG/Z0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HOsKR9cfXqY/hUM81yJm+hEIZnGwJeBVz87q1pIJWRw=; b=d
 BZR+6DGyUlOiBRC62AfidNlfSgYBLxTZHFToelJ+P5ftMhYRQd0JAK6oFK5dzvyWQ5B+uq3RxkZVS
 BmI28xJjwhEi7wIo3Le/IyZr+bHHYBbQQIdire6uzZoz2Ahk87tS3IoKx6Qt0n7icnMXjPUkx1AAa
 TvH0EZ++WCPZMUJ0=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnIKi-0005aJ-O8 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:01:08 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-476a130c138so672738f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 09:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784908859; x=1785513659; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HOsKR9cfXqY/hUM81yJm+hEIZnGwJeBVz87q1pIJWRw=;
 b=X+rV5nwA4y3zROd4c/CggwuF2pv4z8g75IMkDMwMbFZHK0pfEBOI75Qx5J7e5xTuTZ
 vpiMVvkk+hDve1a3lRsEx5//J2TTQTEvr82+hQirZt4oh3I1s1OIxgwgVCn6/FVcSZPo
 l00Q9p6nn1bn7Z1iKUugEkfs2cNPymqhwvgwternRGwnRZKe87tRuRf5UjqomfxrAJ3P
 wE3sZ5AQuKAYXh3MPofx8yO2fJo5BFuJBI7Og9VomgxOCvuakdzJgJjj5NPFkNWpPyl8
 KnCMF4VCD2DIs3NP9FEjFkb4Yp2vqPCrQXKigz4MWJJrzj5pQGYX3RWdF6ntNeHrpH9v
 R5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784908859; x=1785513659;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HOsKR9cfXqY/hUM81yJm+hEIZnGwJeBVz87q1pIJWRw=;
 b=TB4SdoYnGdsxGJ8rfBHlM3EpHj7Tb6znxGO78w57RFEUvNRDzDJzpJcaK6CKIKTEhv
 3oppptz4eriV1x+U+7DIOgsb1ne6t9Ix13d9PEu/WWPbteyBMaCt5PGb0SAfQjfgbZDV
 Mu4mRq4WL5J68+P1Wj9c5ekqZqLdhzfPJTxGh1QILHOpAJQebwL/XoBYXAQlLF2QHC/Z
 Yn+37iMu0BqZG7gNZ/Fhzt4yk2bsrRX51MifwApR0moI+AcN5pCu+lVsL9AsVcnBaMh7
 MXM2l1YucI4EUQcQdSEJxuR/gozFVgyyUZk9u/5NGB0k0Xqq9UvEiUW5QBu4NbtwtC+r
 0fog==
X-Gm-Message-State: AOJu0YwgKz+KrE0cZyQW/Nh18Z4HXhzwSJMSxqh/weTNUR54xAPZwNpa
 C5d8hOhWBiMIg8DmJfxBmEgZHurl5d/n+7Rq4do+2ohX2WWIFgED5SC64yS8Rj+cjbVW3NfWPml
 8fU18uY/espppNneskLLup7oMfqkPyewKBmoV1YsvjDcR2JOMBbwv32oDxT669dlRErxib2E3bb
 qNKiYC6A==
X-Gm-Gg: AR+sD10NPSboCgUs5Nui8j/+hl+BcY5s5WzA2AWwYVEHEGF8a7tsJ1f/Ysrc2+Wz02Q
 PKTQw3dDdBkFj2vdSr9Qus/s4Gc+RLuP/2okmCUQwdhMR9+7XZYdUU62EiGAhoCOKSbptFggZzS
 hfGybtOo1fdrrFSe+ye3kR77+byli62+aTm6hvZP8D/2AavqLIMnhV7f70qRvlqawRAGi8DOaKZ
 3vmqgXck/kX4VdN9iXDaZ+qyZ4tYWNKisbSCIpnISjPkDn7VnxZTRT6p+RrAiAFQ+CNBOqjjpAF
 yyS0GQUzUY6IJBSHjqd9KJswNRoV7v3dvczEsdqbnNyIf5ShYjTHo4wCGuOonWBIYmMTS1SH3EA
 Gfnl1gq+RxHfT5L772wUzUPhMCueYg8M+UfrezMRrSeSBWlR7YTvU/WcqqFVOMvf10swuYI0+cb
 4FFQBs1L7elfXOp5g6unC7+ShS0X0Km8FcUuEL1Ms7S+E5cxV7A/itvo9FwEW5YuHnecFSRtK8U
 BhUQRxWSW6jSeqWJ7orLvr26qbe0judiO7y57jH3RNZpKLG1OcI2Itz1Uf1RQM/f3U2
X-Received: by 2002:a05:6000:4025:b0:47f:7c50:2222 with SMTP id
 ffacd0b85a97d-47f8da7cce0mr9855447f8f.24.1784908858259; 
 Fri, 24 Jul 2026 09:00:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5d9sm24211059f8f.5.2026.07.24.09.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 09:00:57 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 16:00:47 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
X-Gerrit-Change-Number: 31
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/31?usp=email>
X-Gerrit-Commit: 43e47e7fa4fb6fec01e17246aea0ab830f31e097
In-Reply-To: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwOWFhMjdjYWExYTNhYWIwZDFiZTYxMThiMjZkNTRhMWMxYmY3YWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <497e83ba52a5478a0d6f57682931fd9622362cac-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnIKi-0005aJ-O8
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6339870793019512395=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6339870793019512395==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WcrQDCvcFhY="; charset=UTF-8

--WcrQDCvcFhY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello flichtenheld, 

I=
'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/31?usp=3Demail

to look at the new patch set (#21)=2E=



Change subject: Use OpenSSL's SIPHASH implementation to double check our=
 implementation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Use OpenSSL's SIPHASH implementation to double check our implementatio=
n

OpenSSL library is currently slower than the reference implementation
(a=
bout 1=2E5x to 2x depending of the compiler)=2E

The OpenSSL API for using =
the SIPHASH MAC is different enough from using
normal HMAC or Digest that w=
e already implement that combining them into
one API does not make sense=2E=


SIPHASH is only available on OpenSSL 3=2E1 and later=2E We still check fo=
r
support on 3=2E0 and later as the whole API to allow using the SIPHASH al=
rady
exists in OpenSSL 3=2E0=2E Some of the later OpenSSL 3=2E0=2Ex might g=
et support
for it=2E Theoretically, a provider can be loaded in OpenSSL 3=
=2E0 that
implements SIPHASH=2E

With OpenSSL's implementation being slower=
, we currently only use it to
check that our reference implementation and t=
he OpenSSL implementation
yield the same result in unit tests

Change-Id: I=
09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
Signed-off-by: Arne Schwabe <arne@=
rfc2549=2Eorg>
---
M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
M src/ope=
nvpn/siphash=2Eh
M src/openvpn/siphash_reference=2Ec
M tests/unit_tests/ope=
nvpn/Makefile=2Eam
A tests/unit_tests/openvpn/siphash_openssl=2Ec
A tests/u=
nit_tests/openvpn/siphash_openssl=2Eh
M tests/unit_tests/openvpn/test_crypt=
o=2Ec
8 files changed, 283 insertions(+), 7 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/31/31/21

diff --git a/C=
MakeLists=2Etxt b/CMakeLists=2Etxt
index 7473f15=2E=2Ef113207 100644
--- a/=
CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -572,6 +572,8 @@
     src/openvp=
n/shaper=2Eh
     src/openvpn/sig=2Ec
     src/openvpn/sig=2Eh
+    src/ope=
nvpn/siphash=2Eh
+    src/openvpn/siphash_reference=2Ec
     src/openvpn/so=
cket=2Ec
     src/openvpn/socket=2Eh
     src/openvpn/socket_util=2Ec
@@ -7=
84,6 +786,7 @@
         )
 
     target_sources(test_crypto PRIVATE
+      =
  tests/unit_tests/openvpn//siphash_openssl=2Ec
         src/openvpn/crypto=
_mbedtls=2Ec
         src/openvpn/crypto_openssl=2Ec
         src/openvpn/c=
rypto_epoch=2Ec
@@ -792,8 +795,11 @@
         src/openvpn/packet_id=2Ec
   =
      src/openvpn/mtu=2Ec
         src/openvpn/mss=2Ec
+        src/openvpn=
/siphash_reference=2Ec
         )
 
+    target_compile_definitions(test_cr=
ypto PRIVATE PREFER_OPENSSL_SIPHASH)
+
     target_sources(test_ssl PRIVATE=

             tests/unit_tests/openvpn/mock_management=2Ec
             tes=
ts/unit_tests/openvpn/mock_ssl_dependencies=2Ec
diff --git a/src/openvpn/Ma=
kefile=2Eam b/src/openvpn/Makefile=2Eam
index ff8cc54=2E=2E1f77384 100644
-=
-- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -128,6 +1=
28,7 @@
 	session_id=2Ec session_id=2Eh \
 	shaper=2Ec shaper=2Eh \
 	sig=
=2Ec sig=2Eh \
+	siphash_reference=2Ec siphash=2Eh \
 	socket=2Ec socket=2E=
h \
 	socket_util=2Ec socket_util=2Eh \
 	socks=2Ec socks=2Eh \
diff --git =
a/src/openvpn/siphash=2Eh b/src/openvpn/siphash=2Eh
index ef61110=2E=2Ebddd=
dc3 100644
--- a/src/openvpn/siphash=2Eh
+++ b/src/openvpn/siphash=2Eh
@@ -=
18,12 +18,26 @@
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
+/**
+ * Calculates SIPHASH using the reference imp=
lementation
+ */
+int
+siphash_reference(const void *in, size_t inlen, cons=
t void *k,
+                  uint8_t *out, size_t outlen);
 
-#endif
+
+st=
atic inline int
+siphash(const void *in, size_t inlen, const void *k,
+    =
    uint8_t *out, size_t outlen)
+{
+    return siphash_reference(in, inlen=
, k, out, outlen);
+}
+
+#endif /* ifndef SIPHASH_H */
\ No newline at end =
of file
diff --git a/src/openvpn/siphash_reference=2Ec b/src/openvpn/siphas=
h_reference=2Ec
index b21a86e=2E=2E4667bc4 100644
--- a/src/openvpn/siphash=
_reference=2Ec
+++ b/src/openvpn/siphash_reference=2Ec
@@ -100,7 +100,7 @@
=
  *  outlen: length of the output in bytes, must be 8 or 16
  */
 int
-siph=
ash(const void *in, const size_t inlen, const void *k, uint8_t *out,
+sipha=
sh_reference(const void *in, const size_t inlen, const void *k, uint8_t *ou=
t,
         const size_t outlen)
 {
     const unsigned char *ni =3D (const=
 unsigned char *)in;
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/=
tests/unit_tests/openvpn/Makefile=2Eam
index d861ef9=2E=2E287e0ae 100644
--=
- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/M=
akefile=2Eam
@@ -73,6 +73,7 @@
 crypto_testdriver_LDFLAGS =3D @TEST_LDFLAGS=
@
 crypto_testdriver_SOURCES =3D test_crypto=2Ec \
 	mock_msg=2Ec mock_msg=
=2Eh test_common=2Eh \
+	siphash_openssl=2Ec siphash_openssl=2Eh \
 	$(top_=
srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
 =
	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \
@@ -84,7 +85,8 @@
 	$(top_s=
rcdir)/src/openvpn/platform=2Ec \
 	$(top_srcdir)/src/openvpn/mtu=2Ec \
 	$=
(top_srcdir)/src/openvpn/win32-util=2Ec \
-	$(top_srcdir)/src/openvpn/mss=
=2Ec
+	$(top_srcdir)/src/openvpn/mss=2Ec \
+	$(top_srcdir)/src/openvpn/siph=
ash_reference=2Ec
 
 dhcp_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvp=
n -I$(top_srcdir)/src/compat @TEST_CFLAGS@ -DDHCP_UNIT_TEST
 dhcp_testdrive=
r_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn
@@ -97,6 +99,7 @@
=
 
 ssl_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/s=
rc/compat -I$(top_srcdir)/src/openvpn \
+	-DPREFER_OPENSSL_SIPHASH \
 	@TES=
T_CFLAGS@
 ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIB=
S)
 ssl_testdriver_SOURCES =3D test_ssl=2Ec \
diff --git a/tests/unit_tests=
/openvpn/siphash_openssl=2Ec b/tests/unit_tests/openvpn/siphash_openssl=2Ec=

new file mode 100644
index 0000000=2E=2E90d248a
--- /dev/null
+++ b/tests/=
unit_tests/openvpn/siphash_openssl=2Ec
@@ -0,0 +1,144 @@
+/*
+ *  OpenVPN -=
- An application to securely tunnel IP networks
+ *             over a sing=
le TCP/UDP port, with support for SSL/TLS-based
+ *             session aut=
hentication and key exchange,
+ *             packet encryption, packet aut=
hentication, and
+ *             packet compression=2E
+ *
+ *  Copyright (=
C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2026 Arne=
 Schwabe <arne@rfc2549=2Eorg>
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
+#include "siphash=2Eh"
+
+#ifdef ENABLE_=
CRYPTO_OPENSSL
+#include <openssl/opensslv=2Eh>
+#endif
+
+/* OpenSSL sipha=
sh is currently 2-3 times slower than the reference
+ * implementation, so =
we only use for unit testing that our impelmentation
+ * and OpenSSL agree*=
/
+#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >=3D 0x3000=
0000L
+#include <openssl/evp=2Eh>
+#include "crypto_openssl=2Eh"
+#include =
"crypto_backend=2Eh"
+#include "buffer=2Eh"
+
+struct siphash_context
+{
+ =
   EVP_MAC *mac;
+    EVP_MAC_CTX *ctx;
+    size_t size;
+    OSSL_PARAM p=
arams[3];
+};
+
+/*
+ *  Computes a SipHash value
+ * in: pointer to input =
data (read-only)
+ *  inlen: input data length in bytes (any size_t value)
=
+ * k: pointer to the key data (read-only), must be 16 bytes
+ * out: point=
er to output data (write-only), outlen bytes must be allocated
+ *  outlen:=
 length of the output in bytes, must be 8 or 16
+ */
+int
+siphash_openssl(=
void *sip_context, const void *in, const size_t inlen,
+                con=
st void *k, uint8_t *out, const size_t outlen)
+{
+    struct siphash_conte=
xt *sip =3D sip_context;
+
+
+    sip->params[1] =3D OSSL_PARAM_construct_o=
ctet_string("key", (void *)k,
+                                            =
           SIPHASH_KEY_SIZE);
+    if (!EVP_MAC_init(sip->ctx, NULL, 0, sip=
->params))
+    {
+        crypto_msg(M_FATAL, "EVP_MAC_init failed");
+   =
 }
+    EVP_MAC_update(sip->ctx, in, inlen);
+
+    size_t outl =3D 0;
+   =
 EVP_MAC_final(sip->ctx, out, &outl, outlen);
+    return 0;
+}
+
+void *
+=
siphash_openssl_init(size_t hash_size)
+{
+    struct siphash_context *sip;=

+    ALLOC_OBJ(sip, struct siphash_context);
+
+    sip->mac =3D EVP_MAC_f=
etch(NULL, "SIPHASH", NULL);
+    if (!sip->mac)
+    {
+        /* Our Ope=
nSSL library does not support SIPHASH */
+        return sip;
+    }
+    s=
ip->ctx =3D EVP_MAC_CTX_new(sip->mac);
+
+    /* OpenSSL will truly hold a =
pointer to an int in that parameter */
+    sip->size =3D hash_size;
+    s=
ip->params[0] =3D OSSL_PARAM_construct_size_t("size", &sip->size);
+    /* =
params[1] will hold the key that changes which each invocation */
+    sip-=
>params[2] =3D OSSL_PARAM_construct_end();
+    return sip;
+}
+
+bool
+sip=
hash_openssl_available(void *sip_context)
+{
+    struct siphash_context *s=
ip =3D sip_context;
+
+    return (bool)(sip->mac);
+}
+
+void
+siphash_ope=
nssl_uninit(void *sip_context)
+{
+    struct siphash_context *sip =3D sip_=
context;
+    EVP_MAC_CTX_free(sip->ctx);
+    EVP_MAC_free(sip->mac);
+   =
 free(sip_context);
+}
+#else
+/* Do avoid a lot more ifdefs in the test we=
 put dummy functions here */
+int
+siphash_openssl(void *sip_context, const=
 void *in, const size_t inlen,
+                const void *k, uint8_t *out=
, const size_t outlen)
+{
+    return -1;
+}
+
+bool
+siphash_openssl_avail=
able(void *sip_context)
+{
+    return false;
+}
+
+void *
+siphash_openssl=
_init(size_t hash_size)
+{
+    return NULL;
+}
+
+void
+siphash_openssl_un=
init(void *sip_context)
+{
+}
+
+
+#endif /* if defined(ENABLE_CRYPTO_OPENS=
SL) && OPENSSL_VERSION_NUMBER >=3D 0x30000000L */
diff --git a/tests/unit_t=
ests/openvpn/siphash_openssl=2Eh b/tests/unit_tests/openvpn/siphash_openssl=
=2Eh
new file mode 100644
index 0000000=2E=2E9d9757d
--- /dev/null
+++ b/te=
sts/unit_tests/openvpn/siphash_openssl=2Eh
@@ -0,0 +1,60 @@
+/*
+ * SipHash=
 reference C implementation
+ *
+ * Copyright (c) 2012-2021 Jean-Philippe A=
umasson
+ * <jeanphilippe=2Eaumasson@gmail=2Ecom>
+ * Copyright (c) 2012-20=
14 Daniel J=2E Bernstein <djb@cr=2Eyp=2Eto>
+ *
+ * To the extent possible =
under law, the author(s) have dedicated all copyright
+ * and related and n=
eighboring rights to this software to the public domain
+ * worldwide=2E Th=
is software is distributed without any warranty=2E
+ *
+ * You should have =
received a copy of the CC0 Public Domain Dedication along
+ * with
+ * this=
 software=2E If not, see
+ * <http://creativecommons=2Eorg/publicdomain/zer=
o/1=2E0/>=2E
+ */
+
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
index cb4eaa2=2E=2E8c8e371 100644
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
@@ -923,6 +926,49 @@
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
+    siphash_openssl_uninit(sipctx);
+}
+
+
 int
 main(void)
 {
@@ -96=
0,7 +1006,9 @@
         cmocka_unit_test_prestate_setup_teardown(crypto_tes=
t_epoch_edge,
                                                  crypto_test=
_epoch_setup,
                                                  crypto_test=
_epoch_teardown, &prestate_num13),
-        cmocka_unit_test(epoch_test_der=
ive_data_key)
+        cmocka_unit_test(epoch_test_derive_data_key),
+     =
   cmocka_unit_test(test_siphash),
+        cmocka_unit_test(test_siphash_o=
penssl)
     };
 
     return cmocka_run_group_tests_name("crypto tests", t=
ests, NULL, NULL);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/31?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
Gerrit-Change-Number: 31
Gerrit-P=
atchSet: 21
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Rev=
iewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>

--WcrQDCvcFhY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #21</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/31?usp=3Demail">View Change</a></p><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Use Op=
enSSL&#39;s SIPHASH implementation to double check our implementation<br><b=
r>OpenSSL library is currently slower than the reference implementation<br>=
(about 1=2E5x to 2x depending of the compiler)=2E<br><br>The OpenSSL API fo=
r using the SIPHASH MAC is different enough from using<br>normal HMAC or Di=
gest that we already implement that combining them into<br>one API does not=
 make sense=2E<br><br>SIPHASH is only available on OpenSSL 3=2E1 and later=
=2E We still check for<br>support on 3=2E0 and later as the whole API to al=
low using the SIPHASH alrady<br>exists in OpenSSL 3=2E0=2E Some of the late=
r OpenSSL 3=2E0=2Ex might get support<br>for it=2E Theoretically, a provide=
r can be loaded in OpenSSL 3=2E0 that<br>implements SIPHASH=2E<br><br>With =
OpenSSL&#39;s implementation being slower, we currently only use it to<br>c=
heck that our reference implementation and the OpenSSL implementation<br>yi=
eld the same result in unit tests<br><br>Change-Id: I09aa27caa1a3aab0d1be61=
18b26d54a1c1bf7aa0<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt=
;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>M src/open=
vpn/siphash=2Eh<br>M src/openvpn/siphash_reference=2Ec<br>M tests/unit_test=
s/openvpn/Makefile=2Eam<br>A tests/unit_tests/openvpn/siphash_openssl=2Ec<b=
r>A tests/unit_tests/openvpn/siphash_openssl=2Eh<br>M tests/unit_tests/open=
vpn/test_crypto=2Ec<br>8 files changed, 283 insertions(+), 7 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/31/31/21</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=
=2Etxt</span><br><span>index 7473f15=2E=2Ef113207 100644</span><br><span>--=
- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span=
>@@ -572,6 +572,8 @@</span><br><span>     src/openvpn/shaper=2Eh</span><br>=
<span>     src/openvpn/sig=2Ec</span><br><span>     src/openvpn/sig=2Eh</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/siphash=
=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn=
/siphash_reference=2Ec</span><br><span>     src/openvpn/socket=2Ec</span><b=
r><span>     src/openvpn/socket=2Eh</span><br><span>     src/openvpn/socket=
_util=2Ec</span><br><span>@@ -784,6 +786,7 @@</span><br><span>         )</s=
pan><br><span> </span><br><span>     target_sources(test_crypto PRIVATE</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_test=
s/openvpn//siphash_openssl=2Ec</span><br><span>         src/openvpn/crypto_=
mbedtls=2Ec</span><br><span>         src/openvpn/crypto_openssl=2Ec</span><=
br><span>         src/openvpn/crypto_epoch=2Ec</span><br><span>@@ -792,8 +7=
95,11 @@</span><br><span>         src/openvpn/packet_id=2Ec</span><br><span=
>         src/openvpn/mtu=2Ec</span><br><span>         src/openvpn/mss=2Ec<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/=
siphash_reference=2Ec</span><br><span>         )</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    target_compile_definitio=
ns(test_crypto PRIVATE PREFER_OPENSSL_SIPHASH)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span>     target_sources(test_ssl PR=
IVATE</span><br><span>             tests/unit_tests/openvpn/mock_management=
=2Ec</span><br><span>             tests/unit_tests/openvpn/mock_ssl_depende=
ncies=2Ec</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/open=
vpn/Makefile=2Eam</span><br><span>index ff8cc54=2E=2E1f77384 100644</span><=
br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/=
Makefile=2Eam</span><br><span>@@ -128,6 +128,7 @@</span><br><span> 	session=
_id=2Ec session_id=2Eh \</span><br><span> 	shaper=2Ec shaper=2Eh \</span><b=
r><span> 	sig=2Ec sig=2Eh \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	siphash_reference=2Ec siphash=2Eh \</span><br><span> 	socket=2Ec s=
ocket=2Eh \</span><br><span> 	socket_util=2Ec socket_util=2Eh \</span><br><=
span> 	socks=2Ec socks=2Eh \</span><br><span>diff --git a/src/openvpn/sipha=
sh=2Eh b/src/openvpn/siphash=2Eh</span><br><span>index ef61110=2E=2Ebddddc3=
 100644</span><br><span>--- a/src/openvpn/siphash=2Eh</span><br><span>+++ b=
/src/openvpn/siphash=2Eh</span><br><span>@@ -18,12 +18,26 @@</span><br><spa=
n> #ifndef SIPHASH_H</span><br><span> #define SIPHASH_H</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;inttypes=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &l=
t;stdint=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &lt;stdio=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &lt;stdbool=2Eh&gt;</span><br><span> </span><br><span> /* siph=
ash always uses 128-bit keys */</span><br><span> #define SIPHASH_KEY_SIZE 1=
6</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-in=
t siphash(const void *in, size_t inlen, const void *k, uint8_t *out,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            size_t outlen);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Calculates SIPHASH using the refe=
rence implementation</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+siphash_reference(const void *i=
n, size_t inlen, const void *k,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                  uint8_t *out, size_t outlen);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static inline int</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+siphash(const void *in, size_t inlen, const void *k,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint8_t *out=
, size_t outlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return siphash_re=
ference(in, inlen, k, out, outlen);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef SIPH=
ASH_H */</span><br><span>\ No newline at end of file</span><br><span>diff -=
-git a/src/openvpn/siphash_reference=2Ec b/src/openvpn/siphash_reference=2E=
c</span><br><span>index b21a86e=2E=2E4667bc4 100644</span><br><span>--- a/s=
rc/openvpn/siphash_reference=2Ec</span><br><span>+++ b/src/openvpn/siphash_=
reference=2Ec</span><br><span>@@ -100,7 +100,7 @@</span><br><span>  *  outl=
en: length of the output in bytes, must be 8 or 16</span><br><span>  */</sp=
an><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-siph=
ash(const void *in, const size_t inlen, const void *k, uint8_t *out,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_reference(const vo=
id *in, const size_t inlen, const void *k, uint8_t *out,</span><br><span>  =
       const size_t outlen)</span><br><span> {</span><br><span>     const u=
nsigned char *ni =3D (const unsigned char *)in;</span><br><span>diff --git =
a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefil=
e=2Eam</span><br><span>index d861ef9=2E=2E287e0ae 100644</span><br><span>--=
- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit=
_tests/openvpn/Makefile=2Eam</span><br><span>@@ -73,6 +73,7 @@</span><br><s=
pan> crypto_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span> crypto_t=
estdriver_SOURCES =3D test_crypto=2Ec \</span><br><span> 	mock_msg=2Ec mock=
_msg=2Eh test_common=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	siphash_openssl=2Ec siphash_openssl=2Eh \</span><br><span> 	$(top_s=
rcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn=
/crypto=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2E=
c \</span><br><span>@@ -84,7 +85,8 @@</span><br><span> 	$(top_srcdir)/src/o=
penvpn/platform=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/mtu=2Ec \=
</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/mss=2Ec<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/o=
penvpn/mss=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(=
top_srcdir)/src/openvpn/siphash_reference=2Ec</span><br><span> </span><br><=
span> dhcp_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdi=
r)/src/compat @TEST_CFLAGS@ -DDHCP_UNIT_TEST</span><br><span> dhcp_testdriv=
er_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn</span><br><span>@=
@ -97,6 +99,7 @@</span><br><span> </span><br><span> ssl_testdriver_CFLAGS  =
=3D \</span><br><span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat =
-I$(top_srcdir)/src/openvpn \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	-DPREFER_OPENSSL_SIPHASH \</span><br><span> 	@TEST_CFLAGS@</span=
><br><span> ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LI=
BS)</span><br><span> ssl_testdriver_SOURCES =3D test_ssl=2Ec \</span><br><s=
pan>diff --git a/tests/unit_tests/openvpn/siphash_openssl=2Ec b/tests/unit_=
tests/openvpn/siphash_openssl=2Ec</span><br><span>new file mode 100644</spa=
n><br><span>index 0000000=2E=2E90d248a</span><br><span>--- /dev/null</span>=
<br><span>+++ b/tests/unit_tests/openvpn/siphash_openssl=2Ec</span><br><spa=
n>@@ -0,0 +1,144 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An=
 application to securely tunnel IP networks</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with sup=
port for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *             session authentication and key exchange,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, pa=
cket authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             packet compression=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026=
 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  This program is free software; you can redistribute it and/or modif=
y</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the t=
erms of the GNU General Public License version 2</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundati=
on=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed=
 in the hope that it will be useful,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied war=
ranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHAN=
TABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for mor=
e details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have rece=
ived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;ht=
tps://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONF=
IG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_CRYPTO_OPENSSL</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &lt;openssl/opensslv=2E=
h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* OpenSSL siphash is currently 2-3 times slow=
er than the reference</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * implementation, so we only use for unit testing that our impelmentatio=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * and OpenSSL agr=
ee*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENA=
BLE_CRYPTO_OPENSSL) &amp;&amp; OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;openssl/=
evp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;crypto_openssl=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;crypto_backend=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+struct siphash_context</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    EVP_MAC *mac;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    EVP_MAC_CTX *ctx;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    size_t size;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    OSSL_PARAM params[3];</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  Computes a SipHash value</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * in: pointer to input data =
(read-only)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  inle=
n: input data length in bytes (any size_t value)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * k: pointer to the key data (read-only), mus=
t be 16 bytes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * out=
: pointer to output data (write-only), outlen bytes must be allocated</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  outlen: length of the=
 output in bytes, must be 8 or 16</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_openssl(vo=
id *sip_context, const void *in, const size_t inlen,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                const void *k, uint8_t *o=
ut, const size_t outlen)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct si=
phash_context *sip =3D sip_context;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;params[1] =
=3D OSSL_PARAM_construct_octet_string(&quot;key&quot;, (void *)k,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
                          SIPHASH_KEY_SIZE);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!EVP_MAC_init(sip-&gt;ctx, NULL, 0, sip-&g=
t;params))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        crypto_msg(M_FA=
TAL, &quot;EVP_MAC_init failed&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    EVP_MAC_update(sip-&gt;ctx, in, inlen);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    size_t outl =3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    EVP_MAC_final(sip-&gt;ctx, out, &amp;outl, outlen);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash=
_openssl_init(size_t hash_size)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct siphash_context *sip;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ALLOC_OBJ(sip, struct siphash_context);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    sip-&gt;mac =3D EVP_MAC_fetch(NULL, &quot;SIPHASH&quot;, NU=
LL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!sip-&g=
t;mac)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Our OpenSSL libr=
ary does not support SIPHASH */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return sip;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  sip-&gt;ctx =3D EVP_MAC_CTX_new(sip-&gt;mac);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* OpenSSL will truly hold a pointer to an int in that paramet=
er */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;si=
ze =3D hash_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  sip-&gt;params[0] =3D OSSL_PARAM_construct_size_t(&quot;size&quot;, &amp;=
sip-&gt;size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* params[1] will hold the key that changes which each invocation */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;params[2] =3D O=
SSL_PARAM_construct_end();</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return sip;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+siphash_openssl_available(void *sip_context)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct siphash_context *sip =3D sip_c=
ontext;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return (bool)(sip-&gt;mac);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+siphash_openssl_uninit(void *sip_context)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct siphash_context *sip =3D sip_context;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_CTX_free(sip-&gt;ctx);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_free(sip-&g=
t;mac);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(sip=
_context);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Do avoid a lot more ifdefs in the test=
 we put dummy functions here */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siph=
ash_openssl(void *sip_context, const void *in, const size_t inlen,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                const void *=
k, uint8_t *out, const size_t outlen)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+siphash_openssl_available(void *sip_context)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_openssl_init(size_=
t hash_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sipha=
sh_openssl_uninit(void *sip_context)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif /* if defined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; OP=
ENSSL_VERSION_NUMBER &gt;=3D 0x30000000L */</span><br><span>diff --git a/te=
sts/unit_tests/openvpn/siphash_openssl=2Eh b/tests/unit_tests/openvpn/sipha=
sh_openssl=2Eh</span><br><span>new file mode 100644</span><br><span>index 0=
000000=2E=2E9d9757d</span><br><span>--- /dev/null</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/siphash_openssl=2Eh</span><br><span>@@ -0,0 +1,60 @@<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * SipHash reference C implementation=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Copyright (c) 2012-2021 Jean-Phil=
ippe Aumasson</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * &lt=
;jeanphilippe=2Eaumasson@gmail=2Ecom&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Copyright (c) 2012-2014 Daniel J=2E Bernstein &lt;d=
jb@cr=2Eyp=2Eto&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * To the extent =
possible under law, the author(s) have dedicated all copyright</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * and related and neighboring r=
ights to this software to the public domain</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * worldwide=2E This software is distributed withou=
t any warranty=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * You should have =
received a copy of the CC0 Public Domain Dedication along</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * with</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * this software=2E If not, see</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * &lt;http://creativecommons=2Eorg/p=
ublicdomain/zero/1=2E0/&gt;=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef SIPHASH_OPENSSL_=
H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SIPHASH_OP=
ENSSL_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdint=2Eh&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdio=2Eh&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;std=
bool=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* Prototypes for an implementation of SIPHAS=
H in a crypto library */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param hash_size the size=
 of the output hash size</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @return initialised context for siphash</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
iphash_openssl_init(size_t hash_size);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Calculates SIPHASH using the cry=
pto library function=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+siphash_openssl(void *sip_co=
ntext, const void *in, size_t inlen,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                const void *k, uint8_t *out, size_t outlen=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Free the siphash context used for the crypto libr=
ary</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param sip_co=
ntext</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+siphash_openssl_uninit(void *sip_context);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Returns if the crypto library is available (and should=
 be used)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * This returns if there is=
 a crypto library version of Siphash24 is</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * available and should be used (OpenSSL 3/4 version =
is quite slow, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 we prefer the reference implementation)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_openssl_available(v=
oid *sip_context);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif /* ifndef SIPHASH_OPENSSL_H */</span><br><span>\ No newline at end of=
 file</span><br><span>diff --git a/tests/unit_tests/openvpn/test_crypto=2Ec=
 b/tests/unit_tests/openvpn/test_crypto=2Ec</span><br><span>index cb4eaa2=
=2E=2E8c8e371 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_cr=
ypto=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_crypto=2Ec</sp=
an><br><span>@@ -31,12 +31,15 @@</span><br><span> #include &lt;stdarg=2Eh&g=
t;</span><br><span> #include &lt;string=2Eh&gt;</span><br><span> #include &=
lt;setjmp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &lt;inttypes=2Eh&gt;</span><br><span> #include &lt;cmocka=2Eh&gt;</s=
pan><br><span> </span><br><span> #include &quot;crypto=2Eh&quot;</span><br>=
<span> #include &quot;crypto_epoch=2Eh&quot;</span><br><span> #include &quo=
t;options=2Eh&quot;</span><br><span> #include &quot;ssl_backend=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphas=
h=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;siphash_openssl=2Eh&quot;</span><br><span> </span><br><span> #includ=
e &quot;mss=2Eh&quot;</span><br><span> #include &quot;test_common=2Eh&quot;=
</span><br><span>@@ -923,6 +926,49 @@</span><br><span>     assert_memory_eq=
ual(key_parameters=2Ehmac, exp_impl_iv, sizeof(exp_impl_iv));</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* Use a define here since some c compilers don&#39;t like array initia=
lisation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * with an =
integer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define U=
T_SIPHASH_HASH_SIZE 16</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const cha=
r *ut_message =3D &quot;Look behind you, a Three-Headed Monkey!&quot;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static const uint8_t ut_=
key[SIPHASH_KEY_SIZE] =3D { 0x11, 0x22, 0x33, 0x44, 0x55, 0x66 };</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+const uint8_t expected_hash[U=
T_SIPHASH_HASH_SIZE] =3D { 0x3e, 0xea, 0x95, 0xb2, 0x6d, 0x5c, 0x4e, 0xfa,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                                  0x20, 0x47, 0x65, 0x7e, 0xdd, 0xcd, 0x62,=
 0x51 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+test_siphash(void **state)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    uint8_t out[UT_SIPHASH_HASH_SIZE] =3D { 0 };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    siphash_referenc=
e(ut_message, strlen(ut_message), ut_key, out, UT_SIPHASH_HASH_SIZE);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(o=
ut, expected_hash, UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+test_siphash_openssl(vo=
id **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    void *sipctx =3D sipha=
sh_openssl_init(UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (!siphash_openssl_available(sipctx))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        siphash_openssl_uninit(sipctx);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        skip();</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uin=
t8_t out[UT_SIPHASH_HASH_SIZE] =3D { 0 };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    siphash_openssl(sipctx, ut_message, strlen(ut_message), ut_key, out,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_memory_equal(out, expected_hash, UT_SIPHASH_HASH_SIZE);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* check that calling the function tw=
ice is safe */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
iphash_openssl(sipctx, ut_message, strlen(ut_message), ut_key, out,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    UT_SIPH=
ASH_HASH_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_memory_equal(out, expected_hash, UT_SIPHASH_HASH_SIZE);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    siphash_openssl_uninit(sipctx);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> int</span><br><span> main(void)</span><br><span> {</sp=
an><br><span>@@ -960,7 +1006,9 @@</span><br><span>         cmocka_unit_test=
_prestate_setup_teardown(crypto_test_epoch_edge,</span><br><span>          =
                                        crypto_test_epoch_setup,</span><br>=
<span>                                                  crypto_test_epoch_t=
eardown, &amp;prestate_num13),</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        cmocka_unit_test(epoch_test_derive_data_key)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(epoch_te=
st_derive_data_key),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        cmocka_unit_test(test_siphash),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        cmocka_unit_test(test_siphash_openssl)</span><=
br><span>     };</span><br><span> </span><br><span>     return cmocka_run_g=
roup_tests_name(&quot;crypto tests&quot;, tests, NULL, NULL);</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/31?usp=3Demail">change 31</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/31?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1=
bf7aa0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 31 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 21 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>

</body></html>
--WcrQDCvcFhY=--


--===============6339870793019512395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6339870793019512395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6339870793019512395==--

