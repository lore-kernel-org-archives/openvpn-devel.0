Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D66CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 11:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RNzKWTH8JP8PEboVUlC8UyXe7QQUvUa1Nr0eYr0h3S8=; b=QwlA2/DwFBnw5JpiqAbMmD9oR8
	eRT8JD7q8vby/jzaPcoK92TjtmLS2UZRijwYcA4pYfgl0MuolCcSGPXWwNO4jEtWNs+IYA0ei4koU
	LnRhJkEHEZATyOvkTacRot3soIcqZ2MDMAdLKqY4tj1tE475fpbvzud2CcXg4fBx9ClM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIP83-0006tr-Ox;
	Sun, 18 Oct 2026 11:32:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIP81-0006tk-Dk
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 11:32:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LbRXWw2ipGbH+UQ5aUKTIZ1nVoM1mMHX3Z7kfM7/DnY=; b=Lha0BTLn8XuHnC4L4sNSP8PGdF
 iQIelWUvMJRDc0nu2ZXEWbkC66QV5bR4Vgf6/oTIbnLb4r0gBCnj75AqnnnwHgqPFnGGP8cTMZ6W3
 ydpNgs5v3AFAjPx+TkMYovsigpqByZqxLFUVi0SnRnm1C/pIwUKeI+e9dy4Z7x4b33Qw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LbRXWw2ipGbH+UQ5aUKTIZ1nVoM1mMHX3Z7kfM7/DnY=; b=c
 3NWoolQt9Kah3m5dEzE13MDBkU8g3ABQXmrC5Cbt2/fwvGuW8+fqvXWwr9afKjU92759lhsHUA4wl
 RBx37ENNE2VVXqBl/1+E5lnqeiMV7XzFTbB0ZX/BAuSAwgWxtNIM1WImUuzal65pnUCZsmAJiuQRG
 RVpm51l2rfFMJ8zg=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIP7u-0004gW-Ag for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 11:32:38 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso607478f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 04:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792323144; x=1792927944; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LbRXWw2ipGbH+UQ5aUKTIZ1nVoM1mMHX3Z7kfM7/DnY=;
 b=eDoAKvZuqe6N2/xXg2ieoveonayg4Ziy0M/Xfvbzis+YAuuTgc8mB48vaCE5edGBou
 vT7c2l+yrXn3Gmq6HIgcnZ+/pVAE3qh98GXvxc02wfABWlITo7WC4b5UqpfiX4BwNRw/
 p9D/OA1QZ8pIoLvesZs4psY2hBdgiFnjzjz6gwwjLapmhy7DCltUxxNJ7w9+qh8v/8m/
 GicJoAkoMGHSEyzMEuRf/THCumUqPaEyge1caOf2/PWMHlLJCNdjr+ZOuMr2iaikXq8E
 Uft+iqXnsA7h2JuqJ9cTu8LmvjAhD7o9yKVpoJTl/Xfft6QRBvQv04B84gXOEGXkxl1V
 UnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792323144; x=1792927944;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LbRXWw2ipGbH+UQ5aUKTIZ1nVoM1mMHX3Z7kfM7/DnY=;
 b=snggEN6E8J/mWIqa6L6k0oI4m3ZcDJmjucvPV8kW+mqdj1viSX/tB+JxR5xUmVUk4+
 spgfCCb65/pvN6xVNZAfM4Kr8JKhToseiqVFLgmuh3rxduYF60K0+HoMNbAZyH6SAEDA
 Hka2TYmEuzLeKWGAgnlJ45/OnY7/tgq61EVDxvAMn+5U3h1a4WmipUzxT6S0tkWdYbVq
 uf0h36yN/xcaNWfbL1QoxQSVQvgN4GWOLJTabX+BXmj8XCcRivbuVSzpqqp7IwspFG3+
 49qYFpnSLy2Jp0uLM7eJWGRxWaiIHMUlcTox8TTXXWYKsp05PqjZj6aV1W3uqTqZpY5j
 kebg==
X-Gm-Message-State: AFq9FYJSfwOoMdi4ZwqS1vzWA1zdgVNA6/bqsNFoatoRQZj0UBDuiYkq
 GvktlAjxQQwUUKgthOh2TwzJemBC7oTxYdHBANNqrC7AcJq0mYkt0i4HBq+uzTipfOM72yJ65xs
 x078A3SBp7yUD4eouax9D3PB7ARFx4lKndn16aADw3n2fb7mMHoVO8wtxbIZp+IyCL+s2w90uQU
 12Sm6WkQ==
X-Gm-Gg: AYBFou1/OrZlayOD3bSrS2iXWnAZ8cAvt2tPsKy7MDp67tiX7LC6qoS9n7wJE+IO72N
 +TJR3M3CGbZR29phO3ZJPClwLhxLyb7Jzm0iGigbHmJB47qdjKVNMu4gPGt4am1ak/lW0oz+Syc
 VSPh0qae47WfwJlP6jJdPpa92Y2bgJYg0XX2JI3PhOoy+rQSGCBFn1/AOVhvtQ03dGDI0jYUqXg
 Mfc9INox7rJLF7x0IRzffDBkJ+/Agtg+fylmfWl/aJZr4SkWA/U7LczUxf4Ee0YtR6HHhWaDaii
 vxfleZGK0f9HyC8kTDWKHzy7EBd0Dvj7WhPZrLL2qTxe+zTskQBp4GTGU64VM6tlQn7M18dtY0x
 z4Z5norY52a259dQ6AZ7vaEMeysCuYiGwaY//5981NLpaakqoBSmaAZ3JqKw1kdYp0IZFM4azVc
 C28luBjCnWeWQtBwvBtkhL24rETSvysOKJ85PoIonwxFDR8MRP6ID08/tOJaryj7zJEKDTDzyPR
 REVL9FWGlFctbRZ2D/4J+qESzotWXs2cc0XAt/xqqVwgbTiM4jPuvGGlNiWqFzrbs0umbEJiTDt
 LJaGKWGoZzTfQvjC9ivj5WKMWKx+ncgNkL06VXudZbfQ9K7pT8/SxZ5OsrLu6A==
X-Received: by 2002:a05:600c:a10c:b0:4a0:1a7f:2abb with SMTP id
 5b1f17b1804b1-4a1d75fe221mr76872885e9.11.1792323143207; 
 Sun, 18 Oct 2026 04:32:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8ad6245sm202322225e9.3.2026.10.18.04.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 04:32:22 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 11:32:19 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
X-Gerrit-Change-Number: 1783
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1783?usp=email>
X-Gerrit-Commit: 9cb5d3bc93878e351b5f822e8ff2ddd21dddf0f6
In-Reply-To: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
References: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLklhMWU3ZGI5NTYxNWQ5OWVmOTY4N2RlN2M0ZTk5NmRjODAzM2UyNjMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a336240704d661da0554aa28715a5d7adfa55d22-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIP7u-0004gW-Ag
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6102885188806618541=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6102885188806618541==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1QM8jUtpgpk="; charset=UTF-8

--1QM8jUtpgpk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, Fran=
k Lichtenheld=2E

Hello Arne Schwabe, Frank Lichtenheld, Gert Doering, 

I'=
d like you to reexamine a change=2E Please visit

    https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1783?usp=3Demail

to look at the new patch set (#7)=
=2E


Change subject: multi: assign clients from a named, tagged subnet-poo=
l
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: ass=
ign clients from a named, tagged subnet-pool

Add two server directives:

 =
 subnet-pool <tag> <network> <netmask> [<gateway>]   (main config)
  subnet=
-pool-tag <tag>                               (per-client CCD)

so groups o=
f clients can be given addresses from subnets other than the
--server netwo=
rk (per-group firewall rules under --topology subnet, and
thus DCO)=2E A cl=
ient's subnet-pool-tag is resolved to its pool and served
a virtual IP from=
 that subnet: a static --ifconfig-push within it, or the
next free address =
from a dynamic per-group pool shared by tag=2E Such a
client is validated a=
gainst its own subnet instead of the global
tunnel-network constraint and n=
ever falls back to the global pool; a tag
matching no configured pool is de=
clined with AUTH_FAILED=2E The tag is
resolved again after every client-con=
nect handler, so a script, plugin
or management interface may override the =
one set by the CCD file=2E

The pools are checked when the config is loaded=
, as for --server: the
netmask must be contiguous and between /16 and /29, =
the gateway a host
address inside the subnet, tags unique, and no pool may =
overlap another
or the --server network=2E Every pool is created at startup=
, and its
gateway is reserved so it is never handed out to a client=2E

The=
 server routes each pool's subnet into its tun device, as the device
is onl=
y configured with the --server network: without this the server
cannot reac=
h its subnet-pool clients=2E This is a regular --route, so it
is installed =
before privileges are dropped and honours --route-table,
--route-metric and=
 --route-noexec=2E Under DCO on Linux and FreeBSD,
though, the kernel selec=
ts the peer by the route's next hop, so a route
via a gateway would deliver=
 every packet for an unassigned pool address
to the client owning that gate=
way address: there the route is installed
on-link on the tun device instead=
 (a new on_link route option flag), and
each client of the pool gets its ow=
n on-link host route on connect (as
its address is outside the --ifconfig n=
etwork), so such packets match
no peer=2E

Change-Id: Ia1e7db95615d99ef9687=
de7c4e996dc8033e2631
GitHub: closes openvpn/OpenVPN#987
Signed-off-by: Anto=
nio Quartulli <antonio@mandelbit=2Ecom>
---
M CMakeLists=2Etxt
M doc/man-se=
ctions/server-options=2Erst
M src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh=

M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M src/openvpn/options_=
util=2Ec
M src/openvpn/options_util=2Eh
M src/openvpn/pool=2Ec
M src/openvp=
n/pool=2Eh
M src/openvpn/route=2Ec
M src/openvpn/route=2Eh
M tests/unit_tes=
ts/openvpn/Makefile=2Eam
A tests/unit_tests/openvpn/test_subnet_pool=2Ec
14=
 files changed, 676 insertions(+), 15 deletions(-)


  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/83/1783/7

diff --git a/CMakeL=
ists=2Etxt b/CMakeLists=2Etxt
index b286ee2=2E=2E4e87a6a 100644
--- a/CMake=
Lists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -694,6 +694,7 @@
         "test_provi=
der"
         "test_socket"
         "test_ssl"
+        "test_subnet_pool"=

         "test_user_pass"
         "test_push_update_msg"
         )
@@ -8=
68,6 +869,11 @@
         src/openvpn/session_id=2Ec
     )
 
+    target_so=
urces(test_subnet_pool PRIVATE
+        tests/unit_tests/openvpn/mock_get_r=
andom=2Ec
+        src/openvpn/options_util=2Ec
+        )
+
     target_so=
urces(test_ncp PRIVATE
         src/openvpn/crypto_epoch=2Ec
         src/o=
penvpn/crypto_mbedtls=2Ec
diff --git a/doc/man-sections/server-options=2Ers=
t b/doc/man-sections/server-options=2Erst
index 9dfa6bd=2E=2Ed868d09 100644=

--- a/doc/man-sections/server-options=2Erst
+++ b/doc/man-sections/server-=
options=2Erst
@@ -330,6 +330,41 @@
   by ``--ifconfig``, OpenVPN will insta=
ll a /32 host route for the ``local``
   IP address=2E
 
+--subnet-pool arg=
s
+  Define a named pool of addresses from a subnet different from the
+  `=
`--server`` network, so groups of clients can be given IPs from separate
+ =
 subnets for per-group firewall rules under ``--topology subnet`` (and
+  t=
herefore DCO)=2E This is a main-config directive and may be repeated to
+  =
define several pools=2E
+
+  Valid syntax:
+  ::
+
+     subnet-pool tag ne=
twork netmask [gateway]
+
+  ``tag`` is a name a client refers to with ``--=
subnet-pool-tag``; ``gateway``
+  defaults to the first address of ``networ=
k``/``netmask`` and is never
+  assigned to a client=2E A client assigned t=
o a pool receives (dynamically, or
+  via a static ``--ifconfig-push`` that=
 must lie within the subnet) an address
+  from it, plus the matching netma=
sk=2E
+
+  Requires ``--server`` with ``--dev tun`` and ``--topology subnet=
``=2E
+  ``netmask`` must be between /16 and /29 (as for ``--server``), ``g=
ateway``
+  must be a host address inside the subnet, each ``tag`` may be d=
efined only
+  once and no pool may overlap another one or the ``--server``=
 network=2E
+
+  The server routes each pool's subnet into the tun device, =
as it does for
+  the ``--server`` network; no ``--route`` needs to be adde=
d for it=2E These
+  routes honour ``--route-table`` and ``--route-metric``=
=2E With DCO on Linux
+  and FreeBSD the IPv4 route is installed on-link, w=
ithout a gateway, so its
+  ``route_gateway_{n}`` is not set for ``--route-=
up`` scripts=2E
+
+--subnet-pool-tag tag
+  Assign this client to the ``--s=
ubnet-pool`` named ``tag``=2E Must be
+  associated with a specific client =
instance via ``--client-config-dir`` or
+  ``--client-connect``=2E Several =
clients may reference the same tag and are
+  then served from the same sha=
red pool=2E
+
 --ifconfig-ipv6-push args
   for ``--client-config-dir`` per=
-client static IPv6 interface
   configuration, see ``--client-config-dir``=
 and ``--ifconfig-push`` for
diff --git a/src/openvpn/multi=2Ec b/src/openv=
pn/multi=2Ec
index a2cfdbf=2E=2E12b7442 100644
--- a/src/openvpn/multi=2Ec
=
+++ b/src/openvpn/multi=2Ec
@@ -43,6 +43,7 @@
 #include "auth_token=2Eh"
 #=
include "route=2Eh"
 #include "sid_hash=2Eh"
+#include "options_util=2Eh"
 =
#include <inttypes=2Eh>
 #include <string=2Eh>
 
@@ -54,6 +55,20 @@
 #inclu=
de "dco=2Eh"
 #include "reflect_filter=2Eh"
 
+/*
+ * Dynamic address pool =
serving the clients of one --subnet-pool tag=2E  Shared
+ * by every client=
 that references the tag, created on first use=2E
+ */
+struct subnet_pool
=
+{
+    struct subnet_pool *next;
+    const char *tag;
+    struct ifconfi=
g_pool *pool;
+};
+
+static struct ifconfig_pool *multi_get_group_pool(stru=
ct multi_context *m,
+                                                  con=
st struct options *o, const char *tag);
+
 /*#define MULTI_DEBUG_EVENT_LOOP=
*/
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
@@ -371,6 +386,13 @@
         }
     }
