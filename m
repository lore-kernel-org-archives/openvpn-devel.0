Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D2BC531CB
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o1y3WTzlSpvuIfuyYlfN+x/KPGqEsbnehqbS+GXKii4=; b=Rfaw5FMfegKkWqlY4dsqRp25D1
	UVdg2HwEVe/lS3TM60Kf1+BVZCMXb3sJt/qrGkIvi+p/0OfhF8nUI74HPt5fH+CZVHANL7uZrFldR
	Vjft3Hn+pcSm/CkoIqvBRdk9VjCl6Uxg9hT1yl2a+g8UMFNAG9RMEn337ed3bZycJUCo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmsAf-0004pq-8A;
	Thu, 23 Jul 2026 12:05:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmsAD-0004np-Gp
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 12:04:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=8lucAJz755XVnsIA5DUIs9bmKBGHMFWgZKgMp5nflnA=; b=DbJXyON4P0zz5bYWtw61D1p/FI
 Irt4aCvsD/J07uBt0buLKxK+/sM4X+UfJckpTOj8Av5K8x3AXqtQHnMIh7gjiEwEXv9K/20Lwcpuv
 p3rXvIzk0TBMKPRrWlXUdF1N6EcO7gVOR8kqGFvBUDc6meuGQr/FuRBBdUdFwnun4GeU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8lucAJz755XVnsIA5DUIs9bmKBGHMFWgZKgMp5nflnA=; b=b
 QZSrCHH3gwAf2Nn/L3naPeCji2vbASWhzF+XQAQZ3ye2RkvX36C5qsk4bENd++RgKH//8S65pUR8G
 6T6piAZ5WyIsk++V5+KaPwCsUzJS22vFwqGxckhB96sdNLfFZIo2WpWR0dKp+/XxSth2h7+6JkpkV
 pvwjMsocn+MWeZnw=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmsAC-0004CR-Lr for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 12:04:34 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so4287485e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 23 Jul 2026 05:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784808266; x=1785413066; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8lucAJz755XVnsIA5DUIs9bmKBGHMFWgZKgMp5nflnA=;
 b=R1a5+3mGj0KSs+NU/XZpznxG+yztmohyMgAtcxVL9KwUeJeBIbPd2GdesbvN4Kwdfa
 8Ah9Vlrs6Ckl1Xl0/cwK9NmT+/Bw/hbdN9AkCTCnYwoqhtXVm/OsIFb8s0gXl3ThOUM6
 WVlGJ0aZVIFqihlSbqIA8ICabWOZforIAJVOUsaO9mw9jfCCn00tsnwdYq71EnxDpjcx
 qPx7aH9kb7RMaqMsHg1eG1RAIgT3NeBdV3lkYSmBgnq3gzLkWkuXJ33gndYZ6gziUokW
 hzLpW30QGSsDEk2kwGkVQdI90Z0mUeEz0o21CRsUIzm3xkDAK+0+a5Dpl4vVS79cB9KR
 DmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784808266; x=1785413066;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8lucAJz755XVnsIA5DUIs9bmKBGHMFWgZKgMp5nflnA=;
 b=ZYPrFGKpEQnkG9WpiP0p1rc/LARMsoS999HX7pzqatu8IdH1zG3JR8WKKQQTYDbjMn
 Cy2bvy/tyKydp0b5HhbHBWV189o7rlc6jtJmUUvndX/8DJyn8x2MkoZ8fFETY+etYfYS
 Nu3RIzXMW20cJDJi9++y3eTIN4SjHXXT4Fo5kBCaWXRKT52ZbzX1dccrzN6+yk9z7S8g
 VRJt0CAax2Oo43DXJuSexk+lrfiBOVRiM9wQdmjTF8biXZA60pFu0jxGgH7q5nr1FS+D
 DkYbFCPbDRu+jCylYJzDywj58DvYFFP/jyZMEXbTxAU4fseDqBaGlNTDJzqxmRPZYh01
 +L0A==
X-Gm-Message-State: AOJu0YwepqOgWqxL/D6TiQ6GRsfyDY2ymB0wSfCTzS5ifNLa4oZ1Mg5e
 Mp1si/Ou1ymEcXm0GLlpzHVXZQirhM+e+J/TKQwXULRe5VptRmCjPs/XoB3Z6cESEvmUE3XhCmQ
 s6LKxuqOiWPAcqMPOPEYDN67Zp4Q8nWYkkS+WHrMxXCL8zm1zqZ0201AwoUfkobxn/RrMWdP7WE
 5AbZ7E/Q==
