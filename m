Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697DDC531D0
	for <openvpn-devel@archiver.kernel.org>; Sun, 26 Jul 2026 00:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LQkohObJrkc5vNbYgfOy5/avjQv9gX0LcWA/P0YkBlU=; b=H5B/sKA6Ax6pn0ghyCj7DCOtSa
	aU4NKi9iEqrwIXT7xnzTV6OzeCsDVLIrYhDxMK7v2ksYqJ8qXWIWVWJ8dGur4SsDGA5+poF1YMXZ6
	/9wlzOoUX+J3hPPenmZb1t7+8ZaxpOgyvZOjObiokRPuhxziHUKqPAmXcDFe7mxkYMR4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnmnV-0007r0-HV;
	Sun, 26 Jul 2026 00:32:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnmnT-0007qt-SR
 for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 00:32:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=hH8b6KLSBHbFfDyXNUcolFFZmOoIq2tesfMKVSDGwSI=; b=V7vZI5B+HXzKgRtK1h8KxhHfpL
 IZQGf+6YNrtPhM5PiNMH/GdInfO/Z+sd9SbbOnrsCy7Ncs1xceLH6Q2Zjb2Vk1iGYRtBBbjYBsneA
 fO40kgSdYZ+h74SjdicXlcf5a/AqrOUsn0NSfIqeu4/FRtZWTz1O2g6LICtX8ZMBG7go=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hH8b6KLSBHbFfDyXNUcolFFZmOoIq2tesfMKVSDGwSI=; b=O
 iESkiS6wplOeLvv9ReVJ9RJG2g3QbxpcyTYob5vZ5hiui7Cc7/tmX/2C087D6IaeTkJA9WxS0J3GY
 TFIKm89EgcmK5CElMV1nLh8eTngqGZaMTIW6mpoGKoQPtjuGL+/kfc/8KzjlD3qjkLsyS1VaWwQWA
 SfIe2KKnVTtnL3Mk=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnmnV-0006Tf-G2 for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 00:32:52 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4954d29264cso7929225e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 17:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785025963; x=1785630763; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hH8b6KLSBHbFfDyXNUcolFFZmOoIq2tesfMKVSDGwSI=;
 b=d2ObL3xePxWoL3kEFaedFw8NYgnKPvtmwbHE8+t7IhK6+k/f5iH/aF+w1WGAQlY014
 oJiEYpUMJsYv2++48w9JZGn5wbDPWcgqA8beOZRi5XfQsLSgpbpGG+CY7V+xZ642KDLG
 euWkfd2lM2e9hunpgpGIRFNjHuE5JdxqNoyv3J0GcPM899fKg43nic4Gidc11fy/MkB6
 IasRYdMF+YNyuuXzaL3aCjZFobDAe/wwDNlZ61IoI/EgVhh7SIK7fKQVPie3IIvzdWSG
 mOHzO5a/G+lzL98BMIlcplKSeENkYq/inr0DFG2+I3lv9n8jG8oFpJXIvd66+myhN4+Y
 T7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785025963; x=1785630763;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hH8b6KLSBHbFfDyXNUcolFFZmOoIq2tesfMKVSDGwSI=;
 b=BMuCM/mHqt/dwqtX39+Vm7JHTVABZu82NxoLjFqHTHQ3UtoozNpZtTFY+/066RA+xs
 uhnEd8gzRjlre05H/8B3rAXmMxMm16rSMHSIYm/02SBxbthVcgf+RSB7yMGdLnJ0ycud
 PB5R0qtkXuznHUf8LMTMBBS71Ts2v5pBxQO01+s/kcJswxmkGjP3SqddzEp+VEI7s7Af
 S5HQxKItfcNbc4l6HhyPFJvHYiF9s3LYao79p1mU/qVGXu05SF3abKvFUzjyIcGykwdu
 E6ARr9NFckSkK7z9roWi/GXlprah+HaZldMvi1zPlEN6umfGUpO+g3wD5cm3CidVujWM
 Gulg==
X-Gm-Message-State: AOJu0Yy24pihP1tuf8mmYV27pEjnRKkg8d17Z65yJt17psaUjoipxTDc
 QV1juvFrezIxyELEAX4mYqKer27uE+5jALNe8Ut41XnrguWftzQxwcP8LQKuiiAvKdXJFcQBTBl
 NzreAw7dT/2MAnbH5oksKAA+oGlxR1NYbDPK4Mr53vpgkh+IFLTDztX+fwHhN8Ejl8OLJYCEOqy
 PEwfu8YQ==
