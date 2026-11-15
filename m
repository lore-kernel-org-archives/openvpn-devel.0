Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B65606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 11:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KXNxd37s;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Obcr2lw1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ybr64Puh;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bycF4p3/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FXTpaE4Nwu6pY3yP0cr6hQzLj505poq9QvHBysZ3IAM=; b=KXNxd37sA724gemMSOLYd9sYYH
	2QWLycdZ0bolrIt7FcY3392Qb6yLRWdCFG8bHLOQPy4WprOsh7607+OW0W0jbLblDEupDETOtlVUA
	B13tW6dkbwCE7Hegezi4MwQcDSchy7BqifSUpjDv99zTGqeYfMNcSYJz2htIK5SMraXo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSYK4-000000001tB-3sY8;
	Sun, 15 Nov 2026 11:23:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSYK3-000000001t5-1j08
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 11:22:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SHy3YTDx8nfLK3iw38kBdx5epvmhWYA8Hx9/REMQwH4=; b=Obcr2lw1qRI0l67VPlhcs78JHn
 AaSCcrQ5iS50cj56y6XRXlYb3Xkqw+HA0HpoPKnWBnTIbGTsdX6ra+DIr1TrJeYNTYvlVPndbT/Va
 AWQJb7XhcBhGXh0nRhL9Pfs4XFX3u27xY/mzjJLjOIj9JFVGNvG9dUZ4K4NHKrDTnB3o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SHy3YTDx8nfLK3iw38kBdx5epvmhWYA8Hx9/REMQwH4=; b=Ybr64PuhQYZDT+swqD6dfN2hOK
 OVs0CY6T0Mi5uwCKdrM+kMkwcowECsAnjzGKt9TAjDfzCDSMeA7/M7VcLUUKekb2izmFS9Bi1RbMo
 E+BP9T/4ucEAbiJBZGuCDIp6QMv/h64cZe/exX6J6Y9obuXn8F1S2sY8JiiG2EdKVe/4=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSYK1-000000006bN-36oB for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 11:22:59 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4919a880834so1168869f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 03:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794741771; x=1795346571; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SHy3YTDx8nfLK3iw38kBdx5epvmhWYA8Hx9/REMQwH4=;
 b=bycF4p3/OQtkEFZ0rgEopDhYmhPN9YuPx4A/18QQt8uixxfRJn3oP+jxpBTIW2qTHi
 H/UWbohe1NzGONMBFw18KHafUex7QYboDCyvbO4MuDLgv2bHf8xZQZvFQ4tIRkqxmBdr
 yKmUywyrUI1MTpjLoFbJXdijvapDlTwlTNpjs/EYGDvPvZM7GIBHsrhjzYUQL0KT3djE
 wgK8P3UNrBAya9a34lZ19QQBUSJDjssKa5zcUoEfWwwvOJ5R9xKk7Rq6/9QRsGBVE1BX
 LEoddBjBLHxCLR46XSM1gdXl5DmeiABav0WFUxkHzVGfKLpKSUUTMxO8XHUDlGMfaBlR
 gCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794741771; x=1795346571;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SHy3YTDx8nfLK3iw38kBdx5epvmhWYA8Hx9/REMQwH4=;
 b=VXIYhTNrazkEOJPA+gBkJt1f3EQM10m/+Hk7Fv89DzOQSS+pbEawKFt4pS4RD2nv4Q
 sQQZ0jJznNfSUXvNYSgm25dpmY6px5D2QP7rdcZOqI7nRgHernNMnQxnlR5kHD37j0JF
 Ryr6e0qiFxz1D8xW+YVpIPn+Inw22ISvoCbo5bOS64pKC4nJGhr9TGxTG0ORFZeNMCrR
 fD6vbb4h/2n00Ecg0jYBF863q/L3C+7CLvywsgvXGTSS7jXOxmKX4IygXNBHkfi8pWvS
 JpM1V2VTUGrmyWGNawJhL0GaYfHVQ75+QoI44AzJPLyMbp5E8urBLYQX6io5ZelJ1xnx
 HLhw==
