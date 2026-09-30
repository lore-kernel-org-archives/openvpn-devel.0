Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46EF4CA5FC5
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ahq1OwsYzXnld1C7U07lxTvovp6BNYaRaE4KWEBmuvE=; b=QBUMBYzZZnBeAULhXz/O75pePI
	Tw02hmYR78cWJG/BKkkp4d/aZ2jOCwJGwHo14x3azrk4nIhpWnsqZdlZ/xJCbTOX9ayk6YNGLbq4U
	PPbiU2+o2pF5CmQhOs4fwDLRqrAdsHipqD1PTTxb5si8+3AWFXHtSVBWPyROLSfEAkdw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBpeM-0003Mm-Kp;
	Wed, 30 Sep 2026 08:26:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBpe2-0003Fq-44
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=XZ8xKXyPzkZEFkiNdWH61LcYtCsaQaGi/VNReGO1Jgc=; b=l9AaLIbUjyj8sOaLfTUKQuKFwa
 EJK3EYCCDOgEmXhZAskwmVF851gTcmFXUKurufYadt0BrU6xOvWB+PyabVDgKz1GYCzF862lKHFiZ
 DBSb16jH1DlgtSCjzbWLpYrzPhlLs5M0jqldQbeXsx9JR3JBuyGYSnSa7xQf6TPjwgHQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XZ8xKXyPzkZEFkiNdWH61LcYtCsaQaGi/VNReGO1Jgc=; b=c
 yARN8oLqLQnGB6i5K92ECi1fOo/0bQb7uyGOAI+N918g+qsurbiq/3QLAX3MGAGg2U5BvAjP42dWW
 yOtCD09wKtYXyiRb06yj4Bnx3AktTesQxMk+ALvUV4zM/Qt4rFdmzrpBR6YvN4YgEJ3kvKq6UvcWQ
 I1SDXgee8USuSgWo=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBpdc-0005oD-UI for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:06 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ffb83bf7aso31916225e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 01:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790756758; x=1791361558; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XZ8xKXyPzkZEFkiNdWH61LcYtCsaQaGi/VNReGO1Jgc=;
 b=LhZrbj3ZP0+BJUnlavNtWcvOteRB3i2JbuS80bgpq5jyYS9BHX2RfyvMoeIEwPD33K
 WcuTqx82HSxCRyfIycmQcKa6mOWUD6piSdbm51/usPlxRGVBg06M2SMHSmeMSEpG8UZg
 rTeGPAmdFSxIFFHtcNF8rPUsbxnR/Hv/yf8/OSl2MvVVqrg0KqkFFPcg2d/41wLQex5A
 3OXIWCJ23MHl7rCfgjSYMih4SwZg0hUgrrTlLyMcvwa+Bnh2nCAwUOuAqgtrzKnml7oC
 P2/crCa5I15g2b67PR3VN+e2La3V9UJ/B9GHcRjZbHv0gsFrFv3S7t86XeC3h1xAvZ6F
 r7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790756758; x=1791361558;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XZ8xKXyPzkZEFkiNdWH61LcYtCsaQaGi/VNReGO1Jgc=;
 b=caPzDstdpjk1QoOyotVv5UiVRUUrteGCHuQlsCWylpiK8zit076OLyjQCbdekQGXzr
 gi3FRNL6vd7ZBsKH2fhBFeh2zMvJ0iPu/tOtAG3WVgzwGtD3FrBuIsF1p1xK5K9o1ovO
 oi1RVAr0bU6h1bOE/yqNw+rpG+8hHwAo02guCX8aE6Xa8h4ZyJ1jGd4yov/WF8InDC1r
 Z3ob+d1OCnsK0uBCUcLdG0ZvVNpejrcHUgFIvPFrsqWnky9kHJyjFnoAKbvc9Ms9xs0G
 RY4lNihcN21cC+xE1RS+zy27LrdH4M0mGqLQagXVenRHDz93rkVHmPk8/5LKGeMoye6Q
 XYxg==
