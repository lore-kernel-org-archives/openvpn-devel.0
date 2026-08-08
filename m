Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB84C5AD48
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g2gJM9uTIewpfLJ8P72hSo9t9lB4QcoIzEtUom6aNBg=; b=Nen7j3m+vvPA3Qe1U2mUQGUwoA
	Hl7vzxULMa0GoGkvqZr5Jes+9ui2UyEAxduP5dlkguvFcyNuq+gUjb1MTBrgadkTf10qvCw6SwQbT
	u6S+TOFpHmr83Na8kPeFra1M6ZFcr8hrTskpA3jDMBlRUcj7K8EUsAgaBBLV4K3cOpDg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wshJx-00011t-1Q;
	Sat, 08 Aug 2026 13:42:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wshJi-00011K-SD
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 13:42:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1X+e+HX7OtxCtwV+TQgwUR5mlxJAiajfYkiWSEgeLGg=; b=TfM1wZhxqloJohd5C6lYkF9C38
 TCorJbyUnvbneX0S4wZ/LyXhisAe3jnNwaW2JrddC32L5ZLilEvn6s4tJ8iLM7c1vKOpwqDEDXN12
 KHDjN/EkRJevtha68d21jNkBU70aMnrt3PsYFHmbIsMiVKsngt9eWHpWOy8c34p3wgFI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1X+e+HX7OtxCtwV+TQgwUR5mlxJAiajfYkiWSEgeLGg=; b=B
 FaklNyzfBP7LRudo/P732NexVeQkRcx1VuhzDC3d2R1tPBQj/GJm5Z9YPnnyXvu899Pm9NsOxNcy5
 0o2yJX/ILlJ56wTQxOW32IZuAMI68RQ+bVHlugj2NilhZddZc1FOWbY73N5BsdsuTmOYZfjMlTQGR
 phhQ7tCw08eZxCvA=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wshJl-0004CQ-NB for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 13:42:27 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4994c49f588so3898295e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 08 Aug 2026 06:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786196540; x=1786801340; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1X+e+HX7OtxCtwV+TQgwUR5mlxJAiajfYkiWSEgeLGg=;
 b=B/qds5VplTSr5lqrqFbFRw73QW9bQwB7gS4/oRp7aMg6STxpxYdZyP8qZeRkGfG4fL
 kZMT0JicjtNHEV1TrPtYpinTNMQ7aIV1W/CoMrhwfOHdFv1DDB6iwLGK1KGX3aAoM8jG
 KG9QPVNda3iKgemErFixwGqwiOOgQFfn1WdJyXD+DDYqFcLeiO6b8N1QY6zPUEWI9P4y
 xw96YCNbzaUyQn2kM0vCY7+niXVLjHRHC+ZE25KwHtRCrbshNlxgu5yiZRur4HncW7qG
 G1AdyT6iIn/8EOJ6S+XqLqlwGl6t486YLWN25eVSaqFno74ac1gRUmXy1zAK3b/tvDPz
 t/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786196540; x=1786801340;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1X+e+HX7OtxCtwV+TQgwUR5mlxJAiajfYkiWSEgeLGg=;
 b=Wqe4FdM/MSPK53GcxjqLki7J+OcPDWaUbO/dUU9bv5nBJQKjnVk2V849RzJI8LnLao
 WS/rukBXt6fnSoh/mPzVZCpEaPxni88P1qjKEoMXx+LLIQAxAvawZaCKfc5iigNmTFyk
 tPS1CrKiHtNQNkE5JLms6CH8dlItEjvXXRH/eL5Nj6dIKr/br9zUM1YP7jHERhUIO+sq
 yu7+MNUfnA64zBC8X4jKpcwt8N1+GY6lsw8oXZDJVXLOdVckdw38lrRhI68IyrkLKn5q
 FeqJ5YUCZ/qzBOvCdTuHFQeCAWtBMakWJnI6Jm9jNOAcwKMS+127hrI7PvFuaTJWHA69
 Eu0w==
