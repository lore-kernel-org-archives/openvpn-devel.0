Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23A0C2A09B
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WiSjE6nc7DvoP53j8uuDhO8gfAOyXQ8Xs8OLGcJy5DM=; b=Ql923d9dWNLTUe3y5yj/3b8X8U
	PpWCncR7BZYFpuPGEsri9eWBNvs7vnuds0thw9TNjet6KJ0vuPYCTyAoaAx37yiQrrPXHR+OCPWcg
	6AS+v7fATZNg0q6udd34Z1kCFg0wSlE9yn8sFxAhuZMtB4ZNArKM8nC4EBv7CCQeW+ss=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsMS2-0007UB-WE;
	Fri, 07 Aug 2026 15:25:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsMS1-0007Tz-Ov
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:25:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Qp0SubAWT8RgnK9/Et9fGWbUJ+nb3jeP0yS2i3vnGxA=; b=FwnWX4w67GioyDG41z5yGYiJZO
 NfBVvLOg4lTU8u6rhIvqMlwO+85oCF8WOZJjUVsw0HGV4fnNjGZy8kQS6oKdfZOhmgRLVi9TXDPG6
 SK//LFPMrJCS4Etp4RKCLsvkQIKD1Db5JBI9YdOmrqC3A6QNU//0ekRqECxMaaGqWle0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Qp0SubAWT8RgnK9/Et9fGWbUJ+nb3jeP0yS2i3vnGxA=; b=G
 itos4tgPDJ59c5odblntqdh2UOIdb0KJbyDtb1RH3WNMHPCnKLS2NLFOLdMUZhHQLstlyiVFJvZZ+
 uOI+SMj8I3YXWVyHWAyzeRKfDVUCEemU3Il24ncrQmBEv8hEeC6q3TB3QnObp6C2PFx/8CtgQV2PL
 dmDkOWJowcgd9EM8=;
