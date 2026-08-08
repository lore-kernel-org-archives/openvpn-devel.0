Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F543C5AD55
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JAJ2/R3uTQFsWvH5jARneGtq4S/q37X5huZ2O/tKf74=; b=FF9TBGMTQsTvcMYglyasYVMnG+
	GgwUCos20s4WV/zfIR1hHIn87QYasY3p8ZE5hFn9ObOvBfcY6N2wy/uk5BvNFHZsKtQ7QQbl5xRT8
	rcnIuqMt5NpoL8fNnJQYv1yUd3D+AT8Rr1s2cpoFpJB2AKntyWDT6mvEFWR+/sW/U91A=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wshJx-0004XX-6B;
	Sat, 08 Aug 2026 13:42:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wshJk-0004X5-8h
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 13:42:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=WHdxWAAyfhbxEmdRORVeTLl80yzZTktw63zrv+cmXAQ=; b=DtXzY++B5R8S/V/Dy1YJDCMdgU
 9K2qnSS8upNnSgltutpvS3/y/ykbuI7yzd20r2HTJg9fHvHMz0RzieRYoVCDDmiU9Vlgw/TuaiQnn
 om4l0tQtvpfvk6h1wh7h+KCuFsjGBp3XFOoQwghtQTp8+teXGKTv9OTURegUiU79kZh8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WHdxWAAyfhbxEmdRORVeTLl80yzZTktw63zrv+cmXAQ=; b=n
 Q7/oknKovj7HPv6EdqF/EypWvMfHqCM50Mz1fzlZ8s2yzBjMCzzYXcmrU2ELq1eDxTpBuoE5RPQLn
 b0t0orHLFnzCMUdLLuf7dRY8rSyUhEfkcNGCmjOjXFrOON5FJBQQb7qja4IGld+pEvNyxPT4I5FMH
 Sgy39OzgpJLVDgPI=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wshJj-0002Gg-BV for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 13:42:28 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so16742735e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 08 Aug 2026 06:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786196541; x=1786801341; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WHdxWAAyfhbxEmdRORVeTLl80yzZTktw63zrv+cmXAQ=;
 b=bosDq4N0JItn1AOJwGKPrr8ea+z0gw2trQJYJz3BowrzkJy4oEE2MxbIP8ENJTr0J+
 SLCBGYT5v7eU+unf/b1p3Flxu8k+TjUZdtmPbvfcBMNkgn0m0NS9X7bqOoxpJkf/TVpz
 cA/JnSSxs82Ak5kVAttTHs1Ksl2c33rwAy2YpeqXkycvXUock+GRzglEI5AXXUJO0mcF
 8lMxzfS5A9yJ9TmoexDV5EYfWtQSGDu5OT85l9H7WLgjeSjFKg8rKVd8NvbjmrGiCKaE
 8s6vH+6ae4T+hP2sjUbRfJp+/OJMAXj8ZhnTUjeWc7QYirJA8+qlhqsLT4apydJai8dg
 zQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786196541; x=1786801341;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WHdxWAAyfhbxEmdRORVeTLl80yzZTktw63zrv+cmXAQ=;
 b=GbP74SGPcnAtUGrrxAfm3BdHEkOnqfMjxaYXyesWlL7zrW3ds1XrFTRKtn57n0D1U9
 BW5m47+XjGRM2L8871/lDGwZKwqT6C1o9eVeq9hgRVtCKgXQiDsFoYd5gE8Lawi8+LeI
 zf43IfmYN/s2cGABsAB97eZ501BenkZQtJTVmijUV9Ro5UakwT20NykOXiy3h1ZA5GS8
 B8Cc5SjxmGZCosGCTAH8YYoZqjGFe59tVcNqO8L8vqy9BWCYykPhtCGUfJ5jacTx55uT
 iNlUL91GxWMOtpuMTiEYCz+TCvAVxVL8NSZFXm2kOknXO23CvhiJ0Tbrgcc+ySCsJ3kL
 M7NQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqCY9JRUSeLGzYDPDoIlUe26D+xSLn8bswBdLlVD0ijxGJF9F7s+/ZFzlW73nZeJRoYAMPoL1aOVNwsZoFr@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwJQf6zxIxim1GLdIZgoCgyxm23Jr2wsfiuHlB2j7k/BA49U9Tx
 d3qRLuJelnOETBxIFqSsut1HwqeNh2w7SAz9zqhXcl3QKX1aECUIi/cKpMArQeXbHa2QeTd/u2+
 xB9KpSVRE3aICbh4GiNpTollx9MhQP+/tBGPFErdnV8WczyEiilJIOwcQOLO/Bqq0LxaX