=
 
+    /* create every --subnet-pool group up front rather than on first us=
e, so
+     * that its pool exists before any client of the group connects =
*/
+    for (const struct subnet_pool_def *d =3D t->options=2Esubnet_pools;=
 d; d =3D d->next)
+    {
+        multi_get_group_pool(m, &t->options, d->=
tag);
+    }
+
     /*
      * Help us keep track of routing table=2E
     =
 */
@@ -625,7 +647,8 @@
 
         schedule_remove_entry(m->schedule, (stru=
ct schedule_entry *)mi);
 
-        ifconfig_pool_release(m->ifconfig_pool,=
 mi->vaddr_handle, false);
+        ifconfig_pool_release(mi->vaddr_pool ? =
mi->vaddr_pool : m->ifconfig_pool, mi->vaddr_handle,
+                     =
         false);
 
         if (mi->did_iroutes)
         {
@@ -707,6 +730,=
14 @@
         schedule_free(m->schedule);
         mbuf_free(m->mbuf);
   =
      ifconfig_pool_free(m->ifconfig_pool);
+        while (m->subnet_pools=
)
+        {
+            struct subnet_pool *sp =3D m->subnet_pools;
+
+  =
          m->subnet_pools =3D sp->next;
+            ifconfig_pool_free(sp-=
>pool);
+            free(sp);
+        }
         frequency_limit_free(m->=
new_connection_limiter);
         initial_rate_limit_free(m->initial_rate_l=
imiter);
         multi_reap_free(m->reaper);
@@ -1405,6 +1436,12 @@
     c=
onst struct options *o =3D &c->options;
     if (o->push_ifconfig_constrain=
t_defined && c->c2=2Epush_ifconfig_defined)
     {
+        /* a subnet-poo=
l client is validated against its own subnet */
+        if (o->subnet_pool=
_defined)
+        {
+            return (o->subnet_pool_netmask & c->c2=2E=
push_ifconfig_local)
+                   =3D=3D o->subnet_pool_network;
+  =
      }
         return (o->push_ifconfig_constraint_netmask & c->c2=2Epush=
_ifconfig_local)
                =3D=3D o->push_ifconfig_constraint_network=
;
     }
@@ -1415,6 +1452,37 @@
 }
 
 /*
+ * Return the dynamic pool servin=
g the clients tagged with <tag>, creating it
+ * on first use from the matc=
hing --subnet-pool definition in <o>=2E
+ */
+static struct ifconfig_pool *=

+multi_get_group_pool(struct multi_context *m, const struct options *o, co=
nst char *tag)
+{
+    struct subnet_pool *sp;
+
+    for (sp =3D m->subnet=
_pools; sp; sp =3D sp->next)
+    {
+        if (!strcmp(sp->tag, tag))
+  =
      {
+            return sp->pool;
+        }
+    }
+
+    const struct=
 subnet_pool_def *d4 =3D subnet_pool_by_tag(o->subnet_pools, tag);
+    ASS=
ERT(d4);
+    ALLOC_OBJ_CLEAR(sp, struct subnet_pool);
+    sp->tag =3D d4-=
>tag;
+    /* every host address of the subnet, minus the gateway reserved =
below */
+    sp->pool =3D ifconfig_pool_init(true, IFCONFIG_POOL_INDIV, d4=
->network + 1,
+                                  (d4->network | ~d4->netma=
sk) - 1, o->duplicate_cn, false,
+                                  in6addr=
_any, 0);
+    ifconfig_pool_reserve_ip(sp->pool, d4->gateway);
+    sp->ne=
xt =3D m->subnet_pools;
+    m->subnet_pools =3D sp;
+    return sp->pool;
=
+}
+
+/*
  * Select a virtual address for a new client instance=2E
  * Use =
an --ifconfig-push directive, if given (static IP)=2E
  * Otherwise use an =
--ifconfig-pool address (dynamic IP)=2E
@@ -1424,6 +1492,25 @@
 {
     stru=
ct gc_arena gc =3D gc_new();
 
+    /* resolve --subnet-pool-tag against th=
e main-config --subnet-pool list (an
+     * unknown tag is rejected with A=
UTH_FAILED in multi_connection_established)=2E
+     * This runs again afte=
r every client-connect handler, and a later handler
+     * (script, plugin=
, management) may override the tag set by the CCD file,
+     * so always r=
esolve the current tag=2E */
+    if (mi->context=2Eoptions=2Esubnet_pool_t=
ag)
+    {
+        const struct subnet_pool_def *d =3D
+            subnet=
_pool_by_tag(m->top=2Eoptions=2Esubnet_pools, mi->context=2Eoptions=2Esubne=
t_pool_tag);
+
+        mi->context=2Eoptions=2Esubnet_pool_defined =3D d !=
=3D NULL;
+        if (d)
+        {
+            mi->context=2Eoptions=2Es=
ubnet_pool_network =3D d->network;
+            mi->context=2Eoptions=2Esub=
net_pool_netmask =3D d->netmask;
+            mi->context=2Eoptions=2Esubne=
t_pool_gateway =3D d->gateway;
+        }
+    }
+
     /*
      * If ifcon=
fig addresses were set by dynamic config file,
      * release pool address=
es, otherwise keep them=2E
@@ -1434,8 +1521,10 @@
          * release dynam=
ic allocation */
         if (mi->vaddr_handle >=3D 0)
         {
-        =
    ifconfig_pool_release(m->ifconfig_pool, mi->vaddr_handle, true);
+     =
       ifconfig_pool_release(mi->vaddr_pool ? mi->vaddr_pool : m->ifconfig_=
pool,
+                                  mi->vaddr_handle, true);
         =
    mi->vaddr_handle =3D -1;
+            mi->vaddr_pool =3D NULL;
        =
 }
 
         mi->context=2Ec2=2Epush_ifconfig_defined =3D true;
@@ -1455,6=
 +1544,52 @@
                 "MULTI_sva: WARNING: if --ifconfig-push is us=
ed for IPv4, automatic IPv6 assignment from --ifconfig-ipv6-pool does not w=
ork=2E  Use --ifconfig-ipv6-push for IPv6 then=2E");
         }
     }
+   =
 else if (mi->context=2Eoptions=2Esubnet_pool_defined)
+    {
+        /* d=
ynamic address from this client's --subnet-pool group */
+        struct if=
config_pool *group =3D
+            multi_get_group_pool(m, &m->top=2Eoptio=
ns, mi->context=2Eoptions=2Esubnet_pool_tag);
+
+        /* the address may=
 have been acquired before the tag was known (from
+         * the global p=
ool) or for a tag that a later handler overrode: drop
+         * it so we =
serve this client from its current group */
+        if (mi->vaddr_handle >=
=3D 0 && mi->vaddr_pool !=3D group)
+        {
+            ifconfig_pool_r=
elease(mi->vaddr_pool ? mi->vaddr_pool : m->ifconfig_pool,
+               =
                   mi->vaddr_handle, true);
+            mi->vaddr_handle =
=3D -1;
+            mi->vaddr_pool =3D NULL;
+            /* both addresse=
s of the dropped slot go back to its pool */
+            mi->context=2Ec2=
=2Epush_ifconfig_defined =3D false;
+            mi->context=2Ec2=2Epush_if=
config_ipv6_defined =3D false;
+        }
+
+        if (mi->vaddr_handle <=
 0)
+        {
+            in_addr_t local =3D 0, remote =3D 0;
+         =
   const char *cn =3D NULL;
+
+            if (!mi->context=2Eoptions=2Edup=
licate_cn)
+            {
+                cn =3D tls_common_name(mi->conte=
xt=2Ec2=2Etls_multi, true);
+            }
+
+            mi->vaddr_pool =
=3D group;
+            mi->vaddr_handle =3D ifconfig_pool_acquire(mi->vadd=
r_pool, &local, &remote, NULL, cn);
+            if (mi->vaddr_handle >=3D =
0)
+            {
+                mi->context=2Ec2=2Epush_ifconfig_local =
=3D remote;
+                mi->context=2Ec2=2Epush_ifconfig_remote_netmas=
k =3D
+                    mi->context=2Eoptions=2Esubnet_pool_netmask;
+  =
              mi->context=2Ec2=2Epush_ifconfig_defined =3D true;
+         =
   }
+            else
+            {
+                msg(D_MULTI_ERRORS, =
"MULTI: no free --subnet-pool addresses are available for %s",
+           =
         multi_instance_string(mi, false, &gc));
+            }
+        }
=
+    }
     else if (m->ifconfig_pool && mi->vaddr_handle < 0) /* otherwise=
, choose a pool address */
     {
         in_addr_t local =3D 0, remote =
=3D 0;
@@ -2360,10 +2495,9 @@
         const char *ifconfig_constraint_netm=
ask =3D
             print_in_addr_t(mi->context=2Eoptions=2Epush_ifconfig_=
constraint_netmask, 0, &gc);
 
-        /* JYFIXME -- this should cause the=
 connection to fail */
         msg(D_MULTI_ERRORS,
-            "MULTI ERR=
OR: primary virtual IP for %s (%s) "
-            "violates tunnel network/=
netmask constraint (%s/%s)",
+            "WARNING: primary virtual IP for =
%s (%s) "
+            "violates tunnel network/netmask constraint (%s/%s) =
and may not work",
             multi_instance_string(mi, false, &gc),
    =
         print_in_addr_t(mi->context=2Ec2=2Epush_ifconfig_local, 0, &gc),
 =
            ifconfig_constraint_network, ifconfig_constraint_netmask);
@@ -=
2471,6 +2605,7 @@
 
     /* reset pool handle to null */
     mi->vaddr_han=
dle =3D -1;
+    mi->vaddr_pool =3D NULL;
 
     /* do --client-connect set=
envs */
     multi_select_virtual_addr(m, mi);
@@ -2792,6 +2927,15 @@
     =
    cc_succeeded =3D false;
     }
 
+    if (mi->context=2Eoptions=2Esubne=
t_pool_tag
+        && !subnet_pool_by_tag(m->top=2Eoptions=2Esubnet_pools,=
 mi->context=2Eoptions=2Esubnet_pool_tag))
+    {
+        msg(D_MULTI_ERRO=
RS, "MULTI: client has been rejected due to unknown --subnet-pool-tag '%s'"=
,
+            mi->context=2Eoptions=2Esubnet_pool_tag);
+        auth_set_=
client_reason(mi->context=2Ec2=2Etls_multi, "unknown subnet-pool-tag");
+  =
      cc_succeeded =3D false;
+    }
+
     if (cc_succeeded)
     {
      =
   multi_client_connect_late_setup(m, mi, *option_types_found);
diff --git =
a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 5db7147=2E=2E14f71dd =
100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -121,6 +1=
21,8 @@
     struct mroute_addr real; /**< External network address of the
=
                               *   remote peer=2E */
     ifconfig_pool_han=
dle vaddr_handle;
+    /* pool vaddr_handle belongs to (NULL =3D the global=
 one) */
+    struct ifconfig_pool *vaddr_pool;
     char msg_prefix[MULTI_=
PREFIX_MAX_LENGTH];
 
     /* queued outgoing data in Server/TCP mode */
@@=
 -190,6 +192,8 @@
                                         *   instances=2E=
 */
     struct multi_io *multi_io;         /**< I/O state and events track=
er */
     struct ifconfig_pool *ifconfig_pool;
+    /* per-group --subnet-=
pool dynamic pools */
+    struct subnet_pool *subnet_pools;
     struct fr=
equency_limit *new_connection_limiter;
     struct initial_packet_rate_limi=
t *initial_rate_limiter;
     struct mroute_helper *route_helper;
diff --gi=
t a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 7fc8614=2E=2Ed5=
666b8 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@=
 -452,6 +452,11 @@
     "                  If seconds=3D0, file will be tre=
ated as read-only=2E\n"
     "--ifconfig-ipv6-pool base-IP/bits : set aside=
 an IPv6 network block\n"
     "                  to be dynamically allocat=
ed to connecting clients=2E\n"
+    "--subnet-pool tag network netmask [gat=
eway] : Define a named pool of\n"
+    "                  addresses outside=
 the --server network, selected per\n"
+    "                  client with =
--subnet-pool-tag=2E\n"
+    "--subnet-pool-tag tag : Assign this client to=
 the --subnet-pool named tag=2E\n"
+    "                  Only valid in a =
client-specific config file=2E\n"
     "--ifconfig-push local remote-netmas=
k : Push an ifconfig option to remote,\n"
     "                  overrides=
 --ifconfig-pool dynamic allocation=2E\n"
     "                  Only vali=
d in a client-specific config file=2E\n"
@@ -1925,6 +1930,20 @@
         {
=
             msg(M_USAGE, "--ifconfig-ipv6-pool needs --ifconfig-ipv6");
  =
       }
