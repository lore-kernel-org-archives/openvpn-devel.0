Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13903606A324
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=D3ViPz2I;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JaSgG3xj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PvH8SWrR;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eDOU8IYp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=e4U8Jogm3eUu58tKel7cTRPauPBAmxX3lPqgelkH//Q=; b=D3ViPz2IaOE1Eobs9EExL2DjJj
	nH27Ip7poO2Wn+BUArJnAt3f2Ad+wqYM6gSRq1pIAZy+YlCrkL7oSWik+PQVvYNSueo86hw0ZwaHQ
	P+KCGrRyJuEVEWJvaPUhBPAmdb7lTFWGwjAF0wJMSOEE7DgVixnceEVNpsWwdue0ADU0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRBvE-000000005gD-3E95;
	Wed, 11 Nov 2026 17:15:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRBvC-000000005fo-0lCR
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 17:15:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NmuSNhsVmnKkLGaKcR4ac63cRHW/S0MK3N0NjblWKVA=; b=JaSgG3xjl2bCryZLxyOaTFtOcZ
 sS/QYkP1g1+y/bje+HjDkAsP4Tu+E2//+SZxDp59B/F3VTCRw6+7ZHZ+We4heflw0aqeHdN6kgEwG
 JzXKX0D9jI2xp2mZDoAjkkzXYW1/SSfP6gYxCikyML7fDAsJQ+qRZcRJs0vzAHhtYODA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NmuSNhsVmnKkLGaKcR4ac63cRHW/S0MK3N0NjblWKVA=; b=PvH8SWrRMNfjtcYdqOMH3WSOTy
 niTc2cofitPTbWQLpNT6rJTjrN+VHfsAtoOOrzRDX9qpbe63vhXa+dr1tVGgzaWiXIAS8Ni3W4O9f
 nujhwB1n3FH32ytNZg5UI/Q38GCnjtQcapCuAFAfDYw5nHdbnWDNxq802ZaWW3zalu/g=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRBv9-000000003N9-0v4b for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 17:15:42 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so25305015e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 09:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794417333; x=1795022133; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NmuSNhsVmnKkLGaKcR4ac63cRHW/S0MK3N0NjblWKVA=;
 b=eDOU8IYppQGZYfn8d+v8pcwaTF+xSSpUfU+kjikN0jJaC/vhkukLXKtXLesBhS1fIE
 ZLqyLpp5jSwEsGIdGbieH8pUM43J3Ncmcjr+pnsePwxKk6FiuLSVn9KF+1z/FQxN7Np2
 +c3eXJoI5PATm9YdsF6d633zjOWrsg4FJ8dzZD/onEiJfqnhd+gRkbwf/Xn8wvxE8wPm
 5+EXMngU6OOJfH8Xen/8uqSyWFqFYOJNbhefJRZMvz6dDlAbgGpmVtJQS5maBCt0PJw/
 osw1AiVqm86k1M+FmlwUxYtl80hhT0jOBVMjMrn9Y8ShBXu/HYqf4qDxMHK6jrU4r5jM
 dmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794417333; x=1795022133;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NmuSNhsVmnKkLGaKcR4ac63cRHW/S0MK3N0NjblWKVA=;
 b=ohe9b0IXl2umSZu53BwUgBQ9t3E6TSGvwLVx5OMiiqyZldDeFm3JNgzGYj79V+ksTY
 pZGCzg3L7HFRPEmKrJ/+6kEwo2XnCix1lVZJ62A0xQzJOOQOiVmsDi+8OFGbNxbrx7jz
 +c4OnYW5pGOMJm3HQHcsVAmzVMXuNvRTLsvilC/mDMoQefLTQNzRkauNPFsbXooVPv9q
 Gpuem6AUZDqLAwaKAHOxnXL+URcxUQNwjx0qKbl1rEez92po6JoMqzLvIeqH+p7a/wkH
 BnLsnjg2yBsnTrO1SLlqbnI7mUtN+fdx0MSbmUju3U6BTLaGs9OIA9zUEWGiNB3WYZAk
 yRtw==