X-Gm-Gg: AR+sD12YW8bOtUR+ZGNV2TygJN5CQq20RfIRqjuu5L0OBD9EnLzdsg6oeaxl6Cn2rLR
 rcUBs7MXUz1ORaldpz6IomzAyVN0+3k096YJVMfnLB7Dq0Fs/CFjDjScncFenx+y2osUwtxhVVy
 2Zjwg3KwgT8+pvZw9OGyx1DwWL98JTxsIyFrM9iPCKo++PncZXc7YdpzKx1kRD0zqsLzwqkDIUL
 lPB6+EAwpLvp2hO+txlVd2Ui6dIcvXLwXsMBwIP4l8aI6dLDUoRmTT1gZunnZYL9ZsxrfoHDka3
 O/lXlUUs2TVIzIUfNUDumC44xDX+7kp1hDdfbwiDxIBK3x1q7xtsxJa4iBms1w8ER+cZCBfVPj9
 HAeBihejy7Hj6aMWM9bcDmd+Wb4AIpFnL0XgtZAhv8re6/EXH6Vi6AO6DQ5qliYyKtRuLEVKWl3
 vC7yLiT4RbaBPvi1SKUNHuCC2osqlKS7MeCa/tKOfbFik/i146/e/QuF7AhK//EVZz/UsnODRDA
 Wp9QtsicQgtNHtFmH3Tnwd6cALFOBgo2mbD6ir1Gzvia1lwJy4HXapYQy0T3LELXr6UMornWFYF
 tolS64CrRoyC0iy2ZGq7R3VTYnBrICpK0E+946EU098lWJq8DzRC
X-Received: by 2002:a05:600c:3154:b0:495:3bc6:d381 with SMTP id
 5b1f17b1804b1-49962453c45mr65549075e9.2.1786196540583; 
 Sat, 08 Aug 2026 06:42:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995e9e7164sm152184515e9.2.2026.08.08.06.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 06:42:20 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 8 Aug 2026 13:42:19 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I81b7168b64c438f759eace1e8f2735891c797bb9
X-Gerrit-Change-Number: 1611
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1611?usp=email>
X-Gerrit-Commit: 6575d4521a02e8a48a280f7246af6714504a2a86
In-Reply-To: <gerrit.1775343746000.I81b7168b64c438f759eace1e8f2735891c797bb9@gerrit.openvpn.net>
References: <gerrit.1775343746000.I81b7168b64c438f759eace1e8f2735891c797bb9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MzQzNzQ2MDAwLkk4MWI3MTY4YjY0YzQzOGY3NTllYWNlMWU4ZjI3MzU4OTFjNzk3YmI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <453f6441988f5c2157758f9278c4da2f0a6d2c33-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wshJj-0002Gg-BV
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Hide various
 functions when unused
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6048443425989584525=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6048443425989584525==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="06XUewmI3sA="; charset=UTF-8

--06XUewmI3sA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1611?usp=3Demail )

Change subject: Hide various functions when unused
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Hide various =
functions when unused

Wrap them into the same ifdef as their only user(s)=
=2E

Identified by cppcheck=2E

