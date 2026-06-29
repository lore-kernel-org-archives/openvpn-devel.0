Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D968C43602
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=/Cj6krC6Xj1ux4AwqItKd9pQEnylXucYpTDbvrvZTOI=; b=YTwNXEciJlzHsN
	+wS30KGpBdERvz7EInFDW8tUen+7xJZm8cjsSNY5IDWxembWViHtqHJbGxR+gW0c+HJnvpnRYKA1R
	spRfjkhIW7b3udtLxACddB5cMKpoVTfXaiBMaQ0xGmhVEQbMfWhTIrYNRWThw98yX81balfiW4Arv
	a28=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1we6td-0002Ih-DP;
	Mon, 29 Jun 2026 07:59:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1we6tb-0002IP-BC
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q8YD7gmedkZKbBIyi5cH8GTrxtp0+Pk0tsZ7o4j4k3s=; b=ATMpRkCi/Lx9GYpOnJaCUu1xuw
 SfsSVGGzPtUDKCwJ9UtiAWY0cYxS/vsXk45i0856N+Yibpzi7obgrwjd52PeECSGdxufXGR2CV+7b
 bRblchZHOdkc0AuRGufhk+ogwnzLLDOF9lDjXSct/u4lZzfyKFuO50e+Z/p7FnZixxCA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Q8YD7gmedkZKbBIyi5cH8GTrxtp0+Pk0tsZ7o4j4k3s=; b=b
 0uRM/sL+4TLiYzHFQXiT6oe6Bj+gsB4nbo4il/5FfFfkw5e0M2A/BnTt2nF6PmaV0d9MOm1GFrSyg
 Wl/mZK+YAa6mOdrddegtZVHMj+yE2xp0LfCdC53NCfLvg02po/vkzgaQTNU+hyu0t9r7W3qktmDXU
 pPA9xG/R047EC+Ds=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1we6tZ-0008NT-Pk for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:12 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso1688517f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 00:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782719944; x=1783324744; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q8YD7gmedkZKbBIyi5cH8GTrxtp0+Pk0tsZ7o4j4k3s=;
 b=Au/die6LZWa+EpSA5PMwvZYKITLkqUR5njIzSZZkuWX2tAXasEsZkcOJGFSKG9H0vb
 GX5askecwtOyMjc7EYT4yFIVk61bXQf1/iWGR2p8OOb6NU9pqBLK08Owstg4KWYldRdj
 N46Thneuw+gjC7nMxTVqg7i8OVYF36rJ4LBIzIpsgcRdiZ6M2i8r/GPJGGMdCQ4+4ZCt
 S6HILhRvwv5T5A73ZkWQTIVNnk2e6o7RkWW6d7VIqhMR5qdx4VuLvSM5mC29WP8D7j3Z
 3+1/iOZSFu+n4OA0f0GPAw5nnXoyp+61nwTe48y2pADQ/kDsRy+TA3V4XxaERbctYWMT
 f0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782719944; x=1783324744;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q8YD7gmedkZKbBIyi5cH8GTrxtp0+Pk0tsZ7o4j4k3s=;
 b=BXfoXq16xKdvA7XdVE3B/l/pS53qsA98Si5EW+/f6O5HQ9OK+W/x63k31U8pmMsKGL
 Wersu2QGPZC2IMNB5HunXflNE9fkkQACIvFmnEZEYRlc21oSPR2l1BJo/rsOPiOgtcHS
 cLIymjNa1qN1vsbwiuWPJuD5UFs4tHjBYre0OnveF4prdoOZ9laaTgW2fvmS0Vv+VXws
 /RqjF5XTkSjctKUfqL0hG1SJb9pe5VhfeCjsEqXSZRaZFHioS+J0U8PN03tNQsTTZ+53
 aRJHkm7tDvTm3Kx87Jg9RIWaoJCPl+yfsFlPuFa1IS8Y7hcmfJwNiTbVv/wWDZtty9Qg
 h7hg==
X-Gm-Message-State: AOJu0YxfYEJg4M1qNsmJ358/vEwFYaGOCHmdz7c5Iuqzi88cV8oUvxZ3
 G1980qBcpqV2t7Uad4SKQ1iXls+DLhvQoiujdFbHvn9KD8sH4bYNYbx/7KIOL6AoJ+h4f1p+NXB
 WxV199eIoYc4zZamPVOycw/ujSiFgaChJNOlg9MTFd7Hgo2gHj036BG1ypja0VQvFL8tNO+niHV
 9jkcY4TQ==
