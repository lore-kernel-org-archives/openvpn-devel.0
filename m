Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FEDC44501
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 22:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Hxe0kWIlL1b7jEEIa+xAw67UF3q2S9FAHZIEKK/Uisk=; b=S/I4Hw8ckJVY8G
	geRP+cGeNfn3P6KSvZLTFrfCy6DVw2olRWktZfs4r3czGpPtothCblJywQ7rvHH7lYFtf4OWNPLud
	ge6ccHRFytC75ClaA22t50Q0YEIQyC4aZkhFq9TUwsQcB5ri6QKswDCMbT6XUm4W47wUqi4NmYrfn
	uSE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjlRp-0005r9-Mo;
	Tue, 14 Jul 2026 22:17:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjlRo-0005qu-Ba
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 22:17:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IPg/ltXHEG25eOVAiDM6Ocmo/jx2pdVG6ADBCOJ7A8I=; b=bGxXQ/LvXi8llknaiAW+hccR8I
 6nPmSfyleCk9fFCDVsvlK07wZIIO09TtR4U9OK/4hzzVE2BOoLzI0tB/wk7R7xmUH8iOp5y/F209a
 HiArz0LKDtt7INZDTPCqh9E8Sq1ejXW9xo2Yzbf1qJGZ7xXobSgYPiVyU9+UKci6FeAQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IPg/ltXHEG25eOVAiDM6Ocmo/jx2pdVG6ADBCOJ7A8I=; b=U
 VnSqHWTtJuc69+tO4M8+ufdHFe+3xXVo+fuHuMj+QEM3SXggESm2/WgNTDkrgWA3Q09/rPBYSdgTT
 +eoKOtXprVXoe74P5wfccuZ0/Z2dk1mIe6pUB/Mq1P6BzILZC2vRUXTwu5jK5KWnEqYK8IE2tKGP/
 y29hgKCAP03+ipO4=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjlRm-0002eF-9H for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 22:17:52 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-475881b9a4bso1296610f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 15:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784067459; x=1784672259; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IPg/ltXHEG25eOVAiDM6Ocmo/jx2pdVG6ADBCOJ7A8I=;
 b=SGLprTpy/EjB+KKX9qwigZtDxa0MJ845OsBqimrOsRoVxWMT5s021gVlq98ppSWVEx
 9ZdMcN7nyxHS+qZDbRrvxdKYCQRF81xxLuUafuCfpAaR9RRIAEwWYAd4lfau0Qy3gYVN
 5YSfG3m28ZcecG2o8BTsgpCb8zF6L9inA/fwhyrjnqaDVYhhMiv3xHZ7VXkqW15HiHsa
 nYJP2AMeqPBL6fB+ByWgWFnRQ1Q6jzbXXGaxEmhmh8zuL3XC/Tos4s/lYNIJicH6DSv6
 1xIU5dVGuOZGBf7TURMl7Teli1HhK1gTIvUEkcsDkolmDFQDBH4k/5PJ6/HC66fHXO5I
 F82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784067459; x=1784672259;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IPg/ltXHEG25eOVAiDM6Ocmo/jx2pdVG6ADBCOJ7A8I=;
 b=gG8uPyVCSfHnj709CPUa6B0KWUPOLbJD47eVMDPoWmDmWarIF5A1u+2kHuB1X3Bz2e
 wjPuEarHPb7rIcBquxsFkxz0uMNqbADLUmyGvORJzTLsaC1emghSzZUzCJry8oXa8a3p
 zfPCkJua940aRJXCHg5GSdXCuQIesW/L0DMvK0dRdNh9pN68HEQu+eiQeZMsekVyoAvE
 0OUDU0zk+s4jzoq9YMDO1zyZgdz1JI6MDtMyzwxQmYHGLa+kHiw8O2ksee5umko6fQJs
 I/sEMRYbV+O8WLC6ttBNgx/wHnSqONYYlZDc9jgIkf/XO7GfBVLsA8iU8abMaJF50Loj
 9s+w==
X-Gm-Message-State: AOJu0Ywad9x1Z9EDUMWzVAGgc1twyLhnRQp7awEO+lfmEyIIJ5JUf+NQ
 PV9tm/8wq4uccIHKsxRX/6a45mUHalgnJaVslbrGHHd/dufB7aMs3gS3yk3DT7q7/fc3nQdF6af
 Q+bYgFdEW4gQmRe8fMt3WQXJ+iUbGsi2UH93OJ3LI2fXjeoofxbANvI9oTXUh3zJZcUid8wHXLn
 fnSgAePg==
X-Gm-Gg: AfdE7clhYMLgwi0pw07Gin9lac52827tpJMNcffeN1zmVwUMRt3OzVTj3++e4Z69n5S
 4Qdm9jjS7FfXzccuBO3L7cghYFFaG8brwoxhBdfRI2ItdX8sv2xIDdGblb1GZetLjIOwe8qDqTC
 8NbMTdTnSD2lA90GwLVfVZPpZhKH8J6zPparfK+HoorGLwlUaIrREwk/1qCNOeJ9KVUeoUmDUns
 su53rDTteET5C+IvzOMoNanxttW8ss6zogi9TY2D4IAq8PlmkDW+Z30pwYa4d+TY6SkIyw8xvfp
 gHJZQyFHHLh32fqto4pORH9t1/e2W/9ADV0qUrjc+hpSCOjaCIYo/7SxKUbMlr4BZytskDR3jfr
 ixOoi5RkcuE8I/9/72BF6ggjKLjISdHQa5/2o/92kaWUKphv4SKK5aUMUpYftrU9MjUSvk0qEWo
 2RRb6DWwOyEcrClG1m738kYjgB2Ot0pVHXlFwH6zDlagDQG1cx0MQq/9TmVs0282RWN8YnL5CDI
 5nEbZ6N5M+ZDPv7Rb+rB5krgctM/qocq5m3KFF1OrykBMH139HMq1aiE9zVRTVNFkASZjDHQq9y
 d/Y=
