Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CA7606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 01:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kuSemwZ2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YXP7fev0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eGLRl/Gg;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bhiQypyJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=xM77gdPVSA8Jm4IxIS2MwIRN/giTh+MNkNDroYcEwuQ=; b=kuSemwZ2GMakqEjNndmDMVwPcs
	V4239EPRLxMo9wlbwwBfRbVA4Cat4ZOcnDaWPqdTyUckAxrO/71SKgvzoXtgE+MnzQNUsYTdqR9c9
	yHZy+a71vKr/25g9FZyGyqHYbkxXgiqK7Rt/sYw8FFqM3KmO/nwzij8cnsUMcpIDEzcw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWksE-0000000057v-11s5;
	Fri, 27 Nov 2026 01:35:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWksC-0000000057b-0NDM
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 01:35:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BAUJOK6o/2ytpb+6RI9a2Lrp9mscgaIfFzAsXIOv8ts=; b=YXP7fev0F5A6Hw38pfbs+9MAL3
 vuTVvelwakzyPz7WDgWIM5+Oz9HXqAuDMT1t0uPyFaomCU8+nh/u8XqCmj4ywk1CqdzbPhGipqHIQ
 9MZckb8naL4RxX/39y9H4jT4IM/171+3sLn+0CvC15fnTwMI7KLP1tQ9MXcBt4PexTQw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BAUJOK6o/2ytpb+6RI9a2Lrp9mscgaIfFzAsXIOv8ts=; b=eGLRl/Gg13YZ2FVZmRCpIK/O8P
 cKf0xQ4qF++ngfmnUCRlHPhZ90aPy/gGg4T9KGR71DADcdCszcuLjUHdzVUUN36GC6AJvuFYiKKOZ
 gJ0mI1U0xU+9dVxBsoAc8e205xVzM+FbpEUAoLaVYGT1WsmYfbhTWUAwn1aD6Nsf2Fm4=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWks8-000000001dh-4BcY for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 01:35:36 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4bb77a462c6so61971405e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 17:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795743326; x=1796348126; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BAUJOK6o/2ytpb+6RI9a2Lrp9mscgaIfFzAsXIOv8ts=;
 b=bhiQypyJ1zUvFiEAUZJGetfTdFsrbEBzrQA3b3PsRiqHT4gFw+gbtliVXQEpq9Txol
 Ke6dWY5ngJhiHIgX8JrC9kIpPEJZ6kffnkuyuN3vfeAGP5seauc9ViCwBUKbT3IxPyaJ
 XmoOOXYV6k0bA/lWPRIp5brXD/80bfIxZ5J37tPML/Jmm8O3punK50f196mrph7Z/p6+
 CK2D5Nsu4MzalyEPGUWl3wy5ejKaSAXzv0LIQDAAP7PUNuK66TC/+v6Cn6FYDlMED+r7
 DKd8GHE+QF8z5AkRCDYkMtpqxKYG03ANb/jJ0TyBRob+cuRDe22cZ+YFHk+8Jvpt3NcI
 0yXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795743326; x=1796348126;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BAUJOK6o/2ytpb+6RI9a2Lrp9mscgaIfFzAsXIOv8ts=;
 b=nN4T8cPloXCas06Kuzu7aXRSKWBiYWftJN9b8uMny0XKL+iJHU+O5rG7fYzUNdFgt8
 zoeascFSY3oYEGGM5YMH4JhsTYZcitKqQkLDm9gThGXyImulzeMm94AeFfmBMVtn4n/b
 FzT6RUxe0wN6E5SBSwf4lIcU9C/bXoi7OZ/EhcDGD8FaX10awCvoFOkDSM26I8f7lNdW
 uP+og4SSMXvRV2cP+tS1g8hGl9dj4WHO5Hv51QhxyyYVJQ3p/zJvLZK5Q1IhdDg81uTA
 b3zXPhHF3QAYa54V9TTVeJhsZgmkxKJu5rPTkSIejL9FHFTJGaJtCLPl0s8f7AY6OMJR
 Xcsw==
X-Gm-Message-State: APuU4Z8J/g1qr7aSAGVumZklU0Fy8+m+drY/JGBy7u2OIxOxaE8Ct7p+
 lDYU6HyfQMvxoHHamZ0Y1jcM9jzSleGLVMSRJT3xGeO6MKPGTm1Up2BmmmlsMva/zUT1lfPuFZE
 /MCHmbBooyIWhwSCoI7Ttb33Ho11Qu+KZBRI5fFsb7dMv8tEkVD2gtK0WDLALvQJ5eyfKtzOIfb
 /fp1aadg==
X-Gm-Gg: AZFdTZfSK4yFmcyYoi/U0d5dHq5s7z0ML1dIn+u+TpB8dFwfPLd6HgfdzWYrTA+SXsE
 jBHDJ2EieVmmQwJcQLKtxqusjev+n3LWiddH+R12Opxpu0Ry907lscRp4t+E92PpLdjRWlPc4m5
 njfRlLfxMgNDWl/z+Asf+NvouTZg98w1DQ3/wXmUNSh4fSkBOZOFc8aaOWUfB3D/IKqRyKhNt5s
 A+hZT0qCGTu00CVzkmKKzE4mTE40rf9F3xbN1T6zGuSfRDR1Dmg58Rv2b/JQOQ1YkEUUP1igH7c
 e/1rg/3A4XYJiyHiusNEX03NFjtY4Q4uATvVeavel6uvZR1qMio58HHubwSpn/RHxASMMe4ZXgR
 C4E06+P19UYKdOSGzAHUSxnIFCu5a+oJnDx6zV1xFr8R9qHGDT6CDu6Fyd4Mlkd5I67o6TmRck/
 hkvqLs4qy5RWn7b4aC5qVwJzGLINvwA5vsZD5mJcGXH3j2mGs8Me4NkLaY7+y8HjoV6+ufAN3UE
 n8nfoNpvtTGg5qNIwinVDLLIyPdcWB8fUfUOflOhTCJ7w+WREFPuR3iiqJmtNOWcNWePHxJeexW
 4LyxP/uZNVx6rOK8dUEXMAMYctrmAuCCbidE0N0IA5A8LAxVT5K5ZidtG5zrHBMj5VTrOjFcgli
 day6v04Pv61K1AChp3gXY94aczTCEezSjcN6fTar/Wwl/ogrppvXm+k8MrjPrwNvNcMS16IxMeW
 DlKv9rUD7aqKEpbk+Z
