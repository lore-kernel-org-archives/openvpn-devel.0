Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F9DC44501
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DDfEYfUU7JYY13QRx7POXqXLnKeOniHZgijM2B9qCzI=; b=E5jSJ/TuaKhG0FqG+dAppsz8sa
	nTaWWqkFs8JKkihqHqJtJYELaZddBCFas1tHUt/JaWK4n6mCAhs1U93v0BVDMceW28N5RLNmY5PJI
	sLKv8vmeUPxCqFD46TkFUkvQYeOtNe1kvVtLno6LSM2HVn+BJIx0WBl1c8TUkgBk923I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk1B5-0004Zf-0o;
	Wed, 15 Jul 2026 15:05:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk1B3-0004ZN-0U
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:05:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HgogoR+7CvoewKqFE3swPNAzuiWOnZbAn5liN5iWu2g=; b=GGDWK3SxQk0VJPu2LY+6TVzJ2z
 jCjJj1Lj8FMx2PLpGVGr3hDnzjru+ETUosTaudgtdoE3/ApS4FC7VJ5oMzkOexdGni/nlwyJjbvGP
 tv4HqT4g4ng2UUAAABloQNMWA3IkuyfKlcKCyZoOWuWoduR3tPkS58JRQO3OBq5syoXg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HgogoR+7CvoewKqFE3swPNAzuiWOnZbAn5liN5iWu2g=; b=f
 DIOUBgegVs/YL0ywQmWJ190I+5Da9/7EdMuG92KDdrEw6UDxIBlN7uGltyPGtZjy7p4cj2cuf0tSz
 Jk+Ta9LOYh+S/ralThQEGXn3Ns7piLZeLID+v7pZl2a54b+DmtDVAl0F1jYIp1Qj5QYep0ogGzdO/
 XDtlCDO0J0UVED2g=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk1Az-00071f-U1 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:05:37 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4720d22c94aso2424223f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 08:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784127922; x=1784732722; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HgogoR+7CvoewKqFE3swPNAzuiWOnZbAn5liN5iWu2g=;
 b=Hl06G2ncFQP7MLfg/s8UuyubJnqOAvXAdvZcbfMhsWqCqc3RN/AfBV8brYxncND6D8
 BXBjkwUtHbT/+OF6lsyND1DAadsHh04kIz3Z/WOmYuGvyLDSwhfeUBRysI+kPfdBQpgT
 PgrWml+Xxl9vdGxzXsvUKeF75y4K6jdWheT0kHjOFoPa3g7fMZHI0GntgwJOGVeIEeWe
 BScIlqtXchtdG/9+s9THgeLXOlc11LjC5/ID8sWJPNpIFZL2PqbFOcKG88tSf2HaSqrW
 HyWm4k8X85JBypYasV1D3+2NBJqMpY4T4rNJl4+VzVjq4jIfx45Pt3KBUUVAtaE5/evP
 if5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784127922; x=1784732722;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HgogoR+7CvoewKqFE3swPNAzuiWOnZbAn5liN5iWu2g=;
 b=HOliJyCrcqGMMq2pW6xkj49MIeeXuUL4opcJror0o3VlwvpXhtZvk9Y3lysaOe1Avl
 KAQPfJsK9ZcczfkQ0JSlcAbtqqBI0hPIcN3Hy4fJt8euPtCkWkS9wrSPFIR0JxrZnOBm
 ciVxxf4hZWBaavW3tW/pKoWK8f9JBw1Y1HhjmnN8uvNVX97pJQ2GBgW1GAGEMc6TWajN
 apSxu7WmWWIf7wbwfbtyMYdTc8zSyLwR6gdOBkmdAumQ5woauy7iow0e1pgMJfJhwLsG
 FoWAdIoD26sGNRtAv0XHjuj5UtS3tAv0egIzcqjGfDXTOMhzi9uBoWcv58nugStmk+1o
 Jjow==
X-Gm-Message-State: AOJu0YwbH9/hMPzNh2JleqkzlnzgLXV5k7EBsHN83FF4N/VAdpLaJJiP
 e1gcRBiz0ZwREXL9uYIYmn15kgBHhQM8K5KxgdlpAlvsWN0Zlog7av9Ru2plqDuPxiO/t1wVD6l
 x0IbUspXM9Sra/38Lq0uQP8J1LN/VYFRo/KPeeYSsuArpIHvhTB230cYjQHbMs6hDUqxVxAKGku
 pwDcg19A==
X-Gm-Gg: AfdE7ckNccIL5P+q85t8oUlXAh8Vpgt8UzdqWDhzItHS2AB8kqX7WzLsNWLvl901Qyn
 4uiOArm0IokQhCoc8sZgTafWrG+vgCjNWiO1wcIXAAt+94pK+VZAs7lyeFucAiDXC1y+aILtUby
 ELb0EyMw9qo1t+6xdCnBMsxpONk+OZ8f+GmCf0XcWr5glayY1nHcoFZo1uOtIuLVIrSxNiqEspC
 luwBzfwUqDt5SPiDMqrMio/NUWVoqzbo/xskVwzRyn8488Hew28kSEeGQIi8ePZZBXD/gihjDkw
 3uCxmbJBq0fawdtTV403+LoajCC/ELJCFsrw0HBNVSU6rvzIczk476VlUy7ZkQrU8ZgOFnUTkDV
 H8buSb7UttZXrRCTxMPoEYApbhdctIfmHiby/iAuWyCtVooL2dzEShOB/Tmnxvk7qPKer4zR3Ob
 XZSR8EjmkPgDXDqVnn3/P+i9sbr2ly9K1juKd6yylpnwBBgXly8PqnzjwqtahLEOEbvzAtnd0vG
 fKDwrJzj3VEAowbpv84BopdbJfIMSRj0noLiJPJSpXYOlQBtPg/zWl28G7qPXH43fELdvR9yZXp
 /RUJ2OsU6+gYWw==
X-Received: by 2002:a05:600c:1f8f:b0:493:e79e:da6b with SMTP id
 5b1f17b1804b1-493f8815d42mr232772635e9.21.1784121838346; 
 Wed, 15 Jul 2026 06:23:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4953c599049sm46346045e9.0.2026.07.15.06.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 06:23:57 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 13:23:53 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
X-Gerrit-Change-Number: 1783
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1783?usp=email>
X-Gerrit-Commit: e81f65f2b97d657d6747bef40e2911b19ea1a938
In-Reply-To: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
References: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLklhMWU3ZGI5NTYxNWQ5OWVmOTY4N2RlN2M0ZTk5NmRjODAzM2UyNjMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e31fbc79eb423cd231b9796dc25ea3968031cb0c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk1Az-00071f-U1
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multi: assign
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
Content-Type: multipart/mixed; boundary="===============8862601107015511569=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8862601107015511569==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UEAlywAh9Dc="; charset=UTF-8

--UEAlywAh9Dc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos=2E

He=
llo flichtenheld, plaisthos, 

I'd like you to reexamine a change=2E Please=
 visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail

to =
look at the new patch set (#3)=2E


Change subject: multi: assign clients f=
rom a named, tagged subnet-pool
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

multi: assign clients from a named, tagged subnet-pool
=

Add two server directives:

  subnet-pool <tag> <network> <netmask> [<gate=
way>]   (main config)
  subnet-pool-tag <tag>                              =
 (per-client CCD)

so groups of clients can be given addresses from subnets=
 other than the
--server network (per-group firewall rules under --topology=
 subnet, and
thus DCO)=2E A client's subnet-pool-tag is resolved to its poo=
l and served
a virtual IP from that subnet: a static --ifconfig-push within=
 it, or the
next free address from a dynamic per-group pool shared by tag a=
nd created
on first use=2E Such a client is validated against its own subne=
t instead
of the global tunnel-network constraint and never falls back to t=
he
global pool; a tag matching no configured pool is declined with
AUTH_FAI=
LED=2E

Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
GitHub: closes=
 openvpn/OpenVPN#987
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2E=
com>
---
M CMakeLists=2Etxt
M doc/man-sections/server-options=2Erst
M src/o=
penvpn/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/options=2Ec
M src/op=
envpn/options=2Eh
M src/openvpn/options_util=2Ec
M src/openvpn/options_util=
=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
A tests/unit_tests/openvpn/te=
st_subnet_pool=2Ec
10 files changed, 323 insertions(+), 5 deletions(-)


  =
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/83/1783/3
=

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 23541a5d=2E=2E3463b=
5a 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -671,6 +671,7 @@=

         "test_provider"
         "test_socket"
         "test_ssl"
+     =
   "test_subnet_pool"
         "test_user_pass"
         "test_push_update_=
msg"
         )
@@ -829,6 +830,11 @@
         src/openvpn/list=2Ec
        =
 )
 
+    target_sources(test_subnet_pool PRIVATE
+        tests/unit_tests=
/openvpn/mock_get_random=2Ec
+        src/openvpn/options_util=2Ec
+       =
 )
+
     target_sources(test_ncp PRIVATE
         src/openvpn/crypto_epoch=
=2Ec
         src/openvpn/crypto_mbedtls=2Ec
diff --git a/doc/man-sections/=
server-options=2Erst b/doc/man-sections/server-options=2Erst
index f420588=
=2E=2Eb6464af 100644
--- a/doc/man-sections/server-options=2Erst
+++ b/doc/=
man-sections/server-options=2Erst
@@ -330,6 +330,37 @@
   by ``--ifconfig``=
, OpenVPN will install a /32 host route for the ``local``
   IP address=2E
=
 
+--subnet-pool args
+  Define a named pool of addresses from a subnet dif=
ferent from the
+  ``--server`` network, so groups of clients can be given =
IPs from separate
+  subnets for per-group firewall rules under ``--topolog=
y subnet`` (and
+  therefore DCO)=2E This is a main-config directive and ma=
y be repeated to
+  define several pools=2E
+
+  Valid syntax:
+  ::
+
+   =
  subnet-pool tag network netmask [gateway]
+
+  ``tag`` is a name a client=
 refers to with ``--subnet-pool-tag``; ``gateway``
+  defaults to the first=
 address of ``network``/``netmask``=2E A client assigned
+  to a pool recei=
ves (dynamically, or via a static ``--ifconfig-push`` that
+  must lie with=
in the subnet) an address from it, plus the matching netmask
+  and a ``--r=
oute-gateway`` inside the subnet so that its pushed routes
+  install on-li=
nk=2E
+
+  A host route to the server's own VPN IP is not pushed, as it is =
not needed
+  to reach the networks behind the server=2E If your clients ne=
ed to reach the
+  server's VPN address itself, add an explicit
+  ``push "=
route <server-VPN-IP> 255=2E255=2E255=2E255"`` (or the ``route-ipv6``
+  eq=
uivalent) to the server config=2E
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
index c4293a7=2E=2Eda46cf4 100644
--- a/src/=
openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -42,6 +42,7 @@
 #include "=
vlan=2Eh"
 #include "auth_token=2Eh"
 #include "route=2Eh"
+#include "optio=
ns_util=2Eh"
 #include <inttypes=2Eh>
 #include <string=2Eh>
 
@@ -53,6 +54=
,17 @@
 #include "dco=2Eh"
 #include "reflect_filter=2Eh"
 
+/*
+ * Dynamic=
 address pool serving the clients of one --subnet-pool tag=2E  Shared
+ * b=
y every client that references the tag, created on first use=2E
+ */
+struc=
t subnet_pool
+{
+    struct subnet_pool *next;
+    const char *tag;
+    =
struct ifconfig_pool *pool;
+};
+
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
 #i=
fdef MULTI_DEBUG_EVENT_LOOP
@@ -612,7 +624,8 @@
 
         schedule_remove_=
entry(m->schedule, (struct schedule_entry *)mi);
 
-        ifconfig_pool_r=
elease(m->ifconfig_pool, mi->vaddr_handle, false);
+        ifconfig_pool_r=
elease(mi->vaddr_pool ? mi->vaddr_pool : m->ifconfig_pool, mi->vaddr_handle=
,
+                              false);
 
         if (mi->did_iroutes)
  =
       {
@@ -687,6 +700,14 @@
         schedule_free(m->schedule);
        =
 mbuf_free(m->mbuf);
         ifconfig_pool_free(m->ifconfig_pool);
+      =
  while (m->subnet_pools)
+        {
+            struct subnet_pool *sp =
=3D m->subnet_pools;
+
+            m->subnet_pools =3D sp->next;
+        =
    ifconfig_pool_free(sp->pool);
+            free(sp);
+        }
       =
  frequency_limit_free(m->new_connection_limiter);
         initial_rate_li=
mit_free(m->initial_rate_limiter);
         multi_reap_free(m->reaper);
@@ =
-1384,6 +1405,12 @@
     const struct options *o =3D &c->options;
     if (=
o->push_ifconfig_constraint_defined && c->c2=2Epush_ifconfig_defined)
     =
{
+        /* a subnet-pool client is validated against its own subnet */
+=
        if (o->subnet_pool_defined)
+        {
+            return (o->subn=
et_pool_netmask & c->c2=2Epush_ifconfig_local)
+                   =3D=3D o=
->subnet_pool_network;
+        }
         return (o->push_ifconfig_constra=
int_netmask & c->c2=2Epush_ifconfig_local)
                =3D=3D o->push_i=
fconfig_constraint_network;
     }
@@ -1394,6 +1421,34 @@
 }
 
 /*
+ * Retu=
rn the dynamic pool serving the clients tagged with <tag>, creating it
+ * =
on first use from the matching --subnet-pool definition=2E
+ */
+static str=
uct ifconfig_pool *
+multi_get_group_pool(struct multi_context *m, const ch=
ar *tag)
+{
+    struct subnet_pool *sp;
+
+    for (sp =3D m->subnet_pools=
; sp; sp =3D sp->next)
+    {
+        if (!strcmp(sp->tag, tag))
+        =
{
+            return sp->pool;
+        }
+    }
+
+    const struct subne=
t_pool_def *d4 =3D subnet_pool_by_tag(m->top=2Eoptions=2Esubnet_pools, tag)=
;
+    ALLOC_OBJ_CLEAR(sp, struct subnet_pool);
+    sp->tag =3D d4->tag;
+=
    sp->pool =3D ifconfig_pool_init(true, IFCONFIG_POOL_INDIV, d4->network =
+ 2,
+                                  (d4->network | ~d4->netmask) - 1, m=
->top=2Eoptions=2Eduplicate_cn,
+                                  false, i=
n6addr_any, 0);
+    sp->next =3D m->subnet_pools;
+    m->subnet_pools =3D=
 sp;
+    return sp->pool;
+}
+
+/*
  * Select a virtual address for a new =
client instance=2E
  * Use an --ifconfig-push directive, if given (static I=
P)=2E
  * Otherwise use an --ifconfig-pool address (dynamic IP)=2E
@@ -1403=
,6 +1458,21 @@
 {
     struct gc_arena gc =3D gc_new();
 
+    /* resolve a=
 CCD --subnet-pool-tag against the main-config --subnet-pool list
+     * (=
an unknown tag is rejected with AUTH_FAILED in multi_client_connect) */
+  =
  if (mi->context=2Eoptions=2Esubnet_pool_tag && !mi->context=2Eoptions=2Es=
ubnet_pool_defined)
+    {
+        const struct subnet_pool_def *d =3D
+  =
          subnet_pool_by_tag(m->top=2Eoptions=2Esubnet_pools, mi->context=
=2Eoptions=2Esubnet_pool_tag);
+        if (d)
+        {
+            mi->=
context=2Eoptions=2Esubnet_pool_defined =3D true;
+            mi->context=
=2Eoptions=2Esubnet_pool_network =3D d->network;
+            mi->context=
=2Eoptions=2Esubnet_pool_netmask =3D d->netmask;
+            mi->context=
=2Eoptions=2Esubnet_pool_gateway =3D d->gateway;
+        }
+    }
+
     /=
