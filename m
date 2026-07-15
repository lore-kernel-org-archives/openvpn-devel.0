Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BFEC44501
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 07:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G4uS19fywez/Ash7DWEWVUz6VAZs18E8pak2IR3s6kw=; b=eKvl6Mt4vNQU84d2I7+kXeY0CB
	TIqK6u74KsRuDTS/EkPArDJe0m9dyvk8y1H0/Dy/Ad8eS9jDtJIKTghYlA5SlOHXQnehsuwPVJzAf
	JZhvfL5Yh0hd7rJTn6dRYaAYRHgEBJ520ab8/n5IHALViqmQbjiXCdEOwoCHcQuo2/1A=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjuUZ-00089f-95;
	Wed, 15 Jul 2026 07:57:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjuUX-00089X-3r
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 07:57:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9WtngU4NCCCmApVYCOJNr6lnpD0wksj3oKR4dW5i0yU=; b=MXHOCQ8J9nbrb6QqkI+tW912WA
 OrB3VvT98tpdtC7ATfRZsZEMleXUIfPwGfxKSB96ZLt18BjPmVLv0y50HYGhB8u+5bs9QzQnopkSm
 DzwK8qOvxRxwBZ90WjlNeL5TdQW0VuAObEMIBSTvnujj1Sjb1+PamGF8ZCCdD8rj8Luo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9WtngU4NCCCmApVYCOJNr6lnpD0wksj3oKR4dW5i0yU=; b=m
 JXvywJLgWCS28M65DiwMgFqEV5d9Og27Fsd5QMLFDuzrqdzdoR1WUtjPmknjTF07PDP902KOJjVGM
 qSPXfPLvUv4b57oACW9szx583JPuU5rIHxRZYvBJBc2AGHGxf1uhmRH7it4KCjANAqS00pPlBh5Gu
 Dq8/+mH1vBrMKEoI=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjuUV-0006bG-0y for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 07:57:17 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4938d5f86f3so10788045e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 00:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784102223; x=1784707023; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9WtngU4NCCCmApVYCOJNr6lnpD0wksj3oKR4dW5i0yU=;
 b=KMLa/fQrg8P1lWdtORaE1EDY/XsnOvkG2SKpiGS/+ovzJVSNIqYhhI6ATNNxYzFE9a
 Kz0M2mO+M/z44vdxhwizj1M0/OouHvhBPb65cTbt0VyGqP/k14n57URbblieadCjDB/o
 ZH4lAje7aaGzZ8ZMp+Notm0tnA3kVaxecJNdELreN8Xeu0ihbeEJqmLjK9+5hVsCsCTv
 SzTfb6/JyUbL2DjTQ7XZ/mL6shVSLVkqZGXg8mdHjenqft8SYlFxeBbz7WiOmpauYL1O
 el5XcAs7Ib+fOXokZ1UkTMitZ1EdbUU7v9aoht/Xf88wyTWqrpkRzvTty52vPHv273S3
 HkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784102223; x=1784707023;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9WtngU4NCCCmApVYCOJNr6lnpD0wksj3oKR4dW5i0yU=;
 b=ibUhAtkJKzfzwuZpMEhSZsBXFQEvc7/FtFmehOTBDXhcGo/jsnKrpErN3R2SaZ65zW
 PgWrfEVCmfndcT2QOw+P44F63fE62M7yD6U6YNuM40vH9arFEUjQF5FgZlVrwEIx6jWW
 13jxKGVWcWSCeb2SQqRl5jj2t9yrcMP1ozLMTTi2T7OGoNAgzamwxRZomMcuPFLoHlgn
 hUo+7r8bBs89Wwm7BjhA1ntvsEOhhmUupQDaLjiAmCYKvceH4Jt0Z7i/D8coU4UUHkpT
 7P6FJlzW/Hv1vw9U5hMvZIL2jQAZ3BiVvGTWIOb7CAqwyidR+WXKZauGnqB/IC6z85e4
 pLzQ==
X-Gm-Message-State: AOJu0YxwvyGa3uJxbP1jqLYg3YFNl5V6OUGO0d7EsMsHuodYGB/3+zB6
 QJfqdh2qfuCshgdB+mjW3UVC3O7ZPF6RavUWiR9/LCUdn1P9rIrY4Bk+ANi5YJn7Es1MiJTwdLV
 H40Ce+9e/ATs0w1oaEWbP5+y5vgjQYz4+/ky+Y36VA0BmMNhb/GyQs3Z5nd817D/h9EG6
X-Gm-Gg: AfdE7cmdPWYInQsMNbBLEGZrKhjmMVKscKcG0d45061EzIJmLRCQ7en3iw/CWQaIFjF
 NNeelwAgmRZSTca48Zn7xxOXmOZmXVzKBbg3uEgJlA1TQJ5WDSlX6ZPeg4DxuEOiUqZmQsgg0g5
 SOHsX845yyFEFCJwGKGJGKN9Pq9V8RTALX79Dcx1MOm6OMptuUnBPsW+TcQEWlV/3L50YE1vkCe
 SCFOV5H0Tjr5PU00atpb1yJREoEtYcttZgGTtD9Wfbju0P2vcOzFB1Nl+VzrmF3ATmdyX0qqFn5
 O1H3m4B7erVV2O/SAtSjFJZ2zV6K2zkyoVUUN6UuyyibOODoWnoq8dG02djRfTkiG1HVXto+Dnx
 AZMfrtp2vsQWSIxoLplJMXO81Cm8tYSn/FG3AIJwypkPudfCBV6k2VC/E5tH4yfKNGZpbNBSziY
 Kg8PkGzKzDx7RUoZglcybVdcBH3qFVAm6bVFomDfGAhUV4yZZAxGD+fYxeu2u1yzYgBzRpbI2fp
 GIEGzooIouI9366LiJmofJ3pvTCNxOxnX5fARLPutwOiHvM0wD8C2TAy2VB8pZdX+m6vobtNxF9
 Ffc=