X-Gm-Message-State: APuU4Z9d+FIgvN4i619nGeZ3xisviRmFJ4VUf4Jxzg/5NaZNS3nHgQSb
 X0yGCxkCFqQZhu+6aKmxFoRZVmDtF6auA0t/bnNPFDUYemAekRRL+9JjVT+P6w3RkCBG/1xYtOk
 OY9FJjEdLZljZXDCUJyBzCYOnqOuhkBW/5t2CEH6Nd4q/LMeiYJ+5lqFe0JAKyhGeGC6z
X-Gm-Gg: AYBFou1q/rbiBD7Qdji0y4JgRlOg8b0QNERgiE+ybC2SjBajpxZc0CVdDgu0Gv5D+BB
 NeS/u7ldgIlAJhl9r6fF8bgSmXENUig5UWuKAbJmh8daO5fT9jVjEWbi8LM7Th2LLkUbOwDRvEy
 x1eGaVlxdJrIoer8YMPkRPpDfBbRBfxxwLWGjBtYFJFV4gH3I4RnYs/iCcOB8YQHU4nftnq/LMY
 nTttft+0velpfTaozYTyrH1/bmhuqy5IDtz9tiEExon29tz0LhHRYmMwWZmNFe56VFPCH+66JVl
 9hobORLLU6V/jAfFPcf260fFCvE9Jjc6/yde41mCQNIjB9CLp/1d7Z+nIPDzgY6kP9X3s8JDx/F
 pw3MdJJQzThLRuEsn0lwIULNtqSvjhoBp7WXN5nyUpZOGEo1wJ45KprxBlLmJktMByiy3k3N8ml
 9VxketIEUmVHtLJQSFOHWnGWNrawQTb7PCR/u3SFI0NLkqF/zURFFQJtBg5PCHYL72jWmeNwQtn
 bvEBz/J8C6kWmMdxF0SmV10kdrk2im2ykz31bz5PDXe5QcE+Fj1dK6fjf+12woJ/G0iR/opVtTC
 3vpdTRmcOlOS5VzC1BtPzFRWy20Od/z+u0zmyyWPftEqaFSEqD79ShwrWmwcZPWGr4JtYebqHCm
 OsgTmLpl+fTtt19hyBYamfN9Fyb4UwXygJ26KpErVQtIJ074xwxT1fWWMvyKRfMPTztaMxQo+B8
 FcmB8AXFE+Cg65NAfOmfOWGPI++MnWSXSwCrRT
X-Received: by 2002:a05:6000:4916:b0:48e:4300:c6d8 with SMTP id
 ffacd0b85a97d-49c723fc072mr15180948f8f.35.1794741770826; 
 Sun, 15 Nov 2026 03:22:50 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c888b90d4sm15462888f8f.9.2026.11.15.03.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 03:22:50 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 11:22:48 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1a36c382af05c8db6d342b9bdfb2dc0aae2d10df
X-Gerrit-Change-Number: 2129
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2129?usp=email>
X-Gerrit-Commit: 7697c2f1d978c6cf2a933c2cf543366bb719bae3
In-Reply-To: <gerrit.1793785416000.I1a36c382af05c8db6d342b9bdfb2dc0aae2d10df@gerrit.openvpn.net>
References: <gerrit.1793785416000.I1a36c382af05c8db6d342b9bdfb2dc0aae2d10df@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzg1NDE2MDAwLkkxYTM2YzM4MmFmMDVjOGRiNmQzNDJiOWJkZmIyZGMwYWFlMmQxMGRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5147cf6e5dc117a5fd693e4282105c4f52867062-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSYK1-000000006bN-36oB
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2320068675584384623=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2320068675584384623==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mptbmI2RyS8="; charset=UTF-8

--mptbmI2RyS8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2129?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: route: remove never-=
returned LR_ERROR
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

route: remove never-returned LR_ERROR

