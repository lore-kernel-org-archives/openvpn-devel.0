Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CB3606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=g2ItHE+P;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=U5Rqu1fW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=H8Orcwlt;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=a4cbGHSJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9jpPfjtexUd2qERR2+3BSLRVH/E9k1M7hjormqV8Yhw=; b=g2ItHE+PoAlXEM5AJmneYTIzBo
	YLuue0WekO9rpK2yuq0U2CGdT2OL+96SEpscWnC/dALutj2Ur52mniB3ukI7213sNKHhDQeCuoeyL
	y8qOOB9qGyWl1rQ9sC2aLl398UiSJ1NKJmWTWIu9SrYEjg+DYma8iyi/Qj6RLblR6Cgc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVtQg-000000007nf-3dU0;
	Tue, 24 Nov 2026 16:31:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVtQg-000000007nZ-1AJq
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 16:31:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2GQuzvrirkwcgEioI7W3NOB560ZZz/gTkwGkgKB1q8U=; b=U5Rqu1fWj8vUBC1nVzYLyD9WxU
 JwhOEULNoWYUci1Xj41+7FxTt1KBvvT23s3ZdU/fFimOQuKypfu1aJeiqmqYxUjvPaEBmio/YyHg1
 sudhi6ZV0v36CG8BCfIQH7JXar9l/z8iNpvVNDlt4LXFDbOq2nYznAncl5WxZhPfLIl0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2GQuzvrirkwcgEioI7W3NOB560ZZz/gTkwGkgKB1q8U=; b=H8OrcwltWfZu4tlYtdDXyD+J1g
 VeglgwkBYLLMnJY0qzQkGr1/j5WEGTSfFKTQfAZRVfHgG7M257Beh4U7nTMZuLhYr5xJOXK1XnH+E
 O+waJBf16d9InZRUfRBzysKHOCKfZU7wNaCoqOOZXYOBdl4J0kz6czIT9G411++bddzY=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVtQc-0000000089P-47It for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 16:31:38 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb6c7b6dbdso44223995e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 08:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795537888; x=1796142688; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2GQuzvrirkwcgEioI7W3NOB560ZZz/gTkwGkgKB1q8U=;
 b=a4cbGHSJtu9iOvZA/EqM3aTQorYy1YUCUQxu9d5eq0WzTuhkgJqyOPUFejlDiicACh
 wzn3Sdze3VVU2a3+nbcNezX6lVpMvYB5s8T+//EXL12U+rAcCzsQEf61sZ/mRjWqdw5b
 JnimrXEiNZlJj9OvNTGQxGR4xmn5I7ZbJ1YpWghyOG01XxkgOjXoIvaQXrlYJe2aUdiS
 TIlHD4ITr2T1/diAtkVkhZG45JNV4/p/iwBlIEpnwoqi5gNe8BkcznqS32JAa6qw4Fj6
 mtRYG5uwgX/xy5aZ2bZwPTp9JAQvvyqzC7k8qhaVTCHWRkjkAaj0Y+q0MBukt0EfHwAi
 HtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795537888; x=1796142688;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2GQuzvrirkwcgEioI7W3NOB560ZZz/gTkwGkgKB1q8U=;
 b=Eh/fcPDQmMc0/CuwSNMNYnV/CKy1lJ4pBrFjx4xxRNFaT3g7I7cCIhdH/4Rd/OPgPt
 gj2AT1LvwBwK3QbAtHcpreAfIjeFbWFU5eZ7se86Ql6SG9Pd6JQbAoNQR6Q9UHDxvToy
 cmGoqZzuTWwQnvfHkjRFKapMtsN87fj5x+QfogWMmkxQbLi08O5xl6uimfXu8PNE40fF
 LWL7LCVcGPLu3gH9PbnhfmKIbHtYgaP0ywgFRSNFWNRSA4kveOa2knghROdj927SV1HZ
 2lN9ZQdj914MspXjODVp4Ng6+g86nWpodA6n7ie0xqj66ioyb27dPe0Ib1gXnAlrl5aW
 V5UA==
