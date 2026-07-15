Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BEFC44508
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 07:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KP1d5oJT2yGMscw7bTclwd2n3AcpS+/TbbVeKYIfag4=; b=WrYxtl6sx7pnRl+0eMW05lXQas
	tcNT2iXfjrNxvtLsXJIgzQICynFnzjCFZ9bNaLG2dRIGBs3XLj4EZDqGYvMwWp6Dsi+TSNdIFFBgL
	shJmkaaMRGk8qZOBYWL9P55oyjck8eUw1o7oWcRWSvf5VWpa0dKxKMC7LEmj79JZCO+8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjuUa-0005Ct-5e;
	Wed, 15 Jul 2026 07:57:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjuUY-0005Cn-KW
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 07:57:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UoFOeOxLFFPUaR25nPgMkCQDXywSKB36x0gtDGllnW0=; b=Kr41/+k+NWAh/iOVRDegFTLV6Q
 tPVjk6bSr/XdZSIcuXWvLGbFpDFovH1zsgN+4KOGwpOwcrC8Wc4nkdORx2jsFAb36aHMVRBAYK4NZ
 bBMKiL84i7sOJer/P18u95qjoyDrkHPXtac7DeMswJt5ppanydmRh9YcYimoRhdgscu0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UoFOeOxLFFPUaR25nPgMkCQDXywSKB36x0gtDGllnW0=; b=j
 MxSUv/51+LAbiO+jFo1GWi0nI24UAdqdjmTDIbkoGRF4F7icPgVYWYNVXriov5t0ZoxfKDsyP2MGR
 akt69fJB3grxkx+CvAS0qssVDDYEcaF8+Tj7tlH4qsu7b8Aicro7j2BLWLb4d8SttTFUuZzYMGKRl
 6H/sF96sIjkd10to=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjuUW-0006bR-NU for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 07:57:18 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47df6a5202bso3197327f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 00:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784102225; x=1784707025; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UoFOeOxLFFPUaR25nPgMkCQDXywSKB36x0gtDGllnW0=;
 b=Q7b/0fcMipS1jP5oLO3WmtQ9Tb+K81ZAANEBFUs4tmW0GIF7KrBKiXyv7OYawxI4L/
 OSAP8DKVmoZjXSYt+KRYOHMpnVOND8q6zbHV5CfcsqsghP/1dNg16vI/luJjBrWSlsEn
 6DHRE8SrQG5A9mRAUbABMeu/znesK7FrdSWwUFhkK9Ebvf33b/VyGCmBC8dqloufDJfb
 2et9UfFQa+98x7DyVg9w0JPH3hmDVicDBGCtHeyRN1EmL5U4FKKSlBbwc+gTGSPLEsf+
 APM9gyzwWvqZJlqKviOyZZS4ksYuuTkrbXrp4UhM0bQm+be4RzFuP8wTWteunBaVh0Pj
 rHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784102225; x=1784707025;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UoFOeOxLFFPUaR25nPgMkCQDXywSKB36x0gtDGllnW0=;
 b=Ye0v4Zb73Z/zg8Jlg3SkHFbYA3qOK3pp49t8xp/UkZyVd3pWhGvX46C4WQQuHyGJKQ
 z8ojfJOpcGFLr8mMWojWNeiJrNztxUEeCuhPcFf8IZzqsaVyfCZdPonFvYj/Xd3Xm26b
 vxqbvnGI5p560QyrkTiqjyF0yWOfdLKFqTriV6I4UAt9WLoVT6Eo+e2EPzalDfnqOYKY
 +o+TUASwj3Id6l2nXMrsS8LDrRMCwkzaUq/IilGsOa54ZU6VpSW1fAXmHh+SmWVDqcYL
 2dYJDcJLjOtWO5jo+9HsWa9KtuFYgy6Pr9GEc638E1eSp6GeHhMDQGVyf2hyvZSLJbn5
 9NWw==
X-Gm-Message-State: AOJu0YwiXFokTGpUzS3jN7o67hvL/H+EqkZpmh+lP+vmvYEYyl+v2nqQ
 TWadrdIthz6JvmX9Dnhd3fRK2An5Od3wQQ+iTBgKivqAwhM0+L1f9WWnsNpR48u+AMdtYBK3ojU
 HZ9pjsQU7qApL0DDbLkdnO0Y6QkPKtIuLKZWaQl+w00eN6m+G6OMtUMPuhQSHekjQUExH8hX83R
 +w6Vp4rQ==