X-Received: by 2002:a05:6000:1ac7:b0:470:2fb1:3db5 with SMTP id
 ffacd0b85a97d-47f2dd20824mr16129708f8f.30.1784067458476; 
 Tue, 14 Jul 2026 15:17:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635c86csm10935702f8f.16.2026.07.14.15.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 15:17:38 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 22:17:37 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
X-Gerrit-Change-Number: 1783
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1783?usp=email>
X-Gerrit-Commit: 4786ae8ca577fea293664e3d0ece8dbabf8d91b0
References: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLklhMWU3ZGI5NTYxNWQ5OWVmOTY4N2RlN2M0ZTk5NmRjODAzM2UyNjMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1a9a1dc870c20bb0822f1adbd7f2e7e2bc11e303-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjlRm-0002eF-9H
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi: assign
 clients from a named, tagged subnet-pool
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
Content-Type: multipart/mixed; boundary="===============4401625786692705247=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4401625786692705247==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IylGO4ZUbl8="; charset=UTF-8

--IylGO4ZUbl8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1783?usp=3Demail

to review the following change=2E


Chang=
e subject: multi: assign clients from a named, tagged subnet-pool
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: assign clients =
from a named, tagged subnet-pool

Add two server directives:

  subnet-pool=
 <tag> <network> <netmask> [<gateway>]   (main config)
  subnet-pool-tag <t=
ag>                               (per-client CCD)

so groups of clients ca=
n be given addresses from subnets other than the
--server network (per-grou=
p firewall rules under --topology subnet, and
thus DCO)=2E A client's subne=
t-pool-tag is resolved to its pool and served
a virtual IP from that subnet=
: a static --ifconfig-push within it, or the
next free address from a dynam=
ic per-group pool shared by tag and created
on first use=2E Such a client i=
s validated against its own subnet instead
of the global tunnel-network con=
straint and never falls back to the
global pool; a tag matching no configur=
ed pool is declined with
AUTH_FAILED=2E

Change-Id: Ia1e7db95615d99ef9687de=
7c4e996dc8033e2631
GitHub: closes openvpn/OpenVPN#987
Signed-off-by: Antoni=
o Quartulli <antonio@mandelbit=2Ecom>
---
M doc/man-sections/server-options=
=2Erst
M src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/option=
s=2Ec
M src/openvpn/options=2Eh
5 files changed, 209 insertions(+), 5 delet=
ions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/83/1783/1

diff --git a/doc/man-sections/server-options=2Erst b/doc/man-=
sections/server-options=2Erst
index f420588=2E=2E8800b98 100644
--- a/doc/m=
an-sections/server-options=2Erst
+++ b/doc/man-sections/server-options=2Ers=
t
@@ -330,6 +330,31 @@
   by ``--ifconfig``, OpenVPN will install a /32 hos=
t route for the ``local``
   IP address=2E
 
+--subnet-pool args
+  Define =
a named pool of addresses from a subnet different from the
+  ``--server`` =
network, so groups of clients can be given IPs from separate
+  subnets for=
 per-group firewall rules under ``--topology subnet`` (and
+  therefore DCO=
)=2E This is a main-config directive and may be repeated to
+  define sever=
al pools=2E
+
+  Valid syntax:
+  ::
+
+     subnet-pool tag network netmas=
k [gateway]
+
+  ``tag`` is a name a client refers to with ``--subnet-pool-=
tag``; ``gateway``
+  defaults to the first address of ``network``/``netmas=
k``=2E A client assigned
+  to a pool receives (dynamically, or via a stati=
c ``--ifconfig-push`` that
+  must lie within the subnet) an address from i=
t, plus the matching netmask, a
+  ``--route-gateway`` inside the subnet, a=
nd a host route back to the server's
+  VPN IP, so it is reachable without =
manual per-client route pushes=2E
+
+--subnet-pool-tag tag
+  Assign this c=
lient to the ``--subnet-pool`` named ``tag``=2E Must be
+  associated with =
a specific client instance via ``--client-config-dir`` or
+  ``--client-con=
nect``=2E Several clients may reference the same tag and are
+  then served=
 from the same shared pool=2E
+
 --ifconfig-ipv6-push args
   for ``--clien=
t-config-dir`` per-client static IPv6 interface
   configuration, see ``--c=
lient-config-dir`` and ``--ifconfig-push`` for
diff --git a/src/openvpn/mul=
ti=2Ec b/src/openvpn/multi=2Ec
index c4293a7=2E=2E84f25b3 100644
--- a/src/=
openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -53,6 +53,17 @@
 #include =
"dco=2Eh"
 #include "reflect_filter=2Eh"
 
+/*
+ * Dynamic address pool ser=
ving the clients of one --subnet-pool tag=2E  Shared
+ * by every client th=
at references the tag, created on first use=2E
+ */
+struct subnet_pool
+{
=
+    struct subnet_pool *next;
+    const char *tag;
+    struct ifconfig_p=
ool *pool;
+};
+
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
 #ifdef MULTI_DEBUG_=
EVENT_LOOP
@@ -612,7 +623,8 @@
 
         schedule_remove_entry(m->schedule=
, (struct schedule_entry *)mi);
 
