Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C84C55ABF
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 12:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C/KKaxmEMeUEMCQ0FuJugKCZClT+BTKcMGO/gORBgh0=; b=S+dC/81jlU4q4AnJyA3peXSwOl
	iBHeNWmqLiGlY/RF3ZNhKOnScr0cUMHXt7lbVxyS/nJkXwpWGAVz2fzTTUfmiG7VrPw3VJ1Dsmqnt
	whgGOnRLwVQFpXuiHaR3xiCOV3X+ttMA9JB2ofV8rUcPouspkJXfl+KeTQ3fuGevjb+o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrxHI-0006OZ-JN;
	Thu, 06 Aug 2026 12:32:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrxHG-0006OJ-P3
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 12:32:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=OvoF3H4IM3kM8PRaSBVsJFPGKmSO6W0eKuSZe8EApLQ=; b=AENlDHOwRqD6K1wMKhjWN0C5MA
 II92tq9IZbr/ZTZJhzVYmLP6dPLe2rQctBS3H47r8ZyO+CJhE8NpYS7QFu/2njZ3g406rXRZQLpcz
 PqdU34+GXJOivw452LcwInkfj+4EC1Gf/fc04YOxP0Aq0dE0wtLy2MbPu9S4Oc33DV3c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OvoF3H4IM3kM8PRaSBVsJFPGKmSO6W0eKuSZe8EApLQ=; b=e
 aPdK8UlkXDm4BF8pRhPUgAdZ2RwdBKdpc0Pn90X38930X48hbG+tnZvv67orTBhDROxg6BoNCxy81
 nK9VmmipKq3ZJI6I6TQFfiMJNbXbhABowlNHuPxL1GqqkJv8X+QmSwY8HucOUQVsvuFI2beK4HF9m
 zJf7+PAi4zZmO7sQ=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrxHJ-0004KB-Bi for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 12:32:51 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so1611963f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 05:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786019563; x=1786624363; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OvoF3H4IM3kM8PRaSBVsJFPGKmSO6W0eKuSZe8EApLQ=;
 b=g14uidtV9HFYsX/v50QGDwBJGoO2914zs20hI5eKu95sR16gvTnY87kDtL9nQ25Ixg
 gMBU/aO5aNPbyDQrG7+YwA2kNQVZnQH5kMZfC3f/iLoTlL3BcJIqjjbFaiNJPK91Ix/c
 w8diuKa2U0VnPfV73cHMRAvTL8QgH9Ux0fpUIipMFIFxspOXnIHau/PVu6Z1ImgI5KiR
 FRSi53MVtNJMldsbcCHZmw+gxpGuUBQROpYR9FELvZNO1jG87R4LVDfk1dUvuHeCgC74
 IMoqERmKDaqtZAiuUhivXdDGZMVaslalNpHZYU86QT02yUxQmDgIc1nYRSq0g//RA1J5
 AjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786019563; x=1786624363;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OvoF3H4IM3kM8PRaSBVsJFPGKmSO6W0eKuSZe8EApLQ=;
 b=G5gg8mFSLj47B5pSSVkcWjBOyChKgWjxMO2rinJF4kip6hJeNK31PvGFZg/s5jOLlp
 4ndGTDKJHBXO9r8BqJeHObeOtuJn7woUpGZ3vH4xZqnAO69BY/0phF4UpQ1iOcNXtFF0
 ZyaBpkoAWiNaKgxu0OJP9nLtqS+dY06h0E6w1JEQ647HvWlgumo6dEXI0v0pQdxCo28p
 YJXLW1KTOGMEMHqECnBcJt8dIWIlDuuqi+ShOVZO9JbV0HG2hKl7FtFn8guYb5fOkP6Q
 ZXFtLhWPCEL6rBS+HJbXwXeQYzB3qoj8DKrZTdXoMF0zIy2eR2n5A2bmARhZEA+PGBN/
 ZRDQ==
