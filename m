Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D02E606A323
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mVT/OUgZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=chEfy1Ht;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=S6qPI83W;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CHe8+3WI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EoDD0QhHH2aPZrZfKAMPFKCIlVbHSnmo0D7rRIGYy+U=; b=mVT/OUgZeoGlYJg26vHMGzAhzD
	GNPXO/xRWuKd+fDfG/pk6btYnDzRbKf/iBx4Iq3Oj5AkbpArvrprzg53PYUTu8bFcFp9stW6EhsLV
	JEhP3lZUMG7AukFfXkbH4ddnorHK6vq+uuYEn0ZbM8bGB5X1Ns8qZjKEHI9Xrj0qbE+g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSvBG-000000000kf-0Bo0;
	Mon, 16 Nov 2026 11:47:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSvAv-000000000iT-3fcg
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 11:47:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v3pycAO1DAK63LlrUTSYmBP1LATHspNZbPh4kJU6E3o=; b=chEfy1HtHt4NuicuO2DH+1UTf3
 BEPGaO5Iw0iND3DrAS6HAuW/AB1hh4eGQBvkU3J0SJIBPsgIUQWJUEBcJ0sOiy9V21RYq617bVrNs
 iOj+ul2Y9n0xakO7W3Ktp59FhMdwGwXDbHrx9YhrBuK4X9AlLIaUoeiOFA/nAtw5GJJY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v3pycAO1DAK63LlrUTSYmBP1LATHspNZbPh4kJU6E3o=; b=S6qPI83Wq/50W+9unwwQzpIAp1
 W0ZnMvVrCmGEk23QGt0hp1YjIooBXsiGqYSC3E4TlI1OCpohfxof97VmUnEOSFAiQEkSD9GEUB4CJ
 0Emg9ba3AAmPw2f82zMKL8jl8x5qyKINE1yQCIHF4WPvqiCPoBY5ajrm47u91fs9jUo4=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSvAd-000000004xG-1T14 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 11:46:52 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so21803785e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 03:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794829601; x=1795434401; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=v3pycAO1DAK63LlrUTSYmBP1LATHspNZbPh4kJU6E3o=;
 b=CHe8+3WIiep8qxFFAFdhlNLIPvCaMEAD4X4IdUrte0RQUbLNcLFDao99kGdzf1Q2mt
 km7pTL+eOmhmvjpXr5gealAsfNkbSDSpbl3Bk55fAuvfmADwvwSi9c19NYxCPuJcSEK1
 KnZEnJ4JCX6EA7/5/twAfYFKvq3XKo2WbTvmoQC5AqgibUc0D+7KzRAhyQkK2/ZSis/l
 k+3s4F77yHx/Wer4+clAvOFAzG+So5+B0D+a48xQauhmTE7UGY2uJcQXqGKJ10Ck49u/
 9PWUn5U5dv7ppdktLbIvnMov9U9spp9BqJlNPkGppsJZM/y+sVmrwhLVuMeFkut7PvJM
 1L/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794829601; x=1795434401;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=v3pycAO1DAK63LlrUTSYmBP1LATHspNZbPh4kJU6E3o=;
 b=EOqfaRXK4VrBgrtnxMOGRj7Qk1onlch1WKGyGWX6SUHyj6ASGu0Qk5SrMaHy0cNtke
 SpErKlrugAxUit88dZZD21fXzP/2i6nFzgJf2q5uGNZqqW23tFS4jqIH2URIQvf8URdz
 aMAMh+Utc1Aakn2ZZ6o44KqW371KAJd/nsBy8i5mq8fGgToGWxjWRbfKe/eJr85KXEGF
 JC5Hf4+ihcpuiwQDdJsvGdPELwIjrYz4cJ3TQHxFfiaX0fv8J/wTwr7ROxNy8SssO6Y6
 GBNFzlJNRCbOEYGThRvBYTuVjCaHIq5N8a/73EgzOUpzbqjdKvvq1snc0Ai7rhOhK0c3
 1AQA==
X-Gm-Message-State: APuU4Z9XQR7+u6SXgADJZ06y8g/pG/2m/FPuVEfQ1g70Uq9OmtlqW3V0
 Q4DBt2mqGQ5qgOs2xjN2J0TeZvbXkAAQJvl4gGu33pE4uSAWhHQlPIcB5sCl9CddlFCW/iHkHU/
 7OJ49gZMpNYSNNDZJoSaL3wIDTB7oGrlp7CcFpCgT9mTkUkxWA2moajvGJt/EJ1psozJIC5wrTC
 bM+adQtQ==