Received: from mail-ed1-f42.google.com ([209.85.208.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsMS4-0002wW-59 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:25:38 +0000
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6a18840e2abso4079914a12.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 08:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786116330; x=1786721130; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Qp0SubAWT8RgnK9/Et9fGWbUJ+nb3jeP0yS2i3vnGxA=;
 b=Xjy8GFenl27vWa12oRxa0pi8LFW57tzXUx1zjMU9LLKClIGaMIyPHFGGt5cjTD96UF
 Lpm2Li5XINwIVRp8F8XIwg0B2YJCA7K5JbU6Sop8iVlHYEysQuEQL21dEzWaMDEjSX5h
 ZGhC8qUVaZsy4KtSvx0CsY8tkdGfwJnZvZ2DeYV3k8kWW2d46FvcdsukdKwy2PX1JQbn
 Ba8S+SLdCl57Fo28srjnZUq5mY4MBJAM0GnujS2gMNWFk+UkPpsXs//+sAZ5qIbUTq2x
 BJoSHR7QENpypsWH/WJrW2lzjP+I+J3C5ds6mBK5BAvKynDVQpTP7QzYW6560O2gS3qv
 bOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786116330; x=1786721130;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Qp0SubAWT8RgnK9/Et9fGWbUJ+nb3jeP0yS2i3vnGxA=;
 b=Z/wkWs3T9uA+40CM8eUDJTpR+2XbqZigq/D8hP8AqLnCPIZ+DjikRG9gwEvU9obtlE
 3MEFB2ykaAl1LaO8M95CtabT3DvFdH8wEhjPj86qisGU+KpczTrwmWIpP82zsuRAJ1+h
 cfPVwry19JIuUAvfLxpDxwWF7NeX+9gZaxkNL/gHNx3KfTbzKk5sQgEjfkPDbpwPIRQE
 jP4IPCY60jtXv/DxjTUSgxf5Qr2r2jpGlPXl4XFDvJQM9NzN1M5yioBy/fgRWcQVz0bP
 VkwxeQdY7FgYbb8QksG+3Q3H4QdRb5cYr4f/oXO8slK/Z84iCLXzsJnr1mBUutevf57g
 XVww==
X-Gm-Message-State: AOJu0YxzbnhSuKOfD2l6sCeI4XCps1E2Ci+xsWpCeJXI9WVDYERXCW7U
 mLtqBA3M5+dQf1Ddf9vJVQHnFXTKfOHJMUK7QK0IplwtzHAZFTYj6eXh6xOfgTzIbmqWu+v8LvO
 tMySQj0HtYBHjdiCP7EqC4xqWY9FfzifT8SbTXMDz/jlEMhdxEuKH6bfhMHAyzPqFwmY2hHQOn0
 QwiGwHhA==
X-Gm-Gg: AR+sD109VarVIsqxQuNLRbDXG80ncUa9uhhUD7Ltu93SbaYZz6e19lYHW6RngLMPDc9
 BvmqhTAx0xozxn6CmehEUKuoayPvHSlOS3CGNlB89VNKS3GYnbaz/ANYxLSt6WCAxc5/vCA6XXM
 uQdsJEDtJ2qQPO5EfGLwelumUdqaNkxVG/UmHJu3egyf8m74TEjboVEhjNu2oPwEXGXNgWoI1ry
 AS53lM1DxriXwbFc7ra2sby7IZlEbu0VfOS7vlod9CkyAw190NqEUxPTeKmWkOfLy4NqvdDUMiq
 tThC1/wmCk0Ysooj38BB9r4ORo7yIOAlj7lBURNmWRMBeOWdePWTWix6a6rBBqF2iYBtAexNbvf
 y3FwnRtUHDcvHfwc/8H23DLOBk0drOsAsBVEWEk4cIjGyzJaVZJVNfmNM0O4/qoeMg6IQs+q/sm
 M4//Wi2yAw+D99e85gL3GtNHqchS+E3KOu25KfH8EXhPDCJUC90Tq95EdP2BlyV8PmCfWWb0MT1
 k9zLviPmLs/jhNOq75IHbBXK7beD5iIs4xRgd8LLa0hd3P2kFiwHk6gVDDBtbb5mTTObCjyq1Cx
 Xv5h6AYJQhhDjaM6juPGwy7ukyEokkOOKf0PT907Shiy0QM2QJA=
X-Received: by 2002:a05:600d:8483:b0:498:1371:6612 with SMTP id
 5b1f17b1804b1-4994e7a70aemr243387905e9.6.1786110579701; 
 Fri, 07 Aug 2026 06:49:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995e9e702dsm52928985e9.3.2026.08.07.06.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 06:49:39 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 7 Aug 2026 13:49:36 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0
X-Gerrit-Change-Number: 1728
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1728?usp=email>
X-Gerrit-Commit: 7f4541b3b554f681d3e102c57d9c50f9ebc51199
In-Reply-To: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
References: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTQyMjY4MDAwLklhZjFmMzQ3NWU0ZjI3YTkyMGMwMjhjZDczYjFhMjQ5Nzk1MzU4M2QwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <101e2eb2989a7a7f51e0bdaba046d2f02dded605-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsMS4-0002wW-59
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
Content-Type: multipart/mixed; boundary="===============1287372067655188051=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1287372067655188051==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z8MPSdZomQg="; charset=UTF-8

--Z8MPSdZomQg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728?usp=3Demail

to look at the new pa=
tch set (#6)=2E

The following approvals got outdated and were removed:
Cod=
e-Review+2 by flichtenheld


Change subject: Do not differentiate TLS serve=
r and client context initialisation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Do not differentiate TLS server and client context i=
nitialisation

OpenSSL has the quite curious way of allowing to create cont=
exts
that allow only server or only client=2E This creates extra
complicati=
ons when we want to use both server and client SSL
objects and does not see=
m to have any advantages=2E

We later explicitly tell OpenSSL to initialise=
 the SSL objects
to be a server or client object in key_state_ssl_init via
=
SSL_set_accept_state or SSL_set_connect_state=2E If this is
mismatched we e=
nd up getting an error from OpenSSL ("called a
function you should not call=
") that ends up calling a function
that is not defined in that TLS_method=
=2E

Looking into the OpenSSL source (IMPLEMENT_tls_meth_func) the main
dif=
ference between the methods is whether they have a proper
accept/connect or=
 have the ssl_undefined_function that triggers the
"called a function you s=
hould not call"=2E

Our mbed TLS code basically does not give the TLS conte=
xt any personality
of client or server until we are in the same area in whi=
ch the OpenSSL
code calls SSL_set_accept_state/SSL_set_connect_state=2E

Th=
is also modifies the mbedTLS backend to make the decision to use
client or =
server TLS context personality in key_state_ssl_init=2E
same as the OpenSSL=
 backend=2E

Change-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0
Signed-of=
f-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/ssl=2Ec
M src/ope=
nvpn/ssl_backend=2Eh
M src/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_mbedtl=
s=2Eh
M src/openvpn/ssl_openssl=2Ec
M tests/unit_tests/openvpn/test_ssl=2Ec=

6 files changed, 17 insertions(+), 65 deletions(-)


  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/28/1728/6

diff --git a/src/o=
penvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index ccd8264=2E=2E17808f7 100644
--- =
a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -525,18 +525,11 @@
     =
struct tls_root_ctx *new_ctx;
     ALLOC_OBJ_CLEAR(new_ctx, struct tls_root=
_ctx);
 
-    if (options->tls_server)
-    {
-        tls_ctx_server_new(n=
ew_ctx);
+    tls_ctx_new(new_ctx);
 
-        if (options->dh_file)
-     =
   {
-            tls_ctx_load_dh_params(new_ctx, options->dh_file, options=
->dh_file_inline);
-        }
-    }
-    else /* if client */
+    if (opt=
ions->tls_server && options->dh_file)
     {
-        tls_ctx_client_new(ne=
w_ctx);
+        tls_ctx_load_dh_params(new_ctx, options->dh_file, options-=
>dh_file_inline);
     }
 
     /* Restrict allowed certificate crypto algo=
rithms */
diff --git a/src/openvpn/ssl_backend=2Eh b/src/openvpn/ssl_backen=
d=2Eh
index 816fb9c=2E=2Ea6d57f2 100644
--- a/src/openvpn/ssl_backend=2Eh
+=
++ b/src/openvpn/ssl_backend=2Eh
@@ -117,18 +117,11 @@
 int tls_version_max=
(void);
 
 /**
- * Initialise a library-specific TLS context for a server=
=2E
+ * Initialise a library-specific TLS context=2E
  *
  * @param ctx    =
       TLS context to initialise
  */
-void tls_ctx_server_new(struct tls_r=
oot_ctx *ctx);
-
-/**
- * Initialises a library-specific TLS context for a =
client=2E
- *
- * @param ctx           TLS context to initialise
- */
-void=
 tls_ctx_client_new(struct tls_root_ctx *ctx);
+void tls_ctx_new(struct tls=
_root_ctx *ctx);
 
 /**
  * Frees the library-specific TLSv1 context
diff -=
-git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 07ca=
f08=2E=2E6d7ac04 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn=
/ssl_mbedtls=2Ec
@@ -88,7 +88,7 @@
 }
 
 void
-tls_ctx_server_new(struct tl=
s_root_ctx *ctx)
+tls_ctx_new(struct tls_root_ctx *ctx)
 {
     ASSERT(NULL=
 !=3D ctx);
     CLEAR(*ctx);
@@ -99,24 +99,9 @@
 
     ALLOC_OBJ_CLEAR(ctx=
->ca_chain, mbedtls_x509_crt);
 
-    ctx->endpoint =3D MBEDTLS_SSL_IS_SERV=
ER;
     ctx->initialised =3D true;
 }
 
-void
-tls_ctx_client_new(struct t=
ls_root_ctx *ctx)
-{
-    ASSERT(NULL !=3D ctx);
-    CLEAR(*ctx);
-
-#if M=
BEDTLS_VERSION_NUMBER < 0x04000000
-    ALLOC_OBJ_CLEAR(ctx->dhm_ctx, mbedt=
ls_dhm_context);
-#endif
-    ALLOC_OBJ_CLEAR(ctx->ca_chain, mbedtls_x509_c=
rt);
-
-    ctx->endpoint =3D MBEDTLS_SSL_IS_CLIENT;
-    ctx->initialised =
=3D true;
-}
 
 void
 tls_ctx_free(struct tls_root_ctx *ctx)
@@ -1141,7 +11=
26,8 @@
     /* Initialise SSL config */
     ALLOC_OBJ_CLEAR(ks_ssl->ssl_c=
onfig, mbedtls_ssl_config);
     mbedtls_ssl_config_init(ks_ssl->ssl_config=
);
-    mbedtls_ssl_config_defaults(ks_ssl->ssl_config, ssl_ctx->endpoint, =
MBEDTLS_SSL_TRANSPORT_STREAM,
+    int endpoint =3D is_server ? MBEDTLS_SSL=
_IS_SERVER : MBEDTLS_SSL_IS_CLIENT;
+    mbedtls_ssl_config_defaults(ks_ssl=
->ssl_config, endpoint, MBEDTLS_SSL_TRANSPORT_STREAM,
                     =
            MBEDTLS_SSL_PRESET_DEFAULT);
 #ifdef MBEDTLS_DEBUG_C
     /* We=
 only want to have mbed TLS generate debug level logging when we would
@@ -=
1530,7 +1516,7 @@
     struct tls_root_ctx tls_ctx;
     const int *ciphers=
 =3D mbedtls_ssl_list_ciphersuites();
 
-    tls_ctx_server_new(&tls_ctx);
=
+    tls_ctx_new(&tls_ctx);
     tls_ctx_set_cert_profile(&tls_ctx, tls_cer=
t_profile);
     tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
 
diff --=
git a/src/openvpn/ssl_mbedtls=2Eh b/src/openvpn/ssl_mbedtls=2Eh
index 6b678=
b2=2E=2E32d4f60 100644
--- a/src/openvpn/ssl_mbedtls=2Eh
+++ b/src/openvpn/=
ssl_mbedtls=2Eh
@@ -114,8 +114,6 @@
 {
     bool initialised; /**< True if =
the context has been initialised */
 
-    int endpoint;     /**< Whether o=
r not this is a server or a client */
-
 #if MBEDTLS_VERSION_NUMBER < 0x040=
00000
     mbedtls_dhm_context *dhm_ctx;          /**< Diffie-Helmann-Merkl=
e context */
 #endif
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn=
/ssl_openssl=2Ec
index 32b13db=2E=2Ee4e78e9 100644
--- a/src/openvpn/ssl_op=
enssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -100,37 +100,19 @@
 }
 
 voi=
d
-tls_ctx_server_new(struct tls_root_ctx *ctx)
+tls_ctx_new(struct tls_roo=
t_ctx *ctx)
 {
     ASSERT(NULL !=3D ctx);
 
-    ctx->ctx =3D SSL_CTX_new_=
ex(tls_libctx, NULL, SSLv23_server_method());
+    ctx->ctx =3D SSL_CTX_new=
_ex(tls_libctx, NULL, TLS_method());
 
     if (ctx->ctx =3D=3D NULL)
     =
{
-        crypto_msg(M_FATAL, "SSL_CTX_new SSLv23_server_method");
+      =
  crypto_msg(M_FATAL, "SSL_CTX_new TLS_method");
     }
     if (ERR_peek_e=
rror() !=3D 0)
     {
-        crypto_msg(M_WARN, "Warning: TLS server cont=
ext initialisation "
-                           "has warnings=2E");
-    }=

-}
-
-void
-tls_ctx_client_new(struct tls_root_ctx *ctx)
-{
-    ASSERT(NU=
LL !=3D ctx);
-
-    ctx->ctx =3D SSL_CTX_new_ex(tls_libctx, NULL, SSLv23_c=
lient_method());
-
-    if (ctx->ctx =3D=3D NULL)
-    {
-        crypto_ms=
g(M_FATAL, "SSL_CTX_new SSLv23_client_method");
-    }
-    if (ERR_peek_er=
ror() !=3D 0)
-    {
-        crypto_msg(M_WARN, "Warning: TLS client conte=
xt initialisation "
+        crypto_msg(M_WARN, "Warning: TLS context initi=
alisation "
                            "has warnings=2E");
     }
 }
diff =
--git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/te=
st_ssl=2Ec
index d473d67=2E=2E54d52a0 100644
--- a/tests/unit_tests/openvpn=
/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -175,7 +175,7 =
@@
     struct gc_arena gc =3D gc_new();
 
     struct tls_root_ctx ctx =3D=
 { 0 };
-    tls_ctx_client_new(&ctx);
+    tls_ctx_new(&ctx);
     tls_ctx=
_load_cert_file(&ctx, unittest_cert, true);
 
     openvpn_x509_cert_t *cer=
t =3D NULL;
@@ -208,13 +208,13 @@
     /* test loading of inlined cert and =
key=2E
      * loading the key also checks that it matches the loaded certi=
ficate
      */
-    tls_ctx_client_new(&ctx);
+    tls_ctx_new(&ctx);
    =
 tls_ctx_load_cert_file(&ctx, unittest_cert, true);
     assert_int_equal(t=
ls_ctx_load_priv_file(&ctx, unittest_key, true), 0);
     tls_ctx_free(&ctx=
);
 
     /* test loading of cert and key from file */
-    tls_ctx_client_=
new(&ctx);
+    tls_ctx_new(&ctx);
     tls_ctx_load_cert_file(&ctx, global=
_state=2Ecertfile, false);
     assert_int_equal(tls_ctx_load_priv_file(&ct=
x, global_state=2Ekeyfile, false), 0);
     tls_ctx_free(&ctx);
@@ -252,7 +=
252,7 @@
     string_mod(BSTR(&keyuri), CC_ANY, CC_BACKSLASH, '/');
 #endif=
 /* _WIN32 */
 
-    tls_ctx_client_new(&ctx);
+    tls_ctx_new(&ctx);
    =
 tls_ctx_load_cert_file(&ctx, BSTR(&certuri), false);
     assert_int_equal=
(tls_ctx_load_priv_file(&ctx, BSTR(&keyuri), false), 0);
     tls_ctx_free(=
&ctx);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaf1f3475e=
4f27a920c028cd73b1a2497953583d0
Gerrit-Change-Number: 1728
Gerrit-PatchSet:=
 6
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: fl=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--Z8MPSdZomQg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #6</strong> to this change=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1728?usp=3Demail">View Change</a></p><p>Th=
e following approvals got outdated and were removed:
Code-Review+2 by flich=
tenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">Do not differentiate TLS server and client context=
 initialisation<br><br>OpenSSL has the quite curious way of allowing to cre=
ate contexts<br>that allow only server or only client=2E This creates extra=
<br>complications when we want to use both server and client SSL<br>objects=
 and does not seem to have any advantages=2E<br><br>We later explicitly tel=
l OpenSSL to initialise the SSL objects<br>to be a server or client object =
in key_state_ssl_init via<br>SSL_set_accept_state or SSL_set_connect_state=
=2E If this is<br>mismatched we end up getting an error from OpenSSL (&quot=
;called a<br>function you should not call&quot;) that ends up calling a fun=
ction<br>that is not defined in that TLS_method=2E<br><br>Looking into the =
OpenSSL source (IMPLEMENT_tls_meth_func) the main<br>difference between the=
 methods is whether they have a proper<br>accept/connect or have the ssl_un=
defined_function that triggers the<br>&quot;called a function you should no=
t call&quot;=2E<br><br>Our mbed TLS code basically does not give the TLS co=
ntext any personality<br>of client or server until we are in the same area =
in which the OpenSSL<br>code calls SSL_set_accept_state/SSL_set_connect_sta=
te=2E<br><br>This also modifies the mbedTLS backend to make the decision to=
 use<br>client or server TLS context personality in key_state_ssl_init=2E<b=
r>same as the OpenSSL backend=2E<br><br>Change-Id: Iaf1f3475e4f27a920c028cd=
73b1a2497953583d0<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;=
<br>---<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_backend=2Eh<br>M src/=
openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_mbedtls=2Eh<br>M src/openvpn/s=
sl_openssl=2Ec<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>6 files change=
d, 17 insertions(+), 65 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/28/1728/6</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index c=
cd8264=2E=2E17808f7 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span>=
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
</span><br><span>index 07caf08=2E=2E6d7ac04 100644</span><br><span>--- a/sr=
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
(struct tls_root_ctx *ctx)</span><br><span>@@ -1141,7 +1126,8 @@</span><br>=
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
l logging when we would</span><br><span>@@ -1530,7 +1516,7 @@</span><br><sp=
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
pan>index 32b13db=2E=2Ee4e78e9 100644</span><br><span>--- a/src/openvpn/ssl=
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
ts/unit_tests/openvpn/test_ssl=2Ec</span><br><span>index d473d67=2E=2E54d52=
a0 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</span=
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

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1728 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>

</body></html>
--Z8MPSdZomQg=--


--===============1287372067655188051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1287372067655188051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1287372067655188051==--

