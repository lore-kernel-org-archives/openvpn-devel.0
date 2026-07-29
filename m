Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4440C54FD1
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4K/qGk3z/oVChZAfzm2SAZAZzR1N8YjpGawXThq6bZw=; b=Y5ps10PeS+GRDnLiB37t1tN45a
	c8d0YAZw6fzEWvLUlgVjLKOHA/vQA/dialjt2ZCP1YjlYLqRf+1nzfBFYm5Pc86gGs2INuMYhhFdB
	OR+ahCs0jX1aq9FXmrXyhsBO547YUu4P8mVBecjOXf9TFr8u08t2eXRqML7B/KRMdZZs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp3Jq-0006Z9-FK;
	Wed, 29 Jul 2026 12:23:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wp3Jn-0006Yt-WB
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=q/ljHoZFSytNQ4Wak2ZgG1dATn0KLywudpxhbscGERM=; b=ZAWo4NyGb3jzrqBPJsl7Ayel9C
 HJR/U8f1zqYmC1ew2KNWUDffBT+zJy52r/1nKecIpUoLdV8HBpIBViNE8sEZTpXl83HRWC1kYkLnh
 EfGNd/U6Wc6jFDPaT/1JthG0rgO4oz4gHbVeVZwCMOny17nZltOaX2eVGD4VL3aXMRR8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=q/ljHoZFSytNQ4Wak2ZgG1dATn0KLywudpxhbscGERM=; b=Z
 7m6JQ5F5tZSH79rlyQIAlG6MTQ+J72DXS/abonwTYksHrCTrqSj/F6eL6hBT7RUTfzY5MmIpCnfaV
 KN2ZJZkHtoF650ocmeYGwaRQ2cA5hih6SafHF9jVS2VJ7sXObPOVf34vbTlgkkrDF9EmnXWBVW2RA
 mFUoM/u+LOH7E1sI=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp3Jl-0006OF-Sp for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:27 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so474377f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 05:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785327799; x=1785932599; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=q/ljHoZFSytNQ4Wak2ZgG1dATn0KLywudpxhbscGERM=;
 b=gRIZVSg+mgUwM4hqyB2/AkCXaM+vASULMb5bssuCkNCckSqJbGEtPCGHzhwSOR5MrI
 vyyVxoGvYqiWZNjw9htusYGlNZA0hkoqMCVSAr+/9QnUE1sTOXGXmFtt+T43EGndYXmn
 huDJYvIQfywmJboXHGE8FHLXBxUFQA3N2faYbWhc3+HVGLcsYR4qA/ORWBRh9uNNIQVr
 75+xLz9nereKRIC4YrBG1rsNq8YcUAfBSOt5HCtSJ5/20u9/8tLvGH2LyOE9X6jn9s0J
 API08zWZCDHm7WMle5kUYIMhnFCsdR16xjLQLPq7CwTxFYFPJdl4NoXuoFKqND77l7T9
 5CvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785327799; x=1785932599;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=q/ljHoZFSytNQ4Wak2ZgG1dATn0KLywudpxhbscGERM=;
 b=sqJiMgP2AUlBMZgZtZTR9amLrdSxXnGY4tNARyOv7ytwULz9nzgHelH1jCh1XErDet
 nTEeTB21utLnjrpb4ORMKuNbRYxAykLCwCf1Vsgku9jpi2ni1DSJOY7DpfCSYotGOmIn
 znMM/HEL4+nJYieK4fwZuFkadqZY+4K4JKpLZCN9FKMRoF5puwNLBWhBwfz8npx/ETa0
 VXXixNPKXIkcIfKJq8PM7WoGwMovZkS/tuNk8uRh5rhXQh+yOUE8WGTi2jDYupH7MmzO
 b/zxXz9ftX3WwqPCucBCKuGM4MhFApgTKOJQ6rYiz80VLE6QWLcVSnDRlCdpRRaBXDPG
 sNpw==
