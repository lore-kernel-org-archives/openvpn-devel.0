Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2A5CDB46F
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=BJjdN/gI+aSpcEoObCwsgXB3NJPsxRoJZTpT/Y3SSa8=; b=IIIFn96oEMh47q
	DvcElmniAP05j+wwfA4HPFQwWu+BJOyhIEUods5nP+HGzwvLaEBHcENiclMr/W77sSjaMMGOtpX39
	Sbcw7Q2pwPLshN1N/Dv+RqoWGD6MRD5MQqXkfZtm2TtYXSGdGx/Zgjat0xFCGkRD9y7FXyPThwNkS
	O/o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbgci-0002vZ-Rm;
	Mon, 22 Jun 2026 15:31:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbgch-0002vO-71
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:31:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9fBGWttTXbjJBDmRyZU1yo4VUBdjezzmoqKEg7yGrFM=; b=VdkBXFXQcFt2sffjV056KtZcoU
 g05zCc/AnlxWppjWt2KaMoZq5Jwy1kIJbaL61Tltt0sJfqBlfJoYDzh2YSCQAkF3gLfjNSq0xEPZ6
 i9GIoovKERQNkHmpFveBSJEhVnKgY4Fh4JNZr1zi+cnFK6TzKr3hYShHlHqb8bkdigdA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9fBGWttTXbjJBDmRyZU1yo4VUBdjezzmoqKEg7yGrFM=; b=Q
 pmIQPPJc2HITLtEtz6Yx+14mWtBlicOJX80+HnYITI3Gj2bwFb2KoYHm8BhtTrVOgawOH9MXmVMbW
 zH/DkisB0LA9+HthVM2uVgAVbFP2SJeUCdhf/eiM70LqIEvdcaiLr3F/2alg/7f1G8bSZQhgZQ4cM
 zrV8rLCo+T9jemm0=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbgcf-0007nx-MK for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:31:43 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso65811635e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 08:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782142291; x=1782747091; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9fBGWttTXbjJBDmRyZU1yo4VUBdjezzmoqKEg7yGrFM=;
 b=HuZ9Fsbvx77YGwax+ArwOAc+mKGRa8G5TjQAWAWT7KvKB+lNY27SS28/cOFmxkMeFQ
 6QFlV6wXAPjiJGomwYAX5xfEx/s0VfWgMY831VgYpxtH8I1gXRSU2QaWwbkgRt0ZK0rG
 xe4vhTYDJ2J0wC2mC+5FW4NXyhvg3o3xpVR34JdcvRTVsRKFLNIVwIh+WBTctjvLcNXp
 n1RcmW2poyNTfZiraBQ2Pytbh3baMpy75BqQ9GwzzeYaWYnWjEb1FofP+tMofSFllj8J
 d65xeoWvMIg19C1ANwN8tWRAg6Wf5+G8vQhY6FmRPI1d40pYp9Iq/mRAP+O78OPHDNQs
 cq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782142291; x=1782747091;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9fBGWttTXbjJBDmRyZU1yo4VUBdjezzmoqKEg7yGrFM=;
 b=W6kw84iI7/+yFlwMiuP2mZLpqGAymOhnTdAwLmZYLBW57oDfFonAcdZTzLzTOMuSKb
 k4jiCQXCxvtAGgG6l8ebNH6iCXl/RNPgDiPmJwJfnE2YfJD4pp55S/ATGtWB8Zhns102
 N9nne3I3JusjPBOYvFj2l3kLE06bvt0r0ehgedyMy0GfvXfuzcGW1FZh8tzNCRKdA+h4
 rYaN1y5VQA9hVOe8JDfFk7l4wSsTRBm7sc2Z2+cr/XvSKEHrKjoMmbTbkihrvpR/2SNw
 wOJg9uoo0R+SgwOV+HvrJEF2YKvt7v6GzQ94j9VTWr09Iws5rtiL629s52QBnB8zLwAx
 P/vw==
X-Gm-Message-State: AOJu0YxOo1++j2aTsCc3pEzsltyORSB5GjeOBmxNYT44nSiX73euy9ri
 69RIzkJRJ9pQpgwDMK6Wb6WDcZurw0FKqBry4z75tHGTWr1oiBZ7KRJQA3yYNGplIyiJoKUcnMm
 RpuYAg3dHdhjfcbbwlvGAz6n8RsuYe8PjyIpOJPtRLLKeBJWN2+0ehp2vijZo9U+Oh5MdN8QNDf
 8DgZwr4Q==