X-Gm-Gg: AR+sD13kscOi/TpGSJHpkDt6diQigNKGg0o27VeigHk8tnG9AGi0+U5ndH1nNTrEWc+
 FRS3/+AFSBdbI/qNOCzlDq0LYM2Yf+U/GFa1WyUo0EbNXFm3k6x5et6+Yrasc2ZHb1YsxE11uys
 rH0EghfVjdAbhXWJhTHZ70s5QhsS7YkRm6PmCfgKr8Zdo81EqAyqVGFZxfOqSJYFz0TWGxgIYqh
 aKcMfVLkiFtoN8XN8t9Bp8Gsq9VstFJRXQ20tsCZyyuyDT1NP3M/PPw8fi8A9G7kmZYpw0PsN68
 d4R08Qm2HApmWQ9HHaw3dEk1cRpyy7cmmVlZLZ7SqeRQcBbl3pU6nibn71LnG3jTrHx9VGt2Ue8
 uUhidSuwTCXOZBL9BzqzK/Xx+RV1MGNDp5TpM/SdBy87rOAUPiuBBOTk2uxGPP6IH73dPWMTc51
 I2uFK+Y6rGP1IWfdJXO/4PF1ui7n3yI8Evy3CO6RHbp3oQnboKD60qj5kUX/e6dkxpKArfiuYGp
 1hFA//IrCSgKfm7LuJIS6Pj4xROhh5sZ1jg7oHWYLURbh5BjzN/M1UgmzXpRGWdvqZ0yY8RKrVg
 fSMDOD38833xow==
X-Received: by 2002:a05:600c:e557:20b0:493:b811:e549 with SMTP id
 5b1f17b1804b1-496b5725f66mr26263485e9.29.1785025962996; 
 Sat, 25 Jul 2026 17:32:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4858e28sm102647925e9.2.2026.07.25.17.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 17:32:42 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 26 Jul 2026 00:32:37 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 27
X-Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
X-Gerrit-Change-Number: 31
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/31?usp=email>
X-Gerrit-Commit: 95aff6db153999b0a95b62f22b2e2c0ff7bb8c99
In-Reply-To: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwOWFhMjdjYWExYTNhYWIwZDFiZTYxMThiMjZkNTRhMWMxYmY3YWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8abef8d26d2a4abf73ca74bbc306ebf5becde030-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnmnV-0006Tf-G2
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
Content-Type: multipart/mixed; boundary="===============5570116768293487739=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5570116768293487739==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="f0rw9tjPUvQ="; charset=UTF-8

--f0rw9tjPUvQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello flichtenheld, 

I=
'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/31?usp=3Demail