X-Gm-Gg: AYBFou19hZ2boTbtuY8nsTL8lUWVyl6WmRAPIWxtgEngg6ogEHeNeKYqFND0/0z7zW7
 t0+h1phSJJ45/Evl4iQVBD5MHxUgPxHD9GqqZXR/20166A0GTyJ72hTdoQwsqi1Rw2lOKA/7M+q
 AWyf/mElJhLureCqH6GRdHdGwDJnn0FK4pUje5mDXYp2NsbmUQV456swFbBGz5ZutbFLC5MPfqP
 4TOhSEi5NaP8/7dm+sSrtjupQVErD05c6WFlGTgOwZvzmfkrn50IGUflFh4/Y8Cm11bEZYHnIoU
 h5AgpDUBuRK+UR8Q9Vvwg9fgbF6asbn8sV6xTuAZZ+H6EifBNYPznawYSdZsaLQnHxqmh/RhxG5
 UsK4H6GQs3oFdmplYK1WfGgi1AvHjTKX4eDd0PS9f5g1uwF/EV7Wm4nEzpSz4a4K2YrVzwoHv/F
 Zpr3p50oiLKVO/SbvP3ADNugEL/s0yQN4aQXhnPIhPQZoSW84ASpwcpHZQK1c3wq1SaV0GMRs3C
 JW6FDUNv2tAH0L4x4JIMAJv/14siNUnsF2F53lAbVBB/6yQIgr/jYl23Cqn1Sz+4q7AYt50S+qz
 9wMOO340OgmYUeJniArTc1o9t6zXNH/3Vseqbzwi0cRd7dD9/4ybnjxxfRuuQXGtT2u9K/744H4
 5QNYKI3jXoh/7p5FbdEvP51Og73WJVp5vmMudrlN9IAnvIVndzJHGt7ifHe4z5aAeMNfbh19NHy
 nkM7XxrvtClZ8FSNbg
X-Received: by 2002:a05:600c:3152:b0:4a2:677:ad8e with SMTP id
 5b1f17b1804b1-4bb55aac0bfmr227077965e9.34.1794829600441; 
 Mon, 16 Nov 2026 03:46:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb666a3ca1sm204270475e9.9.2026.11.16.03.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:46:40 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 11:46:38 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118
X-Gerrit-Change-Number: 2177
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2177?usp=email>
X-Gerrit-Commit: 5f21576c5a3cd522f75975f2ace80184e713cabd
In-Reply-To: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
References: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDE3MzIyMDAwLkk2ZjVjYTUzZDQyODhiMDkyMTYxMGY3YTNmODRhZDU1ZDJhYjQ5MTE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <41d6182a8c329820e243f11c780aa1e2ede4f374-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSvAd-000000004xG-1T14
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com,
 gert@greenie.muc.de
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2154748918265491172=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2154748918265491172==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+i30bWAWAQc="; charset=UTF-8

--+i30bWAWAQc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, Fran=
k Lichtenheld, Gert Doering, R=C4=83zvan Cojocaru=2E

Hello Antonio Quartul=
li, Arne Schwabe, Gert Doering, R=C4=83zvan Cojocaru, 

I'd like you to ree=
xamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2177?usp=3Demail

to look at the new patch set (#3)=2E

The following =
approvals got outdated and were removed:
Code-Review+2 by Antonio Quartulli=
, Code-Review+2 by R=C4=83zvan Cojocaru, Code-Review-1 by Gert Doering


Ch=
ange subject: networking_sitnl: Reduce boilerplate code for parameter check=
s
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

networking=
_sitnl: Reduce boilerplate code for parameter checks

Also removes some inc=
onsistencies and some
sign conversion warnings=2E

Change-Id: I6f5ca53d4288=
b0921610f7a3f84ad55d2ab49118
Signed-off-by: Frank Lichtenheld <frank@lichte=
nheld=2Ecom>
---
M src/openvpn/networking_sitnl=2Ec
1 file changed, 74 inse=
rtions(+), 169 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/77/2177/3

diff --git a/src/openvpn/networking_sitnl=
=2Ec b/src/openvpn/networking_sitnl=2Ec
index d5ec6bb=2E=2Eb7c0f58 100644
-=
-- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2E=
c
@@ -677,25 +677,37 @@
 
 #ifdef ENABLE_SITNL
 
+static int
+get_ifindex(c=
onst char *func, const char *iface, uint32_t *ifindex)
+{
+    if (!iface)
=
+    {
+        msg(M_WARN, "%s: passed NULL interface", func);
+        re=
turn -EINVAL;
+    }
+
+    *ifindex =3D if_nametoindex(iface);
+    if (*i=
findex =3D=3D 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot ge=
t ifindex for %s", func, iface);
+        return -ENOENT;
+    }
+    retur=
n 0;
+}
+
+
 int
 net_iface_up(const openvpn_net_ctx_t *ctx, const char *if=
ace, bool up)
 {
     struct sitnl_link_req req;
-    int ifindex;
+    uin=
t32_t ifindex;
 
     CLEAR(req);
 
-    if (!iface)
+    const int ret =3D=
 get_ifindex(__func__, iface, &ifindex);
+    if (ret < 0)
     {
-        =
msg(M_WARN, "%s: passed NULL interface", __func__);
-        return -EINVAL=
;
-    }
-
-    ifindex =3D if_nametoindex(iface);
-    if (ifindex =3D=3D =
0)
-    {
-        msg(M_WARN, "%s: rtnl: cannot get ifindex for %s: %s", _=
_func__, iface, strerror(errno));
-        return -ENOENT;
+        return =
ret;
     }
 
     req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));