X-Gm-Gg: AfdE7cn3qD/GpFdihWS9RWZsI88G7O+dQZE1VSb4gvP8dVxv13wswt5A06WamFxmz4G
 VaPHYTw93jvGYc/xVz66OTGts0h9jfBIrzQ7JKDzvBJ67KHC9Ipum6cj2aMEZ/eKQH2suJBZNtg
 nEqq4+mkbQPNAviRCcIyNByywc1LZrTfvvLAad+1kfgE4us+DOXyxfHybveZJ95qteXCa5TBOTM
 HA0s7MTYYRIm4sr+fl6AZaE2f6lVGrgHR47j0zZEwah4h1voWn8Jia44eSu9kuwWRM0KsOJLkJ+
 lLxgTtThU8+YfObc5twap3wsk5IBVTKYgKgpwINvyq849O9MJcBbVyfz0gPtHJPDjG9a8RBpHJW
 Om8+qx1R4/Wwz4L/Zp7KBk+hoxEDsTv/htw78S41g38Lf5NsLGv+E1ry6vSVnhqFWWx9XxswvEz
 1jAJ8cWimiSXyDOwuK7Zfv+jT+37bWIb/BOweC7xO21/3fno6YpUgCd74tnFU4O+VYXh4tS3JEG
 pV6pF7xrN/xxR3uyNEmkh1QuTramEFNzFIimE6ZJGT9XZnAa3txN8fMsr4G2cKMxf/B2uZ63Ju8
 qDw=
X-Received: by 2002:a05:600c:5493:b0:490:e190:38f3 with SMTP id
 5b1f17b1804b1-4924256fe84mr202611815e9.21.1782142289259; 
 Mon, 22 Jun 2026 08:31:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd15535sm335449015e9.3.2026.06.22.08.31.28
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:31:28 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 15:31:28 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0
X-Gerrit-Change-Number: 1728
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1728?usp=email>
X-Gerrit-Commit: 1eec88cff05fc7eb8135943739c1ab670014a490
References: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTQyMjY4MDAwLklhZjFmMzQ3NWU0ZjI3YTkyMGMwMjhjZDczYjFhMjQ5Nzk1MzU4M2QwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a4bd1c0e17c010808768bc75a2bb642522d9bc6b-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbgcf-0007nx-MK
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7826471729308611225=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7826471729308611225==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Rad5m9wkrD4="; charset=UTF-8

--Rad5m9wkrD4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1728?usp=3Demail )


Change subject: Do not differentiat=
e TLS server and client context initialisation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Do not differentiate TLS server and clie=
nt context initialisation

OpenSSL has the quite curious way of allowing to=
 create contexts
that allow only server or only client=2E This creates extr=
a
complications when we want to use both server and client SSL
objects and =
does not seem to have any advantages=2E

We later explicitly tell initialis=
e the SSL objects to be a server or
client object in key_state_ssl_init via=
 SSL_set_accept_state or
