Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4B2C5B572
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6t3pwLUTSnUXkk7qdlylZkEgrpfOlan8Xpz4rLudhGM=; b=K8kjndI2vlDsSdhBQ66Ga3cyA4
	6uAhOSq78lwkVbd5ujWB9q5kujJVBGlBI56l/3YVTkZmWAApPzRkiW/MWS0zRDY0leKHifUJZb7H+
	hsBZ6Pt/m67uHHHhi7ksYzHERnwaQ2ckKLJrTg9kl3V6hZajuuHo84FYtT/8poUSK2rU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wulyM-0002ve-Fr;
	Fri, 14 Aug 2026 07:04:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wulyL-0002vV-Hw
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:04:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tOcxPdzYtQqEG/jdyObwOh5joc1Y0op9AdF4i3XdoFI=; b=I6WwVACr4r3Mq8Rp5AvY6HclJV
 xE2mEP6GpAGvtnyI4EF/cSSTUw0cdOOwewLfey/Arvr7P/KpPJTtyn5lTEEPQ/jdurUQy03lZelNW
 zmJcpPwanQMPx3GnhSA3OfJLwn5Sr3WVmVuhSGkRujnkiablsTum0+TP5EDbXPd7vLCM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tOcxPdzYtQqEG/jdyObwOh5joc1Y0op9AdF4i3XdoFI=; b=H
 SKgLymhkvVI//7EbtoP/ZcafwJKSQOdr8aHolH+ZsrtT2oHFSuMeXbBwq6+knNSdZNF6NgoiD1Fqc
 fZmJZReUpd8l2JRWPxvqeQLWSVFnG6dWCqx+ikh4YHwnHtqluedfTHyl5vRwnOtKV6xidgrhYbgX9
 hfP3OAe7j9aFRv/0=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wulyJ-0000aM-TB for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:04:57 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so4859955e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 00:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786691089; x=1787295889; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tOcxPdzYtQqEG/jdyObwOh5joc1Y0op9AdF4i3XdoFI=;
 b=Owu2gQjbFalTS2zW6X+j45J8g7dn2JZNwJu+fgtqkPaTTviJ9DPtcQADoK0NTWgjQ7
 LdsGpyS4LxSOEJm5jo7D2aACese7cuIgnU7UmsWGE9Ek59u38o1pnjaKRgDmJvyQ/LP6
 Ztek6nEqeVGhXBR7P/Or9SqSlnZ3y4UM+iHoJDorO+EZ4PGlwJbjMN1DvPMy4U+aWsKf
 Ln57zuU34O3BJsl43djyOiY8xxd4rsTsQf9Yx8XVDXrY51G0dl6vLxQKlYJgSJAVwvFd
 nQBnUjjia5msuOgQTuaqk36dU7vUMAuh1GEOOtEAinNJCx4HnVfAD+fs2M0VG5jCgXKC
 sLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786691089; x=1787295889;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tOcxPdzYtQqEG/jdyObwOh5joc1Y0op9AdF4i3XdoFI=;
 b=RlHNNYZbpTpG/1/ZamulWCFa0tzJZBFrtv0LLeh2A+EYbnXsnfG17pnyhpCls/RE98
 Rhzu0Q7GPWlKwgtdpqRMIPDndetL9t/RlwT7D09TbebTiRORouycg3WXZmAuOFfCUgYE
 K14EBiVgJT9wlXEE+ukYJV1r37Rfn+XQirN8tJT+RzSzkZkZBf+u9Dpz/x0M4O6perMA
 g4DokXArar/NN8hC+G2NFsrnCNJxQe9TYXaGJB1iiC+dJmJm9goM1mwVYhkoudbvbxME
 c0bCo31/GQJgUGOckP0P4U3qhglmOWKQlAvZoyCEQge9nXSYX+RgNm1xdRpFEkNFS6nu
 F4yA==