X-Received: by 2002:a05:600d:8496:10b0:492:6f5c:fd8c with SMTP id
 5b1f17b1804b1-493f88c6d2emr117393555e9.15.1784102222869; 
 Wed, 15 Jul 2026 00:57:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4953c6ff429sm25206105e9.1.2026.07.15.00.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 00:57:02 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 07:56:56 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
X-Gerrit-Change-Number: 1783
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1783?usp=email>
X-Gerrit-Commit: eb960603f5aeb60dfd37b47e67d33b709acabb56
In-Reply-To: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
References: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLklhMWU3ZGI5NTYxNWQ5OWVmOTY4N2RlN2M0ZTk5NmRjODAzM2UyNjMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <04556e562728bd0f9203d56fa3135bb98c84da71-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjuUV-0006bG-0y
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2757326017815245820=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2757326017815245820==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1le+bnuL+/A="; charset=UTF-8

--1le+bnuL+/A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos=2E

He=
llo flichtenheld, plaisthos, 

I'd like you to reexamine a change=2E Please=
 visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail

to =
look at the new patch set (#2)=2E

The following approvals got outdated and=
 were removed:
Code-Review-1 by flichtenheld


Change subject: multi: assig=
n clients from a named, tagged subnet-pool
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: assign clients from a named, tagged =
subnet-pool

Add two server directives:

  subnet-pool <tag> <network> <net=
mask> [<gateway>]   (main config)
  subnet-pool-tag <tag>                  =
             (per-client CCD)

so groups of clients can be given addresses =
from subnets other than the
--server network (per-group firewall rules unde=
r --topology subnet, and
thus DCO)=2E A client's subnet-pool-tag is resolve=
d to its pool and served
a virtual IP from that subnet: a static --ifconfig=
-push within it, or the
next free address from a dynamic per-group pool sha=
red by tag and created
on first use=2E Such a client is validated against i=
ts own subnet instead
of the global tunnel-network constraint and never fal=
ls back to the
global pool; a tag matching no configured pool is declined w=
ith
AUTH_FAILED=2E

Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
Gi=
tHub: closes openvpn/OpenVPN#987
Signed-off-by: Antonio Quartulli <antonio@=
mandelbit=2Ecom>
---
M doc/man-sections/server-options=2Erst
M src/openvpn/=
multi=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/options=2Ec
M src/openvpn/o=
ptions=2Eh
5 files changed, 214 insertions(+), 5 deletions(-)


  git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/83/1783/2

diff --g=
it a/doc/man-sections/server-options=2Erst b/doc/man-sections/server-option=
s=2Erst
index f420588=2E=2E8800b98 100644
--- a/doc/man-sections/server-opt=
ions=2Erst
+++ b/doc/man-sections/server-options=2Erst
@@ -330,6 +330,31 @@=

   by ``--ifconfig``, OpenVPN will install a /32 host route for the ``loca=
l``
   IP address=2E
 
+--subnet-pool args
+  Define a named pool of addres=
ses from a subnet different from the
+  ``--server`` network, so groups of =
clients can be given IPs from separate
+  subnets for per-group firewall ru=
les under ``--topology subnet`` (and
+  therefore DCO)=2E This is a main-co=
nfig directive and may be repeated to
+  define several pools=2E
+
+  Valid=
 syntax:
+  ::
+
+     subnet-pool tag network netmask [gateway]
+
+  ``tag=
`` is a name a client refers to with ``--subnet-pool-tag``; ``gateway``
+  =
defaults to the first address of ``network``/``netmask``=2E A client assign=
ed
+  to a pool receives (dynamically, or via a static ``--ifconfig-push`` =
that
+  must lie within the subnet) an address from it, plus the matching n=
etmask, a
+  ``--route-gateway`` inside the subnet, and a host route back t=
o the server's
+  VPN IP, so it is reachable without manual per-client rout=
e pushes=2E
+
+--subnet-pool-tag tag
+  Assign this client to the ``--subne=
t-pool`` named ``tag``=2E Must be
+  associated with a specific client inst=
ance via ``--client-config-dir`` or
+  ``--client-connect``=2E Several clie=
nts may reference the same tag and are
+  then served from the same shared =
pool=2E
+
 --ifconfig-ipv6-push args
   for ``--client-config-dir`` per-cli=
ent static IPv6 interface
   configuration, see ``--client-config-dir`` and=
 ``--ifconfig-push`` for
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/m=
ulti=2Ec
index c4293a7=2E=2E84f25b3 100644
--- a/src/openvpn/multi=2Ec
+++ =
b/src/openvpn/multi=2Ec
@@ -53,6 +53,17 @@
 #include "dco=2Eh"
 #include "r=
eflect_filter=2Eh"
 
+/*
+ * Dynamic address pool serving the clients of on=
e --subnet-pool tag=2E  Shared
+ * by every client that references the tag,=
 created on first use=2E
+ */
+struct subnet_pool
+{
+    struct subnet_poo=
l *next;
+    const char *tag;
+    struct ifconfig_pool *pool;
+};
+
 /*#d=
efine MULTI_DEBUG_EVENT_LOOP*/
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
@@ -612,7 +=
623,8 @@
 
         schedule_remove_entry(m->schedule, (struct schedule_ent=
ry *)mi);
 
-        ifconfig_pool_release(m->ifconfig_pool, mi->vaddr_hand=
le, false);
+        ifconfig_pool_release(mi->vaddr_pool ? mi->vaddr_pool =
: m->ifconfig_pool, mi->vaddr_handle,
+                              false)=
;
 
         if (mi->did_iroutes)
         {
@@ -687,6 +699,14 @@
         =
schedule_free(m->schedule);
         mbuf_free(m->mbuf);
         ifconfig_=
pool_free(m->ifconfig_pool);
+        while (m->subnet_pools)
+        {
+ =
           struct subnet_pool *sp =3D m->subnet_pools;
+
+            m->su=
bnet_pools =3D sp->next;
+            ifconfig_pool_free(sp->pool);
+      =
      free(sp);
+        }
         frequency_limit_free(m->new_connection_=
limiter);
         initial_rate_limit_free(m->initial_rate_limiter);
      =
   multi_reap_free(m->reaper);
@@ -1384,6 +1404,12 @@
     const struct opt=
ions *o =3D &c->options;
     if (o->push_ifconfig_constraint_defined && c-=
>c2=2Epush_ifconfig_defined)
     {
+        /* a subnet-pool client is val=
idated against its own subnet */
+        if (o->subnet_pool_defined)
+    =
    {
+            return (o->subnet_pool_netmask & c->c2=2Epush_ifconfig_l=
ocal)
+                   =3D=3D o->subnet_pool_network;
+        }
       =
  return (o->push_ifconfig_constraint_netmask & c->c2=2Epush_ifconfig_local=
)
                =3D=3D o->push_ifconfig_constraint_network;
     }
@@ -13=
93,6 +1419,47 @@
     }
 }
 