X-Gm-Gg: AfdE7ckFc6Dr8uOKtx0Q+BDEg6dJEnHKFgoVVv8dOu2h82lNSOI+TtsPc7S9nJq0+Vo
 IPExGCXzCjLjGcn4NnHdrxiFT+RRC/G4NbUJ23H84QlCVXVWmTf60y+RftsWUAKYBsytOtJ0FN4
 V839diojpK1muiwOMPhM3ygpCVFaSqyZWi2lD/R/gv3XHJCcuRtlqfHsuO++3ckHsgnuOHjXTP+
 Uqj0+SuP5IWqU/QvqcFEdpwURiO8NhmYwq0o/TJAD7DPpNtJcJtB8Jsyinhg6leZWFSoaW/WNcU
 ANc8295OYM8elqu3OiWVw9CJBZYkm1PwzctvzYO+22kyTL/4gNQm2/0nuO6d64lh5o6wYUqiJlq
 Jof7OLMJd5hNNUdpoyDIv0SRWwM95EaQ6tDMHKd6Fso7uCC8Aj9p6+2QirLmXXRvZW/GyZ0MoMy
 TX92hdhDWNHYfeJjnCtW6vVvR4/Y1OMfl6meTSFl7TTxGPv9TBnVSD9q7EYvc2dGMmp+Hwi4598
 ClBj+FDBphhjnHSNc3RvpFRdEUE9QDVOLg5CWWRq1w8Z7JvRedHWqofoyn6UrpnT61V3vVMjr4v
 sig=
X-Received: by 2002:a05:600c:a20a:b0:492:40a1:1e16 with SMTP id
 5b1f17b1804b1-4953c1451d5mr12487915e9.8.1784102224899; 
 Wed, 15 Jul 2026 00:57:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950871e830sm134521095e9.2.2026.07.15.00.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 00:57:04 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 07:56:56 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727
X-Gerrit-Change-Number: 1786
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1786?usp=email>
X-Gerrit-Commit: 41378df81fccebcb8f6b93afe22a9df245814925
In-Reply-To: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
References: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkk2NGUwODUwZDQ4NjQ3YTJjMGUzZDM4NWMyZjIwYTlmNDQ1OTMxNzI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <54fb96d030da8cee556ad134fdce7d889c82e8c8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjuUW-0006bR-NU
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
Content-Type: multipart/mixed; boundary="===============5853956318536940735=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5853956318536940735==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MvY9+DoiMJw="; charset=UTF-8

--MvY9+DoiMJw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1786?usp=3Demail

to look at the new patch set (#2)=2E

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
6 files changed, =
138 insertions(+), 25 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/86/1786/2

diff --git a/doc/man-sections/serve=
r-options=2Erst b/doc/man-sections/server-options=2Erst
index 8800b98=2E=2E=
cf92905 100644
--- a/doc/man-sections/server-options=2Erst
+++ b/doc/man-se=
ctions/server-options=2Erst
@@ -349,11 +349,24 @@
   ``--route-gateway`` in=
side the subnet, and a host route back to the server's
   VPN IP, so it is =
reachable without manual per-client route pushes=2E
 
+--subnet-pool-ipv6 a=
rgs
+  The IPv6 counterpart of ``--subnet-pool``=2E Repeatable main-config =
directive=2E
+
+  Valid syntax:
+  ::
+
+     subnet-pool-ipv6 tag network/=
bits [gateway]
+
+  ``bits`` must be between 64 and 124; ``gateway`` defaul=
ts to the first
+  address of the network=2E A tag may name an IPv4 pool, a=
n IPv6 pool, or both;
+  a client referencing it with ``--subnet-pool-tag``=
 is then assigned an
+  address from each family the tag defines=2E
+
 --su=
bnet-pool-tag tag
-  Assign this client to the ``--subnet-pool`` named ``ta=
g``=2E Must be
-  associated with a specific client instance via ``--client=
-config-dir`` or
-  ``--client-connect``=2E Several clients may reference t=
he same tag and are
-  then served from the same shared pool=2E
+  Assign t=
his client to the ``--subnet-pool`` / ``--subnet-pool-ipv6`` named
+  ``tag=
``=2E Must be associated with a specific client instance via
+  ``--client-=
config-dir`` or ``--client-connect``=2E Several clients may
+  reference th=
e same tag and are then served from the same shared pool(s)=2E
 
 --ifconfi=
g-ipv6-push args
   for ``--client-config-dir`` per-client static IPv6 inte=
rface
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index da46=
cf4=2E=2E1cd84b6 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=
=2Ec
@@ -1438,11 +1438,14 @@
     }
 
     const struct subnet_pool_def *d4=
 =3D subnet_pool_by_tag(m->top=2Eoptions=2Esubnet_pools, tag);
+    const s=
truct subnet_pool6_def *d6 =3D subnet_pool6_by_tag(m->top=2Eoptions=2Esubne=
t_pools_ipv6, tag);
     ALLOC_OBJ_CLEAR(sp, struct subnet_pool);
-    sp->=
tag =3D d4->tag;
-    sp->pool =3D ifconfig_pool_init(true, IFCONFIG_POOL_I=
NDIV, d4->network + 2,
-                                  (d4->network | ~d=
4->netmask) - 1, m->top=2Eoptions=2Eduplicate_cn,
-                        =
          false, in6addr_any, 0);
+    sp->tag =3D d4 ? d4->tag : d6->tag;
=
+    sp->pool =3D ifconfig_pool_init(d4 !=3D NULL, IFCONFIG_POOL_INDIV, d4 =
? d4->network + 2 : 0,
+                                  d4 ? (d4->network=
 | ~d4->netmask) - 1 : 0,
+                                  m->top=2Eoptio=
ns=2Eduplicate_cn, d6 !=3D NULL,
+                                  d6 ? ad=
d_in6_addr(d6->network, 2) : in6addr_any,
+                                =
  d6 ? (int)d6->netbits : 0);
     sp->next =3D m->subnet_pools;
     m->su=