@=
@ -703,7 +715,7 @@
     req=2En=2Enlmsg_type =3D RTM_SETLINK;
 
     req=2E=
i=2Eifi_family =3D AF_PACKET;
-    req=2Ei=2Eifi_index =3D ifindex;
+    re=
q=2Ei=2Eifi_index =3D (int)ifindex;
     req=2Ei=2Eifi_change |=3D IFF_UP;
=
     if (up)
     {
@@ -711,7 +723,7 @@
     }
     else
     {
-        re=
q=2Ei=2Eifi_flags &=3D ~IFF_UP;
+        req=2Ei=2Eifi_flags &=3D ~(unsigne=
d int)IFF_UP;
     }
 
     msg(M_INFO, "%s: set %s %s", __func__, iface, u=
p ? "up" : "down");
@@ -723,14 +735,13 @@
 net_iface_mtu_set(const openvpn_=
net_ctx_t *ctx, const char *iface, uint32_t mtu)
 {
     struct sitnl_link_=
req req;
-    int ifindex, ret =3D -1;
+    int ret =3D -1;
+    uint32_t i=
findex;
 
     CLEAR(req);
 
-    ifindex =3D if_nametoindex(iface);
-    i=
f (ifindex =3D=3D 0)
+    if (get_ifindex(__func__, iface, &ifindex) < 0)
 =
    {
-        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s",=
 __func__, iface);
         return -1;
     }
 
@@ -739,7 +750,7 @@
     re=
q=2En=2Enlmsg_type =3D RTM_SETLINK;
 
     req=2Ei=2Eifi_family =3D AF_PACK=
ET;
-    req=2Ei=2Eifi_index =3D ifindex;
+    req=2Ei=2Eifi_index =3D (int=
)ifindex;
 
     SITNL_ADDATTR(&req=2En, sizeof(req), IFLA_MTU, &mtu, 4);
 =

@@ -754,14 +765,13 @@
 net_addr_ll_set(const openvpn_net_ctx_t *ctx, const=
 openvpn_net_iface_t *iface, uint8_t *addr)
 {
     struct sitnl_link_req r=
eq;
-    int ifindex, ret =3D -1;
+    int ret =3D -1;
+    uint32_t ifinde=
x;
 
     CLEAR(req);
 
-    ifindex =3D if_nametoindex(iface);
-    if (if=
index =3D=3D 0)
+    if (get_ifindex(__func__, iface, &ifindex) < 0)
     {=

-        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __fu=
nc__, iface);
         return -1;
     }
 
@@ -770,7 +780,7 @@
     req=2En=
=2Enlmsg_type =3D RTM_SETLINK;
 
     req=2Ei=2Eifi_family =3D AF_PACKET;
-=
    req=2Ei=2Eifi_index =3D ifindex;
+    req=2Ei=2Eifi_index =3D (int)ifin=
dex;
 
     SITNL_ADDATTR(&req=2En, sizeof(req), IFLA_ADDRESS, addr, OPENVP=
N_ETH_ALEN);
 
@@ -782,22 +792,19 @@
 }
 
 static int
-sitnl_addr_set(uint1=
6_t cmd, uint16_t flags, int ifindex, sa_family_t af_family,
+sitnl_addr_se=
t(uint16_t cmd, uint16_t flags, const char *iface, sa_family_t af_family,
 =
               const inet_address_t *local, const inet_address_t *remote, i=
nt prefixlen)
 {
     struct sitnl_addr_req req;
-    uint32_t size;
-    i=
nt ret =3D -EINVAL;
+    size_t size;
+    uint32_t ifindex;
 
-    CLEAR(r=
eq);
-
-    req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));
-    req=
=2En=2Enlmsg_type =3D cmd;
-    req=2En=2Enlmsg_flags =3D NLM_F_REQUEST | f=
lags;
-
-    req=2Ei=2Eifa_index =3D ifindex;
-    ASSERT(af_family <=3D UI=
NT8_MAX);
-    req=2Ei=2Eifa_family =3D (uint8_t)af_family;
+    int ret =
=3D get_ifindex(__func__, iface, &ifindex);
+    if (ret < 0)
+    {
+     =
   return ret;
+    }
+    ret =3D -EINVAL; /* for SITNL_ADDATTR */
 
     =
switch (af_family)
     {
@@ -814,10 +821,20 @@
             return -EINVAL=
;
     }
 
