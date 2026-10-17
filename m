Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FFECCF2CC
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 22:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u3IEDwmZdFDJ1GaWpoeREgLcvRO7rl84n7BTMI1RJfU=; b=X8xqT1NUOVJHztvLC+0H2h1doF
	4NoKuEXvmiDI4oMHKvoY1zfu87zJXKX5L3sbmMNmbn+bOVj+APLtQAGEMy4CtmXgHz+/RPRaQnw4W
	XpWZCLMMOBcNR47eo5fokpuartOTuGwuhcOAgvuj3BAU/jcktHNVM5V+5zPyXvGeWvJI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIDGZ-0000FJ-IW;
	Sat, 17 Oct 2026 22:52:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIDGX-0000FC-GT
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 22:52:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=OiFqQtCsYolTbiKdB2DmuCqFhqUkY8Tb/E6jCy6Qolg=; b=AzlyUJLVHMDS4Po0IDQAPiGd5f
 sYUG3uV3ySrNV6JA7yZj0C320Rkbq9HFZ31TgbrhV6DTkG4z4S+nulctOs72787on64NCnbzv+9x3
 kR4GOJ9z9DVbGwGGHXcAPgZrJ4UIpeQb8GbxS4dgZh9U2slkV9cRB4wk/XLJp1uxsPv0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OiFqQtCsYolTbiKdB2DmuCqFhqUkY8Tb/E6jCy6Qolg=; b=E
 j6yEBXfy6deCLgp4wKRYRHoc3SD5Izxttqkx9BNE9CsZ2SerIyGj8+rgd2OM5vTdO8WAArUCvhqvd
 3Qq62dB+9qhjaiO5ph9S+Jam9XpZp21GbMkaKLwD68hJFUPkA9RZbd/3dIwBFbg9J24+Fu973veh9
 hY53ZQZ/enC8J6Tc=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIDGT-0005kk-U8 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 22:52:38 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso474732f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 15:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792277547; x=1792882347; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OiFqQtCsYolTbiKdB2DmuCqFhqUkY8Tb/E6jCy6Qolg=;
 b=PVd4BVgdqh357rTqpWKIKzJrVLsCk7hsnz17X1D28H++Qta0qbrbRcWNfBZ6VX0wfE
 8vkKqd4sj9M251micLFEtGcmG7sqnG+3BJsWTGW60rkt24EdgSB6+Zl9v1uTWSHtuv8s
 m/tZR/b1Du43FcT4m2IqovOTsM6fGsmwz/qZ+K1vwNbxLilUYMIjSwdUoopstaaiO+XO
 CBwXtTC7v8hh0M6fncpundZtAUuEjlP1nPeIiy3nZ1u5h35YM0XS6Oeqap0UEes+X5pg
 pC7mdKnuGErvEDf4q1VQ7sezFheZv0sV2Kp2K5QSK+Ib8BbrDzwcl7dRUuECcl366xDw
 J1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792277547; x=1792882347;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OiFqQtCsYolTbiKdB2DmuCqFhqUkY8Tb/E6jCy6Qolg=;
 b=1AQIpCRbhsOXLo1ihDZ/D44ncHY0PN5mvIGPx26DhjJsM4KPBf0b/7uyD/U9VGXWXJ
 etNa7xmIbo+RIyvtqlE8A1JSVrONxS3rh/YaRX9e3/o2iUTWg5r8jveYAf0hZxX6dyTc
 nKbkmF2rJq+hrzxR+k2c0zscHP6WTw1cLANnpADzHLWBFh0/aaIyPYhIFxaAMJj9vu7D
 xMMHVsZ8xwh72n6PG8lgOhO3RLJa4Av0yRTESeK8RcRVLJUuciwbNoR7Dk0937xbRjG6
 /cUd7c5TlbuWLQ1/5bgna/Vu0ytkoBXS9m7TKQe9tPQGSqMnyNx1KYPRyUbFCT24mrOA
 ZdGA==
X-Gm-Message-State: AFq9FYKxjwwTMB24ywg/S73V0bZ8gkTgEs5WlAOBabr5tUYmzRZtcrib
 GaEf/ZZbSmiUohSrZyXJDU85nfsd1Xg1MBOG6uKmbOzVRaYxlVEb6PYB66WidEwTOU1klQqj6+n
 pmNriIpiDXdAuH4zNPjrljSoOziD0vDKcH2xd+DWuUcFoptHrNhOY/I41naZbTHhSFs94
X-Gm-Gg: AYBFou1PD1cjt+OD3dNN6GASG1OOIf5TzUfQpAIvJYHpCF318IwPq1FlI1R4uimVRbR
 Nbn2Nj1Dkhcm3KdvV3E0xzWKPZDyF9FzzUmhYzGV7YkfuiaB1+PwhxyqKlQ3i4fJbGhYY9JGyGv
 BsWGYJ2aYSNnOLP7AR1fvqqz7UiRakrHUstBrV5U26qvq/J+k+L830/87VY7yVdXZW9b8/vlozo
 0aSs7iQSnA43EqIrXcxrJQGPG7RcMsNzGl9QbYcLyIIAOmmm8IN0inUjv1niVVZjvVGJ6crGa28
 YoEcV6JY2qtuxHfEEVjIb6oFo9tWQyGwJevJmUg7BpY5gjRiCBEd5i5+kW9CGtqQN7Z0qnn7+19
 EuOh2We/CtFCdF6E+WTkQLn8n4cM8jz0cVVxgnJbd3rqpjkFNzSMXPbDiDLEQ3CTQGeUNoDSrEu
 8e7uxT33mCk+tG0G5EhmBxNOIunHUZTgMKPWaZ+vV7BjikrNU7EZPelvGkCqaEYRhXtqmlgJaCX
 euSYK11CsbZJ1/sjhCUWprQBkTg2LlKUaQIxvKqHTYkbp4Fuu5rwpkU++2vRirS3HPABAu+ZScq
 Ce5C66m21DIG8ZuyWM5QOtoRQeR5VVepTjcDfONGHcAS2YzfUaZ17BxiWE0i
X-Received: by 2002:a5d:66c3:0:b0:48c:7d67:8ee5 with SMTP id
 ffacd0b85a97d-48e07f9b9a3mr5070225f8f.43.1792277547036; 
 Sat, 17 Oct 2026 15:52:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd510c78sm13458802f8f.57.2026.10.17.15.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 15:52:26 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 22:52:22 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727
X-Gerrit-Change-Number: 1786
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1786?usp=email>
X-Gerrit-Commit: 2369a67b315d68f2559b80d70ab68aba8681defc
In-Reply-To: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
References: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkk2NGUwODUwZDQ4NjQ3YTJjMGUzZDM4NWMyZjIwYTlmNDQ1OTMxNzI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <491b624ab1aeb6a60a94c8c3a61ebe61c68c6c14-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIDGT-0005kk-U8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multi: assign IPv6
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
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7247859261292971087=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7247859261292971087==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M/Xf+WQVKt8="; charset=UTF-8

--M/Xf+WQVKt8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1786?usp=3Demail

to look at the new patch set (#=
4)=2E


Change subject: multi: assign IPv6 addresses from a tagged subnet-p=
ool
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: =
assign IPv6 addresses from a tagged subnet-pool

Add the IPv6 counterpart o=
f --subnet-pool:

  subnet-pool-ipv6 <tag> <network>/<bits> [<gateway>]   (=
main config)

selected by the same per-client --subnet-pool-tag=2E A client=
's tag is
resolved against the IPv6 pool list too and, when it matches, an =
IPv6
address is handed out from the group's pool alongside any IPv4 one (a
=
single dual-stack ifconfig_pool per tag)=2E The pool gateway is pushed as
t=
he remote end of the client's ifconfig-ipv6, as the server's own
address is=
 off-link for it=2E A tag matching neither family is still
declined with AU=
TH_FAILED=2E

As for IPv4 the pools are checked when the config is loaded (=
network
between /64 and /124 without host bits, gateway a host address insi=
de
it, unique tags, no overlap with another pool or the --server-ipv6
netwo=
rk), created at startup with their gateway reserved, and routed
into the se=
rver's tun device=2E

Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727
=
GitHub: closes openvpn/OpenVPN#987
Signed-off-by: Antonio Quartulli <antoni=
o@mandelbit=2Ecom>
---
M doc/man-sections/server-options=2Erst
M src/openvp=
n/multi=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M src/openv=
pn/options_util=2Ec
M src/openvpn/options_util=2Eh
M src/openvpn/pool=2Ec
M=
 src/openvpn/pool=2Eh
M tests/unit_tests/openvpn/test_subnet_pool=2Ec
9 fil=
es changed, 389 insertions(+), 29 deletions(-)


  git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/86/1786/4

diff --git a/doc/man-se=
ctions/server-options=2Erst b/doc/man-sections/server-options=2Erst
index b=
6eab9a=2E=2E1e98ff9 100644
--- a/doc/man-sections/server-options=2Erst
+++ =
b/doc/man-sections/server-options=2Erst
@@ -356,11 +356,32 @@
   The server=
 routes each pool's subnet into the tun device, as it does for
   the ``--s=
erver`` network; no ``--route`` needs to be added for it=2E
 
+--subnet-poo=
l-ipv6 args
+  The IPv6 counterpart of ``--subnet-pool``=2E Repeatable main=
-config directive=2E
+
+  Valid syntax:
+  ::
+
+     subnet-pool-ipv6 tag =
network/bits [gateway]
+
+  ``bits`` must be between 64 and 124; ``gateway`=
` defaults to the first
+  address of the network, is never assigned to a c=
lient, and is pushed to the
+  pool's clients as the remote end of their ``=
ifconfig-ipv6``=2E A tag may name
+  an IPv4 pool, an IPv6 pool, or both; a=
 client referencing it with
