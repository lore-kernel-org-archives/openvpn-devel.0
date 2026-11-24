Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4788B606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=klmivCmm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jNmku1zc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fkhc5Y84;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BM/D32FY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wBLZum25Ek3QTI32cawcYDcrfQXGtMEYD6kDt6FAB8k=; b=klmivCmmNqFVo5loMLJaLofbnY
	dNOYuNDp6PwV+Lah8E4sMo00bmP8lsEwv2rCYECfHpXy1NjVTojIzfvvULbEisSfxltWm3vAoyJkJ
	qOtGruw6O8ROSNiZAzQ+U8wmH0BiA3FAkg1HEANNV5FA9wUJztEaeVJLfTu15oE5KFew=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVtQi-000000006Ev-3SAX;
	Tue, 24 Nov 2026 16:31:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVtQh-000000006Eg-0vEO
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 16:31:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XO7ynpFINmwoxZiGmKQyyJc5CVob8K5Hnlcocd/TLwQ=; b=jNmku1zcd03d1KB1WXd8nj+Vwx
 2j+LWZvZra/8QksRRdnfSGMjlIivjH3YyYgYCqxoMR9Ph9sGu5d1dd97GDQl+N0QB/OEhvzjPhdzL
 PO7OivHYWoiCOwHffeOT41aBKI+CuXzOkcgMxi92i3hMvJE1QX1/ePQOYV/tpnFdrWl0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XO7ynpFINmwoxZiGmKQyyJc5CVob8K5Hnlcocd/TLwQ=; b=fkhc5Y84881uYLdUyxB4PcSUqm
 GFo4DZPSblW1Mgp++L42QmoHWtcZw7BJThbliR/ROL09f/auDJy1JXptuMKbI9jrgmgancJA1qrWv
 ZySsHMEMxOkxJpZasHMwZHvAxAvGGL3r7lDsHDPSYUrZesqXDd6kYtlDsYKcP8BCZNno=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVtQd-000000006uy-3QDC for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 16:31:39 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so40925325e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 08:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795537889; x=1796142689; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XO7ynpFINmwoxZiGmKQyyJc5CVob8K5Hnlcocd/TLwQ=;
 b=BM/D32FYOj+sNHkOgMZytkBgcHk8qnIMvNgwkA4GUm5NTgnpncLRENTJj9mmPTRzI9
 vwZ5f5yVM+rb0rOzyWYXkpP8xrLiUs83CrxJGIicOCB8ebHEoTyRNFPHLViTl1ZZZXnY
 xU/d4yYRw/EJpMxiixrKJGAFT8O3frpcX8Mk8Yn5EWB9xZ/MCbH1dD0K5Kup6HvoHFoU
 fR7pIFQceydxHe3jh3H5QYhE0BLuNy/p6jTfQDJhzXkJjL6yNJW5B357Hu9z+rMhed2c
 FWb/TsSi0uq4NfTM9aXojLTW4PPiznVZEMOlnWNyL5/VddsnOBlwmqezkWgKyOk5DNTb
 476w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795537889; x=1796142689;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XO7ynpFINmwoxZiGmKQyyJc5CVob8K5Hnlcocd/TLwQ=;
 b=pxztgHOhUE18E8gDUhE0TahYc3aiNbLbarS2cFrCLR81WMCqjQCsPSzPBqGr8Gb6js
 57Wdj23w0LR2p9EeR7gW1s7knmlPH7dV7TVg9lABCmfADygkRcRH4wl7AdXo0Q5Wjm8z
 2EaJYC5BFKqzp/7NOX+GOd1ETj3cG5PlxIi/IZs3ruUGiOWe1MPjW3H4qDS2prUZKq/H
 TB9FyODkH4ztXoA2uhrbFw60wlFX1JKd6ho4LEDPVVwOrlp4iQRYHFg6m3wkp36EK+bG
 BwIep+Ld44IaA/VId+P+oqvnTkbi2cIybjiNWUi4v20pjLfnXCu2pdpjzoyt06b3xrwB
 Vh9w==