+    CLEAR(req);
+
+    req=2En=2Enlmsg_len =3D NLMSG_LENGTH(siz=
eof(req=2Ei));
+    req=2En=2Enlmsg_type =3D cmd;
+    req=2En=2Enlmsg_flag=
s =3D NLM_F_REQUEST | flags;
+
+    req=2Ei=2Eifa_index =3D ifindex;
+    A=
SSERT(af_family <=3D UINT8_MAX);
+    req=2Ei=2Eifa_family =3D (uint8_t)af_=
family;
+
     /* if no prefixlen has been specified, assume host address *=
/
     if (prefixlen =3D=3D 0)
     {
-        prefixlen =3D size * 8;
+   =
     prefixlen =3D (int)size * 8;
     }
     ASSERT(prefixlen <=3D UINT8_M=
AX);
     req=2Ei=2Eifa_prefixlen =3D (uint8_t)prefixlen;
@@ -852,76 +869,3=
7 @@
 sitnl_addr_ptp_add(sa_family_t af_family, const char *iface, const in=
et_address_t *local,
                    const inet_address_t *remote)
 {
-=
    int ifindex;
-
-    switch (af_family)
-    {
-        case AF_INET:
- =
       case AF_INET6:
-            break;
-
-        default:
-            =
return -EINVAL;
-    }
-
-    if (!iface)
-    {
-        msg(M_WARN, "%s: =
passed NULL interface", __func__);
-        return -EINVAL;
-    }
-
-    i=
findex =3D if_nametoindex(iface);
-    if (ifindex =3D=3D 0)
-    {
-      =
  msg(M_WARN, "%s: cannot get ifindex for %s: %s", __func__, np(iface), str=
error(errno));
-        return -ENOENT;
-    }
-
-    return sitnl_addr_set=
(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family, local,
+   =
 return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, iface, af=
_family, local,
                           remote, 0);
 }
 
 static int
 si=
tnl_addr_ptp_del(sa_family_t af_family, const char *iface, const inet_addre=
ss_t *local)
 {
-    int ifindex;
-
-    switch (af_family)
-    {
-       =
 case AF_INET:
-        case AF_INET6:
-            break;
-
-        defau=
lt:
-            return -EINVAL;
-    }
-
-    if (!iface)
-    {
-        =
msg(M_WARN, "%s: passed NULL interface", __func__);
-        return -EINVAL=
;
-    }
-
-    ifindex =3D if_nametoindex(iface);
-    if (ifindex =3D=3D =
0)
-    {
-        msg(M_WARN | M_ERRNO, "%s: cannot get ifindex for %s", _=
_func__, iface);
-        return -ENOENT;
-    }
-
-    return sitnl_addr_s=
et(RTM_DELADDR, 0, ifindex, af_family, local, NULL, 0);
+    return sitnl_a=
ddr_set(RTM_DELADDR, 0, iface, af_family, local, NULL, 0);
 }
 
 static int=

-sitnl_route_set(uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af=
_family, const void *dst,
+sitnl_route_set(uint16_t cmd, uint16_t flags, co=
nst char *iface, sa_family_t af_family, const void *dst,
                 i=
nt prefixlen, const void *gw, enum rt_class_t table, int metric,
          =
       enum rt_scope_t scope, unsigned char protocol, unsigned char type)
 =
{
     struct sitnl_route_req req;
-    int ret =3D -1, size;
+    int ret =
=3D -1; /* for SITNL_ADDATTR */
+    size_t size;
+    uint32_t ifindex =3D=
 0;
 
     CLEAR(req);
 
+    if (iface)
+    {
+        const int ifi_ret =
=3D get_ifindex(__func__, iface, &ifindex);
+        if (ifi_ret < 0)
+    =
    {
+            return ifi_ret;
+        }
+    }
+
     switch (af_fami=
ly)
     {
         case AF_INET:
@@ -986,64 +964,14 @@
 static int
 sitnl_=
addr_add(sa_family_t af_family, const char *iface, const inet_address_t *ad=
dr, int prefixlen)
 {
-    int ifindex;
-
-    switch (af_family)
-    {
- =
       case AF_INET:
-        case AF_INET6:
-            break;
-
-       =
 default:
-            return -EINVAL;
-    }
-
-    if (!iface)
-    {
-  =
      msg(M_WARN, "%s: passed NULL interface", __func__);
-        return -=
EINVAL;
-    }
-
-    ifindex =3D if_nametoindex(iface);
-    if (ifindex =
=3D=3D 0)
-    {
-        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifind=
ex for %s", __func__, iface);
-        return -ENOENT;
-    }
-
-    return=
 sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_fami=
ly, addr, NULL,
+    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_=
F_REPLACE, iface, af_family, addr, NULL,
                           prefixl=
en);
 }
 
 static int
 sitnl_addr_del(sa_family_t af_family, const char *if=
ace, const inet_address_t *addr, int prefixlen)
 {
-    int ifindex;
-
-   =
 switch (af_family)
-    {
-        case AF_INET:
-        case AF_INET6:
-=
            break;
-
-        default:
-            return -EINVAL;
-    }
=
-
-    if (!iface)
-    {
-        msg(M_WARN, "%s: passed NULL interface",=
 __func__);
-        return -EINVAL;
-    }
-
-    ifindex =3D if_nametoind=
ex(iface);
-    if (ifindex =3D=3D 0)
-    {
-        msg(M_WARN | M_ERRNO,=
 "%s: rtnl: cannot get ifindex for %s", __func__, iface);
-        return -=
ENOENT;
-    }
-
-    return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_fam=
ily, addr, NULL, prefixlen);
+    return sitnl_addr_set(RTM_DELADDR, 0, ifa=
ce, af_family, addr, NULL, prefixlen);
 }
 
 int