X-Gm-Message-State: APuU4Z9ra4DIcSzVydGxxBmDtMzq1jyppcsmyteMxhSVV3ijGxV6j3Yq
 6NHFEA6RUuysB5cvzPhDQrMPlASPAoM+LaOsM0WmuN5WF8p7GfJqmEpUHI8nZdMA7P9XFLNAeQf
 75+R/+SAdrzwcXFmInUP9tAa6Ilw6+pdMAufHOHlbyAQOM/LeNVekSbDiRimNhgDJdCKccwe6eS
 /rdOeVTw==
X-Gm-Gg: AYBFou0oETzjhziHOpvyBwFqo20ZhMqTWZ1OFtKoBvFrRur95QcDNKZ8f4BEgjGrQgp
 Giplpvc+IWVOW9eTVNIWOtin/HUMiZmf5tlfYKC3Dc2x7ATvWyz2yNJf+VEj0hM86jWoru3S/Aa
 BQd8fECZOQVpQ6CIBmdvXhOv0RwCvp6IToS1ZwVgLt4No0La5X5pTiaIo9Q3nfYhAlbk6S0dfEc
 GPCtdp0uNsobzzf8DV856fpi1nmhrVSOi2MCTrczuqU9ouD8fUe1oGMpgCbNS6RQA3XipNinOKL
 t+SrzaPwRVdB0rqPfhBjD+fQ56jM1tPCys9uwks84cKFzgF4oaQr58N6wqv3w2w7HRB78txg81d
 zKkPW/g6NRS2jER2CATDW7bfPmkh233EvlBOfRpldVJREGWmUueTZJ0+2PUVA/ZiDw21+F7AoLD
 POqsK+GFHh3wGqbpUU/SZKvESsEfVWjUT0mIKEBdEadsVOGJcG7idiJkSWbr6ICVhPTlENTkoFw
 WQ+SvxDVzRa4aaxpkRFnnaMN/rTY2Yc4T5ZOKoLUZ5IpqgY09qdYscoLyIlbocZOt9zl+HHAVEf
 +mzig3Bzgjjq2QduL2PSjAO0MLIBXCV4qzyRXypNSOvk3TGT7CG3jKqr39lPcPn+ncN+MbtqRxk
 cZgRKwStACWLWGi0vIz+n5L2Sp836fMP/mAh5ztYUV07ZhJ6OeN65le+j5RNwpCVrFhdLf+OPjH
 hZkYwwqbYOmQMq+NU=
X-Received: by 2002:a05:600c:3f08:b0:49e:7c8c:361d with SMTP id
 5b1f17b1804b1-4ba0937820cmr52313105e9.22.1794417332159; 
 Wed, 11 Nov 2026 09:15:32 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e28c882sm2309475e9.6.2026.11.11.09.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 09:15:31 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 17:15:31 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118
X-Gerrit-Change-Number: 2177
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2177?usp=email>
X-Gerrit-Commit: f1aa080919614eb7977b422b7d8ac3911bf24cdf
References: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDE3MzIyMDAwLkk2ZjVjYTUzZDQyODhiMDkyMTYxMGY3YTNmODRhZDU1ZDJhYjQ5MTE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5e5b81d45a49def54aff623a3d8ff6caaf6affd4-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRBv9-000000003N9-0v4b
Subject: [Openvpn-devel] [M] Change in openvpn[master]: networking_sitnl:
 Reduce boilerplate code for parameter checks
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2948197831089143241=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2948197831089143241==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0GFyTAMvV4Q="; charset=UTF-8

--0GFyTAMvV4Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2177?usp=3Demail

to review the following change=2E
=


Change subject: networking_sitnl: Reduce boilerplate code for parameter c=
hecks
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

network=
ing_sitnl: Reduce boilerplate code for parameter checks

Also removes some =
inconsistencies and some
sign conversion warnings=2E

Change-Id: I6f5ca53d4=
288b0921610f7a3f84ad55d2ab49118
Signed-off-by: Frank Lichtenheld <frank@lic=
htenheld=2Ecom>
---
M src/openvpn/networking_sitnl=2Ec
1 file changed, 79 i=
nsertions(+), 137 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/77/2177/1

diff --git a/src/openvpn/networking_si=
tnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index 501c635=2E=2Ed33afc3 10064=
4
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=
=2Ec
@@ -673,25 +673,64 @@
 
 #ifdef ENABLE_SITNL
 