X-Forwarded-Encrypted: i=1;
 AL+hErEB8Gc4Ef0J1iBRuMJ7GGomvC2L/Gw2qFrXQ+u3drPimzNa/3gyJqxoUxiDsYM87QMVDLQewDqL8UyV3/Hm@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9s7Vam0eKMkKb1Kh94YPmtWcYmiKV+jWR4zyjSdtNXEs7dT0mr
 npue5T1pGSZMPbTalwe92i/07vlU+4rFu/0kPvLIFBSB6fC3jGQIWQlpizREBTbRTYTEqbGGZBO
 a458qYoJCixCAj8rrST+sAy7+Qg1hZlYB9azjtT/e2FsMy6DoPVyoHzSU0OyH53Ji92EW
X-Gm-Gg: AZFdTZeWmqnokV641Wgue4YL8bhoyWOOO4wketM6afHpXHPtrr2+bqMN81/X1HpuU1l
 n2gP7RxBWfLmYHLi3389Q0vgDUaJfyWy09Qroz9dGiRtmOaI14xyblOIblRxtILT1OJO2d42eB7
 AuM5/nGXakVe8fm1dVM34mt0OO6j3LwZ61/oLLlm6Jj1rJ4EYOHwxSmjWXjBpNl40n4eoQNIWDS
 KboedV/N5qkhYlGHxBhWpormWuiFp4eJqJmvxcABCG0Hk9LQOIMCeTpiYIdCzaWHJqs4q9Rcb2R
 qpjd+fWAYS2V+RPaP6l4Xw8dxT3v/yON6J2ERdVMcMepDEpDDzl69IVlJ7/H/7kqgt74kXGsfb8
 /3HIGcx8HEnLzGUkDoyUOdZDEIJtfFU02z5IbuMwQRBnulOviDHSjE1RIAAyZHGZ/ZpayY1u599
 uRcocC9+xym3vgCQqqIjb/ZoaiwAJ8gwMi5eKrvGnqzwKNmcw1irnzds9dUmhBeCe2W5u8hgjFv
 HqacdDAV4N73Vqxyzej/Z7Kr2wdAisensDMCarxJp2gt1LbxmjSJvksPzShxM8x5sFZxrOpPK4/
 sC6cJeSjaTuHiQbeuoaBGwh7SCNSZwJUYiEZLeEpYGrfEO6N7ENBQspl48/E7bCLobejimLGHSO
 GLR/xWDZIBM8bhRUkevDBIOUR/PYQwItiKrzQvm8AV9uB8V83Rc10mJWpF/QExzoK0oynTAmDMB
 7dRi3TFrP8+q/Owo0=
X-Received: by 2002:a05:600c:a55:b0:49f:ce78:356d with SMTP id
 5b1f17b1804b1-4bb88827db0mr329831955e9.30.1795537889020; 
 Tue, 24 Nov 2026 08:31:29 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm647227855e9.13.2026.11.24.08.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:31:28 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 16:31:28 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 34
X-Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
X-Gerrit-Change-Number: 1749
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1749?usp=email>
X-Gerrit-Commit: a8b521fddb1f35d045db6834b542a8201867b7c2
In-Reply-To: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
References: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk3ZDg1NDZkYTllZjA2YzIyMjZlYTc3ZTQ2MWY5NTUwZDI0ODk0YzYxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8a17dc23b3441372cc4581333a71855678220365-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVtQd-000000006uy-3QDC
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1230094868596346698=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1230094868596346698==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mV4ycsWFNwo="; charset=UTF-8

--mV4ycsWFNwo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1749?usp=3Demail )

Change subject: init: Extract init_tls_wrap=
_ctx() control-channel wrap helper
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

init: Extract init_tls_wrap_ctx() control-channel wr=
ap helper

