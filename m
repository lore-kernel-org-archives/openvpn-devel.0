Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FF5C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=43bCVzUm2/EwJ1PzkhF/CiJd3iqtFMrrWWm5PcF4PWk=; b=kNB1TOUf1NofvAI6svE005xDBD
	HFDpnHIctstSv7JryYyK0UDbST1Ywbnq6nO9xg1CVFNjHt84F+Ly6zkvE1/cSkqfvPDbUO0hN65Jb
	WLeTNPPGNtAS4ms3lH3i63dC6W9tTFD00pUwynzthGbdZGs2ywoGpuddu9PRI2u1rBRY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wulyL-0006z6-0b;
	Fri, 14 Aug 2026 07:04:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wulyJ-0006yx-AI
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:04:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JfISiw8MF9nbZmQaAjnsIjde4Ty21mbBmuNcROP+LCQ=; b=Hi9xi8p4h5P3F7eJPkrXDWIwQG
 GFFJ6tH/HXGdFT1wJosHuzf5gNErjPyTMZXRjKJaAiEHQ4xRVY2wCkHy0VWYDvKKKESJMz8+TxglN
 s+BBl2NKpiPsrsCNvxiYZSVFftMbHJjaiPFmd5EZ0+zjjgOd3UdQj+v14Rh0GQux6tm8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JfISiw8MF9nbZmQaAjnsIjde4Ty21mbBmuNcROP+LCQ=; b=P
 1xFd3UG4bvERcutBVR8QEQ6fpsP7lj26hpch+eubZV0mUnxp8BSsxfJiL4ARMLs/ANfQeoh+fzwhN
 WJBe0wgfsGrG3Lk7SZFyTRG43PM5emGkmfBK8Wtwc5aekZN5RQgOjCHT8JQjqWlpqJLqZayMNw5/u
 ZuAAVQNMm2TlJ5Bw=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wulyL-0002HG-Ug for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:04:55 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4994c49f588so4914725e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 00:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786691088; x=1787295888; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JfISiw8MF9nbZmQaAjnsIjde4Ty21mbBmuNcROP+LCQ=;
 b=DZGeyoBcEphvT0sprS9WTZUsEbo5AHClqbH9q3UN9fZsBO8kskdDKAKSKQXU/3PVPb
 U/JwPPvC3cPk1ymSPvzXGUBQQEcCO83Q80qhe9tlw106qmT9iPR33PLdjOtccV7AEdjN
 7AGb6izlLNsaGgXVSYg+VZYWxs5KinvOpFBvhMhimmzPnKff3n5w5PsHrTtPqiPzn81F
 yDpeVaMGCZjTrW5LksWAYt47/PLz6TT6WtzzybY8iNWdjujkOa8+pdhBu4DtNRbd+4Q4
 mlkMfyPYAj2qvh5drLN5Cav8Hci4nxH+ieCPYoaSJG2I0BZkN0JFSHGws0aXsqUyJ8xE
 T53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786691088; x=1787295888;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JfISiw8MF9nbZmQaAjnsIjde4Ty21mbBmuNcROP+LCQ=;
 b=Dqd395cP8y42c+5JkNGT4i1bYX58NXI63qJGaiDVnRpPUs6VziP9MRkXDMzNvQi0zO
 DsINAm1u6NS9YmKM8iHHyFtDrWHSSOqTHsasKj+WY2H1X5d6ecSkOY/ycFQoyrgAj7ot
 cXXqEUM4k3LlCD+IuufuPEINJ+qGrirKSURQs9kMviylyV5r66VslM5iJz8QRVrfqppv
 e4vNC04hvt+rEJBxPlBGbGAdcpcQLnAmW0AlDbn5hBG5Vs9xQz7BMv4RrElps6Uoziby
 2CilKP/NEP9IHa2YE27WRj6wOgDF7jSoSVDv7oibH3ni592kJrpi4G0i6eL5D0d0kuTx
 HRqQ==
X-Gm-Message-State: AOJu0YyTVYutVRZHKhK5pOl2/7Ed7Jjm4fKCGwsNH1Z4HhmeB4dDaoPj
 tWDbSIw3pdTkajYrlU/xhyULRkelRWSkUVhgtxEOr6jJuxUq2mnUCXJUYCAk0LQgVZ/8CzA7OH8
 FKY2kjgzIfwAYTbveHH8WiOBuWLuVsW9u3N/Lo47CBEIwO6+RQP0+8QxwidYCI7HQ/Sd5vkpaSA
 Q1FAuuCA==
