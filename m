Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC644CD5BD0
	for <openvpn-devel@archiver.kernel.org>; Tue, 26 May 2026 12:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=8s7Ya/stO0QrOzAWqE09/SjJ8/UlBC288p32QBB0OHA=; b=d63fJEjNyCpOp/
	jkMQTxJxnMwyl7c0iYiL50GrprwiEq5HZlkA0dunaNA5AROqcD56BEVTFOKa/48VfMArelEwAGq2a
	+5yEUYbXTVVc2sndJr6A+7WFnVHYZJkN09hrpSkolNFOYWDK9mGJzqxatm9xkSP9Ll7zWjneCgNBE
	JNo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wRqlY-0006zC-Pe;
	Tue, 26 May 2026 12:20:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wRqlK-0006yI-Tn
 for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 12:19:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l9ZyyL2BkVoYimTN0x6ErPgGQrMMxpLEmsCpNkU7xQ0=; b=IuzSTKVbhnAzvrKv1iQiOCQseg
 EaidhCCDioQo107c5Y+5Ye35j9BA7keM2dyvR22VCQ36uur3RoZlUGyV/1cKkDcvhh9ZQNG0nugF6
 biLrMjLBMg3rJ9ozlDiB9WDP1UTQjli2hAx3oO+AWWuB0R/zaKNShX0DqxYl+p8vzndk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=l9ZyyL2BkVoYimTN0x6ErPgGQrMMxpLEmsCpNkU7xQ0=; b=S
 OFupS7kd7E94FZrcCszk+0AWtL9OieDVcfw0QaFEgmGU1s/SvP8/aU8xWSu4iZY0mahFAStmWockO
 EDILIzrhM0x8fiyo0qrYShYUNInAMRIp0bpatPmVg3JsZ7N/IJq7CJTzBBfevrax/aQNM+fYNaKup
 8EXtpqwqvND86dPw=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wRqlJ-00068f-EY for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 12:19:59 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso90739885e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 26 May 2026 05:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779797986; x=1780402786; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l9ZyyL2BkVoYimTN0x6ErPgGQrMMxpLEmsCpNkU7xQ0=;
 b=SX4aaV8NWrPxPOYPLT6+PgQNzpa2N9xMvmvkL+LxZdOEVlMC5cP+qSdH9ApWhPyGsZ
 qUhOJM7sSVIUhmsOGnQUnUq7OhbezOiwCK8WxypjleqYwRQm0aAnNjwPJtxGvtfRPJz1
 CAEXbS8745EFL/tzhk/w7WL7e2lpGugbTXZbFeh+HW/lQiPhwMFBnsk5Fdfn7JXE/JL3
 K2L4raqdXFlsx1lqTSZ6W+9ReYbWLdr0Yih95b/vLVqnnzr5vmVOm3/ZwQpK/I2kaLcZ
 TzZ6yFn4gKQywrGWA7R9G2xabhMl960AFGDiiV7StLDtocSU3DrzxH8VQNFbeblMv5TR
 0+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779797986; x=1780402786;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l9ZyyL2BkVoYimTN0x6ErPgGQrMMxpLEmsCpNkU7xQ0=;
 b=pCzkIIeCwpD71Bdo+1KZKteBOOE4CipKGqKmwG52D2+Qb2LiLBq2CkrCeO12FeJDHK
 Ovaru8pC+/VXYICdB49OjZakEihroTUl+GsH3VNR4OVFY0cCd3ZvWTsZX2fzOPlxE9iy
 JICGnHjBlPd+bbONTM5msiIfW6P/Sq1Ro2CoEHDP1bURBGZwa2ZB5Oldfx9xkCTwGwoa
 uz8f1q1gjRVJxQR5LDh50hBMy1FWRQBPWpdgT6fyUdFWEDDvd0sRluGVXc7k+iAKaX0w
 GiBkmNlvFC/eRHFatHIgihx7Bh0rNtrLkyKf2QwDzYCdmK2ZjajegA2LFlwSQqO6nBKA
 NVyg==
X-Gm-Message-State: AOJu0YwuA3/TTUQvr28hi1rYIYBK5T1IOxhEcDDPaO6DFZPQzRpDNcSH
 KHn8rOcincA4FnrlDSyhUZ4vTXPj0qbEv7Hb+6pleNAXuedXzasjl4WicEs4MLDO4/Oo/goGSXu
 xEeK9d+8VRK0cFHE1RUyOcFvJMdMJfuVRwQS8Ixt4Vf/OwG63gPi4fp80B2Nm5rHsyhK3+GQVOV
 z0oakQlg==
