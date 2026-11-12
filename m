Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73F1606A201
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XYDZ+2Mu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Y0oW0PwA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=H/iPkwVU;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DT8W/+mY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QWk4EltNoPngo+Fm6U03xVVywf+739DHxy1pJiiOy5U=; b=XYDZ+2Mu/WLB6cGA/Lc0cHYDBP
	eK614hwOqY34/v2gdw4HDW2n2Tj+qJOgwyEF+Yi8ZpD8i8AGPF3RqmOLEVc1cTwAf+5+ViDnpynHb
	BNmljF68FK8sVJkyNbi85niWQ+cgRA8xoNbPp44oTOdDU4NOzHyXWua/HfxZ69Za8YdQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRYpk-000000004B8-2REL;
	Thu, 12 Nov 2026 17:43:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRYph-000000004At-2tG0
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:43:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sRwjmUz8E2maRBEGVUJf5etjJqoCey1cATmCklZ7YHY=; b=Y0oW0PwAv3EApo/jwsty461S+r
 28X3woU4oCp8hpVocDMaFQv5z6PKO0bityG6I6jf7m90Q/nPt7qXG1+9oEWsqozDxxFKBktDPoYNd
 Rg4YZ8nCl7sc980Oydea9uVTfPMnBPF7D6YtHWSUc4iDG4rYllxSBogZOuWCXb1AeoYI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sRwjmUz8E2maRBEGVUJf5etjJqoCey1cATmCklZ7YHY=; b=H/iPkwVUJfrudcJImF6i16XT8b
 Ii2mT/gaVTHGeDUuaTt3Nsjv8S4rhRJ/GEUKAmBInDO1bGAmQr4GDlTU6vvMNyEo8dlFO8gXaKiS4
 QTLDCtoe9kLC3goii1804QsnsRe+Y8qXemPHwf7pVeNZciw6lbQOqLFThiSByQgR+3Po=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRYpS-000000003pa-0euS for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:43:21 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so569545e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 09:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794505391; x=1795110191; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sRwjmUz8E2maRBEGVUJf5etjJqoCey1cATmCklZ7YHY=;
 b=DT8W/+mYKUs/DwKPXGyQdnXyGXeLbeoaL0EqPVJf40CHD2n9qJ+gatsyB1MENrKOtf
 w0X0ulm6aHbfVOgpWasNQuN3fZf/b8i1sucIwcX3jETQhfehAaMQwm7KQ3A8JkzI93Nu
 3dkjGi5w5IfLazTrpEdXVsycID5Q/uMf3wYNj4T61WeQbrqqz/P1sbCgd/ZRLBjU30Q9
 I6wkzWHRf6kpK3YJJhPSaJlxlVYuaxCe5RKH1/61zKD9gU+GW6XJdFMNKWe2XJY5pNUw
 rHMJy9sVSnUttoXl5LGnRvlal+2SwzBv2q7a+hYIYaYY0hvsLlEENmfDdFRhKuEKrZa5
 VEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794505391; x=1795110191;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sRwjmUz8E2maRBEGVUJf5etjJqoCey1cATmCklZ7YHY=;
 b=pa9c2XxmiNxDog09NS48f3n7iVAfzVLzoQrVWROIZXuuQIWilqpi9QsQuKqdvHa66S
 Du0re4k0QOIFA3ox+s/N5Us3Unt2jNCN1jA1my4+d3tGj3dR+SYmOhKf9FaI8v22KzY5
 w+nM7YH4l/7r67jJC49mfaG8NFYLBqm9Yw8yA55N2SHo/5MrBxH4m07q0b1194ZUKejm
 FjptQi3VrIixR/ZRO8qBV3+Z2rabjSFSf47ZIyGNOaJa0KPz6LwATgkbunKao268Izvu
 gtZkbla9Ak4blND+gg7MFK6UpXIrgqki9z06mPj+y6ucpwTQDfbz8V2+n3GNOnCPpcmY
 7Y1g==
