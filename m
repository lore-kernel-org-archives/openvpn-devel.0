Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF7F606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dXaVKpEK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Su49YySg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EG6b+KOg;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JgrApaVo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SXiYb5EwtDCUoKBdHbdyn+IB5hqQxDZAhjbSoJGspjY=; b=dXaVKpEKH7DvBdG07Zbeb9KQrP
	BrDpJ5smBhOhx+KXTn+6eJripO4f6y52MUbzbaQz+4b+22ft+OKjREMObj34csbw889F357VF+K7D
	N5lZLJayrA7/wQzda4vTBoomnI2c5pLCFOfeA/uPVt2nChGNRiRyFtSvIYymFkuXpsbk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSxqC-0000000057q-0frV;
	Mon, 16 Nov 2026 14:37:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSxqB-0000000057i-06CS
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:37:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PEOgJnOzHNifZwi2bFpsq0DW0kfYsx2DtyzerslW0VA=; b=Su49YySg65jWpQmPN8taoAhbLO
 M97R7vuRq1FiBOwARHFSD3t4U63rOkcJzDOhkY6eiFjPUww2p9bZ5+5R2e9GgTmR0kZBhJ1WydJGc
 nF+6fqx2JXBck697BBzTyiYtF5uUnDVx9B78RWMC6VWX8/jZ+nOCPeYWLx+GBIXtu0UA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PEOgJnOzHNifZwi2bFpsq0DW0kfYsx2DtyzerslW0VA=; b=EG6b+KOgvLrLxUBRkn5OE5ffd2
 SgDkIPK1skdVRpV0CcqGpo0sWBFFDhDX5Pmid6rxEXIOAnvfBIGNeRhtvjpXkDqbQ41dPv+X/aEqK
 kFEzTDEFdfBR1pzLzrZ39dTfEOIcVxHnaZHLmUSKaG15x2/dmZnJJF3ofgc0rEr1CHZs=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSxq7-000000000SP-30YE for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:37:50 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so1677053f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 06:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794839861; x=1795444661; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PEOgJnOzHNifZwi2bFpsq0DW0kfYsx2DtyzerslW0VA=;
 b=JgrApaVonIYRTTjWSmyC+VuA2RABop3L7AHONGeR8+t7Z7SqedFwjNQk7169ZUsbEh
 LUPZNW0vr3oGtbSKQK0+sF4toAy6QsCZ3uKfXhi8FJ4LipMcj6VAW/y5yWRN1hwG6k6X
 Li+mxkDc+DBI9iCbrjESusDkwfWcnMqTRQAmJWthqsCi/lALZapavUeDFEFBswDU6e8t
 dHCnQQ8c7Y2qPvfVg9kYKYX7eq643L7QryODOHjojL1/Lgz85TpOdkPEHdEmYl73m2at
 CiztfPiuDRRMQtV4dvjr6QaPKS+HiknPA47miUTpPOcaBIATcwCaHPBl8X8clHWaOvOD
 WlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794839861; x=1795444661;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PEOgJnOzHNifZwi2bFpsq0DW0kfYsx2DtyzerslW0VA=;
 b=u08ROIeN1BP3V4KiCpgXpJiZlW6QC1VaCBSred4OU9lHMkUAMDGMsHwti3BeNeWb29
 ZK3OetFHQA5wVF8yLJgNbjSfWjLQCHf+ViMtK4RpH9iZ+du9jvwV6URcLuI/qejVXqON
 bB/IsN+LzSHriJ671BAS9lMPa64/y33Jpuv0ExMnzgI+F9RkIK6ajYPWP54fwf8uRLkR
 CWdm1aCHm8CdPkhruA7Xz0waLqNH8unCrZrhwjAQT8vlOMKxLPFFbm4J2yF5OxYcYSSc
 o8KwZcpF6gLUri/4HBViKcwVf3M/W9Whysjsqg0xSMhYdLiYwKoguPAndQnh/HeoN6ND
 RY2A==
X-Gm-Message-State: APuU4Z8n4O52NY/p7C1o0IFsbqjwwf9RzAqCAJhUT9oh+N+2WssGvqTe
 UpNaVV38vDx5IJ3jDIGmiRxIbXDq9rPqDFZnTq67Zkyq75wQmYV9JJgBlMdDxcDcNdNxbEHpf+r
 5vpOzRqfskz9DA48Bhp3EwnqWvYuhEDpNOl3GTUYwAZmIyUnlFN5hfCKy7EF5ICA7ppEx+0BeLG
 3xnwvfjg==
