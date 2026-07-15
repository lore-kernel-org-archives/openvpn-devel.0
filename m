Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4291DC44501
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 16:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cO80o0VC84Tw7k6zABnPol8Z5gw2/6/teDsJ/zuML6Q=; b=X7S0y4yyHAQFD1CoD46x5rv/oX
	lh2Mejky1AqbgwAklUS1hnhdsYdzfOcnYzndgDa+B8WoOtBujSpDv5Ux1LnxaA8uvM+ehpb6og/9E
	bRW1AmNJjkG84Fo0vVrDYWK+k4FoxaBgetOWNF7uqOgJMqkPdLSiz1HyBsbbGdr47HVE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk2XO-00079E-31;
	Wed, 15 Jul 2026 16:32:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk2XB-00077d-6R
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 16:32:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=kIPT67BrJvpPnnks+6ckirSC/TwCq3mT5Gyu/ewbXxA=; b=dk32ibpFAe5KzEl2oNzKNvydQh
 zcEfPcl2orQqi6w49gX/98mvAdHPY0FHeLTVwUeTBqL7biFrEhDjdx5gI6DGq5UMqDibNXmgjkBSS
 uttiEUZJ6K4PHfJIz4AqYuUBhrPgbNBs9Tr3zef6A/RkRDkMX8UfoY9BuGChteldIp5k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kIPT67BrJvpPnnks+6ckirSC/TwCq3mT5Gyu/ewbXxA=; b=K
 yqWPyighhO48Pjxb5zHAQILCTnV6m9ojfVO17Py6pLUmCZoFbpIXTLyIm2NlWltkQ8y8gbqW2ULHd
 a8xHhlEcR6O6Z23QR7J5CUiGeO4W8AEsF0SY0DhSfR8nFgaZFLu9NU3sa2gyegBYkhg88fZPxF0DU
 dHIwckunxmqYWNEE=;