X-Gm-Gg: Acq92OH9z4G4sOcCJ/wLhs8kcnUS0hJ+8b+TUT0PGuvJa9BXIkTlmjwcxzP5OYLEjf9
 e1OZgryIp0NHcGcHqskLXTQxFv03pVwyzkeTpvuDPGtJHTmQCfFtWlKCFKpJ/FKWac1qThzF0Hz
 8THzsB/dNVlCisgPdTuFHA3rkQPDPR7VuheT1DfSCr/o2EyCFua1XO8E+NOldGAHbrMUBR6+7XA
 x6uxPBbqfdy/BDQkVIzic0G+L1wSPmkcRCvLRmcr0dY/l4fhwB5V/+FmPXyk6M8yERh1rsDwbnk
 95p3yMMXKDtHa73d1G86AMb9vA51TEnjxPVw87FDezVxQhZQoyGi7ipYASv/HvRcJXcgbVN3iJW
 0QL3WIqgDTcqxzZ18M4VjnUZCjvAGQlE5Cn5u3yhqvdz6yhF0d0Ob3KUh5zRHq7dnfzd/3Guj34
 kJbHUuy9T2r9iMQY/pHfbGO0JcBuXdg7tZJxBqMUeaRDyTXO0d6nKoM5wn/eJ520fOEDInAaiAt
 PzDCvYCSWlos2E2f/dSsoD6KKH8dSJyG4T5q+8N1jK35YqHCQ9vnxIy+UznD7YXvzPE0kufjtxg
 GASdnM0oNIMifA==
X-Received: by 2002:a05:600c:4ecc:b0:490:389:7644 with SMTP id
 5b1f17b1804b1-490426d4d7fmr305869915e9.17.1779797986164; 
 Tue, 26 May 2026 05:19:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ed8873a35sm4301057f8f.14.2026.05.26.05.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 05:19:45 -0700 (PDT)
From: "its_Giaan (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 26 May 2026 12:19:45 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I115a17a2c61c65f48aea41d94150f34ea31f82da
X-Gerrit-Change-Number: 1703
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1703?usp=email>
X-Gerrit-Commit: c0912e077fe19033a61d0fab245fccbe7c75f07f
References: <gerrit.1779797980000.I115a17a2c61c65f48aea41d94150f34ea31f82da@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5Nzk3OTgwMDAwLkkxMTVhMTdhMmM2MWM2NWY0OGFlYTQxZDk0MTUwZjM0ZWEzMWY4MmRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <94852bf93a34571ab42dfacf89e31254302d37dd-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wRqlJ-00068f-EY
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
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3478452481917768572=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3478452481917768572==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ieM6PNBsagQ="; charset=UTF-8

--ieM6PNBsagQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1703?usp=3Demail

to review the following change=2E


Chang=
e subject: Add support for user defined L3 master devices
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add support for user defined=
 L3 master devices

Introduce the --l3mdev option to allow associating Open=
VPN
tun interfaces with a user-defined L3 master device (VRF)=2E

When conf=
igured, the tun interface is automatically bound
to the specified l3mdev du=
ring interface initialization=2E

This allows VPN traffic to operate within=
 a VRF domain,
enabling network isolation and policy-based routing at L3 le=
vel=2E

Note: This feature is Linux-only and relies on SITNL backend=2E

Ch=
ange-Id: I115a17a2c61c65f48aea41d94150f34ea31f82da
Signed-off-by: Gianmarco=
 De Gregori <gianmarco@mandelbit=2Ecom>
---
M doc/man-sections/vpn-network-=
options=2Erst
M src/openvpn/dco=2Ec
M src/openvpn/networking=2Eh
M src/open=
vpn/networking_sitnl=2Ec
M src/openvpn/networking_sitnl=2Eh
M src/openvpn/o=
ptions=2Ec
M src/openvpn/options=2Eh
M src/openvpn/tun=2Ec
8 files changed,=
 95 insertions(+), 0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/03/1703/1

diff --git a/doc/man-sections/vpn-n=
etwork-options=2Erst b/doc/man-sections/vpn-network-options=2Erst
index 181=
c990=2E=2E4cc11e9 100644
--- a/doc/man-sections/vpn-network-options=2Erst
+=
++ b/doc/man-sections/vpn-network-options=2Erst
@@ -304,6 +304,12 @@
   Spe=
