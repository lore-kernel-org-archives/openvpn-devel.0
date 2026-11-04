Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6D2606A326
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Br9e/SOq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CjCMtgpl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=J/EjY7Rn;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HLnzqX2d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=22iz0+IVxeE412Wfh9NJ04eUVvX2Ii3Eq6xuSARqnwY=; b=Br9e/SOqzzx01XY8OwwxYw09wm
	vA+Q4syy4F4uqLGRCzH+7SD0lflsX9X4yKi6oOfzQKlfXVW+QIYlGTKhxfHiw6T/7IS3fnSYolK6w
	Gc6614/APHJSqztRGJQY/6fVrhoAudRXMvUq83XQZ+q18oHenk+8ftfC/7hmaVos+Viw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOXX2-000000004Sk-3yYi;
	Wed, 04 Nov 2026 09:43:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOXX1-000000004Sd-1dUl
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 09:43:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8QsuipMOHA58Qo0YIZfQnEbPs9CMPgH44gRxlQCy7Go=; b=CjCMtgplCSiljwgVWnKINbSQvc
 jWZskm4roSGHezEnrSMG/0QOZFz501EGVmV2XjFrOHrVReljJ8fWCyEaJ4L9ZcGAUctRi4rR3IFaw
 6caY5QMSjUIVF9uKjv+OvGxf9OR5ncdeX1Zxgm3dHG65bIDqQSWzXbJ9Ws4Xrm3hYvzA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8QsuipMOHA58Qo0YIZfQnEbPs9CMPgH44gRxlQCy7Go=; b=J/EjY7RnGHxDKE0PcuaSLABTT2
 bYHvpFJHKdqxA2SHGJq7cYopxY6IOe1MeRSijCv85VHBB50FjfFeX+JBAXPcFcmiUDrIHlRyfq+4d
 zwH/d52Dh0xuF8xlZzTX4wRSxpGrJmIGiYhz7uaVHDvptlRr3pcvFBootimZWEFUxfFM=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOXWz-000000004TM-2diN for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 09:43:47 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso208919f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 01:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793785419; x=1794390219; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8QsuipMOHA58Qo0YIZfQnEbPs9CMPgH44gRxlQCy7Go=;
 b=HLnzqX2dGlTLGblHjEVzonFNkklQigb6zPNOw3q78Eemm0oCXEYya3la4sR/eFL7pT
 lXEZsu21BoQG7i9+J2NdNLXyC4dKQmEs6TCzrMbVnSE56FYcvhCGy9rPHoZKIuivv5O8
 ZlqSVsytlK14aXhGC0ZcL2aCMWcrTzsEGe/GYdc3sMNS9VvigewSV61FSfC47O3pT4Uc
 JmaM2wxTnWNoZM9ThpYPDMLRR4hzubAJNKkjFKwvgHbT3cLX/NsPbusUIYWaEkKGn7DG
 iW45qXMw3vDVdA75oqA3QQei9sam0lY+2dngtq/tanXYh1n78SgItFKXXWNhn9zjD1Yb
 j4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793785419; x=1794390219;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8QsuipMOHA58Qo0YIZfQnEbPs9CMPgH44gRxlQCy7Go=;
 b=mD79ihzRLN3r0In4COyZFlwYwaqazgO9jsfdK35DIdnCNUNmsG6KkKIVEYB6CMyt8I
 tmx41Z67mD8FvGLRDGUwizaWjdV1S3eZG8GhoUEApkw7/ypjpqSXSnQabi/fI2uxp6qH
 LvfDXIs6pbWE7K/cOXkNICDwXSvV9T9OTTkQoJbQNEaWXtwC93xisxc/9epibIFKPqbp
 wYpk4aQRSuoYaQfxEqrymzi4XYUmxT28cj9Fb5em9aRC48ITTMlgxeTp00P4WW0RImJj
 blUXEPweGvbxSjeYupDCaCSd+DLqjavgqJSXK/Npi6CO7AdV4S8frGk2cv7fvy+KdAHD
 AmyQ==
