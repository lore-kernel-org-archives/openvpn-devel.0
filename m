Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2612C43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 22:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=ogRjghfSxaEEs3Ypz66tywu3HOAgjHKvR5n/PLKP1EM=; b=htSfawZPSu3SH7
	21uMUYgrnNUi9OAh4yg0DudAgnup0w8PXxvPxMo5dhZiyc8EPo4+ALZ5hP3eC6KDEv/v05Q0nqZy4
	BmFUEX5ndh5CuseGVjpLJf/X68fpIiLMtZcZFfNBEhEQjHo+W0T+01DbGdfpDCl8nGylA+awuEeKq
	mKQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjlRt-00062k-1d;
	Tue, 14 Jul 2026 22:17:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjlRo-00062S-WE
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 22:17:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nsdJYe4lw4QSjxWv2KmLuHqPdnp0OFE1IpUT9qnPEeE=; b=LAqyk0ETjFvUTyNt7QKzT+P4uD
 gb6H8WZFLO0ivde176HzElY7wAOQFmfKvmHvxNS1HBEfhkU53O0o3hKRcPC8gvT2YEdTomnvS7csI
 0uqr36c6h1U9F5EiP0hdXJ0oJWAvcZdCNeq3V+hQK4DRoCxuzDHKG7O/GrLJ2xrbnTck=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nsdJYe4lw4QSjxWv2KmLuHqPdnp0OFE1IpUT9qnPEeE=; b=C
 KYQaXaBLvNryEvJBUFp7iqKYh5JPBeFH+lqLc9tJA2EMyn+NHi4R23py/HAq29FuiWcVs2YwoRJT0
 jEWq45ZsKSJmvpz3wSVduo81Qd56isrkgtFTNKIOj1VcQwY9ZLYRpZ56hiCSsRskrT9AvjztC5/kY
 +U86ynjwXtzlR5Xk=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjlRn-0002eJ-6l for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 22:17:53 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-470174001a0so769657f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 15:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784067460; x=1784672260; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nsdJYe4lw4QSjxWv2KmLuHqPdnp0OFE1IpUT9qnPEeE=;
 b=J+TVaFl090gJlwQs0A+zTdiPdpp2eoIsVH6oz+4jgU5weTuLzEwXsMuZfL4/K69CjE
 TKfBtyooOu2NzAZZhc7aCiMjyTGVyeHEpCjAbpkWutP9bciKpOBk2Iqf1i5ohTt9UDxO
 MbmSSPfIBptZLitVrHeD0ODsJHDq428j3wVTm9mEcp3gTehtCu+fH4kFGbn6iEEYSUkE
 p45Rf8y1OZaQgjkp2078wb3VfYD3aLEoLSLYyebw5vXFpWu/XfIUPpApM/ZQtK4b52mz
 hCBrE/g/60ofXaqE3OtyfNScOSpU2AVI2XVEdRi0oMeRx5w1enD68JZFs6Jo5ckejE8U
 78pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784067460; x=1784672260;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nsdJYe4lw4QSjxWv2KmLuHqPdnp0OFE1IpUT9qnPEeE=;
 b=rMQudMgEJd3Mae36B1wwx5nvcm1JuFrxV5pn/qmEE9BbO2QyTSzEQVt82qF2vf59yx
 /WL95CDzyEcTgJ+Yt2J4HBrxoa7tkAAclP3gVx48MaGy+SSrLUBSYjp4UwwcUEHoZ5Rf
 Ojj1uGwnFpkTVQYegll16veukp77KyU5urIRFLeKGYSj9qJ+Wp8BNOmb1KaSreFCuqfg
 V0qAzfmS0ZYPr3Cb8biLB6l3V/0Xop0pjc5ie4wOc1lqmKrfZcNiXJkZN3xD9iwJjn0j
 GZWzCvc4DTP0z5XPzXdnaFprwyV0ouSEvGKptXrD2+KJCuVJR/mCNxS/pvZHlwe8iKwx
 4CFA==
X-Gm-Message-State: AOJu0Ywibw9gjnavWh6Vgcsyq5Mbb8DeoCqJoO6Vk0t05xR+0WXlsnui
 5frGej1jnwPKXOjDc1Ln8WPYT8uBKKi87asZcNJ59gv+l07O5llk+p5WISFpm8HyZhpr/lpUQQu
 4vla5fqFcGMy4KRpCahZv6fVFLPX1JH0gY27fUWL/93KgcMtZS81QaKERkH+kD+BhUUtVgCuKwz
 zAuifkNw==
