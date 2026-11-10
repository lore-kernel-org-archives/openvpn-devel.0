Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D9E606A335
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kO63xBAs;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jW48J4SL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FM4sITC0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IfcNlqZX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YMk+MbGAQ2P9eyDL1G8qwolUhtmDAPIQRuA8ifkh6rU=; b=kO63xBAsHQA2SND/+EnpZUmIL7
	TlPsKpvb2GRR9tcOZTvLz+JtqFqJCkniRc/Epa4uxR543EgiM1fIUiOcQR3anH2f1OggRRUKoYkvD
	1wfkZ/SnpLyqTmJRHP5mFtP+uJzdIY/Nb+9297hAryeS+nfM/nHfvnDHF9+Wd5fq5kUk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQjiZ-000000004vl-0dYI;
	Tue, 10 Nov 2026 11:08:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQjiY-000000004vZ-1Vnd
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:08:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cUiMWuj5KYArglA5zgZBKMRq2Ky9rAsZxbnmaBv5QQI=; b=jW48J4SLlxINqAus87MWDJsHY7
 O/nbVPI8AsLXwUMxFWCoD/ZOVHItw2Le+xUusnn2K3zkz57NexNCRFhtCMqH2mPEodwziEIH226KY
 XMjt+BeOjxhqbqZ+HJG4nwdiu9w2erjAPXWqaBHK1cv+SMrR+rQ+A19C2qx2GcUGQhKM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cUiMWuj5KYArglA5zgZBKMRq2Ky9rAsZxbnmaBv5QQI=; b=FM4sITC00iLzigU7lNdersWP4e
 S1n5XjE5r1IjsNYT4Mc3R87DtgcJvgukvqDUih4bR+aW0KepmMXUrw0oyl3eGOMFMYWNhHGi4TMQK
 F2ti1VFNm7aCCGqQ+eZFYrUqBcyPgs8cudJ/v7B7W8qr19QWTUvJgDsW0Wdq8TePxlWw=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQjiW-000000003tX-2FJq for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:08:46 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso20046555e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 03:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794308918; x=1794913718; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cUiMWuj5KYArglA5zgZBKMRq2Ky9rAsZxbnmaBv5QQI=;
 b=IfcNlqZXIpO/N13S5w0H3zcadbWxA7OKaYysPsTQSl8yaOJzufQBp+HvziW9JPHYhv
 YFPR47F47hEbJP0gllFywxzQ4O41B8lAbb2wnSXimOl1YrwCrZ8ihlcZgcbJA5D/QEmz
 4jCaxGn2WR68mdlQAHlskypIMrpuTOrLtrUVQF9bnqr1mggvVA6Zcewkm7+T07I9oUd7
 1r9VvWOWbl4QpRPGe5iL4GQD0CW3Iwbnv7uefAK9hJxzT+RTdswNmOAJXMfIhCyMrfvl
 ne6Puw25uxz/rW/SgvvxClnp+0XaLsgEzm8VWpQBV37DhUX+R4awBfZTSKZTptgt57Mp
 mLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794308918; x=1794913718;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cUiMWuj5KYArglA5zgZBKMRq2Ky9rAsZxbnmaBv5QQI=;
 b=spCk2R1lyeReUd35da9oP4o5s5iXwNDvcPzPQ06C2EJC7rl/lem/W/TXvIR11gbdGF
 UR3gIgbAypQat2K2O02d4HChfnVv0WtpoFRHdWooqx47tTQ2l0taxEID2eeDpEtUZKTE
 xC3fquDjY4VQgMD85ozLLkaaXt4buTIxdMvG9DwQA1sANjmgK+2F7sN34tiTrcfL8EIf
 i8DJLVfOaMoaXn20i5KEVnS/T+uFMYdsyDioyiZ3zHoAP7Vh/9ZKrw6bvELO892088il
 NN8D0qLxE9SIt1kO8lOBo3SFSLjCBOD4PEDjuGT4KU2j7U/mZR3G2R29xGVDUgfAK1BN
 ruVw==
