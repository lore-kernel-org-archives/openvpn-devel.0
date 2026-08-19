Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613CEC5DF81
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9lF4S6JgptTHW8R2TjJmrLmRvlG3ppF4PFcWIcYdfeo=; b=TkZc5jVmJtKrjQk4zflFMz12aY
	w9mLJAAwyKacqnKO6ybQW0jLjow5sUiawwfbAhbsv/0Z01XLZFJpdB8IC61JGOuIfID7wwthJhaQP
	+sIHeF+Rx9Mdm75gLCvWLIC2Vbf/UwXMtT0Z6XVBg5Zz/77dASxZbLo3aq7ch/7h4dS8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwiCW-0007hp-R0;
	Wed, 19 Aug 2026 15:27:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwiCU-0007hi-W4
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:27:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=5sfaHNjFuMTinMOjm0sjxB+Lk0LuT95ZsxlL0KcxK/k=; b=SwKOOskvdlIjk0mObX5vSe1pWt
 klMvo6rIBxwmCe5G9cCJtXTp9gVEgRu3TB9TVRe8QAGDFssfYrlYxls1PiwOX4Tz/Bk9Qv1j7Od9A
 okmmlT1WX3DQFeYLowZ6z54YDiQoDMTLE99nF0ly0eJmaGDb7mCKbWV0Xe8gRrD94cHY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5sfaHNjFuMTinMOjm0sjxB+Lk0LuT95ZsxlL0KcxK/k=; b=B
 wMQY1ytWyzAxIrtdUCoaoo/YQ6QlIeY8N/IVJWDbFinJWZe4l3NrOEmKA5u/eCU3INy67+abbC9Tm
 ojx7zQNj0mUkAZd4Z25XZT3vdrxLXMReKRbUn/oijvnLcxKrT6j979yDALUkMyYBM1s6xXpM9ePEE
 jYIi5utDGKggXxpQ=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwiCP-00072p-Fj for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:27:32 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4998590d392so10928885e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 08:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787153243; x=1787758043; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5sfaHNjFuMTinMOjm0sjxB+Lk0LuT95ZsxlL0KcxK/k=;
 b=bz/JaoYov+JpucFrdugawemz87I4HwJAJnpd/5tJuYpjlw5QaT8StcAjdkx2WQXlov
 BfmI4mO2n/nU9bFN5BQpj8wVUj3iUgSW7wLm8/yqdcUvvg8Y/cCO/e4nq4TVpHMEVeCd
 ChHwFg70DGOGz/gO3iupwTb90JOTEACrlWQprcbmKMvMj68/bmG0NFYCoSwIqe8t3sw7
 XwQ6V9syEWtMDQFiSzopDqErvyCRf1FbnrxRskpTO7HLqNibShWu5bliTAO7/RrgstVK
 eXUGdGFI8yrSjhr+KSo5xeAXpzaDbnZZdSlteWTYIAJ8W8jxlbZFULAiRUhqxVzd3flz
 p6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787153243; x=1787758043;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5sfaHNjFuMTinMOjm0sjxB+Lk0LuT95ZsxlL0KcxK/k=;
 b=dsDoGnYCrptGeiOwr1/Xj5rYj0bgNUrOraUBzQXAnL57yxuZ10k7n4qsg4jZUjDYSB
 g8p1DfqI9/1x5VL99QMfLmX7zR5dX0/Ml3Wv1mTOu+rEn2yHtRKNgRPHCgVIFFD/hRKa
 pMCyZz4ABDfSoJG67bhQTVxWm/s8itjMFHQyTE2mXalUCYh++YWcd/iIu1/2Cdm0sGmu
 4GVVDSDxotsqxkkzoQtORvl2HerV3z0HKcTZ3hnKcfX4K5OoXxzDtWklFUjqZ4xVi4aK
 HGSeWreGImaMT1Ch2Nh1+v65TgtjaOIJwtTGRlyn0kBtlx+nATgTc33/ihUTO9vadoJ8
 tK0A==
X-Gm-Message-State: AOJu0YzeXa+wcQ+5urw09QD36E0GDqSOhO3PpbxtpGR+IKwTPCKEBDdG
 jPVek/i/acwnbSyRwuAMBetQus6YWG8CqU/9u6y1EM+SWGTj+YjouddD2P4xYwdgD0zt9F/arEP
 vTuWSae4MFbs2zpo8yq+Ya9RYeJ5TwPSPxdhrJNRNtZdOorGR7NVB7YM2fMTNqVo1UNLc
X-Gm-Gg: AR+sD10mZ1nX54NcegoUCaN3fW5clFNSBlyGs5bSNS5diy4pDdEhxWBjVB4HOiP/1ru
 Gw4hsqpw83z019QKtywTw3gAu0gmm/Kgqpotei0+YhRqKhKrzkW+znq0TDOu+YTj0E2Z/NzzZkK
 q8HDw0a+4iN8Bp2mwQO6TIkSkhJAYdyFvmQBWKbMZLYO94fcbQAtS2UCtFiazPbe0XmxARRw2tE
 jn0QMjJe+jIURAN6pNDuHC9ZNzA20+1aXugIhanMrs3Y0LJYvUY1Nu2aiTcMT8Dt2PcXQe0u8cM
 P5zECt28Rgfus6snTE8XqJ43WY2P7LdiOqA44fRzV+UYtJ1y6lkROm4n78qlL5MKt22c1x63/Pk
 FN7Oq1WWfdCyqhMMWpafvjx2x4/oeSnRIIMg6ZPpj4rhrMyrhZTC0dX/JzFHOhPdzZWpnomp2ch
 n0Rt1UPOWgHOZt0C0nbKT0DmvY3D4DIf8OCs5waiT5kHC+ifTZNnI31JCAyC/w2hTh4NK9K26Rp
 GCTq5JcztoQYF4hvfc2PHrNWAHMsPVOQygRKOD3MKYPD2cGP1TWCUlJ0pBYJ27/PMNWZwdnlbuJ
 OmXdCq73wUM0GPJebPhpR/DvZ5odn3ZVPKkzg8jt4LpQyx0lQoo=