+        if (options->subnet_pools)
+        {
+            if (!o=
ptions->server_defined)
+            {
+                msg(M_USAGE, "--sub=
net-pool requires --server");
+            }
+            if (dev_type_enum=
(options->dev, options->dev_type) !=3D DEV_TYPE_TUN
+                || opt=
ions->topology !=3D TOP_SUBNET)
+            {
+                msg(M_USAGE=
, "--subnet-pool requires --dev tun and --topology subnet");
+            }=

+            subnet_pools_check(options->subnet_pools, options->server_net=
work,
+                               options->server_netmask, M_USAGE);
+ =
       }
         MUST_BE_UNDEF(allow_recursive_routing, "allow-recursive-r=
outing");
         if (options->auth_user_pass_file)
         {
@@ -1991,6 =
+2010,7 @@
         MUST_BE_UNDEF(ifconfig_pool_defined, "ifconfig-pool");
=
         MUST_BE_UNDEF(ifconfig_pool_persist_filename, "ifconfig-pool-persi=
st");
         MUST_BE_UNDEF(ifconfig_ipv6_pool_defined, "ifconfig-ipv6-poo=
l");
+        MUST_BE_UNDEF(subnet_pools, "subnet-pool");
         MUST_BE_=
UNDEF(real_hash_size, "hash-size");
         MUST_BE_UNDEF(virtual_hash_siz=
e, "hash-size");
         MUST_BE_UNDEF(learn_address_script, "learn-addres=
s");
@@ -3123,6 +3143,28 @@
     }
 }
 
+/*
+ * The server's tun device is =
only configured with the --server network, so
+ * route each --subnet-pool =
network into it as well: without this the server
+ * could not reach its su=
bnet-pool clients when the data channel runs in
+ * userspace=2E  Under DCO=
 on Linux and FreeBSD the routes are installed on-link,
+ * see subnet_pool=
_routes_onlink()=2E
+ */
+static void
+options_postprocess_subnet_pool_rout=
es(struct options *o)
+{
+    for (const struct subnet_pool_def *d =3D o->s=
ubnet_pools; d; d =3D d->next)
+    {
+        struct route_option *ro;
+
+=
        rol_check_alloc(o);
+        ro =3D add_route_to_option_list(o->rou=
tes, print_in_addr_t(d->network, 0, &o->gc),
+                             =
         print_in_addr_t(d->netmask, 0, &o->gc), NULL, NULL,
+             =
                         o->route_default_table_id);
+        ro->on_link =
=3D subnet_pool_routes_onlink(o);
+    }
+}
+
 static void
 options_postpro=
cess_mutate(struct options *o, struct env_set *es)
 {
@@ -3258,6 +3300,12 @=
@
         /* check if any option should force disabling DCO */
         o-=
>disable_dco =3D !dco_check_option(D_DCO, o) || !dco_check_startup_option(D=
_DCO, o);
     }
+
+    if (o->mode =3D=3D MODE_SERVER)
+    {
+        /* =
how the pools are routed depends on the DCO decision above */
+        opti=
ons_postprocess_subnet_pool_routes(o);
+    }
 #ifdef USE_COMP
     if (dco=
_enabled(o))
     {
@@ -6245,6 +6293,43 @@
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
+        sp->gateway =3D (network & netmask) + 1;
+        if =
(p[4])
+        {
+            bool ok =3D false;
+
+            sp->gatewa=
y =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[4], 0, &ok, NULL);
+ =
           if (!ok)
+            {
+                msg(msglevel, "cannot p=
arse --subnet-pool gateway");
+                goto err;
+            }
+  =
      }
+        sp->next =3D options->subnet_pools;
+        options->subn=
et_pools =3D sp;
+    }
+    else if (streq(p[0], "subnet-pool-tag") && p[1=
] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_INSTANCE);
+        opt=
ions->subnet_pool_tag =3D p[1];
+    }
     else if (streq(p[0], "ifconfig-=
push-constraint") && p[1] && p[2] && !p[3])
     {
         in_addr_t netwo=
rk, netmask;
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh=

index d347830=2E=2Eff26066 100644
--- a/src/openvpn/options=2Eh
+++ b/src/=
openvpn/options=2Eh
@@ -252,6 +252,17 @@
     struct verify_hash_list *next=
;
 };
 
+/* A named --subnet-pool: a subnet clients can be assigned from, r=
eferenced
+ * from a CCD file by its tag via --subnet-pool-tag=2E */
+struc=
t subnet_pool_def
+{
+    struct subnet_pool_def *next;
+    const char *ta=
g;
+    in_addr_t network;
+    in_addr_t netmask;
+    in_addr_t gateway;
=
+};
+
 /* Command line options */
 struct options
 {
@@ -518,6 +529,12 @@
 =
    bool push_ifconfig_constraint_defined;
     in_addr_t push_ifconfig_con=
straint_network;
     in_addr_t push_ifconfig_constraint_netmask;
+    stru=
ct subnet_pool_def *subnet_pools; /* named pools (server config) */
+    co=
nst char *subnet_pool_tag;          /* which pool this client uses (CCD) */=

+    bool subnet_pool_defined;             /* resolved from the tag at con=
nect */
+    in_addr_t subnet_pool_network;
+    in_addr_t subnet_pool_netm=
ask;
+    in_addr_t subnet_pool_gateway;
     bool push_ifconfig_ipv4_block=
ed;           /* IPv4 */
     bool push_ifconfig_ipv6_defined;           /*=
 IPv6 */
     struct in6_addr push_ifconfig_ipv6_local;  /* IPv6 */
@@ -978=
,4 +995,23 @@
 #endif /* ENABLE_DCO */
 }
 
+/**
+ * Whether the routes of =
the --subnet-pool networks are installed on-link on
+ * the DCO device rath=
er than via a gateway=2E  With DCO on Linux and FreeBSD the
+ * kernel sele=
cts the peer by a route's next hop, so a route via a gateway
+ * would deli=
ver every packet for an unassigned pool address to the client
+ * owning th=
at gateway address; on-link, such a packet matches no peer, while
+ * each =
pool client gets its own on-link host route when it connects (see
+ * multi=
_learn_in_addr_t())=2E
+ */
+static inline bool
+subnet_pool_routes_onlink(=
const struct options *o)
+{
+#if defined(TARGET_LINUX) || defined(TARGET_FR=
EEBSD)
+    return dco_enabled(o);
+#else
+    return false;
+#endif
+}
+
 =
#endif /* ifndef OPTIONS_H */
diff --git a/src/openvpn/options_util=2Ec b/s=
rc/openvpn/options_util=2Ec
index d25d85c=2E=2E744ad4c 100644
--- a/src/ope=
nvpn/options_util=2Ec
+++ b/src/openvpn/options_util=2Ec
@@ -30,6 +30,91 @@=

 #include "options_util=2Eh"
 
 #include "push=2Eh"
+#include "pool=2Eh"
+=

+const struct subnet_pool_def *
+subnet_pool_by_tag(const struct subnet_po=
ol_def *pools, const char *tag)
+{
+    for (const struct subnet_pool_def *=
d =3D pools; d; d =3D d->next)
+    {
+        if (!strcmp(d->tag, tag))
+ =
       {
+            return d;
+        }
+    }
+    return NULL;
+}
+
+/=
* true if the two IPv4 subnets share at least one address */
+static bool
+=
subnets_overlap(in_addr_t a, in_addr_t mask_a, in_addr_t b, in_addr_t mask_=
b)
+{
+    const in_addr_t mask =3D mask_a & mask_b;
+
+    return (a & mas=
k) =3D=3D (b & mask);
+}
+
+bool
+subnet_pools_check(const struct subnet_po=
ol_def *pools, in_addr_t server_network,
+                   in_addr_t serv=
er_netmask, msglvl_t msglevel)
+{
+    for (const struct subnet_pool_def *d=
 =3D pools; d; d =3D d->next)
+    {
+        const in_addr_t host =3D ~d->=
netmask;
+        int netbits =3D 32;
+
+        /* the netmask must be con=
tiguous */
+        if (host & (host + 1))
+        {
+            msg(msgl=
evel, "--subnet-pool %s: invalid netmask", d->tag);
+            return fal=
se;
+        }
+        for (in_addr_t h =3D host; h; h >>=3D 1)
+        {=

+            netbits--;
+        }
+
+        /* same bounds as --server: =
the pool must hold at least 2 addresses
+         * besides network, gatewa=
y and broadcast, and fit IFCONFIG_POOL_MAX */
+        if (netbits < IFCONF=
IG_POOL_MIN_NETBITS || netbits > 29)
+        {
+            msg(msglevel, =
"--subnet-pool %s: netmask must be between /%d and /29 (not /%d)",
+       =
         d->tag, IFCONFIG_POOL_MIN_NETBITS, netbits);
+            return f=
alse;
+        }
+
+        if ((d->gateway & d->netmask) !=3D d->network |=
| d->gateway =3D=3D d->network
+            || d->gateway =3D=3D (d->networ=
k | host))
+        {
+            msg(msglevel, "--subnet-pool %s: gateway=
 must be a host address inside the subnet",
+                d->tag);
+    =
        return false;
+        }
+
+        if (server_netmask
+           =
 && subnets_overlap(d->network, d->netmask, server_network, server_netmask)=
)
+        {
+            msg(msglevel, "--subnet-pool %s: subnet overlaps =
the --server network", d->tag);
+            return false;
+        }
+
+  =
      for (const struct subnet_pool_def *e =3D d->next; e; e =3D e->next)
+=
        {
+            if (!strcmp(d->tag, e->tag))
+            {
+       =
         msg(msglevel, "--subnet-pool %s: tag defined more than once", d->t=
ag);
+                return false;
+            }
+            if (subnets=
_overlap(d->network, d->netmask, e->network, e->netmask))
+            {
+ =
               msg(msglevel, "--subnet-pool %s and %s: subnets overlap", d-=
>tag, e->tag);
+                return false;
+            }
+        }
+  =
  }
+
+    return true;
+}
 
 const char *
 parse_auth_failed_temp(struct o=
ptions *o, const char *reason)
diff --git a/src/openvpn/options_util=2Eh b/=
src/openvpn/options_util=2Eh
index 5226a6f=2E=2Ed60759a 100644
--- a/src/op=
envpn/options_util=2Eh
+++ b/src/openvpn/options_util=2Eh
@@ -28,6 +28,31 @=
@
 
 const char *parse_auth_failed_temp(struct options *o, const char *reas=
on);
 
+/**
+ * Look up a named --subnet-pool in a list of pool definitions=
=2E
+ *
+ * @param pools  head of the --subnet-pool list (may be NULL)
+ * =
@param tag    the --subnet-pool-tag to match
+ * @return       the matching=
 pool definition, or NULL if none matches
+ */
+const struct subnet_pool_de=
f *subnet_pool_by_tag(const struct subnet_pool_def *pools,
+               =
                                  const char *tag);
+
+/**
+ * Validate the=
 --subnet-pool definitions: contiguous netmask between
+ * /IFCONFIG_POOL_M=
IN_NETBITS and /29, gateway a host address inside its
+ * subnet, unique ta=
gs, and no subnet overlapping another pool or the --server
+ * network=2E
+=
 *
+ * @param pools           head of the --subnet-pool list (may be NULL)
=
+ * @param server_network  the --server network (host order)
+ * @param ser=
ver_netmask  the --server netmask, or 0 if there is none
+ * @param msgleve=
l        level of the message logged on the first error
+ * @return        =
        true if every definition is valid
+ */
+bool subnet_pools_check(con=
st struct subnet_pool_def *pools, in_addr_t server_network,
+              =
          in_addr_t server_netmask, msglvl_t msglevel);
+
 
 /** Checks if =
the string is a valid integer by checking if it can be
  *  converted to an=
 integer */
diff --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec
index =
63fc930=2E=2Efa04d9c 100644
--- a/src/openvpn/pool=2Ec
+++ b/src/openvpn/po=
ol=2Ec
@@ -350,7 +350,7 @@
 {
     bool ret =3D false;
 
-    if (pool && h=
and >=3D 0 && hand < pool->size)
+    if (pool && hand >=3D 0 && hand < poo=
l->size && !pool->list[hand]=2Ereserved)
     {
         ifconfig_pool_entr=
y_free(&pool->list[hand], hard);
         ret =3D true;
@@ -429,6 +429,22 @=
@
     return ret;
 }
 
+bool
+ifconfig_pool_reserve_ip(struct ifconfig_poo=
l *pool, const in_addr_t addr)
+{
+    const ifconfig_pool_handle h =3D ifc=
onfig_pool_ip_base_to_handle(pool, addr);
+
+    if (h < 0)
+    {
+       =
 return false;
+    }
+
+    ifconfig_pool_entry_free(&pool->list[h], true)=
;
+    pool->list[h]=2Ein_use =3D true;
+    pool->list[h]=2Ereserved =3D t=
rue;
+    return true;
+}
+
 static in_addr_t
 ifconfig_pool_handle_to_ip_b=
ase(const struct ifconfig_pool *pool, ifconfig_pool_handle hand)
 {
@@ -476=
,6 +492,13 @@
                   const bool fixed)
 {
     struct ifconfig_=
pool_entry *e =3D &pool->list[h];
+
+    if (e->reserved)
+    {
+        m=
sg(M_WARN, "pool: ignoring persisted entry for CN=3D%s: its address is rese=
rved", cn);
+        return;
+    }
+
     ifconfig_pool_entry_free(e, true=
);
     e->in_use =3D false;
     e->common_name =3D string_alloc(cn, NULL)=
;
diff --git a/src/openvpn/pool=2Eh b/src/openvpn/pool=2Eh
index e2d3f82=2E=
=2E497dcda 100644
--- a/src/openvpn/pool=2Eh
+++ b/src/openvpn/pool=2Eh
@@ =
-43,6 +43,7 @@
     char *common_name;
     time_t last_release;
     bool =
fixed;
+    bool reserved; /* never handed out, e=2Eg=2E a --subnet-pool ga=
teway */
 };
 
 struct ifconfig_pool
@@ -86,6 +87,17 @@
 
 bool ifconfig_po=
ol_release(struct ifconfig_pool *pool, ifconfig_pool_handle hand, const boo=
l hard);
 
+/**
+ * Permanently reserve the pool slot holding \c addr, so t=
hat it is never
+ * handed out to a client nor taken over by a persisted en=
try (e=2Eg=2E the
+ * gateway of a --subnet-pool)=2E
+ *
+ * @param pool  t=
he pool
+ * @param addr  IPv4 address (host order) to reserve
+ * @return  =
    true if \c addr lies in the pool and was reserved
+ */
+bool ifconfig_p=
ool_reserve_ip(struct ifconfig_pool *pool, in_addr_t addr);
+
 struct ifcon=
fig_pool_persist *ifconfig_pool_persist_init(const char *filename, int refr=
esh_freq);
 
 void ifconfig_pool_persist_close(struct ifconfig_pool_persist=
 *persist);
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
inde=
x 9c80f3b=2E=2Ee1b3849 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn=
/route=2Ec
@@ -407,6 +407,11 @@
         r->flags |=3D RT_METRIC_DEFINED;
 =
    }
 
+    if (ro->on_link)
+    {
+        r->flags |=3D RT_ON_LINK;
+  =
  }
+
     r->flags |=3D RT_DEFINED;
 
     /* routing table id */
@@ -477,=
7 +482,7 @@
     return false;
 }
 
-void
+struct route_option *
 add_route=
_to_option_list(struct route_option_list *l, const char *network, const cha=
r *netmask,
                          const char *gateway, const char *metr=
ic, int table_id)
 {
@@ -488,8 +493,10 @@
     ro->gateway =3D gateway;
   =
  ro->metric =3D metric;
     ro->table_id =3D table_id;
+    ro->on_link =
=3D false;
     ro->next =3D l->routes;
     l->routes =3D ro;
+    return =
ro;
 }
 
 void
@@ -1321,7 +1328,11 @@
     {
         setenv_route_addr(es,=
 "network", r->network, i);
         setenv_route_addr(es, "netmask", r->ne=
tmask, i);
-        setenv_route_addr(es, "gateway", r->gateway, i);
+     =
   /* an on-link route has no gateway */
+        if (!(r->flags & RT_ON_LI=
NK))
+        {
+            setenv_route_addr(es, "gateway", r->gateway, i=
);
+        }
 
         if (r->flags & RT_METRIC_DEFINED)
         {
@@ -1=
477,6 +1488,7 @@
 
 #if defined(TARGET_LINUX)
     const char *iface =3D NU=
LL;
+    const in_addr_t *gateway =3D &r->gateway;
     int metric =3D -1;
=
 
     if (is_on_link(is_local_route, flags, rgi))
@@ -1484,6 +1496,12 @@
 =
        iface =3D rgi->iface;
     }
 
+    if ((r->flags & RT_ON_LINK) && =
tt)
+    {
+        gateway =3D NULL;
+        iface =3D tt->actual_name;
+=
    }
+
     if (r->flags & RT_METRIC_DEFINED)
     {
         metric =3D r=
->metric;
@@ -1491,8 +1509,8 @@
 
 
     status =3D RTA_SUCCESS;
-    int r=
et =3D net_route_v4_add(ctx, &r->network, netmask_to_netbits2(r->netmask), =
&r->gateway,
-                               iface, r->table_id, metric);
+=
    int ret =3D net_route_v4_add(ctx, &r->network, netmask_to_netbits2(r->n=
etmask), gateway, iface,
+                               r->table_id, metri=
c);
     if (ret =3D=3D -EEXIST)
     {
         msg(D_ROUTE, "NOTE: Linux =
route add command failed because route exists");
@@ -1615,7 +1633,15 @@
   =
  }
 #endif
 
-    argv_printf_cat(&argv, "-net %s %s %s", network, gateway=
, netmask);
+    if ((r->flags & RT_ON_LINK) && tt)
+    {
+        argv_pr=
intf_cat(&argv, "-net %s/%d -iface %s", network, netmask_to_netbits2(r->net=
mask),
+                        tt->actual_name);
+    }
+    else
+    {
+=
        argv_printf_cat(&argv, "-net %s %s %s", network, gateway, netmask);=

+    }
 
     /* FIXME -- add on-link support for FreeBSD */
 
@@ -2034,7 =
+2060,16 @@
         metric =3D r->metric;
     }
 
-    if (net_route_v4_d=
el(ctx, &r->network, netmask_to_netbits2(r->netmask), &r->gateway, NULL,
+ =
   const in_addr_t *gateway =3D &r->gateway;
+    const char *iface =3D NUL=
L;
+
+    if ((r->flags & RT_ON_LINK) && tt)
+    {
+        gateway =3D NU=
LL;
+        iface =3D tt->actual_name;
+    }
+
+    if (net_route_v4_del(=
ctx, &r->network, netmask_to_netbits2(r->netmask), gateway, iface,
        =
                  r->table_id, metric)
         < 0)
     {
@@ -2090,7 +212=
5,15 @@
 
 #elif defined(TARGET_FREEBSD)
 
-    argv_printf(&argv, "%s dele=
te -net %s %s %s", ROUTE_PATH, network, gateway, netmask);
+    if ((r->fla=
gs & RT_ON_LINK) && tt)
+    {
+        argv_printf(&argv, "%s delete -net =
%s/%d -iface %s", ROUTE_PATH, network,
+                    netmask_to_netb=
its2(r->netmask), tt->actual_name);
+    }
+    else
+    {
+        argv_p=
rintf(&argv, "%s delete -net %s %s %s", ROUTE_PATH, network, gateway, netma=
sk);
+    }
 
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&arg=
v, es, 0, "ERROR: FreeBSD route delete command failed");
diff --git a/src/o=
penvpn/route=2Eh b/src/openvpn/route=2Eh
index 0d33d36=2E=2E7c5528f 100644
=
--- a/src/openvpn/route=2Eh
+++ b/src/openvpn/route=2Eh
@@ -80,6 +80,10 @@
=
     const char *gateway;
     int table_id;
     const char *metric;
+    =
/* on Linux and FreeBSD, install the route on-link on the tun device
+     =
* instead of via the gateway (needed under DCO, where the kernel selects
+ =
    * the peer by the route's next hop) */
+    bool on_link;
 };
 
 /* red=
irect-gateway flags */
@@ -120,6 +124,7 @@
 #define RT_DEFINED        (1u <=
< 0)
 #define RT_ADDED          (1u << 1)
 #define RT_METRIC_DEFINED (1u <<=
 2)
+#define RT_ON_LINK        (1u << 3) /* see struct route_option=2Eon_li=
nk */
     struct route_ipv4 *next;
     unsigned int flags;
     const str=
uct route_option *option;
@@ -311,8 +316,9 @@
                const struct =
route_gateway_info *rgi, const struct env_set *es,
                openvpn_=
net_ctx_t *ctx);
 
-void add_route_to_option_list(struct route_option_list =
*l, const char *network, const char *netmask,
-                            =
  const char *gateway, const char *metric, int table_id);
+struct route_opt=
ion *add_route_to_option_list(struct route_option_list *l, const char *netw=
ork,
+                                              const char *netmask, co=
nst char *gateway,
+                                              const cha=
r *metric, int table_id);
 
 void add_route_ipv6_to_option_list(struct rout=
e_ipv6_option_list *l, const char *prefix,
                                =
    const char *gateway, const char *metric, int table_id);
diff --git a/te=
sts/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2E=
am
index 38299f5=2E=2E78f4b6c 100644
--- a/tests/unit_tests/openvpn/Makefil=
e=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -21,6 +21,7 @@
 	pus=
h_update_msg_testdriver \
 	socket_testdriver \
 	ssl_testdriver \
+	subnet=
_pool_testdriver \
 	user_pass_testdriver
 
 if HAVE_LD_WRAP_SUPPORT
@@ -38=
4,6 +385,19 @@
 	$(top_srcdir)/src/openvpn/platform=2Ec \
 	$(top_srcdir)/s=
rc/openvpn/mbuf=2Ec
 
+subnet_pool_testdriver_CFLAGS  =3D \
+	-I$(top_srcdi=
r)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	@TEST=
_CFLAGS@
+
+subnet_pool_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
+
+subnet_poo=
l_testdriver_SOURCES =3D test_subnet_pool=2Ec \
+	mock_msg=2Ec test_common=
=2Eh \
+	mock_get_random=2Ec \
+	$(top_srcdir)/src/openvpn/buffer=2Ec \
+	$=
(top_srcdir)/src/openvpn/options_util=2Ec \
+	$(top_srcdir)/src/openvpn/pla=
tform=2Ec
+
 misc_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I$(to=
p_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	-DSOURCEDIR=3D\"$(top_=
srcdir)\" @TEST_CFLAGS@
diff --git a/tests/unit_tests/openvpn/test_subnet_p=
ool=2Ec b/tests/unit_tests/openvpn/test_subnet_pool=2Ec
new file mode 10064=
4
index 0000000=2E=2E5ce4c76
--- /dev/null
+++ b/tests/unit_tests/openvpn/t=
est_subnet_pool=2Ec
@@ -0,0 +1,143 @@
+/*
+ *  OpenVPN -- An application to=
 securely tunnel IP networks
+ *             over a single UDP port, with s=
upport for SSL/TLS-based
+ *             session authentication and key exc=
hange,
+ *             packet encryption, packet authentication, and
+ *   =
          packet compression=2E
+ *
+ *  Copyright (C) 2026 OpenVPN Inc <sa=
les@openvpn=2Enet>
+ *
+ *  This program is free software; you can redistri=
bute it and/or modify
+ *  it under the terms of the GNU General Public Lic=
ense version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *=
  This program is distributed in the hope that it will be useful,
+ *  but =
WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABI=
LITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Publi=
c License for more details=2E
+ *
+ *  You should have received a copy of t=
he GNU General Public License along
+ *  with this program; if not, see <ht=
tps://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include =
"config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdlib=2Eh>
+#i=
nclude <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "options=2Eh"
+#incl=
ude "options_util=2Eh"
+#include "test_common=2Eh"
+#include "mock_msg=2Eh"=

+
+/* --subnet-pool-tag resolves a client to its --subnet-pool; an unknown=
 tag
+ * returns NULL, which is what makes the server reject that client=2E=
 */
+static void
+test_subnet_pool_by_tag(void **state)
+{
+    struct subn=
et_pool_def c =3D { =2Enext =3D NULL, =2Etag =3D "grpC", =2Enetwork =3D 0x0=
a020300, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a020301 };
+    struc=
t subnet_pool_def b =3D { =2Enext =3D &c, =2Etag =3D "grpB", =2Enetwork =3D=
 0x0a020200, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a020201 };
+    s=
truct subnet_pool_def a =3D { =2Enext =3D &b, =2Etag =3D "grpA", =2Enetwork=
 =3D 0x0a020100, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a020101 };
+
=
+    /* every configured tag resolves to its own pool, wherever it sits */
=
+    assert_ptr_equal(subnet_pool_by_tag(&a, "grpA"), &a);
+    assert_ptr_=
equal(subnet_pool_by_tag(&a, "grpB"), &b);
+    assert_ptr_equal(subnet_poo=
l_by_tag(&a, "grpC"), &c);
+
+    /* and it carries that pool's subnet/gate=
way */
+    const struct subnet_pool_def *r =3D subnet_pool_by_tag(&a, "grp=
B");
+    assert_int_equal(r->network, 0x0a020200);
+    assert_int_equal(r=
->netmask, 0xffffff00);
+    assert_int_equal(r->gateway, 0x0a020201);
+
+ =
   /* unknown tag and empty list both miss */
+    assert_null(subnet_pool_=
by_tag(&a, "nope"));
+    assert_null(subnet_pool_by_tag(NULL, "grpA"));
+}=

+
+/* a single pool <net>/<mask> with gateway <gw>, checked against the
+ =
* 10=2E8=2E0=2E0/24 --server network */
+static bool
+check_one(in_addr_t n=
et, in_addr_t mask, in_addr_t gw)
+{
+    struct subnet_pool_def d =3D { =
=2Enext =3D NULL, =2Etag =3D "grp", =2Enetwork =3D net, =2Enetmask =3D mask=
, =2Egateway =3D gw };
+
+    return subnet_pools_check(&d, 0x0a080000, 0xf=
fffff00, M_WARN);
+}
+
+/* --subnet-pool geometry: anything ifconfig_pool_i=
nit() cannot serve must be
+ * refused when the config is checked, not when=
 the first client connects */
+static void
+test_subnet_pools_check_netmask=
(void **state)
+{
+    /* the bounds of --server: /16 =2E=2E /29 */
+    as=
sert_true(check_one(0x0a090000, 0xffff0000, 0x0a090001));
+    assert_true(=
check_one(0x0a090000, 0xffffff00, 0x0a090001));
+    assert_true(check_one(=
0x0a090000, 0xfffffff8, 0x0a090001));
+    /* /30, /31, /32: too few addres=
ses for a pool */
+    assert_false(check_one(0x0a090000, 0xfffffffc, 0x0a0=
90001));
+    assert_false(check_one(0x0a090000, 0xfffffffe, 0x0a090001));
=
+    assert_false(check_one(0x0a090000, 0xffffffff, 0x0a090000));
+    /* /=
15: larger than IFCONFIG_POOL_MAX */
+    assert_false(check_one(0x0a080000=
, 0xfffe0000, 0x0a080001));
+    /* non-contiguous netmask */
+    assert_f=
alse(check_one(0x0a000900, 0xff00ff00, 0x0a000901));
+}
+
+static void
+tes=
t_subnet_pools_check_gateway(void **state)
+{
+    /* any host address of t=
he subnet is fine, not only the first one */
+    assert_true(check_one(0x0=
a090000, 0xffffff00, 0x0a0900fe));
+    assert_true(check_one(0x0a090000, 0=
xffffff00, 0x0a090080));
+    /* network address, broadcast address, outsid=
e the subnet */
+    assert_false(check_one(0x0a090000, 0xffffff00, 0x0a090=
000));
+    assert_false(check_one(0x0a090000, 0xffffff00, 0x0a0900ff));
+ =
   assert_false(check_one(0x0a090000, 0xffffff00, 0x0a0a0001));
+}
+
+stati=
c void
+test_subnet_pools_check_overlap(void **state)
+{
+    struct subnet=
_pool_def b =3D { =2Enext =3D NULL, =2Etag =3D "grpB", =2Enetwork =3D 0x0a0=
a0000, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a0a0001 };
+    struct =
subnet_pool_def a =3D { =2Enext =3D &b, =2Etag =3D "grpA", =2Enetwork =3D 0=
x0a090000, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a090001 };
+
+    /=
* disjoint pools, disjoint from --server */
+    assert_true(subnet_pools_c=
heck(&a, 0x0a080000, 0xffffff00, M_WARN));
+
+    /* a pool inside the --se=
rver network =2E=2E=2E */
+    assert_false(subnet_pools_check(&a, 0x0a0900=
00, 0xffffff00, M_WARN));
+    /* =2E=2E=2E or covering it */
+    assert_f=
alse(subnet_pools_check(&a, 0x0a0a0080, 0xffffff80, M_WARN));
+    /* no --=
server network: only the pools are checked against each other */
+    asser=
t_true(subnet_pools_check(&a, 0, 0, M_WARN));
+
+    /* a /16 grpB containi=
ng grpA */
+    struct subnet_pool_def b16 =3D { =2Enext =3D NULL, =2Etag =
=3D "grpB", =2Enetwork =3D 0x0a090000, =2Enetmask =3D 0xffff0000, =2Egatewa=
y =3D 0x0a090101 };
+    struct subnet_pool_def a16 =3D { =2Enext =3D &b16,=
 =2Etag =3D "grpA", =2Enetwork =3D 0x0a090000, =2Enetmask =3D 0xffffff00, =
=2Egateway =3D 0x0a090001 };
+    assert_false(subnet_pools_check(&a16, 0, =
0, M_WARN));
+
+    /* the same tag defined twice */
+    struct subnet_poo=
l_def bdup =3D { =2Enext =3D NULL, =2Etag =3D "grpA", =2Enetwork =3D 0x0a0a=
0000, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a0a0001 };
+    struct s=
ubnet_pool_def adup =3D { =2Enext =3D &bdup, =2Etag =3D "grpA", =2Enetwork =
=3D 0x0a090000, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a090001 };
+  =
  assert_false(subnet_pools_check(&adup, 0, 0, M_WARN));
+}
+
+const struct=
 CMUnitTest subnet_pool_tests[] =3D {
+    cmocka_unit_test(test_subnet_poo=
l_by_tag),
+    cmocka_unit_test(test_subnet_pools_check_netmask),
+    cmo=
cka_unit_test(test_subnet_pools_check_gateway),
+    cmocka_unit_test(test_=
subnet_pools_check_overlap),
+};
+
+int
+main(void)
+{
+    openvpn_unit_te=
st_setup();
+    return cmocka_run_group_tests(subnet_pool_tests, NULL, NUL=
L);
+}

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchs=
et
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia1e7db9=
5615d99ef9687de7c4e996dc8033e2631
Gerrit-Change-Number: 1783
Gerrit-PatchSe=
t: 7
Gerrit-Owner: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doering <gert@greeni=
e=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerri=
t-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>

--1QM8jUtpgpk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, Frank Lichtenheld=2E=
 </p>
<p>Antonio Quartulli <strong>uploaded patch set #7</strong> to this c=
hange=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?u=
sp=3Demail">View Change</a></p><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">multi: assign clients from a n=
amed, tagged subnet-pool<br><br>Add two server directives:<br><br>  subnet-=
pool &lt;tag&gt; &lt;network&gt; &lt;netmask&gt; [&lt;gateway&gt;]   (main =
config)<br>  subnet-pool-tag &lt;tag&gt;                               (per=
-client CCD)<br><br>so groups of clients can be given addresses from subnet=
s other than the<br>--server network (per-group firewall rules under --topo=
logy subnet, and<br>thus DCO)=2E A client&#39;s subnet-pool-tag is resolved=
 to its pool and served<br>a virtual IP from that subnet: a static --ifconf=
ig-push within it, or the<br>next free address from a dynamic per-group poo=
l shared by tag=2E Such a<br>client is validated against its own subnet ins=
tead of the global<br>tunnel-network constraint and never falls back to the=
 global pool; a tag<br>matching no configured pool is declined with AUTH_FA=
ILED=2E The tag is<br>resolved again after every client-connect handler, so=
 a script, plugin<br>or management interface may override the one set by th=
e CCD file=2E<br><br>The pools are checked when the config is loaded, as fo=
r --server: the<br>netmask must be contiguous and between /16 and /29, the =
gateway a host<br>address inside the subnet, tags unique, and no pool may o=
verlap another<br>or the --server network=2E Every pool is created at start=
up, and its<br>gateway is reserved so it is never handed out to a client=2E=
<br><br>The server routes each pool&#39;s subnet into its tun device, as th=
e device<br>is only configured with the --server network: without this the =
server<br>cannot reach its subnet-pool clients=2E This is a regular --route=
, so it<br>is installed before privileges are dropped and honours --route-t=
able,<br>--route-metric and --route-noexec=2E Under DCO on Linux and FreeBS=
D,<br>though, the kernel selects the peer by the route&#39;s next hop, so a=
 route<br>via a gateway would deliver every packet for an unassigned pool a=
ddress<br>to the client owning that gateway address: there the route is ins=
talled<br>on-link on the tun device instead (a new on_link route option fla=
g), and<br>each client of the pool gets its own on-link host route on conne=
ct (as<br>its address is outside the --ifconfig network), so such packets m=
atch<br>no peer=2E<br><br>Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2=
631<br>GitHub: closes openvpn/OpenVPN#987<br>Signed-off-by: Antonio Quartul=
li &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<br>M doc/ma=
n-sections/server-options=2Erst<br>M src/openvpn/multi=2Ec<br>M src/openvpn=
/multi=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M s=
rc/openvpn/options_util=2Ec<br>M src/openvpn/options_util=2Eh<br>M src/open=
vpn/pool=2Ec<br>M src/openvpn/pool=2Eh<br>M src/openvpn/route=2Ec<br>M src/=
openvpn/route=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests/un=
it_tests/openvpn/test_subnet_pool=2Ec<br>14 files changed, 676 insertions(+=
), 15 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/83/1783/7</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLis=
ts=2Etxt b/CMakeLists=2Etxt</span><br><span>index b286ee2=2E=2E4e87a6a 1006=
44</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=
=2Etxt</span><br><span>@@ -694,6 +694,7 @@</span><br><span>         &quot;t=
est_provider&quot;</span><br><span>         &quot;test_socket&quot;</span><=
br><span>         &quot;test_ssl&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        &quot;test_subnet_pool&quot;</span><br><span>   =
      &quot;test_user_pass&quot;</span><br><span>         &quot;test_push_u=
pdate_msg&quot;</span><br><span>         )</span><br><span>@@ -868,6 +869,1=
1 @@</span><br><span>         src/openvpn/session_id=2Ec</span><br><span>  =
   )</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    target_sources(test_subnet_pool PRIVATE</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/mock_get_random=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/ope=
nvpn/options_util=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span>     target_sources(test_ncp PRIVATE</span><br><span>         src/=
openvpn/crypto_epoch=2Ec</span><br><span>         src/openvpn/crypto_mbedtl=
s=2Ec</span><br><span>diff --git a/doc/man-sections/server-options=2Erst b/=
doc/man-sections/server-options=2Erst</span><br><span>index 9dfa6bd=2E=2Ed8=
68d09 100644</span><br><span>--- a/doc/man-sections/server-options=2Erst</s=
pan><br><span>+++ b/doc/man-sections/server-options=2Erst</span><br><span>@=
@ -330,6 +330,41 @@</span><br><span>   by ``--ifconfig``, OpenVPN will inst=
all a /32 host route for the ``local``</span><br><span>   IP address=2E</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--sub=
net-pool args</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Defi=
ne a named pool of addresses from a subnet different from the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  ``--server`` network, so groups=
 of clients can be given IPs from separate</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  subnets for per-group firewall rules under ``--top=
ology subnet`` (and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  therefore DCO)=2E This is a main-config directive and may be repeated to<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  define several poo=
ls=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  Valid syntax:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  ::</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     subnet-pool tag network netmask [gateway]</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  ``tag`` is a name a client refers to with ``--subnet-pool-tag=
``; ``gateway``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  de=
faults to the first address of ``network``/``netmask`` and is never</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  assigned to a client=2E A=
 client assigned to a pool receives (dynamically, or</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  via a static ``--ifconfig-push`` that m=
ust lie within the subnet) an address</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  from it, plus the matching netmask=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  Requires ``--server`` with ``--dev tun`` and ``--topol=
ogy subnet``=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``=
netmask`` must be between /16 and /29 (as for ``--server``), ``gateway``</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  must be a host addre=
ss inside the subnet, each ``tag`` may be defined only</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  once and no pool may overlap another o=
ne or the ``--server`` network=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The=
 server routes each pool&#39;s subnet into the tun device, as it does for</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  the ``--server`` ne=
twork; no ``--route`` needs to be added for it=2E These</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  routes honour ``--route-table`` and `=
`--route-metric``=2E With DCO on Linux</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  and FreeBSD the IPv4 route is installed on-link, witho=
ut a gateway, so its</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  ``route_gateway_{n}`` is not set for ``--route-up`` scripts=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+--subnet-pool-tag tag</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  Assign this client to the ``--subnet-pool`` =
named ``tag``=2E Must be</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  associated with a specific client instance via ``--client-config-dir=
`` or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--client-c=
onnect``=2E Several clients may reference the same tag and are</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  then served from the same shar=
ed pool=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> --ifconfig-ipv6-push args</span><br><span>   for ``--client-config=
-dir`` per-client static IPv6 interface</span><br><span>   configuration, s=
ee ``--client-config-dir`` and ``--ifconfig-push`` for</span><br><span>diff=
 --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>inde=
x a2cfdbf=2E=2E12b7442 100644</span><br><span>--- a/src/openvpn/multi=2Ec</=
span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -43,6 +43,7 @=
@</span><br><span> #include &quot;auth_token=2Eh&quot;</span><br><span> #in=
clude &quot;route=2Eh&quot;</span><br><span> #include &quot;sid_hash=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;o=
ptions_util=2Eh&quot;</span><br><span> #include &lt;inttypes=2Eh&gt;</span>=
<br><span> #include &lt;string=2Eh&gt;</span><br><span> </span><br><span>@@=
 -54,6 +55,20 @@</span><br><span> #include &quot;dco=2Eh&quot;</span><br><s=
pan> #include &quot;reflect_filter=2Eh&quot;</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Dynamic address pool serving the clients of on=
e --subnet-pool tag=2E  Shared</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * by every client that references the tag, created on first use=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+struct subnet_pool</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct subnet_pool *next;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *tag;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool *pool;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static struct ifconfig_pool *multi_get_group_pool(struct multi_c=
ontext *m,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                                         const struct options *o, const cha=
r *tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> /*#define MULTI_DEBUG_EVENT_LOOP*/</span><br><span> </span><br><span=
> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span>@@ -371,6 +386,13 @@</span>=
<br><span>         }</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* create every --subnet-pool=
 group up front rather than on first use, so</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * that its pool exists before any client of t=
he group connects */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    for (const struct subnet_pool_def *d =3D t-&gt;options=2Esubnet_pools;=
 d; d =3D d-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mult=
i_get_group_pool(m, &amp;t-&gt;options, d-&gt;tag);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     /*</span><br><span>      * Help u=
s keep track of routing table=2E</span><br><span>      */</span><br><span>@=
@ -625,7 +647,8 @@</span><br><span> </span><br><span>         schedule_remo=
ve_entry(m-&gt;schedule, (struct schedule_entry *)mi);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        ifconfig_pool_re=
lease(m-&gt;ifconfig_pool, mi-&gt;vaddr_handle, false);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        ifconfig_pool_release(mi-&gt;va=
ddr_pool ? mi-&gt;vaddr_pool : m-&gt;ifconfig_pool, mi-&gt;vaddr_handle,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
        false);</span><br><span> </span><br><span>         if (mi-&gt;did_i=
routes)</span><br><span>         {</span><br><span>@@ -707,6 +730,14 @@</sp=
an><br><span>         schedule_free(m-&gt;schedule);</span><br><span>      =
   mbuf_free(m-&gt;mbuf);</span><br><span>         ifconfig_pool_free(m-&gt=
;ifconfig_pool);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     while (m-&gt;subnet_pools)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            struct subnet_pool *sp =3D m-&gt;subnet_pools;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            m-&gt;subnet_pools =3D sp-&gt;next;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            ifconfig_pool=
_free(sp-&gt;pool);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            free(sp);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span>         frequency_limit_free(m-&gt;new_connect=
ion_limiter);</span><br><span>         initial_rate_limit_free(m-&gt;initia=
l_rate_limiter);</span><br><span>         multi_reap_free(m-&gt;reaper);</s=
pan><br><span>@@ -1405,6 +1436,12 @@</span><br><span>     const struct opti=
ons *o =3D &amp;c-&gt;options;</span><br><span>     if (o-&gt;push_ifconfig=
_constraint_defined &amp;&amp; c-&gt;c2=2Epush_ifconfig_defined)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 /* a subnet-pool client is validated against its own subnet */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (o-&gt;subnet_pool_d=
efined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            return (o-=
&gt;subnet_pool_netmask &amp; c-&gt;c2=2Epush_ifconfig_local)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                   =3D=3D o-&gt;s=
ubnet_pool_network;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span>         return (o-&gt;push_ifconfig_constraint_n=
etmask &amp; c-&gt;c2=2Epush_ifconfig_local)</span><br><span>              =
  =3D=3D o-&gt;push_ifconfig_constraint_network;</span><br><span>     }</sp=
an><br><span>@@ -1415,6 +1452,37 @@</span><br><span> }</span><br><span> </s=
pan><br><span> /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Return the dynamic pool serving the clients tagged with &lt;tag&gt;, creat=
ing it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * on first u=
se from the matching --subnet-pool definition in &lt;o&gt;=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static struct ifconfig_pool *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+multi_get_group_pool(struct multi_conte=
xt *m, const struct options *o, const char *tag)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct subnet_pool *sp;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    for (sp =3D m-&gt;subnet_pools; sp; sp =3D sp-&gt;next)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (!strcmp(sp-&gt;tag, tag))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return sp-&gt;pool;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const struct subnet_pool_def *d4 =3D subnet_pool_by_tag(o-&gt;subnet=
_pools, tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    AS=
SERT(d4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_=
OBJ_CLEAR(sp, struct subnet_pool);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    sp-&gt;tag =3D d4-&gt;tag;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* every host address of the subnet, minus th=
e gateway reserved below */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    sp-&gt;pool =3D ifconfig_pool_init(true, IFCONFIG_POOL_INDIV, d=
4-&gt;network + 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                 (d4-&gt;network | ~d4-&gt;netmask) - 1, o-=
&gt;duplicate_cn, false,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                  in6addr_any, 0);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_reserve_ip(sp-&gt;poo=
l, d4-&gt;gateway);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    sp-&gt;next =3D m-&gt;subnet_pools;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    m-&gt;subnet_pools =3D sp;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return sp-&gt;pool;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
</span><br><span>  * Select a virtual address for a new client instance=2E<=
/span><br><span>  * Use an --ifconfig-push directive, if given (static IP)=
=2E</span><br><span>  * Otherwise use an --ifconfig-pool address (dynamic I=
P)=2E</span><br><span>@@ -1424,6 +1492,25 @@</span><br><span> {</span><br><=
span>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* resolve --subnet-pool-tag a=
gainst the main-config --subnet-pool list (an</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * unknown tag is rejected with AUTH_FAILED i=
n multi_connection_established)=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * This runs again after every client-connect handler, a=
nd a later handler</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * (script, plugin, management) may override the tag set by the CCD file=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * so always r=
esolve the current tag=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (mi-&gt;context=2Eoptions=2Esubnet_pool_tag)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        const struct subnet_pool_def *d =3D</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            subnet_pool_=
by_tag(m-&gt;top=2Eoptions=2Esubnet_pools, mi-&gt;context=2Eoptions=2Esubne=
t_pool_tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;context=2Eo=
ptions=2Esubnet_pool_defined =3D d !=3D NULL;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (d)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            mi-&gt;context=2Eoptions=2Esubnet_pool_network =3D d=
-&gt;network;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      mi-&gt;context=2Eoptions=2Esubnet_pool_netmask =3D d-&gt;netmask;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;cont=
ext=2Eoptions=2Esubnet_pool_gateway =3D d-&gt;gateway;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span>     /*</span><br><span>      * If ifconfig add=
resses were set by dynamic config file,</span><br><span>      * release poo=
l addresses, otherwise keep them=2E</span><br><span>@@ -1434,8 +1521,10 @@<=
/span><br><span>          * release dynamic allocation */</span><br><span> =
        if (mi-&gt;vaddr_handle &gt;=3D 0)</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            ifconfig_pool_r=
elease(m-&gt;ifconfig_pool, mi-&gt;vaddr_handle, true);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            ifconfig_pool_release(mi-&g=
t;vaddr_pool ? mi-&gt;vaddr_pool : m-&gt;ifconfig_pool,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                  mi-&g=
t;vaddr_handle, true);</span><br><span>             mi-&gt;vaddr_handle =3D=
 -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi-=
&gt;vaddr_pool =3D NULL;</span><br><span>         }</span><br><span> </span=
><br><span>         mi-&gt;context=2Ec2=2Epush_ifconfig_defined =3D true;</=
span><br><span>@@ -1455,6 +1544,52 @@</span><br><span>                 &quo=
t;MULTI_sva: WARNING: if --ifconfig-push is used for IPv4, automatic IPv6 a=
ssignment from --ifconfig-ipv6-pool does not work=2E  Use --ifconfig-ipv6-p=
ush for IPv6 then=2E&quot;);</span><br><span>         }</span><br><span>   =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (mi-=
&gt;context=2Eoptions=2Esubnet_pool_defined)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        /* dynamic address from this client&#39;s --subnet-pool =
group */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        str=
uct ifconfig_pool *group =3D</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            multi_get_group_pool(m, &amp;m-&gt;top=2Eoptions, mi-&=
gt;context=2Eoptions=2Esubnet_pool_tag);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* the address may have been acquired before the tag was known (f=
rom</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * the g=
lobal pool) or for a tag that a later handler overrode: drop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+         * it so we serve this cli=
ent from its current group */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (mi-&gt;vaddr_handle &gt;=3D 0 &amp;&amp; mi-&gt;vaddr=
_pool !=3D group)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
ifconfig_pool_release(mi-&gt;vaddr_pool ? mi-&gt;vaddr_pool : m-&gt;ifconfi=
g_pool,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                      mi-&gt;vaddr_handle, true);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            mi-&gt;vaddr_handle =3D -1;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;vaddr_=
pool =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       /* both addresses of the dropped slot go back to its pool */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=
=2Ec2=2Epush_ifconfig_defined =3D false;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_d=
efined =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (mi-&gt;vaddr_handle=
 &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            in_addr_t=
 local =3D 0, remote =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            const char *cn =3D NULL;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            if (!mi-&gt;context=2Eoptions=2Eduplicate_cn)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                cn =3D tls_common_nam=
e(mi-&gt;context=2Ec2=2Etls_multi, true);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         mi-&gt;vaddr_pool =3D group;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            mi-&gt;vaddr_handle =3D ifconfig_pool_acquire=
(mi-&gt;vaddr_pool, &amp;local, &amp;remote, NULL, cn);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            if (mi-&gt;vaddr_handle &gt=
;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                mi=
-&gt;context=2Ec2=2Epush_ifconfig_local =3D remote;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                mi-&gt;context=2Ec2=2Epus=
h_ifconfig_remote_netmask =3D</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    mi-&gt;context=2Eoptions=2Esubnet_pool_netmas=
k;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                m=
i-&gt;context=2Ec2=2Epush_ifconfig_defined =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            else</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                msg(D_MULTI_ERRORS, &quot;MULTI: no free=
 --subnet-pool addresses are available for %s&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    multi_instance_string=
(mi, false, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span>     else if (m-&gt;ifconfig_pool &amp;&amp; mi-&gt;vaddr_handle &=
lt; 0) /* otherwise, choose a pool address */</span><br><span>     {</span>=
<br><span>         in_addr_t local =3D 0, remote =3D 0;</span><br><span>@@ =
-2360,10 +2495,9 @@</span><br><span>         const char *ifconfig_constrain=
t_netmask =3D</span><br><span>             print_in_addr_t(mi-&gt;context=
=2Eoptions=2Epush_ifconfig_constraint_netmask, 0, &amp;gc);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* JYFIXME =
-- this should cause the connection to fail */</span><br><span>         msg=
(D_MULTI_ERRORS,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       &quot;MULTI ERROR: primary virtual IP for %s (%s) &quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            &quot;violates tunnel=
 network/netmask constraint (%s/%s)&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            &quot;WARNING: primary virtual IP for %s=
 (%s) &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &quot;violates tunnel network/netmask constraint (%s/%s) and may not w=
ork&quot;,</span><br><span>             multi_instance_string(mi, false, &a=
mp;gc),</span><br><span>             print_in_addr_t(mi-&gt;context=2Ec2=2E=
push_ifconfig_local, 0, &amp;gc),</span><br><span>             ifconfig_con=
straint_network, ifconfig_constraint_netmask);</span><br><span>@@ -2471,6 +=
2605,7 @@</span><br><span> </span><br><span>     /* reset pool handle to nu=
ll */</span><br><span>     mi-&gt;vaddr_handle =3D -1;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;vaddr_pool =3D NULL;</span><b=
r><span> </span><br><span>     /* do --client-connect setenvs */</span><br>=
<span>     multi_select_virtual_addr(m, mi);</span><br><span>@@ -2792,6 +29=
27,15 @@</span><br><span>         cc_succeeded =3D false;</span><br><span> =
    }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (mi-&gt;context=2Eoptions=2Esubnet_pool_tag</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !subnet_pool_by_tag(m=
-&gt;top=2Eoptions=2Esubnet_pools, mi-&gt;context=2Eoptions=2Esubnet_pool_t=
ag))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_ERRORS, &=
quot;MULTI: client has been rejected due to unknown --subnet-pool-tag &#39;=
%s&#39;&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        auth_set_client_reason(mi-&gt;con=
text=2Ec2=2Etls_multi, &quot;unknown subnet-pool-tag&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cc_succeeded =3D false;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (cc_succeed=
ed)</span><br><span>     {</span><br><span>         multi_client_connect_la=
te_setup(m, mi, *option_types_found);</span><br><span>diff --git a/src/open=
vpn/multi=2Eh b/src/openvpn/multi=2Eh</span><br><span>index 5db7147=2E=2E14=
f71dd 100644</span><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>++=
+ b/src/openvpn/multi=2Eh</span><br><span>@@ -121,6 +121,8 @@</span><br><sp=
an>     struct mroute_addr real; /**&lt; External network address of the</s=
pan><br><span>                               *   remote peer=2E */</span><b=
r><span>     ifconfig_pool_handle vaddr_handle;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* pool vaddr_handle belongs to (NULL =3D t=
he global one) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct ifconfig_pool *vaddr_pool;</span><br><span>     char msg_prefix[MU=
LTI_PREFIX_MAX_LENGTH];</span><br><span> </span><br><span>     /* queued ou=
tgoing data in Server/TCP mode */</span><br><span>@@ -190,6 +192,8 @@</span=
><br><span>                                         *   instances=2E */</sp=
an><br><span>     struct multi_io *multi_io;         /**&lt; I/O state and =
events tracker */</span><br><span>     struct ifconfig_pool *ifconfig_pool;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* per-group --=
subnet-pool dynamic pools */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct subnet_pool *subnet_pools;</span><br><span>     struct =
frequency_limit *new_connection_limiter;</span><br><span>     struct initia=
l_packet_rate_limit *initial_rate_limiter;</span><br><span>     struct mrou=
te_helper *route_helper;</span><br><span>diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec</span><br><span>index 7fc8614=2E=2Ed5666b8 1=
00644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/s=
rc/openvpn/options=2Ec</span><br><span>@@ -452,6 +452,11 @@</span><br><span=
>     &quot;                  If seconds=3D0, file will be treated as read-=
only=2E\n&quot;</span><br><span>     &quot;--ifconfig-ipv6-pool base-IP/bit=
s : set aside an IPv6 network block\n&quot;</span><br><span>     &quot;    =
              to be dynamically allocated to connecting clients=2E\n&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--subnet-p=
ool tag network netmask [gateway] : Define a named pool of\n&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;                  =
addresses outside the --server network, selected per\n&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &quot;                  client=
 with --subnet-pool-tag=2E\n&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &quot;--subnet-pool-tag tag : Assign this client to the =
--subnet-pool named tag=2E\n&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &quot;                  Only valid in a client-specific =
config file=2E\n&quot;</span><br><span>     &quot;--ifconfig-push local rem=
ote-netmask : Push an ifconfig option to remote,\n&quot;</span><br><span>  =
   &quot;                  overrides --ifconfig-pool dynamic allocation=2E\=
n&quot;</span><br><span>     &quot;                  Only valid in a client=
-specific config file=2E\n&quot;</span><br><span>@@ -1925,6 +1930,20 @@</sp=
an><br><span>         {</span><br><span>             msg(M_USAGE, &quot;--i=
fconfig-ipv6-pool needs --ifconfig-ipv6&quot;);</span><br><span>         }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (options-=
&gt;subnet_pools)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (!options-&gt;server_defined)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                msg(M_USAGE, &quot;--subnet-pool requires --server&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (dev=
_type_enum(options-&gt;dev, options-&gt;dev_type) !=3D DEV_TYPE_TUN</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                || options-=
&gt;topology !=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                msg(M_USAGE, &quot;--subnet-pool requires --dev tun and=
 --topology subnet&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            subnet_pools_check(options-&gt;subnet_pools, options-&gt;serve=
r_network,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                      options-&gt;server_netmask, M_USAGE);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>         =
MUST_BE_UNDEF(allow_recursive_routing, &quot;allow-recursive-routing&quot;)=
;</span><br><span>         if (options-&gt;auth_user_pass_file)</span><br><=
span>         {</span><br><span>@@ -1991,6 +2010,7 @@</span><br><span>     =
    MUST_BE_UNDEF(ifconfig_pool_defined, &quot;ifconfig-pool&quot;);</span>=
<br><span>         MUST_BE_UNDEF(ifconfig_pool_persist_filename, &quot;ifco=
nfig-pool-persist&quot;);</span><br><span>         MUST_BE_UNDEF(ifconfig_i=
pv6_pool_defined, &quot;ifconfig-ipv6-pool&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(subnet_pools, &quot;su=
bnet-pool&quot;);</span><br><span>         MUST_BE_UNDEF(real_hash_size, &q=
uot;hash-size&quot;);</span><br><span>         MUST_BE_UNDEF(virtual_hash_s=
ize, &quot;hash-size&quot;);</span><br><span>         MUST_BE_UNDEF(learn_a=
ddress_script, &quot;learn-address&quot;);</span><br><span>@@ -3123,6 +3143=
,28 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * The server&#39;s tun device is only config=
ured with the --server network, so</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * route each --subnet-pool network into it as well: without=
 this the server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
could not reach its subnet-pool clients when the data channel runs in</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * userspace=2E  Under DC=
O on Linux and FreeBSD the routes are installed on-link,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * see subnet_pool_routes_onlink()=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+options_postprocess_subnet_pool_routes(struc=
t options *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (const struct su=
bnet_pool_def *d =3D o-&gt;subnet_pools; d; d =3D d-&gt;next)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct route_option *ro;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        rol_check_alloc(o);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        ro =3D add_route_to_option_list(o-&gt=
;routes, print_in_addr_t(d-&gt;network, 0, &amp;o-&gt;gc),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                    =
  print_in_addr_t(d-&gt;netmask, 0, &amp;o-&gt;gc), NULL, NULL,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
       o-&gt;route_default_table_id);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        ro-&gt;on_link =3D subnet_pool_routes_onlink(o);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><span> optio=
ns_postprocess_mutate(struct options *o, struct env_set *es)</span><br><spa=
n> {</span><br><span>@@ -3258,6 +3300,12 @@</span><br><span>         /* che=
ck if any option should force disabling DCO */</span><br><span>         o-&=
gt;disable_dco =3D !dco_check_option(D_DCO, o) || !dco_check_startup_option=
(D_DCO, o);</span><br><span>     }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (o-&gt;mode =3D=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* how the pools are routed depends on the DCO decision above */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options_postp=
rocess_subnet_pool_routes(o);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span> #ifdef USE_COMP</span><br><span>     if (d=
co_enabled(o))</span><br><span>     {</span><br><span>@@ -6245,6 +6293,43 @=
@</span><br><span>             goto err;</span><br><span>         }</span><=
br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else if (streq(p[0], &quot;subnet-pool&quot;) &amp;&amp; p[1] &amp;&amp; p[=
2] &amp;&amp; p[3] &amp;&amp; !p[5])</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        struct subnet_pool_def *sp;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        in_addr_t network, netmask;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        network =3D getaddr(GETADDR_H=
OST_ORDER | GETADDR_RESOLVE, p[2], 0, NULL, NULL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        netmask =3D getaddr(GETADDR_HOST_ORD=
ER, p[3], 0, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (!network || !netmask)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            msg(msglevel, &quot;cannot parse --subnet-pool addres=
ses&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ALLOC_OB=
J_GC(sp, struct subnet_pool_def, &amp;options-&gt;gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;tag =3D p[1];</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;network =3D netw=
ork &amp; netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       sp-&gt;netmask =3D netmask;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        sp-&gt;gateway =3D (network &amp; netmask) + 1;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p[4])</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            bool ok =3D false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            sp-&gt;gateway =3D getaddr(GETAD=
DR_HOST_ORDER | GETADDR_RESOLVE, p[4], 0, &amp;ok, NULL);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            if (!ok)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;canno=
t parse --subnet-pool gateway&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                goto err;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        sp-&gt;next =3D options-&gt;subnet_pools;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        options-&gt;subnet_pools =3D =
sp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot=
;subnet-pool-tag&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_INSTANCE);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;subnet_p=
ool_tag =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span>     else if (streq(p[0], &quot;ifconfig-push-constrain=
t&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>=
     {</span><br><span>         in_addr_t network, netmask;</span><br><span=
>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><=
span>index d347830=2E=2Eff26066 100644</span><br><span>--- a/src/openvpn/op=
tions=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ =
-252,6 +252,17 @@</span><br><span>     struct verify_hash_list *next;</span=
><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/* A named --subnet-pool: a subnet clients can be assigned fro=
m, referenced</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * fro=
m a CCD file by its tag via --subnet-pool-tag=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+struct subnet_pool_def</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct subnet_pool_def *next;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *tag;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    in_addr_t network;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    in_addr_t netmask;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t gateway;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> /* Command line options */</sp=
an><br><span> struct options</span><br><span> {</span><br><span>@@ -518,6 +=
529,12 @@</span><br><span>     bool push_ifconfig_constraint_defined;</span=
><br><span>     in_addr_t push_ifconfig_constraint_network;</span><br><span=
>     in_addr_t push_ifconfig_constraint_netmask;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct subnet_pool_def *subnet_pools; /* =
named pools (server config) */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const char *subnet_pool_tag;          /* which pool this cli=
ent uses (CCD) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  bool subnet_pool_defined;             /* resolved from the tag at connect=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t su=
bnet_pool_network;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   in_addr_t subnet_pool_netmask;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    in_addr_t subnet_pool_gateway;</span><br><span>     bool =
push_ifconfig_ipv4_blocked;           /* IPv4 */</span><br><span>     bool =
push_ifconfig_ipv6_defined;           /* IPv6 */</span><br><span>     struc=
t in6_addr push_ifconfig_ipv6_local;  /* IPv6 */</span><br><span>@@ -978,4 =
+995,23 @@</span><br><span> #endif /* ENABLE_DCO */</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Whether the routes =
of the --subnet-pool networks are installed on-link on</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * the DCO device rather than via a gate=
way=2E  With DCO on Linux and FreeBSD the</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * kernel selects the peer by a route&#39;s next hop,=
 so a route via a gateway</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * would deliver every packet for an unassigned pool address to the c=
lient</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * owning that=
 gateway address; on-link, such a packet matches no peer, while</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * each pool client gets its ow=
n on-link host route when it connects (see</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * multi_learn_in_addr_t())=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static inline bool</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+subnet_pool_routes_onlink(const struct options *o)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) || defined(TARGET_F=
REEBSD)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return d=
co_enabled(o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifndef OPTIONS_H */</spa=
n><br><span>diff --git a/src/openvpn/options_util=2Ec b/src/openvpn/options=
_util=2Ec</span><br><span>index d25d85c=2E=2E744ad4c 100644</span><br><span=
>--- a/src/openvpn/options_util=2Ec</span><br><span>+++ b/src/openvpn/optio=
ns_util=2Ec</span><br><span>@@ -30,6 +30,91 @@</span><br><span> #include &q=
uot;options_util=2Eh&quot;</span><br><span> </span><br><span> #include &quo=
t;push=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;pool=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const struct=
 subnet_pool_def *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
ubnet_pool_by_tag(const struct subnet_pool_def *pools, const char *tag)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (const struct subnet_pool_def *d =
=3D pools; d; d =3D d-&gt;next)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (!strcmp(d-&gt;tag, tag))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            return d;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* true if the two IPv4 subnets share at least one addres=
s */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+subnets_overlap(in_addr=
_t a, in_addr_t mask_a, in_addr_t b, in_addr_t mask_b)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const in_addr_t mask =3D mask_a &amp; mask_b;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return (a &amp; mask) =3D=3D (b &amp; mask)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+subnet_pools_check(const struct subnet_pool_def *pools, in_addr_t serv=
er_network,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
           in_addr_t server_netmask, msglvl_t msglevel)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (const struct subnet_pool_def *d =3D pools; d; d =
=3D d-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const in_a=
ddr_t host =3D ~d-&gt;netmask;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        int netbits =3D 32;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        /* the netmask must be contiguous */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (host &amp; (host + 1))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--subnet-pool=
 %s: invalid netmask&quot;, d-&gt;tag);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            return false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        for (in_addr_t h =3D host; h; h &gt;&gt;=3D 1)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            netbits--;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* same bounds as --server: the pool must hold at le=
ast 2 addresses</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     * besides network, gateway and broadcast, and fit IFCONFIG_POOL_MAX */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (netbits=
 &lt; IFCONFIG_POOL_MIN_NETBITS || netbits &gt; 29)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--subnet-pool %s: n=
etmask must be between /%d and /29 (not /%d)&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                d-&gt;tag, IFCONFIG_POOL_=
MIN_NETBITS, netbits);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            return false;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((d-&gt;g=
ateway &amp; d-&gt;netmask) !=3D d-&gt;network || d-&gt;gateway =3D=3D d-&g=
t;network</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  || d-&gt;gateway =3D=3D (d-&gt;network | host))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            msg(msglevel, &quot;--subnet-pool %s: gatew=
ay must be a host address inside the subnet&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                d-&gt;tag);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (server_netmask</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            &amp;&amp; subnets_overlap(d-&gt;network=
, d-&gt;netmask, server_network, server_netmask))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            msg(msglevel, &quot;--subnet-pool %s: subne=
t overlaps the --server network&quot;, d-&gt;tag);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            return false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        for (const struct subnet_pool_def *e =3D d-&gt;next; e; e =
=3D e-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if=
 (!strcmp(d-&gt;tag, e-&gt;tag))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                msg(msglevel, &quot;--subnet-pool %s: tag defined mo=
re than once&quot;, d-&gt;tag);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            if (subnets_overlap(d-&gt;network, d-&gt;netmas=
k, e-&gt;network, e-&gt;netmask))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                msg(msglevel, &quot;--subnet-pool %s and %s: subnet=
s overlap&quot;, d-&gt;tag, e-&gt;tag);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </s=
pan><br><span> const char *</span><br><span> parse_auth_failed_temp(struct =
options *o, const char *reason)</span><br><span>diff --git a/src/openvpn/op=
tions_util=2Eh b/src/openvpn/options_util=2Eh</span><br><span>index 5226a6f=
=2E=2Ed60759a 100644</span><br><span>--- a/src/openvpn/options_util=2Eh</sp=
an><br><span>+++ b/src/openvpn/options_util=2Eh</span><br><span>@@ -28,6 +2=
8,31 @@</span><br><span> </span><br><span> const char *parse_auth_failed_te=
mp(struct options *o, const char *reason);</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * Look up a named --subnet-pool in a list of pool=
 definitions=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pools  head=
 of the --subnet-pool list (may be NULL)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param tag    the --subnet-pool-tag to match</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return       the match=
ing pool definition, or NULL if none matches</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+const struct subnet_pool_def *subnet_pool_by_tag(const struct subn=
et_pool_def *pools,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                                 const char *tag);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Validate the --subnet-pool definitions: contiguous netmask b=
etween</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * /IFCONFIG_=
POOL_MIN_NETBITS and /29, gateway a host address inside its</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * subnet, unique tags, and no subn=
et overlapping another pool or the --server</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * network=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param pools           head of the --subnet-pool list (may be NULL)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param server_networ=
k  the --server network (host order)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param server_netmask  the --server netmask, or 0 if th=
ere is none</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m msglevel        level of the message logged on the first error</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @return                true=
 if every definition is valid</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool s=
ubnet_pools_check(const struct subnet_pool_def *pools, in_addr_t server_net=
work,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
          in_addr_t server_netmask, msglvl_t msglevel);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span> /**=
 Checks if the string is a valid integer by checking if it can be</span><br=
><span>  *  converted to an integer */</span><br><span>diff --git a/src/ope=
nvpn/pool=2Ec b/src/openvpn/pool=2Ec</span><br><span>index 63fc930=2E=2Efa0=
4d9c 100644</span><br><span>--- a/src/openvpn/pool=2Ec</span><br><span>+++ =
b/src/openvpn/pool=2Ec</span><br><span>@@ -350,7 +350,7 @@</span><br><span>=
 {</span><br><span>     bool ret =3D false;</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (pool &amp;&amp; hand &gt;=
=3D 0 &amp;&amp; hand &lt; pool-&gt;size)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (pool &amp;&amp; hand &gt;=3D 0 &amp;&amp; han=
d &lt; pool-&gt;size &amp;&amp; !pool-&gt;list[hand]=2Ereserved)</span><br>=
<span>     {</span><br><span>         ifconfig_pool_entry_free(&amp;pool-&g=
t;list[hand], hard);</span><br><span>         ret =3D true;</span><br><span=
>@@ -429,6 +429,22 @@</span><br><span>     return ret;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ifconfig_pool_rese=
rve_ip(struct ifconfig_pool *pool, const in_addr_t addr)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const ifconfig_pool_handle h =3D ifconfig_pool_ip_ba=
se_to_handle(pool, addr);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (h &lt=
; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ifconfig_pool_entry_free(&amp;pool-&gt;list[h], true);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pool-&gt;list[h]=
=2Ein_use =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    pool-&gt;list[h]=2Ereserved =3D true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> static in_addr_t</span><br><span> ifconfig_pool_handle_t=
o_ip_base(const struct ifconfig_pool *pool, ifconfig_pool_handle hand)</spa=
n><br><span> {</span><br><span>@@ -476,6 +492,13 @@</span><br><span>       =
            const bool fixed)</span><br><span> {</span><br><span>     struc=
t ifconfig_pool_entry *e =3D &amp;pool-&gt;list[h];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (e-&gt;reserved)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        msg(M_WARN, &quot;pool: ignoring persisted entry for CN=3D%s: =
its address is reserved&quot;, cn);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     ifconfig_pool_entry_free(e, true);</span><br><span>    =
 e-&gt;in_use =3D false;</span><br><span>     e-&gt;common_name =3D string_=
alloc(cn, NULL);</span><br><span>diff --git a/src/openvpn/pool=2Eh b/src/op=
envpn/pool=2Eh</span><br><span>index e2d3f82=2E=2E497dcda 100644</span><br>=
<span>--- a/src/openvpn/pool=2Eh</span><br><span>+++ b/src/openvpn/pool=2Eh=
</span><br><span>@@ -43,6 +43,7 @@</span><br><span>     char *common_name;<=
/span><br><span>     time_t last_release;</span><br><span>     bool fixed;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool reserved; /=
* never handed out, e=2Eg=2E a --subnet-pool gateway */</span><br><span> };=
</span><br><span> </span><br><span> struct ifconfig_pool</span><br><span>@@=
 -86,6 +87,17 @@</span><br><span> </span><br><span> bool ifconfig_pool_rele=
ase(struct ifconfig_pool *pool, ifconfig_pool_handle hand, const bool hard)=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Permanently r=
eserve the pool slot holding \c addr, so that it is never</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * handed out to a client nor taken o=
ver by a persisted entry (e=2Eg=2E the</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * gateway of a --subnet-pool)=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param pool  the pool</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param addr  IPv4 address (host order) to reserve<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return      true=
 if \c addr lies in the pool and was reserved</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+bool ifconfig_pool_reserve_ip(struct ifconfig_pool *pool, in_addr=
_t addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> struct ifconfig_pool_persist *ifconfig_pool_persist_init(const char=
 *filename, int refresh_freq);</span><br><span> </span><br><span> void ifco=
nfig_pool_persist_close(struct ifconfig_pool_persist *persist);</span><br><=
span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><=
span>index 9c80f3b=2E=2Ee1b3849 100644</span><br><span>--- a/src/openvpn/ro=
ute=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -407=
,6 +407,11 @@</span><br><span>         r-&gt;flags |=3D RT_METRIC_DEFINED;<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (ro-&gt;on_link)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        r-&gt;flags |=3D RT_ON_LINK;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>     r-&gt;flags |=3D RT_DEFINED;</span><br>=
<span> </span><br><span>     /* routing table id */</span><br><span>@@ -477=
,7 +482,7 @@</span><br><span>     return false;</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+struct route_option *</span=
><br><span> add_route_to_option_list(struct route_option_list *l, const cha=
r *network, const char *netmask,</span><br><span>                          =
const char *gateway, const char *metric, int table_id)</span><br><span> {</=
span><br><span>@@ -488,8 +493,10 @@</span><br><span>     ro-&gt;gateway =3D=
 gateway;</span><br><span>     ro-&gt;metric =3D metric;</span><br><span>  =
   ro-&gt;table_id =3D table_id;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    ro-&gt;on_link =3D false;</span><br><span>     ro-&gt;next=
 =3D l-&gt;routes;</span><br><span>     l-&gt;routes =3D ro;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return ro;</span><br><span> }<=
/span><br><span> </span><br><span> void</span><br><span>@@ -1321,7 +1328,11=
 @@</span><br><span>     {</span><br><span>         setenv_route_addr(es, &=
quot;network&quot;, r-&gt;network, i);</span><br><span>         setenv_rout=
e_addr(es, &quot;netmask&quot;, r-&gt;netmask, i);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        setenv_route_addr(es, &quot;gateway&qu=
ot;, r-&gt;gateway, i);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /* an on-link route has no gateway */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (!(r-&gt;flags &amp; RT_ON_LINK))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            setenv_route_addr(=
es, &quot;gateway&quot;, r-&gt;gateway, i);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span> </span><br><span>       =
  if (r-&gt;flags &amp; RT_METRIC_DEFINED)</span><br><span>         {</span=
><br><span>@@ -1477,6 +1488,7 @@</span><br><span> </span><br><span> #if def=
ined(TARGET_LINUX)</span><br><span>     const char *iface =3D NULL;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const in_addr_t *gatewa=
y =3D &amp;r-&gt;gateway;</span><br><span>     int metric =3D -1;</span><br=
><span> </span><br><span>     if (is_on_link(is_local_route, flags, rgi))</=
span><br><span>@@ -1484,6 +1496,12 @@</span><br><span>         iface =3D rg=
i-&gt;iface;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if ((r-&gt;flags &amp; RT_ON_LINK) &a=
mp;&amp; tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gateway =3D N=
ULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        iface =
=3D tt-&gt;actual_name;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>     if (r-&gt;flags &amp; RT_METRIC_DEFINED)</span><br><span>     {=
</span><br><span>         metric =3D r-&gt;metric;</span><br><span>@@ -1491=
,8 +1509,8 @@</span><br><span> </span><br><span> </span><br><span>     stat=
us =3D RTA_SUCCESS;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  int ret =3D net_route_v4_add(ctx, &amp;r-&gt;network, netmask_to_netbits2=
(r-&gt;netmask), &amp;r-&gt;gateway,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                               iface, r-&gt;table_id, metric=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D n=
et_route_v4_add(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-&gt;netmask)=
, gateway, iface,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                             r-&gt;table_id, metric);</span><br><span>     =
if (ret =3D=3D -EEXIST)</span><br><span>     {</span><br><span>         msg=
(D_ROUTE, &quot;NOTE: Linux route add command failed because route exists&q=
uot;);</span><br><span>@@ -1615,7 +1633,15 @@</span><br><span>     }</span>=
<br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    argv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot;, net=
work, gateway, netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if ((r-&gt;flags &amp; RT_ON_LINK) &amp;&amp; tt)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;argv, &quot;-net %s/%=
d -iface %s&quot;, network, netmask_to_netbits2(r-&gt;netmask),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        tt-&gt;=
actual_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;argv, &quot;-net=
 %s %s %s&quot;, network, gateway, netmask);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     /* FI=
XME -- add on-link support for FreeBSD */</span><br><span> </span><br><span=
>@@ -2034,7 +2060,16 @@</span><br><span>         metric =3D r-&gt;metric;</=
span><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (net_route_v4_del(ctx, &amp;r-&gt;network, netmask=
_to_netbits2(r-&gt;netmask), &amp;r-&gt;gateway, NULL,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const in_addr_t *gateway =3D &amp;r-=
&gt;gateway;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st char *iface =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((r-&gt=
;flags &amp; RT_ON_LINK) &amp;&amp; tt)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        gateway =3D NULL;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        iface =3D tt-&gt;actual_name;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (net_route_v4_del(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-&gt;ne=
tmask), gateway, iface,</span><br><span>                          r-&gt;tab=
le_id, metric)</span><br><span>         &lt; 0)</span><br><span>     {</spa=
n><br><span>@@ -2090,7 +2125,15 @@</span><br><span> </span><br><span> #elif=
 defined(TARGET_FREEBSD)</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s delete -net %s %s =
%s&quot;, ROUTE_PATH, network, gateway, netmask);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if ((r-&gt;flags &amp; RT_ON_LINK) &amp;&=
amp; tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&amp;=
argv, &quot;%s delete -net %s/%d -iface %s&quot;, ROUTE_PATH, network,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    netm=
ask_to_netbits2(r-&gt;netmask), tt-&gt;actual_name);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   argv_printf(&amp;argv, &quot;%s delete -net %s %s %s&quot;, ROUTE_PATH, =
network, gateway, netmask);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span> </span><br><span>     argv_msg(D_ROUTE, &amp=
;argv);</span><br><span>     openvpn_execve_check(&amp;argv, es, 0, &quot;E=
RROR: FreeBSD route delete command failed&quot;);</span><br><span>diff --gi=
t a/src/openvpn/route=2Eh b/src/openvpn/route=2Eh</span><br><span>index 0d3=
3d36=2E=2E7c5528f 100644</span><br><span>--- a/src/openvpn/route=2Eh</span>=
<br><span>+++ b/src/openvpn/route=2Eh</span><br><span>@@ -80,6 +80,10 @@</s=
pan><br><span>     const char *gateway;</span><br><span>     int table_id;<=
/span><br><span>     const char *metric;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* on Linux and FreeBSD, install the route on-link=
 on the tun device</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * instead of via the gateway (needed under DCO, where the kernel select=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the peer by=
 the route&#39;s next hop) */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    bool on_link;</span><br><span> };</span><br><span> </span><br=
><span> /* redirect-gateway flags */</span><br><span>@@ -120,6 +124,7 @@</s=
pan><br><span> #define RT_DEFINED        (1u &lt;&lt; 0)</span><br><span> #=
define RT_ADDED          (1u &lt;&lt; 1)</span><br><span> #define RT_METRIC=
_DEFINED (1u &lt;&lt; 2)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define RT_ON_LINK        (1u &lt;&lt; 3) /* see struct route_option=
=2Eon_link */</span><br><span>     struct route_ipv4 *next;</span><br><span=
>     unsigned int flags;</span><br><span>     const struct route_option *o=
ption;</span><br><span>@@ -311,8 +316,9 @@</span><br><span>                =
const struct route_gateway_info *rgi, const struct env_set *es,</span><br><=
span>                openvpn_net_ctx_t *ctx);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-void add_route_to_option_list(str=
uct route_option_list *l, const char *network, const char *netmask,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
 const char *gateway, const char *metric, int table_id);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+struct route_option *add_route_to_opti=
on_list(struct route_option_list *l, const char *network,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                     =
         const char *netmask, const char *gateway,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                            =
  const char *metric, int table_id);</span><br><span> </span><br><span> voi=
d add_route_ipv6_to_option_list(struct route_ipv6_option_list *l, const cha=
r *prefix,</span><br><span>                                    const char *=
gateway, const char *metric, int table_id);</span><br><span>diff --git a/te=
sts/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2E=
am</span><br><span>index 38299f5=2E=2E78f4b6c 100644</span><br><span>--- a/=
tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tes=
ts/openvpn/Makefile=2Eam</span><br><span>@@ -21,6 +21,7 @@</span><br><span>=
 	push_update_msg_testdriver \</span><br><span> 	socket_testdriver \</span>=
<br><span> 	ssl_testdriver \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	subnet_pool_testdriver \</span><br><span> 	user_pass_testdriver</=
span><br><span> </span><br><span> if HAVE_LD_WRAP_SUPPORT</span><br><span>@=
@ -384,6 +385,19 @@</span><br><span> 	$(top_srcdir)/src/openvpn/platform=2E=
c \</span><br><span> 	$(top_srcdir)/src/openvpn/mbuf=2Ec</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+subnet_pool_testdriv=
er_CFLAGS  =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-I=
$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvp=
n \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	@TEST_CFLAGS@</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+subnet_pool_testdriver_LDFLAGS =3D @TEST=
_LDFLAGS@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+subnet_pool_testdriver_SOURCE=
S =3D test_subnet_pool=2Ec \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	mock_msg=2Ec test_common=2Eh \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	mock_get_random=2Ec \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/opti=
ons_util=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(to=
p_srcdir)/src/openvpn/platform=2Ec</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> misc_testdriver_CFLAGS  =3D \</span><br><s=
pan> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/sr=
c/openvpn \</span><br><span> 	-DSOURCEDIR=3D\&quot;$(top_srcdir)\&quot; @TE=
ST_CFLAGS@</span><br><span>diff --git a/tests/unit_tests/openvpn/test_subne=
t_pool=2Ec b/tests/unit_tests/openvpn/test_subnet_pool=2Ec</span><br><span>=
new file mode 100644</span><br><span>index 0000000=2E=2E5ce4c76</span><br><=
span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_subn=
et_pool=2Ec</span><br><span>@@ -0,0 +1,143 @@</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a sin=
gle UDP port, with support for SSL/TLS-based</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             session authentication and key exch=
ange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 packet encryption, packet authentication, and</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 OpenVPN Inc &lt;sales@ope=
nvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is fr=
ee software; you can redistribute it and/or modify</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Pu=
blic License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  as published by the Free Software Foundation=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  This program is distributed in the hope that it will =
be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but W=
ITHOUT ANY WARRANTY; without even the implied warranty of</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A =
PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  GNU General Public License for more details=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU Gen=
eral Public License along</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licens=
es/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
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
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* a single pool &lt;n=
et&gt;/&lt;mask&gt; with gateway &lt;gw&gt;, checked against the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * 10=2E8=2E0=2E0/24 --server =
network */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bo=
ol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_one(in_addr=
_t net, in_addr_t mask, in_addr_t gw)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct subnet_pool_def d =3D { =2Enext =3D NULL, =2Etag =3D &quot;grp&q=
uot;, =2Enetwork =3D net, =2Enetmask =3D mask, =2Egateway =3D gw };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return subnet_pools_check(&amp;d, 0x0a0800=
00, 0xffffff00, M_WARN);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* --subnet-pool geometry: anyth=
ing ifconfig_pool_init() cannot serve must be</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * refused when the config is checked, not when t=
he first client connects */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_subnet_pools_check_netmask(void **state)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* the bounds of --server: /16 =2E=2E /29 */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(check_one(0x0a090000, =
0xffff0000, 0x0a090001));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_true(check_one(0x0a090000, 0xffffff00, 0x0a090001));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(check_one=
(0x0a090000, 0xfffffff8, 0x0a090001));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* /30, /31, /32: too few addresses for a pool */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check=
_one(0x0a090000, 0xfffffffc, 0x0a090001));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_false(check_one(0x0a090000, 0xfffffffe, 0=
x0a090001));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_false(check_one(0x0a090000, 0xffffffff, 0x0a090000));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* /15: larger than IFCONFIG_POOL=
_MAX */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_f=
alse(check_one(0x0a080000, 0xfffe0000, 0x0a080001));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* non-contiguous netmask */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_one(0=
x0a000900, 0xff00ff00, 0x0a000901));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+test_subnet_pools_check_gate=
way(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* any host addr=
ess of the subnet is fine, not only the first one */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(check_one(0x0a090000, 0xf=
fffff00, 0x0a0900fe));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(check_one(0x0a090000, 0xffffff00, 0x0a090080));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* network address, broa=
dcast address, outside the subnet */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_false(check_one(0x0a090000, 0xffffff00, 0x0a090=
000));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fa=
lse(check_one(0x0a090000, 0xffffff00, 0x0a0900ff));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_one(0x0a090000, 0x=
ffffff00, 0x0a0a0001));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_subnet_pools_check_overlap(void **st=
ate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_def b =3D =
{ =2Enext =3D NULL, =2Etag =3D &quot;grpB&quot;, =2Enetwork =3D 0x0a0a0000,=
 =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a0a0001 };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_def a =3D { =2E=
next =3D &amp;b, =2Etag =3D &quot;grpA&quot;, =2Enetwork =3D 0x0a090000, =
=2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a090001 };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* disjoint pools, disjoint from --server */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(subnet_pools_=
check(&amp;a, 0x0a080000, 0xffffff00, M_WARN));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* a pool inside the --server network =2E=2E=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(subnet_pools_c=
heck(&amp;a, 0x0a090000, 0xffffff00, M_WARN));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* =2E=2E=2E or covering it */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(subnet_pools_che=
ck(&amp;a, 0x0a0a0080, 0xffffff80, M_WARN));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* no --server network: only the pools are che=
cked against each other */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_true(subnet_pools_check(&amp;a, 0, 0, M_WARN));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* a /16 grpB containing grpA */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_def b16 =
=3D { =2Enext =3D NULL, =2Etag =3D &quot;grpB&quot;, =2Enetwork =3D 0x0a090=
000, =2Enetmask =3D 0xffff0000, =2Egateway =3D 0x0a090101 };</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_def a16 =3D=
 { =2Enext =3D &amp;b16, =2Etag =3D &quot;grpA&quot;, =2Enetwork =3D 0x0a09=
0000, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a090001 };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(subnet_pools_che=
ck(&amp;a16, 0, 0, M_WARN));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the=
 same tag defined twice */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct subnet_pool_def bdup =3D { =2Enext =3D NULL, =2Etag =3D &=
quot;grpA&quot;, =2Enetwork =3D 0x0a0a0000, =2Enetmask =3D 0xffffff00, =2Eg=
ateway =3D 0x0a0a0001 };</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct subnet_pool_def adup =3D { =2Enext =3D &amp;bdup, =2Etag =
=3D &quot;grpA&quot;, =2Enetwork =3D 0x0a090000, =2Enetmask =3D 0xffffff00,=
 =2Egateway =3D 0x0a090001 };</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_false(subnet_pools_check(&amp;adup, 0, 0, M_WARN));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+const struct CMUnitTest subnet_pool_tests[] =3D {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_sub=
net_pool_by_tag),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
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
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Antonio Quartulli &lt;antonio@mandelbi=
t=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body>=
</html>
--1QM8jUtpgpk=--


--===============6102885188806618541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6102885188806618541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6102885188806618541==--