X-Gm-Message-State: AOJu0YxqrYu0FbezHv7CDlUQbl/UWcCthCWGVDbUOBtw7XcvcSfXosIm
 Gb6gtd6HGgh2OpYA1a9mbcR4RiObDwO73wA9TkwvPmdD/UNzDJuWLH4OoZYs9d5T+GZEIPXT4hs
 aJ9decliUGoUzyQHyMQ2UWQ2FSmYd2zZKkxpd3AtSNVXNLjVIMCvF4xYdk13fYHVwRoC6
X-Gm-Gg: AR+sD10e/zu8pQwe3OcbtCqKFzypWLs0sAvLSG3B91NQxwVUnuay4OWbiA4PYJjWlKq
 c1XaR5gj9sWPcfOTPIUbAnhXEL897AoE3AK1uvAL+0UoJh/wl+TWl55R65Bk8QgOgVweAsKrOZ7
 73Sn4qNWzACfnNWf8qW/23n3Lsc7Jkg6zlMwulDqnvRHq56xwHYW4j3YH6qVKRZq0X02ZdjGJWt
 Ns2VZcIhwp1VVPPc4/JqQWnL7E5gGj9llZeMzQei6tvOPR3EYYmp/X6yptwwKjVbbJVq/JX1Cg2
 whjNJfBNe01fyP9U/cozJ4mfhiQ3CO3JmqBcw2KYG8KqPgj8nroUUK4xurQamB0a7Pl46AAp3MA
 U/Yzx2mhld5Uc49aW8GJwkzUtMV9Gimc4FC+ka9lSepknj3s0VxvxI8yIrMRVvAllzxTWjp8L6S
 3W43Js5v3GYewVZ85V/JbHzBrtpT3UPMCMqa3olPdsr5bvH8K91jQ+JaJmyx/gwl0JN2HEQ5Tgt
 0vOAG0u0VJY7EGxLB8bvMf6vKHaChmvYaFyk5HxRome8+kCIWg5vkc6QFta1txVXtd+1VcfRiaE
 ZRY6J2q5buLqgzio2sDGenZ+dNMLD2xW4aait+a5YgwrLnjSDkY=
X-Received: by 2002:a05:6000:2408:b0:47f:93a1:115f with SMTP id
 ffacd0b85a97d-47fb1ec2a47mr7543915f8f.60.1785327799021; 
 Wed, 29 Jul 2026 05:23:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b19653sm7984430f8f.30.2026.07.29.05.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:23:18 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 12:22:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
X-Gerrit-Change-Number: 1749
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1749?usp=email>
X-Gerrit-Commit: 07337d595cf3d6fd11a4e40f7366effdb7b2e6a8
In-Reply-To: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
References: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk3ZDg1NDZkYTllZjA2YzIyMjZlYTc3ZTQ2MWY5NTUwZDI0ODk0YzYxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e80246bdfe3b4ea846dd9e18ca9d501da9d0490f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wp3Jl-0006OF-Sp
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Extract
 init_tls_wrap_ctx() control-channel wrap helper
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1590101494992222397=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1590101494992222397==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bbTy6OO7cXg="; charset=UTF-8

--bbTy6OO7cXg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1749?usp=3Demail