X-Gm-Message-State: APuU4Z/7kTxGVa91x6wh041/wJK+j13otQQSasECNiEYBC5t2EnXnXuB
 sIeWSDA+Jr/fy8f0NC9yPhytPbC3tq9yhcm4YSLJD+7Z8T66daqTADCuZ03j+TbN+qQ3q5b4sA6
 YM5KajPcE0j1E6X7QB4vuBMklpq8xpEZmefrGYFuiCearwZQpyeeGF2KsaMH8qwjoAWXQ
X-Gm-Gg: AYBFou27b8TKHshqxaW/1eZFVv/A241SCjHxapYlVXWhjCd2ouAeMtEohyMtMPJVJPj
 0CCjvxuMa7F7wfAjVl+6M3yWfzRkhrtB61SupTPZU6upLajrmgnMnZHPu81GTRIfVO8OA2CKWs6
 FgAPwwHYPI7OmBZUKG11tXb6Aea5dhoAt6ODO1eF0/0R4WHCuonJwR9gnYalBOvhIj77E8p/l+H
 WXcAaHPFvLlGLGVehZwMcM+ghrPyopdqp6CQ7aPRWkYwp334iW5srkV6wRzdpiL6vc9LksQSh3Q
 X+25srhW3ebpPM72gVRzY5dg0ZMNebsgrgoeV0EUQfO1LuDft/FWQ1YHxP7Sy4SUCPW4PHGbyqo
 DyEXjfwqu+1xjNMpZ8pKudzn/L5US/ug2x01K0CGddMLA5koAD4vnIIfZ0TpXIkNfNEvipBNEXI
 WOQCO8GGB54vHfsIT9tOe1FjwDRF/zs7N6FczG2XxwLyhILKT5XOcHejrsxY0sMHF6F0m2jwdFN
 4GY/xxAMZQ4ZhYu+q/piRVQPg4S+UWSgpuGv3xOuV1EmJ7FcPQk/DDpXIwQkDXGWqbpUUYOOXoY
 2NjMhxX/g6/qF+nOh7uV8aGzJ2FbWj2+1FNukejlUl+2TN6V1XsKnxlIT9wpJqFnRK0IJ1k/c9Z
 rfifE6dRl1kQ9VdfDfKdJOIWeMksCHQmHGdpJErqlEGk96faa8dcoZ6yu6yjlS8d9/VaK8aBnOw
 ztrJcXs17po3uVok4=
X-Received: by 2002:a05:600c:4f84:b0:4ac:da92:2bd4 with SMTP id
 5b1f17b1804b1-4ba0931d9eamr117108815e9.1.1794505391334; 
 Thu, 12 Nov 2026 09:43:11 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0953d26asm85163675e9.4.2026.11.12.09.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:43:10 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 17:43:09 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f
X-Gerrit-Change-Number: 2163
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2163?usp=email>
X-Gerrit-Commit: 2a59209487d37e8d28ee4394bfa4de6e011a3c05
In-Reply-To: <gerrit.1794307698000.I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f@gerrit.openvpn.net>
References: <gerrit.1794307698000.I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzA3Njk4MDAwLkk1YzUyY2M1YzNhYWFkMjFkMWMyMmYzNmY2NDUxMjM1MzAyZWE2YzRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8f515b48e1c4e75f0068136f463f84f43cc2a873-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRYpS-000000003pa-0euS
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6809414915455153827=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6809414915455153827==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FPjrvg2fGEE="; charset=UTF-8

--FPjrvg2fGEE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2163?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Antonio Quartulli


Change subject: sitnl: clear inet_ad=
dress_t locals with CLEAR()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

sitnl: clear inet_address_t locals with CLEAR()

The inet_=
address_t locals were initialized with "=3D { 0 }", which only
initializes =
the first union member, the 4 byte ipv4=2E GCC 15 and later
no longer clear=
 the rest of the union for this, so the IPv6 addresses
