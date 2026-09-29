Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5608CA5FAE
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JXOPyWq5c6peXd9PjFs93CqXWupbKCQnvEmlsiXtvZo=; b=KBMEBY8Y6qx7Sk6+FlaqPvcinC
	U0xtr0C0yHcrRNBxf41vhZemN8HG15rhIrQgaaJ/VHV9lL9WXcopFCTOkKDAhp9rRd8GB4NxPT+Zt
	LEFASSfgbIil3GzxEidq8O0CnuJ5BgcmezenJ47WfGwDyzo0dga896V6gW9yPq47sQ1s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBXhk-0002ul-CO;
	Tue, 29 Sep 2026 13:17:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBXhi-0002uV-P0
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:17:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Vbap3A64tOQs5zFW5zeQEQnkwvXxt5C0eBiapxqw7Zc=; b=AMsHkcEevUt9DvJ9kbJcgSrbGj
 q73FuFCFKGzQl/pt0px1xmsHNILYxmFk2oQ4OMZkrZya7EeUXppE7u1nNw4O6SYvqWk1GcX/jhBhB
 UxZWstx/PneebjetsHDdrONAagl8gmCrUEJCYzF2O+1kSaLHMvxegk1F4FlJuz7qXVmg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Vbap3A64tOQs5zFW5zeQEQnkwvXxt5C0eBiapxqw7Zc=; b=H
 YqB8KhusN0SPEJ4BVhFrcA2wQ/FcSklHTP3Q9nLvTg9xO0Prx7kxW5f8N42vLVf7Lxq+V291N/kV2
 TtjA+9KFp8JE+5vaBFX+nUckr5+8j4JJ36HQ/tEm8xn54tbXtYN559I/ZuqD270Di6cSb0R3nPANn
 /OVR3jAbE1HOsgyM=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBXhd-0001Fm-OP for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:17:04 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485933b24c3so2564903f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 06:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790687815; x=1791292615; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Vbap3A64tOQs5zFW5zeQEQnkwvXxt5C0eBiapxqw7Zc=;
 b=Kn8P9BezyN/33V2uoZ+be7GFFYdiEa9RSQT/LZUo6qWuVL4FHh+tgSnPlMgR2C0VsC
 C3GDjKxyK3tySg/tnjFTmDpVJQlHUvWaaEwScyWwWyTLDCijxr+padNAZrxzrlN6mpCB
 q+BhFoI0DKm9uuSzon9la1y3s97OfwNar1a1wsZJzqbXD4rLq4hU5U29FIriocvuGnd8
 r/SDupUIH+Scia9cjSbmaPIzaJ4Xu7YGeY8O3h9AmuAXS7TeoiDvHa6tRjt9AiMxEYFJ
 0rzye8aeIuFKcrwN+9l9B0ywpIKir73hT0l3jCFUJfC82sJgWDw/lcHhbTCSdoUoNo3z
 bRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790687815; x=1791292615;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Vbap3A64tOQs5zFW5zeQEQnkwvXxt5C0eBiapxqw7Zc=;
 b=obUUpDtA0qBG9Tu6+pn/h5foB+t9sQzzFGI9iEpaPWQXYbznc9B2YBEsL0MnKNF4zR
 1IQiTpp58N6R9f/jujVHSFgKzmnNCtFEWSrpyzi2JkWDNTRBsytSA0Yqq+1cwe27/5dn
 ozPB36S7ZC0VQcWTtvTozGU8u0qA7Ii0qQEt2nLeSXD0VfDbPTRL63CsAWtwKEUucspe
 VRymYFFs1M7NShSWG8Ofu5AKntelIBQ/FRuDEonp0bIOO5TOegAtHKwKs3UTEF0x75O3
 cfC+XHqTPbeAKCffpxoFPbp9OJV5FjgNaGs1PzxHaVyZb8KEAWNouDfG6F5taNIeUyNF
 Qjhg==
X-Gm-Message-State: AFq9FYLECuNTe94Nm/flS/TsA1sGugaFzXEuX/94Eu6FvU6G8dQCCbBl
 F6NmhoPd9IhUyU04p9rhvvHu9sZ3Z0y7e+gPQJgn6fCT8r6GD8A6qI77PBdK0/zF0KtBa3ZVe4q
 RGC1TEJt6DGzpx/Nbg1RNd7PcwXZRKXoG8x8IF0DpB5r4fvNNBypQmLKF8uuEN/x6Fb4Dy0a+Az
 wyHHtQeA==