X-Gm-Gg: AR+sD12vG/lDGKm7sgoLRxXnZ6E5wnPUePH/ntzy6zHC7aPvV6AlQPYcZtR51a+Qii4
 seWuFiobRqjoKS++45MpUeQ6UHLvNbUWCuDrkzZoMRZ7EM0Ywp/jKX+GkkoZsIJJDSRzI+QQGeb
 fcm4LlSK40a6wZhfAFFrvqx+hFppskST3fKeY6XXu+JM0TZXpbeoT28ZcpT/8UkYAyPlSDxjBYF
 v4pJZhKXPazE38FCwYBA3NSOsPKRAFo2CYUwF1NuHnvCNZp1s6jAWnhdNuCky9ZvRkJ6SjpV1wo
 nuMVhRyBaSJ+UPd/TGIZexrlfuExWgGr+HGSg4lKe0LabBS7rWvUJZPvmZo6uHaE6p9bEuR0AHe
 MH5E2/TfXFfRZk0lpcWMd0cKg8wxdEHOVZD2vhSpJ5h+hBpyAR6qOT0jX9XRC8bVyvBiY4JY1Cg
 HOSCOaOJjcvRFdd6X9HlJVWgTLyBJZzFPdrBw3jfXFy3vMMPgoi4IlEJU8pmcSZw1J0y81RyVx8
 lWYn7JRZIy9f2/X57cSGvHidwJHox0bq4SuPrUV9bQ7kfELn6YopVUEyBvc+TWOBJzlQk3m9ClV
 SrXzSsWEbmoILkLWzzcsLwvnqXU+2+pBKsGak7ln/yJhLN1f7Uw=
X-Received: by 2002:a05:600c:4e14:b0:495:3bc6:d381 with SMTP id
 5b1f17b1804b1-49987a4f03bmr41083425e9.2.1786691087661; 
 Fri, 14 Aug 2026 00:04:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b25625sm27820895e9.13.2026.08.14.00.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 00:04:46 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 07:04:43 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0
X-Gerrit-Change-Number: 1728
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1728?usp=email>
X-Gerrit-Commit: 37acc42ce769a1c7415311eaf40b9013316d8a61
In-Reply-To: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
References: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTQyMjY4MDAwLklhZjFmMzQ3NWU0ZjI3YTkyMGMwMjhjZDczYjFhMjQ5Nzk1MzU4M2QwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <47cea0e4e4bfc41d66be3248a8bf640ba8683195-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wulyL-0002HG-Ug
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
Content-Type: multipart/mixed; boundary="===============7666236141943841169=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7666236141943841169==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5wFa/KzmnNY="; charset=UTF-8

--5wFa/KzmnNY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#7) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
flichtenheld


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

Our mbed TLS code basically does not give the TLS context any persona=
lity
of client or server until we are in the same area in which the OpenSSL=

code calls SSL_set_accept_state/SSL_set_connect_state=2E

This also modifi=
es the mbedTLS backend to make the decision to use
client or server TLS con=
text personality in key_state_ssl_init=2E
same as the OpenSSL backend=2E

C=
hange-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0
Signed-off-by: Arne Sch=
wabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728
Message-Id=
: <20260813185258=2E7084-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email=
-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38340=2Ehtml
Sign=
ed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
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
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/28/1728/7

diff --g=
it a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index d539018=2E=2Efd96b85 1=
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
index e4b760e=2E=2E0b01634 100644
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
index 793a70f=2E=2Ecb9c480 100644
--- a/tests/unit_tests=
/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -177,7=
 +177,7 @@
     struct gc_arena gc =3D gc_new();
 
     struct tls_root_ctx=
 ctx =3D { 0 };
-    tls_ctx_client_new(&ctx);
+    tls_ctx_new(&ctx);
    =
 tls_ctx_load_cert_file(&ctx, unittest_cert, true);
 
     openvpn_x509_cer=
t_t *cert =3D NULL;
@@ -210,13 +210,13 @@
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
-254,7 +254,7 @@
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
atchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>

