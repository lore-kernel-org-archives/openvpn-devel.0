Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223A8606D829
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QSZKsUK7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YCU511Yc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ht26sBZ0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MX51+DP8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=3DcNZy1jpbibiQpetTAAOyHJtEQEWz0QKhzUAK+Cwc4=; b=QSZKsUK7W+xeYVZ0Dg0KmFuT/P
	hUKJi+YqHRZYos1T93vz6c3253qrqGCtwyTmGsX1EppYbFzRFEVTBoik+O4ojLkDt8CXG0cbsgZXL
	Eq94XbVm150QwbB+q5z0HmXZHUYKCMSoIGp9OOzCdgzbC/WmK/V+UefBQd7vmpMOmkoQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xODsh-000000003mQ-3VE2;
	Tue, 03 Nov 2026 12:44:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xODsT-000000003m4-3F5J
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:44:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZUpUmH5whL6r97DngJ81GaIr6Nr77FKxyjj18Uz0kfo=; b=YCU511YcD/8JthIeLfJytQrBqP
 t/LwByYQFy6Noz0cYGfaGWlXcWdu0C0aRIKIRZxB3m08Ed/msSJQ/deIIK9k8zvhBdctI59FYUA8X
 ozvdLD/jLJubFZZP4O/CEUmGg+HkDSm97NYds+eF9qye5R3s+kbdEsZ9AJUUhy954saI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZUpUmH5whL6r97DngJ81GaIr6Nr77FKxyjj18Uz0kfo=; b=Ht26sBZ0y/sVxwArkhKHyjYIPw
 lZTHQef++gwizfXk6AkT3alkVs448KnPwtjVvcd8gkXry8YXmXLqWWxMet+5Ce/V5V9YA7roRgIUU
 uaZpSWu9AnUBCXZz+mJbXKwg3o52JChCj8oBSjdTHwESK9sF26xO/mmqNtX3QpJ0wo6M=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xODsG-000000003rf-27yJ for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:44:27 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4afe2d546f9so25202935e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 04:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793709858; x=1794314658; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZUpUmH5whL6r97DngJ81GaIr6Nr77FKxyjj18Uz0kfo=;
 b=MX51+DP8qsBJMETXbfFj0HCN4KFxNJ2oppUcBmpPLQYHRXTJ6ODixicTpovz+14FDa
 hc7yDHtweeH900sioL9ePH0kwZ1lRHuxXLkGhAyYP34ybPQX1yGhhVE8gxBmxKflaE3R
 do/6oBy/9R0ZPx/H9PZpfT5lWevo5wekwKkPIFgbM8jYZP6khM+j16O84W2M+RvoaJ7i
 xR3Jaln9FVjZ3CfjQ+mhX/TyfqYDTevQW4gzUHH6/HOTykg8EYhL7ThYCr2fudPNT0mt
 QhsHa6qfA79G5N2fPJWs7bwja9LWOc2+OLzxZaz3AhPqlOycDlglhJx2BDvINsWfTWwY
 xtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793709858; x=1794314658;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZUpUmH5whL6r97DngJ81GaIr6Nr77FKxyjj18Uz0kfo=;
 b=SjMZBFA9A2AtRBLJpWdXuY2C1uxqiJivQShTPFvlogTQnFhqoWbkK1blTyq6AqS97l
 c/uq+e1CQpvQqr2xraEMxuEOkO+yuHwYv3SiGxLZ8bmiu4wSJ4wXg+OyJI23UWO5JpkM
 CN1VuD2BHsgaEs4/qrHbTNMbTnwNoDjli2K8/5cGobAONMSeE4wT72EoSjxLnHuScjfi
 6xLQyNBOA5W7pJpwp6gfi93s5nTPequOZe0ZYFb90Gjb1GU7bFYkt0MnKAME567CCBHK
 iu1sjeeppQLKTCHY547e3XfyXdcp1Gre/TACQAlMDHmagoE1aS+kPzftFhmlOoDVK28h
 5gqA==
X-Gm-Message-State: APuU4Z8+u14gaIS3eJQYsHPMxOV7eiuQJ/FvuBMajL+4iIh9ubODU9EK
 XwFlmfbaI9+Iv3f3Qr7T5XO7RCuS6sDYUA8h21bnbsyv2SSRkNNrs9Iu9wXWRSwpxaUqnq/PXZO
 mXxfJzWudOSmx0KhOrWL98+/wBmtwEQt73cllJWOXMECaziqDbe0A7CrOlhdLNMExzfiK4dn0x1
 U1cbzicw==
