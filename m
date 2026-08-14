Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D96C5DF67
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g5cwsjp/lgzNJ2ejLAkRplkksSbsk1l+dkqOfzonCW8=; b=Zv7zLv45Y9ioksCou5NSvcigIT
	uU9XhDG51QkoZbFox2qI5kpCKG8u7hckVbZqKxmTqYQZSIRQJ6vr5jPJrXdijf0WyuWDYlurNlBkN
	OEjkv5aoW1h2U2mzMiMGLg0v4/idNCrMgQN3bSqiXRn70vsSpO+YzEE9D2BYxYF7NKi4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wupH5-0008Fi-DF;
	Fri, 14 Aug 2026 10:36:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wupGk-0008FQ-Rv
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:36:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=k20jOI11e79TMyjuFXzYvKTpfohkt3a9dfIQYvScHYk=; b=Fu8+LMC8aew3/WkluStaVButcF
 DDtQsBFbnmhvlnK6DCrQw1ecO4sTaJ4Ml5gtqoRGk9xrWrBRZ8EfR4iI32SRHRJYZjsHSDYeaUtoF
 qxMm+lZ07CLKpY/X2eHZPA793dInE0JQFWOdLG66iKHs5g5MSf3j0FC8QWpDmIwsYqWo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=k20jOI11e79TMyjuFXzYvKTpfohkt3a9dfIQYvScHYk=; b=k
 8AhzbS0BOTX8T39k9oj4ZJsatJ8u9XKPGC0pd4+0XIzZEC1+fpY5hSy4j6G63AQM8i7j15uQFZL0Y
 cQu6sbv7IYUblhok0my5HXYu2j/kyoaZvqkjWPR6t4fAtjfj8KLg5naNvbCnyZgISh6aCBgSySA25
 +/JQiGWsDl7K/+Dc=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wupGe-0001iM-4a for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:36:06 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49987fb18c0so3148885e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 03:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786703757; x=1787308557; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k20jOI11e79TMyjuFXzYvKTpfohkt3a9dfIQYvScHYk=;
 b=HRElk6q5bR8vozhEXBkx3vAYrC3KFKihqvwUyuE7E/IkMPuueV6dYNvmKKUVVLo/CI
 SInFRT+GsWhmmT1QfnoTz+XmtO6JUmGog7+eFjrGUUJxw7Agzzp6L5/iBE5E/jjvXhq0
 DK9z11cTzepeywCvMBCAVdgXBc5ynEe/C0oLvqZaW9LTBDJ0rpZkYF5qF+GH8Zx0sP2X
 n1WiAdw5lTbEcyH1+5uc+zneOPCy9UUWGJAZJgOa5NbsKiRER3I8hIEwg0cQxyo+pSaw
 KSIavE+3bTzYD3LRAJsWV7i//axHATaE46o6UjhVHgk/XfpIkpFqEdxT3EuH0gR0WoEb
 mI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786703757; x=1787308557;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=k20jOI11e79TMyjuFXzYvKTpfohkt3a9dfIQYvScHYk=;
 b=B6z2S/bgHwUGtjgZ2LQlxrlcMq+cHnIz6fNg/pxij2qRcU7uJHkDdlD7hlg/R26my7
 RvAdAMvBRFOiDvQ5qRWn4XRoLRDZZcHJslW2XUFgSZ4jGtP1l/E2NN0dYRuy+eilakw0
 AKyp3HXHr9ItOfNn2PBi7RmKuut0fcvlfWOq/mNNIvq3JfkdercHTtW7JTXUG84fuJHL
 2p7hVQYEInqoL7DkpVDWsD7BQ0ZlLpvGdjvVv3vMAidQ3H6wt6/O7aJvGNgIxNia9XVf
 /g0UwfYB/2e+rQfOCUeBbF5lXcoqRglbejxzIMI9cD4j/ojYQ81PI+h1HUkQjnYBW00t
 joPQ==
X-Gm-Message-State: AOJu0YzYaUsa2l7xd8EEIBUMjH6D9FPUG0ssCffk9kmNndBEKYrZ5aAm
 AetedFvZPs+WoErPuLsISVWuOexQzYicK3lbLxqcN0zvzFYf49VmiXDPcFn85qJHafczh877DWu
 YsSV2dIKvGGiKiuO3Ep3Ugv2ejxfqmU8u4EqiMpFswnesc3AdPu5WGJoXuCGZ6vddOL5J6qfCDI
 vvGD22lg==