X-Gm-Gg: AfdE7cl8YwdzcjJPqOh7iam6Pz0DiQ/kIG+yMd1dB3wyWHSITJgP0ALzQ35ebRD+wIX
 JG7uzocvy2G24MXsIJnTZsDBFDerznjS/F4LVGlonEIsPMT78ULtbgF6Sv7TEJPqgIbisB371mH
 72jzNCmY+d6ePMqgqOqN60pqr7OyStsCiMrL7CBF2fE+syItwfpyhMgk3BiVpGY5WJ/lu7rUM5W
 1+PHBTMyx34jN4Sute7FChj8Ba3g0QcxMheOcUtrYcrhfMN1vJ8JtQDhJYdmMxSTeFSrY4h/iXO
 WreOgjrEOfO3Uo9UEtLjEhaoCcRjtFGyyfgLrW7WpAS62hZKZ7h8xG9HwLyRE2kXW8+k8flHJLJ
 dQlSreFssr5+vOOaUBdyJPQSQ5bUPklp/KPKuSmKP+1MTl1U2aZcq1CxbKh77SGQUsbz+drKWr6
 BXn3wJ5RbLm2PB2eTm2KJOLHgFCYP5+cfWFn6ACHG4c2/P781vrab4eFicbSy818KNAZGGIn14S
 Q98UgVTqJx75Q8NxNLY/Kg9+KHK6qeMyLgYA847jcWycZ9EAKOWwW/8DdZKKs91GtRd1JvxhkXM
 Sqk=
X-Received: by 2002:a5d:5f53:0:b0:461:9950:da50 with SMTP id
 ffacd0b85a97d-46dc092ed80mr25726555f8f.11.1782719943490; 
 Mon, 29 Jun 2026 00:59:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4728072189asm13997350f8f.30.2026.06.29.00.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 00:59:03 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 07:59:02 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
X-Gerrit-Change-Number: 1749
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1749?usp=email>
X-Gerrit-Commit: 3c9d06f404680f612acaf7e9bc1f71b34fca7179
References: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk3ZDg1NDZkYTllZjA2YzIyMjZlYTc3ZTQ2MWY5NTUwZDI0ODk0YzYxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <61c6a9553cb0d3bbedc71dd83fd594f6ee10c4da-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1we6tZ-0008NT-Pk
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
Content-Type: multipart/mixed; boundary="===============0318096475244062080=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0318096475244062080==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RNQIW6n6tmw="; charset=UTF-8

--RNQIW6n6tmw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1749?usp=3Demail

to review the following change=2E


Chang=
e subject: oob: Extract init_tls_wrap_ctx() control-channel wrap helper
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Extract ini=
t_tls_wrap_ctx() control-channel wrap helper

Factor the tls-auth/tls-crypt=
 wrapping-context setup out of
do_init_crypto_tls() into a reusable init_tl=
s_wrap_ctx() helper, and
expose it together with do_init_tls_wrap_key() in =
init=2Eh=2E No behavior
change=2E

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

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/49/1749=
/1

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
index 9d5050d=2E=2E5e7a03c 100644
--- a/src/openvpn/init=2E=
h
+++ b/src/openvpn/init=2Eh
@@ -73,6 +73,39 @@
 
 void do_test_crypto(stru=
ct context *o);
 