local_route() has never returne=
d LR_ERROR since it was added in
7fb0e07e ("Added redirect-gateway block-lo=
cal flag, =2E=2E=2E"), so the
checks in add_route() and delete_route() were=
 dead=2E They were also the
only readers of is_local_route on most platform=
s, so let is_on_link()
call local_route() itself and drop the variable and =
the unused done
labels=2E

Change-Id: I1a36c382af05c8db6d342b9bdfb2dc0aae2d=
10df
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2129
Message-Id: <20261114162252=2E5144-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg41316=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/route=2Ec
1 file changed, 7 insertions(+), 2=
1 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/29/2129/2

diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=
=2Ec
index c812dac=2E=2E4cbba06 100644
--- a/src/openvpn/route=2Ec
+++ b/sr=
c/openvpn/route=2Ec
@@ -1408,7 +1408,6 @@
 /* local_route() return values *=
/
 #define LR_NOMATCH 0 /* route is not local */
 #define LR_MATCH   1 /* r=
oute is local */
-#define LR_ERROR   2 /* caller should abort adding route =
*/
 
 static int
 local_route(in_addr_t network, in_addr_t netmask, in_addr=
_t gateway,
@@ -1443,10 +1442,11 @@
  * a route is specified as an interfac=
e rather than an address=2E */
 #if defined(TARGET_LINUX) || defined(_WIN32=
) || defined(TARGET_DARWIN)
 static inline bool
-is_on_link(const int is_lo=
cal_route, const unsigned int flags, const struct route_gateway_info *rgi)
=
+is_on_link(const struct route_ipv4 *r, const unsigned int flags,
+        =
   const struct route_gateway_info *rgi)
 {
     return rgi
-           && =
(is_local_route =3D=3D LR_MATCH
+           && (local_route(r->network, r->=
netmask, r->gateway, rgi) =3D=3D LR_MATCH
                || ((flags & ROUT=
E_REF_GW) && (rgi->flags & RGI_ON_LINK)));
 }
 #endif
@@ -1457,7 +1457,6 @@=

           const struct env_set *es, openvpn_net_ctx_t *ctx)
 {
     int s=
tatus =3D 0;
-    int is_local_route;
 
     if (!(r->flags & RT_DEFINED))
=
     {
@@ -1475,17 +1474,12 @@
     const char *gateway =3D print_in_addr_t=
(r->gateway, 0, &gc);
 #endif
 
-    is_local_route =3D local_route(r->netw=
ork, r->netmask, r->gateway, rgi);
-    if (is_local_route =3D=3D LR_ERROR)=

-    {
-        goto done;
-    }
 
 #if defined(TARGET_LINUX)
     const =
char *iface =3D NULL;
     int metric =3D -1;
 
-    if (is_on_link(is_loca=
l_route, flags, rgi))
+    if (is_on_link(r, flags, rgi))
     {
         i=
face =3D rgi->iface;
     }
@@ -1533,7 +1527,7 @@
         {
             a=
rgv_printf_cat(&argv, "METRIC %d", r->metric);
         }
-        if (is_o=
n_link(is_local_route, flags, rgi))
+        if (is_on_link(r, flags, rgi))=

         {
             ai =3D rgi->adapter_index;
             argv_print=
f_cat(&argv, "IF %lu", ai);
@@ -1659,7 +1653,7 @@
     }
 #endif
 
-    if =
(is_on_link(is_local_route, flags, rgi))
+    if (is_on_link(r, flags, rgi)=
)
     {
         /* Mac OS X route syntax for ON_LINK:
          * route a=
dd -cloning -net 10=2E10=2E0=2E1 -netmask 255=2E255=2E255=2E255 -interface =
en0 */
@@ -1718,7 +1712,6 @@
         "Sorry, but I don't know how to do 'r=
oute' commands on this operating system=2E  Try putting your routes in a --=
route-up script");
 #endif /* if defined(TARGET_LINUX) */
 
-done:
     if =
(status =3D=3D RTA_SUCCESS)
     {
         r->flags |=3D RT_ADDED;
@@ -200=
9,7 +2002,6 @@
 #else /* if !defined(TARGET_LINUX) */
     int metric;
 #en=
dif
-    int is_local_route;
 
     if ((r->flags & (RT_DEFINED | RT_ADDED)=
) !=3D (RT_DEFINED | RT_ADDED))
     {
@@ -2027,11 +2019,6 @@
     gateway =
=3D print_in_addr_t(r->gateway, 0, &gc);
 #endif
 
-    is_local_route =3D =
local_route(r->network, r->netmask, r->gateway, rgi);
-    if (is_local_rou=
te =3D=3D LR_ERROR)
-    {
-        goto done;
-    }
 
 #if defined(TARGET=
_LINUX)
     metric =3D -1;
@@ -2110,7 +2097,7 @@
 
 #elif defined(TARGET_D=
ARWIN)
 
-    if (is_on_link(is_local_route, flags, rgi))
+    if (is_on_li=
nk(r, flags, rgi))
     {
         argv_printf(&argv, "%s delete -cloning -=
net %s -netmask %s -interface %s", ROUTE_PATH,
                     network=
, netmask, rgi->iface);
@@ -2160,7 +2147,6 @@
         "Sorry, but I don't =
know how to do 'route' commands on this operating system=2E  Try putting yo=
ur routes in a --route-up script");
 #endif /* if defined(TARGET_LINUX) */
=
 
-done:
     r->flags &=3D ~RT_ADDED;
     argv_free(&argv);
     gc_free(=
&gc);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2129?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchse=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1a36c382=
af05c8db6d342b9bdfb2dc0aae2d10df
Gerrit-Change-Number: 2129
Gerrit-PatchSet=
: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>

--mptbmI2RyS8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2129?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">route: remove never-returned LR_ERROR<br><br>local_route() has never re=
turned LR_ERROR since it was added in<br>7fb0e07e (&quot;Added redirect-gat=
eway block-local flag, =2E=2E=2E&quot;), so the<br>checks in add_route() an=
d delete_route() were dead=2E They were also the<br>only readers of is_loca=
l_route on most platforms, so let is_on_link()<br>call local_route() itself=
 and drop the variable and the unused done<br>labels=2E<br><br>Change-Id: I=
1a36c382af05c8db6d342b9bdfb2dc0aae2d10df<br>Signed-off-by: Razvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lich=
tenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2129<br>Message-Id: &lt;20261114162252=2E5144-1-gert@greenie=2Emuc=2Ede&gt=
;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforg=
e=2Enet/msg41316=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Em=
uc=2Ede&gt;<br>---<br>M src/openvpn/route=2Ec<br>1 file changed, 7 insertio=
ns(+), 21 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/29/2129/2</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/=
openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index c812dac=2E=
=2E4cbba06 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><sp=
an>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -1408,7 +1408,6 @@</span>=
<br><span> /* local_route() return values */</span><br><span> #define LR_NO=
MATCH 0 /* route is not local */</span><br><span> #define LR_MATCH   1 /* r=
oute is local */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne LR_ERROR   2 /* caller should abort adding route */</span><br><span> </s=
pan><br><span> static int</span><br><span> local_route(in_addr_t network, i=
n_addr_t netmask, in_addr_t gateway,</span><br><span>@@ -1443,10 +1442,11 @=
@</span><br><span>  * a route is specified as an interface rather than an a=
ddress=2E */</span><br><span> #if defined(TARGET_LINUX) || defined(_WIN32) =
|| defined(TARGET_DARWIN)</span><br><span> static inline bool</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-is_on_link(const int is_local_route=
, const unsigned int flags, const struct route_gateway_info *rgi)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+is_on_link(const struct route=
_ipv4 *r, const unsigned int flags,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+           const struct route_gateway_info *rgi)</span><br>=
<span> {</span><br><span>     return rgi</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-           &amp;&amp; (is_local_route =3D=3D LR_MATCH</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; =
(local_route(r-&gt;network, r-&gt;netmask, r-&gt;gateway, rgi) =3D=3D LR_MA=
TCH</span><br><span>                || ((flags &amp; ROUTE_REF_GW) &amp;&am=
p; (rgi-&gt;flags &amp; RGI_ON_LINK)));</span><br><span> }</span><br><span>=
 #endif</span><br><span>@@ -1457,7 +1457,6 @@</span><br><span>           co=
nst struct env_set *es, openvpn_net_ctx_t *ctx)</span><br><span> {</span><b=
r><span>     int status =3D 0;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    int is_local_route;</span><br><span> </span><br><span>     if =
(!(r-&gt;flags &amp; RT_DEFINED))</span><br><span>     {</span><br><span>@@=
 -1475,17 +1474,12 @@</span><br><span>     const char *gateway =3D print_in=
_addr_t(r-&gt;gateway, 0, &amp;gc);</span><br><span> #endif</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    is_local_route =
=3D local_route(r-&gt;network, r-&gt;netmask, r-&gt;gateway, rgi);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (is_local_route =3D=3D =
LR_ERROR)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        goto done;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> </span><=
br><span> #if defined(TARGET_LINUX)</span><br><span>     const char *iface =
=3D NULL;</span><br><span>     int metric =3D -1;</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (is_on_link(is_local_r=
oute, flags, rgi))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (is_on_link(r, flags, rgi))</span><br><span>     {</span><br><span>  =
       iface =3D rgi-&gt;iface;</span><br><span>     }</span><br><span>@@ -=
1533,7 +1527,7 @@</span><br><span>         {</span><br><span>             a=
rgv_printf_cat(&amp;argv, &quot;METRIC %d&quot;, r-&gt;metric);</span><br><=
span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (is_on_link(is_local_route, flags, rgi))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (is_on_link(r, flags, rgi))</span><br>=
<span>         {</span><br><span>             ai =3D rgi-&gt;adapter_index;=
</span><br><span>             argv_printf_cat(&amp;argv, &quot;IF %lu&quot;=
, ai);</span><br><span>@@ -1659,7 +1653,7 @@</span><br><span>     }</span><=
br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (is_on_link(is_local_route, flags, rgi))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (is_on_link(r, flags, rgi))=
</span><br><span>     {</span><br><span>         /* Mac OS X route syntax f=
or ON_LINK:</span><br><span>          * route add -cloning -net 10=2E10=2E0=
=2E1 -netmask 255=2E255=2E255=2E255 -interface en0 */</span><br><span>@@ -1=
718,7 +1712,6 @@</span><br><span>         &quot;Sorry, but I don&#39;t know=
 how to do &#39;route&#39; commands on this operating system=2E  Try puttin=
g your routes in a --route-up script&quot;);</span><br><span> #endif /* if =
defined(TARGET_LINUX) */</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-done:</span><br><span>     if (status =3D=3D RTA_SUCCE=
SS)</span><br><span>     {</span><br><span>         r-&gt;flags |=3D RT_ADD=
ED;</span><br><span>@@ -2009,7 +2002,6 @@</span><br><span> #else /* if !def=
ined(TARGET_LINUX) */</span><br><span>     int metric;</span><br><span> #en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int is_local_r=
oute;</span><br><span> </span><br><span>     if ((r-&gt;flags &amp; (RT_DEF=
INED | RT_ADDED)) !=3D (RT_DEFINED | RT_ADDED))</span><br><span>     {</spa=
n><br><span>@@ -2027,11 +2019,6 @@</span><br><span>     gateway =3D print_i=
n_addr_t(r-&gt;gateway, 0, &amp;gc);</span><br><span> #endif</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    is_local_route=
 =3D local_route(r-&gt;network, r-&gt;netmask, r-&gt;gateway, rgi);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (is_local_route =3D=3D=
 LR_ERROR)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        goto done;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> </span>=
<br><span> #if defined(TARGET_LINUX)</span><br><span>     metric =3D -1;</s=
pan><br><span>@@ -2110,7 +2097,7 @@</span><br><span> </span><br><span> #eli=
f defined(TARGET_DARWIN)</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (is_on_link(is_local_route, flags, rgi))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (is_on_link(r, flag=
s, rgi))</span><br><span>     {</span><br><span>         argv_printf(&amp;a=
rgv, &quot;%s delete -cloning -net %s -netmask %s -interface %s&quot;, ROUT=
E_PATH,</span><br><span>                     network, netmask, rgi-&gt;ifac=
e);</span><br><span>@@ -2160,7 +2147,6 @@</span><br><span>         &quot;So=
rry, but I don&#39;t know how to do &#39;route&#39; commands on this operat=
ing system=2E  Try putting your routes in a --route-up script&quot;);</span=
><br><span> #endif /* if defined(TARGET_LINUX) */</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-done:</span><br><span>     r-=
&gt;flags &amp;=3D ~RT_ADDED;</span><br><span>     argv_free(&amp;argv);</s=
pan><br><span>     gc_free(&amp;gc);</span><br></pre><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2129?usp=3Demail">change =
2129</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2129?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I1a36c382af05c8db6d342b9bdfb2dc0aae2d10df </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2129 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--mptbmI2RyS8=--


--===============2320068675584384623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2320068675584384623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2320068675584384623==--