+static int
+get_ifinde=
x(const char *func, const char *iface)
+{
+    if (!iface)
+    {
+        =
msg(M_WARN, "%s: passed NULL interface", func);
+        return -EINVAL;
+ =
   }
+
+    const int ifindex =3D (int)if_nametoindex(iface);
+    if (ifin=
dex =3D=3D 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get i=
findex for %s", func, iface);
+        return -ENOENT;
+    }
+    return i=
findex;
+}
+
+static int
+check_sitnl_addr_args(const char *func, sa_family=
_t af_family, const char *iface, uint32_t *ifindex)
+{
+    switch (af_fami=
ly)
+    {
+        case AF_INET:
+        case AF_INET6:
+            brea=
k;
+
+        default:
+            return -EINVAL;
+    }
+
+    if (!ifac=
e)
+    {
+        msg(M_WARN, "%s: passed NULL interface", func);
+       =
 return -EINVAL;
+    }
+
+    *ifindex =3D if_nametoindex(iface);
+    if =
(*ifindex =3D=3D 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot=
 get ifindex for %s", func, iface);
+        return -ENOENT;
+    }
+    re=
turn 0;
+}
+
+
 int
 net_iface_up(const openvpn_net_ctx_t *ctx, const char =
*iface, bool up)
 {
     struct sitnl_link_req req;
-    int ifindex;
 
   =
  CLEAR(req);
 
-    if (!iface)
+    const int ifindex =3D get_ifindex(__f=
unc__, iface);
+    if (ifindex < 0)
     {
-        msg(M_WARN, "%s: passe=
d NULL interface", __func__);
-        return -EINVAL;
-    }
-
-    ifinde=
x =3D if_nametoindex(iface);
-    if (ifindex =3D=3D 0)
-    {
-        msg=
(M_WARN, "%s: rtnl: cannot get ifindex for %s: %s", __func__, iface, strerr=
or(errno));
-        return -ENOENT;
+        return ifindex;
     }
 
    =
 req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));
