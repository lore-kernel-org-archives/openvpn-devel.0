Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D33C88E7A
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SgmbijFjbN3kc/9vQODptL5dYMjeL+xdSmDtKu9DSmU=; b=X9PidOPnrt7I5rFqkb6QWMvP1o
	z23O/B8+/gVXZfZnYIDxXXJGXa60SNpUJ+SjsoyzO1l1XlWrq8ru8YtSM/gJ9iD2S5d+4U2F+PBTy
	swcGNWEUSafqfaFCxqH6Jg6gzsjonDTAQ2ozgemv4vb5OWzdDUSmFalgZJQMJCjEC15c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x67WR-0000KH-TW;
	Mon, 14 Sep 2026 14:19:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x67WQ-0000K9-GY
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Nt6+kNiWg5uKEresalv4DOQWKf8si8pDoC0BZTh1ylw=; b=a+mpyG04QgVH43QdxrLobiJCoo
 NGiFE9cmrwwZU8uaklSZ5J4SQ9whkR+1ez1Gin3fHpZXLUN+BWY5UKZJXUomhPu5PIKymHDsCbqms
 klvSRDFBjJTWgrMGhdfHNY4E0RNJRd115NaaciCU77PI5zEA/4xaIl/2LFHbk8t6Rl8s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Nt6+kNiWg5uKEresalv4DOQWKf8si8pDoC0BZTh1ylw=; b=T
 bZhfFbSHaHVkXexaOjNz8pjtshM6OttapeySfEhP5q88ZWDNYJSZf+CfyjJJry4NU2zmO9Tpl/yoP
 VfgGIxOs8wVrV3257aoOvFUYT6PBx/tulOyPdMon3OIcCHOOcEvd43G/AkgREMxSRO3ynwmpidfhI
 NFc3vJrIwVMN/R3A=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x67WL-0006eI-SF for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:03 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e2406so8563695e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 07:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789395531; x=1790000331; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Nt6+kNiWg5uKEresalv4DOQWKf8si8pDoC0BZTh1ylw=;
 b=OjQBfjKtzFCVbhh9boOA40zuK60mLWk3RmlPfz/Lge+145gd7f+mxDGFQ5bE5CntPi
 ofJgH5en95GhVVgh1s//yhUdeibPT5ErmI4uR955cxiGePFOb3tCBOFinqzA03I6baDT
 szpyEhlhGeBYM8/KgNSoaD+QN6w+BDiVEcjJ99l6+fNC9vN678bvVBz+M8QozDYjh5IV
 plREpMgT/8YG5mGrS+dOrSekm7b2s7hSIIHM8sIm2lBAkrXx+Jq4CGCPegg+B9RTIkC9
 1NpjIKDXX9pEYrf3CuqSmtQrBERLXeojc15xvQpaBerR7cL7jAUT+hyeecUmzIIWRE2a
 mZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395531; x=1790000331;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Nt6+kNiWg5uKEresalv4DOQWKf8si8pDoC0BZTh1ylw=;
 b=bIxdOAqQuyEm9zU0ZMdp8v7dheQO80wxIIic5LCziQQ4nQyqqEgZox3PYGkowvPoZr
 DB5/fGmhOwOIS15oxZr8PANmWOVd9mbbtbFPHsj0J7EOBEpVCYdmPS1hSM21JlxqNIqp
 MYuf9qXDXEqh0S32ABipFGnh6+aPxojGvU2jsvaw57jPVnL9DBAtO1vuyGSy2aCDj6M4
 1iZXmZ+ZUO6O6ZDlXnnl2HIypqp8a2qqbxblQJP/dem1b6wfHb2WFQUXZZu5uIKUVnv+
 rrStUnktxZ6OrMBGP0t9FQRosudwErvc/VLv/JPCsK2mz6AvX6+Lqfe9Nmjg7JZ930cn
 K0kQ==
X-Gm-Message-State: AFuF++mz4o4xEMZavntED5jqcuTDyoV6yVFsYfedYuuxpR2WsHIbwsdx
 faMfut8Dg9tARbWXKEvctgM7AEQ3zkRvvT1yN6jHu7mLdKh/pvcTT7Iet/OBnCTJjN2C8LD2Xow
 Rcim1k6Q9vxT4LfqTlBuZUyPnfRZFLBT6iWWVt4Kwp2s/KIdoMLjqRvJWylCebNHOVTjB