-        ifconfig_pool_release(m->ifconfi=
g_pool, mi->vaddr_handle, false);
+        ifconfig_pool_release(mi->vaddr_=
pool ? mi->vaddr_pool : m->ifconfig_pool, mi->vaddr_handle,
+              =
                false);
 
         if (mi->did_iroutes)
         {
@@ -687,=
6 +699,14 @@
         schedule_free(m->schedule);
         mbuf_free(m->mbu=
f);
         ifconfig_pool_free(m->ifconfig_pool);
+        while (m->subne=
t_pools)
+        {
+            struct subnet_pool *sp =3D m->subnet_pools=
;
+
+            m->subnet_pools =3D sp->next;
+            ifconfig_pool_f=
ree(sp->pool);
+            free(sp);
+        }
         frequency_limit_f=
ree(m->new_connection_limiter);
         initial_rate_limit_free(m->initial=
_rate_limiter);
         multi_reap_free(m->reaper);
@@ -1384,6 +1404,12 @@=

     const struct options *o =3D &c->options;
     if (o->push_ifconfig_co=
nstraint_defined && c->c2=2Epush_ifconfig_defined)
     {
+        /* a sub=
net-pool client is validated against its own subnet */
+        if (o->subn=
et_pool_defined)
+        {
+            return (o->subnet_pool_netmask & c=
->c2=2Epush_ifconfig_local)
+                   =3D=3D o->subnet_pool_netwo=
rk;
+        }
         return (o->push_ifconfig_constraint_netmask & c->c2=
=2Epush_ifconfig_local)
                =3D=3D o->push_ifconfig_constraint_=
network;
     }
@@ -1393,6 +1419,47 @@
     }
 }
 
+static const struct sub=
net_pool_def *
+subnet_pool_by_tag(const struct options *o, const char *tag=
)
+{
+    for (const struct subnet_pool_def *d =3D o->subnet_pools; d; d =
=3D d->next)
+    {
+        if (!strcmp(d->tag, tag))
+        {
+        =
    return d;
+        }
+    }
+    return NULL;
+}
+
+/*
+ * Return the d=
ynamic pool serving the clients tagged with <tag>, creating it
+ * on first=
 use from the matching --subnet-pool definition=2E
+ */
+static struct ifco=
nfig_pool *
+multi_get_group_pool(struct multi_context *m, const char *tag)=

+{
+    struct subnet_pool *sp;
+
+    for (sp =3D m->subnet_pools; sp; sp=
 =3D sp->next)
+    {
+        if (!strcmp(sp->tag, tag))
+        {
+     =
       return sp->pool;
+        }
+    }
+
+    const struct subnet_pool_d=
ef *d4 =3D subnet_pool_by_tag(&m->top=2Eoptions, tag);
+    ALLOC_OBJ_CLEAR=
(sp, struct subnet_pool);
+    sp->tag =3D d4->tag;
+    sp->pool =3D ifcon=
fig_pool_init(true, IFCONFIG_POOL_INDIV, d4->network + 2,
+                =
                  (d4->network | ~d4->netmask) - 1, m->top=2Eoptions=2Edupl=
icate_cn,
+                                  false, in6addr_any, 0);
+    s=
p->next =3D m->subnet_pools;
+    m->subnet_pools =3D sp;
+    return sp->p=
ool;
+}
+
 /*
  * Select a virtual address for a new client instance=2E
  *=
 Use an --ifconfig-push directive, if given (static IP)=2E
@@ -1403,6 +1470=
,21 @@
 {
     struct gc_arena gc =3D gc_new();
 
+    /* resolve a CCD --s=
ubnet-pool-tag against the main-config --subnet-pool list
+     * (an unkno=
wn tag is rejected with AUTH_FAILED in multi_client_connect) */
+    if (mi=
->context=2Eoptions=2Esubnet_pool_tag && !mi->context=2Eoptions=2Esubnet_po=
ol_defined)
+    {
+        const struct subnet_pool_def *d =3D
+          =
  subnet_pool_by_tag(&m->top=2Eoptions, mi->context=2Eoptions=2Esubnet_pool=
_tag);
+        if (d)
+        {
+            mi->context=2Eoptions=2Esubn=
et_pool_defined =3D true;
+            mi->context=2Eoptions=2Esubnet_pool_=
network =3D d->network;
+            mi->context=2Eoptions=2Esubnet_pool_ne=
tmask =3D d->netmask;
+            mi->context=2Eoptions=2Esubnet_pool_gate=
way =3D d->gateway;
+        }
+    }
+
     /*
      * If ifconfig address=
es were set by dynamic config file,
      * release pool addresses, otherwi=
se keep them=2E
@@ -1413,8 +1495,10 @@
          * release dynamic allocati=
on */
         if (mi->vaddr_handle >=3D 0)
         {
-            ifconfi=
g_pool_release(m->ifconfig_pool, mi->vaddr_handle, true);
+            ifco=
nfig_pool_release(mi->vaddr_pool ? mi->vaddr_pool : m->ifconfig_pool,
+    =
                              mi->vaddr_handle, true);
             mi->vad=
dr_handle =3D -1;
+            mi->vaddr_pool =3D NULL;
         }
 
      =
   mi->context=2Ec2=2Epush_ifconfig_defined =3D true;
@@ -1434,6 +1518,44 @=
@
                 "MULTI_sva: WARNING: if --ifconfig-push is used for IPv4=
, automatic IPv6 assignment from --ifconfig-ipv6-pool does not work=2E  Use=
 --ifconfig-ipv6-push for IPv6 then=2E");
         }
     }