X-Received: by 2002:a05:600c:19ce:b0:499:a277:e8b5 with SMTP id
 5b1f17b1804b1-499aa1896e6mr94866155e9.3.1787153242602; 
 Wed, 19 Aug 2026 08:27:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa11fd3asm62042105e9.8.2026.08.19.08.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:27:22 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 15:27:14 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
X-Gerrit-Change-Number: 1610
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1610?usp=email>
X-Gerrit-Commit: 871b80b3d7079145d0bb580e6601b4e6791ac753
In-Reply-To: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
References: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MzQzNzQ2MDAwLkk4MmE0ZTgyZmY4NzZmYWI3MTVlMDUyZGUxOTAzYzY1YjgzNTM2MGI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8e60335069e926468f35616c088a124f8b813f96-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwiCP-00072p-Fj
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove various
 unused functions
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1362138092814430443=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1362138092814430443==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SR0kq4STsgc="; charset=UTF-8

--SR0kq4STsgc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

Hello plaisthos,=
 stipa, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail

to look at the new patch=
 set (#14)=2E


Change subject: Remove various unused functions
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove various unused =
functions

Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
Signed-off-=
by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/buffer=2E=
h
M src/openvpn/crypto_backend=2Eh
M src/openvpn/crypto_mbedtls=2Ec
M src/o=
penvpn/crypto_mbedtls_legacy=2Ec
M src/openvpn/crypto_openssl=2Ec
M src/ope=
nvpn/dco_win=2Eh
M src/openvpn/env_set=2Ec
M src/openvpn/env_set=2Eh
M src/=
openvpn/event=2Eh
M src/openvpn/interval=2Eh
M src/openvpn/manage=2Eh
M src=
/openvpn/mroute=2Eh
M src/openvpn/multi_io=2Ec
M src/openvpn/multi_io=2Eh
M=
 src/openvpn/openvpn=2Ec
M src/openvpn/plugin=2Ec
M src/openvpn/plugin=2Eh
=
M src/openvpn/route=2Ec
M src/openvpn/route=2Eh
19 files changed, 0 inserti=
ons(+), 256 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/10/1610/14

diff --git a/src/openvpn/buffer=2Eh b/src/op=
envpn/buffer=2Eh
index 85277ff=2E=2E47c9420 100644
--- a/src/openvpn/buffer=
=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -1848,17 +1848,6 @@
 void x_gc_freespe=
cial(struct gc_arena *a);
 
 /**
- * Return true iff the arena contains at =
least one allocation=2E
- *
- * @param a  The arena to test=2E
- */
-static=
 inline bool
-gc_defined(struct gc_arena *a)
-{
-    return a->list !=3D NU=
LL;
-}
-
-/**
  * Initialise a garbage collection arena to an empty state=
=2E
  *
  * @param a  The arena to initialise=2E
diff --git a/src/openvpn/c=
rypto_backend=2Eh b/src/openvpn/crypto_backend=2Eh
index 17085d6=2E=2Eb7f82=
0d 100644
--- a/src/openvpn/crypto_backend=2Eh
+++ b/src/openvpn/crypto_bac=
kend=2Eh
@@ -569,15 +569,6 @@
 void md_ctx_cleanup(md_ctx_t *ctx);
 
 /*
- =
* Returns the size of the message digest output by the given context
- *
- =
* @param ctx           Message digest context=2E
- *
- * @return           =
   Size of the message digest, or \0 if ctx is NULL=2E
- */
-int md_ctx_siz=
e(const md_ctx_t *ctx);
-
-/*
  * Process the given data for use in the mes=
sage digest=2E
  *
  * @param ctx           Message digest context=2E May n=
ot be NULL=2E
diff --git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/cry=
pto_mbedtls=2Ec
index 6662def=2E=2E665257c0 100644
--- a/src/openvpn/crypto=
_mbedtls=2Ec
+++ b/src/openvpn/crypto_mbedtls=2Ec
@@ -718,16 +718,6 @@
    =
 ASSERT(psa_hash_abort(&ctx->operation) =3D=3D PSA_SUCCESS);
 }
 
-int
-md_=
ctx_size(const md_ctx_t *ctx)
-{
-    if (ctx =3D=3D NULL)
-    {
-        =
return 0;
-    }
-    return (int)PSA_HASH_LENGTH(ctx->md_info->psa_alg);
-=
}
-
 void
 md_ctx_update(md_ctx_t *ctx, const uint8_t *src, size_t src_len)=

 {
diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/openvpn/crypto=
_mbedtls_legacy=2Ec
index 9e47c26=2E=2E8b187bf 100644
--- a/src/openvpn/cry=
pto_mbedtls_legacy=2Ec
+++ b/src/openvpn/crypto_mbedtls_legacy=2Ec
@@ -848,=
16 +848,6 @@
     mbedtls_md_free(ctx);
 }
 
-int
-md_ctx_size(const mbedtl=
s_md_context_t *ctx)
-{
-    if (NULL =3D=3D ctx)
-    {
-        return 0;=

-    }
-    return (int)mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx))=
;
-}
-
 void
 md_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src, =
size_t src_len)
 {
diff --git a/src/openvpn/crypto_openssl=2Ec b/src/openvp=
n/crypto_openssl=2Ec
index 2019280=2E=2E0be87e4 100644
--- a/src/openvpn/cr=
ypto_openssl=2Ec
+++ b/src/openvpn/crypto_openssl=2Ec
@@ -1108,12 +1108,6 @=
@
     EVP_MD_CTX_reset(ctx);
 }
 
-int
-md_ctx_size(const EVP_MD_CTX *ctx)=

-{
-    return (int)EVP_MD_CTX_size(ctx);
-}
-
 void
 md_ctx_update(EVP_MD=
_CTX *ctx, const uint8_t *src, size_t src_len)
 {
diff --git a/src/openvpn/=
dco_win=2Eh b/src/openvpn/dco_win=2Eh
index ac3ce33=2E=2Ea92e5ad 100644
---=
 a/src/openvpn/dco_win=2Eh
+++ b/src/openvpn/dco_win=2Eh
@@ -65,8 +65,6 @@
=
 void dco_p2p_new_peer(HANDLE handle, OVERLAPPED *ov, struct link_socket *s=
ock,
                       struct signal_info *sig_info);
 
-void dco_star=
t_tun(struct tuntap *tt);
-
 bool dco_win_supports_multipeer(void);
 
 void=
 dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int ne=
tbits,
@@ -79,13 +77,5 @@
 
 void dco_win_del_iroute_ipv6(dco_context_t *dc=
o, struct in6_addr dst, unsigned int netbits);
 
-#else  /* if defined(ENAB=
LE_DCO) && defined(_WIN32) */
-
-static inline void
-dco_start_tun(struct t=
untap *tt)
-{
-    ASSERT(false);
-}
-
 #endif /* defined(_WIN32) */
 #endi=
f /* ifndef DCO_H */
diff --git a/src/openvpn/env_set=2Ec b/src/openvpn/env=
_set=2Ec
index d992097=2E=2Ee147913 100644
--- a/src/openvpn/env_set=2Ec
++=
+ b/src/openvpn/env_set=2Ec
@@ -209,32 +209,6 @@
 }
 
 void