Received: from mail-lf1-f47.google.com ([209.85.167.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk2X8-0003jb-CE for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 16:32:33 +0000
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-5b013aa02b2so1175365e87.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 09:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784133138; x=1784737938; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kIPT67BrJvpPnnks+6ckirSC/TwCq3mT5Gyu/ewbXxA=;
 b=FU0Oxcf392xIcf33nXAlkQLtP1eRCMfVpvo0Sz/y/84FG2qIut06/m3Jr/U2Sy3Owj
 w/enPfl8wO3/V1RorrPRlrVCD/bopYT96hDRu1g9+YE5fm6iG8uESrZAwaaFZG15HSFK
 H5EuDk2DrFvAjIuoRQNEJxEGKpXeF5DDtt7o09AqzMd7IaYMzMsZM+7SqLbGlvMiL6EA
 pASwbA0GjlSDwT2eNfmE52/fsQEdfjNIiwQCs82vIz9FMbG3ADzSryKcDJfK89VjHmet
 TEX6Vq/5epoLurS5c1zGppMIkF+atRaeFvwiE3kzX8OPhFuDw3e/V7Pt6Lt5/aPT/F3E
 L6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784133138; x=1784737938;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kIPT67BrJvpPnnks+6ckirSC/TwCq3mT5Gyu/ewbXxA=;
 b=NuwLxWpoFpfe3Di9tdaIquCrPI3OqGsTD/sE1neQGeC6NmaxaaJam9/+tR94fq5OMm
 ZPk7Wn0bCQVOFoANGMgDsq1a+GfcFzrFyKNtre9cRBD44YmCP2euHyjfBbB4BZBMFGwf
 ysmYOu02xnIqRcgTH+nI4gTKw6sQtM12JSUQGqM/SvcYhugtyzupX2Tnr+6MJGG/X4vF
 mxgAATkAYKGCPoWoVlo+ZWqQCmK0wGgbB17stujUqjULvDZEWZohl1CjS08MnmVkaJSR
 OUeVbzrzTQAZ4amQn3JMfzp4Hf/nDOBwKaB/fIgt8ClhH3sFlun4B+cauHRCvUFA8vna
 offA==
X-Gm-Message-State: AOJu0YygnouUWxuqLwrCkSbwZwakYdS6E5mtnw+gMW561W0Cw5xvJmrS
 tjstDDO3jg4wI90kVoppeazjAANyzfVJzdQ41fshRSN/UWWTodZJUyPg5lnMejATWIgwooj1CZY
 Kx3eUJiKj1su1RjUdTQcQx4xQNXdgivqNEEn0z1n8NqhxhU+gpx7bnyz1Xlo1p3itGP6MBdSGZR
 WsZ3rH1Q==
X-Gm-Gg: AfdE7ckOrEt5zRyZRn75RPO/Uc72deb7jf5eU55B7Su0DTavBELSgDbV6TyhVMx/dls
 YG6J7o2ZtpXU6ZPzbAn/QeKKAedBqxZnZuQZ/o/Xi4m9l8BOUq+aQI9f3FmQBlivFiaX7TZyc/w
 E5TxGlIlY0dabTmiPyDzV6+ZXeTqoE3PQarfH9POpqEhlp4PTQtKCla47sJCA27dfh6oqZbmIxR
 K4Wd+DxBO4ExEuVjGOqCxFnd/k1qcegFwsilkaXcpfNbkJQVS1tbRtP3TxTB5cWk0nCJcK3AvOP
 FCe+f8JCJNYWWFEyIbP5eDG4VSJhjTWMuax+95mCvk7QIN+JwRRU82YTq+ZOSZ2K04Dn22F4gu0
 stn/BE0lV3ii8YBy3BjCUQetHEc5BmblE/diY3p4oVOn6k4IYrJPXrTth+l8dUFB3aUct9e1FjM
 1khUo5mgEv/XhXKlrkT0jgLJvMLbzJpJVZiGaFU3APpvB1hEZGDUZFbvbGrT2JT6XZfFkI8UBBq
 R4+qy8jUgQgHlbQa7Ro2DGzANFRYTcxu2ckmLiqA75n430JGLK79d4Y6yX7yzuKScgplwO5yf5d
 hOpj12hlxR7wEQ==
X-Received: by 2002:a05:6000:430c:b0:472:8043:f00b with SMTP id
 ffacd0b85a97d-47ef697ecfemr26607580f8f.14.1784121839935; 
 Wed, 15 Jul 2026 06:23:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635c86csm16285172f8f.16.2026.07.15.06.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 06:23:59 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 13:23:53 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727
X-Gerrit-Change-Number: 1786
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1786?usp=email>
X-Gerrit-Commit: f5038725a0104d7f238ff7080c8ee13ab1ccdca0
In-Reply-To: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
References: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkk2NGUwODUwZDQ4NjQ3YTJjMGUzZDM4NWMyZjIwYTlmNDQ1OTMxNzI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4724dd261fbadff1f8de821877ded73adb116e07-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk2X8-0003jb-CE
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi: assign IPv6
 addresses from a tagged subnet-pool
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2812420719724154160=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2812420719724154160==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YV/AuxfZWHw="; charset=UTF-8

--YV/AuxfZWHw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1786?usp=3Demail

to look at the new patch set (#3)=2E

=

Change subject: multi: assign IPv6 addresses from a tagged subnet-pool
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: assign IP=
v6 addresses from a tagged subnet-pool

Add the IPv6 counterpart of --subne=
t-pool:

  subnet-pool-ipv6 <tag> <network>/<bits> [<gateway>]   (main conf=
ig)

selected by the same per-client --subnet-pool-tag=2E A client's tag is=

resolved against the IPv6 pool list too and, when it matches, an IPv6
addr=
ess is handed out from the group's pool alongside any IPv4 one (a
single du=
al-stack ifconfig_pool per tag)=2E A tag matching neither family
is still d=
eclined with AUTH_FAILED=2E

Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445=
931727
GitHub: closes openvpn/OpenVPN#987
Signed-off-by: Antonio Quartulli =
<antonio@mandelbit=2Ecom>
---
M doc/man-sections/server-options=2Erst
M src=
/openvpn/multi=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M sr=
c/openvpn/options_util=2Ec
M src/openvpn/options_util=2Eh
M tests/unit_test=
s/openvpn/test_subnet_pool=2Ec
7 files changed, 156 insertions(+), 25 delet=
ions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/86/1786/3

diff --git a/doc/man-sections/server-options=2Erst b/doc/man-s=
ections/server-options=2Erst
index b6464af=2E=2E0146594 100644
--- a/doc/ma=
n-sections/server-options=2Erst
+++ b/doc/man-sections/server-options=2Erst=

@@ -355,11 +355,24 @@
   ``push "route <server-VPN-IP> 255=2E255=2E255=2E2=
55"`` (or the ``route-ipv6``
   equivalent) to the server config=2E
 
+--su=
bnet-pool-ipv6 args
+  The IPv6 counterpart of ``--subnet-pool``=2E Repeata=
ble main-config directive=2E
+
+  Valid syntax:
+  ::
+
+     subnet-pool-i=
pv6 tag network/bits [gateway]
+
+  ``bits`` must be between 64 and 124; ``=
gateway`` defaults to the first
+  address of the network=2E A tag may name=
 an IPv4 pool, an IPv6 pool, or both;
+  a client referencing it with ``--s=
ubnet-pool-tag`` is then assigned an
+  address from each family the tag de=
fines=2E
+
 --subnet-pool-tag tag
-  Assign this client to the ``--subnet-p=
ool`` named ``tag``=2E Must be
-  associated with a specific client instanc=
e via ``--client-config-dir`` or
-  ``--client-connect``=2E Several clients=
 may reference the same tag and are
-  then served from the same shared poo=
l=2E
+  Assign this client to the ``--subnet-pool`` / ``--subnet-pool-ipv6`=
` named
+  ``tag``=2E Must be associated with a specific client instance vi=
a
+  ``--client-config-dir`` or ``--client-connect``=2E Several clients may=

+  reference the same tag and are then served from the same shared pool(s)=
=2E
 
 --ifconfig-ipv6-push args
   for ``--client-config-dir`` per-client =
static IPv6 interface
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/mult=
i=2Ec
index da46cf4=2E=2E1cd84b6 100644
--- a/src/openvpn/multi=2Ec
+++ b/s=
rc/openvpn/multi=2Ec
@@ -1438,11 +1438,14 @@
     }
 
     const struct sub=
net_pool_def *d4 =3D subnet_pool_by_tag(m->top=2Eoptions=2Esubnet_pools, ta=
g);
+    const struct subnet_pool6_def *d6 =3D subnet_pool6_by_tag(m->top=
=2Eoptions=2Esubnet_pools_ipv6, tag);
     ALLOC_OBJ_CLEAR(sp, struct subne=
t_pool);
-    sp->tag =3D d4->tag;
-    sp->pool =3D ifconfig_pool_init(tru=
e, IFCONFIG_POOL_INDIV, d4->network + 2,
-                                 =
 (d4->network | ~d4->netmask) - 1, m->top=2Eoptions=2Eduplicate_cn,
-      =
                            false, in6addr_any, 0);
+    sp->tag =3D d4 ? d=
4->tag : d6->tag;
+    sp->pool =3D ifconfig_pool_init(d4 !=3D NULL, IFCONF=
IG_POOL_INDIV, d4 ? d4->network + 2 : 0,
+                                 =
 d4 ? (d4->network | ~d4->netmask) - 1 : 0,
+                              =
    m->top=2Eoptions=2Eduplicate_cn, d6 !=3D NULL,
+                       =
           d6 ? add_in6_addr(d6->network, 2) : in6addr_any,
+              =
                    d6 ? (int)d6->netbits : 0);
     sp->next =3D m->subnet=
_pools;
     m->subnet_pools =3D sp;
     return sp->pool;
@@ -1472,6 +1475=
,18 @@
             mi->context=2Eoptions=2Esubnet_pool_gateway =3D d->gate=