X-Gm-Message-State: AFuF++mwpT1SrIbrkvy6wzSzawlCFmXH1fkj3gnO3xJza4CXNn+Voqbj
 +sEvpcI5XtIAPqA9dYy3TeyafOx1iQ6JgAGx3dcB8SSn/02+XYEBfPrIjhF1UNxi+0a3APPpeeW
 MQxcEdUT7227Afvy+KSheHzntT/HC+ZetjU9JaRKOtmDDGQced5P6ZJd4AppmWfMOKF7N2BqDQM
 FCVmxDoQ==
X-Gm-Gg: AYBFou0Gzw4rvrB+dpcIZAS/d1gcrD2YSeROhPSaC3AfLzRA1htW6ZZmsTE9E4UMCF7
 gx8ze4ooRVFHejPBlKRwQ+PUOMx8wklxUEf3T/Di0Xk7fUPoZDttSRlUKlO4M/juq2V1yirbzZV
 MI00wFr6aCK6fNMAcN7SuhcaL0lRaUL/XBiyd/z5WWt2OlowqO4bOSw2Qe00QtiVjmTnYQrYZ5A
 +YWYTdRviheyAlfNBILkDulvQ0PSswDnclkq8CJbr7B7m6YxeMO+gWjP5RJb5mZHyEtT8nh2752
 6XeLXpSpD230pvUd2i5UNZofmd/rLiw0JxuR2ekjBNn2GdurJ/DAny5aAxFYMlJmmo2c+5fn3a6
 QWHIxT2sNuAw6K8c5erpZuMK3kdjvMJCu4aJz3eAYkW0FWorSiiRMNMuPFwT96IyL0KobqAvr8F
 H1FBQhcwjqLyHEay07vpE1zP+w+5tjCgAYT6+nEm1t/YOsDUcd83i8i+CSI6WNbHt0fY5zIfkd6
 ZYA/WqLQ3oF3PPfDHZAy70P95578M70VHh0DZgmNkXDgNHBjouwJwbzEGrk0EsL84iGM1ybUbRK
 k5LqCAsCKcMo3iGQ/dZPMksmLEoL9AAmbvaamOIK7JpQE+GhdFSsDYVP00mJ71W3dhXGW3vQ
X-Received: by 2002:a05:600c:4e42:b0:49d:2450:68ac with SMTP id
 5b1f17b1804b1-4a01afe84a4mr10488315e9.5.1790756758226; 
 Wed, 30 Sep 2026 01:25:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b02949a4fsm1712674f8f.3.2026.09.30.01.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:25:57 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 08:25:29 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 30
X-Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
X-Gerrit-Change-Number: 1749
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1749?usp=email>
X-Gerrit-Commit: aad13f822a304c802df8f49c13896167a80203ce
In-Reply-To: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
References: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk3ZDg1NDZkYTllZjA2YzIyMjZlYTc3ZTQ2MWY5NTUwZDI0ODk0YzYxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9413d4c6f165b118bfc95b0c007b669240cc63fc-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBpdc-0005oD-UI
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
Content-Type: multipart/mixed; boundary="===============7151396479812858655=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7151396479812858655==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5EdT5rb2hNI="; charset=UTF-8

--5EdT5rb2hNI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail

to look a=
t the new patch set (#30)=2E


Change subject: oob: Extract init_tls_wrap_c=
tx() control-channel wrap helper
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

oob: Extract init_tls_wrap_ctx() control-channel wrap h=
elper

Factor the tls-auth/tls-crypt wrapping-context setup out of
do_init_=
crypto_tls() into a reusable init_tls_wrap_ctx() helper, and
expose it in i=
nit=2Eh together with do_init_tls_wrap_key(), which now
takes the connectio=
n entry to read its keys from instead of using
options=2Ece=2E Both call si=
tes pass &c->options=2Ece, so there is no behavior
change=2E

This lets the=
 client --server-probe path build the same control-channel
wrapping context=
 before a connection is established, so the probe can be
wrapped with tls-a=
uth/tls-crypt like any other control packet=2E

Change-Id: I7d8546da9ef06c2=
226ea77e461f9550d24894c61
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
-=
--
M src/openvpn/init=2Ec
M src/openvpn/init=2Eh
2 files changed, 79 insert=
ions(+), 37 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/49/1749/30

diff --git a/src/openvpn/init=2Ec b/src/open=
vpn/init=2Ec
index 529c5a3=2E=2Efb1aa2a 100644
--- a/src/openvpn/init=2Ec
+=
++ b/src/openvpn/init=2Ec
@@ -3056,13 +3056,13 @@
 /*
  * Initialize the tl=
s-auth/crypt key context
  */
-static void
-do_init_tls_wrap_key(struct con=
text *c)
+void
+do_init_tls_wrap_key(struct context *c, const struct connec=
tion_entry *ce)
 {
     const struct options *options =3D &c->options;
 
  =
   /* TLS handshake authentication (--tls-auth) */
-    if (options->ce=2Et=
ls_auth_file)
+    if (ce->tls_auth_file)
     {
         /* Initialize key=
_type for tls-auth with auth only */
         CLEAR(c->c1=2Eks=2Etls_auth_k=
ey_type);
@@ -3077,33 +3077,31 @@
         }
 
         crypto_read_openvpn=
_key(&c->c1=2Eks=2Etls_auth_key_type, &c->c1=2Eks=2Etls_wrap_key,
-        =
                        options->ce=2Etls_auth_file, options->ce=2Etls_auth=
_file_inline,
-                                options->ce=2Ekey_direction,=
 "Control Channel Authentication",
-                                "tls-au=
th", &c->c1=2Eks=2Eoriginal_wrap_keydata);
+                               =
 ce->tls_auth_file, ce->tls_auth_file_inline, ce->key_direction,
+         =
                       "Control Channel Authentication", "tls-auth",
+     =
                           &c->c1=2Eks=2Eoriginal_wrap_keydata);
     }
 
 =
    /* TLS handshake encryption+authentication (--tls-crypt) */
-    if (op=
tions->ce=2Etls_crypt_file)
+    if (ce->tls_crypt_file)
     {
         tl=
s_crypt_init_key(&c->c1=2Eks=2Etls_wrap_key, &c->c1=2Eks=2Eoriginal_wrap_ke=
ydata,
-                           options->ce=2Etls_crypt_file, options->c=
e=2Etls_crypt_file_inline,
-                           options->tls_server)=
;
+                           ce->tls_crypt_file, ce->tls_crypt_file_inline=
, options->tls_server);
     }
 
     /* tls-crypt with client-specific key=
s (--tls-crypt-v2) */
-    if (options->ce=2Etls_crypt_v2_file)
+    if (ce=
->tls_crypt_v2_file)
     {
         if (options->tls_server)
         {
  =
           tls_crypt_v2_init_server_key(&c->c1=2Eks=2Etls_crypt_v2_server_k=
ey, true,
-                                         options->ce=2Etls_crypt=
_v2_file,
-                                         options->ce=2Etls_crypt=
_v2_file_inline);
+                                         ce->tls_crypt_v=
2_file, ce->tls_crypt_v2_file_inline);
         }
         else
         {
=
             tls_crypt_v2_init_client_key(&c->c1=2Eks=2Etls_wrap_key, &c->c=
1=2Eks=2Eoriginal_wrap_keydata,
-                                         &=
c->c1=2Eks=2Etls_crypt_v2_wkc, options->ce=2Etls_crypt_v2_file,
-          =
                               options->ce=2Etls_crypt_v2_file_inline);
+  =
                                       &c->c1=2Eks=2Etls_crypt_v2_wkc, ce->=
tls_crypt_v2_file,
+                                         ce->tls_crypt_=
v2_file_inline);
         }
         /* We have to ensure that the loaded t=
ls-crypt key is small enough
          * to fit into the initial hard reset=
 v3 packet */
@@ -3112,18 +3110,45 @@
         /* empty ACK/message id, tls=
-crypt, Opcode, UDP, ipv6 */
         int required_size =3D 5 + wkc_len + t=