@@ -1190,17 +1118,6 @@
   =
              const void *gw, uint32_t table, int metric)
 {
     enum rt_s=
cope_t scope =3D RT_SCOPE_UNIVERSE;
-    int ifindex =3D 0;
-
-    if (ifac=
e)
-    {
-        ifindex =3D if_nametoindex(iface);
-        if (ifindex =
=3D=3D 0)
-        {
-            msg(M_WARN | M_ERRNO, "%s: rtnl: can't ge=
t ifindex for %s", __func__, iface);
-            return -ENOENT;
-        =
}
-    }
 
     if (table =3D=3D 0)
     {
@@ -1212,7 +1129,7 @@
         s=
cope =3D RT_SCOPE_LINK;
     }
 
-    return sitnl_route_set(RTM_NEWROUTE, =
NLM_F_CREATE, ifindex, af_family, dst, prefixlen, gw,
+    return sitnl_rou=
te_set(RTM_NEWROUTE, NLM_F_CREATE, iface, af_family, dst, prefixlen, gw,
  =
                          table, metric, scope, RTPROT_BOOT, RTN_UNICAST);
=
 }
 
@@ -1277,24 +1194,12 @@
 sitnl_route_del(const char *iface, sa_family_=
t af_family, const inet_address_t *dst, int prefixlen,
                 con=
st inet_address_t *gw, uint32_t table, int metric)
 {
-    int ifindex =3D =
0;
-
-    if (iface)
-    {
-        ifindex =3D if_nametoindex(iface);
-  =
      if (ifindex =3D=3D 0)
-        {
-            msg(M_WARN | M_ERRNO, "=
%s: rtnl: can't get ifindex for %s", __func__, iface);
-            return =
-ENOENT;
-        }
-    }
-
     if (table =3D=3D 0)
     {
         table=
 =3D RT_TABLE_MAIN;
     }
 
-    return sitnl_route_set(RTM_DELROUTE, 0, i=
findex, af_family, dst, prefixlen, gw, table, metric,
+    return sitnl_rou=
te_set(RTM_DELROUTE, 0, iface, af_family, dst, prefixlen, gw, table, metric=
,
                            RT_SCOPE_NOWHERE, 0, 0);
 }
 
@@ -1464,7 +136=
9,7 @@
 net_iface_type(const openvpn_net_ctx_t *ctx, const char *iface, cha=
r type[IFACE_TYPE_LEN_MAX])
 {
     struct sitnl_link_req req =3D {};
-    =
int ifindex =3D if_nametoindex(iface);
+    int ifindex =3D (int)if_nametoi=
ndex(iface);
 
     if (!ifindex)
     {
@@ -1496,7 +1401,7 @@
 net_iface_d=
el(const openvpn_net_ctx_t *ctx, const char *iface)
 {
     struct sitnl_li=
nk_req req =3D {};
-    int ifindex =3D if_nametoindex(iface);
+    int ifi=
ndex =3D (int)if_nametoindex(iface);
 
     if (!ifindex)
     {

-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3=
f84ad55d2ab49118
Gerrit-Change-Number: 2177
Gerrit-PatchSet: 3
Gerrit-Owner=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Antonio Quar=
tulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Ger=
rit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Antoni=
o Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: R=C4=83zvan Cojocar=
u <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-=
Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--+i30bWAWAQc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, Frank Lichtenheld, G=
ert Doering, R=C4=83zvan Cojocaru=2E </p>
<p>Frank Lichtenheld <strong>uplo=
aded patch set #3</strong> to this change=2E</p><p><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail">View Change</a></p><p>The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by Antonio =
Quartulli, Code-Review+2 by R=C4=83zvan Cojocaru, Code-Review-1 by Gert Doe=
ring</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">networking_sitnl: Reduce boilerplate code for paramet=
er checks<br><br>Also removes some inconsistencies and some<br>sign convers=
ion warnings=2E<br><br>Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---=
<br>M src/openvpn/networking_sitnl=2Ec<br>1 file changed, 74 insertions(+),=
 169 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/77/2177/3</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><span>=
index d5ec6bb=2E=2Eb7c0f58 100644</span><br><span>--- a/src/openvpn/network=
ing_sitnl=2Ec</span><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</span>=
<br><span>@@ -677,25 +677,37 @@</span><br><span> </span><br><span> #ifdef E=
NABLE_SITNL</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+get_ifindex(const char *func, const char *iface, uint32_t *ifindex)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!iface)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(M_WARN, &quot;%s: passed NULL interface&quot;, fun=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -=
EINVAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    *ifindex =3D if_nametoindex(iface);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (*ifindex =3D=3D 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &q=
uot;%s: rtnl: cannot get ifindex for %s&quot;, func, iface);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return -ENOENT;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> int</span><br><span> net_iface_up(const openvpn_net_ctx_t *ctx, const=
 char *iface, bool up)</span><br><span> {</span><br><span>     struct sitnl=
_link_req req;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int=
 ifindex;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32=
_t ifindex;</span><br><span> </span><br><span>     CLEAR(req);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!iface)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int ret =
=3D get_ifindex(__func__, iface, &amp;ifindex);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (ret &lt; 0)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;=
%s: passed NULL interface&quot;, __func__);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        return -EINVAL;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =
=3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (ifindex =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 msg(M_WARN, &quot;%s: rtnl: cannot get ifindex for %s: %s&quot;, __func__,=
 iface, strerror(errno));</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        return -ENOENT;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return ret;</span><br><span>     }</span><br><span> </span>=
<br><span>     req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));</span=
><br><span>@@ -703,7 +715,7 @@</span><br><span>     req=2En=2Enlmsg_type =
=3D RTM_SETLINK;</span><br><span> </span><br><span>     req=2Ei=2Eifi_famil=
y =3D AF_PACKET;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eq=2Ei=2Eifi_index =3D ifindex;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    req=2Ei=2Eifi_index =3D (int)ifindex;</span><br><span>     =
req=2Ei=2Eifi_change |=3D IFF_UP;</span><br><span>     if (up)</span><br><s=
pan>     {</span><br><span>@@ -711,7 +723,7 @@</span><br><span>     }</span=
><br><span>     else</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        req=2Ei=2Eifi_flags &amp;=3D ~IFF_UP;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        req=2Ei=2Eifi_flags=
 &amp;=3D ~(unsigned int)IFF_UP;</span><br><span>     }</span><br><span> </=
span><br><span>     msg(M_INFO, &quot;%s: set %s %s&quot;, __func__, iface,=
 up ? &quot;up&quot; : &quot;down&quot;);</span><br><span>@@ -723,14 +735,1=
3 @@</span><br><span> net_iface_mtu_set(const openvpn_net_ctx_t *ctx, const=
 char *iface, uint32_t mtu)</span><br><span> {</span><br><span>     struct =
sitnl_link_req req;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  int ifindex, ret =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int ret =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    uint32_t ifindex;</span><br><span> </span><br><span>     CLEAR(r=
eq);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    ifindex =3D if_nametoindex(iface);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (ifindex =3D=3D 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (get_ifindex(__func__, iface, &amp;ifindex) =
&lt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex f=
or %s&quot;, __func__, iface);</span><br><span>         return -1;</span><b=
r><span>     }</span><br><span> </span><br><span>@@ -739,7 +750,7 @@</span>=
<br><span>     req=2En=2Enlmsg_type =3D RTM_SETLINK;</span><br><span> </spa=
n><br><span>     req=2Ei=2Eifi_family =3D AF_PACKET;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    req=2Ei=2Eifi_index =3D ifindex;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2Ei=2Eifi_index =
=3D (int)ifindex;</span><br><span> </span><br><span>     SITNL_ADDATTR(&amp=
;req=2En, sizeof(req), IFLA_MTU, &amp;mtu, 4);</span><br><span> </span><br>=
<span>@@ -754,14 +765,13 @@</span><br><span> net_addr_ll_set(const openvpn_=
net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr)</span><br>=
<span> {</span><br><span>     struct sitnl_link_req req;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    int ifindex, ret =3D -1;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D -1;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t ifindex;</span><br=
><span> </span><br><span>     CLEAR(req);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_nametoindex(iface)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ifindex =3D=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (get_i=
findex(__func__, iface, &amp;ifindex) &lt; 0)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN | M_ERRNO=
, &quot;%s: rtnl: cannot get ifindex for %s&quot;, __func__, iface);</span>=
<br><span>         return -1;</span><br><span>     }</span><br><span> </spa=
n><br><span>@@ -770,7 +780,7 @@</span><br><span>     req=2En=2Enlmsg_type =
=3D RTM_SETLINK;</span><br><span> </span><br><span>     req=2Ei=2Eifi_famil=
y =3D AF_PACKET;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eq=2Ei=2Eifi_index =3D ifindex;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    req=2Ei=2Eifi_index =3D (int)ifindex;</span><br><span> </sp=
an><br><span>     SITNL_ADDATTR(&amp;req=2En, sizeof(req), IFLA_ADDRESS, ad=
dr, OPENVPN_ETH_ALEN);</span><br><span> </span><br><span>@@ -782,22 +792,19=
 @@</span><br><span> }</span><br><span> </span><br><span> static int</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_addr_set(uint16_t cmd,=
 uint16_t flags, int ifindex, sa_family_t af_family,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+sitnl_addr_set(uint16_t cmd, uint16_t fla=
gs, const char *iface, sa_family_t af_family,</span><br><span>             =
   const inet_address_t *local, const inet_address_t *remote, int prefixlen=
)</span><br><span> {</span><br><span>     struct sitnl_addr_req req;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t size;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D -EINVAL;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t size;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t ifindex;</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(r=
eq);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    req=2En=2Enlmsg_len =3D NLMSG_LENG=
TH(sizeof(req=2Ei));</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   req=2En=2Enlmsg_type =3D cmd;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    req=2En=2Enlmsg_flags =3D NLM_F_REQUEST | flags;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    req=2Ei=2Eifa_index =3D ifindex;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    ASSERT(af_family &lt;=3D UINT8_MAX)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    req=2Ei=2Eifa_fa=
mily =3D (uint8_t)af_family;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int ret =3D get_ifindex(__func__, iface, &amp;ifindex);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret &lt; 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return ret;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ret =3D -EINVAL; /* for SITNL_ADDATTR */</span><br=
><span> </span><br><span>     switch (af_family)</span><br><span>     {</sp=
an><br><span>@@ -814,10 +821,20 @@</span><br><span>             return -EIN=
VAL;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    CLEAR(req);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    req=2En=2Enlmsg_type =3D cmd;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2En=2Enlmsg=
_flags =3D NLM_F_REQUEST | flags;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eq=2Ei=2Eifa_index =3D ifindex;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ASSERT(af_family &lt;=3D UINT8_MAX);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    req=2Ei=2Eifa_family =3D (uint8_t)af_=
family;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>     /* if no prefixlen has been specified, assume host address */</sp=
an><br><span>     if (prefixlen =3D=3D 0)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        prefixlen =3D size * 8;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        prefixlen =
=3D (int)size * 8;</span><br><span>     }</span><br><span>     ASSERT(prefi=
xlen &lt;=3D UINT8_MAX);</span><br><span>     req=2Ei=2Eifa_prefixlen =3D (=
uint8_t)prefixlen;</span><br><span>@@ -852,76 +869,37 @@</span><br><span> s=
itnl_addr_ptp_add(sa_family_t af_family, const char *iface, const inet_addr=
ess_t *local,</span><br><span>                    const inet_address_t *rem=
ote)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    int ifindex;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (af_family)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        case AF_INET:</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        case AF_INET6:</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        default:</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            return -EINVAL;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!iface)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: passed NULL i=
nterface&quot;, __func__);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        return -EINVAL;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_nametoindex=
(iface);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ifind=
ex =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot=
;%s: cannot get ifindex for %s: %s&quot;, __func__, np(iface), strerror(err=
no));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return -=
ENOENT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE=
 | NLM_F_REPLACE, ifindex, af_family, local,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREAT=
E | NLM_F_REPLACE, iface, af_family, local,</span><br><span>               =
            remote, 0);</span><br><span> }</span><br><span> </span><br><spa=
