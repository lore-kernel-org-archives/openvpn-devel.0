Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5B1C531FA
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=wtGBrkYxqg1XatmA6/Dn4B8ccqWxtffl2X+z3SE+wNY=; b=DBODai9k8WfVvD
	QkjbPkS9jocxJ8g6tjHMXr/Vr/kWSItcsjHMvhoW0nHaBRonKnePO9FuU6j+j5m9h8UebrUFMrA5M
	hObAvJfnMiynMbyAQZzTgOtx+fiICqJ1DTBYj+4kpbPr/j1OC4gg0N9OcpG1OJ50K6BJiUUKxuJEf
	pNY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnHXb-0001Ju-8s;
	Fri, 24 Jul 2026 15:10:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnHXa-0001Jn-MJ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:10:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ICTK9QKKl2RLHfm76TG71zeA7HAl2PeDtgb65QCGKCw=; b=goHOl3LKK1ZiSwgsqrQ3HwHQ8d
 NJuhzZkHH9DdgQ2ok4Fg/XfE/M69g9OKx07hOqBMiz8YLK5KGThe9qBLdtsEM1PWixWrhOZhdXzO7
 +1HIJIaTVDaCrYYnW7tD5Nc4HUDCCb2GGKqWlRfcuHV6BUE1QiWZ12T5QEtI3Rkxv280=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ICTK9QKKl2RLHfm76TG71zeA7HAl2PeDtgb65QCGKCw=; b=a
 6D5t3MUEaXbnwmSS9Pf2FasV6IddxAoCx8w9jp/hoDa5ABgtbLvEyAIyS+/OR3CR+UE0B47zW+sFn
 CVDiqR6+uoBrMjS2/A7k8aco6OIE+US1zZrYzWh2My9wYm4lIK4KQyKWuC3UAhCuVP69crAWYz/eh
 VSWqaYzQTwm2CYnY=;
