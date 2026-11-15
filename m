Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997B2606A31E
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 11:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=c0trNVLE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lCCeizhg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=P65BxXn+;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CU58x2xu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3ZJqokVZnxGWcy1mGw8fYuGRvBNxAyRhssWtzAOEUCM=; b=c0trNVLEfAaWWjuK4Qd/tapJwz
	Q48cJee+SJ4BLcwY4LK0R9LuD/8Xy+Ha1cavrYlemCtCHIpcjxTzLFiLp7GUuPS1wVlyW6xj0ncKr
	3J/iM//elCYA5Ma8inHAsxbeOxiEqtCYWvBK/VnfCluBdA1yVZ8/MzNunBLfXOmO6KfA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSYK6-000000000rZ-1Dfd;
	Sun, 15 Nov 2026 11:23:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSYK4-000000000rC-330F
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 11:23:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ykz2zlxgDFAEswqtHnLu3whMVRgLDs7wKvpUUjaVTlI=; b=lCCeizhgOZMp2wXN9FSB+46+ZL
 clTGKOUSxWnQr5A+pOqSUSfo86ELEWQZ4Y6X707XcZFJ9zQ4+RceVUF4NZMts1zwOxvHaYQACJFXa
 lQ7wOgoof5Jb6HAXnNd3hySTomUmv6sJVtlWiau3P7F2HoG/h9GuJY7580fS/3HSuxuw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ykz2zlxgDFAEswqtHnLu3whMVRgLDs7wKvpUUjaVTlI=; b=P65BxXn+lr9jBWpYah5PLume7o
 8WXgidMZ+kdNQWE40aLe1CKPI6z7D9C1xmCK6rVGW5tjNs/f06xSza4rsxxI2Qwh1QJiozEJFM+cY
 RY9zKQD4rbcPeHhip38qrtHMVuitofALcxzCnYtUjsqzCSyjdkX+glbA07yRXYYJID68=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSYK3-000000007NK-1aIk for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 11:23:00 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so1176012f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 03:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794741773; x=1795346573; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ykz2zlxgDFAEswqtHnLu3whMVRgLDs7wKvpUUjaVTlI=;
 b=CU58x2xuhxQLD9QAV/HIGzEvG89gKDZhlLLnuExgR/ayzc1H/ozGrOKBu1YuFAyo/e
 RX9mOYPwW6EdR9mns8vG6wOyBq+4PrgcCuP4hvDiu7O/8TEcA3URHxRV8eihbIltQ/sq
 Sx8e1ftdBFp7uE7nrEshjnbYmn/2nCFg76jV+OCn0c5BWs0CJInQmcP27INcEVMI6nxZ
 uj6D8R5+eCO0bfCdbBG9uFmYJO3t2olk4SkfLG7mRVgOgW+uv/OEn1q/SUqgeziHvdx+
 8c//hTwgB6D9ULPR/7i1OchgmUWg8qb9VSl5T4hRUPeyh1sWldMo98Kzs4/z2RWNQrm+
 RPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794741773; x=1795346573;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ykz2zlxgDFAEswqtHnLu3whMVRgLDs7wKvpUUjaVTlI=;
 b=C9WIU2dyb03Ew8xhlur7bCNpWUmlIAjY84D5ar1bcn8okSWksb7osm0Ov9zh8ChWdi
 C1WIlhYLMYKX4LC9nPhzjiaOFWzpiBO9zX6I2695HQ+PRDvKT8XnQeyO+wZUn0n5BVLt
 tNtS9oiPikouDnWyQnpM07RZWo0caxLTWtAiybmaEo0r/M9Izlm9NazoQlWgkYT85mp3
 2kXwXvmr9i0j8DkNHEVN6PkY5BZZYpDZBoj62D4pQHatasb+xrXlCYe/GmAo8w+isf78
 cKlAbVhbMmim24gK8yuJdv2mm7lxtTmkha4AYmyJjnc0k0yJPtIMGlzbsr4joF0QAp49
 sMwA==
