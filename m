Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DFAC53219
	for <openvpn-devel@archiver.kernel.org>; Sun, 26 Jul 2026 00:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+tPvthHa70jYgIHdwPcG7w4R6uU6hhY7NbGdUeJDWgQ=; b=f+C4UBg979PiILTUwSwraxnibS
	MPG4xioyv5nxQ0Wi4SsLmI1sJQuGKlmYSwq2cI4vVQlvpvmz2s1jaicti+EpoFBVviSuZcBgoi+ud
	WJD/0Owcy+/3/LHTDiZNQb+wiNfbhatB/q+kXV6wr5BtOlntRy3NI0msjgTdDTPxPYzI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnmOa-0003nQ-RT;
	Sun, 26 Jul 2026 00:07:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnmOI-0003mr-Ny
 for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 00:06:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Lu16XDT3jywmKY6tXFORx8eXtfBdj4uJpS7yrVUb5oc=; b=BrzzZ2kNF5YhPS1tt6ULEXdTTj
 +maQUwMK0+sZPMVt/1kDVEpHWGvtDZQK+5waNTojux3K2K/N1Xw7jHciJMm3F1Tycr/8PDnb124HU
 SbQVeeys4KhS472OlFJmY1Jmt71vs+Jm8bB0pC7KvMlKQf//bMhNa4KfgPrjCSX3S/0U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Lu16XDT3jywmKY6tXFORx8eXtfBdj4uJpS7yrVUb5oc=; b=f
 XMLk7mTBY0FDGwcOHw1fOocQt0TjCN9+D2HU8n3IHLSCQvmr52yj5a+QYnMYjtvjUR9kjY9N4QBY0
 FZTmpp0RkWH1jFvipPD7d07AUAsPWCo8U8PJ87iRBqXsy3FO6zHY20ZEw/PHjptmS2DrOy4qU+iMD
 bYgwmWH0d15ku3jA=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnmOL-0005yl-2B for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 00:06:51 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49550ec592cso16578525e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 17:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785024403; x=1785629203; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Lu16XDT3jywmKY6tXFORx8eXtfBdj4uJpS7yrVUb5oc=;
 b=DGoJiacZabq1n7Of45pU0ToVIWkzZotwdwZ167G3LUa713Lb/RSFxD7P3B8wbfbtwh
 2hW+AA1qVATrON99JhoJvjDic7cn6DLqouB8U4egHiuCSgPruKRjfXVpDq6JqUXlr0TM
 aU5Q5MkC5ac59JnPNcToOQEZwqjHE0kQT9b49K/2MRhyJjR/GEps02s1PmCTaKSUL1zW
 VYJabEj8BpwDEuryU5GAdw+4Rdleo7l4poOHnccYLg8WC8KOI0LO14MJwS9/3ruXoh0t
 ZKa9uZx3ODMloSNyapJ2BH2qPzXKzywsMq+0SQR0OToD0aIX4bbMb0z9bx8QfGzigdci
 zv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785024403; x=1785629203;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Lu16XDT3jywmKY6tXFORx8eXtfBdj4uJpS7yrVUb5oc=;
 b=Ocm9cgtlXLqUScEvVxtB5EcFVbQaDLcAOrn95Pe8rD2evAvWTj1p5g29wgUyJoj+z8
 DDsRcnPWRy35hXf5pAveGQlYOBzZgIU44LNT/lisLFaN0HC2pIDeRLzbLrtNlMWCU40x
 X/0HWqm7gtPs6HS09OlBbDgCwzFqsLoSle/LoEaZem5UjrU/b0Lf72HX6boSp7UrnsiX
 v74IOFFMa4IAhwfpuCjEdSdqzuZ2hAj6TXcwPBrHi7Y2RRC9g05MkHRLoH9UV2ykIVY8
 jpT7mWcH/LftqAXmbh0Xdz9sNUV07rchiaQeUu6zgYd58P0xyGn/1ClHotmBdLw1+63G
 LsCw==
