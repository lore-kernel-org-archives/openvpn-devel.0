Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD57BCD98C7
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oFFfWwljupilFRopioVe+inIUsGAT8w/7mqgpPiMMHU=; b=GuutTsS05vQ7NGv3dEAbsAPgYB
	ojCvPM1Zd5Mb3qms1ydcYsSXY3sgR/Z2QrYQ/Pn+sAOUW7mKrD7gkB4LiYf0wLFJHCztazikv3RZp
	0o0BB4bno8dYCL1TFYkvOQAkpFK5oyLue/GtUaHCxV5MIF8TAlT0y+gNoPgi9fydJvWg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXHDj-0002R0-0Y;
	Wed, 10 Jun 2026 11:35:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXHDK-0002Oz-Sk
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 11:35:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=upZkkSiLJFn7CyWKcxL2GDgauqsi0PL0oMCKgxM7VRg=; b=PBquiUSx0EcZhAb5QJLL27bxg6
 vZamRXS4CKRP4aNvgBGqv05ZZIT6NwxXkZoA7IqmkdteGGakTIHbPJXHHI5KkxB2v3Iohj94cZw5i
 tr/HuiaGNUP8Frj4+QVo4dBKwQfXJqzsJ3kQpLA0gXaIe9qnhL5yQZuUxHbYZkItHH1U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=upZkkSiLJFn7CyWKcxL2GDgauqsi0PL0oMCKgxM7VRg=; b=T
 vbsIveHqB03zvVFPbDQIc7eTBgXXhi/TplDGZvCOlJbXu+eaeDQedBDwBbcw17u/K4Ve0GEtlxZgG
 ZjI8DQ/y8eFqaObGLqZuuSGfMzUBIFv42vXhvoUdLyBBbO9wAzZXFw2LuzhwBENsUeZWN6jutFB6H
 jRtjS1mcaieuw9Dw=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXHD6-0000gg-I5 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 11:35:08 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4600cbb06deso3656337f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 10 Jun 2026 04:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781091298; x=1781696098; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=upZkkSiLJFn7CyWKcxL2GDgauqsi0PL0oMCKgxM7VRg=;
 b=QSKyJHd6wJ5gC9bSpxonxhJFJn81ygTPmQeXd46/mUuiwwObPE226W5m4YqL7Hvrcp
 0f+97sZ/HIIVOX1GwQZZ7OMKxxIcBVVFZUhvBjzBzROml9BX6NpnBwnzeawAJd9Qz1wx
 f8prur3qWZckYOMSiK4ifaBcM+jGN05jTioYrxU/9imZ+eczbSht9e3InDjVHKK5jyuI
 vetHvq5WPX2WA3PNhhVP8aRSfRM0N37d7T5zOZgMaTGoRL9vGWXX24w1ysPzAzoSb2B0
 RdqbIr+I1sCbUGvbi57BhIG9lPK1x4bV47y20CU2mld3ysbAvBaou1ZyF02ghb4XYmvu
 NJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781091298; x=1781696098;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=upZkkSiLJFn7CyWKcxL2GDgauqsi0PL0oMCKgxM7VRg=;
 b=tSkj1Qd4f8JIQz7yeM60v2vFDJInpdWV+Gd316PGX17xFdST4LoRQ7KYuEJg7x56CI
 5SD3OCeML1LV/bo9YsjGwIYJB1A6obyjnqSxG63pF5/OsVY7QKC8kko2Ouf7dteQZHxP
 T6435r3luYCXkttB8DKq3x09u0nAIKaON8yHTWz9WAkGZnGsiCQaazSqUcZE61mgUIBy
 9uoYCKyzVqrFEjumK0sqicCTJgdu+60wf0eHYrEjIac+rNm8vwLYhIxLHfb8vVDviqgt
 ns+oUpNo8td3X/mDxycETC6y8oDp0mWsufJ3N3YiFrPdQAoFz3RMIykkedb9stAUI2CT
 6upg==