Change-Id: I81b7168b64c438f759eace1e8f27358=
91c797bb9
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-=
by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1611
Message-Id: <20260808133204=2E6139-1-gert@gr=
eenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg38233=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M src=
/openvpn/error=2Ec
M src/openvpn/error=2Eh
M src/openvpn/socket=2Ec
M src/o=
penvpn/socket=2Eh
M src/openvpn/socket_util=2Eh
M src/openvpn/ssl_openssl=
=2Ec
M tests/unit_tests/openvpn/test_pkcs11=2Ec
9 files changed, 25 inserti=
ons(+), 10 deletions(-)




diff --git a/src/openvpn/buffer=2Ec b/src/openv=
pn/buffer=2Ec
index 5f2b233=2E=2E922238d 100644
--- a/src/openvpn/buffer=2E=
c
+++ b/src/openvpn/buffer=2Ec
@@ -594,6 +594,7 @@
     return str;
 }
 
+#=
ifdef _WIN32
 /*
  * like buf_null_terminate, but operate on strings
  */
@=
@ -610,6 +611,7 @@
         *(str + len - 1) =3D '\0';
     }
 }
+#endif
 
=
 /*
  * Remove trailing \r and \n chars=2E
diff --git a/src/openvpn/buffer=
=2Eh b/src/openvpn/buffer=2Eh
index 1db9367=2E=2E797bd08 100644
--- a/src/o=
penvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -470,7 +470,9 @@
 
 const=
 char *skip_leading_whitespace(const char *str);
 
+#ifdef _WIN32
 void str=
ing_null_terminate(char *str, int len, int capacity);
+#endif
 
 /**
  * Wr=
ite buffer contents to file=2E
diff --git a/src/openvpn/error=2Ec b/src/ope=
nvpn/error=2Ec
index 2900352=2E=2E26d4c7c 100644
--- a/src/openvpn/error=2E=
c
+++ b/src/openvpn/error=2Ec
@@ -84,18 +84,20 @@
 /* If non-null, messages=
 should be written here (used for debugging only) */
 static FILE *msgfp; /=
* GLOBAL */
 
-/* If true, we forked from main OpenVPN process */
-static b=
ool forked; /* GLOBAL */
-
 /* our default output targets */
 static FILE *=
default_out; /* GLOBAL */
 static FILE *default_err; /* GLOBAL */
 
+/* If =
true, we forked from main OpenVPN process */
+static bool forked; /* GLOBAL=
 */
+
+#if PORT_SHARE
 void
 msg_forked(void)
 {
     forked =3D true;
 }
+=
#endif
 
 bool
 set_debug_level(const int level, const unsigned int flags)
=
diff --git a/src/openvpn/error=2Eh b/src/openvpn/error=2Eh
index 3b742d7=2E=
=2E45826a2 100644
--- a/src/openvpn/error=2Eh
+++ b/src/openvpn/error=2Eh
@=
@ -260,8 +260,10 @@
     return check_debug_level(flags) && dont_mute(flags=
);
 }
 
+#if PORT_SHARE
 /* Call if we forked */
 void msg_forked(void);
+#=
endif
 
 /* syslog output */
 
@@ -393,12 +395,14 @@
     return false;
 }
=
 
+#if defined(ENABLE_CRYPTO_OPENSSL)
 /** Convert fatal errors to nonfatal=
, don't touch other errors */
 static inline msglvl_t
 nonfatal(const msglv=
l_t err)
 {
     return (err & M_FATAL) ? (err ^ M_FATAL) | M_NONFATAL : er=
r;
 }
+#endif
 
 static inline int
 openvpn_errno_maybe_crt(bool *crt_error=
)
diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 8bcc33=
2=2E=2E0f66ad51 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socke=
t=2Ec
@@ -2961,6 +2961,8 @@
     return rwflags;
 }
 
+#if UNIX_SOCK_SUPPOR=
T
+
 void
 sd_close(socket_descriptor_t *sd)
 {
@@ -2971,8 +2973,6 @@
     =
}
 }
 
-#if UNIX_SOCK_SUPPORT
-
 /*
  * code for unix domain sockets
  */
d=
iff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
index b490610=
=2E=2E1a532e1 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/socket=
=2Eh
@@ -366,7 +366,9 @@
 
 void link_socket_close(struct link_socket *sock=
);
 