+  ``--subnet-pool-tag`` is then assigned an ad=
dress from each family the tag
+  defines=2E
+
+  Requires ``--server-ipv6`=
` with ``--dev tun``=2E ``network`` must have no host
+  bits set, ``gatewa=
y`` must be a host address inside it, each ``tag`` may be
+  defined only o=
nce and no pool may overlap another one or the
+  ``--server-ipv6`` network=
=2E As for ``--subnet-pool``, the server routes each
+  pool's network into=
 the tun device=2E
+
 --subnet-pool-tag tag
-  Assign this client to the ``=
--subnet-pool`` named ``tag``=2E Must be
-  associated with a specific clie=
nt instance via ``--client-config-dir`` or
-  ``--client-connect``=2E Sever=
al clients may reference the same tag and are
-  then served from the same =
shared pool=2E
+  Assign this client to the ``--subnet-pool`` / ``--subnet-=
pool-ipv6`` named
+  ``tag``=2E Must be associated with a specific client i=
nstance via
+  ``--client-config-dir`` or ``--client-connect``=2E Several c=
lients may
+  reference the same tag and are then served from the same shar=
ed pool(s)=2E
 
 --ifconfig-ipv6-push args
   for ``--client-config-dir`` p=
er-client static IPv6 interface
diff --git a/src/openvpn/multi=2Ec b/src/op=
envpn/multi=2Ec
index 86fd9c0=2E=2Eac3962d 100644
--- a/src/openvpn/multi=
=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -392,6 +392,10 @@
     {
         multi=
_get_group_pool(m, &t->options, d->tag);
     }
+    for (const struct subn=
et_pool6_def *d =3D t->options=2Esubnet_pools_ipv6; d; d =3D d->next)
+    =
{
+        multi_get_group_pool(m, &t->options, d->tag);
+    }
 
     /*
 =
     * Help us keep track of routing table=2E
@@ -1469,14 +1473,24 @@
     =
}
 
     const struct subnet_pool_def *d4 =3D subnet_pool_by_tag(o->subnet_=
pools, tag);
-    ASSERT(d4);
+    const struct subnet_pool6_def *d6 =3D su=
bnet_pool6_by_tag(o->subnet_pools_ipv6, tag);
+    ASSERT(d4 || d6);
     A=
LLOC_OBJ_CLEAR(sp, struct subnet_pool);
-    sp->tag =3D d4->tag;
-    /* e=
very host address of the subnet, minus the gateway reserved below */
-    s=
p->pool =3D ifconfig_pool_init(true, IFCONFIG_POOL_INDIV, d4->network + 1,
=
-                                  (d4->network | ~d4->netmask) - 1, o->dup=
licate_cn, false,
-                                  in6addr_any, 0);
-    =
ifconfig_pool_reserve_ip(sp->pool, d4->gateway);
+    sp->tag =3D d4 ? d4->=
tag : d6->tag;
+    /* every host address of each subnet, minus the gateway=
s reserved below
+     * (the IPv4 and the IPv6 address of a client share o=
ne pool handle) */
+    sp->pool =3D ifconfig_pool_init(d4 !=3D NULL, IFCON=
FIG_POOL_INDIV, d4 ? d4->network + 1 : 0,
+                                =
  d4 ? (d4->network | ~d4->netmask) - 1 : 0, o->duplicate_cn,
+            =
                      d6 !=3D NULL, d6 ? add_in6_addr(d6->network, 1) : in6=
addr_any,
+                                  d6 ? (int)d6->netbits : 0);
+ =
   if (d4)
+    {
+        ifconfig_pool_reserve_ip(sp->pool, d4->gateway);=

+    }
+    if (d6)
+    {
+        ifconfig_pool_reserve_ipv6(sp->pool, &=
d6->gateway);
+    }
     sp->next =3D m->subnet_pools;
     m->subnet_pool=
s =3D sp;
     return sp->pool;
@@ -1510,6 +1524,19 @@
             mi->con=
text=2Eoptions=2Esubnet_pool_gateway =3D d->gateway;
         }
     }
+   =
 if (mi->context=2Eoptions=2Esubnet_pool_tag)
+    {
+        const struct =
subnet_pool6_def *d =3D subnet_pool6_by_tag(
+            m->top=2Eoptions=
=2Esubnet_pools_ipv6, mi->context=2Eoptions=2Esubnet_pool_tag);
+
+        =
mi->context=2Eoptions=2Esubnet_pool_ipv6_defined =3D d !=3D NULL;
+        =
if (d)
+        {
+            mi->context=2Eoptions=2Esubnet_pool_ipv6_net=
work =3D d->network;
+            mi->context=2Eoptions=2Esubnet_pool_ipv6_=
netbits =3D d->netbits;
+            mi->context=2Eoptions=2Esubnet_pool_ip=
v6_gateway =3D d->gateway;
+        }
+    }
 
     /*
      * If ifconfig =
addresses were set by dynamic config file,
@@ -1544,15 +1571,16 @@
        =
         "MULTI_sva: WARNING: if --ifconfig-push is used for IPv4, automati=
c IPv6 assignment from --ifconfig-ipv6-pool does not work=2E  Use --ifconfi=
g-ipv6-push for IPv6 then=2E");
         }
     }
-    else if (mi->context=
=2Eoptions=2Esubnet_pool_defined)
+    else if (mi->context=2Eoptions=2Esub=
net_pool_defined
+             || mi->context=2Eoptions=2Esubnet_pool_ipv6_=
defined)
     {
-        /* dynamic address from this client's --subnet-poo=
l group */
+        /* dynamic address(es) from this client's --subnet-pool=
 group */
         struct ifconfig_pool *group =3D
             multi_get_g=
roup_pool(m, &m->top=2Eoptions, mi->context=2Eoptions=2Esubnet_pool_tag);
 =

         /* the address may have been acquired before the tag was known (f=
rom
          * the global pool) or for a tag that a later handler overrode=
: drop
-         * it so we serve this client from its current group */
+  =
       * it so we serve this client from its current group only */
        =
 if (mi->vaddr_handle >=3D 0 && mi->vaddr_pool !=3D group)
         {
     =
        ifconfig_pool_release(mi->vaddr_pool ? mi->vaddr_pool : m->ifconfig=
_pool,
@@ -1560,32 +1588,50 @@
             mi->vaddr_handle =3D -1;
      =
       mi->vaddr_pool =3D NULL;
             mi->context=2Ec2=2Epush_ifconf=
ig_defined =3D false;
+            mi->context=2Ec2=2Epush_ifconfig_ipv6_de=
fined =3D false;
         }
 
         if (mi->vaddr_handle < 0)
         {=

             in_addr_t local =3D 0, remote =3D 0;
+            struct in6_=
addr remote_ipv6;
             const char *cn =3D NULL;
 
+            CLEA=
R(remote_ipv6);
             if (!mi->context=2Eoptions=2Eduplicate_cn)
   =
          {
                 cn =3D tls_common_name(mi->context=2Ec2=2Etls_=
multi, true);
             }
 
             mi->vaddr_pool =3D group;
-    =
        mi->vaddr_handle =3D ifconfig_pool_acquire(mi->vaddr_pool, &local, =
&remote, NULL, cn);
-            if (mi->vaddr_handle >=3D 0)
-            =
{
-                mi->context=2Ec2=2Epush_ifconfig_local =3D remote;
-    =
            mi->context=2Ec2=2Epush_ifconfig_remote_netmask =3D
-          =
          mi->context=2Eoptions=2Esubnet_pool_netmask;
-                mi-=
>context=2Ec2=2Epush_ifconfig_defined =3D true;
-            }
-           =
 else
+            mi->vaddr_handle =3D
+                ifconfig_pool_acqu=
ire(mi->vaddr_pool, &local, &remote, &remote_ipv6, cn);
+            if (mi=
->vaddr_handle < 0)
             {
                 msg(D_MULTI_ERRORS, "MU=
LTI: no free --subnet-pool addresses are available for %s",
               =
      multi_instance_string(mi, false, &gc));
             }
+            e=
lse
+            {
+                if (mi->context=2Eoptions=2Esubnet_pool=
_defined)
+                {
+                    mi->context=2Ec2=2Epush_i=
fconfig_local =3D remote;
+                    mi->context=2Ec2=2Epush_ifco=
nfig_remote_netmask =3D
+                        mi->context=2Eoptions=2Esu=
bnet_pool_netmask;
+                    mi->context=2Ec2=2Epush_ifconfig_de=
fined =3D true;
+                }
+                if (mi->context=2Eoptio=
ns=2Esubnet_pool_ipv6_defined)
+                {
+                    /* t=
he server's own address is off-link for this client:
+                     =
* hand out the pool gateway as the remote end instead */
+                 =
   mi->context=2Ec2=2Epush_ifconfig_ipv6_local =3D remote_ipv6;
+          =
          mi->context=2Ec2=2Epush_ifconfig_ipv6_remote =3D
+               =
         mi->context=2Eoptions=2Esubnet_pool_ipv6_gateway;
+               =
     mi->context=2Ec2=2Epush_ifconfig_ipv6_netbits =3D
+                   =
     mi->context=2Eoptions=2Esubnet_pool_ipv6_netbits;
+                   =
 mi->context=2Ec2=2Epush_ifconfig_ipv6_defined =3D true;
+                }=

+            }
         }
     }
     else if (m->ifconfig_pool && mi->vad=
dr_handle < 0) /* otherwise, choose a pool address */
@@ -2926,7 +2972,9 @@=

     }
 
     if (mi->context=2Eoptions=2Esubnet_pool_tag
-        && !sub=
net_pool_by_tag(m->top=2Eoptions=2Esubnet_pools, mi->context=2Eoptions=2Esu=
bnet_pool_tag))
+        && !subnet_pool_by_tag(m->top=2Eoptions=2Esubnet_p=
ools, mi->context=2Eoptions=2Esubnet_pool_tag)
+        && !subnet_pool6_by=
_tag(m->top=2Eoptions=2Esubnet_pools_ipv6,
+                               =
 mi->context=2Eoptions=2Esubnet_pool_tag))
     {
         msg(D_MULTI_ERRO=
RS, "MULTI: client has been rejected due to unknown --subnet-pool-tag '%s'"=
,
             mi->context=2Eoptions=2Esubnet_pool_tag);
diff --git a/src/o=
penvpn/options=2Ec b/src/openvpn/options=2Ec
index cd29fc4=2E=2E95b0ab4 100=
644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -455,6 +=
455,8 @@
     "--subnet-pool tag network netmask [gateway] : Define a named=
 pool of\n"
     "                  addresses outside the --server network,=
 selected per\n"
     "                  client with --subnet-pool-tag=2E\n=
"
+    "--subnet-pool-ipv6 tag network/bits [gateway] : IPv6 counterpart of=
\n"
+    "                  --subnet-pool=2E\n"
     "--subnet-pool-tag tag=
 : Assign this client to the --subnet-pool named tag=2E\n"
     "          =
        Only valid in a client-specific config file=2E\n"
     "--ifconfig-=
push local remote-netmask : Push an ifconfig option to remote,\n"
@@ -1944,=
6 +1946,20 @@
             subnet_pools_check(options->subnet_pools, option=
s->server_network,
                                options->server_netmask,=
 M_USAGE);
         }