bnet_pools =3D sp;
     return sp->pool;
@@ -1472,6 +1475,18 @@
           =
  mi->context=2Eoptions=2Esubnet_pool_gateway =3D d->gateway;
         }
  =
   }
+    if (mi->context=2Eoptions=2Esubnet_pool_tag && !mi->context=2Eopt=
ions=2Esubnet_pool_ipv6_defined)
+    {
+        const struct subnet_pool6_=
def *d =3D subnet_pool6_by_tag(
+            m->top=2Eoptions=2Esubnet_pool=
s_ipv6, mi->context=2Eoptions=2Esubnet_pool_tag);
+        if (d)
+        =
{
+            mi->context=2Eoptions=2Esubnet_pool_ipv6_defined =3D true;
+=
            mi->context=2Eoptions=2Esubnet_pool_ipv6_network =3D d->network=
;
+            mi->context=2Eoptions=2Esubnet_pool_ipv6_netbits =3D d->netb=
its;
+            mi->context=2Eoptions=2Esubnet_pool_ipv6_gateway =3D d->g=
ateway;
+        }
+    }
 
     /*
      * If ifconfig addresses were set =
by dynamic config file,
@@ -1506,42 +1521,60 @@
                 "MULTI_sva=
: WARNING: if --ifconfig-push is used for IPv4, automatic IPv6 assignment f=
rom --ifconfig-ipv6-pool does not work=2E  Use --ifconfig-ipv6-push for IPv=
6 then=2E");
         }
     }
-    else if (mi->context=2Eoptions=2Esubnet=
_pool_defined)
+    else if (mi->context=2Eoptions=2Esubnet_pool_tag)
     =
{
-        /* dynamic address from this client's --subnet-pool group */
+  =
      /* dynamic address(es) from this client's --subnet-pool group */
 
  =
       /* the CCD is read after a global-pool address may already have been=

-         * acquired; drop it so we can serve this client from its group *=
/
+         * acquired; drop it so we serve this client from its group only=
 */
         if (mi->vaddr_handle >=3D 0 && !mi->vaddr_pool)
         {
   =
          ifconfig_pool_release(m->ifconfig_pool, mi->vaddr_handle, true);
=
             mi->vaddr_handle =3D -1;
+            mi->context=2Ec2=2Epush_=
ifconfig_defined =3D false;
+            mi->context=2Ec2=2Epush_ifconfig_i=
pv6_defined =3D false;
         }
 
-        if (mi->vaddr_handle < 0)
+   =
     if ((mi->context=2Eoptions=2Esubnet_pool_defined
+             || mi->=
context=2Eoptions=2Esubnet_pool_ipv6_defined)
+            && mi->vaddr_han=
dle < 0)
         {
             in_addr_t local =3D 0, remote =3D 0;
+    =
        struct in6_addr remote_ipv6;
             const char *cn =3D NULL;
=
 
+            CLEAR(remote_ipv6);
             if (!mi->context=2Eoptions=
=2Eduplicate_cn)
             {
                 cn =3D tls_common_name(mi-=
>context=2Ec2=2Etls_multi, true);
             }
 
             mi->vaddr_p=
ool =3D multi_get_group_pool(m, mi->context=2Eoptions=2Esubnet_pool_tag);
-=
            mi->vaddr_handle =3D ifconfig_pool_acquire(mi->vaddr_pool, &loc=
al, &remote, NULL, cn);
-            if (mi->vaddr_handle >=3D 0)
-        =
    {
-                mi->context=2Ec2=2Epush_ifconfig_local =3D remote;
-=
                mi->context=2Ec2=2Epush_ifconfig_remote_netmask =3D
-      =
              mi->context=2Eoptions=2Esubnet_pool_netmask;
-               =
 mi->context=2Ec2=2Epush_ifconfig_defined =3D true;
-            }
-       =
     else
+            mi->vaddr_handle =3D
+                ifconfig_pool_=
acquire(mi->vaddr_pool, &local, &remote, &remote_ipv6, cn);
+            if=
 (mi->vaddr_handle < 0)
             {
                 msg(D_MULTI_ERRORS,=
 "MULTI: no free --subnet-pool addresses are available for %s",
           =
          multi_instance_string(mi, false, &gc));
             }
+         =
   else
+            {
+                if (mi->context=2Eoptions=2Esubnet_=
pool_defined)
+                {
+                    mi->context=2Ec2=2Epu=
sh_ifconfig_local =3D remote;
+                    mi->context=2Ec2=2Epush_=
ifconfig_remote_netmask =3D
+                        mi->context=2Eoptions=
=2Esubnet_pool_netmask;
+                    mi->context=2Ec2=2Epush_ifconf=
ig_defined =3D true;
+                }
+                if (mi->context=2E=
options=2Esubnet_pool_ipv6_defined)
+                {
+                   =
 mi->context=2Ec2=2Epush_ifconfig_ipv6_local =3D remote_ipv6;
+            =
        mi->context=2Ec2=2Epush_ifconfig_ipv6_remote =3D mi->context=2Ec1=
=2Etuntap->local_ipv6;
+                    mi->context=2Ec2=2Epush_ifconfi=
g_ipv6_netbits =3D
+                        mi->context=2Eoptions=2Esubnet_=
pool_ipv6_netbits;
+                    mi->context=2Ec2=2Epush_ifconfig_ip=
v6_defined =3D true;
+                }
+            }
         }
     }
  =
   else if (m->ifconfig_pool && mi->vaddr_handle < 0) /* otherwise, choose =
a pool address */
@@ -2852,7 +2885,9 @@
     }
 
     if (mi->context=2Eopt=
ions=2Esubnet_pool_tag
-        && !subnet_pool_by_tag(m->top=2Eoptions=2Es=
ubnet_pools, mi->context=2Eoptions=2Esubnet_pool_tag))
+        && !subnet_=
pool_by_tag(m->top=2Eoptions=2Esubnet_pools, mi->context=2Eoptions=2Esubnet=
_pool_tag)
+        && !subnet_pool6_by_tag(m->top=2Eoptions=2Esubnet_pools=
_ipv6,
+                                mi->context=2Eoptions=2Esubnet_pool=
_tag))
     {
         msg(D_MULTI_ERRORS, "MULTI: client has been rejected=
 due to unknown --subnet-pool-tag '%s'",
             mi->context=2Eoptions=
=2Esubnet_pool_tag);
diff --git a/src/openvpn/options=2Ec b/src/openvpn/opt=
ions=2Ec
index 3f9f7de=2E=2Eb4485ca 100644
--- a/src/openvpn/options=2Ec
++=
+ b/src/openvpn/options=2Ec
@@ -446,6 +446,8 @@
     "--subnet-pool tag net=
work netmask [gateway] : Define a named pool of\n"
     "                  =
addresses outside the --server network, selected per\n"
     "             =
     client with --subnet-pool-tag=2E\n"
+    "--subnet-pool-ipv6 tag netwo=
rk/bits [gateway] : IPv6 counterpart of\n"
+    "                  --subnet=
-pool=2E\n"
     "--subnet-pool-tag tag : Assign this client to the --subne=
t-pool named tag=2E\n"
     "                  Only valid in a client-speci=
fic config file=2E\n"
     "--ifconfig-push local remote-netmask : Push an =
ifconfig option to remote,\n"
@@ -7658,6 +7660,37 @@
         sp->next =3D =
options->subnet_pools;
         options->subnet_pools =3D sp;
     }