X-Gm-Message-State: AOJu0YxZmOkKEACK01Oj10KFr9Mm2pL7aX9oi3AIZrPT66yRGSGOCegA
 0PCMGfwFrjWU36hSFlu5Km4m58EWRxqo7bDmd2HKERIpZhYXt6sAaOBosInlsVk1VdsAhkIOtFT
 CiRy7ODWH4GPF5/7WjJMXGoQrSf/9PtiKkSbELSvzq//haXgRtFKqTa4UBIm8W691LsuuxWLeSq
 nFFnRD8g==
X-Gm-Gg: AR+sD10tJtS3Jz9PeVhuiafkPyL7VtKzMZNqM8tDTCspEQ83CIyeHrlzgZsBruJ3AsM
 dbd1soYKJ1/2VRiGzC4y0YApfTxn5fa/OyY2K9ZX25bqkUhAINP1qew8DtPkDTmAFmrBtCK2JJq
 xIh3qJ9kk1CdUla/df4TN7dIouebDi23u7xPoEtrH9JpAUVKwB2/uz7cNu+ia4Oxr5sfwnAflci
 +WkU0PJChm/l5C5uYKReO78HRXJSS8M7XT+NICYURt4UDupupxBcpS9hCcCLN+E/Vbo8y4MuNMw
 U74egdLdaBo9g5YJuwUqfondq+HUvOquQYDl5vg4QdldWzyilcv96nHJiIDAvu3IJZCs5XUD8jx
 fyl798IIfcL3FHyb5VdFBc+koIJ404MKgZZonWJJU52KXcCeOQkPQC0it0saiagIN6+GPGcxPS5
 7GGSFfL+rCFsKVu8qglvGJLiT+TI/GyAonQQz1TrGGUbD4Xg3842ishJH43e+yNFmxNen7vAfbA
 Y5q2rtrK4qV5EO3iPr5slCpPqEPW5rxRSTYnJiDr7ucQXSbMVInpudumydgGbUdCdJE6/ulVzUk
 0euxdV+ZQ/L1nk1Kxzc032EFdOlR7nQn44BjXvj5WDidgE93NKnpYdtCz+iRC8w=
X-Received: by 2002:a05:600c:4695:b0:495:5d6d:9cc1 with SMTP id
 5b1f17b1804b1-499622340b3mr54802435e9.0.1786196539476; 
 Sat, 08 Aug 2026 06:42:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995c7a54f2sm112519005e9.2.2026.08.08.06.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 06:42:18 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 8 Aug 2026 13:42:16 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I81b7168b64c438f759eace1e8f2735891c797bb9
X-Gerrit-Change-Number: 1611
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1611?usp=email>
X-Gerrit-Commit: 6575d4521a02e8a48a280f7246af6714504a2a86
In-Reply-To: <gerrit.1775343746000.I81b7168b64c438f759eace1e8f2735891c797bb9@gerrit.openvpn.net>
References: <gerrit.1775343746000.I81b7168b64c438f759eace1e8f2735891c797bb9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MzQzNzQ2MDAwLkk4MWI3MTY4YjY0YzQzOGY3NTllYWNlMWU4ZjI3MzU4OTFjNzk3YmI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <453f6441988f5c2157758f9278c4da2f0a6d2c33-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wshJl-0004CQ-NB
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8261358700314808804=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8261358700314808804==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0WuoGlNnVhg="; charset=UTF-8

--0WuoGlNnVhg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#13) to the change originally created b=
y flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1611?usp=3Dem=
ail )

The following approvals got outdated and were removed:
Code-Review+2=
 by plaisthos


Change subject: Hide various functions when unused
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Hide various functi=
ons when unused

Wrap them into the same ifdef as their only user(s)=2E

Id=
entified by cppcheck=2E

