Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84CFCCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 22:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BSIOwiKpmwJXeBgFZP+WjNBcSwI69tXpXU4eGGFLt6g=; b=XeFQkGrPVdsLfj+IVBB1EKJmGG
	RtKkZ5b23oFAI/T8hqiMIXCg0PcQ5FfAeSxWLe033VxuKRVa9dQbZRC1wPkGiBnfQk0v+AAbH6KJR
	oBdAQSKQUcs9KAC8Imu6z/RcEBU2bj7J3UTWdHvbh9NlfNZe1R7AH9cBsQgcMb6z+26c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIDGb-0006ev-8D;
	Sat, 17 Oct 2026 22:52:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIDGY-0006em-GP
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 22:52:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nscMvE22aq043PES6E/3aa5F1ssLafmuwDfCkw9A9ZI=; b=ORkVEv3yA8CQlFLMY/l70YQDHA
 q3qGx3/iPT4PwdKMQflDM7VSUU29aIJcwqkV2rx5/u8pUFL5PcEXh9iE5xp5SjHl66cnuZ1MtN43B
 te+PdlZgioBJYEPa38rf7LrbsNrH9umQFbAfai/lj/8116tNyIGl1EKdlspG6UTRYANM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nscMvE22aq043PES6E/3aa5F1ssLafmuwDfCkw9A9ZI=; b=i
 Skf9Rd0dCcZf0kKr8+6yHWQexnMilE4gK567AhFLmmWS7YTW8DDL/FjKZtGe60s23+01xY3AL7Qy2
 UuH5ef+90UlW5cgqjqZf/KisfhmOkB4RTZYuy1yf8f8sGvNdib5aZuN2oA7PWmk58408u76wbVBBQ
 ZK8WRr/d3J61jl7o=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIDGS-0004TB-Vq for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 22:52:38 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso321860f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 15:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792277546; x=1792882346; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nscMvE22aq043PES6E/3aa5F1ssLafmuwDfCkw9A9ZI=;
 b=V/a7HuCa/PbIv//kU6dR3tgD2iAnXlOEUOw+JRF97bhl7to+n6cGhzfviz7lRMmeaU
 0hSJd5UIjNJvVAedZa0EAB+aQX0cXJv2Aq4ifn5hBmEOSeEKL3tYOIoS9Eap91COxYko
 caOIAGIV9ACk57/cB4fw2WHvx4QbDE/LN5eHXIgrYhvPU9pYX8u/hV0n8BXekK1Ciy/h
 H1xOJbKnii1FeSdzFWXMEbkqdMlLPLFpe7c62SLSxD5KSV+U3z2gw3W76cBSWtsd66hQ
 oF/89HKg9BkDguBiwhJHq71VgKEEyaPq1aJpYmgsVTed9MxgrEQa3pqBvdZC24mIwi7G
 HnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792277546; x=1792882346;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nscMvE22aq043PES6E/3aa5F1ssLafmuwDfCkw9A9ZI=;
 b=yQxXXPtRosewkLEkdY0wu9Fh8CDc39OX+nPzTNgMQRgXIMlwi9mjfEZ7dSfgGFpVde
 hBZoAcnDMIGjlbMwGrRHBSe0P27zqLdP7JMoXAHDMf7WxidNFkOtUE4aNx1eAPKr2Zel
 8TQWfsi49yJjxrUdsKLrfss76HDKCk2YBnGRr0TXtR1vgu5xNgmnt7Re3NYtvbhyNbb7
 /ouFNWxe9wC0Z/R//BNCbiZn9DLkRCPKnCnP5RZHGSBNt1w2uX4/VVucY7zdUmbPhXsl
 4x07DpIj8+fxraZ+quVp3OpViS/r8Buh9MmJXv7M6YV7r/l33WfyOvOs1ZT/SYCIaK3S
 hkEg==
X-Gm-Message-State: AFq9FYKEwLBglaMLNyPqqK04U9c5lhIc0JKzwhOJFPlBNbRzeL7STjOq
 jiw49nyqEMBY2AuOYz9zf5fst1FCwXcch7cV0uflPAwmU4WxGMHlJ7pkdyEIKpMcLAPy1KtRMyv
 ofMaO8lAol6BkfYwJYcshEC+ovdih/ZdysgY6fh4nAOO3xgHzy8jtSU3HnIYqcswWxP+m
X-Gm-Gg: AYBFou3O37RhHfa+t40pvDJwDm5Y5whmj4ZgTVw9ruVN6tvWc++e8q61sKOEwHX8O/4
 HtuiN3QiLhkwwp+iLpAAr+sKpZVo5AaOC8Yk/ivgE31d5uWRPBylqwLqTHsUeNE1pw2VKTJNEDJ
 0S59DI67gjA00Xnt8xk6rYjD4FYUAGm3Hj6W5k6R4sWjWovJAyOjZHu4liaj3GnBAzh0xY1ndVk
 9ajp5dimuRIN67yutngX6Jgc6/6wIxlEyaAj59m6zQcO6D9bW61ArY2RVaGAHkdKjhW1yIa/hva
 EeRqAKkqRPNzG7AzdDnnpfUrBUAqvxi0IrQID/aL9xqmHy6PnfQnXmsAadQYhTJ1zth/+an2Ich
 j/udhBNCn/HWG47RlNBmIjBqmPRuJL1zOl3Tn5wN6bG0oqF8IRakWDq+z4QxGjof1/7nm3REt5h
 9CYJfrOZtixnevg/SzIeTA8+L75l5y7VGvIeZaZ7/oHUilh9Qu6sN/ZEg9hn+wW9aSkbh1kiRCS
 K8eVwk6yA4Sk1rqsYzBoBy1+3j9BqzcgbCz5aMrQmfWTUcIRvgu0e9FJOXCH6J9j/7RxgQHQjAt
 Fxbp+d9E83YhsXiCQnoRM0slqyUJ7lUxn8isemtgLM4lQIU6tkgrm9nt8Z0+
X-Received: by 2002:a05:6000:3c9:b0:48d:f470:6b3e with SMTP id
 ffacd0b85a97d-48e08017195mr6008820f8f.13.1792277545848; 
 Sat, 17 Oct 2026 15:52:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd500e75sm13210067f8f.42.2026.10.17.15.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 15:52:25 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 22:52:22 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
X-Gerrit-Change-Number: 1783
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1783?usp=email>
X-Gerrit-Commit: 3e543fe30b84e2f41c8c75aba832014e14ed0af2
In-Reply-To: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
References: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLklhMWU3ZGI5NTYxNWQ5OWVmOTY4N2RlN2M0ZTk5NmRjODAzM2UyNjMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d7b7c42137a8bd0415c235d07dcff401773452b4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIDGS-0004TB-Vq
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
Content-Type: multipart/mixed; boundary="===============4457876447550753157=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4457876447550753157==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XjWJ7m5qqcg="; charset=UTF-8

--XjWJ7m5qqcg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
ello Arne Schwabe, Frank Lichtenheld, 

I'd like you to reexamine a change=
=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=
=3Demail

to look at the new patch set (#4)=2E


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
cannot reach its subnet-pool clients when th=
e data channel runs in
userspace (with DCO each such client additionally ge=
ts an on-link host
route on connect, as its address is outside the --ifconf=
ig network)=2E

Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
GitHub=
: closes openvpn/OpenVPN#987
Signed-off-by: Antonio Quartulli <antonio@mand=
elbit=2Ecom>
---
M CMakeLists=2Etxt
M doc/man-sections/server-options=2Erst=

M src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/options=2Ec
=
M src/openvpn/options=2Eh
M src/openvpn/options_util=2Ec
M src/openvpn/opti=
ons_util=2Eh
M src/openvpn/pool=2Ec
M src/openvpn/pool=2Eh
M tests/unit_tes=
ts/openvpn/Makefile=2Eam
A tests/unit_tests/openvpn/test_subnet_pool=2Ec
12=
 files changed, 589 insertions(+), 6 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/83/1783/4

diff --git a/CMakeLi=
sts=2Etxt b/CMakeLists=2Etxt
index b286ee2=2E=2E4e87a6a 100644
--- a/CMakeL=
ists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -694,6 +694,7 @@
         "test_provid=
er"
         "test_socket"
         "test_ssl"
+        "test_subnet_pool"
=
         "test_user_pass"
         "test_push_update_msg"
         )
@@ -86=
8,6 +869,11 @@
         src/openvpn/session_id=2Ec
     )
 
+    target_sou=
rces(test_subnet_pool PRIVATE
+        tests/unit_tests/openvpn/mock_get_ra=
ndom=2Ec
+        src/openvpn/options_util=2Ec
+        )
+
     target_sou=
