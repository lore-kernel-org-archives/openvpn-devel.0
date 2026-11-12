Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21C6606A200
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BfHmFwT8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fMnGYxoF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LUVfHnJQ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=O0N0nUSV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BzPZzsghUil6kZ/PKyhbdHi3z3vif3SVBLB9frqJFZM=; b=BfHmFwT8XmpZSViv7OI6tr9FaA
	ymOS/iLyQLS1vYOxGsqTZF/OCpiqizhOcbpmG9PIfYenxbhuGuZc8qYIHN6MWulOt1O6LkDH6lWA5
	Qugbh3h8BtuLl3/Dl/arJZh6W+krIYR/3iVazttUo/S6RXXHDTG/aYtqwAlUlDxk4sZY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRYpj-000000004VA-14yj;
	Thu, 12 Nov 2026 17:43:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRYph-000000004Uv-2tAC
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:43:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=skQW4VCHOwhwGCLHZLxM7Go1ICH1l74Wd71gO4PL9k0=; b=fMnGYxoFBUxgkX/w0veHMdQX3n
 YTt8Rt4i9hQe+W6DUUsdS0m+BqQr85PmgIWcxvAk4u0qreJguoZEbS+gpMLmok9DVuwcvHAysFqjf
 iSthToxLHOTBiWpJrFEhqGKIv06WdGvj0tHqvyB0rjt2Ag9aFsPpcna/i2vIYlmHOpmQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=skQW4VCHOwhwGCLHZLxM7Go1ICH1l74Wd71gO4PL9k0=; b=LUVfHnJQNuhgXgCnrFk28PZL2I
 Ry16CMCimzEWzvX+eW+1UOQKf4aggoPOYIp6hT7SSf6OBPtWY9ywBCqdcIONWr9MdJYUNfhg88XZ0
 BXgCSqiItRq3VUJ+I5qnZfGp/KB17uKb9oip+4L2Ye40r0YUXP/AghQlSFIdoBhdq2Ak=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRYpU-0000000083I-10Yz for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:43:21 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4b7252a32c8so930205e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 09:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794505394; x=1795110194; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=skQW4VCHOwhwGCLHZLxM7Go1ICH1l74Wd71gO4PL9k0=;
 b=O0N0nUSVpB8YqNDmzL99scv1ZFRK/DrbDOKJetll0Mk2aI9OjPQqyuRLOlRKZdIS/S
 jyRX4eabfJPaIFeZNSx3J/iinYhcs5j369hM2O4lKncp3+TH4+QfikkA9Mw3hHh/5cIp
 RmHOgdAN19Fv6Z1rpIe1Yx+gvW4XIOJgSYRT0ExF1bdYbV8ks3kJNdtOfmLm533fkyUi
 agIFB9fm6Z+y907ZZOCCbM28RmN9y+u4f9ykVRykpWkoroUykzEtFSG3xd1OH+Snt0BF
 z2x7zWhCeV84GmmFprjn9wWzU0+ZHA3Jd7CjR/TqeaTxqRgiEdaFeUAkFfm4hJA49Sg9
 YFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794505394; x=1795110194;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=skQW4VCHOwhwGCLHZLxM7Go1ICH1l74Wd71gO4PL9k0=;
 b=1g0WE/x6fwWLBJCcuQhOx/MVXY8R1czQDnKQagEmbyC2Oo+HbzfQEXalSkktmqnihP
 K24hYoX9rMfzgGKWFdewJMR6KoXRUWhPcLgJKufRJyqzqQhKtEu9Mc0hm2aIveHBsrNE
 19TinW8ORJ8UmR14y7ccHXbNI6Ot54TQyklT12b8PeMUZ8i5FUGj0zRYLKPES47eHzkY
 Laay6UU9HOGJLozngdb+d8nbxspg6e6O085UYuert1MwFX0VBCMiLwlUKCPb844X+rAX
 pY5W2AwoCe1tJlEEE32W9y6xhrzL3Mextbn/hgBwxwF6Go0tEcTiMCHg9x4kJUOHdqQ+
 IdKQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFl5VfoqAWEWDPbkSutv1DXT5icFDEmQLzM9VOJuHbrdN4xC5csAvdNeXahTApspobauCfZPFeVd9aD8Bq7@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+sr4O3Xvt1Ad+Oaoru0hsu3hMyRp/4+44xzOVMuMfcu1qS4410
 rZsw4zFxzZR8kcqkQREx+HLwrZBblTZan34eUBkS9alIpammS4TmcX/WaqtBgKQlJzy9yudVZdu
 R99S686LxOJ5dhL65/8I3hRCb+R645K5n6hcYKdf9yMfP3l8qO/GJjesqNtcJ0aUanOPK