to look at the new patch set (#14)=2E
=


Change subject: oob: Extract init_tls_wrap_ctx() control-channel wrap hel=
per
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Ex=
tract init_tls_wrap_ctx() control-channel wrap helper

Factor the tls-auth/=
tls-crypt wrapping-context setup out of
do_init_crypto_tls() into a reusabl=
e init_tls_wrap_ctx() helper, and expose it
in init=2Eh together with do_in=
it_tls_wrap_key(), which now takes the connection
entry to read its keys fr=
om instead of using options=2Ece=2E Both call sites pass
&c->options=2Ece, =
so there is no behavior change=2E

This lets the client --server-probe path=
 build the same control-channel
wrapping context before a connection is est=
ablished, so the probe can be
wrapped with tls-auth/tls-crypt like any othe=
r control packet=2E

Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
S=
igned-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/init=2Ec
M=
 src/openvpn/init=2Eh
2 files changed, 83 insertions(+), 37 deletions(-)


=
  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/49/1749/=
14

diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 274c86a=
=2E=2Ee0d6a14 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
=
@@ -3077,13 +3077,13 @@
 /*
  * Initialize the tls-auth/crypt key context
 =
 */
-static void
-do_init_tls_wrap_key(struct context *c)
+void
+do_init_tl=
s_wrap_key(struct context *c, const struct connection_entry *ce)
 {
     co=
nst struct options *options =3D &c->options;
 
     /* TLS handshake authen=
tication (--tls-auth) */
-    if (options->ce=2Etls_auth_file)
+    if (ce-=
>tls_auth_file)
     {
         /* Initialize key_type for tls-auth with au=
th only */
         CLEAR(c->c1=2Eks=2Etls_auth_key_type);
@@ -3098,33 +309=
8,31 @@
         }
 
         crypto_read_openvpn_key(&c->c1=2Eks=2Etls_aut=
h_key_type, &c->c1=2Eks=2Etls_wrap_key,
-                                op=
tions->ce=2Etls_auth_file, options->ce=2Etls_auth_file_inline,
-           =
                     options->ce=2Ekey_direction, "Control Channel Authenti=
cation",
-                                "tls-auth", &c->c1=2Eks=2Eorigina=
l_wrap_keydata);
+                                ce->tls_auth_file, ce->tl=
s_auth_file_inline, ce->key_direction,
+                                "Co=
ntrol Channel Authentication", "tls-auth",
+                               =
 &c->c1=2Eks=2Eoriginal_wrap_keydata);
     }
 
     /* TLS handshake encry=
ption+authentication (--tls-crypt) */
-    if (options->ce=2Etls_crypt_file=
)
+    if (ce->tls_crypt_file)
     {
         tls_crypt_init_key(&c->c1=2E=
ks=2Etls_wrap_key, &c->c1=2Eks=2Eoriginal_wrap_keydata,
-                  =
         options->ce=2Etls_crypt_file, options->ce=2Etls_crypt_file_inline,=

-                           options->tls_server);
+                       =
    ce->tls_crypt_file, ce->tls_crypt_file_inline, options->tls_server);
  =
   }
 
     /* tls-crypt with client-specific keys (--tls-crypt-v2) */
-   =
 if (options->ce=2Etls_crypt_v2_file)
+    if (ce->tls_crypt_v2_file)
     =
{
         if (options->tls_server)
         {
             tls_crypt_v2_in=
it_server_key(&c->c1=2Eks=2Etls_crypt_v2_server_key, true,
-               =
                          options->ce=2Etls_crypt_v2_file,
-               =
                          options->ce=2Etls_crypt_v2_file_inline);
+       =
                                  ce->tls_crypt_v2_file, ce->tls_crypt_v2_f=
ile_inline);
         }
         else
         {
             tls_crypt_v2_=
init_client_key(&c->c1=2Eks=2Etls_wrap_key, &c->c1=2Eks=2Eoriginal_wrap_key=
data,
-                                         &c->c1=2Eks=2Etls_crypt_v2_=
wkc, options->ce=2Etls_crypt_v2_file,
-                                    =
     options->ce=2Etls_crypt_v2_file_inline);
+                            =
             &c->c1=2Eks=2Etls_crypt_v2_wkc, ce->tls_crypt_v2_file,
+      =
                                   ce->tls_crypt_v2_file_inline);
         =
}
         /* We have to ensure that the loaded tls-crypt key is small enou=
gh
          * to fit into the initial hard reset v3 packet */
@@ -3133,19 =
+3131,50 @@
         /* empty ACK/message id, tls-crypt, Opcode, UDP, ipv6 =
*/
         int required_size =3D 5 + wkc_len + tls_crypt_buf_overhead() + =
1 + 8 + 40;
 