ls_crypt_buf_overhead() + 1 + 8 + 40;
 
-        if (required_size > c->opt=
ions=2Ece=2Etls_mtu)
+        if (required_size > ce->tls_mtu)
         {
 =
            msg(M_WARN,
                 "ERROR: tls-crypt-v2 client key to=
o large to work with "
                 "requested --max-packet-size %d, re=
quires at least "
                 "--max-packet-size %d=2E Packets will ig=
nore requested "
                 "maximum packet size",
-                c=
->options=2Ece=2Etls_mtu, required_size);
+                ce->tls_mtu, req=
uired_size);
         }
     }
 }
 
+void
+init_tls_wrap_ctx(struct tls_wra=
p_ctx *tls_wrap, const struct connection_entry *ce, bool tls_client,
+     =
             const struct key_schedule *ks, struct packet_id_persist *pid_p=
ersist)
+{
+    CLEAR(*tls_wrap);
+
+    /* TLS handshake authentication (-=
-tls-auth) */
+    if (ce->tls_auth_file)
+    {
+        tls_wrap->mode =
=3D TLS_WRAP_AUTH;
+    }
+
+    /* TLS handshake encryption (--tls-crypt) =
*/
+    if (ce->tls_crypt_file || (ce->tls_crypt_v2_file && tls_client))
+ =
   {
+        tls_wrap->mode =3D TLS_WRAP_CRYPT;
+    }
+
+    if (tls_wrap=
->mode =3D=3D TLS_WRAP_AUTH || tls_wrap->mode =3D=3D TLS_WRAP_CRYPT)
+    {=

+        tls_wrap->opt=2Ekey_ctx_bi =3D ks->tls_wrap_key;
+        tls_wra=
p->opt=2Epid_persist =3D pid_persist;
+        tls_wrap->opt=2Eflags |=3D C=
O_PACKET_ID_LONG_FORM;
+        tls_wrap->original_wrap_keydata =3D ks->ori=
ginal_wrap_keydata;
+    }
+}
+
 /*
  * Initialize the persistent component=
 of OpenVPN's TLS mode,
  * which is preserved across SIGUSR1 resets=2E
@@ =
-3195,7 +3220,7 @@
         init_key_type(&c->c1=2Eks=2Ekey_type, ciphernam=
e, options->authname, true, warn);
 
         /* initialize tls-auth/crypt/=
crypt-v2 key */
-        do_init_tls_wrap_key(c);
+        do_init_tls_wrap=
_key(c, &c->options=2Ece);
 
         /* initialise auth-token crypto suppo=
rt */
         if (c->options=2Eauth_token_generate)
@@ -3220,7 +3245,7 @@
=
          * tls-auth/crypt key can be configured per connection block, ther=
efore
          * we must reload it as it may have changed
          */
-  =
      do_init_tls_wrap_key(c);
+        do_init_tls_wrap_key(c, &c->options=
=2Ece);
     }
 }
 
@@ -3396,25 +3421,9 @@
         to=2Eekm_size =3D 0;
  =
   }
 
-    /* TLS handshake authentication (--tls-auth) */
-    if (option=
s->ce=2Etls_auth_file)
-    {
-        to=2Etls_wrap=2Emode =3D TLS_WRAP_AU=
TH;
-    }
-
-    /* TLS handshake encryption (--tls-crypt) */
-    if (opt=
ions->ce=2Etls_crypt_file || (options->ce=2Etls_crypt_v2_file && options->t=
ls_client))
-    {
-        to=2Etls_wrap=2Emode =3D TLS_WRAP_CRYPT;
-    }=