+/**
+ * @brief Load the tls-auth/tls-crypt(-v2) key mate=
rial into @p c->c1=2Eks=2E
+ *
+ * Reads the key from the file configured o=
n connection entry @p ce (--tls-auth,
+ * --tls-crypt or --tls-crypt-v2); a=
 no-op when none of them is set=2E May be
+ * called more than once (the ke=
y can be configured per connection block, so it
+ * is reloaded for each co=
nnection)=2E
+ *
+ * @param c  The context whose c1=2Eks key schedule is po=
pulated=2E
+ * @param ce The connection entry whose tls-wrap key file is lo=
aded=2E
+ */
+void do_init_tls_wrap_key(struct context *c, const struct con=
nection_entry *ce);
+
+/**
+ * @brief Configure a control-channel wrapping =
context from a connection entry
+ *        and previously loaded tls-wrap k=
ey material=2E
+ *
+ * Sets @p tls_wrap to TLS_WRAP_AUTH (--tls-auth) or TL=
S_WRAP_CRYPT
+ * (--tls-crypt / client --tls-crypt-v2) and installs the key=
 context, or
+ * leaves it in TLS_WRAP_NONE when neither is configured=2E T=
he key material must
+ * already have been loaded with do_init_tls_wrap_key=
()=2E tls-crypt-v2 specifics
+ * (the wrapped client key and the server key=
) are left to the caller=2E
+ *
+ * @param tls_wrap    The wrapping context=
 to configure=2E
+ * @param ce          The connection entry selecting the =
wrapping mode=2E
+ * @param tls_client  Whether this is a TLS client (selec=
ts tls-crypt-v2 mode)=2E
+ * @param ks          Key schedule holding the lo=
aded tls-wrap key material=2E
+ * @param pid_persist Packet-id persistence =
object to attach to the context=2E
+ */
+void init_tls_wrap_ctx(struct tls_=
wrap_ctx *tls_wrap, const struct connection_entry *ce,
+                   =
    bool tls_client, const struct key_schedule *ks,
+                      =
 struct packet_id_persist *pid_persist);
+
 void context_gc_free(struct con=
text *c);
 
 bool do_up(struct context *c, bool pulled_options, uint64_t op=
tion_types_found);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1749?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I7d8546da9ef06c2226ea77e461f9550d24894c61
Gerrit-Change-Number: 1749
Gerrit=
-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>

--RNQIW6n6tmw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1749?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oo=
b: Extract init_tls_wrap_ctx() control-channel wrap helper<br><br>Factor th=
e tls-auth/tls-crypt wrapping-context setup out of<br>do_init_crypto_tls() =
into a reusable init_tls_wrap_ctx() helper, and<br>expose it together with =
do_init_tls_wrap_key() in init=2Eh=2E No behavior<br>change=2E<br><br>This =
lets the client --server-probe path build the same control-channel<br>wrapp=
ing context before a connection is established, so the probe can be<br>wrap=
ped with tls-auth/tls-crypt like any other control packet=2E<br><br>Change-=
Id: I7d8546da9ef06c2226ea77e461f9550d24894c61<br>Signed-off-by: Lev Stipako=
v &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/init=2Ec<br>M src/openv=
pn/init=2Eh<br>2 files changed, 83 insertions(+), 37 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/49/1749/1</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/i=
nit=2Ec</span><br><span>index 274c86a=2E=2Ee0d6a14 100644</span><br><span>-=
-- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span>=
<br><span>@@ -3077,13 +3077,13 @@</span><br><span> /*</span><br><span>  * I=
nitialize the tls-auth/crypt key context</span><br><span>  */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-do_init_tls_wrap_key(struct context *c)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+do_init_tls_wrap_key(struct context *c=
, const struct connection_entry *ce)</span><br><span> {</span><br><span>   =
  const struct options *options =3D &amp;c-&gt;options;</span><br><span> </=
span><br><span>     /* TLS handshake authentication (--tls-auth) */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;ce=2Etls_=
auth_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c=
e-&gt;tls_auth_file)</span><br><span>     {</span><br><span>         /* Ini=
tialize key_type for tls-auth with auth only */</span><br><span>         CL=
EAR(c-&gt;c1=2Eks=2Etls_auth_key_type);</span><br><span>@@ -3098,33 +3098,3=
1 @@</span><br><span>         }</span><br><span> </span><br><span>         =
crypto_read_openvpn_key(&amp;c-&gt;c1=2Eks=2Etls_auth_key_type, &amp;c-&gt;=
c1=2Eks=2Etls_wrap_key,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                                options-&gt;ce=2Etls_auth_file, options-&=
gt;ce=2Etls_auth_file_inline,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                                options-&gt;ce=2Ekey_direction, &qu=
ot;Control Channel Authentication&quot;,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                                &quot;tls-auth&quot;, &a=
mp;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                ce-&gt;tls_auth_file=
, ce-&gt;tls_auth_file_inline, ce-&gt;key_direction,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                &quot;Con=
trol Channel Authentication&quot;, &quot;tls-auth&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                &amp;c=
-&gt;c1=2Eks=2Eoriginal_wrap_keydata);</span><br><span>     }</span><br><sp=
an> </span><br><span>     /* TLS handshake encryption+authentication (--tls=
-crypt) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (opt=
ions-&gt;ce=2Etls_crypt_file)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (ce-&gt;tls_crypt_file)</span><br><span>     {</span><br><=
span>         tls_crypt_init_key(&amp;c-&gt;c1=2Eks=2Etls_wrap_key, &amp;c-=
&gt;c1=2Eks=2Eoriginal_wrap_keydata,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                           options-&gt;ce=2Etls_crypt_file, =
options-&gt;ce=2Etls_crypt_file_inline,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                           options-&gt;tls_server);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
  ce-&gt;tls_crypt_file, ce-&gt;tls_crypt_file_inline, options-&gt;tls_serv=
er);</span><br><span>     }</span><br><span> </span><br><span>     /* tls-c=
rypt with client-specific keys (--tls-crypt-v2) */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (options-&gt;ce=2Etls_crypt_v2_file)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;tls_cry=
pt_v2_file)</span><br><span>     {</span><br><span>         if (options-&gt=
;tls_server)</span><br><span>         {</span><br><span>             tls_cr=
ypt_v2_init_server_key(&amp;c-&gt;c1=2Eks=2Etls_crypt_v2_server_key, true,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
                   options-&gt;ce=2Etls_crypt_v2_file,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                                         o=
ptions-&gt;ce=2Etls_crypt_v2_file_inline);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                         ce-&gt;tls_=
crypt_v2_file, ce-&gt;tls_crypt_v2_file_inline);</span><br><span>         }=
</span><br><span>         else</span><br><span>         {</span><br><span> =
            tls_crypt_v2_init_client_key(&amp;c-&gt;c1=2Eks=2Etls_wrap_key,=
 &amp;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                                         &amp;c-&gt;=
c1=2Eks=2Etls_crypt_v2_wkc, options-&gt;ce=2Etls_crypt_v2_file,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
        options-&gt;ce=2Etls_crypt_v2_file_inline);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
&amp;c-&gt;c1=2Eks=2Etls_crypt_v2_wkc, ce-&gt;tls_crypt_v2_file,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
           ce-&gt;tls_crypt_v2_file_inline);</span><br><span>         }</sp=