X-Gm-Message-State: APuU4Z+TE3eYfuSAC2wLaEzkjlo52cKxhR2Z51LdZHkabdKe14Qd7eKJ
 TI5GO6G1v+dVW71x9BSeVTua0nLcA54k6urdNx2vy+U6IZANFDSz7pCjDaACcQIiFXYCcaSVsaq
 Z3YihR9rc1BPa27ERlNA9oKPS73aHLtsDj4poU8C6Irwu/hZaNUYkN5oeaynYeqGll6nS
X-Gm-Gg: AZFdTZdywynowSuR4iNdvZSwhmhz0/uvOsmJhVIDXsj/zPIYj+IPnPvwixX/vJwbU7j
 go2keGDe2SDnzCc/X/HLrMhhwArXK7HcHY+FNDb58iXfsXCw+WCaPJ+7lv22vu8EYD/DTPX1CHJ
 w4Uif4QKQ1ENEWbUx6TOYeyOKaVJMtvHVIW0rYlIeDuiqll6pM13C1OgeEgR3fWnCxP8jWF+2xg
 9ys8q8uRLkCisGs69C5PcGMYeq47R1Qtd9AtcosmsW14gJRSqTVI8v+x+rdlioE4+9NSdirK+lu
 MNfTYTpJfcrROuSA31bf8FiZgJXoUoMlXSgEnv1NMWERhjNV6D4H3SDXrqYDi8ED9XlA1eHNOR+
 OwcEPq68MzcX+6b3DKkpUKXjGDGKR/4DKMcCiJbE9bbug3/cgB1Z2szd/iSIRz+bkyvL2vWKAgR
 nw7bN9H5XP4JlCi5vHERVvhWyujC6wqCPbgHBeza3KcY+ToRvk5Rb6y4QBpJ1fZfS5Y+v8L5dX8
 ir4rj7cKZ0Eq8pm4xhF21/R4pO67MNihc92RGr5J891hO/zl8zdM995ogTF+z39BLisNlibR6Mm
 +iYH450w5I+Y/xkECZTjwrKy4hr6RjDWOQqq0lax/jYotuCacp84lTpDzhm84HhY/wNLag9m/Qw
 5bhbkBUDOs8J1GJmdmyp02tqmX4JDS9LaKCGuI0BBsdJ9Jd8nrff2sbsi2F2d+UcG3MBY7PSmpJ
 LKAPnRT8mGLZYyYwZ0N3Kmi29aEatNmkXT2OCgbg==
X-Received: by 2002:a05:600c:8210:b0:4bb:6a2d:b438 with SMTP id
 5b1f17b1804b1-4bb88786c81mr307144305e9.0.1795537888221; 
 Tue, 24 Nov 2026 08:31:28 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a12acsm476704655e9.8.2026.11.24.08.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:31:27 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 16:31:26 +0000
To: Lev Stipakov <lstipakov@gmail.com>, Ralf Lici <ralf@mandelbit.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 34
X-Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
X-Gerrit-Change-Number: 1749
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1749?usp=email>
X-Gerrit-Commit: a8b521fddb1f35d045db6834b542a8201867b7c2
In-Reply-To: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
References: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk3ZDg1NDZkYTllZjA2YzIyMjZlYTc3ZTQ2MWY5NTUwZDI0ODk0YzYxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8a17dc23b3441372cc4581333a71855678220365-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVtQc-0000000089P-47It
Subject: [Openvpn-devel] [M] Change in openvpn[master]: init: Extract
 init_tls_wrap_ctx() control-channel wrap helper
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7370497114769468900=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7370497114769468900==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dsUrwX3a5QM="; charset=UTF-8

--dsUrwX3a5QM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#34) to the change originally cr=
eated by Lev Stipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?=
usp=3Demail )

The following approvals got outdated and were removed:
Code-=
Review+2 by R=C4=83zvan Cojocaru


Change subject: init: Extract init_tls_w=
rap_ctx() control-channel wrap helper
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

init: Extract init_tls_wrap_ctx() control-channel=
 wrap helper

Factor the tls-auth/tls-crypt wrapping-context setup out of
d=
o_init_crypto_tls() into a reusable init_tls_wrap_ctx() helper, and
expose =
it in init=2Eh together with do_init_tls_wrap_key(), which now
takes the co=
nnection entry to read its keys from instead of using
options=2Ece=2E Both =
call sites pass &c->options=2Ece, so there is no behavior
change=2E