X-Gm-Message-State: APuU4Z97R0IXvbzYLLK275d+8LehzVy5XEhv58cDhp9tpqxRzyG445xz
 tJ99zR60KxrYaVxnvq3SaJfarQN2yRTmmgtBNdE99T5mFyLJq6k9nL/Ej4QtAz6UTVdOb415qbD
 j9acqOvZlHLRzeJAry7s+7YqdwBkM0Q3P1jwFf1Y0n3ns2NKMqpNmWcZjP4WA5QkuDWMw
X-Gm-Gg: AYBFou23N8Mv0+bw9zGRejG2G6iK5aE6359ZQqyi72+pTARvbcjlxah1CqSRR81B69F
 3SsVkaN8uKPM04jeoZGAoo8afemmV4DUPg8a3X1vS4dXtG0Y9b5z8BOvfOlW7DlwgLYPcoriqj/
 spDK/3dIlr5sGOKj6J+cVtNXy4YuVRV+xNhENCkOdCdClXbMROaBaQlKtbE9rGdekLppMOVYYsl
 IRRdYKF6uW9XWzhAOufDUDaEjf/Y40VIv9kh5KbxXeF0y6iswGYCEJMLpQQr7ZSoyuS7gjCTVla
 Rmdif2idHpcAfLP9XxgIv2b40IZ/pPJZZVkOQ+QNLxCd2c+BdTZfyIkW8S2tGVh1QlsfvcXDric
 fbQxK/T5VCM2i1gDXer99LIGpRwf769Xrf05zAkkuI0gTauDKBQztI9vlomxTmHAys41zysXqlA
 +s7joGCU/nY9h9cY64pMc/VKVIgkScVXBlMXz5SrpcIUNUvjdEfC+7AKWptr+8xqHs87+QKOP4K
 +iO96d4nDYjpJu5quWcq/7SDJaXabKcrUy1u7cQeIOJvUs28KH/jIbqeAP1UVdEskyUsPZiI4+F
 zvhEC+HuxN6iCz3c/4DascF0KNbWc4mFDaYOtPT5Nu7B+3ztnCNh1UBnxfuIO7v5o3C7BFvvhwi
 E2ZdPO03w1XGuPITWcZt51QT/41/Dlz+Ui62mdoj53xMgZXMvPWCjgG/iNGQUh/XqrEAh7N9Llo
 +/443L7FiudJh6GzI=
X-Received: by 2002:a05:6000:4281:b0:48b:e54:84a1 with SMTP id
 ffacd0b85a97d-48e6e521411mr30346535f8f.55.1793785418720; 
 Wed, 04 Nov 2026 01:43:38 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda1fb0esm2744923f8f.49.2026.11.04.01.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:43:38 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 09:43:38 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1a36c382af05c8db6d342b9bdfb2dc0aae2d10df
X-Gerrit-Change-Number: 2129
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2129?usp=email>
X-Gerrit-Commit: c4d6d41cbc97ac2f137750aa49d1a77548daebca
References: <gerrit.1793785416000.I1a36c382af05c8db6d342b9bdfb2dc0aae2d10df@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzg1NDE2MDAwLkkxYTM2YzM4MmFmMDVjOGRiNmQzNDJiOWJkZmIyZGMwYWFlMmQxMGRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5cf6dfb4db0e0417088ac9ccfe7c6ec17a3112f6-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOXWz-000000004TM-2diN
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7693222476351960227=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7693222476351960227==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CIpvRvC/O+4="; charset=UTF-8

--CIpvRvC/O+4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2129?usp=3Demail

to review the following change=2E
=


Change subject: route: remove never-returned LR_ERROR
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

route: remove never-returned LR=
_ERROR

local_route() has never returned LR_ERROR since it was added in
7fb=
0e07e ("Added redirect-gateway block-local flag, =2E=2E=2E"), so the
checks=
 in add_route() and delete_route() were dead=2E They were also the
only rea=
ders of is_local_route on most platforms, so let is_on_link()
call local_ro=
ute() itself and drop the variable and the unused done
labels=2E

Change-Id=
: I1a36c382af05c8db6d342b9bdfb2dc0aae2d10df
Signed-off-by: Razvan Cojocaru =
<razvanc@mailbox=2Eorg>
---
M src/openvpn/route=2Ec
1 file changed, 7 inser=
tions(+), 21 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/29/2129/1