rces(test_ncp PRIVATE
         src/openvpn/crypto_epoch=2Ec
         src/op=
envpn/crypto_mbedtls=2Ec
diff --git a/doc/man-sections/server-options=2Erst=
 b/doc/man-sections/server-options=2Erst
index 9dfa6bd=2E=2Eb6eab9a 100644
=
--- a/doc/man-sections/server-options=2Erst
+++ b/doc/man-sections/server-o=
ptions=2Erst
@@ -330,6 +330,38 @@
   by ``--ifconfig``, OpenVPN will instal=
l a /32 host route for the ``local``
   IP address=2E
 
+--subnet-pool args=

+  Define a named pool of addresses from a subnet different from the
+  ``=
--server`` network, so groups of clients can be given IPs from separate
+  =
subnets for per-group firewall rules under ``--topology subnet`` (and
+  th=
erefore DCO)=2E This is a main-config directive and may be repeated to
+  d=
efine several pools=2E
+
+  Valid syntax:
+  ::
+
+     subnet-pool tag net=
work netmask [gateway]
+
+  ``tag`` is a name a client refers to with ``--s=
ubnet-pool-tag``; ``gateway``
+  defaults to the first address of ``network=
``/``netmask`` and is never
+  assigned to a client=2E A client assigned to=
 a pool receives (dynamically, or
+  via a static ``--ifconfig-push`` that =
must lie within the subnet) an address
+  from it, plus the matching netmas=
k=2E
+
+  Requires ``--server`` with ``--dev tun`` and ``--topology subnet`=
`=2E
+  ``netmask`` must be between /16 and /29 (as for ``--server``), ``ga=
teway``
+  must be a host address inside the subnet, each ``tag`` may be de=
fined only
+  once and no pool may overlap another one or the ``--server`` =
network=2E
+
+  The server routes each pool's subnet into the tun device, a=
s it does for
+  the ``--server`` network; no ``--route`` needs to be added=
 for it=2E
+
+--subnet-pool-tag tag
+  Assign this client to the ``--subnet=
-pool`` named ``tag``=2E Must be
+  associated with a specific client insta=
nce via ``--client-config-dir`` or
+  ``--client-connect``=2E Several clien=
ts may reference the same tag and are
+  then served from the same shared p=
ool=2E
+
 --ifconfig-ipv6-push args
   for ``--client-config-dir`` per-clie=
nt static IPv6 interface
   configuration, see ``--client-config-dir`` and =
``--ifconfig-push`` for
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/mu=
lti=2Ec
index a2cfdbf=2E=2E86fd9c0 100644
--- a/src/openvpn/multi=2Ec
+++ b=
/src/openvpn/multi=2Ec
@@ -43,6 +43,7 @@
 #include "auth_token=2Eh"
 #inclu=
de "route=2Eh"
 #include "sid_hash=2Eh"
+#include "options_util=2Eh"
 #incl=
ude <inttypes=2Eh>
 #include <string=2Eh>
 
@@ -54,6 +55,20 @@
 #include "d=
co=2Eh"
 #include "reflect_filter=2Eh"
 
+/*
+ * Dynamic address pool servi=
ng the clients of one --subnet-pool tag=2E  Shared
+ * by every client that=
 references the tag, created on first use=2E
+ */
+struct subnet_pool
+{
+ =
   struct subnet_pool *next;
+    const char *tag;
+    struct ifconfig_poo=
l *pool;
+};
+
+static struct ifconfig_pool *multi_get_group_pool(struct mu=
lti_context *m,
+                                                  const st=
ruct options *o, const char *tag);
+
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
=
 #ifdef MULTI_DEBUG_EVENT_LOOP
@@ -371,6 +386,13 @@
         }
     }
 
+  =
  /* create every --subnet-pool group up front rather than on first use, so=

+     * that its pool exists before any client of the group connects */
+ =
   for (const struct subnet_pool_def *d =3D t->options=2Esubnet_pools; d; d=
 =3D d->next)
+    {
+        multi_get_group_pool(m, &t->options, d->tag);=

+    }
+
     /*
      * Help us keep track of routing table=2E
      */
@=
@ -625,7 +647,8 @@
 
         schedule_remove_entry(m->schedule, (struct sc=
hedule_entry *)mi);
 
-        ifconfig_pool_release(m->ifconfig_pool, mi->=
vaddr_handle, false);
+        ifconfig_pool_release(mi->vaddr_pool ? mi->v=
addr_pool : m->ifconfig_pool, mi->vaddr_handle,
+                          =
    false);
 
         if (mi->did_iroutes)
         {
@@ -707,6 +730,14 @@=

         schedule_free(m->schedule);
         mbuf_free(m->mbuf);
        =
 ifconfig_pool_free(m->ifconfig_pool);
+        while (m->subnet_pools)
+  =
      {
+            struct subnet_pool *sp =3D m->subnet_pools;
+
+       =
     m->subnet_pools =3D sp->next;
+            ifconfig_pool_free(sp->pool=
);
+            free(sp);
+        }
         frequency_limit_free(m->new_c=
onnection_limiter);
         initial_rate_limit_free(m->initial_rate_limite=
r);
         multi_reap_free(m->reaper);
@@ -1405,6 +1436,12 @@
     const =
struct options *o =3D &c->options;
     if (o->push_ifconfig_constraint_def=
ined && c->c2=2Epush_ifconfig_defined)
     {
+        /* a subnet-pool cli=
ent is validated against its own subnet */
+        if (o->subnet_pool_defi=
ned)
+        {
+            return (o->subnet_pool_netmask & c->c2=2Epush_=
ifconfig_local)
+                   =3D=3D o->subnet_pool_network;
+       =
 }
         return (o->push_ifconfig_constraint_netmask & c->c2=2Epush_ifco=
nfig_local)
                =3D=3D o->push_ifconfig_constraint_network;
   =
  }
@@ -1415,6 +1452,37 @@
 }
 
 /*
+ * Return the dynamic pool serving the=
 clients tagged with <tag>, creating it
+ * on first use from the matching =
--subnet-pool definition in <o>=2E
+ */
+static struct ifconfig_pool *
+mul=
ti_get_group_pool(struct multi_context *m, const struct options *o, const c=
har *tag)
+{
+    struct subnet_pool *sp;
+
+    for (sp =3D m->subnet_pool=
s; sp; sp =3D sp->next)
+    {
+        if (!strcmp(sp->tag, tag))
+       =
 {
+            return sp->pool;
+        }
+    }
+
+    const struct subn=
et_pool_def *d4 =3D subnet_pool_by_tag(o->subnet_pools, tag);
+    ASSERT(d=
4);
+    ALLOC_OBJ_CLEAR(sp, struct subnet_pool);
+    sp->tag =3D d4->tag;=

+    /* every host address of the subnet, minus the gateway reserved below=
 */
+    sp->pool =3D ifconfig_pool_init(true, IFCONFIG_POOL_INDIV, d4->net=
work + 1,
+                                  (d4->network | ~d4->netmask) -=
 1, o->duplicate_cn, false,
+                                  in6addr_any,=
 0);
+    ifconfig_pool_reserve_ip(sp->pool, d4->gateway);
+    sp->next =
=3D m->subnet_pools;
+    m->subnet_pools =3D sp;
+    return sp->pool;
+}
=
+
+/*
  * Select a virtual address for a new client instance=2E
  * Use an =
--ifconfig-push directive, if given (static IP)=2E
  * Otherwise use an --i=
fconfig-pool address (dynamic IP)=2E
@@ -1424,6 +1492,25 @@
 {
     struct =
gc_arena gc =3D gc_new();
 
+    /* resolve --subnet-pool-tag against the m=
ain-config --subnet-pool list (an
+     * unknown tag is rejected with AUTH=
_FAILED in multi_connection_established)=2E
+     * This runs again after e=
very client-connect handler, and a later handler
+     * (script, plugin, m=
anagement) may override the tag set by the CCD file,
+     * so always reso=
lve the current tag=2E */
+    if (mi->context=2Eoptions=2Esubnet_pool_tag)=

+    {
+        const struct subnet_pool_def *d =3D
+            subnet_po=
ol_by_tag(m->top=2Eoptions=2Esubnet_pools, mi->context=2Eoptions=2Esubnet_p=
ool_tag);
+
+        mi->context=2Eoptions=2Esubnet_pool_defined =3D d !=3D=
 NULL;
+        if (d)
+        {
+            mi->context=2Eoptions=2Esubn=
et_pool_network =3D d->network;
+            mi->context=2Eoptions=2Esubnet=
_pool_netmask =3D d->netmask;
+            mi->context=2Eoptions=2Esubnet_p=
ool_gateway =3D d->gateway;
+        }
+    }
+
     /*
      * If ifconfig=
 addresses were set by dynamic config file,
      * release pool addresses,=
 otherwise keep them=2E
@@ -1434,8 +1521,10 @@
          * release dynamic =
allocation */
         if (mi->vaddr_handle >=3D 0)
         {
-           =
 ifconfig_pool_release(m->ifconfig_pool, mi->vaddr_handle, true);
+        =
    ifconfig_pool_release(mi->vaddr_pool ? mi->vaddr_pool : m->ifconfig_poo=
l,
+                                  mi->vaddr_handle, true);
            =
 mi->vaddr_handle =3D -1;
+            mi->vaddr_pool =3D NULL;
         }
=
 
         mi->context=2Ec2=2Epush_ifconfig_defined =3D true;
@@ -1455,6 +1=
544,50 @@
                 "MULTI_sva: WARNING: if --ifconfig-push is used =