X-Gm-Gg: AR+sD11ERBDYEJbqweAev3LIOU/bMSxw7660BsFZoQQTiu8ubqry8lSIpPBULRB6ZT/
 1O6O5HSUgjxbX6t21mkWnm8C7O9OJ65cZ0YkaVAIY1BLeT12/2XzzlF4GKj3/xQPLJdY6UGLyzS
 soiLzMg7aD3qkqpcei4oputCN6hWfGW4iNr1f4HCbVjz53jeopB38JjFr7mE0K8izrJJkmYGbTC
 jaY6bpTDN6SjEO2C6oN9a+5ifynFZ/7qBTVKTciGGck4yc/UZCHuulFkTlUpzZQ5oJ+X2gVpk2R
 3m4uPsVMEyqI1s04v9pWGv+VTa7CblgVCFmcwWiGYijG2QIb3Q+z3B2gR8chdBDOgT9JAeumpql
 jLoAPGKy4J/r8wCTk1znsF00XgiekrB8aPZ8HJzhtADFNLbD23FBtT9Fm4LSuYvbcd55TX+RfXZ
 k/RXmkbYAHqHOn0aODyAOp4s9CHfTrEOooe34koH73bAL3Quhu8b73REyNo9AykVMYbWvI5j/Vx
 /UKzV864QRY0S7jCGrydK8AlWDokb9rTGP12M7S1wyVTUaU+oJfoSV921K0GTNWRgrs
X-Received: by 2002:a05:600c:c05a:b0:495:49da:e15a with SMTP id
 5b1f17b1804b1-49573d083c6mr33725265e9.30.1784808265840; 
 Thu, 23 Jul 2026 05:04:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956ab22e74sm128218035e9.1.2026.07.23.05.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 05:04:25 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 23 Jul 2026 12:04:23 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0
X-Gerrit-Change-Number: 1728
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1728?usp=email>
X-Gerrit-Commit: 6ad6d340bf9bd7ae183521fc973ecb115f124f03
In-Reply-To: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
References: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTQyMjY4MDAwLklhZjFmMzQ3NWU0ZjI3YTkyMGMwMjhjZDczYjFhMjQ5Nzk1MzU4M2QwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <01b5cb349d514527e1a9ab321c5057eb1e7dc4c7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmsAC-0004CR-Lr
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
Content-Type: multipart/mixed; boundary="===============5644255154921639713=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5644255154921639713==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="H12j80JyOIc="; charset=UTF-8

--H12j80JyOIc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1728?usp=3Demail

to look at the new patch set (#4=
)=2E

The following approvals got outdated and were removed:
Code-Review-1 =
by flichtenheld


Change subject: Do not differentiate TLS server and clien=
t context initialisation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

Do not differentiate TLS server and client context initialisa=
tion

OpenSSL has the quite curious way of allowing to create contexts
that=
 allow only server or only client=2E This creates extra
complications when =
we want to use both server and client SSL
objects and does not seem to have=
 any advantages=2E