X-Received: by 2002:a05:600c:e553:b0:4bb:9457:3c93 with SMTP id
 5b1f17b1804b1-4bb94573c9amr264457865e9.2.1795743326018; 
 Thu, 26 Nov 2026 17:35:26 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b09bsm1184430675e9.4.2026.11.26.17.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 17:35:25 -0800 (PST)
X-Google-Original-From: "Max Fillinger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 01:35:25 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6c6dfed1557608d5b1442fb008bf84fa4f948579
X-Gerrit-Change-Number: 2359
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2359?usp=email>
X-Gerrit-Commit: 165b8298c79e51ec1a92bbcf3c324df48879ced3
References: <gerrit.1795743323000.I6c6dfed1557608d5b1442fb008bf84fa4f948579@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzQzMzIzMDAwLkk2YzZkZmVkMTU1NzYwOGQ1YjE0NDJmYjAwOGJmODRmYTRmOTQ4NTc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3e55ca09781c00985cf97ec06599c029e27481d9-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWks8-000000001dh-4BcY
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Reject certificates
 with too large serial numbers
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Max Fillinger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Max Fillinger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7927193619175222767=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7927193619175222767==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="anrq8FMHA6g="; charset=UTF-8

--anrq8FMHA6g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2359?usp=3Demail

to review the following change=2E
=


Change subject: Reject certificates with too large serial numbers
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Reject certificates=
 with too large serial numbers

Arturs Parker and Jim Biniyaz, ResilientX S=
ecurity, reported that
OpenVPN with the Mbed TLS backend can be DoS'd by se=
nding certificates
with extremely large (8 KB) serial numbers, because the =
functions for
writing these serial numbers in decimal are inefficient=2E

T=
his could be fixed by checking the serial number size before printing,
but =
we decided instead to check the certificates immediately (both in
Mbed TLS =
and OpenSSL) and refuse them if their serial number is too
large=2E This is=
 because someone sending a certificate with an excessively
long serial numb=
er is likely up to no good, and we would rather not wait
to find out if the=
y can also cause problems in other places=2E

We use 40 bytes as the limit =
for serial numbers, which is twice the
maximum allowed by RFC 5280=2E

CVE:=
 2026-135412
Reported-by: Arturs Parker and Jim Biniyaz, ResilientX Securit=
y
Github: OpenVPN/openvpn-private-issues/issues/187
Change-Id: I6c6dfed1557=
608d5b1442fb008bf84fa4f948579
Signed-off-by: Max Fillinger <max@max-filling=
er=2Enet>
---
M src/openvpn/cryptoapi=2Ec
M src/openvpn/ssl_mbedtls=2Ec
M s=
rc/openvpn/ssl_openssl=2Ec
M src/openvpn/ssl_verify=2Eh
M src/openvpn/ssl_v=
erify_backend=2Eh
M src/openvpn/ssl_verify_mbedtls=2Ec
M src/openvpn/ssl_ve=
rify_openssl=2Ec
7 files changed, 139 insertions(+), 13 deletions(-)



  g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/2359/1

=
diff --git a/src/openvpn/cryptoapi=2Ec b/src/openvpn/cryptoapi=2Ec
index 30=
a5144=2E=2Ed32100e 100644
--- a/src/openvpn/cryptoapi=2Ec
+++ b/src/openvpn=
/cryptoapi=2Ec
@@ -52,6 +52,8 @@
 #include "win32=2Eh"
 #include "xkey_comm=
on=2Eh"
 #include "crypto_openssl=2Eh"
+#include "ssl_verif=2Eh"
+#include =
"ssl_verify_backend=2Eh"
 
 #ifndef HAVE_XKEY_PROVIDER
 
@@ -618,6 +620,10 =
@@
     {
         return ret;
     }
+    if (!backend_x509_serial_size_ok=
(cert))
+    {
+        msg(M_FATAL, "The certificate serial number is too =
large, maximum size is %d=2E", MAX_SERIAL_SIZE);
+    }
     if (SSL_CTX_us=
e_certificate(ssl_ctx, cert) && SSL_CTX_use_PrivateKey(ssl_ctx, privkey))
 =
    {
         crypto_print_openssl_errors(M_WARN);
diff --git a/src/openvp=
n/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index dbc1b9d=2E=2E0bdca37 =
100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
=
@@ -44,6 +44,8 @@
 #include "pkcs11_backend=2Eh"
 #include "ssl_common=2Eh"=

 #include "ssl_util=2Eh"
+#include "ssl_verify=2Eh"
+#include "ssl_verify_=
backend=2Eh"
 
 #include "ssl_verify_mbedtls=2Eh"
 #include <mbedtls/debug=
=2Eh>
@@ -427,6 +429,21 @@
 }
 #endif /* _WIN32 */
 
+static bool
+cert_cha=
in_serial_size_ok(const mbedtls_x509_crt *cert_chain)
+{
+    const mbedtls=
_x509_crt *cert =3D cert_chain;
+    while (cert !=3D NULL)
+    {
+       =
 if (!backend_x509_serial_size_ok(cert))
+        {
+            return fal=
se;
+        }
+        cert =3D cert->next;
+    }
+    return true;
+}
+
=
 void
 tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_fi=
le, bool cert_inline)
 {
@@ -456,6 +473,11 @@
             msg(M_FATAL, "Ca=
nnot load certificate file %s", cert_file);
         }
     }