Received: from mail-ej1-f51.google.com ([209.85.218.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnHXY-0006iP-AM for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:10:22 +0000
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c1600d040e4so73737266b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 08:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784905814; x=1785510614; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ICTK9QKKl2RLHfm76TG71zeA7HAl2PeDtgb65QCGKCw=;
 b=hUqVsfobTAs+fnglYvC4kUUb9hLjxwqabzXmeGkAWXwsROOHNCGwFhjgz7UxWaRhho
 CKFc16SfIdOcGlHcPEBBb8PYUcxjNIH9zxc39fEh/lLOvYdKLdOgMeiSEna0wr0ymHeD
 7KR8sQfsBBOMCxOCtp1Bc2mzAHseqL6BqzXTr+qGWtZ2dZHlDvz0OoEBqpnwclHXotMO
 6aYgTOYhKVfjMGSZ1oeXdYSWs3yfvBdEQ5EgbJvbpw2nhTfAK5Bug5XRTslzG500rKOj
 PQPgyd2OebMOjxHqGxgcUdZapC0VJ9th5zV9VSHMjTedoGaKPjX3K7QaMZhR1bhucIsA
 +73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784905814; x=1785510614;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ICTK9QKKl2RLHfm76TG71zeA7HAl2PeDtgb65QCGKCw=;
 b=YgDRGeGJcrJTTdwrjaY0QddQQba/ujhrijrKPyHShe9b58MX0LANfI7MUrk3QNOIYa
 tZTHFEJ3LWXJOLb47H8O5flOYqo5WNRA9h5nMg8fpatpx5tSIShX0lq2xotjlzLfOJWw
 EctlwCSmeWTsNivUbSWGCUxrQxIAI8n5e5dBOEvVbt91nHhJudCjNEYOFSTfIQUVtxzn
 2LzgTT3fq87Fr3oIbgXmzeohZK8O0W/snihT9PalvpI9Tz8yW5g+GH7c4UNFlOKUwvry
 laI+On3FQOtcP7P4xNKRNpl6sxGJhfiKyuY9+S+BmCzF4aPn4NWzRqlzx4oZIaVTklEY
 RKxw==
X-Gm-Message-State: AOJu0YwYWCbKyBBtQqm0sI9333lH69j0GPZCbh7yZ2n3jvRhjH1Iom1q
 +jObMxH2LsH1IJd+rk0qT9cCGms5fscbJhPppv6o5/wWbxz1oJdOkiDwaXHk8d3b7+X1wWDdyIP
 XJNoHpUppozlg+k5XMyq975eY9rt51MuUghJUCkLn0H+T1Z0gQsyBITtmTzG1TaCMU71YSp22HL
 VSLBPMWg==
X-Gm-Gg: AR+sD10QJm5+VrKglWjaAM5L5P+MiIkH85FcMN2DMG0m9neGGZ7nK2F3dBo5XjU+6iB
 XdoOr7AbI0G8xM6xnVizd0DZGf1adounZmZVcMLIhG4ZX8GL6c8NCAEOXhyJehD1njPRA/AI0Ih
 GBHuAgCJVfCk9GPEA2tOp3wNRTdTtZxfQWI2+3K4xuphuwZXc6y5y6F2q3K/31zBzFdRY4DMfFv
 axg49dnNQGaryZTbRDgVrWLdv+f5EF2ZrRh5HKCTTWScd8NvgS9Vri7w/gglw0/DO2RnGOKxWDl
 6SNDyxpP9aqxOoJjuZ2GMyPhiaiNGqaBOBQeawHrTs0uaD+t3xDpcrzblNnxmw5rxAhCen0hACQ
 R6puT8spohr6ZjziyeS9UFpTg59wO7uhKGhxUwohYXU5sBH8SAPdNvC4oI96bblWAK9rD7FztCF
 VfJUWlbzMUqCLQshx844l/9x36SXLUtQpxr9Lqt/vpShFKhrkuKlaPeaoeAGJveCh5hKSaZDKBu
 5nBh+r6WxMgma9cB166vATeYGqRF/gYP5q3CsogsiTQWUuWdoqB+lq7c4u8ct61lhpK
X-Received: by 2002:a05:600c:c494:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-496997235c1mr7834165e9.6.1784901911759; 
 Fri, 24 Jul 2026 07:05:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af910besm87979135e9.14.2026.07.24.07.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 07:05:11 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 14:05:10 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iae76f10fa683369ca3f718dc24fd54560bb74112
X-Gerrit-Change-Number: 1821
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1821?usp=email>
X-Gerrit-Commit: 9d7e5ed1101d19f463ac9351d617f8a74b5346c4
References: <gerrit.1784824991000.Iae76f10fa683369ca3f718dc24fd54560bb74112@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0ODI0OTkxMDAwLklhZTc2ZjEwZmE2ODMzNjljYTNmNzE4ZGMyNGZkNTQ1NjBiYjc0MTEyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <11297ec0a52f4a58c4c452a44ebf9cd2ff334afc-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnHXY-0006iP-AM
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Drop support for
 OpenSSL 1.1.0
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7357521716291779804=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7357521716291779804==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CwxOCl5lQow="; charset=UTF-8

--CwxOCl5lQow=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1821?usp=3Demail

to review the following change=2E


Chang=
e subject: Drop support for OpenSSL 1=2E1=2E0
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Drop support for OpenSSL 1=2E1=2E0

Slig=
ht simplification of the code since we can then
assume that TLS 1=2E3 suppo=
rt is present=2E

Change-Id: Iae76f10fa683369ca3f718dc24fd54560bb74112
Sign=
ed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M INSTALL
M conf=
igure=2Eac
M src/openvpn/openssl_compat=2Eh
M src/openvpn/ssl_openssl=2Ec
M=
 tests/unit_tests/openvpn/test_ncp=2Ec
5 files changed, 16 insertions(+), 7=
8 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/21/1821/1

diff --git a/INSTALL b/INSTALL
index 77656b2c=2E=2E783=
90d5 100644
--- a/INSTALL
+++ b/INSTALL
@@ -66,10 +66,10 @@
   (1) TUN and/=
or TAP driver to allow user-space programs to control
       a virtual poin=
t-to-point IP or Ethernet device=2E
       See TUN/TAP Driver References se=
ction below for more info=2E
-  (2a) OpenSSL library, necessary for encrypt=
ion, version 1=2E1=2E0 or higher
+  (2a) OpenSSL library, necessary for enc=
ryption, version 1=2E1=2E1 or higher
       required, available from https:=
//www=2Eopenssl=2Eorg/
       or
-  (2b) mbed TLS library, an alternative f=
or encryption, version 2=2E0 or higher
+  (2b) mbed TLS library, an alterna=
tive for encryption, version 3=2E2=2E1 or higher
       required, available=
 from https://tls=2Embed=2Eorg/
   (3) on Linux, "libnl-gen" is required fo=
r kernel netlink support
   (4) on Linux, "libcap-ng" is required for Linux=
 capability handling
diff --git a/configure=2Eac b/configure=2Eac
index 188=
f8fa=2E=2E1aec805 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -776,=
7 +776,7 @@
 		# if the user did not explicitly specify flags, try to autod=
etect
 		PKG_CHECK_MODULES(
 			[OPENSSL],
-			[openssl >=3D 1=2E1=2E0],
+	=
		[openssl >=3D 1=2E1=2E1],
 			[have_openssl=3D"yes"],
 			[AC_MSG_WARN([O=
penSSL not found by pkg-config ${pkg_config_found}])] # If this fails, we w=
ill do another test next
 		)
@@ -799,7 +799,7 @@
 				]],
 				[[
 /*	    =
 Version encoding: MNNFFPPS - see opensslv=2Eh for details */
-#if OPENSSL_=
VERSION_NUMBER < 0x10100000L
+#if OPENSSL_VERSION_NUMBER < 0x10101000L
 #er=
ror OpenSSL too old
 #endif
 				]]