A plan=
ned server-probe feature will use the helper to build the wrapping
context =
before a connection exists, so that a probe can be wrapped with
tls-auth/tl=
s-crypt like any other control packet=2E

Change-Id: I7d8546da9ef06c2226ea7=
7e461f9550d24894c61
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
Acked-b=
y: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1749
Message-Id: <20261118210114=2E19873-1-gert@gree=
nie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg41654=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M src/openvpn/init=2Ec
M src/openvpn/init=2Eh
2 files c=
hanged, 75 insertions(+), 36 deletions(-)


  git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/49/1749/34

diff --git a/src/openvpn/in=
it=2Ec b/src/openvpn/init=2Ec
index e1052c5=2E=2E0a76263 100644
--- a/src/o=
penvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3004,13 +3004,13 @@
 /*
  * =
Initialize the tls-auth/crypt key context
  */
-static void
-do_init_tls_wr=
ap_key(struct context *c)
+void
+do_init_tls_wrap_key(struct context *c, co=
nst struct connection_entry *ce)
 {
     const struct options *options =3D =
&c->options;
 
     /* TLS handshake authentication (--tls-auth) */
-    if=
 (options->ce=2Etls_auth_file)
+    if (ce->tls_auth_file)
     {
         =
/* Initialize key_type for tls-auth with auth only */
         CLEAR(c->c1=
=2Eks=2Etls_auth_key_type);
@@ -3025,33 +3025,31 @@
         }
 
         c=
rypto_read_openvpn_key(&c->c1=2Eks=2Etls_auth_key_type, &c->c1=2Eks=2Etls_w=
rap_key,
-                                options->ce=2Etls_auth_file, opti=
ons->ce=2Etls_auth_file_inline,
-                                options->c=
e=2Ekey_direction, "Control Channel Authentication",
-                     =
           "tls-auth", &c->c1=2Eks=2Eoriginal_wrap_keydata);
+             =
                   ce->tls_auth_file, ce->tls_auth_file_inline, ce->key_dir=
ection,
+                                "Control Channel Authentication", =
"tls-auth",
+                                &c->c1=2Eks=2Eoriginal_wrap_ke=
ydata);
     }
 
     /* TLS handshake encryption+authentication (--tls-cry=
pt) */
-    if (options->ce=2Etls_crypt_file)
+    if (ce->tls_crypt_file)
=
     {
         tls_crypt_init_key(&c->c1=2Eks=2Etls_wrap_key, &c->c1=2Eks=
=2Eoriginal_wrap_keydata,
-                           options->ce=2Etls_cry=
pt_file, options->ce=2Etls_crypt_file_inline,
-                           o=
ptions->tls_server);
+                           ce->tls_crypt_file, ce->tl=
s_crypt_file_inline, options->tls_server);
     }
 
     /* tls-crypt with =
client-specific keys (--tls-crypt-v2) */
-    if (options->ce=2Etls_crypt_v=
2_file)
+    if (ce->tls_crypt_v2_file)
     {
         if (options->tls_se=
rver)
         {
             tls_crypt_v2_init_server_key(&c->c1=2Eks=2Etl=
s_crypt_v2_server_key, true,
-                                         opti=
ons->ce=2Etls_crypt_v2_file,
-                                         opti=
ons->ce=2Etls_crypt_v2_file_inline);
+                                     =
    ce->tls_crypt_v2_file, ce->tls_crypt_v2_file_inline);
         }
      =
   else
         {
             tls_crypt_v2_init_client_key(&c->c1=2Eks=2E=
tls_wrap_key, &c->c1=2Eks=2Eoriginal_wrap_keydata,
-                       =
                  &c->c1=2Eks=2Etls_crypt_v2_wkc, options->ce=2Etls_crypt_v=
2_file,
-                                         options->ce=2Etls_crypt_v=
2_file_inline);
+                                         &c->c1=2Eks=2Etls=
_crypt_v2_wkc, ce->tls_crypt_v2_file,
+                                    =
     ce->tls_crypt_v2_file_inline);
         }
         /* We have to ensur=
e that the loaded tls-crypt key is small enough
          * to fit into the=
 initial hard reset v3 packet */
