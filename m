Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438E606A88A
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IjL3Jstc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=H5sKXGot;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bwZtkcYr;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=X6BO9r+t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+zWamIIbIOWoQ6nHcxeKcuNnwkOzysWGVI733XzfyRU=; b=IjL3Jstc8LRxQeF2XeydRibRZ3
	wZ4awR18e3WBnY/P5K6mtN6bHJZAIrkeOAw98KUHPgoUuezgylhNFbpaq/4CHzV13YWrMXxem6MWJ
	wxTYUiI9wb43GjeW21rLCnfTrH2ATnrjRVwVshAC4rE7t20FHL6hnriSUnC7IDpYYERc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRpXy-000000001U2-3YGY;
	Fri, 13 Nov 2026 11:34:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRpXw-000000001Tp-3MXD
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 11:34:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TVA7p+zNSARg1AeO3RdWPbUGN2LJb1enyYGiJOZ/ois=; b=H5sKXGotzmzlDY9/Sywt+EhECD
 8K9QHhEW4Cg8L/5ENAsGh12terQr6sgtQ082vU5Lv6UOBZ1JZNW//irmsEoRW0C9X9YJLFNqJOT1E
 /t/RHqVq6affZkZFh/A2IzFyhuaglSZUiCrFwlZErvo9+50BB7szeAx2s/RTkhzzdCxQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TVA7p+zNSARg1AeO3RdWPbUGN2LJb1enyYGiJOZ/ois=; b=bwZtkcYrRSIJVtUjwpcNXQF6zq
 Ps+W6+JUKqo4uGEs39ZBkd2c+SuC8F0nUYG4VV5rlPdUBXHh5PRodwsJZL67kNNabA25GHvzebXJP
 ePK72PlV6GcljWF5kGvj0rF0wvlwri4q/dJSBBBURE9b3gQnA7tgDnsjeuDITba0PHD8=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRpXt-000000007og-45ri for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 11:34:20 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so351585f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 03:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794569651; x=1795174451; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TVA7p+zNSARg1AeO3RdWPbUGN2LJb1enyYGiJOZ/ois=;
 b=X6BO9r+tskurU1ngms4a+RnoeP8YrUDOjcizGfONkjTA9QfTtUG5eimIA60umTCVl/
 04+uBC+TLwOi3rEqsz4B/phfZfZJXm4UE6IPLMwocIKpV93N5FMFyUVaCW0IL+u93X8L
 bdb7iYNldj3ReKDkGS4G0Bu+QNt35sbyiYVSpNLvJVCcbpaMCPPiUXddMpGOHsMPQ1RR
 kDnek/TD2kM3Y9ngIGnt+zfZtpBKrA/l7xQlXXFGHULac/4OAuCMTb2XHbtl92PhR21N
 B5TNp0UpsD+tMXKaYpQPK8GSeOEJ84rmrUlKGUA/nowFBeGPUevJlN3wgQEi5jKUF1XK
 Mj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794569651; x=1795174451;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TVA7p+zNSARg1AeO3RdWPbUGN2LJb1enyYGiJOZ/ois=;
 b=xa2329UXZkb2go2ioNY6dZlTMMwwlPY5I5f2D2UnDY6zJOoAsfxO288uwIO8azx4Kz
 Ts5An9p3xMHVnylvNZWPQoxYVctzwXw8nh/NTRx5aFF9BhTh8YjrPQeUFfcf9uI3j8uU
 6UokdsaD7bCHHQZm5mZg8GqRrI095mZfSwAXEaXFv4tovalAtJ5y6j6NDv63DNqnPvSe
 W4v2qI4DLlK1MU/8xaLjnr8ZFvrUtKVm6tH9MosX6Dl9lGknH2Yrh1zOlY5dQRqNukxd
 y97jz9P9MSxz/nIKsZAZ6Mgm+yIqGPiljY1/1yuk0aE/onSj7mlWgr8jon+tlUzsrMtD
 sCAA==
X-Forwarded-Encrypted: i=1;
 AL+hErEJvFmb8r/EAfiS+PY8DyjOw2C51SNQO2JC9GstazShXpAN5ERNVFwLANtbkIS+HNOB/gceYnBrkSTzfWI+@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8vW0J3sObxvSZL3tLBgLcUc17NtBoWMC0TULznf9B65Yqe9tUV
 kvPdfbFtSOjnG2SbEl6qn/P6hrDOH0WKlwtmI1CJdGFWEtTWZmAQGGrydbcldO5b8QlZtUVbJuv
 5hPmjng1G4ghe4qbfA9zK1fod+OLGqd2jXiaUQlORYFal/CMRGscKJi2DhjuVrlHzOuMi