-        if (required_size > c->options=2Ece=2Etls_mtu)
+    =
    if (required_size > ce->tls_mtu)
         {
             msg(M_WARN,
  =
               "ERROR: tls-crypt-v2 client key too large to work with "
   =
              "requested --max-packet-size %d, requires at least "
        =
         "--max-packet-size %d=2E Packets will ignore requested "
         =
        "maximum packet size",
-                c->options=2Ece=2Etls_mtu, =
required_size);
+                ce->tls_mtu, required_size);
         }
  =
   }
 }
 
 /*
+ * Configure a control-channel wrapping context (tls-auth/tl=
s-crypt) from a
+ * connection entry and the already-loaded tls-wrap key ma=
terial=2E Leaves the
+ * context in TLS_WRAP_NONE if neither tls-auth nor t=
ls-crypt is configured=2E
+ * tls-crypt-v2 specifics (WKc, server key) are =
handled by the caller=2E
+ */
+void
+init_tls_wrap_ctx(struct tls_wrap_ctx =
*tls_wrap, const struct connection_entry *ce, bool tls_client,
+           =
       const struct key_schedule *ks, struct packet_id_persist *pid_persist=
)
+{
+    /* TLS handshake authentication (--tls-auth) */
+    if (ce->tls_=
auth_file)
+    {
+        tls_wrap->mode =3D TLS_WRAP_AUTH;
+    }
+
+    =
/* TLS handshake encryption (--tls-crypt) */
+    if (ce->tls_crypt_file ||=
 (ce->tls_crypt_v2_file && tls_client))
+    {
+        tls_wrap->mode =3D =
TLS_WRAP_CRYPT;
+    }
+
+    if (tls_wrap->mode =3D=3D TLS_WRAP_AUTH || tl=
s_wrap->mode =3D=3D TLS_WRAP_CRYPT)
+    {
+        tls_wrap->opt=2Ekey_ctx=
_bi =3D ks->tls_wrap_key;
+        tls_wrap->opt=2Epid_persist =3D pid_pers=
ist;
+        tls_wrap->opt=2Eflags |=3D CO_PACKET_ID_LONG_FORM;
+        t=
ls_wrap->original_wrap_keydata =3D ks->original_wrap_keydata;
+    }
+}
+
+=
/*
  * Initialize the persistent component of OpenVPN's TLS mode,
  * which=
 is preserved across SIGUSR1 resets=2E
  */
@@ -3216,7 +3245,7 @@
         =
init_key_type(&c->c1=2Eks=2Ekey_type, ciphername, options->authname, true, =
warn);
 
         /* initialize tls-auth/crypt/crypt-v2 key */
-        do_=
init_tls_wrap_key(c);
+        do_init_tls_wrap_key(c, &c->options=2Ece);
 =

         /* initialise auth-token crypto support */
         if (c->option=
s=2Eauth_token_generate)
@@ -3241,7 +3270,7 @@
          * tls-auth/crypt k=
ey can be configured per connection block, therefore
          * we must re=
load it as it may have changed
          */
-        do_init_tls_wrap_key(c=
);
+        do_init_tls_wrap_key(c, &c->options=2Ece);
     }
 }
 
@@ -3420=
,25 +3449,9 @@
         to=2Eekm_size =3D 0;
     }
 
-    /* TLS handshake=
 authentication (--tls-auth) */
-    if (options->ce=2Etls_auth_file)
-    =
{
-        to=2Etls_wrap=2Emode =3D TLS_WRAP_AUTH;
-    }
-
-    /* TLS han=
dshake encryption (--tls-crypt) */
-    if (options->ce=2Etls_crypt_file ||=
 (options->ce=2Etls_crypt_v2_file && options->tls_client))