@@ -3060,18 +3058,44 @@
         /* empty =
ACK/message id, tls-crypt, Opcode, UDP, ipv6 */
         int required_size =
=3D 5 + wkc_len + tls_crypt_buf_overhead() + 1 + 8 + 40;
 
-        if (req=
uired_size > c->options=2Ece=2Etls_mtu)
+        if (required_size > ce->tl=
s_mtu)
         {
             msg(M_WARN,
                 "ERROR: tls-cry=
pt-v2 client key too large to work with "
                 "requested --max=
-packet-size %d, requires at least "
                 "--max-packet-size %d=
=2E Packets will ignore requested "
                 "maximum packet size",=

-                c->options=2Ece=2Etls_mtu, required_size);
+             =
   ce->tls_mtu, required_size);
         }
     }
 }
 
+void
+init_tls_wrap=
_ctx(struct tls_wrap_ctx *tls_wrap, const struct connection_entry *ce, bool=
 tls_client,
+                  const struct key_schedule *ks)
+{
+    CLEA=
R(*tls_wrap);
+
+    /* TLS handshake authentication (--tls-auth) */
+    i=
f (ce->tls_auth_file)
+    {
+        tls_wrap->mode =3D TLS_WRAP_AUTH;
+  =
  }
+
+    /* TLS handshake encryption (--tls-crypt) */
+    if (ce->tls_cr=
ypt_file || (ce->tls_crypt_v2_file && tls_client))
+    {
+        tls_wrap=
->mode =3D TLS_WRAP_CRYPT;
+    }
+
+    if (tls_wrap->mode =3D=3D TLS_WRAP=
_AUTH || tls_wrap->mode =3D=3D TLS_WRAP_CRYPT)
+    {
+        tls_wrap->op=
t=2Ekey_ctx_bi =3D ks->tls_wrap_key;
+        tls_wrap->opt=2Eflags |=3D CO=
_PACKET_ID_LONG_FORM;
+        tls_wrap->original_wrap_keydata =3D ks->orig=
inal_wrap_keydata;
+    }
+}
+
 /*
  * Initialize the persistent component =
of OpenVPN's TLS mode,
  * which is preserved across SIGUSR1 resets=2E
@@ -=
3143,7 +3167,7 @@
         init_key_type(&c->c1=2Eks=2Ekey_type, ciphername=
, options->authname, warn);
 
         /* initialize tls-auth/crypt/crypt-v=
2 key */
-        do_init_tls_wrap_key(c);
+        do_init_tls_wrap_key(c,=
 &c->options=2Ece);
 
         /* initialise auth-token crypto support */
 =
        if (c->options=2Eauth_token_generate)
@@ -3168,7 +3192,7 @@
       =
   * tls-auth/crypt key can be configured per connection block, therefore
 =
         * we must reload it as it may have changed
          */
-        d=
o_init_tls_wrap_key(c);
+        do_init_tls_wrap_key(c, &c->options=2Ece);=

     }
 }
 
@@ -3349,24 +3373,8 @@
         to=2Eekm_size =3D 0;
     }
 
=
-    /* TLS handshake authentication (--tls-auth) */
-    if (options->ce=
=2Etls_auth_file)
-    {
-        to=2Etls_wrap=2Emode =3D TLS_WRAP_AUTH;
-=
    }