+#ifdef ENABLE_MANAGEMENT
 void sd_close(socket_descriptor_t *sd);
+#e=
ndif
 
 void bad_address_length(int actual, int expected);
 
diff --git a/s=
rc/openvpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh
index 13deeaa=2E=
=2E13f5962 100644
--- a/src/openvpn/socket_util=2Eh
+++ b/src/openvpn/socke=
t_util=2Eh
@@ -250,6 +250,7 @@
     }
 }
 
+#ifdef TARGET_ANDROID
 static i=
nline bool
 addr_local(const struct sockaddr *addr)
 {
@@ -269,12 +270,12 @=
@
             return false;
     }
 }
+#endif
 
-
+#if ENABLE_IP_PKTINFO
 =
static inline bool
 addr_defined_ipi(const struct link_socket_actual *lsa)
=
 {
-#if ENABLE_IP_PKTINFO
     if (!lsa)
     {
         return 0;
@@ -296,=
11 +297,9 @@
         default:
             return 0;
     }
-#else /* if E=
NABLE_IP_PKTINFO */
-    ASSERT(0);
-#endif
     return false;
 }
+#endif
 =

 /*
  * Overhead added to packets by various protocols=2E
diff --git a/src=
/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index 32b13db=2E=2Ee=
4b760e 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_opens=
sl=2Ec
@@ -436,6 +436,7 @@
     }
 }
 
+#ifdef TLS1_3_VERSION
 static void
=
 convert_tls13_list_to_openssl(char *openssl_ciphers, size_t len, const cha=
r *ciphers)
 {
@@ -460,6 +461,7 @@
         }
     }
 }
+#endif
 
 void
 tl=
s_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers)=

diff --git a/tests/unit_tests/openvpn/test_pkcs11=2Ec b/tests/unit_tests/o=
penvpn/test_pkcs11=2Ec
index 8b6e594=2E=2E042bd8b 100644
--- a/tests/unit_t=
ests/openvpn/test_pkcs11=2Ec
+++ b/tests/unit_tests/openvpn/test_pkcs11=2Ec=

@@ -45,6 +45,7 @@
 
 struct management *management; /* global */
 
+#if de=
fined(ENABLE_CRYPTO_OPENSSL)
 /* replacement for crypto_print_openssl_error=
s() */
 void
 crypto_print_openssl_errors(const unsigned int flags)
@@ -55,=
6 +56,7 @@
         msg(flags, "OpenSSL error %lu: %s", e, ERR_error_string=
(e, NULL));
     }
 }
+#endif
 
 /* stubs for some unused functions instead=
 of pulling in too many dependencies */
 int

-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1611?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: I81b7168b64c438f759eace1e8f2735891c797bb9
Gerrit-Cha=
nge-Number: 1611
Gerrit-PatchSet: 13
Gerrit-Owner: flichtenheld <frank@lich=
tenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--06XUewmI3sA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1611?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Hide various functions when unused<br><br>=
Wrap them into the same ifdef as their only user(s)=2E<br><br>Identified by=
 cppcheck=2E<br><br>Change-Id: I81b7168b64c438f759eace1e8f2735891c797bb9<br=
>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-=
by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1611<br>Message-Id: &lt;20260808133204=
=2E6139-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2E=
com/openvpn-devel@lists=2Esourceforge=2Enet/msg38233=2Ehtml<br>Signed-off-b=
y: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/buf=
fer=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/openvpn/error=2Ec<br>M src/ope=
nvpn/error=2Eh<br>M src/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>M=
 src/openvpn/socket_util=2Eh<br>M src/openvpn/ssl_openssl=2Ec<br>M tests/un=