X-Gm-Gg: AYBFou3nLKlHTznuCCj23egUPS0NsVDfWES46baW4ryQntDh8kP/m8E4nSZZt4RhgCP
 DJa77NJ5OXPoP0gL2vdyOo1Cv/3Z8mppGoJYcd1Fa9TFAqky4QVcDB04PsiWSmmoFU132jwk3hP
 a83/fkg+Z4AfUIuxf+78tRpJB9UUE8iWBMvMHsBTlg/4TmNUzp/sYUeD6wRJbnHNVHZNgqQTps0
 VW40uLkgRUj4dosgYOIjEKb6WaTGe8HOgUZVoPHICvT/wY8YzpKVSn0rIfHk5pP94WBdmaM18kc
 2SRjnQsP2Wow7GhYwG54p56wZR7wU+rWBsOizdMtlb/r/z2838H7rXud7L0H4HZIbmnzEeXHs6F
 dk4wB5sIANIBY1ia4THzD6DuluvVWJBa1JiYLVHzXuv9RWaD+t3dnqDTM6XhgNhJan+BGaM2bUp
 wbXQSNCSZxEhN1YxUzvjHB1eSKcqaX5RhNOAnCMjv1OpmiRwkon8wyNa0lqYwEVpfH/4GjXTe9J
 ttKcA6HhRmzU96mXwvajmK8MeAVcDICBElOribySXTfmfHXZSS//17sLNt2xPbdpNJ23N45OSdj
 x3wXn7hnNv+3O5/rYsg645SCCMOGPloL7vAVjGX/+M+YtHDORnermjEiYSv20GTverkUhZ2G
X-Received: by 2002:a05:600c:3484:b0:49c:f13e:e52 with SMTP id
 5b1f17b1804b1-49e7a6865c1mr37976845e9.15.1789395530696; 
 Mon, 14 Sep 2026 07:18:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7d23f932sm5631185e9.1.2026.09.14.07.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:18:50 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 14:18:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
X-Gerrit-Change-Number: 1749
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1749?usp=email>
X-Gerrit-Commit: 98f9ff2f77d8fa738a51db8473ea596415c94843
In-Reply-To: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
References: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk3ZDg1NDZkYTllZjA2YzIyMjZlYTc3ZTQ2MWY5NTUwZDI0ODk0YzYxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8ec9a99158b56ccc36da77fba2089fed15107b75-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x67WL-0006eI-SF
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1090144413943273509=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1090144413943273509==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CBLkHxbG5pw="; charset=UTF-8

--CBLkHxbG5pw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail

to look a=
t the new patch set (#22)=2E

The following approvals got outdated and were=
 removed:
Code-Review+1 by ralf_lici


Change subject: oob: Extract init_tl=
s_wrap_ctx() control-channel wrap helper
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Extract init_tls_wrap_ctx() control-chann=
el wrap helper

Factor the tls-auth/tls-crypt wrapping-context setup out of
do_init_crypto_tls() into a reusable init_tls_wrap_ctx() helper, and
expose it in init=2Eh together with do_init_tls_wrap_key(), which now
takes the connection entry to read its keys from instead of using
options=2Ece=2E Both call sites pass &c->options=2Ece, so there is no beha=
vior
change=2E

This lets the client --server-probe path build the same control-channel
wrapping context before a connection is established, so the probe can be
wrapped with tls-auth/tls-crypt like any other control packet=2E

Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/init=2Ec=

M src/openvpn/init=2Eh
2 files changed, 86 insertions(+), 37 deletions(-)
=


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/49/174=
9/22

diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 529c5a=
3=2E=2Eddf60c6 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec=

@@ -3056,13 +3056,13 @@
 /*
  * Initialize the tls-auth/crypt key context
=
  */
-static void
-do_init_tls_wrap_key(struct context *c)
+void
+do_init_t=
ls_wrap_key(struct context *c, const struct connection_entry *ce)
 {
     c=
onst struct options *options =3D &c->options;
 
     /* TLS handshake authe=
ntication (--tls-auth) */
-    if (options->ce=2Etls_auth_file)
+    if (ce=
->tls_auth_file)
     {
         /* Initialize key_type for tls-auth with a=
uth only */
         CLEAR(c->c1=2Eks=2Etls_auth_key_type);
@@ -3077,33 +30=
77,31 @@
         }
 
         crypto_read_openvpn_key(&c->c1=2Eks=2Etls_au=
th_key_type, &c->c1=2Eks=2Etls_wrap_key,
-                                o=
ptions->ce=2Etls_auth_file, options->ce=2Etls_auth_file_inline,
-          =
                      options->ce=2Ekey_direction, "Control Channel Authent=
ication",
-                                "tls-auth", &c->c1=2Eks=2Eorigin=
al_wrap_keydata);
+                                ce->tls_auth_file, ce->t=
ls_auth_file_inline, ce->key_direction,
+                                "C=
ontrol Channel Authentication", "tls-auth",
+                              =
  &c->c1=2Eks=2Eoriginal_wrap_keydata);
     }
 
     /* TLS handshake encr=
yption+authentication (--tls-crypt) */
-    if (options->ce=2Etls_crypt_fil=
e)
+    if (ce->tls_crypt_file)
     {
         tls_crypt_init_key(&c->c1=
=2Eks=2Etls_wrap_key, &c->c1=2Eks=2Eoriginal_wrap_keydata,
-               =
            options->ce=2Etls_crypt_file, options->ce=2Etls_crypt_file_inli=
ne,
-                           options->tls_server);
+                    =
       ce->tls_crypt_file, ce->tls_crypt_file_inline, options->tls_server);=

     }
 
     /* tls-crypt with client-specific keys (--tls-crypt-v2) */
-=
    if (options->ce=2Etls_crypt_v2_file)
+    if (ce->tls_crypt_v2_file)
  =
   {
         if (options->tls_server)
         {
             tls_crypt_v2=
_init_server_key(&c->c1=2Eks=2Etls_crypt_v2_server_key, true,
-            =
                             options->ce=2Etls_crypt_v2_file,
-            =
                             options->ce=2Etls_crypt_v2_file_inline);
+    =
                                     ce->tls_crypt_v2_file, ce->tls_crypt_v=
2_file_inline);
         }
         else
         {
             tls_crypt_=
v2_init_client_key(&c->c1=2Eks=2Etls_wrap_key, &c->c1=2Eks=2Eoriginal_wrap_=
keydata,
-                                         &c->c1=2Eks=2Etls_crypt_=
v2_wkc, options->ce=2Etls_crypt_v2_file,
-                                 =
        options->ce=2Etls_crypt_v2_file_inline);
+                         =
                &c->c1=2Eks=2Etls_crypt_v2_wkc, ce->tls_crypt_v2_file,
+   =
                                      ce->tls_crypt_v2_file_inline);
      =
   }
         /* We have to ensure that the loaded tls-crypt key is small e=
nough
          * to fit into the initial hard reset v3 packet */
@@ -3112,=
19 +3110,53 @@
         /* empty ACK/message id, tls-crypt, Opcode, UDP, ip=
v6 */
         int required_size =3D 5 + wkc_len + tls_crypt_buf_overhead()=
 + 1 + 8 + 40;
 