X-Gm-Gg: AYBFou0ib6R+BfJZKlaU1FCAj+7AiUlbN+h+kICtbXHRdK82DNfNCMT4QoFOaS8GiGS
 QaHUKoxDFknJ0NudujOdPXB0G20qll7fpHVoxMKYu6iXhBscuOadz5+zu3W6S+GPmlRzVHt9YrL
 wWEgw5h3KF7G/CfdMF3EiW8s2yMYguVekoJdYt/arv3geqX+9+vR/3dOHXbSbIGMDKnrmAmVAb0
 Ib3OXdvKxEDn8mKusbDFI3rRFogFMRk9VGIj6C1sqrCyu8niChpmTJPVZzENcoYX75VrxNT9iYT
 QrrBrKgtt7UuLdfgOh5NSQk6AXl0RdOhbpoqe/vwbdQm+EwJCfUGL7Ou7FdFMV63pbytJXsbYBj
 7lGGxx4gosgNp2H/AlgIYw+roR5xBJWC+jH4hA25lvMA4LkiTCh0XQ9QITsbsq33z6ZTvsx4lpj
 8AYSDhW3JBE8dsD+54lbOrUBufrvj/MZv2o/FtQJfcNp48tMCWmC3AklZHi3ZN64mqSAhlhqzYZ
 IoLvcyTKy0DP7r8JN7L+DVhiMpGxe727w554yrgF0sRFxu0IQxndBhMkl6W+7uQgiTRIUa5af3s
 3TZGEXO3gfLWfBwyCjT88O3aSvAow3kgsouIMhg0v+oxpWNYaOjzPmpexwvj
X-Received: by 2002:a05:6000:178c:b0:485:8ee5:5ffa with SMTP id
 ffacd0b85a97d-48871703b57mr29694186f8f.38.1790687814049; 
 Tue, 29 Sep 2026 06:16:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af506fdc1sm3972886f8f.21.2026.09.29.06.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:16:53 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 13:16:31 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 29
X-Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
X-Gerrit-Change-Number: 1749
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1749?usp=email>
X-Gerrit-Commit: 8ae8b68ff2e316997d1ba6d832dbcfb9cdc159ee
In-Reply-To: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
References: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk3ZDg1NDZkYTllZjA2YzIyMjZlYTc3ZTQ2MWY5NTUwZDI0ODk0YzYxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9db640cc1909153eb7eb47eb6d850240fe1be64b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBXhd-0001Fm-OP
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
Content-Type: multipart/mixed; boundary="===============7270930114835773834=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7270930114835773834==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="F3hcg4K7qyo="; charset=UTF-8

--F3hcg4K7qyo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail

to look a=
t the new patch set (#29)=2E

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

Factor the tls-auth/tls-crypt wrapping-context setup out of=

do_init_crypto_tls() into a reusable init_tls_wrap_ctx() helper, and
expos=
e it in init=2Eh together with do_init_tls_wrap_key(), which now
takes the =
connection entry to read its keys from instead of using
options=2Ece=2E Bot=
h call sites pass &c->options=2Ece, so there is no behavior
change=2E

This=
 lets the client --server-probe path build the same control-channel
wrappin=
g context before a connection is established, so the probe can be
wrapped w=
ith tls-auth/tls-crypt like any other control packet=2E

Change-Id: I7d8546=
da9ef06c2226ea77e461f9550d24894c61
Signed-off-by: Lev Stipakov <lev@openvpn=
=2Enet>
---
M src/openvpn/init=2Ec
M src/openvpn/init=2Eh
2 files changed, =
79 insertions(+), 37 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/49/1749/29

diff --git a/src/openvpn/init=2Ec b=
/src/openvpn/init=2Ec
index 529c5a3=2E=2Efb1aa2a 100644
--- a/src/openvpn/i=
nit=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3056,13 +3056,13 @@
 /*
  * Initiali=
ze the tls-auth/crypt key context
  */
-static void
-do_init_tls_wrap_key(s=
truct context *c)
+void
+do_init_tls_wrap_key(struct context *c, const stru=
ct connection_entry *ce)
 {
     const struct options *options =3D &c->opti=
ons;
 
     /* TLS handshake authentication (--tls-auth) */
-    if (option=
s->ce=2Etls_auth_file)
+    if (ce->tls_auth_file)
     {
         /* Initi=
alize key_type for tls-auth with auth only */
         CLEAR(c->c1=2Eks=2Et=
ls_auth_key_type);
@@ -3077,33 +3077,31 @@
         }
 
         crypto_rea=
d_openvpn_key(&c->c1=2Eks=2Etls_auth_key_type, &c->c1=2Eks=2Etls_wrap_key,
=
-                                options->ce=2Etls_auth_file, options->ce=
=2Etls_auth_file_inline,
-                                options->ce=2Ekey=
_direction, "Control Channel Authentication",
-                            =
    "tls-auth", &c->c1=2Eks=2Eoriginal_wrap_keydata);
+                    =
            ce->tls_auth_file, ce->tls_auth_file_inline, ce->key_direction,=

+                                "Control Channel Authentication", "tls-au=
th",
+                                &c->c1=2Eks=2Eoriginal_wrap_keydata);=

     }
 
     /* TLS handshake encryption+authentication (--tls-crypt) */