-env_set_print(=
msglvl_t msglevel, const struct env_set *es)
-{
-    if (check_debug_level(=
msglevel))
-    {
-        const struct env_item *e;
-        int i;
-
-   =
     if (es)
-        {
-            e =3D es->list;
-            i =3D 0;
=
-
-            while (e)
-            {
-                if (env_safe_to_pr=
int(e->string))
-                {
-                    msg(msglevel, "ENV =
[%d] '%s'", i, e->string);
-                }
-                ++i;
-      =
          e =3D e->next;
-            }
-        }
-    }
-}
-
-void
 env_s=
et_write_file(const char *path, const struct env_set *es)
 {
     FILE *fp =
=3D platform_fopen(path, "w");
@@ -411,15 +385,6 @@
 }
 
 void
-setenv_int_=
i(struct env_set *es, const char *name, const int value, const int i)
-{
- =
   struct gc_arena gc =3D gc_new();
-    const char *name_str =3D setenv_fo=
rmat_indexed_name(name, i, &gc);
-    setenv_int(es, name_str, value);
-   =
 gc_free(&gc);
-}
-
-void
 setenv_str_i(struct env_set *es, const char *nam=
e, const char *value, const int i)
 {
     struct gc_arena gc =3D gc_new();=

diff --git a/src/openvpn/env_set=2Eh b/src/openvpn/env_set=2Eh
index fcfc3=
ca=2E=2E9b4a1e7 100644
--- a/src/openvpn/env_set=2Eh
+++ b/src/openvpn/env_=
set=2Eh
@@ -69,8 +69,6 @@
  */
 void setenv_str_incr(struct env_set *es, co=
nst char *name, const char *value);
 
-void setenv_int_i(struct env_set *es=
, const char *name, const int value, const int i);
-
 void setenv_str_i(str=
uct env_set *es, const char *name, const char *value, const int i);
 
 /* s=
truct env_set functions */
@@ -85,8 +83,6 @@
 
 const char *env_set_get(con=
st struct env_set *es, const char *name);
 
-void env_set_print(msglvl_t ms=
glevel, const struct env_set *es);
-
 /**
  * Write a struct env_set to a f=
ile=2E Each item on one line=2E
  *
diff --git a/src/openvpn/event=2Eh b/sr=
c/openvpn/event=2Eh
index 40ed161=2E=2Eb784dfe 100644
--- a/src/openvpn/eve=
nt=2Eh
+++ b/src/openvpn/event=2Eh
@@ -190,13 +190,6 @@
     return ret;
 }=

 
-static inline void
-event_set_return_init(struct event_set_return *esr)=

-{
-    esr->rwflags =3D 0;
-    esr->arg =3D NULL;
-}
-
 #ifdef _WIN32
 
=
 static inline void
diff --git a/src/openvpn/interval=2Eh b/src/openvpn/int=
erval=2Eh
index f6d3503=2E=2E59051bd 100644
--- a/src/openvpn/interval=2Eh
=
+++ b/src/openvpn/interval=2Eh
@@ -255,47 +255,4 @@
  */
 bool event_timeou=
t_trigger(struct event_timeout *et, struct timeval *tv, int et_const_retry)=
;
 
-/*
- * Measure time intervals in microseconds
- */
-
-#define USEC_TIM=
ER_MAX 60 /* maximum interval size in seconds */
-
-#define USEC_TIMER_MAX_=
USEC (USEC_TIMER_MAX * 1000000)
-
-struct usec_timer
-{
-    struct timeval=
 start;
-    struct timeval end;
-};
-
-#ifdef HAVE_GETTIMEOFDAY
-
-static =
inline void
-usec_timer_start(struct usec_timer *obj)
-{
-    CLEAR(*obj);
=
-    openvpn_gettimeofday(&obj->start, NULL);
-}
-
-static inline void
-use=
c_timer_end(struct usec_timer *obj)
-{
-    openvpn_gettimeofday(&obj->end,=
 NULL);
-}
-
-#endif /* HAVE_GETTIMEOFDAY */
-
-static inline bool
-usec_ti=
mer_interval_defined(struct usec_timer *obj)
-{
-    return obj->start=2Etv=
_sec && obj->end=2Etv_sec;
-}
-
-static inline int
-usec_timer_interval(str=
uct usec_timer *obj)
-{
-    return tv_subtract(&obj->end, &obj->start, USE=
C_TIMER_MAX);
-}
-
 #endif /* INTERVAL_H */
diff --git a/src/openvpn/manage=
=2Eh b/src/openvpn/manage=2Eh
index 27d3b60=2E=2E1be3549 100644
--- a/src/o=
penvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -158,12 +158,6 @@
     re=
turn h->size;
 }
 
-static inline int
-log_history_capacity(const struct lo=
g_history *h)
-{
-    return h->capacity;
-}
-
 /*
  * Callbacks for 'statu=
s' and 'kill' commands=2E
  * Also for management-based deferred authentica=
tion and packet filter=2E
diff --git a/src/openvpn/mroute=2Eh b/src/openvpn=
/mroute=2Eh
index 639281b=2E=2E9d61b22 100644
--- a/src/openvpn/mroute=2Eh
=
+++ b/src/openvpn/mroute=2Eh
@@ -249,24 +249,4 @@
     dest->v4=2Eaddr =3D =
htonl(src);
 }
 
-static inline in_addr_t
-in_addr_t_from_mroute_addr(const=
 struct mroute_addr *addr)
-{
-    if ((addr->type & MR_ADDR_MASK) =3D=3D M=
R_ADDR_IPV4 && addr->netbits =3D=3D 0 && addr->len =3D=3D 4)
-    {
-      =
  return ntohl(addr->v4=2Eaddr);
-    }
-    else
-    {
-        return 0;=

-    }
-}
-
-static inline void
-mroute_addr_reset(struct mroute_addr *ma)=

-{
-    ma->len =3D 0;
-    ma->type =3D MR_ADDR_NONE;
-}
-
 #endif /* MRO=
UTE_H */
diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
i=
ndex d8cc708=2E=2Ebb1fbce 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/o=
penvpn/multi_io=2Ec
@@ -661,12 +661,3 @@
 
     } while (action !=3D TA_UND=
EF);
 }