an><br><span>         /* We have to ensure that the loaded tls-crypt key is=
 small enough</span><br><span>          * to fit into the initial hard rese=
t v3 packet */</span><br><span>@@ -3133,19 +3131,50 @@</span><br><span>    =
     /* empty ACK/message id, tls-crypt, Opcode, UDP, ipv6 */</span><br><sp=
an>         int required_size =3D 5 + wkc_len + tls_crypt_buf_overhead() + =
1 + 8 + 40;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (required_size &gt; c-&gt;options=2Ece=2Etls_mtu)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (required_size =
&gt; ce-&gt;tls_mtu)</span><br><span>         {</span><br><span>           =
  msg(M_WARN,</span><br><span>                 &quot;ERROR: tls-crypt-v2 cl=
ient key too large to work with &quot;</span><br><span>                 &qu=
ot;requested --max-packet-size %d, requires at least &quot;</span><br><span=
>                 &quot;--max-packet-size %d=2E Packets will ignore request=
ed &quot;</span><br><span>                 &quot;maximum packet size&quot;,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                c-&gt=
;options=2Ece=2Etls_mtu, required_size);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                ce-&gt;tls_mtu, required_size);</span>=
<br><span>         }</span><br><span>     }</span><br><span> }</span><br><s=
pan> </span><br><span> /*</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Configure a control-channel wrapping context (tls-auth/tls-crypt) =
from a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * connection=
 entry and the already-loaded tls-wrap key material=2E Leaves the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * context in TLS_WRAP_NONE i=
f neither tls-auth nor tls-crypt is configured=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * tls-crypt-v2 specifics (WKc, server key) a=
re handled by the caller=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+init_tls_wrap_ctx(struc=
t tls_wrap_ctx *tls_wrap, const struct connection_entry *ce, bool tls_clien=
t,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
 const struct key_schedule *ks, struct packet_id_persist *pid_persist)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* TLS handshake authentication (--tl=
s-auth) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c=
e-&gt;tls_auth_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_w=
rap-&gt;mode =3D TLS_WRAP_AUTH;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* TLS handshake =
encryption (--tls-crypt) */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (ce-&gt;tls_crypt_file || (ce-&gt;tls_crypt_v2_file &amp;&am=
p; tls_client))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_wrap-&=
gt;mode =3D TLS_WRAP_CRYPT;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tls_wrap-&gt;mode=
 =3D=3D TLS_WRAP_AUTH || tls_wrap-&gt;mode =3D=3D TLS_WRAP_CRYPT)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tls_wrap-&gt;opt=2Ekey_ctx_bi =3D=
 ks-&gt;tls_wrap_key;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        tls_wrap-&gt;opt=2Epid_persist =3D pid_persist;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        tls_wrap-&gt;opt=2Eflags |=3D=
 CO_PACKET_ID_LONG_FORM;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        tls_wrap-&gt;original_wrap_keydata =3D ks-&gt;original_wrap_ke=