n> static int</span><br><span> sitnl_addr_ptp_del(sa_family_t af_family, co=
nst char *iface, const inet_address_t *local)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    int ifindex;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    switch (af_family)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        case AF_INET:</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        case AF_INET6:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        default:</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            return -EINVAL=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (!iface)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    msg(M_WARN, &quot;%s: passed NULL interface&quot;, __func__);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        return -EINVAL;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    ifindex =3D if_nametoindex(iface);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (ifindex =3D=3D 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(M_WARN | M_ERRNO, &quot;%s: cannot get ifindex =
for %s&quot;, __func__, iface);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        return -ENOENT;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_addr_set=
(RTM_DELADDR, 0, ifindex, af_family, local, NULL, 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return sitnl_addr_set(RTM_DELADDR, 0,=
 iface, af_family, local, NULL, 0);</span><br><span> }</span><br><span> </s=
pan><br><span> static int</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-sitnl_route_set(uint16_t cmd, uint16_t flags, int ifindex, sa_family_t =
af_family, const void *dst,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+sitnl_route_set(uint16_t cmd, uint16_t flags, const char *iface, sa=
_family_t af_family, const void *dst,</span><br><span>                 int =
prefixlen, const void *gw, enum rt_class_t table, int metric,</span><br><sp=
an>                 enum rt_scope_t scope, unsigned char protocol, unsigned=
 char type)</span><br><span> {</span><br><span>     struct sitnl_route_req =
req;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D -=
1, size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret=
 =3D -1; /* for SITNL_ADDATTR */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    size_t size;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    uint32_t ifindex =3D 0;</span><br><span> </span><br><span>   =
  CLEAR(req);</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (iface)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 const int ifi_ret =3D get_ifindex(__func__, iface, &amp;ifindex);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (ifi_ret &lt; 0)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            return ifi_ret;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span>     switch (af_family)</span=
><br><span>     {</span><br><span>         case AF_INET:</span><br><span>@@=
 -986,64 +964,14 @@</span><br><span> static int</span><br><span> sitnl_addr=
_add(sa_family_t af_family, const char *iface, const inet_address_t *addr, =
int prefixlen)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    int ifindex;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (af=
_family)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET:</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET6:</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        default:</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            return -EINVAL;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!ifac=
e)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: passe=
d NULL interface&quot;, __func__);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        return -EINVAL;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_nam=
etoindex(iface);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (ifindex =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WAR=
N | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for %s&quot;, __func__, ifa=
ce);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return -E=
NOENT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE =
| NLM_F_REPLACE, ifindex, af_family, addr, NULL,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return sitnl_addr_set(RTM_NEWADDR, NLM_F_C=
REATE | NLM_F_REPLACE, iface, af_family, addr, NULL,</span><br><span>      =
                     prefixlen);</span><br><span> }</span><br><span> </span=
><br><span> static int</span><br><span> sitnl_addr_del(sa_family_t af_famil=
y, const char *iface, const inet_address_t *addr, int prefixlen)</span><br>=
<span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ifind=
ex;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    switch (af_family)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        case AF_INET:</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        case AF_INET6:</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     return -EINVAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (!iface)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(M_WARN, &quot;%s: passed NULL interface&quot;, =
__func__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret=
urn -EINVAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    ifindex =3D if_nametoindex(iface);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ifindex =3D=3D 0)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN | M_ERRNO, &quot;%s: r=
tnl: cannot get ifindex for %s&quot;, __func__, iface);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        return -ENOENT;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, addr, NULL, pr=
efixlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 sitnl_addr_set(RTM_DELADDR, 0, iface, af_family, addr, NULL, prefixlen);</=
span><br><span> }</span><br><span> </span><br><span> int</span><br><span>@@=
 -1190,17 +1118,6 @@</span><br><span>                 const void *gw, uint3=