of these locals keep=
 up to 12 bytes of stack garbage when the caller
passes no address=2E

net_=
route_v6_del() then sends a garbage RTA_GATEWAY for routes without
a gatewa=
y, and the kernel refuses to delete them=2E net_route_v6_best_gw()
looks up=
 a garbage destination when asked for the default route=2E

Clear the whole=
 union with CLEAR() instead=2E The other inet_address_t
locals are cleared =
the same way, so none relies on the partial
initialization=2E

Latent since=
 c6542257 ("introduce sitnl: Simplified Interface To
NetLink")=2E

Change-I=
d: I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f
Signed-off-by: Razvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Acked-by: Antonio Quartulli <antonio@mandelbit=2Ec=
om>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2163
Message-Id:=
 <20261110112059=2E30832-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email=
-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41061=2Ehtml
Sign=
ed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/network=
ing_sitnl=2Ec
1 file changed, 40 insertions(+), 15 deletions(-)


  git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/2163/3

diff -=
-git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
=
index 97ff7bd=2E=2Eeafb9f7 100644
--- a/src/openvpn/networking_sitnl=2Ec
++=
+ b/src/openvpn/networking_sitnl=2Ec
@@ -612,10 +612,12 @@
 net_route_v6_be=
st_gw(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, struct in6_addr *=
best_gw,
                      char *best_iface)
 {
-    inet_address_t dst=
_v6 =3D { 0 };
+    inet_address_t dst_v6;
     char buf[INET6_ADDRSTRLEN];=

     int ret;
 
+    CLEAR(dst_v6);
+
     if (dst)
     {
         dst_v6=
=2Eipv6 =3D *dst;
@@ -640,10 +642,12 @@
 net_route_v4_best_gw(openvpn_net_c=
tx_t *ctx, const in_addr_t *dst, in_addr_t *best_gw,
                      =
char *best_iface)
 {
-    inet_address_t dst_v4 =3D { 0 };
+    inet_addres=
s_t dst_v4;
     char buf[INET_ADDRSTRLEN];
     int ret;
 
+    CLEAR(dst_=
v4);
+
     if (dst)
     {
         dst_v4=2Eipv4 =3D htonl(*dst);
@@ -104=
0,9 +1044,11 @@
 int
 net_addr_v4_add(const openvpn_net_ctx_t *ctx, const c=
har *iface, const in_addr_t *addr, int prefixlen)
 {
-    inet_address_t ad=
dr_v4 =3D { 0 };
+    inet_address_t addr_v4;
     char buf[INET_ADDRSTRLEN=
];
 
+    CLEAR(addr_v4);
+
     if (!addr)
     {
         return -EINVAL;=

@@ -1060,9 +1066,11 @@
 net_addr_v6_add(const openvpn_net_ctx_t *ctx, cons=
t char *iface, const struct in6_addr *addr,
                 int prefixlen)=

 {
-    inet_address_t addr_v6 =3D { 0 };
+    inet_address_t addr_v6;
   =
  char buf[INET6_ADDRSTRLEN];
 
+    CLEAR(addr_v6);
+
     if (!addr)
    =
 {
         return -EINVAL;
@@ -1079,9 +1087,11 @@
 int
 net_addr_v4_del(co=
nst openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int p=
refixlen)
 {
-    inet_address_t addr_v4 =3D { 0 };
+    inet_address_t add=
r_v4;
     char buf[INET_ADDRSTRLEN];
 
+    CLEAR(addr_v4);
+
     if (!ad=
dr)
     {
         return -EINVAL;
@@ -1099,9 +1109,11 @@
 net_addr_v6_del=
(const openvpn_net_ctx_t *ctx, const char *iface, const struct in6_addr *ad=
dr,
                 int prefixlen)
 {
-    inet_address_t addr_v6 =3D { 0 =
};
+    inet_address_t addr_v6;
     char buf[INET6_ADDRSTRLEN];
 
+    CLE=
AR(addr_v6);
+
     if (!addr)
     {
         return -EINVAL;
@@ -1119,11 =
+1131,14 @@
 net_addr_ptp_v4_add(const openvpn_net_ctx_t *ctx, const char *=
iface, const in_addr_t *local,
                     const in_addr_t *remote=
)
 {
-    inet_address_t local_v4 =3D { 0 };
-    inet_address_t remote_v4 =
=3D { 0 };
+    inet_address_t local_v4;
+    inet_address_t remote_v4;
   =
  char buf1[INET_ADDRSTRLEN];
     char buf2[INET_ADDRSTRLEN];
 
+    CLEAR=
(local_v4);
+    CLEAR(remote_v4);
+
     if (!local)
     {
         retur=
n -EINVAL;
@@ -1147,9 +1162,10 @@
 net_addr_ptp_v4_del(const openvpn_net_ct=
x_t *ctx, const char *iface, const in_addr_t *local,
                     c=
onst in_addr_t *remote)
 {
-    inet_address_t local_v4 =3D { 0 };
+    ine=
t_address_t local_v4;
     char buf[INET6_ADDRSTRLEN];
 
+    CLEAR(local_v=
4);
 
     if (!local)
     {
@@ -1227,11 +1243,14 @@
 net_route_v6_add(con=
st openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
     =
             const struct in6_addr *gw, const char *iface, uint32_t table, =
int metric)
 {
-    inet_address_t dst_v6 =3D { 0 };
-    inet_address_t gw=
_v6 =3D { 0 };
+    inet_address_t dst_v6;
+    inet_address_t gw_v6;
     =
char dst_str[INET6_ADDRSTRLEN];
     char gw_str[INET6_ADDRSTRLEN];
 
+    =
CLEAR(dst_v6);
+    CLEAR(gw_v6);
+
     if (dst)
     {
         dst_v6=2E=
ipv6 =3D *dst;
@@ -1278,11 +1297,14 @@
 net_route_v4_del(const openvpn_net_=
ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
     =
             const char *iface, uint32_t table, int metric)
 {
-    inet_ad=
dress_t dst_v4 =3D { 0 };
-    inet_address_t gw_v4 =3D { 0 };
+    inet_ad=
dress_t dst_v4;
+    inet_address_t gw_v4;
     char dst_str[INET_ADDRSTRLE=
N];
     char gw_str[INET_ADDRSTRLEN];
 
+    CLEAR(dst_v4);
+    CLEAR(gw_=
v4);
+
     if (dst)
     {
         dst_v4=2Eipv4 =3D htonl(*dst);
@@ -130=
4,11 +1326,14 @@
 net_route_v6_del(const openvpn_net_ctx_t *ctx, const stru=
ct in6_addr *dst, int prefixlen,
                  const struct in6_addr *g=
w, const char *iface, uint32_t table, int metric)
 {
-    inet_address_t ds=
t_v6 =3D { 0 };
-    inet_address_t gw_v6 =3D { 0 };
+    inet_address_t ds=
t_v6;
+    inet_address_t gw_v6;
     char dst_str[INET6_ADDRSTRLEN];
     =
char gw_str[INET6_ADDRSTRLEN];
 
+    CLEAR(dst_v6);
+    CLEAR(gw_v6);
+
 =
    if (dst)
     {
         dst_v6=2Eipv6 =3D *dst;

-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2163?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I5c52cc5c3aaad21d1c22f36f6451235302ea=
6c4f
Gerrit-Change-Number: 2163
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <anto=
nio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--FPjrvg2fGEE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2163?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Antonio Quartulli</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">sitnl: clear inet_address_t locals with CLEAR()<br><br>The inet_address=
_t locals were initialized with &quot;=3D { 0 }&quot;, which only<br>initia=
lizes the first union member, the 4 byte ipv4=2E GCC 15 and later<br>no lon=
ger clear the rest of the union for this, so the IPv6 addresses<br>of these=
 locals keep up to 12 bytes of stack garbage when the caller<br>passes no a=
ddress=2E<br><br>net_route_v6_del() then sends a garbage RTA_GATEWAY for ro=
utes without<br>a gateway, and the kernel refuses to delete them=2E net_rou=
te_v6_best_gw()<br>looks up a garbage destination when asked for the defaul=
t route=2E<br><br>Clear the whole union with CLEAR() instead=2E The other i=
net_address_t<br>locals are cleared the same way, so none relies on the par=
tial<br>initialization=2E<br><br>Latent since c6542257 (&quot;introduce sit=
nl: Simplified Interface To<br>NetLink&quot;)=2E<br><br>Change-Id: I5c52cc5=
c3aaad21d1c22f36f6451235302ea6c4f<br>Signed-off-by: Razvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@mandelbit=
=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2163<b=
r>Message-Id: &lt;20261110112059=2E30832-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg41061=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>M src/openvpn/networking_sitnl=2Ec<br>1 file changed, 40 in=
sertions(+), 15 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/2163/3</pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span=
><br><span>index 97ff7bd=2E=2Eeafb9f7 100644</span><br><span>--- a/src/open=
vpn/networking_sitnl=2Ec</span><br><span>+++ b/src/openvpn/networking_sitnl=
=2Ec</span><br><span>@@ -612,10 +612,12 @@</span><br><span> net_route_v6_be=
st_gw(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, struct in6_addr *=
best_gw,</span><br><span>                      char *best_iface)</span><br>=
<span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    inet_addr=
ess_t dst_v6 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    inet_address_t dst_v6;</span><br><span>     char buf[INET6_ADDRSTRL=
EN];</span><br><span>     int ret;</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    CLEAR(dst_v6);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (dst)</span><br>=
<span>     {</span><br><span>         dst_v6=2Eipv6 =3D *dst;</span><br><sp=
an>@@ -640,10 +642,12 @@</span><br><span> net_route_v4_best_gw(openvpn_net_=
ctx_t *ctx, const in_addr_t *dst, in_addr_t *best_gw,</span><br><span>     =
                 char *best_iface)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    inet_address_t dst_v4 =3D { 0 };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    inet_address_t dst_v4;=
</span><br><span>     char buf[INET_ADDRSTRLEN];</span><br><span>     int r=
et;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    CLEAR(dst_v4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span>     if (dst)</span><br><span>     {</span><br><span>    =
     dst_v4=2Eipv4 =3D htonl(*dst);</span><br><span>@@ -1040,9 +1044,11 @@<=
/span><br><span> int</span><br><span> net_addr_v4_add(const openvpn_net_ctx=
_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    inet_add=
ress_t addr_v4 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    inet_address_t addr_v4;</span><br><span>     char buf[INET_ADDRST=
RLEN];</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    CLEAR(addr_v4);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span>     if (!addr)</span><br><span>     {</span><br><spa=
n>         return -EINVAL;</span><br><span>@@ -1060,9 +1066,11 @@</span><br=
><span> net_addr_v6_add(const openvpn_net_ctx_t *ctx, const char *iface, co=
nst struct in6_addr *addr,</span><br><span>                 int prefixlen)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 inet_address_t addr_v6 =3D { 0 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    inet_address_t addr_v6;</span><br><span>     char buf[IN=
ET6_ADDRSTRLEN];</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    CLEAR(addr_v6);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span>     if (!addr)</span><br><span>     {</spa=
n><br><span>         return -EINVAL;</span><br><span>@@ -1079,9 +1087,11 @@=
</span><br><span> int</span><br><span> net_addr_v4_del(const openvpn_net_ct=
x_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    inet_ad=
dress_t addr_v4 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    inet_address_t addr_v4;</span><br><span>     char buf[INET_ADDRS=
TRLEN];</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    CLEAR(addr_v4);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span>     if (!addr)</span><br><span>     {</span><br><sp=
an>         return -EINVAL;</span><br><span>@@ -1099,9 +1109,11 @@</span><b=
r><span> net_addr_v6_del(const openvpn_net_ctx_t *ctx, const char *iface, c=
onst struct in6_addr *addr,</span><br><span>                 int prefixlen)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  inet_address_t addr_v6 =3D { 0 };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    inet_address_t addr_v6;</span><br><span>     char buf[I=
NET6_ADDRSTRLEN];</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    CLEAR(addr_v6);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span>     if (!addr)</span><br><span>     {</sp=
an><br><span>         return -EINVAL;</span><br><span>@@ -1119,11 +1131,14 =
@@</span><br><span> net_addr_ptp_v4_add(const openvpn_net_ctx_t *ctx, const=
 char *iface, const in_addr_t *local,</span><br><span>                     =
const in_addr_t *remote)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    inet_address_t local_v4 =3D { 0 };</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    inet_address_t remote_v4 =3D { 0=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    inet_address=
_t local_v4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ine=
t_address_t remote_v4;</span><br><span>     char buf1[INET_ADDRSTRLEN];</sp=
an><br><span>     char buf2[INET_ADDRSTRLEN];</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(local_v4);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(remote_v4);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (!l=
ocal)</span><br><span>     {</span><br><span>         return -EINVAL;</span=
><br><span>@@ -1147,9 +1162,10 @@</span><br><span> net_addr_ptp_v4_del(cons=
t openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,</span>=
<br><span>                     const in_addr_t *remote)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    inet_address_t loc=
al_v4 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 inet_address_t local_v4;</span><br><span>     char buf[INET6_ADDRSTRLEN];<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  CLEAR(local_v4);</span><br><span> </span><br><span>     if (!local)</span=
><br><span>     {</span><br><span>@@ -1227,11 +1243,14 @@</span><br><span> =
net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, =
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
6 =3D *dst;</span><br><span>@@ -1278,11 +1297,14 @@</span><br><span> net_ro=
ute_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixle=
n, const in_addr_t *gw,</span><br><span>                  const char *iface=
, uint32_t table, int metric)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    inet_address_t dst_v4 =3D { 0 };</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    inet_address_t gw_v4 =3D { 0 =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    inet_address_=
t dst_v4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    inet_a=
ddress_t gw_v4;</span><br><span>     char dst_str[INET_ADDRSTRLEN];</span><=
br><span>     char gw_str[INET_ADDRSTRLEN];</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(dst_v4);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(gw_v4);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (dst)</span=
><br><span>     {</span><br><span>         dst_v4=2Eipv4 =3D htonl(*dst);</=
span><br><span>@@ -1304,11 +1326,14 @@</span><br><span> net_route_v6_del(co=
nst openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,</spa=
n><br><span>                  const struct in6_addr *gw, const char *iface,=
 uint32_t table, int metric)</span><br><span> {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    inet_address_t dst_v6 =3D { 0 };</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    inet_address_t gw_v6 =3D { 0 }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    inet_address_t=
 dst_v6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    inet_ad=
dress_t gw_v6;</span><br><span>     char dst_str[INET6_ADDRSTRLEN];</span><=
br><span>     char gw_str[INET6_ADDRSTRLEN];</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(dst_v6);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(gw_v6);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (dst)</spa=
n><br><span>     {</span><br><span>         dst_v6=2Eipv6 =3D *dst;</span><=
br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2163?usp=3Demail">change 2163</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2163?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType=
: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I5c52cc5c3aaad21d1c22f36f6451235302ea6=
c4f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2163 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;an=
tonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--FPjrvg2fGEE=--


--===============6809414915455153827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6809414915455153827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6809414915455153827==--