+    e=
lse if (streq(p[0], "subnet-pool-ipv6") && p[1] && p[2] && !p[4])
+    {
+ =
       struct subnet_pool6_def *sp;
+        struct in6_addr network, gatew=
ay;
+        unsigned int netbits =3D 0;
+
+        VERIFY_PERMISSION(OPT_P=
_GENERAL);
+        if (!get_ipv6_addr(p[2], &network, &netbits, msglevel))=

+        {
+            msg(msglevel, "cannot parse --subnet-pool-ipv6 net=
work");
+            goto err;
+        }
+        if (netbits < 64 || netb=
its > 124)
+        {
+            msg(msglevel, "--subnet-pool-ipv6 networ=
k must be between /64 and /124 (not /%d)",
+                netbits);
+    =
        goto err;
+        }
+        if (p[3] && !get_ipv6_addr(p[3], &gat=
eway, NULL, msglevel))
+        {
+            msg(msglevel, "cannot parse =
--subnet-pool-ipv6 gateway");
+            goto err;
+        }
+        AL=
LOC_OBJ_GC(sp, struct subnet_pool6_def, &options->gc);
+        sp->tag =3D=
 p[1];
+        sp->network =3D network;
+        sp->netbits =3D netbits;
=
+        sp->gateway =3D p[3] ? gateway : add_in6_addr(network, 1);
+      =
  sp->next =3D options->subnet_pools_ipv6;
+        options->subnet_pools_i=
pv6 =3D sp;
+    }
     else if (streq(p[0], "subnet-pool-tag") && p[1] && =
!p[2])
     {
         VERIFY_PERMISSION(OPT_P_INSTANCE);
diff --git a/src/=
openvpn/options=2Eh b/src/openvpn/options=2Eh
index 0c810b3=2E=2E7f0e3ce 10=
0644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -261,6 =
+261,16 @@
     in_addr_t gateway;
 };
 
+/* The IPv6 counterpart of struct=
 subnet_pool_def (--subnet-pool-ipv6)=2E */
+struct subnet_pool6_def
+{
+  =
  struct subnet_pool6_def *next;
+    const char *tag;
+    struct in6_addr=
 network;
+    unsigned int netbits;
+    struct in6_addr gateway;
+};
+
 /=
* Command line options */
 struct options
 {
@@ -526,12 +536,17 @@
     boo=
l push_ifconfig_constraint_defined;
     in_addr_t push_ifconfig_constraint=
_network;
     in_addr_t push_ifconfig_constraint_netmask;
-    struct subn=
et_pool_def *subnet_pools; /* named pools (server config) */
-    const cha=
r *subnet_pool_tag;          /* which pool this client uses (CCD) */
-    b=
ool subnet_pool_defined;             /* resolved from the tag at connect */=

+    struct subnet_pool_def *subnet_pools;       /* named IPv4 pools (serv=
er config) */
+    struct subnet_pool6_def *subnet_pools_ipv6; /* named IPv=
6 pools (server config) */
+    const char *subnet_pool_tag;               =
 /* which pool this client uses (CCD) */
+    bool subnet_pool_defined;    =
               /* resolved from the tag at connect */
     in_addr_t subnet=
_pool_network;
     in_addr_t subnet_pool_netmask;
     in_addr_t subnet_po=
ol_gateway;
+    bool subnet_pool_ipv6_defined; /* resolved from the tag at=
 connect */
+    struct in6_addr subnet_pool_ipv6_network;
+    unsigned in=
t subnet_pool_ipv6_netbits;
+    struct in6_addr subnet_pool_ipv6_gateway;
=
     bool push_ifconfig_ipv4_blocked;           /* IPv4 */
     bool push_i=
fconfig_ipv6_defined;           /* IPv6 */
     struct in6_addr push_ifconf=
ig_ipv6_local;  /* IPv6 */
diff --git a/src/openvpn/options_util=2Ec b/src/=
openvpn/options_util=2Ec
index ba04917=2E=2E7826458 100644
--- a/src/openvp=
n/options_util=2Ec
+++ b/src/openvpn/options_util=2Ec
@@ -44,6 +44,19 @@
  =
   return NULL;
 }
 
+const struct subnet_pool6_def *
+subnet_pool6_by_tag(=
const struct subnet_pool6_def *pools, const char *tag)
+{
+    for (const s=
truct subnet_pool6_def *d =3D pools; d; d =3D d->next)
+    {
+        if (=
!strcmp(d->tag, tag))
+        {
+            return d;
+        }
+    }
+=
    return NULL;
+}
+
 const char *
 parse_auth_failed_temp(struct options =
*o, const char *reason)
 {
diff --git a/src/openvpn/options_util=2Eh b/src/=
openvpn/options_util=2Eh
index c54357c=2E=2Eed2017a 100644
--- a/src/openvp=
n/options_util=2Eh
+++ b/src/openvpn/options_util=2Eh
@@ -38,6 +38,10 @@
 c=
onst struct subnet_pool_def *subnet_pool_by_tag(const struct subnet_pool_de=
f *pools,
                                                  const char *tag=
);
 
+/** IPv6 counterpart of subnet_pool_by_tag()=2E */
+const struct subn=
et_pool6_def *subnet_pool6_by_tag(const struct subnet_pool6_def *pools,
+  =
                                                 const char *tag);
+
 
 /**=
 Checks if the string is a valid integer by checking if it can be
  *  conv=
erted to an integer */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1786?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727
Gerrit-Change-Number: 1786
=
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>

--MvY9+DoiMJw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex <strong>uploaded patch set=
 #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
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
ptions_util=2Eh<br>6 files changed, 138 insertions(+), 25 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/86/1786/2</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/doc/man-sections/server-options=
=2Erst b/doc/man-sections/server-options=2Erst</span><br><span>index 8800b9=
8=2E=2Ecf92905 100644</span><br><span>--- a/doc/man-sections/server-options=
=2Erst</span><br><span>+++ b/doc/man-sections/server-options=2Erst</span><b=
r><span>@@ -349,11 +349,24 @@</span><br><span>   ``--route-gateway`` inside=
 the subnet, and a host route back to the server&#39;s</span><br><span>   V=
PN IP, so it is reachable without manual per-client route pushes=2E</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--subnet-=
pool-ipv6 args</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The=
 IPv6 counterpart of ``--subnet-pool``=2E Repeatable main-config directive=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  Valid syntax:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  ::</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     subnet-pool-ipv6 tag network/bits [gateway]</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  ``bits`` must be between 64 and 124; ``gateway`` defaults to =
the first</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  address =
of the network=2E A tag may name an IPv4 pool, an IPv6 pool, or both;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  a client referencing it=
 with ``--subnet-pool-tag`` is then assigned an</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  address from each family the tag defines=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --s=
ubnet-pool-tag tag</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  A=
ssign this client to the ``--subnet-pool`` named ``tag``=2E Must be</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  associated with a specific =
client instance via ``--client-config-dir`` or</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  ``--client-connect``=2E Several clients may refe=
rence the same tag and are</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  then served from the same shared pool=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  Assign this client to the ``--subnet-pool`` /=
 ``--subnet-pool-ipv6`` named</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  ``tag``=2E Must be associated with a specific client instance v=
ia</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--client-conf=
ig-dir`` or ``--client-connect``=2E Several clients may</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  reference the same tag and are then s=
erved from the same shared pool(s)=2E</span><br><span> </span><br><span> --=
ifconfig-ipv6-push args</span><br><span>   for ``--client-config-dir`` per-=
client static IPv6 interface</span><br><span>diff --git a/src/openvpn/multi=
=2Ec b/src/openvpn/multi=2Ec</span><br><span>index da46cf4=2E=2E1cd84b6 100=
644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/o=
penvpn/multi=2Ec</span><br><span>@@ -1438,11 +1438,14 @@</span><br><span>  =
   }</span><br><span> </span><br><span>     const struct subnet_pool_def *d=
4 =3D subnet_pool_by_tag(m-&gt;top=2Eoptions=2Esubnet_pools, tag);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const struct subnet_pool=
6_def *d6 =3D subnet_pool6_by_tag(m-&gt;top=2Eoptions=2Esubnet_pools_ipv6, =
tag);</span><br><span>     ALLOC_OBJ_CLEAR(sp, struct subnet_pool);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    sp-&gt;tag =3D d4-&gt;tag=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sp-&gt;pool =3D =
ifconfig_pool_init(true, IFCONFIG_POOL_INDIV, d4-&gt;network + 2,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
   (d4-&gt;network | ~d4-&gt;netmask) - 1, m-&gt;top=2Eoptions=2Eduplicate_=
cn,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
                false, in6addr_any, 0);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    sp-&gt;tag =3D d4 ? d4-&gt;tag : d6-&gt;tag;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;pool =3D ifconf=
ig_pool_init(d4 !=3D NULL, IFCONFIG_POOL_INDIV, d4 ? d4-&gt;network + 2 : 0=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                d4 ? (d4-&gt;network | ~d4-&gt;netmask) - 1 : 0,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
    m-&gt;top=2Eoptions=2Eduplicate_cn, d6 !=3D NULL,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                  d6 ? ad=
d_in6_addr(d6-&gt;network, 2) : in6addr_any,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                  d6 ? (int)d6-&gt=
;netbits : 0);</span><br><span>     sp-&gt;next =3D m-&gt;subnet_pools;</sp=
an><br><span>     m-&gt;subnet_pools =3D sp;</span><br><span>     return sp=
-&gt;pool;</span><br><span>@@ -1472,6 +1475,18 @@</span><br><span>         =
    mi-&gt;context=2Eoptions=2Esubnet_pool_gateway =3D d-&gt;gateway;</span=
><br><span>         }</span><br><span>     }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (mi-&gt;context=2Eoptions=2Esubnet_pool_tag=
 &amp;&amp; !mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_defined)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const struct subnet_pool6_def *d =