X-Gm-Gg: AYBFou3nYZM8YGL/9gg56WMQHfcHAoYm5wvaRXJxXowW0tbu3e3ESClI5/VgEIThRVq
 GDNClzGKat/geiiVS0n3lb+tqJ1SGrpLy7ZLvvPkmy3CHkSe0Ww71gZcsHXJms2ig1ivJMxBU+j
 He3wJtY5bS5rXI734Jq89D+O+W1IvVji3mKjCoxNmopDEMIRamRUqk72pKJFMcntLOHpB4XVnCs
 +T+iznnSvy2WjcgvUAcoP1V4RjQ/92cWETJidtEZXxmmeeFFzjkOxMUx4SPJ3z0zlMsvIdvWidi
 yYgXoeUvSb7jTdadqTZgr09iElnzXjFY6ocpsS6L8Qf3K0D/F/AozdJsv5hRc5yHOx7jw1MNuOS
 LmpRvCoE3fDiNEyFIbiYNBSeL9eo4+LJY/9CAkhM9+J/ppv8PS35CmS+rgDYxN74/YQ+BAojkud
 syCBQcJj+VlZFhhxx5tP9hHuOSzJvukpW44NdAOZN9QzpY1C0kxYvuOJJePfG6BFHrXxJcYTko1
 1m8hBkeHsHheHh23gw+Xhb4Ygaw8uwh7Sxy4X+UfZVggyVva/CbTvdfXXxfdtC3XojrhIt3+3pw
 BKmyMwtWHds+qpRfH0Fvg3rOjtOhQ/c/cVHQypKr4r7/o7ydufUAvvgWfr8Z+rZ9cayWGB3KnU0
 o3+vcrnb00P8rZG6WFZMpEI9y1CPwqgGykxDAU2dmlDnwlZztA4IhAlVDJzHgfdrDBAmsEYaTds
 7j9jSCnl+RJvjAg0c=
X-Received: by 2002:a05:6000:641:b0:48e:932:aefa with SMTP id
 ffacd0b85a97d-49c714a30b4mr4147374f8f.26.1794569651222; 
 Fri, 13 Nov 2026 03:34:11 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6020bb0fsm4404614f8f.34.2026.11.13.03.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 03:34:10 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 11:34:10 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e
X-Gerrit-Change-Number: 2108
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2108?usp=email>
X-Gerrit-Commit: f6f035bca56e3b7da845f6e08c7b8bff6bfa97e8
In-Reply-To: <gerrit.1793709839000.I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e@gerrit.openvpn.net>
References: <gerrit.1793709839000.I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkk1NzFlMzBiYjIyZWM3YmZmYzJjNWZhMDRmZGNkNzNiNTJjZTQ3ZTVlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6903e7836c8b5706420cdbcf0c1d8cbfd3c79f76-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRpXt-000000007og-45ri
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6605269693915996127=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6605269693915996127==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0Ix758WOKvQ="; charset=UTF-8

--0Ix758WOKvQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2108?usp=3Demail )

Change subject: Silence remaining cppcheck =
warnings on macOS and FreeBSD
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Silence remaining cppcheck warnings on macOS and FreeBSD

=
Change-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e
Signed-off-by: Arne Sc=
hwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108
Message=
-Id: <20261111152112=2E31478-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41164=2Ehtml
=
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/rou=
te=2Ec
M src/openvpn/tun=2Ec
2 files changed, 12 insertions(+), 12 deletion=
s(-)




diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index d=
0d26c6=2E=2E449b4f1 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/ro=
ute=2Ec
@@ -3331,7 +3331,6 @@
     int rtm_addrs;
     struct sockaddr so_d=
st, so_mask;
     char *cp =3D m_rtmsg=2Em_space;
-    struct sockaddr *gat=
e =3D NULL, *ifp =3D NULL, *sa;
     struct rt_msghdr *rtm_aux;
 
 #define =
rtm m_rtmsg=2Em_rtm
@@ -3396,6 +3395,8 @@
     sockfd =3D -1;
 
     /* ext=
ract return data from routing socket */
+    const struct sockaddr_in *gate=
 =3D NULL;
+    const struct sockaddr_dl *adl =3D NULL;
     rtm_aux =3D &r=
tm;
     cp =3D (char *)(rtm_aux + 1);
     if (rtm_aux->rtm_addrs)