=
-    if (options->ce=2Etls_crypt_file)
+    if (ce->tls_crypt_file)
     {
=
         tls_crypt_init_key(&c->c1=2Eks=2Etls_wrap_key, &c->c1=2Eks=2Eorigi=
nal_wrap_keydata,
-                           options->ce=2Etls_crypt_file,=
 options->ce=2Etls_crypt_file_inline,
-                           options->=
tls_server);
+                           ce->tls_crypt_file, ce->tls_crypt_=
file_inline, options->tls_server);
     }
 
     /* tls-crypt with client-s=
pecific keys (--tls-crypt-v2) */
-    if (options->ce=2Etls_crypt_v2_file)
=
+    if (ce->tls_crypt_v2_file)
     {
         if (options->tls_server)
  =
       {
             tls_crypt_v2_init_server_key(&c->c1=2Eks=2Etls_crypt_=
v2_server_key, true,
-                                         options->ce=
=2Etls_crypt_v2_file,
-                                         options->ce=
=2Etls_crypt_v2_file_inline);
+                                         ce-=
>tls_crypt_v2_file, ce->tls_crypt_v2_file_inline);
         }
         else=

         {
             tls_crypt_v2_init_client_key(&c->c1=2Eks=2Etls_wra=
p_key, &c->c1=2Eks=2Eoriginal_wrap_keydata,
-                              =
           &c->c1=2Eks=2Etls_crypt_v2_wkc, options->ce=2Etls_crypt_v2_file,=

-                                         options->ce=2Etls_crypt_v2_file_=
inline);
+                                         &c->c1=2Eks=2Etls_crypt_=
v2_wkc, ce->tls_crypt_v2_file,
+                                         ce=
->tls_crypt_v2_file_inline);
         }
         /* We have to ensure that =
the loaded tls-crypt key is small enough
          * to fit into the initia=
l hard reset v3 packet */
@@ -3112,18 +3110,45 @@
         /* empty ACK/mes=
sage id, tls-crypt, Opcode, UDP, ipv6 */
         int required_size =3D 5 +=
 wkc_len + tls_crypt_buf_overhead() + 1 + 8 + 40;
 
-        if (required_s=
ize > c->options=2Ece=2Etls_mtu)
+        if (required_size > ce->tls_mtu)
=
         {
             msg(M_WARN,
                 "ERROR: tls-crypt-v2 c=
lient key too large to work with "
                 "requested --max-packet=
-size %d, requires at least "
                 "--max-packet-size %d=2E Pac=
kets will ignore requested "
                 "maximum packet size",
-     =
           c->options=2Ece=2Etls_mtu, required_size);
+                ce->=
tls_mtu, required_size);
         }
     }
 }
 