+static const struct subnet_pool_def *
+subnet=
_pool_by_tag(const struct options *o, const char *tag)
+{
+    for (const s=
truct subnet_pool_def *d =3D o->subnet_pools; d; d =3D d->next)
+    {
+   =
     if (!strcmp(d->tag, tag))
+        {
+            return d;
+        }=

+    }
+    return NULL;
+}
+
+/*
+ * Return the dynamic pool serving the =
clients tagged with <tag>, creating it
+ * on first use from the matching -=
-subnet-pool definition=2E
+ */
+static struct ifconfig_pool *
+multi_get_g=
roup_pool(struct multi_context *m, const char *tag)
+{
+    struct subnet_p=
ool *sp;
+
+    for (sp =3D m->subnet_pools; sp; sp =3D sp->next)
+    {
+ =
       if (!strcmp(sp->tag, tag))
+        {
+            return sp->pool;
=
+        }
+    }
+
+    const struct subnet_pool_def *d4 =3D subnet_pool_b=
y_tag(&m->top=2Eoptions, tag);
+    ALLOC_OBJ_CLEAR(sp, struct subnet_pool)=
;
+    sp->tag =3D d4->tag;
+    sp->pool =3D ifconfig_pool_init(true, IFCO=
NFIG_POOL_INDIV, d4->network + 2,
+                                  (d4->n=
etwork | ~d4->netmask) - 1, m->top=2Eoptions=2Eduplicate_cn,
+             =
                     false, in6addr_any, 0);
+    sp->next =3D m->subnet_po=
ols;
+    m->subnet_pools =3D sp;
+    return sp->pool;
+}
+
 /*
  * Select=
 a virtual address for a new client instance=2E
  * Use an --ifconfig-push =
directive, if given (static IP)=2E
@@ -1403,6 +1470,21 @@
 {
     struct gc=
_arena gc =3D gc_new();
 
+    /* resolve a CCD --subnet-pool-tag against t=
he main-config --subnet-pool list
+     * (an unknown tag is rejected with =
AUTH_FAILED in multi_client_connect) */
+    if (mi->context=2Eoptions=2Esu=
bnet_pool_tag && !mi->context=2Eoptions=2Esubnet_pool_defined)
+    {
+    =
    const struct subnet_pool_def *d =3D
+            subnet_pool_by_tag(&m-=
>top=2Eoptions, mi->context=2Eoptions=2Esubnet_pool_tag);
+        if (d)
+=
        {
+            mi->context=2Eoptions=2Esubnet_pool_defined =3D true=
;
+            mi->context=2Eoptions=2Esubnet_pool_network =3D d->network;
=
+            mi->context=2Eoptions=2Esubnet_pool_netmask =3D d->netmask;
+ =
           mi->context=2Eoptions=2Esubnet_pool_gateway =3D d->gateway;
+   =
     }
+    }
+
     /*
      * If ifconfig addresses were set by dynamic c=
onfig file,
      * release pool addresses, otherwise keep them=2E
@@ -1413=
,8 +1495,10 @@
          * release dynamic allocation */
         if (mi->v=
addr_handle >=3D 0)
         {
-            ifconfig_pool_release(m->ifconf=
ig_pool, mi->vaddr_handle, true);
+            ifconfig_pool_release(mi->va=
ddr_pool ? mi->vaddr_pool : m->ifconfig_pool,
+                            =
      mi->vaddr_handle, true);
             mi->vaddr_handle =3D -1;
+     =
       mi->vaddr_pool =3D NULL;
         }
 
         mi->context=2Ec2=2Epu=
sh_ifconfig_defined =3D true;
@@ -1434,6 +1518,44 @@
                 "MULT=
I_sva: WARNING: if --ifconfig-push is used for IPv4, automatic IPv6 assignm=
ent from --ifconfig-ipv6-pool does not work=2E  Use --ifconfig-ipv6-push fo=
r IPv6 then=2E");
         }
     }
