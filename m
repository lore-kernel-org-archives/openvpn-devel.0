Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B09CCA490
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 08:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Hm3Or61bIv2Eoxl1RXlIgZy+ngzzuig+pym0/RF3Nc=; b=Id3B2BUkw0z3H589O85exAD46M
	x/h3rVU3aLt4xOgnHrpEjdFsg/C1TM9BxHaq89GjzRrfFttFpiG6/BC7Uvndu8JeShkrFnlbvZH5A
	lEoSQz1h2GiBdLnOPm8DcaefswHu3KjEEJSnYCxqJYOvkco2/7Tx6v8lgfxSvF70rhCU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIMRH-0003T4-UB;
	Sun, 18 Oct 2026 08:40:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIMR3-0003Lx-QM
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 08:40:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=XoKfBdx8gTQ7ERaMff5rSOHMwkVN9RR8pZPULMU7zi4=; b=EzY8aCWYcUvBHjQUSV6ywD0Hoc
 DhaJrH7HvJ6whqIgkVuHsdrvRqDYE2t/6pHo0tQLwKOHibm7fOXVAJ8yOuRXlVDltZZZcM6PSQ1fV
 etpt4fpQVtRZAOTZOzBz6zJAgKZKH/UKh1AVq1A3QA9XHa0WoOVvnO7hORaP3FKq/leY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XoKfBdx8gTQ7ERaMff5rSOHMwkVN9RR8pZPULMU7zi4=; b=F
 dzdRS7HRGD3XP1Um08WC5Uxelsw8y7Z7Vi7TcbbEfjaCi7FCM9+dwd1HyB5SUZ1TM1TI9KI9X0Xwu
 VA2SClyIGrSDhuNBwr40ahqRdzZWuZumhUWvaDy4UrYRvZjShkWdH7Z6TuBD7Qp1YRUo4PuMjloPF
 l3C7Rrv9ar5a7dxU=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIMQs-0007U2-VW for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 08:40:03 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48e0d1da913so585297f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 01:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792312788; x=1792917588; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XoKfBdx8gTQ7ERaMff5rSOHMwkVN9RR8pZPULMU7zi4=;
 b=agFyfxprSyj9ZmmAUfhqYxrjzp0n6HI8RxxxZs5T7Lws2xMeoHlfzItrlmdzZRs4At
 d3PWaJPf/RARCkXrvpWlpaVKDwZ+k54PdQcswuNz4pCuPlzVyQ2TJ/Xo3ADHm+df78++
 dIGzkIbLteCi5micdV7p4k8CEF94iyrmVYsHt6NNNM9goTwjJZB3haryASTwHgirCjQB
 YRLilBmkfbsvroFnfuwa28ScxiHNOwFb5IfTEkmIDXaM1jiyvg58MoLfnh8wm2zODOlM
 aQ/F7mgpWyTyw8SIWn+qWCMkx0UTeoQB3zLc2mKT2JEq/rQTKNFaY0UhgKyJraA7scq1
 LTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792312788; x=1792917588;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XoKfBdx8gTQ7ERaMff5rSOHMwkVN9RR8pZPULMU7zi4=;
 b=LndRCvWtC6eNlBq1DLkhOyY0pxNV8VfVK2uzeJ7c06Ti21oLeG5vZbasG6+mRAWryu
 Zm9HRnuJVgknz9hqkkRTzOcHJKZ33c5fZG/bxu072H5HwuzDw2MMS4JUtEXl/Gmfd63G
 /lRkL9ly5MeFx1TtiftT667LftP6hrg+47YhbWCIMGZzyqTy+bMutarwJDR5H4ESVLN4
 b9Kdq+1QEN2rypjxZAD5eaWmJN34QJ3WeBmh1AkSfY1H93QqGSSCxj+cjiX0xpzTGP69
 573IOp8kDcoAYTsVBs+k7xXx52daYnCTYp7TlpGORCSdjyA7SSGWNp+gRY1rtC9MrmaX
 EEXw==
X-Gm-Message-State: AFq9FYK4QfegrqNzhMjgozmuXnX7C5uPjD8DK59cIGew7XZDgKi07fh4
 YuTDIAhOdTx3kW44Elot7wSYmRas4qg1fb9jSymrRClGGI+4G9FxuAm2tmNbDQl/baKHsWnq/cm
 Q59oY9BodovKYjX/CIyP6u79b2i6ApdLm1Q0m988kB0IwT3V/+df1kDgXN3A/2YHFKeEkhc5Ie+
 wPj7IjYg==
X-Gm-Gg: AYBFou0RbGxh/WkWQW9YGjfrLEp8oETuBX7JmmncuTX1uw3N/xsoUYgxUZz4OFnLBmr
 9QllKvIZYj/Lw6sBp6K37yS0x3TwAVUR3HmIb3vOJXUtkCEMfxMdu+DVEwKnhYz5Lo8cwrNjPx1
 ndoMpByqDkxuyX4un8peT+SpCWGCbd1ohK4abya5oE1O5fb6qYHmiF5hdTG+/kxRI2lv7s8iStO
 JmtUZlgDShY1AAKdjHNqni0r9TYs9ge8Bs8yLwQr7MNFQQgrZmqboXGwVsHMOgieVYUkL9osBNk
 kVKYrGpIOWdlZ6YNfiQfsbQRmfvo+ONV4FugJ8hJH5INOEmE3MyYZHjLSXu1+VdTrhcCC0FkBuf
 tlbrngMwOgepWcCehhdV1LTARugRS9XS6+hH0t31x/iZg9LVSjoL9ZB0neJKudjv75IV2anPLhv
 1m43b774H8gYK+xyI/5dkQ+lTmkIzAuLaY0Sa6FU3r1CcWF5J5oJBdsL0aiiBgoRIBOPc1pZCQi
 H/xFRKcE30M9QIWDDTCDJsx4OrilaPl47q7McD1VFemdE/S3VYVEwEsMDGwlIbIHNeE/xSg2AwA
 oP1cS34p0sRUSUazJKk8k5NPymuQav1EGI+Vf4q2+cuL093z1N9Ppjz2fefL
X-Received: by 2002:a05:6000:2488:b0:48d:f3ec:e818 with SMTP id
 ffacd0b85a97d-48dfae552eemr17867068f8f.7.1792312787630; 
 Sun, 18 Oct 2026 01:39:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd510c78sm15673268f8f.57.2026.10.18.01.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 01:39:46 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 08:39:43 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
X-Gerrit-Change-Number: 1783
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1783?usp=email>
X-Gerrit-Commit: 690ed32a0c87a92f2be1aecd90650d31f56953b4
In-Reply-To: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
References: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLklhMWU3ZGI5NTYxNWQ5OWVmOTY4N2RlN2M0ZTk5NmRjODAzM2UyNjMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ce30883d797f9849e39310b35c68f3ba10c21bb9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIMQs-0007U2-VW
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
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0658675065004423094=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0658675065004423094==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fiW41LolruI="; charset=UTF-8

--fiW41LolruI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
ello Arne Schwabe, Frank Lichtenheld, 

I'd like you to reexamine a change=
=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=
=3Demail

to look at the new patch set (#6)=2E


Change subject: multi: ass=
ign clients from a named, tagged subnet-pool
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
red by tag=2E Such a
client is validated against its own subnet instead of =
the global
tunnel-network constraint and never falls back to the global poo=
l; a tag
matching no configured pool is declined with AUTH_FAILED=2E The ta=
g is
resolved again after every client-connect handler, so a script, plugin=

or management interface may override the one set by the CCD file=2E

The p=
ools are checked when the config is loaded, as for --server: the
netmask mu=
st be contiguous and between /16 and /29, the gateway a host
address inside=
 the subnet, tags unique, and no pool may overlap another
or the --server n=
etwork=2E Every pool is created at startup, and its
gateway is reserved so =
it is never handed out to a client=2E

The server routes each pool's subnet=
 into its tun device, as the device
is only configured with the --server ne=
twork: without this the server
cannot reach its subnet-pool clients=2E This=
 is a regular --route, so it
is installed before privileges are dropped and=
 honours --route-table,
--route-metric and --route-noexec=2E Under DCO on L=
inux and FreeBSD,
though, the kernel selects the peer by the route's next h=
op, so a route
via a gateway would deliver every packet for an unassigned p=
ool address
to the client owning that gateway address: there the route is i=
nstalled
on-link on the tun device instead (a new on_link route option flag=
), and
each client of the pool gets its own on-link host route on connect (=
as
its address is outside the --ifconfig network), so such packets match
no=
 peer=2E

Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
GitHub: clos=
es openvpn/OpenVPN#987
Signed-off-by: Antonio Quartulli <antonio@mandelbit=
=2Ecom>
---
M CMakeLists=2Etxt
M doc/man-sections/server-options=2Erst
M sr=
c/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/options=2Ec
M src=
/openvpn/options=2Eh
M src/openvpn/options_util=2Ec
M src/openvpn/options_u=
til=2Eh
M src/openvpn/pool=2Ec
M src/openvpn/pool=2Eh
M src/openvpn/route=
=2Ec
M src/openvpn/route=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
A tes=
ts/unit_tests/openvpn/test_subnet_pool=2Ec
14 files changed, 679 insertions=
(+), 15 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/83/1783/6

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
=
index b286ee2=2E=2E4e87a6a 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=
=2Etxt
@@ -694,6 +694,7 @@
         "test_provider"
         "test_socket"
=
         "test_ssl"
+        "test_subnet_pool"
         "test_user_pass"
 =
        "test_push_update_msg"
         )
@@ -868,6 +869,11 @@
         src=
/openvpn/session_id=2Ec
     )
 
+    target_sources(test_subnet_pool PRIVA=
TE
+        tests/unit_tests/openvpn/mock_get_random=2Ec
+        src/openv=
pn/options_util=2Ec
+        )
+
     target_sources(test_ncp PRIVATE
     =
    src/openvpn/crypto_epoch=2Ec
         src/openvpn/crypto_mbedtls=2Ec
di=
ff --git a/doc/man-sections/server-options=2Erst b/doc/man-sections/server-=
options=2Erst
index 9dfa6bd=2E=2Ed868d09 100644
--- a/doc/man-sections/serv=
er-options=2Erst
+++ b/doc/man-sections/server-options=2Erst
@@ -330,6 +330=
,41 @@
   by ``--ifconfig``, OpenVPN will install a /32 host route for the =
``local``
   IP address=2E
 
+--subnet-pool args
+  Define a named pool of =
addresses from a subnet different from the
+  ``--server`` network, so grou=
ps of clients can be given IPs from separate
+  subnets for per-group firew=
all rules under ``--topology subnet`` (and
+  therefore DCO)=2E This is a m=
ain-config directive and may be repeated to
+  define several pools=2E
+
+ =
 Valid syntax:
+  ::
+
+     subnet-pool tag network netmask [gateway]
+
+ =
 ``tag`` is a name a client refers to with ``--subnet-pool-tag``; ``gateway=
``
+  defaults to the first address of ``network``/``netmask`` and is never=

+  assigned to a client=2E A client assigned to a pool receives (dynamical=
ly, or
+  via a static ``--ifconfig-push`` that must lie within the subnet)=
 an address
+  from it, plus the matching netmask=2E
+
+  Requires ``--serv=
er`` with ``--dev tun`` and ``--topology subnet``=2E
+  ``netmask`` must be=
 between /16 and /29 (as for ``--server``), ``gateway``
+  must be a host a=
ddress inside the subnet, each ``tag`` may be defined only
+  once and no p=
ool may overlap another one or the ``--server`` network=2E
+
+  The server =
routes each pool's subnet into the tun device, as it does for
+  the ``--se=
rver`` network; no ``--route`` needs to be added for it=2E These
+  routes =
honour ``--route-table`` and ``--route-metric``=2E With DCO on Linux
+  and=
 FreeBSD the IPv4 route is installed on-link, without a gateway, so its
+  =
``route_gateway_{n}`` is not set for ``--route-up`` scripts=2E
+
+--subnet-=
pool-tag tag
+  Assign this client to the ``--subnet-pool`` named ``tag``=
=2E Must be
+  associated with a specific client instance via ``--client-co=
nfig-dir`` or
+  ``--client-connect``=2E Several clients may reference the =
same tag and are
+  then served from the same shared pool=2E
+
 --ifconfig-=
ipv6-push args
   for ``--client-config-dir`` per-client static IPv6 interf=
ace
   configuration, see ``--client-config-dir`` and ``--ifconfig-push`` f=
or
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index a2cfdbf=
=2E=2E12b7442 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2E=
c
@@ -43,6 +43,7 @@
 #include "auth_token=2Eh"
 #include "route=2Eh"
 #incl=
ude "sid_hash=2Eh"
+#include "options_util=2Eh"
 #include <inttypes=2Eh>
 #=
include <string=2Eh>
 
@@ -54,6 +55,20 @@
 #include "dco=2Eh"
 #include "re=
flect_filter=2Eh"
 
+/*
+ * Dynamic address pool serving the clients of one=
 --subnet-pool tag=2E  Shared
+ * by every client that references the tag, =
created on first use=2E
+ */
+struct subnet_pool
+{
+    struct subnet_pool=
 *next;
+    const char *tag;
+    struct ifconfig_pool *pool;
+};
+
+stati=
c struct ifconfig_pool *multi_get_group_pool(struct multi_context *m,
+    =
                                              const struct options *o, cons=
t char *tag);
+
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
 #ifdef MULTI_DEBUG_E=
VENT_LOOP
@@ -371,6 +386,13 @@
         }
     }
 
+    /* create every --s=
ubnet-pool group up front rather than on first use, so
+     * that its poo=
l exists before any client of the group connects */
+    for (const struct =
subnet_pool_def *d =3D t->options=2Esubnet_pools; d; d =3D d->next)
+    {
=
+        multi_get_group_pool(m, &t->options, d->tag);
+    }
+
     /*
   =
   * Help us keep track of routing table=2E
      */