Factor the tls-auth/tls-crypt wrapping-context setup out of
do_i=
nit_crypto_tls() into a reusable init_tls_wrap_ctx() helper, and
expose it =
in init=2Eh together with do_init_tls_wrap_key(), which now
takes the conne=
ction entry to read its keys from instead of using
options=2Ece=2E Both cal=
l sites pass &c->options=2Ece, so there is no behavior
change=2E

A planned=
 server-probe feature will use the helper to build the wrapping
context bef=
ore a connection exists, so that a probe can be wrapped with
tls-auth/tls-c=
rypt like any other control packet=2E

Change-Id: I7d8546da9ef06c2226ea77e4=
61f9550d24894c61
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
Acked-by: =
Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1749
Message-Id: <20261118210114=2E19873-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg41654=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/init=2Ec
M src/openvpn/init=2Eh
2 files chan=
ged, 75 insertions(+), 36 deletions(-)




diff --git a/src/openvpn/init=2E=
c b/src/openvpn/init=2Ec
index e1052c5=2E=2E0a76263 100644
--- a/src/openvp=
n/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3004,13 +3004,13 @@
 /*
  * Initi=
alize the tls-auth/crypt key context
  */
-static void
-do_init_tls_wrap_ke=
y(struct context *c)
+void
+do_init_tls_wrap_key(struct context *c, const s=
truct connection_entry *ce)
 {
     const struct options *options =3D &c->o=
ptions;
 
     /* TLS handshake authentication (--tls-auth) */
-    if (opt=
ions->ce=2Etls_auth_file)
+    if (ce->tls_auth_file)
     {
         /* In=
itialize key_type for tls-auth with auth only */
         CLEAR(c->c1=2Eks=
=2Etls_auth_key_type);
@@ -3025,33 +3025,31 @@
         }
 
         crypto=
_read_openvpn_key(&c->c1=2Eks=2Etls_auth_key_type, &c->c1=2Eks=2Etls_wrap_k=
ey,
-                                options->ce=2Etls_auth_file, options->=
ce=2Etls_auth_file_inline,
-                                options->ce=2Ek=
ey_direction, "Control Channel Authentication",
-                          =
      "tls-auth", &c->c1=2Eks=2Eoriginal_wrap_keydata);
+                  =
              ce->tls_auth_file, ce->tls_auth_file_inline, ce->key_directio=
n,
+                                "Control Channel Authentication", "tls-=
auth",
+                                &c->c1=2Eks=2Eoriginal_wrap_keydata=
);
     }
 
     /* TLS handshake encryption+authentication (--tls-crypt) *=
/
-    if (options->ce=2Etls_crypt_file)
+    if (ce->tls_crypt_file)
     =
{
         tls_crypt_init_key(&c->c1=2Eks=2Etls_wrap_key, &c->c1=2Eks=2Eori=
ginal_wrap_keydata,
-                           options->ce=2Etls_crypt_fil=
e, options->ce=2Etls_crypt_file_inline,
-                           options=
->tls_server);
+                           ce->tls_crypt_file, ce->tls_cryp=
t_file_inline, options->tls_server);
     }
 
     /* tls-crypt with client=
-specific keys (--tls-crypt-v2) */
-    if (options->ce=2Etls_crypt_v2_file=
)
+    if (ce->tls_crypt_v2_file)
     {
         if (options->tls_server)
=
         {
             tls_crypt_v2_init_server_key(&c->c1=2Eks=2Etls_cryp=
t_v2_server_key, true,
-                                         options->c=
e=2Etls_crypt_v2_file,
-                                         options->c=
e=2Etls_crypt_v2_file_inline);
+                                         ce=
->tls_crypt_v2_file, ce->tls_crypt_v2_file_inline);
         }
         els=