@@ -340=
4,14 +3405,14 @@
         {
             if (i & rtm_aux->rtm_addrs)
      =
       {
-                sa =3D (struct sockaddr *)cp;
+                co=
nst struct sockaddr *sa =3D (const struct sockaddr *)cp;
                 i=
f (i =3D=3D RTA_GATEWAY)
                 {
-                    gate =3D s=
a;
+                    gate =3D (const struct sockaddr_in *)sa;
          =
       }
                 else if (i =3D=3D RTA_IFP)
                 {
-  =
                  ifp =3D sa;
+                    adl =3D (const struct so=
ckaddr_dl *)sa;
                 }
                 ADVANCE(cp, sa);
      =
       }
@@ -3423,19 +3424,18 @@
     }
 
     /* get gateway addr and inte=
rface name */
-    if (gate !=3D NULL)
+    if (gate)
     {
         /* ge=
t default gateway addr */
-        rgi->gateway=2Eaddr =3D ntohl(((struct s=
ockaddr_in *)gate)->sin_addr=2Es_addr);
+        rgi->gateway=2Eaddr =3D nt=
ohl((gate)->sin_addr=2Es_addr);
         if (rgi->gateway=2Eaddr)
         =
{
             rgi->flags |=3D RGI_ADDR_DEFINED;
         }
 
-        if (=
ifp)
+        if (adl)
         {
             /* get interface name */
-  =
          const struct sockaddr_dl *adl =3D (struct sockaddr_dl *)ifp;
    =
         if (adl->sdl_nlen && adl->sdl_nlen < sizeof(rgi->iface))
         =
    {
                 memcpy(rgi->iface, adl->sdl_data, adl->sdl_nlen);
di=
ff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index bcea331=2E=2Ea1f=
9886 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -1040,7 =
+1040,7 @@
  * @param ctx       the networking API opaque context
  */
 sta=
tic void
-do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_m=
tu, const struct env_set *es,
+do_ifconfig_ipv6(const struct tuntap *tt, co=
nst char *ifname, int tun_mtu, const struct env_set *es,
                  =
openvpn_net_ctx_t *ctx)
 {
 #if !defined(TARGET_LINUX)
@@ -1231,7 +1231,7 @=
@
  * @param ctx       the networking API opaque context
  */
 static void
=
-do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu, const=
 struct env_set *es,
+do_ifconfig_ipv4(const struct tuntap *tt, const char =
*ifname, int tun_mtu, const struct env_set *es,
                  openvpn_n=
et_ctx_t *ctx)
 {
 #if !defined(_WIN32) && !defined(TARGET_ANDROID)
@@ -158=
7,7 +1587,7 @@
 }
 
 static void
-undo_ifconfig_ipv4(const struct tuntap *t=
t, openvpn_net_ctx_t *ctx)
+undo_ifconfig_ipv4(const struct tuntap *tt, con=
st openvpn_net_ctx_t *ctx)
 {
 #if defined(TARGET_LINUX)
     int netbits =
=3D netmask_to_netbits2(tt->remote_netmask);
@@ -1622,7 +1622,7 @@
 }
 
 st=
atic void
-undo_ifconfig_ipv6(const struct tuntap *tt, openvpn_net_ctx_t *c=
tx)
+undo_ifconfig_ipv6(const struct tuntap *tt, const openvpn_net_ctx_t *c=
tx)
 {
 #if defined(TARGET_LINUX)
     if (net_addr_v6_del(ctx, tt->actual_=
name, &tt->local_ipv6, tt->netbits_ipv6) < 0)

-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2108?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e
Gerrit-=
Change-Number: 2108
Gerrit-PatchSet: 3
Gerrit-Owner: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--0Ix758WOKvQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2108?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Silence remaining cppcheck warning=
s on macOS and FreeBSD<br><br>Change-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52=
ce47e5e<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-=
by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108<br>Message-Id: &lt;20261111152112=
=2E31478-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41164=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
route=2Ec<br>M src/openvpn/tun=2Ec<br>2 files changed, 12 insertions(+), 12=
 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/route=2Ec b/src/ope=
nvpn/route=2Ec</span><br><span>index d0d26c6=2E=2E449b4f1 100644</span><br>=
<span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=
=2Ec</span><br><span>@@ -3331,7 +3331,6 @@</span><br><span>     int rtm_add=
rs;</span><br><span>     struct sockaddr so_dst, so_mask;</span><br><span> =
    char *cp =3D m_rtmsg=2Em_space;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct sockaddr *gate =3D NULL, *ifp =3D NULL, *sa;</span=
><br><span>     struct rt_msghdr *rtm_aux;</span><br><span> </span><br><spa=
n> #define rtm m_rtmsg=2Em_rtm</span><br><span>@@ -3396,6 +3395,8 @@</span>=
<br><span>     sockfd =3D -1;</span><br><span> </span><br><span>     /* ext=
ract return data from routing socket */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const struct sockaddr_in *gate =3D NULL;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const struct sockaddr_dl *=
adl =3D NULL;</span><br><span>     rtm_aux =3D &amp;rtm;</span><br><span>  =
   cp =3D (char *)(rtm_aux + 1);</span><br><span>     if (rtm_aux-&gt;rtm_a=
ddrs)</span><br><span>@@ -3404,14 +3405,14 @@</span><br><span>         {</s=
pan><br><span>             if (i &amp; rtm_aux-&gt;rtm_addrs)</span><br><sp=
an>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            sa =3D (struct sockaddr *)cp;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                const struct sockaddr *sa =3D (const =
struct sockaddr *)cp;</span><br><span>                 if (i =3D=3D RTA_GAT=
EWAY)</span><br><span>                 {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    gate =3D sa;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    gate =3D (const struc=
t sockaddr_in *)sa;</span><br><span>                 }</span><br><span>    =
             else if (i =3D=3D RTA_IFP)</span><br><span>                 {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    if=
p =3D sa;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          adl =3D (const struct sockaddr_dl *)sa;</span><br><span>         =
        }</span><br><span>                 ADVANCE(cp, sa);</span><br><span=
>             }</span><br><span>@@ -3423,19 +3424,18 @@</span><br><span>   =
  }</span><br><span> </span><br><span>     /* get gateway addr and interfac=
e name */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (gate=
 !=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
gate)</span><br><span>     {</span><br><span>         /* get default gatewa=
y addr */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        rgi-=
&gt;gateway=2Eaddr =3D ntohl(((struct sockaddr_in *)gate)-&gt;sin_addr=2Es_=
addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        rgi-&=
gt;gateway=2Eaddr =3D ntohl((gate)-&gt;sin_addr=2Es_addr);</span><br><span>=
         if (rgi-&gt;gateway=2Eaddr)</span><br><span>         {</span><br><=
span>             rgi-&gt;flags |=3D RGI_ADDR_DEFINED;</span><br><span>    =
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (ifp)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (adl)</span><br><span>         {</span><br><span>             /*=
 get interface name */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            const struct sockaddr_dl *adl =3D (struct sockaddr_dl *)ifp;</=
span><br><span>             if (adl-&gt;sdl_nlen &amp;&amp; adl-&gt;sdl_nle=
n &lt; sizeof(rgi-&gt;iface))</span><br><span>             {</span><br><spa=
n>                 memcpy(rgi-&gt;iface, adl-&gt;sdl_data, adl-&gt;sdl_nlen=
);</span><br><span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</=
span><br><span>index bcea331=2E=2Ea1f9886 100644</span><br><span>--- a/src/=
openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>@=
@ -1040,7 +1040,7 @@</span><br><span>  * @param ctx       the networking AP=
I opaque context</span><br><span>  */</span><br><span> static void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-do_ifconfig_ipv6(struct tuntap=
 *tt, const char *ifname, int tun_mtu, const struct env_set *es,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+do_ifconfig_ipv6(const struct =
tuntap *tt, const char *ifname, int tun_mtu, const struct env_set *es,</spa=
n><br><span>                  openvpn_net_ctx_t *ctx)</span><br><span> {</s=
pan><br><span> #if !defined(TARGET_LINUX)</span><br><span>@@ -1231,7 +1231,=
7 @@</span><br><span>  * @param ctx       the networking API opaque context=
</span><br><span>  */</span><br><span> static void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-do_ifconfig_ipv4(struct tuntap *tt, const char=
 *ifname, int tun_mtu, const struct env_set *es,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+do_ifconfig_ipv4(const struct tuntap *tt, cons=
t char *ifname, int tun_mtu, const struct env_set *es,</span><br><span>    =
              openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span> #=
if !defined(_WIN32) &amp;&amp; !defined(TARGET_ANDROID)</span><br><span>@@ =
-1587,7 +1587,7 @@</span><br><span> }</span><br><span> </span><br><span> st=
atic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-undo_ifconfi=
g_ipv4(const struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+undo_ifconfig_ipv4(const struct tuntap =
*tt, const openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span> #if =
defined(TARGET_LINUX)</span><br><span>     int netbits =3D netmask_to_netbi=
ts2(tt-&gt;remote_netmask);</span><br><span>@@ -1622,7 +1622,7 @@</span><br=
><span> }</span><br><span> </span><br><span> static void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-undo_ifconfig_ipv6(const struct tuntap *=
tt, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+undo_ifconfig_ipv6(const struct tuntap *tt, const openvpn_net_ctx_t=
 *ctx)</span><br><span> {</span><br><span> #if defined(TARGET_LINUX)</span>=
<br><span>     if (net_addr_v6_del(ctx, tt-&gt;actual_name, &amp;tt-&gt;loc=
al_ipv6, tt-&gt;netbits_ipv6) &lt; 0)</span><br></pre><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108?usp=3Demail">change=
 2108</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2108 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>

</body></html>
--0Ix758WOKvQ=--


--===============6605269693915996127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6605269693915996127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6605269693915996127==--