-        if (required_size > c->options=2Ece=2Etls_mtu)
+ =
       if (required_size > ce->tls_mtu)
         {
             msg(M_WARN,=

                 "ERROR: tls-crypt-v2 client key too large to work with "
=
                 "requested --max-packet-size %d, requires at least "
     =
            "--max-packet-size %d=2E Packets will ignore requested "
      =
           "maximum packet size",
-                c->options=2Ece=2Etls_mt=
u, required_size);
+                ce->tls_mtu, required_size);
         }=

     }
 }
 
 /*
+ * Initialise a control-channel wrapping context (tls-aut=
h/tls-crypt) from a
+ * connection entry and the already-loaded tls-wrap ke=
y material=2E The context is
+ * cleared first, so it is left in TLS_WRAP_N=
ONE if neither tls-auth nor
+ * tls-crypt is configured=2E tls-crypt-v2 spe=
cifics (WKc, server key) are added
+ * by the caller afterwards=2E
+ */
+vo=
id
+init_tls_wrap_ctx(struct tls_wrap_ctx *tls_wrap, const struct connectio=
n_entry *ce, bool tls_client,
+                  const struct key_schedule =
*ks, struct packet_id_persist *pid_persist)
+{
+    CLEAR(*tls_wrap);
+
+  =
  /* TLS handshake authentication (--tls-auth) */
+    if (ce->tls_auth_fil=
e)
+    {
+        tls_wrap->mode =3D TLS_WRAP_AUTH;
+    }
+
+    /* TLS h=
andshake encryption (--tls-crypt) */
+    if (ce->tls_crypt_file || (ce->tl=
s_crypt_v2_file && tls_client))
+    {
+        tls_wrap->mode =3D TLS_WRAP=
_CRYPT;
+    }
+
+    if (tls_wrap->mode =3D=3D TLS_WRAP_AUTH || tls_wrap->=
mode =3D=3D TLS_WRAP_CRYPT)
+    {
+        tls_wrap->opt=2Ekey_ctx_bi =3D =
ks->tls_wrap_key;
+        tls_wrap->opt=2Epid_persist =3D pid_persist;
+  =
      tls_wrap->opt=2Eflags |=3D CO_PACKET_ID_LONG_FORM;
+        tls_wrap-=
>original_wrap_keydata =3D ks->original_wrap_keydata;
+    }
+}
+
+/*
  * I=
nitialize the persistent component of OpenVPN's TLS mode,
  * which is pres=
erved across SIGUSR1 resets=2E
  */
@@ -3195,7 +3227,7 @@
         init_key=
_type(&c->c1=2Eks=2Ekey_type, ciphername, options->authname, true, warn);
 =

         /* initialize tls-auth/crypt/crypt-v2 key */
-        do_init_tls=
_wrap_key(c);
+        do_init_tls_wrap_key(c, &c->options=2Ece);
 
       =
  /* initialise auth-token crypto support */
         if (c->options=2Eauth=
_token_generate)
@@ -3220,7 +3252,7 @@
          * tls-auth/crypt key can b=
e configured per connection block, therefore
          * we must reload it =
as it may have changed
          */
-        do_init_tls_wrap_key(c);
+    =
    do_init_tls_wrap_key(c, &c->options=2Ece);
     }
 }
 
@@ -3396,25 +342=
8,9 @@
         to=2Eekm_size =3D 0;
     }
 
-    /* TLS handshake authent=
ication (--tls-auth) */
-    if (options->ce=2Etls_auth_file)
-    {
-     =
   to=2Etls_wrap=2Emode =3D TLS_WRAP_AUTH;
-    }
-
-    /* TLS handshake e=
ncryption (--tls-crypt) */
-    if (options->ce=2Etls_crypt_file || (option=
s->ce=2Etls_crypt_v2_file && options->tls_client))
-    {
-        to=2Etls=
_wrap=2Emode =3D TLS_WRAP_CRYPT;
-    }
-
-    if (to=2Etls_wrap=2Emode =3D=
=3D TLS_WRAP_AUTH || to=2Etls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)
-    {
-  =
      to=2Etls_wrap=2Eopt=2Ekey_ctx_bi =3D c->c1=2Eks=2Etls_wrap_key;
-    =
    to=2Etls_wrap=2Eopt=2Epid_persist =3D &c->c1=2Epid_persist;
-        to=
=2Etls_wrap=2Eopt=2Eflags |=3D CO_PACKET_ID_LONG_FORM;
-        to=2Etls_wr=
ap=2Eoriginal_wrap_keydata =3D c->c1=2Eks=2Eoriginal_wrap_keydata;
-    }
+=
    /* Control-channel wrapping (--tls-auth / --tls-crypt) */