SSL_set_connect_state=2E If this is mismatched we =
end up getting an
error from OpenSSL ("called a function you should not cal=
l") that
that ends up calling a function that is not defined in that
TLS_me=
thod=2E

Looking into the OpenSSL source (IMPLEMENT_tls_meth_func) the main=

difference between the methods is whether they have a proper
accept/connec=
t or have the ssl_undefined_function that triggers the
"called a function y=
ou should not call"=2E

Our mBed TLS code basically does give the SSL conte=
t any personlity
of client or server until we the same area where the OpenS=
SL code
calls the set accept/connect state call=2E

Change-Id: Iaf1f3475e4f=
27a920c028cd73b1a2497953583d0
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eo=
rg>
---
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_backend=2Eh
M src/openvpn/s=
sl_mbedtls=2Ec
M src/openvpn/ssl_mbedtls=2Eh
M src/openvpn/ssl_openssl=2Ec
=
M tests/unit_tests/openvpn/test_ssl=2Ec
6 files changed, 17 insertions(+), =
65 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/28/1728/1

diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2E=
c
index 6d58a3d=2E=2E76f1788 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/ope=
nvpn/ssl=2Ec
@@ -525,18 +525,11 @@
     struct tls_root_ctx *new_ctx;
     =
ALLOC_OBJ_CLEAR(new_ctx, struct tls_root_ctx);
 
-    if (options->tls_serv=
er)
-    {
-        tls_ctx_server_new(new_ctx);
+    tls_ctx_new(new_ctx);=

 
-        if (options->dh_file)
-        {
-            tls_ctx_load_dh_p=
arams(new_ctx, options->dh_file, options->dh_file_inline);
-        }
-    =
}
-    else /* if client */
+    if (options->tls_server && options->dh_fil=
e)
     {
-        tls_ctx_client_new(new_ctx);
+        tls_ctx_load_dh_pa=
rams(new_ctx, options->dh_file, options->dh_file_inline);
     }
 
     /* =
Restrict allowed certificate crypto algorithms */
diff --git a/src/openvpn/=
ssl_backend=2Eh b/src/openvpn/ssl_backend=2Eh
index 816fb9c=2E=2Ea6d57f2 10=
0644
--- a/src/openvpn/ssl_backend=2Eh
+++ b/src/openvpn/ssl_backend=2Eh
@@=
 -117,18 +117,11 @@
 int tls_version_max(void);
 
 /**
- * Initialise a lib=
rary-specific TLS context for a server=2E
+ * Initialise a library-specific=
 TLS context=2E
  *
  * @param ctx           TLS context to initialise
  */=

-void tls_ctx_server_new(struct tls_root_ctx *ctx);
-
-/**
- * Initialises=
 a library-specific TLS context for a client=2E
- *
- * @param ctx         =
  TLS context to initialise
- */
-void tls_ctx_client_new(struct tls_root_c=
tx *ctx);
+void tls_ctx_new(struct tls_root_ctx *ctx);
 
 /**
  * Frees the=
 library-specific TLSv1 context
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/=
src/openvpn/ssl_mbedtls=2Ec
index 8a0f7d2=2E=2E2dba50a 100644
--- a/src/ope=
nvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -88,7 +88,7 @@
 }=

 
 void
-tls_ctx_server_new(struct tls_root_ctx *ctx)
+tls_ctx_new(struct =
tls_root_ctx *ctx)
 {
     ASSERT(NULL !=3D ctx);
     CLEAR(*ctx);
@@ -99,=
24 +99,9 @@
 
     ALLOC_OBJ_CLEAR(ctx->ca_chain, mbedtls_x509_crt);
 
-   =
 ctx->endpoint =3D MBEDTLS_SSL_IS_SERVER;
     ctx->initialised =3D true;
 =
}
 
-void
-tls_ctx_client_new(struct tls_root_ctx *ctx)
-{
-    ASSERT(NULL=
 !=3D ctx);
-    CLEAR(*ctx);
-
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
- =
   ALLOC_OBJ_CLEAR(ctx->dhm_ctx, mbedtls_dhm_context);
-#endif
-    ALLOC_O=
BJ_CLEAR(ctx->ca_chain, mbedtls_x509_crt);
-
-    ctx->endpoint =3D MBEDTLS=
_SSL_IS_CLIENT;
-    ctx->initialised =3D true;
-}
 
 void
 tls_ctx_free(st=
ruct tls_root_ctx *ctx)
@@ -1140,7 +1125,8 @@
     /* Initialise SSL config=
 */
     ALLOC_OBJ_CLEAR(ks_ssl->ssl_config, mbedtls_ssl_config);
     mbed=
tls_ssl_config_init(ks_ssl->ssl_config);
-    mbedtls_ssl_config_defaults(k=
s_ssl->ssl_config, ssl_ctx->endpoint, MBEDTLS_SSL_TRANSPORT_STREAM,
+    in=
t endpoint =3D is_server ? MBEDTLS_SSL_IS_SERVER : MBEDTLS_SSL_IS_CLIENT;
+=
    mbedtls_ssl_config_defaults(ks_ssl->ssl_config, endpoint, MBEDTLS_SSL_T=
RANSPORT_STREAM,
                                 MBEDTLS_SSL_PRESET_DEFAUL=
T);
 #ifdef MBEDTLS_DEBUG_C
     /* We only want to have mbed TLS generate =
debug level logging when we would
@@ -1529,7 +1515,7 @@
     struct tls_roo=
t_ctx tls_ctx;
     const int *ciphers =3D mbedtls_ssl_list_ciphersuites();=

 
-    tls_ctx_server_new(&tls_ctx);
+    tls_ctx_new(&tls_ctx);
     tls_=
ctx_set_cert_profile(&tls_ctx, tls_cert_profile);
     tls_ctx_restrict_cip=
hers(&tls_ctx, cipher_list);
 
diff --git a/src/openvpn/ssl_mbedtls=2Eh b/s=
rc/openvpn/ssl_mbedtls=2Eh
index 6b678b2=2E=2E32d4f60 100644
--- a/src/open=
vpn/ssl_mbedtls=2Eh
+++ b/src/openvpn/ssl_mbedtls=2Eh
@@ -114,8 +114,6 @@
 =
{
     bool initialised; /**< True if the context has been initialised */
 =

-    int endpoint;     /**< Whether or not this is a server or a client */=

-
 #if MBEDTLS_VERSION_NUMBER < 0x04000000
     mbedtls_dhm_context *dhm_c=
tx;          /**< Diffie-Helmann-Merkle context */
 #endif
diff --git a/src=
/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index ef99b22=2E=2Ec=
5de165 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_opens=
sl=2Ec
@@ -100,37 +100,19 @@
 }
 
 void
-tls_ctx_server_new(struct tls_root=
_ctx *ctx)
+tls_ctx_new(struct tls_root_ctx *ctx)
 {
     ASSERT(NULL !=3D =
ctx);
 
-    ctx->ctx =3D SSL_CTX_new_ex(tls_libctx, NULL, SSLv23_server_me=
thod());
+    ctx->ctx =3D SSL_CTX_new_ex(tls_libctx, NULL, TLS_method());
=
 
     if (ctx->ctx =3D=3D NULL)
     {
-        crypto_msg(M_FATAL, "SSL_C=
TX_new SSLv23_server_method");
+        crypto_msg(M_FATAL, "SSL_CTX_new TL=
S_method");
     }
     if (ERR_peek_error() !=3D 0)
     {
-        crypto=
_msg(M_WARN, "Warning: TLS server context initialisation "
-               =
            "has warnings=2E");
-    }
-}
-
-void
-tls_ctx_client_new(struc=
t tls_root_ctx *ctx)
-{
-    ASSERT(NULL !=3D ctx);
-
-    ctx->ctx =3D SSL=
_CTX_new_ex(tls_libctx, NULL, SSLv23_client_method());
-
-    if (ctx->ctx =
=3D=3D NULL)
-    {
-        crypto_msg(M_FATAL, "SSL_CTX_new SSLv23_client=
_method");
-    }
-    if (ERR_peek_error() !=3D 0)
-    {
-        crypto_=
msg(M_WARN, "Warning: TLS client context initialisation "
+        crypto_m=
sg(M_WARN, "Warning: TLS context initialisation "
                         =
   "has warnings=2E");
     }
 }
diff --git a/tests/unit_tests/openvpn/test=
_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec
index 0e9cecf=2E=2Ed7d645f=
 100644
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/=
openvpn/test_ssl=2Ec
@@ -175,7 +175,7 @@
     struct gc_arena gc =3D gc_new=
();
 
     struct tls_root_ctx ctx =3D { 0 };
-    tls_ctx_client_new(&ctx)=
;
+    tls_ctx_new(&ctx);
     tls_ctx_load_cert_file(&ctx, unittest_cert, =
true);
 
     openvpn_x509_cert_t *cert =3D NULL;
@@ -208,13 +208,13 @@
   =
  /* test loading of inlined cert and key=2E
      * loading the key also c=
hecks that it matches the loaded certificate
      */
-    tls_ctx_client_n=
ew(&ctx);
+    tls_ctx_new(&ctx);
     tls_ctx_load_cert_file(&ctx, unittes=
t_cert, true);
     assert_int_equal(tls_ctx_load_priv_file(&ctx, unittest_=
key, true), 0);
     tls_ctx_free(&ctx);
 
     /* test loading of cert and=
 key from file */
-    tls_ctx_client_new(&ctx);
+    tls_ctx_new(&ctx);
  =
   tls_ctx_load_cert_file(&ctx, global_state=2Ecertfile, false);
     asser=
t_int_equal(tls_ctx_load_priv_file(&ctx, global_state=2Ekeyfile, false), 0)=
;
     tls_ctx_free(&ctx);
@@ -252,7 +252,7 @@
     string_mod(BSTR(&keyuri=
), CC_ANY, CC_BACKSLASH, '/');
 #endif /* _WIN32 */
 
-    tls_ctx_client_n=
ew(&ctx);
+    tls_ctx_new(&ctx);
     tls_ctx_load_cert_file(&ctx, BSTR(&c=
erturi), false);
     assert_int_equal(tls_ctx_load_priv_file(&ctx, BSTR(&k=
eyuri), false), 0);
     tls_ctx_free(&ctx);

-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1728?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0
Gerrit-=
Change-Number: 1728
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>

--Rad5m9wkrD4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1728?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Do not differentiate TLS server and client context initialisation<=
br><br>OpenSSL has the quite curious way of allowing to create contexts<br>=
that allow only server or only client=2E This creates extra<br>complication=
s when we want to use both server and client SSL<br>objects and does not se=
em to have any advantages=2E<br><br>We later explicitly tell initialise the=
 SSL objects to be a server or<br>client object in key_state_ssl_init via S=
SL_set_accept_state or<br>SSL_set_connect_state=2E If this is mismatched we=
 end up getting an<br>error from OpenSSL (&quot;called a function you shoul=
d not call&quot;) that<br>that ends up calling a function that is not defin=
ed in that<br>TLS_method=2E<br><br>Looking into the OpenSSL source (IMPLEME=
NT_tls_meth_func) the main<br>difference between the methods is whether the=
y have a proper<br>accept/connect or have the ssl_undefined_function that t=
riggers the<br>&quot;called a function you should not call&quot;=2E<br><br>=
Our mBed TLS code basically does give the SSL contet any personlity<br>of c=
lient or server until we the same area where the OpenSSL code<br>calls the =
set accept/connect state call=2E<br><br>Change-Id: Iaf1f3475e4f27a920c028cd=
73b1a2497953583d0<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;=
<br>---<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_backend=2Eh<br>M src/=
openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_mbedtls=2Eh<br>M src/openvpn/s=
sl_openssl=2Ec<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>6 files change=
d, 17 insertions(+), 65 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/28/1728/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 6=
d58a3d=2E=2E76f1788 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span>=
<br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -525,18 +525,11 @@</=
span><br><span>     struct tls_root_ctx *new_ctx;</span><br><span>     ALLO=
C_OBJ_CLEAR(new_ctx, struct tls_root_ctx);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;tls_server)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        tls_ctx_server_new(new_ctx);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_ctx_new(new_ctx);=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (options-&gt;dh_file)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        tls_ctx_load_dh_params(new_ctx, options-&gt;dh_file, options-&gt;dh=
_file_inline);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    else /* if client */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;tls_server=
 &amp;&amp; options-&gt;dh_file)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        tls_ctx_client_new(new_ctx);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_ctx_load_dh_=
params(new_ctx, options-&gt;dh_file, options-&gt;dh_file_inline);</span><br=
><span>     }</span><br><span> </span><br><span>     /* Restrict allowed ce=
rtificate crypto algorithms */</span><br><span>diff --git a/src/openvpn/ssl=
_backend=2Eh b/src/openvpn/ssl_backend=2Eh</span><br><span>index 816fb9c=2E=
=2Ea6d57f2 100644</span><br><span>--- a/src/openvpn/ssl_backend=2Eh</span><=
br><span>+++ b/src/openvpn/ssl_backend=2Eh</span><br><span>@@ -117,18 +117,=
11 @@</span><br><span> int tls_version_max(void);</span><br><span> </span><=
br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Initi=
alise a library-specific TLS context for a server=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Initialise a library-specific TLS cont=
ext=2E</span><br><span>  *</span><br><span>  * @param ctx           TLS con=
text to initialise</span><br><span>  */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-void tls_ctx_server_new(struct tls_root_ctx *ctx);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * Initialises a library-specific TLS context for a client=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * @param ctx           TLS context to initial=
ise</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void tls_ctx_client_new(struct tls_r=
oot_ctx *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void =
tls_ctx_new(struct tls_root_ctx *ctx);</span><br><span> </span><br><span> /=
**</span><br><span>  * Frees the library-specific TLSv1 context</span><br><=
span>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec=
</span><br><span>index 8a0f7d2=2E=2E2dba50a 100644</span><br><span>--- a/sr=
c/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec=
</span><br><span>@@ -88,7 +88,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls=
_ctx_server_new(struct tls_root_ctx *ctx)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+tls_ctx_new(struct tls_root_ctx *ctx)</span><br><span=
> {</span><br><span>     ASSERT(NULL !=3D ctx);</span><br><span>     CLEAR(=
*ctx);</span><br><span>@@ -99,24 +99,9 @@</span><br><span> </span><br><span=
>     ALLOC_OBJ_CLEAR(ctx-&gt;ca_chain, mbedtls_x509_crt);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt;endpoint=
 =3D MBEDTLS_SSL_IS_SERVER;</span><br><span>     ctx-&gt;initialised =3D tr=
ue;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-tls_ctx_client_new(struct tls_root_ctx *ctx)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    ASSERT(NULL !=3D ctx);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    CLEAR(*ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERS=
ION_NUMBER &lt; 0x04000000</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    ALLOC_OBJ_CLEAR(ctx-&gt;dhm_ctx, mbedtls_dhm_context);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    ALLOC_OBJ_CLEAR(ctx-&gt;ca_chain, mbedtls_x5=
09_crt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt;endpoint =3D MBEDTLS_S=
SL_IS_CLIENT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ctx-=
&gt;initialised =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span> </span><br><span> void</span><br><span> tls_ctx_free=
(struct tls_root_ctx *ctx)</span><br><span>@@ -1140,7 +1125,8 @@</span><br>=
<span>     /* Initialise SSL config */</span><br><span>     ALLOC_OBJ_CLEAR=
(ks_ssl-&gt;ssl_config, mbedtls_ssl_config);</span><br><span>     mbedtls_s=
sl_config_init(ks_ssl-&gt;ssl_config);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    mbedtls_ssl_config_defaults(ks_ssl-&gt;ssl_config, ssl=
_ctx-&gt;endpoint, MBEDTLS_SSL_TRANSPORT_STREAM,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int endpoint =3D is_server ? MBEDTLS_SSL_I=
S_SERVER : MBEDTLS_SSL_IS_CLIENT;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    mbedtls_ssl_config_defaults(ks_ssl-&gt;ssl_config, endpoi=
nt, MBEDTLS_SSL_TRANSPORT_STREAM,</span><br><span>                         =
        MBEDTLS_SSL_PRESET_DEFAULT);</span><br><span> #ifdef MBEDTLS_DEBUG_=
C</span><br><span>     /* We only want to have mbed TLS generate debug leve=
l logging when we would</span><br><span>@@ -1529,7 +1515,7 @@</span><br><sp=
an>     struct tls_root_ctx tls_ctx;</span><br><span>     const int *cipher=
s =3D mbedtls_ssl_list_ciphersuites();</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    tls_ctx_server_new(&amp;tls_ctx);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_ctx_new(&amp;t=
ls_ctx);</span><br><span>     tls_ctx_set_cert_profile(&amp;tls_ctx, tls_ce=
rt_profile);</span><br><span>     tls_ctx_restrict_ciphers(&amp;tls_ctx, ci=
pher_list);</span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_=
mbedtls=2Eh b/src/openvpn/ssl_mbedtls=2Eh</span><br><span>index 6b678b2=2E=
=2E32d4f60 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Eh</span><=
br><span>+++ b/src/openvpn/ssl_mbedtls=2Eh</span><br><span>@@ -114,8 +114,6=
 @@</span><br><span> {</span><br><span>     bool initialised; /**&lt; True =
if the context has been initialised */</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    int endpoint;     /**&lt; Whether or=
 not this is a server or a client */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span> #if MBEDTLS_VERSION_NUMBER &lt; 0x04000000=
</span><br><span>     mbedtls_dhm_context *dhm_ctx;          /**&lt; Diffie=
-Helmann-Merkle context */</span><br><span> #endif</span><br><span>diff --g=
it a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><s=
pan>index ef99b22=2E=2Ec5de165 100644</span><br><span>--- a/src/openvpn/ssl=
_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><s=
pan>@@ -100,37 +100,19 @@</span><br><span> }</span><br><span> </span><br><s=
pan> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_serv=
er_new(struct tls_root_ctx *ctx)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+tls_ctx_new(struct tls_root_ctx *ctx)</span><br><span> {</span=
><br><span>     ASSERT(NULL !=3D ctx);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt;ctx =3D SSL_CTX_new_ex(tls_l=
ibctx, NULL, SSLv23_server_method());</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ctx-&gt;ctx =3D SSL_CTX_new_ex(tls_libctx, NULL, TLS_=
method());</span><br><span> </span><br><span>     if (ctx-&gt;ctx =3D=3D NU=
LL)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        crypto_msg(M_FATAL, &quot;SSL_CTX_new SSLv23_server_method&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        crypto_=
msg(M_FATAL, &quot;SSL_CTX_new TLS_method&quot;);</span><br><span>     }</s=
pan><br><span>     if (ERR_peek_error() !=3D 0)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        crypto_msg(M_WARN,=
 &quot;Warning: TLS server context initialisation &quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                           &quot;has war=
nings=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_=
ctx_client_new(struct tls_root_ctx *ctx)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   ASSERT(NULL !=3D ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt;ctx =
=3D SSL_CTX_new_ex(tls_libctx, NULL, SSLv23_client_method());</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (ctx-&gt;ctx =3D=3D NULL)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        crypto_msg(M_FATAL, &quot;SSL_CTX_new SSLv23_client=
_method&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ERR_peek_error=
() !=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        crypto_msg(M_WARN, =
&quot;Warning: TLS client context initialisation &quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        crypto_msg(M_WARN, &quot;Warnin=
g: TLS context initialisation &quot;</span><br><span>                      =
      &quot;has warnings=2E&quot;);</span><br><span>     }</span><br><span>=
 }</span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tes=
ts/unit_tests/openvpn/test_ssl=2Ec</span><br><span>index 0e9cecf=2E=2Ed7d64=
5f 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</span=
><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>@@ -=
175,7 +175,7 @@</span><br><span>     struct gc_arena gc =3D gc_new();</span=
><br><span> </span><br><span>     struct tls_root_ctx ctx =3D { 0 };</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_ctx_client_new(&amp;=
ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_ctx_ne=
w(&amp;ctx);</span><br><span>     tls_ctx_load_cert_file(&amp;ctx, unittest=
_cert, true);</span><br><span> </span><br><span>     openvpn_x509_cert_t *c=
ert =3D NULL;</span><br><span>@@ -208,13 +208,13 @@</span><br><span>     /*=
 test loading of inlined cert and key=2E</span><br><span>      * loading th=
e key also checks that it matches the loaded certificate</span><br><span>  =
    */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_ctx_cli=
ent_new(&amp;ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   tls_ctx_new(&amp;ctx);</span><br><span>     tls_ctx_load_cert_file(&amp;=
ctx, unittest_cert, true);</span><br><span>     assert_int_equal(tls_ctx_lo=
ad_priv_file(&amp;ctx, unittest_key, true), 0);</span><br><span>     tls_ct=
x_free(&amp;ctx);</span><br><span> </span><br><span>     /* test loading of=
 cert and key from file */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    tls_ctx_client_new(&amp;ctx);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    tls_ctx_new(&amp;ctx);</span><br><span>     tls_ctx_=
load_cert_file(&amp;ctx, global_state=2Ecertfile, false);</span><br><span> =
    assert_int_equal(tls_ctx_load_priv_file(&amp;ctx, global_state=2Ekeyfil=
e, false), 0);</span><br><span>     tls_ctx_free(&amp;ctx);</span><br><span=
>@@ -252,7 +252,7 @@</span><br><span>     string_mod(BSTR(&amp;keyuri), CC_=
ANY, CC_BACKSLASH, &#39;/&#39;);</span><br><span> #endif /* _WIN32 */</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_c=
tx_client_new(&amp;ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    tls_ctx_new(&amp;ctx);</span><br><span>     tls_ctx_load_cert_file=
(&amp;ctx, BSTR(&amp;certuri), false);</span><br><span>     assert_int_equa=
l(tls_ctx_load_priv_file(&amp;ctx, BSTR(&amp;keyuri), false), 0);</span><br=
><span>     tls_ctx_free(&amp;ctx);</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728?usp=
=3Demail">change 1728</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1728?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1728 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--Rad5m9wkrD4=--


--===============7826471729308611225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7826471729308611225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7826471729308611225==--