X-Gm-Gg: AfdE7clqokJNc5/zKy4ttG1XCINKJggp9taLZZJp2cw06yt/Fv/0XrGdNj/sy0Rq+O9
 SXZVtw3Iq9Sb04njmgk39/qzPdGRL3/36JE2Zfxo64oT0yq6RYV2aLFy4KrheZZ4ge/W5Neoh2p
 cHLUVPmJTVQ2/3BhtTmwbUc/MOTqqcQxnYC8teCm0pD4GyyEI+lCULleinJPexbksGVrQx5Ad9e
 iwAwW+slFdXYZYo/aM8loDCFiW/phE/0V1TF4YLp3O3Akv9858KkQ/QMXIh+C++Q1oMRRkOWa1x
 RHQAYQIJ1xuX3sypnLbYoOAa8Iz9ZgeRk2xeZ5Rv2EAJLIU3cSu0CsD25TnX/2RtESjZzWpeflz
 /v+KNWektMJhQKa/RVglpViNfdooS1N1weSuqyEsKs155NKvEMcFen90fPckGYcApyL5udwhAH6
 PMH6wsgOg28GlZgIw0M9bdnKBPQN0K575NhoNwt8rNamYgQMH7bikeQW9p72y1YGEmFfMD9RJsV
 znkzQTrsa3Xp0nT24dbjYT7HiGtqSPF+5Jn3b0+uAjkE+aHdjktev/c35cKdlcRA1tRs38/8/o/
 Q5Q=
X-Received: by 2002:a05:6000:2406:b0:473:975c:4fd1 with SMTP id
 ffacd0b85a97d-47f2dcae339mr18133784f8f.25.1784067459418; 
 Tue, 14 Jul 2026 15:17:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635a935sm11078288f8f.11.2026.07.14.15.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 15:17:39 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 22:17:38 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727
X-Gerrit-Change-Number: 1786
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1786?usp=email>
X-Gerrit-Commit: 72c1d8d81e3a2fc5962597d5d8d627718ca8952d
References: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkk2NGUwODUwZDQ4NjQ3YTJjMGUzZDM4NWMyZjIwYTlmNDQ1OTMxNzI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7eda2e5a8ca0a5caa69c9f1550494bee37b0d3e2-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjlRn-0002eJ-6l
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
Content-Type: multipart/mixed; boundary="===============0356789942734128360=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0356789942734128360==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VOyM7etN61M="; charset=UTF-8

--VOyM7etN61M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1786?usp=3Demail

to review the following change=2E


Chang=
e subject: multi: assign IPv6 addresses from a tagged subnet-pool
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: assign IPv6 add=
resses from a tagged subnet-pool

Add the IPv6 counterpart of --subnet-pool=
:

  subnet-pool-ipv6 <tag> <network>/<bits> [<gateway>]   (main config)

s=
elected by the same per-client --subnet-pool-tag=2E A client's tag is
resol=
ved against the IPv6 pool list too and, when it matches, an IPv6
address is=
 handed out from the group's pool alongside any IPv4 one (a
single dual-sta=
ck ifconfig_pool per tag)=2E A tag matching neither family
is still decline=
d with AUTH_FAILED=2E

Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727=

GitHub: closes openvpn/OpenVPN#987
Signed-off-by: Antonio Quartulli <anton=
io@mandelbit=2Ecom>
---
M doc/man-sections/server-options=2Erst
M src/openv=
pn/multi=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M src/open=
vpn/options_util=2Ec
M src/openvpn/options_util=2Eh
6 files changed, 136 in=
sertions(+), 25 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/86/1786/1

diff --git a/doc/man-sections/server-opt=
ions=2Erst b/doc/man-sections/server-options=2Erst
index 8800b98=2E=2Ecf929=
05 100644
--- a/doc/man-sections/server-options=2Erst
+++ b/doc/man-section=
s/server-options=2Erst
@@ -349,11 +349,24 @@
   ``--route-gateway`` inside =
the subnet, and a host route back to the server's
   VPN IP, so it is reach=
able without manual per-client route pushes=2E
 
+--subnet-pool-ipv6 args
+=
  The IPv6 counterpart of ``--subnet-pool``=2E Repeatable main-config direc=