+    init_tls=
_wrap_ctx(&to=2Etls_wrap, &c->options=2Ece, options->tls_client, &c->c1=2Ek=
s,
+                      &c->c1=2Epid_persist);
 
     if (options->ce=2Et=
ls_crypt_v2_file)
     {
diff --git a/src/openvpn/init=2Eh b/src/openvpn/in=
it=2Eh
index ce8f74e=2E=2Efbe461b 100644
--- a/src/openvpn/init=2Eh
+++ b/s=
rc/openvpn/init=2Eh
@@ -73,6 +73,39 @@
 
 void do_test_crypto(struct contex=
t *o);
 
+/**
+ * @brief Load the tls-auth/tls-crypt(-v2) key material into=
 c->c1=2Eks=2E
+ *
+ * Reads the key from the file configured on connection=
 entry ce (--tls-auth,
+ * --tls-crypt or --tls-crypt-v2); a no-op when non=
e of them is set=2E May be
+ * called more than once (the key can be config=
ured per connection block, so it
+ * is reloaded for each connection)=2E
+ =
*
+ * @param c  The context whose c1=2Eks key schedule is populated=2E
+ * =
@param ce The connection entry whose tls-wrap key file is loaded=2E
+ */
+v=
oid do_init_tls_wrap_key(struct context *c, const struct connection_entry *=
ce);
+
+/**
+ * @brief Configure a control-channel wrapping context from a =
connection entry
+ *        and previously loaded tls-wrap key material=2E
=
+ *
+ * Sets tls_wrap to TLS_WRAP_AUTH (--tls-auth) or TLS_WRAP_CRYPT
+ * (=
--tls-crypt / client --tls-crypt-v2) and installs the key context, or
+ * l=
eaves it in TLS_WRAP_NONE when neither is configured=2E The key material mu=
st
+ * already have been loaded with do_init_tls_wrap_key()=2E tls-crypt-v2=
 specifics
+ * (the wrapped client key and the server key) are left to the =
caller=2E
+ *
+ * @param tls_wrap    The wrapping context to configure=2E
+=
 * @param ce          The connection entry selecting the wrapping mode=2E
+=
 * @param tls_client  Whether this is a TLS client (selects tls-crypt-v2 mo=
de)=2E
+ * @param ks          Key schedule holding the loaded tls-wrap key =
material=2E
+ * @param pid_persist Packet-id persistence object to attach t=
o the context=2E
+ */
+void init_tls_wrap_ctx(struct tls_wrap_ctx *tls_wrap=
, const struct connection_entry *ce,
+                       bool tls_clien=
t, const struct key_schedule *ks,
+                       struct packet_id_=
persist *pid_persist);
+
 void context_gc_free(struct context *c);
 
 bool =
do_up(struct context *c, bool pulled_options, uint64_t option_types_found);=


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7d8546da9ef06c=
2226ea77e461f9550d24894c61
Gerrit-Change-Number: 1749
Gerrit-PatchSet: 22
G=
errit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ralf_lici=
 <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--CBLkHxbG5pw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #22</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review+1 by ralf=
_lici</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">oob: Extract init_tls_wrap_ctx() control-channel wra=
p helper<br><br>Factor the tls-auth/tls-crypt wrapping-context setup out of=
<br>do_init_crypto_tls() into a reusable init_tls_wrap_ctx() helper, and<br=
>expose it in init=2Eh together with do_init_tls_wrap_key(), which now<br>t=
akes the connection entry to read its keys from instead of using<br>options=
=2Ece=2E Both call sites pass &amp;c-&gt;options=2Ece, so there is no behav=
ior<br>change=2E<br><br>This lets the client --server-probe path build the =
same control-channel<br>wrapping context before a connection is established=
, so the probe can be<br>wrapped with tls-auth/tls-crypt like any other con=
trol packet=2E<br><br>Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61<=
br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/op=
envpn/init=2Ec<br>M src/openvpn/init=2Eh<br>2 files changed, 86 insertions(=
+), 37 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/49/1749/22</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 529c5a3=2E=2Edd=
f60c6 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++=
 b/src/openvpn/init=2Ec</span><br><span>@@ -3056,13 +3056,13 @@</span><br><=
span> /*</span><br><span>  * Initialize the tls-auth/crypt key context</spa=
n><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stati=
c void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_init_tls_wra=
p_key(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_init_tl=
s_wrap_key(struct context *c, const struct connection_entry *ce)</span><br>=
<span> {</span><br><span>     const struct options *options =3D &amp;c-&gt;=
options;</span><br><span> </span><br><span>     /* TLS handshake authentica=
tion (--tls-auth) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (options-&gt;ce=2Etls_auth_file)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (ce-&gt;tls_auth_file)</span><br><span>     {</sp=
an><br><span>         /* Initialize key_type for tls-auth with auth only */=
</span><br><span>         CLEAR(c-&gt;c1=2Eks=2Etls_auth_key_type);</span><=
br><span>@@ -3077,33 +3077,31 @@</span><br><span>         }</span><br><span=
> </span><br><span>         crypto_read_openvpn_key(&amp;c-&gt;c1=2Eks=2Etl=
s_auth_key_type, &amp;c-&gt;c1=2Eks=2Etls_wrap_key,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                options-&gt=
;ce=2Etls_auth_file, options-&gt;ce=2Etls_auth_file_inline,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                optio=
ns-&gt;ce=2Ekey_direction, &quot;Control Channel Authentication&quot;,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
      &quot;tls-auth&quot;, &amp;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
          ce-&gt;tls_auth_file, ce-&gt;tls_auth_file_inline, ce-&gt;key_dir=
ection,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                    &quot;Control Channel Authentication&quot;, &quot;tls-a=
uth&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                       &amp;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata);</span><=
br><span>     }</span><br><span> </span><br><span>     /* TLS handshake enc=
ryption+authentication (--tls-crypt) */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (options-&gt;ce=2Etls_crypt_file)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;tls_crypt_file)</span=
><br><span>     {</span><br><span>         tls_crypt_init_key(&amp;c-&gt;c1=
=2Eks=2Etls_wrap_key, &amp;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                           opti=
ons-&gt;ce=2Etls_crypt_file, options-&gt;ce=2Etls_crypt_file_inline,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                           o=
ptions-&gt;tls_server);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                           ce-&gt;tls_crypt_file, ce-&gt;tls_crypt_file=
_inline, options-&gt;tls_server);</span><br><span>     }</span><br><span> <=
/span><br><span>     /* tls-crypt with client-specific keys (--tls-crypt-v2=
) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&=
gt;ce=2Etls_crypt_v2_file)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (ce-&gt;tls_crypt_v2_file)</span><br><span>     {</span><br><=
span>         if (options-&gt;tls_server)</span><br><span>         {</span>=
<br><span>             tls_crypt_v2_init_server_key(&amp;c-&gt;c1=2Eks=2Etl=
s_crypt_v2_server_key, true,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                                         options-&gt;ce=2Etls_crypt_=
v2_file,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                            options-&gt;ce=2Etls_crypt_v2_file_inline);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
                  ce-&gt;tls_crypt_v2_file, ce-&gt;tls_crypt_v2_file_inline=
);</span><br><span>         }</span><br><span>         else</span><br><span=
>         {</span><br><span>             tls_crypt_v2_init_client_key(&amp;=
c-&gt;c1=2Eks=2Etls_wrap_key, &amp;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
                  &amp;c-&gt;c1=2Eks=2Etls_crypt_v2_wkc, options-&gt;ce=2Et=
ls_crypt_v2_file,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                                     options-&gt;ce=2Etls_crypt_v2_file_inl=
ine);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                           &amp;c-&gt;c1=2Eks=2Etls_crypt_v2_wkc, ce-&gt;tl=
s_crypt_v2_file,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                      ce-&gt;tls_crypt_v2_file_inline);</sp=
an><br><span>         }</span><br><span>         /* We have to ensure that =
the loaded tls-crypt key is small enough</span><br><span>          * to fit=
 into the initial hard reset v3 packet */</span><br><span>@@ -3112,19 +3110=