X-Gm-Message-State: AOJu0Yw9eyF9y008vU0Hwsm9Nw8928cdpGEI7gEspoKTBDllXwCxcW70
 RYtla0XVX7pl8vuU8AG/toRoOZRzB72cS+F5lbxvZNYFYGGgAYlU3/zVf9GF2fW+55XbEZdM2ld
 QuWbhFb9oSdQBiFGpoaUU6d1cxxyONNLkZ9TRxHRPPA3cCRwVEi1HxF6iAHOZFv6Ba7vqSoLjxR
 ZaB0PWhw==
X-Gm-Gg: AR+sD11rQ6XWXAyNjW9vTYKV+e6X7XLMuO+ZTqoGhVRQ2GZHeyoOfiIqUX0Ew4CdABF
 tEZ+vvRhuJ1LvNUk6QqmIoh6/BJ9oGWyKit8UYf+ldbzbaDS66pDeRjFfelTTYkaqF7M9wb0uBH
 nEcU0JRXW7gM46yQHOaDZyVSRNbIiuv4tSTKGAI81Cl6Dxru+5Kazkiyf9BdVpwrt/+pv4HhgM4
 dR5HlPF5C+WaWJB5byS63mA3c9qH3DjN6Sz/9GSRwAjwEJFxC2dgL27pAJMrr8qJiwCbE/kV8pL
 BDZHbyUpdDVKOtOJhC0bpSYHRPQzEEdo422B6yGIOnHz8+HtDHUiwf2Cz835l+hk4nLRWg+OgjO
 pal8CtmSWW/afqGoauMM/trOK3sOUcQGFFcXi2AcklVie93Fo02E1XsJaLXRuME5yoIyXCZz149
 HijuiR6NQLMocKN5MnOQjf5HNkEr+JGZwrU3M/M2ojPCQ1vYQ+WtgB1YblDR1YxjpmQ2Z2BRtfl
 80F86Gye6aMKN5lmSTkwfnDq37UmtzZtlP1xEb18KcsjWDQjyeX57c0zOlYN3LnB2ig
X-Received: by 2002:a05:600c:4704:b0:495:6022:5a23 with SMTP id
 5b1f17b1804b1-496b5c92ebfmr40888715e9.19.1785024402684; 
 Sat, 25 Jul 2026 17:06:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4f30126sm98978285e9.13.2026.07.25.17.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 17:06:41 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 26 Jul 2026 00:06:29 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0
X-Gerrit-Change-Number: 1728
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1728?usp=email>
X-Gerrit-Commit: 65f7bf08caa1a473bf6ca5c0f1464485908e7231
In-Reply-To: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
References: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTQyMjY4MDAwLklhZjFmMzQ3NWU0ZjI3YTkyMGMwMjhjZDczYjFhMjQ5Nzk1MzU4M2QwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b402b1690d5790b1b3dfc136b5a401107bec5da0-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnmOL-0005yl-2B
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Do not differentiate
 TLS server and client context initialisation
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
Content-Type: multipart/mixed; boundary="===============8289575204994267106=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8289575204994267106==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sTrZw3N5YI8="; charset=UTF-8

--sTrZw3N5YI8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello flichtenheld, 

I=
'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1728?usp=3Demail