diff --git a/src/openvpn/route=2Ec b/src/op=
envpn/route=2Ec
index 53550c4=2E=2E0ab9f6d 100644
--- a/src/openvpn/route=
=2Ec
+++ b/src/openvpn/route=2Ec
@@ -1403,7 +1403,6 @@
 /* local_route() re=
turn values */
 #define LR_NOMATCH 0 /* route is not local */
 #define LR_M=
ATCH   1 /* route is local */
-#define LR_ERROR   2 /* caller should abort =
adding route */
 
 static int
 local_route(in_addr_t network, in_addr_t net=
mask, in_addr_t gateway,
@@ -1438,10 +1437,11 @@
  * a route is specified a=
s an interface rather than an address=2E */
 #if defined(TARGET_LINUX) || d=
efined(_WIN32) || defined(TARGET_DARWIN)
 static inline bool
-is_on_link(co=
nst int is_local_route, const unsigned int flags, const struct route_gatewa=
y_info *rgi)
+is_on_link(const struct route_ipv4 *r, const unsigned int fla=
gs,
+           const struct route_gateway_info *rgi)
 {
     return rgi
- =
          && (is_local_route =3D=3D LR_MATCH
+           && (local_route(r-=
>network, r->netmask, r->gateway, rgi) =3D=3D LR_MATCH
                || (=
(flags & ROUTE_REF_GW) && (rgi->flags & RGI_ON_LINK)));
 }
 #endif
@@ -1452=
,7 +1452,6 @@
           const struct env_set *es, openvpn_net_ctx_t *ctx)
=
 {
     int status =3D 0;
-    int is_local_route;
 
     if (!(r->flags & =
RT_DEFINED))
     {
@@ -1470,17 +1469,12 @@
     const char *gateway =3D pr=
int_in_addr_t(r->gateway, 0, &gc);
 #endif
 
-    is_local_route =3D local_=
route(r->network, r->netmask, r->gateway, rgi);
-    if (is_local_route =3D=
=3D LR_ERROR)
-    {
-        goto done;
-    }
 
 #if defined(TARGET_LINUX=
)
     const char *iface =3D NULL;
     int metric =3D -1;
 
-    if (is_on=
_link(is_local_route, flags, rgi))
+    if (is_on_link(r, flags, rgi))
    =
 {
         iface =3D rgi->iface;
     }
@@ -1528,7 +1522,7 @@
         {
 =
            argv_printf_cat(&argv, "METRIC %d", r->metric);
         }
-   =
     if (is_on_link(is_local_route, flags, rgi))
+        if (is_on_link(r,=
 flags, rgi))
         {
             ai =3D rgi->adapter_index;
          =
   argv_printf_cat(&argv, "IF %lu", ai);
@@ -1654,7 +1648,7 @@
     }
 #end=
if
 
-    if (is_on_link(is_local_route, flags, rgi))
+    if (is_on_link(r=
, flags, rgi))
     {
         /* Mac OS X route syntax for ON_LINK:
      =
    * route add -cloning -net 10=2E10=2E0=2E1 -netmask 255=2E255=2E255=2E25=
5 -interface en0 */
@@ -1713,7 +1707,6 @@
         "Sorry, but I don't know=
 how to do 'route' commands on this operating system=2E  Try putting your r=
outes in a --route-up script");
 #endif /* if defined(TARGET_LINUX) */
 
-d=
one:
     if (status =3D=3D RTA_SUCCESS)
     {
         r->flags |=3D RT_A=
DDED;
@@ -2004,7 +1997,6 @@
 #else /* if !defined(TARGET_LINUX) */
     int=
 metric;
 #endif
-    int is_local_route;
 
     if ((r->flags & (RT_DEFINE=
D | RT_ADDED)) !=3D (RT_DEFINED | RT_ADDED))
     {
@@ -2022,11 +2014,6 @@
=
     gateway =3D print_in_addr_t(r->gateway, 0, &gc);
 #endif
 
-    is_loc=
al_route =3D local_route(r->network, r->netmask, r->gateway, rgi);
-    if =
(is_local_route =3D=3D LR_ERROR)
-    {
-        goto done;
-    }
 
 #if d=
efined(TARGET_LINUX)
     metric =3D -1;
@@ -2105,7 +2092,7 @@
 
 #elif def=
ined(TARGET_DARWIN)
 
-    if (is_on_link(is_local_route, flags, rgi))
+   =
 if (is_on_link(r, flags, rgi))
     {
         argv_printf(&argv, "%s dele=
te -cloning -net %s -netmask %s -interface %s", ROUTE_PATH,
               =
      network, netmask, rgi->iface);
@@ -2155,7 +2142,6 @@
         "Sorry,=
 but I don't know how to do 'route' commands on this operating system=2E  T=
ry putting your routes in a --route-up script");
 #endif /* if defined(TARG=
ET_LINUX) */
 
-done:
     r->flags &=3D ~RT_ADDED;
     argv_free(&argv);
=
     gc_free(&gc);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2129?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I1a36c382af05c8db6d342b9bdfb2dc0aae2d10df
Gerrit-Change-Number: 2129
Gerr=
it-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>

--CIpvRvC/O+4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2129?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">route: remove never-returned LR_ERROR<br><br>local_rout=
e() has never returned LR_ERROR since it was added in<br>7fb0e07e (&quot;Ad=
ded redirect-gateway block-local flag, =2E=2E=2E&quot;), so the<br>checks i=
n add_route() and delete_route() were dead=2E They were also the<br>only re=
aders of is_local_route on most platforms, so let is_on_link()<br>call loca=
l_route() itself and drop the variable and the unused done<br>labels=2E<br>=
<br>Change-Id: I1a36c382af05c8db6d342b9bdfb2dc0aae2d10df<br>Signed-off-by: =
Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/route=
=2Ec<br>1 file changed, 7 insertions(+), 21 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/2=
9/2129/1</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec=
</span><br><span>index 53550c4=2E=2E0ab9f6d 100644</span><br><span>--- a/sr=
c/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><=
span>@@ -1403,7 +1403,6 @@</span><br><span> /* local_route() return values =
*/</span><br><span> #define LR_NOMATCH 0 /* route is not local */</span><br=
><span> #define LR_MATCH   1 /* route is local */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define LR_ERROR   2 /* caller should abort add=
ing route */</span><br><span> </span><br><span> static int</span><br><span>=
 local_route(in_addr_t network, in_addr_t netmask, in_addr_t gateway,</span=
><br><span>@@ -1438,10 +1437,11 @@</span><br><span>  * a route is specified=
 as an interface rather than an address=2E */</span><br><span> #if defined(=
TARGET_LINUX) || defined(_WIN32) || defined(TARGET_DARWIN)</span><br><span>=
 static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-is=
_on_link(const int is_local_route, const unsigned int flags, const struct r=
oute_gateway_info *rgi)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+is_on_link(const struct route_ipv4 *r, const unsigned int flags,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+           const struct ro=
ute_gateway_info *rgi)</span><br><span> {</span><br><span>     return rgi</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-           &amp;&amp; (=
is_local_route =3D=3D LR_MATCH</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+           &amp;&amp; (local_route(r-&gt;network, r-&gt;netmask,=
 r-&gt;gateway, rgi) =3D=3D LR_MATCH</span><br><span>                || ((f=
lags &amp; ROUTE_REF_GW) &amp;&amp; (rgi-&gt;flags &amp; RGI_ON_LINK)));</s=
pan><br><span> }</span><br><span> #endif</span><br><span>@@ -1452,7 +1452,6=
 @@</span><br><span>           const struct env_set *es, openvpn_net_ctx_t =
*ctx)</span><br><span> {</span><br><span>     int status =3D 0;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    int is_local_route;</span><br=
><span> </span><br><span>     if (!(r-&gt;flags &amp; RT_DEFINED))</span><b=
r><span>     {</span><br><span>@@ -1470,17 +1469,12 @@</span><br><span>    =
 const char *gateway =3D print_in_addr_t(r-&gt;gateway, 0, &amp;gc);</span>=
<br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    is_local_route =3D local_route(r-&gt;network, r-&gt;netma=
sk, r-&gt;gateway, rgi);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (is_local_route =3D=3D LR_ERROR)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        goto done;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span> </span><br><span> #if defined(TARGET_LINUX)</span>=
<br><span>     const char *iface =3D NULL;</span><br><span>     int metric =
=3D -1;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (is_on_link(is_local_route, flags, rgi))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (is_on_link(r, flags, rgi))</span>=
<br><span>     {</span><br><span>         iface =3D rgi-&gt;iface;</span><b=
r><span>     }</span><br><span>@@ -1528,7 +1522,7 @@</span><br><span>      =
   {</span><br><span>             argv_printf_cat(&amp;argv, &quot;METRIC %=
d&quot;, r-&gt;metric);</span><br><span>         }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (is_on_link(is_local_route, flags, =
rgi))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (is=
_on_link(r, flags, rgi))</span><br><span>         {</span><br><span>       =
      ai =3D rgi-&gt;adapter_index;</span><br><span>             argv_print=
f_cat(&amp;argv, &quot;IF %lu&quot;, ai);</span><br><span>@@ -1654,7 +1648,=
7 @@</span><br><span>     }</span><br><span> #endif</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (is_on_link(is_local=
_route, flags, rgi))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (is_on_link(r, flags, rgi))</span><br><span>     {</span><br><span>=
         /* Mac OS X route syntax for ON_LINK:</span><br><span>          * =
route add -cloning -net 10=2E10=2E0=2E1 -netmask 255=2E255=2E255=2E255 -int=
erface en0 */</span><br><span>@@ -1713,7 +1707,6 @@</span><br><span>       =
  &quot;Sorry, but I don&#39;t know how to do &#39;route&#39; commands on t=
his operating system=2E  Try putting your routes in a --route-up script&quo=
t;);</span><br><span> #endif /* if defined(TARGET_LINUX) */</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-done:</span><br><sp=
an>     if (status =3D=3D RTA_SUCCESS)</span><br><span>     {</span><br><sp=
an>         r-&gt;flags |=3D RT_ADDED;</span><br><span>@@ -2004,7 +1997,6 @=
@</span><br><span> #else /* if !defined(TARGET_LINUX) */</span><br><span>  =
   int metric;</span><br><span> #endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    int is_local_route;</span><br><span> </span><br><span>=
     if ((r-&gt;flags &amp; (RT_DEFINED | RT_ADDED)) !=3D (RT_DEFINED | RT_=
ADDED))</span><br><span>     {</span><br><span>@@ -2022,11 +2014,6 @@</span=
><br><span>     gateway =3D print_in_addr_t(r-&gt;gateway, 0, &amp;gc);</sp=
an><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    is_local_route =3D local_route(r-&gt;network, r-&gt;ne=
tmask, r-&gt;gateway, rgi);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (is_local_route =3D=3D LR_ERROR)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        goto done;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span> </span><br><span> #if defined(TARGET_LINUX)</sp=
an><br><span>     metric =3D -1;</span><br><span>@@ -2105,7 +2092,7 @@</spa=
n><br><span> </span><br><span> #elif defined(TARGET_DARWIN)</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (is_on_link(=
is_local_route, flags, rgi))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (is_on_link(r, flags, rgi))</span><br><span>     {</span><b=
r><span>         argv_printf(&amp;argv, &quot;%s delete -cloning -net %s -n=
etmask %s -interface %s&quot;, ROUTE_PATH,</span><br><span>                =
     network, netmask, rgi-&gt;iface);</span><br><span>@@ -2155,7 +2142,6 @=
@</span><br><span>         &quot;Sorry, but I don&#39;t know how to do &#39=
;route&#39; commands on this operating system=2E  Try putting your routes i=
n a --route-up script&quot;);</span><br><span> #endif /* if defined(TARGET_=
LINUX) */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-done:</span><br><span>     r-&gt;flags &amp;=3D ~RT_ADDED;</span><br>=
<span>     argv_free(&amp;argv);</span><br><span>     gc_free(&amp;gc);</sp=
an><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2129?usp=3Demail">change 2129</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2129?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: I1a36c382af05c8db6d342b9bdfb2dc0aae2d=
10df </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2129 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--CIpvRvC/O+4=--


--===============7693222476351960227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7693222476351960227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7693222476351960227==--