*
      * If ifconfig addresses were set by dynamic config file,
      * re=
lease pool addresses, otherwise keep them=2E
@@ -1413,8 +1483,10 @@
       =
   * release dynamic allocation */
         if (mi->vaddr_handle >=3D 0)
  =
       {
-            ifconfig_pool_release(m->ifconfig_pool, mi->vaddr_han=
dle, true);
+            ifconfig_pool_release(mi->vaddr_pool ? mi->vaddr_p=
ool : m->ifconfig_pool,
+                                  mi->vaddr_handle=
, true);
             mi->vaddr_handle =3D -1;
+            mi->vaddr_pool =
=3D NULL;
         }
 
         mi->context=2Ec2=2Epush_ifconfig_defined =
=3D true;
@@ -1434,6 +1506,44 @@
                 "MULTI_sva: WARNING: if -=
-ifconfig-push is used for IPv4, automatic IPv6 assignment from --ifconfig-=
ipv6-pool does not work=2E  Use --ifconfig-ipv6-push for IPv6 then=2E");
  =
       }
     }
+    else if (mi->context=2Eoptions=2Esubnet_pool_defined)
=
+    {
+        /* dynamic address from this client's --subnet-pool group *=
/
+
+        /* the CCD is read after a global-pool address may already hav=
e been
+         * acquired; drop it so we can serve this client from its g=
roup */
+        if (mi->vaddr_handle >=3D 0 && !mi->vaddr_pool)
+        {=

+            ifconfig_pool_release(m->ifconfig_pool, mi->vaddr_handle, tru=
e);
+            mi->vaddr_handle =3D -1;
+        }
+
+        if (mi->vad=
dr_handle < 0)
+        {
+            in_addr_t local =3D 0, remote =3D 0;=

+            const char *cn =3D NULL;
+
+            if (!mi->context=2Eop=
tions=2Eduplicate_cn)
+            {
+                cn =3D tls_common_nam=
e(mi->context=2Ec2=2Etls_multi, true);
+            }
+
+            mi->va=
ddr_pool =3D multi_get_group_pool(m, mi->context=2Eoptions=2Esubnet_pool_ta=
g);
+            mi->vaddr_handle =3D ifconfig_pool_acquire(mi->vaddr_pool,=
 &local, &remote, NULL, cn);
+            if (mi->vaddr_handle >=3D 0)
+   =
         {
+                mi->context=2Ec2=2Epush_ifconfig_local =3D remo=
te;
+                mi->context=2Ec2=2Epush_ifconfig_remote_netmask =3D
+ =
                   mi->context=2Eoptions=2Esubnet_pool_netmask;
+          =
      mi->context=2Ec2=2Epush_ifconfig_defined =3D true;
+            }
+  =
          else
+            {
+                msg(D_MULTI_ERRORS, "MULTI: =
no free --subnet-pool addresses are available for %s",
+                   =
 multi_instance_string(mi, false, &gc));
+            }
+        }
+    }
 =
    else if (m->ifconfig_pool && mi->vaddr_handle < 0) /* otherwise, choose=
 a pool address */
     {
         in_addr_t local =3D 0, remote =3D 0;
@@ =
-2339,10 +2449,9 @@
         const char *ifconfig_constraint_netmask =3D
  =
           print_in_addr_t(mi->context=2Eoptions=2Epush_ifconfig_constraint=
_netmask, 0, &gc);
 
-        /* JYFIXME -- this should cause the connectio=
n to fail */
         msg(D_MULTI_ERRORS,
-            "MULTI ERROR: primar=
y virtual IP for %s (%s) "
-            "violates tunnel network/netmask co=
nstraint (%s/%s)",
+            "WARNING: primary virtual IP for %s (%s) "
=
+            "violates tunnel network/netmask constraint (%s/%s) and may no=
t work",
             multi_instance_string(mi, false, &gc),
             p=
rint_in_addr_t(mi->context=2Ec2=2Epush_ifconfig_local, 0, &gc),
           =
  ifconfig_constraint_network, ifconfig_constraint_netmask);
@@ -2450,6 +25=
59,7 @@
 
     /* reset pool handle to null */
     mi->vaddr_handle =3D -1=
;
+    mi->vaddr_pool =3D NULL;
 
     /* do --client-connect setenvs */
  =
   multi_select_virtual_addr(m, mi);
@@ -2741,6 +2851,15 @@
         cc_suc=
ceeded =3D false;
     }
 
+    if (mi->context=2Eoptions=2Esubnet_pool_tag=

+        && !subnet_pool_by_tag(m->top=2Eoptions=2Esubnet_pools, mi->conte=
xt=2Eoptions=2Esubnet_pool_tag))
+    {
+        msg(D_MULTI_ERRORS, "MULTI=
: client has been rejected due to unknown --subnet-pool-tag '%s'",
+       =
     mi->context=2Eoptions=2Esubnet_pool_tag);
+        auth_set_client_rea=
son(mi->context=2Ec2=2Etls_multi, "unknown subnet-pool-tag");
+        cc_s=
ucceeded =3D false;
+    }
+
     if (cc_succeeded)
     {
         multi_c=
lient_connect_late_setup(m, mi, *option_types_found);
diff --git a/src/open=
vpn/multi=2Eh b/src/openvpn/multi=2Eh
index 8b837fa=2E=2Ef6815f4 100644
---=
 a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -121,6 +121,8 @@
  =
   struct mroute_addr real; /**< External network address of the
          =
                     *   remote peer=2E */
     ifconfig_pool_handle vaddr_=
handle;
+    /* pool vaddr_handle belongs to (NULL =3D the global one) */
+=
    struct ifconfig_pool *vaddr_pool;
     char msg_prefix[MULTI_PREFIX_MAX=
_LENGTH];
 
     /* queued outgoing data in Server/TCP mode */
@@ -176,6 +1=
78,8 @@
                                         *   instances=2E */
     s=
truct multi_io *multi_io;         /**< I/O state and events tracker */
    =
 struct ifconfig_pool *ifconfig_pool;
+    /* per-group --subnet-pool dynam=
ic pools */
+    struct subnet_pool *subnet_pools;
     struct frequency_li=
mit *new_connection_limiter;
     struct initial_packet_rate_limit *initial=
_rate_limiter;
     struct mroute_helper *route_helper;
diff --git a/src/op=
envpn/options=2Ec b/src/openvpn/options=2Ec
index 87218d4=2E=2E3f9f7de 1006=
44
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -443,6 +4=
43,11 @@
     "                  If seconds=3D0, file will be treated as re=
ad-only=2E\n"
     "--ifconfig-ipv6-pool base-IP/bits : set aside an IPv6 n=
etwork block\n"
     "                  to be dynamically allocated to conn=
ecting clients=2E\n"
+    "--subnet-pool tag network netmask [gateway] : De=
fine a named pool of\n"
+    "                  addresses outside the --ser=
ver network, selected per\n"
+    "                  client with --subnet-p=
ool-tag=2E\n"
+    "--subnet-pool-tag tag : Assign this client to the --sub=
net-pool named tag=2E\n"
+    "                  Only valid in a client-spe=
cific config file=2E\n"
     "--ifconfig-push local remote-netmask : Push a=
n ifconfig option to remote,\n"
     "                  overrides --ifconfi=
g-pool dynamic allocation=2E\n"
     "                  Only valid in a cli=
ent-specific config file=2E\n"
@@ -7631,6 +7636,33 @@
             goto err=
;
         }
     }