X-Forwarded-Encrypted: i=1;
 AHgh+RonYCH7fTE66eFuYYgct7HDAIk1q7KGWst1ATzTfAom/Dap8VEtTfUebTOBkxyWI1FfVp5jVaDc6TgeqpCw@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yys/1ExeFsEyZVKJLIWh1hZze16xlNTbXEpshsWneKnJ6X3t70w
 nImipV0y8r4LlGlvZ/bc/fexgzKP8omgaIbHiCVwPTJcVrDIFRNeJHQo4lSMxfQpS1Y+K1vL6jN
 U0s2vKbNejaKVxK8+PNAzwmQrUrB1G8VLBzlj0CFvQS+xZhoOQ7TGG50xyLtLnS0vIXnE541tWA
 yexeASfw==
X-Gm-Gg: AR+sD12AVlqqhpda6ystlpaJzSutF37gEp2BX2DhQWXVelf1/+S4ZtdfR6k18H/6qxp
 alYmld1LqF+nRawqrTDu1/28BcJKnW3WCGusqdlImadKolTkbaw3D9J0P9wzXImJC/mil5+YJDQ
 ayygo5cWqPOf8If+hJQuejYIeptn5gVq54ynTCRyNXmN7zpouWZfmJseQZMMU9cXHNxhPcRUpkZ
 Wf30yjrJAc7V0ngDF4YGGk1cnxa33sEvrPtsyGbqPEg/xf7jqBa+UsuG34xvBWtuIQWmn5xdCuL
 Mr8pL2IQmvCsTyPoYtVlJep5oxLz4ygocgqgyPEhLcOQ53H4qcOzi+M32+AjVeYh346pKmnrH2u
 0PJjLH60LLR9+9sB9WLgOj7orZ83Bt/qS7LvSOhFa7wKlQ80JDNZ99wXpahJVjIPQoVMYRkwzQJ
 nGwlH4oJSbiLcZXcnhTaLg6dTx516eyHOjXoCoyB8CAGaAY4yIJmnMNDsYJqyYf7RBROJKLygjz
 /wbJP3mPfQi2QoeynCqq0vHoWxFF9VDyACLWzctYG/xqUrYDgZlkT61YQt458b0EhN/b1zaBPEd
 8tYpDAknwSctXxdYFVg8YMASCOtRDt+e8ZUI57UA2YWtIh3xOGY=
X-Received: by 2002:a05:600c:3496:b0:493:f318:3bc6 with SMTP id
 5b1f17b1804b1-4998796e478mr51506125e9.13.1786691089075; 
 Fri, 14 Aug 2026 00:04:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499877a6e0asm20907515e9.2.2026.08.14.00.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 00:04:48 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 07:04:47 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0
X-Gerrit-Change-Number: 1728
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1728?usp=email>
X-Gerrit-Commit: 37acc42ce769a1c7415311eaf40b9013316d8a61
In-Reply-To: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
References: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTQyMjY4MDAwLklhZjFmMzQ3NWU0ZjI3YTkyMGMwMjhjZDczYjFhMjQ5Nzk1MzU4M2QwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <47cea0e4e4bfc41d66be3248a8bf640ba8683195-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wulyJ-0000aM-TB
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7894142391068020551=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7894142391068020551==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gxRw3UYgQn8="; charset=UTF-8

--gxRw3UYgQn8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1728?usp=3Demail )

Change subject: Do not differentiate TLS server and=
 client context initialisation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Do not differentiate TLS server and client context init=
ialisation

OpenSSL has the quite curious way of allowing to create context=
s
that allow only server or only client=2E This creates extra
complications=
 when we want to use both server and client SSL
objects and does not seem t=
o have any advantages=2E