X-Forwarded-Encrypted: i=1;
 AL+hErGDRwhD9TpUBclMQHY5JYh2h4hikO9gYqdjhvc6ZvLQf6jvk0vP4LR/rsaIrlmrxjVUyl7lElLlUlF4IUwN@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9Zxi4CkOJMAUGosMibSTXZLI6O/9E24NtObdd6+KX365lvx5VN
 7yr2xTK2IZpc0q5sbjVVxERCCI6sUKsiIsWgQUpCkDl0SDRODMbHFpsmMtXdhTKYlZQ+8rqtZcw
 kd9rfXweN2J5weXBuHi5BniM9+z0tLGV1IGny6tfGNdhBXrCSSa81uvb60oVNS2eN+Osh
X-Gm-Gg: AYBFou0cbpB+9L3TpGL1d3g7rtgWJPaCmKlGAa7F5Uhpcc6l6NvzErwuyZgrQuJg7L8
 Agour0sa5JoXhXkhp2alpHqB8DaV76jF9ETZBK8csC9qkh3B5uzRfSR55/wWqE+hroTvSLJgDn5
 4H+FRp3muzOJofW3qtUg4L/pbwrfSt/uUBcf1pNgbyVdYb2+NskB1NML58pMBw0fW3MELdQ6DAS
 xGG8jKq/9TtLKAu0+r5WeiifC1hZEZJUPun+z0sV/8fexErwTs2U+ehSAjvQDuYXTy9hBe61j4p
 iG+iPTqA1wwpg6o89KOaEwd6hnxPtvznP0I/7UCfVDwh1pADif2j7rvPmeERYb6CQ4mDbmS41Sk
 SUrMewje01XAjSioqNYtP983zPMH5dXBrxam2p0ypadZYM9l9vfxlEg2RXM+hxJ5v9Pj9WDTSXd
 q7T9jY8YT0fBg3dWRk9XJ3IugMoqsQsn2gyXZUYyzJ8dKchf24cN7tSRAikqqheq/QpQU82uMr+
 hfOv/oemgT/gdfXkfI41RCNZbkDTn3FcJFz55sI3W3LyTxpud5KYv6vcVtCLX19jr0YEFMi6l2w
 Q1xKr5I5Hx6YWjiEQnw6+tkItpouigTGdXdX2YIhwzDBy10BQgPsv0TK5/f/D8wd1fkFIqJu/2L
 8KIP7DlOv/ADNoohMjPJlffTzv12mpOeQh+7tn1hxtKt3EjPcHqfcvgFLh8l6YGgt4b5KtKZesk
 0admBiU/HM4n5xdJs=
X-Received: by 2002:a05:6000:22c2:b0:48d:ecba:3cf8 with SMTP id
 ffacd0b85a97d-49c741b1331mr17983053f8f.43.1794741772615; 
 Sun, 15 Nov 2026 03:22:52 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f1c0e31sm13782865f8f.19.2026.11.15.03.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 03:22:51 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 11:22:50 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1a36c382af05c8db6d342b9bdfb2dc0aae2d10df
X-Gerrit-Change-Number: 2129
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2129?usp=email>
X-Gerrit-Commit: 7697c2f1d978c6cf2a933c2cf543366bb719bae3
In-Reply-To: <gerrit.1793785416000.I1a36c382af05c8db6d342b9bdfb2dc0aae2d10df@gerrit.openvpn.net>
References: <gerrit.1793785416000.I1a36c382af05c8db6d342b9bdfb2dc0aae2d10df@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzg1NDE2MDAwLkkxYTM2YzM4MmFmMDVjOGRiNmQzNDJiOWJkZmIyZGMwYWFlMmQxMGRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5147cf6e5dc117a5fd693e4282105c4f52867062-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSYK3-000000007NK-1aIk
Subject: [Openvpn-devel] [S] Change in openvpn[master]: route: remove
 never-returned LR_ERROR
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3540677756974515129=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3540677756974515129==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GGHSkmDOrD4="; charset=UTF-8

--GGHSkmDOrD4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2129?usp=3Demail )

Change subject: route: remove never-returne=
d LR_ERROR
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

r=
oute: remove never-returned LR_ERROR