+
+    if (!c=
ert_chain_serial_size_ok(ctx->crt_chain))
+    {
+        msg(M_FATAL, "The=
 serial number of a certificate is too large, maximum size is %d=2E", MAX_S=
ERIAL_SIZE);
+    }
 }
 
 int
@@ -605,6 +627,11 @@
             msg(M_FATAL=
, "Cannot load CA certificate file %s", ca_file);
         }
     }
+
+    =
if (!cert_chain_serial_size_ok(ctx->ca_chain))
+    {
+        msg(M_FATAL,=
 "The serial number of a CA certificate is too large, maximum size is %d=2E=
", MAX_SERIAL_SIZE);
+    }
 }
 
 void
@@ -633,6 +660,12 @@
             ms=
g(M_FATAL, "Cannot load extra-certs file: %s", extra_certs_file);
         =
}
     }
+
+    if (!cert_chain_serial_size_ok(ctx->crt_chain))
+    {
+   =
     msg(M_FATAL, "The certificate serial number of an extra certificate is=
 too large, maximum size is %d=2E",
+            MAX_SERIAL_SIZE);
+    }
 =
}
 
 /* **************************************
diff --git a/src/openvpn/ssl=
_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index 03e0279=2E=2E52b05dd 10064=
4
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -4=
1,6 +41,8 @@
 #include "memdbg=2Eh"
 #include "ssl_backend=2Eh"
 #include "=
ssl_common=2Eh"
+#include "ssl_verify=2Eh"
+#include "ssl_verify_backend=2E=
h"
 #include "base64=2Eh"
 #include "openssl_compat=2Eh"
 #include "xkey_co=
mmon=2Eh"
@@ -912,7 +914,7 @@
     FILE *fp;
     EVP_PKEY *pkey;
     X509=
 *cert;
-    STACK_OF(X509) *ca =3D NULL;
+    STACK_OF(X509) *ca_stack =3D=
 NULL;
     PKCS12 *p12;
     char password[256];
 
@@ -948,12 +950,12 @@
 =
    }
 
     /* Parse the PKCS #12 file */