Change-Id: I81b7168b64c438f759eace1e8f2735891c797b=
b9
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1611
Message-Id: <20260808133204=2E6139-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg38233=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M src/op=
envpn/error=2Ec
M src/openvpn/error=2Eh
M src/openvpn/socket=2Ec
M src/open=
vpn/socket=2Eh
M src/openvpn/socket_util=2Eh
M src/openvpn/ssl_openssl=2Ec
=
M tests/unit_tests/openvpn/test_pkcs11=2Ec
9 files changed, 25 insertions(+=
), 10 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/11/1611/13

diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/=
buffer=2Ec
index 5f2b233=2E=2E922238d 100644
--- a/src/openvpn/buffer=2Ec
+=
++ b/src/openvpn/buffer=2Ec
@@ -594,6 +594,7 @@
     return str;
 }
 
+#ifd=
ef _WIN32
 /*
  * like buf_null_terminate, but operate on strings
  */
@@ -=
610,6 +611,7 @@
         *(str + len - 1) =3D '\0';
     }
 }
+#endif
 
 /*=

  * Remove trailing \r and \n chars=2E
diff --git a/src/openvpn/buffer=2Eh=
 b/src/openvpn/buffer=2Eh
index 1db9367=2E=2E797bd08 100644
--- a/src/openv=
pn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -470,7 +470,9 @@
 
 const cha=
r *skip_leading_whitespace(const char *str);
 
+#ifdef _WIN32
 void string_=
null_terminate(char *str, int len, int capacity);
+#endif
 
 /**
  * Write =
buffer contents to file=2E
diff --git a/src/openvpn/error=2Ec b/src/openvpn=
/error=2Ec
index 2900352=2E=2E26d4c7c 100644
--- a/src/openvpn/error=2Ec
++=
+ b/src/openvpn/error=2Ec
@@ -84,18 +84,20 @@
 /* If non-null, messages sho=
uld be written here (used for debugging only) */
 static FILE *msgfp; /* GL=
OBAL */
 
-/* If true, we forked from main OpenVPN process */
-static bool =
forked; /* GLOBAL */
-
 /* our default output targets */
 static FILE *defa=
ult_out; /* GLOBAL */
 static FILE *default_err; /* GLOBAL */
 
+/* If true=
, we forked from main OpenVPN process */
+static bool forked; /* GLOBAL */
=
+
+#if PORT_SHARE
 void
 msg_forked(void)
 {
     forked =3D true;
 }
+#end=
if
 
 bool
 set_debug_level(const int level, const unsigned int flags)
diff=
 --git a/src/openvpn/error=2Eh b/src/openvpn/error=2Eh
index 3b742d7=2E=2E4=
5826a2 100644
--- a/src/openvpn/error=2Eh
+++ b/src/openvpn/error=2Eh
@@ -2=
60,8 +260,10 @@
     return check_debug_level(flags) && dont_mute(flags);
 =
}
 
+#if PORT_SHARE
 /* Call if we forked */
 void msg_forked(void);
+#endi=
f
 
 /* syslog output */
 
@@ -393,12 +395,14 @@
     return false;
 }
 
+#=
if defined(ENABLE_CRYPTO_OPENSSL)
 /** Convert fatal errors to nonfatal, do=
n't touch other errors */
 static inline msglvl_t
 nonfatal(const msglvl_t =
err)
 {
     return (err & M_FATAL) ? (err ^ M_FATAL) | M_NONFATAL : err;
 =
}
+#endif
 
 static inline int
 openvpn_errno_maybe_crt(bool *crt_error)
di=
ff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 8bcc332=2E=
=2E0f66ad51 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2E=
c
@@ -2961,6 +2961,8 @@
     return rwflags;
 }
 
+#if UNIX_SOCK_SUPPORT
+
=
 void
 sd_close(socket_descriptor_t *sd)
 {
@@ -2971,8 +2973,6 @@
     }
 }=

 
-#if UNIX_SOCK_SUPPORT
-
 /*
  * code for unix domain sockets
  */
diff =
--git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
index b490610=2E=2E=
1a532e1 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@=
 -366,7 +366,9 @@
 
 void link_socket_close(struct link_socket *sock);
 