diff --git a/src/openvpn/openssl_compat=
=2Eh b/src/openvpn/openssl_compat=2Eh
index b61bcbf=2E=2E098bdd5 100644
---=
 a/src/openvpn/openssl_compat=2Eh
+++ b/src/openvpn/openssl_compat=2Eh
@@ -=
26,9 +26,9 @@
  * OpenSSL compatibility stub
  *
  * This file provide comp=
atibility stubs for the OpenSSL libraries
- * prior to version 1=2E1=2E Thi=
s version introduces many changes in the
- * library interface, including t=
he fact that various objects and
- * structures are not fully opaque=2E
+ *=
 prior to the current major version=2E Newer versions may introduce changes=

+ * in the library interface, including replacing functions or enforcing
+=
 * various objects and structures as fully opaque=2E
  */
 
 #ifndef OPENSS=
L_COMPAT_H_
@@ -62,11 +62,6 @@
 #endif
 
 
-/* Functionality missing in 1=
=2E1=2E0 */
-#if OPENSSL_VERSION_NUMBER < 0x10101000L && !defined(ENABLE_CR=
YPTO_WOLFSSL)
-#define SSL_CTX_set1_groups SSL_CTX_set1_curves
-#endif
-
 /=
* Functionality missing in LibreSSL before 3=2E5 */
 #if defined(LIBRESSL_V=
ERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x3050000fL
 #define EVP_CTRL_A=
EAD_SET_TAG EVP_CTRL_GCM_SET_TAG
diff --git a/src/openvpn/ssl_openssl=2Ec b=
/src/openvpn/ssl_openssl=2Ec
index ef99b22=2E=2E32b13db 100644
--- a/src/op=
envpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -200,42 +200,12 =
@@
 
 /*
  * Return maximum TLS version supported by local OpenSSL library=
=2E
- * Assume that presence of SSL_OP_NO_TLSvX macro indicates that
- * TL=
SvX is supported=2E
+ * We only support OpenSSL versions that support TLS 1=
=2E3=2E
  */
 int
 tls_version_max(void)
 {
-#if defined(TLS1_3_VERSION)
- =
   /* If this is defined we can safely assume TLS 1=2E3 support */
     ret=
urn TLS_VER_1_3;
-#elif OPENSSL_VERSION_NUMBER >=3D 0x10100000L
-    /*
-  =
   * If TLS_VER_1_3 is not defined, we were compiled against a version that=

-     * did not support TLS 1=2E3=2E
-     *
-     * However, the library =
we are *linked* against might be OpenSSL 1=2E1=2E1
-     * and therefore su=
pports TLS 1=2E3=2E This needs to be checked at runtime
-     * since we ca=
n be compiled against 1=2E1=2E0 and then the library can be
-     * upgrade=
d to 1=2E1=2E1=2E
-     * We only need to check this for OpenSSL versions t=
hat can be
-     * upgraded to 1=2E1=2E1 without recompile (>=3D 1=2E1=2E0)=

-     */
-    if (OpenSSL_version_num() >=3D 0x1010100fL)
-    {
-        =
return TLS_VER_1_3;
-    }
-    else
-    {
-        return TLS_VER_1_2;
- =
   }
-#elif defined(TLS1_2_VERSION) || defined(SSL_OP_NO_TLSv1_2)
-    retu=
rn TLS_VER_1_2;
-#elif defined(TLS1_1_VERSION) || defined(SSL_OP_NO_TLSv1_1=
)
-    return TLS_VER_1_1;
-#else /* if defined(TLS1_3_VERSION) */
-    ret=
urn TLS_VER_1_0;
-#endif
 }
 
 /** Convert internal version number to opens=
sl version number */
@@ -256,22 +226,7 @@
     }
     else if (ver =3D=3D T=
LS_VER_1_3)
     {
-        /*
-         * Supporting the library upgraded =
to TLS1=2E3 without recompile
-         * is enough to support here with a =
simple constant that the same
-         * as in the TLS 1=2E3, so spec it i=
s very unlikely that OpenSSL
-         * will change this constant
-       =
  */
-#ifndef TLS1_3_VERSION
-        /*
-         * We do not want to defi=
ne TLS_VER_1_3 if not defined
-         * since other parts of the code use=
 the existance of this macro
-         * as proxy for TLS 1=2E3 support
-  =
       */
-        return 0x0304;
-#else
         return TLS1_3_VERSION;
-#=
endif
     }
     return 0;
 }