to look at the new patch set (#5)=
=2E

The change is no longer submittable: checks~ChecksSubmitRule is unsati=
sfied now=2E


Change subject: Do not differentiate TLS server and client c=
ontext initialisation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Do not differentiate TLS server and client context initialisatio=
n

OpenSSL has the quite curious way of allowing to create contexts
that al=
low only server or only client=2E This creates extra
complications when we =
want to use both server and client SSL
objects and does not seem to have an=
y advantages=2E

We later explicitly tell OpenSSL to initialise the SSL obj=
ects
to be a server or client object in key_state_ssl_init via
SSL_set_acce=
pt_state or SSL_set_connect_state=2E If this is
mismatched we end up gettin=
g an error from OpenSSL ("called a
function you should not call") that ends=
 up calling a function
that is not defined in that TLS_method=2E

Looking i=
nto the OpenSSL source (IMPLEMENT_tls_meth_func) the main
difference betwee=
n the methods is whether they have a proper
accept/connect or have the ssl_=
undefined_function that triggers the
"called a function you should not call=
"=2E

Our mbed TLS code basically does give the SSL context any personality=

of client or server until we are in the same area in which the OpenSSL
cod=
e calls SSL_set_accept_state/SSL_set_connect_sate=2E

This also modifies th=
e mbedTLS to use the decision to pick client
and server in that path as the=
 OpenSSL code path=2E

Change-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0=

Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/ssl=2Ec=

M src/openvpn/ssl_backend=2Eh
M src/openvpn/ssl_mbedtls=2Ec
M src/openvpn/=
ssl_mbedtls=2Eh
M src/openvpn/ssl_openssl=2Ec
M tests/unit_tests/openvpn/te=
st_ssl=2Ec
6 files changed, 17 insertions(+), 65 deletions(-)


  git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/28/1728/5

diff --g=
it a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 9f0052e=2E=2E22b3f48 1=
00644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -525,18 +525,1=
1 @@
     struct tls_root_ctx *new_ctx;
     ALLOC_OBJ_CLEAR(new_ctx, struc=
t tls_root_ctx);
 
-    if (options->tls_server)
-    {
-        tls_ctx_se=
rver_new(new_ctx);
+    tls_ctx_new(new_ctx);
 
-        if (options->dh_fi=
le)
-        {
-            tls_ctx_load_dh_params(new_ctx, options->dh_fil=
e, options->dh_file_inline);
-        }
-    }
-    else /* if client */
+ =
   if (options->tls_server && options->dh_file)
     {
-        tls_ctx_cli=
ent_new(new_ctx);
+        tls_ctx_load_dh_params(new_ctx, options->dh_file=
, options->dh_file_inline);
     }
 
     /* Restrict allowed certificate c=
rypto algorithms */
diff --git a/src/openvpn/ssl_backend=2Eh b/src/openvpn/=
ssl_backend=2Eh
index 816fb9c=2E=2Ea6d57f2 100644
--- a/src/openvpn/ssl_bac=
kend=2Eh
+++ b/src/openvpn/ssl_backend=2Eh
@@ -117,18 +117,11 @@
 int tls_v=
ersion_max(void);
 
 /**
- * Initialise a library-specific TLS context for =
a server=2E
+ * Initialise a library-specific TLS context=2E
  *
  * @param=
 ctx           TLS context to initialise
  */
-void tls_ctx_server_new(stru=
ct tls_root_ctx *ctx);
-
-/**
- * Initialises a library-specific TLS contex=
t for a client=2E
- *
- * @param ctx           TLS context to initialise
- =
*/
-void tls_ctx_client_new(struct tls_root_ctx *ctx);
+void tls_ctx_new(st=
ruct tls_root_ctx *ctx);
 
 /**
  * Frees the library-specific TLSv1 contex=
t
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
in=
dex 07caf08=2E=2E6d7ac04 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src=
/openvpn/ssl_mbedtls=2Ec
@@ -88,7 +88,7 @@
 }
 
 void
-tls_ctx_server_new(s=
truct tls_root_ctx *ctx)
+tls_ctx_new(struct tls_root_ctx *ctx)
 {
     ASS=
ERT(NULL !=3D ctx);
     CLEAR(*ctx);
@@ -99,24 +99,9 @@
 
     ALLOC_OBJ_C=
LEAR(ctx->ca_chain, mbedtls_x509_crt);
 
-    ctx->endpoint =3D MBEDTLS_SSL=
_IS_SERVER;
     ctx->initialised =3D true;
 }
 
-void
-tls_ctx_client_new(=
struct tls_root_ctx *ctx)
-{
-    ASSERT(NULL !=3D ctx);
-    CLEAR(*ctx);
=
-
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    ALLOC_OBJ_CLEAR(ctx->dhm_ct=
x, mbedtls_dhm_context);
-#endif
-    ALLOC_OBJ_CLEAR(ctx->ca_chain, mbedtl=
s_x509_crt);
-
-    ctx->endpoint =3D MBEDTLS_SSL_IS_CLIENT;
-    ctx->init=
ialised =3D true;
-}
 
 void
 tls_ctx_free(struct tls_root_ctx *ctx)
@@ -11=
41,7 +1126,8 @@
     /* Initialise SSL config */
     ALLOC_OBJ_CLEAR(ks_ss=
l->ssl_config, mbedtls_ssl_config);
     mbedtls_ssl_config_init(ks_ssl->ss=
l_config);
-    mbedtls_ssl_config_defaults(ks_ssl->ssl_config, ssl_ctx->en=
dpoint, MBEDTLS_SSL_TRANSPORT_STREAM,
+    int endpoint =3D is_server ? MBE=
DTLS_SSL_IS_SERVER : MBEDTLS_SSL_IS_CLIENT;
+    mbedtls_ssl_config_default=
s(ks_ssl->ssl_config, endpoint, MBEDTLS_SSL_TRANSPORT_STREAM,
             =
                    MBEDTLS_SSL_PRESET_DEFAULT);
 #ifdef MBEDTLS_DEBUG_C
  =
   /* We only want to have mbed TLS generate debug level logging when we wo=
uld
@@ -1530,7 +1516,7 @@
     struct tls_root_ctx tls_ctx;
     const int =
*ciphers =3D mbedtls_ssl_list_ciphersuites();
 
-    tls_ctx_server_new(&tl=
s_ctx);
+    tls_ctx_new(&tls_ctx);
     tls_ctx_set_cert_profile(&tls_ctx,=
 tls_cert_profile);
     tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
 =

diff --git a/src/openvpn/ssl_mbedtls=2Eh b/src/openvpn/ssl_mbedtls=2Eh
ind=
ex 6b678b2=2E=2E32d4f60 100644
--- a/src/openvpn/ssl_mbedtls=2Eh
+++ b/src/=
openvpn/ssl_mbedtls=2Eh
@@ -114,8 +114,6 @@
 {
     bool initialised; /**< =
True if the context has been initialised */
 
-    int endpoint;     /**< W=
hether or not this is a server or a client */
-
 #if MBEDTLS_VERSION_NUMBER=
 < 0x04000000
     mbedtls_dhm_context *dhm_ctx;          /**< Diffie-Helma=
nn-Merkle context */
 #endif
diff --git a/src/openvpn/ssl_openssl=2Ec b/src=
/openvpn/ssl_openssl=2Ec
index ef99b22=2E=2Ec5de165 100644
--- a/src/openvp=
n/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -100,37 +100,19 @@
 =
}
 
 void
-tls_ctx_server_new(struct tls_root_ctx *ctx)
+tls_ctx_new(struct=
 tls_root_ctx *ctx)
 {
     ASSERT(NULL !=3D ctx);
 
-    ctx->ctx =3D SSL_=
CTX_new_ex(tls_libctx, NULL, SSLv23_server_method());
+    ctx->ctx =3D SSL=
_CTX_new_ex(tls_libctx, NULL, TLS_method());
 
     if (ctx->ctx =3D=3D NUL=
L)
     {
-        crypto_msg(M_FATAL, "SSL_CTX_new SSLv23_server_method");=

+        crypto_msg(M_FATAL, "SSL_CTX_new TLS_method");
     }
     if (ER=
R_peek_error() !=3D 0)
     {
-        crypto_msg(M_WARN, "Warning: TLS ser=
ver context initialisation "
-                           "has warnings=2E")=
;
-    }
-}
-
-void
-tls_ctx_client_new(struct tls_root_ctx *ctx)
-{
-    A=
SSERT(NULL !=3D ctx);
-
-    ctx->ctx =3D SSL_CTX_new_ex(tls_libctx, NULL, =
SSLv23_client_method());
-
-    if (ctx->ctx =3D=3D NULL)
-    {
-        c=
rypto_msg(M_FATAL, "SSL_CTX_new SSLv23_client_method");
-    }
-    if (ERR=
_peek_error() !=3D 0)
-    {
-        crypto_msg(M_WARN, "Warning: TLS clie=
nt context initialisation "
+        crypto_msg(M_WARN, "Warning: TLS conte=
xt initialisation "
                            "has warnings=2E");
     }
=
 }
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/op=
envpn/test_ssl=2Ec
index d473d67=2E=2E54d52a0 100644
--- a/tests/unit_tests=
/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -175,7=
 +175,7 @@
     struct gc_arena gc =3D gc_new();
 
     struct tls_root_ctx=
 ctx =3D { 0 };
-    tls_ctx_client_new(&ctx);
+    tls_ctx_new(&ctx);
    =
 tls_ctx_load_cert_file(&ctx, unittest_cert, true);
 
     openvpn_x509_cer=
t_t *cert =3D NULL;
@@ -208,13 +208,13 @@
     /* test loading of inlined c=
ert and key=2E
      * loading the key also checks that it matches the load=
ed certificate
      */
-    tls_ctx_client_new(&ctx);
+    tls_ctx_new(&ct=
x);
     tls_ctx_load_cert_file(&ctx, unittest_cert, true);
     assert_int=
_equal(tls_ctx_load_priv_file(&ctx, unittest_key, true), 0);
     tls_ctx_f=
ree(&ctx);
 
     /* test loading of cert and key from file */
-    tls_ctx=
_client_new(&ctx);
+    tls_ctx_new(&ctx);
     tls_ctx_load_cert_file(&ctx=
, global_state=2Ecertfile, false);
     assert_int_equal(tls_ctx_load_priv_=
file(&ctx, global_state=2Ekeyfile, false), 0);
     tls_ctx_free(&ctx);
@@ =
-252,7 +252,7 @@
     string_mod(BSTR(&keyuri), CC_ANY, CC_BACKSLASH, '/');=

 #endif /* _WIN32 */
 
-    tls_ctx_client_new(&ctx);
+    tls_ctx_new(&ct=
x);
     tls_ctx_load_cert_file(&ctx, BSTR(&certuri), false);
     assert_i=
nt_equal(tls_ctx_load_priv_file(&ctx, BSTR(&keyuri), false), 0);
     tls_c=
tx_free(&ctx);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1728?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
patchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia=
f1f3475e4f27a920c028cd73b1a2497953583d0
Gerrit-Change-Number: 1728
Gerrit-P=
atchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-open=
vpn@rfc2549=2Eorg>

--sTrZw3N5YI8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #5</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1728?usp=3Demail">View Change</a></p><p>The change is no=
 longer submittable: checks~ChecksSubmitRule is unsatisfied now=2E</p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Do not differentiate TLS server and client context initialisation<=
br><br>OpenSSL has the quite curious way of allowing to create contexts<br>=
that allow only server or only client=2E This creates extra<br>complication=
s when we want to use both server and client SSL<br>objects and does not se=
em to have any advantages=2E<br><br>We later explicitly tell OpenSSL to ini=
tialise the SSL objects<br>to be a server or client object in key_state_ssl=
_init via<br>SSL_set_accept_state or SSL_set_connect_state=2E If this is<br=
>mismatched we end up getting an error from OpenSSL (&quot;called a<br>func=
tion you should not call&quot;) that ends up calling a function<br>that is =
not defined in that TLS_method=2E<br><br>Looking into the OpenSSL source (I=
MPLEMENT_tls_meth_func) the main<br>difference between the methods is wheth=
er they have a proper<br>accept/connect or have the ssl_undefined_function =
that triggers the<br>&quot;called a function you should not call&quot;=2E<b=
r><br>Our mbed TLS code basically does give the SSL context any personality=
<br>of client or server until we are in the same area in which the OpenSSL<=
br>code calls SSL_set_accept_state/SSL_set_connect_sate=2E<br><br>This also=
 modifies the mbedTLS to use the decision to pick client<br>and server in t=
hat path as the OpenSSL code path=2E<br><br>Change-Id: Iaf1f3475e4f27a920c0=
28cd73b1a2497953583d0<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg=
&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_backend=2Eh<br>M =
src/openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_mbedtls=2Eh<br>M src/openv=
pn/ssl_openssl=2Ec<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>6 files ch=
anged, 17 insertions(+), 65 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/28/1728/5</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>ind=
ex 9f0052e=2E=2E22b3f48 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</s=
pan><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -525,18 +525,11 =
@@</span><br><span>     struct tls_root_ctx *new_ctx;</span><br><span>     =
ALLOC_OBJ_CLEAR(new_ctx, struct tls_root_ctx);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;tls_server)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        tls_ctx_server_new(new_ctx);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_ctx_new(new_c=
tx);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (options-&gt;dh_file)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            tls_ctx_load_dh_params(new_ctx, options-&gt;dh_file, options-&g=
t;dh_file_inline);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    else /* if client */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;tls_se=
rver &amp;&amp; options-&gt;dh_file)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        tls_ctx_client_new(new_ctx);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_ctx_load=
_dh_params(new_ctx, options-&gt;dh_file, options-&gt;dh_file_inline);</span=
><br><span>     }</span><br><span> </span><br><span>     /* Restrict allowe=
d certificate crypto algorithms */</span><br><span>diff --git a/src/openvpn=
/ssl_backend=2Eh b/src/openvpn/ssl_backend=2Eh</span><br><span>index 816fb9=
c=2E=2Ea6d57f2 100644</span><br><span>--- a/src/openvpn/ssl_backend=2Eh</sp=
an><br><span>+++ b/src/openvpn/ssl_backend=2Eh</span><br><span>@@ -117,18 +=
117,11 @@</span><br><span> int tls_version_max(void);</span><br><span> </sp=
an><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * I=
nitialise a library-specific TLS context for a server=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Initialise a library-specific TLS c=
ontext=2E</span><br><span>  *</span><br><span>  * @param ctx           TLS =
context to initialise</span><br><span>  */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-void tls_ctx_server_new(struct tls_root_ctx *ctx);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * Initialises a library-specific TLS context for a client=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param ctx           TLS context to init=
ialise</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-void tls_ctx_client_new(struct tl=
s_root_ctx *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id tls_ctx_new(struct tls_root_ctx *ctx);</span><br><span> </span><br><span=
> /**</span><br><span>  * Frees the library-specific TLSv1 context</span><b=
r><span>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=
=2Ec</span><br><span>index 07caf08=2E=2E6d7ac04 100644</span><br><span>--- =
a/src/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=
=2Ec</span><br><span>@@ -88,7 +88,7 @@</span><br><span> }</span><br><span> =
</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-tls_ctx_server_new(struct tls_root_ctx *ctx)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+tls_ctx_new(struct tls_root_ctx *ctx)</span><br><=
span> {</span><br><span>     ASSERT(NULL !=3D ctx);</span><br><span>     CL=
EAR(*ctx);</span><br><span>@@ -99,24 +99,9 @@</span><br><span> </span><br><=
span>     ALLOC_OBJ_CLEAR(ctx-&gt;ca_chain, mbedtls_x509_crt);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt;endp=
oint =3D MBEDTLS_SSL_IS_SERVER;</span><br><span>     ctx-&gt;initialised =
=3D true;</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-tls_ctx_client_new(struct tls_root_ctx *ctx)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    ASSERT(NULL !=3D ctx);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    CLEAR(*ctx);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDT=
LS_VERSION_NUMBER &lt; 0x04000000</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    ALLOC_OBJ_CLEAR(ctx-&gt;dhm_ctx, mbedtls_dhm_context);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    ALLOC_OBJ_CLEAR(ctx-&gt;ca_chain, mbe=
dtls_x509_crt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt;endpoint =3D MB=
EDTLS_SSL_IS_CLIENT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   ctx-&gt;initialised =3D true;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span> </span><br><span> void</span><br><span> tls_c=
tx_free(struct tls_root_ctx *ctx)</span><br><span>@@ -1141,7 +1126,8 @@</sp=
an><br><span>     /* Initialise SSL config */</span><br><span>     ALLOC_OB=
J_CLEAR(ks_ssl-&gt;ssl_config, mbedtls_ssl_config);</span><br><span>     mb=
edtls_ssl_config_init(ks_ssl-&gt;ssl_config);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    mbedtls_ssl_config_defaults(ks_ssl-&gt;ssl_conf=
ig, ssl_ctx-&gt;endpoint, MBEDTLS_SSL_TRANSPORT_STREAM,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int endpoint =3D is_server ? MBEDTL=
S_SSL_IS_SERVER : MBEDTLS_SSL_IS_CLIENT;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    mbedtls_ssl_config_defaults(ks_ssl-&gt;ssl_config,=
 endpoint, MBEDTLS_SSL_TRANSPORT_STREAM,</span><br><span>                  =
               MBEDTLS_SSL_PRESET_DEFAULT);</span><br><span> #ifdef MBEDTLS=
_DEBUG_C</span><br><span>     /* We only want to have mbed TLS generate deb=
ug level logging when we would</span><br><span>@@ -1530,7 +1516,7 @@</span>=
<br><span>     struct tls_root_ctx tls_ctx;</span><br><span>     const int =
*ciphers =3D mbedtls_ssl_list_ciphersuites();</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    tls_ctx_server_new(&amp;tls_c=
tx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_ctx_new=
(&amp;tls_ctx);</span><br><span>     tls_ctx_set_cert_profile(&amp;tls_ctx,=
 tls_cert_profile);</span><br><span>     tls_ctx_restrict_ciphers(&amp;tls_=
ctx, cipher_list);</span><br><span> </span><br><span>diff --git a/src/openv=
pn/ssl_mbedtls=2Eh b/src/openvpn/ssl_mbedtls=2Eh</span><br><span>index 6b67=
8b2=2E=2E32d4f60 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Eh</=
span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Eh</span><br><span>@@ -114,8 =
+114,6 @@</span><br><span> {</span><br><span>     bool initialised; /**&lt;=
 True if the context has been initialised */</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    int endpoint;     /**&lt; Whet=
her or not this is a server or a client */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span> #if MBEDTLS_VERSION_NUMBER &lt; 0x04=
000000</span><br><span>     mbedtls_dhm_context *dhm_ctx;          /**&lt; =
Diffie-Helmann-Merkle context */</span><br><span> #endif</span><br><span>di=
ff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span>=
<br><span>index ef99b22=2E=2Ec5de165 100644</span><br><span>--- a/src/openv=
pn/ssl_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span>=
<br><span>@@ -100,37 +100,19 @@</span><br><span> }</span><br><span> </span>=
<br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_ct=
x_server_new(struct tls_root_ctx *ctx)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+tls_ctx_new(struct tls_root_ctx *ctx)</span><br><span> {=
</span><br><span>     ASSERT(NULL !=3D ctx);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt;ctx =3D SSL_CTX_new_ex=
(tls_libctx, NULL, SSLv23_server_method());</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    ctx-&gt;ctx =3D SSL_CTX_new_ex(tls_libctx, NULL=
, TLS_method());</span><br><span> </span><br><span>     if (ctx-&gt;ctx =3D=
=3D NULL)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        crypto_msg(M_FATAL, &quot;SSL_CTX_new SSLv23_server_meth=
od&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
rypto_msg(M_FATAL, &quot;SSL_CTX_new TLS_method&quot;);</span><br><span>   =
  }</span><br><span>     if (ERR_peek_error() !=3D 0)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        crypto_msg(M=
_WARN, &quot;Warning: TLS server context initialisation &quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                           &quot;h=
as warnings=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-tls_ctx_client_new(struct tls_root_ctx *ctx)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    ASSERT(NULL !=3D ctx);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt=
;ctx =3D SSL_CTX_new_ex(tls_libctx, NULL, SSLv23_client_method());</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (ctx-&gt;ctx =3D=3D NULL)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        crypto_msg(M_FATAL, &quot;SSL_CTX_new SSLv23_cli=
ent_method&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ERR_peek_er=
ror() !=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        crypto_msg(M_WAR=
N, &quot;Warning: TLS client context initialisation &quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        crypto_msg(M_WARN, &quot;War=
ning: TLS context initialisation &quot;</span><br><span>                   =
         &quot;has warnings=2E&quot;);</span><br><span>     }</span><br><sp=
an> }</span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/=
tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>index d473d67=2E=2E54=
d52a0 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</s=
pan><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>@=
@ -175,7 +175,7 @@</span><br><span>     struct gc_arena gc =3D gc_new();</s=
pan><br><span> </span><br><span>     struct tls_root_ctx ctx =3D { 0 };</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_ctx_client_new(&a=
mp;ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_ctx=
_new(&amp;ctx);</span><br><span>     tls_ctx_load_cert_file(&amp;ctx, unitt=
est_cert, true);</span><br><span> </span><br><span>     openvpn_x509_cert_t=
 *cert =3D NULL;</span><br><span>@@ -208,13 +208,13 @@</span><br><span>    =
 /* test loading of inlined cert and key=2E</span><br><span>      * loading=
 the key also checks that it matches the loaded certificate</span><br><span=
>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_ctx_=
client_new(&amp;ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    tls_ctx_new(&amp;ctx);</span><br><span>     tls_ctx_load_cert_file(&a=
mp;ctx, unittest_cert, true);</span><br><span>     assert_int_equal(tls_ctx=
_load_priv_file(&amp;ctx, unittest_key, true), 0);</span><br><span>     tls=
_ctx_free(&amp;ctx);</span><br><span> </span><br><span>     /* test loading=
 of cert and key from file */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    tls_ctx_client_new(&amp;ctx);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    tls_ctx_new(&amp;ctx);</span><br><span>     tls_c=
tx_load_cert_file(&amp;ctx, global_state=2Ecertfile, false);</span><br><spa=
n>     assert_int_equal(tls_ctx_load_priv_file(&amp;ctx, global_state=2Ekey=
file, false), 0);</span><br><span>     tls_ctx_free(&amp;ctx);</span><br><s=
pan>@@ -252,7 +252,7 @@</span><br><span>     string_mod(BSTR(&amp;keyuri), =
CC_ANY, CC_BACKSLASH, &#39;/&#39;);</span><br><span> #endif /* _WIN32 */</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tl=
s_ctx_client_new(&amp;ctx);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    tls_ctx_new(&amp;ctx);</span><br><span>     tls_ctx_load_cert_f=
ile(&amp;ctx, BSTR(&amp;certuri), false);</span><br><span>     assert_int_e=
qual(tls_ctx_load_priv_file(&amp;ctx, BSTR(&amp;keyuri), false), 0);</span>=
<br><span>     tls_ctx_free(&amp;ctx);</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728?us=
p=3Demail">change 1728</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1728?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1728 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-O=
wner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></h=
tml>
--sTrZw3N5YI8=--


--===============8289575204994267106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8289575204994267106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8289575204994267106==--