-    {
-        =
to=2Etls_wrap=2Emode =3D TLS_WRAP_CRYPT;
-    }
-
-    if (to=2Etls_wrap=2E=
mode =3D=3D TLS_WRAP_AUTH || to=2Etls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)
- =
   {
-        to=2Etls_wrap=2Eopt=2Ekey_ctx_bi =3D c->c1=2Eks=2Etls_wrap_ke=
y;
-        to=2Etls_wrap=2Eopt=2Epid_persist =3D &c->c1=2Epid_persist;
-  =
      to=2Etls_wrap=2Eopt=2Eflags |=3D CO_PACKET_ID_LONG_FORM;
-        to=
=2Etls_wrap=2Eoriginal_wrap_keydata =3D c->c1=2Eks=2Eoriginal_wrap_keydata;=

-    }
+    /* Control-channel wrapping (--tls-auth / --tls-crypt) */
+   =
 init_tls_wrap_ctx(&to=2Etls_wrap, &c->options=2Ece, options->tls_client, &=
c->c1=2Eks,
+                      &c->c1=2Epid_persist);
 
     if (option=
s->ce=2Etls_crypt_v2_file)
     {
diff --git a/src/openvpn/init=2Eh b/src/o=
penvpn/init=2Eh
index 9d5050d=2E=2E3090375 100644
--- a/src/openvpn/init=2E=
h
+++ b/src/openvpn/init=2Eh
@@ -73,6 +73,39 @@
 
 void do_test_crypto(stru=
ct context *o);
 
+/**
+ * @brief Load the tls-auth/tls-crypt(-v2) key mate=
rial into c->c1=2Eks=2E
+ *
+ * Reads the key from the file configured on c=
onnection entry ce (--tls-auth,
+ * --tls-crypt or --tls-crypt-v2); a no-op=
 when none of them is set=2E May be
+ * called more than once (the key can =
be configured per connection block, so it
+ * is reloaded for each connecti=
on)=2E
+ *
+ * @param c  The context whose c1=2Eks key schedule is populate=
d=2E
+ * @param ce The connection entry whose tls-wrap key file is loaded=
=2E
+ */
+void do_init_tls_wrap_key(struct context *c, const struct connect=
ion_entry *ce);
+
+/**
+ * @brief Configure a control-channel wrapping cont=
ext from a connection entry
+ *        and previously loaded tls-wrap key m=
aterial=2E
+ *
+ * Sets tls_wrap to TLS_WRAP_AUTH (--tls-auth) or TLS_WRAP_=
CRYPT
+ * (--tls-crypt / client --tls-crypt-v2) and installs the key contex=
t, or
+ * leaves it in TLS_WRAP_NONE when neither is configured=2E The key =
material must
+ * already have been loaded with do_init_tls_wrap_key()=2E t=
ls-crypt-v2 specifics
+ * (the wrapped client key and the server key) are l=
eft to the caller=2E
+ *
+ * @param tls_wrap    The wrapping context to con=
figure=2E
+ * @param ce          The connection entry selecting the wrappin=
g mode=2E
+ * @param tls_client  Whether this is a TLS client (selects tls-=
crypt-v2 mode)=2E
+ * @param ks          Key schedule holding the loaded tl=
s-wrap key material=2E
+ * @param pid_persist Packet-id persistence object =
to attach to the context=2E
+ */
+void init_tls_wrap_ctx(struct tls_wrap_ct=
x *tls_wrap, const struct connection_entry *ce,
+                       boo=
l tls_client, const struct key_schedule *ks,
+                       struct=
 packet_id_persist *pid_persist);
+
 void context_gc_free(struct context *c=
);
 
 bool do_up(struct context *c, bool pulled_options, uint64_t option_ty=
pes_found);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
749?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpat=
chset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7d85=
46da9ef06c2226ea77e461f9550d24894c61
Gerrit-Change-Number: 1749
Gerrit-Patc=
hSet: 14
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>

--bbTy6OO7cXg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #14</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1749?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Ext=
ract init_tls_wrap_ctx() control-channel wrap helper<br><br>Factor the tls-=
auth/tls-crypt wrapping-context setup out of<br>do_init_crypto_tls() into a=
 reusable init_tls_wrap_ctx() helper, and expose it<br>in init=2Eh together=
 with do_init_tls_wrap_key(), which now takes the connection<br>entry to re=
ad its keys from instead of using options=2Ece=2E Both call sites pass<br>&=
amp;c-&gt;options=2Ece, so there is no behavior change=2E<br><br>This lets =
the client --server-probe path build the same control-channel<br>wrapping c=
ontext before a connection is established, so the probe can be<br>wrapped w=
ith tls-auth/tls-crypt like any other control packet=2E<br><br>Change-Id: I=
7d8546da9ef06c2226ea77e461f9550d24894c61<br>Signed-off-by: Lev Stipakov &lt=
;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/init=2Ec<br>M src/openvpn/in=
it=2Eh<br>2 files changed, 83 insertions(+), 37 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/49/1749/14</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=
=2Ec</span><br><span>index 274c86a=2E=2Ee0d6a14 100644</span><br><span>--- =
a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br=
><span>@@ -3077,13 +3077,13 @@</span><br><span> /*</span><br><span>  * Init=
ialize the tls-auth/crypt key context</span><br><span>  */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-do_init_tls_wrap_key(struct context *c)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+do_init_tls_wrap_key(struct context *c, c=
onst struct connection_entry *ce)</span><br><span> {</span><br><span>     c=
onst struct options *options =3D &amp;c-&gt;options;</span><br><span> </spa=
n><br><span>     /* TLS handshake authentication (--tls-auth) */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;ce=2Etls_aut=
h_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&=
gt;tls_auth_file)</span><br><span>     {</span><br><span>         /* Initia=
lize key_type for tls-auth with auth only */</span><br><span>         CLEAR=
(c-&gt;c1=2Eks=2Etls_auth_key_type);</span><br><span>@@ -3098,33 +3098,31 @=
@</span><br><span>         }</span><br><span> </span><br><span>         cry=
pto_read_openvpn_key(&amp;c-&gt;c1=2Eks=2Etls_auth_key_type, &amp;c-&gt;c1=
=2Eks=2Etls_wrap_key,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                options-&gt;ce=2Etls_auth_file, options-&gt=
;ce=2Etls_auth_file_inline,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                                options-&gt;ce=2Ekey_direction, &quot=
;Control Channel Authentication&quot;,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                &quot;tls-auth&quot;, &amp=
;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                ce-&gt;tls_auth_file, =
ce-&gt;tls_auth_file_inline, ce-&gt;key_direction,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                &quot;Contro=
l Channel Authentication&quot;, &quot;tls-auth&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                &amp;c-&g=
t;c1=2Eks=2Eoriginal_wrap_keydata);</span><br><span>     }</span><br><span>=
 </span><br><span>     /* TLS handshake encryption+authentication (--tls-cr=
ypt) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (option=
s-&gt;ce=2Etls_crypt_file)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (ce-&gt;tls_crypt_file)</span><br><span>     {</span><br><spa=
n>         tls_crypt_init_key(&amp;c-&gt;c1=2Eks=2Etls_wrap_key, &amp;c-&gt=
;c1=2Eks=2Eoriginal_wrap_keydata,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                           options-&gt;ce=2Etls_crypt_file, opt=
ions-&gt;ce=2Etls_crypt_file_inline,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                           options-&gt;tls_server);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                           c=
e-&gt;tls_crypt_file, ce-&gt;tls_crypt_file_inline, options-&gt;tls_server)=
;</span><br><span>     }</span><br><span> </span><br><span>     /* tls-cryp=
t with client-specific keys (--tls-crypt-v2) */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (options-&gt;ce=2Etls_crypt_v2_file)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;tls_crypt_=
v2_file)</span><br><span>     {</span><br><span>         if (options-&gt;tl=
s_server)</span><br><span>         {</span><br><span>             tls_crypt=
_v2_init_server_key(&amp;c-&gt;c1=2Eks=2Etls_crypt_v2_server_key, true,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
                options-&gt;ce=2Etls_crypt_v2_file,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                         op=
tions-&gt;ce=2Etls_crypt_v2_file_inline);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                         ce-&gt;tls_c=
rypt_v2_file, ce-&gt;tls_crypt_v2_file_inline);</span><br><span>         }<=
/span><br><span>         else</span><br><span>         {</span><br><span>  =
           tls_crypt_v2_init_client_key(&amp;c-&gt;c1=2Eks=2Etls_wrap_key, =
&amp;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                         &amp;c-&gt;c=
1=2Eks=2Etls_crypt_v2_wkc, options-&gt;ce=2Etls_crypt_v2_file,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                  =
       options-&gt;ce=2Etls_crypt_v2_file_inline);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                         &am=
p;c-&gt;c1=2Eks=2Etls_crypt_v2_wkc, ce-&gt;tls_crypt_v2_file,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
        ce-&gt;tls_crypt_v2_file_inline);</span><br><span>         }</span>=