+    else if (mi->context=2Eoptions=2Es=
ubnet_pool_defined)
+    {
+        /* dynamic address from this client's -=
-subnet-pool group */
+
+        /* the CCD is read after a global-pool add=
ress may already have been
+         * acquired; drop it so we can serve th=
is client from its group */
+        if (mi->vaddr_handle >=3D 0 && !mi->va=
ddr_pool)
+        {
+            ifconfig_pool_release(m->ifconfig_pool, m=
i->vaddr_handle, true);
+            mi->vaddr_handle =3D -1;
+        }
+
=
+        if (mi->vaddr_handle < 0)
+        {
+            in_addr_t local =
=3D 0, remote =3D 0;
+            const char *cn =3D NULL;
+
+            i=
f (!mi->context=2Eoptions=2Eduplicate_cn)
+            {
+                c=
n =3D tls_common_name(mi->context=2Ec2=2Etls_multi, true);
+            }
+=

+            mi->vaddr_pool =3D multi_get_group_pool(m, mi->context=2Eopti=
ons=2Esubnet_pool_tag);
+            mi->vaddr_handle =3D ifconfig_pool_acq=
uire(mi->vaddr_pool, &local, &remote, NULL, cn);
+            if (mi->vaddr=
_handle >=3D 0)
+            {
+                mi->context=2Ec2=2Epush_ifc=
onfig_local =3D remote;
+                mi->context=2Ec2=2Epush_ifconfig_r=
emote_netmask =3D
+                    mi->context=2Eoptions=2Esubnet_pool_=
netmask;
+                mi->context=2Ec2=2Epush_ifconfig_defined =3D true=
;
+            }
+            else
+            {
+                msg(D_MU=
LTI_ERRORS, "MULTI: no free --subnet-pool addresses are available for %s",
=
+                    multi_instance_string(mi, false, &gc));
+            }=

+        }
+    }
     else if (m->ifconfig_pool && mi->vaddr_handle < 0) =
/* otherwise, choose a pool address */
     {
         in_addr_t local =3D =
0, remote =3D 0;
@@ -2339,10 +2461,9 @@
         const char *ifconfig_const=
raint_netmask =3D
             print_in_addr_t(mi->context=2Eoptions=2Epush=
_ifconfig_constraint_netmask, 0, &gc);
 
-        /* JYFIXME -- this should=
 cause the connection to fail */
         msg(D_MULTI_ERRORS,
-            =
"MULTI ERROR: primary virtual IP for %s (%s) "
-            "violates tunne=
l network/netmask constraint (%s/%s)",
+            "WARNING: primary virtu=
al IP for %s (%s) "
+            "violates tunnel network/netmask constrain=
t (%s/%s) and may not work",
             multi_instance_string(mi, false, =
&gc),
             print_in_addr_t(mi->context=2Ec2=2Epush_ifconfig_local, =
0, &gc),
             ifconfig_constraint_network, ifconfig_constraint_netm=
ask);
@@ -2450,6 +2571,7 @@
 
     /* reset pool handle to null */
     mi-=
>vaddr_handle =3D -1;
+    mi->vaddr_pool =3D NULL;
 
     /* do --client-c=
onnect setenvs */
     multi_select_virtual_addr(m, mi);
@@ -2741,6 +2863,1=
5 @@
         cc_succeeded =3D false;
     }
 
+    if (mi->context=2Eoptio=
ns=2Esubnet_pool_tag
+        && !subnet_pool_by_tag(&m->top=2Eoptions, mi-=
>context=2Eoptions=2Esubnet_pool_tag))
+    {
+        msg(D_MULTI_ERRORS, =
"MULTI: client has been rejected due to unknown --subnet-pool-tag '%s'",
+ =
           mi->context=2Eoptions=2Esubnet_pool_tag);
+        auth_set_clie=
nt_reason(mi->context=2Ec2=2Etls_multi, "unknown subnet-pool-tag");
+      =
  cc_succeeded =3D false;
+    }
+
     if (cc_succeeded)
     {
         m=
ulti_client_connect_late_setup(m, mi, *option_types_found);
diff --git a/sr=
c/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 8b837fa=2E=2Ef6815f4 1006=
44
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -121,6 +121,8=
 @@
     struct mroute_addr real; /**< External network address of the
    =
                           *   remote peer=2E */
     ifconfig_pool_handle =
vaddr_handle;
+    /* pool vaddr_handle belongs to (NULL =3D the global one=
) */
+    struct ifconfig_pool *vaddr_pool;
     char msg_prefix[MULTI_PREF=
IX_MAX_LENGTH];
 
     /* queued outgoing data in Server/TCP mode */
@@ -17=
6,6 +178,8 @@
                                         *   instances=2E */
=
     struct multi_io *multi_io;         /**< I/O state and events tracker *=
/
     struct ifconfig_pool *ifconfig_pool;
+    /* per-group --subnet-pool=
 dynamic pools */
+    struct subnet_pool *subnet_pools;
     struct freque=
ncy_limit *new_connection_limiter;
     struct initial_packet_rate_limit *i=
nitial_rate_limiter;
     struct mroute_helper *route_helper;
diff --git a/=
src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 87218d4=2E=2E3f9f7d=
e 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -44=
3,6 +443,11 @@
     "                  If seconds=3D0, file will be treated=
 as read-only=2E\n"
     "--ifconfig-ipv6-pool base-IP/bits : set aside an =
IPv6 network block\n"
     "                  to be dynamically allocated t=
o connecting clients=2E\n"
+    "--subnet-pool tag network netmask [gateway=
] : Define a named pool of\n"
+    "                  addresses outside the=
 --server network, selected per\n"
+    "                  client with --su=
bnet-pool-tag=2E\n"
+    "--subnet-pool-tag tag : Assign this client to the=
 --subnet-pool named tag=2E\n"
+    "                  Only valid in a clie=
nt-specific config file=2E\n"
     "--ifconfig-push local remote-netmask : =
Push an ifconfig option to remote,\n"
     "                  overrides --i=
fconfig-pool dynamic allocation=2E\n"
     "                  Only valid in=
 a client-specific config file=2E\n"
@@ -7631,6 +7636,33 @@
             go=
to err;
         }
     }
+    else if (streq(p[0], "subnet-pool") && p[1] =
&& p[2] && p[3] && !p[5])
+    {
+        struct subnet_pool_def *sp;
+    =
    in_addr_t network, netmask;
+
+        VERIFY_PERMISSION(OPT_P_GENERAL)=
;
+        network =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[2], =
0, NULL, NULL);
+        netmask =3D getaddr(GETADDR_HOST_ORDER, p[3], 0, N=
ULL, NULL);
+        if (!network || !netmask)
+        {
+            msg(=
msglevel, "cannot parse --subnet-pool addresses");
+            goto err;
+=
        }