@@ -491,8 +446,8 @@
      */
     if (strlen=
(ciphers) >=3D (len - 1))
     {
-        msg(M_FATAL, "Failed to set restr=
icted TLS 1=2E3 cipher list, too long (>%d)=2E",
-            (int)(len - 1=
));
+        msg(M_FATAL, "Failed to set restricted TLS 1=2E3 cipher list, =
too long (>%zd)=2E",
+            len - 1);
     }
 
     strncpy(openssl_c=
iphers, ciphers, len);
@@ -511,17 +466,11 @@
 {
     if (ciphers =3D=3D NUL=
L)
     {
-        /* default cipher list of OpenSSL 1=2E1=2E1 is sane, do =
not set own
+        /* default cipher list of OpenSSL is sane, do not set =
own
          * default as we do with tls-cipher */
         return;
     }=

 
-#if !defined(TLS1_3_VERSION)
-    crypto_msg(M_WARN,
-               "N=
ot compiled with OpenSSL 1=2E1=2E1 or higher=2E "
-               "Ignoring=
 TLS 1=2E3 only tls-ciphersuites '%s' setting=2E",
-               ciphers)=
;
-#else
     ASSERT(NULL !=3D ctx);
 
     char openssl_ciphers[4096];
@@ =
-531,14 +480,12 @@
     {
         crypto_msg(M_FATAL, "Failed to set restr=
icted TLS 1=2E3 cipher list: %s", openssl_ciphers);
     }
-#endif
 }
 
 vo=
id
 tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)=

 {
-#if OPENSSL_VERSION_NUMBER > 0x10100000L                              =
              \
-    && (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERS=
ION_NUMBER > 0x3060000fL) \
+#if (!defined(LIBRESSL_VERSION_NUMBER) || LIBR=
ESSL_VERSION_NUMBER > 0x3060000fL) \
     && !defined(OPENSSL_IS_AWSLC)
   =
  /* OpenSSL does not have certificate profiles, but a complex set of
     =
 * callbacks that we could try to implement to achieve something similar=2E=

@@ -565,7 +512,7 @@
     {
         msg(M_FATAL, "ERROR: Invalid cert prof=
ile: %s", profile);
     }
-#else  /* if OPENSSL_VERSION_NUMBER > 0x1010000=
0L */
+#else
     if (profile)
     {
         msg(M_WARN,
@@ -573,7 +520,7=
 @@
             "support --tls-cert-profile, ignoring user-set profile: '%=
s'",
             profile);
     }
-#endif /* if OPENSSL_VERSION_NUMBER > 0=
x10100000L */
+#endif
 }
 
 void
@@ -2597,14 +2544,12 @@
         crypto_ms=
g(M_FATAL, "Cannot create SSL_CTX object");
     }
 
-#if defined(TLS1_3_VE=
RSION)
     if (tls13)
     {
         SSL_CTX_set_min_proto_version(tls_ct=
x=2Ectx, TLS1_3_VERSION);
         tls_ctx_restrict_ciphers_tls13(&tls_ctx,=
 cipher_list);
     }
     else