to look at the new patch set (#27)=2E=



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
8 files changed, 304 insertions(+), 8 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/31/31/27

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
index b21a86e=2E=2Ead19a51 100644
--- a/src/openvpn/siphash=
_reference=2Ec
+++ b/src/openvpn/siphash_reference=2Ec
@@ -100,8 +100,8 @@
=
  *  outlen: length of the output in bytes, must be 8 or 16
  */
 int
-siph=
ash(const void *in, const size_t inlen, const void *k, uint8_t *out,
-     =
   const size_t outlen)
+siphash_reference(const void *in, const size_t inl=
en, const void *k, uint8_t *out,
+                  const size_t outlen)
 {=

     const unsigned char *ni =3D (const unsigned char *)in;
     const uns=
igned char *kk =3D (const unsigned char *)k;
diff --git a/tests/unit_tests/=
openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index d861ef=
9=2E=2E287e0ae 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/te=
sts/unit_tests/openvpn/Makefile=2Eam
@@ -73,6 +73,7 @@
 crypto_testdriver_L=
DFLAGS =3D @TEST_LDFLAGS@
 crypto_testdriver_SOURCES =3D test_crypto=2Ec \
=
 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \
+	siphash_openssl=2Ec siphash=
_openssl=2Eh \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src=
/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \
@@ -=
84,7 +85,8 @@
 	$(top_srcdir)/src/openvpn/platform=2Ec \
 	$(top_srcdir)/sr=
c/openvpn/mtu=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
-	$(top_sr=
cdir)/src/openvpn/mss=2Ec
+	$(top_srcdir)/src/openvpn/mss=2Ec \
+	$(top_src=
dir)/src/openvpn/siphash_reference=2Ec
 
 dhcp_testdriver_CFLAGS  =3D -I$(t=
op_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@ -DDHCP_UNIT=
_TEST
 dhcp_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openv=
pn
@@ -97,6 +99,7 @@
 
 ssl_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/incl=
ude -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	-DPREFER_OPE=
NSSL_SIPHASH \
 	@TEST_CFLAGS@
 ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  =
$(OPTIONAL_CRYPTO_LIBS)
 ssl_testdriver_SOURCES =3D test_ssl=2Ec \
diff --g=
it a/tests/unit_tests/openvpn/siphash_openssl=2Ec b/tests/unit_tests/openvp=
n/siphash_openssl=2Ec
new file mode 100644
index 0000000=2E=2E90d248a
--- /=
dev/null
+++ b/tests/unit_tests/openvpn/siphash_openssl=2Ec
@@ -0,0 +1,144 =
@@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *   =
          over a single TCP/UDP port, with support for SSL/TLS-based
+ *   =
          session authentication and key exchange,
+ *             packet e=
ncryption, packet authentication, and
+ *             packet compression=2E=

+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Co=
pyright (C) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *  This program is=
 free software; you can redistribute it and/or modify
+ *  it under the ter=
ms of the GNU General Public License version 2
+ *  as published by the Fre=
e Software Foundation=2E
+ *
+ *  This program is distributed in the hope t=
hat it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the impl=
ied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E=
  See the
+ *  GNU General Public License for more details=2E
+ *
+ *  You =
should have received a copy of the GNU General Public License along
+ *  wi=
th this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
=
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "siphash=
=2Eh"
+
+#ifdef ENABLE_CRYPTO_OPENSSL
+#include <openssl/opensslv=2Eh>
+#en=
dif
+
+/* OpenSSL siphash is currently 2-3 times slower than the reference
=
+ * implementation, so we only use for unit testing that our impelmentation=

+ * and OpenSSL agree*/
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
index 0000000=2E=2E9d9757d=

--- /dev/null
+++ b/tests/unit_tests/openvpn/siphash_openssl=2Eh
@@ -0,0 +=
1,60 @@
+/*
+ * SipHash reference C implementation
+ *
+ * Copyright (c) 20=
12-2021 Jean-Philippe Aumasson
+ * <jeanphilippe=2Eaumasson@gmail=2Ecom>
+ =
* Copyright (c) 2012-2014 Daniel J=2E Bernstein <djb@cr=2Eyp=2Eto>
+ *
+ * =
To the extent possible under law, the author(s) have dedicated all copyrigh=
t
+ * and related and neighboring rights to this software to the public dom=
ain
+ * worldwide=2E This software is distributed without any warranty=2E
+=
 *
+ * You should have received a copy of the CC0 Public Domain Dedication =
along
+ * with
+ * this software=2E If not, see
+ * <http://creativecommons=
=2Eorg/publicdomain/zero/1=2E0/>=2E
+ */
+
+#ifndef SIPHASH_OPENSSL_H
+#def=
ine SIPHASH_OPENSSL_H
+
+#include <stdint=2Eh>
+#include <stdio=2Eh>
+#incl=
ude <stdbool=2Eh>
+
+
+/* Prototypes for an implementation of SIPHASH in a =
crypto library */
+/**
+ *
+ * @param hash_size the size of the output hash=
 size
+ * @return initialised context for siphash
+ */
+void *
+siphash_ope=
nssl_init(size_t hash_size);
+
+
+/**
+ * Calculates SIPHASH using the cryp=
to library function=2E
+ */
+int
+siphash_openssl(void *sip_context, const =
void *in, size_t inlen,
+                const void *k, uint8_t *out, size_=
t outlen);
+
+/**
+ * Free the siphash context used for the crypto library
=
+ * @param sip_context
+ */
+void
+siphash_openssl_uninit(void *sip_context=
);
+
+/**
+ * Returns if the crypto library is available (and should be use=
d)
+ *
+ * This returns if there is a crypto library version of Siphash24 i=
s
+ * available and should be used (OpenSSL 3/4 version is quite slow, so
+=
 * we prefer the reference implementation)
+ *
+ */
+bool
+siphash_openssl_=
available(void *sip_context);
+#endif /* ifndef SIPHASH_OPENSSL_H */
\ No n=
ewline at end of file
diff --git a/tests/unit_tests/openvpn/test_crypto=2Ec=
 b/tests/unit_tests/openvpn/test_crypto=2Ec
index cb4eaa2=2E=2E77cf295 1006=
44
--- a/tests/unit_tests/openvpn/test_crypto=2Ec
+++ b/tests/unit_tests/op=
envpn/test_crypto=2Ec
@@ -31,12 +31,15 @@
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
+#include "=
siphash_openssl=2Eh"
 
 #include "mss=2Eh"
 #include "test_common=2Eh"
@@ -=
923,6 +926,69 @@
     assert_memory_equal(key_parameters=2Ehmac, exp_impl_i=
v, sizeof(exp_impl_iv));
 }
 
+/* Use a define here since some c compilers =
don't like array initialisation
+ * with an integer */
+#define UT_SIPHASH_=
HASH_SIZE 16
+
+static const char *ut_message =3D "Look behind you, a Three=
-Headed Monkey!";
+static const uint8_t ut_key[SIPHASH_KEY_SIZE] =3D { 0x11=
, 0x22, 0x33, 0x44, 0x55, 0x66 };
+const uint8_t expected_hash[UT_SIPHASH_H=
ASH_SIZE] =3D { 0x3e, 0xea, 0x95, 0xb2, 0x6d, 0x5c, 0x4e, 0xfa,
+          =
                                            0x20, 0x47, 0x65, 0x7e, 0xdd, 0=
xcd, 0x62, 0x51 };
+
+static void
+test_siphash(void **state)
+{
+    uint8=
_t out[UT_SIPHASH_HASH_SIZE] =3D { 0 };
+    siphash_reference(ut_message, =
strlen(ut_message), ut_key, out, UT_SIPHASH_HASH_SIZE);
+    assert_memory_=
equal(out, expected_hash, UT_SIPHASH_HASH_SIZE);
+}
+
+static void
+test_si=
phash_openssl(void **state)
+{
+    void *sipctx =3D siphash_openssl_init(U=
T_SIPHASH_HASH_SIZE);
+
+    if (!siphash_openssl_available(sipctx))
+    {=

+        siphash_openssl_uninit(sipctx);
+        skip();
+    }
+
+    ui=
nt8_t out[UT_SIPHASH_HASH_SIZE] =3D { 0 };
+
+    siphash_openssl(sipctx, u=
t_message, strlen(ut_message), ut_key, out,
+                    UT_SIPHASH=
_HASH_SIZE);
+    assert_memory_equal(out, expected_hash, UT_SIPHASH_HASH_S=
IZE);
+
+    /* check that calling the function twice is safe */
+    sipha=
sh_openssl(sipctx, ut_message, strlen(ut_message), ut_key, out,
+          =
          UT_SIPHASH_HASH_SIZE);
+    assert_memory_equal(out, expected_has=
h, UT_SIPHASH_HASH_SIZE);
+
+    /* Test a few random strings and ensure th=
at our implementation behave the
+     * same */
+    for (int i =3D 0; i <=
 1000; i++)
+    {
+        size_t len =3D random() % 1000u;
+        uint8=
_t buf[1024] =3D { 0 };
+        uint8_t key[SIPHASH_KEY_SIZE] =3D { 0 };
+=

+        assert_true(rand_bytes(buf, (int)len));
+        assert_true(rand=
_bytes(key, sizeof(key)));
+
+
+        siphash_openssl(sipctx, buf, len, k=
ey, out, UT_SIPHASH_HASH_SIZE);
+
+        uint8_t outref[UT_SIPHASH_HASH_S=
IZE] =3D { 0 };
+        siphash_reference(buf, len, key, outref, UT_SIPHAS=
H_HASH_SIZE);
+
+        assert_memory_equal(out, outref, UT_SIPHASH_HASH_S=
IZE);
+    }
+
+    siphash_openssl_uninit(sipctx);
+}
+
+
 int
 main(void)=

 {
@@ -960,7 +1026,9 @@
         cmocka_unit_test_prestate_setup_teardown(=
crypto_test_epoch_edge,
                                                  c=
rypto_test_epoch_setup,
                                                  c=
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
Gerrit-PatchSet: 27
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>

--f0rw9tjPUvQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #27</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvp=
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
vpn/test_crypto=2Ec<br>8 files changed, 304 insertions(+), 8 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/31/31/27</pre><pre style=3D"font-family: monospace,monospac=
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
c</span><br><span>index b21a86e=2E=2Ead19a51 100644</span><br><span>--- a/s=
rc/openvpn/siphash_reference=2Ec</span><br><span>+++ b/src/openvpn/siphash_=
reference=2Ec</span><br><span>@@ -100,8 +100,8 @@</span><br><span>  *  outl=
en: length of the output in bytes, must be 8 or 16</span><br><span>  */</sp=
an><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-siph=
ash(const void *in, const size_t inlen, const void *k, uint8_t *out,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        const size_t outlen)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_reference(c=
onst void *in, const size_t inlen, const void *k, uint8_t *out,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                  const size_t =
outlen)</span><br><span> {</span><br><span>     const unsigned char *ni =3D=
 (const unsigned char *)in;</span><br><span>     const unsigned char *kk =
=3D (const unsigned char *)k;</span><br><span>diff --git a/tests/unit_tests=
/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><=
span>index d861ef9=2E=2E287e0ae 100644</span><br><span>--- a/tests/unit_tes=
ts/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Mak=
efile=2Eam</span><br><span>@@ -73,6 +73,7 @@</span><br><span> crypto_testdr=
iver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span> crypto_testdriver_SOURCES =
=3D test_crypto=2Ec \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh test_comm=
on=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	siphash_op=
enssl=2Ec siphash_openssl=2Eh \</span><br><span> 	$(top_srcdir)/src/openvpn=
/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=2Ec \</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \</span><br><spa=
n>@@ -84,7 +85,8 @@</span><br><span> 	$(top_srcdir)/src/openvpn/platform=2E=
c \</span><br><span> 	$(top_srcdir)/src/openvpn/mtu=2Ec \</span><br><span> =
	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/mss=2Ec</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/mss=2Ec \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/op=
envpn/siphash_reference=2Ec</span><br><span> </span><br><span> dhcp_testdri=
ver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TES=
T_CFLAGS@ -DDHCP_UNIT_TEST</span><br><span> dhcp_testdriver_LDFLAGS =3D @TE=
ST_LDFLAGS@ -L$(top_srcdir)/src/openvpn</span><br><span>@@ -97,6 +99,7 @@</=
span><br><span> </span><br><span> ssl_testdriver_CFLAGS  =3D \</span><br><s=
pan> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/sr=
c/openvpn \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-DPREFE=
R_OPENSSL_SIPHASH \</span><br><span> 	@TEST_CFLAGS@</span><br><span> ssl_te=
stdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)</span><br><spa=
n> ssl_testdriver_SOURCES =3D test_ssl=2Ec \</span><br><span>diff --git a/t=
ests/unit_tests/openvpn/siphash_openssl=2Ec b/tests/unit_tests/openvpn/siph=
ash_openssl=2Ec</span><br><span>new file mode 100644</span><br><span>index =
0000000=2E=2E90d248a</span><br><span>--- /dev/null</span><br><span>+++ b/te=
sts/unit_tests/openvpn/siphash_openssl=2Ec</span><br><span>@@ -0,0 +1,144 @=
@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to se=
curely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *             over a single TCP/UDP port, with support for SSL/TLS-b=
ased</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
session authentication and key exchange,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             packet encryption, packet authenticatio=
n, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *           =
  packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright=
 (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 Arne Schwabe &lt;=
arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This progr=
am is free software; you can redistribute it and/or modify</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU Ge=
neral Public License version 2</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  as published by the Free Software Foundation=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that =
it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  but WITHOUT ANY WARRANTY; without even the implied warranty of</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNES=
S FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  GNU General Public License for more details=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of th=
e GNU General Public License along</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eo=
rg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;siphash=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifdef ENABLE_CRYPTO_OPENSSL</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &lt;openssl/opensslv=2Eh&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* OpenSSL siphash is currently 2-3 times slower than the referen=
ce</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * implementation=
, so we only use for unit testing that our impelmentation</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * and OpenSSL agree*/</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_CRYPTO_OPENSSL)=
 &amp;&amp; OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &lt;openssl/evp=2Eh&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto_opens=
sl=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;crypto_backend=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+struct siphash_context</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP_M=
AC *mac;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC=
_CTX *ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_=
t size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OSSL_PAR=
AM params[3];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
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
yle=3D"color: hsl(120, 100%, 40%);">+siphash_openssl(void *sip_context, con=
st void *in, const size_t inlen,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                const void *k, uint8_t *out, const size_t outl=
en)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct siphash_context *sip =
=3D sip_context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;params[1] =3D OSSL_PARAM_cons=
truct_octet_string(&quot;key&quot;, (void *)k,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                                =
       SIPHASH_KEY_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!EVP_MAC_init(sip-&gt;ctx, NULL, 0, sip-&gt;params))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        crypto_msg(M_FATAL, &quot;EVP_MAC=
_init failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_u=
pdate(sip-&gt;ctx, in, inlen);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size=
_t outl =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    E=
VP_MAC_final(sip-&gt;ctx, out, &amp;outl, outlen);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_openssl_init(size=
_t hash_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct siphash_conte=
xt *sip;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_O=
BJ(sip, struct siphash_context);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    si=
p-&gt;mac =3D EVP_MAC_fetch(NULL, &quot;SIPHASH&quot;, NULL);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!sip-&gt;mac)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* Our OpenSSL library does not suppo=
rt SIPHASH */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return sip;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;ctx =3D =
EVP_MAC_CTX_new(sip-&gt;mac);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Op=
enSSL will truly hold a pointer to an int in that parameter */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;size =3D hash_size;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;params[0=
] =3D OSSL_PARAM_construct_size_t(&quot;size&quot;, &amp;sip-&gt;size);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* params[1] will h=
old the key that changes which each invocation */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    sip-&gt;params[2] =3D OSSL_PARAM_construc=
t_end();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
sip;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+siphash_openssl_available(void *sip_context)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct siphash_context *sip =3D sip_context;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return (bool)(sip-&gt;mac);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_openss=
l_uninit(void *sip_context)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 siphash_context *sip =3D sip_context;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    EVP_MAC_CTX_free(sip-&gt;ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_free(sip-&gt;mac);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    free(sip_context);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* Do avoid a lot more ifdefs in the test we put dummy func=
tions here */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_openssl(void *=
sip_context, const void *in, const size_t inlen,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                const void *k, uint8_t *out, c=
onst size_t outlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return -1;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
siphash_openssl_available(void *sip_context)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+siphash_openssl_init(size_t hash_size)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_openssl_uninit(v=
oid *sip_context)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif /* if defined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; OPENSSL_VERSION_NUMBE=
R &gt;=3D 0x30000000L */</span><br><span>diff --git a/tests/unit_tests/open=
vpn/siphash_openssl=2Eh b/tests/unit_tests/openvpn/siphash_openssl=2Eh</spa=
n><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E9d9757d=
</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openv=
pn/siphash_openssl=2Eh</span><br><span>@@ -0,0 +1,60 @@</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * SipHash reference C implementation</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Copyright (c) 2012-2021 Jean-Philippe Aumasson</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * &lt;jeanphilippe=2Eaum=
asson@gmail=2Ecom&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Copyright (c) 2012-2014 Daniel J=2E Bernstein &lt;djb@cr=2Eyp=2Eto&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * To the extent possible under law,=
 the author(s) have dedicated all copyright</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * and related and neighboring rights to this softw=
are to the public domain</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * worldwide=2E This software is distributed without any warranty=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * You should have received a copy of =
the CC0 Public Domain Dedication along</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * with</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * this software=2E If not, see</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * &lt;http://creativecommons=2Eorg/publicdomain/zero/1=
=2E0/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef SIPHASH_OPENSSL_H</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define SIPHASH_OPENSSL_H</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &lt;stdint=2Eh&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdio=2Eh&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdbool=2Eh&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Prototypes for an implementation of SIPHASH in a crypto l=
ibrary */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
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
errit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I09aa27caa1a3aab0d1be6=
118b26d54a1c1bf7aa0 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 31 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 27 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>

</body></html>
--f0rw9tjPUvQ=--


--===============5570116768293487739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5570116768293487739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5570116768293487739==--