X-Gm-Message-State: AOJu0YxpWEzOCtWiITXFGuGVteEyle0ZQRmpAuAFrqdNNDyehiV/aUMu
 gNS1f4NwKRzn3muKV3nbRsQTDplbdzXg993EyVs89gWKFM8KeO2XDJl9AyCyld9cUzfW1dh/xyf
 4MSSNabyRg18uZHCFFjCwzDQD4SMsvI20lh/SjCHS3Bhpxq0jlLsSRu7TGUZFgXxlg8SoM4OYkA
 ZJ8UEUHA==
X-Gm-Gg: AR+sD12ldkDaQojxx7k6RuWMvIoJSNUoDPbLVkL5ExmVRs1Br85dqAMc1oUVB4zWWzz
 niZMHdYm6Yb8aNDF+uDtsFjBiUcK1e4DCJK1ENTcRg/FmkmaG0d8DiW2gcaLsrIpXWlwu1uDTf5
 Q7dqLn5iS3QDg4BJKMfhThoqnyQj+WPLs/YKIB4/io1Pj8p1NoT5hipruqbER+kEQQ1Sl6xQHSh
 eVeut12Et0Zkga/Bjq0tbianE/XxkKWeUKw3RBBApyKRuR9N+9MdlQp/dErwe5QzCdWJz8JEo/X
 7gRukUXZudU356XIILVJEhtwQhxaSy5WfOUXqHcwJSlJbOlH+vasBLLq7Z/wk6vwWNLtD8vWcJ7
 3s90/HnLpj8h3dOGfvg+dJrOA410mIt+eWDrLkcHV9VnRF2leSv+rvj5ENiheY4SWLKnIdoSE0n
 22OIm3xxN8V5XybmOZkjX4cmongQh8Xg9bnLY1Ke0U1V72tCdMYSkMO96flQ0MMrzy7o8llRYFk
 kpzi5Nxp0OPn580Ib506zErvO7KHzpUmTybA5XCYEss1WIW/HaRAoCPgsWD/kmqo55YCitC2XMy
 iQbSJ1lugJ7tOKQYZtQc07b2pVv84H4CdKTaEaCw0X5SRQ0hG0A=
X-Received: by 2002:a05:6000:2995:20b0:47f:c648:e265 with SMTP id
 ffacd0b85a97d-47fec51960cmr20527955f8f.17.1786019561995; 
 Thu, 06 Aug 2026 05:32:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b18079sm5820845f8f.17.2026.08.06.05.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 05:32:41 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 6 Aug 2026 12:32:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I81b7168b64c438f759eace1e8f2735891c797bb9
X-Gerrit-Change-Number: 1611
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1611?usp=email>
X-Gerrit-Commit: c18e74d52fd88489806f86a43712b78b56d9b231
In-Reply-To: <gerrit.1775343746000.I81b7168b64c438f759eace1e8f2735891c797bb9@gerrit.openvpn.net>
References: <gerrit.1775343746000.I81b7168b64c438f759eace1e8f2735891c797bb9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MzQzNzQ2MDAwLkk4MWI3MTY4YjY0YzQzOGY3NTllYWNlMWU4ZjI3MzU4OTFjNzk3YmI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bfe954cbb56b371512d8172c802d4384d93e739a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrxHJ-0004KB-Bi
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3526288270317923532=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3526288270317923532==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kDP0oiIabmc="; charset=UTF-8

--kDP0oiIabmc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1611?usp=3Demail

to look at the new patch set (#12)=2E
=


Change subject: Hide various functions when unused
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Hide various functions when unused=


Wrap them into the same ifdef as their only user(s)=2E

Identified by cpp=
check=2E

Change-Id: I81b7168b64c438f759eace1e8f2735891c797bb9
Signed-off-b=
y: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/buffer=2Ec=

M src/openvpn/buffer=2Eh
M src/openvpn/error=2Ec
M src/openvpn/error=2Eh
M=
 src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
M src/openvpn/socket_util=
=2Eh
M src/openvpn/ssl_openssl=2Ec
M tests/unit_tests/openvpn/test_pkcs11=
=2Ec
9 files changed, 25 insertions(+), 10 deletions(-)


  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/11/1611/12

diff --git a/=
src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index 5f2b233=2E=2E922238d =
100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -594,6 =
+594,7 @@
     return str;
 }
 