X-Gm-Gg: AYBFou2GtVMKT9DC40Rx48BVCdT13z0g2o89jYM7/v+kDcyuiFkqQdXEDAkDHn2u/eJ
 MP75nRGv+eY1gXvNmd/lEBcPtu1mSlxwPj697A6Nl0VeQiSBAHXOc6vcCD9XKG6YZbW4Zf/oumG
 mQQS93pxlCN570PUFNTLyjZybajE3wSyXXFjKdy9GG5YMXE8tZUiHWQZPW/s99pRhlzQDyiTcqo
 03qaSXKHXL6dglmIneoUx5aIWX720KSROE2eeZgR/dKQI3dRlRIAAPohLx/VxMoU47E5wH1l+vx
 VCIOZ1vORdQ11pIhnND5F4lkT3AveOR6inlHW6VjQcWTxgTSzba5HYtiVTH825/J/+/JxlfxV/Y
 8gg/E7tfOKYP2cpuqceCSk4VTOcUqEWK7apqHuQAuc+ueIKOMMV2Ra/4/QNQiGMiOBvpSsOwS4R
 OFlQTQRHCHkX+EgP52rTNBLaroPlD16VJA8niTtDP/5wTbEWN5ZmNjsTxTRfSooS7S99IM4k8wN
 H7TriLFznGx6bILwZvkpXFxrrMNFU3oZkCNiKMakgn+WwmYOJj+aMIl+K5T2EqNRPMNgOdLe0yn
 gYRjiGGXGP9Pn9dDDHQU0tfLQSxS9QMndKKOOrhZk5zb3l8v4H+5mpVyHznMKT1zqA0M35Iw/Cu
 4+5zJE/2lqzCzoSjlE0yTnO1MG6DNaDs5+IfzAnjinwxInXzovnAvA7BErp7b4bRaViqUFAUHWC
 TUm03pmYKR1+zSOA==
X-Received: by 2002:a05:600c:848c:b0:4a6:42cc:bf65 with SMTP id
 5b1f17b1804b1-4ac1709b206mr315247745e9.17.1793709857734; 
 Tue, 03 Nov 2026 04:44:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b9eaeesm24865353f8f.49.2026.11.03.04.44.17
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 04:44:17 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 12:44:16 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e
X-Gerrit-Change-Number: 2108
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2108?usp=email>
X-Gerrit-Commit: 51425676a1171e901b3d515c34dc11fa4eeb3abe
References: <gerrit.1793709839000.I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkk1NzFlMzBiYjIyZWM3YmZmYzJjNWZhMDRmZGNkNzNiNTJjZTQ3ZTVlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <39c15f9230c294938384d7b87bfc1baa58905a21-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xODsG-000000003rf-27yJ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Silence remaining
 cppcheck warnings on macOS and FreeBSD
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1998505051854531521=="
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1998505051854531521==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JJLs8JmaRvI="; charset=UTF-8

--JJLs8JmaRvI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded this change for review=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2108?usp=3Demail )


Change subject: Silence remainin=
g cppcheck warnings on macOS and FreeBSD
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

Silence remaining cppcheck warnings on macOS a=
nd FreeBSD

Change-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e
Signed-off=
-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/route=2Ec
M src/op=
envpn/tun=2Ec
2 files changed, 5 insertions(+), 5 deletions(-)



  git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/08/2108/1

diff -=
-git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index e8de2d5=2E=2E99f=
30d1 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -333=
3,7 +3333,7 @@
     int rtm_addrs;
     struct sockaddr so_dst, so_mask;
  =
   char *cp =3D m_rtmsg=2Em_space;
-    struct sockaddr *gate =3D NULL, *if=
p =3D NULL, *sa;
+    const struct sockaddr *gate =3D NULL, *ifp =3D NULL, =
*sa;
     struct rt_msghdr *rtm_aux;
 
 #define rtm m_rtmsg=2Em_rtm
diff --=
git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index 58f4750=2E=2E769b4c7 =
100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -1042,7 +1042=
,7 @@
  * @param ctx       the networking API opaque context
  */
 static v=