We later explicitly tell OpenSSL to initialise th=
e SSL objects
to be a server or client object in key_state_ssl_init via
SSL=
_set_accept_state or SSL_set_connect_state=2E If this is
mismatched we end =
up getting an error from OpenSSL ("called a
function you should not call") =
that ends up calling a function
that is not defined in that TLS_method=2E

=
Looking into the OpenSSL source (IMPLEMENT_tls_meth_func) the main
differen=
ce between the methods is whether they have a proper
accept/connect or have=
 the ssl_undefined_function that triggers the
"called a function you should=
 not call"=2E

Our mbed TLS code basically does not give the TLS context an=
y personality
of client or server until we are in the same area in which th=
e OpenSSL
code calls SSL_set_accept_state/SSL_set_connect_state=2E

This al=
so modifies the mbedTLS backend to make the decision to use
client or serve=
r TLS context personality in key_state_ssl_init=2E
same as the OpenSSL back=
end=2E

Change-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0
Signed-off-by:=
 Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728
M=
essage-Id: <20260813185258=2E7084-1-gert@greenie=2Emuc=2Ede>
URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38340=2E=
html
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvp=
n/ssl=2Ec
M src/openvpn/ssl_backend=2Eh
M src/openvpn/ssl_mbedtls=2Ec
M src=
/openvpn/ssl_mbedtls=2Eh
M src/openvpn/ssl_openssl=2Ec
M tests/unit_tests/o=
penvpn/test_ssl=2Ec
6 files changed, 17 insertions(+), 65 deletions(-)




=
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index d539018=2E=2Ef=
d96b85 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -525,1=
8 +525,11 @@
     struct tls_root_ctx *new_ctx;
     ALLOC_OBJ_CLEAR(new_ct=
x, struct tls_root_ctx);
 
-    if (options->tls_server)
-    {
-        tl=
s_ctx_server_new(new_ctx);
+    tls_ctx_new(new_ctx);
 
-        if (option=
s->dh_file)
-        {
-            tls_ctx_load_dh_params(new_ctx, options=
->dh_file, options->dh_file_inline);
-        }
-    }
-    else /* if clie=
nt */
+    if (options->tls_server && options->dh_file)
     {
-        tls=
_ctx_client_new(new_ctx);
+        tls_ctx_load_dh_params(new_ctx, options-=
>dh_file, options->dh_file_inline);
     }
 
     /* Restrict allowed certi=
ficate crypto algorithms */
diff --git a/src/openvpn/ssl_backend=2Eh b/src/=
openvpn/ssl_backend=2Eh
index 816fb9c=2E=2Ea6d57f2 100644
--- a/src/openvpn=
/ssl_backend=2Eh
+++ b/src/openvpn/ssl_backend=2Eh
@@ -117,18 +117,11 @@
 i=
nt tls_version_max(void);
 
 /**
- * Initialise a library-specific TLS cont=
ext for a server=2E
+ * Initialise a library-specific TLS context=2E
  *
  =
* @param ctx           TLS context to initialise
  */
-void tls_ctx_server_=
new(struct tls_root_ctx *ctx);
-
-/**
- * Initialises a library-specific TL=
S context for a client=2E
- *
- * @param ctx           TLS context to initi=
alise
- */
-void tls_ctx_client_new(struct tls_root_ctx *ctx);
+void tls_ct=
x_new(struct tls_root_ctx *ctx);
 
 /**
  * Frees the library-specific TLSv=
1 context
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtl=
s=2Ec
index 07caf08=2E=2E6d7ac04 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+=
++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -88,7 +88,7 @@
 }
 
 void
-tls_ctx_serv=
er_new(struct tls_root_ctx *ctx)
+tls_ctx_new(struct tls_root_ctx *ctx)
 {
=
     ASSERT(NULL !=3D ctx);
     CLEAR(*ctx);
@@ -99,24 +99,9 @@
 
     ALL=
OC_OBJ_CLEAR(ctx->ca_chain, mbedtls_x509_crt);
 
-    ctx->endpoint =3D MBE=
DTLS_SSL_IS_SERVER;
     ctx->initialised =3D true;
 }
 
-void
-tls_ctx_cli=
ent_new(struct tls_root_ctx *ctx)
-{
-    ASSERT(NULL !=3D ctx);
-    CLEAR=
(*ctx);
-
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    ALLOC_OBJ_CLEAR(ctx=
->dhm_ctx, mbedtls_dhm_context);
-#endif
-    ALLOC_OBJ_CLEAR(ctx->ca_chain=
, mbedtls_x509_crt);
-
-    ctx->endpoint =3D MBEDTLS_SSL_IS_CLIENT;
-    c=
tx->initialised =3D true;
-}
 
 void
 tls_ctx_free(struct tls_root_ctx *ctx=
)
@@ -1141,7 +1126,8 @@
     /* Initialise SSL config */
     ALLOC_OBJ_CLE=
AR(ks_ssl->ssl_config, mbedtls_ssl_config);
     mbedtls_ssl_config_init(ks=
_ssl->ssl_config);
-    mbedtls_ssl_config_defaults(ks_ssl->ssl_config, ssl=
_ctx->endpoint, MBEDTLS_SSL_TRANSPORT_STREAM,
+    int endpoint =3D is_serv=
er ? MBEDTLS_SSL_IS_SERVER : MBEDTLS_SSL_IS_CLIENT;
+    mbedtls_ssl_config=
_defaults(ks_ssl->ssl_config, endpoint, MBEDTLS_SSL_TRANSPORT_STREAM,
     =
                            MBEDTLS_SSL_PRESET_DEFAULT);
 #ifdef MBEDTLS_DE=
BUG_C
     /* We only want to have mbed TLS generate debug level logging wh=
en we would
@@ -1530,7 +1516,7 @@
     struct tls_root_ctx tls_ctx;
     co=
nst int *ciphers =3D mbedtls_ssl_list_ciphersuites();
 
-    tls_ctx_server=
_new(&tls_ctx);
+    tls_ctx_new(&tls_ctx);
     tls_ctx_set_cert_profile(&=
tls_ctx, tls_cert_profile);
     tls_ctx_restrict_ciphers(&tls_ctx, cipher_=
list);
 
diff --git a/src/openvpn/ssl_mbedtls=2Eh b/src/openvpn/ssl_mbedtls=
=2Eh
index 6b678b2=2E=2E32d4f60 100644
--- a/src/openvpn/ssl_mbedtls=2Eh
++=
+ b/src/openvpn/ssl_mbedtls=2Eh
@@ -114,8 +114,6 @@
 {
     bool initialise=
d; /**< True if the context has been initialised */
 
-    int endpoint;   =
  /**< Whether or not this is a server or a client */
-
 #if MBEDTLS_VERSIO=
N_NUMBER < 0x04000000
     mbedtls_dhm_context *dhm_ctx;          /**< Diff=
ie-Helmann-Merkle context */
 #endif
diff --git a/src/openvpn/ssl_openssl=
=2Ec b/src/openvpn/ssl_openssl=2Ec
index e4b760e=2E=2E0b01634 100644
--- a/=
src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -100,37 +1=
00,19 @@
 }
 
 void
-tls_ctx_server_new(struct tls_root_ctx *ctx)
+tls_ctx_=
new(struct tls_root_ctx *ctx)
 {
     ASSERT(NULL !=3D ctx);
 
-    ctx->ct=
x =3D SSL_CTX_new_ex(tls_libctx, NULL, SSLv23_server_method());
+    ctx->c=
tx =3D SSL_CTX_new_ex(tls_libctx, NULL, TLS_method());
 
     if (ctx->ctx =
=3D=3D NULL)
     {
-        crypto_msg(M_FATAL, "SSL_CTX_new SSLv23_server=
_method");
+        crypto_msg(M_FATAL, "SSL_CTX_new TLS_method");
     }
 =
    if (ERR_peek_error() !=3D 0)
     {
-        crypto_msg(M_WARN, "Warnin=
g: TLS server context initialisation "
-                           "has war=
nings=2E");
-    }
-}
-
-void
-tls_ctx_client_new(struct tls_root_ctx *ctx)=

-{
-    ASSERT(NULL !=3D ctx);
-
-    ctx->ctx =3D SSL_CTX_new_ex(tls_libc=
tx, NULL, SSLv23_client_method());
-
-    if (ctx->ctx =3D=3D NULL)
-    {
=
-        crypto_msg(M_FATAL, "SSL_CTX_new SSLv23_client_method");
-    }
- =
   if (ERR_peek_error() !=3D 0)
-    {
-        crypto_msg(M_WARN, "Warning=
: TLS client context initialisation "
+        crypto_msg(M_WARN, "Warning:=
 TLS context initialisation "
                            "has warnings=2E"=
);
     }
 }
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/uni=
t_tests/openvpn/test_ssl=2Ec
index 793a70f=2E=2Ecb9c480 100644
--- a/tests/=
unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec=

@@ -177,7 +177,7 @@
     struct gc_arena gc =3D gc_new();
 
     struct tl=
s_root_ctx ctx =3D { 0 };
-    tls_ctx_client_new(&ctx);
+    tls_ctx_new(&=
ctx);
     tls_ctx_load_cert_file(&ctx, unittest_cert, true);
 
     openvp=
n_x509_cert_t *cert =3D NULL;
@@ -210,13 +210,13 @@
     /* test loading of=
 inlined cert and key=2E
      * loading the key also checks that it matche=
s the loaded certificate
      */
-    tls_ctx_client_new(&ctx);
+    tls_c=
tx_new(&ctx);
     tls_ctx_load_cert_file(&ctx, unittest_cert, true);
     =
assert_int_equal(tls_ctx_load_priv_file(&ctx, unittest_key, true), 0);
    =
 tls_ctx_free(&ctx);
 
     /* test loading of cert and key from file */
- =
   tls_ctx_client_new(&ctx);
+    tls_ctx_new(&ctx);
     tls_ctx_load_cert=
_file(&ctx, global_state=2Ecertfile, false);
     assert_int_equal(tls_ctx_=
load_priv_file(&ctx, global_state=2Ekeyfile, false), 0);
     tls_ctx_free(=
&ctx);
@@ -254,7 +254,7 @@
     string_mod(BSTR(&keyuri), CC_ANY, CC_BACKSL=
ASH, '/');
 #endif /* _WIN32 */
 
-    tls_ctx_client_new(&ctx);
+    tls_c=
tx_new(&ctx);
     tls_ctx_load_cert_file(&ctx, BSTR(&certuri), false);
   =
  assert_int_equal(tls_ctx_load_priv_file(&ctx, BSTR(&keyuri), false), 0);
=
     tls_ctx_free(&ctx);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1728?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: Iaf1f3475e4f27a920c028cd73b1a2497953583d0
Gerrit-Change-Number: 1728
Ger=
rit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>

--gxRw3UYgQn8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1728?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Do not differentiate TLS server and client=
 context initialisation<br><br>OpenSSL has the quite curious way of allowin=
g to create contexts<br>that allow only server or only client=2E This creat=
es extra<br>complications when we want to use both server and client SSL<br=
>objects and does not seem to have any advantages=2E<br><br>We later explic=
itly tell OpenSSL to initialise the SSL objects<br>to be a server or client=
 object in key_state_ssl_init via<br>SSL_set_accept_state or SSL_set_connec=
t_state=2E If this is<br>mismatched we end up getting an error from OpenSSL=
 (&quot;called a<br>function you should not call&quot;) that ends up callin=
g a function<br>that is not defined in that TLS_method=2E<br><br>Looking in=
to the OpenSSL source (IMPLEMENT_tls_meth_func) the main<br>difference betw=
een the methods is whether they have a proper<br>accept/connect or have the=
 ssl_undefined_function that triggers the<br>&quot;called a function you sh=
ould not call&quot;=2E<br><br>Our mbed TLS code basically does not give the=
 TLS context any personality<br>of client or server until we are in the sam=
e area in which the OpenSSL<br>code calls SSL_set_accept_state/SSL_set_conn=
ect_state=2E<br><br>This also modifies the mbedTLS backend to make the deci=
sion to use<br>client or server TLS context personality in key_state_ssl_in=
it=2E<br>same as the OpenSSL backend=2E<br><br>Change-Id: Iaf1f3475e4f27a92=
0c028cd73b1a2497953583d0<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2E=
org&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>G=
errit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728<br>Message-Id: &=
lt;20260813185258=2E7084-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38340=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_backend=2Eh<br>M src/openvpn/ss=
l_mbedtls=2Ec<br>M src/openvpn/ssl_mbedtls=2Eh<br>M src/openvpn/ssl_openssl=
=2Ec<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>6 files changed, 17 inse=
rtions(+), 65 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2E=
c b/src/openvpn/ssl=2Ec</span><br><span>index d539018=2E=2Efd96b85 100644</=
span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/=
ssl=2Ec</span><br><span>@@ -525,18 +525,11 @@</span><br><span>     struct t=
ls_root_ctx *new_ctx;</span><br><span>     ALLOC_OBJ_CLEAR(new_ctx, struct =
tls_root_ctx);</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (options-&gt;tls_server)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        tls_ctx_server_new(new_ctx);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    tls_ctx_new(new_ctx);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;dh_file=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            tls_ctx_load_dh_para=
ms(new_ctx, options-&gt;dh_file, options-&gt;dh_file_inline);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    else /* if client */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (options-&gt;tls_server &amp;&amp; options-&gt;dh_f=
ile)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        tls_ctx_client_new(new_ctx);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        tls_ctx_load_dh_params(new_ctx, options-&gt;=
dh_file, options-&gt;dh_file_inline);</span><br><span>     }</span><br><spa=
n> </span><br><span>     /* Restrict allowed certificate crypto algorithms =
*/</span><br><span>diff --git a/src/openvpn/ssl_backend=2Eh b/src/openvpn/s=
sl_backend=2Eh</span><br><span>index 816fb9c=2E=2Ea6d57f2 100644</span><br>=
<span>--- a/src/openvpn/ssl_backend=2Eh</span><br><span>+++ b/src/openvpn/s=
sl_backend=2Eh</span><br><span>@@ -117,18 +117,11 @@</span><br><span> int t=
ls_version_max(void);</span><br><span> </span><br><span> /**</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * Initialise a library-specific TLS=
 context for a server=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Initialise a library-specific TLS context=2E</span><br><span>  *</s=
pan><br><span>  * @param ctx           TLS context to initialise</span><br>=
<span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void tls_ct=
x_server_new(struct tls_root_ctx *ctx);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Initialises a libr=
ary-specific TLS context for a client=2E</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * @param ctx           TLS context to initialise</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-void tls_ctx_client_new(struct tls_root_ctx *ctx);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void tls_ctx_new(struct tls_root_c=
tx *ctx);</span><br><span> </span><br><span> /**</span><br><span>  * Frees =
the library-specific TLSv1 context</span><br><span>diff --git a/src/openvpn=
/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>index 07caf0=
8=2E=2E6d7ac04 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec</sp=
an><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -88,7 +88=
,7 @@</span><br><span> }</span><br><span> </span><br><span> void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_server_new(struct tls_ro=
ot_ctx *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_ctx=
_new(struct tls_root_ctx *ctx)</span><br><span> {</span><br><span>     ASSE=
RT(NULL !=3D ctx);</span><br><span>     CLEAR(*ctx);</span><br><span>@@ -99=
,24 +99,9 @@</span><br><span> </span><br><span>     ALLOC_OBJ_CLEAR(ctx-&gt=
;ca_chain, mbedtls_x509_crt);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    ctx-&gt;endpoint =3D MBEDTLS_SSL_IS_SERVER;</=
span><br><span>     ctx-&gt;initialised =3D true;</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_client_new(struct t=
ls_root_ctx *ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(NULL !=3D ctx=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(*ctx);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_OBJ_CLEAR(ct=
x-&gt;dhm_ctx, mbedtls_dhm_context);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    ALLOC_OBJ_CLEAR(ctx-&gt;ca_chain, mbedtls_x509_crt);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    ctx-&gt;endpoint =3D MBEDTLS_SSL_IS_CLIENT;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt;initialised =3D true;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span> </sp=
an><br><span> void</span><br><span> tls_ctx_free(struct tls_root_ctx *ctx)<=
/span><br><span>@@ -1141,7 +1126,8 @@</span><br><span>     /* Initialise SS=
L config */</span><br><span>     ALLOC_OBJ_CLEAR(ks_ssl-&gt;ssl_config, mbe=
dtls_ssl_config);</span><br><span>     mbedtls_ssl_config_init(ks_ssl-&gt;s=
sl_config);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtl=
s_ssl_config_defaults(ks_ssl-&gt;ssl_config, ssl_ctx-&gt;endpoint, MBEDTLS_=
SSL_TRANSPORT_STREAM,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int endpoint =3D is_server ? MBEDTLS_SSL_IS_SERVER : MBEDTLS_SSL_IS_C=
LIENT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_s=
sl_config_defaults(ks_ssl-&gt;ssl_config, endpoint, MBEDTLS_SSL_TRANSPORT_S=
TREAM,</span><br><span>                                 MBEDTLS_SSL_PRESET_=
DEFAULT);</span><br><span> #ifdef MBEDTLS_DEBUG_C</span><br><span>     /* W=
e only want to have mbed TLS generate debug level logging when we would</sp=
an><br><span>@@ -1530,7 +1516,7 @@</span><br><span>     struct tls_root_ctx=
 tls_ctx;</span><br><span>     const int *ciphers =3D mbedtls_ssl_list_ciph=
ersuites();</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    tls_ctx_server_new(&amp;tls_ctx);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    tls_ctx_new(&amp;tls_ctx);</span><br><span>  =
   tls_ctx_set_cert_profile(&amp;tls_ctx, tls_cert_profile);</span><br><spa=
n>     tls_ctx_restrict_ciphers(&amp;tls_ctx, cipher_list);</span><br><span=
> </span><br><span>diff --git a/src/openvpn/ssl_mbedtls=2Eh b/src/openvpn/s=
sl_mbedtls=2Eh</span><br><span>index 6b678b2=2E=2E32d4f60 100644</span><br>=
<span>--- a/src/openvpn/ssl_mbedtls=2Eh</span><br><span>+++ b/src/openvpn/s=
sl_mbedtls=2Eh</span><br><span>@@ -114,8 +114,6 @@</span><br><span> {</span=
><br><span>     bool initialised; /**&lt; True if the context has been init=
ialised */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    int endpoint;     /**&lt; Whether or not this is a server or a c=
lient */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> #if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span>     mbedtl=
s_dhm_context *dhm_ctx;          /**&lt; Diffie-Helmann-Merkle context */</=
span><br><span> #endif</span><br><span>diff --git a/src/openvpn/ssl_openssl=
=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>index e4b760e=2E=2E0b016=
34 100644</span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span=
>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@@ -100,37 +100,19 @@</s=
pan><br><span> }</span><br><span> </span><br><span> void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-tls_ctx_server_new(struct tls_root_ctx *=
ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_ctx_new(str=
uct tls_root_ctx *ctx)</span><br><span> {</span><br><span>     ASSERT(NULL =
!=3D ctx);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    ctx-&gt;ctx =3D SSL_CTX_new_ex(tls_libctx, NULL, SSLv23_server_m=
ethod());</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ctx-&g=
t;ctx =3D SSL_CTX_new_ex(tls_libctx, NULL, TLS_method());</span><br><span> =
</span><br><span>     if (ctx-&gt;ctx =3D=3D NULL)</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        crypto_msg(M_FA=
TAL, &quot;SSL_CTX_new SSLv23_server_method&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        crypto_msg(M_FATAL, &quot;SSL_CTX=
_new TLS_method&quot;);</span><br><span>     }</span><br><span>     if (ERR=
_peek_error() !=3D 0)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        crypto_msg(M_WARN, &quot;Warning: TLS server=
 context initialisation &quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                           &quot;has warnings=2E&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_client_new(struct tls_=
root_ctx *ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(NULL !=3D ctx);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt;ctx =3D SSL_CTX_new_ex(tls_libc=
tx, NULL, SSLv23_client_method());</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
ctx-&gt;ctx =3D=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        crypt=
o_msg(M_FATAL, &quot;SSL_CTX_new SSLv23_client_method&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (ERR_peek_error() !=3D 0)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        crypto_msg(M_WARN, &quot;Warning: TLS client con=
text initialisation &quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        crypto_msg(M_WARN, &quot;Warning: TLS context initialisation=
 &quot;</span><br><span>                            &quot;has warnings=2E&q=
uot;);</span><br><span>     }</span><br><span> }</span><br><span>diff --git=
 a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ss=
l=2Ec</span><br><span>index 793a70f=2E=2Ecb9c480 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>+++ b/tests/unit_t=
ests/openvpn/test_ssl=2Ec</span><br><span>@@ -177,7 +177,7 @@</span><br><sp=
an>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>=
     struct tls_root_ctx ctx =3D { 0 };</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    tls_ctx_client_new(&amp;ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    tls_ctx_new(&amp;ctx);</span><br><spa=
n>     tls_ctx_load_cert_file(&amp;ctx, unittest_cert, true);</span><br><sp=
an> </span><br><span>     openvpn_x509_cert_t *cert =3D NULL;</span><br><sp=
an>@@ -210,13 +210,13 @@</span><br><span>     /* test loading of inlined ce=
rt and key=2E</span><br><span>      * loading the key also checks that it m=
atches the loaded certificate</span><br><span>      */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    tls_ctx_client_new(&amp;ctx);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    tls_ctx_new(&amp;ctx);</=
span><br><span>     tls_ctx_load_cert_file(&amp;ctx, unittest_cert, true);<=
/span><br><span>     assert_int_equal(tls_ctx_load_priv_file(&amp;ctx, unit=
test_key, true), 0);</span><br><span>     tls_ctx_free(&amp;ctx);</span><br=
><span> </span><br><span>     /* test loading of cert and key from file */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_ctx_client_new=
(&amp;ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_=
ctx_new(&amp;ctx);</span><br><span>     tls_ctx_load_cert_file(&amp;ctx, gl=
obal_state=2Ecertfile, false);</span><br><span>     assert_int_equal(tls_ct=
x_load_priv_file(&amp;ctx, global_state=2Ekeyfile, false), 0);</span><br><s=
pan>     tls_ctx_free(&amp;ctx);</span><br><span>@@ -254,7 +254,7 @@</span>=
<br><span>     string_mod(BSTR(&amp;keyuri), CC_ANY, CC_BACKSLASH, &#39;/&#=
39;);</span><br><span> #endif /* _WIN32 */</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    tls_ctx_client_new(&amp;ctx);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_ctx_new(&amp;c=
tx);</span><br><span>     tls_ctx_load_cert_file(&amp;ctx, BSTR(&amp;certur=
i), false);</span><br><span>     assert_int_equal(tls_ctx_load_priv_file(&a=
mp;ctx, BSTR(&amp;keyuri), false), 0);</span><br><span>     tls_ctx_free(&a=
mp;ctx);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728?usp=3Demail">change 1728</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iaf1f3475e4f27=
a920c028cd73b1a2497953583d0 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1728 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flicht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--gxRw3UYgQn8=--


--===============7894142391068020551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7894142391068020551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7894142391068020551==--