-
-    /* TLS handshake encryption (--tls-crypt) */
-    if (options-=
>ce=2Etls_crypt_file || (options->ce=2Etls_crypt_v2_file && options->tls_cl=
ient))
-    {
-        to=2Etls_wrap=2Emode =3D TLS_WRAP_CRYPT;
-    }
-
- =
   if (to=2Etls_wrap=2Emode =3D=3D TLS_WRAP_AUTH || to=2Etls_wrap=2Emode =
=3D=3D TLS_WRAP_CRYPT)
-    {
-        to=2Etls_wrap=2Eopt=2Ekey_ctx_bi =3D=
 c->c1=2Eks=2Etls_wrap_key;
-        to=2Etls_wrap=2Eopt=2Eflags |=3D CO_PA=
CKET_ID_LONG_FORM;
-        to=2Etls_wrap=2Eoriginal_wrap_keydata =3D c->c1=
=2Eks=2Eoriginal_wrap_keydata;
-    }
+    /* Control-channel wrapping (--t=
ls-auth / --tls-crypt) */
+    init_tls_wrap_ctx(&to=2Etls_wrap, &c->option=
s=2Ece, options->tls_client, &c->c1=2Eks);
 
     if (options->ce=2Etls_cry=
pt_v2_file)
     {
diff --git a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh=

index c486158=2E=2Ed028280 100644
--- a/src/openvpn/init=2Eh
+++ b/src/ope=
nvpn/init=2Eh
@@ -73,6 +73,37 @@
 
 void do_test_crypto(struct context *o);=

 
+/**
+ * @brief Load the tls-auth/tls-crypt(-v2) key material into c->c1=
=2Eks=2E
+ *
+ * Reads the key from the file configured on connection entry=
 ce (--tls-auth,
+ * --tls-crypt or --tls-crypt-v2); a no-op when none of t=
hem is set=2E May be
+ * called more than once (the key can be configured p=
er connection block, so it
+ * is reloaded for each connection)=2E
+ *
+ * =
@param c  The context whose c1=2Eks key schedule is populated=2E
+ * @param=
 ce The connection entry whose tls-wrap key file is loaded=2E
+ */
+void do=
_init_tls_wrap_key(struct context *c, const struct connection_entry *ce);
+=

+/**
+ * @brief Configure a control-channel wrapping context from a connec=
tion entry
+ *        and previously loaded tls-wrap key material=2E
+ *
+ =
* Sets tls_wrap to TLS_WRAP_AUTH (--tls-auth) or TLS_WRAP_CRYPT
+ * (--tls-=
crypt / client --tls-crypt-v2) and installs the key context, or
+ * leaves =
it in TLS_WRAP_NONE when neither is configured=2E The key material must
+ *=
 already have been loaded with do_init_tls_wrap_key()=2E tls-crypt-v2 speci=
fics
+ * (the wrapped client key and the server key) are left to the caller=
=2E
+ *
+ * @param tls_wrap   The wrapping context to configure=2E
+ * @par=
am ce         The connection entry selecting the wrapping mode=2E
+ * @para=
m tls_client Whether this is a TLS client (selects tls-crypt-v2 mode)=2E
+ =
* @param ks         Key schedule holding the loaded tls-wrap key material=
=2E
+ */
+void init_tls_wrap_ctx(struct tls_wrap_ctx *tls_wrap, const struc=
t connection_entry *ce,
+                       bool tls_client, const stru=
ct key_schedule *ks);
+
 void context_gc_free(struct context *c);
 
 bool d=
o_up(struct context *c, bool pulled_options, uint64_t option_types_found);
=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7d8546da9ef06c=
2226ea77e461f9550d24894c61
Gerrit-Change-Number: 1749
Gerrit-PatchSet: 34
G=
errit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@green=
ie=2Emuc=2Ede>
Gerrit-Reviewer: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Rev=
iewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>

--dsUrwX3a5QM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #34</strong> to the change originally created by Lev=
 Stipakov=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
49?usp=3Demail">View Change</a></p><p>The following approvals got outdated =
and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">in=
it: Extract init_tls_wrap_ctx() control-channel wrap helper<br><br>Factor t=
he tls-auth/tls-crypt wrapping-context setup out of<br>do_init_crypto_tls()=
 into a reusable init_tls_wrap_ctx() helper, and<br>expose it in init=2Eh t=
ogether with do_init_tls_wrap_key(), which now<br>takes the connection entr=
y to read its keys from instead of using<br>options=2Ece=2E Both call sites=
 pass &amp;c-&gt;options=2Ece, so there is no behavior<br>change=2E<br><br>=
A planned server-probe feature will use the helper to build the wrapping<br=
>context before a connection exists, so that a probe can be wrapped with<br=
>tls-auth/tls-crypt like any other control packet=2E<br><br>Change-Id: I7d8=
546da9ef06c2226ea77e461f9550d24894c61<br>Signed-off-by: Lev Stipakov &lt;le=
v@openvpn=2Enet&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&=
gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749<br>Messa=
ge-Id: &lt;20261118210114=2E19873-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: htt=
ps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41=
654=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<b=
r>---<br>M src/openvpn/init=2Ec<br>M src/openvpn/init=2Eh<br>2 files change=
d, 75 insertions(+), 36 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/49/1749/34</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>inde=
x e1052c5=2E=2E0a76263 100644</span><br><span>--- a/src/openvpn/init=2Ec</s=
pan><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -3004,13 +3004,=
13 @@</span><br><span> /*</span><br><span>  * Initialize the tls-auth/crypt=
 key context</span><br><span>  */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-do_init_tls_wrap_key(struct context *c)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+do_init_tls_wrap_key(struct context *c, const struct connection_entr=
y *ce)</span><br><span> {</span><br><span>     const struct options *option=
s =3D &amp;c-&gt;options;</span><br><span> </span><br><span>     /* TLS han=
dshake authentication (--tls-auth) */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (options-&gt;ce=2Etls_auth_file)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;tls_auth_file)</span><br=
><span>     {</span><br><span>         /* Initialize key_type for tls-auth =
with auth only */</span><br><span>         CLEAR(c-&gt;c1=2Eks=2Etls_auth_k=
ey_type);</span><br><span>@@ -3025,33 +3025,31 @@</span><br><span>         =
}</span><br><span> </span><br><span>         crypto_read_openvpn_key(&amp;c=
-&gt;c1=2Eks=2Etls_auth_key_type, &amp;c-&gt;c1=2Eks=2Etls_wrap_key,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
    options-&gt;ce=2Etls_auth_file, options-&gt;ce=2Etls_auth_file_inline,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
          options-&gt;ce=2Ekey_direction, &quot;Control Channel Authenticat=
ion&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                     &quot;tls-auth&quot;, &amp;c-&gt;c1=2Eks=2Eoriginal_wr=
ap_keydata);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                         ce-&gt;tls_auth_file, ce-&gt;tls_auth_file_inline,=
 ce-&gt;key_direction,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                &quot;Control Channel Authentication&quo=
t;, &quot;tls-auth&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                &amp;c-&gt;c1=2Eks=2Eoriginal_wrap_ke=
ydata);</span><br><span>     }</span><br><span> </span><br><span>     /* TL=
S handshake encryption+authentication (--tls-crypt) */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;ce=2Etls_crypt_file)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;tls_cr=
ypt_file)</span><br><span>     {</span><br><span>         tls_crypt_init_ke=
y(&amp;c-&gt;c1=2Eks=2Etls_wrap_key, &amp;c-&gt;c1=2Eks=2Eoriginal_wrap_key=
data,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
           options-&gt;ce=2Etls_crypt_file, options-&gt;ce=2Etls_crypt_file=
_inline,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
              options-&gt;tls_server);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                           ce-&gt;tls_crypt_file, ce-&gt=
;tls_crypt_file_inline, options-&gt;tls_server);</span><br><span>     }</sp=
an><br><span> </span><br><span>     /* tls-crypt with client-specific keys =
(--tls-crypt-v2) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (options-&gt;ce=2Etls_crypt_v2_file)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (ce-&gt;tls_crypt_v2_file)</span><br><span>   =
  {</span><br><span>         if (options-&gt;tls_server)</span><br><span>  =
       {</span><br><span>             tls_crypt_v2_init_server_key(&amp;c-&=
gt;c1=2Eks=2Etls_crypt_v2_server_key, true,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                         options-&gt;=
ce=2Etls_crypt_v2_file,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                                         options-&gt;ce=2Etls_crypt_v2_fi=
le_inline);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                                 ce-&gt;tls_crypt_v2_file, ce-&gt;tls_crypt=
_v2_file_inline);</span><br><span>         }</span><br><span>         else<=
/span><br><span>         {</span><br><span>             tls_crypt_v2_init_c=
lient_key(&amp;c-&gt;c1=2Eks=2Etls_wrap_key, &amp;c-&gt;c1=2Eks=2Eoriginal_=
wrap_keydata,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                                 &amp;c-&gt;c1=2Eks=2Etls_crypt_v2_wkc, opt=
ions-&gt;ce=2Etls_crypt_v2_file,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                                         options-&gt;ce=2Etls_cr=
ypt_v2_file_inline);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                         &amp;c-&gt;c1=2Eks=2Etls_crypt_v2=
_wkc, ce-&gt;tls_crypt_v2_file,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                         ce-&gt;tls_crypt_v2_fi=
le_inline);</span><br><span>         }</span><br><span>         /* We have =
to ensure that the loaded tls-crypt key is small enough</span><br><span>   =
       * to fit into the initial hard reset v3 packet */</span><br><span>@@=
 -3060,18 +3058,44 @@</span><br><span>         /* empty ACK/message id, tls=
-crypt, Opcode, UDP, ipv6 */</span><br><span>         int required_size =3D=
 5 + wkc_len + tls_crypt_buf_overhead() + 1 + 8 + 40;</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (required_size=
 &gt; c-&gt;options=2Ece=2Etls_mtu)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (required_size &gt; ce-&gt;tls_mtu)</span><br><s=