X-Gm-Message-State: APuU4Z8JrqpyrmasIOR3l2uDoLxn/cDDVgauGDXl03nhOHmz70zkfM6/
 0uGX/EeOo1eGYeTODJpZWlD45bLRefiIqvvARLfGRD/bBLLwf96pUY3TXPuzi7F3Cz3vN/BB3Fh
 dYIJT4WoCFCzIYNLKmVzx4H5xv7opWtAjBWZGNqEB9XbvZgZCOBkAX8LcdISA7Q16bia0k471Lk
 wyzy5fQg==
X-Gm-Gg: AYBFou2UtM67/UmNh2lwsDkkgZEHoDkmvkCy+d/REVO8ifYx72hI4ObkDl/UZfKbXWg
 soTJksaoC/5purNKvnnqytfonlMLJOIxAwh+uYYegy082zcOVtiSv9g89urLIZtzvfvG9EAq7Z+
 X2XQDeIhbCG09HsT1w8rVgzs0GrV2euifbwDNgwougB0a4OmM3imod0m/QVyxFYRxpf9vxLUROA
 Kzu+2pcgT1OjYnpqO4TBn9nmeU4tp0FgyFKpA1xgN285S+Mn+JiQ1iqj6oZ4337xWzyptDJvmEn
 LTwfYfkYe70D887JoM+Ra13xhkpecJYcAtQfRE+c02z3fJ+PbKbVSN2QZpuufkAVuegM0S5XnUY
 jV1qrGqQlkGcCvaU5svyc/BHtXYUtNgypBu8vjLQVcxMaf1nGaFlc6ooSL/VROYzNNSo/mkieqZ
 MdKTiJG8H8rSIP7hPQ2ZENKxUTRm1NUTfEvtxtj/VHsQxC9uVbNSWQHkzXGXmOuIXwmVW9AajZr
 gCsetbeolv4MTto+EipzkAKpi7Kom8Zp/Duq+VGRaAk9fFQsRx4N47+juH8RrAxq9VYSpxt4RKn
 IdVQ3FZHTXthpFWF7nUUGrbzPUhRxu3S+fkN0RNjOChWCODBK5rQwyLk3qkGepFOhF2Nh7/bnaf
 aNUaNk0/16xiYP2RND9y9ifZiDpyi6B4NsdpowABnlAPGvaQcOHQANop9Yp3lyKhKXOWDdD2jD9
 +Ew6t+Ddo+6GFg4w8=
X-Received: by 2002:a05:600c:4f86:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4ba022c9c7dmr40242945e9.0.1794308917573; 
 Tue, 10 Nov 2026 03:08:37 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fba476sm67614045e9.2.2026.11.10.03.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 03:08:37 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 11:08:36 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f
X-Gerrit-Change-Number: 2163
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2163?usp=email>
X-Gerrit-Commit: 4cec021e663787b962dc818dec3af846fcc88b78
In-Reply-To: <gerrit.1794307698000.I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f@gerrit.openvpn.net>
References: <gerrit.1794307698000.I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzA3Njk4MDAwLkk1YzUyY2M1YzNhYWFkMjFkMWMyMmYzNmY2NDUxMjM1MzAyZWE2YzRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d5ae4b7a98b664ebaf9cfa2431de0cdebd0c7ae1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQjiW-000000003tX-2FJq
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6667620953487943730=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6667620953487943730==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PRozarqUnxM="; charset=UTF-8

--PRozarqUnxM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, R=C4=
=83zvan Cojocaru=2E

Hello Antonio Quartulli, Arne Schwabe, 

I'd like you =
to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2163?usp=3Demail