-
-    if (to=2Etls_wrap=2Emode =3D=3D TLS_WRAP_AUTH || to=2Etls_wrap=2Emo=
de =3D=3D TLS_WRAP_CRYPT)
-    {
-        to=2Etls_wrap=2Eopt=2Ekey_ctx_bi =
=3D c->c1=2Eks=2Etls_wrap_key;
-        to=2Etls_wrap=2Eopt=2Epid_persist =
=3D &c->c1=2Epid_persist;
-        to=2Etls_wrap=2Eopt=2Eflags |=3D CO_PACK=
ET_ID_LONG_FORM;
-        to=2Etls_wrap=2Eoriginal_wrap_keydata =3D c->c1=
=2Eks=2Eoriginal_wrap_keydata;
-    }
+    /* Control-channel wrapping (--t=
ls-auth / --tls-crypt) */
+    init_tls_wrap_ctx(&to=2Etls_wrap, &c->option=
s=2Ece, options->tls_client, &c->c1=2Eks,
+                      &c->c1=2Ep=
id_persist);
 
     if (options->ce=2Etls_crypt_v2_file)
     {
diff --git =
a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh
index ce8f74e=2E=2Efbe461b 10=
0644
--- a/src/openvpn/init=2Eh
+++ b/src/openvpn/init=2Eh
@@ -73,6 +73,39 =
@@
 
 void do_test_crypto(struct context *o);
 
+/**
+ * @brief Load the tl=
s-auth/tls-crypt(-v2) key material into c->c1=2Eks=2E
+ *
+ * Reads the key=
 from the file configured on connection entry ce (--tls-auth,
+ * --tls-cry=
pt or --tls-crypt-v2); a no-op when none of them is set=2E May be
+ * calle=
d more than once (the key can be configured per connection block, so it
+ *=
 is reloaded for each connection)=2E
+ *
+ * @param c  The context whose c1=
=2Eks key schedule is populated=2E
+ * @param ce The connection entry whose=
 tls-wrap key file is loaded=2E
+ */
+void do_init_tls_wrap_key(struct cont=
ext *c, const struct connection_entry *ce);
+
+/**
+ * @brief Configure a c=
ontrol-channel wrapping context from a connection entry
+ *        and prev=
iously loaded tls-wrap key material=2E
+ *
+ * Sets tls_wrap to TLS_WRAP_AU=
TH (--tls-auth) or TLS_WRAP_CRYPT
+ * (--tls-crypt / client --tls-crypt-v2)=
 and installs the key context, or
+ * leaves it in TLS_WRAP_NONE when neith=
er is configured=2E The key material must
+ * already have been loaded with=
 do_init_tls_wrap_key()=2E tls-crypt-v2 specifics
+ * (the wrapped client k=
ey and the server key) are left to the caller=2E
+ *
+ * @param tls_wrap   =
 The wrapping context to configure=2E
+ * @param ce          The connection=
 entry selecting the wrapping mode=2E
+ * @param tls_client  Whether this i=
s a TLS client (selects tls-crypt-v2 mode)=2E
+ * @param ks          Key sc=
hedule holding the loaded tls-wrap key material=2E
+ * @param pid_persist P=
acket-id persistence object to attach to the context=2E
+ */
+void init_tls=
_wrap_ctx(struct tls_wrap_ctx *tls_wrap, const struct connection_entry *ce,=

+                       bool tls_client, const struct key_schedule *ks,
+ =
                      struct packet_id_persist *pid_persist);
+
 void conte=
xt_gc_free(struct context *c);
 
 bool do_up(struct context *c, bool pulled=
_options, uint64_t option_types_found);

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
Gerrit-C=
hange-Number: 1749
Gerrit-PatchSet: 30
Gerrit-Owner: stipa <lstipakov@gmail=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ralf_lici <ralf@mandelbit=
=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>

--5EdT5rb2hNI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #30</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">oob: Extract init_tls_wrap_ctx() control-channel wrap helper<br><=
br>Factor the tls-auth/tls-crypt wrapping-context setup out of<br>do_init_c=
rypto_tls() into a reusable init_tls_wrap_ctx() helper, and<br>expose it in=
 init=2Eh together with do_init_tls_wrap_key(), which now<br>takes the conn=
ection entry to read its keys from instead of using<br>options=2Ece=2E Both=
 call sites pass &amp;c-&gt;options=2Ece, so there is no behavior<br>change=
=2E<br><br>This lets the client --server-probe path build the same control-=
channel<br>wrapping context before a connection is established, so the prob=
e can be<br>wrapped with tls-auth/tls-crypt like any other control packet=
=2E<br><br>Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61<br>Signed-o=
ff-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/init=
=2Ec<br>M src/openvpn/init=2Eh<br>2 files changed, 79 insertions(+), 37 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/49/1749/30</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init=
=2Ec b/src/openvpn/init=2Ec</span><br><span>index 529c5a3=2E=2Efb1aa2a 1006=
44</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/ope=
nvpn/init=2Ec</span><br><span>@@ -3056,13 +3056,13 @@</span><br><span> /*</=
span><br><span>  * Initialize the tls-auth/crypt key context</span><br><spa=
n>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-do_init_tls_wrap_key(stru=
ct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_init_tls_wrap_key=
(struct context *c, const struct connection_entry *ce)</span><br><span> {</=
span><br><span>     const struct options *options =3D &amp;c-&gt;options;</=
span><br><span> </span><br><span>     /* TLS handshake authentication (--tl=
s-auth) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (opt=
ions-&gt;ce=2Etls_auth_file)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (ce-&gt;tls_auth_file)</span><br><span>     {</span><br><sp=
an>         /* Initialize key_type for tls-auth with auth only */</span><br=
><span>         CLEAR(c-&gt;c1=2Eks=2Etls_auth_key_type);</span><br><span>@=
@ -3077,33 +3077,31 @@</span><br><span>         }</span><br><span> </span><=
br><span>         crypto_read_openvpn_key(&amp;c-&gt;c1=2Eks=2Etls_auth_key=
_type, &amp;c-&gt;c1=2Eks=2Etls_wrap_key,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                                options-&gt;ce=2Etls_au=
th_file, options-&gt;ce=2Etls_auth_file_inline,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                                options-&gt;ce=2E=
key_direction, &quot;Control Channel Authentication&quot;,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                                &quot;=
tls-auth&quot;, &amp;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                ce=
-&gt;tls_auth_file, ce-&gt;tls_auth_file_inline, ce-&gt;key_direction,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
        &quot;Control Channel Authentication&quot;, &quot;tls-auth&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
           &amp;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata);</span><br><span>   =
  }</span><br><span> </span><br><span>     /* TLS handshake encryption+auth=
entication (--tls-crypt) */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (options-&gt;ce=2Etls_crypt_file)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (ce-&gt;tls_crypt_file)</span><br><span> =
    {</span><br><span>         tls_crypt_init_key(&amp;c-&gt;c1=2Eks=2Etls_=
wrap_key, &amp;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                           options-&gt;ce=
=2Etls_crypt_file, options-&gt;ce=2Etls_crypt_file_inline,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                           options-&gt=
;tls_server);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                     ce-&gt;tls_crypt_file, ce-&gt;tls_crypt_file_inline, o=
ptions-&gt;tls_server);</span><br><span>     }</span><br><span> </span><br>=
<span>     /* tls-crypt with client-specific keys (--tls-crypt-v2) */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;ce=2Etl=
s_crypt_v2_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (ce-&gt;tls_crypt_v2_file)</span><br><span>     {</span><br><span>     =
    if (options-&gt;tls_server)</span><br><span>         {</span><br><span>=
             tls_crypt_v2_init_server_key(&amp;c-&gt;c1=2Eks=2Etls_crypt_v2=
_server_key, true,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                                      options-&gt;ce=2Etls_crypt_v2_file,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
                  options-&gt;ce=2Etls_crypt_v2_file_inline);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
        ce-&gt;tls_crypt_v2_file, ce-&gt;tls_crypt_v2_file_inline);</span><=
br><span>         }</span><br><span>         else</span><br><span>         =
{</span><br><span>             tls_crypt_v2_init_client_key(&amp;c-&gt;c1=
=2Eks=2Etls_wrap_key, &amp;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
          &amp;c-&gt;c1=2Eks=2Etls_crypt_v2_wkc, options-&gt;ce=2Etls_crypt=
_v2_file,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                             options-&gt;ce=2Etls_crypt_v2_file_inline);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
                   &amp;c-&gt;c1=2Eks=2Etls_crypt_v2_wkc, ce-&gt;tls_crypt_=
v2_file,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                              ce-&gt;tls_crypt_v2_file_inline);</span><br><=
span>         }</span><br><span>         /* We have to ensure that the load=
ed tls-crypt key is small enough</span><br><span>          * to fit into th=
e initial hard reset v3 packet */</span><br><span>@@ -3112,18 +3110,45 @@</=
span><br><span>         /* empty ACK/message id, tls-crypt, Opcode, UDP, ip=
v6 */</span><br><span>         int required_size =3D 5 + wkc_len + tls_cryp=
t_buf_overhead() + 1 + 8 + 40;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (required_size &gt; c-&gt;options=2Ec=
e=2Etls_mtu)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (required_size &gt; ce-&gt;tls_mtu)</span><br><span>         {</span><b=
r><span>             msg(M_WARN,</span><br><span>                 &quot;ERR=
OR: tls-crypt-v2 client key too large to work with &quot;</span><br><span> =
                &quot;requested --max-packet-size %d, requires at least &qu=
ot;</span><br><span>                 &quot;--max-packet-size %d=2E Packets =
will ignore requested &quot;</span><br><span>                 &quot;maximum=
 packet size&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              c-&gt;options=2Ece=2Etls_mtu, required_size);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                ce-&gt;tls_mtu, req=
uired_size);</span><br><span>         }</span><br><span>     }</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_tls_w=
rap_ctx(struct tls_wrap_ctx *tls_wrap, const struct connection_entry *ce, b=
ool tls_client,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
              const struct key_schedule *ks, struct packet_id_persist *pid_=
persist)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(*tls_wrap);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* TLS handshake authentication (--tls-aut=
h) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt=
;tls_auth_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_wrap-&=
gt;mode =3D TLS_WRAP_AUTH;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* TLS handshake encry=
ption (--tls-crypt) */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (ce-&gt;tls_crypt_file || (ce-&gt;tls_crypt_v2_file &amp;&amp; tl=
s_client))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_wrap-&gt;mo=
de =3D TLS_WRAP_CRYPT;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (tls_wrap-&gt;mode =3D=
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
r: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Initiali=
ze the persistent component of OpenVPN&#39;s TLS mode,</span><br><span>  * =
which is preserved across SIGUSR1 resets=2E</span><br><span>@@ -3195,7 +322=
0,7 @@</span><br><span>         init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type=
, ciphername, options-&gt;authname, true, warn);</span><br><span> </span><b=
r><span>         /* initialize tls-auth/crypt/crypt-v2 key */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        do_init_tls_wrap_key(c);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        do_init_tls_wr=
ap_key(c, &amp;c-&gt;options=2Ece);</span><br><span> </span><br><span>     =
    /* initialise auth-token crypto support */</span><br><span>         if =