X-Gm-Gg: AYBFou3xrvAoyYBUnbNVS/rFEerDS1XdzufanDCSKrQ7b7oG9tc9WWXWCBoM/LTYpKH
 3NGCU3BZa+fzGHuD1D7qyJoUewA+2YqW7DA06a3/tBHFXHnitSUA5CgY7pO5uLoZSgR+6/PUN92
 nyY0GOn9xiQgAizud36BkyzUwNGyXY0IEFoiXBfnLVrpfo0nX8rGkUTIq/xpW/ZV23sGTiDSRS7
 WUkHkEeFU1BKkQ+pqsFpm3eTfITkVeBm6xAPJskFXMfrsIZWk5kfQ0fFOk+tbItZcq+fYwj8HiC
 V2S+K3rkMaWoUocpC5/pEYdtCUfrfs+i8pcDRCNJoiNsxhWnd/INt0dV5+zKyWSAYpoUFL9dNng
 K/A9nvTn3ZLIjBCC496umJKoaUyGPRzOjY1DlPD1WxCW+sTiVmK3dOLH10K4X7/NOpYPVsfy9ny
 51WybyTPrPCwdQYda/09DBSaPNSzrzEVATTP2tTupakqLiindL/UYHTdsG0DnAxgKwQy9q5gJSL
 WIt65fBaO+vQ/WCowUBAMQObEZLDRbNgBhTu6kVWcHDzu3zaA9F9s6/EUoC0YqFjRF9prW4TFeR
 aRfxzBGuwcZsHLgpOk2AZQH6h7Ob7u5/30l1hk7vy9itIMj78IJcukLdMC/l+dFwtRtGQBhOMAC
 Ednk4bJaOvjgn7AzzXqJN3FxR5znRTsYRayjb6QepjdDzhOT9xQQafud8x3fiDXGPlyx/0CDEGH
 Wk66Wqw6gPQBtDFsg=
X-Received: by 2002:a05:600c:46d1:b0:4b1:2026:6b41 with SMTP id
 5b1f17b1804b1-4ba0938fbbemr121686485e9.30.1794505393525; 
 Thu, 12 Nov 2026 09:43:13 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e251491sm88608515e9.2.2026.11.12.09.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:43:12 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 17:43:12 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f
X-Gerrit-Change-Number: 2163
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2163?usp=email>
X-Gerrit-Commit: 2a59209487d37e8d28ee4394bfa4de6e011a3c05
In-Reply-To: <gerrit.1794307698000.I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f@gerrit.openvpn.net>
References: <gerrit.1794307698000.I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzA3Njk4MDAwLkk1YzUyY2M1YzNhYWFkMjFkMWMyMmYzNmY2NDUxMjM1MzAyZWE2YzRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8f515b48e1c4e75f0068136f463f84f43cc2a873-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRYpU-0000000083I-10Yz
Subject: [Openvpn-devel] [M] Change in openvpn[master]: sitnl: clear
 inet_address_t locals with CLEAR()
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2955921770574368403=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2955921770574368403==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WL8DAmhDp9I="; charset=UTF-8

--WL8DAmhDp9I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2163?usp=3Demail )

Change subject: sitnl: clear inet_address_t=
 locals with CLEAR()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

sitnl: clear inet_address_t locals with CLEAR()

The inet_address_t=
 locals were initialized with "=3D { 0 }", which only