-    if (!PKCS12_parse(p12, "", =
&pkey, &cert, &ca))
+    if (!PKCS12_parse(p12, "", &pkey, &cert, &ca_stack=
))
     {
         pem_password_callback(password, sizeof(password) - 1, 0,=
 NULL);
         /* Reparse the PKCS #12 file with password */
-        ca =
=3D NULL;
-        if (!PKCS12_parse(p12, password, &pkey, &cert, &ca))
+  =
      ca_stack =3D NULL;
+        if (!PKCS12_parse(p12, password, &pkey, &=
cert, &ca_stack))
         {
             crypto_msg(M_WARN, "Decoding PKCS=
12 failed=2E Probably wrong password "
                                "or =
unsupported/legacy encryption");
@@ -970,6 +972,10 @@
     PKCS12_free(p12)=
;
 
     /* Load Certificate */
+    if (!backend_x509_serial_size_ok(cert)=
)
+    {
+        msg(M_FATAL, "The certificate serial number is too large,=
 maximum size is %d=2E", MAX_SERIAL_SIZE);
+    }
     if (!SSL_CTX_use_cer=
tificate(ctx->ctx, cert))
     {
         crypto_print_openssl_errors(M_WAR=
N);
@@ -995,24 +1001,29 @@
          * They're also used to fill in the cha=
in of intermediate certs as
          * necessary=2E
          */
-        =
if (ca && sk_X509_num(ca))
+        if (ca_stack && sk_X509_num(ca_stack))
=
         {
-            for (openssl_stack_size_t i =3D 0; i < sk_X509_num(=
ca); i++)
+            for (openssl_stack_size_t i =3D 0; i < sk_X509_num(c=
a_stack); i++)
             {
+                X509 *ca =3D sk_X509_value(c=
a_stack, i);
+                if (!backend_x509_serial_size_ok(ca))
+      =
          {
+                    msg(M_FATAL, "The certificate serial numbe=
r is too large, maximum size is %d=2E", MAX_SERIAL_SIZE);
+                =
}
                 X509_STORE *cert_store =3D SSL_CTX_get_cert_store(ctx->c=
tx);
-                if (!X509_STORE_add_cert(cert_store, sk_X509_value(ca=
, i)))
+                if (!X509_STORE_add_cert(cert_store, ca))
         =
        {
                     crypto_msg(M_FATAL,
                        =
        "Cannot add certificate to certificate chain (X509_STORE_add_cert)"=
);
                 }
-                if (!SSL_CTX_add_client_CA(ctx->ctx,=
 sk_X509_value(ca, i)))
+                if (!SSL_CTX_add_client_CA(ctx->ct=
x, ca))
                 {
                     crypto_msg(M_FATAL,
       =
                         "Cannot add certificate to client CA list (SSL_CTX=
_add_client_CA)");
                 }
             }
         }
-        sk=
_X509_pop_free(ca, X509_free);
+        sk_X509_pop_free(ca_stack, X509_fre=
e);
     }
     else
     {
@@ -1021,11 +1032,16 @@
          * certs chain=
 just in case they include intermediate CAs needed to
          * prove my =
identity to the other end=2E This does not make them trusted=2E
          *=
/
-        if (ca && sk_X509_num(ca))
+        if (ca_stack && sk_X509_num(=
ca_stack))
         {
-            for (openssl_stack_size_t i =3D 0; i < s=
k_X509_num(ca); i++)
+            for (openssl_stack_size_t i =3D 0; i < sk=
_X509_num(ca_stack); i++)
             {
-                if (!SSL_CTX_add_=
extra_chain_cert(ctx->ctx, sk_X509_value(ca, i)))
+                const X5=
09 *chain_cert =3D sk_X509_value(ca_stack, i);
+                if (!backen=
d_x509_serial_size_ok(chain_cert))
+                {
+                    =
msg(M_FATAL, "The certificate serial number is too large, maximum size is %=
d=2E", MAX_SERIAL_SIZE);
+                }
+                if (!SSL_CTX_a=
dd_extra_chain_cert(ctx->ctx, chain_cert))
                 {
             =
        crypto_msg(
                         M_FATAL,
@@ -1034,7 +1050,7 @@=

             }
         }
         /* the certs now belong to ctx */
-    =
    sk_X509_free(ca);
+        sk_X509_free(ca_stack);
     }
     X509_fre=
e(cert);
     EVP_PKEY_free(pkey);
@@ -1079,6 +1095,12 @@
             /* O=
therwise, bail out with error */
             crypto_msg(M_FATAL, "Error re=
ading extra certificate");
         }
+
+        if (!backend_x509_serial_s=
ize_ok(cert))
+        {
+            msg(M_FATAL, "The certificate serial =
number is too large, maximum size is %d=2E", MAX_SERIAL_SIZE);
+        }
+=

         /* takes ownership of cert like a set1 method */
         if (SSL=
_CTX_add_extra_chain_cert(ctx->ctx, cert) !=3D 1)
         {
@@ -1154,6 +11=
76,11 @@
     }
     msg(D_TLS_DEBUG_MED, "Found cert in store using URI: %=
s", uri);
 
+    if (!backend_x509_serial_size_ok(x))
+    {
+        msg(M=
_FATAL, "The certificate serial number is too large, maximum size is %d=2E"=
, MAX_SERIAL_SIZE);
+    }
+
     ret =3D SSL_CTX_use_certificate(tls_ctx->=
ctx, x);
     if (!ret)
     {
@@ -1233,6 +1260,11 @@
         goto end;
  =
   }
 
+    if (!backend_x509_serial_size_ok(x))
+    {
+        msg(M_FATA=
L, "The certificate serial number is too large, maximum size is %d=2E", MAX=
_SERIAL_SIZE);
+    }
+
     ret =3D SSL_CTX_use_certificate(ctx->ctx, x);
=
     if (ret)
     {
diff --git a/src/openvpn/ssl_verify=2Eh b/src/openvpn/=
ssl_verify=2Eh
index e77bc4a=2E=2Ecfb71a9 100644
--- a/src/openvpn/ssl_veri=
fy=2Eh
+++ b/src/openvpn/ssl_verify=2Eh
@@ -53,6 +53,14 @@
 /** Maximum len=
gth of common name */
 #define TLS_USERNAME_LEN 64
 
+/**
+ * Maximum lengt=
h for serial numbers=2E
+ *
+ * RFC 5280 says that conformant CAs must not =
issue certificates with serial
+ * numbers longer than 20 bytes=2E To be ge=
nerous, we allow double that amount=2E
+ */
+#define MAX_SERIAL_SIZE 40
+
 =
/** Structure containing the hash for a single certificate */
 struct cert_=
hash
 {
diff --git a/src/openvpn/ssl_verify_backend=2Eh b/src/openvpn/ssl_v=
erify_backend=2Eh
index 46720d6=2E=2Ec1f68c52 100644
--- a/src/openvpn/ssl_=
verify_backend=2Eh
+++ b/src/openvpn/ssl_verify_backend=2Eh
@@ -265,4 +265,=
13 @@
  */
 bool tls_verify_crl_missing(const struct tls_options *opt);
 
+=
/**
+ * Check the size of a certificate serial number=2E
+ *
+ * @param cer=
t  Certificate to check=2E
+ *
+ * @return True if the size of the serial n=
umber is acceptable=2E
+ */
+bool backend_x509_serial_size_ok(const openvpn=
_x509_cert_t *cert);
+
 #endif /* SSL_VERIFY_BACKEND_H_ */
diff --git a/src=
/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec
index =
bba2f2f=2E=2E81f891e 100644
--- a/src/openvpn/ssl_verify_mbedtls=2Ec
+++ b/=
src/openvpn/ssl_verify_mbedtls=2Ec
@@ -37,6 +37,7 @@
 #include "crypto_mbed=
tls=2Eh"
 
 #include "ssl_verify=2Eh"
+#include "ssl_verify_backend=2Eh"
 #=
include <mbedtls/asn1=2Eh>
 #include <mbedtls/error=2Eh>
 #include <mbedtls=
/oid=2Eh>
@@ -54,6 +55,14 @@
 
     session->verified =3D false;
 
+    if =
(!backend_x509_serial_size_ok(cert))
+    {
+        *flags |=3D MBEDTLS_X5=
09_BADCERT_OTHER;
+        msg(D_TLS_ERRORS, "VERIFY ERROR: depth=3D%d, Cer=
tificate with excessively long serial, maximum is %d bytes=2E",
+          =
  cert_depth, MAX_SERIAL_SIZE);
+        goto cleanup;
+    }
+
     /* Rem=
ember certificate hash */
     struct buffer cert_fingerprint =3D x509_get_=
sha256_fingerprint(cert, &gc);
     cert_hash_remember(session, cert_depth,=
 &cert_fingerprint);
@@ -112,6 +121,7 @@
         *flags |=3D MBEDTLS_X509_=
BADCERT_OTHER;
     }
 
+cleanup:
     gc_free(&gc);
 
     /*
@@ -120,6 +1=
30,12 @@
     return 0;
 }
 
+bool
+backend_x509_serial_size_ok(const mbedt=
ls_x509_crt *cert)
+{
+    return cert->serial=2Elen <=3D MAX_SERIAL_SIZE;
=
+}
+
 /* not supported for mbedTLS yet */
 bool
 x509_username_field_ext_su=
pported(const char *fieldname)
diff --git a/src/openvpn/ssl_verify_openssl=
=2Ec b/src/openvpn/ssl_verify_openssl=2Ec
index 731ab3e=2E=2E266bbf4 100644=

--- a/src/openvpn/ssl_verify_openssl=2Ec
+++ b/src/openvpn/ssl_verify_open=
ssl=2Ec
@@ -46,6 +46,21 @@
 #include <openssl/err=2Eh>
 #include <openssl/x=
509v3=2Eh>
 
+bool
+backend_x509_serial_size_ok(const X509 *cert)
+{
+    b=
ool size_ok =3D false;
+    const ASN1_INTEGER *asn1_i =3D X509_get0_serial=
Number(cert);
+    BIGNUM *bn_serial =3D ASN1_INTEGER_to_BN(asn1_i, NULL);
=
+    if (bn_serial !=3D NULL)
+    {
+        int size =3D BN_num_bytes(bn_=
serial);
+        size_ok =3D size <=3D MAX_SERIAL_SIZE;
+    }
+    BN_fre=
e(bn_serial);
+    return size_ok;
+}
+
 int
 verify_callback(int preverify=
_ok, X509_STORE_CTX *ctx)
 {
@@ -61,6 +76,13 @@
     ASSERT(session);
 
   =
  X509 *current_cert =3D X509_STORE_CTX_get_current_cert(ctx);
+    if (!ba=
ckend_x509_serial_size_ok(current_cert))
+    {
+        msg(D_TLS_ERRORS, =
"VERIFY ERROR: Certificate with excessively long serial, maximum is %d byte=
s=2E",
+            MAX_SERIAL_SIZE);
+        goto cleanup;
+    }
+
     =
struct buffer cert_hash =3D x509_get_sha256_fingerprint(current_cert, &gc);=

     cert_hash_remember(session, X509_STORE_CTX_get_error_depth(ctx), &cer=
t_hash);
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
359?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newch=
ange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6c6df=
ed1557608d5b1442fb008bf84fa4f948579
Gerrit-Change-Number: 2359
Gerrit-Patch=
Set: 1
Gerrit-Owner: Max Fillinger <max@max-fillinger=2Enet>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>

--anrq8FMHA6g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Max Fillinger would like Arne=
 Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2359?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Reject certificates with too large serial numbers<br><br>Artur=
s Parker and Jim Biniyaz, ResilientX Security, reported that<br>OpenVPN wit=
h the Mbed TLS backend can be DoS&#39;d by sending certificates<br>with ext=
remely large (8 KB) serial numbers, because the functions for<br>writing th=
ese serial numbers in decimal are inefficient=2E<br><br>This could be fixed=
 by checking the serial number size before printing,<br>but we decided inst=
ead to check the certificates immediately (both in<br>Mbed TLS and OpenSSL)=
 and refuse them if their serial number is too<br>large=2E This is because =
someone sending a certificate with an excessively<br>long serial number is =
likely up to no good, and we would rather not wait<br>to find out if they c=
an also cause problems in other places=2E<br><br>We use 40 bytes as the lim=
it for serial numbers, which is twice the<br>maximum allowed by RFC 5280=2E=
<br><br>CVE: 2026-135412<br>Reported-by: Arturs Parker and Jim Biniyaz, Res=
ilientX Security<br>Github: OpenVPN/openvpn-private-issues/issues/187<br>Ch=
ange-Id: I6c6dfed1557608d5b1442fb008bf84fa4f948579<br>Signed-off-by: Max Fi=
llinger &lt;max@max-fillinger=2Enet&gt;<br>---<br>M src/openvpn/cryptoapi=
=2Ec<br>M src/openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_openssl=2Ec<br>M=
 src/openvpn/ssl_verify=2Eh<br>M src/openvpn/ssl_verify_backend=2Eh<br>M sr=
c/openvpn/ssl_verify_mbedtls=2Ec<br>M src/openvpn/ssl_verify_openssl=2Ec<br=
>7 files changed, 139 insertions(+), 13 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/23=
59/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/cryptoapi=2Ec b/src/openvpn/cryptoapi=
=2Ec</span><br><span>index 30a5144=2E=2Ed32100e 100644</span><br><span>--- =
a/src/openvpn/cryptoapi=2Ec</span><br><span>+++ b/src/openvpn/cryptoapi=2Ec=
</span><br><span>@@ -52,6 +52,8 @@</span><br><span> #include &quot;win32=2E=
h&quot;</span><br><span> #include &quot;xkey_common=2Eh&quot;</span><br><sp=
an> #include &quot;crypto_openssl=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &quot;ssl_verif=2Eh&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_verify_backend=2E=
h&quot;</span><br><span> </span><br><span> #ifndef HAVE_XKEY_PROVIDER</span=
><br><span> </span><br><span>@@ -618,6 +620,10 @@</span><br><span>     {</s=
pan><br><span>         return ret;</span><br><span>     }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!backend_x509_serial_size_ok(=
cert))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;=
The certificate serial number is too large, maximum size is %d=2E&quot;, MA=
X_SERIAL_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span>     if (SSL_CTX_use_certificate(ssl_ctx, cert) &amp;&amp=
; SSL_CTX_use_PrivateKey(ssl_ctx, privkey))</span><br><span>     {</span><b=
r><span>         crypto_print_openssl_errors(M_WARN);</span><br><span>diff =
--git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br=
><span>index dbc1b9d=2E=2E0bdca37 100644</span><br><span>--- a/src/openvpn/=
ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br=
><span>@@ -44,6 +44,8 @@</span><br><span> #include &quot;pkcs11_backend=2Eh=
&quot;</span><br><span> #include &quot;ssl_common=2Eh&quot;</span><br><span=
> #include &quot;ssl_util=2Eh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;ssl_verify=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_verify_backend=2Eh&quo=
t;</span><br><span> </span><br><span> #include &quot;ssl_verify_mbedtls=2Eh=
&quot;</span><br><span> #include &lt;mbedtls/debug=2Eh&gt;</span><br><span>=
@@ -427,6 +429,21 @@</span><br><span> }</span><br><span> #endif /* _WIN32 *=
/</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cert_cha=
in_serial_size_ok(const mbedtls_x509_crt *cert_chain)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const mbedtls_x509_crt *cert =3D cert_chain;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    while (cert !=3D NULL)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (!backend_x509_serial_size=
_ok(cert))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return =
false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        cert =3D cert-&=
gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> tls_ct=
x_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file, bool cert=
_inline)</span><br><span> {</span><br><span>@@ -456,6 +473,11 @@</span><br>=
<span>             msg(M_FATAL, &quot;Cannot load certificate file %s&quot;=
, cert_file);</span><br><span>         }</span><br><span>     }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!cert_chain_serial_size_ok(ctx-&gt;crt_cha=
in))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;Th=
e serial number of a certificate is too large, maximum size is %d=2E&quot;,=
 MAX_SERIAL_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span> }</span><br><span> </span><br><span> int</span><br><s=
pan>@@ -605,6 +627,11 @@</span><br><span>             msg(M_FATAL, &quot;Ca=
nnot load CA certificate file %s&quot;, ca_file);</span><br><span>         =
}</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!cert_=
chain_serial_size_ok(ctx-&gt;ca_chain))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg(M_FATAL, &quot;The serial number of a CA certificate is t=
oo large, maximum size is %d=2E&quot;, MAX_SERIAL_SIZE);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><br><sp=
an> </span><br><span> void</span><br><span>@@ -633,6 +660,12 @@</span><br><=
span>             msg(M_FATAL, &quot;Cannot load extra-certs file: %s&quot;=
, extra_certs_file);</span><br><span>         }</span><br><span>     }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!cert_chain_serial_size_ok(ctx-&g=
t;crt_chain))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL,=
 &quot;The certificate serial number of an extra certificate is too large, =
maximum size is %d=2E&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            MAX_SERIAL_SIZE);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span> }</span><br><span> </span><br><sp=
an> /* **************************************</span><br><span>diff --git a/=
src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>i=
ndex 03e0279=2E=2E52b05dd 100644</span><br><span>--- a/src/openvpn/ssl_open=
ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@=
@ -41,6 +41,8 @@</span><br><span> #include &quot;memdbg=2Eh&quot;</span><br=
><span> #include &quot;ssl_backend=2Eh&quot;</span><br><span> #include &quo=
t;ssl_common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;ssl_verify=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;ssl_verify_backend=2Eh&quot;</span><br><s=
pan> #include &quot;base64=2Eh&quot;</span><br><span> #include &quot;openss=
l_compat=2Eh&quot;</span><br><span> #include &quot;xkey_common=2Eh&quot;</s=
pan><br><span>@@ -912,7 +914,7 @@</span><br><span>     FILE *fp;</span><br>=
<span>     EVP_PKEY *pkey;</span><br><span>     X509 *cert;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    STACK_OF(X509) *ca =3D NULL;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    STACK_OF(X509) *ca_s=
tack =3D NULL;</span><br><span>     PKCS12 *p12;</span><br><span>     char =
password[256];</span><br><span> </span><br><span>@@ -948,12 +950,12 @@</spa=
n><br><span>     }</span><br><span> </span><br><span>     /* Parse the PKCS=
 #12 file */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!=