way;
         }
     }
+    if (mi->context=2Eoptions=2Esubnet_pool_tag && =
!mi->context=2Eoptions=2Esubnet_pool_ipv6_defined)
+    {
+        const st=
ruct subnet_pool6_def *d =3D subnet_pool6_by_tag(
+            m->top=2Eopt=
ions=2Esubnet_pools_ipv6, mi->context=2Eoptions=2Esubnet_pool_tag);
+      =
  if (d)
+        {
+            mi->context=2Eoptions=2Esubnet_pool_ipv6_d=
efined =3D true;
+            mi->context=2Eoptions=2Esubnet_pool_ipv6_netw=
ork =3D d->network;
+            mi->context=2Eoptions=2Esubnet_pool_ipv6_n=
etbits =3D d->netbits;
+            mi->context=2Eoptions=2Esubnet_pool_ipv=
6_gateway =3D d->gateway;
+        }
+    }
 
     /*
      * If ifconfig a=
ddresses were set by dynamic config file,
@@ -1506,42 +1521,60 @@
         =
        "MULTI_sva: WARNING: if --ifconfig-push is used for IPv4, automatic=
 IPv6 assignment from --ifconfig-ipv6-pool does not work=2E  Use --ifconfig=
-ipv6-push for IPv6 then=2E");
         }
     }
-    else if (mi->context=
=2Eoptions=2Esubnet_pool_defined)
+    else if (mi->context=2Eoptions=2Esub=
net_pool_tag)
     {
-        /* dynamic address from this client's --subne=
t-pool group */
+        /* dynamic address(es) from this client's --subnet=
-pool group */
 
         /* the CCD is read after a global-pool address ma=
y already have been
-         * acquired; drop it so we can serve this clie=
nt from its group */
+         * acquired; drop it so we serve this client =
from its group only */
         if (mi->vaddr_handle >=3D 0 && !mi->vaddr_p=
ool)
         {
             ifconfig_pool_release(m->ifconfig_pool, mi->va=
ddr_handle, true);
             mi->vaddr_handle =3D -1;
+            mi->c=
ontext=2Ec2=2Epush_ifconfig_defined =3D false;
+            mi->context=2Ec=
2=2Epush_ifconfig_ipv6_defined =3D false;
         }
 
-        if (mi->vad=
dr_handle < 0)
+        if ((mi->context=2Eoptions=2Esubnet_pool_defined
+ =
            || mi->context=2Eoptions=2Esubnet_pool_ipv6_defined)
+         =
   && mi->vaddr_handle < 0)
         {
             in_addr_t local =3D 0, =
remote =3D 0;
+            struct in6_addr remote_ipv6;
             const =
char *cn =3D NULL;
 
+            CLEAR(remote_ipv6);
             if (!mi-=
>context=2Eoptions=2Eduplicate_cn)
             {
                 cn =3D t=
ls_common_name(mi->context=2Ec2=2Etls_multi, true);
             }
 
      =
       mi->vaddr_pool =3D multi_get_group_pool(m, mi->context=2Eoptions=2Es=
ubnet_pool_tag);
-            mi->vaddr_handle =3D ifconfig_pool_acquire(mi=
->vaddr_pool, &local, &remote, NULL, cn);
-            if (mi->vaddr_handle=
 >=3D 0)
-            {
-                mi->context=2Ec2=2Epush_ifconfig_l=
ocal =3D remote;
-                mi->context=2Ec2=2Epush_ifconfig_remote_n=
etmask =3D
-                    mi->context=2Eoptions=2Esubnet_pool_netmask=
;
-                mi->context=2Ec2=2Epush_ifconfig_defined =3D true;
-    =
        }
-            else
+            mi->vaddr_handle =3D
+            =
    ifconfig_pool_acquire(mi->vaddr_pool, &local, &remote, &remote_ipv6, cn=
);
+            if (mi->vaddr_handle < 0)
             {
                 m=
sg(D_MULTI_ERRORS, "MULTI: no free --subnet-pool addresses are available fo=
r %s",
                     multi_instance_string(mi, false, &gc));
       =
      }
+            else
+            {
+                if (mi->context=
=2Eoptions=2Esubnet_pool_defined)
+                {
+                    m=
i->context=2Ec2=2Epush_ifconfig_local =3D remote;
+                    mi->=
context=2Ec2=2Epush_ifconfig_remote_netmask =3D
+                        mi=
->context=2Eoptions=2Esubnet_pool_netmask;
+                    mi->context=
=2Ec2=2Epush_ifconfig_defined =3D true;
+                }
+               =
 if (mi->context=2Eoptions=2Esubnet_pool_ipv6_defined)
+                {
+=
                    mi->context=2Ec2=2Epush_ifconfig_ipv6_local =3D remote_=
ipv6;
+                    mi->context=2Ec2=2Epush_ifconfig_ipv6_remote =3D=
 mi->context=2Ec1=2Etuntap->local_ipv6;
+                    mi->context=2E=
c2=2Epush_ifconfig_ipv6_netbits =3D
+                        mi->context=2E=
options=2Esubnet_pool_ipv6_netbits;
+                    mi->context=2Ec2=
=2Epush_ifconfig_ipv6_defined =3D true;
+                }
+            }
 =
        }
     }
     else if (m->ifconfig_pool && mi->vaddr_handle < 0) /*=
 otherwise, choose a pool address */