+        ALLOC_OBJ_GC(sp, struct subnet_pool_def, &options->gc);
=
+        sp->tag =3D p[1];
+        sp->network =3D network & netmask;
+   =
     sp->netmask =3D netmask;
+        sp->gateway =3D p[4] ? getaddr(GETAD=
DR_HOST_ORDER | GETADDR_RESOLVE, p[4], 0, NULL, NULL)
+                    =
       : (network & netmask) + 1;
+        sp->next =3D options->subnet_poo=
ls;
+        options->subnet_pools =3D sp;
+    }
+    else if (streq(p[0],=
 "subnet-pool-tag") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT=
_P_INSTANCE);
+        options->subnet_pool_tag =3D p[1];
+    }
     else =
if (streq(p[0], "ifconfig-push-constraint") && p[1] && p[2] && !p[3])
     =
{
         in_addr_t network, netmask;
diff --git a/src/openvpn/options=2Eh=
 b/src/openvpn/options=2Eh
index a111cf8=2E=2E0c810b3 100644
--- a/src/open=
vpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -250,6 +250,17 @@
     str=
uct verify_hash_list *next;
 };
 
+/* A named --subnet-pool: a subnet clien=
ts can be assigned from, referenced
+ * from a CCD file by its tag via --su=
bnet-pool-tag=2E */
+struct subnet_pool_def
+{
+    struct subnet_pool_def =
*next;
+    const char *tag;
+    in_addr_t network;
+    in_addr_t netmask=
;
+    in_addr_t gateway;
+};
+
 /* Command line options */
 struct options=

 {
@@ -515,6 +526,12 @@
     bool push_ifconfig_constraint_defined;
     i=
n_addr_t push_ifconfig_constraint_network;
     in_addr_t push_ifconfig_con=
straint_netmask;
+    struct subnet_pool_def *subnet_pools; /* named pools =
(server config) */
+    const char *subnet_pool_tag;          /* which pool=
 this client uses (CCD) */
+    bool subnet_pool_defined;             /* re=
solved from the tag at connect */
+    in_addr_t subnet_pool_network;
+    =
in_addr_t subnet_pool_netmask;
+    in_addr_t subnet_pool_gateway;
     boo=
l push_ifconfig_ipv4_blocked;           /* IPv4 */
     bool push_ifconfig_=
ipv6_defined;           /* IPv6 */
     struct in6_addr push_ifconfig_ipv6_=
local;  /* IPv6 */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1783?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
Gerrit-Change-Number: 1783
Gerr=
it-PatchSet: 2
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewe=
r: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: ord=
ex <antonio@mandelbit=2Ecom>

--1le+bnuL+/A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ordex, plaisthos=2E </p>
<p>ordex <stro=
ng>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail">View Change</a></p><p=
>The following approvals got outdated and were removed:
Code-Review-1 by fl=
ichtenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">multi: assign clients from a named, tagged subn=
et-pool<br><br>Add two server directives:<br><br>  subnet-pool &lt;tag&gt; =
&lt;network&gt; &lt;netmask&gt; [&lt;gateway&gt;]   (main config)<br>  subn=
et-pool-tag &lt;tag&gt;                               (per-client CCD)<br><=
br>so groups of clients can be given addresses from subnets other than the<=
br>--server network (per-group firewall rules under --topology subnet, and<=
br>thus DCO)=2E A client&#39;s subnet-pool-tag is resolved to its pool and =
served<br>a virtual IP from that subnet: a static --ifconfig-push within it=
, or the<br>next free address from a dynamic per-group pool shared by tag a=
nd created<br>on first use=2E Such a client is validated against its own su=
bnet instead<br>of the global tunnel-network constraint and never falls bac=
k to the<br>global pool; a tag matching no configured pool is declined with=
<br>AUTH_FAILED=2E<br><br>Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2=
631<br>GitHub: closes openvpn/OpenVPN#987<br>Signed-off-by: Antonio Quartul=
li &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M doc/man-sections/server-opti=
ons=2Erst<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M src/op=
envpn/options=2Ec<br>M src/openvpn/options=2Eh<br>5 files changed, 214 inse=
rtions(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/83/1783/2</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
doc/man-sections/server-options=2Erst b/doc/man-sections/server-options=2Er=
st</span><br><span>index f420588=2E=2E8800b98 100644</span><br><span>--- a/=
doc/man-sections/server-options=2Erst</span><br><span>+++ b/doc/man-section=
s/server-options=2Erst</span><br><span>@@ -330,6 +330,31 @@</span><br><span=
>   by ``--ifconfig``, OpenVPN will install a /32 host route for the ``loca=
l``</span><br><span>   IP address=2E</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+--subnet-pool args</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  Define a named pool of addresses from a=
 subnet different from the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  ``--server`` network, so groups of clients can be given IPs from s=
eparate</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  subnets fo=
r per-group firewall rules under ``--topology subnet`` (and</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  therefore DCO)=2E This is a main-=
config directive and may be repeated to</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  define several pools=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  Valid syntax:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  ::</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     subnet-pool tag network ne=
tmask [gateway]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``tag`` is a name a c=
lient refers to with ``--subnet-pool-tag``; ``gateway``</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  defaults to the first address of ``ne=
twork``/``netmask``=2E A client assigned</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  to a pool receives (dynamically, or via a static ``-=
-ifconfig-push`` that</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  must lie within the subnet) an address from it, plus the matching netma=
sk, a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--route-ga=
teway`` inside the subnet, and a host route back to the server&#39;s</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  VPN IP, so it is reachab=
le without manual per-client route pushes=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+--subnet-pool-tag tag</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  Assign this client to the ``--subnet-pool`` named ``tag``=2E Must=
 be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  associated wit=
h a specific client instance via ``--client-config-dir`` or</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  ``--client-connect``=2E Several c=
lients may reference the same tag and are</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  then served from the same shared pool=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --ifconfig-i=
pv6-push args</span><br><span>   for ``--client-config-dir`` per-client sta=
tic IPv6 interface</span><br><span>   configuration, see ``--client-config-=
dir`` and ``--ifconfig-push`` for</span><br><span>diff --git a/src/openvpn/=
multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index c4293a7=2E=2E84f25b=
3 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/=
src/openvpn/multi=2Ec</span><br><span>@@ -53,6 +53,17 @@</span><br><span> #=
include &quot;dco=2Eh&quot;</span><br><span> #include &quot;reflect_filter=
=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Dynam=
ic address pool serving the clients of one --subnet-pool tag=2E  Shared</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * by every client that=
 references the tag, created on first use=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+struct subnet_pool</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 subnet_pool *next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const char *tag;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct ifconfig_pool *pool;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> /*#define MULTI_DEBUG_EVENT_LOOP*/</span><br><span> </span><b=
r><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span>@@ -612,7 +623,8 @@<=
/span><br><span> </span><br><span>         schedule_remove_entry(m-&gt;sche=
dule, (struct schedule_entry *)mi);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ifconfig_pool_release(m-&gt;ifconfi=
g_pool, mi-&gt;vaddr_handle, false);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        ifconfig_pool_release(mi-&gt;vaddr_pool ? mi-&gt;v=
addr_pool : m-&gt;ifconfig_pool, mi-&gt;vaddr_handle,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                              false);</sp=
an><br><span> </span><br><span>         if (mi-&gt;did_iroutes)</span><br><=
span>         {</span><br><span>@@ -687,6 +699,14 @@</span><br><span>      =
   schedule_free(m-&gt;schedule);</span><br><span>         mbuf_free(m-&gt;=
mbuf);</span><br><span>         ifconfig_pool_free(m-&gt;ifconfig_pool);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        while (m-&gt;s=
ubnet_pools)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            struc=
t subnet_pool *sp =3D m-&gt;subnet_pools;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            m-&gt;subnet_pools =3D sp-&gt;next;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            ifconfig_pool_free(sp-&gt;pool);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            free(sp=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span>         frequency_limit_free(m-&gt;new_connection_limiter);</span=
><br><span>         initial_rate_limit_free(m-&gt;initial_rate_limiter);</s=
pan><br><span>         multi_reap_free(m-&gt;reaper);</span><br><span>@@ -1=
384,6 +1404,12 @@</span><br><span>     const struct options *o =3D &amp;c-&=
gt;options;</span><br><span>     if (o-&gt;push_ifconfig_constraint_defined=
 &amp;&amp; c-&gt;c2=2Epush_ifconfig_defined)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /* a subnet-pool c=
lient is validated against its own subnet */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (o-&gt;subnet_pool_defined)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return (o-&gt;subnet_pool_net=
mask &amp; c-&gt;c2=2Epush_ifconfig_local)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                   =3D=3D o-&gt;subnet_pool_network;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span>         return (o-&gt;push_ifconfig_constraint_netmask &amp; c-&gt;=
c2=2Epush_ifconfig_local)</span><br><span>                =3D=3D o-&gt;push=
_ifconfig_constraint_network;</span><br><span>     }</span><br><span>@@ -13=
93,6 +1419,47 @@</span><br><span>     }</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const struc=
t subnet_pool_def *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
subnet_pool_by_tag(const struct options *o, const char *tag)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    for (const struct subnet_pool_def *d =3D o-&gt;s=
ubnet_pools; d; d =3D d-&gt;next)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (!strcmp(d-&gt;tag, tag))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            return d;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Return the dynamic pool serving the clients tagged with &lt;tag&gt;, =
creating it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * on fi=
rst use from the matching --subnet-pool definition=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static struct ifconfig_pool *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+multi_get_group_pool(struct multi_context *m, c=
onst char *tag)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool=
 *sp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    for (sp =3D m-&gt;subnet_pool=
s; sp; sp =3D sp-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (!strcmp(sp-&gt;tag, tag))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            return sp-&gt;pool;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const struct subnet_pool_d=
ef *d4 =3D subnet_pool_by_tag(&amp;m-&gt;top=2Eoptions, tag);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(sp, struct su=
bnet_pool);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sp-&=
gt;tag =3D d4-&gt;tag;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    sp-&gt;pool =3D ifconfig_pool_init(true, IFCONFIG_POOL_INDIV, d4-&gt=
;network + 2,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                            (d4-&gt;network | ~d4-&gt;netmask) - 1, m-&gt;t=
op=2Eoptions=2Eduplicate_cn,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                  false, in6addr_any, 0);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;next =3D m-&gt;su=
bnet_pools;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&g=
t;subnet_pools =3D sp;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return sp-&gt;pool;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> /*</span><br><span>  * Select a virtual address for a new client ins=
tance=2E</span><br><span>  * Use an --ifconfig-push directive, if given (st=
atic IP)=2E</span><br><span>@@ -1403,6 +1470,21 @@</span><br><span> {</span=
><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* resolve a CCD --subne=
t-pool-tag against the main-config --subnet-pool list</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * (an unknown tag is rejected with A=
UTH_FAILED in multi_client_connect) */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (mi-&gt;context=2Eoptions=2Esubnet_pool_tag &amp;=
&amp; !mi-&gt;context=2Eoptions=2Esubnet_pool_defined)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        const struct subnet_pool_def *d =3D</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            subnet_pool_by_tag=
(&amp;m-&gt;top=2Eoptions, mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (d)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=2Eoptions=
=2Esubnet_pool_defined =3D true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            mi-&gt;context=2Eoptions=2Esubnet_pool_network =3D=
 d-&gt;network;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        mi-&gt;context=2Eoptions=2Esubnet_pool_netmask =3D d-&gt;netmask;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;co=
ntext=2Eoptions=2Esubnet_pool_gateway =3D d-&gt;gateway;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>     /*</span><br><span>      * If ifconfig a=
ddresses were set by dynamic config file,</span><br><span>      * release p=
ool addresses, otherwise keep them=2E</span><br><span>@@ -1413,8 +1495,10 @=
@</span><br><span>          * release dynamic allocation */</span><br><span=
>         if (mi-&gt;vaddr_handle &gt;=3D 0)</span><br><span>         {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            ifconfig_pool=
_release(m-&gt;ifconfig_pool, mi-&gt;vaddr_handle, true);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            ifconfig_pool_release(mi-=
&gt;vaddr_pool ? mi-&gt;vaddr_pool : m-&gt;ifconfig_pool,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                  mi-=
&gt;vaddr_handle, true);</span><br><span>             mi-&gt;vaddr_handle =
=3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
mi-&gt;vaddr_pool =3D NULL;</span><br><span>         }</span><br><span> </s=
pan><br><span>         mi-&gt;context=2Ec2=2Epush_ifconfig_defined =3D true=
;</span><br><span>@@ -1434,6 +1518,44 @@</span><br><span>                 &=
quot;MULTI_sva: WARNING: if --ifconfig-push is used for IPv4, automatic IPv=
6 assignment from --ifconfig-ipv6-pool does not work=2E  Use --ifconfig-ipv=
6-push for IPv6 then=2E&quot;);</span><br><span>         }</span><br><span>=
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (=
mi-&gt;context=2Eoptions=2Esubnet_pool_defined)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        /* dynamic address from this client&#39;s --subnet-po=
ol group */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        /* the CCD is read =
after a global-pool address may already have been</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+         * acquired; drop it so we can serve =
this client from its group */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (mi-&gt;vaddr_handle &gt;=3D 0 &amp;&amp; !mi-&gt;vadd=
r_pool)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            ifconfig_p=
ool_release(m-&gt;ifconfig_pool, mi-&gt;vaddr_handle, true);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;vaddr_handle =
=3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (mi-&gt;vaddr_handle &lt; 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            in_addr_t local =3D=
 0, remote =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          const char *cn =3D NULL;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (!mi-&gt;context=2Eoptions=2Eduplicate_cn)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                cn =3D tls_common_name(mi-&gt;c=
ontext=2Ec2=2Etls_multi, true);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
i-&gt;vaddr_pool =3D multi_get_group_pool(m, mi-&gt;context=2Eoptions=2Esub=
net_pool_tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       mi-&gt;vaddr_handle =3D ifconfig_pool_acquire(mi-&gt;vaddr_pool, &am=
p;local, &amp;remote, NULL, cn);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            if (mi-&gt;vaddr_handle &gt;=3D 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                mi-&gt;context=2Ec2=2Epus=
h_ifconfig_local =3D remote;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                mi-&gt;context=2Ec2=2Epush_ifconfig_remote_netmask=
 =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     mi-&gt;context=2Eoptions=2Esubnet_pool_netmask;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                mi-&gt;context=2Ec2=2Epus=
h_ifconfig_defined =3D true;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          msg(D_MULTI_ERRORS, &quot;MULTI: no free --subnet-pool addresses =
are available for %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    multi_instance_string(mi, false, &amp;gc));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (m-&=
gt;ifconfig_pool &amp;&amp; mi-&gt;vaddr_handle &lt; 0) /* otherwise, choos=
e a pool address */</span><br><span>     {</span><br><span>         in_addr=
_t local =3D 0, remote =3D 0;</span><br><span>@@ -2339,10 +2461,9 @@</span>=
<br><span>         const char *ifconfig_constraint_netmask =3D</span><br><s=
pan>             print_in_addr_t(mi-&gt;context=2Eoptions=2Epush_ifconfig_c=
onstraint_netmask, 0, &amp;gc);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        /* JYFIXME -- this should cause the con=
nection to fail */</span><br><span>         msg(D_MULTI_ERRORS,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            &quot;MULTI ERROR: pr=
imary virtual IP for %s (%s) &quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            &quot;violates tunnel network/netmask constraint =
(%s/%s)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       &quot;WARNING: primary virtual IP for %s (%s) &quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            &quot;violates tunnel n=
etwork/netmask constraint (%s/%s) and may not work&quot;,</span><br><span> =
            multi_instance_string(mi, false, &amp;gc),</span><br><span>    =
         print_in_addr_t(mi-&gt;context=2Ec2=2Epush_ifconfig_local, 0, &amp=
;gc),</span><br><span>             ifconfig_constraint_network, ifconfig_co=
nstraint_netmask);</span><br><span>@@ -2450,6 +2571,7 @@</span><br><span> <=
/span><br><span>     /* reset pool handle to null */</span><br><span>     m=
i-&gt;vaddr_handle =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    mi-&gt;vaddr_pool =3D NULL;</span><br><span> </span><br><span>  =
   /* do --client-connect setenvs */</span><br><span>     multi_select_virt=
ual_addr(m, mi);</span><br><span>@@ -2741,6 +2863,15 @@</span><br><span>   =
      cc_succeeded =3D false;</span><br><span>     }</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;context=
=2Eoptions=2Esubnet_pool_tag</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        &amp;&amp; !subnet_pool_by_tag(&amp;m-&gt;top=2Eoptions, m=
i-&gt;context=2Eoptions=2Esubnet_pool_tag))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg(D_MULTI_ERRORS, &quot;MULTI: client has been rejected=
 due to unknown --subnet-pool-tag &#39;%s&#39;&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=2Eoptions=2Esu=
bnet_pool_tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    auth_set_client_reason(mi-&gt;context=2Ec2=2Etls_multi, &quot;unknown s=
ubnet-pool-tag&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cc_succeeded =3D false;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span>     if (cc_succeeded)</span><br><span>     {</span><br><=
span>         multi_client_connect_late_setup(m, mi, *option_types_found);<=
/span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh<=
/span><br><span>index 8b837fa=2E=2Ef6815f4 100644</span><br><span>--- a/src=
/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><br><s=
pan>@@ -121,6 +121,8 @@</span><br><span>     struct mroute_addr real; /**&l=
t; External network address of the</span><br><span>                        =
       *   remote peer=2E */</span><br><span>     ifconfig_pool_handle vadd=
r_handle;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* poo=
l vaddr_handle belongs to (NULL =3D the global one) */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool *vaddr_pool;</s=
pan><br><span>     char msg_prefix[MULTI_PREFIX_MAX_LENGTH];</span><br><spa=
n> </span><br><span>     /* queued outgoing data in Server/TCP mode */</spa=
n><br><span>@@ -176,6 +178,8 @@</span><br><span>                           =
              *   instances=2E */</span><br><span>     struct multi_io *mul=
ti_io;         /**&lt; I/O state and events tracker */</span><br><span>    =
 struct ifconfig_pool *ifconfig_pool;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* per-group --subnet-pool dynamic pools */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool *subne=
t_pools;</span><br><span>     struct frequency_limit *new_connection_limite=
r;</span><br><span>     struct initial_packet_rate_limit *initial_rate_limi=
ter;</span><br><span>     struct mroute_helper *route_helper;</span><br><sp=
an>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br=
><span>index 87218d4=2E=2E3f9f7de 100644</span><br><span>--- a/src/openvpn/=
options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@=
@ -443,6 +443,11 @@</span><br><span>     &quot;                  If seconds=
=3D0, file will be treated as read-only=2E\n&quot;</span><br><span>     &qu=
ot;--ifconfig-ipv6-pool base-IP/bits : set aside an IPv6 network block\n&qu=
ot;</span><br><span>     &quot;                  to be dynamically allocate=
d to connecting clients=2E\n&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &quot;--subnet-pool tag network netmask [gateway] : Defi=
ne a named pool of\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    &quot;                  addresses outside the --server network, =
selected per\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &quot;                  client with --subnet-pool-tag=2E\n&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--subnet-pool-t=
ag tag : Assign this client to the --subnet-pool named tag=2E\n&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;               =
   Only valid in a client-specific config file=2E\n&quot;</span><br><span> =
    &quot;--ifconfig-push local remote-netmask : Push an ifconfig option to=
 remote,\n&quot;</span><br><span>     &quot;                  overrides --i=
fconfig-pool dynamic allocation=2E\n&quot;</span><br><span>     &quot;     =
             Only valid in a client-specific config file=2E\n&quot;</span><=
br><span>@@ -7631,6 +7636,33 @@</span><br><span>             goto err;</spa=
n><br><span>         }</span><br><span>     }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;subnet-pool&quot;)=
 &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; p[3] &amp;&amp; !p[5])</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct subnet_pool_def *sp;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        in_addr_t network=
, netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OP=
T_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  network =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[2], 0, NULL, =
NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        netma=
sk =3D getaddr(GETADDR_HOST_ORDER, p[3], 0, NULL, NULL);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (!network || !netmask)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;ca=
nnot parse --subnet-pool addresses&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            goto err;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        ALLOC_OBJ_GC(sp, struct subnet_pool_def, &amp;option=
s-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
p-&gt;tag =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        sp-&gt;network =3D network &amp; netmask;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        sp-&gt;netmask =3D netmask;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;gateway =3D p[=
4] ? getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[4], 0, NULL, NULL)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
    : (network &amp; netmask) + 1;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        sp-&gt;next =3D options-&gt;subnet_pools;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;subnet_poo=
ls =3D sp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0]=
, &quot;subnet-pool-tag&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_INSTANCE);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;s=
ubnet_pool_tag =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span>     else if (streq(p[0], &quot;ifconfig-push-co=
nstraint&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br=
><span>     {</span><br><span>         in_addr_t network, netmask;</span><b=
r><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</spa=
n><br><span>index a111cf8=2E=2E0c810b3 100644</span><br><span>--- a/src/ope=
nvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><s=
pan>@@ -250,6 +250,17 @@</span><br><span>     struct verify_hash_list *next=
;</span><br><span> };</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* A named --subnet-pool: a subnet clients can be assig=
ned from, referenced</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * from a CCD file by its tag via --subnet-pool-tag=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+struct subnet_pool_def</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct subnet_pool_def *next;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const char *tag;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t network;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t netmask;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t gateway;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> /* Command line options */=
</span><br><span> struct options</span><br><span> {</span><br><span>@@ -515=
,6 +526,12 @@</span><br><span>     bool push_ifconfig_constraint_defined;</=
span><br><span>     in_addr_t push_ifconfig_constraint_network;</span><br><=
span>     in_addr_t push_ifconfig_constraint_netmask;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_def *subnet_pools;=
 /* named pools (server config) */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const char *subnet_pool_tag;          /* which pool this=
 client uses (CCD) */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    bool subnet_pool_defined;             /* resolved from the tag at con=
nect */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_addr_=
t subnet_pool_network;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    in_addr_t subnet_pool_netmask;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    in_addr_t subnet_pool_gateway;</span><br><span>     b=
ool push_ifconfig_ipv4_blocked;           /* IPv4 */</span><br><span>     b=
ool push_ifconfig_ipv6_defined;           /* IPv6 */</span><br><span>     s=
truct in6_addr push_ifconfig_ipv6_local;  /* IPv6 */</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1783?usp=3Demail">change 1783</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1783?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2=
631 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1783 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichte=
nheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>

</body></htm=
l>
--1le+bnuL+/A=--


--===============2757326017815245820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2757326017815245820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2757326017815245820==--