for IPv4, automatic IPv6 assignment from --ifconfig-ipv6-pool does not work=
=2E  Use --ifconfig-ipv6-push for IPv6 then=2E");
         }
     }
+    el=
se if (mi->context=2Eoptions=2Esubnet_pool_defined)
+    {
+        /* dyna=
mic address from this client's --subnet-pool group */
+        struct ifcon=
fig_pool *group =3D
+            multi_get_group_pool(m, &m->top=2Eoptions,=
 mi->context=2Eoptions=2Esubnet_pool_tag);
+
+        /* the address may ha=
ve been acquired before the tag was known (from
+         * the global pool=
) or for a tag that a later handler overrode: drop
+         * it so we ser=
ve this client from its current group */
+        if (mi->vaddr_handle >=3D=
 0 && mi->vaddr_pool !=3D group)
+        {
+            ifconfig_pool_rele=
ase(mi->vaddr_pool ? mi->vaddr_pool : m->ifconfig_pool,
+                  =
                mi->vaddr_handle, true);
+            mi->vaddr_handle =3D =
-1;
+            mi->vaddr_pool =3D NULL;
+            mi->context=2Ec2=2Ep=
ush_ifconfig_defined =3D false;
+        }
+
+        if (mi->vaddr_handle =
< 0)
+        {
+            in_addr_t local =3D 0, remote =3D 0;
+        =
    const char *cn =3D NULL;
+
+            if (!mi->context=2Eoptions=2Edu=
plicate_cn)
+            {
+                cn =3D tls_common_name(mi->cont=
ext=2Ec2=2Etls_multi, true);
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
@@ -2360,10 +2493,9 @@
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
2471,6 +2603,7 @@
 
     /* reset pool handle to null */
     mi->vaddr_han=
dle =3D -1;
+    mi->vaddr_pool =3D NULL;
 
     /* do --client-connect set=
envs */
     multi_select_virtual_addr(m, mi);
@@ -2792,6 +2925,15 @@
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
index 7fc8614=2E=2Ecd=
29fc4 100644
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
@@ -3123,6 +3143,25 @@
     }
 }
 
+/*
+ * The server's tun device is =
only configured with the --server network, so
+ * route each --subnet-pool =
network into it as well: without this the server
+ * could not reach its su=
bnet-pool clients when the data channel runs in
+ * userspace (under DCO, e=
ach such client additionally gets an on-link host
+ * route when it connect=
s, see multi_learn_in_addr_t())=2E
+ */
+static void
+options_postprocess_s=
ubnet_pool_routes(struct options *o)
+{
+    for (const struct subnet_pool_=
def *d =3D o->subnet_pools; d; d =3D d->next)
+    {
+        rol_check_all=
oc(o);
+        add_route_to_option_list(o->routes, print_in_addr_t(d->netw=
ork, 0, &o->gc),
+                                 print_in_addr_t(d->netma=
sk, 0, &o->gc), NULL, NULL,
+                                 o->route_defa=
ult_table_id);
+    }
+}
+
 static void
 options_postprocess_mutate(struct =
options *o, struct env_set *es)
 {
@@ -3139,6 +3178,7 @@
     if (o->mode =
=3D=3D MODE_SERVER)
     {
         helper_hashmap_sizes(o);
+        optio=
ns_postprocess_subnet_pool_routes(o);
     }
 
     options_postprocess_set=
default_ncpciphers(o);
@@ -6245,6 +6285,43 @@
             goto err;
      =
   }
     }
+    else if (streq(p[0], "subnet-pool") && p[1] && p[2] && p[3=
] && !p[5])
+    {
+        struct subnet_pool_def *sp;
+        in_addr_t =
network, netmask;
+
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        net=
work =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[2], 0, NULL, NULL)=
;
+        netmask =3D getaddr(GETADDR_HOST_ORDER, p[3], 0, NULL, NULL);
+ =
       if (!network || !netmask)