@@ -2852,7 +2885,9 @@
     }
 
     if=
 (mi->context=2Eoptions=2Esubnet_pool_tag
-        && !subnet_pool_by_tag(m=
->top=2Eoptions=2Esubnet_pools, mi->context=2Eoptions=2Esubnet_pool_tag))
+=
        && !subnet_pool_by_tag(m->top=2Eoptions=2Esubnet_pools, mi->context=
=2Eoptions=2Esubnet_pool_tag)
+        && !subnet_pool6_by_tag(m->top=2Eopt=
ions=2Esubnet_pools_ipv6,
+                                mi->context=2Eop=
tions=2Esubnet_pool_tag))
     {
         msg(D_MULTI_ERRORS, "MULTI: clien=
t has been rejected due to unknown --subnet-pool-tag '%s'",
             mi=
->context=2Eoptions=2Esubnet_pool_tag);
diff --git a/src/openvpn/options=2E=
c b/src/openvpn/options=2Ec
index 3f9f7de=2E=2Eb4485ca 100644
--- a/src/ope=
nvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -446,6 +446,8 @@
     "--=
subnet-pool tag network netmask [gateway] : Define a named pool of\n"
     =
"                  addresses outside the --server network, selected per\n"
=
     "                  client with --subnet-pool-tag=2E\n"
+    "--subnet-=
pool-ipv6 tag network/bits [gateway] : IPv6 counterpart of\n"
+    "       =
           --subnet-pool=2E\n"
     "--subnet-pool-tag tag : Assign this cl=
ient to the --subnet-pool named tag=2E\n"
     "                  Only vali=
d in a client-specific config file=2E\n"
     "--ifconfig-push local remote=
-netmask : Push an ifconfig option to remote,\n"
@@ -7658,6 +7660,37 @@
   =
      sp->next =3D options->subnet_pools;
         options->subnet_pools =
=3D sp;
     }