@@ -719,14 +758,13 =
@@
 net_iface_mtu_set(const openvpn_net_ctx_t *ctx, const char *iface, uint=
32_t mtu)
 {
     struct sitnl_link_req req;
-    int ifindex, ret =3D -1;
=
+    int ret =3D -1;
 
     CLEAR(req);
 
-    ifindex =3D if_nametoindex(i=
face);
-    if (ifindex =3D=3D 0)
+    const int ifindex =3D get_ifindex(__=
func__, iface);
+    if (ifindex < 0)
     {
-        msg(M_WARN | M_ERRNO,=
 "%s: rtnl: cannot get ifindex for %s", __func__, iface);
         return -=
1;
     }
 
@@ -750,14 +788,13 @@
 net_addr_ll_set(const openvpn_net_ctx_t =
*ctx, const openvpn_net_iface_t *iface, uint8_t *addr)
 {
     struct sitnl=
_link_req req;
-    int ifindex, ret =3D -1;
+    int ret =3D -1;
 
     CL=
EAR(req);
 
-    ifindex =3D if_nametoindex(iface);
-    if (ifindex =3D=3D=
 0)
+    const int ifindex =3D get_ifindex(__func__, iface);
+    if (ifind=
ex < 0)
     {
-        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex=
 for %s", __func__, iface);
         return -1;
     }
 
@@ -778,12 +815,19=
 @@
 }
 
 static int
-sitnl_addr_set(uint16_t cmd, uint16_t flags, int ifin=
dex, sa_family_t af_family,
+sitnl_addr_set(uint16_t cmd, uint16_t flags, c=
onst char *iface, sa_family_t af_family,
                const inet_address=
_t *local, const inet_address_t *remote, int prefixlen)
 {
     struct sitn=
l_addr_req req;
-    uint32_t size;
-    int ret =3D -EINVAL;
+    size_t s=
ize;
+    uint32_t ifindex;
+
+    int ret =3D check_sitnl_addr_args(__func=
__, af_family, iface, &ifindex);
+    if (ret < 0)
+    {
+        return r=
et;
+    }
+    ret =3D -EINVAL; /* for SITNL_ADDATTR */
 
     CLEAR(req);=

 
@@ -813,7 +857,7 @@
     /* if no prefixlen has been specified, assume h=
ost address */
     if (prefixlen =3D=3D 0)
     {
-        prefixlen =3D s=
ize * 8;
+        prefixlen =3D (int)size * 8;
     }
     ASSERT(prefixlen=
 <=3D UINT8_MAX);
     req=2Ei=2Eifa_prefixlen =3D (uint8_t)prefixlen;
@@ -=
848,64 +892,14 @@
 sitnl_addr_ptp_add(sa_family_t af_family, const char *if=
ace, const inet_address_t *local,
                    const inet_address_t =
*remote)
 {
-    int ifindex;
-
-    switch (af_family)
-    {
-        cas=
e AF_INET:
-        case AF_INET6:
-            break;
-
-        default:
=
-            return -EINVAL;
-    }
-
-    if (!iface)
-    {
-        msg(=
M_WARN, "%s: passed NULL interface", __func__);
-        return -EINVAL;
- =
   }
-
-    ifindex =3D if_nametoindex(iface);
-    if (ifindex =3D=3D 0)
-=
    {
-        msg(M_WARN, "%s: cannot get ifindex for %s: %s", __func__, n=
p(iface), strerror(errno));
-        return -ENOENT;
-    }
-
-    return s=
itnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family=
, local,
+    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLA=
CE, iface, af_family, local,
                           remote, 0);
 }
 
 s=
tatic int
 sitnl_addr_ptp_del(sa_family_t af_family, const char *iface, con=
st inet_address_t *local)
 {
-    int ifindex;
-
-    switch (af_family)
- =
   {
-        case AF_INET:
-        case AF_INET6:
-            break;
-
-=
        default:
-            return -EINVAL;
-    }
-
-    if (!iface)
-  =
  {
-        msg(M_WARN, "%s: passed NULL interface", __func__);
-        r=
eturn -EINVAL;
-    }
-
-    ifindex =3D if_nametoindex(iface);
-    if (if=
index =3D=3D 0)
-    {
-        msg(M_WARN | M_ERRNO, "%s: cannot get ifind=
ex for %s", __func__, iface);
-        return -ENOENT;
-    }
-
-    return=
 sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, local, NULL, 0);
+    r=
eturn sitnl_addr_set(RTM_DELADDR, 0, iface, af_family, local, NULL, 0);
 }
=
 
 static int
@@ -982,64 +976,14 @@
 static int
 sitnl_addr_add(sa_family_t=
 af_family, const char *iface, const inet_address_t *addr, int prefixlen)
 =
{
-    int ifindex;
-
-    switch (af_family)
-    {
-        case AF_INET:=

-        case AF_INET6:
-            break;
-
-        default:
-         =
   return -EINVAL;
-    }
-
-    if (!iface)
-    {
-        msg(M_WARN, "%=
s: passed NULL interface", __func__);
-        return -EINVAL;
-    }
-
-  =
  ifindex =3D if_nametoindex(iface);
-    if (ifindex =3D=3D 0)
-    {
-   =
     msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__,=
 iface);
-        return -ENOENT;
-    }
-
-    return sitnl_addr_set(RTM_N=
EWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family, addr, NULL,
+    =
return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, iface, af_=
family, addr, NULL,
                           prefixlen);
 }
 
 static int=

 sitnl_addr_del(sa_family_t af_family, const char *iface, const inet_addre=
ss_t *addr, int prefixlen)
 {
-    int ifindex;
-
-    switch (af_family)
-=
    {
-        case AF_INET:
-        case AF_INET6:
-            break;
-
=
-        default:
-            return -EINVAL;
-    }
-
-    if (!iface)
- =
   {
-        msg(M_WARN, "%s: passed NULL interface", __func__);
-        =
return -EINVAL;
-    }
-
-    ifindex =3D if_nametoindex(iface);
-    if (i=
findex =3D=3D 0)
-    {
-        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot ge=
t ifindex for %s", __func__, iface);
-        return -ENOENT;
-    }
-
-   =
 return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, addr, NULL, pref=
ixlen);
+    return sitnl_addr_set(RTM_DELADDR, 0, iface, af_family, addr, =
NULL, prefixlen);
 }
 
 int
@@ -1178,11 +1122,10 @@
 
     if (iface)
     =
{
-        ifindex =3D if_nametoindex(iface);
-        if (ifindex =3D=3D 0=
)
+        ifindex =3D get_ifindex(__func__, iface);
+        if (ifindex <=
 0)
         {
-            msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifin=
dex for %s", __func__, iface);
-            return -ENOENT;
+            re=
turn ifindex;
         }
     }
 
@@ -1262,11 +1205,10 @@
 
     if (iface)=

     {
-        ifindex =3D if_nametoindex(iface);
-        if (ifindex =
=3D=3D 0)
+        ifindex =3D get_ifindex(__func__, iface);
+        if (i=
findex < 0)
         {
-            msg(M_WARN | M_ERRNO, "%s: rtnl: can't =
get ifindex for %s", __func__, iface);
-            return -ENOENT;
+      =
      return ifindex;
         }
     }
 
@@ -1439,7 +1381,7 @@
 net_iface_=
type(const openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_=
LEN_MAX])
 {
     struct sitnl_link_req req =3D {};
-    int ifindex =3D if=
_nametoindex(iface);
+    int ifindex =3D (int)if_nametoindex(iface);
 
   =
  if (!ifindex)
     {
@@ -1471,7 +1413,7 @@
 net_iface_del(const openvpn_n=
et_ctx_t *ctx, const char *iface)
 {
     struct sitnl_link_req req =3D {};=

-    int ifindex =3D if_nametoindex(iface);
+    int ifindex =3D (int)if_n=
ametoindex(iface);
 
     if (!ifindex)
     {

-- 
To view, visit https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118
Ger=
rit-Change-Number: 2177
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--0GFyTAMvV4Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">networking_sitnl: Reduce boilerplate code for parameter ch=
ecks<br><br>Also removes some inconsistencies and some<br>sign conversion w=
arnings=2E<br><br>Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118<br>S=
igned-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M=
 src/openvpn/networking_sitnl=2Ec<br>1 file changed, 79 insertions(+), 137 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/77/2177/1</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ne=
tworking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><span>index=
 501c635=2E=2Ed33afc3 100644</span><br><span>--- a/src/openvpn/networking_s=
itnl=2Ec</span><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</span><br><=
span>@@ -673,25 +673,64 @@</span><br><span> </span><br><span> #ifdef ENABLE=
_SITNL</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_=
ifindex(const char *func, const char *iface)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!iface)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg=
(M_WARN, &quot;%s: passed NULL interface&quot;, func);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return -EINVAL;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const int ifindex =3D (int)if_nametoindex(iface);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (ifindex =3D=3D 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;%s: r=
tnl: cannot get ifindex for %s&quot;, func, iface);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return -ENOENT;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return ifindex;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+check_sitnl_addr_args(=
const char *func, sa_family_t af_family, const char *iface, uint32_t *ifind=
ex)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    switch (af_family)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        case AF_INET:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        case AF_INET6:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        default:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            return -EINVAL;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!if=
ace)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;%s:=
 passed NULL interface&quot;, func);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return -EINVAL;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *ifindex=
 =3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (*ifindex =3D=3D 0)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for %s&qu=
ot;, func, iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return -ENOENT;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> int</span><br><span> net_iface_up(co=
nst openvpn_net_ctx_t *ctx, const char *iface, bool up)</span><br><span> {<=
/span><br><span>     struct sitnl_link_req req;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    int ifindex;</span><br><span> </span><br><spa=
n>     CLEAR(req);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (!iface)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const int ifindex =3D get_ifindex(__func__, iface);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (ifindex &lt; 0)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     msg(M_WARN, &quot;%s: passed NULL interface&quot;, __func__);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        return -EINVAL;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    ifindex =3D if_nametoindex(iface);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (ifindex =3D=3D 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(M_WARN, &quot;%s: rtnl: cannot get ifindex for =
%s: %s&quot;, __func__, iface, strerror(errno));</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        return -ENOENT;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return ifindex;</span><br><span>    =
 }</span><br><span> </span><br><span>     req=2En=2Enlmsg_len =3D NLMSG_LEN=
GTH(sizeof(req=2Ei));</span><br><span>@@ -719,14 +758,13 @@</span><br><span=
> net_iface_mtu_set(const openvpn_net_ctx_t *ctx, const char *iface, uint32=
_t mtu)</span><br><span> {</span><br><span>     struct sitnl_link_req req;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ifindex, ret =
=3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =
=3D -1;</span><br><span> </span><br><span>     CLEAR(req);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_n=
ametoindex(iface);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (ifindex =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const int ifindex =3D get_ifindex(__func__, iface);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (ifindex &lt; 0)</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg=
(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for %s&quot;, __func_=
_, iface);</span><br><span>         return -1;</span><br><span>     }</span=
><br><span> </span><br><span>@@ -750,14 +788,13 @@</span><br><span> net_add=
r_ll_set(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, ui=
nt8_t *addr)</span><br><span> {</span><br><span>     struct sitnl_link_req =
req;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ifindex, =
ret =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
ret =3D -1;</span><br><span> </span><br><span>     CLEAR(req);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D =
if_nametoindex(iface);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (ifindex =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const int ifindex =3D get_ifindex(__func__, iface);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (ifindex &lt; 0)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for %s&quot;, __f=
unc__, iface);</span><br><span>         return -1;</span><br><span>     }</=
span><br><span> </span><br><span>@@ -778,12 +815,19 @@</span><br><span> }</=
span><br><span> </span><br><span> static int</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-sitnl_addr_set(uint16_t cmd, uint16_t flags, int ifi=
ndex, sa_family_t af_family,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+sitnl_addr_set(uint16_t cmd, uint16_t flags, const char *iface, sa=
_family_t af_family,</span><br><span>                const inet_address_t *=
local, const inet_address_t *remote, int prefixlen)</span><br><span> {</spa=
n><br><span>     struct sitnl_addr_req req;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    uint32_t size;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    int ret =3D -EINVAL;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    size_t size;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    uint32_t ifindex;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    int ret =3D check_sitnl_addr_args(__func__, af_family, iface, &amp;=
ifindex);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (re=
t &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return ret;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ret =3D -EINVAL; /* for SITNL_ADDA=
TTR */</span><br><span> </span><br><span>     CLEAR(req);</span><br><span> =
</span><br><span>@@ -813,7 +857,7 @@</span><br><span>     /* if no prefixle=
n has been specified, assume host address */</span><br><span>     if (prefi=
xlen =3D=3D 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        prefixlen =3D size * 8;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        prefixlen =3D (int)size * 8;</span><br>=
<span>     }</span><br><span>     ASSERT(prefixlen &lt;=3D UINT8_MAX);</spa=
n><br><span>     req=2Ei=2Eifa_prefixlen =3D (uint8_t)prefixlen;</span><br>=
<span>@@ -848,64 +892,14 @@</span><br><span> sitnl_addr_ptp_add(sa_family_t=
 af_family, const char *iface, const inet_address_t *local,</span><br><span=
>                    const inet_address_t *remote)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ifindex;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    switch (af_family)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        case AF_INET:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        case AF_INET6:</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            break;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        default:=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return -E=
INVAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (!iface)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        msg(M_WARN, &quot;%s: passed NULL interface&quot;, __func__);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        return -EINVAL;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    ifindex =3D if_nametoindex(iface);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (ifindex =3D=3D 0)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: cannot get ifindex for %s=
: %s&quot;, __func__, np(iface), strerror(errno));</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        return -ENOENT;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af=
_family, local,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, iface, af_=
family, local,</span><br><span>                           remote, 0);</span=
><br><span> }</span><br><span> </span><br><span> static int</span><br><span=
> sitnl_addr_ptp_del(sa_family_t af_family, const char *iface, const inet_a=
ddress_t *local)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    int ifindex;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (=
af_family)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET:</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET6:</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        default:</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            return -EINVAL;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!if=
ace)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: pas=
sed NULL interface&quot;, __func__);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        return -EINVAL;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_n=
ametoindex(iface);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (ifindex =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_W=
ARN | M_ERRNO, &quot;%s: cannot get ifindex for %s&quot;, __func__, iface);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return -ENOEN=
T;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_fa=
mily, local, NULL, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return sitnl_addr_set(RTM_DELADDR, 0, iface, af_family, local, NULL,=
 0);</span><br><span> }</span><br><span> </span><br><span> static int</span=