--5wFa/KzmnNY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #7</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1728?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Do not differentiate=
 TLS server and client context initialisation<br><br>OpenSSL has the quite =
curious way of allowing to create contexts<br>that allow only server or onl=
y client=2E This creates extra<br>complications when we want to use both se=
rver and client SSL<br>objects and does not seem to have any advantages=2E<=
br><br>We later explicitly tell OpenSSL to initialise the SSL objects<br>to=
 be a server or client object in key_state_ssl_init via<br>SSL_set_accept_s=
tate or SSL_set_connect_state=2E If this is<br>mismatched we end up getting=
 an error from OpenSSL (&quot;called a<br>function you should not call&quot=
;) that ends up calling a function<br>that is not defined in that TLS_metho=
d=2E<br><br>Looking into the OpenSSL source (IMPLEMENT_tls_meth_func) the m=
ain<br>difference between the methods is whether they have a proper<br>acce=
pt/connect or have the ssl_undefined_function that triggers the<br>&quot;ca=
lled a function you should not call&quot;=2E<br><br>Our mbed TLS code basic=
ally does not give the TLS context any personality<br>of client or server u=
ntil we are in the same area in which the OpenSSL<br>code calls SSL_set_acc=
ept_state/SSL_set_connect_state=2E<br><br>This also modifies the mbedTLS ba=
ckend to make the decision to use<br>client or server TLS context personali=
ty in key_state_ssl_init=2E<br>same as the OpenSSL backend=2E<br><br>Change=
-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0<br>Signed-off-by: Arne Schwa=
be &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lich=
tenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1728<br>Message-Id: &lt;20260813185258=2E7084-1-gert@greenie=2Emuc=2Ede&gt=
;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforg=
e=2Enet/msg38340=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Em=
uc=2Ede&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_backend=2E=
h<br>M src/openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_mbedtls=2Eh<br>M sr=
c/openvpn/ssl_openssl=2Ec<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>6 f=
iles changed, 17 insertions(+), 65 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/28/1728/7<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><s=
pan>index d539018=2E=2Efd96b85 100644</span><br><span>--- a/src/openvpn/ssl=
=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -525,18 +=
525,11 @@</span><br><span>     struct tls_root_ctx *new_ctx;</span><br><spa=
n>     ALLOC_OBJ_CLEAR(new_ctx, struct tls_root_ctx);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;tls_s=
erver)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        tls_ctx_server_new(new_=
ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_ctx_ne=
w(new_ctx);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (options-&gt;dh_file)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            tls_ctx_load_dh_params(new_ctx, options-&gt;dh_file, opt=
ions-&gt;dh_file_inline);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    else /* if client */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt=
;tls_server &amp;&amp; options-&gt;dh_file)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        tls_ctx_client_new(new=
_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_c=
tx_load_dh_params(new_ctx, options-&gt;dh_file, options-&gt;dh_file_inline)=
;</span><br><span>     }</span><br><span> </span><br><span>     /* Restrict=
 allowed certificate crypto algorithms */</span><br><span>diff --git a/src/=
openvpn/ssl_backend=2Eh b/src/openvpn/ssl_backend=2Eh</span><br><span>index=
 816fb9c=2E=2Ea6d57f2 100644</span><br><span>--- a/src/openvpn/ssl_backend=