+    else if (m=
i->context=2Eoptions=2Esubnet_pool_defined)
+    {
+        /* dynamic addr=
ess from this client's --subnet-pool group */
+
+        /* the CCD is read=
 after a global-pool address may already have been
+         * acquired; dr=
op it so we can serve this client from its group */
+        if (mi->vaddr_=
handle >=3D 0 && !mi->vaddr_pool)
+        {
+            ifconfig_pool_rel=
ease(m->ifconfig_pool, mi->vaddr_handle, true);
+            mi->vaddr_hand=
le =3D -1;
+        }
+
+        if (mi->vaddr_handle < 0)
+        {
+    =
        in_addr_t local =3D 0, remote =3D 0;
+            const char *cn =
=3D NULL;
+
+            if (!mi->context=2Eoptions=2Eduplicate_cn)
+      =
      {
+                cn =3D tls_common_name(mi->context=2Ec2=2Etls_mult=
i, true);
+            }
+
+            mi->vaddr_pool =3D multi_get_group_=
pool(m, mi->context=2Eoptions=2Esubnet_pool_tag);
+            mi->vaddr_ha=
ndle =3D ifconfig_pool_acquire(mi->vaddr_pool, &local, &remote, NULL, cn);
=
+            if (mi->vaddr_handle >=3D 0)
+            {
+                m=
i->context=2Ec2=2Epush_ifconfig_local =3D remote;
+                mi->cont=
ext=2Ec2=2Epush_ifconfig_remote_netmask =3D
+                    mi->contex=
t=2Eoptions=2Esubnet_pool_netmask;
+                mi->context=2Ec2=2Epush=
_ifconfig_defined =3D true;
+            }
+            else
+            {=

+                msg(D_MULTI_ERRORS, "MULTI: no free --subnet-pool address=
es are available for %s",
+                    multi_instance_string(mi, fa=
lse, &gc));
+            }
+        }
+    }
     else if (m->ifconfig_pool=
 && mi->vaddr_handle < 0) /* otherwise, choose a pool address */
     {
   =
      in_addr_t local =3D 0, remote =3D 0;
@@ -2339,10 +2461,9 @@
         =
const char *ifconfig_constraint_netmask =3D
             print_in_addr_t(mi=
->context=2Eoptions=2Epush_ifconfig_constraint_netmask, 0, &gc);
 
-       =
 /* JYFIXME -- this should cause the connection to fail */
         msg(D_M=
ULTI_ERRORS,
-            "MULTI ERROR: primary virtual IP for %s (%s) "
- =
           "violates tunnel network/netmask constraint (%s/%s)",
+         =
   "WARNING: primary virtual IP for %s (%s) "
+            "violates tunnel=
 network/netmask constraint (%s/%s) and may not work",
             multi_i=
nstance_string(mi, false, &gc),
             print_in_addr_t(mi->context=2E=
c2=2Epush_ifconfig_local, 0, &gc),
             ifconfig_constraint_network=
, ifconfig_constraint_netmask);
@@ -2450,6 +2571,7 @@
 
     /* reset pool =
handle to null */
     mi->vaddr_handle =3D -1;
+    mi->vaddr_pool =3D NUL=
L;
 
     /* do --client-connect setenvs */
     multi_select_virtual_addr(=
m, mi);
@@ -2741,6 +2863,15 @@
         cc_succeeded =3D false;
     }
 
+ =
   if (mi->context=2Eoptions=2Esubnet_pool_tag
+        && !subnet_pool_by_=
tag(&m->top=2Eoptions, mi->context=2Eoptions=2Esubnet_pool_tag))
+    {
+  =
      msg(D_MULTI_ERRORS, "MULTI: client has been rejected due to unknown -=
-subnet-pool-tag '%s'",
+            mi->context=2Eoptions=2Esubnet_pool_ta=
g);
+        auth_set_client_reason(mi->context=2Ec2=2Etls_multi, "unknown =
subnet-pool-tag");
+        cc_succeeded =3D false;
+    }
+
     if (cc_su=
cceeded)
     {
         multi_client_connect_late_setup(m, mi, *option_typ=
es_found);
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index=
 8b837fa=2E=2Ef6815f4 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/=
multi=2Eh
@@ -121,6 +121,8 @@
     struct mroute_addr real; /**< External n=
etwork address of the
                               *   remote peer=2E */
=
     ifconfig_pool_handle vaddr_handle;
+    /* pool vaddr_handle belongs t=
o (NULL =3D the global one) */
+    struct ifconfig_pool *vaddr_pool;
     =
char msg_prefix[MULTI_PREFIX_MAX_LENGTH];
 
     /* queued outgoing data in=
 Server/TCP mode */
@@ -176,6 +178,8 @@
                                   =
      *   instances=2E */
     struct multi_io *multi_io;         /**< I/O =
state and events tracker */
     struct ifconfig_pool *ifconfig_pool;
+    =
/* per-group --subnet-pool dynamic pools */
+    struct subnet_pool *subnet=
_pools;
     struct frequency_limit *new_connection_limiter;
     struct in=
itial_packet_rate_limit *initial_rate_limiter;
     struct mroute_helper *r=
oute_helper;
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec=

index 87218d4=2E=2Ec395671 100644
--- a/src/openvpn/options=2Ec
+++ b/src/=
openvpn/options=2Ec
@@ -7631,6 +7631,33 @@
             goto err;
         =
}
     }
+    else if (streq(p[0], "subnet-pool") && p[1] && p[2] && p[3] &=
& !p[5])
+    {
+        struct subnet_pool_def *sp;
+        in_addr_t net=
work, netmask;
+
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        networ=
k =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[2], 0, NULL, NULL);
+=
        netmask =3D getaddr(GETADDR_HOST_ORDER, p[3], 0, NULL, NULL);
