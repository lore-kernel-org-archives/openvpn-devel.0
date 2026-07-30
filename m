Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B51C55162
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 11:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OrqvcMI4UM/eEEUBjnrgFp5ZpVH/5I1EqWM12fdt7Fo=; b=dZY1ps4xNdP+YWisODqzxi3+fT
	jZSiZPyeGwCxirqhmxwJuOh60ZLBljramiZBjL3Lwo93YmBnU5yAp+IRty7Yxit43ZKa8OvZo796P
	P/bJ6dzQSVn/HqR5mhneec/D7PoMNNJo4N6PvpJpXJfx+4JgSjk9Err+aK5Akgc8acXE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpOyI-0005PU-EP;
	Thu, 30 Jul 2026 11:30:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpOy8-0005PI-Ff
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 11:30:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=8eXQ5etYXx/9b0FfJHU/c+b1O9Sa1hdqzdfCMzc5i0w=; b=kx8LONrL4ljX0BMEzpzyuFYUuA
 7tqWYkCzDtHetayXRnptt4LC8QpQlgHQ+UpMfytI/yVuIUjouU0Pm7k4s7NQl4zjszvVdO8XVyuwg
 hjQ+2+RYCai1WmEYtrvbfB2x4kUvQguz2BtN5kSdq0c7V/F+3oGGGlyKBqRYFyQ+bcgk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8eXQ5etYXx/9b0FfJHU/c+b1O9Sa1hdqzdfCMzc5i0w=; b=C
 6uY+0Bpg6SV3OX3Q7faai/XF9f+s8LJ6rEEyRnKUIuo3ENaayjKrrDIur54Mq7v4pOkLkUu7TmtYJ
 WFlYcwYTH5v9ykvcTic631XLCgU5ZS32Yunw6iWAlw0kT8+spOJI5f0xx2Fv5/47oa3IFi8q1qhsq
 ECNzYtj7csPyrvwQ=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpOy9-0005al-EB for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 11:30:33 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso5156475e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 04:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785411023; x=1786015823; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8eXQ5etYXx/9b0FfJHU/c+b1O9Sa1hdqzdfCMzc5i0w=;
 b=Eq2TiWVFP/Tz3o/vCzip9w0zkVeD7VwffnFo4pGIn0u0UKpl3sDZAnjd6bOhRw8oic
 yvfz6uRQeivtZM3Z+R9SmCMS7/RMiFg6jm7UdmCcfxc5MOTwi4VJt885QSU+hlYWap4i
 k4CLIZNFu73DOcLJRA7Zv4AemkYyp0jPL9T1bGKvySqi2HA+6yEITKbApRVrQAFfj0zB
 H3lL2j28BCHtmQX7ksN7iu+m6k8AvkKhUHKzCJ8PdQe8DbnPp4PNlU5nD7/JpmVyhGRs
 ElkEE+1+FjCD2fCV4T1Tqx2zaPu5jKaEV0o1lxPDc3vGGKXT3o7GvTAkL5SLVB26AK8R
 I3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785411023; x=1786015823;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8eXQ5etYXx/9b0FfJHU/c+b1O9Sa1hdqzdfCMzc5i0w=;
 b=WbWGkgQYISg3V6vEJSuLpXVJ2B/DJ7MoEzcM8TgY7CJ0KnLApJT2Rp6GJ/H1IhN4KC
 9WoDeaygZm7qb6IzSswzi3pk+xMz1aqDvcUPRCuELTIViSV6366X3N2wtt0Lj9fLxy2l
 7JJGILT67FhBeho4R7t2AzQsQYDUr4kfUGslm5vwazY++h6HVevueRy+G3GYTHMZ39xP
 Tm3Qudaoq2Y2mmKYtKmzHm68TMo9N6vL0+Vi4VDdzsiYbMNzNlyLSaNI+hZ8NUKyukYx
 bZoDAzH7ttP80zApV6hQeSMFinVJ3Qh/Dy7SZ6D+35XlbqqsQjW1mKx6klYyfNuID7xj
 22kw==
X-Gm-Message-State: AOJu0YyxmVym6QJyks81AcuE+lmiApIw5gpLkO3Qp0wEJtdFgd/yN4m6
 mUmZsHguKkHXEO3LrrgoI+718UqN6/KK4nSgG55LMHM917RDkXORkgpnSQKBvcy3Wknc36hGpkV
 nS0gJDzyBNrogwkqWJ2hmUMMGQMpHFTAx5VMT5L1TfthiQkzIViG6bcmnoCpkhTjr6ZVeoPFIpq
 FYI2yKTg==
X-Gm-Gg: AR+sD13y68RuuhNtlspTme00Y6nT0M5du517I4J6pkgoOUE4msMZywW1va02QeHpr1K
 TZ4OSwVRInTvv67VeV17f0OdR0PfpkfFBBZiWGAFqQkygHQLnm17wNQg9TMaA4VCEXt0h4CCM4w
 mIfu2m4BOa0F5FsdIwYaHk/3r6YAhpHrGIHuyD9VuUMKmfewr9mh/rQpVRqU8hAOxfzhCF53UM9
 kq8gAa3b8RKv31qK5glKtBQbhEn7Kn0OaRT+WD6fvEZhPZ4r1isLR7TYTloAO25zr1s2oFLJ4XI
 HFEZ1y5TJjRzV63lJ/uqKSUCVytpH1LtcO63RnF6UirQbgFcmBunhGOR1Pci8TW5qFu0mhY6ot7
 Sgyvpl1DH4MVTiBYlUicJUoZU2x+nTtQacHslF7GllIBeJ36XI1bmnAk7TwS4yKTsglqsOfPvc3
 Sc6nLcadx71yXdM1Qo7gqwuN4+G+9BhdHTeFnfq3JIQU27GnKHDm0bNu5AspHcVYYYhUJSSz/z0
 GQqT3o1ze7ObDmFxbDjmo5+FgkvsSM2foH6T7b2cx+tmlYCO6pP0nuAMInv1vRwjtw2GYaMAv2x
 ZNRJ62H7c52tOKbsFAC3djVnfXnPz8LwiH1sxFAUD1yeUKJRcSc=