X-Gm-Gg: AR+sD12NUz1guDKeAFyjezvg3QhFMQGrNdaZHHPIe6ReZhui/5SaxYoHBepqQWgB4jZ
 7wHjTekesZyx+w/0bg6jTWbrDs4gGFXLPxzURTreg1hyIgAj3gZrtgH5mm+e9NcVf14yj0P8XzQ
 yJ5MwPgQHKN7GDBHHFkVcwDtV5X121mpj8HqgQHFRuogxrGQ8xG7JPwBfYtN8is6zCHlxWPPWGw
 KWgG6Lld/EmclFbIqgwPLX8p1z4C9DwlxT2YgUOn6fMaIJJNAwNbzDXZ30hkmuNAEvxfl7nO8uv
 EQcL/Ma2ldrKQgNCE1H2WrCro+gU3drfLOP9XpjWzfLuj6WUPqYoceZ+69oPLlz+6D0TpBlepaZ
 oosdROVrjcaphkgrgop9iwr4MLQn6IiAqlQDr2YZ/v2vf7gHGP8hoQL07mueWlKOYiXB+SXMLih
 gOQ0b0F3grS/tEsE9EDLOfwNAue/7T8cBbb3Abt+AhZEIUAs4NOH4LBjJBC6kIU5BHJH3xYD5cm
 wGSMRR6CdhEstKnjF51GS9/ZcHkQzPmNQ6U7vzDAtsZr4viFL1MvU1uM3GRKjorAsHKwaEeoyQs
 xJnHmvwJG87SUGWCXq4/gZVF/Ursar6fiUz8CVvO8DwsqvRVePCMzuU3wu7qCA==
X-Received: by 2002:a05:600c:1f91:b0:497:fecd:5b00 with SMTP id
 5b1f17b1804b1-4998797c6dbmr57978805e9.9.1786703757282; 
 Fri, 14 Aug 2026 03:35:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2c129dsm7083470f8f.26.2026.08.14.03.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 03:35:56 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 10:35:48 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
X-Gerrit-Change-Number: 1610
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1610?usp=email>
X-Gerrit-Commit: f5ea903b6ec7feb54b9854e2b709a545da23d570
In-Reply-To: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
References: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MzQzNzQ2MDAwLkk4MmE0ZTgyZmY4NzZmYWI3MTVlMDUyZGUxOTAzYzY1YjgzNTM2MGI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a6798cdd876d426f8ec6d94a962e7a7805966c8b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wupGe-0001iM-4a
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
Content-Type: multipart/mixed; boundary="===============0462169266728002089=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0462169266728002089==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aNublEUi6to="; charset=UTF-8

--aNublEUi6to=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

He=
llo plaisthos, stipa, 

I'd like you to reexamine a change=2E Please visit
=

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail

to look at=
 the new patch set (#13)=2E

The following approvals got outdated and were =
removed:
Code-Review+1 by plaisthos, Code-Review-1 by stipa


Change subjec=
t: Remove various unused functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Remove various unused functions

Change-Id: I82a4e82=
ff876fab715e052de1903c65b835360b5
Signed-off-by: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
---
M src/openvpn/buffer=2Eh
M src/openvpn/crypto_backend=
=2Eh
M src/openvpn/crypto_mbedtls=2Ec
M src/openvpn/crypto_mbedtls_legacy=
=2Ec
M src/openvpn/crypto_openssl=2Ec
M src/openvpn/dco_win=2Eh
M src/openv=
pn/env_set=2Ec
M src/openvpn/env_set=2Eh
M src/openvpn/event=2Eh
M src/open=
vpn/interval=2Eh
M src/openvpn/manage=2Eh
M src/openvpn/mroute=2Eh
M src/op=
envpn/multi_io=2Ec
M src/openvpn/openvpn=2Ec
M src/openvpn/plugin=2Ec
M src=
/openvpn/plugin=2Eh
M src/openvpn/route=2Ec
M src/openvpn/route=2Eh
18 file=
s changed, 0 insertions(+), 254 deletions(-)


  git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/10/1610/13

diff --git a/src/openvpn=
/buffer=2Eh b/src/openvpn/buffer=2Eh
index 74c84b2=2E=2E37cec28 100644
--- =
a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -1848,17 +1848,6 @=
@
 void x_gc_freespecial(struct gc_arena *a);
 
 /**
- * Return true iff th=
e arena contains at least one allocation=2E
- *
- * @param a  The arena to =
test=2E
- */
-static inline bool
-gc_defined(struct gc_arena *a)
-{
-    re=
turn a->list !=3D NULL;
-}
-
-/**
  * Initialise a garbage collection arena=
 to an empty state=2E
  *
  * @param a  The arena to initialise=2E
diff --g=
it a/src/openvpn/crypto_backend=2Eh b/src/openvpn/crypto_backend=2Eh
index =
17085d6=2E=2Eb7f820d 100644
--- a/src/openvpn/crypto_backend=2Eh
+++ b/src/=
openvpn/crypto_backend=2Eh
@@ -569,15 +569,6 @@
 void md_ctx_cleanup(md_ctx=
_t *ctx);
 
 /*
- * Returns the size of the message digest output by the gi=
ven context
- *
- * @param ctx           Message digest context=2E
- *
- * =
@return              Size of the message digest, or \0 if ctx is NULL=2E
- =
*/
-int md_ctx_size(const md_ctx_t *ctx);
-
-/*
  * Process the given data =
for use in the message digest=2E
  *
  * @param ctx           Message diges=
t context=2E May not be NULL=2E
diff --git a/src/openvpn/crypto_mbedtls=2Ec=
 b/src/openvpn/crypto_mbedtls=2Ec
index 6662def=2E=2E665257c0 100644
--- a/=
src/openvpn/crypto_mbedtls=2Ec
+++ b/src/openvpn/crypto_mbedtls=2Ec
@@ -718=
,16 +718,6 @@
     ASSERT(psa_hash_abort(&ctx->operation) =3D=3D PSA_SUCCES=
S);
 }
 
-int
-md_ctx_size(const md_ctx_t *ctx)
-{
-    if (ctx =3D=3D NULL=
)
-    {
-        return 0;
-    }
-    return (int)PSA_HASH_LENGTH(ctx->md=
_info->psa_alg);
-}
-
 void
 md_ctx_update(md_ctx_t *ctx, const uint8_t *sr=
c, size_t src_len)
 {
diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/=
src/openvpn/crypto_mbedtls_legacy=2Ec
index 9e47c26=2E=2E8b187bf 100644
---=
 a/src/openvpn/crypto_mbedtls_legacy=2Ec
+++ b/src/openvpn/crypto_mbedtls_l=
egacy=2Ec
@@ -848,16 +848,6 @@
     mbedtls_md_free(ctx);
 }
 
-int
-md_ctx=
_size(const mbedtls_md_context_t *ctx)
-{
-    if (NULL =3D=3D ctx)
-    {
=
-        return 0;
-    }
-    return (int)mbedtls_md_get_size(mbedtls_md_i=
nfo_from_ctx(ctx));
-}
-
 void
 md_ctx_update(mbedtls_md_context_t *ctx, co=
nst uint8_t *src, size_t src_len)
 {
diff --git a/src/openvpn/crypto_openss=
l=2Ec b/src/openvpn/crypto_openssl=2Ec
index 2019280=2E=2E0be87e4 100644
--=
- a/src/openvpn/crypto_openssl=2Ec
+++ b/src/openvpn/crypto_openssl=2Ec
@@ =
-1108,12 +1108,6 @@
     EVP_MD_CTX_reset(ctx);
 }
 
-int
-md_ctx_size(cons=
t EVP_MD_CTX *ctx)
-{
-    return (int)EVP_MD_CTX_size(ctx);
-}
-
 void
 md=
_ctx_update(EVP_MD_CTX *ctx, const uint8_t *src, size_t src_len)
 {
diff --=
git a/src/openvpn/dco_win=2Eh b/src/openvpn/dco_win=2Eh
index ac3ce33=2E=2E=
a92e5ad 100644
--- a/src/openvpn/dco_win=2Eh
+++ b/src/openvpn/dco_win=2Eh
=
@@ -65,8 +65,6 @@
 void dco_p2p_new_peer(HANDLE handle, OVERLAPPED *ov, str=
uct link_socket *sock,
                       struct signal_info *sig_info)=
;
 
-void dco_start_tun(struct tuntap *tt);
-
 bool dco_win_supports_multip=
eer(void);
 
 void dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t ds=
t, unsigned int netbits,
@@ -79,13 +77,5 @@
 
 void dco_win_del_iroute_ipv6=
(dco_context_t *dco, struct in6_addr dst, unsigned int netbits);
 
-#else  =
/* if defined(ENABLE_DCO) && defined(_WIN32) */
-
-static inline void
-dco_=
start_tun(struct tuntap *tt)
-{
-    ASSERT(false);
-}
-
 #endif /* defined=
(_WIN32) */
 #endif /* ifndef DCO_H */
diff --git a/src/openvpn/env_set=2Ec=
 b/src/openvpn/env_set=2Ec
index d992097=2E=2Ee147913 100644
--- a/src/open=
vpn/env_set=2Ec
+++ b/src/openvpn/env_set=2Ec
@@ -209,32 +209,6 @@
 }
 
 vo=
id
-env_set_print(msglvl_t msglevel, const struct env_set *es)
-{
-    if (=
check_debug_level(msglevel))
-    {
-        const struct env_item *e;
-   =
     int i;
-
-        if (es)
-        {
-            e =3D es->list;
-   =
         i =3D 0;
-
-            while (e)
-            {
-                =
if (env_safe_to_print(e->string))
-                {
-                    m=
sg(msglevel, "ENV [%d] '%s'", i, e->string);
-                }
-          =
      ++i;
-                e =3D e->next;
-            }
-        }
-    }=

-}
-
-void
 env_set_write_file(const char *path, const struct env_set *es)=

 {
     FILE *fp =3D platform_fopen(path, "w");
@@ -411,15 +385,6 @@
 }
 
=
 void