+    else if (streq(p[0], "subnet-pool-ipv6") && p[1] && p[2=
] && !p[4])
+    {
+        struct subnet_pool6_def *sp;
+        struct in=
6_addr network, gateway;
+        unsigned int netbits =3D 0;
+
+        VE=
RIFY_PERMISSION(OPT_P_GENERAL);
+        if (!get_ipv6_addr(p[2], &network,=
 &netbits, msglevel))
+        {
+            msg(msglevel, "cannot parse -=
-subnet-pool-ipv6 network");
+            goto err;
+        }
+        if =
(netbits < 64 || netbits > 124)
+        {
+            msg(msglevel, "--su=
bnet-pool-ipv6 network must be between /64 and /124 (not /%d)",
+          =
      netbits);
+            goto err;
+        }
+        if (p[3] && !get=
_ipv6_addr(p[3], &gateway, NULL, msglevel))
+        {
+            msg(msg=
level, "cannot parse --subnet-pool-ipv6 gateway");
+            goto err;
+=
        }
+        ALLOC_OBJ_GC(sp, struct subnet_pool6_def, &options->gc);=

+        sp->tag =3D p[1];
+        sp->network =3D network;
+        sp->=
netbits =3D netbits;
+        sp->gateway =3D p[3] ? gateway : add_in6_addr=
(network, 1);
+        sp->next =3D options->subnet_pools_ipv6;
+        op=
tions->subnet_pools_ipv6 =3D sp;
+    }
     else if (streq(p[0], "subnet-p=
ool-tag") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_INSTANC=
E);
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index 0c=
810b3=2E=2E7f0e3ce 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/o=
ptions=2Eh
@@ -261,6 +261,16 @@
     in_addr_t gateway;
 };
 
+/* The IPv6 =
counterpart of struct subnet_pool_def (--subnet-pool-ipv6)=2E */
+struct su=
bnet_pool6_def
+{
+    struct subnet_pool6_def *next;
+    const char *tag;=

+    struct in6_addr network;
+    unsigned int netbits;
+    struct in6_a=
ddr gateway;
+};
+
 /* Command line options */
 struct options
 {
@@ -526,1=
2 +536,17 @@
     bool push_ifconfig_constraint_defined;
     in_addr_t pus=
h_ifconfig_constraint_network;
     in_addr_t push_ifconfig_constraint_netm=
ask;
-    struct subnet_pool_def *subnet_pools; /* named pools (server conf=
ig) */
-    const char *subnet_pool_tag;          /* which pool this client=
 uses (CCD) */
-    bool subnet_pool_defined;             /* resolved from =
the tag at connect */
+    struct subnet_pool_def *subnet_pools;       /* n=
amed IPv4 pools (server config) */
+    struct subnet_pool6_def *subnet_poo=
ls_ipv6; /* named IPv6 pools (server config) */
+    const char *subnet_poo=
l_tag;                /* which pool this client uses (CCD) */
+    bool sub=
net_pool_defined;                   /* resolved from the tag at connect */
=
     in_addr_t subnet_pool_network;
     in_addr_t subnet_pool_netmask;
   =
  in_addr_t subnet_pool_gateway;
+    bool subnet_pool_ipv6_defined; /* res=
olved from the tag at connect */
+    struct in6_addr subnet_pool_ipv6_netw=
ork;
+    unsigned int subnet_pool_ipv6_netbits;
+    struct in6_addr subne=
t_pool_ipv6_gateway;
     bool push_ifconfig_ipv4_blocked;           /* IPv=
4 */
     bool push_ifconfig_ipv6_defined;           /* IPv6 */
     struct=
 in6_addr push_ifconfig_ipv6_local;  /* IPv6 */
diff --git a/src/openvpn/op=
tions_util=2Ec b/src/openvpn/options_util=2Ec
index ba04917=2E=2E7826458 10=
0644
--- a/src/openvpn/options_util=2Ec
+++ b/src/openvpn/options_util=2Ec
=
@@ -44,6 +44,19 @@
     return NULL;
 }
 
+const struct subnet_pool6_def *
=
+subnet_pool6_by_tag(const struct subnet_pool6_def *pools, const char *tag)=

+{
+    for (const struct subnet_pool6_def *d =3D pools; d; d =3D d->next)=

+    {
+        if (!strcmp(d->tag, tag))
+        {
+            return d=
;
+        }
+    }
+    return NULL;
+}
+
 const char *
 parse_auth_failed=
_temp(struct options *o, const char *reason)
 {
diff --git a/src/openvpn/op=
tions_util=2Eh b/src/openvpn/options_util=2Eh
index c54357c=2E=2Eed2017a 10=
0644
--- a/src/openvpn/options_util=2Eh
+++ b/src/openvpn/options_util=2Eh
=
@@ -38,6 +38,10 @@
 const struct subnet_pool_def *subnet_pool_by_tag(const =
struct subnet_pool_def *pools,
                                            =
      const char *tag);
 
+/** IPv6 counterpart of subnet_pool_by_tag()=2E =
*/
+const struct subnet_pool6_def *subnet_pool6_by_tag(const struct subnet_=
pool6_def *pools,
+                                                   const=
 char *tag);
+
 
 /** Checks if the string is a valid integer by checking i=
f it can be
  *  converted to an integer */
diff --git a/tests/unit_tests/o=
penvpn/test_subnet_pool=2Ec b/tests/unit_tests/openvpn/test_subnet_pool=2Ec=

index 8e73b64=2E=2Ed01ce05 100644
--- a/tests/unit_tests/openvpn/test_subn=
et_pool=2Ec
+++ b/tests/unit_tests/openvpn/test_subnet_pool=2Ec
@@ -60,8 +6=
0,26 @@
     assert_null(subnet_pool_by_tag(NULL, "grpA"));
 }
 
+/* the IP=
v6 counterpart resolves independently: a tag may name a v4 pool, a
+ * v6 p=
ool, or both=2E */
+static void
+test_subnet_pool6_by_tag(void **state)
+{
=
+    struct subnet_pool6_def c =3D { =2Enext =3D NULL, =2Etag =3D "grpC", =
=2Enetbits =3D 64 };
+    struct subnet_pool6_def b =3D { =2Enext =3D &c, =
=2Etag =3D "grpB", =2Enetbits =3D 96 };
+    struct subnet_pool6_def a =3D =
{ =2Enext =3D &b, =2Etag =3D "grpA", =2Enetbits =3D 64 };
+
+    assert_ptr=
_equal(subnet_pool6_by_tag(&a, "grpA"), &a);
+    assert_ptr_equal(subnet_p=
ool6_by_tag(&a, "grpB"), &b);
+    assert_ptr_equal(subnet_pool6_by_tag(&a,=
 "grpC"), &c);
+    assert_int_equal(subnet_pool6_by_tag(&a, "grpB")->netbi=
ts, 96);
+    assert_null(subnet_pool6_by_tag(&a, "nope"));
+    assert_nul=
l(subnet_pool6_by_tag(NULL, "grpA"));
+}
+
 const struct CMUnitTest subnet_=
pool_tests[] =3D {
     cmocka_unit_test(test_subnet_pool_by_tag),
+    cmo=
cka_unit_test(test_subnet_pool6_by_tag),
 };
 
 int

-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I64e0850d48647a2c0e3d385c2f20a9f44593172=
7
Gerrit-Change-Number: 1786
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antoni=
o@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--YV/AuxfZWHw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex <strong>uploaded patch set=
 #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1786?usp=3Demail">View Change</a></p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">multi: as=
sign IPv6 addresses from a tagged subnet-pool<br><br>Add the IPv6 counterpa=
rt of --subnet-pool:<br><br>  subnet-pool-ipv6 &lt;tag&gt; &lt;network&gt;/=
&lt;bits&gt; [&lt;gateway&gt;]   (main config)<br><br>selected by the same =
per-client --subnet-pool-tag=2E A client&#39;s tag is<br>resolved against t=
he IPv6 pool list too and, when it matches, an IPv6<br>address is handed ou=
t from the group&#39;s pool alongside any IPv4 one (a<br>single dual-stack =
ifconfig_pool per tag)=2E A tag matching neither family<br>is still decline=
d with AUTH_FAILED=2E<br><br>Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445=
931727<br>GitHub: closes openvpn/OpenVPN#987<br>Signed-off-by: Antonio Quar=
tulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M doc/man-sections/server-o=
ptions=2Erst<br>M src/openvpn/multi=2Ec<br>M src/openvpn/options=2Ec<br>M s=
rc/openvpn/options=2Eh<br>M src/openvpn/options_util=2Ec<br>M src/openvpn/o=
ptions_util=2Eh<br>M tests/unit_tests/openvpn/test_subnet_pool=2Ec<br>7 fil=
es changed, 156 insertions(+), 25 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/86/1786/3</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/doc/man-sections/server-options=2Erst b/doc/man-section=
s/server-options=2Erst</span><br><span>index b6464af=2E=2E0146594 100644</s=
pan><br><span>--- a/doc/man-sections/server-options=2Erst</span><br><span>+=
++ b/doc/man-sections/server-options=2Erst</span><br><span>@@ -355,11 +355,=
24 @@</span><br><span>   ``push &quot;route &lt;server-VPN-IP&gt; 255=2E255=
=2E255=2E255&quot;`` (or the ``route-ipv6``</span><br><span>   equivalent) =
to the server config=2E</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+--subnet-pool-ipv6 args</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  The IPv6 counterpart of ``--subnet-pool``=2E Re=
peatable main-config directive=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Val=
id syntax:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ::</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     subnet-pool-ipv6 tag network/bits [g=
ateway]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  ``bits`` must be between 64 a=
nd 124; ``gateway`` defaults to the first</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  address of the network=2E A tag may name an IPv4 po=
ol, an IPv6 pool, or both;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  a client referencing it with ``--subnet-pool-tag`` is then assigne=
d an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  address from =
each family the tag defines=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> --subnet-pool-tag tag</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-  Assign this client to the ``--subnet-pool`` =
named ``tag``=2E Must be</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  associated with a specific client instance via ``--client-config-dir``=
 or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``--client-conne=
ct``=2E Several clients may reference the same tag and are</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  then served from the same shared poo=
l=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Assign this c=
lient to the ``--subnet-pool`` / ``--subnet-pool-ipv6`` named</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  ``tag``=2E Must be associated w=
ith a specific client instance via</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  ``--client-config-dir`` or ``--client-connect``=2E Several=
 clients may</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  refer=