(c-&gt;options=2Eauth_token_generate)</span><br><span>@@ -3220,7 +3245,7 @@=
</span><br><span>          * tls-auth/crypt key can be configured per conne=
ction block, therefore</span><br><span>          * we must reload it as it =
may have changed</span><br><span>          */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        do_init_tls_wrap_key(c);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        do_init_tls_wrap_key(c, &amp;c=
-&gt;options=2Ece);</span><br><span>     }</span><br><span> }</span><br><sp=
an> </span><br><span>@@ -3396,25 +3421,9 @@</span><br><span>         to=2Ee=
km_size =3D 0;</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /* TLS handshake authentication (--tl=
s-auth) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (opt=
ions-&gt;ce=2Etls_auth_file)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        t=
o=2Etls_wrap=2Emode =3D TLS_WRAP_AUTH;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* TLS handshake=
 encryption (--tls-crypt) */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (options-&gt;ce=2Etls_crypt_file || (options-&gt;ce=2Etls_cry=
pt_v2_file &amp;&amp; options-&gt;tls_client))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        to=2Etls_wrap=2Emode =3D TLS_WRAP_CRYPT;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (to=2Etls_wrap=2Emode =3D=3D TLS_WRAP_AUTH || to=2Etls_wrap=2Emode =
=3D=3D TLS_WRAP_CRYPT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        to=2Etl=
s_wrap=2Eopt=2Ekey_ctx_bi =3D c-&gt;c1=2Eks=2Etls_wrap_key;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        to=2Etls_wrap=2Eopt=2Epid_per=
sist =3D &amp;c-&gt;c1=2Epid_persist;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        to=2Etls_wrap=2Eopt=2Eflags |=3D CO_PACKET_ID_LONG_=
FORM;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        to=2Etls=
_wrap=2Eoriginal_wrap_keydata =3D c-&gt;c1=2Eks=2Eoriginal_wrap_keydata;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* Control-channel wrapping (--tls=
-auth / --tls-crypt) */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    init_tls_wrap_ctx(&amp;to=2Etls_wrap, &amp;c-&gt;options=2Ece, opti=
ons-&gt;tls_client, &amp;c-&gt;c1=2Eks,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                      &amp;c-&gt;c1=2Epid_persist);</sp=
an><br><span> </span><br><span>     if (options-&gt;ce=2Etls_crypt_v2_file)=
</span><br><span>     {</span><br><span>diff --git a/src/openvpn/init=2Eh b=
/src/openvpn/init=2Eh</span><br><span>index ce8f74e=2E=2Efbe461b 100644</sp=
an><br><span>--- a/src/openvpn/init=2Eh</span><br><span>+++ b/src/openvpn/i=
nit=2Eh</span><br><span>@@ -73,6 +73,39 @@</span><br><span> </span><br><spa=
n> void do_test_crypto(struct context *o);</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @brief Load the tls-auth/tls-crypt(-v2) key mat=
erial into c-&gt;c1=2Eks=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Reads =
the key from the file configured on connection entry ce (--tls-auth,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * --tls-crypt or --tls-cr=
ypt-v2); a no-op when none of them is set=2E May be</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * called more than once (the key can be =
configured per connection block, so it</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * is reloaded for each connection)=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param c  The context whose c1=2Eks key schedule is=
 populated=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram ce The connection entry whose tls-wrap key file is loaded=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void do_init_tls_wrap_key(struct context *c, c=
onst struct connection_entry *ce);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brief Configure =
a control-channel wrapping context from a connection entry</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *        and previously loaded tls-=
wrap key material=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Sets tls_wrap=
 to TLS_WRAP_AUTH (--tls-auth) or TLS_WRAP_CRYPT</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * (--tls-crypt / client --tls-crypt-v2) and i=
nstalls the key context, or</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * leaves it in TLS_WRAP_NONE when neither is configured=2E The key=
 material must</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * al=
ready have been loaded with do_init_tls_wrap_key()=2E tls-crypt-v2 specific=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (the wrapped cl=
ient key and the server key) are left to the caller=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param tls_wrap    The wrapping context to configure=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ce    =
      The connection entry selecting the wrapping mode=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param tls_client  Whether this is=
 a TLS client (selects tls-crypt-v2 mode)=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param ks          Key schedule holding the loa=
ded tls-wrap key material=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param pid_persist Packet-id persistence object to attach to th=
e context=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void init_tls_wrap_ctx(=
struct tls_wrap_ctx *tls_wrap, const struct connection_entry *ce,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                       bool t=
ls_client, const struct key_schedule *ks,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                       struct packet_id_persist *pid_=
persist);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> void context_gc_free(struct context *c);</span><br><span> </span><b=
r><span> bool do_up(struct context *c, bool pulled_options, uint64_t option=
_types_found);</span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail">change 1749</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7d8546da9ef06c222=
6ea77e461f9550d24894c61 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1749 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 30 </div>
=
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf=
@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body>=
</html>
--5EdT5rb2hNI=--


--===============7151396479812858655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7151396479812858655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7151396479812858655==--