ydata;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/*</span><br><span>  * Initialize the persistent component of Op=
enVPN&#39;s TLS mode,</span><br><span>  * which is preserved across SIGUSR1=
 resets=2E</span><br><span>  */</span><br><span>@@ -3216,7 +3245,7 @@</span=
><br><span>         init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, ciphername=
, options-&gt;authname, true, warn);</span><br><span> </span><br><span>    =
     /* initialize tls-auth/crypt/crypt-v2 key */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        do_init_tls_wrap_key(c);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        do_init_tls_wrap_key(c, &a=
mp;c-&gt;options=2Ece);</span><br><span> </span><br><span>         /* initi=
alise auth-token crypto support */</span><br><span>         if (c-&gt;optio=
ns=2Eauth_token_generate)</span><br><span>@@ -3241,7 +3270,7 @@</span><br><=
span>          * tls-auth/crypt key can be configured per connection block,=
 therefore</span><br><span>          * we must reload it as it may have cha=
nged</span><br><span>          */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        do_init_tls_wrap_key(c);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        do_init_tls_wrap_key(c, &amp;c-&gt;options=
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
n/init=2Eh</span><br><span>index 9d5050d=2E=2E5e7a03c 100644</span><br><spa=
n>--- a/src/openvpn/init=2Eh</span><br><span>+++ b/src/openvpn/init=2Eh</sp=
an><br><span>@@ -73,6 +73,39 @@</span><br><span> </span><br><span> void do_=
test_crypto(struct context *o);</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @brief Load the tls-auth/tls-crypt(-v2) key material into =
@p c-&gt;c1=2Eks=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Reads the key =
from the file configured on connection entry @p ce (--tls-auth,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * --tls-crypt or --tls-crypt-v=
2); a no-op when none of them is set=2E May be</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * called more than once (the key can be configu=
red per connection block, so it</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * is reloaded for each connection)=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param c  The context whose c1=2Eks key schedule is popula=
ted=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ce =
The connection entry whose tls-wrap key file is loaded=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void do_init_tls_wrap_key(struct context *c, const st=
ruct connection_entry *ce);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brief Configure a contr=
ol-channel wrapping context from a connection entry</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *        and previously loaded tls-wrap =
key material=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Sets @p tls_wrap t=
o TLS_WRAP_AUTH (--tls-auth) or TLS_WRAP_CRYPT</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * (--tls-crypt / client --tls-crypt-v2) and ins=
talls the key context, or</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * leaves it in TLS_WRAP_NONE when neither is configured=2E The key m=
aterial must</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * alre=
ady have been loaded with do_init_tls_wrap_key()=2E tls-crypt-v2 specifics<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (the wrapped clie=
nt key and the server key) are left to the caller=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param tls_wrap    The wrapping context to configure=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ce       =
   The connection entry selecting the wrapping mode=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param tls_client  Whether this is a =
TLS client (selects tls-crypt-v2 mode)=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param ks          Key schedule holding the loaded=
 tls-wrap key material=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param pid_persist Packet-id persistence object to attach to the c=
ontext=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void init_tls_wrap_ctx(str=
uct tls_wrap_ctx *tls_wrap, const struct connection_entry *ce,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                       bool tls_=
client, const struct key_schedule *ks,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                       struct packet_id_persist *pid_per=
sist);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> void context_gc_free(struct context *c);</span><br><span> </span><br><=
span> bool do_up(struct context *c, bool pulled_options, uint64_t option_ty=
pes_found);</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail">change 1749</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7d8546=
da9ef06c2226ea77e461f9550d24894c61 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 1749 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gm=
ail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>

</body></html>
--RNQIW6n6tmw=--


--===============0318096475244062080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0318096475244062080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0318096475244062080==--