@@ -625,7 +647,8 @@
 
=
         schedule_remove_entry(m->schedule, (struct schedule_entry *)mi);
 =

-        ifconfig_pool_release(m->ifconfig_pool, mi->vaddr_handle, false);=

+        ifconfig_pool_release(mi->vaddr_pool ? mi->vaddr_pool : m->ifconf=
ig_pool, mi->vaddr_handle,
+                              false);
 
       =
  if (mi->did_iroutes)
         {
@@ -707,6 +730,14 @@
         schedule_fr=
ee(m->schedule);
         mbuf_free(m->mbuf);
         ifconfig_pool_free(m=
->ifconfig_pool);
+        while (m->subnet_pools)
+        {
+            =
struct subnet_pool *sp =3D m->subnet_pools;
+
+            m->subnet_pools =
=3D sp->next;
+            ifconfig_pool_free(sp->pool);
+            free(=
sp);
+        }
         frequency_limit_free(m->new_connection_limiter);
 =
        initial_rate_limit_free(m->initial_rate_limiter);
         multi_re=
ap_free(m->reaper);
@@ -1405,6 +1436,12 @@
     const struct options *o =3D=
 &c->options;
     if (o->push_ifconfig_constraint_defined && c->c2=2Epush_=
ifconfig_defined)
     {
+        /* a subnet-pool client is validated agai=
nst its own subnet */
+        if (o->subnet_pool_defined)
+        {
+    =
        return (o->subnet_pool_netmask & c->c2=2Epush_ifconfig_local)
+    =
               =3D=3D o->subnet_pool_network;
+        }
         return (o=
->push_ifconfig_constraint_netmask & c->c2=2Epush_ifconfig_local)
         =
       =3D=3D o->push_ifconfig_constraint_network;
     }
@@ -1415,6 +1452,=
37 @@
 }
 
 /*
+ * Return the dynamic pool serving the clients tagged with =
<tag>, creating it
+ * on first use from the matching --subnet-pool definit=
ion in <o>=2E
+ */
+static struct ifconfig_pool *
+multi_get_group_pool(str=
uct multi_context *m, const struct options *o, const char *tag)
+{
+    str=
uct subnet_pool *sp;
+
+    for (sp =3D m->subnet_pools; sp; sp =3D sp->nex=
t)
+    {
+        if (!strcmp(sp->tag, tag))
+        {
+            retur=
n sp->pool;
+        }
+    }
+
+    const struct subnet_pool_def *d4 =3D s=
ubnet_pool_by_tag(o->subnet_pools, tag);
+    ASSERT(d4);
+    ALLOC_OBJ_CL=
EAR(sp, struct subnet_pool);
+    sp->tag =3D d4->tag;
+    /* every host a=
ddress of the subnet, minus the gateway reserved below */
+    sp->pool =3D=
 ifconfig_pool_init(true, IFCONFIG_POOL_INDIV, d4->network + 1,
+          =
                        (d4->network | ~d4->netmask) - 1, o->duplicate_cn, =
false,
+                                  in6addr_any, 0);
+    ifconfig_po=
ol_reserve_ip(sp->pool, d4->gateway);
+    sp->next =3D m->subnet_pools;
+ =
   m->subnet_pools =3D sp;
+    return sp->pool;
+}
+
+/*
  * Select a virt=
ual address for a new client instance=2E
  * Use an --ifconfig-push directi=
ve, if given (static IP)=2E
  * Otherwise use an --ifconfig-pool address (d=
ynamic IP)=2E
@@ -1424,6 +1492,25 @@
 {
     struct gc_arena gc =3D gc_new(=
);
 
+    /* resolve --subnet-pool-tag against the main-config --subnet-poo=
l list (an
+     * unknown tag is rejected with AUTH_FAILED in multi_connec=
tion_established)=2E
+     * This runs again after every client-connect han=
dler, and a later handler
+     * (script, plugin, management) may override=
 the tag set by the CCD file,
+     * so always resolve the current tag=2E =
*/
+    if (mi->context=2Eoptions=2Esubnet_pool_tag)
+    {
+        const =
struct subnet_pool_def *d =3D
+            subnet_pool_by_tag(m->top=2Eopti=
ons=2Esubnet_pools, mi->context=2Eoptions=2Esubnet_pool_tag);
+
+        mi=
->context=2Eoptions=2Esubnet_pool_defined =3D d !=3D NULL;
+        if (d)
=
+        {
+            mi->context=2Eoptions=2Esubnet_pool_network =3D d->=
network;
+            mi->context=2Eoptions=2Esubnet_pool_netmask =3D d->ne=
tmask;
+            mi->context=2Eoptions=2Esubnet_pool_gateway =3D d->gate=
way;
+        }
+    }
+
     /*
      * If ifconfig addresses were set by =
dynamic config file,
      * release pool addresses, otherwise keep them=2E=

@@ -1434,8 +1521,10 @@
          * release dynamic allocation */
         =
if (mi->vaddr_handle >=3D 0)
         {
-            ifconfig_pool_release(=
m->ifconfig_pool, mi->vaddr_handle, true);
+            ifconfig_pool_relea=
se(mi->vaddr_pool ? mi->vaddr_pool : m->ifconfig_pool,
+                   =
               mi->vaddr_handle, true);
             mi->vaddr_handle =3D -=
1;
+            mi->vaddr_pool =3D NULL;
         }
 
         mi->context=
=2Ec2=2Epush_ifconfig_defined =3D true;
@@ -1455,6 +1544,52 @@
            =
     "MULTI_sva: WARNING: if --ifconfig-push is used for IPv4, automatic IP=
v6 assignment from --ifconfig-ipv6-pool does not work=2E  Use --ifconfig-ip=
v6-push for IPv6 then=2E");
         }
     }
+    else if (mi->context=2Eo=
ptions=2Esubnet_pool_defined)
+    {
+        /* dynamic address from this =
client's --subnet-pool group */
+        struct ifconfig_pool *group =3D
+ =
           multi_get_group_pool(m, &m->top=2Eoptions, mi->context=2Eoptions=
=2Esubnet_pool_tag);
+
+        /* the address may have been acquired befor=
e the tag was known (from
+         * the global pool) or for a tag that a =
later handler overrode: drop
+         * it so we serve this client from it=
s current group */
+        if (mi->vaddr_handle >=3D 0 && mi->vaddr_pool !=
=3D group)
+        {
+            ifconfig_pool_release(mi->vaddr_pool ? m=
i->vaddr_pool : m->ifconfig_pool,
+                                  mi->va=
ddr_handle, true);
+            mi->vaddr_handle =3D -1;
+            mi->v=
addr_pool =3D NULL;
+            /* both addresses of the dropped slot go b=
ack to its pool */
+            mi->context=2Ec2=2Epush_ifconfig_defined =
=3D false;
+            mi->context=2Ec2=2Epush_ifconfig_ipv6_defined =3D f=
alse;
+        }
+
+        if (mi->vaddr_handle < 0)
+        {
+         =
   in_addr_t local =3D 0, remote =3D 0;
+            const char *cn =3D NUL=
L;
+
+            if (!mi->context=2Eoptions=2Eduplicate_cn)
+            {=

+                cn =3D tls_common_name(mi->context=2Ec2=2Etls_multi, true=
);
+            }
+
+            mi->vaddr_pool =3D group;
+            mi-=
>vaddr_handle =3D ifconfig_pool_acquire(mi->vaddr_pool, &local, &remote, NU=
LL, cn);
+            if (mi->vaddr_handle >=3D 0)
+            {
+        =
        mi->context=2Ec2=2Epush_ifconfig_local =3D remote;
+               =
 mi->context=2Ec2=2Epush_ifconfig_remote_netmask =3D
+                    m=
i->context=2Eoptions=2Esubnet_pool_netmask;
+                mi->context=2E=
c2=2Epush_ifconfig_defined =3D true;
+            }
+            else
+    =
        {
+                msg(D_MULTI_ERRORS, "MULTI: no free --subnet-poo=
l addresses are available for %s",
+                    multi_instance_stri=
ng(mi, false, &gc));
+            }
+        }
+    }
     else if (m->ifco=
nfig_pool && mi->vaddr_handle < 0) /* otherwise, choose a pool address */
 =
    {
         in_addr_t local =3D 0, remote =3D 0;
@@ -2360,10 +2495,9 @@
=
         const char *ifconfig_constraint_netmask =3D
             print_in_=
addr_t(mi->context=2Eoptions=2Epush_ifconfig_constraint_netmask, 0, &gc);
 =

-        /* JYFIXME -- this should cause the connection to fail */
       =
  msg(D_MULTI_ERRORS,
-            "MULTI ERROR: primary virtual IP for %s =
(%s) "
-            "violates tunnel network/netmask constraint (%s/%s)",
+=
            "WARNING: primary virtual IP for %s (%s) "
+            "violat=
es tunnel network/netmask constraint (%s/%s) and may not work",
           =
  multi_instance_string(mi, false, &gc),
             print_in_addr_t(mi->c=
ontext=2Ec2=2Epush_ifconfig_local, 0, &gc),
             ifconfig_constrain=
t_network, ifconfig_constraint_netmask);
@@ -2471,6 +2605,7 @@
 
     /* re=
set pool handle to null */
     mi->vaddr_handle =3D -1;
+    mi->vaddr_poo=
l =3D NULL;
 
     /* do --client-connect setenvs */
     multi_select_virt=
ual_addr(m, mi);
@@ -2792,6 +2927,15 @@
         cc_succeeded =3D false;
  =
   }
 