to look at the new patch set (#2)=2E

The foll=
owing approvals got outdated and were removed:
Code-Review-1 by Antonio Qua=
rtulli


Change subject: sitnl: clear inet_address_t locals with CLEAR()
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

sitnl: clear =
inet_address_t locals with CLEAR()

The inet_address_t locals were initiali=
zed with "=3D { 0 }", which only
initializes the first union member, the 4 =
byte ipv4=2E GCC 15 and later
no longer clear the rest of the union for thi=
s, so the IPv6 addresses
of these locals keep up to 12 bytes of stack garba=
ge when the caller
passes no address=2E

net_route_v6_del() then sends a ga=
rbage RTA_GATEWAY for routes without
a gateway, and the kernel refuses to d=
elete them=2E net_route_v6_best_gw()
looks up a garbage destination when as=
ked for the default route=2E

Clear the whole union with CLEAR() instead=2E=
 The other inet_address_t
locals are cleared the same way, so none relies o=
n the partial
initialization=2E

Latent since c6542257 ("introduce sitnl: S=
implified Interface To
NetLink")=2E

Change-Id: I5c52cc5c3aaad21d1c22f36f64=
51235302ea6c4f
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M=
 src/openvpn/networking_sitnl=2Ec
1 file changed, 40 insertions(+), 15 dele=
tions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/63/2163/2

diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/n=
etworking_sitnl=2Ec
index 97ff7bd=2E=2Eeafb9f7 100644
--- a/src/openvpn/net=
working_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -612,10 +612,12=
 @@
 net_route_v6_best_gw(openvpn_net_ctx_t *ctx, const struct in6_addr *ds=
t, struct in6_addr *best_gw,
                      char *best_iface)
 {
-  =
  inet_address_t dst_v6 =3D { 0 };
+    inet_address_t dst_v6;
     char bu=
f[INET6_ADDRSTRLEN];
     int ret;
 
+    CLEAR(dst_v6);
+
     if (dst)
  =
   {
         dst_v6=2Eipv6 =3D *dst;
@@ -640,10 +642,12 @@
 net_route_v4_b=
est_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst, in_addr_t *best_gw,
  =
                    char *best_iface)
 {
-    inet_address_t dst_v4 =3D { 0=
 };
+    inet_address_t dst_v4;
     char buf[INET_ADDRSTRLEN];
     int re=
t;
 
+    CLEAR(dst_v4);
+
     if (dst)
     {
         dst_v4=2Eipv4 =3D =
htonl(*dst);
@@ -1040,9 +1044,11 @@
 int
 net_addr_v4_add(const openvpn_net=
_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)
 {
- =
   inet_address_t addr_v4 =3D { 0 };
+    inet_address_t addr_v4;
     char=
 buf[INET_ADDRSTRLEN];
 
+    CLEAR(addr_v4);
+
     if (!addr)
     {
    =
     return -EINVAL;
@@ -1060,9 +1066,11 @@
 net_addr_v6_add(const openvpn_=
net_ctx_t *ctx, const char *iface, const struct in6_addr *addr,
           =
      int prefixlen)
 {
-    inet_address_t addr_v6 =3D { 0 };
+    inet_ad=
dress_t addr_v6;
     char buf[INET6_ADDRSTRLEN];
 
+    CLEAR(addr_v6);
+
=
     if (!addr)
     {
         return -EINVAL;
@@ -1079,9 +1087,11 @@
 int=

 net_addr_v4_del(const openvpn_net_ctx_t *ctx, const char *iface, const in=
_addr_t *addr, int prefixlen)
 {
-    inet_address_t addr_v4 =3D { 0 };
+  =
  inet_address_t addr_v4;
     char buf[INET_ADDRSTRLEN];
 
+    CLEAR(addr=
_v4);
+
     if (!addr)
     {
         return -EINVAL;
@@ -1099,9 +1109,11=
 @@
 net_addr_v6_del(const openvpn_net_ctx_t *ctx, const char *iface, const=
 struct in6_addr *addr,
                 int prefixlen)
 {
-    inet_addres=
s_t addr_v6 =3D { 0 };
+    inet_address_t addr_v6;
     char buf[INET6_ADD=
RSTRLEN];
 
+    CLEAR(addr_v6);
+
     if (!addr)
     {
         return -=
EINVAL;
@@ -1119,11 +1131,14 @@
 net_addr_ptp_v4_add(const openvpn_net_ctx_=
t *ctx, const char *iface, const in_addr_t *local,
                     con=
st in_addr_t *remote)
 {
-    inet_address_t local_v4 =3D { 0 };
-    inet_=
address_t remote_v4 =3D { 0 };
+    inet_address_t local_v4;
+    inet_addr=
ess_t remote_v4;
     char buf1[INET_ADDRSTRLEN];
     char buf2[INET_ADDRS=
TRLEN];
 
+    CLEAR(local_v4);
+    CLEAR(remote_v4);
+
     if (!local)
 =
    {
         return -EINVAL;
@@ -1147,9 +1162,10 @@
 net_addr_ptp_v4_del(=
const openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,
  =
                   const in_addr_t *remote)
 {
-    inet_address_t local_v4=
 =3D { 0 };
+    inet_address_t local_v4;
     char buf[INET6_ADDRSTRLEN];
=
 
+    CLEAR(local_v4);
 
     if (!local)
     {
@@ -1227,11 +1243,14 @@
 =
net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, =
int prefixlen,
                  const struct in6_addr *gw, const char *ifa=
ce, uint32_t table, int metric)
 {
-    inet_address_t dst_v6 =3D { 0 };
- =
   inet_address_t gw_v6 =3D { 0 };
+    inet_address_t dst_v6;
+    inet_ad=
dress_t gw_v6;
     char dst_str[INET6_ADDRSTRLEN];
     char gw_str[INET6_=
ADDRSTRLEN];
 
+    CLEAR(dst_v6);
+    CLEAR(gw_v6);
+
     if (dst)
     =
{
         dst_v6=2Eipv6 =3D *dst;
@@ -1278,11 +1297,14 @@
 net_route_v4_de=
l(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const =
in_addr_t *gw,
                  const char *iface, uint32_t table, int met=
ric)
 {
-    inet_address_t dst_v4 =3D { 0 };
-    inet_address_t gw_v4 =3D=
 { 0 };
+    inet_address_t dst_v4;
+    inet_address_t gw_v4;
     char ds=
t_str[INET_ADDRSTRLEN];
     char gw_str[INET_ADDRSTRLEN];
 
+    CLEAR(dst=
_v4);
+    CLEAR(gw_v4);
+
     if (dst)
     {
         dst_v4=2Eipv4 =3D =
htonl(*dst);
@@ -1304,11 +1326,14 @@
 net_route_v6_del(const openvpn_net_ct=
x_t *ctx, const struct in6_addr *dst, int prefixlen,
                  cons=
t struct in6_addr *gw, const char *iface, uint32_t table, int metric)
 {
- =
   inet_address_t dst_v6 =3D { 0 };
-    inet_address_t gw_v6 =3D { 0 };
+ =
   inet_address_t dst_v6;
+    inet_address_t gw_v6;
     char dst_str[INET=
6_ADDRSTRLEN];
     char gw_str[INET6_ADDRSTRLEN];
 
+    CLEAR(dst_v6);
+ =
   CLEAR(gw_v6);
+
     if (dst)
     {
         dst_v6=2Eipv6 =3D *dst;

-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2163?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5c52cc5c3aaad2=
1d1c22f36f6451235302ea6c4f
Gerrit-Change-Number: 2163
Gerrit-PatchSet: 2
Ge=
rrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: A=
ntonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=
=2Ecom>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--PRozarqUnxM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, R=C4=83zvan Cojocaru=
=2E </p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #2</strong> to =
this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2163?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review-1 by Antonio Quartulli</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">sit=
nl: clear inet_address_t locals with CLEAR()<br><br>The inet_address_t loca=
ls were initialized with &quot;=3D { 0 }&quot;, which only<br>initializes t=
he first union member, the 4 byte ipv4=2E GCC 15 and later<br>no longer cle=
ar the rest of the union for this, so the IPv6 addresses<br>of these locals=
 keep up to 12 bytes of stack garbage when the caller<br>passes no address=
=2E<br><br>net_route_v6_del() then sends a garbage RTA_GATEWAY for routes w=
ithout<br>a gateway, and the kernel refuses to delete them=2E net_route_v6_=
best_gw()<br>looks up a garbage destination when asked for the default rout=
e=2E<br><br>Clear the whole union with CLEAR() instead=2E The other inet_ad=
dress_t<br>locals are cleared the same way, so none relies on the partial<b=
r>initialization=2E<br><br>Latent since c6542257 (&quot;introduce sitnl: Si=
mplified Interface To<br>NetLink&quot;)=2E<br><br>Change-Id: I5c52cc5c3aaad=
21d1c22f36f6451235302ea6c4f<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@m=
ailbox=2Eorg&gt;<br>---<br>M src/openvpn/networking_sitnl=2Ec<br>1 file cha=
nged, 40 insertions(+), 15 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/2163/2</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitn=
l=2Ec</span><br><span>index 97ff7bd=2E=2Eeafb9f7 100644</span><br><span>---=
 a/src/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/src/openvpn/netwo=
rking_sitnl=2Ec</span><br><span>@@ -612,10 +612,12 @@</span><br><span> net_=
route_v6_best_gw(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, struct=
 in6_addr *best_gw,</span><br><span>                      char *best_iface)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  inet_address_t dst_v6 =3D { 0 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    inet_address_t dst_v6;</span><br><span>     char buf[INE=
T6_ADDRSTRLEN];</span><br><span>     int ret;</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(dst_v6);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (dst)</=
span><br><span>     {</span><br><span>         dst_v6=2Eipv6 =3D *dst;</spa=
n><br><span>@@ -640,10 +642,12 @@</span><br><span> net_route_v4_best_gw(ope=
nvpn_net_ctx_t *ctx, const in_addr_t *dst, in_addr_t *best_gw,</span><br><s=
pan>                      char *best_iface)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    inet_address_t dst_v4 =3D { 0 =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    inet_address_=
t dst_v4;</span><br><span>     char buf[INET_ADDRSTRLEN];</span><br><span> =
    int ret;</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    CLEAR(dst_v4);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>     if (dst)</span><br><span>     {</span><br><=
span>         dst_v4=2Eipv4 =3D htonl(*dst);</span><br><span>@@ -1040,9 +10=
44,11 @@</span><br><span> int</span><br><span> net_addr_v4_add(const openvp=
n_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 inet_address_t addr_v4 =3D { 0 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    inet_address_t addr_v4;</span><br><span>     char buf[IN=
ET_ADDRSTRLEN];</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    CLEAR(addr_v4);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>     if (!addr)</span><br><span>     {</span=
><br><span>         return -EINVAL;</span><br><span>@@ -1060,9 +1066,11 @@<=
/span><br><span> net_addr_v6_add(const openvpn_net_ctx_t *ctx, const char *=
iface, const struct in6_addr *addr,</span><br><span>                 int pr=
efixlen)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    inet_address_t addr_v6 =3D { 0 };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    inet_address_t addr_v6;</span><br><span>     ch=
ar buf[INET6_ADDRSTRLEN];</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    CLEAR(addr_v6);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span>     if (!addr)</span><br><span>  =
   {</span><br><span>         return -EINVAL;</span><br><span>@@ -1079,9 +1=
087,11 @@</span><br><span> int</span><br><span> net_addr_v4_del(const openv=
pn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  inet_address_t addr_v4 =3D { 0 };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    inet_address_t addr_v4;</span><br><span>     char buf[I=
NET_ADDRSTRLEN];</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    CLEAR(addr_v4);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span>     if (!addr)</span><br><span>     {</spa=
n><br><span>         return -EINVAL;</span><br><span>@@ -1099,9 +1109,11 @@=
</span><br><span> net_addr_v6_del(const openvpn_net_ctx_t *ctx, const char =
*iface, const struct in6_addr *addr,</span><br><span>                 int p=
refixlen)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    inet_address_t addr_v6 =3D { 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    inet_address_t addr_v6;</span><br><span>     c=
har buf[INET6_ADDRSTRLEN];</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    CLEAR(addr_v6);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>     if (!addr)</span><br><span> =
    {</span><br><span>         return -EINVAL;</span><br><span>@@ -1119,11 =
+1131,14 @@</span><br><span> net_addr_ptp_v4_add(const openvpn_net_ctx_t *c=
tx, const char *iface, const in_addr_t *local,</span><br><span>            =
         const in_addr_t *remote)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    inet_address_t local_v4 =3D { 0 };</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    inet_address_t remote_=
v4 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in=
et_address_t local_v4;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    inet_address_t remote_v4;</span><br><span>     char buf1[INET_ADDRST=
RLEN];</span><br><span>     char buf2[INET_ADDRSTRLEN];</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(local_v4);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(remote_v4)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
    if (!local)</span><br><span>     {</span><br><span>         return -EIN=
VAL;</span><br><span>@@ -1147,9 +1162,10 @@</span><br><span> net_addr_ptp_v=
4_del(const openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *loc=
al,</span><br><span>                     const in_addr_t *remote)</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    inet_add=
ress_t local_v4 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    inet_address_t local_v4;</span><br><span>     char buf[INET6_ADD=
RSTRLEN];</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    CLEAR(local_v4);</span><br><span> </span><br><span>     if (!lo=
cal)</span><br><span>     {</span><br><span>@@ -1227,11 +1243,14 @@</span><=
br><span> net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_a=
ddr *dst, int prefixlen,</span><br><span>                  const struct in6=
_addr *gw, const char *iface, uint32_t table, int metric)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    inet_address_t d=
st_v6 =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
net_address_t gw_v6 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    inet_address_t dst_v6;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    inet_address_t gw_v6;</span><br><span>     char dst_s=
tr[INET6_ADDRSTRLEN];</span><br><span>     char gw_str[INET6_ADDRSTRLEN];</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 CLEAR(dst_v6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
CLEAR(gw_v6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>     if (dst)</span><br><span>     {</span><br><span>         ds=
t_v6=2Eipv6 =3D *dst;</span><br><span>@@ -1278,11 +1297,14 @@</span><br><sp=
an> net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, in=
t prefixlen, const in_addr_t *gw,</span><br><span>                  const c=
har *iface, uint32_t table, int metric)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    inet_address_t dst_v4 =3D { 0 };</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    inet_address_t gw_v=
4 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ine=
t_address_t dst_v4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    inet_address_t gw_v4;</span><br><span>     char dst_str[INET_ADDRSTRLEN=
];</span><br><span>     char gw_str[INET_ADDRSTRLEN];</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(dst_v4);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(gw_v4);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (=
dst)</span><br><span>     {</span><br><span>         dst_v4=2Eipv4 =3D hton=
l(*dst);</span><br><span>@@ -1304,11 +1326,14 @@</span><br><span> net_route=
_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefi=
xlen,</span><br><span>                  const struct in6_addr *gw, const ch=
ar *iface, uint32_t table, int metric)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    inet_address_t dst_v6 =3D { 0 };</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    inet_address_t gw_v6=
 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    inet=
_address_t dst_v6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   inet_address_t gw_v6;</span><br><span>     char dst_str[INET6_ADDRSTRLEN=
];</span><br><span>     char gw_str[INET6_ADDRSTRLEN];</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(dst_v6);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(gw_v6);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if =
(dst)</span><br><span>     {</span><br><span>         dst_v6=2Eipv6 =3D *ds=
t;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2163?usp=3Demail">change 2163</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http:/=
/schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2163?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-M=
essageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I5c52cc5c3aaad21d1c22f36f6451=
235302ea6c4f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2163=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Qua=
rtulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--PRozarqUnxM=--


--===============6667620953487943730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6667620953487943730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6667620953487943730==--