2_t table, int metric)</span><br><span> {</span><br><span>     enum rt_scop=
e_t scope =3D RT_SCOPE_UNIVERSE;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    int ifindex =3D 0;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (i=
face)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        ifindex =3D if_nametoind=
ex(iface);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(ifindex =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg=
(M_WARN | M_ERRNO, &quot;%s: rtnl: can&#39;t get ifindex for %s&quot;, __fu=
nc__, iface);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    return -ENOENT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span> </span><br><span>     if (table =3D=3D 0)</span><br><span>     {</=
span><br><span>@@ -1212,7 +1129,7 @@</span><br><span>         scope =3D RT_=
SCOPE_LINK;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return sitnl_route_set(RTM_NEWROUTE, NL=
M_F_CREATE, ifindex, af_family, dst, prefixlen, gw,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return sitnl_route_set(RTM_NEWROUTE, =
NLM_F_CREATE, iface, af_family, dst, prefixlen, gw,</span><br><span>       =
                     table, metric, scope, RTPROT_BOOT, RTN_UNICAST);</span=
><br><span> }</span><br><span> </span><br><span>@@ -1277,24 +1194,12 @@</sp=
an><br><span> sitnl_route_del(const char *iface, sa_family_t af_family, con=
st inet_address_t *dst, int prefixlen,</span><br><span>                 con=
st inet_address_t *gw, uint32_t table, int metric)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ifindex =3D 0;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (iface)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        ifindex =3D if_nametoindex(iface);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (ifindex =3D=3D 0)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            msg(M_WARN | M_ERRNO, &quot;%s: rtnl: can=
&#39;t get ifindex for %s&quot;, __func__, iface);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            return -ENOENT;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span>     if (table =3D=3D 0)</span><br><span>     {</sp=
an><br><span>         table =3D RT_TABLE_MAIN;</span><br><span>     }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retur=
n sitnl_route_set(RTM_DELROUTE, 0, ifindex, af_family, dst, prefixlen, gw, =
table, metric,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn sitnl_route_set(RTM_DELROUTE, 0, iface, af_family, dst, prefixlen, gw=
, table, metric,</span><br><span>                            RT_SCOPE_NOWHE=
RE, 0, 0);</span><br><span> }</span><br><span> </span><br><span>@@ -1464,7 =
+1369,7 @@</span><br><span> net_iface_type(const openvpn_net_ctx_t *ctx, co=
nst char *iface, char type[IFACE_TYPE_LEN_MAX])</span><br><span> {</span><b=
r><span>     struct sitnl_link_req req =3D {};</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    int ifindex =3D if_nametoindex(iface);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    int ifindex =3D (int)if=
_nametoindex(iface);</span><br><span> </span><br><span>     if (!ifindex)</=
span><br><span>     {</span><br><span>@@ -1496,7 +1401,7 @@</span><br><span=
> net_iface_del(const openvpn_net_ctx_t *ctx, const char *iface)</span><br>=
<span> {</span><br><span>     struct sitnl_link_req req =3D {};</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    int ifindex =3D if_nametoinde=
x(iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int if=
index =3D (int)if_nametoindex(iface);</span><br><span> </span><br><span>   =
  if (!ifindex)</span><br><span>     {</span><br></pre><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail">chang=
e 2177</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2177 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: G=
ert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>

</body></html>
--+i30bWAWAQc=--


--===============2154748918265491172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2154748918265491172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2154748918265491172==--