+    if (mi->context=2Eoptions=2Esubnet_pool_tag
+        && !subnet=
_pool_by_tag(m->top=2Eoptions=2Esubnet_pools, mi->context=2Eoptions=2Esubne=
t_pool_tag))
+    {
+        msg(D_MULTI_ERRORS, "MULTI: client has been re=
jected due to unknown --subnet-pool-tag '%s'",
+            mi->context=2Eo=
ptions=2Esubnet_pool_tag);
+        auth_set_client_reason(mi->context=2Ec2=
=2Etls_multi, "unknown subnet-pool-tag");
+        cc_succeeded =3D false;
=
+    }
+
     if (cc_succeeded)
     {
         multi_client_connect_late_s=
etup(m, mi, *option_types_found);
diff --git a/src/openvpn/multi=2Eh b/src/=
openvpn/multi=2Eh
index 5db7147=2E=2E14f71dd 100644
--- a/src/openvpn/multi=
=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -121,6 +121,8 @@
     struct mroute_add=
r real; /**< External network address of the
                              =
 *   remote peer=2E */
     ifconfig_pool_handle vaddr_handle;
+    /* pool=
 vaddr_handle belongs to (NULL =3D the global one) */
+    struct ifconfig_=
pool *vaddr_pool;
     char msg_prefix[MULTI_PREFIX_MAX_LENGTH];
 
     /* =
queued outgoing data in Server/TCP mode */
@@ -190,6 +192,8 @@
            =
                             *   instances=2E */
     struct multi_io *mult=
i_io;         /**< I/O state and events tracker */
     struct ifconfig_poo=
l *ifconfig_pool;
+    /* per-group --subnet-pool dynamic pools */
+    str=
uct subnet_pool *subnet_pools;
     struct frequency_limit *new_connection_=
limiter;
     struct initial_packet_rate_limit *initial_rate_limiter;
     =
struct mroute_helper *route_helper;
diff --git a/src/openvpn/options=2Ec b/=
src/openvpn/options=2Ec
index 7fc8614=2E=2Ed5666b8 100644
--- a/src/openvpn=
/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -452,6 +452,11 @@
     "     =
             If seconds=3D0, file will be treated as read-only=2E\n"
     "=
--ifconfig-ipv6-pool base-IP/bits : set aside an IPv6 network block\n"
    =
 "                  to be dynamically allocated to connecting clients=2E\n"=

+    "--subnet-pool tag network netmask [gateway] : Define a named pool of=
\n"
+    "                  addresses outside the --server network, selecte=
d per\n"
+    "                  client with --subnet-pool-tag=2E\n"
+    "=
--subnet-pool-tag tag : Assign this client to the --subnet-pool named tag=
=2E\n"
+    "                  Only valid in a client-specific config file=
=2E\n"
     "--ifconfig-push local remote-netmask : Push an ifconfig option=
 to remote,\n"
     "                  overrides --ifconfig-pool dynamic al=
location=2E\n"
     "                  Only valid in a client-specific conf=
ig file=2E\n"
@@ -1925,6 +1930,20 @@
         {
             msg(M_USAGE, "=
--ifconfig-ipv6-pool needs --ifconfig-ipv6");
         }
+        if (optio=
ns->subnet_pools)
+        {
+            if (!options->server_defined)
+  =
          {
+                msg(M_USAGE, "--subnet-pool requires --server"=
);
+            }
+            if (dev_type_enum(options->dev, options->dev=
_type) !=3D DEV_TYPE_TUN
+                || options->topology !=3D TOP_SUB=
NET)
+            {
+                msg(M_USAGE, "--subnet-pool requires -=
-dev tun and --topology subnet");
+            }
+            subnet_pools_=
check(options->subnet_pools, options->server_network,
+                    =
           options->server_netmask, M_USAGE);
+        }
         MUST_BE_U=
NDEF(allow_recursive_routing, "allow-recursive-routing");
         if (opti=
ons->auth_user_pass_file)
         {
@@ -1991,6 +2010,7 @@
         MUST_BE=
_UNDEF(ifconfig_pool_defined, "ifconfig-pool");
         MUST_BE_UNDEF(ifco=
nfig_pool_persist_filename, "ifconfig-pool-persist");
         MUST_BE_UNDE=
F(ifconfig_ipv6_pool_defined, "ifconfig-ipv6-pool");
+        MUST_BE_UNDEF=
(subnet_pools, "subnet-pool");
         MUST_BE_UNDEF(real_hash_size, "hash=
-size");
         MUST_BE_UNDEF(virtual_hash_size, "hash-size");
         M=
UST_BE_UNDEF(learn_address_script, "learn-address");
@@ -3123,6 +3143,28 @@=

     }
 }
 
+/*
+ * The server's tun device is only configured with the --=
server network, so
+ * route each --subnet-pool network into it as well: wi=
thout this the server
+ * could not reach its subnet-pool clients when the =
data channel runs in
+ * userspace=2E  Under DCO on Linux and FreeBSD the r=
outes are installed on-link,
+ * see subnet_pool_routes_onlink()=2E
+ */
+s=
tatic void
+options_postprocess_subnet_pool_routes(struct options *o)
+{
+ =
   for (const struct subnet_pool_def *d =3D o->subnet_pools; d; d =3D d->ne=
xt)
+    {
+        struct route_option *ro;
+
+        rol_check_alloc(o);=

+        ro =3D add_route_to_option_list(o->routes, print_in_addr_t(d->net=
work, 0, &o->gc),
+                                      print_in_addr_t(d-=
>netmask, 0, &o->gc), NULL, NULL,
+                                      o-=
>route_default_table_id);
+        ro->on_link =3D subnet_pool_routes_onlin=
k(o);
+    }
+}
+
 static void
 options_postprocess_mutate(struct options *=
o, struct env_set *es)
 {
@@ -3258,6 +3300,12 @@
         /* check if any o=
ption should force disabling DCO */
         o->disable_dco =3D !dco_check_=
option(D_DCO, o) || !dco_check_startup_option(D_DCO, o);
     }
+
+    if (=
o->mode =3D=3D MODE_SERVER)
+    {
+        /* how the pools are routed dep=
ends on the DCO decision above */
+        options_postprocess_subnet_pool_=
routes(o);
+    }
 #ifdef USE_COMP
     if (dco_enabled(o))
     {
@@ -6245=
,6 +6293,43 @@
             goto err;
         }
     }
+    else if (streq=
(p[0], "subnet-pool") && p[1] && p[2] && p[3] && !p[5])
+    {
+        str=
uct subnet_pool_def *sp;
+        in_addr_t network, netmask;
+
+        VE=
RIFY_PERMISSION(OPT_P_GENERAL);
+        network =3D getaddr(GETADDR_HOST_O=
RDER | GETADDR_RESOLVE, p[2], 0, NULL, NULL);
+        netmask =3D getaddr(=
GETADDR_HOST_ORDER, p[3], 0, NULL, NULL);
+        if (!network || !netmask=
)
+        {
+            msg(msglevel, "cannot parse --subnet-pool address=
es");
+            goto err;
+        }
+        ALLOC_OBJ_GC(sp, struct su=
bnet_pool_def, &options->gc);
+        sp->tag =3D p[1];
+        sp->netwo=
rk =3D network & netmask;
+        sp->netmask =3D netmask;
+        sp->ga=
teway =3D (network & netmask) + 1;
+        if (p[4])
+        {
+         =
   bool ok =3D false;
+
+            sp->gateway =3D getaddr(GETADDR_HOST_O=
RDER | GETADDR_RESOLVE, p[4], 0, &ok, NULL);
+            if (!ok)
+       =
     {
+                msg(msglevel, "cannot parse --subnet-pool gateway")=
;
+                goto err;
+            }
+        }
+        sp->next =
=3D options->subnet_pools;
+        options->subnet_pools =3D sp;
+    }
+ =
   else if (streq(p[0], "subnet-pool-tag") && p[1] && !p[2])
+    {
+      =
  VERIFY_PERMISSION(OPT_P_INSTANCE);
+        options->subnet_pool_tag =3D =
p[1];
+    }
     else if (streq(p[0], "ifconfig-push-constraint") && p[1] =
&& p[2] && !p[3])
     {
         in_addr_t network, netmask;
diff --git a/=
src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index d347830=2E=2Eff2606=
6 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -25=
2,6 +252,17 @@
     struct verify_hash_list *next;
 };
 
+/* A named --subn=
et-pool: a subnet clients can be assigned from, referenced
+ * from a CCD f=
ile by its tag via --subnet-pool-tag=2E */
+struct subnet_pool_def
+{
+    =
struct subnet_pool_def *next;
+    const char *tag;
+    in_addr_t network;=

+    in_addr_t netmask;
+    in_addr_t gateway;
+};
+
 /* Command line opt=
ions */
 struct options
 {
@@ -518,6 +529,12 @@
     bool push_ifconfig_con=
straint_defined;
     in_addr_t push_ifconfig_constraint_network;
     in_a=
ddr_t push_ifconfig_constraint_netmask;
+    struct subnet_pool_def *subnet=
_pools; /* named pools (server config) */
+    const char *subnet_pool_tag;=
          /* which pool this client uses (CCD) */
+    bool subnet_pool_def=
ined;             /* resolved from the tag at connect */
+    in_addr_t sub=
net_pool_network;
+    in_addr_t subnet_pool_netmask;
+    in_addr_t subnet=
_pool_gateway;
     bool push_ifconfig_ipv4_blocked;           /* IPv4 */
 =
    bool push_ifconfig_ipv6_defined;           /* IPv6 */
     struct in6_a=
ddr push_ifconfig_ipv6_local;  /* IPv6 */
@@ -978,4 +995,23 @@
 #endif /* E=
NABLE_DCO */
 }
 
+/**
+ * Whether the routes of the --subnet-pool networks=
 are installed on-link on
+ * the DCO device rather than via a gateway=2E  =
With DCO on Linux and FreeBSD the
+ * kernel selects the peer by a route's =
next hop, so a route via a gateway
+ * would deliver every packet for an un=
assigned pool address to the client
+ * owning that gateway address; on-lin=
k, such a packet matches no peer, while
+ * each pool client gets its own o=
n-link host route when it connects (see
+ * multi_learn_in_addr_t())=2E
+ *=
/
+static inline bool
+subnet_pool_routes_onlink(const struct options *o)
+=
{
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+    return dco_ena=
bled(o);
+#else
+    return false;
+#endif
+}
+
 #endif /* ifndef OPTIONS_H=
 */
diff --git a/src/openvpn/options_util=2Ec b/src/openvpn/options_util=2E=
c
index d25d85c=2E=2E744ad4c 100644
--- a/src/openvpn/options_util=2Ec
+++ =
b/src/openvpn/options_util=2Ec
@@ -30,6 +30,91 @@
 #include "options_util=
=2Eh"
 
 #include "push=2Eh"
+#include "pool=2Eh"
+
+const struct subnet_po=
ol_def *
+subnet_pool_by_tag(const struct subnet_pool_def *pools, const cha=
r *tag)
+{
+    for (const struct subnet_pool_def *d =3D pools; d; d =3D d-=
>next)
+    {
+        if (!strcmp(d->tag, tag))
+        {
+            re=
turn d;
+        }
+    }
+    return NULL;
+}
+
+/* true if the two IPv4 s=
ubnets share at least one address */
+static bool
+subnets_overlap(in_addr_=
t a, in_addr_t mask_a, in_addr_t b, in_addr_t mask_b)
+{
+    const in_addr=
_t mask =3D mask_a & mask_b;
+
+    return (a & mask) =3D=3D (b & mask);
+}=

+
+bool
+subnet_pools_check(const struct subnet_pool_def *pools, in_addr_t=
 server_network,
+                   in_addr_t server_netmask, msglvl_t msg=
level)
+{
+    for (const struct subnet_pool_def *d =3D pools; d; d =3D d->=
next)
+    {
+        const in_addr_t host =3D ~d->netmask;
+        int ne=
tbits =3D 32;
+
+        /* the netmask must be contiguous */
+        if (=
host & (host + 1))
+        {
+            msg(msglevel, "--subnet-pool %s:=
 invalid netmask", d->tag);
+            return false;
+        }
+        =
for (in_addr_t h =3D host; h; h >>=3D 1)
+        {
+            netbits--;=

+        }
+
+        /* same bounds as --server: the pool must hold at le=
ast 2 addresses
+         * besides network, gateway and broadcast, and fit=
 IFCONFIG_POOL_MAX */
+        if (netbits < IFCONFIG_POOL_MIN_NETBITS || n=
etbits > 29)
+        {
+            msg(msglevel, "--subnet-pool %s: netma=
sk must be between /%d and /29 (not /%d)",
+                d->tag, IFCONFI=
G_POOL_MIN_NETBITS, netbits);
+            return false;
+        }
+
+    =
    if ((d->gateway & d->netmask) !=3D d->network || d->gateway =3D=3D d->n=
etwork
+            || d->gateway =3D=3D (d->network | host))
+        {
+ =
           msg(msglevel, "--subnet-pool %s: gateway must be a host address =
inside the subnet",
+                d->tag);
+            return false;
+ =
       }
+
+        if (server_netmask
+            && subnets_overlap(d->n=
etwork, d->netmask, server_network, server_netmask))
+        {
+          =
  msg(msglevel, "--subnet-pool %s: subnet overlaps the --server network", d=
->tag);
+            return false;
+        }
+
+        for (const struct =
subnet_pool_def *e =3D d->next; e; e =3D e->next)
+        {
+            i=
f (!strcmp(d->tag, e->tag))
+            {
+                msg(msglevel, "=
--subnet-pool %s: tag defined more than once", d->tag);
+                re=
turn false;
+            }
+            if (subnets_overlap(d->network, d->=
netmask, e->network, e->netmask))
+            {
+                msg(msgle=
vel, "--subnet-pool %s and %s: subnets overlap", d->tag, e->tag);
+        =
        return false;
+            }
+        }
+    }
+
+    return true;
=
+}
 
 const char *
 parse_auth_failed_temp(struct options *o, const char *r=
eason)
diff --git a/src/openvpn/options_util=2Eh b/src/openvpn/options_util=
=2Eh
index 5226a6f=2E=2Ed60759a 100644
--- a/src/openvpn/options_util=2Eh
+=
++ b/src/openvpn/options_util=2Eh
@@ -28,6 +28,31 @@
 
 const char *parse_a=
uth_failed_temp(struct options *o, const char *reason);
 
+/**
+ * Look up =
a named --subnet-pool in a list of pool definitions=2E
+ *
+ * @param pools=
  head of the --subnet-pool list (may be NULL)
+ * @param tag    the --subn=
et-pool-tag to match
+ * @return       the matching pool definition, or NUL=
L if none matches
+ */
+const struct subnet_pool_def *subnet_pool_by_tag(co=
nst struct subnet_pool_def *pools,
+                                       =
          const char *tag);
+
+/**
+ * Validate the --subnet-pool definitio=
ns: contiguous netmask between
+ * /IFCONFIG_POOL_MIN_NETBITS and /29, gate=
way a host address inside its
+ * subnet, unique tags, and no subnet overla=
pping another pool or the --server
+ * network=2E
+ *
+ * @param pools     =
      head of the --subnet-pool list (may be NULL)
+ * @param server_networ=
k  the --server network (host order)
+ * @param server_netmask  the --serve=
r netmask, or 0 if there is none
+ * @param msglevel        level of the me=
ssage logged on the first error
+ * @return                true if every de=
finition is valid
+ */
+bool subnet_pools_check(const struct subnet_pool_de=
f *pools, in_addr_t server_network,
+                        in_addr_t serv=
er_netmask, msglvl_t msglevel);
+
 
 /** Checks if the string is a valid in=
teger by checking if it can be
  *  converted to an integer */
diff --git a=
/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec
index 63fc930=2E=2Efa04d9c 100=
644
--- a/src/openvpn/pool=2Ec
+++ b/src/openvpn/pool=2Ec
@@ -350,7 +350,7 =
@@
 {
     bool ret =3D false;
 
-    if (pool && hand >=3D 0 && hand < poo=
l->size)
+    if (pool && hand >=3D 0 && hand < pool->size && !pool->list[h=
and]=2Ereserved)
     {
         ifconfig_pool_entry_free(&pool->list[hand]=
, hard);
         ret =3D true;
@@ -429,6 +429,22 @@
     return ret;
 }
 
=
+bool
+ifconfig_pool_reserve_ip(struct ifconfig_pool *pool, const in_addr_t=
 addr)
+{
+    const ifconfig_pool_handle h =3D ifconfig_pool_ip_base_to_ha=
ndle(pool, addr);
+
+    if (h < 0)
+    {
+        return false;
+    }
+
=
+    ifconfig_pool_entry_free(&pool->list[h], true);
+    pool->list[h]=2Ei=
n_use =3D true;
+    pool->list[h]=2Ereserved =3D true;
+    return true;
+=
}
+
 static in_addr_t
 ifconfig_pool_handle_to_ip_base(const struct ifconfi=
g_pool *pool, ifconfig_pool_handle hand)
 {
@@ -476,6 +492,13 @@
          =
         const bool fixed)
 {
     struct ifconfig_pool_entry *e =3D &pool-=
>list[h];
+
+    if (e->reserved)
+    {
+        msg(M_WARN, "pool: ignori=
ng persisted entry for CN=3D%s: its address is reserved", cn);
+        ret=
urn;
+    }
+
     ifconfig_pool_entry_free(e, true);
     e->in_use =3D fa=
lse;
     e->common_name =3D string_alloc(cn, NULL);
diff --git a/src/openv=
pn/pool=2Eh b/src/openvpn/pool=2Eh
index e2d3f82=2E=2E497dcda 100644
--- a/=
src/openvpn/pool=2Eh
+++ b/src/openvpn/pool=2Eh
@@ -43,6 +43,7 @@
     char=
 *common_name;
     time_t last_release;
     bool fixed;
+    bool reserve=
d; /* never handed out, e=2Eg=2E a --subnet-pool gateway */
 };
 
 struct i=
fconfig_pool
@@ -86,6 +87,17 @@
 
 bool ifconfig_pool_release(struct ifconf=
ig_pool *pool, ifconfig_pool_handle hand, const bool hard);
 
+/**
+ * Perm=
anently reserve the pool slot holding \c addr, so that it is never
+ * hand=
ed out to a client nor taken over by a persisted entry (e=2Eg=2E the
+ * ga=
teway of a --subnet-pool)=2E
+ *
+ * @param pool  the pool
+ * @param addr =
 IPv4 address (host order) to reserve
+ * @return      true if \c addr lies=
 in the pool and was reserved
+ */
+bool ifconfig_pool_reserve_ip(struct if=
config_pool *pool, in_addr_t addr);
+
 struct ifconfig_pool_persist *ifconf=
ig_pool_persist_init(const char *filename, int refresh_freq);
 
 void ifcon=
fig_pool_persist_close(struct ifconfig_pool_persist *persist);
diff --git a=
/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 9c80f3b=2E=2Ee1b3849 1=
00644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -407,6 +40=
7,11 @@
         r->flags |=3D RT_METRIC_DEFINED;
     }
 
+    if (ro->on_=
link)
+    {
+        r->flags |=3D RT_ON_LINK;
+    }
+
     r->flags |=3D=
 RT_DEFINED;
 
     /* routing table id */
@@ -477,7 +482,7 @@
     return =
false;
 }
 
-void
+struct route_option *
 add_route_to_option_list(struct r=
oute_option_list *l, const char *network, const char *netmask,
            =
              const char *gateway, const char *metric, int table_id)
 {
@@ =
-488,8 +493,10 @@
     ro->gateway =3D gateway;
     ro->metric =3D metric;=

     ro->table_id =3D table_id;
+    ro->on_link =3D false;
     ro->next =
=3D l->routes;
     l->routes =3D ro;
+    return ro;
 }
 
 void
@@ -1321,7=
 +1328,11 @@
     {
         setenv_route_addr(es, "network", r->network, i=
);
         setenv_route_addr(es, "netmask", r->netmask, i);
-        seten=
v_route_addr(es, "gateway", r->gateway, i);
+        /* an on-link route ha=
s no gateway */
+        if (!(r->flags & RT_ON_LINK))
+        {
+        =
    setenv_route_addr(es, "gateway", r->gateway, i);
+        }
 
         =
if (r->flags & RT_METRIC_DEFINED)
         {
@@ -1477,6 +1488,7 @@
 
 #if d=
efined(TARGET_LINUX)
     const char *iface =3D NULL;
+    const in_addr_t =
*gateway =3D &r->gateway;
     int metric =3D -1;
 
     if (is_on_link(is_=
local_route, flags, rgi))
@@ -1484,6 +1496,12 @@
         iface =3D rgi->if=
ace;
     }
 
+    if ((r->flags & RT_ON_LINK) && tt)
+    {
+        gatew=
ay =3D NULL;
+        iface =3D tt->actual_name;
+    }
+
     if (r->flags=
 & RT_METRIC_DEFINED)
     {
         metric =3D r->metric;
@@ -1491,8 +150=
9,8 @@
 
 
     status =3D RTA_SUCCESS;
-    int ret =3D net_route_v4_add(c=
tx, &r->network, netmask_to_netbits2(r->netmask), &r->gateway,
-           =
                    iface, r->table_id, metric);
+    int ret =3D net_route=
_v4_add(ctx, &r->network, netmask_to_netbits2(r->netmask), gateway, iface,
=
+                               r->table_id, metric);
     if (ret =3D=3D -=
EEXIST)
     {
         msg(D_ROUTE, "NOTE: Linux route add command failed =
because route exists");
@@ -1615,7 +1633,15 @@
     }
 #endif
 
-    argv_p=
rintf_cat(&argv, "-net %s %s %s", network, gateway, netmask);
+    if ((r->=
flags & RT_ON_LINK) && tt)
+    {
+        argv_printf_cat(&argv, "-net %s/=
%d -iface %s", network, netmask_to_netbits2(r->netmask),
+                 =
       tt->actual_name);
+    }
+    else
+    {
+        argv_printf_cat(&=
argv, "-net %s %s %s", network, gateway, netmask);
+    }
 
     /* FIXME -=
- add on-link support for FreeBSD */
 
@@ -2034,7 +2060,16 @@
         metr=
ic =3D r->metric;
     }
 
-    if (net_route_v4_del(ctx, &r->network, netm=
ask_to_netbits2(r->netmask), &r->gateway, NULL,
+    const in_addr_t *gatew=
ay =3D &r->gateway;
+    const char *iface =3D NULL;
+
+    if ((r->flags &=
 RT_ON_LINK) && tt)
+    {
+        gateway =3D NULL;
+        iface =3D tt=
->actual_name;
+    }
+
+    if (net_route_v4_del(ctx, &r->network, netmask=
_to_netbits2(r->netmask), gateway, iface,
                          r->tabl=
e_id, metric)
         < 0)
     {
@@ -2090,7 +2125,15 @@
 
 #elif defined(=
TARGET_FREEBSD)
 
-    argv_printf(&argv, "%s delete -net %s %s %s", ROUTE_=
PATH, network, gateway, netmask);
+    if ((r->flags & RT_ON_LINK) && tt)
+=
    {
+        argv_printf(&argv, "%s delete -net %s/%d -iface %s", ROUTE_P=
ATH, network,
+                    netmask_to_netbits2(r->netmask), tt->act=
ual_name);
+    }
+    else
+    {
+        argv_printf(&argv, "%s delete -=
net %s %s %s", ROUTE_PATH, network, gateway, netmask);
+    }
 
     argv_m=
sg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, es, 0, "ERROR: FreeBSD=
 route delete command failed");
diff --git a/src/openvpn/route=2Eh b/src/op=
envpn/route=2Eh
index 0d33d36=2E=2E7c5528f 100644
--- a/src/openvpn/route=
=2Eh
+++ b/src/openvpn/route=2Eh
@@ -80,6 +80,10 @@
     const char *gatewa=
y;
     int table_id;
     const char *metric;
+    /* on Linux and FreeBSD=
, install the route on-link on the tun device
+     * instead of via the ga=
teway (needed under DCO, where the kernel selects
+     * the peer by the r=
oute's next hop) */
+    bool on_link;
 };
 
 /* redirect-gateway flags */
=
@@ -120,6 +124,7 @@
 #define RT_DEFINED        (1u << 0)
 #define RT_ADDED =
         (1u << 1)
 #define RT_METRIC_DEFINED (1u << 2)
+#define RT_ON_LINK=
        (1u << 3) /* see struct route_option=2Eon_link */
     struct route=
_ipv4 *next;
     unsigned int flags;
     const struct route_option *optio=
n;
@@ -311,8 +316,9 @@
                const struct route_gateway_info *rgi=
, const struct env_set *es,
                openvpn_net_ctx_t *ctx);
 
-voi=
d add_route_to_option_list(struct route_option_list *l, const char *network=
, const char *netmask,
-                              const char *gateway, =
const char *metric, int table_id);
+struct route_option *add_route_to_optio=
n_list(struct route_option_list *l, const char *network,
+                 =
                             const char *netmask, const char *gateway,
+   =
                                           const char *metric, int table_id=
);
 
 void add_route_ipv6_to_option_list(struct route_ipv6_option_list *l, =
const char *prefix,
                                    const char *gateway=
, const char *metric, int table_id);
diff --git a/tests/unit_tests/openvpn/=
Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 38299f5=2E=2E7=
8f4b6c 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit=
_tests/openvpn/Makefile=2Eam
@@ -21,6 +21,7 @@
 	push_update_msg_testdriver=
 \
 	socket_testdriver \
 	ssl_testdriver \
+	subnet_pool_testdriver \
 	us=
er_pass_testdriver
 
 if HAVE_LD_WRAP_SUPPORT
@@ -384,6 +385,19 @@
 	$(top_=
srcdir)/src/openvpn/platform=2Ec \
 	$(top_srcdir)/src/openvpn/mbuf=2Ec
 
+=
subnet_pool_testdriver_CFLAGS  =3D \
+	-I$(top_srcdir)/include -I$(top_srcd=
ir)/src/compat -I$(top_srcdir)/src/openvpn \
+	@TEST_CFLAGS@
+
+subnet_pool=
_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
+
+subnet_pool_testdriver_SOURCES =
=3D test_subnet_pool=2Ec \
+	mock_msg=2Ec test_common=2Eh \
+	mock_get_rand=
om=2Ec \
+	$(top_srcdir)/src/openvpn/buffer=2Ec \
+	$(top_srcdir)/src/openv=
pn/options_util=2Ec \
+	$(top_srcdir)/src/openvpn/platform=2Ec
+
 misc_test=
driver_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -=
I$(top_srcdir)/src/openvpn \
 	-DSOURCEDIR=3D\"$(top_srcdir)\" @TEST_CFLAGS=
@
diff --git a/tests/unit_tests/openvpn/test_subnet_pool=2Ec b/tests/unit_t=
ests/openvpn/test_subnet_pool=2Ec
new file mode 100644
index 0000000=2E=2E1=
bb9e4c
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_subnet_pool=2Ec
@@=
 -0,0 +1,146 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP ne=
tworks
+ *             over a single UDP port, with support for SSL/TLS-bas=
ed
+ *             session authentication and key exchange,
+ *            =
 packet encryption, packet authentication, and
+ *             packet compr=
ession=2E
+ *
+ *  Copyright (C) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *=

+ *  This program is free software; you can redistribute it and/or modify
=
+ *  it under the terms of the GNU General Public License version 2
+ *  as=
 published by the Free Software Foundation=2E
+ *
+ *  This program is dist=
ributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; =
without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A =
PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more det=
ails=2E
+ *
+ *  You should have received a copy of the GNU General Public =
License along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/=
licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+=

+#include "syshead=2Eh"
+
+#include <stdlib=2Eh>
+#include <setjmp=2Eh>
+#=
include <cmocka=2Eh>
+
+#include "options=2Eh"
+#include "options_util=2Eh"=

+#include "test_common=2Eh"
+#include "mock_msg=2Eh"
+
+/* --subnet-pool-t=
ag resolves a client to its --subnet-pool; an unknown tag
+ * returns NULL,=
 which is what makes the server reject that client=2E */
+static void
+test=
_subnet_pool_by_tag(void **state)
+{
+    struct subnet_pool_def c =3D { =
=2Enext =3D NULL, =2Etag =3D "grpC", =2Enetwork =3D 0x0a020300, =2Enetmask =
=3D 0xffffff00, =2Egateway =3D 0x0a020301 };
+    struct subnet_pool_def b =
=3D { =2Enext =3D &c, =2Etag =3D "grpB", =2Enetwork =3D 0x0a020200, =2Enetm=
ask =3D 0xffffff00, =2Egateway =3D 0x0a020201 };
+    struct subnet_pool_de=
f a =3D { =2Enext =3D &b, =2Etag =3D "grpA", =2Enetwork =3D 0x0a020100, =2E=
netmask =3D 0xffffff00, =2Egateway =3D 0x0a020101 };
+
+    /* every config=
ured tag resolves to its own pool, wherever it sits */
+    assert_ptr_equa=
l(subnet_pool_by_tag(&a, "grpA"), &a);
+    assert_ptr_equal(subnet_pool_by=
_tag(&a, "grpB"), &b);
+    assert_ptr_equal(subnet_pool_by_tag(&a, "grpC")=
, &c);
+
+    /* and it carries that pool's subnet/gateway */
+    const st=
ruct subnet_pool_def *r =3D subnet_pool_by_tag(&a, "grpB");
+    assert_int=
_equal(r->network, 0x0a020200);
+    assert_int_equal(r->netmask, 0xffffff0=
0);
+    assert_int_equal(r->gateway, 0x0a020201);
+
+    /* unknown tag an=
d empty list both miss */
+    assert_null(subnet_pool_by_tag(&a, "nope"));=

+    assert_null(subnet_pool_by_tag(NULL, "grpA"));
+}
+
+/* a single pool=
 <net>/<mask> with gateway <gw>, checked against the
+ * 10=2E8=2E0=2E0/24 =
--server network */
+static bool
+check_one(in_addr_t net, in_addr_t mask, =
in_addr_t gw)
+{
+    struct subnet_pool_def d =3D { =2Enext =3D NULL, =2Et=
ag =3D "grp", =2Enetwork =3D net, =2Enetmask =3D mask, =2Egateway =3D gw };=

+
+    return subnet_pools_check(&d, 0x0a080000, 0xffffff00, M_WARN);
+}
+=

+/* --subnet-pool geometry: anything ifconfig_pool_init() cannot serve mus=
t be
+ * refused when the config is checked, not when the first client conn=
ects */
+static void
+test_subnet_pools_check_netmask(void **state)
+{
+   =
 /* the bounds of --server: /16 =2E=2E /29 */
+    assert_true(check_one(0x=
0a090000, 0xffff0000, 0x0a090001));
+    assert_true(check_one(0x0a090000, =
0xffffff00, 0x0a090001));
+    assert_true(check_one(0x0a090000, 0xfffffff8=
, 0x0a090001));
+    /* /30, /31, /32: too few addresses for a pool */
+   =
 assert_false(check_one(0x0a090000, 0xfffffffc, 0x0a090001));
+    assert_f=
alse(check_one(0x0a090000, 0xfffffffe, 0x0a090001));
+    assert_false(chec=
k_one(0x0a090000, 0xffffffff, 0x0a090000));
+    /* /15: larger than IFCONF=
IG_POOL_MAX */
+    assert_false(check_one(0x0a080000, 0xfffe0000, 0x0a0800=
01));
+    /* non-contiguous netmask */
+    assert_false(check_one(0x0a000=
900, 0xff00ff00, 0x0a000901));
+}
+
+static void
+test_subnet_pools_check_g=
ateway(void **state)
+{
+    /* any host address of the subnet is fine, not=
 only the first one */
+    assert_true(check_one(0x0a090000, 0xffffff00, 0=
x0a0900fe));
+    assert_true(check_one(0x0a090000, 0xffffff00, 0x0a090080)=
);
+    /* network address, broadcast address, outside the subnet */
+    a=
ssert_false(check_one(0x0a090000, 0xffffff00, 0x0a090000));
+    assert_fal=
se(check_one(0x0a090000, 0xffffff00, 0x0a0900ff));
+    assert_false(check_=
one(0x0a090000, 0xffffff00, 0x0a0a0001));
+}
+
+static void
+test_subnet_po=
ols_check_overlap(void **state)
+{
+    struct subnet_pool_def b =3D { =2En=
ext =3D NULL, =2Etag =3D "grpB", =2Enetwork =3D 0x0a0a0000, =2Enetmask =3D =
0xffffff00, =2Egateway =3D 0x0a0a0001 };
+    struct subnet_pool_def a =3D =
{ =2Enext =3D &b, =2Etag =3D "grpA", =2Enetwork =3D 0x0a090000, =2Enetmask =
=3D 0xffffff00, =2Egateway =3D 0x0a090001 };
+
+    /* disjoint pools, disj=
oint from --server */
+    assert_true(subnet_pools_check(&a, 0x0a080000, 0=
xffffff00, M_WARN));
+
+    /* a pool inside the --server network =2E=2E=2E=
 */
+    assert_false(subnet_pools_check(&a, 0x0a090000, 0xffffff00, M_WARN=
));
+    /* =2E=2E=2E or covering it */
+    assert_false(subnet_pools_chec=
k(&a, 0x0a0a0080, 0xffffff80, M_WARN));
+    /* no --server network: only t=
he pools are checked against each other */
+    assert_true(subnet_pools_ch=
eck(&a, 0, 0, M_WARN));
+
+    /* grpB grown to a /16 now contains grpA */
=
+    b=2Enetwork =3D 0x0a090000;
+    b=2Enetmask =3D 0xffff0000;
+    b=2E=
gateway =3D 0x0a090101;
+    assert_false(subnet_pools_check(&a, 0, 0, M_WA=
RN));
+
+    /* the same tag defined twice */
+    b=2Enetwork =3D 0x0a0a00=
00;
+    b=2Enetmask =3D 0xffffff00;
+    b=2Egateway =3D 0x0a0a0001;
+    =
b=2Etag =3D "grpA";
+    assert_false(subnet_pools_check(&a, 0, 0, M_WARN))=
;
+}
+
+const struct CMUnitTest subnet_pool_tests[] =3D {
+    cmocka_unit_=
test(test_subnet_pool_by_tag),
+    cmocka_unit_test(test_subnet_pools_chec=
k_netmask),
+    cmocka_unit_test(test_subnet_pools_check_gateway),
+    cm=
ocka_unit_test(test_subnet_pools_check_overlap),
+};
+
+int
+main(void)
+{
=
+    openvpn_unit_test_setup();
+    return cmocka_run_group_tests(subnet_p=
ool_tests, NULL, NULL);
+}

-- 
To view, visit https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1783?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
Gerrit-Change-Number:=
 1783
Gerrit-PatchSet: 6
Gerrit-Owner: Antonio Quartulli <antonio@mandelbit=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@li=
chtenheld=2Ecom>

--fiW41LolruI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Antonio Qu=
artulli <strong>uploaded patch set #6</strong> to this change=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail">View Ch=
ange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">multi: assign clients from a named, tagged subnet=
-pool<br><br>Add two server directives:<br><br>  subnet-pool &lt;tag&gt; &l=
t;network&gt; &lt;netmask&gt; [&lt;gateway&gt;]   (main config)<br>  subnet=
-pool-tag &lt;tag&gt;                               (per-client CCD)<br><br=
>so groups of clients can be given addresses from subnets other than the<br=
>--server network (per-group firewall rules under --topology subnet, and<br=
>thus DCO)=2E A client&#39;s subnet-pool-tag is resolved to its pool and se=
rved<br>a virtual IP from that subnet: a static --ifconfig-push within it, =
or the<br>next free address from a dynamic per-group pool shared by tag=2E =
Such a<br>client is validated against its own subnet instead of the global<=
br>tunnel-network constraint and never falls back to the global pool; a tag=
<br>matching no configured pool is declined with AUTH_FAILED=2E The tag is<=
br>resolved again after every client-connect handler, so a script, plugin<b=
r>or management interface may override the one set by the CCD file=2E<br><b=
r>The pools are checked when the config is loaded, as for --server: the<br>=
netmask must be contiguous and between /16 and /29, the gateway a host<br>a=
ddress inside the subnet, tags unique, and no pool may overlap another<br>o=
r the --server network=2E Every pool is created at startup, and its<br>gate=
way is reserved so it is never handed out to a client=2E<br><br>The server =
routes each pool&#39;s subnet into its tun device, as the device<br>is only=
 configured with the --server network: without this the server<br>cannot re=
ach its subnet-pool clients=2E This is a regular --route, so it<br>is insta=
lled before privileges are dropped and honours --route-table,<br>--route-me=
tric and --route-noexec=2E Under DCO on Linux and FreeBSD,<br>though, the k=
ernel selects the peer by the route&#39;s next hop, so a route<br>via a gat=
eway would deliver every packet for an unassigned pool address<br>to the cl=
ient owning that gateway address: there the route is installed<br>on-link o=
n the tun device instead (a new on_link route option flag), and<br>each cli=
ent of the pool gets its own on-link host route on connect (as<br>its addre=
ss is outside the --ifconfig network), so such packets match<br>no peer=2E<=
br><br>Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631<br>GitHub: clos=
es openvpn/OpenVPN#987<br>Signed-off-by: Antonio Quartulli &lt;antonio@mand=
elbit=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<br>M doc/man-sections/server-o=
ptions=2Erst<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M src=
/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/options_=
util=2Ec<br>M src/openvpn/options_util=2Eh<br>M src/openvpn/pool=2Ec<br>M s=
rc/openvpn/pool=2Eh<br>M src/openvpn/route=2Ec<br>M src/openvpn/route=2Eh<b=
r>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests/unit_tests/openvpn/te=
st_subnet_pool=2Ec<br>14 files changed, 679 insertions(+), 15 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/83/1783/6</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLis=
ts=2Etxt</span><br><span>index b286ee2=2E=2E4e87a6a 100644</span><br><span>=
--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><sp=
an>@@ -694,6 +694,7 @@</span><br><span>         &quot;test_provider&quot;</=
span><br><span>         &quot;test_socket&quot;</span><br><span>         &q=
uot;test_ssl&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       &quot;test_subnet_pool&quot;</span><br><span>         &quot;test_use=
r_pass&quot;</span><br><span>         &quot;test_push_update_msg&quot;</spa=
n><br><span>         )</span><br><span>@@ -868,6 +869,11 @@</span><br><span=
>         src/openvpn/session_id=2Ec</span><br><span>     )</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    target_source=
s(test_subnet_pool PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        tests/unit_tests/openvpn/mock_get_random=2Ec</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/options_util=2E=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        )</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     target=
_sources(test_ncp PRIVATE</span><br><span>         src/openvpn/crypto_epoch=
=2Ec</span><br><span>         src/openvpn/crypto_mbedtls=2Ec</span><br><spa=
n>diff --git a/doc/man-sections/server-options=2Erst b/doc/man-sections/ser=
ver-options=2Erst</span><br><span>index 9dfa6bd=2E=2Ed868d09 100644</span><=
br><span>--- a/doc/man-sections/server-options=2Erst</span><br><span>+++ b/=
doc/man-sections/server-options=2Erst</span><br><span>@@ -330,6 +330,41 @@<=
/span><br><span>   by ``--ifconfig``, OpenVPN will install a /32 host route=
 for the ``local``</span><br><span>   IP address=2E</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+--subnet-pool args</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  Define a named pool of a=
ddresses from a subnet different from the</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  ``--server`` network, so groups of clients can be g=
iven IPs from separate</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  subnets for per-group firewall rules under ``--topology subnet`` (and<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  therefore DCO)=2E =
This is a main-config directive and may be repeated to</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  define several pools=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  Valid syntax:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  ::</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     subnet-pool=
 tag network netmask [gateway]</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``tag`=
` is a name a client refers to with ``--subnet-pool-tag``; ``gateway``</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  defaults to the first =
address of ``network``/``netmask`` and is never</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  assigned to a client=2E A client assigned to =
a pool receives (dynamically, or</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  via a static ``--ifconfig-push`` that must lie within the su=
bnet) an address</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  f=
rom it, plus the matching netmask=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
Requires ``--server`` with ``--dev tun`` and ``--topology subnet``=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``netmask`` must be bet=
ween /16 and /29 (as for ``--server``), ``gateway``</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  must be a host address inside the subne=
t, each ``tag`` may be defined only</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  once and no pool may overlap another one or the ``--serve=
r`` network=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  The server routes each=
 pool&#39;s subnet into the tun device, as it does for</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  the ``--server`` network; no ``--route=
`` needs to be added for it=2E These</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  routes honour ``--route-table`` and ``--route-metric``=
=2E With DCO on Linux</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  and FreeBSD the IPv4 route is installed on-link, without a gateway, so =
its</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``route_gatewa=
y_{n}`` is not set for ``--route-up`` scripts=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+--subnet-pool-tag tag</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  Assign this client to the ``--subnet-pool`` named ``tag``=2E =
Must be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  associated=
 with a specific client instance via ``--client-config-dir`` or</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  ``--client-connect``=2E Sever=
al clients may reference the same tag and are</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  then served from the same shared pool=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --ifconf=
ig-ipv6-push args</span><br><span>   for ``--client-config-dir`` per-client=
 static IPv6 interface</span><br><span>   configuration, see ``--client-con=
fig-dir`` and ``--ifconfig-push`` for</span><br><span>diff --git a/src/open=
vpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index a2cfdbf=2E=2E12=
b7442 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>++=
+ b/src/openvpn/multi=2Ec</span><br><span>@@ -43,6 +43,7 @@</span><br><span=
> #include &quot;auth_token=2Eh&quot;</span><br><span> #include &quot;route=
=2Eh&quot;</span><br><span> #include &quot;sid_hash=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options_util=2Eh&q=
uot;</span><br><span> #include &lt;inttypes=2Eh&gt;</span><br><span> #inclu=
de &lt;string=2Eh&gt;</span><br><span> </span><br><span>@@ -54,6 +55,20 @@<=
/span><br><span> #include &quot;dco=2Eh&quot;</span><br><span> #include &qu=
ot;reflect_filter=2Eh&quot;</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Dynamic address pool serving the clients of one --subnet-pool t=
ag=2E  Shared</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * by =
every client that references the tag, created on first use=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+struct subnet_pool</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct subnet_pool *next;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const char *tag;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct ifconfig_pool *pool;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 struct ifconfig_pool *multi_get_group_pool(struct multi_context *m,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
                        const struct options *o, const char *tag);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*#define =
MULTI_DEBUG_EVENT_LOOP*/</span><br><span> </span><br><span> #ifdef MULTI_DE=
BUG_EVENT_LOOP</span><br><span>@@ -371,6 +386,13 @@</span><br><span>       =
  }</span><br><span>     }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* create every --subnet-pool group up front r=
ather than on first use, so</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * that its pool exists before any client of the group connects=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (const s=
truct subnet_pool_def *d =3D t-&gt;options=2Esubnet_pools; d; d =3D d-&gt;n=
ext)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        multi_get_group_pool(=
m, &amp;t-&gt;options, d-&gt;tag);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span>     /*</span><br><span>      * Help us keep track of rou=
ting table=2E</span><br><span>      */</span><br><span>@@ -625,7 +647,8 @@<=
/span><br><span> </span><br><span>         schedule_remove_entry(m-&gt;sche=
dule, (struct schedule_entry *)mi);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ifconfig_pool_release(m-&gt;ifconfi=
g_pool, mi-&gt;vaddr_handle, false);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        ifconfig_pool_release(mi-&gt;vaddr_pool ? mi-&gt;v=
addr_pool : m-&gt;ifconfig_pool, mi-&gt;vaddr_handle,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                              false);</sp=
an><br><span> </span><br><span>         if (mi-&gt;did_iroutes)</span><br><=
span>         {</span><br><span>@@ -707,6 +730,14 @@</span><br><span>      =
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
405,6 +1436,12 @@</span><br><span>     const struct options *o =3D &amp;c-&=
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
_ifconfig_constraint_network;</span><br><span>     }</span><br><span>@@ -14=
15,6 +1452,37 @@</span><br><span> }</span><br><span> </span><br><span> /*</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return the dynamic=
 pool serving the clients tagged with &lt;tag&gt;, creating it</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * on first use from the matchin=
g --subnet-pool definition in &lt;o&gt;=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static struct ifconfig_pool *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+multi_get_group_pool(struct multi_context *m, const struct=
 options *o, const char *tag)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct subnet_pool *sp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (sp =3D m-&=
gt;subnet_pools; sp; sp =3D sp-&gt;next)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (!strcmp(sp-&gt;tag, tag))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            return sp-&gt;pool;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct=
 subnet_pool_def *d4 =3D subnet_pool_by_tag(o-&gt;subnet_pools, tag);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(d4);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(sp, struc=
t subnet_pool);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
sp-&gt;tag =3D d4-&gt;tag;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* every host address of the subnet, minus the gateway reserved =
below */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;=
pool =3D ifconfig_pool_init(true, IFCONFIG_POOL_INDIV, d4-&gt;network + 1,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
              (d4-&gt;network | ~d4-&gt;netmask) - 1, o-&gt;duplicate_cn, f=
alse,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                    in6addr_any, 0);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ifconfig_pool_reserve_ip(sp-&gt;pool, d4-&gt;gateway);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;next =3D=
 m-&gt;subnet_pools;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    m-&gt;subnet_pools =3D sp;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return sp-&gt;pool;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span>  =
* Select a virtual address for a new client instance=2E</span><br><span>  *=
 Use an --ifconfig-push directive, if given (static IP)=2E</span><br><span>=
  * Otherwise use an --ifconfig-pool address (dynamic IP)=2E</span><br><spa=
n>@@ -1424,6 +1492,25 @@</span><br><span> {</span><br><span>     struct gc_=
arena gc =3D gc_new();</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* resolve --subnet-pool-tag against the main-conf=
ig --subnet-pool list (an</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * unknown tag is rejected with AUTH_FAILED in multi_connection_e=
stablished)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* This runs again after every client-connect handler, and a later handler</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (script, plugi=
n, management) may override the tag set by the CCD file,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * so always resolve the current t=
ag=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi-=
&gt;context=2Eoptions=2Esubnet_pool_tag)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        const struct subnet_pool_def *d =3D</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            subnet_pool_by_tag(m-&gt;top=2Eo=
ptions=2Esubnet_pools, mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        mi-&gt;context=2Eoptions=2Esubnet_pool=
_defined =3D d !=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   mi-&gt;context=2Eoptions=2Esubnet_pool_network =3D d-&gt;network;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=
=2Eoptions=2Esubnet_pool_netmask =3D d-&gt;netmask;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=2Eoptions=2Esu=
bnet_pool_gateway =3D d-&gt;gateway;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>     /*</span><br><span>      * If ifconfig addresses were set by=
 dynamic config file,</span><br><span>      * release pool addresses, other=
wise keep them=2E</span><br><span>@@ -1434,8 +1521,10 @@</span><br><span>  =
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
@@ -1455,6 +1544,52 @@</span><br><span>                 &quot;MULTI_sva: WA=
RNING: if --ifconfig-push is used for IPv4, automatic IPv6 assignment from =
--ifconfig-ipv6-pool does not work=2E  Use --ifconfig-ipv6-push for IPv6 th=
en=2E&quot;);</span><br><span>         }</span><br><span>     }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    else if (mi-&gt;context=2Eo=
ptions=2Esubnet_pool_defined)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* dynamic address from this client&#39;s --subnet-pool group */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        struct ifconfig_po=
ol *group =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      multi_get_group_pool(m, &amp;m-&gt;top=2Eoptions, mi-&gt;context=2Eop=
tions=2Esubnet_pool_tag);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* th=
e address may have been acquired before the tag was known (from</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+         * the global pool) or =
for a tag that a later handler overrode: drop</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         * it so we serve this client from its cu=
rrent group */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (mi-&gt;vaddr_handle &gt;=3D 0 &amp;&amp; mi-&gt;vaddr_pool !=3D grou=
p)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            ifconfig_pool_r=
elease(mi-&gt;vaddr_pool ? mi-&gt;vaddr_pool : m-&gt;ifconfig_pool,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
       mi-&gt;vaddr_handle, true);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            mi-&gt;vaddr_handle =3D -1;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;vaddr_pool =3D NULL;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* both =
addresses of the dropped slot go back to its pool */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=2Ec2=2Epush_if=
config_defined =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_defined =3D fals=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (mi-&gt;vaddr_handle &lt; 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            in_addr_t local =3D 0, r=
emote =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     const char *cn =3D NULL;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   if (!mi-&gt;context=2Eoptions=2Eduplicate_cn)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                cn =3D tls_common_name(mi-&gt;contex=
t=2Ec2=2Etls_multi, true);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt=
;vaddr_pool =3D group;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            mi-&gt;vaddr_handle =3D ifconfig_pool_acquire(mi-&gt;vaddr_p=
ool, &amp;local, &amp;remote, NULL, cn);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (mi-&gt;vaddr_handle &gt;=3D 0)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                mi-&gt;context=2E=
c2=2Epush_ifconfig_local =3D remote;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                mi-&gt;context=2Ec2=2Epush_ifconfig_remote=
_netmask =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             mi-&gt;context=2Eoptions=2Esubnet_pool_netmask;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                mi-&gt;context=2Ec=
2=2Epush_ifconfig_defined =3D true;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            else</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                msg(D_MULTI_ERRORS, &quot;MULTI: no free --subnet-pool add=
resses are available for %s&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    multi_instance_string(mi, false, &amp;gc=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else =
if (m-&gt;ifconfig_pool &amp;&amp; mi-&gt;vaddr_handle &lt; 0) /* otherwise=
, choose a pool address */</span><br><span>     {</span><br><span>         =
in_addr_t local =3D 0, remote =3D 0;</span><br><span>@@ -2360,10 +2495,9 @@=
</span><br><span>         const char *ifconfig_constraint_netmask =3D</span=
><br><span>             print_in_addr_t(mi-&gt;context=2Eoptions=2Epush_ifc=
onfig_constraint_netmask, 0, &amp;gc);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        /* JYFIXME -- this should cause =
the connection to fail */</span><br><span>         msg(D_MULTI_ERRORS,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;MULTI ER=
ROR: primary virtual IP for %s (%s) &quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            &quot;violates tunnel network/netmask cons=
traint (%s/%s)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            &quot;WARNING: primary virtual IP for %s (%s) &quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;violates t=
unnel network/netmask constraint (%s/%s) and may not work&quot;,</span><br>=
<span>             multi_instance_string(mi, false, &amp;gc),</span><br><sp=
an>             print_in_addr_t(mi-&gt;context=2Ec2=2Epush_ifconfig_local, =
0, &amp;gc),</span><br><span>             ifconfig_constraint_network, ifco=
nfig_constraint_netmask);</span><br><span>@@ -2471,6 +2605,7 @@</span><br><=
span> </span><br><span>     /* reset pool handle to null */</span><br><span=
>     mi-&gt;vaddr_handle =3D -1;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    mi-&gt;vaddr_pool =3D NULL;</span><br><span> </span><br><=
span>     /* do --client-connect setenvs */</span><br><span>     multi_sele=
ct_virtual_addr(m, mi);</span><br><span>@@ -2792,6 +2927,15 @@</span><br><s=
pan>         cc_succeeded =3D false;</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;co=
ntext=2Eoptions=2Esubnet_pool_tag</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        &amp;&amp; !subnet_pool_by_tag(m-&gt;top=2Eoptions=2E=
subnet_pools, mi-&gt;context=2Eoptions=2Esubnet_pool_tag))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg(D_MULTI_ERRORS, &quot;MULTI: client ha=
s been rejected due to unknown --subnet-pool-tag &#39;%s&#39;&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=
=2Eoptions=2Esubnet_pool_tag);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        auth_set_client_reason(mi-&gt;context=2Ec2=2Etls_multi, =
&quot;unknown subnet-pool-tag&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        cc_succeeded =3D false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span>     if (cc_succeeded)</span><br><span>   =
  {</span><br><span>         multi_client_connect_late_setup(m, mi, *option=
_types_found);</span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/ope=
nvpn/multi=2Eh</span><br><span>index 5db7147=2E=2E14f71dd 100644</span><br>=
<span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=
=2Eh</span><br><span>@@ -121,6 +121,8 @@</span><br><span>     struct mroute=
_addr real; /**&lt; External network address of the</span><br><span>       =
                        *   remote peer=2E */</span><br><span>     ifconfig=
_pool_handle vaddr_handle;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* pool vaddr_handle belongs to (NULL =3D the global one) */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_poo=
l *vaddr_pool;</span><br><span>     char msg_prefix[MULTI_PREFIX_MAX_LENGTH=
];</span><br><span> </span><br><span>     /* queued outgoing data in Server=
/TCP mode */</span><br><span>@@ -190,6 +192,8 @@</span><br><span>          =
                               *   instances=2E */</span><br><span>     str=
uct multi_io *multi_io;         /**&lt; I/O state and events tracker */</sp=
an><br><span>     struct ifconfig_pool *ifconfig_pool;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* per-group --subnet-pool dynamic p=
ools */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct s=
ubnet_pool *subnet_pools;</span><br><span>     struct frequency_limit *new_=
connection_limiter;</span><br><span>     struct initial_packet_rate_limit *=
initial_rate_limiter;</span><br><span>     struct mroute_helper *route_help=
er;</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/opti=
ons=2Ec</span><br><span>index 7fc8614=2E=2Ed5666b8 100644</span><br><span>-=
-- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec<=
/span><br><span>@@ -452,6 +452,11 @@</span><br><span>     &quot;           =
       If seconds=3D0, file will be treated as read-only=2E\n&quot;</span><=
br><span>     &quot;--ifconfig-ipv6-pool base-IP/bits : set aside an IPv6 n=
etwork block\n&quot;</span><br><span>     &quot;                  to be dyn=
amically allocated to connecting clients=2E\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;--subnet-pool tag network netma=
sk [gateway] : Define a named pool of\n&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &quot;                  addresses outside the=
 --server network, selected per\n&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    &quot;                  client with --subnet-pool-t=
ag=2E\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &q=
uot;--subnet-pool-tag tag : Assign this client to the --subnet-pool named t=
ag=2E\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &q=
uot;                  Only valid in a client-specific config file=2E\n&quot=
;</span><br><span>     &quot;--ifconfig-push local remote-netmask : Push an=
 ifconfig option to remote,\n&quot;</span><br><span>     &quot;            =
      overrides --ifconfig-pool dynamic allocation=2E\n&quot;</span><br><sp=
an>     &quot;                  Only valid in a client-specific config file=
=2E\n&quot;</span><br><span>@@ -1925,6 +1930,20 @@</span><br><span>        =
 {</span><br><span>             msg(M_USAGE, &quot;--ifconfig-ipv6-pool nee=
ds --ifconfig-ipv6&quot;);</span><br><span>         }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt;subnet_pools)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (!options-&gt;serv=
er_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  msg(M_USAGE, &quot;--subnet-pool requires --server&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            if (dev_type_enum(options-&g=
t;dev, options-&gt;dev_type) !=3D DEV_TYPE_TUN</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                || options-&gt;topology !=3D TOP=
_SUBNET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                m=
sg(M_USAGE, &quot;--subnet-pool requires --dev tun and --topology subnet&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            subnet_p=
ools_check(options-&gt;subnet_pools, options-&gt;server_network,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
 options-&gt;server_netmask, M_USAGE);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span>         MUST_BE_UNDEF(allow_r=
ecursive_routing, &quot;allow-recursive-routing&quot;);</span><br><span>   =
      if (options-&gt;auth_user_pass_file)</span><br><span>         {</span=
><br><span>@@ -1991,6 +2010,7 @@</span><br><span>         MUST_BE_UNDEF(ifc=
onfig_pool_defined, &quot;ifconfig-pool&quot;);</span><br><span>         MU=
ST_BE_UNDEF(ifconfig_pool_persist_filename, &quot;ifconfig-pool-persist&quo=
t;);</span><br><span>         MUST_BE_UNDEF(ifconfig_ipv6_pool_defined, &qu=
ot;ifconfig-ipv6-pool&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        MUST_BE_UNDEF(subnet_pools, &quot;subnet-pool&quot;);</sp=
an><br><span>         MUST_BE_UNDEF(real_hash_size, &quot;hash-size&quot;);=
</span><br><span>         MUST_BE_UNDEF(virtual_hash_size, &quot;hash-size&=
quot;);</span><br><span>         MUST_BE_UNDEF(learn_address_script, &quot;=
learn-address&quot;);</span><br><span>@@ -3123,6 +3143,28 @@</span><br><spa=
n>     }</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * The server&#39;s tun device is only configured with the --serve=
r network, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rou=
te each --subnet-pool network into it as well: without this the server</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * could not reach its s=
ubnet-pool clients when the data channel runs in</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * userspace=2E  Under DCO on Linux and FreeBS=
D the routes are installed on-link,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * see subnet_pool_routes_onlink()=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+options_postprocess_subnet_pool_routes(struct options *o)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (const struct subnet_pool_def *d =3D =
o-&gt;subnet_pools; d; d =3D d-&gt;next)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        struct route_option *ro;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        rol_check_alloc(o);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        ro =3D add_route_to_option_list(o-&gt;routes, print_in_add=
r_t(d-&gt;network, 0, &amp;o-&gt;gc),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                      print_in_addr_t(d-&=
gt;netmask, 0, &amp;o-&gt;gc), NULL, NULL,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                      o-&gt;route_de=
fault_table_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     ro-&gt;on_link =3D subnet_pool_routes_onlink(o);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> static void</span><br><span> options_postprocess_mutate=
(struct options *o, struct env_set *es)</span><br><span> {</span><br><span>=
@@ -3258,6 +3300,12 @@</span><br><span>         /* check if any option shou=
ld force disabling DCO */</span><br><span>         o-&gt;disable_dco =3D !d=
co_check_option(D_DCO, o) || !dco_check_startup_option(D_DCO, o);</span><br=
><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;mode =3D=3D=
 MODE_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* how the p=
ools are routed depends on the DCO decision above */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        options_postprocess_subnet_pool_r=
outes(o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span> #ifdef USE_COMP</span><br><span>     if (dco_enabled(o))</span=
><br><span>     {</span><br><span>@@ -6245,6 +6293,43 @@</span><br><span>  =
           goto err;</span><br><span>         }</span><br><span>     }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0],=
 &quot;subnet-pool&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; p[3] &=
amp;&amp; !p[5])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct su=
bnet_pool_def *sp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       in_addr_t network, netmask;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        network =3D getaddr(GETADDR_HOST_ORDER | GETADDR_=
RESOLVE, p[2], 0, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        netmask =3D getaddr(GETADDR_HOST_ORDER, p[3], 0, NULL, N=
ULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!n=
etwork || !netmask)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  msg(msglevel, &quot;cannot parse --subnet-pool addresses&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        ALLOC_OBJ_GC(sp, struct subn=
et_pool_def, &amp;options-&gt;gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        sp-&gt;tag =3D p[1];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        sp-&gt;network =3D network &amp; netmask;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;netmas=
k =3D netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   sp-&gt;gateway =3D (network &amp; netmask) + 1;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (p[4])</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            bool ok =3D false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            sp-&gt;gateway =3D getaddr(GETADDR_HOST_ORDER | GETA=
DDR_RESOLVE, p[4], 0, &amp;ok, NULL);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            if (!ok)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                msg(msglevel, &quot;cannot parse --subnet-pool=
 gateway&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sp-&g=
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
nvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index d347830=2E=
=2Eff26066 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><=
span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -252,6 +252,17 @@</sp=
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
ions</span><br><span> {</span><br><span>@@ -518,6 +529,12 @@</span><br><spa=
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
_ipv6_local;  /* IPv6 */</span><br><span>@@ -978,4 +995,23 @@</span><br><sp=
an> #endif /* ENABLE_DCO */</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Whether the routes of the --subnet-pool net=
works are installed on-link on</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * the DCO device rather than via a gateway=2E  With DCO on Linu=
x and FreeBSD the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 kernel selects the peer by a route&#39;s next hop, so a route via a gatewa=
y</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * would deliver e=
very packet for an unassigned pool address to the client</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * owning that gateway address; on-lin=
k, such a packet matches no peer, while</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * each pool client gets its own on-link host route whe=
n it connects (see</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* multi_learn_in_addr_t())=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 inline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+subnet_=
pool_routes_onlink(const struct options *o)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return dco_enabled(o);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> #endif /* ifndef OPTIONS_H */</span><br><span>diff --g=
it a/src/openvpn/options_util=2Ec b/src/openvpn/options_util=2Ec</span><br>=
<span>index d25d85c=2E=2E744ad4c 100644</span><br><span>--- a/src/openvpn/o=
ptions_util=2Ec</span><br><span>+++ b/src/openvpn/options_util=2Ec</span><b=
r><span>@@ -30,6 +30,91 @@</span><br><span> #include &quot;options_util=2Eh=
&quot;</span><br><span> </span><br><span> #include &quot;push=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;pool=2Eh=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+const struct subnet_pool_def *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+subnet_pool_by_tag(co=
nst struct subnet_pool_def *pools, const char *tag)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    for (const struct subnet_pool_def *d =3D pools; d; d =
=3D d-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!strcm=
p(d-&gt;tag, tag))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 return d;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* true if the two IPv4 subnets share at least one address */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+subnets_overlap(in_addr_t a, in_addr_t =
mask_a, in_addr_t b, in_addr_t mask_b)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const in_addr_t mask =3D mask_a &amp; mask_b;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return (a &amp; mask) =3D=3D (b &amp; mask);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+subnet_pool=
s_check(const struct subnet_pool_def *pools, in_addr_t server_network,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                   in_ad=
dr_t server_netmask, msglvl_t msglevel)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    for (const struct subnet_pool_def *d =3D pools; d; d =3D d-&gt;next)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        const in_addr_t host =3D ~=
d-&gt;netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   int netbits =3D 32;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* the n=
etmask must be contiguous */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (host &amp; (host + 1))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(msglevel, &quot;--subnet-pool %s: invalid net=
mask&quot;, d-&gt;tag);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            return false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        for (in_addr_t h =3D host; h; h &gt;&gt;=3D 1)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            netbits--;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       /* same bounds as --server: the pool must hold at least 2 addresses<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * besides n=
etwork, gateway and broadcast, and fit IFCONFIG_POOL_MAX */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (netbits &lt; IFCONFIG_P=
OOL_MIN_NETBITS || netbits &gt; 29)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            msg(msglevel, &quot;--subnet-pool %s: netmask must be bet=
ween /%d and /29 (not /%d)&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                d-&gt;tag, IFCONFIG_POOL_MIN_NETBITS, netbits=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retur=
n false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if ((d-&gt;gateway &amp; d-&gt;n=
etmask) !=3D d-&gt;network || d-&gt;gateway =3D=3D d-&gt;network</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            || d-&gt;gateway =
=3D=3D (d-&gt;network | host))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            msg(msglevel, &quot;--subnet-pool %s: gateway must be a host a=
ddress inside the subnet&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                d-&gt;tag);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            return false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (server_netmask</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            &amp;&amp; subnets_overlap(d-&gt;network, d-&gt;netmask, se=
rver_network, server_netmask))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            msg(msglevel, &quot;--subnet-pool %s: subnet overlaps the --se=
rver network&quot;, d-&gt;tag);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            return false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for=
 (const struct subnet_pool_def *e =3D d-&gt;next; e; e =3D e-&gt;next)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            if (!strcmp(d-&gt;tag,=
 e-&gt;tag))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   msg(msglevel, &quot;--subnet-pool %s: tag defined more than once&quot;, =
d-&gt;tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (subnets_overlap(d-&gt;network, d-&gt;netmask, e-&gt;network, e-=
&gt;netmask))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    msg(msglevel, &quot;--subnet-pool %s and %s: subnets overlap&quot;, d-&=
gt;tag, e-&gt;tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                return false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> cons=
t char *</span><br><span> parse_auth_failed_temp(struct options *o, const c=
har *reason)</span><br><span>diff --git a/src/openvpn/options_util=2Eh b/sr=
c/openvpn/options_util=2Eh</span><br><span>index 5226a6f=2E=2Ed60759a 10064=
4</span><br><span>--- a/src/openvpn/options_util=2Eh</span><br><span>+++ b/=
src/openvpn/options_util=2Eh</span><br><span>@@ -28,6 +28,31 @@</span><br><=
span> </span><br><span> const char *parse_auth_failed_temp(struct options *=
o, const char *reason);</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Look up a named --subnet-pool in a list of pool definitions=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param pools  head of the --subnet-po=
ol list (may be NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param tag    the --subnet-pool-tag to match</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @return       the matching pool definition=
, or NULL if none matches</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const stru=
ct subnet_pool_def *subnet_pool_by_tag(const struct subnet_pool_def *pools,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                              const char *tag);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Vali=
date the --subnet-pool definitions: contiguous netmask between</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * /IFCONFIG_POOL_MIN_NETBITS an=
d /29, gateway a host address inside its</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * subnet, unique tags, and no subnet overlapping anot=
her pool or the --server</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * network=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pools   =
        head of the --subnet-pool list (may be NULL)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param server_network  the --server ne=
twork (host order)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param server_netmask  the --server netmask, or 0 if there is none</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param msglevel        =
level of the message logged on the first error</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @return                true if every definiti=
on is valid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+bool subnet_pools_check(=
const struct subnet_pool_def *pools, in_addr_t server_network,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        in_addr_=
t server_netmask, msglvl_t msglevel);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> </span><br><span> /** Checks if the str=
ing is a valid integer by checking if it can be</span><br><span>  *  conver=
ted to an integer */</span><br><span>diff --git a/src/openvpn/pool=2Ec b/sr=
c/openvpn/pool=2Ec</span><br><span>index 63fc930=2E=2Efa04d9c 100644</span>=
<br><span>--- a/src/openvpn/pool=2Ec</span><br><span>+++ b/src/openvpn/pool=
=2Ec</span><br><span>@@ -350,7 +350,7 @@</span><br><span> {</span><br><span=
>     bool ret =3D false;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (pool &amp;&amp; hand &gt;=3D 0 &amp;&amp; han=
d &lt; pool-&gt;size)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (pool &amp;&amp; hand &gt;=3D 0 &amp;&amp; hand &lt; pool-&gt;size=
 &amp;&amp; !pool-&gt;list[hand]=2Ereserved)</span><br><span>     {</span><=
br><span>         ifconfig_pool_entry_free(&amp;pool-&gt;list[hand], hard);=
</span><br><span>         ret =3D true;</span><br><span>@@ -429,6 +429,22 @=
@</span><br><span>     return ret;</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ifconfig_pool_reserve_ip(struct ifconf=
ig_pool *pool, const in_addr_t addr)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const ifconfig_pool_handle h =3D ifconfig_pool_ip_base_to_handle(pool, a=
ddr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (h &lt; 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
fconfig_pool_entry_free(&amp;pool-&gt;list[h], true);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    pool-&gt;list[h]=2Ein_use =3D true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pool-&gt;list[h]=
=2Ereserved =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> s=
tatic in_addr_t</span><br><span> ifconfig_pool_handle_to_ip_base(const stru=
ct ifconfig_pool *pool, ifconfig_pool_handle hand)</span><br><span> {</span=
><br><span>@@ -476,6 +492,13 @@</span><br><span>                   const bo=
ol fixed)</span><br><span> {</span><br><span>     struct ifconfig_pool_entr=
y *e =3D &amp;pool-&gt;list[h];</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(e-&gt;reserved)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WAR=
N, &quot;pool: ignoring persisted entry for CN=3D%s: its address is reserve=
d&quot;, cn);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if=
config_pool_entry_free(e, true);</span><br><span>     e-&gt;in_use =3D fals=
e;</span><br><span>     e-&gt;common_name =3D string_alloc(cn, NULL);</span=
><br><span>diff --git a/src/openvpn/pool=2Eh b/src/openvpn/pool=2Eh</span><=
br><span>index e2d3f82=2E=2E497dcda 100644</span><br><span>--- a/src/openvp=
n/pool=2Eh</span><br><span>+++ b/src/openvpn/pool=2Eh</span><br><span>@@ -4=
3,6 +43,7 @@</span><br><span>     char *common_name;</span><br><span>     t=
ime_t last_release;</span><br><span>     bool fixed;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool reserved; /* never handed out, e=
=2Eg=2E a --subnet-pool gateway */</span><br><span> };</span><br><span> </s=
pan><br><span> struct ifconfig_pool</span><br><span>@@ -86,6 +87,17 @@</spa=
n><br><span> </span><br><span> bool ifconfig_pool_release(struct ifconfig_p=
ool *pool, ifconfig_pool_handle hand, const bool hard);</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Permanently reserve the pool slot =
holding \c addr, so that it is never</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * handed out to a client nor taken over by a persisted en=
try (e=2Eg=2E the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 gateway of a --subnet-pool)=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram pool  the pool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param addr  IPv4 address (host order) to reserve</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return      true if \c addr lies in t=
he pool and was reserved</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ifconf=
ig_pool_reserve_ip(struct ifconfig_pool *pool, in_addr_t addr);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> struct ifconf=
ig_pool_persist *ifconfig_pool_persist_init(const char *filename, int refre=
sh_freq);</span><br><span> </span><br><span> void ifconfig_pool_persist_clo=
se(struct ifconfig_pool_persist *persist);</span><br><span>diff --git a/src=
/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 9c80f3b=2E=
=2Ee1b3849 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><sp=
an>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -407,6 +407,11 @@</span><=
br><span>         r-&gt;flags |=3D RT_METRIC_DEFINED;</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (ro-&gt;on_link)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r-=
&gt;flags |=3D RT_ON_LINK;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>     r-&gt;flags |=3D RT_DEFINED;</span><br><span> </span><br><sp=
an>     /* routing table id */</span><br><span>@@ -477,7 +482,7 @@</span><b=
r><span>     return false;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+struct route_option *</span><br><span> add_route=
_to_option_list(struct route_option_list *l, const char *network, const cha=
r *netmask,</span><br><span>                          const char *gateway, =
const char *metric, int table_id)</span><br><span> {</span><br><span>@@ -48=
8,8 +493,10 @@</span><br><span>     ro-&gt;gateway =3D gateway;</span><br><=
span>     ro-&gt;metric =3D metric;</span><br><span>     ro-&gt;table_id =
=3D table_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ro=
-&gt;on_link =3D false;</span><br><span>     ro-&gt;next =3D l-&gt;routes;<=
/span><br><span>     l-&gt;routes =3D ro;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return ro;</span><br><span> }</span><br><span> </=
span><br><span> void</span><br><span>@@ -1321,7 +1328,11 @@</span><br><span=
>     {</span><br><span>         setenv_route_addr(es, &quot;network&quot;,=
 r-&gt;network, i);</span><br><span>         setenv_route_addr(es, &quot;ne=
tmask&quot;, r-&gt;netmask, i);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        setenv_route_addr(es, &quot;gateway&quot;, r-&gt;gateway,=
 i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* an o=
n-link route has no gateway */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (!(r-&gt;flags &amp; RT_ON_LINK))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            setenv_route_addr(es, &quot;gateway&q=
uot;, r-&gt;gateway, i);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span> </span><br><span>         if (r-&gt;flags &=
amp; RT_METRIC_DEFINED)</span><br><span>         {</span><br><span>@@ -1477=
,6 +1488,7 @@</span><br><span> </span><br><span> #if defined(TARGET_LINUX)<=
/span><br><span>     const char *iface =3D NULL;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const in_addr_t *gateway =3D &amp;r-&gt;ga=
teway;</span><br><span>     int metric =3D -1;</span><br><span> </span><br>=
<span>     if (is_on_link(is_local_route, flags, rgi))</span><br><span>@@ -=
1484,6 +1496,12 @@</span><br><span>         iface =3D rgi-&gt;iface;</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if ((r-&gt;flags &amp; RT_ON_LINK) &amp;&amp; tt)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        gateway =3D NULL;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        iface =3D tt-&gt;actual_na=
me;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (r-&g=
t;flags &amp; RT_METRIC_DEFINED)</span><br><span>     {</span><br><span>   =
      metric =3D r-&gt;metric;</span><br><span>@@ -1491,8 +1509,8 @@</span>=
<br><span> </span><br><span> </span><br><span>     status =3D RTA_SUCCESS;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D net_ro=
ute_v4_add(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-&gt;netmask), &am=
p;r-&gt;gateway,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                          iface, r-&gt;table_id, metric);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int ret =3D net_route_v4_add(ctx,=
 &amp;r-&gt;network, netmask_to_netbits2(r-&gt;netmask), gateway, iface,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
         r-&gt;table_id, metric);</span><br><span>     if (ret =3D=3D -EEXI=
ST)</span><br><span>     {</span><br><span>         msg(D_ROUTE, &quot;NOTE=
: Linux route add command failed because route exists&quot;);</span><br><sp=
an>@@ -1615,7 +1633,15 @@</span><br><span>     }</span><br><span> #endif</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ar=
gv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot;, network, gateway, netma=
sk);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((r-&gt;=
flags &amp; RT_ON_LINK) &amp;&amp; tt)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        argv_printf_cat(&amp;argv, &quot;-net %s/%d -iface %s&quot;, n=
etwork, netmask_to_netbits2(r-&gt;netmask),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                        tt-&gt;actual_name);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        argv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot;, net=
work, gateway, netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span> </span><br><span>     /* FIXME -- add on-link s=
upport for FreeBSD */</span><br><span> </span><br><span>@@ -2034,7 +2060,16=
 @@</span><br><span>         metric =3D r-&gt;metric;</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (net_route_v4_del(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-&gt;n=
etmask), &amp;r-&gt;gateway, NULL,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const in_addr_t *gateway =3D &amp;r-&gt;gateway;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *iface =3D N=
ULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if ((r-&gt;flags &amp; RT_ON_L=
INK) &amp;&amp; tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gatewa=
y =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
iface =3D tt-&gt;actual_name;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (net_route_v4_de=
l(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-&gt;netmask), gateway, ifa=
ce,</span><br><span>                          r-&gt;table_id, metric)</span=
><br><span>         &lt; 0)</span><br><span>     {</span><br><span>@@ -2090=
,7 +2125,15 @@</span><br><span> </span><br><span> #elif defined(TARGET_FREE=
BSD)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    argv_printf(&amp;argv, &quot;%s delete -net %s %s %s&quot;, ROUTE_PATH=
, network, gateway, netmask);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if ((r-&gt;flags &amp; RT_ON_LINK) &amp;&amp; tt)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, &quot;%s delet=
e -net %s/%d -iface %s&quot;, ROUTE_PATH, network,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    netmask_to_netbits2(r-&g=
t;netmask), tt-&gt;actual_name);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&amp;a=
rgv, &quot;%s delete -net %s %s %s&quot;, ROUTE_PATH, network, gateway, net=
mask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span> </span><br><span>     argv_msg(D_ROUTE, &amp;argv);</span><br><sp=
an>     openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: FreeBSD route d=
elete command failed&quot;);</span><br><span>diff --git a/src/openvpn/route=
=2Eh b/src/openvpn/route=2Eh</span><br><span>index 0d33d36=2E=2E7c5528f 100=
644</span><br><span>--- a/src/openvpn/route=2Eh</span><br><span>+++ b/src/o=
penvpn/route=2Eh</span><br><span>@@ -80,6 +80,10 @@</span><br><span>     co=
nst char *gateway;</span><br><span>     int table_id;</span><br><span>     =
const char *metric;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* on Linux and FreeBSD, install the route on-link on the tun device</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * instead of via =
the gateway (needed under DCO, where the kernel selects</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * the peer by the route&#39;s next=
 hop) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool on=
_link;</span><br><span> };</span><br><span> </span><br><span> /* redirect-g=
ateway flags */</span><br><span>@@ -120,6 +124,7 @@</span><br><span> #defin=
e RT_DEFINED        (1u &lt;&lt; 0)</span><br><span> #define RT_ADDED      =
    (1u &lt;&lt; 1)</span><br><span> #define RT_METRIC_DEFINED (1u &lt;&lt;=
 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define RT_ON_LI=
NK        (1u &lt;&lt; 3) /* see struct route_option=2Eon_link */</span><br=
><span>     struct route_ipv4 *next;</span><br><span>     unsigned int flag=
s;</span><br><span>     const struct route_option *option;</span><br><span>=
@@ -311,8 +316,9 @@</span><br><span>                const struct route_gate=
way_info *rgi, const struct env_set *es,</span><br><span>                op=
envpn_net_ctx_t *ctx);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-void add_route_to_option_list(struct route_option_list *=
l, const char *network, const char *netmask,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                              const char *gateway, c=
onst char *metric, int table_id);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+struct route_option *add_route_to_option_list(struct route_op=
tion_list *l, const char *network,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                              const char *ne=
tmask, const char *gateway,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                              const char *metric, i=
nt table_id);</span><br><span> </span><br><span> void add_route_ipv6_to_opt=
ion_list(struct route_ipv6_option_list *l, const char *prefix,</span><br><s=
pan>                                    const char *gateway, const char *me=
tric, int table_id);</span><br><span>diff --git a/tests/unit_tests/openvpn/=
Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>inde=
x 38299f5=2E=2E78f4b6c 100644</span><br><span>--- a/tests/unit_tests/openvp=
n/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Ea=
m</span><br><span>@@ -21,6 +21,7 @@</span><br><span> 	push_update_msg_testd=
river \</span><br><span> 	socket_testdriver \</span><br><span> 	ssl_testdri=
ver \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	subnet_pool_t=
estdriver \</span><br><span> 	user_pass_testdriver</span><br><span> </span>=
<br><span> if HAVE_LD_WRAP_SUPPORT</span><br><span>@@ -384,6 +385,19 @@</sp=
an><br><span> 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><span> 	$=
(top_srcdir)/src/openvpn/mbuf=2Ec</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+subnet_pool_testdriver_CFLAGS  =3D \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdir)/include=
 -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	@TEST_CFLAGS@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+subnet_pool_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+subnet_pool_testdriver_SOURCES =3D test_subnet_po=
ol=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg=
=2Ec test_common=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	mock_get_random=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/options_util=2Ec \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/open=
vpn/platform=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> misc_testdriver_CFLAGS  =3D \</span><br><span> 	-I$(top_srcd=
ir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span>=
<br><span> 	-DSOURCEDIR=3D\&quot;$(top_srcdir)\&quot; @TEST_CFLAGS@</span><=
br><span>diff --git a/tests/unit_tests/openvpn/test_subnet_pool=2Ec b/tests=
/unit_tests/openvpn/test_subnet_pool=2Ec</span><br><span>new file mode 1006=
44</span><br><span>index 0000000=2E=2E1bb9e4c</span><br><span>--- /dev/null=
</span><br><span>+++ b/tests/unit_tests/openvpn/test_subnet_pool=2Ec</span>=
<br><span>@@ -0,0 +1,146 @@</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenV=
PN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP port, wi=
th support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             session authentication and key exchange,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encrypti=
on, packet authentication, and</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             packet compression=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  Copyright (C) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you=
 can redistribute it and/or modify</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  it under the terms of the GNU General Public License ver=
sion 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publis=
hed by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  This program is distributed in the hope that it will be useful,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRA=
NTY; without even the implied warranty of</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPO=
SE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  G=
NU General Public License for more details=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  You should have received a copy of the GNU General Public Lice=
nse along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with t=
his program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
lt;stdlib=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &lt;setjmp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;options=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;options_util=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;test_common=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;mock_msg=2Eh&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* --subnet-pool-tag resolves a clien=
t to its --subnet-pool; an unknown tag</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * returns NULL, which is what makes the server reject t=
hat client=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_subnet=
_pool_by_tag(void **state)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
subnet_pool_def c =3D { =2Enext =3D NULL, =2Etag =3D &quot;grpC&quot;, =2En=
etwork =3D 0x0a020300, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a020301=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subne=
t_pool_def b =3D { =2Enext =3D &amp;c, =2Etag =3D &quot;grpB&quot;, =2Enetw=
ork =3D 0x0a020200, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a020201 };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_p=
ool_def a =3D { =2Enext =3D &amp;b, =2Etag =3D &quot;grpA&quot;, =2Enetwork=
 =3D 0x0a020100, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a020101 };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* every configured tag resolves to i=
ts own pool, wherever it sits */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_ptr_equal(subnet_pool_by_tag(&amp;a, &quot;grpA&quo=
t;), &amp;a);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_ptr_equal(subnet_pool_by_tag(&amp;a, &quot;grpB&quot;), &amp;b);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(subn=
et_pool_by_tag(&amp;a, &quot;grpC&quot;), &amp;c);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* and it carries that pool&#39;s subnet/gateway */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct subnet_poo=
l_def *r =3D subnet_pool_by_tag(&amp;a, &quot;grpB&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r-&gt;network, =
0x0a020200);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(r-&gt;netmask, 0xffffff00);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(r-&gt;gateway, 0x0a020201);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* unknown tag and empty list both mi=
ss */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_nul=
l(subnet_pool_by_tag(&amp;a, &quot;nope&quot;));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_null(subnet_pool_by_tag(NULL, &quot=
;grpA&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* a single pool &lt;net&gt;/&lt;mask&gt;=
 with gateway &lt;gw&gt;, checked against the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * 10=2E8=2E0=2E0/24 --server network */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+check_one(in_addr_t net, in_addr_t m=
ask, in_addr_t gw)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_p=
ool_def d =3D { =2Enext =3D NULL, =2Etag =3D &quot;grp&quot;, =2Enetwork =
=3D net, =2Enetmask =3D mask, =2Egateway =3D gw };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return subnet_pools_check(&amp;d, 0x0a080000, 0xffffff00, M=
_WARN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* --subnet-pool geometry: anything ifconfig_pool=
_init() cannot serve must be</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * refused when the config is checked, not when the first client c=
onnects */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_subnet_pools=
_check_netmask(void **state)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* th=
e bounds of --server: /16 =2E=2E /29 */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(check_one(0x0a090000, 0xffff0000, 0x0a0=
90001));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(check_one(0x0a090000, 0xffffff00, 0x0a090001));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(check_one(0x0a090000, 0xf=
ffffff8, 0x0a090001));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* /30, /31, /32: too few addresses for a pool */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_one(0x0a090000,=
 0xfffffffc, 0x0a090001));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_false(check_one(0x0a090000, 0xfffffffe, 0x0a090001));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_=
one(0x0a090000, 0xffffffff, 0x0a090000));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* /15: larger than IFCONFIG_POOL_MAX */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_one(0=
x0a080000, 0xfffe0000, 0x0a080001));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* non-contiguous netmask */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_false(check_one(0x0a000900, 0xff00=
ff00, 0x0a000901));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+test_subnet_pools_check_gateway(void **state)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* any host address of the subnet=
 is fine, not only the first one */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(check_one(0x0a090000, 0xffffff00, 0x0a0900f=
e));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(check_one(0x0a090000, 0xffffff00, 0x0a090080));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* network address, broadcast address, out=
side the subnet */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_false(check_one(0x0a090000, 0xffffff00, 0x0a090000));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_one(0x0a=
090000, 0xffffff00, 0x0a0900ff));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_false(check_one(0x0a090000, 0xffffff00, 0x0a0a0001=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+test_subnet_pools_check_overlap(void **state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct subnet_pool_def b =3D { =2Enext =3D NULL, =
=2Etag =3D &quot;grpB&quot;, =2Enetwork =3D 0x0a0a0000, =2Enetmask =3D 0xff=
ffff00, =2Egateway =3D 0x0a0a0001 };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct subnet_pool_def a =3D { =2Enext =3D &amp;b, =2E=
tag =3D &quot;grpA&quot;, =2Enetwork =3D 0x0a090000, =2Enetmask =3D 0xfffff=
f00, =2Egateway =3D 0x0a090001 };</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* disjoint pools, disjoint from --server */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(subnet_pools_check(&amp;a, 0x0a0800=
00, 0xffffff00, M_WARN));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a pool=
 inside the --server network =2E=2E=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_false(subnet_pools_check(&amp;a, 0x0a09000=
0, 0xffffff00, M_WARN));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* =2E=2E=2E or covering it */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_false(subnet_pools_check(&amp;a, 0x0a0a0080,=
 0xffffff80, M_WARN));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* no --server network: only the pools are checked against each othe=
r */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(subnet_pools_check(&amp;a, 0, 0, M_WARN));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* grpB grown to a /16 now contains grpA */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    b=2Enetwork =3D 0x0a090000;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    b=2Enetmask =3D 0xffff000=
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=2Egateway =
=3D 0x0a090101;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_false(subnet_pools_check(&amp;a, 0, 0, M_WARN));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* the same tag defined twice */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    b=2Enetwork =3D 0x0a0a0000;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    b=2Enetmask =3D 0xffffff0=
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=2Egateway =
=3D 0x0a0a0001;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
b=2Etag =3D &quot;grpA&quot;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_false(subnet_pools_check(&amp;a, 0, 0, M_WARN));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+const struct CMUnitTest subnet_pool_tests[] =3D {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_subn=
et_pool_by_tag),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 cmocka_unit_test(test_subnet_pools_check_netmask),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_subnet_pools_ch=
eck_gateway),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cm=
ocka_unit_test(test_subnet_pools_check_overlap),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+main(void)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    openvpn_unit_test_setup();</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return cmocka_run_group_tests(subne=
t_pool_tests, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1783?usp=3Demail">change 1783</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia1e7db95615d99ef9687de=
7c4e996dc8033e2631 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1783 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Antonio Quartulli &lt;antonio@mandelbi=
t=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>

</body></html>
--fiW41LolruI=--


--===============0658675065004423094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0658675065004423094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0658675065004423094==--