-setenv_int_i(struct env_set *es, const char *name, const int value, =
const int i)
-{
-    struct gc_arena gc =3D gc_new();
-    const char *name=
_str =3D setenv_format_indexed_name(name, i, &gc);
-    setenv_int(es, name=
_str, value);
-    gc_free(&gc);
-}
-
-void
 setenv_str_i(struct env_set *e=
s, const char *name, const char *value, const int i)
 {
     struct gc_aren=
a gc =3D gc_new();
diff --git a/src/openvpn/env_set=2Eh b/src/openvpn/env_s=
et=2Eh
index fcfc3ca=2E=2E9b4a1e7 100644
--- a/src/openvpn/env_set=2Eh
+++ =
b/src/openvpn/env_set=2Eh
@@ -69,8 +69,6 @@
  */
 void setenv_str_incr(stru=
ct env_set *es, const char *name, const char *value);
 
-void setenv_int_i(=
struct env_set *es, const char *name, const int value, const int i);
-
 voi=
d setenv_str_i(struct env_set *es, const char *name, const char *value, con=
st int i);
 
 /* struct env_set functions */
@@ -85,8 +83,6 @@
 
 const cha=
r *env_set_get(const struct env_set *es, const char *name);
 
-void env_set=
_print(msglvl_t msglevel, const struct env_set *es);
-
 /**
  * Write a str=
uct env_set to a file=2E Each item on one line=2E
  *
diff --git a/src/open=
vpn/event=2Eh b/src/openvpn/event=2Eh
index 40ed161=2E=2Eb784dfe 100644
---=
 a/src/openvpn/event=2Eh
+++ b/src/openvpn/event=2Eh
@@ -190,13 +190,6 @@
 =
    return ret;
 }
 
-static inline void
-event_set_return_init(struct even=
t_set_return *esr)
-{
-    esr->rwflags =3D 0;
-    esr->arg =3D NULL;
-}
-=

 #ifdef _WIN32
 
 static inline void
diff --git a/src/openvpn/interval=2Eh=
 b/src/openvpn/interval=2Eh
index f6d3503=2E=2E59051bd 100644
--- a/src/ope=
nvpn/interval=2Eh
+++ b/src/openvpn/interval=2Eh
@@ -255,47 +255,4 @@
  */
=
 bool event_timeout_trigger(struct event_timeout *et, struct timeval *tv, i=
nt et_const_retry);
 
-/*
- * Measure time intervals in microseconds
- */
-=

-#define USEC_TIMER_MAX 60 /* maximum interval size in seconds */
-
-#defi=
ne USEC_TIMER_MAX_USEC (USEC_TIMER_MAX * 1000000)
-
-struct usec_timer
-{
-=
    struct timeval start;
-    struct timeval end;
-};
-
-#ifdef HAVE_GETTI=
MEOFDAY
-
-static inline void
-usec_timer_start(struct usec_timer *obj)
-{
=
-    CLEAR(*obj);
-    openvpn_gettimeofday(&obj->start, NULL);
-}
-
-stati=
c inline void
-usec_timer_end(struct usec_timer *obj)
-{
-    openvpn_getti=
meofday(&obj->end, NULL);
-}
-
-#endif /* HAVE_GETTIMEOFDAY */
-
-static in=
line bool
-usec_timer_interval_defined(struct usec_timer *obj)
-{
-    retu=
rn obj->start=2Etv_sec && obj->end=2Etv_sec;
-}
-
-static inline int
-usec_=
timer_interval(struct usec_timer *obj)
-{
-    return tv_subtract(&obj->end=
, &obj->start, USEC_TIMER_MAX);
-}
-
 #endif /* INTERVAL_H */
diff --git a/=
src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
index 27d3b60=2E=2E1be3549 =
100644
--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -158,12=
 +158,6 @@
     return h->size;
 }
 
-static inline int
-log_history_capaci=
ty(const struct log_history *h)
-{
-    return h->capacity;
-}
-
 /*
  * Ca=
llbacks for 'status' and 'kill' commands=2E
  * Also for management-based d=
eferred authentication and packet filter=2E
diff --git a/src/openvpn/mroute=
=2Eh b/src/openvpn/mroute=2Eh
index 639281b=2E=2E9d61b22 100644
--- a/src/o=
penvpn/mroute=2Eh
+++ b/src/openvpn/mroute=2Eh
@@ -249,24 +249,4 @@
     de=
st->v4=2Eaddr =3D htonl(src);
 }
 
-static inline in_addr_t
-in_addr_t_from=
_mroute_addr(const struct mroute_addr *addr)
-{
-    if ((addr->type & MR_A=
DDR_MASK) =3D=3D MR_ADDR_IPV4 && addr->netbits =3D=3D 0 && addr->len =3D=3D=
 4)
-    {
-        return ntohl(addr->v4=2Eaddr);
-    }
-    else
-    {
=
-        return 0;
-    }
-}
-
-static inline void
-mroute_addr_reset(struc=
t mroute_addr *ma)
-{
-    ma->len =3D 0;
-    ma->type =3D MR_ADDR_NONE;
-=
}
-
 #endif /* MROUTE_H */
diff --git a/src/openvpn/multi_io=2Ec b/src/open=
vpn/multi_io=2Ec
index d8cc708=2E=2Ebb1fbce 100644
--- a/src/openvpn/multi_=
io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -661,12 +661,3 @@
 
     } while (=
action !=3D TA_UNDEF);
 }