X-Gm-Gg: AZFdTZdWwkKepN9BTvgNKZ+017wLlq3x1SLFVAVtWRdpDI7QCzQiNzIxfYkpnGTodb1
 M2v7hlOIKJUi3EY5x+x3KS4VIlKkwxCEk/ejfC5nvb6lUC+zFH3bYOxVXOWWHDU/+bfPAfma7hZ
 clGOEOAc8iUJMgEIVpBVaPVKs/INVrhJKURv4VhuvB2ecnNdj52nQmLg1LP1Zd9c4YR0BNk4OIQ
 DhDYBpX/6giX4bsdJBvk6Rh7LAWpKq+k9hNVyzfhzmECd1VHdh7rKi8QjF+Cqt0F7NGg1RXKLFs
 PqXwSS4wnZKKTI1XhWYo8m0tKHNuA2hbWw+COqJUaGCTr5l3TOuGOfGDoi17StMS7pgSlsoachf
 iPKG0J7eChRQhP/bzZui5RMnLtaEBGjAgEWCZbJibuLGPyIfrd2eDqAab5lLRFE6JdgGJi/oJXF
 vjylKpN0NFtxLxiXBXI8afY4bMwu55dNvncOiv3EpHQn2F6uuKt4W+mxaYH+KPNTesaKlvaiN35
 JlEiIkWXExoXtoPJxfKROpggJ/Kg5Tj6NSWsHeAZsQm1DUU6sEF3iDIh/n/E8Gtf2axur7VXKvd
 oSHGCkZTyDZTDMizggRcKavWib3OdTcJF13mrWJHnBmYQ0iNmZQKx09ZBx46HuVZWFT2WNDh8zy
 lhlZQJWCMs74ZXmtPIaEpOFQ49qj7zsbf04ePjRQFHW6PAHCJB0tXx15k4tmVHDCXgxzR0lyFe7
 J98jLHyDbIewcVPG4=
X-Received: by 2002:a5d:5c03:0:b0:492:9630:6a71 with SMTP id
 ffacd0b85a97d-49c6fc9dbe9mr26747950f8f.1.1794839860723; 
 Mon, 16 Nov 2026 06:37:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c8a77sm22946447f8f.49.2026.11.16.06.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:37:39 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 14:37:35 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118
X-Gerrit-Change-Number: 2177
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2177?usp=email>
X-Gerrit-Commit: 2abd9b62969ee9b0547291057009cfd7b4f7d7db
In-Reply-To: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
References: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDE3MzIyMDAwLkk2ZjVjYTUzZDQyODhiMDkyMTYxMGY3YTNmODRhZDU1ZDJhYjQ5MTE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1e5da0b662660509e75ecb8fd2396ab97a3e9584-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSxq7-000000000SP-30YE
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
Content-Type: multipart/mixed; boundary="===============6874440493317239168=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6874440493317239168==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B9jKFbc+PWs="; charset=UTF-8

--B9jKFbc+PWs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, Fran=
k Lichtenheld=2E

Hello Antonio Quartulli, Arne Schwabe, Gert Doering, R=C4=
=83zvan Cojocaru, 

I'd like you to reexamine a change=2E Please visit

   =
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail

to look at th=
e new patch set (#4)=2E

The change is no longer submittable: checks~Checks=
SubmitRule is unsatisfied now=2E


Change subject: networking_sitnl: Reduce=
 boilerplate code for parameter checks
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

networking_sitnl: Reduce boilerplate code for par=
ameter checks

Also removes some inconsistencies and some
sign conversion w=
arnings=2E

Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118
Signed-off=
-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/networki=
ng_sitnl=2Ec
1 file changed, 74 insertions(+), 169 deletions(-)


  git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/77/2177/4

diff -=
-git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
=
index d5ec6bb=2E=2Eb7c0f58 100644
--- a/src/openvpn/networking_sitnl=2Ec
++=
+ b/src/openvpn/networking_sitnl=2Ec
@@ -677,25 +677,37 @@
 
 #ifdef ENABLE=
_SITNL
 
+static int
+get_ifindex(const char *func, const char *iface, uint=
32_t *ifindex)
+{
+    if (!iface)
+    {
+        msg(M_WARN, "%s: passed =
NULL interface", func);
+        return -EINVAL;
+    }
+
+    *ifindex =3D=
 if_nametoindex(iface);
+    if (*ifindex =3D=3D 0)
+    {
+        msg(M_W=
ARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", func, iface);
+      =
  return -ENOENT;
+    }
+    return 0;
+}
+
+
 int
 net_iface_up(const ope=
nvpn_net_ctx_t *ctx, const char *iface, bool up)
 {
     struct sitnl_link_=
req req;
-    int ifindex;
+    uint32_t ifindex;
 
     CLEAR(req);
 
-   =
 if (!iface)
+    const int ret =3D get_ifindex(__func__, iface, &ifindex);=

+    if (ret < 0)
     {
-        msg(M_WARN, "%s: passed NULL interface",=
 __func__);
-        return -EINVAL;
-    }
-
-    ifindex =3D if_nametoind=
ex(iface);
-    if (ifindex =3D=3D 0)
-    {
-        msg(M_WARN, "%s: rtnl=
: cannot get ifindex for %s: %s", __func__, iface, strerror(errno));
-     =
   return -ENOENT;
+        return ret;
     }
 
     req=2En=2Enlmsg_len =
=3D NLMSG_LENGTH(sizeof(req=2Ei));
@@ -703,7 +715,7 @@
     req=2En=2Enlmsg=
_type =3D RTM_SETLINK;
 
     req=2Ei=2Eifi_family =3D AF_PACKET;
-    req=
=2Ei=2Eifi_index =3D ifindex;
+    req=2Ei=2Eifi_index =3D (int)ifindex;
  =
   req=2Ei=2Eifi_change |=3D IFF_UP;
     if (up)
     {
@@ -711,7 +723,7 @=
@
     }
     else
     {
-        req=2Ei=2Eifi_flags &=3D ~IFF_UP;
+     =
   req=2Ei=2Eifi_flags &=3D ~(unsigned int)IFF_UP;
     }
 
     msg(M_INFO=
, "%s: set %s %s", __func__, iface, up ? "up" : "down");
@@ -723,14 +735,13=
 @@
 net_iface_mtu_set(const openvpn_net_ctx_t *ctx, const char *iface, uin=
t32_t mtu)
 {
     struct sitnl_link_req req;
-    int ifindex, ret =3D -1;=

+    int ret =3D -1;
+    uint32_t ifindex;
 
     CLEAR(req);
 
-    ifin=
dex =3D if_nametoindex(iface);
-    if (ifindex =3D=3D 0)
+    if (get_ifin=
dex(__func__, iface, &ifindex) < 0)
     {
-        msg(M_WARN | M_ERRNO, "=
%s: rtnl: cannot get ifindex for %s", __func__, iface);
         return -1;=

     }
 
@@ -739,7 +750,7 @@
     req=2En=2Enlmsg_type =3D RTM_SETLINK;
 
=
     req=2Ei=2Eifi_family =3D AF_PACKET;
-    req=2Ei=2Eifi_index =3D ifind=
ex;
+    req=2Ei=2Eifi_index =3D (int)ifindex;
 
     SITNL_ADDATTR(&req=2E=
n, sizeof(req), IFLA_MTU, &mtu, 4);
 
@@ -754,14 +765,13 @@
 net_addr_ll_se=
t(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_t *=
addr)
 {
     struct sitnl_link_req req;
-    int ifindex, ret =3D -1;
+   =
 int ret =3D -1;
+    uint32_t ifindex;
 
     CLEAR(req);
 
-    ifindex =
=3D if_nametoindex(iface);
-    if (ifindex =3D=3D 0)
+    if (get_ifindex(=
__func__, iface, &ifindex) < 0)
     {
-        msg(M_WARN | M_ERRNO, "%s: =
rtnl: cannot get ifindex for %s", __func__, iface);
         return -1;
   =
  }
 
@@ -770,7 +780,7 @@
     req=2En=2Enlmsg_type =3D RTM_SETLINK;
 
    =
 req=2Ei=2Eifi_family =3D AF_PACKET;
-    req=2Ei=2Eifi_index =3D ifindex;
=
+    req=2Ei=2Eifi_index =3D (int)ifindex;
 
     SITNL_ADDATTR(&req=2En, s=
izeof(req), IFLA_ADDRESS, addr, OPENVPN_ETH_ALEN);
 
@@ -782,22 +792,19 @@
=
 }
 
 static int
-sitnl_addr_set(uint16_t cmd, uint16_t flags, int ifindex,=
 sa_family_t af_family,
+sitnl_addr_set(uint16_t cmd, uint16_t flags, const=
 char *iface, sa_family_t af_family,
                const inet_address_t *=
local, const inet_address_t *remote, int prefixlen)
 {
     struct sitnl_ad=
dr_req req;
-    uint32_t size;
-    int ret =3D -EINVAL;
+    size_t size;=

+    uint32_t ifindex;
 
-    CLEAR(req);
-
-    req=2En=2Enlmsg_len =3D N=
LMSG_LENGTH(sizeof(req=2Ei));
-    req=2En=2Enlmsg_type =3D cmd;
-    req=
=2En=2Enlmsg_flags =3D NLM_F_REQUEST | flags;
-
-    req=2Ei=2Eifa_index =
=3D ifindex;
-    ASSERT(af_family <=3D UINT8_MAX);
-    req=2Ei=2Eifa_fami=
ly =3D (uint8_t)af_family;
+    int ret =3D get_ifindex(__func__, iface, &i=
findex);
+    if (ret < 0)
+    {
+        return ret;
+    }
+    ret =3D =
-EINVAL; /* for SITNL_ADDATTR */
 
     switch (af_family)
     {
@@ -814,1=
0 +821,20 @@
             return -EINVAL;
     }
 
+    CLEAR(req);
+
+    =
req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));
+    req=2En=2Enlmsg=
_type =3D cmd;
+    req=2En=2Enlmsg_flags =3D NLM_F_REQUEST | flags;
+
+   =
 req=2Ei=2Eifa_index =3D ifindex;
+    ASSERT(af_family <=3D UINT8_MAX);
+ =
   req=2Ei=2Eifa_family =3D (uint8_t)af_family;
+
     /* if no prefixlen h=
as been specified, assume host address */
     if (prefixlen =3D=3D 0)
    =
 {
-        prefixlen =3D size * 8;
+        prefixlen =3D (int)size * 8;
 =
    }
     ASSERT(prefixlen <=3D UINT8_MAX);
     req=2Ei=2Eifa_prefixlen =
=3D (uint8_t)prefixlen;
@@ -852,76 +869,37 @@
 sitnl_addr_ptp_add(sa_family=
_t af_family, const char *iface, const inet_address_t *local,
             =
       const inet_address_t *remote)
 {
-    int ifindex;
-
-    switch (af=
_family)
-    {
-        case AF_INET:
-        case AF_INET6:
-           =
 break;
-
-        default:
-            return -EINVAL;
-    }
-
-    if (=
!iface)
-    {
-        msg(M_WARN, "%s: passed NULL interface", __func__);=

-        return -EINVAL;
-    }
-
-    ifindex =3D if_nametoindex(iface);
=
-    if (ifindex =3D=3D 0)
-    {
-        msg(M_WARN, "%s: cannot get ifin=
dex for %s: %s", __func__, np(iface), strerror(errno));
-        return -EN=
OENT;
-    }
-
-    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F=
_REPLACE, ifindex, af_family, local,
+    return sitnl_addr_set(RTM_NEWADDR=
, NLM_F_CREATE | NLM_F_REPLACE, iface, af_family, local,
                  =
         remote, 0);
 }
 
 static int
 sitnl_addr_ptp_del(sa_family_t af_fa=
mily, const char *iface, const inet_address_t *local)
 {
-    int ifindex;
=
-
-    switch (af_family)
-    {
-        case AF_INET:
-        case AF_IN=
ET6:
-            break;
-
-        default:
-            return -EINVAL;
-=
    }
-
-    if (!iface)
-    {
-        msg(M_WARN, "%s: passed NULL inter=
face", __func__);
-        return -EINVAL;
-    }
-
-    ifindex =3D if_nam=
etoindex(iface);
-    if (ifindex =3D=3D 0)
-    {
-        msg(M_WARN | M_=
ERRNO, "%s: cannot get ifindex for %s", __func__, iface);
-        return -=
ENOENT;
-    }
-
-    return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_fam=
ily, local, NULL, 0);
+    return sitnl_addr_set(RTM_DELADDR, 0, iface, af_=
family, local, NULL, 0);
 }
 
 static int
-sitnl_route_set(uint16_t cmd, ui=
nt16_t flags, int ifindex, sa_family_t af_family, const void *dst,
+sitnl_r=
oute_set(uint16_t cmd, uint16_t flags, const char *iface, sa_family_t af_fa=
mily, const void *dst,
                 int prefixlen, const void *gw, enum=
 rt_class_t table, int metric,
                 enum rt_scope_t scope, unsi=
gned char protocol, unsigned char type)
 {
     struct sitnl_route_req req;=

-    int ret =3D -1, size;
+    int ret =3D -1; /* for SITNL_ADDATTR */
+ =
   size_t size;
+    uint32_t ifindex =3D 0;
 
     CLEAR(req);
 
+    if (=
iface)
+    {
+        const int ifi_ret =3D get_ifindex(__func__, iface, &=
ifindex);
+        if (ifi_ret < 0)
+        {
+            return ifi_ret;=

+        }
+    }
+
     switch (af_family)
     {
         case AF_INET:
=
@@ -986,64 +964,14 @@
 static int
 sitnl_addr_add(sa_family_t af_family, co=
nst char *iface, const inet_address_t *addr, int prefixlen)
 {
-    int ifi=
ndex;
-
-    switch (af_family)
-    {
-        case AF_INET:
-        case=
 AF_INET6:
-            break;
-
-        default:
-            return -EIN=
VAL;
-    }
-
-    if (!iface)
-    {
-        msg(M_WARN, "%s: passed NULL=
 interface", __func__);
-        return -EINVAL;
-    }
-
-    ifindex =3D =
if_nametoindex(iface);
-    if (ifindex =3D=3D 0)
-    {
-        msg(M_WAR=
N | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__, iface);
-    =
    return -ENOENT;
-    }
-
-    return sitnl_addr_set(RTM_NEWADDR, NLM_F_=
CREATE | NLM_F_REPLACE, ifindex, af_family, addr, NULL,
+    return sitnl_a=
ddr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, iface, af_family, addr, =
NULL,
                           prefixlen);
 }
 
 static int
 sitnl_addr_d=
el(sa_family_t af_family, const char *iface, const inet_address_t *addr, in=
t prefixlen)
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
-        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for =
%s", __func__, iface);
-        return -ENOENT;
-    }
-
-    return sitnl_=
addr_set(RTM_DELADDR, 0, ifindex, af_family, addr, NULL, prefixlen);
+    r=
eturn sitnl_addr_set(RTM_DELADDR, 0, iface, af_family, addr, NULL, prefixle=
n);
 }
 
 int
@@ -1190,17 +1118,6 @@
                 const void *gw, uint3=
2_t table, int metric)
 {
     enum rt_scope_t scope =3D RT_SCOPE_UNIVERSE;=

-    int ifindex =3D 0;
-
-    if (iface)
-    {
-        ifindex =3D if_n=
ametoindex(iface);
-        if (ifindex =3D=3D 0)
-        {
-            m=
sg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifindex for %s", __func__, iface)=
;
-            return -ENOENT;
-        }
-    }
 
     if (table =3D=3D 0)=

     {
@@ -1212,7 +1129,7 @@
         scope =3D RT_SCOPE_LINK;
     }
 
- =
   return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, ifindex, af_family, d=
st, prefixlen, gw,
+    return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, =
iface, af_family, dst, prefixlen, gw,
                            table, me=
tric, scope, RTPROT_BOOT, RTN_UNICAST);
 }
 
@@ -1277,24 +1194,12 @@
 sitnl=
_route_del(const char *iface, sa_family_t af_family, const inet_address_t *=
dst, int prefixlen,
                 const inet_address_t *gw, uint32_t tab=
le, int metric)
 {
-    int ifindex =3D 0;
-
-    if (iface)
-    {
-      =
  ifindex =3D if_nametoindex(iface);
-        if (ifindex =3D=3D 0)
-      =
  {
-            msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifindex for %s"=
, __func__, iface);
-            return -ENOENT;
-        }
-    }
-
     i=
f (table =3D=3D 0)
     {
         table =3D RT_TABLE_MAIN;
     }
 
-    r=
eturn sitnl_route_set(RTM_DELROUTE, 0, ifindex, af_family, dst, prefixlen, =
gw, table, metric,
+    return sitnl_route_set(RTM_DELROUTE, 0, iface, af_f=
amily, dst, prefixlen, gw, table, metric,
                            RT_SC=
OPE_NOWHERE, 0, 0);
 }
 
@@ -1464,7 +1369,7 @@
 net_iface_type(const openvp=
n_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX])
 {
    =
 struct sitnl_link_req req =3D {};
-    int ifindex =3D if_nametoindex(ifac=
e);
+    int ifindex =3D (int)if_nametoindex(iface);
 
     if (!ifindex)
 =
    {
@@ -1496,7 +1401,7 @@
 net_iface_del(const openvpn_net_ctx_t *ctx, co=
nst char *iface)
 {
     struct sitnl_link_req req =3D {};
-    int ifindex=
 =3D if_nametoindex(iface);
+    int ifindex =3D (int)if_nametoindex(iface)=
;
 
     if (!ifindex)
     {

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2177?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118
Gerrit-Change-Num=
ber: 2177
Gerrit-PatchSet: 4
Gerrit-Owner: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Ge=
rrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: G=
ert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=2Ec=
om>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Atte=
ntion: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--B9jKFbc+PWs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, Frank Lichtenheld=2E=
 </p>
<p>Frank Lichtenheld <strong>uploaded patch set #4</strong> to this c=
hange=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?u=
sp=3Demail">View Change</a></p><p>The change is no longer submittable: chec=
ks~ChecksSubmitRule is unsatisfied now=2E</p><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">networking_sitnl=
: Reduce boilerplate code for parameter checks<br><br>Also removes some inc=
onsistencies and some<br>sign conversion warnings=2E<br><br>Change-Id: I6f5=
ca53d4288b0921610f7a3f84ad55d2ab49118<br>Signed-off-by: Frank Lichtenheld &=
lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/networking_sitnl=2Ec=
<br>1 file changed, 74 insertions(+), 169 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/77/=
2177/4</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/=
networking_sitnl=2Ec</span><br><span>index d5ec6bb=2E=2Eb7c0f58 100644</spa=
n><br><span>--- a/src/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/sr=
c/openvpn/networking_sitnl=2Ec</span><br><span>@@ -677,25 +677,37 @@</span>=
<br><span> </span><br><span> #ifdef ENABLE_SITNL</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+get_ifindex(const char *func, const c=
har *iface, uint32_t *ifindex)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!iface)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot=
;%s: passed NULL interface&quot;, func);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return -EINVAL;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *ifi=
ndex =3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (*ifindex =3D=3D 0)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for %=
s&quot;, func, iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return -ENOENT;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> net_iface_u=
p(const openvpn_net_ctx_t *ctx, const char *iface, bool up)</span><br><span=
> {</span><br><span>     struct sitnl_link_req req;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int ifindex;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    uint32_t ifindex;</span><br><span> </span>=
<br><span>     CLEAR(req);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (!iface)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const int ret =3D get_ifindex(__func__, iface, &amp;=
ifindex);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (re=
t &lt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        msg(M_WARN, &quot;%s: passed NULL interface&quot;, __fun=
c__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return -=
EINVAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    ifindex =3D if_nametoindex(iface);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (ifindex =3D=3D 0)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: rtnl: cannot get=
 ifindex for %s: %s&quot;, __func__, iface, strerror(errno));</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        return -ENOENT;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return ret;</span><br><=
span>     }</span><br><span> </span><br><span>     req=2En=2Enlmsg_len =3D =
NLMSG_LENGTH(sizeof(req=2Ei));</span><br><span>@@ -703,7 +715,7 @@</span><b=
r><span>     req=2En=2Enlmsg_type =3D RTM_SETLINK;</span><br><span> </span>=
<br><span>     req=2Ei=2Eifi_family =3D AF_PACKET;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    req=2Ei=2Eifi_index =3D ifindex;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    req=2Ei=2Eifi_index =3D (=
int)ifindex;</span><br><span>     req=2Ei=2Eifi_change |=3D IFF_UP;</span><=
br><span>     if (up)</span><br><span>     {</span><br><span>@@ -711,7 +723=
,7 @@</span><br><span>     }</span><br><span>     else</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        req=2Ei=2Ei=
fi_flags &amp;=3D ~IFF_UP;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        req=2Ei=2Eifi_flags &amp;=3D ~(unsigned int)IFF_UP;</span><b=
r><span>     }</span><br><span> </span><br><span>     msg(M_INFO, &quot;%s:=
 set %s %s&quot;, __func__, iface, up ? &quot;up&quot; : &quot;down&quot;);=
</span><br><span>@@ -723,14 +735,13 @@</span><br><span> net_iface_mtu_set(c=
onst openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)</span><br><sp=
an> {</span><br><span>     struct sitnl_link_req req;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int ifindex, ret =3D -1;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D -1;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    uint32_t ifindex;</span><br><s=
pan> </span><br><span>     CLEAR(req);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_nametoindex(iface);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ifindex =3D=3D =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (get_ifind=
ex(__func__, iface, &amp;ifindex) &lt; 0)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN | M_ERRNO, &q=
uot;%s: rtnl: cannot get ifindex for %s&quot;, __func__, iface);</span><br>=
<span>         return -1;</span><br><span>     }</span><br><span> </span><b=
r><span>@@ -739,7 +750,7 @@</span><br><span>     req=2En=2Enlmsg_type =3D R=
TM_SETLINK;</span><br><span> </span><br><span>     req=2Ei=2Eifi_family =3D=
 AF_PACKET;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    req=2E=
i=2Eifi_index =3D ifindex;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    req=2Ei=2Eifi_index =3D (int)ifindex;</span><br><span> </span><b=
r><span>     SITNL_ADDATTR(&amp;req=2En, sizeof(req), IFLA_MTU, &amp;mtu, 4=
);</span><br><span> </span><br><span>@@ -754,14 +765,13 @@</span><br><span>=
 net_addr_ll_set(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *i=
face, uint8_t *addr)</span><br><span> {</span><br><span>     struct sitnl_l=
ink_req req;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i=
findex, ret =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int ret =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    uint32_t ifindex;</span><br><span> </span><br><span>     CLEAR(req);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
index =3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (ifindex =3D=3D 0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (get_ifindex(__func__, iface, &amp;ifindex) &lt; 0)=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for %s&q=
uot;, __func__, iface);</span><br><span>         return -1;</span><br><span=
>     }</span><br><span> </span><br><span>@@ -770,7 +780,7 @@</span><br><sp=
an>     req=2En=2Enlmsg_type =3D RTM_SETLINK;</span><br><span> </span><br><=
span>     req=2Ei=2Eifi_family =3D AF_PACKET;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    req=2Ei=2Eifi_index =3D ifindex;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    req=2Ei=2Eifi_index =3D (int)i=
findex;</span><br><span> </span><br><span>     SITNL_ADDATTR(&amp;req=2En, =
sizeof(req), IFLA_ADDRESS, addr, OPENVPN_ETH_ALEN);</span><br><span> </span=
><br><span>@@ -782,22 +792,19 @@</span><br><span> }</span><br><span> </span=
><br><span> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-sitnl_addr_set(uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af_f=
amily,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_addr_se=
t(uint16_t cmd, uint16_t flags, const char *iface, sa_family_t af_family,</=
span><br><span>                const inet_address_t *local, const inet_addr=
ess_t *remote, int prefixlen)</span><br><span> {</span><br><span>     struc=
t sitnl_addr_req req;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    uint32_t size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 int ret =3D -EINVAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    size_t size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   uint32_t ifindex;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    CLEAR(req);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    req=2E=
n=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    req=2En=2Enlmsg_type =3D cmd;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    req=2En=2Enlmsg_flags =3D NLM_F_=
REQUEST | flags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    req=2Ei=2Eifa_index =
=3D ifindex;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSER=
T(af_family &lt;=3D UINT8_MAX);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    req=2Ei=2Eifa_family =3D (uint8_t)af_family;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D get_ifindex(__func__=
, iface, &amp;ifindex);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D -EINVAL; /* =
for SITNL_ADDATTR */</span><br><span> </span><br><span>     switch (af_fami=
ly)</span><br><span>     {</span><br><span>@@ -814,10 +821,20 @@</span><br>=
<span>             return -EINVAL;</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(req);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    req=2En=2Enlmsg_len =3D NLMSG_LENGTH(=
sizeof(req=2Ei));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  req=2En=2Enlmsg_type =3D cmd;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    req=2En=2Enlmsg_flags =3D NLM_F_REQUEST | flags;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    req=2Ei=2Eifa_index =3D ifindex;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(af_family &lt;=3D UIN=
T8_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2Ei=
=2Eifa_family =3D (uint8_t)af_family;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span>     /* if no prefixlen has been specifi=
ed, assume host address */</span><br><span>     if (prefixlen =3D=3D 0)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      prefixlen =3D size * 8;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        prefixlen =3D (int)size * 8;</span><br><span>     }</span=
><br><span>     ASSERT(prefixlen &lt;=3D UINT8_MAX);</span><br><span>     r=
eq=2Ei=2Eifa_prefixlen =3D (uint8_t)prefixlen;</span><br><span>@@ -852,76 +=
869,37 @@</span><br><span> sitnl_addr_ptp_add(sa_family_t af_family, const =
char *iface, const inet_address_t *local,</span><br><span>                 =
   const inet_address_t *remote)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int ifindex;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    switch (af_family)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c=
ase AF_INET:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c=
ase AF_INET6:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        default:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            return -EINVAL;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (!iface)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_W=
ARN, &quot;%s: passed NULL interface&quot;, __func__);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        return -EINVAL;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  ifindex =3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (ifindex =3D=3D 0)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        msg(M_WARN, &quot;%s: cannot get ifindex for %s: %s&quot;, __fun=
c__, np(iface), strerror(errno));</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        return -ENOENT;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_addr_s=
et(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family, local,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_addr_=
set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, iface, af_family, local,</sp=
an><br><span>                           remote, 0);</span><br><span> }</spa=
n><br><span> </span><br><span> static int</span><br><span> sitnl_addr_ptp_d=
el(sa_family_t af_family, const char *iface, const inet_address_t *local)</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
int ifindex;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    switch (af_family)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        case AF_INET:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        case AF_INET6:</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        default:</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            return -EINVAL;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!iface)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: passed NULL inter=
face&quot;, __func__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        return -EINVAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_nametoindex(ifa=
ce);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ifindex =
=3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN | M_ERRNO=
, &quot;%s: cannot get ifindex for %s&quot;, __func__, iface);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        return -ENOENT;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, local, =
NULL, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 sitnl_addr_set(RTM_DELADDR, 0, iface, af_family, local, NULL, 0);</span><b=
r><span> }</span><br><span> </span><br><span> static int</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-sitnl_route_set(uint16_t cmd, uint16_t f=
lags, int ifindex, sa_family_t af_family, const void *dst,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+sitnl_route_set(uint16_t cmd, uint16=
_t flags, const char *iface, sa_family_t af_family, const void *dst,</span>=
<br><span>                 int prefixlen, const void *gw, enum rt_class_t t=
able, int metric,</span><br><span>                 enum rt_scope_t scope, u=
nsigned char protocol, unsigned char type)</span><br><span> {</span><br><sp=
an>     struct sitnl_route_req req;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    int ret =3D -1, size;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int ret =3D -1; /* for SITNL_ADDATTR */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    size_t size;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    uint32_t ifindex =3D 0;</span>=
<br><span> </span><br><span>     CLEAR(req);</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (iface)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        const int ifi_ret =3D get_ifindex(__func__,=
 iface, &amp;ifindex);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (ifi_ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            return ifi_ret;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n>     switch (af_family)</span><br><span>     {</span><br><span>         c=
ase AF_INET:</span><br><span>@@ -986,64 +964,14 @@</span><br><span> static =
int</span><br><span> sitnl_addr_add(sa_family_t af_family, const char *ifac=
e, const inet_address_t *addr, int prefixlen)</span><br><span> {</span><br>=
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
, 100%, 40%);">-        msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get if=
index for %s&quot;, __func__, iface);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return -ENOENT;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_ad=
dr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family, addr,=
 NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return si=
tnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, iface, af_family, a=
ddr, NULL,</span><br><span>                           prefixlen);</span><br=
><span> }</span><br><span> </span><br><span> static int</span><br><span> si=
tnl_addr_del(sa_family_t af_family, const char *iface, const inet_address_t=
 *addr, int prefixlen)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    int ifindex;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sw=
itch (af_family)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET:=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET6=
:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        default:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            return -EINVAL;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (!iface)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;=
%s: passed NULL interface&quot;, __func__);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        return -EINVAL;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =
=3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (ifindex =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for %s&quot;, __f=
unc__, iface);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 return -ENOENT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    return sitnl_addr_set(RTM_DELADDR, 0, =
ifindex, af_family, addr, NULL, prefixlen);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return sitnl_addr_set(RTM_DELADDR, 0, iface, af=
_family, addr, NULL, prefixlen);</span><br><span> }</span><br><span> </span=
><br><span> int</span><br><span>@@ -1190,17 +1118,6 @@</span><br><span>    =
             const void *gw, uint32_t table, int metric)</span><br><span> {=
</span><br><span>     enum rt_scope_t scope =3D RT_SCOPE_UNIVERSE;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    int ifindex =3D 0;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (iface)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        ifindex =3D if_nametoindex(iface);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (ifindex =3D=3D 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(M_WARN | M_ERRNO, &quot;%s: rtnl: can&#=
39;t get ifindex for %s&quot;, __func__, iface);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            return -ENOENT;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span> </span><br><span>     if (table=
 =3D=3D 0)</span><br><span>     {</span><br><span>@@ -1212,7 +1129,7 @@</sp=
an><br><span>         scope =3D RT_SCOPE_LINK;</span><br><span>     }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retur=
n sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, ifindex, af_family, dst, pref=
ixlen, gw,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, iface, af_family, dst, prefix=
len, gw,</span><br><span>                            table, metric, scope, =
RTPROT_BOOT, RTN_UNICAST);</span><br><span> }</span><br><span> </span><br><=
span>@@ -1277,24 +1194,12 @@</span><br><span> sitnl_route_del(const char *i=
face, sa_family_t af_family, const inet_address_t *dst, int prefixlen,</spa=
n><br><span>                 const inet_address_t *gw, uint32_t table, int =
metric)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    int ifindex =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (iface)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        ifindex =3D if_nametoindex(ifa=
ce);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ifind=
ex =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WAR=
N | M_ERRNO, &quot;%s: rtnl: can&#39;t get ifindex for %s&quot;, __func__, =
iface);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            re=
turn -ENOENT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (table =3D=
=3D 0)</span><br><span>     {</span><br><span>         table =3D RT_TABLE_M=
AIN;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return sitnl_route_set(RTM_DELROUTE, 0, ifindex=
, af_family, dst, prefixlen, gw, table, metric,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return sitnl_route_set(RTM_DELROUTE, 0, ifa=
ce, af_family, dst, prefixlen, gw, table, metric,</span><br><span>         =
                   RT_SCOPE_NOWHERE, 0, 0);</span><br><span> }</span><br><s=
pan> </span><br><span>@@ -1464,7 +1369,7 @@</span><br><span> net_iface_type=
(const openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_=
MAX])</span><br><span> {</span><br><span>     struct sitnl_link_req req =3D=
 {};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ifindex =
=3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int ifindex =3D (int)if_nametoindex(iface);</span><br><span> </s=
pan><br><span>     if (!ifindex)</span><br><span>     {</span><br><span>@@ =
-1496,7 +1401,7 @@</span><br><span> net_iface_del(const openvpn_net_ctx_t *=
ctx, const char *iface)</span><br><span> {</span><br><span>     struct sitn=
l_link_req req =3D {};</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    int ifindex =3D if_nametoindex(iface);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int ifindex =3D (int)if_nametoindex(iface);</sp=
an><br><span> </span><br><span>     if (!ifindex)</span><br><span>     {</s=
pan><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2177?usp=3Demail">change 2177</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2177?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2=
ab49118 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2177 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt=
;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@=
mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>

</body></html>
--B9jKFbc+PWs=--


--===============6874440493317239168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6874440493317239168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6874440493317239168==--