+#ifdef _WIN32
 /*
  * like buf_null_termin=
ate, but operate on strings
  */
@@ -610,6 +611,7 @@
         *(str + len -=
 1) =3D '\0';
     }
 }
+#endif
 
 /*
  * Remove trailing \r and \n chars=
=2E
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index 833a=
e6f=2E=2Ec6722c7 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buff=
er=2Eh
@@ -470,7 +470,9 @@
 
 const char *skip_leading_whitespace(const cha=
r *str);
 
+#ifdef _WIN32
 void string_null_terminate(char *str, int len, i=
nt capacity);
+#endif
 
 /**
  * Write buffer contents to file=2E
diff --gi=
t a/src/openvpn/error=2Ec b/src/openvpn/error=2Ec
index 2900352=2E=2E26d4c7=
c 100644
--- a/src/openvpn/error=2Ec
+++ b/src/openvpn/error=2Ec
@@ -84,18 =
+84,20 @@
 /* If non-null, messages should be written here (used for debugg=
ing only) */
 static FILE *msgfp; /* GLOBAL */
 
-/* If true, we forked fro=
m main OpenVPN process */
-static bool forked; /* GLOBAL */
-
 /* our defau=
lt output targets */
 static FILE *default_out; /* GLOBAL */
 static FILE *=
default_err; /* GLOBAL */
 
+/* If true, we forked from main OpenVPN proces=
s */
+static bool forked; /* GLOBAL */
+
+#if PORT_SHARE
 void
 msg_forked(=
void)
 {
     forked =3D true;
 }
+#endif
 
 bool
 set_debug_level(const in=
t level, const unsigned int flags)
diff --git a/src/openvpn/error=2Eh b/src=
/openvpn/error=2Eh
index 3b742d7=2E=2E45826a2 100644
--- a/src/openvpn/erro=
r=2Eh
+++ b/src/openvpn/error=2Eh
@@ -260,8 +260,10 @@
     return check_de=
bug_level(flags) && dont_mute(flags);
 }
 
+#if PORT_SHARE
 /* Call if we f=
orked */
 void msg_forked(void);
+#endif
 
 /* syslog output */
 
@@ -393,1=
2 +395,14 @@
     return false;
 }
 
+#if defined(ENABLE_CRYPTO_OPENSSL)
 /=
** Convert fatal errors to nonfatal, don't touch other errors */
 static in=
line msglvl_t
 nonfatal(const msglvl_t err)
 {
     return (err & M_FATAL) =
? (err ^ M_FATAL) | M_NONFATAL : err;
 }
+#endif
 
 static inline int
 open=
vpn_errno_maybe_crt(bool *crt_error)
diff --git a/src/openvpn/socket=2Ec b/=
src/openvpn/socket=2Ec
index 8bcc332=2E=2E0f66ad51 100644
--- a/src/openvpn=
/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -2961,6 +2961,8 @@
     return =
rwflags;
 }
 
+#if UNIX_SOCK_SUPPORT
+
 void
 sd_close(socket_descriptor_t =
*sd)
 {
@@ -2971,8 +2973,6 @@
     }
 }
 
-#if UNIX_SOCK_SUPPORT
-
 /*
  * =
code for unix domain sockets
  */
diff --git a/src/openvpn/socket=2Eh b/src=
/openvpn/socket=2Eh
index b490610=2E=2E1a532e1 100644
--- a/src/openvpn/soc=
ket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -366,7 +366,9 @@
 
 void link_socke=
t_close(struct link_socket *sock);
 
+#ifdef ENABLE_MANAGEMENT
 void sd_clo=
se(socket_descriptor_t *sd);
+#endif
 
 void bad_address_length(int actual,=
 int expected);
 