><br><span>@@ -982,64 +976,14 @@</span><br><span> static int</span><br><spa=
n> sitnl_addr_add(sa_family_t af_family, const char *iface, const inet_addr=
ess_t *addr, int prefixlen)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    int ifindex;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   switch (af_family)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case AF_=
INET:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case AF_=
INET6:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            bre=
ak;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        default:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            return -EINVAL;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (!iface)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &=
quot;%s: passed NULL interface&quot;, __func__);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        return -EINVAL;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifin=
dex =3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (ifindex =3D=3D 0)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for %s&quot;,=
 __func__, iface);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     return -ENOENT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_addr_set(RTM_NEWADDR,=
 NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family, addr, NULL,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_addr_set(RTM_NE=
WADDR, NLM_F_CREATE | NLM_F_REPLACE, iface, af_family, addr, NULL,</span><b=
r><span>                           prefixlen);</span><br><span> }</span><br=
><span> </span><br><span> static int</span><br><span> sitnl_addr_del(sa_fam=
ily_t af_family, const char *iface, const inet_address_t *addr, int prefixl=
en)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    int ifindex;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (af_family)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        case AF_INET:</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        case AF_INET6:</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        default:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            return -EINVAL;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!iface)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: passed NULL inte=
rface&quot;, __func__);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        return -EINVAL;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_nametoindex(if=
ace);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ifindex =
=3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN | M_ERRNO=
, &quot;%s: rtnl: cannot get ifindex for %s&quot;, __func__, iface);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        return -ENOENT;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, a=
ddr, NULL, prefixlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return sitnl_addr_set(RTM_DELADDR, 0, iface, af_family, addr, NULL, =
prefixlen);</span><br><span> }</span><br><span> </span><br><span> int</span=
><br><span>@@ -1178,11 +1122,10 @@</span><br><span> </span><br><span>     i=
f (iface)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        ifindex =3D if_nametoindex(iface);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (ifindex =3D=3D 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        ifindex =3D get_ifindex(_=
_func__, iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (ifindex &lt; 0)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN | M_ERRNO, &quot;%s:=
 rtnl: can&#39;t get ifindex for %s&quot;, __func__, iface);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            return -ENOENT;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            return ifindex;<=
/span><br><span>         }</span><br><span>     }</span><br><span> </span><=
br><span>@@ -1262,11 +1205,10 @@</span><br><span> </span><br><span>     if =
(iface)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        ifindex =3D if_nametoindex(iface);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (ifindex =3D=3D 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        ifindex =3D get_ifindex(_=
_func__, iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (ifindex &lt; 0)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN | M_ERRNO, &quot;%s:=
 rtnl: can&#39;t get ifindex for %s&quot;, __func__, iface);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            return -ENOENT;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            return ifindex;<=
/span><br><span>         }</span><br><span>     }</span><br><span> </span><=
br><span>@@ -1439,7 +1381,7 @@</span><br><span> net_iface_type(const openvp=
n_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX])</span><=
br><span> {</span><br><span>     struct sitnl_link_req req =3D {};</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    int ifindex =3D if_nametoi=
ndex(iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int=
 ifindex =3D (int)if_nametoindex(iface);</span><br><span> </span><br><span>=
     if (!ifindex)</span><br><span>     {</span><br><span>@@ -1471,7 +1413,=
7 @@</span><br><span> net_iface_del(const openvpn_net_ctx_t *ctx, const cha=
r *iface)</span><br><span> {</span><br><span>     struct sitnl_link_req req=
 =3D {};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ifind=
ex =3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int ifindex =3D (int)if_nametoindex(iface);</span><br><span> =
</span><br><span>     if (!ifindex)</span><br><span>     {</span><br></pre>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/217=
7?usp=3Demail">change 2177</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2177?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchan=
ge </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 2177 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerr=
it-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--0GFyTAMvV4Q=--


--===============2948197831089143241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2948197831089143241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2948197831089143241==--