e
         {
             tls_crypt_v2_init_client_key(&c->c1=2Eks=2Etls_wr=
ap_key, &c->c1=2Eks=2Eoriginal_wrap_keydata,
-                             =
            &c->c1=2Eks=2Etls_crypt_v2_wkc, options->ce=2Etls_crypt_v2_file=
,
-                                         options->ce=2Etls_crypt_v2_file=
_inline);
+                                         &c->c1=2Eks=2Etls_crypt=
_v2_wkc, ce->tls_crypt_v2_file,
+                                         c=
e->tls_crypt_v2_file_inline);
         }
         /* We have to ensure that=
 the loaded tls-crypt key is small enough
          * to fit into the initi=
al hard reset v3 packet */
@@ -3060,18 +3058,44 @@
         /* empty ACK/me=
ssage id, tls-crypt, Opcode, UDP, ipv6 */
         int required_size =3D 5 =
+ wkc_len + tls_crypt_buf_overhead() + 1 + 8 + 40;
 
-        if (required_=
size > c->options=2Ece=2Etls_mtu)
+        if (required_size > ce->tls_mtu)=

         {
             msg(M_WARN,
                 "ERROR: tls-crypt-v2 =
client key too large to work with "
                 "requested --max-packe=
t-size %d, requires at least "
                 "--max-packet-size %d=2E Pa=
ckets will ignore requested "
                 "maximum packet size",
-    =
            c->options=2Ece=2Etls_mtu, required_size);
+                ce-=
>tls_mtu, required_size);
         }
     }
 }
 
+void
+init_tls_wrap_ctx(s=
truct tls_wrap_ctx *tls_wrap, const struct connection_entry *ce, bool tls_c=
lient,
+                  const struct key_schedule *ks)
+{
+    CLEAR(*tls=
_wrap);
+
+    /* TLS handshake authentication (--tls-auth) */
+    if (ce-=
>tls_auth_file)
+    {
+        tls_wrap->mode =3D TLS_WRAP_AUTH;
+    }
+
=
+    /* TLS handshake encryption (--tls-crypt) */
+    if (ce->tls_crypt_fi=
le || (ce->tls_crypt_v2_file && tls_client))
+    {
+        tls_wrap->mode=
 =3D TLS_WRAP_CRYPT;
+    }
+
+    if (tls_wrap->mode =3D=3D TLS_WRAP_AUTH =
|| tls_wrap->mode =3D=3D TLS_WRAP_CRYPT)
+    {
+        tls_wrap->opt=2Eke=
y_ctx_bi =3D ks->tls_wrap_key;
+        tls_wrap->opt=2Eflags |=3D CO_PACKE=
T_ID_LONG_FORM;
+        tls_wrap->original_wrap_keydata =3D ks->original_w=
rap_keydata;
+    }
+}
+
 /*
  * Initialize the persistent component of Ope=
nVPN's TLS mode,
  * which is preserved across SIGUSR1 resets=2E
@@ -3143,7=
 +3167,7 @@
         init_key_type(&c->c1=2Eks=2Ekey_type, ciphername, opti=
ons->authname, warn);
 
         /* initialize tls-auth/crypt/crypt-v2 key =
*/
-        do_init_tls_wrap_key(c);
+        do_init_tls_wrap_key(c, &c->o=
ptions=2Ece);
 
         /* initialise auth-token crypto support */
       =
  if (c->options=2Eauth_token_generate)
@@ -3168,7 +3192,7 @@
          * t=
ls-auth/crypt key can be configured per connection block, therefore
       =
   * we must reload it as it may have changed
          */
-        do_init=
_tls_wrap_key(c);
+        do_init_tls_wrap_key(c, &c->options=2Ece);
     =
}
 }
 
@@ -3349,24 +3373,8 @@
         to=2Eekm_size =3D 0;
     }
 