-#endif
     {
         SSL_CTX_set_max_pro=
to_version(tls_ctx=2Ectx, TLS1_2_VERSION);
         tls_ctx_restrict_cipher=
s(&tls_ctx, cipher_list);
@@ -2618,7 +2563,7 @@
         crypto_msg(M_FATAL=
, "Cannot create SSL object");
     }
 
-#if OPENSSL_VERSION_NUMBER < 0x101=
0000fL || defined(OPENSSL_IS_AWSLC) || defined(ENABLE_CRYPTO_WOLFSSL)
+#if =
defined(OPENSSL_IS_AWSLC) || defined(ENABLE_CRYPTO_WOLFSSL)
     STACK_OF(S=
SL_CIPHER) *sk =3D SSL_get_ciphers(ssl);
 #else
     STACK_OF(SSL_CIPHER) *=
sk =3D SSL_get1_supported_ciphers(ssl);
@@ -2646,9 +2591,7 @@
             =
printf("%s\n", pair->iana_name);
         }
     }
-#if (OPENSSL_VERSION_NU=
MBER >=3D 0x1010000fL)
     sk_SSL_CIPHER_free(sk);
-#endif
     SSL_free(s=
sl);
     SSL_CTX_free(tls_ctx=2Ectx);
 }
diff --git a/tests/unit_tests/ope=
nvpn/test_ncp=2Ec b/tests/unit_tests/openvpn/test_ncp=2Ec
index 29365db=2E=
=2E99e1aac 100644
--- a/tests/unit_tests/openvpn/test_ncp=2Ec
+++ b/tests/u=
nit_tests/openvpn/test_ncp=2Ec
@@ -110,7 +110,7 @@
     assert_string_equal=
(mutate_ncp_cipher_list("AES-256-GCM:?AES-128-CCM:AES-128-GCM", &gc),
     =
                    aes_ciphers);
 
-    /* For testing that with OpenSSL 1=
=2E1=2E0+ that also accepts ciphers in
+    /* For testing that with OpenSS=
L that also accepts ciphers in
      * a different spelling the normalised =
cipher output is the same */
     bool have_chacha_mixed_case =3D cipher_va=
lid("ChaCha20-Poly1305");
     if (have_chacha_mixed_case)

-- 
To view, vi=
sit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1821?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: Iae76f10fa683369ca3f718dc24fd54560b=
b74112
Gerrit-Change-Number: 1821
Gerrit-PatchSet: 1
Gerrit-Owner: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--CwxOCl5lQow=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1821?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">Drop support for OpenSSL 1=2E1=2E0<br><br>Slight simplification of the=
 code since we can then<br>assume that TLS 1=2E3 support is present=2E<br><=
br>Change-Id: Iae76f10fa683369ca3f718dc24fd54560bb74112<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M INSTALL<br>M c=
onfigure=2Eac<br>M src/openvpn/openssl_compat=2Eh<br>M src/openvpn/ssl_open=
ssl=2Ec<br>M tests/unit_tests/openvpn/test_ncp=2Ec<br>5 files changed, 16 i=
nsertions(+), 78 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/21/1821/1</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/INSTALL b/INSTALL</span><br><span>index 77656b2c=2E=2E78390d5 100644</sp=
an><br><span>--- a/INSTALL</span><br><span>+++ b/INSTALL</span><br><span>@@=
 -66,10 +66,10 @@</span><br><span>   (1) TUN and/or TAP driver to allow use=
r-space programs to control</span><br><span>       a virtual point-to-point=
 IP or Ethernet device=2E</span><br><span>       See TUN/TAP Driver Referen=
ces section below for more info=2E</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  (2a) OpenSSL library, necessary for encryption, version 1=2E=
1=2E0 or higher</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (2=
a) OpenSSL library, necessary for encryption, version 1=2E1=2E1 or higher</=
span><br><span>       required, available from https://www=2Eopenssl=2Eorg/=
</span><br><span>       or</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  (2b) mbed TLS library, an alternative for encryption, version 2=2E0 =
or higher</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (2b) mbe=
d TLS library, an alternative for encryption, version 3=2E2=2E1 or higher</=
span><br><span>       required, available from https://tls=2Embed=2Eorg/</s=
pan><br><span>   (3) on Linux, &quot;libnl-gen&quot; is required for kernel=
 netlink support</span><br><span>   (4) on Linux, &quot;libcap-ng&quot; is =