tive=2E
+
+  Valid syntax:
+  ::
+
+     subnet-pool-ipv6 tag network/bits =
[gateway]
+
+  ``bits`` must be between 64 and 124; ``gateway`` defaults to=
 the first
+  address of the network=2E A tag may name an IPv4 pool, an IPv=
6 pool, or both;
+  a client referencing it with ``--subnet-pool-tag`` is t=
hen assigned an
+  address from each family the tag defines=2E
+
 --subnet-=
pool-tag tag
-  Assign this client to the ``--subnet-pool`` named ``tag``=
=2E Must be
-  associated with a specific client instance via ``--client-co=
nfig-dir`` or
-  ``--client-connect``=2E Several clients may reference the =
same tag and are
-  then served from the same shared pool=2E
+  Assign this=
 client to the ``--subnet-pool`` / ``--subnet-pool-ipv6`` named
+  ``tag``=
=2E Must be associated with a specific client instance via
+  ``--client-co=
nfig-dir`` or ``--client-connect``=2E Several clients may
+  reference the =
same tag and are then served from the same shared pool(s)=2E
 
 --ifconfig-=
ipv6-push args
   for ``--client-config-dir`` per-client static IPv6 interf=
ace
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index da46cf=
4=2E=2E1cd84b6 100644
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
index c395671=2E=2E027d5f8 100644
--- a/src/openvpn/options=2Ec
++=
+ b/src/openvpn/options=2Ec
@@ -7653,6 +7653,37 @@
         sp->next =3D op=
tions->subnet_pools;
         options->subnet_pools =3D sp;
     }