X-Gm-Message-State: AOJu0YygEErk3zwntWAoiKJyS+7/Dqy1vCwxRN3GM/EuCmHBbyrBPUOW
 s2SY7yTt3LV1LDabLtDuvE5eq2Hi5SJtwf8Dy25sHjsYZWHLvQQPLjU5YGvgERYwYbdiYAy3pBN
 +ooGfqQt0xgXvoAl9FVGJyvcqZKKAS52ge+GO0s+6BejZ4hAbyIrw2VRJiuo/GJl8WNFT
X-Gm-Gg: Acq92OFZQaYBmDcUvLLVjcgflBN0Dr5NfOI7YZz3FocCwYSbjP00ulRGwDfjxtRSwSf
 MNDb+0uVEFuqdE6jTlj33vAfLDYWtmfrG+D4QYVbfnPE3Sl+dUDUtKLdyT1DQMW7yvNTfKuKoyH
 eSG0rhsEQTc18lPayKYVsxZ2dUKxkB1YaVFA4KMA/MWpl3VbMCIL1jom7QEKPqLcml8jqV4HAHI
 GTzSAa9/gkqKf4PJXDEK+uAU8AqYvfCqoDGeL0epxZiXkGfqZ/hilpuYyWGgzHlFqoA8wqHgdTS
 UFU/evkhXvPwcuF1XNNF2IlA+15N9Zy3MiGxWwuNAgbsUfsJoAdpbq3pGlpv1yrAydsAV56dCvs
 DgQvyINe6/ciwKQ3pJ2iFtY8K38jc0KxMMsIc62fD1bsJ51tIV/bNI1kCL7Ny94fFhPvRntHrBC
 00Xre1h+Imr18tE/kZ9hYJWp/3gGanDpT0GCivT1dRsnHsEL2izaGBHCmHzRsNUv5TCB/MUlPmU
 DQ8eIIbx0P05DNCcHm81Yu3Nbzn7XuTIzH7QdYwfyB9KhSgxRVetXU2auTW18Jusou46Cg5PDKv
 5IA963dKVgI+gqPTKAX9FPQk
X-Received: by 2002:a05:6000:4b07:b0:460:21e7:330e with SMTP id
 ffacd0b85a97d-46032b8164fmr31537864f8f.10.1781091298319; 
 Wed, 10 Jun 2026 04:34:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4602cda363bsm58812909f8f.31.2026.06.10.04.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 04:34:57 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 10 Jun 2026 11:34:52 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I115a17a2c61c65f48aea41d94150f34ea31f82da
X-Gerrit-Change-Number: 1703
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1703?usp=email>
X-Gerrit-Commit: dcb3bbe0ad6d29ae420af36f86b911f284a8bf06
In-Reply-To: <gerrit.1779797980000.I115a17a2c61c65f48aea41d94150f34ea31f82da@gerrit.openvpn.net>
References: <gerrit.1779797980000.I115a17a2c61c65f48aea41d94150f34ea31f82da@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5Nzk3OTgwMDAwLkkxMTVhMTdhMmM2MWM2NWY0OGFlYTQxZDk0MTUwZjM0ZWEzMWY4MmRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9cd17c4dd3b425ca83c6cae827e84c6c0b80f7c8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXHD6-0000gg-I5
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add support for user
 defined L3 master devices
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "its_Giaan \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "its_Giaan \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3095748586859423468=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3095748586859423468==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oIxIKY4Fiec="; charset=UTF-8

--oIxIKY4Fiec=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos=2E

Hello flicht=
enheld, plaisthos, 

I'd like you to reexamine a change=2E Please visit

  =
  http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1703?usp=3Demail