-    /=
* TLS handshake authentication (--tls-auth) */
-    if (options->ce=2Etls_a=
uth_file)
-    {
-        to=2Etls_wrap=2Emode =3D TLS_WRAP_AUTH;
-    }
-
=
-    /* TLS handshake encryption (--tls-crypt) */
-    if (options->ce=2Etl=
s_crypt_file || (options->ce=2Etls_crypt_v2_file && options->tls_client))
-=
    {
-        to=2Etls_wrap=2Emode =3D TLS_WRAP_CRYPT;
-    }
-
-    if (t=
o=2Etls_wrap=2Emode =3D=3D TLS_WRAP_AUTH || to=2Etls_wrap=2Emode =3D=3D TLS=
_WRAP_CRYPT)
-    {
-        to=2Etls_wrap=2Eopt=2Ekey_ctx_bi =3D c->c1=2Ek=
s=2Etls_wrap_key;
-        to=2Etls_wrap=2Eopt=2Eflags |=3D CO_PACKET_ID_LO=
NG_FORM;
-        to=2Etls_wrap=2Eoriginal_wrap_keydata =3D c->c1=2Eks=2Eor=
iginal_wrap_keydata;
-    }
+    /* Control-channel wrapping (--tls-auth / =
--tls-crypt) */
+    init_tls_wrap_ctx(&to=2Etls_wrap, &c->options=2Ece, op=
tions->tls_client, &c->c1=2Eks);
 
     if (options->ce=2Etls_crypt_v2_file=
)
     {
diff --git a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh
index c48=
6158=2E=2Ed028280 100644
--- a/src/openvpn/init=2Eh
+++ b/src/openvpn/init=
=2Eh
@@ -73,6 +73,37 @@
 
 void do_test_crypto(struct context *o);
 
+/**
+=
 * @brief Load the tls-auth/tls-crypt(-v2) key material into c->c1=2Eks=2E
=
+ *
+ * Reads the key from the file configured on connection entry ce (--tl=
s-auth,
+ * --tls-crypt or --tls-crypt-v2); a no-op when none of them is se=
t=2E May be
+ * called more than once (the key can be configured per connec=
tion block, so it
+ * is reloaded for each connection)=2E
+ *
+ * @param c =
 The context whose c1=2Eks key schedule is populated=2E
+ * @param ce The c=
onnection entry whose tls-wrap key file is loaded=2E
+ */
+void do_init_tls=
_wrap_key(struct context *c, const struct connection_entry *ce);
+
+/**
+ *=
 @brief Configure a control-channel wrapping context from a connection entr=
y
+ *        and previously loaded tls-wrap key material=2E
+ *
+ * Sets tl=
s_wrap to TLS_WRAP_AUTH (--tls-auth) or TLS_WRAP_CRYPT
+ * (--tls-crypt / c=
lient --tls-crypt-v2) and installs the key context, or
+ * leaves it in TLS=
_WRAP_NONE when neither is configured=2E The key material must
+ * already =
have been loaded with do_init_tls_wrap_key()=2E tls-crypt-v2 specifics
+ * =
(the wrapped client key and the server key) are left to the caller=2E
+ *
+=
 * @param tls_wrap   The wrapping context to configure=2E
+ * @param ce    =
     The connection entry selecting the wrapping mode=2E
+ * @param tls_cli=
ent Whether this is a TLS client (selects tls-crypt-v2 mode)=2E
+ * @param =
ks         Key schedule holding the loaded tls-wrap key material=2E
+ */
+v=
oid init_tls_wrap_ctx(struct tls_wrap_ctx *tls_wrap, const struct connectio=
n_entry *ce,
+                       bool tls_client, const struct key_sche=
dule *ks);
+
 void context_gc_free(struct context *c);
 
 bool do_up(struct=
 context *c, bool pulled_options, uint64_t option_types_found);

-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f95=
50d24894c61
Gerrit-Change-Number: 1749
Gerrit-PatchSet: 34
Gerrit-Owner: Le=
v Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
=
Gerrit-Reviewer: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: R=C4=83z=
van Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>

--mV4ycsWFNwo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1749?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">init: Extract init_tls_wrap_ctx() =
control-channel wrap helper<br><br>Factor the tls-auth/tls-crypt wrapping-c=
ontext setup out of<br>do_init_crypto_tls() into a reusable init_tls_wrap_c=
tx() helper, and<br>expose it in init=2Eh together with do_init_tls_wrap_ke=
y(), which now<br>takes the connection entry to read its keys from instead =
of using<br>options=2Ece=2E Both call sites pass &amp;c-&gt;options=2Ece, s=
o there is no behavior<br>change=2E<br><br>A planned server-probe feature w=
ill use the helper to build the wrapping<br>context before a connection exi=
sts, so that a probe can be wrapped with<br>tls-auth/tls-crypt like any oth=
er control packet=2E<br><br>Change-Id: I7d8546da9ef06c2226ea77e461f9550d248=
94c61<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>Acked-by:=
 Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1749<br>Message-Id: &lt;20261118210114=2E1987=
3-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/op=
envpn-devel@lists=2Esourceforge=2Enet/msg41654=2Ehtml<br>Signed-off-by: Ger=
t Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/init=2Ec<=
br>M src/openvpn/init=2Eh<br>2 files changed, 75 insertions(+), 36 deletion=
s(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=
=2Ec</span><br><span>index e1052c5=2E=2E0a76263 100644</span><br><span>--- =
a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br=
><span>@@ -3004,13 +3004,13 @@</span><br><span> /*</span><br><span>  * Init=
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
(c-&gt;c1=2Eks=2Etls_auth_key_type);</span><br><span>@@ -3025,33 +3025,31 @=
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
3 packet */</span><br><span>@@ -3060,18 +3058,44 @@</span><br><span>       =
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
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+init_tls_wrap_ctx(struct tls_wra=
p_ctx *tls_wrap, const struct connection_entry *ce, bool tls_client,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                  const st=
ruct key_schedule *ks)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(*tls_=
wrap);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* TLS handshake authenticat=
ion (--tls-auth) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (ce-&gt;tls_auth_file)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    tls_wrap-&gt;mode =3D TLS_WRAP_AUTH;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* TLS h=
andshake encryption (--tls-crypt) */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (ce-&gt;tls_crypt_file || (ce-&gt;tls_crypt_v2_file=
 &amp;&amp; tls_client))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        t=
ls_wrap-&gt;mode =3D TLS_WRAP_CRYPT;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tls_wrap=
-&gt;mode =3D=3D TLS_WRAP_AUTH || tls_wrap-&gt;mode =3D=3D TLS_WRAP_CRYPT)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        tls_wrap-&gt;opt=2Ekey_ctx=
_bi =3D ks-&gt;tls_wrap_key;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        tls_wrap-&gt;opt=2Eflags |=3D CO_PACKET_ID_LONG_FORM;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_wrap-&gt;ori=
ginal_wrap_keydata =3D ks-&gt;original_wrap_keydata;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> /*</span><br><span>  * Initialize the persistent compon=
ent of OpenVPN&#39;s TLS mode,</span><br><span>  * which is preserved acros=
s SIGUSR1 resets=2E</span><br><span>@@ -3143,7 +3167,7 @@</span><br><span> =
        init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, ciphername, options-&g=
t;authname, warn);</span><br><span> </span><br><span>         /* initialize=
 tls-auth/crypt/crypt-v2 key */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        do_init_tls_wrap_key(c);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        do_init_tls_wrap_key(c, &amp;c-&gt;options=
=2Ece);</span><br><span> </span><br><span>         /* initialise auth-token=
 crypto support */</span><br><span>         if (c-&gt;options=2Eauth_token_=
generate)</span><br><span>@@ -3168,7 +3192,7 @@</span><br><span>          *=
 tls-auth/crypt key can be configured per connection block, therefore</span=
><br><span>          * we must reload it as it may have changed</span><br><=
span>          */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    do_init_tls_wrap_key(c);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        do_init_tls_wrap_key(c, &amp;c-&gt;options=2Ece);</span><b=
r><span>     }</span><br><span> }</span><br><span> </span><br><span>@@ -334=
9,24 +3373,8 @@</span><br><span>         to=2Eekm_size =3D 0;</span><br><sp=
an>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    /* TLS handshake authentication (--tls-auth) */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;ce=2Etls_auth_file)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        to=2Etls_wrap=2Emode =3D TLS_=
WRAP_AUTH;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    /* TLS handshake encryption (--tls-crypt) */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;c=
e=2Etls_crypt_file || (options-&gt;ce=2Etls_crypt_v2_file &amp;&amp; option=
s-&gt;tls_client))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        to=2Etls_wr=
ap=2Emode =3D TLS_WRAP_CRYPT;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (to=2Etls_wrap=2Emode =
=3D=3D TLS_WRAP_AUTH || to=2Etls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        to=2Etls_wrap=2Eopt=2Ekey_ctx_bi =
=3D c-&gt;c1=2Eks=2Etls_wrap_key;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        to=2Etls_wrap=2Eopt=2Eflags |=3D CO_PACKET_ID_LONG_FORM=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        to=2Etls_wra=
p=2Eoriginal_wrap_keydata =3D c-&gt;c1=2Eks=2Eoriginal_wrap_keydata;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Control-channel wrapping (--tls-au=
th / --tls-crypt) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    init_tls_wrap_ctx(&amp;to=2Etls_wrap, &amp;c-&gt;options=2Ece, options=
-&gt;tls_client, &amp;c-&gt;c1=2Eks);</span><br><span> </span><br><span>   =
  if (options-&gt;ce=2Etls_crypt_v2_file)</span><br><span>     {</span><br>=
<span>diff --git a/src/openvpn/init=2Eh b/src/openvpn/init=2Eh</span><br><s=
pan>index c486158=2E=2Ed028280 100644</span><br><span>--- a/src/openvpn/ini=
t=2Eh</span><br><span>+++ b/src/openvpn/init=2Eh</span><br><span>@@ -73,6 +=
73,37 @@</span><br><span> </span><br><span> void do_test_crypto(struct cont=
ext *o);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brief=
 Load the tls-auth/tls-crypt(-v2) key material into c-&gt;c1=2Eks=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Reads the key from the file configured=
 on connection entry ce (--tls-auth,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * --tls-crypt or --tls-crypt-v2); a no-op when none of th=
em is set=2E May be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * called more than once (the key can be configured per connection block, s=
o it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is reloaded =
for each connection)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c  =
The context whose c1=2Eks key schedule is populated=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param ce The connection entry whose =
tls-wrap key file is loaded=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void =
do_init_tls_wrap_key(struct context *c, const struct connection_entry *ce);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @brief Configure a control-channel wrapping context=
 from a connection entry</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *        and previously loaded tls-wrap key material=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * Sets tls_wrap to TLS_WRAP_AUTH (--tls-auth) or =
TLS_WRAP_CRYPT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (-=
-tls-crypt / client --tls-crypt-v2) and installs the key context, or</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * leaves it in TLS_WRAP_N=
ONE when neither is configured=2E The key material must</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * already have been loaded with do_ini=
t_tls_wrap_key()=2E tls-crypt-v2 specifics</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * (the wrapped client key and the server key) are l=
eft to the caller=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param tls_wr=
ap   The wrapping context to configure=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param ce         The connection entry selecting t=
he wrapping mode=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param tls_client Whether this is a TLS client (selects tls-crypt-v2 mod=
e)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ks  =
       Key schedule holding the loaded tls-wrap key material=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void init_tls_wrap_ctx(struct tls_wrap_ctx *tls=
_wrap, const struct connection_entry *ce,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                       bool tls_client, const struct =
key_schedule *ks);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> void context_gc_free(struct context *c);</span><br><span> =
</span><br><span> bool do_up(struct context *c, bool pulled_options, uint64=
_t option_types_found);</span><br></pre><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail">change 1749</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7d8546da9ef0=
6c2226ea77e461f9550d24894c61 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1749 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 34 </=
div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@=
gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>

</body></html>
--mV4ycsWFNwo=--


--===============1230094868596346698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1230094868596346698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1230094868596346698==--