-
-void
-multi_io_delete_event(struct multi_io *multi_io, event_t e=
vent)
-{
-    if (multi_io && multi_io->es)
-    {
-        event_del(multi=
_io->es, event);
-    }
-}
diff --git a/src/openvpn/multi_io=2Eh b/src/open=
vpn/multi_io=2Eh
index d6734bd=2E=2E38825ab 100644
--- a/src/openvpn/multi_=
io=2Eh
+++ b/src/openvpn/multi_io=2Eh
@@ -72,6 +72,4 @@
 
 void multi_io_ac=
tion(struct multi_context *m, struct multi_instance *mi, int action, bool p=
oll);
 
-void multi_io_delete_event(struct multi_io *multi_io, event_t even=
t);
-
 #endif /* ifndef MULTI_IO_H */
diff --git a/src/openvpn/openvpn=2Ec =
b/src/openvpn/openvpn=2Ec
index 7d35195=2E=2E24d6bb6 100644
--- a/src/openv=
pn/openvpn=2Ec
+++ b/src/openvpn/openvpn=2Ec
@@ -32,7 +32,6 @@
 #include "w=
in32=2Eh"
 #include "options_show=2Eh"
 #include "platform=2Eh"
-#include "=
string=2Eh"
 
 #include "memdbg=2Eh"
 
diff --git a/src/openvpn/plugin=2Ec =
b/src/openvpn/plugin=2Ec
index f8adde5=2E=2E29f9327 100644
--- a/src/openvp=
n/plugin=2Ec
+++ b/src/openvpn/plugin=2Ec
@@ -993,24 +993,4 @@
     pr->n =
=3D 0;
 }
 
-#ifdef ENABLE_DEBUG
-void
-plugin_return_print(const msglvl_t =
msglevel, const char *prefix, const struct plugin_return *pr)
-{
-    int i=
;
-    msg(msglevel, "PLUGIN_RETURN_PRINT %s", prefix);
-    for (i =3D 0; =
i < pr->n; ++i)
-    {
-        struct openvpn_plugin_string_list *l =3D pr=
->list[i];
-        int count =3D 0;
-
-        msg(msglevel, "PLUGIN #%d (=
%s)", i, prefix);
-        while (l)
-        {
-            msg(msglevel, =
"[%d] '%s' -> '%s'", ++count, l->name, l->value);
-            l =3D l->nex=
t;
-        }
-    }
-}
-#endif /* ifdef ENABLE_DEBUG */
 #endif /* ENABLE_=
PLUGIN */
diff --git a/src/openvpn/plugin=2Eh b/src/openvpn/plugin=2Eh
inde=
x 7e9faf3=2E=2Eb5fb916 100644
--- a/src/openvpn/plugin=2Eh
+++ b/src/openvp=
n/plugin=2Eh
@@ -135,10 +135,6 @@
 
 void plugin_return_free(struct plugin_=
return *pr);
 
-#ifdef ENABLE_DEBUG
-void plugin_return_print(const msglvl_=
t msglevel, const char *prefix, const struct plugin_return *pr);
-
-#endif
=
 
 static inline int
 plugin_n(const struct plugin_list *pl)