+#=
ifdef ENABLE_MANAGEMENT
 void sd_close(socket_descriptor_t *sd);
+#endif
 
=
 void bad_address_length(int actual, int expected);
 
diff --git a/src/open=
vpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh
index 13deeaa=2E=2E13f596=
2 100644
--- a/src/openvpn/socket_util=2Eh
+++ b/src/openvpn/socket_util=2E=
h
@@ -250,6 +250,7 @@
     }
 }
 
+#ifdef TARGET_ANDROID
 static inline boo=
l
 addr_local(const struct sockaddr *addr)
 {
@@ -269,12 +270,12 @@
       =
      return false;
     }
 }
+#endif
 
-
+#if ENABLE_IP_PKTINFO
 static in=
line bool
 addr_defined_ipi(const struct link_socket_actual *lsa)
 {
-#if E=
NABLE_IP_PKTINFO
     if (!lsa)
     {
         return 0;
@@ -296,11 +297,9=
 @@
         default:
             return 0;
     }
-#else /* if ENABLE_IP_=
PKTINFO */
-    ASSERT(0);
-#endif
     return false;
 }
+#endif
 
 /*
  * =
Overhead added to packets by various protocols=2E
diff --git a/src/openvpn/=
ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index 32b13db=2E=2Ee4b760e 10=
0644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@=
 -436,6 +436,7 @@
     }
 }
 
+#ifdef TLS1_3_VERSION
 static void
 convert_=
tls13_list_to_openssl(char *openssl_ciphers, size_t len, const char *cipher=
s)
 {
@@ -460,6 +461,7 @@
         }
     }
 }
+#endif
 
 void
 tls_ctx_res=
trict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers)
diff --g=
it a/tests/unit_tests/openvpn/test_pkcs11=2Ec b/tests/unit_tests/openvpn/te=
st_pkcs11=2Ec
index 8b6e594=2E=2E042bd8b 100644
--- a/tests/unit_tests/open=
vpn/test_pkcs11=2Ec
+++ b/tests/unit_tests/openvpn/test_pkcs11=2Ec
@@ -45,6=
 +45,7 @@
 
 struct management *management; /* global */
 
+#if defined(ENA=
BLE_CRYPTO_OPENSSL)
 /* replacement for crypto_print_openssl_errors() */
 v=
oid
 crypto_print_openssl_errors(const unsigned int flags)
@@ -55,6 +56,7 @=
@
         msg(flags, "OpenSSL error %lu: %s", e, ERR_error_string(e, NULL)=
);
     }
 }
+#endif
 
 /* stubs for some unused functions instead of pulli=
ng in too many dependencies */
 int

-- 
To view, visit http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1611?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master=

Gerrit-Change-Id: I81b7168b64c438f759eace1e8f2735891c797bb9
Gerrit-Change-=
Number: 1611
Gerrit-PatchSet: 13
Gerrit-Owner: flichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--0WuoGlNnVhg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #13</strong> to the change originally created by flichtenhe=
ld=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1611?usp=
=3Demail">View Change</a></p><p>The following approvals got outdated and we=
re removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">Hide various functi=
ons when unused<br><br>Wrap them into the same ifdef as their only user(s)=
=2E<br><br>Identified by cppcheck=2E<br><br>Change-Id: I81b7168b64c438f759e=
ace1e8f2735891c797bb9<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichten=
held=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1611<br>Message-=
Id: &lt;20260808133204=2E6139-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https:/=
/www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38233=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/openvpn=
/error=2Ec<br>M src/openvpn/error=2Eh<br>M src/openvpn/socket=2Ec<br>M src/=
openvpn/socket=2Eh<br>M src/openvpn/socket_util=2Eh<br>M src/openvpn/ssl_op=
enssl=2Ec<br>M tests/unit_tests/openvpn/test_pkcs11=2Ec<br>9 files changed,=
 25 insertions(+), 10 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/11/1611/13</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>in=