local_route() has never returned LR_E=
RROR since it was added in
7fb0e07e ("Added redirect-gateway block-local fl=
ag, =2E=2E=2E"), so the
checks in add_route() and delete_route() were dead=
=2E They were also the
only readers of is_local_route on most platforms, so=
 let is_on_link()
call local_route() itself and drop the variable and the u=
nused done
labels=2E

Change-Id: I1a36c382af05c8db6d342b9bdfb2dc0aae2d10df
=
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2129
Message-Id: <20261114162252=2E5144-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg41316=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/route=2Ec
1 file changed, 7 insertions(+), 21 dele=
tions(-)




diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
ind=
ex c812dac=2E=2E4cbba06 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvp=
n/route=2Ec
@@ -1408,7 +1408,6 @@
 /* local_route() return values */
 #defi=
ne LR_NOMATCH 0 /* route is not local */
 #define LR_MATCH   1 /* route is =
local */
-#define LR_ERROR   2 /* caller should abort adding route */
 
 st=
atic int
 local_route(in_addr_t network, in_addr_t netmask, in_addr_t gatew=
ay,
@@ -1443,10 +1442,11 @@
  * a route is specified as an interface rather=
 than an address=2E */
 #if defined(TARGET_LINUX) || defined(_WIN32) || def=
ined(TARGET_DARWIN)
 static inline bool
-is_on_link(const int is_local_rout=
e, const unsigned int flags, const struct route_gateway_info *rgi)
+is_on_l=
ink(const struct route_ipv4 *r, const unsigned int flags,
+           const=
 struct route_gateway_info *rgi)
 {
     return rgi
-           && (is_loca=
l_route =3D=3D LR_MATCH
+           && (local_route(r->network, r->netmask,=
 r->gateway, rgi) =3D=3D LR_MATCH
                || ((flags & ROUTE_REF_GW=
) && (rgi->flags & RGI_ON_LINK)));
 }
 #endif
@@ -1457,7 +1457,6 @@
       =
    const struct env_set *es, openvpn_net_ctx_t *ctx)
 {
     int status =
=3D 0;
-    int is_local_route;
 
     if (!(r->flags & RT_DEFINED))
     {=

@@ -1475,17 +1474,12 @@
     const char *gateway =3D print_in_addr_t(r->ga=
teway, 0, &gc);
 #endif
 
-    is_local_route =3D local_route(r->network, r=
->netmask, r->gateway, rgi);
-    if (is_local_route =3D=3D LR_ERROR)
-    =
{
-        goto done;
-    }
 
 #if defined(TARGET_LINUX)
     const char *=
iface =3D NULL;
     int metric =3D -1;
 
-    if (is_on_link(is_local_rout=
e, flags, rgi))
+    if (is_on_link(r, flags, rgi))
     {
         iface =
=3D rgi->iface;
     }
@@ -1533,7 +1527,7 @@
         {
             argv_p=
rintf_cat(&argv, "METRIC %d", r->metric);
         }
-        if (is_on_lin=
k(is_local_route, flags, rgi))
+        if (is_on_link(r, flags, rgi))
    =
     {
             ai =3D rgi->adapter_index;
             argv_printf_cat=
(&argv, "IF %lu", ai);
@@ -1659,7 +1653,7 @@
     }
 #endif
 
-    if (is_o=
n_link(is_local_route, flags, rgi))
+    if (is_on_link(r, flags, rgi))
   =
  {
         /* Mac OS X route syntax for ON_LINK:
          * route add -c=
loning -net 10=2E10=2E0=2E1 -netmask 255=2E255=2E255=2E255 -interface en0 *=
/
@@ -1718,7 +1712,6 @@
         "Sorry, but I don't know how to do 'route'=
 commands on this operating system=2E  Try putting your routes in a --route=
-up script");
 #endif /* if defined(TARGET_LINUX) */
 
-done:
     if (stat=
us =3D=3D RTA_SUCCESS)
     {
         r->flags |=3D RT_ADDED;
@@ -2009,7 +=
2002,6 @@
 #else /* if !defined(TARGET_LINUX) */
     int metric;
 #endif
-=
    int is_local_route;
 
     if ((r->flags & (RT_DEFINED | RT_ADDED)) !=
=3D (RT_DEFINED | RT_ADDED))
     {
@@ -2027,11 +2019,6 @@
     gateway =3D=
 print_in_addr_t(r->gateway, 0, &gc);
 #endif
 
-    is_local_route =3D loc=
al_route(r->network, r->netmask, r->gateway, rgi);
-    if (is_local_route =
=3D=3D LR_ERROR)
-    {
-        goto done;
-    }
 
 #if defined(TARGET_LI=
NUX)
     metric =3D -1;
@@ -2110,7 +2097,7 @@
 
 #elif defined(TARGET_DARW=
IN)
 
-    if (is_on_link(is_local_route, flags, rgi))
+    if (is_on_link(=
r, flags, rgi))
     {
         argv_printf(&argv, "%s delete -cloning -net=
 %s -netmask %s -interface %s", ROUTE_PATH,
                     network, n=
etmask, rgi->iface);
@@ -2160,7 +2147,6 @@
         "Sorry, but I don't kno=
w how to do 'route' commands on this operating system=2E  Try putting your =
routes in a --route-up script");
 #endif /* if defined(TARGET_LINUX) */
 
-=
done:
     r->flags &=3D ~RT_ADDED;
     argv_free(&argv);
     gc_free(&gc=
);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2129?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1a36c382af05c8d=
b6d342b9bdfb2dc0aae2d10df
Gerrit-Change-Number: 2129
Gerrit-PatchSet: 2
Ger=
rit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>

--GGHSkmDOrD4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2129?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">route: remove never-returned LR_ER=
ROR<br><br>local_route() has never returned LR_ERROR since it was added in<=
br>7fb0e07e (&quot;Added redirect-gateway block-local flag, =2E=2E=2E&quot;=
), so the<br>checks in add_route() and delete_route() were dead=2E They wer=
e also the<br>only readers of is_local_route on most platforms, so let is_o=
n_link()<br>call local_route() itself and drop the variable and the unused =
done<br>labels=2E<br><br>Change-Id: I1a36c382af05c8db6d342b9bdfb2dc0aae2d10=
df<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked=
-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2129<br>Message-Id: &lt;2026111416225=
2=2E5144-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41316=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
route=2Ec<br>1 file changed, 7 insertions(+), 21 deletions(-)<br><br></pre>=

<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><s=
pan>index c812dac=2E=2E4cbba06 100644</span><br><span>--- a/src/openvpn/rou=
te=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -1408=
,7 +1408,6 @@</span><br><span> /* local_route() return values */</span><br>=
<span> #define LR_NOMATCH 0 /* route is not local */</span><br><span> #defi=
ne LR_MATCH   1 /* route is local */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define LR_ERROR   2 /* caller should abort adding route */<=
/span><br><span> </span><br><span> static int</span><br><span> local_route(=
in_addr_t network, in_addr_t netmask, in_addr_t gateway,</span><br><span>@@=
 -1443,10 +1442,11 @@</span><br><span>  * a route is specified as an interf=
ace rather than an address=2E */</span><br><span> #if defined(TARGET_LINUX)=
 || defined(_WIN32) || defined(TARGET_DARWIN)</span><br><span> static inlin=
e bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-is_on_link(cons=
t int is_local_route, const unsigned int flags, const struct route_gateway_=
info *rgi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+is_on_lin=
k(const struct route_ipv4 *r, const unsigned int flags,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+           const struct route_gateway_i=
nfo *rgi)</span><br><span> {</span><br><span>     return rgi</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-           &amp;&amp; (is_local_rout=
e =3D=3D LR_MATCH</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
         &amp;&amp; (local_route(r-&gt;network, r-&gt;netmask, r-&gt;gatewa=
y, rgi) =3D=3D LR_MATCH</span><br><span>                || ((flags &amp; RO=
UTE_REF_GW) &amp;&amp; (rgi-&gt;flags &amp; RGI_ON_LINK)));</span><br><span=
> }</span><br><span> #endif</span><br><span>@@ -1457,7 +1457,6 @@</span><br=
><span>           const struct env_set *es, openvpn_net_ctx_t *ctx)</span><=
br><span> {</span><br><span>     int status =3D 0;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    int is_local_route;</span><br><span> </spa=
n><br><span>     if (!(r-&gt;flags &amp; RT_DEFINED))</span><br><span>     =
{</span><br><span>@@ -1475,17 +1474,12 @@</span><br><span>     const char *=
gateway =3D print_in_addr_t(r-&gt;gateway, 0, &amp;gc);</span><br><span> #e=
ndif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    is_local_route =3D local_route(r-&gt;network, r-&gt;netmask, r-&gt;gat=
eway, rgi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (is=
_local_route =3D=3D LR_ERROR)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
goto done;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span> </span><br><span> #if defined(TARGET_LINUX)</span><br><span>   =
  const char *iface =3D NULL;</span><br><span>     int metric =3D -1;</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (i=
s_on_link(is_local_route, flags, rgi))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (is_on_link(r, flags, rgi))</span><br><span>     =
{</span><br><span>         iface =3D rgi-&gt;iface;</span><br><span>     }<=
/span><br><span>@@ -1533,7 +1527,7 @@</span><br><span>         {</span><br>=
<span>             argv_printf_cat(&amp;argv, &quot;METRIC %d&quot;, r-&gt;=
metric);</span><br><span>         }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        if (is_on_link(is_local_route, flags, rgi))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (is_on_link(r, fla=
gs, rgi))</span><br><span>         {</span><br><span>             ai =3D rg=
i-&gt;adapter_index;</span><br><span>             argv_printf_cat(&amp;argv=
, &quot;IF %lu&quot;, ai);</span><br><span>@@ -1659,7 +1653,7 @@</span><br>=
<span>     }</span><br><span> #endif</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (is_on_link(is_local_route, flags, =
rgi))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (is_on_=
link(r, flags, rgi))</span><br><span>     {</span><br><span>         /* Mac=
 OS X route syntax for ON_LINK:</span><br><span>          * route add -clon=
ing -net 10=2E10=2E0=2E1 -netmask 255=2E255=2E255=2E255 -interface en0 */</=
span><br><span>@@ -1718,7 +1712,6 @@</span><br><span>         &quot;Sorry, =
but I don&#39;t know how to do &#39;route&#39; commands on this operating s=
ystem=2E  Try putting your routes in a --route-up script&quot;);</span><br>=
<span> #endif /* if defined(TARGET_LINUX) */</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-done:</span><br><span>     if (sta=
tus =3D=3D RTA_SUCCESS)</span><br><span>     {</span><br><span>         r-&=
gt;flags |=3D RT_ADDED;</span><br><span>@@ -2009,7 +2002,6 @@</span><br><sp=
an> #else /* if !defined(TARGET_LINUX) */</span><br><span>     int metric;<=
/span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    int is_local_route;</span><br><span> </span><br><span>     if ((r-&gt=
;flags &amp; (RT_DEFINED | RT_ADDED)) !=3D (RT_DEFINED | RT_ADDED))</span><=
br><span>     {</span><br><span>@@ -2027,11 +2019,6 @@</span><br><span>    =
 gateway =3D print_in_addr_t(r-&gt;gateway, 0, &amp;gc);</span><br><span> #=
endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    is_local_route =3D local_route(r-&gt;network, r-&gt;netmask, r-&gt;ga=
teway, rgi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (i=
s_local_route =3D=3D LR_ERROR)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 goto done;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span> </span><br><span> #if defined(TARGET_LINUX)</span><br><span>  =
   metric =3D -1;</span><br><span>@@ -2110,7 +2097,7 @@</span><br><span> </=
span><br><span> #elif defined(TARGET_DARWIN)</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (is_on_link(is_local_route,=
 flags, rgi))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (is_on_link(r, flags, rgi))</span><br><span>     {</span><br><span>       =
  argv_printf(&amp;argv, &quot;%s delete -cloning -net %s -netmask %s -inte=
rface %s&quot;, ROUTE_PATH,</span><br><span>                     network, n=
etmask, rgi-&gt;iface);</span><br><span>@@ -2160,7 +2147,6 @@</span><br><sp=
an>         &quot;Sorry, but I don&#39;t know how to do &#39;route&#39; com=
mands on this operating system=2E  Try putting your routes in a --route-up =
script&quot;);</span><br><span> #endif /* if defined(TARGET_LINUX) */</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-done:</sp=
an><br><span>     r-&gt;flags &amp;=3D ~RT_ADDED;</span><br><span>     argv=
_free(&amp;argv);</span><br><span>     gc_free(&amp;gc);</span><br></pre><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2129?=
usp=3Demail">change 2129</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2129?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I1a36c382af05c8db6d342b9bdfb2dc0aae2d10df </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2129 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--GGHSkmDOrD4=--


--===============3540677756974515129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3540677756974515129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3540677756974515129==--