it_tests/openvpn/test_pkcs11=2Ec<br>9 files changed, 25 insertions(+), 10 d=
eletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Ec b/src/open=
vpn/buffer=2Ec</span><br><span>index 5f2b233=2E=2E922238d 100644</span><br>=
<span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=
=2Ec</span><br><span>@@ -594,6 +594,7 @@</span><br><span>     return str;</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#ifdef _WIN32</span><br><span> /*</span><br><span>  * like =
buf_null_terminate, but operate on strings</span><br><span>  */</span><br><=
span>@@ -610,6 +611,7 @@</span><br><span>         *(str + len - 1) =3D &#39=
;\0&#39;;</span><br><span>     }</span><br><span> }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span>=
 /*</span><br><span>  * Remove trailing \r and \n chars=2E</span><br><span>=
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><spa=
n>index 1db9367=2E=2E797bd08 100644</span><br><span>--- a/src/openvpn/buffe=
r=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -470,=
7 +470,9 @@</span><br><span> </span><br><span> const char *skip_leading_whi=
tespace(const char *str);</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span> void string_null_ter=
minate(char *str, int len, int capacity);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> /**</span><=
br><span>  * Write buffer contents to file=2E</span><br><span>diff --git a/=
src/openvpn/error=2Ec b/src/openvpn/error=2Ec</span><br><span>index 2900352=
=2E=2E26d4c7c 100644</span><br><span>--- a/src/openvpn/error=2Ec</span><br>=
<span>+++ b/src/openvpn/error=2Ec</span><br><span>@@ -84,18 +84,20 @@</span=
><br><span> /* If non-null, messages should be written here (used for debug=
ging only) */</span><br><span> static FILE *msgfp; /* GLOBAL */</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* If true, we =
forked from main OpenVPN process */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static bool forked; /* GLOBAL */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> /* our default output targets */=
</span><br><span> static FILE *default_out; /* GLOBAL */</span><br><span> s=
tatic FILE *default_err; /* GLOBAL */</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* If true, we forked from main OpenVPN=
 process */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static b=
ool forked; /* GLOBAL */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if PORT_SHARE=
</span><br><span> void</span><br><span> msg_forked(void)</span><br><span> {=
</span><br><span>     forked =3D true;</span><br><span> }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><s=
pan> bool</span><br><span> set_debug_level(const int level, const unsigned =
int flags)</span><br><span>diff --git a/src/openvpn/error=2Eh b/src/openvpn=
/error=2Eh</span><br><span>index 3b742d7=2E=2E45826a2 100644</span><br><spa=
n>--- a/src/openvpn/error=2Eh</span><br><span>+++ b/src/openvpn/error=2Eh</=
span><br><span>@@ -260,8 +260,10 @@</span><br><span>     return check_debug=
_level(flags) &amp;&amp; dont_mute(flags);</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if PORT_SHARE<=
/span><br><span> /* Call if we forked */</span><br><span> void msg_forked(v=
oid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span> </span><br><span> /* syslog output */</span><br><span> </span><br=
><span>@@ -393,12 +395,14 @@</span><br><span>     return false;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(ENABLE_CRYPTO_OPENSSL)</span><br><span> /** Convert fatal=
 errors to nonfatal, don&#39;t touch other errors */</span><br><span> stati=
c inline msglvl_t</span><br><span> nonfatal(const msglvl_t err)</span><br><=
span> {</span><br><span>     return (err &amp; M_FATAL) ? (err ^ M_FATAL) |=
 M_NONFATAL : err;</span><br><span> }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span> </span><br><span> static inline i=
nt</span><br><span> openvpn_errno_maybe_crt(bool *crt_error)</span><br><spa=
n>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><s=
pan>index 8bcc332=2E=2E0f66ad51 100644</span><br><span>--- a/src/openvpn/so=
cket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -2=
961,6 +2961,8 @@</span><br><span>     return rwflags;</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
UNIX_SOCK_SUPPORT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> void</span><br><span> sd_close(socket_descriptor_t *sd)</sp=
an><br><span> {</span><br><span>@@ -2971,8 +2973,6 @@</span><br><span>     =
}</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#if UNIX_SOCK_SUPPORT</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * code for unix dom=
ain sockets</span><br><span>  */</span><br><span>diff --git a/src/openvpn/s=
ocket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index b490610=2E=2E1a532=
e1 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><span>+++ =
b/src/openvpn/socket=2Eh</span><br><span>@@ -366,7 +366,9 @@</span><br><spa=
n> </span><br><span> void link_socket_close(struct link_socket *sock);</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef=
 ENABLE_MANAGEMENT</span><br><span> void sd_close(socket_descriptor_t *sd);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan> </span><br><span> void bad_address_length(int actual, int expected);</=
span><br><span> </span><br><span>diff --git a/src/openvpn/socket_util=2Eh b=
/src/openvpn/socket_util=2Eh</span><br><span>index 13deeaa=2E=2E13f5962 100=
644</span><br><span>--- a/src/openvpn/socket_util=2Eh</span><br><span>+++ b=
/src/openvpn/socket_util=2Eh</span><br><span>@@ -250,6 +250,7 @@</span><br>=
<span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#ifdef TARGET_ANDROID</span><br><span> static=
 inline bool</span><br><span> addr_local(const struct sockaddr *addr)</span=
><br><span> {</span><br><span>@@ -269,12 +270,12 @@</span><br><span>       =
      return false;</span><br><span>     }</span><br><span> }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#if ENABLE_IP_PKTINFO</span><br><span> static inl=