diff --git a/s=
rc/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 8ea745d=2E=2E6dbe3ec 100=
644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -185,19 +185=
,6 @@
     dest->gc =3D a;
 }
 
-static const char *
-route_string(const st=
ruct route_ipv4 *r, struct gc_arena *gc)
-{
-    struct buffer out =3D allo=
c_buf_gc(256, gc);
-    buf_printf(&out, "ROUTE network %s netmask %s gatew=
ay %s", print_in_addr_t(r->network, 0, gc),
-               print_in_addr_t=
(r->netmask, 0, gc), print_in_addr_t(r->gateway, 0, gc));
-    if (r->flags=
 & RT_METRIC_DEFINED)
-    {
-        buf_printf(&out, " metric %d", r->met=
ric);
-    }
-    return BSTR(&out);
-}
-
 static bool
 is_route_parm_defin=
ed(const char *parm)
 {
@@ -1325,27 +1312,6 @@
 #endif /* ifndef ENABLE_SMA=
LL */
 
 static void
-print_route(const struct route_ipv4 *r, msglvl_t msgl=
evel)
-{
-    struct gc_arena gc =3D gc_new();
-    if (r->flags & RT_DEFIN=
ED)
-    {
-        msg(msglevel, "%s", route_string(r, &gc));
-    }
-    =
gc_free(&gc);
-}
-
-void
-print_routes(const struct route_list *rl, msglvl_=
t msglevel)
-{
-    struct route_ipv4 *r;
-    for (r =3D rl->routes; r; r =
=3D r->next)
-    {
-        print_route(r, msglevel);
-    }
-}
-
-static =
void
 setenv_route(struct env_set *es, const struct route_ipv4 *r, int i)
 =
{
     struct gc_arena gc =3D gc_new();
diff --git a/src/openvpn/route=2Eh =
b/src/openvpn/route=2Eh
index 88107e9=2E=2E0d33d36 100644
--- a/src/openvpn=
/route=2Eh
+++ b/src/openvpn/route=2Eh
@@ -377,8 +377,6 @@
 
 #endif
 
-voi=
d print_routes(const struct route_list *rl, msglvl_t msglevel);
-
 #ifdef _=
WIN32
 
 void show_routes(msglvl_t msglevel);
@@ -409,19 +407,6 @@
     ret=
urn mask;
 }
 
-static inline bool
-route_list_vpn_gateway_needed(const str=
uct route_list *rl)
-{
-    if (!rl)
-    {
-        return false;
-    }
-=
    else
-    {
-        return !(rl->spec=2Eflags & RTSA_REMOTE_ENDPOINT);=

-    }
-}
-
 static inline int
 route_did_redirect_default_gateway(const s=
truct route_list *rl)
 {

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1610?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: I82a4e82ff876fab715e052de1903c65b835360b5
Gerrit-Change-Number: 161=
0
Gerrit-PatchSet: 14
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: st=
ipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--SR0kq4STsgc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>flichtenheld <strong>uplo=
aded patch set #14</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail">View Change</a></p><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Remove various unused functions<br><br>Change-Id: I82a4e82ff876fab715=
e052de1903c65b835360b5<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichte=
nheld=2Ecom&gt;<br>---<br>M src/openvpn/buffer=2Eh<br>M src/openvpn/crypto_=
backend=2Eh<br>M src/openvpn/crypto_mbedtls=2Ec<br>M src/openvpn/crypto_mbe=
dtls_legacy=2Ec<br>M src/openvpn/crypto_openssl=2Ec<br>M src/openvpn/dco_wi=
n=2Eh<br>M src/openvpn/env_set=2Ec<br>M src/openvpn/env_set=2Eh<br>M src/op=
envpn/event=2Eh<br>M src/openvpn/interval=2Eh<br>M src/openvpn/manage=2Eh<b=
r>M src/openvpn/mroute=2Eh<br>M src/openvpn/multi_io=2Ec<br>M src/openvpn/m=
ulti_io=2Eh<br>M src/openvpn/openvpn=2Ec<br>M src/openvpn/plugin=2Ec<br>M s=
rc/openvpn/plugin=2Eh<br>M src/openvpn/route=2Ec<br>M src/openvpn/route=2Eh=
<br>19 files changed, 0 insertions(+), 256 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/10=
/1610/14</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=
=2Eh</span><br><span>index 85277ff=2E=2E47c9420 100644</span><br><span>--- =
a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span=
><br><span>@@ -1848,17 +1848,6 @@</span><br><span> void x_gc_freespecial(st=
ruct gc_arena *a);</span><br><span> </span><br><span> /**</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * Return true iff the arena contains a=
t least one allocation=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param a  Th=
e arena to test=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-gc_defined(struct gc_are=
na *a)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    return a-&gt;list !=3D NULL;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/**</span><br><span>  * Initialise a garbage collection arena to=
 an empty state=2E</span><br><span>  *</span><br><span>  * @param a  The ar=
ena to initialise=2E</span><br><span>diff --git a/src/openvpn/crypto_backen=
d=2Eh b/src/openvpn/crypto_backend=2Eh</span><br><span>index 17085d6=2E=2Eb=
7f820d 100644</span><br><span>--- a/src/openvpn/crypto_backend=2Eh</span><b=
r><span>+++ b/src/openvpn/crypto_backend=2Eh</span><br><span>@@ -569,15 +56=
9,6 @@</span><br><span> void md_ctx_cleanup(md_ctx_t *ctx);</span><br><span=
> </span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * Returns the size of the message digest output by the given context</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param ctx           Message digest cont=
ext=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * @return              Size of th=
e message digest, or \0 if ctx is NULL=2E</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-int md_ctx_size(const md_ctx_t *ctx);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*<=
/span><br><span>  * Process the given data for use in the message digest=2E=
</span><br><span>  *</span><br><span>  * @param ctx           Message diges=
t context=2E May not be NULL=2E</span><br><span>diff --git a/src/openvpn/cr=
ypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>index 666=
2def=2E=2E665257c0 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls=
=2Ec</span><br><span>+++ b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>@=
@ -718,16 +718,6 @@</span><br><span>     ASSERT(psa_hash_abort(&amp;ctx-&gt=
;operation) =3D=3D PSA_SUCCESS);</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-md_ctx_size(const md_ctx_t *ctx)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (ctx =3D=3D NULL)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        return 0;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return=
 (int)PSA_HASH_LENGTH(ctx-&gt;md_info-&gt;psa_alg);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> void</span><br><span> md_ctx_update(md_ctx_t =
*ctx, const uint8_t *src, size_t src_len)</span><br><span> {</span><br><spa=
n>diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/openvpn/crypto_m=
bedtls_legacy=2Ec</span><br><span>index 9e47c26=2E=2E8b187bf 100644</span><=
br><span>--- a/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>+++ b/=
src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>@@ -848,16 +848,6 @@<=
/span><br><span>     mbedtls_md_free(ctx);</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-md_ctx_size(const mbedtls_md_contex=
t_t *ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (NULL =3D=3D ctx)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return (int)mbedtls_md_get_size(mbedtls_md_info_from_ctx(ct=
x));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><spa=
n> md_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src, size_t src_=
len)</span><br><span> {</span><br><span>diff --git a/src/openvpn/crypto_ope=
nssl=2Ec b/src/openvpn/crypto_openssl=2Ec</span><br><span>index 2019280=2E=
=2E0be87e4 100644</span><br><span>--- a/src/openvpn/crypto_openssl=2Ec</spa=
n><br><span>+++ b/src/openvpn/crypto_openssl=2Ec</span><br><span>@@ -1108,1=
2 +1108,6 @@</span><br><span>     EVP_MD_CTX_reset(ctx);</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-md_ctx_size(const EVP=
_MD_CTX *ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    return (int)EVP_MD_CTX_s=
ize(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br=
><span> md_ctx_update(EVP_MD_CTX *ctx, const uint8_t *src, size_t src_len)<=
/span><br><span> {</span><br><span>diff --git a/src/openvpn/dco_win=2Eh b/s=
rc/openvpn/dco_win=2Eh</span><br><span>index ac3ce33=2E=2Ea92e5ad 100644</s=
pan><br><span>--- a/src/openvpn/dco_win=2Eh</span><br><span>+++ b/src/openv=
pn/dco_win=2Eh</span><br><span>@@ -65,8 +65,6 @@</span><br><span> void dco_=
p2p_new_peer(HANDLE handle, OVERLAPPED *ov, struct link_socket *sock,</span=
><br><span>                       struct signal_info *sig_info);</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void dco_start=
_tun(struct tuntap *tt);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span> bool dco_win_supports_multipeer(void);</span><br><span=
> </span><br><span> void dco_win_add_iroute_ipv4(dco_context_t *dco, in_add=
r_t dst, unsigned int netbits,</span><br><span>@@ -79,13 +77,5 @@</span><br=
><span> </span><br><span> void dco_win_del_iroute_ipv6(dco_context_t *dco, =
struct in6_addr dst, unsigned int netbits);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#else  /* if defined(ENABLE_DCO) &a=
mp;&amp; defined(_WIN32) */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_start_tun(stru=
ct tuntap *tt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(false);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> #endif /* defined(_WIN32) */</sp=
an><br><span> #endif /* ifndef DCO_H */</span><br><span>diff --git a/src/op=
envpn/env_set=2Ec b/src/openvpn/env_set=2Ec</span><br><span>index d992097=
=2E=2Ee147913 100644</span><br><span>--- a/src/openvpn/env_set=2Ec</span><b=
r><span>+++ b/src/openvpn/env_set=2Ec</span><br><span>@@ -209,32 +209,6 @@<=
/span><br><span> }</span><br><span> </span><br><span> void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-env_set_print(msglvl_t msglevel, const=
 struct env_set *es)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (check_debug_l=
evel(msglevel))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const struct e=
nv_item *e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        in=
t i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (es)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            e =3D es-&gt;list;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            i =3D 0;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            while (e)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               if (env_safe_to_print(e-&gt;string))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    msg(msglevel, &quot;ENV [%d=
] &#39;%s&#39;&quot;, i, e-&gt;string);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                ++i;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                e =3D e-&gt;next;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-void</span><br><span> env_set_write_file(const char =
*path, const struct env_set *es)</span><br><span> {</span><br><span>     FI=
LE *fp =3D platform_fopen(path, &quot;w&quot;);</span><br><span>@@ -411,15 =
+385,6 @@</span><br><span> }</span><br><span> </span><br><span> void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-setenv_int_i(struct env_set =
*es, const char *name, const int value, const int i)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    const char *name_str =3D setenv_format_index=
ed_name(name, i, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    setenv_int(es, name_str, value);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span>=
 setenv_str_i(struct env_set *es, const char *name, const char *value, cons=
t int i)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_=
new();</span><br><span>diff --git a/src/openvpn/env_set=2Eh b/src/openvpn/e=
nv_set=2Eh</span><br><span>index fcfc3ca=2E=2E9b4a1e7 100644</span><br><spa=
n>--- a/src/openvpn/env_set=2Eh</span><br><span>+++ b/src/openvpn/env_set=
=2Eh</span><br><span>@@ -69,8 +69,6 @@</span><br><span>  */</span><br><span=
> void setenv_str_incr(struct env_set *es, const char *name, const char *va=
lue);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-void setenv_int_i(struct env_set *es, const char *name, const int value, =
const int i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> void setenv_str_i(struct env_set *es, const char *name, const cha=
r *value, const int i);</span><br><span> </span><br><span> /* struct env_se=
t functions */</span><br><span>@@ -85,8 +83,6 @@</span><br><span> </span><b=
r><span> const char *env_set_get(const struct env_set *es, const char *name=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-v=
oid env_set_print(msglvl_t msglevel, const struct env_set *es);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><=
span>  * Write a struct env_set to a file=2E Each item on one line=2E</span=
><br><span>  *</span><br><span>diff --git a/src/openvpn/event=2Eh b/src/ope=
nvpn/event=2Eh</span><br><span>index 40ed161=2E=2Eb784dfe 100644</span><br>=
<span>--- a/src/openvpn/event=2Eh</span><br><span>+++ b/src/openvpn/event=
=2Eh</span><br><span>@@ -190,13 +190,6 @@</span><br><span>     return ret;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static inline void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-event_set_return_init(struct event_set_return *esr)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    esr-&gt;rwflags =3D 0;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    esr-&gt;arg =3D NULL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> #ifdef _WIN32</span><br><span> </span><br><sp=
an> static inline void</span><br><span>diff --git a/src/openvpn/interval=2E=
h b/src/openvpn/interval=2Eh</span><br><span>index f6d3503=2E=2E59051bd 100=
644</span><br><span>--- a/src/openvpn/interval=2Eh</span><br><span>+++ b/sr=
c/openvpn/interval=2Eh</span><br><span>@@ -255,47 +255,4 @@</span><br><span=
>  */</span><br><span> bool event_timeout_trigger(struct event_timeout *et,=
 struct timeval *tv, int et_const_retry);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * Measure time intervals in microseconds</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define USEC_TIMER_MAX 60 /* maximum interval size in seconds */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define USEC_TIMER_MAX_USEC (USEC_TIMER_MAX * 1000000=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-struct usec_timer</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct timeval start;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    struct timeval end;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_GETTIMEOFD=
AY</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-usec_timer_start(struct usec_timer *obj)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    CLEAR(*obj);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    openvpn_gettimeofday(&amp;obj-&gt;start, NUL=
L);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-static inline void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-usec_timer_end(struct usec_timer *obj)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    openvpn_gettimeofday(&amp;obj-&gt;end, NULL);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif /* HAVE_GETTIMEOFDAY */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-usec_timer_inter=
val_defined(struct usec_timer *obj)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
turn obj-&gt;start=2Etv_sec &amp;&amp; obj-&gt;end=2Etv_sec;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-st=
atic inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-usec_t=
imer_interval(struct usec_timer *obj)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return tv_subtract(&amp;obj-&gt;end, &amp;obj-&gt;start, USEC_TIMER_MAX);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif /* INTERVAL_H */</=
span><br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh=
</span><br><span>index 27d3b60=2E=2E1be3549 100644</span><br><span>--- a/sr=
c/openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</span><br=
><span>@@ -158,12 +158,6 @@</span><br><span>     return h-&gt;size;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-static inline int</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-log_history_capacity(const struct log_history *h)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return h-&gt;capacity;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> /*</span><br><span>  * Callbacks for &#39;status&#39; and &#=
39;kill&#39; commands=2E</span><br><span>  * Also for management-based defe=
rred authentication and packet filter=2E</span><br><span>diff --git a/src/o=
penvpn/mroute=2Eh b/src/openvpn/mroute=2Eh</span><br><span>index 639281b=2E=
=2E9d61b22 100644</span><br><span>--- a/src/openvpn/mroute=2Eh</span><br><s=
pan>+++ b/src/openvpn/mroute=2Eh</span><br><span>@@ -249,24 +249,4 @@</span=
><br><span>     dest-&gt;v4=2Eaddr =3D htonl(src);</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static in=
line in_addr_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-in_addr=
_t_from_mroute_addr(const struct mroute_addr *addr)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if ((addr-&gt;type &amp; MR_ADDR_MASK) =3D=3D MR_ADDR_IPV4 =
&amp;&amp; addr-&gt;netbits =3D=3D 0 &amp;&amp; addr-&gt;len =3D=3D 4)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        return ntohl(addr-&gt;v4=2Eaddr);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-static inline void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-mroute_addr_reset(struct mroute_addr *ma)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    ma-&gt;len =3D 0;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    ma-&gt;type =3D MR_ADDR_NONE;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> #endif /* MROUTE_H */</span><br><span>diff --=
git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>i=
ndex d8cc708=2E=2Ebb1fbce 100644</span><br><span>--- a/src/openvpn/multi_io=
=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -661=
,12 +661,3 @@</span><br><span> </span><br><span>     } while (action !=3D T=
A_UNDEF);</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-multi_io_delete_event(struct mu=
lti_io *multi_io, event_t event)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (m=
ulti_io &amp;&amp; multi_io-&gt;es)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      event_del(multi_io-&gt;es, event);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span>diff --git a/src/openvpn/multi_io=2Eh b/src/openvpn/mu=
lti_io=2Eh</span><br><span>index d6734bd=2E=2E38825ab 100644</span><br><spa=
n>--- a/src/openvpn/multi_io=2Eh</span><br><span>+++ b/src/openvpn/multi_io=
=2Eh</span><br><span>@@ -72,6 +72,4 @@</span><br><span> </span><br><span> v=
oid multi_io_action(struct multi_context *m, struct multi_instance *mi, int=
 action, bool poll);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-void multi_io_delete_event(struct multi_io *multi_io, even=
t_t event);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> #endif /* ifndef MULTI_IO_H */</span><br><span>diff --git a/src/ope=
nvpn/openvpn=2Ec b/src/openvpn/openvpn=2Ec</span><br><span>index 7d35195=2E=
=2E24d6bb6 100644</span><br><span>--- a/src/openvpn/openvpn=2Ec</span><br><=
span>+++ b/src/openvpn/openvpn=2Ec</span><br><span>@@ -32,7 +32,6 @@</span>=
<br><span> #include &quot;win32=2Eh&quot;</span><br><span> #include &quot;o=
ptions_show=2Eh&quot;</span><br><span> #include &quot;platform=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;string=2E=
h&quot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;<=
/span><br><span> </span><br><span>diff --git a/src/openvpn/plugin=2Ec b/src=
/openvpn/plugin=2Ec</span><br><span>index f8adde5=2E=2E29f9327 100644</span=
><br><span>--- a/src/openvpn/plugin=2Ec</span><br><span>+++ b/src/openvpn/p=
lugin=2Ec</span><br><span>@@ -993,24 +993,4 @@</span><br><span>     pr-&gt;=
n =3D 0;</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-plugin_return_print(const msglvl_t msglevel, const char *prefix, const=
 struct plugin_return *pr)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(msglevel, &quot;PL=
UGIN_RETURN_PRINT %s&quot;, prefix);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    for (i =3D 0; i &lt; pr-&gt;n; ++i)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        struct openvpn_plugin_string_list *l =3D pr-&gt;li=
st[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int cou=
nt =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;PLUGI=
N #%d (%s)&quot;, i, prefix);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        while (l)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    msg(msglevel, &quot;[%d] &#39;%s&#39; -&gt; &#39;%s&#39;&quot;, ++count=
, l-&gt;name, l-&gt;value);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            l =3D l-&gt;next;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_DEBUG */</s=
pan><br><span> #endif /* ENABLE_PLUGIN */</span><br><span>diff --git a/src/=
openvpn/plugin=2Eh b/src/openvpn/plugin=2Eh</span><br><span>index 7e9faf3=
=2E=2Eb5fb916 100644</span><br><span>--- a/src/openvpn/plugin=2Eh</span><br=
><span>+++ b/src/openvpn/plugin=2Eh</span><br><span>@@ -135,10 +135,6 @@</s=
pan><br><span> </span><br><span> void plugin_return_free(struct plugin_retu=
rn *pr);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-void plugin_return_print(const msglvl_t msglevel, const char *prefix, co=
nst struct plugin_return *pr);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span=
><br><span> </span><br><span> static inline int</span><br><span> plugin_n(c=
onst struct plugin_list *pl)</span><br><span>diff --git a/src/openvpn/route=
=2Ec b/src/openvpn/route=2Ec</span><br><span>index 8ea745d=2E=2E6dbe3ec 100=
644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/o=
penvpn/route=2Ec</span><br><span>@@ -185,19 +185,6 @@</span><br><span>     =
dest-&gt;gc =3D a;</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-static const char *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-route_string(const struct route_ipv4 *r, st=
ruct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer out =
=3D alloc_buf_gc(256, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    buf_printf(&amp;out, &quot;ROUTE network %s netmask %s gateway %s&=
quot;, print_in_addr_t(r-&gt;network, 0, gc),</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-               print_in_addr_t(r-&gt;netmask, 0, gc=
), print_in_addr_t(r-&gt;gateway, 0, gc));</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (r-&gt;flags &amp; RT_METRIC_DEFINED)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot; metric %d&q=
uot;, r-&gt;metric);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return BSTR(&=
amp;out);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static bool</s=
pan><br><span> is_route_parm_defined(const char *parm)</span><br><span> {</=
span><br><span>@@ -1325,27 +1312,6 @@</span><br><span> #endif /* ifndef ENA=
BLE_SMALL */</span><br><span> </span><br><span> static void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-print_route(const struct route_ipv4 *=
r, msglvl_t msglevel)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena =
gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (r-&gt;flags &amp; RT_DEFINED)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   msg(msglevel, &quot;%s&quot;, route_string(r, &amp;gc));</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-print_routes(const struct route_list=
 *rl, msglvl_t msglevel)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct route_=
ipv4 *r;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (r =
=3D rl-&gt;routes; r; r =3D r-&gt;next)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        print_route(r, msglevel);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span> setenv_route(s=
truct env_set *es, const struct route_ipv4 *r, int i)</span><br><span> {</s=
pan><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>diff --=
git a/src/openvpn/route=2Eh b/src/openvpn/route=2Eh</span><br><span>index 8=
8107e9=2E=2E0d33d36 100644</span><br><span>--- a/src/openvpn/route=2Eh</spa=
n><br><span>+++ b/src/openvpn/route=2Eh</span><br><span>@@ -377,8 +377,6 @@=
</span><br><span> </span><br><span> #endif</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void print_routes(const struct route=
_list *rl, msglvl_t msglevel);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> #ifdef _WIN32</span><br><span> </span><br><span>=
 void show_routes(msglvl_t msglevel);</span><br><span>@@ -409,19 +407,6 @@<=
/span><br><span>     return mask;</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-route_list_vpn_gateway_needed=
(const struct route_list *rl)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!rl)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 return !(rl-&gt;spec=2Eflags &amp; RTSA_REMOTE_ENDPOINT);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> static inline int</span><br><span> route_did_redirect_de=
fault_gateway(const struct route_list *rl)</span><br><span> {</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1610?usp=3Demail">change 1610</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c6=
5b835360b5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1610 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 14 </div>
<div style=3D=
"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: s=
tipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--SR0kq4STsgc=--


--===============1362138092814430443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1362138092814430443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1362138092814430443==--