=3D subnet_pool6_by_tag(</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            m-&gt;top=2Eoptions=2Esubnet_pools_ipv6, mi-&gt;context=2E=
options=2Esubnet_pool_tag);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (d)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_defined =3D true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=
=2Eoptions=2Esubnet_pool_ipv6_network =3D d-&gt;network;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=2Eoptions=
=2Esubnet_pool_ipv6_netbits =3D d-&gt;netbits;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            mi-&gt;context=2Eoptions=2Esubnet_po=
ol_ipv6_gateway =3D d-&gt;gateway;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span> </span><br><span>     /*</span><br><span>      =
* If ifconfig addresses were set by dynamic config file,</span><br><span>@@=
 -1506,42 +1521,60 @@</span><br><span>                 &quot;MULTI_sva: WAR=
NING: if --ifconfig-push is used for IPv4, automatic IPv6 assignment from -=
-ifconfig-ipv6-pool does not work=2E  Use --ifconfig-ipv6-push for IPv6 the=
n=2E&quot;);</span><br><span>         }</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    else if (mi-&gt;context=2Eopti=
ons=2Esubnet_pool_defined)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    else if (mi-&gt;context=2Eoptions=2Esubnet_pool_tag)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*=
 dynamic address from this client&#39;s --subnet-pool group */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* dynamic address(es) f=