pan>         {</span><br><span>             msg(M_WARN,</span><br><span>   =
              &quot;ERROR: tls-crypt-v2 client key too large to work with &=
quot;</span><br><span>                 &quot;requested --max-packet-size %d=
, requires at least &quot;</span><br><span>                 &quot;--max-pac=
ket-size %d=2E Packets will ignore requested &quot;</span><br><span>       =
          &quot;maximum packet size&quot;,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                c-&gt;options=2Ece=2Etls_mtu, required=
_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    ce-&gt;tls_mtu, required_size);</span><br><span>         }</span><br><s=
pan>     }</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+init_tls_wrap_ctx(struct tls_wrap_ctx *tls_wrap, const struct =
connection_entry *ce, bool tls_client,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                  const struct key_schedule *ks)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    CLEAR(*tls_wrap);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* TLS handshake authentication (--tls-auth) */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;tls_auth_file=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        tls_wrap-&gt;mode =3D TL=
S_WRAP_AUTH;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* TLS handshake encryption (--tls-c=
rypt) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-=
&gt;tls_crypt_file || (ce-&gt;tls_crypt_v2_file &amp;&amp; tls_client))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        tls_wrap-&gt;mode =3D TLS_WRA=
P_CRYPT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (tls_wrap-&gt;mode =3D=3D TLS_WRAP_AU=
TH || tls_wrap-&gt;mode =3D=3D TLS_WRAP_CRYPT)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        tls_wrap-&gt;opt=2Ekey_ctx_bi =3D ks-&gt;tls_wrap_key;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_wrap-&g=
t;opt=2Eflags |=3D CO_PACKET_ID_LONG_FORM;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        tls_wrap-&gt;original_wrap_keydata =3D ks-&g=
t;original_wrap_keydata;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span>=
<br><span>  * Initialize the persistent component of OpenVPN&#39;s TLS mode=
,</span><br><span>  * which is preserved across SIGUSR1 resets=2E</span><br=
><span>@@ -3143,7 +3167,7 @@</span><br><span>         init_key_type(&amp;c-=
&gt;c1=2Eks=2Ekey_type, ciphername, options-&gt;authname, warn);</span><br>=
<span> </span><br><span>         /* initialize tls-auth/crypt/crypt-v2 key =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        do_init_tls=
_wrap_key(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  do_init_tls_wrap_key(c, &amp;c-&gt;options=2Ece);</span><br><span> </span=
><br><span>         /* initialise auth-token crypto support */</span><br><s=
pan>         if (c-&gt;options=2Eauth_token_generate)</span><br><span>@@ -3=
168,7 +3192,7 @@</span><br><span>          * tls-auth/crypt key can be conf=
igured per connection block, therefore</span><br><span>          * we must =
reload it as it may have changed</span><br><span>          */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        do_init_tls_wrap_key(c);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        do_init_tls_wr=
ap_key(c, &amp;c-&gt;options=2Ece);</span><br><span>     }</span><br><span>=
 }</span><br><span> </span><br><span>@@ -3349,24 +3373,8 @@</span><br><span=