diff --git a/src/openvpn/socket_util=2Eh b/src/openvpn/so=
cket_util=2Eh
index 13deeaa=2E=2E13f5962 100644
--- a/src/openvpn/socket_ut=
il=2Eh
+++ b/src/openvpn/socket_util=2Eh
@@ -250,6 +250,7 @@
     }
 }
 
+#=
ifdef TARGET_ANDROID
 static inline bool
 addr_local(const struct sockaddr =
*addr)
 {
@@ -269,12 +270,12 @@
             return false;
     }
 }
+#endi=
f
 
-
+#if ENABLE_IP_PKTINFO
 static inline bool
 addr_defined_ipi(const st=
ruct link_socket_actual *lsa)
 {
-#if ENABLE_IP_PKTINFO
     if (!lsa)
    =
 {
         return 0;
@@ -296,11 +297,9 @@
         default:
             r=
eturn 0;
     }
-#else /* if ENABLE_IP_PKTINFO */
-    ASSERT(0);
-#endif
 =
    return false;
 }
+#endif
 
 /*
  * Overhead added to packets by various=
 protocols=2E
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_op=
enssl=2Ec
index 32b13db=2E=2Ee4b760e 100644
--- a/src/openvpn/ssl_openssl=
=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -436,6 +436,7 @@
     }
 }
 
+#if=
def TLS1_3_VERSION
 static void
 convert_tls13_list_to_openssl(char *openss=
l_ciphers, size_t len, const char *ciphers)
 {
@@ -460,6 +461,7 @@
        =
 }
     }
 }
+#endif
 
 void
 tls_ctx_restrict_ciphers_tls13(struct tls_roo=
t_ctx *ctx, const char *ciphers)
diff --git a/tests/unit_tests/openvpn/test=
_pkcs11=2Ec b/tests/unit_tests/openvpn/test_pkcs11=2Ec
index 8b6e594=2E=2E0=
42bd8b 100644
--- a/tests/unit_tests/openvpn/test_pkcs11=2Ec
+++ b/tests/un=
it_tests/openvpn/test_pkcs11=2Ec
@@ -45,6 +45,7 @@
 
 struct management *ma=
nagement; /* global */
 
+#if defined(ENABLE_CRYPTO_OPENSSL)
 /* replacemen=
t for crypto_print_openssl_errors() */
 void
 crypto_print_openssl_errors(c=
onst unsigned int flags)
@@ -55,6 +56,7 @@
         msg(flags, "OpenSSL err=
or %lu: %s", e, ERR_error_string(e, NULL));
     }
 }
+#endif
 
 /* stubs f=
or some unused functions instead of pulling in too many dependencies */
 in=
t

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1611?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I81b7168b64c438=
f759eace1e8f2735891c797bb9
Gerrit-Change-Number: 1611
Gerrit-PatchSet: 12
G=
errit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>