+    else if (streq(p[0], "subnet-pool") && p[1] && p[2=
] && p[3] && !p[5])
+    {
+        struct subnet_pool_def *sp;
+        in=
_addr_t network, netmask;
+
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+   =
     network =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[2], 0, NUL=
L, NULL);
+        netmask =3D getaddr(GETADDR_HOST_ORDER, p[3], 0, NULL, N=
ULL);
+        if (!network || !netmask)
+        {
+            msg(msglev=
el, "cannot parse --subnet-pool addresses");
+            goto err;
+      =
  }
+        ALLOC_OBJ_GC(sp, struct subnet_pool_def, &options->gc);
+     =
   sp->tag =3D p[1];
+        sp->network =3D network & netmask;
+        s=
p->netmask =3D netmask;
+        sp->gateway =3D p[4] ? getaddr(GETADDR_HOS=
T_ORDER | GETADDR_RESOLVE, p[4], 0, NULL, NULL)
+                          =
 : (network & netmask) + 1;
+        sp->next =3D options->subnet_pools;
+ =
       options->subnet_pools =3D sp;
+    }
+    else if (streq(p[0], "subn=
et-pool-tag") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_INS=
TANCE);
+        options->subnet_pool_tag =3D p[1];
+    }
     else if (st=
req(p[0], "ifconfig-push-constraint") && p[1] && p[2] && !p[3])
     {
    =
     in_addr_t network, netmask;
diff --git a/src/openvpn/options=2Eh b/src=
/openvpn/options=2Eh
index a111cf8=2E=2E0c810b3 100644
--- a/src/openvpn/op=
tions=2Eh
+++ b/src/openvpn/options=2Eh
@@ -250,6 +250,17 @@
     struct ve=
rify_hash_list *next;
 };
 