+void
+init_tls_wrap_ctx(st=
ruct tls_wrap_ctx *tls_wrap, const struct connection_entry *ce, bool tls_cl=
ient,
+                  const struct key_schedule *ks, struct packet_id_pe=
rsist *pid_persist)
+{
+    CLEAR(*tls_wrap);
+
+    /* TLS handshake authe=
ntication (--tls-auth) */
+    if (ce->tls_auth_file)
+    {
+        tls_w=
rap->mode =3D TLS_WRAP_AUTH;
+    }
+
+    /* TLS handshake encryption (--t=
ls-crypt) */
+    if (ce->tls_crypt_file || (ce->tls_crypt_v2_file && tls_c=
lient))
+    {
+        tls_wrap->mode =3D TLS_WRAP_CRYPT;
+    }
+
+    if=
 (tls_wrap->mode =3D=3D TLS_WRAP_AUTH || tls_wrap->mode =3D=3D TLS_WRAP_CRY=
PT)
+    {
+        tls_wrap->opt=2Ekey_ctx_bi =3D ks->tls_wrap_key;
+     =
   tls_wrap->opt=2Epid_persist =3D pid_persist;
+        tls_wrap->opt=2Efl=
ags |=3D CO_PACKET_ID_LONG_FORM;
+        tls_wrap->original_wrap_keydata =
=3D ks->original_wrap_keydata;
+    }
+}
+
 /*
  * Initialize the persisten=
t component of OpenVPN's TLS mode,
  * which is preserved across SIGUSR1 re=
sets=2E
@@ -3195,7 +3220,7 @@
         init_key_type(&c->c1=2Eks=2Ekey_type=
, ciphername, options->authname, true, warn);
 
         /* initialize tls-=
auth/crypt/crypt-v2 key */
-        do_init_tls_wrap_key(c);
+        do_in=
it_tls_wrap_key(c, &c->options=2Ece);
 
         /* initialise auth-token c=
rypto support */
         if (c->options=2Eauth_token_generate)
@@ -3220,7 =
+3245,7 @@
          * tls-auth/crypt key can be configured per connection =
block, therefore
          * we must reload it as it may have changed
     =
     */
-        do_init_tls_wrap_key(c);
+        do_init_tls_wrap_key(c, =
&c->options=2Ece);
     }
 }
 
@@ -3396,25 +3421,9 @@
         to=2Eekm_siz=
e =3D 0;
     }
 
-    /* TLS handshake authentication (--tls-auth) */
-   =
 if (options->ce=2Etls_auth_file)
-    {
-        to=2Etls_wrap=2Emode =3D =
TLS_WRAP_AUTH;
-    }
-
-    /* TLS handshake encryption (--tls-crypt) */
-=
    if (options->ce=2Etls_crypt_file || (options->ce=2Etls_crypt_v2_file &&=
 options->tls_client))