--kDP0oiIabmc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld <strong>uploaded pa=
tch set #12</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1611?usp=3Demail">View Change</a></p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">H=
ide various functions when unused<br><br>Wrap them into the same ifdef as t=
heir only user(s)=2E<br><br>Identified by cppcheck=2E<br><br>Change-Id: I81=
b7168b64c438f759eace1e8f2735891c797bb9<br>Signed-off-by: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src=
/openvpn/buffer=2Eh<br>M src/openvpn/error=2Ec<br>M src/openvpn/error=2Eh<b=
r>M src/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>M src/openvpn/soc=
ket_util=2Eh<br>M src/openvpn/ssl_openssl=2Ec<br>M tests/unit_tests/openvpn=
/test_pkcs11=2Ec<br>9 files changed, 25 insertions(+), 10 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/11/1611/12</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Ec b/src/o=
penvpn/buffer=2Ec</span><br><span>index 5f2b233=2E=2E922238d 100644</span><=
br><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buf=
fer=2Ec</span><br><span>@@ -594,6 +594,7 @@</span><br><span>     return str=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#ifdef _WIN32</span><br><span> /*</span><br><span>  * li=
ke buf_null_terminate, but operate on strings</span><br><span>  */</span><b=
r><span>@@ -610,6 +611,7 @@</span><br><span>         *(str + len - 1) =3D &=
#39;\0&#39;;</span><br><span>     }</span><br><span> }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span=
> /*</span><br><span>  * Remove trailing \r and \n chars=2E</span><br><span=
>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><sp=
an>index 833ae6f=2E=2Ec6722c7 100644</span><br><span>--- a/src/openvpn/buff=
er=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -470=
,7 +470,9 @@</span><br><span> </span><br><span> const char *skip_leading_wh=
itespace(const char *str);</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span> void string_null_te=
rminate(char *str, int len, int capacity);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> /**</span>=
<br><span>  * Write buffer contents to file=2E</span><br><span>diff --git a=
/src/openvpn/error=2Ec b/src/openvpn/error=2Ec</span><br><span>index 290035=
2=2E=2E26d4c7c 100644</span><br><span>--- a/src/openvpn/error=2Ec</span><br=
><span>+++ b/src/openvpn/error=2Ec</span><br><span>@@ -84,18 +84,20 @@</spa=
n><br><span> /* If non-null, messages should be written here (used for debu=
gging only) */</span><br><span> static FILE *msgfp; /* GLOBAL */</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* If true, we=
 forked from main OpenVPN process */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static bool forked; /* GLOBAL */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> /* our default output targets *=
/</span><br><span> static FILE *default_out; /* GLOBAL */</span><br><span> =
static FILE *default_err; /* GLOBAL */</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* If true, we forked from main OpenVP=
N process */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
bool forked; /* GLOBAL */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if PORT_SHAR=
E</span><br><span> void</span><br><span> msg_forked(void)</span><br><span> =
{</span><br><span>     forked =3D true;</span><br><span> }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><=
span> bool</span><br><span> set_debug_level(const int level, const unsigned=
 int flags)</span><br><span>diff --git a/src/openvpn/error=2Eh b/src/openvp=
n/error=2Eh</span><br><span>index 3b742d7=2E=2E45826a2 100644</span><br><sp=
an>--- a/src/openvpn/error=2Eh</span><br><span>+++ b/src/openvpn/error=2Eh<=
/span><br><span>@@ -260,8 +260,10 @@</span><br><span>     return check_debu=
g_level(flags) &amp;&amp; dont_mute(flags);</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if PORT_SHARE=
</span><br><span> /* Call if we forked */</span><br><span> void msg_forked(=
void);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span> </span><br><span> /* syslog output */</span><br><span> </span><b=
r><span>@@ -393,12 +395,14 @@</span><br><span>     return false;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(ENABLE_CRYPTO_OPENSSL)</span><br><span> /** Convert fata=
l errors to nonfatal, don&#39;t touch other errors */</span><br><span> stat=
ic inline msglvl_t</span><br><span> nonfatal(const msglvl_t err)</span><br>=
<span> {</span><br><span>     return (err &amp; M_FATAL) ? (err ^ M_FATAL) =
| M_NONFATAL : err;</span><br><span> }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span> </span><br><span> static inline =
int</span><br><span> openvpn_errno_maybe_crt(bool *crt_error)</span><br><sp=
an>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><=
span>index 8bcc332=2E=2E0f66ad51 100644</span><br><span>--- a/src/openvpn/s=
ocket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -=
2961,6 +2961,8 @@</span><br><span>     return rwflags;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
 UNIX_SOCK_SUPPORT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> void</span><br><span> sd_close(socket_descriptor_t *sd)</s=
pan><br><span> {</span><br><span>@@ -2971,8 +2973,6 @@</span><br><span>    =
 }</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if UNIX_SOCK_SUPPORT</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * code for unix do=
main sockets</span><br><span>  */</span><br><span>diff --git a/src/openvpn/=
socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index b490610=2E=2E1a53=
2e1 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><span>+++=
 b/src/openvpn/socket=2Eh</span><br><span>@@ -366,7 +366,9 @@</span><br><sp=