+/* A named --subnet-pool: a subnet clients can=
 be assigned from, referenced
+ * from a CCD file by its tag via --subnet-p=
ool-tag=2E */
+struct subnet_pool_def
+{
+    struct subnet_pool_def *next;=

+    const char *tag;
+    in_addr_t network;
+    in_addr_t netmask;
+   =
 in_addr_t gateway;
+};
+
 /* Command line options */
 struct options
 {
@@=
 -515,6 +526,12 @@
     bool push_ifconfig_constraint_defined;
     in_addr=
_t push_ifconfig_constraint_network;
     in_addr_t push_ifconfig_constrain=
t_netmask;
+    struct subnet_pool_def *subnet_pools; /* named pools (serve=
r config) */
+    const char *subnet_pool_tag;          /* which pool this =
client uses (CCD) */
+    bool subnet_pool_defined;             /* resolved=
 from the tag at connect */
+    in_addr_t subnet_pool_network;
+    in_add=
r_t subnet_pool_netmask;
+    in_addr_t subnet_pool_gateway;
     bool push=
_ifconfig_ipv4_blocked;           /* IPv4 */
     bool push_ifconfig_ipv6_d=
efined;           /* IPv6 */
     struct in6_addr push_ifconfig_ipv6_local;=
  /* IPv6 */
diff --git a/src/openvpn/options_util=2Ec b/src/openvpn/option=
s_util=2Ec
index 47fe0bc=2E=2Eba04917 100644
--- a/src/openvpn/options_util=
=2Ec
+++ b/src/openvpn/options_util=2Ec
@@ -31,6 +31,19 @@
 
 #include "pus=
h=2Eh"
 
+const struct subnet_pool_def *
+subnet_pool_by_tag(const struct s=
ubnet_pool_def *pools, const char *tag)
+{
+    for (const struct subnet_po=
ol_def *d =3D pools; d; d =3D d->next)
+    {
+        if (!strcmp(d->tag, =
tag))
+        {
+            return d;
+        }
+    }
+    return NULL;=

+}
+
 const char *
 parse_auth_failed_temp(struct options *o, const char *=
reason)
 {
diff --git a/src/openvpn/options_util=2Eh b/src/openvpn/options_=
util=2Eh
index 1d4ea9b=2E=2Ec54357c 100644
--- a/src/openvpn/options_util=
=2Eh
+++ b/src/openvpn/options_util=2Eh
@@ -28,6 +28,16 @@
 
 const char *p=
arse_auth_failed_temp(struct options *o, const char *reason);
 
+/**
+ * Lo=
ok up a named --subnet-pool in a list of pool definitions=2E
+ *
+ * @param=
 pools  head of the --subnet-pool list (may be NULL)
+ * @param tag    the =
--subnet-pool-tag to match
+ * @return       the matching pool definition, =
or NULL if none matches
+ */
+const struct subnet_pool_def *subnet_pool_by_=
tag(const struct subnet_pool_def *pools,
+                                 =
                const char *tag);
+
 
 /** Checks if the string is a valid =
integer by checking if it can be
  *  converted to an integer */
diff --git=
 a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefi=
le=2Eam
index 1128eb4=2E=2Ebfb7284 100644
--- a/tests/unit_tests/openvpn/Ma=
kefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -21,6 +21,7 @@
=
 	push_update_msg_testdriver \
 	socket_testdriver \
 	ssl_testdriver \
+	s=
ubnet_pool_testdriver \
 	user_pass_testdriver
 
 if HAVE_LD_WRAP_SUPPORT
@=
@ -361,6 +362,19 @@
 	$(top_srcdir)/src/openvpn/platform=2Ec \
 	$(top_srcd=
ir)/src/openvpn/mbuf=2Ec
 
+subnet_pool_testdriver_CFLAGS  =3D \
+	-I$(top_=
srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	=
@TEST_CFLAGS@
+
+subnet_pool_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
+
+subne=
t_pool_testdriver_SOURCES =3D test_subnet_pool=2Ec \
+	mock_msg=2Ec test_co=
mmon=2Eh \
+	mock_get_random=2Ec \
+	$(top_srcdir)/src/openvpn/buffer=2Ec \=

+	$(top_srcdir)/src/openvpn/options_util=2Ec \
+	$(top_srcdir)/src/openvpn=
/platform=2Ec
+
 misc_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I=
$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	-DSOURCEDIR=3D\"$(=
top_srcdir)\" @TEST_CFLAGS@
diff --git a/tests/unit_tests/openvpn/test_subn=
et_pool=2Ec b/tests/unit_tests/openvpn/test_subnet_pool=2Ec
new file mode 1=
00644
index 0000000=2E=2E8e73b64
--- /dev/null
+++ b/tests/unit_tests/openv=
pn/test_subnet_pool=2Ec
@@ -0,0 +1,72 @@
+/*
+ *  OpenVPN -- An application=
 to securely tunnel IP networks
+ *             over a single UDP port, wit=
h support for SSL/TLS-based
+ *             session authentication and key =
exchange,
+ *             packet encryption, packet authentication, and
+ *=
             packet compression=2E
+ *
+ *  Copyright (C) 2026 OpenVPN Inc =
<sales@openvpn=2Enet>
+ *
+ *  This program is free software; you can redis=
tribute it and/or modify
+ *  it under the terms of the GNU General Public =
License version 2
+ *  as published by the Free Software Foundation=2E
+ *
=
+ *  This program is distributed in the hope that it will be useful,
+ *  b=
ut WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANT=
ABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Pu=
blic License for more details=2E
+ *
+ *  You should have received a copy o=
f the GNU General Public License along
+ *  with this program; if not, see =
<https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#inclu=
de "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdlib=2Eh>
=
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "options=2Eh"
+#i=
nclude "options_util=2Eh"
+#include "test_common=2Eh"
+#include "mock_msg=
=2Eh"
+
+/* --subnet-pool-tag resolves a client to its --subnet-pool; an un=
known tag
+ * returns NULL, which is what makes the server reject that clie=
nt=2E */
+static void
+test_subnet_pool_by_tag(void **state)
+{
+    struct=
 subnet_pool_def c =3D { =2Enext =3D NULL, =2Etag =3D "grpC", =2Enetwork =
=3D 0x0a020300, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a020301 };
+  =
  struct subnet_pool_def b =3D { =2Enext =3D &c, =2Etag =3D "grpB", =2Enetw=
ork =3D 0x0a020200, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a020201 };=

+    struct subnet_pool_def a =3D { =2Enext =3D &b, =2Etag =3D "grpA", =2E=
network =3D 0x0a020100, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a02010=
1 };
+
+    /* every configured tag resolves to its own pool, wherever it s=
its */
+    assert_ptr_equal(subnet_pool_by_tag(&a, "grpA"), &a);
+    asse=
rt_ptr_equal(subnet_pool_by_tag(&a, "grpB"), &b);
+    assert_ptr_equal(sub=
net_pool_by_tag(&a, "grpC"), &c);
+
+    /* and it carries that pool's subn=
et/gateway */
+    const struct subnet_pool_def *r =3D subnet_pool_by_tag(&=
a, "grpB");
+    assert_int_equal(r->network, 0x0a020200);
+    assert_int_=
equal(r->netmask, 0xffffff00);
+    assert_int_equal(r->gateway, 0x0a020201=
);
+
+    /* unknown tag and empty list both miss */
+    assert_null(subne=
t_pool_by_tag(&a, "nope"));
+    assert_null(subnet_pool_by_tag(NULL, "grpA=
"));
+}
+
+const struct CMUnitTest subnet_pool_tests[] =3D {
+    cmocka_un=
it_test(test_subnet_pool_by_tag),
+};
+
+int
+main(void)
+{
+    openvpn_un=
it_test_setup();
+    return cmocka_run_group_tests(subnet_pool_tests, NULL=
, NULL);
+}

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
783?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpat=
chset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia1e7=
db95615d99ef9687de7c4e996dc8033e2631
Gerrit-Change-Number: 1783
Gerrit-Patc=
hSet: 3
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: flic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: ordex <ant=
onio@mandelbit=2Ecom>

--UEAlywAh9Dc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ordex, plaisthos=2E </p>
<p>ordex <stro=
ng>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail">View Change</a></p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">multi: assign clients from a named, tagged subnet-pool<br><br>A=
dd two server directives:<br><br>  subnet-pool &lt;tag&gt; &lt;network&gt; =
&lt;netmask&gt; [&lt;gateway&gt;]   (main config)<br>  subnet-pool-tag &lt;=
tag&gt;                               (per-client CCD)<br><br>so groups of =
clients can be given addresses from subnets other than the<br>--server netw=
ork (per-group firewall rules under --topology subnet, and<br>thus DCO)=2E =
A client&#39;s subnet-pool-tag is resolved to its pool and served<br>a virt=
ual IP from that subnet: a static --ifconfig-push within it, or the<br>next=
 free address from a dynamic per-group pool shared by tag and created<br>on=
 first use=2E Such a client is validated against its own subnet instead<br>=
of the global tunnel-network constraint and never falls back to the<br>glob=
al pool; a tag matching no configured pool is declined with<br>AUTH_FAILED=
=2E<br><br>Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631<br>GitHub: =
closes openvpn/OpenVPN#987<br>Signed-off-by: Antonio Quartulli &lt;antonio@=
mandelbit=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<br>M doc/man-sections/serv=
er-options=2Erst<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M=
 src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/opti=
ons_util=2Ec<br>M src/openvpn/options_util=2Eh<br>M tests/unit_tests/openvp=
n/Makefile=2Eam<br>A tests/unit_tests/openvpn/test_subnet_pool=2Ec<br>10 fi=
les changed, 323 insertions(+), 5 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/83/1783/3</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>ind=
ex 23541a5d=2E=2E3463b5a 100644</span><br><span>--- a/CMakeLists=2Etxt</spa=
n><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -671,6 +671,7 @@</spa=
n><br><span>         &quot;test_provider&quot;</span><br><span>         &qu=
ot;test_socket&quot;</span><br><span>         &quot;test_ssl&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;test_subnet_po=
ol&quot;</span><br><span>         &quot;test_user_pass&quot;</span><br><spa=
n>         &quot;test_push_update_msg&quot;</span><br><span>         )</spa=
n><br><span>@@ -829,6 +830,11 @@</span><br><span>         src/openvpn/list=
=2Ec</span><br><span>         )</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    target_sources(test_subnet_pool PRIVATE</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_te=
sts/openvpn/mock_get_random=2Ec</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        src/openvpn/options_util=2Ec</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        )</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>     target_sources(test_ncp PRIVATE</s=
pan><br><span>         src/openvpn/crypto_epoch=2Ec</span><br><span>       =
  src/openvpn/crypto_mbedtls=2Ec</span><br><span>diff --git a/doc/man-secti=
ons/server-options=2Erst b/doc/man-sections/server-options=2Erst</span><br>=
<span>index f420588=2E=2Eb6464af 100644</span><br><span>--- a/doc/man-secti=
ons/server-options=2Erst</span><br><span>+++ b/doc/man-sections/server-opti=
ons=2Erst</span><br><span>@@ -330,6 +330,37 @@</span><br><span>   by ``--if=
config``, OpenVPN will install a /32 host route for the ``local``</span><br=
><span>   IP address=2E</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+--subnet-pool args</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  Define a named pool of addresses from a subnet diffe=
rent from the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--=
server`` network, so groups of clients can be given IPs from separate</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  subnets for per-group f=
irewall rules under ``--topology subnet`` (and</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  therefore DCO)=2E This is a main-config direct=
ive and may be repeated to</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  define several pools=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Vali=
d syntax:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ::</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     subnet-pool tag network netmask [gatewa=
y]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  ``tag`` is a name a client refers =
to with ``--subnet-pool-tag``; ``gateway``</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  defaults to the first address of ``network``/``net=
mask``=2E A client assigned</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  to a pool receives (dynamically, or via a static ``--ifconfig-pus=
h`` that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  must lie =
within the subnet) an address from it, plus the matching netmask</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  and a ``--route-gateway`` in=
side the subnet so that its pushed routes</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  install on-link=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  A host route to the server&#39;s own VPN IP is not pushed, as it is n=
ot needed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  to reach=
 the networks behind the server=2E If your clients need to reach the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  server&#39;s VPN address=
 itself, add an explicit</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  ``push &quot;route &lt;server-VPN-IP&gt; 255=2E255=2E255=2E255&quot;=
`` (or the ``route-ipv6``</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  equivalent) to the server config=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+--subnet-pool-tag tag</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  Assign this client to the ``--subnet-pool`` named ``tag``=2E Must =
be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  associated with=
 a specific client instance via ``--client-config-dir`` or</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  ``--client-connect``=2E Several cl=
ients may reference the same tag and are</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  then served from the same shared pool=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --ifconfig-ip=
v6-push args</span><br><span>   for ``--client-config-dir`` per-client stat=
ic IPv6 interface</span><br><span>   configuration, see ``--client-config-d=
ir`` and ``--ifconfig-push`` for</span><br><span>diff --git a/src/openvpn/m=
ulti=2Ec b/src/openvpn/multi=2Ec</span><br><span>index c4293a7=2E=2Eda46cf4=
 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/s=
rc/openvpn/multi=2Ec</span><br><span>@@ -42,6 +42,7 @@</span><br><span> #in=
clude &quot;vlan=2Eh&quot;</span><br><span> #include &quot;auth_token=2Eh&q=
uot;</span><br><span> #include &quot;route=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;options_util=2Eh&quot;</sp=
an><br><span> #include &lt;inttypes=2Eh&gt;</span><br><span> #include &lt;s=
tring=2Eh&gt;</span><br><span> </span><br><span>@@ -53,6 +54,17 @@</span><b=
r><span> #include &quot;dco=2Eh&quot;</span><br><span> #include &quot;refle=
ct_filter=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Dynamic address pool serving the clients of one --subnet-pool tag=2E  S=
hared</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * by every cl=
ient that references the tag, created on first use=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+struct subnet_pool</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct subnet_pool *next;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const char *tag;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct ifconfig_pool *pool;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> /*#define MULTI_DEBUG_EVENT_LOOP*/</span><br><span> =
</span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span>@@ -612,7 +=
624,8 @@</span><br><span> </span><br><span>         schedule_remove_entry(m=
-&gt;schedule, (struct schedule_entry *)mi);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        ifconfig_pool_release(m-&g=
t;ifconfig_pool, mi-&gt;vaddr_handle, false);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        ifconfig_pool_release(mi-&gt;vaddr_pool ?=
 mi-&gt;vaddr_pool : m-&gt;ifconfig_pool, mi-&gt;vaddr_handle,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                              fa=
lse);</span><br><span> </span><br><span>         if (mi-&gt;did_iroutes)</s=
pan><br><span>         {</span><br><span>@@ -687,6 +700,14 @@</span><br><sp=
an>         schedule_free(m-&gt;schedule);</span><br><span>         mbuf_fr=
ee(m-&gt;mbuf);</span><br><span>         ifconfig_pool_free(m-&gt;ifconfig_=
pool);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        while=
 (m-&gt;subnet_pools)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    struct subnet_pool *sp =3D m-&gt;subnet_pools;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            m-&gt;subnet_pools =3D sp-&gt;next;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            ifconfig_pool_free(sp-&=
gt;pool);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  free(sp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span>         frequency_limit_free(m-&gt;new_connection_limite=
r);</span><br><span>         initial_rate_limit_free(m-&gt;initial_rate_lim=
iter);</span><br><span>         multi_reap_free(m-&gt;reaper);</span><br><s=
pan>@@ -1384,6 +1405,12 @@</span><br><span>     const struct options *o =3D=
 &amp;c-&gt;options;</span><br><span>     if (o-&gt;push_ifconfig_constrain=
t_defined &amp;&amp; c-&gt;c2=2Epush_ifconfig_defined)</span><br><span>    =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* a subn=
et-pool client is validated against its own subnet */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (o-&gt;subnet_pool_defined)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            return (o-&gt;subnet=
_pool_netmask &amp; c-&gt;c2=2Epush_ifconfig_local)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                   =3D=3D o-&gt;subnet_po=
ol_network;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span>         return (o-&gt;push_ifconfig_constraint_netmask &=
amp; c-&gt;c2=2Epush_ifconfig_local)</span><br><span>                =3D=3D=
 o-&gt;push_ifconfig_constraint_network;</span><br><span>     }</span><br><=
span>@@ -1394,6 +1421,34 @@</span><br><span> }</span><br><span> </span><br>=
<span> /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return =
the dynamic pool serving the clients tagged with &lt;tag&gt;, creating it</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * on first use from =
the matching --subnet-pool definition=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static struct ifconfig_pool *</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+multi_get_group_pool(struct multi_context *m, const char *ta=
g)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool *sp;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    for (sp =3D m-&gt;subnet_pools; sp; sp =3D=
 sp-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!strcmp(=
sp-&gt;tag, tag))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
return sp-&gt;pool;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct subnet_pool_def *d4 =3D =
subnet_pool_by_tag(m-&gt;top=2Eoptions=2Esubnet_pools, tag);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(sp, struct sub=
net_pool);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sp-&g=
t;tag =3D d4-&gt;tag;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    sp-&gt;pool =3D ifconfig_pool_init(true, IFCONFIG_POOL_INDIV, d4-&gt;=
network + 2,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                           (d4-&gt;network | ~d4-&gt;netmask) - 1, m-&gt;to=
p=2Eoptions=2Eduplicate_cn,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                  false, in6addr_any, 0);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;next =3D m-&gt;sub=
net_pools;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt=
;subnet_pools =3D sp;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return sp-&gt;pool;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span>  * Select a=
 virtual address for a new client instance=2E</span><br><span>  * Use an --=
ifconfig-push directive, if given (static IP)=2E</span><br><span>  * Otherw=
ise use an --ifconfig-pool address (dynamic IP)=2E</span><br><span>@@ -1403=
,6 +1458,21 @@</span><br><span> {</span><br><span>     struct gc_arena gc =
=3D gc_new();</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* resolve a CCD --subnet-pool-tag against the main-config =
--subnet-pool list</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * (an unknown tag is rejected with AUTH_FAILED in multi_client_connect)=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;c=
ontext=2Eoptions=2Esubnet_pool_tag &amp;&amp; !mi-&gt;context=2Eoptions=2Es=
ubnet_pool_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const =
struct subnet_pool_def *d =3D</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            subnet_pool_by_tag(m-&gt;top=2Eoptions=2Esubnet_pools=
, mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (d)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            mi-&gt;context=2Eoptions=2Esubnet_pool_defined =3D =
true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi=
-&gt;context=2Eoptions=2Esubnet_pool_network =3D d-&gt;network;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=2Eop=
tions=2Esubnet_pool_netmask =3D d-&gt;netmask;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            mi-&gt;context=2Eoptions=2Esubnet_po=
ol_gateway =3D d-&gt;gateway;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an>     /*</span><br><span>      * If ifconfig addresses were set by dynami=
c config file,</span><br><span>      * release pool addresses, otherwise ke=
ep them=2E</span><br><span>@@ -1413,8 +1483,10 @@</span><br><span>         =
 * release dynamic allocation */</span><br><span>         if (mi-&gt;vaddr_=
handle &gt;=3D 0)</span><br><span>         {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            ifconfig_pool_release(m-&gt;ifconfig_poo=
l, mi-&gt;vaddr_handle, true);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            ifconfig_pool_release(mi-&gt;vaddr_pool ? mi-&gt;vad=
dr_pool : m-&gt;ifconfig_pool,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                  mi-&gt;vaddr_handle, true);</s=
pan><br><span>             mi-&gt;vaddr_handle =3D -1;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;vaddr_pool =3D NULL;<=
/span><br><span>         }</span><br><span> </span><br><span>         mi-&g=
t;context=2Ec2=2Epush_ifconfig_defined =3D true;</span><br><span>@@ -1434,6=
 +1506,44 @@</span><br><span>                 &quot;MULTI_sva: WARNING: if =
--ifconfig-push is used for IPv4, automatic IPv6 assignment from --ifconfig=
-ipv6-pool does not work=2E  Use --ifconfig-ipv6-push for IPv6 then=2E&quot=
;);</span><br><span>         }</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (mi-&gt;context=2Eoptions=2Es=
ubnet_pool_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* dyn=
amic address from this client&#39;s --subnet-pool group */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* the CCD is read after a global-pool address =
may already have been</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+         * acquired; drop it so we can serve this client from its group *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (mi-&gt=
;vaddr_handle &gt;=3D 0 &amp;&amp; !mi-&gt;vaddr_pool)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            ifconfig_pool_release(m-&gt;ifconfig_p=
ool, mi-&gt;vaddr_handle, true);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            mi-&gt;vaddr_handle =3D -1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (mi-&gt;vaddr_handle &lt; 0)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            in_addr_t local =3D 0, remote =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            const char *cn =3D =
NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (!mi-&gt;context=
=2Eoptions=2Eduplicate_cn)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                cn =3D tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, tr=
ue);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;vaddr_pool =3D multi_=
get_group_pool(m, mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;vaddr_handle =
=3D ifconfig_pool_acquire(mi-&gt;vaddr_pool, &amp;local, &amp;remote, NULL,=
 cn);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if=
 (mi-&gt;vaddr_handle &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                mi-&gt;context=2Ec2=2Epush_ifconfig_local =3D remote=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                mi=
-&gt;context=2Ec2=2Epush_ifconfig_remote_netmask =3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    mi-&gt;context=2Eopti=
ons=2Esubnet_pool_netmask;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                mi-&gt;context=2Ec2=2Epush_ifconfig_defined =3D true=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                msg(D_MULTI_ERROR=
S, &quot;MULTI: no free --subnet-pool addresses are available for %s&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 multi_instance_string(mi, false, &amp;gc));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span>     else if (m-&gt;ifconfig_pool &amp;&amp;=
 mi-&gt;vaddr_handle &lt; 0) /* otherwise, choose a pool address */</span><=
br><span>     {</span><br><span>         in_addr_t local =3D 0, remote =3D =
0;</span><br><span>@@ -2339,10 +2449,9 @@</span><br><span>         const ch=
ar *ifconfig_constraint_netmask =3D</span><br><span>             print_in_a=
ddr_t(mi-&gt;context=2Eoptions=2Epush_ifconfig_constraint_netmask, 0, &amp;=
gc);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        /* JYFIXME -- this should cause the connection to fail */</span><b=
r><span>         msg(D_MULTI_ERRORS,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            &quot;MULTI ERROR: primary virtual IP for %s (%s=
) &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &=
quot;violates tunnel network/netmask constraint (%s/%s)&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            &quot;WARNING: prima=
ry virtual IP for %s (%s) &quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            &quot;violates tunnel network/netmask constraint (=
%s/%s) and may not work&quot;,</span><br><span>             multi_instance_=
string(mi, false, &amp;gc),</span><br><span>             print_in_addr_t(mi=
-&gt;context=2Ec2=2Epush_ifconfig_local, 0, &amp;gc),</span><br><span>     =
        ifconfig_constraint_network, ifconfig_constraint_netmask);</span><b=
r><span>@@ -2450,6 +2559,7 @@</span><br><span> </span><br><span>     /* res=
et pool handle to null */</span><br><span>     mi-&gt;vaddr_handle =3D -1;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;vaddr_poo=
l =3D NULL;</span><br><span> </span><br><span>     /* do --client-connect s=
etenvs */</span><br><span>     multi_select_virtual_addr(m, mi);</span><br>=
<span>@@ -2741,6 +2851,15 @@</span><br><span>         cc_succeeded =3D fals=
e;</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (mi-&gt;context=2Eoptions=2Esubnet_pool_tag<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !=
subnet_pool_by_tag(m-&gt;top=2Eoptions=2Esubnet_pools, mi-&gt;context=2Eopt=
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
4=2E=2E3f9f7de 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><=
br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -443,6 +443,11 @@=
</span><br><span>     &quot;                  If seconds=3D0, file will be =
treated as read-only=2E\n&quot;</span><br><span>     &quot;--ifconfig-ipv6-=
pool base-IP/bits : set aside an IPv6 network block\n&quot;</span><br><span=
>     &quot;                  to be dynamically allocated to connecting cli=
ents=2E\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
&quot;--subnet-pool tag network netmask [gateway] : Define a named pool of\=
n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;  =
                addresses outside the --server network, selected per\n&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;        =
          client with --subnet-pool-tag=2E\n&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &quot;--subnet-pool-tag tag : Assign thi=
s client to the --subnet-pool named tag=2E\n&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &quot;                  Only valid in a =
client-specific config file=2E\n&quot;</span><br><span>     &quot;--ifconfi=
g-push local remote-netmask : Push an ifconfig option to remote,\n&quot;</s=
pan><br><span>     &quot;                  overrides --ifconfig-pool dynami=
c allocation=2E\n&quot;</span><br><span>     &quot;                  Only v=
alid in a client-specific config file=2E\n&quot;</span><br><span>@@ -7631,6=
 +7636,33 @@</span><br><span>             goto err;</span><br><span>       =
  }</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    else if (streq(p[0], &quot;subnet-pool&quot;) &amp;&amp; p[1] &a=
mp;&amp; p[2] &amp;&amp; p[3] &amp;&amp; !p[5])</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        struct subnet_pool_def *sp;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        in_addr_t network, netmask;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        network =3D getadd=
r(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[2], 0, NULL, NULL);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        netmask =3D getaddr(GETAD=
DR_HOST_ORDER, p[3], 0, NULL, NULL);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (!network || !netmask)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(msglevel, &quot;cannot parse --subnet-=
pool addresses&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   ALLOC_OBJ_GC(sp, struct subnet_pool_def, &amp;options-&gt;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;tag =3D p[1];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;netwo=
rk =3D network &amp; netmask;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        sp-&gt;netmask =3D netmask;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        sp-&gt;gateway =3D p[4] ? getaddr(GETADDR=
_HOST_ORDER | GETADDR_RESOLVE, p[4], 0, NULL, NULL)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                           : (network &am=
p; netmask) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     sp-&gt;next =3D options-&gt;subnet_pools;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        options-&gt;subnet_pools =3D sp;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;subnet-poo=
l-tag&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        VERIFY_PERMISSION(OPT_P_INSTANCE);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        options-&gt;subnet_pool_tag =3D=
 p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span>     else if (streq(p[0], &quot;ifconfig-push-constraint&quot;) &a=
mp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>     {</spa=
n><br><span>         in_addr_t network, netmask;</span><br><span>diff --git=
 a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index =
a111cf8=2E=2E0c810b3 100644</span><br><span>--- a/src/openvpn/options=2Eh</=
span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -250,6 +250=
,17 @@</span><br><span>     struct verify_hash_list *next;</span><br><span>=
 };</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* A named --subnet-pool: a subnet clients can be assigned from, referenc=
ed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * from a CCD fil=
e by its tag via --subnet-pool-tag=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+struct subnet_pool_def</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct subnet_pool_def *next;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const char *tag;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    in_addr_t network;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    in_addr_t netmask;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    in_addr_t gateway;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> /* Command line options */</span><br><span> =
struct options</span><br><span> {</span><br><span>@@ -515,6 +526,12 @@</spa=
n><br><span>     bool push_ifconfig_constraint_defined;</span><br><span>   =
  in_addr_t push_ifconfig_constraint_network;</span><br><span>     in_addr_=
t push_ifconfig_constraint_netmask;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct subnet_pool_def *subnet_pools; /* named pools (s=
erver config) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const char *subnet_pool_tag;          /* which pool this client uses (CCD)=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool subnet_=
pool_defined;             /* resolved from the tag at connect */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t subnet_pool_netw=
ork;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t s=
ubnet_pool_netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    in_addr_t subnet_pool_gateway;</span><br><span>     bool push_ifconfig_=
ipv4_blocked;           /* IPv4 */</span><br><span>     bool push_ifconfig_=
ipv6_defined;           /* IPv6 */</span><br><span>     struct in6_addr pus=
h_ifconfig_ipv6_local;  /* IPv6 */</span><br><span>diff --git a/src/openvpn=
/options_util=2Ec b/src/openvpn/options_util=2Ec</span><br><span>index 47fe=
0bc=2E=2Eba04917 100644</span><br><span>--- a/src/openvpn/options_util=2Ec<=
/span><br><span>+++ b/src/openvpn/options_util=2Ec</span><br><span>@@ -31,6=
 +31,19 @@</span><br><span> </span><br><span> #include &quot;push=2Eh&quot;=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
onst struct subnet_pool_def *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+subnet_pool_by_tag(const struct subnet_pool_def *pools, const cha=
r *tag)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    for (const struct subnet_p=
ool_def *d =3D pools; d; d =3D d-&gt;next)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (!strcmp(d-&gt;tag, tag))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            return d;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const cha=
r *</span><br><span> parse_auth_failed_temp(struct options *o, const char *=
reason)</span><br><span> {</span><br><span>diff --git a/src/openvpn/options=
_util=2Eh b/src/openvpn/options_util=2Eh</span><br><span>index 1d4ea9b=2E=
=2Ec54357c 100644</span><br><span>--- a/src/openvpn/options_util=2Eh</span>=
<br><span>+++ b/src/openvpn/options_util=2Eh</span><br><span>@@ -28,6 +28,1=
6 @@</span><br><span> </span><br><span> const char *parse_auth_failed_temp(=
struct options *o, const char *reason);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Look up a named --subnet-pool in a list of pool de=
finitions=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pools  head of=
 the --subnet-pool list (may be NULL)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param tag    the --subnet-pool-tag to match</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @return       the matching=
 pool definition, or NULL if none matches</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+const struct subnet_pool_def *subnet_pool_by_tag(const struct subnet_=
pool_def *pools,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                              const char *tag);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><s=
pan> /** Checks if the string is a valid integer by checking if it can be</=
span><br><span>  *  converted to an integer */</span><br><span>diff --git a=
/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=
=2Eam</span><br><span>index 1128eb4=2E=2Ebfb7284 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_=
tests/openvpn/Makefile=2Eam</span><br><span>@@ -21,6 +21,7 @@</span><br><sp=
an> 	push_update_msg_testdriver \</span><br><span> 	socket_testdriver \</sp=
an><br><span> 	ssl_testdriver \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	subnet_pool_testdriver \</span><br><span> 	user_pass_testdrive=
r</span><br><span> </span><br><span> if HAVE_LD_WRAP_SUPPORT</span><br><spa=
n>@@ -361,6 +362,19 @@</span><br><span> 	$(top_srcdir)/src/openvpn/platform=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/mbuf=2Ec</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+subnet_pool_testd=
river_CFLAGS  =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/ope=
nvpn \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	@TEST_CFLAGS=
@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+subnet_pool_testdriver_LDFLAGS =3D @T=
EST_LDFLAGS@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+subnet_pool_testdriver_SOU=
RCES =3D test_subnet_pool=2Ec \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	mock_msg=2Ec test_common=2Eh \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	mock_get_random=2Ec \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/o=
ptions_util=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$=
(top_srcdir)/src/openvpn/platform=2Ec</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> misc_testdriver_CFLAGS  =3D \</span><br=
><span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)=
/src/openvpn \</span><br><span> 	-DSOURCEDIR=3D\&quot;$(top_srcdir)\&quot; =
@TEST_CFLAGS@</span><br><span>diff --git a/tests/unit_tests/openvpn/test_su=
bnet_pool=2Ec b/tests/unit_tests/openvpn/test_subnet_pool=2Ec</span><br><sp=
an>new file mode 100644</span><br><span>index 0000000=2E=2E8e73b64</span><b=
r><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_s=
ubnet_pool=2Ec</span><br><span>@@ -0,0 +1,72 @@</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a s=
ingle UDP port, with support for SSL/TLS-based</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             session authentication and key ex=
change,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   packet encryption, packet authentication, and</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 OpenVPN Inc &lt;sales@o=
penvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is =
free software; you can redistribute it and/or modify</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General=
 Public License version 2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  as published by the Free Software Foundation=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  This program is distributed in the hope that it wi=
ll be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  bu=
t WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR=
 A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  GNU General Public License for more details=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU =
General Public License along</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/lic=
enses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;options=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;options_util=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;mock_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* --subnet-pool-=
tag resolves a client to its --subnet-pool; an unknown tag</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * returns NULL, which is what makes=
 the server reject that client=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+test_subnet_pool_by_tag(void **state)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct subnet_pool_def c =3D { =2Enext =3D NULL, =2Etag =3D &q=
uot;grpC&quot;, =2Enetwork =3D 0x0a020300, =2Enetmask =3D 0xffffff00, =2Ega=
teway =3D 0x0a020301 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct subnet_pool_def b =3D { =2Enext =3D &amp;c, =2Etag =3D &quot=
;grpB&quot;, =2Enetwork =3D 0x0a020200, =2Enetmask =3D 0xffffff00, =2Egatew=
ay =3D 0x0a020201 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct subnet_pool_def a =3D { =2Enext =3D &amp;b, =2Etag =3D &quot;gr=
pA&quot;, =2Enetwork =3D 0x0a020100, =2Enetmask =3D 0xffffff00, =2Egateway =
=3D 0x0a020101 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* every configur=
ed tag resolves to its own pool, wherever it sits */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(subnet_pool_by_tag(&=
amp;a, &quot;grpA&quot;), &amp;a);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_ptr_equal(subnet_pool_by_tag(&amp;a, &quot;grpB&q=
uot;), &amp;b);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_ptr_equal(subnet_pool_by_tag(&amp;a, &quot;grpC&quot;), &amp;c);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* and it carries that pool&#39;s sub=
net/gateway */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst struct subnet_pool_def *r =3D subnet_pool_by_tag(&amp;a, &quot;grpB&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(r-&gt;network, 0x0a020200);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(r-&gt;netmask, 0xffffff00);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r-&gt;gate=
way, 0x0a020201);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* unknown tag an=
d empty list both miss */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_null(subnet_pool_by_tag(&amp;a, &quot;nope&quot;));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(subnet_poo=
l_by_tag(NULL, &quot;grpA&quot;));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+const struct CMUnitTes=
t subnet_pool_tests[] =3D {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    cmocka_unit_test(test_subnet_pool_by_tag),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
nt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+main(void)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    openvpn_unit_test_setup();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return cmocka_run_group_tests=
(subnet_pool_tests, NULL, NULL);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail">change 1783=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
a1e7db95615d99ef9687de7c4e996dc8033e2631 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1783 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antoni=
o@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@man=
delbit=2Ecom&gt; </div>

</body></html>
--UEAlywAh9Dc=--


--===============8862601107015511569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8862601107015511569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8862601107015511569==--