PKCS12_parse(p12, &quot;&quot;, &amp;pkey, &amp;cert, &amp;ca))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!PKCS12_parse(p12, &quo=
t;&quot;, &amp;pkey, &amp;cert, &amp;ca_stack))</span><br><span>     {</spa=
n><br><span>         pem_password_callback(password, sizeof(password) - 1, =
0, NULL);</span><br><span>         /* Reparse the PKCS #12 file with passwo=
rd */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ca =3D N=
ULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!PKCS=
12_parse(p12, password, &amp;pkey, &amp;cert, &amp;ca))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        ca_stack =3D NULL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (!PKCS12_parse(p12, p=
assword, &amp;pkey, &amp;cert, &amp;ca_stack))</span><br><span>         {</=
span><br><span>             crypto_msg(M_WARN, &quot;Decoding PKCS12 failed=
=2E Probably wrong password &quot;</span><br><span>                        =
        &quot;or unsupported/legacy encryption&quot;);</span><br><span>@@ -=
970,6 +972,10 @@</span><br><span>     PKCS12_free(p12);</span><br><span> </=
span><br><span>     /* Load Certificate */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!backend_x509_serial_size_ok(cert))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;The certificat=
e serial number is too large, maximum size is %d=2E&quot;, MAX_SERIAL_SIZE)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan>     if (!SSL_CTX_use_certificate(ctx-&gt;ctx, cert))</span><br><span> =
    {</span><br><span>         crypto_print_openssl_errors(M_WARN);</span><=
br><span>@@ -995,24 +1001,29 @@</span><br><span>          * They&#39;re als=
o used to fill in the chain of intermediate certs as</span><br><span>      =
    * necessary=2E</span><br><span>          */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (ca &amp;&amp; sk_X509_num(ca))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ca_stack &amp;=
&amp; sk_X509_num(ca_stack))</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            for (openssl_stack_size_t i =
=3D 0; i &lt; sk_X509_num(ca); i++)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            for (openssl_stack_size_t i =3D 0; i &lt; sk_X5=
09_num(ca_stack); i++)</span><br><span>             {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                X509 *ca =3D sk_X509_valu=
e(ca_stack, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            if (!backend_x509_serial_size_ok(ca))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    msg(M_FATAL, &quot;The cert=
ificate serial number is too large, maximum size is %d=2E&quot;, MAX_SERIAL=
_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    }</span><br><span>                 X509_STORE *cert_store =3D SSL_CTX_g=
et_cert_store(ctx-&gt;ctx);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                if (!X509_STORE_add_cert(cert_store, sk_X509_value(ca=
, i)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   if (!X509_STORE_add_cert(cert_store, ca))</span><br><span>              =
   {</span><br><span>                     crypto_msg(M_FATAL,</span><br><sp=
an>                                &quot;Cannot add certificate to certific=
ate chain (X509_STORE_add_cert)&quot;);</span><br><span>                 }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (!S=
SL_CTX_add_client_CA(ctx-&gt;ctx, sk_X509_value(ca, i)))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                if (!SSL_CTX_add_clien=
t_CA(ctx-&gt;ctx, ca))</span><br><span>                 {</span><br><span> =
                    crypto_msg(M_FATAL,</span><br><span>                   =
             &quot;Cannot add certificate to client CA list (SSL_CTX_add_cl=
ient_CA)&quot;);</span><br><span>                 }</span><br><span>       =
      }</span><br><span>         }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        sk_X509_pop_free(ca, X509_free);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        sk_X509_pop_free(ca_stack, X509_f=
ree);</span><br><span>     }</span><br><span>     else</span><br><span>    =
 {</span><br><span>@@ -1021,11 +1032,16 @@</span><br><span>          * cert=
s chain just in case they include intermediate CAs needed to</span><br><spa=
n>          * prove my identity to the other end=2E This does not make them=
 trusted=2E</span><br><span>          */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (ca &amp;&amp; sk_X509_num(ca))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (ca_stack &amp;&amp; s=
k_X509_num(ca_stack))</span><br><span>         {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            for (openssl_stack_size_t i =3D 0; i=
 &lt; sk_X509_num(ca); i++)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            for (openssl_stack_size_t i =3D 0; i &lt; sk_X509_num(c=
a_stack); i++)</span><br><span>             {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                if (!SSL_CTX_add_extra_chain_cert(c=
tx-&gt;ctx, sk_X509_value(ca, i)))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                const X509 *chain_cert =3D sk_X509_value(ca_=
stack, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       if (!backend_x509_serial_size_ok(chain_cert))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    msg(M_FATAL, &quot;Th=
e certificate serial number is too large, maximum size is %d=2E&quot;, MAX_=
SERIAL_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        if (!SSL_CTX_add_extra_chain_cert(ctx-&gt;ctx, chain_cert))</span><=
br><span>                 {</span><br><span>                     crypto_msg=
(</span><br><span>                         M_FATAL,</span><br><span>@@ -103=
4,7 +1050,7 @@</span><br><span>             }</span><br><span>         }</s=
pan><br><span>         /* the certs now belong to ctx */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        sk_X509_free(ca);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        sk_X509_free(ca_stack);</s=
pan><br><span>     }</span><br><span>     X509_free(cert);</span><br><span>=
     EVP_PKEY_free(pkey);</span><br><span>@@ -1079,6 +1095,12 @@</span><br>=
<span>             /* Otherwise, bail out with error */</span><br><span>   =
          crypto_msg(M_FATAL, &quot;Error reading extra certificate&quot;);=
</span><br><span>         }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(!backend_x509_serial_size_ok(cert))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            msg(M_FATAL, &quot;The certificate serial number is too =
large, maximum size is %d=2E&quot;, MAX_SERIAL_SIZE);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span>         /* takes ownership of cer=
t like a set1 method */</span><br><span>         if (SSL_CTX_add_extra_chai=
n_cert(ctx-&gt;ctx, cert) !=3D 1)</span><br><span>         {</span><br><spa=
n>@@ -1154,6 +1176,11 @@</span><br><span>     }</span><br><span>     msg(D_=
TLS_DEBUG_MED, &quot;Found cert in store using URI: %s&quot;, uri);</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!=
backend_x509_serial_size_ok(x))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      msg(M_FATAL, &quot;The certificate serial number is too large, maximu=
m size is %d=2E&quot;, MAX_SERIAL_SIZE);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span>     ret =3D SSL_CTX_use_certificate(tls_ctx-&gt;ct=
x, x);</span><br><span>     if (!ret)</span><br><span>     {</span><br><spa=
n>@@ -1233,6 +1260,11 @@</span><br><span>         goto end;</span><br><span=
>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!backend_x509_serial_size_ok(x))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(M_FATAL, &quot;The certificate serial number is to=
o large, maximum size is %d=2E&quot;, MAX_SERIAL_SIZE);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span>     ret =3D SSL_CTX_use_certificate=
(ctx-&gt;ctx, x);</span><br><span>     if (ret)</span><br><span>     {</spa=
n><br><span>diff --git a/src/openvpn/ssl_verify=2Eh b/src/openvpn/ssl_verif=
y=2Eh</span><br><span>index e77bc4a=2E=2Ecfb71a9 100644</span><br><span>---=
 a/src/openvpn/ssl_verify=2Eh</span><br><span>+++ b/src/openvpn/ssl_verify=
=2Eh</span><br><span>@@ -53,6 +53,14 @@</span><br><span> /** Maximum length=
 of common name */</span><br><span> #define TLS_USERNAME_LEN 64</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Maximum length for serial =
numbers=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * RFC 5280 says that conf=
ormant CAs must not issue certificates with serial</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * numbers longer than 20 bytes=2E To be gen=
erous, we allow double that amount=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define MAX_SERIAL_SIZE 40</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> /** Structure containing the hash for a single c=
ertificate */</span><br><span> struct cert_hash</span><br><span> {</span><b=
r><span>diff --git a/src/openvpn/ssl_verify_backend=2Eh b/src/openvpn/ssl_v=
erify_backend=2Eh</span><br><span>index 46720d6=2E=2Ec1f68c52 100644</span>=
<br><span>--- a/src/openvpn/ssl_verify_backend=2Eh</span><br><span>+++ b/sr=
c/openvpn/ssl_verify_backend=2Eh</span><br><span>@@ -265,4 +265,13 @@</span=
><br><span>  */</span><br><span> bool tls_verify_crl_missing(const struct t=
ls_options *opt);</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Check the size of a certificate serial number=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param cert  Certificate to check=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @return True if the size of the serial number is acc=
eptable=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+bool backend_x509_serial_=
size_ok(const openvpn_x509_cert_t *cert);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> #endif /* SSL_VERIFY_BACKEND_H_ */<=
/span><br><span>diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openv=
pn/ssl_verify_mbedtls=2Ec</span><br><span>index bba2f2f=2E=2E81f891e 100644=
</span><br><span>--- a/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>+=
++ b/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>@@ -37,6 +37,7 @@</=
span><br><span> #include &quot;crypto_mbedtls=2Eh&quot;</span><br><span> </=
span><br><span> #include &quot;ssl_verify=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_verify_backend=2Eh&quo=
t;</span><br><span> #include &lt;mbedtls/asn1=2Eh&gt;</span><br><span> #inc=
lude &lt;mbedtls/error=2Eh&gt;</span><br><span> #include &lt;mbedtls/oid=2E=
h&gt;</span><br><span>@@ -54,6 +55,14 @@</span><br><span> </span><br><span>=
     session-&gt;verified =3D false;</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (!backend_x509_serial_size_ok(cer=
t))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        *flags |=3D MBEDTLS_X5=
09_BADCERT_OTHER;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      msg(D_TLS_ERRORS, &quot;VERIFY ERROR: depth=3D%d, Certificate with ex=
cessively long serial, maximum is %d bytes=2E&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            cert_depth, MAX_SERIAL_SIZE);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto cleanu=
p;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Rememb=
er certificate hash */</span><br><span>     struct buffer cert_fingerprint =
=3D x509_get_sha256_fingerprint(cert, &amp;gc);</span><br><span>     cert_h=
ash_remember(session, cert_depth, &amp;cert_fingerprint);</span><br><span>@=
@ -112,6 +121,7 @@</span><br><span>         *flags |=3D MBEDTLS_X509_BADCER=
T_OTHER;</span><br><span>     }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+cleanup:</span><br><span>     gc_free(&amp;gc=
);</span><br><span> </span><br><span>     /*</span><br><span>@@ -120,6 +130=
,12 @@</span><br><span>     return 0;</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+backend_x509_serial_size_ok(const m=
bedtls_x509_crt *cert)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return cert=
-&gt;serial=2Elen &lt;=3D MAX_SERIAL_SIZE;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> /* not supported for mbedTLS yet */</span><br><span>=
 bool</span><br><span> x509_username_field_ext_supported(const char *fieldn=
ame)</span><br><span>diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/=
openvpn/ssl_verify_openssl=2Ec</span><br><span>index 731ab3e=2E=2E266bbf4 1=
00644</span><br><span>--- a/src/openvpn/ssl_verify_openssl=2Ec</span><br><s=
pan>+++ b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>@@ -46,6 +46,2=
1 @@</span><br><span> #include &lt;openssl/err=2Eh&gt;</span><br><span> #in=
clude &lt;openssl/x509v3=2Eh&gt;</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+backend_x509_serial_size_ok(const X509 *cert)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    bool size_ok =3D false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const ASN1_INTEGER *asn1_i =3D X509_g=
et0_serialNumber(cert);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    BIGNUM *bn_serial =3D ASN1_INTEGER_to_BN(asn1_i, NULL);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (bn_serial !=3D NULL)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        int size =3D BN_num_bytes(bn=
_serial);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        si=
ze_ok =3D size &lt;=3D MAX_SERIAL_SIZE;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    BN_free(bn_serial);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return size_ok;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> int</span><br><span> verify_callback(int preverify_ok, X509_STORE=
_CTX *ctx)</span><br><span> {</span><br><span>@@ -61,6 +76,13 @@</span><br>=
<span>     ASSERT(session);</span><br><span> </span><br><span>     X509 *cu=
rrent_cert =3D X509_STORE_CTX_get_current_cert(ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!backend_x509_serial_size_ok(curr=
ent_cert))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_TLS_ERROR=
S, &quot;VERIFY ERROR: Certificate with excessively long serial, maximum is=
 %d bytes=2E&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            MAX_SERIAL_SIZE);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        goto cleanup;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     struct buffer cert_hash =3D x509_get_sha256_fingerprint=
(current_cert, &amp;gc);</span><br><span>     cert_hash_remember(session, X=
509_STORE_CTX_get_error_depth(ctx), &amp;cert_hash);</span><br></pre><p>To =
view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2359?usp=
=3Demail">change 2359</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2359?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I6c6dfed1557608d5b1442fb008bf84fa4f948579 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2359 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Max Fillinger &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</bo=
dy></html>
--anrq8FMHA6g=--


--===============7927193619175222767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7927193619175222767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7927193619175222767==--