oid
-do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu, c=
onst struct env_set *es,
+do_ifconfig_ipv6(const struct tuntap *tt, const c=
har *ifname, int tun_mtu, const struct env_set *es,
                  openv=
pn_net_ctx_t *ctx)
 {
 #if !defined(TARGET_LINUX)
@@ -1233,7 +1233,7 @@
  *=
 @param ctx       the networking API opaque context
  */
 static void
-do_i=
fconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu, const stru=
ct env_set *es,
+do_ifconfig_ipv4(const struct tuntap *tt, const char *ifna=
me, int tun_mtu, const struct env_set *es,
                  openvpn_net_ct=
x_t *ctx)
 {
 #if !defined(_WIN32) && !defined(TARGET_ANDROID)
@@ -1589,7 +=
1589,7 @@
 }
 
 static void
-undo_ifconfig_ipv4(const struct tuntap *tt, op=
envpn_net_ctx_t *ctx)
+undo_ifconfig_ipv4(const struct tuntap *tt, const op=
envpn_net_ctx_t *ctx)
 {
 #if defined(TARGET_LINUX)
     int netbits =3D ne=
tmask_to_netbits2(tt->remote_netmask);
@@ -1624,7 +1624,7 @@
 }
 
 static v=
oid
-undo_ifconfig_ipv6(const struct tuntap *tt, openvpn_net_ctx_t *ctx)
+u=
ndo_ifconfig_ipv6(const struct tuntap *tt, const openvpn_net_ctx_t *ctx)
 {=

 #if defined(TARGET_LINUX)
     if (net_addr_v6_del(ctx, tt->actual_name, =
&tt->local_ipv6, tt->netbits_ipv6) < 0)

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2108?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e
Gerrit-Ch=
ange-Number: 2108
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>

--JJLs8JmaRvI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
uploaded this change for <strong>review</strong>=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Silence remaining cppcheck warnings on macOS and FreeBSD<br><b=
r>Change-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e<br>Signed-off-by: Ar=
ne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/route=2Ec<br>=
M src/openvpn/tun=2Ec<br>2 files changed, 5 insertions(+), 5 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/08/2108/1</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/route=2Ec b/src/=
openvpn/route=2Ec</span><br><span>index e8de2d5=2E=2E99f30d1 100644</span><=
br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/rout=
e=2Ec</span><br><span>@@ -3333,7 +3333,7 @@</span><br><span>     int rtm_ad=
drs;</span><br><span>     struct sockaddr so_dst, so_mask;</span><br><span>=
     char *cp =3D m_rtmsg=2Em_space;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct sockaddr *gate =3D NULL, *ifp =3D NULL, *sa;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct sockadd=
r *gate =3D NULL, *ifp =3D NULL, *sa;</span><br><span>     struct rt_msghdr=
 *rtm_aux;</span><br><span> </span><br><span> #define rtm m_rtmsg=2Em_rtm</=
span><br><span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span=
><br><span>index 58f4750=2E=2E769b4c7 100644</span><br><span>--- a/src/open=
vpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -1=
042,7 +1042,7 @@</span><br><span>  * @param ctx       the networking API op=
aque context</span><br><span>  */</span><br><span> static void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-do_ifconfig_ipv6(struct tuntap *tt=
, const char *ifname, int tun_mtu, const struct env_set *es,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+do_ifconfig_ipv6(const struct tunt=
ap *tt, const char *ifname, int tun_mtu, const struct env_set *es,</span><b=
r><span>                  openvpn_net_ctx_t *ctx)</span><br><span> {</span>=
<br><span> #if !defined(TARGET_LINUX)</span><br><span>@@ -1233,7 +1233,7 @@=
</span><br><span>  * @param ctx       the networking API opaque context</sp=
an><br><span>  */</span><br><span> static void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-do_ifconfig_ipv4(struct tuntap *tt, const char *if=
name, int tun_mtu, const struct env_set *es,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+do_ifconfig_ipv4(const struct tuntap *tt, const ch=
ar *ifname, int tun_mtu, const struct env_set *es,</span><br><span>        =
          openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span> #if !=
defined(_WIN32) &amp;&amp; !defined(TARGET_ANDROID)</span><br><span>@@ -158=
9,7 +1589,7 @@</span><br><span> }</span><br><span> </span><br><span> static=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-undo_ifconfig_ip=
v4(const struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+undo_ifconfig_ipv4(const struct tuntap *t=
t, const openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span> #if de=
fined(TARGET_LINUX)</span><br><span>     int netbits =3D netmask_to_netbits=
2(tt-&gt;remote_netmask);</span><br><span>@@ -1624,7 +1624,7 @@</span><br><=
span> }</span><br><span> </span><br><span> static void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-undo_ifconfig_ipv6(const struct tuntap *tt=
, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+undo_ifconfig_ipv6(const struct tuntap *tt, const openvpn_net_ctx_t *=
ctx)</span><br><span> {</span><br><span> #if defined(TARGET_LINUX)</span><b=
r><span>     if (net_addr_v6_del(ctx, tt-&gt;actual_name, &amp;tt-&gt;local=
_ipv6, tt-&gt;netbits_ipv6) &lt; 0)</span><br></pre><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108?usp=3Demail">change 2=
108</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2108 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>

</body></html>
--JJLs8JmaRvI=--


--===============1998505051854531521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1998505051854531521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1998505051854531521==--