ence the same tag and are then served from the same shared pool(s)=2E</span=
><br><span> </span><br><span> --ifconfig-ipv6-push args</span><br><span>   =
for ``--client-config-dir`` per-client static IPv6 interface</span><br><spa=
n>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><spa=
n>index da46cf4=2E=2E1cd84b6 100644</span><br><span>--- a/src/openvpn/multi=
=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -1438,1=
1 +1438,14 @@</span><br><span>     }</span><br><span> </span><br><span>    =
 const struct subnet_pool_def *d4 =3D subnet_pool_by_tag(m-&gt;top=2Eoption=
s=2Esubnet_pools, tag);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const struct subnet_pool6_def *d6 =3D subnet_pool6_by_tag(m-&gt;top=
=2Eoptions=2Esubnet_pools_ipv6, tag);</span><br><span>     ALLOC_OBJ_CLEAR(=
sp, struct subnet_pool);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    sp-&gt;tag =3D d4-&gt;tag;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    sp-&gt;pool =3D ifconfig_pool_init(true, IFCONFIG_POOL_INDI=
V, d4-&gt;network + 2,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                  (d4-&gt;network | ~d4-&gt;netmask) - 1, =
m-&gt;top=2Eoptions=2Eduplicate_cn,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                                  false, in6addr_any, 0);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;tag =3D d4 ?=
 d4-&gt;tag : d6-&gt;tag;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    sp-&gt;pool =3D ifconfig_pool_init(d4 !=3D NULL, IFCONFIG_POOL_IN=
DIV, d4 ? d4-&gt;network + 2 : 0,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                  d4 ? (d4-&gt;network | ~d4-=
&gt;netmask) - 1 : 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                  m-&gt;top=2Eoptions=2Eduplicate_cn, d6 =
!=3D NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                         d6 ? add_in6_addr(d6-&gt;network, 2) : in6addr_any=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                d6 ? (int)d6-&gt;netbits : 0);</span><br><span>     sp-&gt;=
next =3D m-&gt;subnet_pools;</span><br><span>     m-&gt;subnet_pools =3D sp=
;</span><br><span>     return sp-&gt;pool;</span><br><span>@@ -1472,6 +1475=
,18 @@</span><br><span>             mi-&gt;context=2Eoptions=2Esubnet_pool_=
gateway =3D d-&gt;gateway;</span><br><span>         }</span><br><span>     =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;con=
text=2Eoptions=2Esubnet_pool_tag &amp;&amp; !mi-&gt;context=2Eoptions=2Esub=
net_pool_ipv6_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        con=
st struct subnet_pool6_def *d =3D subnet_pool6_by_tag(</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            m-&gt;top=2Eoptions=2Esubnet=
_pools_ipv6, mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (d)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            mi-&gt;context=2Eoptions=2Esubnet_pool_=
ipv6_defined =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_network =3D d-&g=
t;network;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_netbits =3D d-&gt;netbits;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;co=
ntext=2Eoptions=2Esubnet_pool_ipv6_gateway =3D d-&gt;gateway;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span> =
    /*</span><br><span>      * If ifconfig addresses were set by dynamic co=
nfig file,</span><br><span>@@ -1506,42 +1521,60 @@</span><br><span>        =
         &quot;MULTI_sva: WARNING: if --ifconfig-push is used for IPv4, aut=
omatic IPv6 assignment from --ifconfig-ipv6-pool does not work=2E  Use --if=
config-ipv6-push for IPv6 then=2E&quot;);</span><br><span>         }</span>=
<br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e=
lse if (mi-&gt;context=2Eoptions=2Esubnet_pool_defined)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    else if (mi-&gt;context=2Eoptions=
=2Esubnet_pool_tag)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        /* dynamic address from this client&#39;s --su=
bnet-pool group */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       /* dynamic address(es) from this client&#39;s --subnet-pool group */=
</span><br><span> </span><br><span>         /* the CCD is read after a glob=
al-pool address may already have been</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-         * acquired; drop it so we can serve this client fr=
om its group */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     * acquired; drop it so we serve this client from its group only */</sp=
an><br><span>         if (mi-&gt;vaddr_handle &gt;=3D 0 &amp;&amp; !mi-&gt;=
vaddr_pool)</span><br><span>         {</span><br><span>             ifconfi=
g_pool_release(m-&gt;ifconfig_pool, mi-&gt;vaddr_handle, true);</span><br><=
span>             mi-&gt;vaddr_handle =3D -1;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            mi-&gt;context=2Ec2=2Epush_ifconfig_d=
efined =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_defined =3D false;</span=
><br><span>         }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (mi-&gt;vaddr_handle &lt; 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if ((mi-&gt;context=2Eoptions=
=2Esubnet_pool_defined</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+             || mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_defined)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; =
mi-&gt;vaddr_handle &lt; 0)</span><br><span>         {</span><br><span>    =
         in_addr_t local =3D 0, remote =3D 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            struct in6_addr remote_ipv6;</span><b=
r><span>             const char *cn =3D NULL;</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            CLEAR(remote_ipv6);=
</span><br><span>             if (!mi-&gt;context=2Eoptions=2Eduplicate_cn)=
</span><br><span>             {</span><br><span>                 cn =3D tls=
_common_name(mi-&gt;context=2Ec2=2Etls_multi, true);</span><br><span>      =
       }</span><br><span> </span><br><span>             mi-&gt;vaddr_pool =
=3D multi_get_group_pool(m, mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            mi-&gt;vaddr=
_handle =3D ifconfig_pool_acquire(mi-&gt;vaddr_pool, &amp;local, &amp;remot=
e, NULL, cn);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    if (mi-&gt;vaddr_handle &gt;=3D 0)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                mi-&gt;context=2Ec2=2Epush_ifconfig_local =3D remo=
te;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                mi=
-&gt;context=2Ec2=2Epush_ifconfig_remote_netmask =3D</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    mi-&gt;context=2Eoption=
s=2Esubnet_pool_netmask;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                mi-&gt;context=2Ec2=2Epush_ifconfig_defined =3D true;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            else</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;vaddr_handle =3D=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ifc=
onfig_pool_acquire(mi-&gt;vaddr_pool, &amp;local, &amp;remote, &amp;remote_=
ipv6, cn);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   if (mi-&gt;vaddr_handle &lt; 0)</span><br><span>             {</span><br=
><span>                 msg(D_MULTI_ERRORS, &quot;MULTI: no free --subnet-p=
ool addresses are available for %s&quot;,</span><br><span>                 =
    multi_instance_string(mi, false, &amp;gc));</span><br><span>           =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (mi-&g=
t;context=2Eoptions=2Esubnet_pool_defined)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    mi-&gt;context=2Ec2=2Epush_ifconfi=
g_local =3D remote;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    mi-&gt;context=2Ec2=2Epush_ifconfig_remote_netmask =3D<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    mi-&gt;context=2Eoptions=2Esubnet_pool_netmask;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    mi-&gt;context=2Ec2=
=2Epush_ifconfig_defined =3D true;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                if (mi-&gt;context=2Eoptions=2Esubnet_pool_ipv=
6_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local =3D remote_ipv6;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    mi=
-&gt;context=2Ec2=2Epush_ifconfig_ipv6_remote =3D mi-&gt;context=2Ec1=2Etun=
tap-&gt;local_ipv6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_netbits =3D</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
  mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_netbits;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    mi-&gt;context=2Ec2=
=2Epush_ifconfig_ipv6_defined =3D true;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span>         }</span><br><span>=
     }</span><br><span>     else if (m-&gt;ifconfig_pool &amp;&amp; mi-&gt;=
vaddr_handle &lt; 0) /* otherwise, choose a pool address */</span><br><span=
>@@ -2852,7 +2885,9 @@</span><br><span>     }</span><br><span> </span><br><=
span>     if (mi-&gt;context=2Eoptions=2Esubnet_pool_tag</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; !subnet_pool_by_tag(m=
-&gt;top=2Eoptions=2Esubnet_pools, mi-&gt;context=2Eoptions=2Esubnet_pool_t=
ag))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&a=
mp; !subnet_pool_by_tag(m-&gt;top=2Eoptions=2Esubnet_pools, mi-&gt;context=
=2Eoptions=2Esubnet_pool_tag)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        &amp;&amp; !subnet_pool6_by_tag(m-&gt;top=2Eoptions=2Esub=
net_pools_ipv6,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                            mi-&gt;context=2Eoptions=2Esubnet_pool_tag))</s=
pan><br><span>     {</span><br><span>         msg(D_MULTI_ERRORS, &quot;MUL=
TI: client has been rejected due to unknown --subnet-pool-tag &#39;%s&#39;&=
quot;,</span><br><span>             mi-&gt;context=2Eoptions=2Esubnet_pool_=
tag);</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/op=
tions=2Ec</span><br><span>index 3f9f7de=2E=2Eb4485ca 100644</span><br><span=
>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2E=
c</span><br><span>@@ -446,6 +446,8 @@</span><br><span>     &quot;--subnet-p=
ool tag network netmask [gateway] : Define a named pool of\n&quot;</span><b=
r><span>     &quot;                  addresses outside the --server network=
, selected per\n&quot;</span><br><span>     &quot;                  client =
with --subnet-pool-tag=2E\n&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    &quot;--subnet-pool-ipv6 tag network/bits [gateway] : IPv=
6 counterpart of\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &quot;                  --subnet-pool=2E\n&quot;</span><br><span> =
    &quot;--subnet-pool-tag tag : Assign this client to the --subnet-pool n=
amed tag=2E\n&quot;</span><br><span>     &quot;                  Only valid=
 in a client-specific config file=2E\n&quot;</span><br><span>     &quot;--i=
fconfig-push local remote-netmask : Push an ifconfig option to remote,\n&qu=
ot;</span><br><span>@@ -7658,6 +7660,37 @@</span><br><span>         sp-&gt;=
next =3D options-&gt;subnet_pools;</span><br><span>         options-&gt;sub=
net_pools =3D sp;</span><br><span>     }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    else if (streq(p[0], &quot;subnet-pool-ipv6&quot;)=
 &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        struct subnet_pool6_def *sp;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct in6_addr network, gateway;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned in=
t netbits =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISS=
ION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (!get_ipv6_addr(p[2], &amp;network, &amp;netbits, msglevel))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;c=
annot parse --subnet-pool-ipv6 network&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            goto err;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (netbits &lt; 64 || netbits &gt; 124)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--sub=
net-pool-ipv6 network must be between /64 and /124 (not /%d)&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                netbits);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (p[3] &amp;&amp; !=
get_ipv6_addr(p[3], &amp;gateway, NULL, msglevel))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(msglevel, &quot;cannot parse --subnet-=
pool-ipv6 gateway&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            goto err;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      ALLOC_OBJ_GC(sp, struct subnet_pool6_def, &amp;options-&gt;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;tag =3D p[=
1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;n=
etwork =3D network;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        sp-&gt;netbits =3D netbits;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        sp-&gt;gateway =3D p[3] ? gateway : add_in6_addr(ne=
twork, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
p-&gt;next =3D options-&gt;subnet_pools_ipv6;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        options-&gt;subnet_pools_ipv6 =3D sp;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> =
    else if (streq(p[0], &quot;subnet-pool-tag&quot;) &amp;&amp; p[1] &amp;=
&amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY_PERMISS=
ION(OPT_P_INSTANCE);</span><br><span>diff --git a/src/openvpn/options=2Eh b=
/src/openvpn/options=2Eh</span><br><span>index 0c810b3=2E=2E7f0e3ce 100644<=
/span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/ope=
nvpn/options=2Eh</span><br><span>@@ -261,6 +261,16 @@</span><br><span>     =
in_addr_t gateway;</span><br><span> };</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* The IPv6 counterpart of struct subn=
et_pool_def (--subnet-pool-ipv6)=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+struct subnet_pool6_def</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct subnet_pool6_def *next;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const char *tag;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct in6_addr network;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    unsigned int netbits;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr gateway;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> /* Command line options */</s=
pan><br><span> struct options</span><br><span> {</span><br><span>@@ -526,12=
 +536,17 @@</span><br><span>     bool push_ifconfig_constraint_defined;</sp=
an><br><span>     in_addr_t push_ifconfig_constraint_network;</span><br><sp=
an>     in_addr_t push_ifconfig_constraint_netmask;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct subnet_pool_def *subnet_pools; /=
* named pools (server config) */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    const char *subnet_pool_tag;          /* which pool this cli=
ent uses (CCD) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
bool subnet_pool_defined;             /* resolved from the tag at connect *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_=
pool_def *subnet_pools;       /* named IPv4 pools (server config) */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6_de=
f *subnet_pools_ipv6; /* named IPv6 pools (server config) */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const char *subnet_pool_tag;  =
              /* which pool this client uses (CCD) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool subnet_pool_defined;            =
       /* resolved from the tag at connect */</span><br><span>     in_addr_=
t subnet_pool_network;</span><br><span>     in_addr_t subnet_pool_netmask;<=
/span><br><span>     in_addr_t subnet_pool_gateway;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool subnet_pool_ipv6_defined; /* res=
olved from the tag at connect */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct in6_addr subnet_pool_ipv6_network;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    unsigned int subnet_pool_ipv6_ne=
tbits;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct in=
6_addr subnet_pool_ipv6_gateway;</span><br><span>     bool push_ifconfig_ip=
v4_blocked;           /* IPv4 */</span><br><span>     bool push_ifconfig_ip=
v6_defined;           /* IPv6 */</span><br><span>     struct in6_addr push_=
ifconfig_ipv6_local;  /* IPv6 */</span><br><span>diff --git a/src/openvpn/o=
ptions_util=2Ec b/src/openvpn/options_util=2Ec</span><br><span>index ba0491=
7=2E=2E7826458 100644</span><br><span>--- a/src/openvpn/options_util=2Ec</s=
pan><br><span>+++ b/src/openvpn/options_util=2Ec</span><br><span>@@ -44,6 +=
44,19 @@</span><br><span>     return NULL;</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+const struct su=
bnet_pool6_def *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sub=
net_pool6_by_tag(const struct subnet_pool6_def *pools, const char *tag)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (const struct subnet_pool6_def *d=
 =3D pools; d; d =3D d-&gt;next)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (!strcmp(d-&gt;tag, tag))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            return d;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const char *</span>=
<br><span> parse_auth_failed_temp(struct options *o, const char *reason)</s=
pan><br><span> {</span><br><span>diff --git a/src/openvpn/options_util=2Eh =
b/src/openvpn/options_util=2Eh</span><br><span>index c54357c=2E=2Eed2017a 1=
00644</span><br><span>--- a/src/openvpn/options_util=2Eh</span><br><span>++=
+ b/src/openvpn/options_util=2Eh</span><br><span>@@ -38,6 +38,10 @@</span><=
br><span> const struct subnet_pool_def *subnet_pool_by_tag(const struct sub=
net_pool_def *pools,</span><br><span>                                      =
            const char *tag);</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/** IPv6 counterpart of subnet_pool_by_tag()=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const struct sub=
net_pool6_def *subnet_pool6_by_tag(const struct subnet_pool6_def *pools,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
                             const char *tag);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span> /** Checks i=
f the string is a valid integer by checking if it can be</span><br><span>  =
*  converted to an integer */</span><br><span>diff --git a/tests/unit_tests=
/openvpn/test_subnet_pool=2Ec b/tests/unit_tests/openvpn/test_subnet_pool=
=2Ec</span><br><span>index 8e73b64=2E=2Ed01ce05 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_subnet_pool=2Ec</span><br><span>+++ b/tests=
/unit_tests/openvpn/test_subnet_pool=2Ec</span><br><span>@@ -60,8 +60,26 @@=
</span><br><span>     assert_null(subnet_pool_by_tag(NULL, &quot;grpA&quot;=
));</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* the IPv6 counterpart resolves independently: a tag =
may name a v4 pool, a</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * v6 pool, or both=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_subnet_pool6_by_tag(void **state)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct subnet_pool6_def c =3D { =2Enext =3D NULL, =2Etag =3D &quot;grp=
C&quot;, =2Enetbits =3D 64 };</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct subnet_pool6_def b =3D { =2Enext =3D &amp;c, =2Etag =
=3D &quot;grpB&quot;, =2Enetbits =3D 96 };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct subnet_pool6_def a =3D { =2Enext =3D &amp=
;b, =2Etag =3D &quot;grpA&quot;, =2Enetbits =3D 64 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_ptr_equal(subnet_pool6_by_tag(&amp;a, &quot;grpA&=
quot;), &amp;a);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_ptr_equal(subnet_pool6_by_tag(&amp;a, &quot;grpB&quot;), &amp;b);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(=
subnet_pool6_by_tag(&amp;a, &quot;grpC&quot;), &amp;c);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(subnet_pool6_by_ta=
g(&amp;a, &quot;grpB&quot;)-&gt;netbits, 96);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_null(subnet_pool6_by_tag(&amp;a, &quot=
;nope&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_null(subnet_pool6_by_tag(NULL, &quot;grpA&quot;));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> const struct CMUnitTest subnet_pool_te=
sts[] =3D {</span><br><span>     cmocka_unit_test(test_subnet_pool_by_tag),=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_tes=
t(test_subnet_pool6_by_tag),</span><br><span> };</span><br><span> </span><b=
r><span> int</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail">change 1786</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I64e0=
850d48647a2c0e3d385c2f20a9f445931727 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1786 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>

</body></html>
--YV/AuxfZWHw=--


--===============2812420719724154160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2812420719724154160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2812420719724154160==--