>         to=2Eekm_size =3D 0;</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* TLS handshake auth=
entication (--tls-auth) */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (options-&gt;ce=2Etls_auth_file)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        to=2Etls_wrap=2Emode =3D TLS_WRAP_AUTH;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/* TLS handshake encryption (--tls-crypt) */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (options-&gt;ce=2Etls_crypt_file || (options-=
&gt;ce=2Etls_crypt_v2_file &amp;&amp; options-&gt;tls_client))</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        to=2Etls_wrap=2Emode =3D TLS_WRAP_CRYPT;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (to=2Etls_wrap=2Emode =3D=3D TLS_WRAP_AUTH || to=2Etl=
s_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       to=2Etls_wrap=2Eopt=2Ekey_ctx_bi =3D c-&gt;c1=2Eks=2Etls_wrap_key;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        to=2Etls_wrap=
=2Eopt=2Eflags |=3D CO_PACKET_ID_LONG_FORM;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        to=2Etls_wrap=2Eoriginal_wrap_keydata =3D c-&=
gt;c1=2Eks=2Eoriginal_wrap_keydata;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* Control-channel wrapping (--tls-auth / --tls-crypt) */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    init_tls_wrap_ctx(&amp;to=2Et=
ls_wrap, &amp;c-&gt;options=2Ece, options-&gt;tls_client, &amp;c-&gt;c1=2Ek=
s);</span><br><span> </span><br><span>     if (options-&gt;ce=2Etls_crypt_v=
2_file)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/ini=
t=2Eh b/src/openvpn/init=2Eh</span><br><span>index c486158=2E=2Ed028280 100=
644</span><br><span>--- a/src/openvpn/init=2Eh</span><br><span>+++ b/src/op=
envpn/init=2Eh</span><br><span>@@ -73,6 +73,37 @@</span><br><span> </span><=
br><span> void do_test_crypto(struct context *o);</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @brief Load the tls-auth/tls-crypt(-v2=
) key material into c-&gt;c1=2Eks=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Reads the key from the file configured on connection entry ce (--tls-aut=
h,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --tls-crypt or=
 --tls-crypt-v2); a no-op when none of them is set=2E May be</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * called more than once (the key =
can be configured per connection block, so it</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * is reloaded for each connection)=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param c  The context whose c1=2Eks key sche=
dule is populated=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param ce The connection entry whose tls-wrap key file is loaded=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void do_init_tls_wrap_key(struct contex=
t *c, const struct connection_entry *ce);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brief Con=
figure a control-channel wrapping context from a connection entry</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *        and previously load=
ed tls-wrap key material=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Sets t=
ls_wrap to TLS_WRAP_AUTH (--tls-auth) or TLS_WRAP_CRYPT</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * (--tls-crypt / client --tls-crypt-v2=
) and installs the key context, or</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * leaves it in TLS_WRAP_NONE when neither is configured=2E =
The key material must</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * already have been loaded with do_init_tls_wrap_key()=2E tls-crypt-v2 s=
pecifics</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (the wra=
pped client key and the server key) are left to the caller=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param tls_wrap   The wrapping context to confi=
gure=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ce=
         The connection entry selecting the wrapping mode=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param tls_client Whether this =
is a TLS client (selects tls-crypt-v2 mode)=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param ks         Key schedule holding the lo=
aded tls-wrap key material=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void i=
nit_tls_wrap_ctx(struct tls_wrap_ctx *tls_wrap, const struct connection_ent=
ry *ce,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
           bool tls_client, const struct key_schedule *ks);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void context_gc_f=
ree(struct context *c);</span><br><span> </span><br><span> bool do_up(struc=
t context *c, bool pulled_options, uint64_t option_types_found);</span><br>=
</pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1749?usp=3Demail">change 1749</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1749?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1749 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 34 </div>
<div style=3D"display:n=
one"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doe=
ring &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--dsUrwX3a5QM=--


--===============7370497114769468900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7370497114769468900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7370497114769468900==--