initializes the first=
 union member, the 4 byte ipv4=2E GCC 15 and later
no longer clear the rest=
 of the union for this, so the IPv6 addresses
of these locals keep up to 12=
 bytes of stack garbage when the caller
passes no address=2E

net_route_v6_=
del() then sends a garbage RTA_GATEWAY for routes without
a gateway, and th=
e kernel refuses to delete them=2E net_route_v6_best_gw()
looks up a garbag=
e destination when asked for the default route=2E

Clear the whole union wi=
th CLEAR() instead=2E The other inet_address_t
locals are cleared the same =
way, so none relies on the partial
initialization=2E

Latent since c6542257=
 ("introduce sitnl: Simplified Interface To
NetLink")=2E

Change-Id: I5c52c=
c5c3aaad21d1c22f36f6451235302ea6c4f
Signed-off-by: Razvan Cojocaru <razvanc=
@mailbox=2Eorg>
Acked-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerri=
t URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2163
Message-Id: <2026111=
0112059=2E30832-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41061=2Ehtml
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/networking_sitn=
l=2Ec
1 file changed, 40 insertions(+), 15 deletions(-)




diff --git a/sr=
c/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index 97f=
f7bd=2E=2Eeafb9f7 100644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/o=
penvpn/networking_sitnl=2Ec
@@ -612,10 +612,12 @@
 net_route_v6_best_gw(ope=
nvpn_net_ctx_t *ctx, const struct in6_addr *dst, struct in6_addr *best_gw,
=
                      char *best_iface)
 {
-    inet_address_t dst_v6 =3D {=
 0 };
+    inet_address_t dst_v6;
     char buf[INET6_ADDRSTRLEN];
     int=
 ret;
 
+    CLEAR(dst_v6);
+
     if (dst)
     {
         dst_v6=2Eipv6 =
=3D *dst;
@@ -640,10 +642,12 @@
 net_route_v4_best_gw(openvpn_net_ctx_t *ct=
x, const in_addr_t *dst, in_addr_t *best_gw,
                      char *be=
st_iface)
 {
-    inet_address_t dst_v4 =3D { 0 };
+    inet_address_t dst_=
v4;
     char buf[INET_ADDRSTRLEN];
     int ret;
 
+    CLEAR(dst_v4);
+
 =
    if (dst)
     {
         dst_v4=2Eipv4 =3D htonl(*dst);
@@ -1040,9 +104=
4,11 @@
 int
 net_addr_v4_add(const openvpn_net_ctx_t *ctx, const char *ifa=
ce, const in_addr_t *addr, int prefixlen)
 {
-    inet_address_t addr_v4 =
=3D { 0 };
+    inet_address_t addr_v4;
     char buf[INET_ADDRSTRLEN];
 
+=
    CLEAR(addr_v4);
+
     if (!addr)
     {
         return -EINVAL;
@@ -1=
060,9 +1066,11 @@
 net_addr_v6_add(const openvpn_net_ctx_t *ctx, const char=
 *iface, const struct in6_addr *addr,
                 int prefixlen)
 {
- =
   inet_address_t addr_v6 =3D { 0 };
+    inet_address_t addr_v6;
     char=
 buf[INET6_ADDRSTRLEN];
 
+    CLEAR(addr_v6);
+
     if (!addr)
     {
   =
      return -EINVAL;
@@ -1079,9 +1087,11 @@
 int
 net_addr_v4_del(const op=
envpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixl=
en)
 {
-    inet_address_t addr_v4 =3D { 0 };
+    inet_address_t addr_v4;
=
     char buf[INET_ADDRSTRLEN];
 
+    CLEAR(addr_v4);
+
     if (!addr)
  =
   {
         return -EINVAL;
@@ -1099,9 +1109,11 @@
 net_addr_v6_del(const=
 openvpn_net_ctx_t *ctx, const char *iface, const struct in6_addr *addr,
  =
               int prefixlen)
 {
-    inet_address_t addr_v6 =3D { 0 };
+  =
  inet_address_t addr_v6;
     char buf[INET6_ADDRSTRLEN];
 
+    CLEAR(add=
r_v6);
+
     if (!addr)
     {
         return -EINVAL;
@@ -1119,11 +1131,=
14 @@
 net_addr_ptp_v4_add(const openvpn_net_ctx_t *ctx, const char *iface,=
 const in_addr_t *local,
                     const in_addr_t *remote)
 {
-=
    inet_address_t local_v4 =3D { 0 };
-    inet_address_t remote_v4 =3D { =
0 };
+    inet_address_t local_v4;
+    inet_address_t remote_v4;
     char=
 buf1[INET_ADDRSTRLEN];
     char buf2[INET_ADDRSTRLEN];
 
+    CLEAR(local=
_v4);
+    CLEAR(remote_v4);
+
     if (!local)
     {
         return -EIN=
VAL;
@@ -1147,9 +1162,10 @@
 net_addr_ptp_v4_del(const openvpn_net_ctx_t *c=
tx, const char *iface, const in_addr_t *local,
                     const i=
n_addr_t *remote)
 {
-    inet_address_t local_v4 =3D { 0 };
+    inet_addr=
ess_t local_v4;
     char buf[INET6_ADDRSTRLEN];
 
+    CLEAR(local_v4);
 
=
     if (!local)
     {
@@ -1227,11 +1243,14 @@
 net_route_v6_add(const ope=
nvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
           =
       const struct in6_addr *gw, const char *iface, uint32_t table, int me=
tric)
 {
-    inet_address_t dst_v6 =3D { 0 };
-    inet_address_t gw_v6 =
=3D { 0 };
+    inet_address_t dst_v6;
+    inet_address_t gw_v6;
     char=
 dst_str[INET6_ADDRSTRLEN];
     char gw_str[INET6_ADDRSTRLEN];
 
+    CLEA=
R(dst_v6);
+    CLEAR(gw_v6);
+
     if (dst)
     {
         dst_v6=2Eipv6=
 =3D *dst;
@@ -1278,11 +1297,14 @@
 net_route_v4_del(const openvpn_net_ctx_=
t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
         =
         const char *iface, uint32_t table, int metric)
 {
-    inet_addres=
s_t dst_v4 =3D { 0 };
-    inet_address_t gw_v4 =3D { 0 };
+    inet_addres=
s_t dst_v4;
+    inet_address_t gw_v4;
     char dst_str[INET_ADDRSTRLEN];
=
     char gw_str[INET_ADDRSTRLEN];
 
+    CLEAR(dst_v4);
+    CLEAR(gw_v4);=

+
     if (dst)
     {
         dst_v4=2Eipv4 =3D htonl(*dst);
@@ -1304,11=
 +1326,14 @@
 net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct i=
n6_addr *dst, int prefixlen,
                  const struct in6_addr *gw, c=
onst char *iface, uint32_t table, int metric)
 {
-    inet_address_t dst_v6=
 =3D { 0 };
-    inet_address_t gw_v6 =3D { 0 };
+    inet_address_t dst_v6=
;
+    inet_address_t gw_v6;
     char dst_str[INET6_ADDRSTRLEN];
     char=
 gw_str[INET6_ADDRSTRLEN];
 
+    CLEAR(dst_v6);
+    CLEAR(gw_v6);
+
     =
if (dst)
     {
         dst_v6=2Eipv6 =3D *dst;

-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2163?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f
Gerr=
it-Change-Number: 2163
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocar=
u <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@mande=
lbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--WL8DAmhDp9I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2163?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">sitnl: clear inet_address_t locals=
 with CLEAR()<br><br>The inet_address_t locals were initialized with &quot;=
=3D { 0 }&quot;, which only<br>initializes the first union member, the 4 by=
te ipv4=2E GCC 15 and later<br>no longer clear the rest of the union for th=
is, so the IPv6 addresses<br>of these locals keep up to 12 bytes of stack g=
arbage when the caller<br>passes no address=2E<br><br>net_route_v6_del() th=
en sends a garbage RTA_GATEWAY for routes without<br>a gateway, and the ker=
nel refuses to delete them=2E net_route_v6_best_gw()<br>looks up a garbage =
destination when asked for the default route=2E<br><br>Clear the whole unio=
n with CLEAR() instead=2E The other inet_address_t<br>locals are cleared th=
e same way, so none relies on the partial<br>initialization=2E<br><br>Laten=
t since c6542257 (&quot;introduce sitnl: Simplified Interface To<br>NetLink=
&quot;)=2E<br><br>Change-Id: I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f<br>S=
igned-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: An=
tonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2163<br>Message-Id: &lt;20261110112059=2E308=
32-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg41061=2Ehtml<br>Signed-off-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/networki=
ng_sitnl=2Ec<br>1 file changed, 40 insertions(+), 15 deletions(-)<br><br></=
pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/network=
ing_sitnl=2Ec</span><br><span>index 97ff7bd=2E=2Eeafb9f7 100644</span><br><=
span>--- a/src/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/src/openv=
pn/networking_sitnl=2Ec</span><br><span>@@ -612,10 +612,12 @@</span><br><sp=
an> net_route_v6_best_gw(openvpn_net_ctx_t *ctx, const struct in6_addr *dst=
, struct in6_addr *best_gw,</span><br><span>                      char *bes=
t_iface)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    inet_address_t dst_v6 =3D { 0 };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    inet_address_t dst_v6;</span><br><span>     char=
 buf[INET6_ADDRSTRLEN];</span><br><span>     int ret;</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(dst_v6);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if=
 (dst)</span><br><span>     {</span><br><span>         dst_v6=2Eipv6 =3D *d=
st;</span><br><span>@@ -640,10 +642,12 @@</span><br><span> net_route_v4_bes=
t_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst, in_addr_t *best_gw,</spa=
n><br><span>                      char *best_iface)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    inet_address_t dst_v4 =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    inet_=
address_t dst_v4;</span><br><span>     char buf[INET_ADDRSTRLEN];</span><br=
><span>     int ret;</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    CLEAR(dst_v4);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span>     if (dst)</span><br><span>     {</sp=
an><br><span>         dst_v4=2Eipv4 =3D htonl(*dst);</span><br><span>@@ -10=
40,9 +1044,11 @@</span><br><span> int</span><br><span> net_addr_v4_add(cons=
t openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int pre=
fixlen)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    inet_address_t addr_v4 =3D { 0 };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    inet_address_t addr_v4;</span><br><span>     cha=
r buf[INET_ADDRSTRLEN];</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    CLEAR(addr_v4);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span>     if (!addr)</span><br><span>    =
 {</span><br><span>         return -EINVAL;</span><br><span>@@ -1060,9 +106=
6,11 @@</span><br><span> net_addr_v6_add(const openvpn_net_ctx_t *ctx, cons=
t char *iface, const struct in6_addr *addr,</span><br><span>               =
  int prefixlen)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    inet_address_t addr_v6 =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    inet_address_t addr_v6;</span><br><sp=
an>     char buf[INET6_ADDRSTRLEN];</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    CLEAR(addr_v6);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (!addr)</span><b=
r><span>     {</span><br><span>         return -EINVAL;</span><br><span>@@ =
-1079,9 +1087,11 @@</span><br><span> int</span><br><span> net_addr_v4_del(c=
onst openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int =
prefixlen)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    inet_address_t addr_v4 =3D { 0 };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    inet_address_t addr_v4;</span><br><span>     =
char buf[INET_ADDRSTRLEN];</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    CLEAR(addr_v4);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>     if (!addr)</span><br><span> =
    {</span><br><span>         return -EINVAL;</span><br><span>@@ -1099,9 +=
1109,11 @@</span><br><span> net_addr_v6_del(const openvpn_net_ctx_t *ctx, c=
onst char *iface, const struct in6_addr *addr,</span><br><span>            =
     int prefixlen)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    inet_address_t addr_v6 =3D { 0 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    inet_address_t addr_v6;</span><br><s=
pan>     char buf[INET6_ADDRSTRLEN];</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    CLEAR(addr_v6);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (!addr)</span><=
br><span>     {</span><br><span>         return -EINVAL;</span><br><span>@@=
 -1119,11 +1131,14 @@</span><br><span> net_addr_ptp_v4_add(const openvpn_ne=
t_ctx_t *ctx, const char *iface, const in_addr_t *local,</span><br><span>  =
                   const in_addr_t *remote)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    inet_address_t local_v4 =3D { =
0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    inet_address_=
t remote_v4 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    inet_address_t local_v4;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    inet_address_t remote_v4;</span><br><span>     char buf1[IN=
ET_ADDRSTRLEN];</span><br><span>     char buf2[INET_ADDRSTRLEN];</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(lo=
cal_v4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(r=
emote_v4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>     if (!local)</span><br><span>     {</span><br><span>         re=
turn -EINVAL;</span><br><span>@@ -1147,9 +1162,10 @@</span><br><span> net_a=
ddr_ptp_v4_del(const openvpn_net_ctx_t *ctx, const char *iface, const in_ad=
dr_t *local,</span><br><span>                     const in_addr_t *remote)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 inet_address_t local_v4 =3D { 0 };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    inet_address_t local_v4;</span><br><span>     char buf[=
INET6_ADDRSTRLEN];</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    CLEAR(local_v4);</span><br><span> </span><br><span>   =
  if (!local)</span><br><span>     {</span><br><span>@@ -1227,11 +1243,14 @=
@</span><br><span> net_route_v6_add(const openvpn_net_ctx_t *ctx, const str=
uct in6_addr *dst, int prefixlen,</span><br><span>                  const s=
truct in6_addr *gw, const char *iface, uint32_t table, int metric)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    inet_ad=
dress_t dst_v6 =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    inet_address_t gw_v6 =3D { 0 };</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    inet_address_t dst_v6;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    inet_address_t gw_v6;</span><br><span>     c=
har dst_str[INET6_ADDRSTRLEN];</span><br><span>     char gw_str[INET6_ADDRS=
TRLEN];</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    CLEAR(dst_v6);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    CLEAR(gw_v6);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>     if (dst)</span><br><span>     {</span><br><span>  =
       dst_v6=2Eipv6 =3D *dst;</span><br><span>@@ -1278,11 +1297,14 @@</spa=
n><br><span> net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t=
 *dst, int prefixlen, const in_addr_t *gw,</span><br><span>                =
  const char *iface, uint32_t table, int metric)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    inet_address_t dst_v4 =3D=
 { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    inet_addre=
ss_t gw_v4 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    inet_address_t dst_v4;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    inet_address_t gw_v4;</span><br><span>     char dst_str[INET_A=
DDRSTRLEN];</span><br><span>     char gw_str[INET_ADDRSTRLEN];</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(dst_=
v4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(gw_v4=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
     if (dst)</span><br><span>     {</span><br><span>         dst_v4=2Eipv4=
 =3D htonl(*dst);</span><br><span>@@ -1304,11 +1326,14 @@</span><br><span> =
net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, =
int prefixlen,</span><br><span>                  const struct in6_addr *gw,=
 const char *iface, uint32_t table, int metric)</span><br><span> {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    inet_address_t dst_v6 =3D =
{ 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    inet_addres=
s_t gw_v6 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    inet_address_t dst_v6;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    inet_address_t gw_v6;</span><br><span>     char dst_str[INET6_A=
DDRSTRLEN];</span><br><span>     char gw_str[INET6_ADDRSTRLEN];</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(dst=
_v6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(gw_v=
6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>     if (dst)</span><br><span>     {</span><br><span>         dst_v6=2Eipv=
6 =3D *dst;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2163?usp=3Demail">change 2163</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2163?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I5c52cc5c3aaad21d1c22f3=
6f6451235302ea6c4f </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2163 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Q=
uartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>

</body></html>
--WL8DAmhDp9I=--


--===============2955921770574368403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2955921770574368403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2955921770574368403==--