=2Eh</span><br><span>+++ b/src/openvpn/ssl_backend=2Eh</span><br><span>@@ -=
117,18 +117,11 @@</span><br><span> int tls_version_max(void);</span><br><sp=
an> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * Initialise a library-specific TLS context for a server=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Initialise a library-specif=
ic TLS context=2E</span><br><span>  *</span><br><span>  * @param ctx       =
    TLS context to initialise</span><br><span>  */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-void tls_ctx_server_new(struct tls_root_ctx *c=
tx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * Initialises a library-specific TLS context for a clie=
nt=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * @param ctx           TLS context=
 to initialise</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-void tls_ctx_client_new(s=
truct tls_root_ctx *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void tls_ctx_new(struct tls_root_ctx *ctx);</span><br><span> </span><=
br><span> /**</span><br><span>  * Frees the library-specific TLSv1 context<=
/span><br><span>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_=
mbedtls=2Ec</span><br><span>index 07caf08=2E=2E6d7ac04 100644</span><br><sp=
an>--- a/src/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_=
mbedtls=2Ec</span><br><span>@@ -88,7 +88,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-tls_ctx_server_new(struct tls_root_ctx *ctx)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tls_ctx_new(struct tls_root_ctx *ctx)</sp=
an><br><span> {</span><br><span>     ASSERT(NULL !=3D ctx);</span><br><span=
>     CLEAR(*ctx);</span><br><span>@@ -99,24 +99,9 @@</span><br><span> </sp=
an><br><span>     ALLOC_OBJ_CLEAR(ctx-&gt;ca_chain, mbedtls_x509_crt);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ctx-=
&gt;endpoint =3D MBEDTLS_SSL_IS_SERVER;</span><br><span>     ctx-&gt;initia=
lised =3D true;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-tls_ctx_client_new(struct tls_root_ctx *ctx)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    ASSERT(NULL !=3D ctx);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    CLEAR(*ctx);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
 MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    ALLOC_OBJ_CLEAR(ctx-&gt;dhm_ctx, mbedtls_dhm_context)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_OBJ_CLEAR(ctx-&gt;ca_chai=
n, mbedtls_x509_crt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt;endpoint =
=3D MBEDTLS_SSL_IS_CLIENT;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    ctx-&gt;initialised =3D true;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-}</span><br><span> </span><br><span> void</span><br><span>=
 tls_ctx_free(struct tls_root_ctx *ctx)</span><br><span>@@ -1141,7 +1126,8 =
@@</span><br><span>     /* Initialise SSL config */</span><br><span>     AL=
LOC_OBJ_CLEAR(ks_ssl-&gt;ssl_config, mbedtls_ssl_config);</span><br><span> =
    mbedtls_ssl_config_init(ks_ssl-&gt;ssl_config);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    mbedtls_ssl_config_defaults(ks_ssl-&gt;=
ssl_config, ssl_ctx-&gt;endpoint, MBEDTLS_SSL_TRANSPORT_STREAM,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int endpoint =3D is_server =
? MBEDTLS_SSL_IS_SERVER : MBEDTLS_SSL_IS_CLIENT;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    mbedtls_ssl_config_defaults(ks_ssl-&gt;ssl=
_config, endpoint, MBEDTLS_SSL_TRANSPORT_STREAM,</span><br><span>          =
                       MBEDTLS_SSL_PRESET_DEFAULT);</span><br><span> #ifdef=
 MBEDTLS_DEBUG_C</span><br><span>     /* We only want to have mbed TLS gene=
rate debug level logging when we would</span><br><span>@@ -1530,7 +1516,7 @=
@</span><br><span>     struct tls_root_ctx tls_ctx;</span><br><span>     co=
nst int *ciphers =3D mbedtls_ssl_list_ciphersuites();</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_ctx_server_new(&a=
mp;tls_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls=
_ctx_new(&amp;tls_ctx);</span><br><span>     tls_ctx_set_cert_profile(&amp;=
tls_ctx, tls_cert_profile);</span><br><span>     tls_ctx_restrict_ciphers(&=
amp;tls_ctx, cipher_list);</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/ssl_mbedtls=2Eh b/src/openvpn/ssl_mbedtls=2Eh</span><br><span>in=
dex 6b678b2=2E=2E32d4f60 100644</span><br><span>--- a/src/openvpn/ssl_mbedt=
ls=2Eh</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Eh</span><br><span>@@=
 -114,8 +114,6 @@</span><br><span> {</span><br><span>     bool initialised;=
 /**&lt; True if the context has been initialised */</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int endpoint;     /**&=
lt; Whether or not this is a server or a client */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span> #if MBEDTLS_VERSION_NUMBER &=
lt; 0x04000000</span><br><span>     mbedtls_dhm_context *dhm_ctx;          =
/**&lt; Diffie-Helmann-Merkle context */</span><br><span> #endif</span><br>=
<span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2E=
c</span><br><span>index e4b760e=2E=2E0b01634 100644</span><br><span>--- a/s=
rc/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=2E=
c</span><br><span>@@ -100,37 +100,19 @@</span><br><span> }</span><br><span>=
 </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-tls_ctx_server_new(struct tls_root_ctx *ctx)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+tls_ctx_new(struct tls_root_ctx *ctx)</span><br>=
<span> {</span><br><span>     ASSERT(NULL !=3D ctx);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt;ctx =3D SSL_CT=
X_new_ex(tls_libctx, NULL, SSLv23_server_method());</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;ctx =3D SSL_CTX_new_ex(tls_li=
bctx, NULL, TLS_method());</span><br><span> </span><br><span>     if (ctx-&=
gt;ctx =3D=3D NULL)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        crypto_msg(M_FATAL, &quot;SSL_CTX_new SSLv23_s=
erver_method&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        crypto_msg(M_FATAL, &quot;SSL_CTX_new TLS_method&quot;);</span><br=
><span>     }</span><br><span>     if (ERR_peek_error() !=3D 0)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cr=
ypto_msg(M_WARN, &quot;Warning: TLS server context initialisation &quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
   &quot;has warnings=2E&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-tls_ctx_client_new(struct tls_root_ctx *ctx)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    ASSERT(NULL !=3D ctx);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   ctx-&gt;ctx =3D SSL_CTX_new_ex(tls_libctx, NULL, SSLv23_client_method())=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (ctx-&gt;ctx =3D=3D NULL)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        crypto_msg(M_FATAL, &quot;SSL_CTX_new =
SSLv23_client_method&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (E=
RR_peek_error() !=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        crypto=
_msg(M_WARN, &quot;Warning: TLS client context initialisation &quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        crypto_msg(M_WARN,=
 &quot;Warning: TLS context initialisation &quot;</span><br><span>         =
                   &quot;has warnings=2E&quot;);</span><br><span>     }</sp=
an><br><span> }</span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>index 793a7=
0f=2E=2Ecb9c480 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_=
ssl=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><=
br><span>@@ -177,7 +177,7 @@</span><br><span>     struct gc_arena gc =3D gc=
_new();</span><br><span> </span><br><span>     struct tls_root_ctx ctx =3D =
{ 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_ctx_cli=
ent_new(&amp;ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   tls_ctx_new(&amp;ctx);</span><br><span>     tls_ctx_load_cert_file(&amp;=
ctx, unittest_cert, true);</span><br><span> </span><br><span>     openvpn_x=
509_cert_t *cert =3D NULL;</span><br><span>@@ -210,13 +210,13 @@</span><br>=
<span>     /* test loading of inlined cert and key=2E</span><br><span>     =
 * loading the key also checks that it matches the loaded certificate</span=
><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  tls_ctx_client_new(&amp;ctx);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    tls_ctx_new(&amp;ctx);</span><br><span>     tls_ctx_load_ce=
rt_file(&amp;ctx, unittest_cert, true);</span><br><span>     assert_int_equ=
al(tls_ctx_load_priv_file(&amp;ctx, unittest_key, true), 0);</span><br><spa=
n>     tls_ctx_free(&amp;ctx);</span><br><span> </span><br><span>     /* te=
st loading of cert and key from file */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    tls_ctx_client_new(&amp;ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    tls_ctx_new(&amp;ctx);</span><br><spa=
n>     tls_ctx_load_cert_file(&amp;ctx, global_state=2Ecertfile, false);</s=
pan><br><span>     assert_int_equal(tls_ctx_load_priv_file(&amp;ctx, global=
_state=2Ekeyfile, false), 0);</span><br><span>     tls_ctx_free(&amp;ctx);<=
/span><br><span>@@ -254,7 +254,7 @@</span><br><span>     string_mod(BSTR(&a=
mp;keyuri), CC_ANY, CC_BACKSLASH, &#39;/&#39;);</span><br><span> #endif /* =
_WIN32 */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    tls_ctx_client_new(&amp;ctx);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    tls_ctx_new(&amp;ctx);</span><br><span>     tls_ctx=
_load_cert_file(&amp;ctx, BSTR(&amp;certuri), false);</span><br><span>     =
assert_int_equal(tls_ctx_load_priv_file(&amp;ctx, BSTR(&amp;keyuri), false)=
, 0);</span><br><span>     tls_ctx_free(&amp;ctx);</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1728?usp=3Demail">change 1728</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1728?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1728 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--5wFa/KzmnNY=--


--===============7666236141943841169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7666236141943841169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7666236141943841169==--