+    els=
e if (streq(p[0], "subnet-pool-ipv6") && p[1] && p[2] && !p[4])
+    {
+   =
     struct subnet_pool6_def *sp;
+        struct in6_addr network, gateway=
;
+        unsigned int netbits =3D 0;
+
+        VERIFY_PERMISSION(OPT_P_G=
ENERAL);
+        if (!get_ipv6_addr(p[2], &network, &netbits, msglevel))
+=
        {
+            msg(msglevel, "cannot parse --subnet-pool-ipv6 netwo=
rk");
+            goto err;
+        }
+        if (netbits < 64 || netbit=
s > 124)
+        {
+            msg(msglevel, "--subnet-pool-ipv6 network =
must be between /64 and /124 (not /%d)",
+                netbits);
+      =
      goto err;
+        }
+        if (p[3] && !get_ipv6_addr(p[3], &gatew=
ay, NULL, msglevel))
+        {
+            msg(msglevel, "cannot parse --=
subnet-pool-ipv6 gateway");
+            goto err;
+        }
+        ALLO=
C_OBJ_GC(sp, struct subnet_pool6_def, &options->gc);
+        sp->tag =3D p=
[1];
+        sp->network =3D network;
+        sp->netbits =3D netbits;
+ =
       sp->gateway =3D p[3] ? gateway : add_in6_addr(network, 1);
+        =
sp->next =3D options->subnet_pools_ipv6;
+        options->subnet_pools_ipv=
6 =3D sp;
+    }
     else if (streq(p[0], "subnet-pool-tag") && p[1] && !p=
[2])
     {
         VERIFY_PERMISSION(OPT_P_INSTANCE);
diff --git a/src/op=
envpn/options=2Eh b/src/openvpn/options=2Eh
index 0c810b3=2E=2E7f0e3ce 1006=
44
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -261,6 +2=
61,16 @@
     in_addr_t gateway;
 };
 
+/* The IPv6 counterpart of struct s=
ubnet_pool_def (--subnet-pool-ipv6)=2E */
+struct subnet_pool6_def
+{
+    =
struct subnet_pool6_def *next;
+    const char *tag;
+    struct in6_addr n=
etwork;
+    unsigned int netbits;
+    struct in6_addr gateway;
+};
+
 /* =
Command line options */
 struct options
 {
@@ -526,12 +536,17 @@
     bool =
push_ifconfig_constraint_defined;
     in_addr_t push_ifconfig_constraint_n=
etwork;
     in_addr_t push_ifconfig_constraint_netmask;
-    struct subnet=
_pool_def *subnet_pools; /* named pools (server config) */
-    const char =
*subnet_pool_tag;          /* which pool this client uses (CCD) */
-    boo=
l subnet_pool_defined;             /* resolved from the tag at connect */
+=
    struct subnet_pool_def *subnet_pools;       /* named IPv4 pools (server=
 config) */
+    struct subnet_pool6_def *subnet_pools_ipv6; /* named IPv6 =
pools (server config) */
+    const char *subnet_pool_tag;                /=
* which pool this client uses (CCD) */
+    bool subnet_pool_defined;      =
             /* resolved from the tag at connect */
     in_addr_t subnet_p=
ool_network;
     in_addr_t subnet_pool_netmask;
     in_addr_t subnet_pool=
_gateway;
+    bool subnet_pool_ipv6_defined; /* resolved from the tag at c=
onnect */
+    struct in6_addr subnet_pool_ipv6_network;
+    unsigned int =
subnet_pool_ipv6_netbits;
+    struct in6_addr subnet_pool_ipv6_gateway;
  =
   bool push_ifconfig_ipv4_blocked;           /* IPv4 */
     bool push_ifc=
onfig_ipv6_defined;           /* IPv6 */
     struct in6_addr push_ifconfig=
_ipv6_local;  /* IPv6 */
diff --git a/src/openvpn/options_util=2Ec b/src/op=
envpn/options_util=2Ec
index ba04917=2E=2E7826458 100644
--- a/src/openvpn/=
options_util=2Ec
+++ b/src/openvpn/options_util=2Ec
@@ -44,6 +44,19 @@
    =
 return NULL;
 }
 
+const struct subnet_pool6_def *
+subnet_pool6_by_tag(co=
nst struct subnet_pool6_def *pools, const char *tag)
+{
+    for (const str=
uct subnet_pool6_def *d =3D pools; d; d =3D d->next)
+    {
+        if (!s=
trcmp(d->tag, tag))
+        {
+            return d;
+        }
+    }
+  =
  return NULL;
+}
+
 const char *
 parse_auth_failed_temp(struct options *o=
, const char *reason)
 {
diff --git a/src/openvpn/options_util=2Eh b/src/op=
envpn/options_util=2Eh
index c54357c=2E=2Eed2017a 100644
--- a/src/openvpn/=
options_util=2Eh
+++ b/src/openvpn/options_util=2Eh
@@ -38,6 +38,10 @@
 con=
st struct subnet_pool_def *subnet_pool_by_tag(const struct subnet_pool_def =
*pools,
                                                  const char *tag);=

 
+/** IPv6 counterpart of subnet_pool_by_tag()=2E */
+const struct subnet=
_pool6_def *subnet_pool6_by_tag(const struct subnet_pool6_def *pools,
+    =
                                               const char *tag);
+
 
 /** C=
hecks if the string is a valid integer by checking if it can be
  *  conver=
ted to an integer */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1786?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I64e0850d48647a2c0e3d385c2f20a9f445931727
Gerrit-Change-Number: 1786
Gerr=
it-PatchSet: 1
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewe=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn=
@rfc2549=2Eorg>

--VOyM7etN61M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1786?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">mu=
lti: assign IPv6 addresses from a tagged subnet-pool<br><br>Add the IPv6 co=
unterpart of --subnet-pool:<br><br>  subnet-pool-ipv6 &lt;tag&gt; &lt;netwo=
rk&gt;/&lt;bits&gt; [&lt;gateway&gt;]   (main config)<br><br>selected by th=
e same per-client --subnet-pool-tag=2E A client&#39;s tag is<br>resolved ag=
ainst the IPv6 pool list too and, when it matches, an IPv6<br>address is ha=
nded out from the group&#39;s pool alongside any IPv4 one (a<br>single dual=
-stack ifconfig_pool per tag)=2E A tag matching neither family<br>is still =
declined with AUTH_FAILED=2E<br><br>Change-Id: I64e0850d48647a2c0e3d385c2f2=
0a9f445931727<br>GitHub: closes openvpn/OpenVPN#987<br>Signed-off-by: Anton=
io Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M doc/man-sections/s=
erver-options=2Erst<br>M src/openvpn/multi=2Ec<br>M src/openvpn/options=2Ec=
<br>M src/openvpn/options=2Eh<br>M src/openvpn/options_util=2Ec<br>M src/op=
envpn/options_util=2Eh<br>6 files changed, 136 insertions(+), 25 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/86/1786/1</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/server-=
options=2Erst b/doc/man-sections/server-options=2Erst</span><br><span>index=
 8800b98=2E=2Ecf92905 100644</span><br><span>--- a/doc/man-sections/server-=
options=2Erst</span><br><span>+++ b/doc/man-sections/server-options=2Erst</=
span><br><span>@@ -349,11 +349,24 @@</span><br><span>   ``--route-gateway``=
 inside the subnet, and a host route back to the server&#39;s</span><br><sp=
an>   VPN IP, so it is reachable without manual per-client route pushes=2E<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--=
subnet-pool-ipv6 args</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  The IPv6 counterpart of ``--subnet-pool``=2E Repeatable main-config dir=
ective=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  Valid syntax:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  ::</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     subnet-pool-ipv6 tag network/bits [gateway]</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  ``bits`` must be between 64 and 124; ``gateway`` defaul=
ts to the first</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ad=
dress of the network=2E A tag may name an IPv4 pool, an IPv6 pool, or both;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  a client referenc=
ing it with ``--subnet-pool-tag`` is then assigned an</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  address from each family the tag define=
s=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> --subnet-pool-tag tag</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  Assign this client to the ``--subnet-pool`` named ``tag``=2E Must be</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  associated with a spe=
cific client instance via ``--client-config-dir`` or</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  ``--client-connect``=2E Several clients m=
ay reference the same tag and are</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  then served from the same shared pool=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  Assign this client to the ``--subnet-p=
ool`` / ``--subnet-pool-ipv6`` named</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  ``tag``=2E Must be associated with a specific client ins=
tance via</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--clie=
nt-config-dir`` or ``--client-connect``=2E Several clients may</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  reference the same tag and are=
 then served from the same shared pool(s)=2E</span><br><span> </span><br><s=
pan> --ifconfig-ipv6-push args</span><br><span>   for ``--client-config-dir=
`` per-client static IPv6 interface</span><br><span>diff --git a/src/openvp=
n/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index da46cf4=2E=2E1cd8=
4b6 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ =
b/src/openvpn/multi=2Ec</span><br><span>@@ -1438,11 +1438,14 @@</span><br><=
span>     }</span><br><span> </span><br><span>     const struct subnet_pool=
_def *d4 =3D subnet_pool_by_tag(m-&gt;top=2Eoptions=2Esubnet_pools, tag);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct subn=
et_pool6_def *d6 =3D subnet_pool6_by_tag(m-&gt;top=2Eoptions=2Esubnet_pools=
_ipv6, tag);</span><br><span>     ALLOC_OBJ_CLEAR(sp, struct subnet_pool);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sp-&gt;tag =3D d4-=
&gt;tag;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sp-&gt;po=
ol =3D ifconfig_pool_init(true, IFCONFIG_POOL_INDIV, d4-&gt;network + 2,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
          (d4-&gt;network | ~d4-&gt;netmask) - 1, m-&gt;top=2Eoptions=2Edup=
licate_cn,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                       false, in6addr_any, 0);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    sp-&gt;tag =3D d4 ? d4-&gt;tag : d6-&gt;tag;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;pool =3D=
 ifconfig_pool_init(d4 !=3D NULL, IFCONFIG_POOL_INDIV, d4 ? d4-&gt;network =
+ 2 : 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                       d4 ? (d4-&gt;network | ~d4-&gt;netmask) - 1 : 0,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
           m-&gt;top=2Eoptions=2Eduplicate_cn, d6 !=3D NULL,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
d6 ? add_in6_addr(d6-&gt;network, 2) : in6addr_any,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                  d6 ? (i=
nt)d6-&gt;netbits : 0);</span><br><span>     sp-&gt;next =3D m-&gt;subnet_p=
ools;</span><br><span>     m-&gt;subnet_pools =3D sp;</span><br><span>     =
return sp-&gt;pool;</span><br><span>@@ -1472,6 +1475,18 @@</span><br><span>=
             mi-&gt;context=2Eoptions=2Esubnet_pool_gateway =3D d-&gt;gatew=
ay;</span><br><span>         }</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;context=2Eoptions=2Esubnet=
_pool_tag &amp;&amp; !mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_defined)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        const struct subnet_pool6_=
def *d =3D subnet_pool6_by_tag(</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            m-&gt;top=2Eoptions=2Esubnet_pools_ipv6, mi-&gt;con=
text=2Eoptions=2Esubnet_pool_tag);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (d)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_defined =3D true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;co=
ntext=2Eoptions=2Esubnet_pool_ipv6_network =3D d-&gt;network;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=2Eopti=
ons=2Esubnet_pool_ipv6_netbits =3D d-&gt;netbits;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            mi-&gt;context=2Eoptions=2Esubnet=
_pool_ipv6_gateway =3D d-&gt;gateway;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span> </span><br><span>     /*</span><br><span>   =
   * If ifconfig addresses were set by dynamic config file,</span><br><span=
>@@ -1506,42 +1521,60 @@</span><br><span>                 &quot;MULTI_sva: =
WARNING: if --ifconfig-push is used for IPv4, automatic IPv6 assignment fro=
m --ifconfig-ipv6-pool does not work=2E  Use --ifconfig-ipv6-push for IPv6 =
then=2E&quot;);</span><br><span>         }</span><br><span>     }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    else if (mi-&gt;context=2Eo=
ptions=2Esubnet_pool_defined)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else if (mi-&gt;context=2Eoptions=2Esubnet_pool_tag)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 /* dynamic address from this client&#39;s --subnet-pool group */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        /* dynamic address(es=
) from this client&#39;s --subnet-pool group */</span><br><span> </span><br=
><span>         /* the CCD is read after a global-pool address may already =
have been</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * a=
cquired; drop it so we can serve this client from its group */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+         * acquired; drop it so =
we serve this client from its group only */</span><br><span>         if (mi=
-&gt;vaddr_handle &gt;=3D 0 &amp;&amp; !mi-&gt;vaddr_pool)</span><br><span>=
         {</span><br><span>             ifconfig_pool_release(m-&gt;ifconfi=
g_pool, mi-&gt;vaddr_handle, true);</span><br><span>             mi-&gt;vad=
dr_handle =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          mi-&gt;context=2Ec2=2Epush_ifconfig_defined =3D false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=2Ec=
2=2Epush_ifconfig_ipv6_defined =3D false;</span><br><span>         }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if=
 (mi-&gt;vaddr_handle &lt; 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if ((mi-&gt;context=2Eoptions=2Esubnet_pool_defined</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+             || mi-&gt;co=
ntext=2Eoptions=2Esubnet_pool_ipv6_defined)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            &amp;&amp; mi-&gt;vaddr_handle &lt; 0)<=
/span><br><span>         {</span><br><span>             in_addr_t local =3D=
 0, remote =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          struct in6_addr remote_ipv6;</span><br><span>             const c=
har *cn =3D NULL;</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            CLEAR(remote_ipv6);</span><br><span>           =
  if (!mi-&gt;context=2Eoptions=2Eduplicate_cn)</span><br><span>           =
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
ndex c395671=2E=2E027d5f8 100644</span><br><span>--- a/src/openvpn/options=
=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -7653=
,6 +7653,37 @@</span><br><span>         sp-&gt;next =3D options-&gt;subnet_=
pools;</span><br><span>         options-&gt;subnet_pools =3D sp;</span><br>=
<span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    els=
e if (streq(p[0], &quot;subnet-pool-ipv6&quot;) &amp;&amp; p[1] &amp;&amp; =
p[2] &amp;&amp; !p[4])</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        str=
uct subnet_pool6_def *sp;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        struct in6_addr network, gateway;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        unsigned int netbits =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (!get_ipv6_addr(p=
[2], &amp;network, &amp;netbits, msglevel))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(msglevel, &quot;cannot parse --subnet-pool-ip=
v6 network&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (netbits &lt; 64 || netbits &gt; 124)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            msg(msglevel, &quot;--subnet-pool-ipv6 network must b=
e between /64 and /124 (not /%d)&quot;,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                netbits);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            goto err;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (p[3] &amp;&amp; !get_ipv6_addr(p[3], &amp;gat=
eway, NULL, msglevel))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(msglevel, &quot;cannot parse --subnet-pool-ipv6 gateway&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        ALLOC_OBJ_GC(sp, struc=
t subnet_pool6_def, &amp;options-&gt;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        sp-&gt;tag =3D p[1];</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        sp-&gt;network =3D network;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;netbits =3D n=
etbits;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sp-&=
gt;gateway =3D p[3] ? gateway : add_in6_addr(network, 1);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;next =3D options-&gt;s=
ubnet_pools_ipv6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      options-&gt;subnet_pools_ipv6 =3D sp;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span>     else if (streq(p[0], &qu=
ot;subnet-pool-tag&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span=
>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_INSTANCE);</span><=
br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</sp=
an><br><span>index 0c810b3=2E=2E7f0e3ce 100644</span><br><span>--- a/src/op=
envpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><=
span>@@ -261,6 +261,16 @@</span><br><span>     in_addr_t gateway;</span><br=
><span> };</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* The IPv6 counterpart of struct subnet_pool_def (--subnet-pool-i=
pv6)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct su=
bnet_pool6_def</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6=
_def *next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t char *tag;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct in6_addr network;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    unsigned int netbits;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct in6_addr gateway;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> /* Command line options */</span><br><span> struct option=
s</span><br><span> {</span><br><span>@@ -526,12 +536,17 @@</span><br><span>=
     bool push_ifconfig_constraint_defined;</span><br><span>     in_addr_t =
push_ifconfig_constraint_network;</span><br><span>     in_addr_t push_ifcon=
fig_constraint_netmask;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    struct subnet_pool_def *subnet_pools; /* named pools (server config) =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *sub=
net_pool_tag;          /* which pool this client uses (CCD) */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    bool subnet_pool_defined;     =
        /* resolved from the tag at connect */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct subnet_pool_def *subnet_pools;       =
/* named IPv4 pools (server config) */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct subnet_pool6_def *subnet_pools_ipv6; /* named=
 IPv6 pools (server config) */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const char *subnet_pool_tag;                /* which pool th=
is client uses (CCD) */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    bool subnet_pool_defined;                   /* resolved from the ta=
g at connect */</span><br><span>     in_addr_t subnet_pool_network;</span><=
br><span>     in_addr_t subnet_pool_netmask;</span><br><span>     in_addr_t=
 subnet_pool_gateway;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    bool subnet_pool_ipv6_defined; /* resolved from the tag at connect */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr=
 subnet_pool_ipv6_network;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    unsigned int subnet_pool_ipv6_netbits;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct in6_addr subnet_pool_ipv6_gateway;=
</span><br><span>     bool push_ifconfig_ipv4_blocked;           /* IPv4 */=
</span><br><span>     bool push_ifconfig_ipv6_defined;           /* IPv6 */=
</span><br><span>     struct in6_addr push_ifconfig_ipv6_local;  /* IPv6 */=
</span><br><span>diff --git a/src/openvpn/options_util=2Ec b/src/openvpn/op=
tions_util=2Ec</span><br><span>index ba04917=2E=2E7826458 100644</span><br>=
<span>--- a/src/openvpn/options_util=2Ec</span><br><span>+++ b/src/openvpn/=
options_util=2Ec</span><br><span>@@ -44,6 +44,19 @@</span><br><span>     re=
turn NULL;</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+const struct subnet_pool6_def *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+subnet_pool6_by_tag(const struct su=
bnet_pool6_def *pools, const char *tag)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    for (const struct subnet_pool6_def *d =3D pools; d; d =3D d-&gt;next)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (!strcmp(d-&gt;tag, ta=
g))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            return d;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return NULL;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> const char *</span><br><span> parse_auth_failed_tem=
p(struct options *o, const char *reason)</span><br><span> {</span><br><span=
>diff --git a/src/openvpn/options_util=2Eh b/src/openvpn/options_util=2Eh</=
span><br><span>index c54357c=2E=2Eed2017a 100644</span><br><span>--- a/src/=
openvpn/options_util=2Eh</span><br><span>+++ b/src/openvpn/options_util=2Eh=
</span><br><span>@@ -38,6 +38,10 @@</span><br><span> const struct subnet_po=
ol_def *subnet_pool_by_tag(const struct subnet_pool_def *pools,</span><br><=
span>                                                  const char *tag);</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** =
IPv6 counterpart of subnet_pool_by_tag()=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+const struct subnet_pool6_def *subnet_pool6_by_t=
ag(const struct subnet_pool6_def *pools,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                                   con=
st char *tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> </span><br><span> /** Checks if the string is a valid integer =
by checking if it can be</span><br><span>  *  converted to an integer */</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail">change 1786</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I64e0850d48647a2c0e3=
d385c2f20a9f445931727 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 1786 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--VOyM7etN61M=--


--===============0356789942734128360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0356789942734128360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0356789942734128360==--