dex 5f2b233=2E=2E922238d 100644</span><br><span>--- a/src/openvpn/buffer=2E=
c</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -594,6 +5=
94,7 @@</span><br><span>     return str;</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</sp=
an><br><span> /*</span><br><span>  * like buf_null_terminate, but operate o=
n strings</span><br><span>  */</span><br><span>@@ -610,6 +611,7 @@</span><b=
r><span>         *(str + len - 1) =3D &#39;\0&#39;;</span><br><span>     }<=
/span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif</span><br><span> </span><br><span> /*</span><br><span>  * Remove trai=
ling \r and \n chars=2E</span><br><span>diff --git a/src/openvpn/buffer=2Eh=
 b/src/openvpn/buffer=2Eh</span><br><span>index 1db9367=2E=2E797bd08 100644=
</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/ope=
nvpn/buffer=2Eh</span><br><span>@@ -470,7 +470,9 @@</span><br><span> </span=
><br><span> const char *skip_leading_whitespace(const char *str);</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN=
32</span><br><span> void string_null_terminate(char *str, int len, int capa=
city);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span> </span><br><span> /**</span><br><span>  * Write buffer contents =
to file=2E</span><br><span>diff --git a/src/openvpn/error=2Ec b/src/openvpn=
/error=2Ec</span><br><span>index 2900352=2E=2E26d4c7c 100644</span><br><spa=
n>--- a/src/openvpn/error=2Ec</span><br><span>+++ b/src/openvpn/error=2Ec</=
span><br><span>@@ -84,18 +84,20 @@</span><br><span> /* If non-null, message=
s should be written here (used for debugging only) */</span><br><span> stat=
ic FILE *msgfp; /* GLOBAL */</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-/* If true, we forked from main OpenVPN process */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool forked; /=
* GLOBAL */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> /* our default output targets */</span><br><span> static FILE *defa=
ult_out; /* GLOBAL */</span><br><span> static FILE *default_err; /* GLOBAL =
*/</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* If true, we forked from main OpenVPN process */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static bool forked; /* GLOBAL */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#if PORT_SHARE</span><br><span> void</span><br>=
<span> msg_forked(void)</span><br><span> {</span><br><span>     forked =3D =
true;</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span> </span><br><span> bool</span><br><span> set_de=
bug_level(const int level, const unsigned int flags)</span><br><span>diff -=
-git a/src/openvpn/error=2Eh b/src/openvpn/error=2Eh</span><br><span>index =
3b742d7=2E=2E45826a2 100644</span><br><span>--- a/src/openvpn/error=2Eh</sp=
an><br><span>+++ b/src/openvpn/error=2Eh</span><br><span>@@ -260,8 +260,10 =
@@</span><br><span>     return check_debug_level(flags) &amp;&amp; dont_mut=
e(flags);</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if PORT_SHARE</span><br><span> /* Call if we fo=
rked */</span><br><span> void msg_forked(void);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> /* sy=
slog output */</span><br><span> </span><br><span>@@ -393,12 +395,14 @@</spa=
n><br><span>     return false;</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_CRYPTO_O=
PENSSL)</span><br><span> /** Convert fatal errors to nonfatal, don&#39;t to=
uch other errors */</span><br><span> static inline msglvl_t</span><br><span=
> nonfatal(const msglvl_t err)</span><br><span> {</span><br><span>     retu=
rn (err &amp; M_FATAL) ? (err ^ M_FATAL) | M_NONFATAL : err;</span><br><spa=
n> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span> </span><br><span> static inline int</span><br><span> openvpn_errno=
_maybe_crt(bool *crt_error)</span><br><span>diff --git a/src/openvpn/socket=
=2Ec b/src/openvpn/socket=2Ec</span><br><span>index 8bcc332=2E=2E0f66ad51 1=
00644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/sr=
c/openvpn/socket=2Ec</span><br><span>@@ -2961,6 +2961,8 @@</span><br><span>=
     return rwflags;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if UNIX_SOCK_SUPPORT</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><s=
pan> sd_close(socket_descriptor_t *sd)</span><br><span> {</span><br><span>@=
@ -2971,8 +2973,6 @@</span><br><span>     }</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if UNIX_SOCK_SU=
PPORT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> /*</span><br><span>  * code for unix domain sockets</span><br><span>  */<=
/span><br><span>diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2E=
h</span><br><span>index b490610=2E=2E1a532e1 100644</span><br><span>--- a/s=
rc/openvpn/socket=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</span><b=
r><span>@@ -366,7 +366,9 @@</span><br><span> </span><br><span> void link_so=
cket_close(struct link_socket *sock);</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><spa=
n> void sd_close(socket_descriptor_t *sd);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> void bad_a=
ddress_length(int actual, int expected);</span><br><span> </span><br><span>=
diff --git a/src/openvpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh</spa=
n><br><span>index 13deeaa=2E=2E13f5962 100644</span><br><span>--- a/src/ope=
nvpn/socket_util=2Eh</span><br><span>+++ b/src/openvpn/socket_util=2Eh</spa=
n><br><span>@@ -250,6 +250,7 @@</span><br><span>     }</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
def TARGET_ANDROID</span><br><span> static inline bool</span><br><span> add=
r_local(const struct sockaddr *addr)</span><br><span> {</span><br><span>@@ =
-269,12 +270,12 @@</span><br><span>             return false;</span><br><sp=
an>     }</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if ENA=
BLE_IP_PKTINFO</span><br><span> static inline bool</span><br><span> addr_de=
fined_ipi(const struct link_socket_actual *lsa)</span><br><span> {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#if ENABLE_IP_PKTINFO</span><b=
r><span>     if (!lsa)</span><br><span>     {</span><br><span>         retu=
rn 0;</span><br><span>@@ -296,11 +297,9 @@</span><br><span>         default=
:</span><br><span>             return 0;</span><br><span>     }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#else /* if ENABLE_IP_PKTINFO */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>     r=
eturn false;</span><br><span> }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span> </span><br><span> /*</span><br><span>  =
* Overhead added to packets by various protocols=2E</span><br><span>diff --=
git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><=
span>index 32b13db=2E=2Ee4b760e 100644</span><br><span>--- a/src/openvpn/ss=
l_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><=
span>@@ -436,6 +436,7 @@</span><br><span>     }</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef TLS=
1_3_VERSION</span><br><span> static void</span><br><span> convert_tls13_lis=
t_to_openssl(char *openssl_ciphers, size_t len, const char *ciphers)</span>=
<br><span> {</span><br><span>@@ -460,6 +461,7 @@</span><br><span>         }=
</span><br><span>     }</span><br><span> }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> void</span=
><br><span> tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const =
char *ciphers)</span><br><span>diff --git a/tests/unit_tests/openvpn/test_p=
kcs11=2Ec b/tests/unit_tests/openvpn/test_pkcs11=2Ec</span><br><span>index =
8b6e594=2E=2E042bd8b 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
test_pkcs11=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkcs11=
=2Ec</span><br><span>@@ -45,6 +45,7 @@</span><br><span> </span><br><span> s=
truct management *management; /* global */</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_CRYPTO_OPENSSL)=
</span><br><span> /* replacement for crypto_print_openssl_errors() */</span=
><br><span> void</span><br><span> crypto_print_openssl_errors(const unsigne=
d int flags)</span><br><span>@@ -55,6 +56,7 @@</span><br><span>         msg=
(flags, &quot;OpenSSL error %lu: %s&quot;, e, ERR_error_string(e, NULL));</=
span><br><span>     }</span><br><span> }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> /* stubs for=
 some unused functions instead of pulling in too many dependencies */</span=
><br><span> int</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1611?usp=3Demail">change 1611=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1611?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
81b7168b64c438f759eace1e8f2735891c797bb9 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1611 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>

</body></html>
--0WuoGlNnVhg=--


--===============8261358700314808804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8261358700314808804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8261358700314808804==--