-
-void
-multi_io_delete_event(struct multi_io *m=
ulti_io, event_t event)
-{
-    if (multi_io && multi_io->es)
-    {
-     =
   event_del(multi_io->es, event);
-    }
-}
diff --git a/src/openvpn/openv=
pn=2Ec b/src/openvpn/openvpn=2Ec
index f38660f=2E=2E5e1f680 100644
--- a/sr=
c/openvpn/openvpn=2Ec
+++ b/src/openvpn/openvpn=2Ec
@@ -31,7 +31,6 @@
 #inc=
lude "multi=2Eh"
 #include "win32=2Eh"
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
Gerrit-PatchSet: 13
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: st=
ipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attenti=
on: stipa <lstipakov@gmail=2Ecom>

--aNublEUi6to=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>flichtenhel=
d <strong>uploaded patch set #13</strong> to this change=2E</p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail">View Change=
</a></p><p>The following approvals got outdated and were removed:
Code-Revi=
ew+1 by plaisthos, Code-Review-1 by stipa</p><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">Remove various u=
nused functions<br><br>Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---=
<br>M src/openvpn/buffer=2Eh<br>M src/openvpn/crypto_backend=2Eh<br>M src/o=
penvpn/crypto_mbedtls=2Ec<br>M src/openvpn/crypto_mbedtls_legacy=2Ec<br>M s=
rc/openvpn/crypto_openssl=2Ec<br>M src/openvpn/dco_win=2Eh<br>M src/openvpn=
/env_set=2Ec<br>M src/openvpn/env_set=2Eh<br>M src/openvpn/event=2Eh<br>M s=
rc/openvpn/interval=2Eh<br>M src/openvpn/manage=2Eh<br>M src/openvpn/mroute=
=2Eh<br>M src/openvpn/multi_io=2Ec<br>M src/openvpn/openvpn=2Ec<br>M src/op=
envpn/plugin=2Ec<br>M src/openvpn/plugin=2Eh<br>M src/openvpn/route=2Ec<br>=
M src/openvpn/route=2Eh<br>18 files changed, 0 insertions(+), 254 deletions=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/10/1610/13</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Eh=
 b/src/openvpn/buffer=2Eh</span><br><span>index 74c84b2=2E=2E37cec28 100644=
</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/ope=
nvpn/buffer=2Eh</span><br><span>@@ -1848,17 +1848,6 @@</span><br><span> voi=
d x_gc_freespecial(struct gc_arena *a);</span><br><span> </span><br><span> =
/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Return true iff=
 the arena contains at least one allocation=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * @param a  The arena to test=2E</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-gc_=