ine bool</span><br><span> addr_defined_ipi(const struct link_socket_actual =
*lsa)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if ENABLE_IP_PKTINFO</span><br><span>     if (!lsa)</span><br><span>   =
  {</span><br><span>         return 0;</span><br><span>@@ -296,11 +297,9 @@=
</span><br><span>         default:</span><br><span>             return 0;</=
span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#else /* if ENABLE_IP_PKTINFO */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    ASSERT(0);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif</span><br><span>     return false;</span><br><span> }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span=
><br><span> /*</span><br><span>  * Overhead added to packets by various pro=
tocols=2E</span><br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/op=
envpn/ssl_openssl=2Ec</span><br><span>index 32b13db=2E=2Ee4b760e 100644</sp=
an><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/op=
envpn/ssl_openssl=2Ec</span><br><span>@@ -436,6 +436,7 @@</span><br><span> =
    }</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#ifdef TLS1_3_VERSION</span><br><span> static void</=
span><br><span> convert_tls13_list_to_openssl(char *openssl_ciphers, size_t=
 len, const char *ciphers)</span><br><span> {</span><br><span>@@ -460,6 +46=
1,7 @@</span><br><span>         }</span><br><span>     }</span><br><span> }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan> </span><br><span> void</span><br><span> tls_ctx_restrict_ciphers_tls13=
(struct tls_root_ctx *ctx, const char *ciphers)</span><br><span>diff --git =
a/tests/unit_tests/openvpn/test_pkcs11=2Ec b/tests/unit_tests/openvpn/test_=
pkcs11=2Ec</span><br><span>index 8b6e594=2E=2E042bd8b 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_pkcs11=2Ec</span><br><span>+++ b/test=
s/unit_tests/openvpn/test_pkcs11=2Ec</span><br><span>@@ -45,6 +45,7 @@</spa=
n><br><span> </span><br><span> struct management *management; /* global */<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined(ENABLE_CRYPTO_OPENSSL)</span><br><span> /* replacement for crypto=
_print_openssl_errors() */</span><br><span> void</span><br><span> crypto_pr=
int_openssl_errors(const unsigned int flags)</span><br><span>@@ -55,6 +56,7=
 @@</span><br><span>         msg(flags, &quot;OpenSSL error %lu: %s&quot;, =
e, ERR_error_string(e, NULL));</span><br><span>     }</span><br><span> }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
> </span><br><span> /* stubs for some unused functions instead of pulling i=
n too many dependencies */</span><br><span> int</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1611?usp=3Demail">change 1611</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1611?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I81b7168b64c438f759eace1e8f2735891c797bb9 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1611 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none">=
 Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--06XUewmI3sA=--


--===============6048443425989584525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6048443425989584525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6048443425989584525==--