We later explicitly tell OpenSSL to initialise the SSL =
objects
to be a server or client object in key_state_ssl_init via
SSL_set_a=
ccept_state or SSL_set_connect_state=2E If this is
mismatched we end up get=
ting an error from OpenSSL ("called a
function you should not call") that e=
nds up calling a function
that is not defined in that TLS_method=2E

Lookin=
g into the OpenSSL source (IMPLEMENT_tls_meth_func) the main
difference bet=
ween the methods is whether they have a proper
accept/connect or have the s=
sl_undefined_function that triggers the
"called a function you should not c=
all"=2E

Our mbed TLS code basically does give the SSL context any personal=
ity
of client or server until we are in the same area in which the OpenSSL
=
code calls SSL_set_accept_state/SSL_set_connect_sate=2E

This also modifies=
 the mbedTLS to use the decision to pick client
and server in that path as =
the OpenSSL code path=2E

Change-Id: Iaf1f3475e4f27a920c028cd73b1a249795358=
3d0
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/ssl=
=2Ec
M src/openvpn/ssl_backend=2Eh
M src/openvpn/ssl_mbedtls=2Ec
M src/open=
vpn/ssl_mbedtls=2Eh
M src/openvpn/ssl_openssl=2Ec
M tests/unit_tests/openvp=
n/test_ssl=2Ec
6 files changed, 17 insertions(+), 65 deletions(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/28/1728/4

diff=
 --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 60df7ce=2E=2E86280=
d3 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -525,18 +5=
25,11 @@
     struct tls_root_ctx *new_ctx;
     ALLOC_OBJ_CLEAR(new_ctx, s=
truct tls_root_ctx);
 
-    if (options->tls_server)
-    {
-        tls_ct=
x_server_new(new_ctx);
+    tls_ctx_new(new_ctx);
 
-        if (options->d=
h_file)
-        {
-            tls_ctx_load_dh_params(new_ctx, options->dh=
_file, options->dh_file_inline);
-        }
-    }
-    else /* if client *=
/
+    if (options->tls_server && options->dh_file)
     {
-        tls_ctx=
_client_new(new_ctx);
+        tls_ctx_load_dh_params(new_ctx, options->dh_=
file, options->dh_file_inline);
     }
 
     /* Restrict allowed certifica=
te crypto algorithms */
diff --git a/src/openvpn/ssl_backend=2Eh b/src/open=
vpn/ssl_backend=2Eh
index 816fb9c=2E=2Ea6d57f2 100644
--- a/src/openvpn/ssl=
_backend=2Eh
+++ b/src/openvpn/ssl_backend=2Eh
@@ -117,18 +117,11 @@
 int t=
ls_version_max(void);
 
 /**
- * Initialise a library-specific TLS context =
for a server=2E
+ * Initialise a library-specific TLS context=2E
  *
  * @p=
aram ctx           TLS context to initialise
  */
-void tls_ctx_server_new(=
struct tls_root_ctx *ctx);
-
-/**
- * Initialises a library-specific TLS co=
ntext for a client=2E
- *
- * @param ctx           TLS context to initialis=
e
- */
-void tls_ctx_client_new(struct tls_root_ctx *ctx);
+void tls_ctx_ne=
w(struct tls_root_ctx *ctx);
 
 /**
  * Frees the library-specific TLSv1 co=
ntext
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2E=
c
index 07caf08=2E=2E6d7ac04 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b=
/src/openvpn/ssl_mbedtls=2Ec
@@ -88,7 +88,7 @@
 }
 
 void
-tls_ctx_server_n=
ew(struct tls_root_ctx *ctx)
+tls_ctx_new(struct tls_root_ctx *ctx)
 {
    =
 ASSERT(NULL !=3D ctx);
     CLEAR(*ctx);
@@ -99,24 +99,9 @@
 
     ALLOC_O=
BJ_CLEAR(ctx->ca_chain, mbedtls_x509_crt);
 
-    ctx->endpoint =3D MBEDTLS=
_SSL_IS_SERVER;
     ctx->initialised =3D true;
 }
 
-void
-tls_ctx_client_=
new(struct tls_root_ctx *ctx)
-{
-    ASSERT(NULL !=3D ctx);
-    CLEAR(*ct=
x);
-
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    ALLOC_OBJ_CLEAR(ctx->dh=
m_ctx, mbedtls_dhm_context);
-#endif
-    ALLOC_OBJ_CLEAR(ctx->ca_chain, mb=
edtls_x509_crt);
-
-    ctx->endpoint =3D MBEDTLS_SSL_IS_CLIENT;
-    ctx->=
initialised =3D true;
-}
 
 void
 tls_ctx_free(struct tls_root_ctx *ctx)
@@=
 -1141,7 +1126,8 @@
     /* Initialise SSL config */
     ALLOC_OBJ_CLEAR(k=
s_ssl->ssl_config, mbedtls_ssl_config);
     mbedtls_ssl_config_init(ks_ssl=
->ssl_config);
-    mbedtls_ssl_config_defaults(ks_ssl->ssl_config, ssl_ctx=
->endpoint, MBEDTLS_SSL_TRANSPORT_STREAM,
+    int endpoint =3D is_server ?=
 MBEDTLS_SSL_IS_SERVER : MBEDTLS_SSL_IS_CLIENT;
+    mbedtls_ssl_config_def=
aults(ks_ssl->ssl_config, endpoint, MBEDTLS_SSL_TRANSPORT_STREAM,
         =
                        MBEDTLS_SSL_PRESET_DEFAULT);
 #ifdef MBEDTLS_DEBUG_=
C
     /* We only want to have mbed TLS generate debug level logging when w=
e would
@@ -1530,7 +1516,7 @@
     struct tls_root_ctx tls_ctx;
     const =
int *ciphers =3D mbedtls_ssl_list_ciphersuites();
 
-    tls_ctx_server_new=
(&tls_ctx);
+    tls_ctx_new(&tls_ctx);
     tls_ctx_set_cert_profile(&tls_=
ctx, tls_cert_profile);
     tls_ctx_restrict_ciphers(&tls_ctx, cipher_list=
);
 
diff --git a/src/openvpn/ssl_mbedtls=2Eh b/src/openvpn/ssl_mbedtls=2Eh=

index 6b678b2=2E=2E32d4f60 100644
--- a/src/openvpn/ssl_mbedtls=2Eh
+++ b/=
src/openvpn/ssl_mbedtls=2Eh
@@ -114,8 +114,6 @@
 {
     bool initialised; /=
**< True if the context has been initialised */
 
-    int endpoint;     /*=
*< Whether or not this is a server or a client */
-
 #if MBEDTLS_VERSION_NU=
MBER < 0x04000000
     mbedtls_dhm_context *dhm_ctx;          /**< Diffie-H=
elmann-Merkle context */
 #endif
diff --git a/src/openvpn/ssl_openssl=2Ec b=
/src/openvpn/ssl_openssl=2Ec
index ef99b22=2E=2Ec5de165 100644
--- a/src/op=
envpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -100,37 +100,19 =
@@
 }
 
 void
-tls_ctx_server_new(struct tls_root_ctx *ctx)
+tls_ctx_new(st=
ruct tls_root_ctx *ctx)
 {
     ASSERT(NULL !=3D ctx);
 
-    ctx->ctx =3D =
SSL_CTX_new_ex(tls_libctx, NULL, SSLv23_server_method());
+    ctx->ctx =3D=
 SSL_CTX_new_ex(tls_libctx, NULL, TLS_method());
 
     if (ctx->ctx =3D=3D=
 NULL)
     {
-        crypto_msg(M_FATAL, "SSL_CTX_new SSLv23_server_metho=
d");
+        crypto_msg(M_FATAL, "SSL_CTX_new TLS_method");
     }
     if=
 (ERR_peek_error() !=3D 0)
     {
-        crypto_msg(M_WARN, "Warning: TLS=
 server context initialisation "
-                           "has warnings=
=2E");
-    }
-}
-
-void
-tls_ctx_client_new(struct tls_root_ctx *ctx)
-{
-=
    ASSERT(NULL !=3D ctx);
-
-    ctx->ctx =3D SSL_CTX_new_ex(tls_libctx, N=
ULL, SSLv23_client_method());
-
-    if (ctx->ctx =3D=3D NULL)
-    {
-    =
    crypto_msg(M_FATAL, "SSL_CTX_new SSLv23_client_method");
-    }
-    if=
 (ERR_peek_error() !=3D 0)
-    {
-        crypto_msg(M_WARN, "Warning: TLS=
 client context initialisation "
+        crypto_msg(M_WARN, "Warning: TLS =
context initialisation "
                            "has warnings=2E");
  =
   }
 }
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tes=
ts/openvpn/test_ssl=2Ec
index d473d67=2E=2E54d52a0 100644
--- a/tests/unit_=
tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -=
175,7 +175,7 @@
     struct gc_arena gc =3D gc_new();
 
     struct tls_roo=
t_ctx ctx =3D { 0 };
-    tls_ctx_client_new(&ctx);
+    tls_ctx_new(&ctx);=

     tls_ctx_load_cert_file(&ctx, unittest_cert, true);
 
     openvpn_x50=
9_cert_t *cert =3D NULL;
@@ -208,13 +208,13 @@
     /* test loading of inli=
ned cert and key=2E
      * loading the key also checks that it matches the=
 loaded certificate
      */
-    tls_ctx_client_new(&ctx);
+    tls_ctx_ne=
w(&ctx);
     tls_ctx_load_cert_file(&ctx, unittest_cert, true);
     asser=
t_int_equal(tls_ctx_load_priv_file(&ctx, unittest_key, true), 0);
     tls_=
ctx_free(&ctx);
 
     /* test loading of cert and key from file */
-    tl=
s_ctx_client_new(&ctx);
+    tls_ctx_new(&ctx);
     tls_ctx_load_cert_file=
(&ctx, global_state=2Ecertfile, false);
     assert_int_equal(tls_ctx_load_=
priv_file(&ctx, global_state=2Ekeyfile, false), 0);
     tls_ctx_free(&ctx)=
;
@@ -252,7 +252,7 @@
     string_mod(BSTR(&keyuri), CC_ANY, CC_BACKSLASH, =
'/');
 #endif /* _WIN32 */
 
-    tls_ctx_client_new(&ctx);
+    tls_ctx_ne=
w(&ctx);
     tls_ctx_load_cert_file(&ctx, BSTR(&certuri), false);
     ass=
ert_int_equal(tls_ctx_load_priv_file(&ctx, BSTR(&keyuri), false), 0);
     =
tls_ctx_free(&ctx);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1728?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: Iaf1f3475e4f27a920c028cd73b1a2497953583d0
Gerrit-Change-Number: 1728
Ger=
rit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <f=
rank@lichtenheld=2Ecom>

--H12j80JyOIc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #4</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1728?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Do not differentiate TLS server and client context initialisa=
tion<br><br>OpenSSL has the quite curious way of allowing to create context=
s<br>that allow only server or only client=2E This creates extra<br>complic=
ations when we want to use both server and client SSL<br>objects and does n=
ot seem to have any advantages=2E<br><br>We later explicitly tell OpenSSL t=
o initialise the SSL objects<br>to be a server or client object in key_stat=
e_ssl_init via<br>SSL_set_accept_state or SSL_set_connect_state=2E If this =
is<br>mismatched we end up getting an error from OpenSSL (&quot;called a<br=
>function you should not call&quot;) that ends up calling a function<br>tha=
t is not defined in that TLS_method=2E<br><br>Looking into the OpenSSL sour=
ce (IMPLEMENT_tls_meth_func) the main<br>difference between the methods is =
whether they have a proper<br>accept/connect or have the ssl_undefined_func=
tion that triggers the<br>&quot;called a function you should not call&quot;=
=2E<br><br>Our mbed TLS code basically does give the SSL context any person=
ality<br>of client or server until we are in the same area in which the Ope=
nSSL<br>code calls SSL_set_accept_state/SSL_set_connect_sate=2E<br><br>This=
 also modifies the mbedTLS to use the decision to pick client<br>and server=
 in that path as the OpenSSL code path=2E<br><br>Change-Id: Iaf1f3475e4f27a=
920c028cd73b1a2497953583d0<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=
=2Eorg&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_backend=2Eh=
<br>M src/openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_mbedtls=2Eh<br>M src=
/openvpn/ssl_openssl=2Ec<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>6 fi=
les changed, 17 insertions(+), 65 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/28/1728/4</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><sp=
an>index 60df7ce=2E=2E86280d3 100644</span><br><span>--- a/src/openvpn/ssl=
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
c</span><br><span>index ef99b22=2E=2Ec5de165 100644</span><br><span>--- a/s=
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
ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>index d473d=
67=2E=2E54d52a0 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_=
ssl=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><=
br><span>@@ -175,7 +175,7 @@</span><br><span>     struct gc_arena gc =3D gc=
_new();</span><br><span> </span><br><span>     struct tls_root_ctx ctx =3D =
{ 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_ctx_cli=
ent_new(&amp;ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   tls_ctx_new(&amp;ctx);</span><br><span>     tls_ctx_load_cert_file(&amp;=
ctx, unittest_cert, true);</span><br><span> </span><br><span>     openvpn_x=
509_cert_t *cert =3D NULL;</span><br><span>@@ -208,13 +208,13 @@</span><br>=
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
/span><br><span>@@ -252,7 +252,7 @@</span><br><span>     string_mod(BSTR(&a=
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
 style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>

</body></html>
--H12j80JyOIc=--


--===============5644255154921639713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5644255154921639713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5644255154921639713==--