defined(struct gc_arena *a)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return a-&=
gt;list !=3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span>  * Initialise a garbag=
e collection arena to an empty state=2E</span><br><span>  *</span><br><span=
>  * @param a  The arena to initialise=2E</span><br><span>diff --git a/src/=
openvpn/crypto_backend=2Eh b/src/openvpn/crypto_backend=2Eh</span><br><span=
>index 17085d6=2E=2Eb7f820d 100644</span><br><span>--- a/src/openvpn/crypto=
_backend=2Eh</span><br><span>+++ b/src/openvpn/crypto_backend=2Eh</span><br=
><span>@@ -569,15 +569,6 @@</span><br><span> void md_ctx_cleanup(md_ctx_t *=
ctx);</span><br><span> </span><br><span> /*</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * Returns the size of the message digest output by t=
he given context</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param ctx           =
Message digest context=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return     =
         Size of the message digest, or \0 if ctx is NULL=2E</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-int md_ctx_size(const md_ctx_t *ctx);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-/*</span><br><span>  * Process the given data for use in th=
e message digest=2E</span><br><span>  *</span><br><span>  * @param ctx     =
      Message digest context=2E May not be NULL=2E</span><br><span>diff --g=
it a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec</span>=
<br><span>index 6662def=2E=2E665257c0 100644</span><br><span>--- a/src/open=
vpn/crypto_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/crypto_mbedtls=2Ec=
</span><br><span>@@ -718,16 +718,6 @@</span><br><span>     ASSERT(psa_hash_=
abort(&amp;ctx-&gt;operation) =3D=3D PSA_SUCCESS);</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-md_ctx_size(const md_ctx_t =
*ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (ctx =3D=3D NULL)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    return (int)PSA_HASH_LENGTH(ctx-&gt;md_info-&gt;psa_alg);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> md_ctx_up=
date(md_ctx_t *ctx, const uint8_t *src, size_t src_len)</span><br><span> {<=
/span><br><span>diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/op=
envpn/crypto_mbedtls_legacy=2Ec</span><br><span>index 9e47c26=2E=2E8b187bf =
100644</span><br><span>--- a/src/openvpn/crypto_mbedtls_legacy=2Ec</span><b=
r><span>+++ b/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>@@ -848=
,16 +848,6 @@</span><br><span>     mbedtls_md_free(ctx);</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-md_ctx_size(const mbe=
dtls_md_context_t *ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (NULL =3D=
=3D ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return (int)mbedtls_md_get_size(mbedtls_md_in=
fo_from_ctx(ctx));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void<=
/span><br><span> md_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *sr=
c, size_t src_len)</span><br><span> {</span><br><span>diff --git a/src/open=
vpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec</span><br><span>ind=
ex 2019280=2E=2E0be87e4 100644</span><br><span>--- a/src/openvpn/crypto_ope=
nssl=2Ec</span><br><span>+++ b/src/openvpn/crypto_openssl=2Ec</span><br><sp=
an>@@ -1108,12 +1108,6 @@</span><br><span>     EVP_MD_CTX_reset(ctx);</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-md_ctx_s=
ize(const EVP_MD_CTX *ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (int=
)EVP_MD_CTX_size(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> v=
oid</span><br><span> md_ctx_update(EVP_MD_CTX *ctx, const uint8_t *src, siz=
e_t src_len)</span><br><span> {</span><br><span>diff --git a/src/openvpn/dc=
o_win=2Eh b/src/openvpn/dco_win=2Eh</span><br><span>index ac3ce33=2E=2Ea92e=
5ad 100644</span><br><span>--- a/src/openvpn/dco_win=2Eh</span><br><span>++=
+ b/src/openvpn/dco_win=2Eh</span><br><span>@@ -65,8 +65,6 @@</span><br><sp=
an> void dco_p2p_new_peer(HANDLE handle, OVERLAPPED *ov, struct link_socket=
 *sock,</span><br><span>                       struct signal_info *sig_info=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-v=
oid dco_start_tun(struct tuntap *tt);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span> bool dco_win_supports_multipeer(void);</s=
pan><br><span> </span><br><span> void dco_win_add_iroute_ipv4(dco_context_t=
 *dco, in_addr_t dst, unsigned int netbits,</span><br><span>@@ -79,13 +77,5=
 @@</span><br><span> </span><br><span> void dco_win_del_iroute_ipv6(dco_con=
text_t *dco, struct in6_addr dst, unsigned int netbits);</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if defined(E=
NABLE_DCO) &amp;&amp; defined(_WIN32) */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-st=
atic inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_s=
tart_tun(struct tuntap *tt)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(fal=
se);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif /* defined(_=
WIN32) */</span><br><span> #endif /* ifndef DCO_H */</span><br><span>diff -=
-git a/src/openvpn/env_set=2Ec b/src/openvpn/env_set=2Ec</span><br><span>in=
dex d992097=2E=2Ee147913 100644</span><br><span>--- a/src/openvpn/env_set=
=2Ec</span><br><span>+++ b/src/openvpn/env_set=2Ec</span><br><span>@@ -209,=
32 +209,6 @@</span><br><span> }</span><br><span> </span><br><span> void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-env_set_print(msglvl_t ms=
glevel, const struct env_set *es)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
check_debug_level(msglevel))</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c=
onst struct env_item *e;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (es)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            e =3D es-&gt;list;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            i =3D 0;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            while (e)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                if (env_safe_to_print(e-&gt;string))</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    msg(msglevel, &qu=
ot;ENV [%d] &#39;%s&#39;&quot;, i, e-&gt;string);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                ++i;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                e =3D e-&gt;next;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-void</span><br><span> env_set_write_file(c=
onst char *path, const struct env_set *es)</span><br><span> {</span><br><sp=
an>     FILE *fp =3D platform_fopen(path, &quot;w&quot;);</span><br><span>@=
@ -411,15 +385,6 @@</span><br><span> }</span><br><span> </span><br><span> v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-setenv_int_i(struc=
t env_set *es, const char *name, const int value, const int i)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    const char *name_str =3D setenv_for=
mat_indexed_name(name, i, &amp;gc);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    setenv_int(es, name_str, value);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><=
br><span> setenv_str_i(struct env_set *es, const char *name, const char *va=
lue, const int i)</span><br><span> {</span><br><span>     struct gc_arena g=
c =3D gc_new();</span><br><span>diff --git a/src/openvpn/env_set=2Eh b/src/=
openvpn/env_set=2Eh</span><br><span>index fcfc3ca=2E=2E9b4a1e7 100644</span=
><br><span>--- a/src/openvpn/env_set=2Eh</span><br><span>+++ b/src/openvpn/=
env_set=2Eh</span><br><span>@@ -69,8 +69,6 @@</span><br><span>  */</span><b=
r><span> void setenv_str_incr(struct env_set *es, const char *name, const c=
har *value);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-void setenv_int_i(struct env_set *es, const char *name, const int =
value, const int i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span> void setenv_str_i(struct env_set *es, const char *name, co=
nst char *value, const int i);</span><br><span> </span><br><span> /* struct=
 env_set functions */</span><br><span>@@ -85,8 +83,6 @@</span><br><span> </=
span><br><span> const char *env_set_get(const struct env_set *es, const cha=
r *name);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-void env_set_print(msglvl_t msglevel, const struct env_set *es);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</spa=
n><br><span>  * Write a struct env_set to a file=2E Each item on one line=
=2E</span><br><span>  *</span><br><span>diff --git a/src/openvpn/event=2Eh =
b/src/openvpn/event=2Eh</span><br><span>index 40ed161=2E=2Eb784dfe 100644</=
span><br><span>--- a/src/openvpn/event=2Eh</span><br><span>+++ b/src/openvp=
n/event=2Eh</span><br><span>@@ -190,13 +190,6 @@</span><br><span>     retur=
n ret;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-static inline void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-event_set_return_init(struct event_set_return *esr)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    esr-&gt;rwflags =3D 0;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    esr-&gt;arg =3D NULL;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> #ifdef _WIN32</span><br><span> </span><=
br><span> static inline void</span><br><span>diff --git a/src/openvpn/inter=
val=2Eh b/src/openvpn/interval=2Eh</span><br><span>index f6d3503=2E=2E59051=
bd 100644</span><br><span>--- a/src/openvpn/interval=2Eh</span><br><span>++=
+ b/src/openvpn/interval=2Eh</span><br><span>@@ -255,47 +255,4 @@</span><br=
><span>  */</span><br><span> bool event_timeout_trigger(struct event_timeou=
t *et, struct timeval *tv, int et_const_retry);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * Measure time intervals in microseconds</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define USEC_TIMER_MAX 60 /* maximum interval size in seconds */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define USEC_TIMER_MAX_USEC (USEC_TIMER_MAX * 1=
000000)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-struct usec_timer</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    struct timeval start;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    struct timeval end;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_GETTIM=
EOFDAY</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-usec_timer_start(struct usec_timer *obj=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    CLEAR(*obj);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    openvpn_gettimeofday(&amp;obj-&gt;start=
, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static inline void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-usec_timer_end(struct usec_timer *obj)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    openvpn_gettimeofday(&amp;obj-&gt;end, NULL);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif /* HAVE_GETTIMEOFDAY */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inl=
ine bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-usec_timer_in=
terval_defined(struct usec_timer *obj)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return obj-&gt;start=2Etv_sec &amp;&amp; obj-&gt;end=2Etv_sec;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-static inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-use=
c_timer_interval(struct usec_timer *obj)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   return tv_subtract(&amp;obj-&gt;end, &amp;obj-&gt;start, USEC_TIMER_MAX)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif /* INTERVAL_H *=
/</span><br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=
=2Eh</span><br><span>index 27d3b60=2E=2E1be3549 100644</span><br><span>--- =
a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</span=
><br><span>@@ -158,12 +158,6 @@</span><br><span>     return h-&gt;size;</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-static inline int</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-log_history_capacity(const struct log_history *h)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return h-&gt;capacity;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> /*</span><br><span>  * Callbacks for &#39;status&#39; an=
d &#39;kill&#39; commands=2E</span><br><span>  * Also for management-based =
deferred authentication and packet filter=2E</span><br><span>diff --git a/s=
rc/openvpn/mroute=2Eh b/src/openvpn/mroute=2Eh</span><br><span>index 639281=
b=2E=2E9d61b22 100644</span><br><span>--- a/src/openvpn/mroute=2Eh</span><b=
r><span>+++ b/src/openvpn/mroute=2Eh</span><br><span>@@ -249,24 +249,4 @@</=
span><br><span>     dest-&gt;v4=2Eaddr =3D htonl(src);</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-stati=
c inline in_addr_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-in_=
addr_t_from_mroute_addr(const struct mroute_addr *addr)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if ((addr-&gt;type &amp; MR_ADDR_MASK) =3D=3D MR_ADDR_IPV=
4 &amp;&amp; addr-&gt;netbits =3D=3D 0 &amp;&amp; addr-&gt;len =3D=3D 4)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        return ntohl(addr-&gt;v4=2Eaddr)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        return 0;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-static inline void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-mroute_addr_reset(struct mroute_addr *ma)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    ma-&gt;len =3D 0;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    ma-&gt;type =3D MR_ADDR_NONE;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> #endif /* MROUTE_H */</span><br><span>diff -=
-git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>=
index d8cc708=2E=2Ebb1fbce 100644</span><br><span>--- a/src/openvpn/multi_i=
o=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -66=
1,12 +661,3 @@</span><br><span> </span><br><span>     } while (action !=3D =
TA_UNDEF);</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-multi_io_delete_event(struct m=
ulti_io *multi_io, event_t event)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
multi_io &amp;&amp; multi_io-&gt;es)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       event_del(multi_io-&gt;es, event);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span>diff --git a/src/openvpn/openvpn=2Ec b/src/openvpn/op=
envpn=2Ec</span><br><span>index f38660f=2E=2E5e1f680 100644</span><br><span=
>--- a/src/openvpn/openvpn=2Ec</span><br><span>+++ b/src/openvpn/openvpn=2E=
c</span><br><span>@@ -31,7 +31,6 @@</span><br><span> #include &quot;multi=
=2Eh&quot;</span><br><span> #include &quot;win32=2Eh&quot;</span><br><span>=
 #include &quot;platform=2Eh&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#include &quot;string=2Eh&quot;</span><br><span> </span><br><s=
pan> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span>diff=
 --git a/src/openvpn/plugin=2Ec b/src/openvpn/plugin=2Ec</span><br><span>in=
dex f8adde5=2E=2E29f9327 100644</span><br><span>--- a/src/openvpn/plugin=2E=
c</span><br><span>+++ b/src/openvpn/plugin=2Ec</span><br><span>@@ -993,24 +=
993,4 @@</span><br><span>     pr-&gt;n =3D 0;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_=
DEBUG</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-plugin_return_print(const msglvl_=
t msglevel, const char *prefix, const struct plugin_return *pr)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    int i;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    msg(msglevel, &quot;PLUGIN_RETURN_PRINT %s&quot;, prefix);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt=
; pr-&gt;n; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct openvp=
n_plugin_string_list *l =3D pr-&gt;list[i];</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        int count =3D 0;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        msg(msglevel, &quot;PLUGIN #%d (%s)&quot;, i, prefix);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        while (l)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            msg(msglevel, &quot;[%d] &#39;%s&#=
39; -&gt; &#39;%s&#39;&quot;, ++count, l-&gt;name, l-&gt;value);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            l =3D l-&gt;next;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif /* ifdef ENABLE_DEBUG */</span><br><span> #endif /* ENABLE_PLUGIN=
 */</span><br><span>diff --git a/src/openvpn/plugin=2Eh b/src/openvpn/plugi=
n=2Eh</span><br><span>index 7e9faf3=2E=2Eb5fb916 100644</span><br><span>---=
 a/src/openvpn/plugin=2Eh</span><br><span>+++ b/src/openvpn/plugin=2Eh</spa=
n><br><span>@@ -135,10 +135,6 @@</span><br><span> </span><br><span> void pl=
ugin_return_free(struct plugin_return *pr);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-void plugin_return_print(const msglvl=
_t msglevel, const char *prefix, const struct plugin_return *pr);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif</span><br><span> </span><br><span> static inl=
ine int</span><br><span> plugin_n(const struct plugin_list *pl)</span><br><=
span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><=
span>index 8ea745d=2E=2E6dbe3ec 100644</span><br><span>--- a/src/openvpn/ro=
ute=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -185=
,19 +185,6 @@</span><br><span>     dest-&gt;gc =3D a;</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-route_st=
ring(const struct route_ipv4 *r, struct gc_arena *gc)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct buffer out =3D alloc_buf_gc(256, gc);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &quot;ROUTE=
 network %s netmask %s gateway %s&quot;, print_in_addr_t(r-&gt;network, 0, =
gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               pr=
int_in_addr_t(r-&gt;netmask, 0, gc), print_in_addr_t(r-&gt;gateway, 0, gc))=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (r-&gt;flags =
&amp; RT_METRIC_DEFINED)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_p=
rintf(&amp;out, &quot; metric %d&quot;, r-&gt;metric);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    return BSTR(&amp;out);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span> static bool</span><br><span> is_route_parm_defined(cons=
t char *parm)</span><br><span> {</span><br><span>@@ -1325,27 +1312,6 @@</sp=
an><br><span> #endif /* ifndef ENABLE_SMALL */</span><br><span> </span><br>=
<span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pri=
nt_route(const struct route_ipv4 *r, msglvl_t msglevel)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (r-&gt;flags &amp; RT_DEFINED)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;%s&quot;, route_st=
ring(r, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pr=
int_routes(const struct route_list *rl, msglvl_t msglevel)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct route_ipv4 *r;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    for (r =3D rl-&gt;routes; r; r =3D r-&gt;next)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        print_route(r, msglevel);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static vo=
id</span><br><span> setenv_route(struct env_set *es, const struct route_ipv=
4 *r, int i)</span><br><span> {</span><br><span>     struct gc_arena gc =3D=
 gc_new();</span><br><span>diff --git a/src/openvpn/route=2Eh b/src/openvpn=
/route=2Eh</span><br><span>index 88107e9=2E=2E0d33d36 100644</span><br><spa=
n>--- a/src/openvpn/route=2Eh</span><br><span>+++ b/src/openvpn/route=2Eh</=
span><br><span>@@ -377,8 +377,6 @@</span><br><span> </span><br><span> #endi=
f</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-vo=
id print_routes(const struct route_list *rl, msglvl_t msglevel);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef _WIN32<=
/span><br><span> </span><br><span> void show_routes(msglvl_t msglevel);</sp=
an><br><span>@@ -409,19 +407,6 @@</span><br><span>     return mask;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-route_list_vpn_gateway_needed(const struct route_list *rl)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (!rl)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        return !(rl-&gt;spec=2Eflags &amp; RTSA_=
REMOTE_ENDPOINT);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static inline int</spa=
n><br><span> route_did_redirect_default_gateway(const struct route_list *rl=
)</span><br><span> {</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail">change =
1610</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I82a4e82ff876fab715e052de1903c65b835360b5 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1610 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lsti=
pakov@gmail=2Ecom&gt; </div>

</body></html>
--aNublEUi6to=--


--===============0462169266728002089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0462169266728002089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0462169266728002089==--