,53 @@</span><br><span>         /* empty ACK/message id, tls-crypt, Opcode,=
 UDP, ipv6 */</span><br><span>         int required_size =3D 5 + wkc_len + =
tls_crypt_buf_overhead() + 1 + 8 + 40;</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (required_size &gt; c-&gt;opt=
ions=2Ece=2Etls_mtu)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (required_size &gt; ce-&gt;tls_mtu)</span><br><span>         {<=
/span><br><span>             msg(M_WARN,</span><br><span>                 &=
quot;ERROR: tls-crypt-v2 client key too large to work with &quot;</span><br=
><span>                 &quot;requested --max-packet-size %d, requires at l=
east &quot;</span><br><span>                 &quot;--max-packet-size %d=2E =
Packets will ignore requested &quot;</span><br><span>                 &quot=
;maximum packet size&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                c-&gt;options=2Ece=2Etls_mtu, required_size);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                ce-&gt;tls_=
mtu, required_size);</span><br><span>         }</span><br><span>     }</spa=
n><br><span> }</span><br><span> </span><br><span> /*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Initialise a control-channel wrapping =
context (tls-auth/tls-crypt) from a</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * connection entry and the already-loaded tls-wrap key mat=
erial=2E The context is</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * cleared first, so it is left in TLS_WRAP_NONE if neither tls-auth no=
r</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * tls-crypt is co=
nfigured=2E tls-crypt-v2 specifics (WKc, server key) are added</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * by the caller afterwards=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+init_tls_wrap_ctx(struct tls_wrap_ctx *tls_wrap, con=
st struct connection_entry *ce, bool tls_client,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                  const struct key_schedule *k=
s, struct packet_id_persist *pid_persist)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    CLEAR(*tls_wrap);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* TLS ha=
ndshake authentication (--tls-auth) */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (ce-&gt;tls_auth_file)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        tls_wrap-&gt;mode =3D TLS_WRAP_AUTH;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* TLS handshake encryption (--tls-crypt) */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;tls_crypt_file || (ce-&g=
t;tls_crypt_v2_file &amp;&amp; tls_client))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        tls_wrap-&gt;mode =3D TLS_WRAP_CRYPT;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (tls_wrap-&gt;mode =3D=3D TLS_WRAP_AUTH || tls_wrap-&gt;mode =3D=
=3D TLS_WRAP_CRYPT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_wr=
ap-&gt;opt=2Ekey_ctx_bi =3D ks-&gt;tls_wrap_key;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        tls_wrap-&gt;opt=2Epid_persist =3D pid=
_persist;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tl=
s_wrap-&gt;opt=2Eflags |=3D CO_PACKET_ID_LONG_FORM;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tls_wrap-&gt;original_wrap_keydat=
a =3D ks-&gt;original_wrap_keydata;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span>  * Initialize t=
he persistent component of OpenVPN&#39;s TLS mode,</span><br><span>  * whic=
h is preserved across SIGUSR1 resets=2E</span><br><span>  */</span><br><spa=
n>@@ -3195,7 +3227,7 @@</span><br><span>         init_key_type(&amp;c-&gt;c=
1=2Eks=2Ekey_type, ciphername, options-&gt;authname, true, warn);</span><br=
><span> </span><br><span>         /* initialize tls-auth/crypt/crypt-v2 key=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        do_init_tl=
s_wrap_key(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   do_init_tls_wrap_key(c, &amp;c-&gt;options=2Ece);</span><br><span> </spa=
n><br><span>         /* initialise auth-token crypto support */</span><br><=
span>         if (c-&gt;options=2Eauth_token_generate)</span><br><span>@@ -=
3220,7 +3252,7 @@</span><br><span>          * tls-auth/crypt key can be con=
figured per connection block, therefore</span><br><span>          * we must=
 reload it as it may have changed</span><br><span>          */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        do_init_tls_wrap_key(c);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        do_init_tls_w=
rap_key(c, &amp;c-&gt;options=2Ece);</span><br><span>     }</span><br><span=
> }</span><br><span> </span><br><span>@@ -3396,25 +3428,9 @@</span><br><spa=
n>         to=2Eekm_size =3D 0;</span><br><span>     }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* TLS handshake aut=
hentication (--tls-auth) */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (options-&gt;ce=2Etls_auth_file)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        to=2Etls_wrap=2Emode =3D TLS_WRAP_AUTH;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 /* TLS handshake encryption (--tls-crypt) */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (options-&gt;ce=2Etls_crypt_file || (options=
-&gt;ce=2Etls_crypt_v2_file &amp;&amp; options-&gt;tls_client))</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        to=2Etls_wrap=2Emode =3D TLS_WRAP_CRYPT;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (to=2Etls_wrap=2Emode =3D=3D TLS_WRAP_AUTH || to=2Et=
ls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        to=2Etls_wrap=2Eopt=2Ekey_ctx_bi =3D c-&gt;c1=2Eks=2Etls_wrap_key;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        to=2Etls_wrap=
=2Eopt=2Epid_persist =3D &amp;c-&gt;c1=2Epid_persist;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        to=2Etls_wrap=2Eopt=2Eflags |=3D CO=
_PACKET_ID_LONG_FORM;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        to=2Etls_wrap=2Eoriginal_wrap_keydata =3D c-&gt;c1=2Eks=2Eoriginal_=
wrap_keydata;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Control-channel=
 wrapping (--tls-auth / --tls-crypt) */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    init_tls_wrap_ctx(&amp;to=2Etls_wrap, &amp;c-&gt;op=
tions=2Ece, options-&gt;tls_client, &amp;c-&gt;c1=2Eks,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                      &amp;c-&gt;c1=2Ep=
id_persist);</span><br><span> </span><br><span>     if (options-&gt;ce=2Etl=
s_crypt_v2_file)</span><br><span>     {</span><br><span>diff --git a/src/op=
envpn/init=2Eh b/src/openvpn/init=2Eh</span><br><span>index ce8f74e=2E=2Efb=
e461b 100644</span><br><span>--- a/src/openvpn/init=2Eh</span><br><span>+++=
 b/src/openvpn/init=2Eh</span><br><span>@@ -73,6 +73,39 @@</span><br><span>=
 </span><br><span> void do_test_crypto(struct context *o);</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @brief Load the tls-auth/tls-cr=
ypt(-v2) key material into c-&gt;c1=2Eks=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Reads the key from the file configured on connection entry ce (--=
tls-auth,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --tls-c=
rypt or --tls-crypt-v2); a no-op when none of them is set=2E May be</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * called more than once (t=
he key can be configured per connection block, so it</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * is reloaded for each connection)=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param c  The context whose c1=2Eks =
key schedule is populated=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param ce The connection entry whose tls-wrap key file is loade=
d=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+void do_init_tls_wrap_key(struc=
t context *c, const struct connection_entry *ce);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @b=
rief Configure a control-channel wrapping context from a connection entry</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        and previou=
sly loaded tls-wrap key material=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Sets tls_wrap to TLS_WRAP_AUTH (--tls-auth) or TLS_WRAP_CRYPT</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * (--tls-crypt / client --tls-=
crypt-v2) and installs the key context, or</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * leaves it in TLS_WRAP_NONE when neither is config=
ured=2E The key material must</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * already have been loaded with do_init_tls_wrap_key()=2E tls-cr=
ypt-v2 specifics</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
(the wrapped client key and the server key) are left to the caller=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param tls_wrap    The wrapping contex=
t to configure=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param ce          The connection entry selecting the wrapping mode=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param tls_client  W=
hether this is a TLS client (selects tls-crypt-v2 mode)=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param ks          Key schedule h=
olding the loaded tls-wrap key material=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param pid_persist Packet-id persistence object t=
o attach to the context=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void init=
_tls_wrap_ctx(struct tls_wrap_ctx *tls_wrap, const struct connection_entry =
*ce,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
        bool tls_client, const struct key_schedule *ks,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                       struct packet_id=
_persist *pid_persist);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> void context_gc_free(struct context *c);</span><br><s=
pan> </span><br><span> bool do_up(struct context *c, bool pulled_options, u=
int64_t option_types_found);</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail"=
>change 1749</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1749 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 22 </div>
<div style=3D"display:none"> Gerrit-Owner: sti=
pa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@=
gmail=2Ecom&gt; </div>

</body></html>
--CBLkHxbG5pw=--


--===============1090144413943273509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1090144413943273509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1090144413943273509==--