X-Received: by 2002:a05:600c:350e:b0:497:ff73:68d5 with SMTP id
 5b1f17b1804b1-49800e1fe0emr32124445e9.0.1785411022910; 
 Thu, 30 Jul 2026 04:30:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4980108c349sm53433175e9.0.2026.07.30.04.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 04:30:22 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 11:30:19 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 29
X-Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
X-Gerrit-Change-Number: 31
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/31?usp=email>
X-Gerrit-Commit: 8b9bb92c480c486a79abf2f8f0f922a71aa880ea
In-Reply-To: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwOWFhMjdjYWExYTNhYWIwZDFiZTYxMThiMjZkNTRhMWMxYmY3YWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9bfb017efa75d6f231282dc3d6872d0e96662f5d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpOy9-0005al-EB
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
Content-Type: multipart/mixed; boundary="===============4783708626172012505=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4783708626172012505==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="o7Ao1ywE2fc="; charset=UTF-8

--o7Ao1ywE2fc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail

to look at the new patc=
h set (#29)=2E

The following approvals got outdated and were removed:
Code=
-Review-1 by flichtenheld


Change subject: Use OpenSSL's SIPHASH implement=
ation to double check our implementation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

Use OpenSSL's SIPHASH implementation to double=
 check our implementation

OpenSSL library is currently slower than the ref=
erence implementation
(about 1=2E5x to 2x depending of the compiler)=2E

Th=
e OpenSSL API for using the SIPHASH MAC is different enough from using
norm=
al HMAC or Digest that we already implement that combining them into
one AP=
I does not make sense=2E

SIPHASH is only available on OpenSSL 3=2E1 and la=
ter=2E We still check for
support on 3=2E0 and later as the whole API to al=
low using the SIPHASH alrady
exists in OpenSSL 3=2E0=2E Some of the later O=
penSSL 3=2E0=2Ex might get support
for it=2E Theoretically, a provider can =
be loaded in OpenSSL 3=2E0 that
implements SIPHASH=2E

With OpenSSL's imple=
mentation being slower, we currently only use it to
check that our referenc=
e implementation and the OpenSSL implementation
yield the same result in un=
it tests

Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
Signed-off-b=
y: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=2Etxt
M src/openvpn/M=
akefile=2Eam
M src/openvpn/siphash=2Eh
M src/openvpn/siphash_reference=2Ec
=
M tests/unit_tests/openvpn/Makefile=2Eam
A tests/unit_tests/openvpn/siphash=
_openssl=2Ec
A tests/unit_tests/openvpn/siphash_openssl=2Eh
M tests/unit_te=
sts/openvpn/test_crypto=2Ec
8 files changed, 305 insertions(+), 8 deletions=
(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/31=
/31/29

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 7473f15=2E=
=2E9e1dde1 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -572,6 +=
572,8 @@
     src/openvpn/shaper=2Eh
     src/openvpn/sig=2Ec
     src/open=
vpn/sig=2Eh
+    src/openvpn/siphash=2Eh
+    src/openvpn/siphash_reference=
=2Ec
     src/openvpn/socket=2Ec
     src/openvpn/socket=2Eh
     src/openv=
pn/socket_util=2Ec
@@ -784,6 +786,7 @@
         )
 
     target_sources(tes=
t_crypto PRIVATE
+        tests/unit_tests/openvpn/siphash_openssl=2Ec
    =
     src/openvpn/crypto_mbedtls=2Ec
         src/openvpn/crypto_openssl=2Ec=

         src/openvpn/crypto_epoch=2Ec
@@ -792,6 +795,7 @@
         src/ope=
nvpn/packet_id=2Ec
         src/openvpn/mtu=2Ec
         src/openvpn/mss=2E=
c
+        src/openvpn/siphash_reference=2Ec
         )
 
     target_sourc=
es(test_ssl PRIVATE
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Ma=
kefile=2Eam
index ff8cc54=2E=2E1f77384 100644
--- a/src/openvpn/Makefile=2E=
am
+++ b/src/openvpn/Makefile=2Eam
@@ -128,6 +128,7 @@
 	session_id=2Ec ses=
sion_id=2Eh \
 	shaper=2Ec shaper=2Eh \
 	sig=2Ec sig=2Eh \
+	siphash_refer=
ence=2Ec siphash=2Eh \
 	socket=2Ec socket=2Eh \
 	socket_util=2Ec socket_u=
til=2Eh \
 	socks=2Ec socks=2Eh \
diff --git a/src/openvpn/siphash=2Eh b/sr=
c/openvpn/siphash=2Eh
index ef61110=2E=2Ebddddc3 100644
--- a/src/openvpn/s=
iphash=2Eh
+++ b/src/openvpn/siphash=2Eh
@@ -18,12 +18,26 @@
 #ifndef SIPHA=
SH_H
 #define SIPHASH_H
 
-#include <inttypes=2Eh>
+#include <stdint=2Eh>
+=
#include <stdio=2Eh>
+#include <stdbool=2Eh>
 
 /* siphash always uses 128-=
bit keys */
 #define SIPHASH_KEY_SIZE 16
 
-int siphash(const void *in, siz=
e_t inlen, const void *k, uint8_t *out,
-            size_t outlen);
+/**
+=
 * Calculates SIPHASH using the reference implementation
+ */
+int
+siphash=
_reference(const void *in, size_t inlen, const void *k,
+                  =
uint8_t *out, size_t outlen);
 
-#endif
+
+static inline int
+siphash(const=
 void *in, size_t inlen, const void *k,
+        uint8_t *out, size_t outle=
n)
+{
+    return siphash_reference(in, inlen, k, out, outlen);
+}
+
+#endi=
f /* ifndef SIPHASH_H */
\ No newline at end of file
diff --git a/src/openv=
pn/siphash_reference=2Ec b/src/openvpn/siphash_reference=2Ec
index b21a86e=
=2E=2Ead19a51 100644
--- a/src/openvpn/siphash_reference=2Ec
+++ b/src/open=
vpn/siphash_reference=2Ec
@@ -100,8 +100,8 @@
  *  outlen: length of the ou=
tput in bytes, must be 8 or 16
  */
 int
-siphash(const void *in, const siz=
e_t inlen, const void *k, uint8_t *out,
-        const size_t outlen)
+siph=
ash_reference(const void *in, const size_t inlen, const void *k, uint8_t *o=
ut,
+                  const size_t outlen)
 {
     const unsigned char *ni=
 =3D (const unsigned char *)in;
     const unsigned char *kk =3D (const uns=
igned char *)k;
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests=
/unit_tests/openvpn/Makefile=2Eam
index d861ef9=2E=2Eae15759 100644
--- a/t=
ests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefi=
le=2Eam
@@ -73,6 +73,7 @@
 crypto_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
 cr=
ypto_testdriver_SOURCES =3D test_crypto=2Ec \
 	mock_msg=2Ec mock_msg=2Eh t=
est_common=2Eh \
+	siphash_openssl=2Ec siphash_openssl=2Eh \
 	$(top_srcdir=
)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(top=
_srcdir)/src/openvpn/crypto_mbedtls=2Ec \
@@ -84,7 +85,8 @@
 	$(top_srcdir)=
/src/openvpn/platform=2Ec \
 	$(top_srcdir)/src/openvpn/mtu=2Ec \
 	$(top_s=
rcdir)/src/openvpn/win32-util=2Ec \
-	$(top_srcdir)/src/openvpn/mss=2Ec
+	$=
(top_srcdir)/src/openvpn/mss=2Ec \
+	$(top_srcdir)/src/openvpn/siphash_refe=
rence=2Ec
 
 dhcp_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(to=
p_srcdir)/src/compat @TEST_CFLAGS@ -DDHCP_UNIT_TEST
 dhcp_testdriver_LDFLAG=
S =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn
diff --git a/tests/unit_te=
sts/openvpn/siphash_openssl=2Ec b/tests/unit_tests/openvpn/siphash_openssl=
=2Ec
new file mode 100644
index 0000000=2E=2Ec301f2d
--- /dev/null
+++ b/te=
sts/unit_tests/openvpn/siphash_openssl=2Ec
@@ -0,0 +1,144 @@
+/*
+ *  OpenV=
PN -- An application to securely tunnel IP networks
+ *             over a =
single TCP/UDP port, with support for SSL/TLS-based
+ *             session=
 authentication and key exchange,
+ *             packet encryption, packet=
 authentication, and
+ *             packet compression=2E
+ *
+ *  Copyrig=
ht (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2026 =
Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *  This program is free software; y=
ou can redistribute it and/or modify
+ *  it under the terms of the GNU Gen=
eral Public License version 2
+ *  as published by the Free Software Founda=
tion=2E
+ *
+ *  This program is distributed in the hope that it will be us=
eful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+=
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GN=
U General Public License for more details=2E
+ *
+ *  You should have recei=
ved a copy of the GNU General Public License along
+ *  with this program; =
if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONF=
IG_H
+#include "config=2Eh"
+#endif
+
+#include "siphash=2Eh"
+
+#ifdef ENA=
BLE_CRYPTO_OPENSSL
+#include <openssl/opensslv=2Eh>
+#endif
+
+/* OpenSSL s=
iphash is currently 2-3 times slower than the reference
+ * implementation,=
 so we only use it for unit testing that our implementation
+ * and OpenSSL=
 agree */
+#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >=
=3D 0x30000000L
+#include <openssl/evp=2Eh>
+#include "crypto_openssl=2Eh"
=
+#include "crypto_backend=2Eh"
+#include "buffer=2Eh"
+
+struct siphash_con=
text
+{
+    EVP_MAC *mac;
+    EVP_MAC_CTX *ctx;
+    size_t size;
+    OS=
SL_PARAM params[3];
+};
+
+/*
+ *  Computes a SipHash value
+ * in: pointer=
 to input data (read-only)
+ *  inlen: input data length in bytes (any size=
_t value)
+ * k: pointer to the key data (read-only), must be 16 bytes
+ * =
out: pointer to output data (write-only), outlen bytes must be allocated
+ =
*  outlen: length of the output in bytes, must be 8 or 16
+ */
+int
+siphas=
h_openssl(void *sip_context, const void *in, const size_t inlen,
+         =
       const void *k, uint8_t *out, const size_t outlen)
+{
+    struct sip=
hash_context *sip =3D sip_context;
+
+
+    sip->params[1] =3D OSSL_PARAM_c=
onstruct_octet_string("key", (void *)k,
+                                  =
                     SIPHASH_KEY_SIZE);
+    if (!EVP_MAC_init(sip->ctx, NU=
LL, 0, sip->params))
+    {
+        crypto_msg(M_FATAL, "EVP_MAC_init fail=
ed");
+    }
+    EVP_MAC_update(sip->ctx, in, inlen);
+
+    size_t outl =
=3D 0;
+    EVP_MAC_final(sip->ctx, out, &outl, outlen);
+    return 0;
+}
=
+
+void *
+siphash_openssl_init(size_t hash_size)
+{
+    struct siphash_co=
ntext *sip;
+    ALLOC_OBJ(sip, struct siphash_context);
+
+    sip->mac =
=3D EVP_MAC_fetch(NULL, "SIPHASH", NULL);
+    if (!sip->mac)
+    {
+     =
   /* Our OpenSSL library does not support SIPHASH */
+        return sip;
=
+    }
+    sip->ctx =3D EVP_MAC_CTX_new(sip->mac);
+
+    /* OpenSSL will =
truly hold a pointer to an int in that parameter */
+    sip->size =3D hash=
_size;
+    sip->params[0] =3D OSSL_PARAM_construct_size_t("size", &sip->si=
ze);
+    /* params[1] will hold the key that changes which each invocation=
 */
+    sip->params[2] =3D OSSL_PARAM_construct_end();
+    return sip;
+}=

+
+bool
+siphash_openssl_available(void *sip_context)
+{
+    struct sipha=
sh_context *sip =3D sip_context;
+
+    return (bool)(sip->mac);
+}
+
+void=

+siphash_openssl_uninit(void *sip_context)
+{
+    struct siphash_context =
*sip =3D sip_context;
+    EVP_MAC_CTX_free(sip->ctx);
+    EVP_MAC_free(si=
p->mac);
+    free(sip_context);
+}
+#else
+/* Do avoid a lot more ifdefs i=
n the test we put dummy functions here */
+int
+siphash_openssl(void *sip_c=
ontext, const void *in, const size_t inlen,
+                const void *k,=
 uint8_t *out, const size_t outlen)
+{
+    return -1;
+}
+
+bool
+siphash_=
openssl_available(void *sip_context)
+{
+    return false;
+}
+
+void *
+si=
phash_openssl_init(size_t hash_size)
+{
+    return NULL;
+}
+
+void
+sipha=
sh_openssl_uninit(void *sip_context)
+{
+}
+
+
+#endif /* if defined(ENABLE=
_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >=3D 0x30000000L */
diff --git a=
/tests/unit_tests/openvpn/siphash_openssl=2Eh b/tests/unit_tests/openvpn/si=
phash_openssl=2Eh
new file mode 100644
index 0000000=2E=2E0f1d329
--- /dev/=
null
+++ b/tests/unit_tests/openvpn/siphash_openssl=2Eh
@@ -0,0 +1,64 @@
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
+#ifndef SIPHASH_OPENSSL_H
+#define SIPHASH_OPENSSL_H
+
+#include=
 <stdint=2Eh>
+#include <stdio=2Eh>
+#include <stdbool=2Eh>
+
+
+/* Prototy=
pes for an implementation of SIPHASH in a crypto library */
+/**
+ *
+ * @p=
aram hash_size the size of the output hash size
+ * @return initialised con=
text for siphash
+ */
+void *
+siphash_openssl_init(size_t hash_size);
+
+
=
+/**
+ * Calculates SIPHASH using the crypto library function=2E
+ */
+int
=
+siphash_openssl(void *sip_context, const void *in, size_t inlen,
+        =
        const void *k, uint8_t *out, size_t outlen);
+
+/**
+ * Free the si=
phash context used for the crypto library
+ * @param sip_context
+ */
+void=

+siphash_openssl_uninit(void *sip_context);
+
+/**
+ * Returns if the cryp=
to library is available (and should be used)
+ *
+ * This returns if there =
is a crypto library version of Siphash24 is
+ * available and should be use=
d (OpenSSL 3/4 version is quite slow, so
+ * we prefer the reference implem=
entation)
+ *
+ */
+bool
+siphash_openssl_available(void *sip_context);
+#e=
ndif /* ifndef SIPHASH_OPENSSL_H */
\ No newline at end of file
diff --git =
a/tests/unit_tests/openvpn/test_crypto=2Ec b/tests/unit_tests/openvpn/test_=
crypto=2Ec
index cb4eaa2=2E=2E77cf295 100644
--- a/tests/unit_tests/openvpn=
/test_crypto=2Ec
+++ b/tests/unit_tests/openvpn/test_crypto=2Ec
@@ -31,12 +=
31,15 @@
 #include <stdarg=2Eh>
 #include <string=2Eh>
 #include <setjmp=2E=
h>
+#include <inttypes=2Eh>
 #include <cmocka=2Eh>
 
 #include "crypto=2Eh"=

 #include "crypto_epoch=2Eh"
 #include "options=2Eh"
 #include "ssl_backen=
d=2Eh"
+#include "siphash=2Eh"
+#include "siphash_openssl=2Eh"
 
 #include =
"mss=2Eh"
 #include "test_common=2Eh"
@@ -923,6 +926,69 @@
     assert_memo=
ry_equal(key_parameters=2Ehmac, exp_impl_iv, sizeof(exp_impl_iv));
 }
 
+/*=
 Use a define here since some c compilers don't like array initialisation
+=
 * with an integer */
+#define UT_SIPHASH_HASH_SIZE 16
+
+static const char=
 *ut_message =3D "Look behind you, a Three-Headed Monkey!";
+static const u=
int8_t ut_key[SIPHASH_KEY_SIZE] =3D { 0x11, 0x22, 0x33, 0x44, 0x55, 0x66 };=

+const uint8_t expected_hash[UT_SIPHASH_HASH_SIZE] =3D { 0x3e, 0xea, 0x95,=
 0xb2, 0x6d, 0x5c, 0x4e, 0xfa,
+                                           =
           0x20, 0x47, 0x65, 0x7e, 0xdd, 0xcd, 0x62, 0x51 };
+
+static void=

+test_siphash(void **state)
+{
+    uint8_t out[UT_SIPHASH_HASH_SIZE] =3D =
{ 0 };
+    siphash_reference(ut_message, strlen(ut_message), ut_key, out, =
UT_SIPHASH_HASH_SIZE);
+    assert_memory_equal(out, expected_hash, UT_SIPH=
ASH_HASH_SIZE);
+}
+
+static void
+test_siphash_openssl(void **state)
+{
+ =
   void *sipctx =3D siphash_openssl_init(UT_SIPHASH_HASH_SIZE);
+
+    if (=
!siphash_openssl_available(sipctx))
+    {
+        siphash_openssl_uninit(=
sipctx);
+        skip();
+    }
+
+    uint8_t out[UT_SIPHASH_HASH_SIZE] =
=3D { 0 };
+
+    siphash_openssl(sipctx, ut_message, strlen(ut_message), u=
t_key, out,
+                    UT_SIPHASH_HASH_SIZE);
+    assert_memory_=
equal(out, expected_hash, UT_SIPHASH_HASH_SIZE);
+
+    /* check that calli=
ng the function twice is safe */
+    siphash_openssl(sipctx, ut_message, s=
trlen(ut_message), ut_key, out,
+                    UT_SIPHASH_HASH_SIZE);=

+    assert_memory_equal(out, expected_hash, UT_SIPHASH_HASH_SIZE);
+
+   =
 /* Test a few random strings and ensure that our implementation behave the=

+     * same */
+    for (int i =3D 0; i < 1000; i++)
+    {
+        size=
_t len =3D random() % 1000u;
+        uint8_t buf[1024] =3D { 0 };
+       =
 uint8_t key[SIPHASH_KEY_SIZE] =3D { 0 };
+
+        assert_true(rand_bytes=
(buf, (int)len));
+        assert_true(rand_bytes(key, sizeof(key)));
+
+
+=
        siphash_openssl(sipctx, buf, len, key, out, UT_SIPHASH_HASH_SIZE);
=
+
+        uint8_t outref[UT_SIPHASH_HASH_SIZE] =3D { 0 };
+        siphash=
_reference(buf, len, key, outref, UT_SIPHASH_HASH_SIZE);
+
+        assert_=
memory_equal(out, outref, UT_SIPHASH_HASH_SIZE);
+    }
+
+    siphash_open=
ssl_uninit(sipctx);
+}
+
+
 int
 main(void)
 {
@@ -960,7 +1026,9 @@
       =
  cmocka_unit_test_prestate_setup_teardown(crypto_test_epoch_edge,
        =
                                          crypto_test_epoch_setup,
        =
                                          crypto_test_epoch_teardown, &pres=
tate_num13),
-        cmocka_unit_test(epoch_test_derive_data_key)
+       =
 cmocka_unit_test(epoch_test_derive_data_key),
+        cmocka_unit_test(te=
st_siphash),
+        cmocka_unit_test(test_siphash_openssl)
     };
 
    =
 return cmocka_run_group_tests_name("crypto tests", tests, NULL, NULL);

--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I09aa27caa1a3aab0d1be6=
118b26d54a1c1bf7aa0
Gerrit-Change-Number: 31
Gerrit-PatchSet: 29
Gerrit-Own=
er: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--o7Ao1ywE2fc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #29</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail">View Change</a></p><p>The=
 following approvals got outdated and were removed:
Code-Review-1 by flicht=
enheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">Use OpenSSL&#39;s SIPHASH implementation to double =
check our implementation<br><br>OpenSSL library is currently slower than th=
e reference implementation<br>(about 1=2E5x to 2x depending of the compiler=
)=2E<br><br>The OpenSSL API for using the SIPHASH MAC is different enough f=
rom using<br>normal HMAC or Digest that we already implement that combining=
 them into<br>one API does not make sense=2E<br><br>SIPHASH is only availab=
le on OpenSSL 3=2E1 and later=2E We still check for<br>support on 3=2E0 and=
 later as the whole API to allow using the SIPHASH alrady<br>exists in Open=
SSL 3=2E0=2E Some of the later OpenSSL 3=2E0=2Ex might get support<br>for i=
t=2E Theoretically, a provider can be loaded in OpenSSL 3=2E0 that<br>imple=
ments SIPHASH=2E<br><br>With OpenSSL&#39;s implementation being slower, we =
currently only use it to<br>check that our reference implementation and the=
 OpenSSL implementation<br>yield the same result in unit tests<br><br>Chang=
e-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0<br>Signed-off-by: Arne Schw=
abe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvp=
n/Makefile=2Eam<br>M src/openvpn/siphash=2Eh<br>M src/openvpn/siphash_refer=
ence=2Ec<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests/unit_tests/=
openvpn/siphash_openssl=2Ec<br>A tests/unit_tests/openvpn/siphash_openssl=
=2Eh<br>M tests/unit_tests/openvpn/test_crypto=2Ec<br>8 files changed, 305 =
insertions(+), 8 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/31/31/29</pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 7473f15=2E=2E9e=
1dde1 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/C=
MakeLists=2Etxt</span><br><span>@@ -572,6 +572,8 @@</span><br><span>     sr=
c/openvpn/shaper=2Eh</span><br><span>     src/openvpn/sig=2Ec</span><br><sp=
an>     src/openvpn/sig=2Eh</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    src/openvpn/siphash=2Eh</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    src/openvpn/siphash_reference=2Ec</span><br><span>     =
src/openvpn/socket=2Ec</span><br><span>     src/openvpn/socket=2Eh</span><b=
r><span>     src/openvpn/socket_util=2Ec</span><br><span>@@ -784,6 +786,7 @=
@</span><br><span>         )</span><br><span> </span><br><span>     target_=
sources(test_crypto PRIVATE</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        tests/unit_tests/openvpn/siphash_openssl=2Ec</span><br><spa=
n>         src/openvpn/crypto_mbedtls=2Ec</span><br><span>         src/open=
vpn/crypto_openssl=2Ec</span><br><span>         src/openvpn/crypto_epoch=2E=
c</span><br><span>@@ -792,6 +795,7 @@</span><br><span>         src/openvpn/=
packet_id=2Ec</span><br><span>         src/openvpn/mtu=2Ec</span><br><span>=
         src/openvpn/mss=2Ec</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        src/openvpn/siphash_reference=2Ec</span><br><span>        =
 )</span><br><span> </span><br><span>     target_sources(test_ssl PRIVATE</=
span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefil=
e=2Eam</span><br><span>index ff8cc54=2E=2E1f77384 100644</span><br><span>--=
- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2E=
am</span><br><span>@@ -128,6 +128,7 @@</span><br><span> 	session_id=2Ec ses=
sion_id=2Eh \</span><br><span> 	shaper=2Ec shaper=2Eh \</span><br><span> 	s=
ig=2Ec sig=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	si=
phash_reference=2Ec siphash=2Eh \</span><br><span> 	socket=2Ec socket=2Eh \=
</span><br><span> 	socket_util=2Ec socket_util=2Eh \</span><br><span> 	sock=
s=2Ec socks=2Eh \</span><br><span>diff --git a/src/openvpn/siphash=2Eh b/sr=
c/openvpn/siphash=2Eh</span><br><span>index ef61110=2E=2Ebddddc3 100644</sp=
an><br><span>--- a/src/openvpn/siphash=2Eh</span><br><span>+++ b/src/openvp=
n/siphash=2Eh</span><br><span>@@ -18,12 +18,26 @@</span><br><span> #ifndef =
SIPHASH_H</span><br><span> #define SIPHASH_H</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#include &lt;inttypes=2Eh&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdint=2Eh&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;std=
io=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&lt;stdbool=2Eh&gt;</span><br><span> </span><br><span> /* siphash always us=
es 128-bit keys */</span><br><span> #define SIPHASH_KEY_SIZE 16</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int siphash(con=
st void *in, size_t inlen, const void *k, uint8_t *out,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            size_t outlen);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Calculates SIPHASH using the reference impleme=
ntation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+siphash_reference(const void *in, size_t inl=
en, const void *k,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                 uint8_t *out, size_t outlen);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static inline int</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+siphash(const void *in, size_t inlen, const void *k,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        uint8_t *out, size_t outl=
en)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return siphash_reference(in, i=
nlen, k, out, outlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef SIPHASH_H */</spa=
n><br><span>\ No newline at end of file</span><br><span>diff --git a/src/op=
envpn/siphash_reference=2Ec b/src/openvpn/siphash_reference=2Ec</span><br><=
span>index b21a86e=2E=2Ead19a51 100644</span><br><span>--- a/src/openvpn/si=
phash_reference=2Ec</span><br><span>+++ b/src/openvpn/siphash_reference=2Ec=
</span><br><span>@@ -100,8 +100,8 @@</span><br><span>  *  outlen: length of=
 the output in bytes, must be 8 or 16</span><br><span>  */</span><br><span>=
 int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-siphash(const voi=
d *in, const size_t inlen, const void *k, uint8_t *out,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        const size_t outlen)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+siphash_reference(const void *in=
, const size_t inlen, const void *k, uint8_t *out,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                  const size_t outlen)</span=
><br><span> {</span><br><span>     const unsigned char *ni =3D (const unsig=
ned char *)in;</span><br><span>     const unsigned char *kk =3D (const unsi=
gned char *)k;</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefi=
le=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index d861=
ef9=2E=2Eae15759 100644</span><br><span>--- a/tests/unit_tests/openvpn/Make=
file=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</spa=
n><br><span>@@ -73,6 +73,7 @@</span><br><span> crypto_testdriver_LDFLAGS =
=3D @TEST_LDFLAGS@</span><br><span> crypto_testdriver_SOURCES =3D test_cryp=
to=2Ec \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	siphash_openssl=2Ec sip=
hash_openssl=2Eh \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \=
</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=2Ec \</span><br><span> =
	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \</span><br><span>@@ -84,7 +8=
5,8 @@</span><br><span> 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br=
><span> 	$(top_srcdir)/src/openvpn/mtu=2Ec \</span><br><span> 	$(top_srcdir=
)/src/openvpn/win32-util=2Ec \</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	$(top_srcdir)/src/openvpn/mss=2Ec</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/mss=2Ec \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash=
_reference=2Ec</span><br><span> </span><br><span> dhcp_testdriver_CFLAGS  =
=3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@ -D=
DHCP_UNIT_TEST</span><br><span> dhcp_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ =
-L$(top_srcdir)/src/openvpn</span><br><span>diff --git a/tests/unit_tests/o=
penvpn/siphash_openssl=2Ec b/tests/unit_tests/openvpn/siphash_openssl=2Ec</=
span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2Ec301=
f2d</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/op=
envpn/siphash_openssl=2Ec</span><br><span>@@ -0,0 +1,144 @@</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP =
networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    over a single TCP/UDP port, with support for SSL/TLS-based</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *             session authentic=
ation and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             packet encryption, packet authentication, and</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compress=
ion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 Op=
enVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  Copyright (C) 2026 Arne Schwabe &lt;arne@rfc2549=2Eor=
g&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free softwa=
re; you can redistribute it and/or modify</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Lice=
nse version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as=
 published by the Free Software Foundation=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  This program is distributed in the hope that it will be useful=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT AN=
Y WARRANTY; without even the implied warranty of</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULA=
R PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  GNU General Public License for more details=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;siphash=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
ifdef ENABLE_CRYPTO_OPENSSL</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &lt;openssl/opensslv=2Eh&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Ope=
nSSL siphash is currently 2-3 times slower than the reference</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * implementation, so we only use=
 it for unit testing that our implementation</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * and OpenSSL agree */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if defined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; =
OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &lt;openssl/evp=2Eh&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto_openssl=2Eh&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;cryp=
to_backend=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct=
 siphash_context</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC *mac;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_CTX *ctx;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t size;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    OSSL_PARAM params[3]=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  Computes a SipHash value</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * in: pointer to input data (read-only)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  inlen: input data length in bytes (an=
y size_t value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * k=
: pointer to the key data (read-only), must be 16 bytes</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * out: pointer to output data (write-o=
nly), outlen bytes must be allocated</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  outlen: length of the output in bytes, must be 8 or 16=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+siphash_openssl(void *sip_context, const void *in, =
const size_t inlen,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                const void *k, uint8_t *out, const size_t outlen)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct siphash_context *sip =3D sip_context=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    sip-&gt;params[1] =3D OSSL_PARAM_construct_octet_str=
ing(&quot;key&quot;, (void *)k,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                                       SIPHASH_=
KEY_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!=
EVP_MAC_init(sip-&gt;ctx, NULL, 0, sip-&gt;params))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        crypto_msg(M_FATAL, &quot;EVP_MAC_init failed&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_update(sip-&gt;=
ctx, in, inlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t outl =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_final(s=
ip-&gt;ctx, out, &amp;outl, outlen);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+siphash_openssl_init(size_t hash_size)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct siphash_context *sip;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ(sip, struct=
 siphash_context);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;mac =3D =
EVP_MAC_fetch(NULL, &quot;SIPHASH&quot;, NULL);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!sip-&gt;mac)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* Our OpenSSL library does not support SIPHASH */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return sip;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;ctx =3D EVP_MAC_CTX_ne=
w(sip-&gt;mac);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* OpenSSL will tru=
ly hold a pointer to an int in that parameter */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    sip-&gt;size =3D hash_size;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;params[0] =3D OSSL_PAR=
AM_construct_size_t(&quot;size&quot;, &amp;sip-&gt;size);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* params[1] will hold the key th=
at changes which each invocation */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    sip-&gt;params[2] =3D OSSL_PARAM_construct_end();</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sip;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphas=
h_openssl_available(void *sip_context)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct siphash_context *sip =3D sip_context;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return (bool)(sip-&gt;mac);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+siphash_openssl_uninit(void *=
sip_context)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct siphash_contex=
t *sip =3D sip_context;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    EVP_MAC_CTX_free(sip-&gt;ctx);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    EVP_MAC_free(sip-&gt;mac);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    free(sip_context);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Do avoid a lot more ifdefs in the test we put dummy functions here */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+siphash_openssl(void *sip_context, c=
onst void *in, const size_t inlen,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                const void *k, uint8_t *out, const size_t ou=
tlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return -1;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_openss=
l_available(void *sip_context)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void *</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+siphash_openssl_init(size_t hash_size)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+siphash_openssl_uninit(void *sip_conte=
xt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if de=
fined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; OPENSSL_VERSION_NUMBER &gt;=3D 0x30=
000000L */</span><br><span>diff --git a/tests/unit_tests/openvpn/siphash_op=
enssl=2Eh b/tests/unit_tests/openvpn/siphash_openssl=2Eh</span><br><span>ne=
w file mode 100644</span><br><span>index 0000000=2E=2E0f1d329</span><br><sp=
an>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/siphash_ope=
nssl=2Eh</span><br><span>@@ -0,0 +1,64 @@</span><br><span style=3D"color: h=
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
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef SIPHASH_OPEN=
SSL_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SIPHAS=
H_OPENSSL_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdint=2Eh&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdio=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &l=
t;stdbool=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* Prototypes for an implementation of S=
IPHASH in a crypto library */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param hash_size the=
 size of the output hash size</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @return initialised context for siphash</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+siphash_openssl_init(size_t hash_size);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Calculates SIPHASH using t=
he crypto library function=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_openssl(void *=
sip_context, const void *in, size_t inlen,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                const void *k, uint8_t *out, size_t =
outlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Free the siphash context used for the crypt=
o library</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
sip_context</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+siphash_openssl_uninit(void *sip_contex=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Returns if the crypto library is available (and =
should be used)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This returns if th=
ere is a crypto library version of Siphash24 is</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * available and should be used (OpenSSL 3/4 ve=
rsion is quite slow, so</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * we prefer the reference implementation)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_openssl_avail=
able(void *sip_context);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif /* ifndef SIPHASH_OPENSSL_H */</span><br><span>\ No newline at =
end of file</span><br><span>diff --git a/tests/unit_tests/openvpn/test_cryp=
to=2Ec b/tests/unit_tests/openvpn/test_crypto=2Ec</span><br><span>index cb4=
eaa2=2E=2E77cf295 100644</span><br><span>--- a/tests/unit_tests/openvpn/tes=
t_crypto=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_crypto=2Ec=
</span><br><span>@@ -31,12 +31,15 @@</span><br><span> #include &lt;stdarg=
=2Eh&gt;</span><br><span> #include &lt;string=2Eh&gt;</span><br><span> #inc=
lude &lt;setjmp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &lt;inttypes=2Eh&gt;</span><br><span> #include &lt;cmocka=2Eh&=
gt;</span><br><span> </span><br><span> #include &quot;crypto=2Eh&quot;</spa=
n><br><span> #include &quot;crypto_epoch=2Eh&quot;</span><br><span> #includ=
e &quot;options=2Eh&quot;</span><br><span> #include &quot;ssl_backend=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
siphash=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;siphash_openssl=2Eh&quot;</span><br><span> </span><br><span> #=
include &quot;mss=2Eh&quot;</span><br><span> #include &quot;test_common=2Eh=
&quot;</span><br><span>@@ -923,6 +926,69 @@</span><br><span>     assert_mem=
ory_equal(key_parameters=2Ehmac, exp_impl_iv, sizeof(exp_impl_iv));</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* Use a define here since some c compilers don&#39;t like array =
initialisation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * wi=
th an integer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine UT_SIPHASH_HASH_SIZE 16</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static con=
st char *ut_message =3D &quot;Look behind you, a Three-Headed Monkey!&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const uint8=
_t ut_key[SIPHASH_KEY_SIZE] =3D { 0x11, 0x22, 0x33, 0x44, 0x55, 0x66 };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+const uint8_t expected_=
hash[UT_SIPHASH_HASH_SIZE] =3D { 0x3e, 0xea, 0x95, 0xb2, 0x6d, 0x5c, 0x4e, =
0xfa,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                                        0x20, 0x47, 0x65, 0x7e, 0xdd, 0xcd,=
 0x62, 0x51 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+test_siphash(void **state)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint8_t out[UT_SIPHASH_HASH_SIZE] =3D=
 { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    siphash_=
reference(ut_message, strlen(ut_message), ut_key, out, UT_SIPHASH_HASH_SIZE=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory=
_equal(out, expected_hash, UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_siphash_op=
enssl(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    void *sipctx =
=3D siphash_openssl_init(UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!siphash_openssl_available(sipctx))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        siphash_openssl_uninit(sipctx);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        skip();</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    uint8_t out[UT_SIPHASH_HASH_SIZE] =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    siphash_openssl(sipctx, ut_message, strlen(ut_message), =
ut_key, out,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_memory_equal(out, expected_hash, UT_SIPHASH_HASH=
_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* check that calling the f=
unction twice is safe */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    siphash_openssl(sipctx, ut_message, strlen(ut_message), ut_key, ou=
t,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_memory_equal(out, expected_hash, UT_SIPHASH_HASH_SIZE);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Test a few random strings and ensu=
re that our implementation behave the</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * same */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    for (int i =3D 0; i &lt; 1000; i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        size_t len =3D random() % 1000u;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        uint8_t buf[1024] =3D { 0 =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint8_t k=
ey[SIPHASH_KEY_SIZE] =3D { 0 };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 assert_true(rand_bytes(buf, (int)len));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        assert_true(rand_bytes(key, sizeof(key)));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        siphash_openssl(sipctx, buf, len, key, out, UT_SIPHA=
SH_HASH_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint8_t outref[U=
T_SIPHASH_HASH_SIZE] =3D { 0 };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        siphash_reference(buf, len, key, outref, UT_SIPHASH_HAS=
H_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        assert_memory_equal(ou=
t, outref, UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    siphash_openssl=
_uninit(sipctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> m=
ain(void)</span><br><span> {</span><br><span>@@ -960,7 +1026,9 @@</span><br=
><span>         cmocka_unit_test_prestate_setup_teardown(crypto_test_epoch_=
edge,</span><br><span>                                                  cry=
pto_test_epoch_setup,</span><br><span>                                     =
             crypto_test_epoch_teardown, &amp;prestate_num13),</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_test(epoch_tes=
t_derive_data_key)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       cmocka_unit_test(epoch_test_derive_data_key),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_siphash),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_t=
est(test_siphash_openssl)</span><br><span>     };</span><br><span> </span><=
br><span>     return cmocka_run_group_tests_name(&quot;crypto tests&quot;, =
tests, NULL, NULL);</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail">change 31<=
/a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div =
itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0=
9aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 31 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 29 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body><=
/html>
--o7Ao1ywE2fc=--


--===============4783708626172012505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4783708626172012505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4783708626172012505==--