+        {
+            msg(msglevel, "can=
not parse --subnet-pool addresses");
+            goto err;
+        }
+   =
     ALLOC_OBJ_GC(sp, struct subnet_pool_def, &options->gc);
+        sp->t=
ag =3D p[1];
+        sp->network =3D network & netmask;
+        sp->netma=
sk =3D netmask;
+        sp->gateway =3D (network & netmask) + 1;
+        =
if (p[4])
+        {
+            bool ok =3D false;
+
+            sp->gat=
eway =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[4], 0, &ok, NULL);=

+            if (!ok)
+            {
+                msg(msglevel, "canno=
t parse --subnet-pool gateway");
+                goto err;
+            }
=
+        }
+        sp->next =3D options->subnet_pools;
+        options->s=
ubnet_pools =3D sp;
+    }
+    else if (streq(p[0], "subnet-pool-tag") && =
p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_INSTANCE);
+        =
options->subnet_pool_tag =3D p[1];
+    }
     else if (streq(p[0], "ifconf=
ig-push-constraint") && p[1] && p[2] && !p[3])
     {
         in_addr_t ne=
twork, netmask;
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=
=2Eh
index d347830=2E=2E028b1e6 100644
--- a/src/openvpn/options=2Eh
+++ b/=
src/openvpn/options=2Eh
@@ -252,6 +252,17 @@
     struct verify_hash_list *=
next;
 };
 
+/* A named --subnet-pool: a subnet clients can be assigned fro=
m, referenced
+ * from a CCD file by its tag via --subnet-pool-tag=2E */
+s=
truct subnet_pool_def
+{
+    struct subnet_pool_def *next;
+    const char=
 *tag;
+    in_addr_t network;
+    in_addr_t netmask;
+    in_addr_t gatew=
ay;
+};
+
 /* Command line options */
 struct options
 {
@@ -518,6 +529,12 =
@@
     bool push_ifconfig_constraint_defined;
     in_addr_t push_ifconfig=
_constraint_network;
     in_addr_t push_ifconfig_constraint_netmask;
+    =
struct subnet_pool_def *subnet_pools; /* named pools (server config) */
+  =
  const char *subnet_pool_tag;          /* which pool this client uses (CCD=
) */
+    bool subnet_pool_defined;             /* resolved from the tag at=
 connect */
+    in_addr_t subnet_pool_network;
+    in_addr_t subnet_pool_=
netmask;
+    in_addr_t subnet_pool_gateway;
     bool push_ifconfig_ipv4_b=
locked;           /* IPv4 */
     bool push_ifconfig_ipv6_defined;         =
  /* IPv6 */
     struct in6_addr push_ifconfig_ipv6_local;  /* IPv6 */
dif=
f --git a/src/openvpn/options_util=2Ec b/src/openvpn/options_util=2Ec
index=
 d25d85c=2E=2E744ad4c 100644
--- a/src/openvpn/options_util=2Ec
+++ b/src/o=
penvpn/options_util=2Ec
@@ -30,6 +30,91 @@
 #include "options_util=2Eh"
 
 =
#include "push=2Eh"
+#include "pool=2Eh"
+
+const struct subnet_pool_def *
=
+subnet_pool_by_tag(const struct subnet_pool_def *pools, const char *tag)
+=
{
+    for (const struct subnet_pool_def *d =3D pools; d; d =3D d->next)
+ =
   {
+        if (!strcmp(d->tag, tag))
+        {
+            return d;
+=
        }
+    }
+    return NULL;
+}
+
+/* true if the two IPv4 subnets sh=
are at least one address */
+static bool
+subnets_overlap(in_addr_t a, in_a=
ddr_t mask_a, in_addr_t b, in_addr_t mask_b)
+{
+    const in_addr_t mask =
=3D mask_a & mask_b;
+
+    return (a & mask) =3D=3D (b & mask);
+}
+
+bool=

+subnet_pools_check(const struct subnet_pool_def *pools, in_addr_t server_=
network,
+                   in_addr_t server_netmask, msglvl_t msglevel)
+=
{
+    for (const struct subnet_pool_def *d =3D pools; d; d =3D d->next)
+ =
   {
+        const in_addr_t host =3D ~d->netmask;
+        int netbits =
=3D 32;
+
+        /* the netmask must be contiguous */
+        if (host &=
 (host + 1))
+        {
+            msg(msglevel, "--subnet-pool %s: inval=
id netmask", d->tag);
+            return false;
+        }
+        for (i=
n_addr_t h =3D host; h; h >>=3D 1)
+        {
+            netbits--;
+    =
    }
+
+        /* same bounds as --server: the pool must hold at least 2 =
addresses
+         * besides network, gateway and broadcast, and fit IFCON=
FIG_POOL_MAX */
+        if (netbits < IFCONFIG_POOL_MIN_NETBITS || netbits=
 > 29)
+        {
+            msg(msglevel, "--subnet-pool %s: netmask mus=
t be between /%d and /29 (not /%d)",
+                d->tag, IFCONFIG_POOL=
_MIN_NETBITS, netbits);
+            return false;
+        }
+
+        if=
 ((d->gateway & d->netmask) !=3D d->network || d->gateway =3D=3D d->network=

+            || d->gateway =3D=3D (d->network | host))
+        {
+       =
     msg(msglevel, "--subnet-pool %s: gateway must be a host address inside=
 the subnet",
+                d->tag);
+            return false;
+       =
 }
+
+        if (server_netmask
+            && subnets_overlap(d->network=
, d->netmask, server_network, server_netmask))
+        {
+            msg(=
msglevel, "--subnet-pool %s: subnet overlaps the --server network", d->tag)=
;
+            return false;
+        }
+
+        for (const struct subnet=
_pool_def *e =3D d->next; e; e =3D e->next)
+        {
+            if (!st=
rcmp(d->tag, e->tag))
+            {
+                msg(msglevel, "--subn=
et-pool %s: tag defined more than once", d->tag);
+                return f=
alse;
+            }
+            if (subnets_overlap(d->network, d->netmas=
k, e->network, e->netmask))
+            {
+                msg(msglevel, "=
--subnet-pool %s and %s: subnets overlap", d->tag, e->tag);
+              =
  return false;
+            }
+        }
+    }
+
+    return true;
+}
 
 =
const char *
 parse_auth_failed_temp(struct options *o, const char *reason)=

diff --git a/src/openvpn/options_util=2Eh b/src/openvpn/options_util=2Eh
i=
ndex 5226a6f=2E=2Ed60759a 100644
--- a/src/openvpn/options_util=2Eh
+++ b/s=
rc/openvpn/options_util=2Eh
@@ -28,6 +28,31 @@
 
 const char *parse_auth_fa=
iled_temp(struct options *o, const char *reason);
 
+/**
+ * Look up a name=
d --subnet-pool in a list of pool definitions=2E
+ *
+ * @param pools  head=
 of the --subnet-pool list (may be NULL)
+ * @param tag    the --subnet-poo=
l-tag to match
+ * @return       the matching pool definition, or NULL if n=
one matches
+ */
+const struct subnet_pool_def *subnet_pool_by_tag(const st=
ruct subnet_pool_def *pools,
+                                             =
    const char *tag);
+
+/**
+ * Validate the --subnet-pool definitions: co=
ntiguous netmask between
+ * /IFCONFIG_POOL_MIN_NETBITS and /29, gateway a =
host address inside its
+ * subnet, unique tags, and no subnet overlapping =
another pool or the --server
+ * network=2E
+ *
+ * @param pools           =
head of the --subnet-pool list (may be NULL)
+ * @param server_network  the=
 --server network (host order)
+ * @param server_netmask  the --server netm=
ask, or 0 if there is none
+ * @param msglevel        level of the message =
logged on the first error
+ * @return                true if every definiti=
on is valid
+ */
+bool subnet_pools_check(const struct subnet_pool_def *poo=
ls, in_addr_t server_network,
+                        in_addr_t server_net=
mask, msglvl_t msglevel);
+
 
 /** Checks if the string is a valid integer =
by checking if it can be
  *  converted to an integer */
diff --git a/src/o=
penvpn/pool=2Ec b/src/openvpn/pool=2Ec
index 63fc930=2E=2Efa04d9c 100644
--=
- a/src/openvpn/pool=2Ec
+++ b/src/openvpn/pool=2Ec
@@ -350,7 +350,7 @@
 {
=
     bool ret =3D false;
 
-    if (pool && hand >=3D 0 && hand < pool->siz=
e)
+    if (pool && hand >=3D 0 && hand < pool->size && !pool->list[hand]=
=2Ereserved)
     {
         ifconfig_pool_entry_free(&pool->list[hand], ha=
rd);
         ret =3D true;
@@ -429,6 +429,22 @@
     return ret;
 }
 
+boo=
l
+ifconfig_pool_reserve_ip(struct ifconfig_pool *pool, const in_addr_t add=
r)
+{
+    const ifconfig_pool_handle h =3D ifconfig_pool_ip_base_to_handle=
(pool, addr);
+
+    if (h < 0)
+    {
+        return false;
+    }
+
+   =
 ifconfig_pool_entry_free(&pool->list[h], true);
+    pool->list[h]=2Ein_us=
e =3D true;
+    pool->list[h]=2Ereserved =3D true;
+    return true;
+}
+
=
 static in_addr_t
 ifconfig_pool_handle_to_ip_base(const struct ifconfig_po=
ol *pool, ifconfig_pool_handle hand)
 {
@@ -476,6 +492,13 @@
              =
     const bool fixed)
 {
     struct ifconfig_pool_entry *e =3D &pool->lis=
t[h];
+
+    if (e->reserved)
+    {
+        msg(M_WARN, "pool: ignoring p=
ersisted entry for CN=3D%s: its address is reserved", cn);
+        return;=

+    }
+
     ifconfig_pool_entry_free(e, true);
     e->in_use =3D false;=

     e->common_name =3D string_alloc(cn, NULL);
diff --git a/src/openvpn/p=
ool=2Eh b/src/openvpn/pool=2Eh
index e2d3f82=2E=2E497dcda 100644
--- a/src/=
openvpn/pool=2Eh
+++ b/src/openvpn/pool=2Eh
@@ -43,6 +43,7 @@
     char *co=
mmon_name;
     time_t last_release;
     bool fixed;
+    bool reserved; /=
* never handed out, e=2Eg=2E a --subnet-pool gateway */
 };
 
 struct ifcon=
fig_pool
@@ -86,6 +87,17 @@
 
 bool ifconfig_pool_release(struct ifconfig_p=
ool *pool, ifconfig_pool_handle hand, const bool hard);
 
+/**
+ * Permanen=
tly reserve the pool slot holding \c addr, so that it is never
+ * handed o=
ut to a client nor taken over by a persisted entry (e=2Eg=2E the
+ * gatewa=
y of a --subnet-pool)=2E
+ *
+ * @param pool  the pool
+ * @param addr  IPv=
4 address (host order) to reserve
+ * @return      true if \c addr lies in =
the pool and was reserved
+ */
+bool ifconfig_pool_reserve_ip(struct ifconf=
ig_pool *pool, in_addr_t addr);
+
 struct ifconfig_pool_persist *ifconfig_p=
ool_persist_init(const char *filename, int refresh_freq);
 
 void ifconfig_=
pool_persist_close(struct ifconfig_pool_persist *persist);
diff --git a/tes=
ts/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Ea=
m
index 38299f5=2E=2E78f4b6c 100644
--- a/tests/unit_tests/openvpn/Makefile=
=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -21,6 +21,7 @@
 	push=
_update_msg_testdriver \
 	socket_testdriver \
 	ssl_testdriver \
+	subnet_=
pool_testdriver \
 	user_pass_testdriver
 
 if HAVE_LD_WRAP_SUPPORT
@@ -384=
,6 +385,19 @@
 	$(top_srcdir)/src/openvpn/platform=2Ec \
 	$(top_srcdir)/sr=
c/openvpn/mbuf=2Ec
 
+subnet_pool_testdriver_CFLAGS  =3D \
+	-I$(top_srcdir=
)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	@TEST_=
CFLAGS@
+
+subnet_pool_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
+
+subnet_pool=
_testdriver_SOURCES =3D test_subnet_pool=2Ec \
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
index 0000000=2E=2E1bb9e4c
--- /dev/null
+++ b/tests/unit_tests/openvpn/t=
est_subnet_pool=2Ec
@@ -0,0 +1,146 @@
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
+    /* grpB grown to a /16=
 now contains grpA */
+    b=2Enetwork =3D 0x0a090000;
+    b=2Enetmask =3D=
 0xffff0000;
+    b=2Egateway =3D 0x0a090101;
+    assert_false(subnet_pool=
s_check(&a, 0, 0, M_WARN));
+
+    /* the same tag defined twice */
+    b=
=2Enetwork =3D 0x0a0a0000;
+    b=2Enetmask =3D 0xffffff00;
+    b=2Egatewa=
y =3D 0x0a0a0001;
+    b=2Etag =3D "grpA";
+    assert_false(subnet_pools_c=
heck(&a, 0, 0, M_WARN));
+}
+
+const struct CMUnitTest subnet_pool_tests[] =
=3D {
+    cmocka_unit_test(test_subnet_pool_by_tag),
+    cmocka_unit_test=
(test_subnet_pools_check_netmask),
+    cmocka_unit_test(test_subnet_pools_=
check_gateway),
+    cmocka_unit_test(test_subnet_pools_check_overlap),
+};=

+
+int
+main(void)
+{
+    openvpn_unit_test_setup();
+    return cmocka_r=
un_group_tests(subnet_pool_tests, NULL, NULL);
+}

-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e263=
1
Gerrit-Change-Number: 1783
Gerrit-PatchSet: 4
Gerrit-Owner: Antonio Quart=
ulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Fran=
k Lichtenheld <frank@lichtenheld=2Ecom>

--XjWJ7m5qqcg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Antonio Qu=
artulli <strong>uploaded patch set #4</strong> to this change=2E</p><p><a h=
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
ach its subnet-pool clients when the data channel runs in<br>userspace (wit=
h DCO each such client additionally gets an on-link host<br>route on connec=
t, as its address is outside the --ifconfig network)=2E<br><br>Change-Id: I=
a1e7db95615d99ef9687de7c4e996dc8033e2631<br>GitHub: closes openvpn/OpenVPN#=
987<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>=
---<br>M CMakeLists=2Etxt<br>M doc/man-sections/server-options=2Erst<br>M s=
rc/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M src/openvpn/options=2E=
c<br>M src/openvpn/options=2Eh<br>M src/openvpn/options_util=2Ec<br>M src/o=
penvpn/options_util=2Eh<br>M src/openvpn/pool=2Ec<br>M src/openvpn/pool=2Eh=
<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests/unit_tests/openvpn/=
test_subnet_pool=2Ec<br>12 files changed, 589 insertions(+), 6 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/83/1783/4</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLi=
sts=2Etxt</span><br><span>index b286ee2=2E=2E4e87a6a 100644</span><br><span=
>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><s=
pan>@@ -694,6 +694,7 @@</span><br><span>         &quot;test_provider&quot;<=
/span><br><span>         &quot;test_socket&quot;</span><br><span>         &=
quot;test_ssl&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        &quot;test_subnet_pool&quot;</span><br><span>         &quot;test_us=
er_pass&quot;</span><br><span>         &quot;test_push_update_msg&quot;</sp=
an><br><span>         )</span><br><span>@@ -868,6 +869,11 @@</span><br><spa=
n>         src/openvpn/session_id=2Ec</span><br><span>     )</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    target_sourc=
es(test_subnet_pool PRIVATE</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        tests/unit_tests/openvpn/mock_get_random=2Ec</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/options_util=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        )</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     tar=
get_sources(test_ncp PRIVATE</span><br><span>         src/openvpn/crypto_ep=
och=2Ec</span><br><span>         src/openvpn/crypto_mbedtls=2Ec</span><br><=
span>diff --git a/doc/man-sections/server-options=2Erst b/doc/man-sections/=
server-options=2Erst</span><br><span>index 9dfa6bd=2E=2Eb6eab9a 100644</spa=
n><br><span>--- a/doc/man-sections/server-options=2Erst</span><br><span>+++=
 b/doc/man-sections/server-options=2Erst</span><br><span>@@ -330,6 +330,38 =
@@</span><br><span>   by ``--ifconfig``, OpenVPN will install a /32 host ro=
ute for the ``local``</span><br><span>   IP address=2E</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+--subnet-pool args</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  Define a named pool o=
f addresses from a subnet different from the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  ``--server`` network, so groups of clients can b=
e given IPs from separate</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  subnets for per-group firewall rules under ``--topology subnet`` (a=
nd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  therefore DCO)=
=2E This is a main-config directive and may be repeated to</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  define several pools=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  Valid syntax:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  ::</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     subnet-=
pool tag network netmask [gateway]</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``=
tag`` is a name a client refers to with ``--subnet-pool-tag``; ``gateway``<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  defaults to the fi=
rst address of ``network``/``netmask`` and is never</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  assigned to a client=2E A client assign=
ed to a pool receives (dynamically, or</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  via a static ``--ifconfig-push`` that must lie within =
the subnet) an address</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  from it, plus the matching netmask=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  Requires ``--server`` with ``--dev tun`` and ``--topology subnet``=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``netmask`` must =
be between /16 and /29 (as for ``--server``), ``gateway``</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  must be a host address inside the s=
ubnet, each ``tag`` may be defined only</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  once and no pool may overlap another one or the ``--s=
erver`` network=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The server routes =
each pool&#39;s subnet into the tun device, as it does for</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  the ``--server`` network; no ``--r=
oute`` needs to be added for it=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--su=
bnet-pool-tag tag</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
Assign this client to the ``--subnet-pool`` named ``tag``=2E Must be</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  associated with a specif=
ic client instance via ``--client-config-dir`` or</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  ``--client-connect``=2E Several clients may=
 reference the same tag and are</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  then served from the same shared pool=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --ifconfig-ipv6-push a=
rgs</span><br><span>   for ``--client-config-dir`` per-client static IPv6 i=
nterface</span><br><span>   configuration, see ``--client-config-dir`` and =
``--ifconfig-push`` for</span><br><span>diff --git a/src/openvpn/multi=2Ec =
b/src/openvpn/multi=2Ec</span><br><span>index a2cfdbf=2E=2E86fd9c0 100644</=
span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvp=
n/multi=2Ec</span><br><span>@@ -43,6 +43,7 @@</span><br><span> #include &qu=
ot;auth_token=2Eh&quot;</span><br><span> #include &quot;route=2Eh&quot;</sp=
an><br><span> #include &quot;sid_hash=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;options_util=2Eh&quot;</span><br=
><span> #include &lt;inttypes=2Eh&gt;</span><br><span> #include &lt;string=
=2Eh&gt;</span><br><span> </span><br><span>@@ -54,6 +55,20 @@</span><br><sp=
an> #include &quot;dco=2Eh&quot;</span><br><span> #include &quot;reflect_fi=
lter=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * D=
ynamic address pool serving the clients of one --subnet-pool tag=2E  Shared=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * by every client =
that references the tag, created on first use=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+struct subnet_pool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct subnet_pool *next;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const char *tag;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct ifconfig_pool *pool;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static struct ifcon=
fig_pool *multi_get_group_pool(struct multi_context *m,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
           const struct options *o, const char *tag);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*#define MULTI_DEBUG_E=
VENT_LOOP*/</span><br><span> </span><br><span> #ifdef MULTI_DEBUG_EVENT_LOO=
P</span><br><span>@@ -371,6 +386,13 @@</span><br><span>         }</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* create every --subnet-pool group up front rather than on=
 first use, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* that its pool exists before any client of the group connects */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    for (const struct subnet_=
pool_def *d =3D t-&gt;options=2Esubnet_pools; d; d =3D d-&gt;next)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        multi_get_group_pool(m, &amp;t-&g=
t;options, d-&gt;tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span>     /*</span><br><span>      * Help us keep track of routing table=
=2E</span><br><span>      */</span><br><span>@@ -625,7 +647,8 @@</span><br>=
<span> </span><br><span>         schedule_remove_entry(m-&gt;schedule, (str=
uct schedule_entry *)mi);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        ifconfig_pool_release(m-&gt;ifconfig_pool, mi=
-&gt;vaddr_handle, false);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        ifconfig_pool_release(mi-&gt;vaddr_pool ? mi-&gt;vaddr_pool =
: m-&gt;ifconfig_pool, mi-&gt;vaddr_handle,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                              false);</span><br><sp=
an> </span><br><span>         if (mi-&gt;did_iroutes)</span><br><span>     =
    {</span><br><span>@@ -707,6 +730,14 @@</span><br><span>         schedul=
e_free(m-&gt;schedule);</span><br><span>         mbuf_free(m-&gt;mbuf);</sp=
an><br><span>         ifconfig_pool_free(m-&gt;ifconfig_pool);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        while (m-&gt;subnet_pool=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            struct subnet_p=
ool *sp =3D m-&gt;subnet_pools;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     m-&gt;subnet_pools =3D sp-&gt;next;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            ifconfig_pool_free(sp-&gt;pool);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            free(sp);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span> =
        frequency_limit_free(m-&gt;new_connection_limiter);</span><br><span=
>         initial_rate_limit_free(m-&gt;initial_rate_limiter);</span><br><s=
pan>         multi_reap_free(m-&gt;reaper);</span><br><span>@@ -1405,6 +143=
6,12 @@</span><br><span>     const struct options *o =3D &amp;c-&gt;options=
;</span><br><span>     if (o-&gt;push_ifconfig_constraint_defined &amp;&amp=
; c-&gt;c2=2Epush_ifconfig_defined)</span><br><span>     {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* a subnet-pool client is v=
alidated against its own subnet */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (o-&gt;subnet_pool_defined)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return (o-&gt;subnet_pool_netmask &amp;=
 c-&gt;c2=2Epush_ifconfig_local)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                   =3D=3D o-&gt;subnet_pool_network;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>   =
      return (o-&gt;push_ifconfig_constraint_netmask &amp; c-&gt;c2=2Epush_=
ifconfig_local)</span><br><span>                =3D=3D o-&gt;push_ifconfig_=
constraint_network;</span><br><span>     }</span><br><span>@@ -1415,6 +1452=
,37 @@</span><br><span> }</span><br><span> </span><br><span> /*</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Return the dynamic pool serv=
ing the clients tagged with &lt;tag&gt;, creating it</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * on first use from the matching --subne=
t-pool definition in &lt;o&gt;=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic struct ifconfig_pool *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+multi_get_group_pool(struct multi_context *m, const struct options =
*o, const char *tag)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet=
_pool *sp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    for (sp =3D m-&gt;subnet=
_pools; sp; sp =3D sp-&gt;next)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (!strcmp(sp-&gt;tag, tag))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            return sp-&gt;pool;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct subnet_p=
ool_def *d4 =3D subnet_pool_by_tag(o-&gt;subnet_pools, tag);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(d4);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(sp, struct subnet_=
pool);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;ta=
g =3D d4-&gt;tag;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* every host address of the subnet, minus the gateway reserved below */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;pool =3D =
ifconfig_pool_init(true, IFCONFIG_POOL_INDIV, d4-&gt;network + 1,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
     (d4-&gt;network | ~d4-&gt;netmask) - 1, o-&gt;duplicate_cn, false,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
           in6addr_any, 0);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ifconfig_pool_reserve_ip(sp-&gt;pool, d4-&gt;gateway);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;next =3D m-&gt;su=
bnet_pools;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&g=
t;subnet_pools =3D sp;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return sp-&gt;pool;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span>  * Select =
a virtual address for a new client instance=2E</span><br><span>  * Use an -=
-ifconfig-push directive, if given (static IP)=2E</span><br><span>  * Other=
wise use an --ifconfig-pool address (dynamic IP)=2E</span><br><span>@@ -142=
4,6 +1492,25 @@</span><br><span> {</span><br><span>     struct gc_arena gc =
=3D gc_new();</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* resolve --subnet-pool-tag against the main-config --subn=
et-pool list (an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * unknown tag is rejected with AUTH_FAILED in multi_connection_establishe=
d)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * This ru=
ns again after every client-connect handler, and a later handler</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * (script, plugin, manage=
ment) may override the tag set by the CCD file,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * so always resolve the current tag=2E */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;conte=
xt=2Eoptions=2Esubnet_pool_tag)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      const struct subnet_pool_def *d =3D</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            subnet_pool_by_tag(m-&gt;top=2Eoptions=2E=
subnet_pools, mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        mi-&gt;context=2Eoptions=2Esubnet_pool_defined =
=3D d !=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt=
;context=2Eoptions=2Esubnet_pool_network =3D d-&gt;network;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=2Eoption=
s=2Esubnet_pool_netmask =3D d-&gt;netmask;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            mi-&gt;context=2Eoptions=2Esubnet_pool_g=
ateway =3D d-&gt;gateway;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
    /*</span><br><span>      * If ifconfig addresses were set by dynamic co=
nfig file,</span><br><span>      * release pool addresses, otherwise keep t=
hem=2E</span><br><span>@@ -1434,8 +1521,10 @@</span><br><span>          * r=
elease dynamic allocation */</span><br><span>         if (mi-&gt;vaddr_hand=
le &gt;=3D 0)</span><br><span>         {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            ifconfig_pool_release(m-&gt;ifconfig_pool, m=
i-&gt;vaddr_handle, true);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            ifconfig_pool_release(mi-&gt;vaddr_pool ? mi-&gt;vaddr_p=
ool : m-&gt;ifconfig_pool,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                  mi-&gt;vaddr_handle, true);</span>=
<br><span>             mi-&gt;vaddr_handle =3D -1;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            mi-&gt;vaddr_pool =3D NULL;</spa=
n><br><span>         }</span><br><span> </span><br><span>         mi-&gt;co=
ntext=2Ec2=2Epush_ifconfig_defined =3D true;</span><br><span>@@ -1455,6 +15=
44,50 @@</span><br><span>                 &quot;MULTI_sva: WARNING: if --if=
config-push is used for IPv4, automatic IPv6 assignment from --ifconfig-ipv=
6-pool does not work=2E  Use --ifconfig-ipv6-push for IPv6 then=2E&quot;);<=
/span><br><span>         }</span><br><span>     }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    else if (mi-&gt;context=2Eoptions=2Esubne=
t_pool_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* dynamic=
 address from this client&#39;s --subnet-pool group */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        struct ifconfig_pool *group =3D<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi_ge=
t_group_pool(m, &amp;m-&gt;top=2Eoptions, mi-&gt;context=2Eoptions=2Esubnet=
_pool_tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        /* the address may =
have been acquired before the tag was known (from</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+         * the global pool) or for a tag that=
 a later handler overrode: drop</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+         * it so we serve this client from its current group */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (mi-&gt;=
vaddr_handle &gt;=3D 0 &amp;&amp; mi-&gt;vaddr_pool !=3D group)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            ifconfig_pool_release(mi-&gt;=
vaddr_pool ? mi-&gt;vaddr_pool : m-&gt;ifconfig_pool,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                  mi-&gt;=
vaddr_handle, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            mi-&gt;vaddr_handle =3D -1;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            mi-&gt;vaddr_pool =3D NULL;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=2Ec2=2E=
push_ifconfig_defined =3D false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (mi-&=
gt;vaddr_handle &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      in_addr_t local =3D 0, remote =3D 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            const char *cn =3D NULL;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (!mi-&gt;context=2Eoptions=2Eduplicate_=
cn)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                cn =3D=
 tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, true);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            mi-&gt;vaddr_pool =3D group;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;vaddr_handle =3D ifcon=
fig_pool_acquire(mi-&gt;vaddr_pool, &amp;local, &amp;remote, NULL, cn);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (mi-&gt;=
vaddr_handle &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              mi-&gt;context=2Ec2=2Epush_ifconfig_local =3D remote;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                mi-&gt;cont=
ext=2Ec2=2Epush_ifconfig_remote_netmask =3D</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    mi-&gt;context=2Eoptions=2Esubn=
et_pool_netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             mi-&gt;context=2Ec2=2Epush_ifconfig_defined =3D true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msg(D_MULTI_ERRORS, &quot=
;MULTI: no free --subnet-pool addresses are available for %s&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    multi_i=
nstance_string(mi, false, &amp;gc));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span>     else if (m-&gt;ifconfig_pool &amp;&amp; mi-&gt;=
vaddr_handle &lt; 0) /* otherwise, choose a pool address */</span><br><span=
>     {</span><br><span>         in_addr_t local =3D 0, remote =3D 0;</span=
><br><span>@@ -2360,10 +2493,9 @@</span><br><span>         const char *ifco=
nfig_constraint_netmask =3D</span><br><span>             print_in_addr_t(mi=
-&gt;context=2Eoptions=2Epush_ifconfig_constraint_netmask, 0, &amp;gc);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 /* JYFIXME -- this should cause the connection to fail */</span><br><span>=
         msg(D_MULTI_ERRORS,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            &quot;MULTI ERROR: primary virtual IP for %s (%s) &quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;vio=
lates tunnel network/netmask constraint (%s/%s)&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            &quot;WARNING: primary virtu=
al IP for %s (%s) &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            &quot;violates tunnel network/netmask constraint (%s/%s) a=
nd may not work&quot;,</span><br><span>             multi_instance_string(m=
i, false, &amp;gc),</span><br><span>             print_in_addr_t(mi-&gt;con=
text=2Ec2=2Epush_ifconfig_local, 0, &amp;gc),</span><br><span>             =
ifconfig_constraint_network, ifconfig_constraint_netmask);</span><br><span>=
@@ -2471,6 +2603,7 @@</span><br><span> </span><br><span>     /* reset pool =
handle to null */</span><br><span>     mi-&gt;vaddr_handle =3D -1;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;vaddr_pool =3D NU=
LL;</span><br><span> </span><br><span>     /* do --client-connect setenvs *=
/</span><br><span>     multi_select_virtual_addr(m, mi);</span><br><span>@@=
 -2792,6 +2925,15 @@</span><br><span>         cc_succeeded =3D false;</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (mi-&gt;context=2Eoptions=2Esubnet_pool_tag</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !subnet_p=
ool_by_tag(m-&gt;top=2Eoptions=2Esubnet_pools, mi-&gt;context=2Eoptions=2Es=
ubnet_pool_tag))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MUL=
TI_ERRORS, &quot;MULTI: client has been rejected due to unknown --subnet-po=
ol-tag &#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        auth_set_client_reason(=
mi-&gt;context=2Ec2=2Etls_multi, &quot;unknown subnet-pool-tag&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cc_succeeded =3D=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (=
cc_succeeded)</span><br><span>     {</span><br><span>         multi_client_=
connect_late_setup(m, mi, *option_types_found);</span><br><span>diff --git =
a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh</span><br><span>index 5db71=
47=2E=2E14f71dd 100644</span><br><span>--- a/src/openvpn/multi=2Eh</span><b=
r><span>+++ b/src/openvpn/multi=2Eh</span><br><span>@@ -121,6 +121,8 @@</sp=
an><br><span>     struct mroute_addr real; /**&lt; External network address=
 of the</span><br><span>                               *   remote peer=2E *=
/</span><br><span>     ifconfig_pool_handle vaddr_handle;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* pool vaddr_handle belongs to (=
NULL =3D the global one) */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct ifconfig_pool *vaddr_pool;</span><br><span>     char msg=
_prefix[MULTI_PREFIX_MAX_LENGTH];</span><br><span> </span><br><span>     /*=
 queued outgoing data in Server/TCP mode */</span><br><span>@@ -190,6 +192,=
8 @@</span><br><span>                                         *   instances=
=2E */</span><br><span>     struct multi_io *multi_io;         /**&lt; I/O =
state and events tracker */</span><br><span>     struct ifconfig_pool *ifco=
nfig_pool;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* pe=
r-group --subnet-pool dynamic pools */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct subnet_pool *subnet_pools;</span><br><span>  =
   struct frequency_limit *new_connection_limiter;</span><br><span>     str=
uct initial_packet_rate_limit *initial_rate_limiter;</span><br><span>     s=
truct mroute_helper *route_helper;</span><br><span>diff --git a/src/openvpn=
/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 7fc8614=2E=2Ec=
d29fc4 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span=
>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -452,6 +452,11 @@</span><=
br><span>     &quot;                  If seconds=3D0, file will be treated =
as read-only=2E\n&quot;</span><br><span>     &quot;--ifconfig-ipv6-pool bas=
e-IP/bits : set aside an IPv6 network block\n&quot;</span><br><span>     &q=
uot;                  to be dynamically allocated to connecting clients=2E\=
n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--=
subnet-pool tag network netmask [gateway] : Define a named pool of\n&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;          =
        addresses outside the --server network, selected per\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;                =
  client with --subnet-pool-tag=2E\n&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    &quot;--subnet-pool-tag tag : Assign this client=
 to the --subnet-pool named tag=2E\n&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    &quot;                  Only valid in a client-s=
pecific config file=2E\n&quot;</span><br><span>     &quot;--ifconfig-push l=
ocal remote-netmask : Push an ifconfig option to remote,\n&quot;</span><br>=
<span>     &quot;                  overrides --ifconfig-pool dynamic alloca=
tion=2E\n&quot;</span><br><span>     &quot;                  Only valid in =
a client-specific config file=2E\n&quot;</span><br><span>@@ -1925,6 +1930,2=
0 @@</span><br><span>         {</span><br><span>             msg(M_USAGE, &=
quot;--ifconfig-ipv6-pool needs --ifconfig-ipv6&quot;);</span><br><span>   =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
options-&gt;subnet_pools)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (!options-&gt;server_defined)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                msg(M_USAGE, &quot;--subnet-pool requires --=
server&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (dev_type_enum(options-&gt;dev, options-&gt;dev_type) !=3D DEV_TYPE_TUN=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                || =
options-&gt;topology !=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                msg(M_USAGE, &quot;--subnet-pool requires --dev=
 tun and --topology subnet&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            subnet_pools_check(options-&gt;subnet_pools, options-&=
gt;server_network,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                              options-&gt;server_netmask, M_USAGE);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span> =
        MUST_BE_UNDEF(allow_recursive_routing, &quot;allow-recursive-routin=
g&quot;);</span><br><span>         if (options-&gt;auth_user_pass_file)</sp=
an><br><span>         {</span><br><span>@@ -1991,6 +2010,7 @@</span><br><sp=
an>         MUST_BE_UNDEF(ifconfig_pool_defined, &quot;ifconfig-pool&quot;)=
;</span><br><span>         MUST_BE_UNDEF(ifconfig_pool_persist_filename, &q=
uot;ifconfig-pool-persist&quot;);</span><br><span>         MUST_BE_UNDEF(if=
config_ipv6_pool_defined, &quot;ifconfig-ipv6-pool&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(subnet_pools, =
&quot;subnet-pool&quot;);</span><br><span>         MUST_BE_UNDEF(real_hash_=
size, &quot;hash-size&quot;);</span><br><span>         MUST_BE_UNDEF(virtua=
l_hash_size, &quot;hash-size&quot;);</span><br><span>         MUST_BE_UNDEF=
(learn_address_script, &quot;learn-address&quot;);</span><br><span>@@ -3123=
,6 +3143,25 @@</span><br><span>     }</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * The server&#39;s tun device is onl=
y configured with the --server network, so</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * route each --subnet-pool network into it as well:=
 without this the server</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * could not reach its subnet-pool clients when the data channel runs =
in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * userspace (und=
er DCO, each such client additionally gets an on-link host</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * route when it connects, see multi=
_learn_in_addr_t())=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+options_postprocess_s=
ubnet_pool_routes(struct options *o)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   for (const struct subnet_pool_def *d =3D o-&gt;subnet_pools; d; d =3D d-=
&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        rol_check_alloc(=
o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        add_rout=
e_to_option_list(o-&gt;routes, print_in_addr_t(d-&gt;network, 0, &amp;o-&gt=
;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                   print_in_addr_t(d-&gt;netmask, 0, &amp;o-&gt;gc), NULL, =
NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                   o-&gt;route_default_table_id);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> static void</span><br><span> options_postprocess_mutate(str=
uct options *o, struct env_set *es)</span><br><span> {</span><br><span>@@ -=
3139,6 +3178,7 @@</span><br><span>     if (o-&gt;mode =3D=3D MODE_SERVER)</=
span><br><span>     {</span><br><span>         helper_hashmap_sizes(o);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        options_postpro=
cess_subnet_pool_routes(o);</span><br><span>     }</span><br><span> </span>=
<br><span>     options_postprocess_setdefault_ncpciphers(o);</span><br><spa=
n>@@ -6245,6 +6285,43 @@</span><br><span>             goto err;</span><br><=
span>         }</span><br><span>     }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    else if (streq(p[0], &quot;subnet-pool&quot;) &amp;&=
amp; p[1] &amp;&amp; p[2] &amp;&amp; p[3] &amp;&amp; !p[5])</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        struct subnet_pool_def *sp;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        in_addr_t network, netmas=
k;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENE=
RAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        networ=
k =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[2], 0, NULL, NULL);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        netmask =3D g=
etaddr(GETADDR_HOST_ORDER, p[3], 0, NULL, NULL);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (!network || !netmask)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;cannot pa=
rse --subnet-pool addresses&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            goto err;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        ALLOC_OBJ_GC(sp, struct subnet_pool_def, &amp;options-&gt;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;t=
ag =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 sp-&gt;network =3D network &amp; netmask;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        sp-&gt;netmask =3D netmask;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;gateway =3D (network =
&amp; netmask) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (p[4])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
bool ok =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            sp-&gt;g=
ateway =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[4], 0, &amp;ok, =
NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (!ok)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ms=
g(msglevel, &quot;cannot parse --subnet-pool gateway&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                goto err;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        sp-&gt;next =3D options-&gt;subnet_p=
ools;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        option=
s-&gt;subnet_pools =3D sp;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    els=
e if (streq(p[0], &quot;subnet-pool-tag&quot;) &amp;&amp; p[1] &amp;&amp; !=
p[2])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OP=
T_P_INSTANCE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   options-&gt;subnet_pool_tag =3D p[1];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;=
ifconfig-push-constraint&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; =
!p[3])</span><br><span>     {</span><br><span>         in_addr_t network, n=
etmask;</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/=
options=2Eh</span><br><span>index d347830=2E=2E028b1e6 100644</span><br><sp=
an>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=
=2Eh</span><br><span>@@ -252,6 +252,17 @@</span><br><span>     struct verif=
y_hash_list *next;</span><br><span> };</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* A named --subnet-pool: a subnet cli=
ents can be assigned from, referenced</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * from a CCD file by its tag via --subnet-pool-tag=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct subnet_pool_=
def</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_def *next;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *tag;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t netwo=
rk;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t ne=
tmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t=
 gateway;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Comman=
d line options */</span><br><span> struct options</span><br><span> {</span>=
<br><span>@@ -518,6 +529,12 @@</span><br><span>     bool push_ifconfig_cons=
traint_defined;</span><br><span>     in_addr_t push_ifconfig_constraint_net=
work;</span><br><span>     in_addr_t push_ifconfig_constraint_netmask;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_d=
ef *subnet_pools; /* named pools (server config) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *subnet_pool_tag;         =
 /* which pool this client uses (CCD) */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    bool subnet_pool_defined;             /* resolved =
from the tag at connect */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    in_addr_t subnet_pool_network;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    in_addr_t subnet_pool_netmask;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    in_addr_t subnet_pool_gateway;</sp=
an><br><span>     bool push_ifconfig_ipv4_blocked;           /* IPv4 */</sp=
an><br><span>     bool push_ifconfig_ipv6_defined;           /* IPv6 */</sp=
an><br><span>     struct in6_addr push_ifconfig_ipv6_local;  /* IPv6 */</sp=
an><br><span>diff --git a/src/openvpn/options_util=2Ec b/src/openvpn/option=
s_util=2Ec</span><br><span>index d25d85c=2E=2E744ad4c 100644</span><br><spa=
n>--- a/src/openvpn/options_util=2Ec</span><br><span>+++ b/src/openvpn/opti=
ons_util=2Ec</span><br><span>@@ -30,6 +30,91 @@</span><br><span> #include &=
quot;options_util=2Eh&quot;</span><br><span> </span><br><span> #include &qu=
ot;push=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;pool=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const struc=
t subnet_pool_def *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
subnet_pool_by_tag(const struct subnet_pool_def *pools, const char *tag)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    for (const struct subnet_pool_def *d=
 =3D pools; d; d =3D d-&gt;next)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (!strcmp(d-&gt;tag, tag))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            return d;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* true if the two IPv4 subnets share at least one addre=
ss */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+subnets_overlap(in_add=
r_t a, in_addr_t mask_a, in_addr_t b, in_addr_t mask_b)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const in_addr_t mask =3D mask_a &amp; mask_b;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return (a &amp; mask) =3D=3D (b &amp; mask=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+subnet_pools_check(const struct subnet_pool_def *pools, in_addr_t ser=
ver_network,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
            in_addr_t server_netmask, msglvl_t msglevel)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    for (const struct subnet_pool_def *d =3D pools; d; d=
 =3D d-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const in_=
addr_t host =3D ~d-&gt;netmask;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        int netbits =3D 32;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* the netmask must be contiguous */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (host &amp; (host + 1))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--subnet-poo=
l %s: invalid netmask&quot;, d-&gt;tag);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            return false;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        for (in_addr_t h =3D host; h; h &gt;&gt;=3D 1)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            netbits--;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* same bounds as --server: the pool must hold at l=
east 2 addresses</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
      * besides network, gateway and broadcast, and fit IFCONFIG_POOL_MAX *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (netbit=
s &lt; IFCONFIG_POOL_MIN_NETBITS || netbits &gt; 29)</span><br><span style=
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
span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests=
/openvpn/Makefile=2Eam</span><br><span>index 38299f5=2E=2E78f4b6c 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>=
+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -21,6 +21,7=
 @@</span><br><span> 	push_update_msg_testdriver \</span><br><span> 	socket=
_testdriver \</span><br><span> 	ssl_testdriver \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	subnet_pool_testdriver \</span><br><span> 	us=
er_pass_testdriver</span><br><span> </span><br><span> if HAVE_LD_WRAP_SUPPO=
RT</span><br><span>@@ -384,6 +385,19 @@</span><br><span> 	$(top_srcdir)/src=
/openvpn/platform=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/mbuf=2E=
c</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
subnet_pool_testdriver_CFLAGS  =3D \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(to=
p_srcdir)/src/openvpn \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	@TEST_CFLAGS@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+subnet_pool_testdriv=
er_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+subnet_po=
ol_testdriver_SOURCES =3D test_subnet_pool=2Ec \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	mock_msg=2Ec test_common=2Eh \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	mock_get_random=2Ec \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/buff=
er=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcd=
ir)/src/openvpn/options_util=2Ec \</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	$(top_srcdir)/src/openvpn/platform=2Ec</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> misc_testdriver_CFLAGS=
  =3D \</span><br><span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compa=
t -I$(top_srcdir)/src/openvpn \</span><br><span> 	-DSOURCEDIR=3D\&quot;$(to=
p_srcdir)\&quot; @TEST_CFLAGS@</span><br><span>diff --git a/tests/unit_test=
s/openvpn/test_subnet_pool=2Ec b/tests/unit_tests/openvpn/test_subnet_pool=
=2Ec</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=
=2E1bb9e4c</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_t=
ests/openvpn/test_subnet_pool=2Ec</span><br><span>@@ -0,0 +1,146 @@</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tu=
nnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            over a single UDP port, with support for SSL/TLS-based</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *             session authe=
ntication and key exchange,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             packet encryption, packet authentication, and</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet comp=
ression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 Ope=
nVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  This program is free software; you can redistribute it and/or modify</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms=
 of the GNU General Public License version 2</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed i=
n the hope that it will be useful,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warra=
nty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTA=
BILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more =
details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have receiv=
ed a copy of the GNU General Public License along</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https:=
//www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;conf=
ig=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;options=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options_util=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;test_common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;mock_msg=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* --subnet-pool-tag resolves a client to its --subnet-pool; an unknown =
tag</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * returns NULL,=
 which is what makes the server reject that client=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+test_subnet_pool_by_tag(void **state)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct subnet_pool_def c =3D { =2Enext =3D=
 NULL, =2Etag =3D &quot;grpC&quot;, =2Enetwork =3D 0x0a020300, =2Enetmask =
=3D 0xffffff00, =2Egateway =3D 0x0a020301 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct subnet_pool_def b =3D { =2Enext =3D &am=
p;c, =2Etag =3D &quot;grpB&quot;, =2Enetwork =3D 0x0a020200, =2Enetmask =3D=
 0xffffff00, =2Egateway =3D 0x0a020201 };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct subnet_pool_def a =3D { =2Enext =3D &amp;b=
, =2Etag =3D &quot;grpA&quot;, =2Enetwork =3D 0x0a020100, =2Enetmask =3D 0x=
ffffff00, =2Egateway =3D 0x0a020101 };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* every configured tag resolves to its own pool, wherever it sits */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(=
subnet_pool_by_tag(&amp;a, &quot;grpA&quot;), &amp;a);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(subnet_pool_by_tag(=
&amp;a, &quot;grpB&quot;), &amp;b);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_ptr_equal(subnet_pool_by_tag(&amp;a, &quot;grpC&=
quot;), &amp;c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* and it carries =
that pool&#39;s subnet/gateway */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const struct subnet_pool_def *r =3D subnet_pool_by_tag(&a=
mp;a, &quot;grpB&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(r-&gt;network, 0x0a020200);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r-&gt;netmask, 0xfff=
fff00);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(r-&gt;gateway, 0x0a020201);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* unknown tag and empty list both miss */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_null(subnet_pool_by_tag(&amp;a, &quot;n=
ope&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_null(subnet_pool_by_tag(NULL, &quot;grpA&quot;));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
a single pool &lt;net&gt;/&lt;mask&gt; with gateway &lt;gw&gt;, checked aga=
inst the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * 10=2E8=
=2E0=2E0/24 --server network */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+check_one(in_addr_t net, in_addr_t mask, in_addr_t gw)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct subnet_pool_def d =3D { =2Enext =3D NULL, =
=2Etag =3D &quot;grp&quot;, =2Enetwork =3D net, =2Enetmask =3D mask, =2Egat=
eway =3D gw };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return subnet_pools_=
check(&amp;d, 0x0a080000, 0xffffff00, M_WARN);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* --subne=
t-pool geometry: anything ifconfig_pool_init() cannot serve must be</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * refused when the config =
is checked, not when the first client connects */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+test_subnet_pools_check_netmask(void **state)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* the bounds of --server: /16 =2E=2E /29=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(=
check_one(0x0a090000, 0xffff0000, 0x0a090001));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(check_one(0x0a090000, 0xffffff0=
0, 0x0a090001));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(check_one(0x0a090000, 0xfffffff8, 0x0a090001));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* /30, /31, /32: too few addr=
esses for a pool */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_false(check_one(0x0a090000, 0xfffffffc, 0x0a090001));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_one(0x0=
a090000, 0xfffffffe, 0x0a090001));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_false(check_one(0x0a090000, 0xffffffff, 0x0a09000=
0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* /15: lar=
ger than IFCONFIG_POOL_MAX */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_false(check_one(0x0a080000, 0xfffe0000, 0x0a080001));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* non-contiguou=
s netmask */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_false(check_one(0x0a000900, 0xff00ff00, 0x0a000901));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_su=
bnet_pools_check_gateway(void **state)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* any host address of the subnet is fine, not only the first one */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(check=
_one(0x0a090000, 0xffffff00, 0x0a0900fe));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(check_one(0x0a090000, 0xffffff00, 0x=
0a090080));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* n=
etwork address, broadcast address, outside the subnet */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_one(0x0a090000,=
 0xffffff00, 0x0a090000));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_false(check_one(0x0a090000, 0xffffff00, 0x0a0900ff));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_=
one(0x0a090000, 0xffffff00, 0x0a0a0001));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+test_subnet_pools_check=
_overlap(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subn=
et_pool_def b =3D { =2Enext =3D NULL, =2Etag =3D &quot;grpB&quot;, =2Enetwo=
rk =3D 0x0a0a0000, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a0a0001 };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_po=
ol_def a =3D { =2Enext =3D &amp;b, =2Etag =3D &quot;grpA&quot;, =2Enetwork =
=3D 0x0a090000, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a090001 };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* disjoint pools, disjoint from --se=
rver */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(subnet_pools_check(&amp;a, 0x0a080000, 0xffffff00, M_WARN));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* a pool inside the --server network =2E=2E=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fa=
lse(subnet_pools_check(&amp;a, 0x0a090000, 0xffffff00, M_WARN));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* =2E=2E=2E or covering i=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fals=
e(subnet_pools_check(&amp;a, 0x0a0a0080, 0xffffff80, M_WARN));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* no --server network: only=
 the pools are checked against each other */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(subnet_pools_check(&amp;a, 0, 0, M=
_WARN));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* grpB grown to a /16 now=
 contains grpA */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  b=2Enetwork =3D 0x0a090000;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    b=2Enetmask =3D 0xffff0000;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    b=2Egateway =3D 0x0a090101;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(subnet_pools_check(&amp;=
a, 0, 0, M_WARN));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the same tag =
defined twice */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 b=2Enetwork =3D 0x0a0a0000;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    b=2Enetmask =3D 0xffffff00;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    b=2Egateway =3D 0x0a0a0001;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    b=2Etag =3D &quot;grpA&quot;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(subnet_poo=
ls_check(&amp;a, 0, 0, M_WARN));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+const struct CMUnitTest =
subnet_pool_tests[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    cmocka_unit_test(test_subnet_pool_by_tag),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_subnet_pools_ch=
eck_netmask),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cm=
ocka_unit_test(test_subnet_pools_check_gateway),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_subnet_pools_check_o=
verlap),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+main(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_uni=
t_test_setup();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return cmocka_run_group_tests(subnet_pool_tests, NULL, NULL);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail">=
change 1783</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/178=
3?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1783 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Ant=
onio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--XjWJ7m5qqcg=--


--===============4457876447550753157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4457876447550753157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4457876447550753157==--