+    =
    if (!network || !netmask)
+        {
+            msg(msglevel, "cannot=
 parse --subnet-pool addresses");
+            goto err;
+        }
+      =
  ALLOC_OBJ_GC(sp, struct subnet_pool_def, &options->gc);
+        sp->tag =
=3D p[1];
+        sp->network =3D network & netmask;
+        sp->netmask =
=3D netmask;
+        sp->gateway =3D p[4] ? getaddr(GETADDR_HOST_ORDER | G=
ETADDR_RESOLVE, p[4], 0, NULL, NULL)
+                           : (network=
 & netmask) + 1;
+        sp->next =3D options->subnet_pools;
+        opti=
ons->subnet_pools =3D sp;
+    }
+    else if (streq(p[0], "subnet-pool-tag=
") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_INSTANCE);
+  =
      options->subnet_pool_tag =3D p[1];
+    }
     else if (streq(p[0], "=
ifconfig-push-constraint") && p[1] && p[2] && !p[3])
     {
         in_add=
r_t network, netmask;
diff --git a/src/openvpn/options=2Eh b/src/openvpn/op=
tions=2Eh
index a111cf8=2E=2E0c810b3 100644
--- a/src/openvpn/options=2Eh
+=
++ b/src/openvpn/options=2Eh
@@ -250,6 +250,17 @@
     struct verify_hash_l=
ist *next;
 };
 
+/* A named --subnet-pool: a subnet clients can be assigne=
d from, referenced
+ * from a CCD file by its tag via --subnet-pool-tag=2E =
*/
+struct subnet_pool_def
+{
+    struct subnet_pool_def *next;
+    const=
 char *tag;
+    in_addr_t network;
+    in_addr_t netmask;
+    in_addr_t =
gateway;
+};
+
 /* Command line options */
 struct options
 {
@@ -515,6 +52=
6,12 @@
     bool push_ifconfig_constraint_defined;
     in_addr_t push_ifc=
onfig_constraint_network;
     in_addr_t push_ifconfig_constraint_netmask;
=
+    struct subnet_pool_def *subnet_pools; /* named pools (server config) *=
/
+    const char *subnet_pool_tag;          /* which pool this client uses=
 (CCD) */
+    bool subnet_pool_defined;             /* resolved from the t=
ag at connect */
+    in_addr_t subnet_pool_network;
+    in_addr_t subnet_=
pool_netmask;
+    in_addr_t subnet_pool_gateway;
     bool push_ifconfig_i=
pv4_blocked;           /* IPv4 */
     bool push_ifconfig_ipv6_defined;    =
       /* IPv6 */
     struct in6_addr push_ifconfig_ipv6_local;  /* IPv6 *=
/

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia1e7db95615d99ef=
9687de7c4e996dc8033e2631
Gerrit-Change-Number: 1783
Gerrit-PatchSet: 1
Gerr=
it-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--IylGO4ZUbl8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1783?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">mu=
lti: assign clients from a named, tagged subnet-pool<br><br>Add two server =
directives:<br><br>  subnet-pool &lt;tag&gt; &lt;network&gt; &lt;netmask&gt=
; [&lt;gateway&gt;]   (main config)<br>  subnet-pool-tag &lt;tag&gt;       =
                        (per-client CCD)<br><br>so groups of clients can be=
 given addresses from subnets other than the<br>--server network (per-group=
 firewall rules under --topology subnet, and<br>thus DCO)=2E A client&#39;s=
 subnet-pool-tag is resolved to its pool and served<br>a virtual IP from th=
at subnet: a static --ifconfig-push within it, or the<br>next free address =
from a dynamic per-group pool shared by tag and created<br>on first use=2E =
Such a client is validated against its own subnet instead<br>of the global =
tunnel-network constraint and never falls back to the<br>global pool; a tag=
 matching no configured pool is declined with<br>AUTH_FAILED=2E<br><br>Chan=
ge-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631<br>GitHub: closes openvpn/=
OpenVPN#987<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom=
&gt;<br>---<br>M doc/man-sections/server-options=2Erst<br>M src/openvpn/mul=
ti=2Ec<br>M src/openvpn/multi=2Eh<br>M src/openvpn/options=2Ec<br>M src/ope=
nvpn/options=2Eh<br>5 files changed, 209 insertions(+), 5 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/83/1783/1</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/doc/man-sections/server-options=
=2Erst b/doc/man-sections/server-options=2Erst</span><br><span>index f42058=
8=2E=2E8800b98 100644</span><br><span>--- a/doc/man-sections/server-options=
=2Erst</span><br><span>+++ b/doc/man-sections/server-options=2Erst</span><b=
r><span>@@ -330,6 +330,31 @@</span><br><span>   by ``--ifconfig``, OpenVPN =
will install a /32 host route for the ``local``</span><br><span>   IP addre=
ss=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+--subnet-pool args</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  Define a named pool of addresses from a subnet different from the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--server`` network, =
so groups of clients can be given IPs from separate</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  subnets for per-group firewall rules un=
der ``--topology subnet`` (and</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  therefore DCO)=2E This is a main-config directive and may be r=
epeated to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  define =
several pools=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  Valid syntax:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  ::</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     subnet-pool tag network netmask [gateway]</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  ``tag`` is a name a client refers to with ``--subn=
et-pool-tag``; ``gateway``</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  defaults to the first address of ``network``/``netmask``=2E A clie=
nt assigned</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  to a p=
ool receives (dynamically, or via a static ``--ifconfig-push`` that</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  must lie within the subne=
t) an address from it, plus the matching netmask, a</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  ``--route-gateway`` inside the subnet, =
and a host route back to the server&#39;s</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  VPN IP, so it is reachable without manual per-clien=
t route pushes=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+--subnet-pool-tag tag=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Assign this clien=
t to the ``--subnet-pool`` named ``tag``=2E Must be</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  associated with a specific client insta=
nce via ``--client-config-dir`` or</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  ``--client-connect``=2E Several clients may reference the =
same tag and are</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  t=
hen served from the same shared pool=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> --ifconfig-ipv6-push args</span><br><=
span>   for ``--client-config-dir`` per-client static IPv6 interface</span>=
<br><span>   configuration, see ``--client-config-dir`` and ``--ifconfig-pu=
sh`` for</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/m=
ulti=2Ec</span><br><span>index c4293a7=2E=2E84f25b3 100644</span><br><span>=
--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</sp=
an><br><span>@@ -53,6 +53,17 @@</span><br><span> #include &quot;dco=2Eh&quo=
t;</span><br><span> #include &quot;reflect_filter=2Eh&quot;</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Dynamic address pool serving th=
e clients of one --subnet-pool tag=2E  Shared</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * by every client that references the tag, creat=
ed on first use=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct subnet_poo=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool *next;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *tag;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool =
*pool;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*#define MU=
LTI_DEBUG_EVENT_LOOP*/</span><br><span> </span><br><span> #ifdef MULTI_DEBU=
G_EVENT_LOOP</span><br><span>@@ -612,7 +623,8 @@</span><br><span> </span><b=
r><span>         schedule_remove_entry(m-&gt;schedule, (struct schedule_ent=
ry *)mi);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        ifconfig_pool_release(m-&gt;ifconfig_pool, mi-&gt;vaddr_handl=
e, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
fconfig_pool_release(mi-&gt;vaddr_pool ? mi-&gt;vaddr_pool : m-&gt;ifconfig=
_pool, mi-&gt;vaddr_handle,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                              false);</span><br><span> </span><br><=
span>         if (mi-&gt;did_iroutes)</span><br><span>         {</span><br>=
<span>@@ -687,6 +699,14 @@</span><br><span>         schedule_free(m-&gt;sch=
edule);</span><br><span>         mbuf_free(m-&gt;mbuf);</span><br><span>   =
      ifconfig_pool_free(m-&gt;ifconfig_pool);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        while (m-&gt;subnet_pools)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            struct subnet_pool *sp =3D m-=
&gt;subnet_pools;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m-&gt;sub=
net_pools =3D sp-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            ifconfig_pool_free(sp-&gt;pool);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            free(sp);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>         freq=
uency_limit_free(m-&gt;new_connection_limiter);</span><br><span>         in=
itial_rate_limit_free(m-&gt;initial_rate_limiter);</span><br><span>        =
 multi_reap_free(m-&gt;reaper);</span><br><span>@@ -1384,6 +1404,12 @@</spa=
n><br><span>     const struct options *o =3D &amp;c-&gt;options;</span><br>=
<span>     if (o-&gt;push_ifconfig_constraint_defined &amp;&amp; c-&gt;c2=
=2Epush_ifconfig_defined)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* a subnet-pool client is validated a=
gainst its own subnet */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (o-&gt;subnet_pool_defined)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            return (o-&gt;subnet_pool_netmask &amp; c-&gt;c2=
=2Epush_ifconfig_local)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                   =3D=3D o-&gt;subnet_pool_network;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>         ret=
urn (o-&gt;push_ifconfig_constraint_netmask &amp; c-&gt;c2=2Epush_ifconfig_=
local)</span><br><span>                =3D=3D o-&gt;push_ifconfig_constrain=
t_network;</span><br><span>     }</span><br><span>@@ -1393,6 +1419,47 @@</s=
pan><br><span>     }</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static const struct subnet_pool_def *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+subnet_pool_by_tag(=
const struct options *o, const char *tag)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    for (const struct subnet_pool_def *d =3D o-&gt;subnet_pools; d; d =
=3D d-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!strcm=
p(d-&gt;tag, tag))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 return d;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return the d=
ynamic pool serving the clients tagged with &lt;tag&gt;, creating it</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * on first use from the m=
atching --subnet-pool definition=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static struct ifconfig_pool *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+multi_get_group_pool(struct multi_context *m, const char *tag)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool *sp;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    for (sp =3D m-&gt;subnet_pools; sp; sp =3D sp-&=
gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!strcmp(sp-&g=
t;tag, tag))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retur=
n sp-&gt;pool;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const struct subnet_pool_def *d4 =3D subnet_=
pool_by_tag(&amp;m-&gt;top=2Eoptions, tag);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(sp, struct subnet_pool);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;tag =3D d4-&gt;=
tag;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;pool=
 =3D ifconfig_pool_init(true, IFCONFIG_POOL_INDIV, d4-&gt;network + 2,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
          (d4-&gt;network | ~d4-&gt;netmask) - 1, m-&gt;top=2Eoptions=2Edup=
licate_cn,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                         false, in6addr_any, 0);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    sp-&gt;next =3D m-&gt;subnet_pools;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;subnet_pools =3D=
 sp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sp-&=
gt;pool;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><b=
r><span>  * Select a virtual address for a new client instance=2E</span><br=
><span>  * Use an --ifconfig-push directive, if given (static IP)=2E</span>=
<br><span>@@ -1403,6 +1470,21 @@</span><br><span> {</span><br><span>     st=
ruct gc_arena gc =3D gc_new();</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* resolve a CCD --subnet-pool-tag against=
 the main-config --subnet-pool list</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * (an unknown tag is rejected with AUTH_FAILED in mult=
i_client_connect) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (mi-&gt;context=2Eoptions=2Esubnet_pool_tag &amp;&amp; !mi-&gt;cont=
ext=2Eoptions=2Esubnet_pool_defined)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        const struct subnet_pool_def *d =3D</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            subnet_pool_by_tag(&amp;m-&gt;top=2E=
options, mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (d)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            mi-&gt;context=2Eoptions=2Esubnet_pool_defin=
ed =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     mi-&gt;context=2Eoptions=2Esubnet_pool_network =3D d-&gt;network;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;conte=
xt=2Eoptions=2Esubnet_pool_netmask =3D d-&gt;netmask;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=2Eoptions=2Esu=
bnet_pool_gateway =3D d-&gt;gateway;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>     /*</span><br><span>      * If ifconfig addresses were set by=
 dynamic config file,</span><br><span>      * release pool addresses, other=
wise keep them=2E</span><br><span>@@ -1413,8 +1495,10 @@</span><br><span>  =
        * release dynamic allocation */</span><br><span>         if (mi-&gt=
;vaddr_handle &gt;=3D 0)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            ifconfig_pool_release(m-&gt;ifc=
onfig_pool, mi-&gt;vaddr_handle, true);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            ifconfig_pool_release(mi-&gt;vaddr_pool ? m=
i-&gt;vaddr_pool : m-&gt;ifconfig_pool,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                  mi-&gt;vaddr_handle, =
true);</span><br><span>             mi-&gt;vaddr_handle =3D -1;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;vaddr_pool =
=3D NULL;</span><br><span>         }</span><br><span> </span><br><span>    =
     mi-&gt;context=2Ec2=2Epush_ifconfig_defined =3D true;</span><br><span>=
@@ -1434,6 +1518,44 @@</span><br><span>                 &quot;MULTI_sva: WA=
RNING: if --ifconfig-push is used for IPv4, automatic IPv6 assignment from =
--ifconfig-ipv6-pool does not work=2E  Use --ifconfig-ipv6-push for IPv6 th=
en=2E&quot;);</span><br><span>         }</span><br><span>     }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    else if (mi-&gt;context=2Eo=
ptions=2Esubnet_pool_defined)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* dynamic address from this client&#39;s --subnet-pool group */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* the CCD is read after a global-poo=
l address may already have been</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+         * acquired; drop it so we can serve this client from i=
ts group */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (mi-&gt;vaddr_handle &gt;=3D 0 &amp;&amp; !mi-&gt;vaddr_pool)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            ifconfig_pool_release(m-&gt;=
ifconfig_pool, mi-&gt;vaddr_handle, true);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            mi-&gt;vaddr_handle =3D -1;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (mi-&gt;vaddr_handle &lt; 0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            in_addr_t local =3D 0, remote =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            const cha=
r *cn =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!mi-&gt=
;context=2Eoptions=2Eduplicate_cn)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                cn =3D tls_common_name(mi-&gt;context=2Ec2=2Etls_m=
ulti, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;vaddr_pool =
=3D multi_get_group_pool(m, mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;vad=
dr_handle =3D ifconfig_pool_acquire(mi-&gt;vaddr_pool, &amp;local, &amp;rem=
ote, NULL, cn);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (mi-&gt;vaddr_handle &gt;=3D 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                mi-&gt;context=2Ec2=2Epush_ifconfig_local =
=3D remote;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        mi-&gt;context=2Ec2=2Epush_ifconfig_remote_netmask =3D</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    mi-&gt;conte=
xt=2Eoptions=2Esubnet_pool_netmask;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                mi-&gt;context=2Ec2=2Epush_ifconfig_defined=
 =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            els=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(D_MU=
LTI_ERRORS, &quot;MULTI: no free --subnet-pool addresses are available for =
%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          multi_instance_string(mi, false, &amp;gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span>     else if (m-&gt;ifconfig_pool &=
amp;&amp; mi-&gt;vaddr_handle &lt; 0) /* otherwise, choose a pool address *=
/</span><br><span>     {</span><br><span>         in_addr_t local =3D 0, re=
mote =3D 0;</span><br><span>@@ -2339,10 +2461,9 @@</span><br><span>        =
 const char *ifconfig_constraint_netmask =3D</span><br><span>             p=
rint_in_addr_t(mi-&gt;context=2Eoptions=2Epush_ifconfig_constraint_netmask,=
 0, &amp;gc);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        /* JYFIXME -- this should cause the connection to fail */=
</span><br><span>         msg(D_MULTI_ERRORS,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            &quot;MULTI ERROR: primary virtual IP f=
or %s (%s) &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        &quot;violates tunnel network/netmask constraint (%s/%s)&quot;,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;WARNI=
NG: primary virtual IP for %s (%s) &quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            &quot;violates tunnel network/netmask con=
straint (%s/%s) and may not work&quot;,</span><br><span>             multi_=
instance_string(mi, false, &amp;gc),</span><br><span>             print_in_=
addr_t(mi-&gt;context=2Ec2=2Epush_ifconfig_local, 0, &amp;gc),</span><br><s=
pan>             ifconfig_constraint_network, ifconfig_constraint_netmask);=
</span><br><span>@@ -2450,6 +2571,7 @@</span><br><span> </span><br><span>  =
   /* reset pool handle to null */</span><br><span>     mi-&gt;vaddr_handle=
 =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;=
vaddr_pool =3D NULL;</span><br><span> </span><br><span>     /* do --client-=
connect setenvs */</span><br><span>     multi_select_virtual_addr(m, mi);</=
span><br><span>@@ -2741,6 +2863,15 @@</span><br><span>         cc_succeeded=
 =3D false;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;context=2Eoptions=2Esubnet=
_pool_tag</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &a=
mp;&amp; !subnet_pool_by_tag(&amp;m-&gt;top=2Eoptions, mi-&gt;context=2Eopt=
ions=2Esubnet_pool_tag))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
sg(D_MULTI_ERRORS, &quot;MULTI: client has been rejected due to unknown --s=
ubnet-pool-tag &#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        auth_set_client=
_reason(mi-&gt;context=2Ec2=2Etls_multi, &quot;unknown subnet-pool-tag&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cc_succe=
eded =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
    if (cc_succeeded)</span><br><span>     {</span><br><span>         multi=
_client_connect_late_setup(m, mi, *option_types_found);</span><br><span>dif=
f --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh</span><br><span>ind=
ex 8b837fa=2E=2Ef6815f4 100644</span><br><span>--- a/src/openvpn/multi=2Eh<=
/span><br><span>+++ b/src/openvpn/multi=2Eh</span><br><span>@@ -121,6 +121,=
8 @@</span><br><span>     struct mroute_addr real; /**&lt; External network=
 address of the</span><br><span>                               *   remote p=
eer=2E */</span><br><span>     ifconfig_pool_handle vaddr_handle;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* pool vaddr_handle belo=
ngs to (NULL =3D the global one) */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct ifconfig_pool *vaddr_pool;</span><br><span>     =
char msg_prefix[MULTI_PREFIX_MAX_LENGTH];</span><br><span> </span><br><span=
>     /* queued outgoing data in Server/TCP mode */</span><br><span>@@ -176=
,6 +178,8 @@</span><br><span>                                         *   i=
nstances=2E */</span><br><span>     struct multi_io *multi_io;         /**&=
lt; I/O state and events tracker */</span><br><span>     struct ifconfig_po=
ol *ifconfig_pool;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* per-group --subnet-pool dynamic pools */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct subnet_pool *subnet_pools;</span><br>=
<span>     struct frequency_limit *new_connection_limiter;</span><br><span>=
     struct initial_packet_rate_limit *initial_rate_limiter;</span><br><spa=
n>     struct mroute_helper *route_helper;</span><br><span>diff --git a/src=
/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 87218d=
4=2E=2Ec395671 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><=
br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -7631,6 +7631,33 =
@@</span><br><span>             goto err;</span><br><span>         }</span>=
<br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else if (streq(p[0], &quot;subnet-pool&quot;) &amp;&amp; p[1] &amp;&amp; p=
[2] &amp;&amp; p[3] &amp;&amp; !p[5])</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        struct subnet_pool_def *sp;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        in_addr_t network, netmask;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        network =3D getaddr(GETADDR_=
HOST_ORDER | GETADDR_RESOLVE, p[2], 0, NULL, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        netmask =3D getaddr(GETADDR_HOST_=
ORDER, p[3], 0, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (!network || !netmask)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            msg(msglevel, &quot;cannot parse --subnet-pool add=
resses&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ALLOC=
_OBJ_GC(sp, struct subnet_pool_def, &amp;options-&gt;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;tag =3D p[1];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;network =3D n=
etwork &amp; netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        sp-&gt;netmask =3D netmask;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        sp-&gt;gateway =3D p[4] ? getaddr(GETADDR_HOST_OR=
DER | GETADDR_RESOLVE, p[4], 0, NULL, NULL)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                           : (network &amp; netmask=
) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sp-&g=
t;next =3D options-&gt;subnet_pools;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        options-&gt;subnet_pools =3D sp;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;subnet-pool-tag&quot=
;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        VERIFY_PERMISSION(OPT_P_INSTANCE);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        options-&gt;subnet_pool_tag =3D p[1];</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> =
    else if (streq(p[0], &quot;ifconfig-push-constraint&quot;) &amp;&amp; p=
[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>     {</span><br><spa=
n>         in_addr_t network, netmask;</span><br><span>diff --git a/src/ope=
nvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index a111cf8=2E=
=2E0c810b3 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><=
span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -250,6 +250,17 @@</sp=
an><br><span>     struct verify_hash_list *next;</span><br><span> };</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A nam=
ed --subnet-pool: a subnet clients can be assigned from, referenced</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * from a CCD file by its t=
ag via --subnet-pool-tag=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+struct subnet_pool_def</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct subnet_pool_def *next;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const char *tag;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    in_addr_t network;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    in_addr_t netmask;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    in_addr_t gateway;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> /* Command line options */</span><br><span> struct opt=
ions</span><br><span> {</span><br><span>@@ -515,6 +526,12 @@</span><br><spa=
n>     bool push_ifconfig_constraint_defined;</span><br><span>     in_addr_=
t push_ifconfig_constraint_network;</span><br><span>     in_addr_t push_ifc=
onfig_constraint_netmask;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct subnet_pool_def *subnet_pools; /* named pools (server conf=
ig) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cha=
r *subnet_pool_tag;          /* which pool this client uses (CCD) */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    bool subnet_pool_defin=
ed;             /* resolved from the tag at connect */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    in_addr_t subnet_pool_network;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t subnet_pool=
_netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_add=
r_t subnet_pool_gateway;</span><br><span>     bool push_ifconfig_ipv4_block=
ed;           /* IPv4 */</span><br><span>     bool push_ifconfig_ipv6_defin=
ed;           /* IPv6 */</span><br><span>     struct in6_addr push_ifconfig=
_ipv6_local;  /* IPv6 */</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail">cha=
nge 1783</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1783 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;=
antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--IylGO4ZUbl8=--


--===============4401625786692705247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4401625786692705247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4401625786692705247==--