to look at th=
e new patch set (#2)=2E


Change subject: Add support for user defined L3 m=
aster devices
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Add support for user defined L3 master devices

Introduce the --l3mdev op=
tion to allow associating OpenVPN
tun interfaces with a user-defined L3 mas=
ter device (VRF)=2E

When configured, the tun interface is automatically bo=
und
to the specified l3mdev during interface initialization=2E

This allows=
 VPN traffic to operate within a VRF domain,
enabling network isolation and=
 policy-based routing at L3 level=2E

Note: This feature is Linux-only and =
relies on SITNL backend=2E

Change-Id: I115a17a2c61c65f48aea41d94150f34ea31=
f82da
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
---
M=
 doc/man-sections/vpn-network-options=2Erst
M src/openvpn/networking=2Eh
M =
src/openvpn/networking_sitnl=2Ec
M src/openvpn/networking_sitnl=2Eh
M src/o=
penvpn/options=2Ec
M src/openvpn/options=2Eh
M src/openvpn/tun=2Ec
7 files =
changed, 104 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/03/1703/2

diff --git a/doc/man-sectio=
ns/vpn-network-options=2Erst b/doc/man-sections/vpn-network-options=2Erst
i=
ndex 181c990=2E=2E3853066 100644
--- a/doc/man-sections/vpn-network-options=
=2Erst
+++ b/doc/man-sections/vpn-network-options=2Erst
@@ -304,6 +304,19 @=
@
   Specify the link layer address, more commonly known as the MAC address=
=2E
   Only applied to TAP devices=2E
 
+--l3mdev name
+   Specify the L3 m=
aster device (such as VRF) to which the tunnel
+   interface will be bound=
=2E The specified device must already exist=2E
+
+   Unlike ``--bind-dev``,=
 which affects only the transport traffic
+   (the encrypted packets exchan=
ged between peers),
+   ``--l3mdev`` associates tun0 with an L3 master devi=
ce,
+   causing the data traffic traversing the tunnel
+   (in its unencryp=
ted form within the local networking stack)
+   to follow the routing polic=
y associated with that L3 domain=2E
+
+  (Supported on Linux only, on other=
 platforms this is a no-op)=2E
+
 --netns name
   Specify the network names=
pace in which the tunnel interface will be created=2E
   The namespace must=
 already exist=2E
diff --git a/src/openvpn/networking=2Eh b/src/openvpn/net=
working=2Eh
index fab6bbf=2E=2E3b4ac9f 100644
--- a/src/openvpn/networking=
=2Eh
+++ b/src/openvpn/networking=2Eh
@@ -125,6 +125,16 @@
 int net_iface_d=
el(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface);
 
 /**
+ * Bi=
nd a network interface to an L3 master device=2E
+ *
+ * @param ctx       O=
penVPN network context=2E
+ * @param iface     Interface to bind=2E
+ *
+ *=
 @return 0 on success, -1 on error=2E
+ */
+int net_iface_l3mdev_bind(openv=
pn_net_ctx_t *ctx, const char *iface);
+
+/**
  * Bring interface up or dow=
n=2E
  *
  * @param ctx       the implementation specific context
diff --gi=
t a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
ind=
ex b60131f=2E=2Ea1d6086 100644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b=
/src/openvpn/networking_sitnl=2Ec
@@ -187,6 +187,7 @@
     char path[PATH_M=
AX];
 
     ctx->netns =3D NULL;
+    ctx->l3mdev =3D NULL;
 
     if (c &&=
 c->options=2Enetns)
     {
@@ -200,6 +201,16 @@
         ctx->netns =3D c-=
>options=2Enetns;
     }
 
+    if (c && c->options=2El3mdev)
+    {
+     =
   if (!if_nametoindex(c->options=2El3mdev))
+        {
+            msg(M_=
ERR, "%s: L3 master device %s does not exist", __func__, c->options=2El3mde=
v);
+        }
+
+        ctx->l3mdev =3D c->options=2El3mdev;
+    }
+
   =
  ctx->gc =3D gc_new();
     return 0;
 }
@@ -1046,6 +1057,44 @@
 #ifdef EN=
ABLE_SITNL
 
 int
+net_iface_l3mdev_bind(openvpn_net_ctx_t *ctx, const char=
 *iface)
+{
+    struct sitnl_link_req req;
+    int ret =3D -1;
+
+    CLE=
AR(req);
+
+    int ifindex =3D if_nametoindex(iface);
+    int l3mdev_inde=
x =3D if_nametoindex(ctx->l3mdev);
+
+    if (ifindex =3D=3D 0)
+    {
+   =
     msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__,=
 iface);
+        return ret;
+    }
+    if (l3mdev_index =3D=3D 0)
+    {=

+        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __fu=
nc__, ctx->l3mdev);
+        return ret;
+    }
+
+    req=2En=2Enlmsg_len =
=3D NLMSG_LENGTH(sizeof(req=2Ei));
+    req=2En=2Enlmsg_flags =3D NLM_F_REQ=
UEST | NLM_F_ACK;
+    req=2En=2Enlmsg_type =3D RTM_NEWLINK;
+
+    req=2Ei=
=2Eifi_family =3D AF_PACKET;
+    req=2Ei=2Eifi_index =3D ifindex;
+
+    S=
ITNL_ADDATTR(&req=2En, sizeof(req), IFLA_MASTER, &l3mdev_index, sizeof(int)=
);
+
+    msg(M_INFO, "Binding %s to %s", iface, ctx->l3mdev);
+
+    ret =
=3D sitnl_send(&req=2En, 0, 0, NULL, NULL);
+err:
+    return ret;
+}
+
+in=
t
 net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, bool up)
 {
    =
 struct sitnl_link_req req;
diff --git a/src/openvpn/networking_sitnl=2Eh b=
/src/openvpn/networking_sitnl=2Eh
index 7e723fe=2E=2E6dff698 100644
--- a/s=
rc/openvpn/networking_sitnl=2Eh
+++ b/src/openvpn/networking_sitnl=2Eh
@@ -=
28,6 +28,7 @@
 struct openvpn_net_ctx
 {
     const char *netns;
+    const=
 char *l3mdev;
     struct gc_arena gc;
 };
 
diff --git a/src/openvpn/opti=
ons=2Ec b/src/openvpn/options=2Ec
index b602dcc=2E=2Ebfc13e2 100644
--- a/s=
rc/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -320,6 +320,9 @@
  =
   "--bind-dev dev  : Bind to the given device when making connection to a =
peer or\n"
     "                  listening for connections=2E This allows=
 sending encrypted packets\n"
     "                  via a VRF present on =
the system=2E\n"
+    "--l3mdev        : Enslave the tunnel interface to a =
layer 3 master device causing\n"
+    "                  the data traffic t=
raversing the tunnel to follow the routing policy\n"
+    "                =
  associated with that layer 3 domain=2E\n"
 #endif
     "--txqueuelen n  :=
 Set the tun/tap TX queue length to n (Linux only)=2E\n"
     "--mlock     =
    : Disable Paging -- ensures key material and tunnel\n"
@@ -6503,6 +6506=
,14 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->netns =
=3D p[1];
     }
+    else if (streq(p[0], "l3mdev") && p[1] && !p[2])
+   =
 {
+#ifndef ENABLE_SITNL
+        msg(M_WARN, "NOTE: --l3mdev is supported =
only on Linux when compiled with SITNL");
+#endif
+        VERIFY_PERMISSIO=
N(OPT_P_GENERAL);
+        options->l3mdev =3D p[1];
+    }
     else if (s=
treq(p[0], "nice") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_=
P_NICE);
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
ind=
ex 88a6dfa=2E=2E1afd41b 100644
--- a/src/openvpn/options=2Eh
+++ b/src/open=
vpn/options=2Eh
@@ -316,6 +316,7 @@
     struct dns_options dns_options;
 
=
     const char *netns;
+    const char *l3mdev;
     bool remote_random;
 =
    const char *ipchange;
     const char *dev;
diff --git a/src/openvpn/tu=
n=2Ec b/src/openvpn/tun=2Ec
index 51d9bed=2E=2E250ce50 100644
--- a/src/ope=
nvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -1059,6 +1059,15 @@
     {
      =
   msg(M_FATAL, "Linux can't set mtu (%d) on %s", tun_mtu, ifname);
     }
=
+#if defined(ENABLE_SITNL)
+    if (ctx->l3mdev)
+    {
+        if (net_if=
ace_l3mdev_bind(ctx, ifname) < 0)
+        {
+            msg(M_NONFATAL, "=
Linux can't bind %s to %s", ifname, ctx->l3mdev);
+        }
+    }
+#endif=

 
     if (net_iface_up(ctx, ifname, true) < 0)
     {
@@ -1265,6 +1274,16=
 @@
         msg(M_FATAL, "Linux can't set mtu (%d) on %s", tun_mtu, ifname=
);
     }
 
+#if defined(ENABLE_SITNL)
+    if (ctx->l3mdev)
+    {
+      =
  if (net_iface_l3mdev_bind(ctx, ifname) < 0)
+        {
+            msg(M=
_NONFATAL, "Linux can't bind %s to %s", ifname, ctx->l3mdev);
+        }
+ =
   }
+#endif
+
     if (net_iface_up(ctx, ifname, true) < 0)
     {
       =
  msg(M_FATAL, "Linux can't bring %s up", ifname);

-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1703?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I115a17a2c61c65f48aea41d94150f34ea31f82da=

Gerrit-Change-Number: 1703
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gia=
nmarco@mandelbit=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: its_Giaan <gianmarco@m=
andelbit=2Ecom>

--oIxIKY4Fiec=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, plaisthos=2E </p>
<p>its_Giaan <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1703?usp=3Demail">View Change</a></p><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Add support for user defined L3 master devices<br><br>Introduce the -=
-l3mdev option to allow associating OpenVPN<br>tun interfaces with a user-d=
efined L3 master device (VRF)=2E<br><br>When configured, the tun interface =
is automatically bound<br>to the specified l3mdev during interface initiali=
zation=2E<br><br>This allows VPN traffic to operate within a VRF domain,<br=
>enabling network isolation and policy-based routing at L3 level=2E<br><br>=
Note: This feature is Linux-only and relies on SITNL backend=2E<br><br>Chan=
ge-Id: I115a17a2c61c65f48aea41d94150f34ea31f82da<br>Signed-off-by: Gianmarc=
o De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>---<br>M doc/man-sections=
/vpn-network-options=2Erst<br>M src/openvpn/networking=2Eh<br>M src/openvpn=
/networking_sitnl=2Ec<br>M src/openvpn/networking_sitnl=2Eh<br>M src/openvp=
n/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/tun=2Ec<br>7 fi=
les changed, 104 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/03/1703/2</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/doc/man-sections/vpn-network-options=2Erst b/doc/man-se=
ctions/vpn-network-options=2Erst</span><br><span>index 181c990=2E=2E3853066=
 100644</span><br><span>--- a/doc/man-sections/vpn-network-options=2Erst</s=
pan><br><span>+++ b/doc/man-sections/vpn-network-options=2Erst</span><br><s=
pan>@@ -304,6 +304,19 @@</span><br><span>   Specify the link layer address,=
 more commonly known as the MAC address=2E</span><br><span>   Only applied =
to TAP devices=2E</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+--l3mdev name</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+   Specify the L3 master device (such as VRF) to which the tunnel=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   interface will b=
e bound=2E The specified device must already exist=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+   Unlike ``--bind-dev``, which affects only the transport t=
raffic</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   (the encry=
pted packets exchanged between peers),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+   ``--l3mdev`` associates tun0 with an L3 master device=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   causing the dat=
a traffic traversing the tunnel</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+   (in its unencrypted form within the local networking stack)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+   to follow the rou=
ting policy associated with that L3 domain=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  (Supported on Linux only, on other platforms this is a no-op)=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --n=
etns name</span><br><span>   Specify the network namespace in which the tun=
nel interface will be created=2E</span><br><span>   The namespace must alre=
ady exist=2E</span><br><span>diff --git a/src/openvpn/networking=2Eh b/src/=
openvpn/networking=2Eh</span><br><span>index fab6bbf=2E=2E3b4ac9f 100644</s=
pan><br><span>--- a/src/openvpn/networking=2Eh</span><br><span>+++ b/src/op=
envpn/networking=2Eh</span><br><span>@@ -125,6 +125,16 @@</span><br><span> =
int net_iface_del(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface)=
;</span><br><span> </span><br><span> /**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Bind a network interface to an L3 master device=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param ctx       OpenVPN network c=
ontext=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
iface     Interface to bind=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @re=
turn 0 on success, -1 on error=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in=
t net_iface_l3mdev_bind(openvpn_net_ctx_t *ctx, const char *iface);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/**</span><br><span>  * Bring interface up or =
down=2E</span><br><span>  *</span><br><span>  * @param ctx       the implem=
entation specific context</span><br><span>diff --git a/src/openvpn/networki=
ng_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><span>index b6013=
1f=2E=2Ea1d6086 100644</span><br><span>--- a/src/openvpn/networking_sitnl=
=2Ec</span><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</span><br><span=
>@@ -187,6 +187,7 @@</span><br><span>     char path[PATH_MAX];</span><br><s=
pan> </span><br><span>     ctx-&gt;netns =3D NULL;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ctx-&gt;l3mdev =3D NULL;</span><br><span=
> </span><br><span>     if (c &amp;&amp; c-&gt;options=2Enetns)</span><br><=
span>     {</span><br><span>@@ -200,6 +201,16 @@</span><br><span>         c=
tx-&gt;netns =3D c-&gt;options=2Enetns;</span><br><span>     }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c &amp=
;&amp; c-&gt;options=2El3mdev)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (!if_nametoindex(c-&gt;options=2El3mdev))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            msg(M_ERR, &quot;%s: L3 master device %s do=
es not exist&quot;, __func__, c-&gt;options=2El3mdev);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        ctx-&gt;l3mdev =3D c-&gt;options=2El3mdev;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span>     ctx-&gt;gc =3D gc_new();</span=
><br><span>     return 0;</span><br><span> }</span><br><span>@@ -1046,6 +10=
57,44 @@</span><br><span> #ifdef ENABLE_SITNL</span><br><span> </span><br><=
span> int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_=
l3mdev_bind(openvpn_net_ctx_t *ctx, const char *iface)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct sitnl_link_req req;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    int ret =3D -1;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    CLEAR(req);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ifinde=
x =3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int l3mdev_index =3D if_nametoindex(ctx-&gt;l3mdev);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (ifindex =3D=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot ge=
t ifindex for %s&quot;, __func__, iface);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return ret;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (l3mdev_index =3D=3D 0)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for %=
s&quot;, __func__, ctx-&gt;l3mdev);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return ret;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2En=2Enlm=
sg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    req=2En=2Enlmsg_flags =3D NLM_F_REQUEST | NLM_F_A=
CK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2En=2Enl=
msg_type =3D RTM_NEWLINK;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2Ei=
=2Eifi_family =3D AF_PACKET;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    req=2Ei=2Eifi_index =3D ifindex;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    SITNL_ADDATTR(&amp;req=2En, sizeof(req), IFLA_MASTER, &amp;l3mde=
v_index, sizeof(int));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_INFO, =
&quot;Binding %s to %s&quot;, iface, ctx-&gt;l3mdev);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ret =3D sitnl_send(&amp;req=2En, 0, 0, NULL, NULL);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+err:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int=
</span><br><span> net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, b=
ool up)</span><br><span> {</span><br><span>     struct sitnl_link_req req;<=
/span><br><span>diff --git a/src/openvpn/networking_sitnl=2Eh b/src/openvpn=
/networking_sitnl=2Eh</span><br><span>index 7e723fe=2E=2E6dff698 100644</sp=
an><br><span>--- a/src/openvpn/networking_sitnl=2Eh</span><br><span>+++ b/s=
rc/openvpn/networking_sitnl=2Eh</span><br><span>@@ -28,6 +28,7 @@</span><br=
><span> struct openvpn_net_ctx</span><br><span> {</span><br><span>     cons=
t char *netns;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *l3mdev;</span><br><span>     struct gc_arena gc;</span><br><span=
> };</span><br><span> </span><br><span>diff --git a/src/openvpn/options=2Ec=
 b/src/openvpn/options=2Ec</span><br><span>index b602dcc=2E=2Ebfc13e2 10064=
4</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/o=
penvpn/options=2Ec</span><br><span>@@ -320,6 +320,9 @@</span><br><span>    =
 &quot;--bind-dev dev  : Bind to the given device when making connection to=
 a peer or\n&quot;</span><br><span>     &quot;                  listening f=
or connections=2E This allows sending encrypted packets\n&quot;</span><br><=
span>     &quot;                  via a VRF present on the system=2E\n&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--l3mdev=
        : Enslave the tunnel interface to a layer 3 master device causing\n=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;   =
               the data traffic traversing the tunnel to follow the routing=
 policy\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
&quot;                  associated with that layer 3 domain=2E\n&quot;</spa=
n><br><span> #endif</span><br><span>     &quot;--txqueuelen n  : Set the tu=
n/tap TX queue length to n (Linux only)=2E\n&quot;</span><br><span>     &qu=
ot;--mlock         : Disable Paging -- ensures key material and tunnel\n&qu=
ot;</span><br><span>@@ -6503,6 +6506,14 @@</span><br><span>         VERIFY_=
PERMISSION(OPT_P_GENERAL);</span><br><span>         options-&gt;netns =3D p=
[1];</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    else if (streq(p[0], &quot;l3mdev&quot;) &amp;&amp; p[1] &amp;&=
amp; !p[2])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SITNL</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &=
quot;NOTE: --l3mdev is supported only on Linux when compiled with SITNL&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OP=
T_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  options-&gt;l3mdev =3D p[1];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;nice&quot;=
) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>=
         VERIFY_PERMISSION(OPT_P_NICE);</span><br><span>diff --git a/src/op=
envpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index 88a6dfa=
=2E=2E1afd41b 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><b=
r><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -316,6 +316,7 @@</=
span><br><span>     struct dns_options dns_options;</span><br><span> </span=
><br><span>     const char *netns;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const char *l3mdev;</span><br><span>     bool remote_ran=
dom;</span><br><span>     const char *ipchange;</span><br><span>     const =
char *dev;</span><br><span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/t=
un=2Ec</span><br><span>index 51d9bed=2E=2E250ce50 100644</span><br><span>--=
- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br=
><span>@@ -1059,6 +1059,15 @@</span><br><span>     {</span><br><span>      =
   msg(M_FATAL, &quot;Linux can&#39;t set mtu (%d) on %s&quot;, tun_mtu, if=
name);</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if defined(ENABLE_SITNL)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (ctx-&gt;l3mdev)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (net_iface_l3mdev_bind(ctx, ifname) &lt; 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            msg(M_NONFATAL, &quot;Linux can&=
#39;t bind %s to %s&quot;, ifname, ctx-&gt;l3mdev);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span> </span><br><span>     if (net_iface_up(ct=
x, ifname, true) &lt; 0)</span><br><span>     {</span><br><span>@@ -1265,6 =
+1274,16 @@</span><br><span>         msg(M_FATAL, &quot;Linux can&#39;t set=
 mtu (%d) on %s&quot;, tun_mtu, ifname);</span><br><span>     }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(E=
NABLE_SITNL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(ctx-&gt;l3mdev)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (net_i=
face_l3mdev_bind(ctx, ifname) &lt; 0)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg(M_NONFATAL, &quot;Linux can&#39;t bind %s to %s&quo=
t;, ifname, ctx-&gt;l3mdev);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (ne=
t_iface_up(ctx, ifname, true) &lt; 0)</span><br><span>     {</span><br><spa=
n>         msg(M_FATAL, &quot;Linux can&#39;t bring %s up&quot;, ifname);</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1703?usp=3Demail">change 1703</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1703?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I115a17a2c61c65f48=
aea41d94150f34ea31f82da </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1703 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>

</b=
ody></html>
--oIxIKY4Fiec=--


--===============3095748586859423468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3095748586859423468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3095748586859423468==--