an> </span><br><span> void link_socket_close(struct link_socket *sock);</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifde=
f ENABLE_MANAGEMENT</span><br><span> void sd_close(socket_descriptor_t *sd)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span> </span><br><span> void bad_address_length(int actual, int expected);<=
/span><br><span> </span><br><span>diff --git a/src/openvpn/socket_util=2Eh =
b/src/openvpn/socket_util=2Eh</span><br><span>index 13deeaa=2E=2E13f5962 10=
0644</span><br><span>--- a/src/openvpn/socket_util=2Eh</span><br><span>+++ =
b/src/openvpn/socket_util=2Eh</span><br><span>@@ -250,6 +250,7 @@</span><br=
><span>     }</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#ifdef TARGET_ANDROID</span><br><span> stati=
c inline bool</span><br><span> addr_local(const struct sockaddr *addr)</spa=
n><br><span> {</span><br><span>@@ -269,12 +270,12 @@</span><br><span>      =
       return false;</span><br><span>     }</span><br><span> }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if ENABLE_IP_PKTINFO</span><br><span> static in=
line bool</span><br><span> addr_defined_ipi(const struct link_socket_actual=
 *lsa)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#if ENABLE_IP_PKTINFO</span><br><span>     if (!lsa)</span><br><span>  =
   {</span><br><span>         return 0;</span><br><span>@@ -296,11 +297,9 @=
@</span><br><span>         default:</span><br><span>             return 0;<=
/span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#else /* if ENABLE_IP_PKTINFO */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    ASSERT(0);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span>     return false;</span><br><span> }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </spa=
n><br><span> /*</span><br><span>  * Overhead added to packets by various pr=
otocols=2E</span><br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/o=
penvpn/ssl_openssl=2Ec</span><br><span>index 32b13db=2E=2Ee4b760e 100644</s=
pan><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/o=
penvpn/ssl_openssl=2Ec</span><br><span>@@ -436,6 +436,7 @@</span><br><span>=
     }</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifdef TLS1_3_VERSION</span><br><span> static void<=
/span><br><span> convert_tls13_list_to_openssl(char *openssl_ciphers, size_=
t len, const char *ciphers)</span><br><span> {</span><br><span>@@ -460,6 +4=
61,7 @@</span><br><span>         }</span><br><span>     }</span><br><span> =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span> </span><br><span> void</span><br><span> tls_ctx_restrict_ciphers_tls1=
3(struct tls_root_ctx *ctx, const char *ciphers)</span><br><span>diff --git=
 a/tests/unit_tests/openvpn/test_pkcs11=2Ec b/tests/unit_tests/openvpn/test=
_pkcs11=2Ec</span><br><span>index 8b6e594=2E=2E042bd8b 100644</span><br><sp=
an>--- a/tests/unit_tests/openvpn/test_pkcs11=2Ec</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/test_pkcs11=2Ec</span><br><span>@@ -45,6 +45,7 @@</sp=
an><br><span> </span><br><span> struct management *management; /* global */=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
if defined(ENABLE_CRYPTO_OPENSSL)</span><br><span> /* replacement for crypt=
o_print_openssl_errors() */</span><br><span> void</span><br><span> crypto_p=
rint_openssl_errors(const unsigned int flags)</span><br><span>@@ -55,6 +56,=
7 @@</span><br><span>         msg(flags, &quot;OpenSSL error %lu: %s&quot;,=
 e, ERR_error_string(e, NULL));</span><br><span>     }</span><br><span> }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n> </span><br><span> /* stubs for some unused functions instead of pulling =
in too many dependencies */</span><br><span> int</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1611?usp=3Demail">change 1611</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1611?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I81b7168b64c438f759eace1e8f2735891c797bb9=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1611 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:n=
one"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>

</body></html>
--kDP0oiIabmc=--


--===============3526288270317923532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3526288270317923532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3526288270317923532==--