cify the link layer address, more commonly known as the MAC address=2E
   O=
nly applied to TAP devices=2E
 
+--l3mdev name
+   Specify the L3 master de=
vice (such as VRF) to which the tunnel 
+   interface will be bound=2E The =
specified device must already exist=2E
+
+  (Supported on Linux only, on ot=
her platforms this is a no-op)=2E
+
 --netns name
   Specify the network na=
mespace in which the tunnel interface will be created=2E
   The namespace m=
ust already exist=2E
diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec=

index fbefcb6=2E=2E40ef5b6 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/open=
vpn/dco=2Ec
@@ -395,6 +395,7 @@
         msg(msglevel, "Note: --netns not s=
upported by DCO, disabling data channel offload=2E");
         return false=
;
     }
+
 #endif /* if defined(_WIN32) */
 
 #if defined(HAVE_LIBCAPNG)
d=
iff --git a/src/openvpn/networking=2Eh b/src/openvpn/networking=2Eh
index f=
ab6bbf=2E=2E3b4ac9f 100644
--- a/src/openvpn/networking=2Eh
+++ b/src/openv=
pn/networking=2Eh
@@ -125,6 +125,16 @@
 int net_iface_del(openvpn_net_ctx_t=
 *ctx, const openvpn_net_iface_t *iface);
 
 /**
+ * Bind a network interfa=
ce to an L3 master device=2E
+ *
+ * @param ctx       OpenVPN network conte=
xt=2E
+ * @param iface     Interface to bind=2E
+ *
+ * @return 0 on succes=
s, -1 on error=2E
+ */
+int net_iface_l3mdev_bind(openvpn_net_ctx_t *ctx, c=
onst char *iface);
+
+/**
  * Bring interface up or down=2E
  *
  * @param =
ctx       the implementation specific context
diff --git a/src/openvpn/netw=
orking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index b60131f=2E=2Ebb9e=
77a 100644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/network=
ing_sitnl=2Ec
@@ -187,6 +187,7 @@
     char path[PATH_MAX];
 
     ctx->net=
ns =3D NULL;
+    ctx->l3mdev =3D NULL;
 
     if (c && c->options=2Enetns)=

     {
@@ -200,6 +201,16 @@
         ctx->netns =3D c->options=2Enetns;
  =
   }
 
+    if (c && c->options=2El3mdev)
+    {
+        if (!if_nametoind=
ex(c->options=2El3mdev))
+        {
+            msg(M_ERR, "%s: L3 master =
device %s does not exist", __func__, c->options=2El3mdev);
+        }
+
+  =
      ctx->l3mdev =3D c->options=2El3mdev;
+    }
+
     ctx->gc =3D gc_new=
();
     return 0;
 }
@@ -1046,6 +1057,44 @@
 #ifdef ENABLE_SITNL
 
 int
+n=
et_iface_l3mdev_bind(openvpn_net_ctx_t *ctx, const char *iface)
+{
+    str=
uct sitnl_link_req req;
+    int ifindex, l3mdev_index, ret =3D -1;
+
+    =
CLEAR(req);
+
+    ifindex =3D if_nametoindex(iface);
+    l3mdev_index =3D=
 if_nametoindex(ctx->l3mdev);
+
+    if (ifindex =3D=3D 0)
+    {
+        =
msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__, ifac=
e);
+        return -1;
+    }
+    if (l3mdev_index =3D=3D 0)
+    {
+    =
    msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__, =
ctx->l3mdev);
+        return -1;
+    }
+
+    req=2En=2Enlmsg_len =3D NLM=
SG_LENGTH(sizeof(req=2Ei));
+    req=2En=2Enlmsg_flags =3D NLM_F_REQUEST | =
NLM_F_ACK;
+    req=2En=2Enlmsg_type =3D RTM_NEWLINK;
+
+    req=2Ei=2Eifi_=
family =3D AF_PACKET;
+    req=2Ei=2Eifi_index =3D ifindex;
+
+    SITNL_AD=
DATTR(&req=2En, sizeof(req), IFLA_MASTER, &l3mdev_index, sizeof(int));
+
+ =
   msg(M_INFO, "Binding %s to %s", iface, ctx->l3mdev);
+
+    ret =3D sitn=
l_send(&req=2En, 0, 0, NULL, NULL);
+err:
+    return ret;
+}
+
+int
 net_i=
face_up(openvpn_net_ctx_t *ctx, const char *iface, bool up)
 {
     struct =
sitnl_link_req req;
diff --git a/src/openvpn/networking_sitnl=2Eh b/src/ope=
nvpn/networking_sitnl=2Eh
index 7e723fe=2E=2E6dff698 100644
--- a/src/openv=
pn/networking_sitnl=2Eh
+++ b/src/openvpn/networking_sitnl=2Eh
@@ -28,6 +28=
,7 @@
 struct openvpn_net_ctx
 {
     const char *netns;
+    const char *l=
3mdev;
     struct gc_arena gc;
 };
 
diff --git a/src/openvpn/options=2Ec =
b/src/openvpn/options=2Ec
index bde3680=2E=2E5247c8e 100644
--- a/src/openv=
pn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -6496,6 +6496,14 @@
       =
  VERIFY_PERMISSION(OPT_P_GENERAL);
         options->netns =3D p[1];
     =
}
+    else if (streq(p[0], "l3mdev") && p[1] && !p[2])
+    {
+#ifndef ENA=
BLE_SITNL
+        msg(M_WARN, "NOTE: --l3mdev is supported only on Linux w=
hen compiled with SITNL");
+#endif
+        VERIFY_PERMISSION(OPT_P_GENERAL=
);
+        options->l3mdev =3D p[1];
+    }
     else if (streq(p[0], "nic=
e") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_NICE);
diff -=
-git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index 88a6dfa=2E=
=2E1afd41b 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=
=2Eh
@@ -316,6 +316,7 @@
     struct dns_options dns_options;
 
     const =
char *netns;
+    const char *l3mdev;
     bool remote_random;
     const c=
har *ipchange;
     const char *dev;
diff --git a/src/openvpn/tun=2Ec b/src=
/openvpn/tun=2Ec
index 51d9bed=2E=2E250ce50 100644
--- a/src/openvpn/tun=2E=
c
+++ b/src/openvpn/tun=2Ec
@@ -1059,6 +1059,15 @@
     {
         msg(M_FA=
TAL, "Linux can't set mtu (%d) on %s", tun_mtu, ifname);
     }
+#if define=
d(ENABLE_SITNL)
+    if (ctx->l3mdev)
+    {
+        if (net_iface_l3mdev_=
bind(ctx, ifname) < 0)
+        {
+            msg(M_NONFATAL, "Linux can't=
 bind %s to %s", ifname, ctx->l3mdev);
+        }
+    }
+#endif
 
     if =
(net_iface_up(ctx, ifname, true) < 0)
     {
@@ -1265,6 +1274,16 @@
       =
  msg(M_FATAL, "Linux can't set mtu (%d) on %s", tun_mtu, ifname);
     }
 =

+#if defined(ENABLE_SITNL)
+    if (ctx->l3mdev)
+    {
+        if (net_i=
face_l3mdev_bind(ctx, ifname) < 0)
+        {
+            msg(M_NONFATAL, =
"Linux can't bind %s to %s", ifname, ctx->l3mdev);
+        }
+    }
+#endi=
f
+
     if (net_iface_up(ctx, ifname, true) < 0)
     {
         msg(M_FAT=
AL, "Linux can't bring %s up", ifname);

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1703?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: I115a17a2c61c65f48aea41d94150f34ea31f82da
Gerrit-Cha=
nge-Number: 1703
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@mand=
elbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: plaisthos <arne-openvpn@rfc2549=2Eorg>

--ieM6PNBsagQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>its_Giaan would like plaisthos t=
o <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1703?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Add support for user defined L3 master devices<br><br>Introduce the --l=
3mdev option to allow associating OpenVPN<br>tun interfaces with a user-def=
ined L3 master device (VRF)=2E<br><br>When configured, the tun interface is=
 automatically bound<br>to the specified l3mdev during interface initializa=
tion=2E<br><br>This allows VPN traffic to operate within a VRF domain,<br>e=
nabling network isolation and policy-based routing at L3 level=2E<br><br>No=
te: This feature is Linux-only and relies on SITNL backend=2E<br><br>Change=
-Id: I115a17a2c61c65f48aea41d94150f34ea31f82da<br>Signed-off-by: Gianmarco =
De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>---<br>M doc/man-sections/v=
pn-network-options=2Erst<br>M src/openvpn/dco=2Ec<br>M src/openvpn/networki=
ng=2Eh<br>M src/openvpn/networking_sitnl=2Ec<br>M src/openvpn/networking_si=
tnl=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/=
openvpn/tun=2Ec<br>8 files changed, 95 insertions(+), 0 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/03/1703/1</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/doc/man-sections/vpn-network-opti=
ons=2Erst b/doc/man-sections/vpn-network-options=2Erst</span><br><span>inde=
x 181c990=2E=2E4cc11e9 100644</span><br><span>--- a/doc/man-sections/vpn-ne=
twork-options=2Erst</span><br><span>+++ b/doc/man-sections/vpn-network-opti=
ons=2Erst</span><br><span>@@ -304,6 +304,12 @@</span><br><span>   Specify t=
he link layer address, more commonly known as the MAC address=2E</span><br>=
<span>   Only applied to TAP devices=2E</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+--l3mdev name</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   Specify the L3 master device (such as =
VRF) to which the tunnel </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+   interface will be bound=2E The specified device must already exist=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  (Supported on Linux only, on othe=
r platforms this is a no-op)=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> --netns name</span><br><span>   Specify the n=
etwork namespace in which the tunnel interface will be created=2E</span><br=
><span>   The namespace must already exist=2E</span><br><span>diff --git a/=
src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index fbefcb6=2E=
=2E40ef5b6 100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br><span=
>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -395,6 +395,7 @@</span><br><s=
pan>         msg(msglevel, &quot;Note: --netns not supported by DCO, disabl=
ing data channel offload=2E&quot;);</span><br><span>         return false;<=
/span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> #endif /* if defined(_WIN32) */</span><br><span> </spa=
n><br><span> #if defined(HAVE_LIBCAPNG)</span><br><span>diff --git a/src/op=
envpn/networking=2Eh b/src/openvpn/networking=2Eh</span><br><span>index fab=
6bbf=2E=2E3b4ac9f 100644</span><br><span>--- a/src/openvpn/networking=2Eh</=
span><br><span>+++ b/src/openvpn/networking=2Eh</span><br><span>@@ -125,6 +=
125,16 @@</span><br><span> int net_iface_del(openvpn_net_ctx_t *ctx, const =
openvpn_net_iface_t *iface);</span><br><span> </span><br><span> /**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Bind a network interface=
 to an L3 master device=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
ctx       OpenVPN network context=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param iface     Interface to bind=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @return 0 on success, -1 on error=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+int net_iface_l3mdev_bind(openvpn_net_ctx_t *ctx, =
const char *iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span=
>  * Bring interface up or down=2E</span><br><span>  *</span><br><span>  * =
@param ctx       the implementation specific context</span><br><span>diff -=
-git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec<=
/span><br><span>index b60131f=2E=2Ebb9e77a 100644</span><br><span>--- a/src=
/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/src/openvpn/networking_=
sitnl=2Ec</span><br><span>@@ -187,6 +187,7 @@</span><br><span>     char pat=
h[PATH_MAX];</span><br><span> </span><br><span>     ctx-&gt;netns =3D NULL;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;l3mdev =
=3D NULL;</span><br><span> </span><br><span>     if (c &amp;&amp; c-&gt;opt=
ions=2Enetns)</span><br><span>     {</span><br><span>@@ -200,6 +201,16 @@</=
span><br><span>         ctx-&gt;netns =3D c-&gt;options=2Enetns;</span><br>=
<span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (c &amp;&amp; c-&gt;options=2El3mdev)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (!if_nametoindex(c-&gt;options=2El3mdev))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_ERR, &quot;%=
s: L3 master device %s does not exist&quot;, __func__, c-&gt;options=2El3md=
ev);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        ctx-&gt;l3mdev =3D c-&gt;options=2El=
3mdev;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     ctx-&=
gt;gc =3D gc_new();</span><br><span>     return 0;</span><br><span> }</span=
><br><span>@@ -1046,6 +1057,44 @@</span><br><span> #ifdef ENABLE_SITNL</spa=
n><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+net_iface_l3mdev_bind(openvpn_net_ctx_t *ctx, const char *if=
ace)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct sitnl_link_req req;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ifindex, l3mde=
v_index, ret =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(req);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ifindex =3D if_nametoindex(iface);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    l3mdev_index =3D i=
f_nametoindex(ctx-&gt;l3mdev);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
ifindex =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WA=
RN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for %s&quot;, __func__, if=
ace);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (l3mdev_index =3D=3D 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &q=
uot;%s: rtnl: cannot get ifindex for %s&quot;, __func__, ctx-&gt;l3mdev);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -1;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2En=2Enl=
msg_flags =3D NLM_F_REQUEST | NLM_F_ACK;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    req=2En=2Enlmsg_type =3D RTM_NEWLINK;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    req=2Ei=2Eifi_family =3D AF_PACKET;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    req=2Ei=2Eifi_index =3D ifi=
ndex;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    SITNL_ADDATTR(&amp;req=2En, s=
izeof(req), IFLA_MASTER, &amp;l3mdev_index, sizeof(int));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    msg(M_INFO, &quot;Binding %s to %s&quot;, iface, ctx=
-&gt;l3mdev);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D sitnl_send(&a=
mp;req=2En, 0, 0, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+err:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+int</span><br><span> net_iface_up(openvpn_net=
_ctx_t *ctx, const char *iface, bool up)</span><br><span> {</span><br><span=
>     struct sitnl_link_req req;</span><br><span>diff --git a/src/openvpn/n=
etworking_sitnl=2Eh b/src/openvpn/networking_sitnl=2Eh</span><br><span>inde=
x 7e723fe=2E=2E6dff698 100644</span><br><span>--- a/src/openvpn/networking_=
sitnl=2Eh</span><br><span>+++ b/src/openvpn/networking_sitnl=2Eh</span><br>=
<span>@@ -28,6 +28,7 @@</span><br><span> struct openvpn_net_ctx</span><br><=
span> {</span><br><span>     const char *netns;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const char *l3mdev;</span><br><span>     st=
ruct gc_arena gc;</span><br><span> };</span><br><span> </span><br><span>dif=
f --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span=
>index bde3680=2E=2E5247c8e 100644</span><br><span>--- a/src/openvpn/option=
s=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -649=
6,6 +6496,14 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);<=
/span><br><span>         options-&gt;netns =3D p[1];</span><br><span>     }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(=
p[0], &quot;l3mdev&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#ifndef ENABLE_SITNL</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;NOTE: --l3mdev is supp=
orted only on Linux when compiled with SITNL&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;l3mdev =3D p=
[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span>     else if (streq(p[0], &quot;nice&quot;) &amp;&amp; p[1] &amp;&am=
p; !p[2])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION=
(OPT_P_NICE);</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/op=
envpn/options=2Eh</span><br><span>index 88a6dfa=2E=2E1afd41b 100644</span><=
br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/op=
tions=2Eh</span><br><span>@@ -316,6 +316,7 @@</span><br><span>     struct d=
ns_options dns_options;</span><br><span> </span><br><span>     const char *=
netns;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cha=
r *l3mdev;</span><br><span>     bool remote_random;</span><br><span>     co=
nst char *ipchange;</span><br><span>     const char *dev;</span><br><span>d=
iff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index=
 51d9bed=2E=2E250ce50 100644</span><br><span>--- a/src/openvpn/tun=2Ec</spa=
n><br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -1059,6 +1059,15 @=
@</span><br><span>     {</span><br><span>         msg(M_FATAL, &quot;Linux =
can&#39;t set mtu (%d) on %s&quot;, tun_mtu, ifname);</span><br><span>     =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE=
_SITNL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ctx-=
&gt;l3mdev)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (net_iface_=
l3mdev_bind(ctx, ifname) &lt; 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(M_NONFATAL, &quot;Linux can&#39;t bind %s to %s&quot;, i=
fname, ctx-&gt;l3mdev);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><sp=
an> </span><br><span>     if (net_iface_up(ctx, ifname, true) &lt; 0)</span=
><br><span>     {</span><br><span>@@ -1265,6 +1274,16 @@</span><br><span>  =
       msg(M_FATAL, &quot;Linux can&#39;t set mtu (%d) on %s&quot;, tun_mtu=
, ifname);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_SITNL)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (ctx-&gt;l3mdev)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (net_iface_l3mdev_bind(ctx, ifname=
) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_NO=
NFATAL, &quot;Linux can&#39;t bind %s to %s&quot;, ifname, ctx-&gt;l3mdev);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>     if (net_iface_up(ctx, ifname, tr=
ue) &lt; 0)</span><br><span>     {</span><br><span>         msg(M_FATAL, &q=
uot;Linux can&#39;t bring %s up&quot;, ifname);</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1703?usp=3Demail">change 1703</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1703?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: I115a17a2c61c65f48aea41d94150f34ea31f82da <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 1703 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=


</body></html>
--ieM6PNBsagQ=--


--===============3478452481917768572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3478452481917768572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3478452481917768572==--