required for Linux capability handling</span><br><span>diff --git a/configu=
re=2Eac b/configure=2Eac</span><br><span>index 188f8fa=2E=2E1aec805 100644<=
/span><br><span>--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</=
span><br><span>@@ -776,7 +776,7 @@</span><br><span> 		# if the user did not=
 explicitly specify flags, try to autodetect</span><br><span> 		PKG_CHECK_M=
ODULES(</span><br><span> 			[OPENSSL],</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-			[openssl &gt;=3D 1=2E1=2E0],</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+			[openssl &gt;=3D 1=2E1=2E1],</span><br><spa=
n> 			[have_openssl=3D&quot;yes&quot;],</span><br><span> 			[AC_MSG_WARN([O=
penSSL not found by pkg-config ${pkg_config_found}])] # If this fails, we w=
ill do another test next</span><br><span> 		)</span><br><span>@@ -799,7 +79=
9,7 @@</span><br><span> 				]],</span><br><span> 				[[</span><br><span> /*=
	     Version encoding: MNNFFPPS - see opensslv=2Eh for details */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#if OPENSSL_VERSION_NUMBER &lt=
; 0x10100000L</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if OP=
ENSSL_VERSION_NUMBER &lt; 0x10101000L</span><br><span> #error OpenSSL too o=
ld</span><br><span> #endif</span><br><span> 				]]</span><br><span>diff --g=
it a/src/openvpn/openssl_compat=2Eh b/src/openvpn/openssl_compat=2Eh</span>=
<br><span>index b61bcbf=2E=2E098bdd5 100644</span><br><span>--- a/src/openv=
pn/openssl_compat=2Eh</span><br><span>+++ b/src/openvpn/openssl_compat=2Eh<=
/span><br><span>@@ -26,9 +26,9 @@</span><br><span>  * OpenSSL compatibility=
 stub</span><br><span>  *</span><br><span>  * This file provide compatibili=
ty stubs for the OpenSSL libraries</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * prior to version 1=2E1=2E This version introduces many chan=
ges in the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * library =
interface, including the fact that various objects and</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * structures are not fully opaque=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * prior to the current =
major version=2E Newer versions may introduce changes</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * in the library interface, including re=
placing functions or enforcing</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * various objects and structures as fully opaque=2E</span><br><=
span>  */</span><br><span> </span><br><span> #ifndef OPENSSL_COMPAT_H_</spa=
n><br><span>@@ -62,11 +62,6 @@</span><br><span> #endif</span><br><span> </s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Fun=
ctionality missing in 1=2E1=2E0 */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if OPENSSL_VERSION_NUMBER &lt; 0x10101000L &amp;&amp; !define=
d(ENABLE_CRYPTO_WOLFSSL)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define SSL_CTX_set1_groups SSL_CTX_set1_curves</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> /* Functionality missing in LibreSSL before=
 3=2E5 */</span><br><span> #if defined(LIBRESSL_VERSION_NUMBER) &amp;&amp; =
LIBRESSL_VERSION_NUMBER &lt; 0x3050000fL</span><br><span> #define EVP_CTRL_=
AEAD_SET_TAG EVP_CTRL_GCM_SET_TAG</span><br><span>diff --git a/src/openvpn/=
ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>index ef99b22=
=2E=2E32b13db 100644</span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</spa=
n><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@@ -200,42 +2=
00,12 @@</span><br><span> </span><br><span> /*</span><br><span>  * Return m=
aximum TLS version supported by local OpenSSL library=2E</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * Assume that presence of SSL_OP_NO_TLS=
vX macro indicates that</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * TLSvX is supported=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * We only support OpenSSL versions that support TLS 1=2E3=2E</span>=
<br><span>  */</span><br><span> int</span><br><span> tls_version_max(void)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
 defined(TLS1_3_VERSION)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    /* If this is defined we can safely assume TLS 1=2E3 support */</spa=
n><br><span>     return TLS_VER_1_3;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#elif OPENSSL_VERSION_NUMBER &gt;=3D 0x10100000L</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-     * If TLS_VER_1_3 is not defined, we were co=
mpiled against a version that</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-     * did not support TLS 1=2E3=2E</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-     *</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-     * However, the library we are *linked* against might be OpenSSL=
 1=2E1=2E1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * and =
therefore supports TLS 1=2E3=2E This needs to be checked at runtime</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-     * since we can be compil=
ed against 1=2E1=2E0 and then the library can be</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-     * upgraded to 1=2E1=2E1=2E</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-     * We only need to check this for =
OpenSSL versions that can be</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-     * upgraded to 1=2E1=2E1 without recompile (&gt;=3D 1=2E1=2E0)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (OpenSSL_version_num() &gt;=3D=
 0x1010100fL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        return TLS_VER_1=
_3;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        return TLS_VER_1_2;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#elif defined(TLS1_2_VERSION) || defined(SSL_OP_NO_TLSv1_2)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    return TLS_VER_1_2;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TLS1_1_VERSION) || =
defined(SSL_OP_NO_TLSv1_1)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return TLS_VER_1_1;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#else /* if defined(TLS1_3_VERSION) */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return TLS_VER_1_0;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif</span><br><span> }</span><br><span> </span=
><br><span> /** Convert internal version number to openssl version number *=
/</span><br><span>@@ -256,22 +226,7 @@</span><br><span>     }</span><br><sp=
an>     else if (ver =3D=3D TLS_VER_1_3)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         * Supporting the library upgraded =
to TLS1=2E3 without recompile</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-         * is enough to support here with a simple constant that th=
e same</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * as i=
n the TLS 1=2E3, so spec it is very unlikely that OpenSSL</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-         * will change this constant</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#ifndef TLS1_3_VERSION</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         * We do not want to define TLS_VER=
_1_3 if not defined</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
       * since other parts of the code use the existance of this macro</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-         * as proxy for TL=
S 1=2E3 support</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
   */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0=
x0304;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br=
><span>         return TLS1_3_VERSION;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#endif</span><br><span>     }</span><br><span>     return =
0;</span><br><span> }</span><br><span>@@ -491,8 +446,8 @@</span><br><span> =
     */</span><br><span>     if (strlen(ciphers) &gt;=3D (len - 1))</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  msg(M_FATAL, &quot;Failed to set restricted TLS 1=2E3 cipher list, too lo=
ng (&gt;%d)=2E&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            (int)(len - 1));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(M_FATAL, &quot;Failed to set restricted TLS 1=2E3 ciph=
er list, too long (&gt;%zd)=2E&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            len - 1);</span><br><span>     }</span><br><s=
pan> </span><br><span>     strncpy(openssl_ciphers, ciphers, len);</span><b=
r><span>@@ -511,17 +466,11 @@</span><br><span> {</span><br><span>     if (c=
iphers =3D=3D NULL)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        /* default cipher list of OpenSSL 1=2E1=2E1 is=
 sane, do not set own</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* default cipher list of OpenSSL is sane, do not set own</span><=
br><span>          * default as we do with tls-cipher */</span><br><span>  =
       return;</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#if !defined(TLS1_3_VERSION)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    crypto_msg(M_WARN,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-               &quot;Not compiled=
 with OpenSSL 1=2E1=2E1 or higher=2E &quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-               &quot;Ignoring TLS 1=2E3 only tls-ciph=
ersuites &#39;%s&#39; setting=2E&quot;,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-               ciphers);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#else</span><br><span>     ASSERT(NULL !=3D ctx);</spa=
n><br><span> </span><br><span>     char openssl_ciphers[4096];</span><br><s=
pan>@@ -531,14 +480,12 @@</span><br><span>     {</span><br><span>         c=
rypto_msg(M_FATAL, &quot;Failed to set restricted TLS 1=2E3 cipher list: %s=
&quot;, openssl_ciphers);</span><br><span>     }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#endif</span><br><span> }</span><br><span> </spa=
n><br><span> void</span><br><span> tls_ctx_set_cert_profile(struct tls_root=
_ctx *ctx, const char *profile)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#if OPENSSL_VERSION_NUMBER &gt; 0x10100000L   =
                                         \</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    &amp;&amp; (!defined(LIBRESSL_VERSION_NUMBER) || L=
IBRESSL_VERSION_NUMBER &gt; 0x3060000fL) \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_V=
ERSION_NUMBER &gt; 0x3060000fL) \</span><br><span>     &amp;&amp; !defined(=
OPENSSL_IS_AWSLC)</span><br><span>     /* OpenSSL does not have certificate=
 profiles, but a complex set of</span><br><span>      * callbacks that we c=
ould try to implement to achieve something similar=2E</span><br><span>@@ -5=
65,7 +512,7 @@</span><br><span>     {</span><br><span>         msg(M_FATAL,=
 &quot;ERROR: Invalid cert profile: %s&quot;, profile);</span><br><span>   =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if OPENS=
SL_VERSION_NUMBER &gt; 0x10100000L */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#else</span><br><span>     if (profile)</span><br><span> =
    {</span><br><span>         msg(M_WARN,</span><br><span>@@ -573,7 +520,7=
 @@</span><br><span>             &quot;support --tls-cert-profile, ignoring=
 user-set profile: &#39;%s&#39;&quot;,</span><br><span>             profile=
);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif /* if OPENSSL_VERSION_NUMBER &gt; 0x10100000L */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> }</span><br=
><span> </span><br><span> void</span><br><span>@@ -2597,14 +2544,12 @@</spa=
n><br><span>         crypto_msg(M_FATAL, &quot;Cannot create SSL_CTX object=
&quot;);</span><br><span>     }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#if defined(TLS1_3_VERSION)</span><br><span>   =
  if (tls13)</span><br><span>     {</span><br><span>         SSL_CTX_set_mi=
n_proto_version(tls_ctx=2Ectx, TLS1_3_VERSION);</span><br><span>         tl=
s_ctx_restrict_ciphers_tls13(&amp;tls_ctx, cipher_list);</span><br><span>  =
   }</span><br><span>     else</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span>     {</span><br><span>         SSL_CTX_set=
_max_proto_version(tls_ctx=2Ectx, TLS1_2_VERSION);</span><br><span>        =
 tls_ctx_restrict_ciphers(&amp;tls_ctx, cipher_list);</span><br><span>@@ -2=
618,7 +2563,7 @@</span><br><span>         crypto_msg(M_FATAL, &quot;Cannot =
create SSL object&quot;);</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#if OPENSSL_VERSION_NUMBER &lt=
; 0x1010000fL || defined(OPENSSL_IS_AWSLC) || defined(ENABLE_CRYPTO_WOLFSSL=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(OPENSS=
L_IS_AWSLC) || defined(ENABLE_CRYPTO_WOLFSSL)</span><br><span>     STACK_OF=
(SSL_CIPHER) *sk =3D SSL_get_ciphers(ssl);</span><br><span> #else</span><br=
><span>     STACK_OF(SSL_CIPHER) *sk =3D SSL_get1_supported_ciphers(ssl);</=
span><br><span>@@ -2646,9 +2591,7 @@</span><br><span>             printf(&q=
uot;%s\n&quot;, pair-&gt;iana_name);</span><br><span>         }</span><br><=
span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if (OPENS=
SL_VERSION_NUMBER &gt;=3D 0x1010000fL)</span><br><span>     sk_SSL_CIPHER_f=
ree(sk);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span>=
<br><span>     SSL_free(ssl);</span><br><span>     SSL_CTX_free(tls_ctx=2Ec=
tx);</span><br><span> }</span><br><span>diff --git a/tests/unit_tests/openv=
pn/test_ncp=2Ec b/tests/unit_tests/openvpn/test_ncp=2Ec</span><br><span>ind=
ex 29365db=2E=2E99e1aac 100644</span><br><span>--- a/tests/unit_tests/openv=
pn/test_ncp=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_ncp=2Ec=
</span><br><span>@@ -110,7 +110,7 @@</span><br><span>     assert_string_equ=
al(mutate_ncp_cipher_list(&quot;AES-256-GCM:?AES-128-CCM:AES-128-GCM&quot;,=
 &amp;gc),</span><br><span>                         aes_ciphers);</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* For te=
sting that with OpenSSL 1=2E1=2E0+ that also accepts ciphers in</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* For testing that with Op=
enSSL that also accepts ciphers in</span><br><span>      * a different spel=
ling the normalised cipher output is the same */</span><br><span>     bool =
have_chacha_mixed_case =3D cipher_valid(&quot;ChaCha20-Poly1305&quot;);</sp=
an><br><span>     if (have_chacha_mixed_case)</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1821?usp=3Demail">change 1821</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1821?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newcha=
nge </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: Iae76f10fa683369ca3f718dc24fd54560bb74112 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 1821 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> G=
errit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</b=
ody></html>
--CwxOCl5lQow=--


--===============7357521716291779804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7357521716291779804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7357521716291779804==--