<br><span>         /* We have to ensure that the loaded tls-crypt key is sm=
all enough</span><br><span>          * to fit into the initial hard reset v=
3 packet */</span><br><span>@@ -3133,19 +3131,50 @@</span><br><span>       =
  /* empty ACK/message id, tls-crypt, Opcode, UDP, ipv6 */</span><br><span>=
         int required_size =3D 5 + wkc_len + tls_crypt_buf_overhead() + 1 +=
 8 + 40;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (required_size &gt; c-&gt;options=2Ece=2Etls_mtu)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (required_size &gt=
; ce-&gt;tls_mtu)</span><br><span>         {</span><br><span>             m=
sg(M_WARN,</span><br><span>                 &quot;ERROR: tls-crypt-v2 clien=
t key too large to work with &quot;</span><br><span>                 &quot;=
requested --max-packet-size %d, requires at least &quot;</span><br><span>  =
               &quot;--max-packet-size %d=2E Packets will ignore requested =
&quot;</span><br><span>                 &quot;maximum packet size&quot;,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                c-&gt;op=
tions=2Ece=2Etls_mtu, required_size);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                ce-&gt;tls_mtu, required_size);</span><br=
><span>         }</span><br><span>     }</span><br><span> }</span><br><span=
> </span><br><span> /*</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Configure a control-channel wrapping context (tls-auth/tls-crypt) fro=
m a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * connection en=
try and the already-loaded tls-wrap key material=2E Leaves the</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * context in TLS_WRAP_NONE if n=
either tls-auth nor tls-crypt is configured=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * tls-crypt-v2 specifics (WKc, server key) are =
handled by the caller=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+init_tls_wrap_ctx(struct t=
ls_wrap_ctx *tls_wrap, const struct connection_entry *ce, bool tls_client,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  co=
nst struct key_schedule *ks, struct packet_id_persist *pid_persist)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* TLS handshake authentication (--tls-au=
th) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&g=
t;tls_auth_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_wrap-=
&gt;mode =3D TLS_WRAP_AUTH;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* TLS handshake encr=
yption (--tls-crypt) */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (ce-&gt;tls_crypt_file || (ce-&gt;tls_crypt_v2_file &amp;&amp; t=
ls_client))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_wrap-&gt;m=
ode =3D TLS_WRAP_CRYPT;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (tls_wrap-&gt;mode =3D=
=3D TLS_WRAP_AUTH || tls_wrap-&gt;mode =3D=3D TLS_WRAP_CRYPT)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        tls_wrap-&gt;opt=2Ekey_ctx_bi =3D ks-&g=
t;tls_wrap_key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    tls_wrap-&gt;opt=2Epid_persist =3D pid_persist;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tls_wrap-&gt;opt=2Eflags |=3D CO_=
PACKET_ID_LONG_FORM;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        tls_wrap-&gt;original_wrap_keydata =3D ks-&gt;original_wrap_keydat=
a;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/*</span><br><span>  * Initialize the persistent component of OpenVP=
N&#39;s TLS mode,</span><br><span>  * which is preserved across SIGUSR1 res=
ets=2E</span><br><span>  */</span><br><span>@@ -3216,7 +3245,7 @@</span><br=
><span>         init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, ciphername, op=
tions-&gt;authname, true, warn);</span><br><span> </span><br><span>        =
 /* initialize tls-auth/crypt/crypt-v2 key */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        do_init_tls_wrap_key(c);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        do_init_tls_wrap_key(c, &amp;c=
-&gt;options=2Ece);</span><br><span> </span><br><span>         /* initialis=
e auth-token crypto support */</span><br><span>         if (c-&gt;options=
=2Eauth_token_generate)</span><br><span>@@ -3241,7 +3270,7 @@</span><br><sp=
an>          * tls-auth/crypt key can be configured per connection block, t=
herefore</span><br><span>          * we must reload it as it may have chang=
ed</span><br><span>          */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        do_init_tls_wrap_key(c);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        do_init_tls_wrap_key(c, &amp;c-&gt;options=
=2Ece);</span><br><span>     }</span><br><span> }</span><br><span> </span><=
br><span>@@ -3420,25 +3449,9 @@</span><br><span>         to=2Eekm_size =3D =
0;</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    /* TLS handshake authentication (--tls-auth) */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;ce=
=2Etls_auth_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        to=2Etls_wra=
p=2Emode =3D TLS_WRAP_AUTH;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* TLS handshake encryption=
 (--tls-crypt) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (options-&gt;ce=2Etls_crypt_file || (options-&gt;ce=2Etls_crypt_v2_file =
&amp;&amp; options-&gt;tls_client))</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      to=2Etls_wrap=2Emode =3D TLS_WRAP_CRYPT;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (to=
=2Etls_wrap=2Emode =3D=3D TLS_WRAP_AUTH || to=2Etls_wrap=2Emode =3D=3D TLS_=
WRAP_CRYPT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        to=2Etls_wrap=2Eop=
t=2Ekey_ctx_bi =3D c-&gt;c1=2Eks=2Etls_wrap_key;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        to=2Etls_wrap=2Eopt=2Epid_persist =3D &a=
mp;c-&gt;c1=2Epid_persist;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        to=2Etls_wrap=2Eopt=2Eflags |=3D CO_PACKET_ID_LONG_FORM;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        to=2Etls_wrap=2Eori=
ginal_wrap_keydata =3D c-&gt;c1=2Eks=2Eoriginal_wrap_keydata;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* Control-channel wrapping (--tls-auth / --t=
ls-crypt) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ini=
t_tls_wrap_ctx(&amp;to=2Etls_wrap, &amp;c-&gt;options=2Ece, options-&gt;tls=
_client, &amp;c-&gt;c1=2Eks,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                      &amp;c-&gt;c1=2Epid_persist);</span><br><spa=
n> </span><br><span>     if (options-&gt;ce=2Etls_crypt_v2_file)</span><br>=
<span>     {</span><br><span>diff --git a/src/openvpn/init=2Eh b/src/openvp=
n/init=2Eh</span><br><span>index 9d5050d=2E=2E3090375 100644</span><br><spa=
n>--- a/src/openvpn/init=2Eh</span><br><span>+++ b/src/openvpn/init=2Eh</sp=
an><br><span>@@ -73,6 +73,39 @@</span><br><span> </span><br><span> void do_=
test_crypto(struct context *o);</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @brief Load the tls-auth/tls-crypt(-v2) key material into =
c-&gt;c1=2Eks=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Reads the key fro=
m the file configured on connection entry ce (--tls-auth,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * --tls-crypt or --tls-crypt-v2); a =
no-op when none of them is set=2E May be</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * called more than once (the key can be configured pe=
r connection block, so it</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * is reloaded for each connection)=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param c  The context whose c1=2Eks key schedule is populated=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ce The co=
nnection entry whose tls-wrap key file is loaded=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void do_init_tls_wrap_key(struct context *c, const struct=
 connection_entry *ce);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @brief Configure a control-c=
hannel wrapping context from a connection entry</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *        and previously loaded tls-wrap key ma=
terial=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Sets tls_wrap to TLS_WRA=
P_AUTH (--tls-auth) or TLS_WRAP_CRYPT</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * (--tls-crypt / client --tls-crypt-v2) and installs the=
 key context, or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
leaves it in TLS_WRAP_NONE when neither is configured=2E The key material m=
ust</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * already have =
been loaded with do_init_tls_wrap_key()=2E tls-crypt-v2 specifics</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * (the wrapped client key an=
d the server key) are left to the caller=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param tls_wrap    The wrapping context to configure=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ce          The con=
nection entry selecting the wrapping mode=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param tls_client  Whether this is a TLS client=
 (selects tls-crypt-v2 mode)=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param ks          Key schedule holding the loaded tls-wrap =
key material=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param pid_persist Packet-id persistence object to attach to the context=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void init_tls_wrap_ctx(struct tls_wr=
ap_ctx *tls_wrap, const struct connection_entry *ce,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                       bool tls_client, c=
onst struct key_schedule *ks,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                       struct packet_id_persist *pid_persist);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void=
 context_gc_free(struct context *c);</span><br><span> </span><br><span> boo=
l do_up(struct context *c, bool pulled_options, uint64_t option_types_found=
);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail">change 1749</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7d8546da9ef06=
c2226ea77e461f9550d24894c61 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1749 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 14 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>

</body></html>
--bbTy6OO7cXg=--


--===============1590101494992222397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1590101494992222397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1590101494992222397==--