+        if (options->subnet_pools_ipv6)
+        {
+=
            if (!options->server_ipv6_defined)
+            {
+            =
    msg(M_USAGE, "--subnet-pool-ipv6 requires --server-ipv6");
+           =
 }
+            if (dev_type_enum(options->dev, options->dev_type) !=3D DEV=
_TYPE_TUN
+                || options->topology !=3D TOP_SUBNET)
+         =
   {
+                msg(M_USAGE, "--subnet-pool-ipv6 requires --dev tun a=
nd --topology subnet");
+            }
+            subnet_pools6_check(opt=
ions->subnet_pools_ipv6, &options->server_network_ipv6,
+                  =
              options->server_netbits_ipv6, M_USAGE);
+        }
         M=
UST_BE_UNDEF(allow_recursive_routing, "allow-recursive-routing");
         =
if (options->auth_user_pass_file)
         {
@@ -2011,6 +2027,7 @@
        =
 MUST_BE_UNDEF(ifconfig_pool_persist_filename, "ifconfig-pool-persist");
  =
       MUST_BE_UNDEF(ifconfig_ipv6_pool_defined, "ifconfig-ipv6-pool");
   =
      MUST_BE_UNDEF(subnet_pools, "subnet-pool");
+        MUST_BE_UNDEF(su=
bnet_pools_ipv6, "subnet-pool-ipv6");
         MUST_BE_UNDEF(real_hash_size=
, "hash-size");
         MUST_BE_UNDEF(virtual_hash_size, "hash-size");
   =
      MUST_BE_UNDEF(learn_address_script, "learn-address");
@@ -3144,8 +316=
1,9 @@
 }
 
 /*
- * The server's tun device is only configured with the --s=
erver network, so
- * route each --subnet-pool network into it as well: wit=
hout this the server
+ * The server's tun device is only configured with th=
e --server and
+ * --server-ipv6 networks, so route each --subnet-pool and =
--subnet-pool-ipv6
+ * network into it as well: without this the server
  *=
 could not reach its subnet-pool clients when the data channel runs in
  * =
userspace (under DCO, each such client additionally gets an on-link host
  =
* route when it connects, see multi_learn_in_addr_t())=2E
@@ -3160,6 +3178,=
16 @@
                                  print_in_addr_t(d->netmask, 0, &o->=
gc), NULL, NULL,
                                  o->route_default_table_i=
d);
     }
+
+    for (const struct subnet_pool6_def *d =3D o->subnet_pools=
_ipv6; d; d =3D d->next)
+    {
+        struct buffer prefix =3D alloc_buf=
_gc(64, &o->gc);
+
+        buf_printf(&prefix, "%s/%u", print_in6_addr(d->=
network, 0, &o->gc), d->netbits);
+        rol6_check_alloc(o);
+        ad=
d_route_ipv6_to_option_list(o->routes_ipv6, BSTR(&prefix), NULL, NULL,
+   =
                                   o->route_default_table_id);
+    }
 }
 
=
 static void
@@ -6317,6 +6345,37 @@
         sp->next =3D options->subnet_p=
ools;
         options->subnet_pools =3D sp;
     }
+    else if (streq(p[0=
], "subnet-pool-ipv6") && p[1] && p[2] && !p[4])
+    {
+        struct sub=
net_pool6_def *sp;
+        struct in6_addr network, gateway;
+        unsi=
gned int netbits =3D 0;
+
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+     =
   if (!get_ipv6_addr(p[2], &network, &netbits, msglevel))
+        {
+    =
        msg(msglevel, "cannot parse --subnet-pool-ipv6 network");
+        =
    goto err;
+        }
+        if (netbits < 64 || netbits > 124)
+     =
   {
+            msg(msglevel, "--subnet-pool-ipv6 network must be between=
 /64 and /124 (not /%d)",
+                netbits);
+            goto err;=

+        }
+        if (p[3] && !get_ipv6_addr(p[3], &gateway, NULL, msgle=
vel))
+        {
+            msg(msglevel, "cannot parse --subnet-pool-ipv=
6 gateway");
+            goto err;
+        }
+        ALLOC_OBJ_GC(sp, st=
ruct subnet_pool6_def, &options->gc);
+        sp->tag =3D p[1];
+        s=
p->network =3D network;
+        sp->netbits =3D netbits;
+        sp->gate=
way =3D p[3] ? gateway : add_in6_addr(network, 1);
+        sp->next =3D op=
tions->subnet_pools_ipv6;
+        options->subnet_pools_ipv6 =3D sp;
+    =
}
     else if (streq(p[0], "subnet-pool-tag") && p[1] && !p[2])
     {
   =
      VERIFY_PERMISSION(OPT_P_INSTANCE);
diff --git a/src/openvpn/options=
=2Eh b/src/openvpn/options=2Eh
index 028b1e6=2E=2E697de91 100644
--- a/src/=
openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -263,6 +263,16 @@
    =
 in_addr_t gateway;
 };
 
+/* The IPv6 counterpart of struct subnet_pool_de=
f (--subnet-pool-ipv6)=2E */
+struct subnet_pool6_def
+{
+    struct subnet=
_pool6_def *next;
+    const char *tag;
+    struct in6_addr network;
+    =
unsigned int netbits;
+    struct in6_addr gateway;
+};
+
 /* Command line =
options */
 struct options
 {
@@ -529,12 +539,17 @@
     bool push_ifconfig=
_constraint_defined;
     in_addr_t push_ifconfig_constraint_network;
     =
in_addr_t push_ifconfig_constraint_netmask;
-    struct subnet_pool_def *su=
bnet_pools; /* named pools (server config) */
-    const char *subnet_pool_=
tag;          /* which pool this client uses (CCD) */
-    bool subnet_pool=
_defined;             /* resolved from the tag at connect */
+    struct su=
bnet_pool_def *subnet_pools;       /* named IPv4 pools (server config) */
+=
    struct subnet_pool6_def *subnet_pools_ipv6; /* named IPv6 pools (server=
 config) */
+    const char *subnet_pool_tag;                /* which pool =
this client uses (CCD) */
+    bool subnet_pool_defined;                   =
/* resolved from the tag at connect */
     in_addr_t subnet_pool_network;
=
     in_addr_t subnet_pool_netmask;
     in_addr_t subnet_pool_gateway;
+  =
  bool subnet_pool_ipv6_defined; /* resolved from the tag at connect */
+  =
  struct in6_addr subnet_pool_ipv6_network;
+    unsigned int subnet_pool_i=
pv6_netbits;
+    struct in6_addr subnet_pool_ipv6_gateway;
     bool push_=
ifconfig_ipv4_blocked;           /* IPv4 */
     bool push_ifconfig_ipv6_de=
fined;           /* IPv6 */
     struct in6_addr push_ifconfig_ipv6_local; =
 /* IPv6 */
diff --git a/src/openvpn/options_util=2Ec b/src/openvpn/options=
_util=2Ec
index 744ad4c=2E=2Efb38cfa 100644
--- a/src/openvpn/options_util=
=2Ec
+++ b/src/openvpn/options_util=2Ec
@@ -116,6 +116,108 @@
     return t=
rue;
 }
 
+/* value of bit <i> (0 =3D most significant) of an IPv6 address =
*/
+static bool
+in6_bit(const struct in6_addr *a, unsigned int i)
+{
+    =
return a->s6_addr[i / 8] & (0x80 >> (i % 8));
+}
+
+/* true if the first <b=
its> bits of the two addresses are equal */
+static bool
+in6_prefix_equal(=
const struct in6_addr *a, const struct in6_addr *b, unsigned int bits)
+{
+=
    for (unsigned int i =3D 0; i < bits; ++i)
+    {
+        if (in6_bit(a=
, i) !=3D in6_bit(b, i))
+        {
+            return false;
+        }
+=
    }
+    return true;
+}
+
+/* true if every bit of <a> from bit <from> o=
n is zero */
+static bool
+in6_suffix_zero(const struct in6_addr *a, unsign=
ed int from)
+{
+    for (unsigned int i =3D from; i < 128; ++i)
+    {
+  =
      if (in6_bit(a, i))
+        {
+            return false;
+        }
+=
    }
+    return true;
+}
+
+bool
+subnet_pools6_check(const struct subnet=
_pool6_def *pools, const struct in6_addr *server_network,
+                =
    unsigned int server_netbits, msglvl_t msglevel)
+{
+    for (const stru=
ct subnet_pool6_def *d =3D pools; d; d =3D d->next)
+    {
+        if (d->=
netbits < 64 || d->netbits > 124)
+        {
+            msg(msglevel, "--=
subnet-pool-ipv6 %s: network must be between /64 and /124 (not /%u)",
+    =
            d->tag, d->netbits);
+            return false;
+        }
+
+ =
       if (!in6_suffix_zero(&d->network, d->netbits))
+        {
+         =
   msg(msglevel, "--subnet-pool-ipv6 %s: network has host bits set", d->tag=
);
+            return false;
+        }
+
+        if (!in6_prefix_equal(&=
d->gateway, &d->network, d->netbits)
+            || in6_suffix_zero(&d->ga=
teway, d->netbits))
+        {
+            msg(msglevel,
+                =
"--subnet-pool-ipv6 %s: gateway must be a host address inside the network",=

+                d->tag);
+            return false;
+        }
+
+       =
 if (server_netbits
+            && in6_prefix_equal(&d->network, server_ne=
twork, min_uint(d->netbits, server_netbits)))
+        {
+            msg(m=
sglevel, "--subnet-pool-ipv6 %s: network overlaps the --server-ipv6 network=
",
+                d->tag);
+            return false;
+        }
+
+     =
   for (const struct subnet_pool6_def *e =3D d->next; e; e =3D e->next)
+  =
      {
+            if (!strcmp(d->tag, e->tag))
+            {
+         =
       msg(msglevel, "--subnet-pool-ipv6 %s: tag defined more than once", d=
->tag);
+                return false;
+            }
+            if (in6_=
prefix_equal(&d->network, &e->network, min_uint(d->netbits, e->netbits)))
+=
            {
+                msg(msglevel, "--subnet-pool-ipv6 %s and %s:=
 networks overlap", d->tag, e->tag);
+                return false;
+      =
      }
+        }
+    }
+
+    return true;
+}
+
+const struct subnet_poo=
l6_def *
+subnet_pool6_by_tag(const struct subnet_pool6_def *pools, const c=
har *tag)
+{
+    for (const struct subnet_pool6_def *d =3D pools; d; d =3D=
 d->next)
+    {
+        if (!strcmp(d->tag, tag))
+        {
+           =
 return d;
+        }
+    }
+    return NULL;
+}
+
 const char *
 parse_au=
th_failed_temp(struct options *o, const char *reason)
 {
diff --git a/src/o=
penvpn/options_util=2Eh b/src/openvpn/options_util=2Eh
index d60759a=2E=2Eb=
ffcddb 100644
--- a/src/openvpn/options_util=2Eh
+++ b/src/openvpn/options_=
util=2Eh
@@ -53,6 +53,25 @@
 bool subnet_pools_check(const struct subnet_po=
ol_def *pools, in_addr_t server_network,
                         in_addr_t=
 server_netmask, msglvl_t msglevel);
 
+/**
+ * IPv6 counterpart of subnet_=
pools_check(): network between /64 and /124
+ * without host bits, gateway =
a host address inside it, unique tags, and no
+ * network overlapping anoth=
er pool or the --server-ipv6 network=2E
+ *
+ * @param pools           head=
 of the --subnet-pool-ipv6 list (may be NULL)
+ * @param server_network  th=
e --server-ipv6 network
+ * @param server_netbits  the --server-ipv6 prefix=
 length, or 0 if there is none
+ * @param msglevel        level of the mess=
age logged on the first error
+ * @return                true if every defi=
nition is valid
+ */
+bool subnet_pools6_check(const struct subnet_pool6_de=
f *pools,
+                         const struct in6_addr *server_network, =
unsigned int server_netbits,
+                         msglvl_t msglevel);
=
+
+/** IPv6 counterpart of subnet_pool_by_tag()=2E */
+const struct subnet_=
pool6_def *subnet_pool6_by_tag(const struct subnet_pool6_def *pools,
+     =
                                              const char *tag);
+
 
 /** Ch=
ecks if the string is a valid integer by checking if it can be
  *  convert=
ed to an integer */
diff --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2E=
c
index fa04d9c=2E=2E8f899d3 100644
--- a/src/openvpn/pool=2Ec
+++ b/src/op=
envpn/pool=2Ec
@@ -445,6 +445,22 @@
     return true;
 }
 
+bool
+ifconfig_=
pool_reserve_ipv6(struct ifconfig_pool *pool, const struct in6_addr *addr)
=
+{
+    const ifconfig_pool_handle h =3D ifconfig_pool_ipv6_base_to_handle(=
pool, addr);
+
+    if (h < 0)
+    {
+        return false;
+    }
+
+    =
ifconfig_pool_entry_free(&pool->list[h], true);
+    pool->list[h]=2Ein_use=
 =3D true;
+    pool->list[h]=2Ereserved =3D true;
+    return true;
+}
+
 =
static in_addr_t
 ifconfig_pool_handle_to_ip_base(const struct ifconfig_poo=
l *pool, ifconfig_pool_handle hand)
 {
diff --git a/src/openvpn/pool=2Eh b/=
src/openvpn/pool=2Eh
index 497dcda=2E=2Efda87ed 100644
--- a/src/openvpn/po=
ol=2Eh
+++ b/src/openvpn/pool=2Eh
@@ -98,6 +98,9 @@
  */
 bool ifconfig_poo=
l_reserve_ip(struct ifconfig_pool *pool, in_addr_t addr);
 
+/** IPv6 count=
erpart of ifconfig_pool_reserve_ip()=2E */
+bool ifconfig_pool_reserve_ipv6=
(struct ifconfig_pool *pool, const struct in6_addr *addr);
+
 struct ifconf=
ig_pool_persist *ifconfig_pool_persist_init(const char *filename, int refre=
sh_freq);
 
 void ifconfig_pool_persist_close(struct ifconfig_pool_persist =
*persist);
diff --git a/tests/unit_tests/openvpn/test_subnet_pool=2Ec b/tes=
ts/unit_tests/openvpn/test_subnet_pool=2Ec
index 1bb9e4c=2E=2Ef3d58cb 10064=
4
--- a/tests/unit_tests/openvpn/test_subnet_pool=2Ec
+++ b/tests/unit_test=
s/openvpn/test_subnet_pool=2Ec
@@ -131,11 +131,88 @@
     assert_false(subn=
et_pools_check(&a, 0, 0, M_WARN));
 }
 
+/* the IPv6 counterpart resolves i=
ndependently: a tag may name a v4 pool, a
+ * v6 pool, or both=2E */
+stati=
c void
+test_subnet_pool6_by_tag(void **state)
+{
+    struct subnet_pool6_=
def c =3D { =2Enext =3D NULL, =2Etag =3D "grpC", =2Enetbits =3D 64 };
+    =
struct subnet_pool6_def b =3D { =2Enext =3D &c, =2Etag =3D "grpB", =2Enetbi=
ts =3D 96 };
+    struct subnet_pool6_def a =3D { =2Enext =3D &b, =2Etag =
=3D "grpA", =2Enetbits =3D 64 };
+
+    assert_ptr_equal(subnet_pool6_by_ta=
g(&a, "grpA"), &a);
+    assert_ptr_equal(subnet_pool6_by_tag(&a, "grpB"), =
&b);
+    assert_ptr_equal(subnet_pool6_by_tag(&a, "grpC"), &c);
+    asser=
t_int_equal(subnet_pool6_by_tag(&a, "grpB")->netbits, 96);
+    assert_null=
(subnet_pool6_by_tag(&a, "nope"));
+    assert_null(subnet_pool6_by_tag(NUL=
L, "grpA"));
+}
+
+/* <prefix>::<host> as an in6_addr */
+static struct in6=
_addr
+in6(const char *addr)
+{
+    struct in6_addr a;
+
+    assert_int_e=
qual(inet_pton(AF_INET6, addr, &a), 1);
+    return a;
+}
+
+/* a single IP=
v6 pool, checked against the fd00:8::/64 --server-ipv6 network */
+static b=
ool
+check6_one(const char *net, unsigned int bits, const char *gw)
+{
+   =
 const struct in6_addr server =3D in6("fd00:8::");
+    struct subnet_pool6=
_def d =3D { =2Enext =3D NULL, =2Etag =3D "grp", =2Enetwork =3D in6(net), =
=2Enetbits =3D bits, =2Egateway =3D in6(gw) };
+
+    return subnet_pools6_=
check(&d, &server, 64, M_WARN);
+}
+
+static void
+test_subnet_pools6_check=
(void **state)
+{
+    /* /64 =2E=2E /124, any host address of the network =
as gateway */
+    assert_true(check6_one("fd00:9::", 64, "fd00:9::1"));
+ =
   assert_true(check6_one("fd00:9::", 124, "fd00:9::1"));
+    assert_true(=
check6_one("fd00:9::", 112, "fd00:9::ffff"));
+    assert_false(check6_one(=
"fd00:9::", 63, "fd00:9::1"));
+    assert_false(check6_one("fd00:9::", 125=
, "fd00:9::1"));
+
+    /* host bits in the network, gateway =3D network or=
 outside it */
+    assert_false(check6_one("fd00:9::5", 64, "fd00:9::1"));=

+    assert_false(check6_one("fd00:9::", 64, "fd00:9::"));
+    assert_fal=
se(check6_one("fd00:9::", 64, "fd00:a::1"));
+
+    /* overlapping the --se=
rver-ipv6 network, inside or covering it */
+    assert_false(check6_one("f=
d00:8::", 96, "fd00:8::1"));
+
+    /* two pools: disjoint, overlapping, sa=
me tag */
+    const struct in6_addr server =3D in6("fd00:8::");
+    struc=
t subnet_pool6_def b =3D { =2Enext =3D NULL, =2Etag =3D "grpB", =2Enetwork =
=3D in6("fd00:a::"), =2Enetbits =3D 64, =2Egateway =3D in6("fd00:a::1") };
=
+    struct subnet_pool6_def a =3D { =2Enext =3D &b, =2Etag =3D "grpA", =2E=
network =3D in6("fd00:9::"), =2Enetbits =3D 64, =2Egateway =3D in6("fd00:9:=
:1") };
+
+    assert_true(subnet_pools6_check(&a, &server, 64, M_WARN));
+=
    assert_true(subnet_pools6_check(&a, &server, 0, M_WARN));
+
+    b=2Ene=
twork =3D in6("fd00:9::100");
+    b=2Enetbits =3D 120;
+    b=2Egateway =
=3D in6("fd00:9::101");
+    assert_false(subnet_pools6_check(&a, &server, =
64, M_WARN));
+
+    b=2Enetwork =3D in6("fd00:a::");
+    b=2Enetbits =3D =
64;
+    b=2Egateway =3D in6("fd00:a::1");
+    b=2Etag =3D "grpA";
+    as=
sert_false(subnet_pools6_check(&a, &server, 64, M_WARN));
+}
+
 const struc=
t CMUnitTest subnet_pool_tests[] =3D {
     cmocka_unit_test(test_subnet_po=
ol_by_tag),
     cmocka_unit_test(test_subnet_pools_check_netmask),
     cm=
ocka_unit_test(test_subnet_pools_check_gateway),
     cmocka_unit_test(test=
_subnet_pools_check_overlap),
+    cmocka_unit_test(test_subnet_pool6_by_ta=
g),
+    cmocka_unit_test(test_subnet_pools6_check),
 };
 
 int

-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I64e0850d48647a2c0e3d385c=
2f20a9f445931727
Gerrit-Change-Number: 1786
Gerrit-PatchSet: 4
Gerrit-Owner=
: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>

--M/Xf+WQVKt8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Antonio Quartulli <strong>upl=
oaded patch set #4</strong> to this change=2E</p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail">View Change</a></p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">multi: assign IPv6 addresses from a tagged subnet-pool<br><br>Add th=
e IPv6 counterpart of --subnet-pool:<br><br>  subnet-pool-ipv6 &lt;tag&gt; =
&lt;network&gt;/&lt;bits&gt; [&lt;gateway&gt;]   (main config)<br><br>selec=
ted by the same per-client --subnet-pool-tag=2E A client&#39;s tag is<br>re=
solved against the IPv6 pool list too and, when it matches, an IPv6<br>addr=
ess is handed out from the group&#39;s pool alongside any IPv4 one (a<br>si=
ngle dual-stack ifconfig_pool per tag)=2E The pool gateway is pushed as<br>=
the remote end of the client&#39;s ifconfig-ipv6, as the server&#39;s own<b=
r>address is off-link for it=2E A tag matching neither family is still<br>d=
eclined with AUTH_FAILED=2E<br><br>As for IPv4 the pools are checked when t=
he config is loaded (network<br>between /64 and /124 without host bits, gat=
eway a host address inside<br>it, unique tags, no overlap with another pool=
 or the --server-ipv6<br>network), created at startup with their gateway re=
served, and routed<br>into the server&#39;s tun device=2E<br><br>Change-Id:=
 I64e0850d48647a2c0e3d385c2f20a9f445931727<br>GitHub: closes openvpn/OpenVP=
N#987<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<b=
r>---<br>M doc/man-sections/server-options=2Erst<br>M src/openvpn/multi=2Ec=
<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn=
/options_util=2Ec<br>M src/openvpn/options_util=2Eh<br>M src/openvpn/pool=
=2Ec<br>M src/openvpn/pool=2Eh<br>M tests/unit_tests/openvpn/test_subnet_po=
ol=2Ec<br>9 files changed, 389 insertions(+), 29 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/86/1786/4</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/doc/man-sections/server-options=2Erst b/=
doc/man-sections/server-options=2Erst</span><br><span>index b6eab9a=2E=2E1e=
98ff9 100644</span><br><span>--- a/doc/man-sections/server-options=2Erst</s=
pan><br><span>+++ b/doc/man-sections/server-options=2Erst</span><br><span>@=
@ -356,11 +356,32 @@</span><br><span>   The server routes each pool&#39;s s=
ubnet into the tun device, as it does for</span><br><span>   the ``--server=
`` network; no ``--route`` needs to be added for it=2E</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+--subnet-pool-ipv6 arg=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The IPv6 counter=
part of ``--subnet-pool``=2E Repeatable main-config directive=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  Valid syntax:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  ::</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     subnet-=
pool-ipv6 tag network/bits [gateway]</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
``bits`` must be between 64 and 124; ``gateway`` defaults to the first</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  address of the network=
, is never assigned to a client, and is pushed to the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  pool&#39;s clients as the remote end of=
 their ``ifconfig-ipv6``=2E A tag may name</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  an IPv4 pool, an IPv6 pool, or both; a client refe=
rencing it with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``=
--subnet-pool-tag`` is then assigned an address from each family the tag</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  defines=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  Requires ``--server-ipv6`` with ``--dev tun``=
=2E ``network`` must have no host</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  bits set, ``gateway`` must be a host address inside it, eac=
h ``tag`` may be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  d=
efined only once and no pool may overlap another one or the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  ``--server-ipv6`` network=2E As f=
or ``--subnet-pool``, the server routes each</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  pool&#39;s network into the tun device=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --subnet=
-pool-tag tag</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Assign=
 this client to the ``--subnet-pool`` named ``tag``=2E Must be</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  associated with a specific clien=
t instance via ``--client-config-dir`` or</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  ``--client-connect``=2E Several clients may reference=
 the same tag and are</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  then served from the same shared pool=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  Assign this client to the ``--subnet-pool`` / ``--=
subnet-pool-ipv6`` named</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  ``tag``=2E Must be associated with a specific client instance via</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--client-config-di=
r`` or ``--client-connect``=2E Several clients may</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  reference the same tag and are then served=
 from the same shared pool(s)=2E</span><br><span> </span><br><span> --ifcon=
fig-ipv6-push args</span><br><span>   for ``--client-config-dir`` per-clien=
t static IPv6 interface</span><br><span>diff --git a/src/openvpn/multi=2Ec =
b/src/openvpn/multi=2Ec</span><br><span>index 86fd9c0=2E=2Eac3962d 100644</=
span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvp=
n/multi=2Ec</span><br><span>@@ -392,6 +392,10 @@</span><br><span>     {</sp=
an><br><span>         multi_get_group_pool(m, &amp;t-&gt;options, d-&gt;tag=
);</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    for (const struct subnet_pool6_def *d =3D t-&gt;options=2Esubnet_=
pools_ipv6; d; d =3D d-&gt;next)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       multi_get_group_pool(m, &amp;t-&gt;options, d-&gt;tag);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><b=
r><span>     /*</span><br><span>      * Help us keep track of routing table=
=2E</span><br><span>@@ -1469,14 +1473,24 @@</span><br><span>     }</span><b=
r><span> </span><br><span>     const struct subnet_pool_def *d4 =3D subnet_=
pool_by_tag(o-&gt;subnet_pools, tag);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    ASSERT(d4);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const struct subnet_pool6_def *d6 =3D subnet_pool6_by_tag(o=
-&gt;subnet_pools_ipv6, tag);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ASSERT(d4 || d6);</span><br><span>     ALLOC_OBJ_CLEAR(sp, st=
ruct subnet_pool);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 sp-&gt;tag =3D d4-&gt;tag;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    /* every host address of the subnet, minus the gateway reserved b=
elow */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sp-&gt;poo=
l =3D ifconfig_pool_init(true, IFCONFIG_POOL_INDIV, d4-&gt;network + 1,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
         (d4-&gt;network | ~d4-&gt;netmask) - 1, o-&gt;duplicate_cn, false,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
             in6addr_any, 0);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    ifconfig_pool_reserve_ip(sp-&gt;pool, d4-&gt;gateway);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;tag =3D d4 ? d4-&=
gt;tag : d6-&gt;tag;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* every host address of each subnet, minus the gateways reserved belo=
w</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (the IPv4 a=
nd the IPv6 address of a client share one pool handle) */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;pool =3D ifconfig_pool_ini=
t(d4 !=3D NULL, IFCONFIG_POOL_INDIV, d4 ? d4-&gt;network + 1 : 0,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
     d4 ? (d4-&gt;network | ~d4-&gt;netmask) - 1 : 0, o-&gt;duplicate_cn,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
             d6 !=3D NULL, d6 ? add_in6_addr(d6-&gt;network, 1) : in6addr_a=
ny,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                  d6 ? (int)d6-&gt;netbits : 0);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (d4)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        ifconfig_pool_reserve_ip(sp-&gt;pool, d4-&gt;gateway);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (d6)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        ifconfig_pool_reserve_ipv6(sp-&gt;pool, &amp;d6-&gt;g=
ateway);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span>     sp-&gt;next =3D m-&gt;subnet_pools;</span><br><span>     m-=
&gt;subnet_pools =3D sp;</span><br><span>     return sp-&gt;pool;</span><br=
><span>@@ -1510,6 +1524,19 @@</span><br><span>             mi-&gt;context=
=2Eoptions=2Esubnet_pool_gateway =3D d-&gt;gateway;</span><br><span>       =
  }</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (mi-&gt;context=2Eoptions=2Esubnet_pool_tag)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        const struct subnet_pool6_def *d =3D subne=
t_pool6_by_tag(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        m-&gt;top=2Eoptions=2Esubnet_pools_ipv6, mi-&gt;context=2Eoptions=
=2Esubnet_pool_tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;con=
text=2Eoptions=2Esubnet_pool_ipv6_defined =3D d !=3D NULL;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (d)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            mi-&gt;context=2Eoptions=2Esubnet_pool_=
ipv6_network =3D d-&gt;network;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_netbits=
 =3D d-&gt;netbits;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_gateway =3D d-&gt;g=
ateway;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>=
 </span><br><span>     /*</span><br><span>      * If ifconfig addresses wer=
e set by dynamic config file,</span><br><span>@@ -1544,15 +1571,16 @@</span=
><br><span>                 &quot;MULTI_sva: WARNING: if --ifconfig-push is=
 used for IPv4, automatic IPv6 assignment from --ifconfig-ipv6-pool does no=
t work=2E  Use --ifconfig-ipv6-push for IPv6 then=2E&quot;);</span><br><spa=
n>         }</span><br><span>     }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    else if (mi-&gt;context=2Eoptions=2Esubnet_pool_defined)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (mi-&gt;=
context=2Eoptions=2Esubnet_pool_defined</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+             || mi-&gt;context=2Eoptions=2Esubnet_pool_=
ipv6_defined)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        /* dynamic address from this client&#39;s --subnet-p=
ool group */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 /* dynamic address(es) from this client&#39;s --subnet-pool group */</span=
><br><span>         struct ifconfig_pool *group =3D</span><br><span>       =
      multi_get_group_pool(m, &amp;m-&gt;top=2Eoptions, mi-&gt;context=2Eop=
tions=2Esubnet_pool_tag);</span><br><span> </span><br><span>         /* the=
 address may have been acquired before the tag was known (from</span><br><s=
pan>          * the global pool) or for a tag that a later handler overrode=
: drop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * it s=
o we serve this client from its current group */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+         * it so we serve this client from its=
 current group only */</span><br><span>         if (mi-&gt;vaddr_handle &gt=
;=3D 0 &amp;&amp; mi-&gt;vaddr_pool !=3D group)</span><br><span>         {<=
/span><br><span>             ifconfig_pool_release(mi-&gt;vaddr_pool ? mi-&=
gt;vaddr_pool : m-&gt;ifconfig_pool,</span><br><span>@@ -1560,32 +1588,50 @=
@</span><br><span>             mi-&gt;vaddr_handle =3D -1;</span><br><span>=
             mi-&gt;vaddr_pool =3D NULL;</span><br><span>             mi-&g=
t;context=2Ec2=2Epush_ifconfig_defined =3D false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            mi-&gt;context=2Ec2=2Epush_ifconf=
ig_ipv6_defined =3D false;</span><br><span>         }</span><br><span> </sp=
an><br><span>         if (mi-&gt;vaddr_handle &lt; 0)</span><br><span>     =
    {</span><br><span>             in_addr_t local =3D 0, remote =3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct in6_=
addr remote_ipv6;</span><br><span>             const char *cn =3D NULL;</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       CLEAR(remote_ipv6);</span><br><span>             if (!mi-&gt;context=
=2Eoptions=2Eduplicate_cn)</span><br><span>             {</span><br><span> =
                cn =3D tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, tru=
e);</span><br><span>             }</span><br><span> </span><br><span>      =
       mi-&gt;vaddr_pool =3D group;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            mi-&gt;vaddr_handle =3D ifconfig_pool_acquire(mi-=
&gt;vaddr_pool, &amp;local, &amp;remote, NULL, cn);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (mi-&gt;vaddr_handle &gt;=3D=
 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                mi-&gt;con=
text=2Ec2=2Epush_ifconfig_local =3D remote;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                mi-&gt;context=2Ec2=2Epush_ifconfig_r=
emote_netmask =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                mi-&gt;context=2Eoptions=2Esubnet_pool_netmask;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                mi-&gt;context=2E=
c2=2Epush_ifconfig_defined =3D true;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            mi-&gt;vaddr_handle =3D</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                ifconfig_pool_acquire(mi-&gt;vaddr_pool=
, &amp;local, &amp;remote, &amp;remote_ipv6, cn);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (mi-&gt;vaddr_handle &lt; 0)</=
span><br><span>             {</span><br><span>                 msg(D_MULTI_=
ERRORS, &quot;MULTI: no free --subnet-pool addresses are available for %s&q=
uot;,</span><br><span>                     multi_instance_string(mi, false,=
 &amp;gc));</span><br><span>             }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            else</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                if (mi-&gt;context=2Eoptions=2Esubnet_pool_de=
fined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     mi-&gt;context=2Ec2=2Epush_ifconfig_local =3D remote;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    mi-&gt;context=
=2Ec2=2Epush_ifconfig_remote_netmask =3D</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                        mi-&gt;context=2Eoptions=2Esub=
net_pool_netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  mi-&gt;context=2Ec2=2Epush_ifconfig_defined =3D true;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (mi-&g=
t;context=2Eoptions=2Esubnet_pool_ipv6_defined)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    /* the server&#39;s own addre=
ss is off-link for this client:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                     * hand out the pool gateway as the remote =
end instead */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local =3D remote_ip=
v6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_remote =3D</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                        mi-&gt;context=
=2Eoptions=2Esubnet_pool_ipv6_gateway;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    mi-&gt;context=2Ec2=2Epush_ifconfig_=
ipv6_netbits =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                     mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_netbits;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    m=
i-&gt;context=2Ec2=2Epush_ifconfig_ipv6_defined =3D true;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>         =
}</span><br><span>     }</span><br><span>     else if (m-&gt;ifconfig_pool =
&amp;&amp; mi-&gt;vaddr_handle &lt; 0) /* otherwise, choose a pool address =
*/</span><br><span>@@ -2926,7 +2972,9 @@</span><br><span>     }</span><br><=
span> </span><br><span>     if (mi-&gt;context=2Eoptions=2Esubnet_pool_tag<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; !su=
bnet_pool_by_tag(m-&gt;top=2Eoptions=2Esubnet_pools, mi-&gt;context=2Eoptio=
ns=2Esubnet_pool_tag))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        &amp;&amp; !subnet_pool_by_tag(m-&gt;top=2Eoptions=2Esubnet_pool=
s, mi-&gt;context=2Eoptions=2Esubnet_pool_tag)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        &amp;&amp; !subnet_pool6_by_tag(m-&gt;to=
p=2Eoptions=2Esubnet_pools_ipv6,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                                mi-&gt;context=2Eoptions=2Esub=
net_pool_tag))</span><br><span>     {</span><br><span>         msg(D_MULTI_=
ERRORS, &quot;MULTI: client has been rejected due to unknown --subnet-pool-=
tag &#39;%s&#39;&quot;,</span><br><span>             mi-&gt;context=2Eoptio=
ns=2Esubnet_pool_tag);</span><br><span>diff --git a/src/openvpn/options=2Ec=
 b/src/openvpn/options=2Ec</span><br><span>index cd29fc4=2E=2E95b0ab4 10064=
4</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/o=
penvpn/options=2Ec</span><br><span>@@ -455,6 +455,8 @@</span><br><span>    =
 &quot;--subnet-pool tag network netmask [gateway] : Define a named pool of=
\n&quot;</span><br><span>     &quot;                  addresses outside the=
 --server network, selected per\n&quot;</span><br><span>     &quot;        =
          client with --subnet-pool-tag=2E\n&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &quot;--subnet-pool-ipv6 tag network/bit=
s [gateway] : IPv6 counterpart of\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;                  --subnet-pool=2E\n&quot;<=
/span><br><span>     &quot;--subnet-pool-tag tag : Assign this client to th=
e --subnet-pool named tag=2E\n&quot;</span><br><span>     &quot;           =
       Only valid in a client-specific config file=2E\n&quot;</span><br><sp=
an>     &quot;--ifconfig-push local remote-netmask : Push an ifconfig optio=
n to remote,\n&quot;</span><br><span>@@ -1944,6 +1946,20 @@</span><br><span=
>             subnet_pools_check(options-&gt;subnet_pools, options-&gt;serv=
er_network,</span><br><span>                                options-&gt;ser=
ver_netmask, M_USAGE);</span><br><span>         }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (options-&gt;subnet_pools_ipv6)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (!options-&gt;ser=
ver_ipv6_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        msg(M_USAGE, &quot;--subnet-pool-ipv6 requires --server-ipv6&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (dev_type=
_enum(options-&gt;dev, options-&gt;dev_type) !=3D DEV_TYPE_TUN</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                || options-&gt;t=
opology !=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               msg(M_USAGE, &quot;--subnet-pool-ipv6 requires --dev tun and=
 --topology subnet&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            subnet_pools6_check(options-&gt;subnet_pools_ipv6, &amp;option=
s-&gt;server_network_ipv6,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                options-&gt;server_netbits_ipv6, M_U=
SAGE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span>         MUST_BE_UNDEF(allow_recursive_routing, &quot;allow-re=
cursive-routing&quot;);</span><br><span>         if (options-&gt;auth_user_=
pass_file)</span><br><span>         {</span><br><span>@@ -2011,6 +2027,7 @@=
</span><br><span>         MUST_BE_UNDEF(ifconfig_pool_persist_filename, &qu=
ot;ifconfig-pool-persist&quot;);</span><br><span>         MUST_BE_UNDEF(ifc=
onfig_ipv6_pool_defined, &quot;ifconfig-ipv6-pool&quot;);</span><br><span> =
        MUST_BE_UNDEF(subnet_pools, &quot;subnet-pool&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(subnet_pool=
s_ipv6, &quot;subnet-pool-ipv6&quot;);</span><br><span>         MUST_BE_UND=
EF(real_hash_size, &quot;hash-size&quot;);</span><br><span>         MUST_BE=
_UNDEF(virtual_hash_size, &quot;hash-size&quot;);</span><br><span>         =
MUST_BE_UNDEF(learn_address_script, &quot;learn-address&quot;);</span><br><=
span>@@ -3144,8 +3161,9 @@</span><br><span> }</span><br><span> </span><br><=
span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * The server=
&#39;s tun device is only configured with the --server network, so</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * route each --subnet-pool ne=
twork into it as well: without this the server</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * The server&#39;s tun device is only configure=
d with the --server and</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * --server-ipv6 networks, so route each --subnet-pool and --subnet-poo=
l-ipv6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * network in=
to it as well: without this the server</span><br><span>  * could not reach =
its subnet-pool clients when the data channel runs in</span><br><span>  * u=
serspace (under DCO, each such client additionally gets an on-link host</sp=
an><br><span>  * route when it connects, see multi_learn_in_addr_t())=2E</s=
pan><br><span>@@ -3160,6 +3178,16 @@</span><br><span>                      =
            print_in_addr_t(d-&gt;netmask, 0, &amp;o-&gt;gc), NULL, NULL,</=
span><br><span>                                  o-&gt;route_default_table_=
id);</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (co=
nst struct subnet_pool6_def *d =3D o-&gt;subnet_pools_ipv6; d; d =3D d-&gt;=
next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        struct buffer prefix=
 =3D alloc_buf_gc(64, &amp;o-&gt;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       buf_printf(&amp;prefix, &quot;%s/%u&quot;, print_in6_addr(d-&gt;netw=
ork, 0, &amp;o-&gt;gc), d-&gt;netbits);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        rol6_check_alloc(o);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        add_route_ipv6_to_option_list(o-&gt;ro=
utes_ipv6, BSTR(&amp;prefix), NULL, NULL,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                      o-&gt;route_def=
ault_table_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span> }</span><br><span> </span><br><span> static void</span><=
br><span>@@ -6317,6 +6345,37 @@</span><br><span>         sp-&gt;next =3D op=
tions-&gt;subnet_pools;</span><br><span>         options-&gt;subnet_pools =
=3D sp;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    else if (streq(p[0], &quot;subnet-pool-ipv6&quot;) &amp;&amp=
; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        struct subnet_pool6_def *sp;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        struct in6_addr network, gateway;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned int netbits =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_=
GENERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (!get_ipv6_addr(p[2], &amp;network, &amp;netbits, msglevel))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;cannot pa=
rse --subnet-pool-ipv6 network&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            goto err;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (netbits &lt; 64 || netbits &gt; 124)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--subnet-pool=
-ipv6 network must be between /64 and /124 (not /%d)&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                netbits);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (p[3] &amp;&amp; !get_ipv6=
_addr(p[3], &amp;gateway, NULL, msglevel))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            msg(msglevel, &quot;cannot parse --subnet-pool-ipv=
6 gateway&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        AL=
LOC_OBJ_GC(sp, struct subnet_pool6_def, &amp;options-&gt;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;tag =3D p[1];</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;network =
=3D network;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 sp-&gt;netbits =3D netbits;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        sp-&gt;gateway =3D p[3] ? gateway : add_in6_addr(network, =
1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;n=
ext =3D options-&gt;subnet_pools_ipv6;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        options-&gt;subnet_pools_ipv6 =3D sp;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     els=
e if (streq(p[0], &quot;subnet-pool-tag&quot;) &amp;&amp; p[1] &amp;&amp; !=
p[2])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT=
_P_INSTANCE);</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/op=
envpn/options=2Eh</span><br><span>index 028b1e6=2E=2E697de91 100644</span><=
br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/op=
tions=2Eh</span><br><span>@@ -263,6 +263,16 @@</span><br><span>     in_addr=
_t gateway;</span><br><span> };</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* The IPv6 counterpart of struct subnet_pool=
_def (--subnet-pool-ipv6)=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+struct subnet_pool6_def</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct subnet_pool6_def *next;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const char *tag;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct in6_addr network;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    unsigned int netbits;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct in6_addr gateway;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /* Command line options */</span><br=
><span> struct options</span><br><span> {</span><br><span>@@ -529,12 +539,1=
7 @@</span><br><span>     bool push_ifconfig_constraint_defined;</span><br>=
<span>     in_addr_t push_ifconfig_constraint_network;</span><br><span>    =
 in_addr_t push_ifconfig_constraint_netmask;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    struct subnet_pool_def *subnet_pools; /* named p=
ools (server config) */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    const char *subnet_pool_tag;          /* which pool this client uses =
(CCD) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool subn=
et_pool_defined;             /* resolved from the tag at connect */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_def =
*subnet_pools;       /* named IPv4 pools (server config) */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6_def *subnet=
_pools_ipv6; /* named IPv6 pools (server config) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *subnet_pool_tag;         =
       /* which pool this client uses (CCD) */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    bool subnet_pool_defined;                   =
/* resolved from the tag at connect */</span><br><span>     in_addr_t subne=
t_pool_network;</span><br><span>     in_addr_t subnet_pool_netmask;</span><=
br><span>     in_addr_t subnet_pool_gateway;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    bool subnet_pool_ipv6_defined; /* resolved fro=
m the tag at connect */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct in6_addr subnet_pool_ipv6_network;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    unsigned int subnet_pool_ipv6_netbits;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr su=
bnet_pool_ipv6_gateway;</span><br><span>     bool push_ifconfig_ipv4_blocke=
d;           /* IPv4 */</span><br><span>     bool push_ifconfig_ipv6_define=
d;           /* IPv6 */</span><br><span>     struct in6_addr push_ifconfig_=
ipv6_local;  /* IPv6 */</span><br><span>diff --git a/src/openvpn/options_ut=
il=2Ec b/src/openvpn/options_util=2Ec</span><br><span>index 744ad4c=2E=2Efb=
38cfa 100644</span><br><span>--- a/src/openvpn/options_util=2Ec</span><br><=
span>+++ b/src/openvpn/options_util=2Ec</span><br><span>@@ -116,6 +116,108 =
@@</span><br><span>     return true;</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* value of bit &lt;i=
&gt; (0 =3D most significant) of an IPv6 address */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+in6_bit(const struct in6_addr *a, unsigned int i)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return a-&gt;s6_addr[i / 8] &amp;=
 (0x80 &gt;&gt; (i % 8));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* true if the first &lt;bits&g=
t; bits of the two addresses are equal */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+in6_prefix_equal(const struct in6_addr *a, const struct in6_a=
ddr *b, unsigned int bits)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (un=
signed int i =3D 0; i &lt; bits; ++i)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (in6_bit(a, i) !=3D in6_bit(b, i))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            return false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* true if every bit of &lt;a&gt; from=
 bit &lt;from&gt; on is zero */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+in6_suffix_zero(const struct in6_addr *a, unsigned int from)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    for (unsigned int i =3D from; i &lt; 128; ++=
i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (in6_bit(a, i))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            return false;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+subnet_pools6_check(const struct=
 subnet_pool6_def *pools, const struct in6_addr *server_network,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    unsigned i=
nt server_netbits, msglvl_t msglevel)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    for (const struct subnet_pool6_def *d =3D pools; d; d =3D d-&gt;next)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (d-&gt;netbits &lt; 64 |=
| d-&gt;netbits &gt; 124)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        msg(msglevel, &quot;--subnet-pool-ipv6 %s: network must be between =
/64 and /124 (not /%u)&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                d-&gt;tag, d-&gt;netbits);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (!in6_suffix_zero(&amp;d-&gt;network, d-&gt;netbits))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &qu=
ot;--subnet-pool-ipv6 %s: network has host bits set&quot;, d-&gt;tag);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            return false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (!in6_prefix_equal(&amp;d-&gt;gatewa=
y, &amp;d-&gt;network, d-&gt;netbits)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            || in6_suffix_zero(&amp;d-&gt;gateway, d-&gt;=
netbits))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msgl=
evel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  &quot;--subnet-pool-ipv6 %s: gateway must be a host address inside the ne=
twork&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         d-&gt;tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (server_net=
bits</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &am=
p;&amp; in6_prefix_equal(&amp;d-&gt;network, server_network, min_uint(d-&gt=
;netbits, server_netbits)))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          msg(msglevel, &quot;--subnet-pool-ipv6 %s: network overlaps the -=
-server-ipv6 network&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                d-&gt;tag);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 for (const struct subnet_pool6_def *e =3D d-&gt;next; e; e =3D e-&gt;next)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            if (!strcmp(d-&gt=
;tag, e-&gt;tag))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        msg(msglevel, &quot;--subnet-pool-ipv6 %s: tag defined more than on=
ce&quot;, d-&gt;tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                return false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            if (in6_prefix_equal(&amp;d-&gt;network, &amp;e-&gt;netwo=
rk, min_uint(d-&gt;netbits, e-&gt;netbits)))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                msg(msglevel, &quot;--subnet-pool-ipv6 %=
s and %s: networks overlap&quot;, d-&gt;tag, e-&gt;tag);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                return false;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+const struct subnet_pool6_def *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+subnet_pool6_by_tag(const str=
uct subnet_pool6_def *pools, const char *tag)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    for (const struct subnet_pool6_def *d =3D pools; d; d =3D d-&gt=
;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!strcmp(d-&gt;t=
ag, tag))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return d=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> const char *</span><br><span> parse_auth_fai=
led_temp(struct options *o, const char *reason)</span><br><span> {</span><b=
r><span>diff --git a/src/openvpn/options_util=2Eh b/src/openvpn/options_uti=
l=2Eh</span><br><span>index d60759a=2E=2Ebffcddb 100644</span><br><span>---=
 a/src/openvpn/options_util=2Eh</span><br><span>+++ b/src/openvpn/options_u=
til=2Eh</span><br><span>@@ -53,6 +53,25 @@</span><br><span> bool subnet_poo=
ls_check(const struct subnet_pool_def *pools, in_addr_t server_network,</sp=
an><br><span>                         in_addr_t server_netmask, msglvl_t ms=
glevel);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * IPv6 c=
ounterpart of subnet_pools_check(): network between /64 and /124</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * without host bits, gateway =
a host address inside it, unique tags, and no</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * network overlapping another pool or the --serv=
er-ipv6 network=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pools   =
        head of the --subnet-pool-ipv6 list (may be NULL)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param server_network  the --serve=
r-ipv6 network</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram server_netbits  the --server-ipv6 prefix length, or 0 if there is none=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param msglevel =
       level of the message logged on the first error</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return                true if every d=
efinition is valid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool subnet_pools=
6_check(const struct subnet_pool6_def *pools,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                         const struct in6_addr *s=
erver_network, unsigned int server_netbits,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                         msglvl_t msglevel);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/** IPv6 counterpart of subnet_pool_by_tag()=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const struct =
subnet_pool6_def *subnet_pool6_by_tag(const struct subnet_pool6_def *pools,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                                const char *tag);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span> /** Check=
s if the string is a valid integer by checking if it can be</span><br><span=
>  *  converted to an integer */</span><br><span>diff --git a/src/openvpn/p=
ool=2Ec b/src/openvpn/pool=2Ec</span><br><span>index fa04d9c=2E=2E8f899d3 1=
00644</span><br><span>--- a/src/openvpn/pool=2Ec</span><br><span>+++ b/src/=
openvpn/pool=2Ec</span><br><span>@@ -445,6 +445,22 @@</span><br><span>     =
return true;</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ifconfig_pool_reserve_ipv6(struct ifconfig_pool *pool, const=
 struct in6_addr *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ifco=
nfig_pool_handle h =3D ifconfig_pool_ipv6_base_to_handle(pool, addr);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (h &lt; 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_poo=
l_entry_free(&amp;pool-&gt;list[h], true);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    pool-&gt;list[h]=2Ein_use =3D true;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    pool-&gt;list[h]=2Ereserved =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static in_add=
r_t</span><br><span> ifconfig_pool_handle_to_ip_base(const struct ifconfig_=
pool *pool, ifconfig_pool_handle hand)</span><br><span> {</span><br><span>d=
iff --git a/src/openvpn/pool=2Eh b/src/openvpn/pool=2Eh</span><br><span>ind=
ex 497dcda=2E=2Efda87ed 100644</span><br><span>--- a/src/openvpn/pool=2Eh</=
span><br><span>+++ b/src/openvpn/pool=2Eh</span><br><span>@@ -98,6 +98,9 @@=
</span><br><span>  */</span><br><span> bool ifconfig_pool_reserve_ip(struct=
 ifconfig_pool *pool, in_addr_t addr);</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/** IPv6 counterpart of ifconfig_pool_=
reserve_ip()=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
ool ifconfig_pool_reserve_ipv6(struct ifconfig_pool *pool, const struct in6=
_addr *addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> struct ifconfig_pool_persist *ifconfig_pool_persist_init(const =
char *filename, int refresh_freq);</span><br><span> </span><br><span> void =
ifconfig_pool_persist_close(struct ifconfig_pool_persist *persist);</span><=
br><span>diff --git a/tests/unit_tests/openvpn/test_subnet_pool=2Ec b/tests=
/unit_tests/openvpn/test_subnet_pool=2Ec</span><br><span>index 1bb9e4c=2E=
=2Ef3d58cb 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_subne=
t_pool=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_subnet_pool=
=2Ec</span><br><span>@@ -131,11 +131,88 @@</span><br><span>     assert_fals=
e(subnet_pools_check(&amp;a, 0, 0, M_WARN));</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* the IPv6 c=
ounterpart resolves independently: a tag may name a v4 pool, a</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * v6 pool, or both=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+test_subnet_pool6_by_tag(void **st=
ate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6_def c =3D=
 { =2Enext =3D NULL, =2Etag =3D &quot;grpC&quot;, =2Enetbits =3D 64 };</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6_=
def b =3D { =2Enext =3D &amp;c, =2Etag =3D &quot;grpB&quot;, =2Enetbits =3D=
 96 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct su=
bnet_pool6_def a =3D { =2Enext =3D &amp;b, =2Etag =3D &quot;grpA&quot;, =2E=
netbits =3D 64 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(=
subnet_pool6_by_tag(&amp;a, &quot;grpA&quot;), &amp;a);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(subnet_pool6_by_ta=
g(&amp;a, &quot;grpB&quot;), &amp;b);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_ptr_equal(subnet_pool6_by_tag(&amp;a, &quot;gr=
pC&quot;), &amp;c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(subnet_pool6_by_tag(&amp;a, &quot;grpB&quot;)-&gt;netb=
its, 96);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_null(subnet_pool6_by_tag(&amp;a, &quot;nope&quot;));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_null(subnet_pool6_by_tag(NULL,=
 &quot;grpA&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* &lt;prefix&gt;::&lt;host&gt; as a=
n in6_addr */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 struct in6_addr</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in6=
(const char *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr=
 a;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(inet_pton(AF_I=
NET6, addr, &amp;a), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return a;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* a single IPv6 pool, checked against=
 the fd00:8::/64 --server-ipv6 network */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+check6_one(const char *net, unsigned int bits, const char *gw=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const struct in6_addr server =3D=
 in6(&quot;fd00:8::&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct subnet_pool6_def d =3D { =2Enext =3D NULL, =2Etag =3D &q=
uot;grp&quot;, =2Enetwork =3D in6(net), =2Enetbits =3D bits, =2Egateway =3D=
 in6(gw) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return subnet_pools6_ch=
eck(&amp;d, &amp;server, 64, M_WARN);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+test_subnet_pools6_check(vo=
id **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* /64 =2E=2E /124, an=
y host address of the network as gateway */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(check6_one(&quot;fd00:9::&quot;, 64=
, &quot;fd00:9::1&quot;));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_true(check6_one(&quot;fd00:9::&quot;, 124, &quot;fd00:9::=
1&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_true(check6_one(&quot;fd00:9::&quot;, 112, &quot;fd00:9::ffff&quot;));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check=
6_one(&quot;fd00:9::&quot;, 63, &quot;fd00:9::1&quot;));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_false(check6_one(&quot;fd00=
:9::&quot;, 125, &quot;fd00:9::1&quot;));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* host bits in the network, gateway =3D network or outside it */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check=
6_one(&quot;fd00:9::5&quot;, 64, &quot;fd00:9::1&quot;));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_false(check6_one(&quot;fd0=
0:9::&quot;, 64, &quot;fd00:9::&quot;));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_false(check6_one(&quot;fd00:9::&quot;, 64, =
&quot;fd00:a::1&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* overlap=
ping the --server-ipv6 network, inside or covering it */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_false(check6_one(&quot;fd00=
:8::&quot;, 96, &quot;fd00:8::1&quot;));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* two pools: disjoint, overlapping, same tag */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const struct in6_addr server =3D in6=
(&quot;fd00:8::&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct subnet_pool6_def b =3D { =2Enext =3D NULL, =2Etag =3D &quot;=
grpB&quot;, =2Enetwork =3D in6(&quot;fd00:a::&quot;), =2Enetbits =3D 64, =
=2Egateway =3D in6(&quot;fd00:a::1&quot;) };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct subnet_pool6_def a =3D { =2Enext =3D &a=
mp;b, =2Etag =3D &quot;grpA&quot;, =2Enetwork =3D in6(&quot;fd00:9::&quot;)=
, =2Enetbits =3D 64, =2Egateway =3D in6(&quot;fd00:9::1&quot;) };</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(subnet_pools6_check(&amp;a, &amp=
;server, 64, M_WARN));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(subnet_pools6_check(&amp;a, &amp;server, 0, M_WARN));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    b=2Enetwork =3D in6(&quot;fd00:9::100=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=2Enet=
bits =3D 120;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
=2Egateway =3D in6(&quot;fd00:9::101&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_false(subnet_pools6_check(&amp;a, &amp;=
server, 64, M_WARN));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=2Enetwork =
=3D in6(&quot;fd00:a::&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    b=2Enetbits =3D 64;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    b=2Egateway =3D in6(&quot;fd00:a::1&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    b=2Etag =3D &quot;grpA&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(s=
ubnet_pools6_check(&amp;a, &amp;server, 64, M_WARN));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> const struct CMUnitTest subnet_pool_tests=
[] =3D {</span><br><span>     cmocka_unit_test(test_subnet_pool_by_tag),</s=
pan><br><span>     cmocka_unit_test(test_subnet_pools_check_netmask),</span=
><br><span>     cmocka_unit_test(test_subnet_pools_check_gateway),</span><b=
r><span>     cmocka_unit_test(test_subnet_pools_check_overlap),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_subne=
t_pool6_by_tag),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 cmocka_unit_test(test_subnet_pools6_check),</span><br><span> };</span><br>=
<span> </span><br><span> int</span><br></pre><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail">change 1786</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6=
4e0850d48647a2c0e3d385c2f20a9f445931727 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1786 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Antonio Quartulli=
 &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--M/Xf+WQVKt8=--


--===============7247859261292971087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7247859261292971087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7247859261292971087==--