-    {
-        to=2Etls_wrap=2Emode =3D TLS_WRAP_CR=
YPT;
-    }
-
-    if (to=2Etls_wrap=2Emode =3D=3D TLS_WRAP_AUTH || to=2Etl=
s_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)
-    {
-        to=2Etls_wrap=2Eopt=2E=
key_ctx_bi =3D c->c1=2Eks=2Etls_wrap_key;
-        to=2Etls_wrap=2Eopt=2Epi=
d_persist =3D &c->c1=2Epid_persist;
-        to=2Etls_wrap=2Eopt=2Eflags |=
=3D CO_PACKET_ID_LONG_FORM;
-        to=2Etls_wrap=2Eoriginal_wrap_keydata =
=3D c->c1=2Eks=2Eoriginal_wrap_keydata;
-    }
+    /* Control-channel wrap=
ping (--tls-auth / --tls-crypt) */
+    init_tls_wrap_ctx(&to=2Etls_wrap, &=
c->options=2Ece, options->tls_client, &c->c1=2Eks,
+                      &=
c->c1=2Epid_persist);
 
     if (options->ce=2Etls_crypt_v2_file)
     {
di=
ff --git a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh
index ce8f74e=2E=2Ef=
be461b 100644
--- a/src/openvpn/init=2Eh
+++ b/src/openvpn/init=2Eh
@@ -73,=
6 +73,39 @@
 
 void do_test_crypto(struct context *o);
 
+/**
+ * @brief Lo=
ad the tls-auth/tls-crypt(-v2) key material into c->c1=2Eks=2E
+ *
+ * Read=
s the key from the file configured on connection entry ce (--tls-auth,
+ * =
--tls-crypt or --tls-crypt-v2); a no-op when none of them is set=2E May be
=
+ * called more than once (the key can be configured per connection block, =
so it
+ * is reloaded for each connection)=2E
+ *
+ * @param c  The context=
 whose c1=2Eks key schedule is populated=2E
+ * @param ce The connection en=
try whose tls-wrap key file is loaded=2E
+ */
+void do_init_tls_wrap_key(st=
ruct context *c, const struct connection_entry *ce);
+
+/**
+ * @brief Conf=
igure a control-channel wrapping context from a connection entry
+ *       =
 and previously loaded tls-wrap key material=2E
+ *
+ * Sets tls_wrap to TL=
S_WRAP_AUTH (--tls-auth) or TLS_WRAP_CRYPT
+ * (--tls-crypt / client --tls-=
crypt-v2) and installs the key context, or
+ * leaves it in TLS_WRAP_NONE w=
hen neither is configured=2E The key material must
+ * already have been lo=
aded with do_init_tls_wrap_key()=2E tls-crypt-v2 specifics
+ * (the wrapped=
 client key and the server key) are left to the caller=2E
+ *
+ * @param tl=
s_wrap    The wrapping context to configure=2E
+ * @param ce          The c=
onnection entry selecting the wrapping mode=2E
+ * @param tls_client  Wheth=
er this is a TLS client (selects tls-crypt-v2 mode)=2E
+ * @param ks       =
   Key schedule holding the loaded tls-wrap key material=2E
+ * @param pid_=
persist Packet-id persistence object to attach to the context=2E
+ */
+void=
 init_tls_wrap_ctx(struct tls_wrap_ctx *tls_wrap, const struct connection_e=
ntry *ce,
+                       bool tls_client, const struct key_schedul=
e *ks,
+                       struct packet_id_persist *pid_persist);
+
 v=
oid context_gc_free(struct context *c);
 
 bool do_up(struct context *c, bo=
ol pulled_options, uint64_t option_types_found);

-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
G=
errit-Change-Number: 1749
Gerrit-PatchSet: 29
Gerrit-Owner: stipa <lstipako=
v@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ralf_lici <ralf@man=
delbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attent=
ion: plaisthos <arne-openvpn@rfc2549=2Eorg>

--F3hcg4K7qyo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #29</strong> to this change=2E</p><p><a href=3D"http://g=
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
envpn/init=2Ec<br>M src/openvpn/init=2Eh<br>2 files changed, 79 insertions(=
+), 37 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/49/1749/29</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 529c5a3=2E=2Efb=
1aa2a 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++=
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
 into the initial hard reset v3 packet */</span><br><span>@@ -3112,18 +3110=
,45 @@</span><br><span>         /* empty ACK/message id, tls-crypt, Opcode,=
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
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in=
it_tls_wrap_ctx(struct tls_wrap_ctx *tls_wrap, const struct connection_entr=
y *ce, bool tls_client,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                  const struct key_schedule *ks, struct packet_id_persi=
st *pid_persist)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(*tls_wrap);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* TLS handshake authentication (-=
-tls-auth) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (ce-&gt;tls_auth_file)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tl=
s_wrap-&gt;mode =3D TLS_WRAP_AUTH;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* TLS handsha=
ke encryption (--tls-crypt) */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (ce-&gt;tls_crypt_file || (ce-&gt;tls_crypt_v2_file &amp;=
&amp; tls_client))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_wra=
p-&gt;mode =3D TLS_WRAP_CRYPT;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tls_wrap-&gt;m=
ode =3D=3D TLS_WRAP_AUTH || tls_wrap-&gt;mode =3D=3D TLS_WRAP_CRYPT)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        tls_wrap-&gt;opt=2Ekey_ctx_bi =
=3D ks-&gt;tls_wrap_key;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        tls_wrap-&gt;opt=2Epid_persist =3D pid_persist;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        tls_wrap-&gt;opt=2Eflags |=
=3D CO_PACKET_ID_LONG_FORM;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        tls_wrap-&gt;original_wrap_keydata =3D ks-&gt;original_wrap=
_keydata;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * =
Initialize the persistent component of OpenVPN&#39;s TLS mode,</span><br><s=
pan>  * which is preserved across SIGUSR1 resets=2E</span><br><span>@@ -319=
5,7 +3220,7 @@</span><br><span>         init_key_type(&amp;c-&gt;c1=2Eks=2E=
key_type, ciphername, options-&gt;authname, true, warn);</span><br><span> <=
/span><br><span>         /* initialize tls-auth/crypt/crypt-v2 key */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        do_init_tls_wrap_ke=
y(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        do_ini=
t_tls_wrap_key(c, &amp;c-&gt;options=2Ece);</span><br><span> </span><br><sp=
an>         /* initialise auth-token crypto support */</span><br><span>    =
     if (c-&gt;options=2Eauth_token_generate)</span><br><span>@@ -3220,7 +3=
245,7 @@</span><br><span>          * tls-auth/crypt key can be configured p=
er connection block, therefore</span><br><span>          * we must reload i=
t as it may have changed</span><br><span>          */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        do_init_tls_wrap_key(c);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        do_init_tls_wrap_key(c=
, &amp;c-&gt;options=2Ece);</span><br><span>     }</span><br><span> }</span=
><br><span> </span><br><span>@@ -3396,25 +3421,9 @@</span><br><span>       =
  to=2Eekm_size =3D 0;</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /* TLS handshake authenticati=
on (--tls-auth) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (options-&gt;ce=2Etls_auth_file)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       to=2Etls_wrap=2Emode =3D TLS_WRAP_AUTH;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* TLS h=
andshake encryption (--tls-crypt) */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (options-&gt;ce=2Etls_crypt_file || (options-&gt;ce=
=2Etls_crypt_v2_file &amp;&amp; options-&gt;tls_client))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        to=2Etls_wrap=2Emode =3D TLS_WRAP_CRYPT;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (to=2Etls_wrap=2Emode =3D=3D TLS_WRAP_AUTH || to=2Etls_wr=
ap=2Emode =3D=3D TLS_WRAP_CRYPT)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   to=2Etls_wrap=2Eopt=2Ekey_ctx_bi =3D c-&gt;c1=2Eks=2Etls_wrap_key;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        to=2Etls_wrap=2Eopt=
=2Epid_persist =3D &amp;c-&gt;c1=2Epid_persist;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        to=2Etls_wrap=2Eopt=2Eflags |=3D CO_PACKE=
T_ID_LONG_FORM;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  to=2Etls_wrap=2Eoriginal_wrap_keydata =3D c-&gt;c1=2Eks=2Eoriginal_wrap_k=
eydata;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* Control-channel wrapp=
ing (--tls-auth / --tls-crypt) */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    init_tls_wrap_ctx(&amp;to=2Etls_wrap, &amp;c-&gt;options=
=2Ece, options-&gt;tls_client, &amp;c-&gt;c1=2Eks,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                      &amp;c-&gt;c1=2Epid_pe=
rsist);</span><br><span> </span><br><span>     if (options-&gt;ce=2Etls_cry=
pt_v2_file)</span><br><span>     {</span><br><span>diff --git a/src/openvpn=
/init=2Eh b/src/openvpn/init=2Eh</span><br><span>index ce8f74e=2E=2Efbe461b=
 100644</span><br><span>--- a/src/openvpn/init=2Eh</span><br><span>+++ b/sr=
c/openvpn/init=2Eh</span><br><span>@@ -73,6 +73,39 @@</span><br><span> </sp=
an><br><span> void do_test_crypto(struct context *o);</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @brief Load the tls-auth/tls-crypt(-=
v2) key material into c-&gt;c1=2Eks=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Reads the key from the file configured on connection entry ce (--tls-a=
uth,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --tls-crypt =
or --tls-crypt-v2); a no-op when none of them is set=2E May be</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * called more than once (the ke=
y can be configured per connection block, so it</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * is reloaded for each connection)=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param c  The context whose c1=2Eks key sc=
hedule is populated=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param ce The connection entry whose tls-wrap key file is loaded=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void do_init_tls_wrap_key(struct cont=
ext *c, const struct connection_entry *ce);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brief C=
onfigure a control-channel wrapping context from a connection entry</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *        and previously lo=
aded tls-wrap key material=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Sets=
 tls_wrap to TLS_WRAP_AUTH (--tls-auth) or TLS_WRAP_CRYPT</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * (--tls-crypt / client --tls-crypt-=
v2) and installs the key context, or</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * leaves it in TLS_WRAP_NONE when neither is configured=
=2E The key material must</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * already have been loaded with do_init_tls_wrap_key()=2E tls-crypt-=
v2 specifics</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (the=
 wrapped client key and the server key) are left to the caller=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param tls_wrap    The wrapping context to =
configure=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am ce          The connection entry selecting the wrapping mode=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param tls_client  Whethe=
r this is a TLS client (selects tls-crypt-v2 mode)=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param ks          Key schedule holdin=
g the loaded tls-wrap key material=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param pid_persist Packet-id persistence object to att=
ach to the context=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void init_tls_=
wrap_ctx(struct tls_wrap_ctx *tls_wrap, const struct connection_entry *ce,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
   bool tls_client, const struct key_schedule *ks,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                       struct packet_id_pers=
ist *pid_persist);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> void context_gc_free(struct context *c);</span><br><span> =
</span><br><span> bool do_up(struct context *c, bool pulled_options, uint64=
_t option_types_found);</span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail">change 1749</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7d8546da9e=
f06c2226ea77e461f9550d24894c61 </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 1749 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 29 =
</div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici =
&lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=

</body></html>
--F3hcg4K7qyo=--


--===============7270930114835773834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7270930114835773834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7270930114835773834==--