rom this client&#39;s --subnet-pool group */</span><br><span> </span><br><s=
pan>         /* the CCD is read after a global-pool address may already hav=
e been</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * acqu=
ired; drop it so we can serve this client from its group */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         * acquired; drop it so we =
serve this client from its group only */</span><br><span>         if (mi-&g=
t;vaddr_handle &gt;=3D 0 &amp;&amp; !mi-&gt;vaddr_pool)</span><br><span>   =
      {</span><br><span>             ifconfig_pool_release(m-&gt;ifconfig_p=
ool, mi-&gt;vaddr_handle, true);</span><br><span>             mi-&gt;vaddr_=
handle =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       mi-&gt;context=2Ec2=2Epush_ifconfig_defined =3D false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=2Ec2=
=2Epush_ifconfig_ipv6_defined =3D false;</span><br><span>         }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(mi-&gt;vaddr_handle &lt; 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if ((mi-&gt;context=2Eoptions=2Esubnet_pool_defined</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+             || mi-&gt;con=
text=2Eoptions=2Esubnet_pool_ipv6_defined)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            &amp;&amp; mi-&gt;vaddr_handle &lt; 0)</=
span><br><span>         {</span><br><span>             in_addr_t local =3D =
0, remote =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         struct in6_addr remote_ipv6;</span><br><span>             const ch=
ar *cn =3D NULL;</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            CLEAR(remote_ipv6);</span><br><span>            =
 if (!mi-&gt;context=2Eoptions=2Eduplicate_cn)</span><br><span>            =
 {</span><br><span>                 cn =3D tls_common_name(mi-&gt;context=
=2Ec2=2Etls_multi, true);</span><br><span>             }</span><br><span> <=
/span><br><span>             mi-&gt;vaddr_pool =3D multi_get_group_pool(m, =
mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            mi-&gt;vaddr_handle =3D ifconfig_pool_ac=
quire(mi-&gt;vaddr_pool, &amp;local, &amp;remote, NULL, cn);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            if (mi-&gt;vaddr_handle =
&gt;=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                mi-=
&gt;context=2Ec2=2Epush_ifconfig_local =3D remote;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                mi-&gt;context=2Ec2=2Epush_ifc=
onfig_remote_netmask =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    mi-&gt;context=2Eoptions=2Esubnet_pool_netmask;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                mi-&gt;con=
text=2Ec2=2Epush_ifconfig_defined =3D true;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            else</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            mi-&gt;vaddr_handle =3D</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                ifconfig_pool_acquire(mi-&gt;vad=
dr_pool, &amp;local, &amp;remote, &amp;remote_ipv6, cn);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (mi-&gt;vaddr_handle &l=
t; 0)</span><br><span>             {</span><br><span>                 msg(D=
_MULTI_ERRORS, &quot;MULTI: no free --subnet-pool addresses are available f=
or %s&quot;,</span><br><span>                     multi_instance_string(mi,=
 false, &amp;gc));</span><br><span>             }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                if (mi-&gt;context=2Eoptions=2Esubnet_=
pool_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            mi-&gt;context=2Ec2=2Epush_ifconfig_local =3D remote;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    mi-&gt;co=
ntext=2Ec2=2Epush_ifconfig_remote_netmask =3D</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                        mi-&gt;context=2Eoptions=
=2Esubnet_pool_netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    mi-&gt;context=2Ec2=2Epush_ifconfig_defined =3D tru=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                if =
(mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_defined)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    mi-&gt;context=2Ec2=
=2Epush_ifconfig_ipv6_local =3D remote_ipv6;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                    mi-&gt;context=2Ec2=2Epush_ifc=
onfig_ipv6_remote =3D mi-&gt;context=2Ec1=2Etuntap-&gt;local_ipv6;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    mi-&gt;c=
ontext=2Ec2=2Epush_ifconfig_ipv6_netbits =3D</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        mi-&gt;context=2Eoptions=
=2Esubnet_pool_ipv6_netbits;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_defin=
ed =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   }</span><br><span>         }</span><br><span>     }</span><br><span>    =
 else if (m-&gt;ifconfig_pool &amp;&amp; mi-&gt;vaddr_handle &lt; 0) /* oth=
erwise, choose a pool address */</span><br><span>@@ -2852,7 +2885,9 @@</spa=
n><br><span>     }</span><br><span> </span><br><span>     if (mi-&gt;contex=
t=2Eoptions=2Esubnet_pool_tag</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        &amp;&amp; !subnet_pool_by_tag(m-&gt;top=2Eoptions=2Esubnet=
_pools, mi-&gt;context=2Eoptions=2Esubnet_pool_tag))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !subnet_pool_by_tag(m-=
&gt;top=2Eoptions=2Esubnet_pools, mi-&gt;context=2Eoptions=2Esubnet_pool_ta=
g)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp=
; !subnet_pool6_by_tag(m-&gt;top=2Eoptions=2Esubnet_pools_ipv6,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
 mi-&gt;context=2Eoptions=2Esubnet_pool_tag))</span><br><span>     {</span>=
<br><span>         msg(D_MULTI_ERRORS, &quot;MULTI: client has been rejecte=
d due to unknown --subnet-pool-tag &#39;%s&#39;&quot;,</span><br><span>    =
         mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</span><br><span>diff =
--git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>i=
ndex 3f9f7de=2E=2Eb4485ca 100644</span><br><span>--- a/src/openvpn/options=
=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -446,=
6 +446,8 @@</span><br><span>     &quot;--subnet-pool tag network netmask [g=
ateway] : Define a named pool of\n&quot;</span><br><span>     &quot;       =
           addresses outside the --server network, selected per\n&quot;</sp=
an><br><span>     &quot;                  client with --subnet-pool-tag=2E\=
n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--=
subnet-pool-ipv6 tag network/bits [gateway] : IPv6 counterpart of\n&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;           =
       --subnet-pool=2E\n&quot;</span><br><span>     &quot;--subnet-pool-ta=
g tag : Assign this client to the --subnet-pool named tag=2E\n&quot;</span>=
<br><span>     &quot;                  Only valid in a client-specific conf=
ig file=2E\n&quot;</span><br><span>     &quot;--ifconfig-push local remote-=
netmask : Push an ifconfig option to remote,\n&quot;</span><br><span>@@ -76=
58,6 +7660,37 @@</span><br><span>         sp-&gt;next =3D options-&gt;subne=
t_pools;</span><br><span>         options-&gt;subnet_pools =3D sp;</span><b=
r><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
lse if (streq(p[0], &quot;subnet-pool-ipv6&quot;) &amp;&amp; p[1] &amp;&amp=
; p[2] &amp;&amp; !p[4])</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
truct subnet_pool6_def *sp;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        struct in6_addr network, gateway;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        unsigned int netbits =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!get_ipv6_addr=
(p[2], &amp;network, &amp;netbits, msglevel))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            msg(msglevel, &quot;cannot parse --subnet-pool-=
ipv6 network&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (netbits &lt; 64 || netbits &gt; 124)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(msglevel, &quot;--subnet-pool-ipv6 network must=
 be between /64 and /124 (not /%d)&quot;,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                netbits);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            goto err;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (p[3] &amp;&amp; !get_ipv6_addr(p[3], &amp;g=
ateway, NULL, msglevel))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       msg(msglevel, &quot;cannot parse --subnet-pool-ipv6 gateway&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto err=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        ALLOC_OBJ_GC(sp, str=
uct subnet_pool6_def, &amp;options-&gt;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        sp-&gt;tag =3D p[1];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;network =3D network;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;netbits =
=3D netbits;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 sp-&gt;gateway =3D p[3] ? gateway : add_in6_addr(network, 1);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;next =3D options-=
&gt;subnet_pools_ipv6;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        options-&gt;subnet_pools_ipv6 =3D sp;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (streq(p[0]=
, &quot;subnet-pool-tag&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br>=
<span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_INSTANCE);</s=
pan><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2E=
h</span><br><span>index 0c810b3=2E=2E7f0e3ce 100644</span><br><span>--- a/s=
rc/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span>=
<br><span>@@ -261,6 +261,16 @@</span><br><span>     in_addr_t gateway;</spa=
n><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/* The IPv6 counterpart of struct subnet_pool_def (--subnet-p=
ool-ipv6)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stru=
ct subnet_pool6_def</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_=
pool6_def *next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const char *tag;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct in6_addr network;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    unsigned int netbits;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct in6_addr gateway;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> /* Command line options */</span><br><span> struct o=
ptions</span><br><span> {</span><br><span>@@ -526,12 +536,17 @@</span><br><=
span>     bool push_ifconfig_constraint_defined;</span><br><span>     in_ad=
dr_t push_ifconfig_constraint_network;</span><br><span>     in_addr_t push_=
ifconfig_constraint_netmask;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    struct subnet_pool_def *subnet_pools; /* named pools (server con=
fig) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char=
 *subnet_pool_tag;          /* which pool this client uses (CCD) */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    bool subnet_pool_defined;=
             /* resolved from the tag at connect */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_def *subnet_pools;=
       /* named IPv4 pools (server config) */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct subnet_pool6_def *subnet_pools_ipv6; /=
* named IPv6 pools (server config) */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const char *subnet_pool_tag;                /* which =
pool this client uses (CCD) */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    bool subnet_pool_defined;                   /* resolved from=
 the tag at connect */</span><br><span>     in_addr_t subnet_pool_network;<=
/span><br><span>     in_addr_t subnet_pool_netmask;</span><br><span>     in=
_addr_t subnet_pool_gateway;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    bool subnet_pool_ipv6_defined; /* resolved from the tag at con=
nect */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct i=
n6_addr subnet_pool_ipv6_network;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    unsigned int subnet_pool_ipv6_netbits;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr subnet_pool_ipv6_g=
ateway;</span><br><span>     bool push_ifconfig_ipv4_blocked;           /* =
IPv4 */</span><br><span>     bool push_ifconfig_ipv6_defined;           /* =
IPv6 */</span><br><span>     struct in6_addr push_ifconfig_ipv6_local;  /* =
IPv6 */</span><br><span>diff --git a/src/openvpn/options_util=2Ec b/src/ope=
nvpn/options_util=2Ec</span><br><span>index ba04917=2E=2E7826458 100644</sp=
an><br><span>--- a/src/openvpn/options_util=2Ec</span><br><span>+++ b/src/o=
penvpn/options_util=2Ec</span><br><span>@@ -44,6 +44,19 @@</span><br><span>=
     return NULL;</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+const struct subnet_pool6_def *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+subnet_pool6_by_tag(const st=
ruct subnet_pool6_def *pools, const char *tag)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    for (const struct subnet_pool6_def *d =3D pools; d; d =3D d-&g=
t;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!strcmp(d-&gt;=
tag, tag))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return =
d;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> const char *</span><br><span> parse_auth_fai=
led_temp(struct options *o, const char *reason)</span><br><span> {</span><b=
r><span>diff --git a/src/openvpn/options_util=2Eh b/src/openvpn/options_uti=
l=2Eh</span><br><span>index c54357c=2E=2Eed2017a 100644</span><br><span>---=
 a/src/openvpn/options_util=2Eh</span><br><span>+++ b/src/openvpn/options_u=
til=2Eh</span><br><span>@@ -38,6 +38,10 @@</span><br><span> const struct su=
bnet_pool_def *subnet_pool_by_tag(const struct subnet_pool_def *pools,</spa=
n><br><span>                                                  const char *t=
ag);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/** IPv6 counterpart of subnet_pool_by_tag()=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+const struct subnet_pool6_def *subnet_poo=
l6_by_tag(const struct subnet_pool6_def *pools,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                               =
    const char *tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> </span><br><span> /** Checks if the string is a valid i=
nteger by checking if it can be</span><br><span>  *  converted to an intege=
r */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail">change 1786</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I64e0850d4864=
7a2c0e3d385c2f20a9f445931727 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1786 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>

</body></html>
--MvY9+DoiMJw=--


--===============5853956318536940735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5853956318536940735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5853956318536940735==--

