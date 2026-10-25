Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415D8606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 25 Oct 2026 23:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OrcQidp9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EeJoW7g2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NWr2wCXS;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=EMGV/MdB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=28UKBqDeiyql63ZuDa2T6eki5ZBb4ORuSNnJISDEbmA=; b=OrcQidp9RsnCNY+bm5Amg+RshZ
	Z6DAI1z3aFc470zBEJDs80WXaqd3MxcB34FD1J0vP6aN6YWtHbBAG1R7SupccdXb/cne7nrF9EFUH
	vaNURGe8W9+mrCB+pg3qSR2UfJfK0Xl8AUH21fuw3i9waQPGSVikVHbOn192iHgJfBtU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xL7Lw-000000007TA-2ftI;
	Sun, 25 Oct 2026 23:10:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xL7Lu-000000007Sq-1TjV
 for openvpn-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 23:10:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CW0mclTzLvRPOCblzQmAhRyY6nVvgiqK3dDEj0MCIMI=; b=EeJoW7g2zOkXqO4n9wLUh5XiM9
 fpdRreKpgg8Arki5E+S0qeaY6xdRMw7bn8yizRUoKRmHURY1CXyfckB4t+gvUGFb0HbAj0b6dq6zE
 vYkzgRUi9tRWPTexOJwKkLSI36lFtvN9Z7cfBWkzDc8hdincVINzn+MQsgz0vlAps3oo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CW0mclTzLvRPOCblzQmAhRyY6nVvgiqK3dDEj0MCIMI=; b=NWr2wCXSmE7EcrudCNrYJANkr6
 V9fTwa+XAwoCmfwNdQJqhBG0TKVijwZ9w/PWcVcWyY14/5dK+Y6mJ+QVr6Wzbxz64DwcRBApt6gIl
 WKxeK5MGc3bQhhkRccg2ioBmNdf5cwcWx9EvI4LVopoBvsWlPbp6dGXHW2Z55UctXkD0=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xL7Lq-0000000074d-3WYv for openvpn-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 23:10:10 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso11033325e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 16:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792969800; x=1793574600; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CW0mclTzLvRPOCblzQmAhRyY6nVvgiqK3dDEj0MCIMI=;
 b=EMGV/MdBHeIZjAFbiB+i12z/gIYn3JyB3XCoIU2mjvKmWv2s/BAujpZZ32niC0vbvZ
 4h/C68ANuc5hvLAiEPRdHuTgEMVe0+hkqlHdFW7ZcRc9/ZsjvcfFy+ZwB5aojpyRLTKt
 Lrvnb08yz8gAc1raxlcjsaFLdm8cUkZypOB6/OYksJZJYAJRgF2iMp1ogXy7myfcj5aP
 c++W/wkzNQADXM6hzQuoq0dowzGlVhiD/FZWF0Y4ip9dKZFeE3kGqudXf5nP/qkkFmQG
 ETUjnrW9Hj/A6eQuGFsFbCNFMfDMG46sxypeKwrIldT0L/wI/fRwpF3W6Qfx/nIcjt+R
 +ouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792969800; x=1793574600;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CW0mclTzLvRPOCblzQmAhRyY6nVvgiqK3dDEj0MCIMI=;
 b=GIZl8FMLa5TLC7JPIFIc97vW9K606Kk0u45zZfBWunIqUZGsThubZLojHL/RkTHEVZ
 +Ynl6v/fJuVMsxlMqsNQYhwTUxxeGYwTM2yAJPzz0pwITpt1OhLQ1n6eia0UoH+udt7h
 EhkjLj0mrL7c1KwDezCGAR2nlaVGqM7te2V9Jhsy6al9FHq/pnJMQSKGsy9w32yFW5iR
 jw5OIL+rN6iJDuBAZxI2xmteDw0yeJSrSNPmnGEUMNyZ5GSjmETJdSGMBBO4mkWIi7Zg
 VwiPzBwu3NgsUymzQ4iGps1a8GUsfvaK/e3M+fB3HghsY3A31dsZTbch1rYL1hG9t2YI
 PuCw==
X-Gm-Message-State: AFq9FYI9wGIGeYWRA48FgDMm5pqAX0kmRXJZ8KpS8Ejwojm/3fq79vVo
 KlpArcaECUWNEed+m4CxAep+zVmxpmqzjUdtwH0op8X+df0S6nLebkO3/KnQ4shp8tNop1Sm/Ba
 UFQaml2UabvCGET5PiWFb+qJqR6tLx9nupaO73V8H8I8nXkyDK7uCJ57mNI8IWclLPRKPSzuVv9
 MhBwF7Hw==
X-Gm-Gg: AYBFou3PSYP9BaG9CLgSA0IRjuJGO0VFOH75EQ7YeGOpuOnesxymSM6dP4L81id0rzN
 nA215zekc0UtH96+u6DftZJjiGcdqpaLzSbtmMe1Vwbn8xPWEUZU+Nj6DF45uF5n1oMaaZ2TmMK
 kBan7z0QlRbTmbSUMECCc9VV/vhdl5hqfjJQ/F5gIsvoTSU6nBrxM+Noas3JsOFFneB6jirRz9e
 1VOOpUDWmzhP4ZgvmSS5P7AKiDWi6OQKabpuaidSqSJ6f8srAyK4dXeFstvH7VhXkO1om8pFhar
 rUIWsBoBnx7KacGWk8eQSdJuSHO/HQCl18XeDxkCzYzaF9Ropv+ruSdfCl5Q6R8IX5qwd93rPtS
 L/kPKQ/F0bjhHAEoIuLBPRTbphavlOSRWoyDjrhQ/kZXN3UusjYMMEeC9CocKuhsJ5weGhiGqua
 OTD8Q+N2jBi/lZar9R4EB3tSTQnt2+Vxc+6mPKEml7cunnwaeQcPCMFEn7BIvriivdWmjdXLSzT
 x15DlAVucxjbcDah1EutpinyzwHXok9VRQhzniMfwBL3U2VA8udpRGpBhz7Bek/cTPgsdoQjM2+
 nOoqFDGmC8jJROJYbAY5Fjhnn2Syg0W/sK/3yi4+eY07ofA81vn795AjmXULMo5VcNK4Iaipeeu
 y0Ifv8KQYWY+920MciBo/9QbiefeXII1OhVltUa0XRg==
X-Received: by 2002:a05:600c:4ece:b0:4a1:6517:ccf1 with SMTP id
 5b1f17b1804b1-4a35ac9d116mr91961415e9.9.1792969799818; 
 Sun, 25 Oct 2026 16:09:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a59d998sm158215295e9.15.2026.10.25.16.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 16:09:59 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 25 Oct 2026 23:09:46 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727
X-Gerrit-Change-Number: 1786
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1786?usp=email>
X-Gerrit-Commit: b255adb97204820d2345d6ba30c1de5958bb3f28
In-Reply-To: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
References: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkk2NGUwODUwZDQ4NjQ3YTJjMGUzZDM4NWMyZjIwYTlmNDQ1OTMxNzI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d7bd579bd644ea7ab1218b2e19ae47725413f0e4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xL7Lq-0000000074d-3WYv
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multi: assign IPv6
 addresses from a tagged subnet-pool
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
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
Content-Type: multipart/mixed; boundary="===============1747645944105701265=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1747645944105701265==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YYNXK6PTauU="; charset=UTF-8

--YYNXK6PTauU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1786?usp=3Demail

to look at the new patch set (#=
8)=2E


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
es changed, 394 insertions(+), 31 deletions(-)


  git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/86/1786/8

diff --git a/doc/man-se=
ctions/server-options=2Erst b/doc/man-sections/server-options=2Erst
index 9=
434e5d=2E=2E484cd43 100644
--- a/doc/man-sections/server-options=2Erst
+++ =
b/doc/man-sections/server-options=2Erst
@@ -366,11 +366,32 @@
   and FreeBS=
D the IPv4 route is installed on-link, without a gateway, so its
   ``route=
_gateway_{n}`` is not set for ``--route-up`` scripts=2E
 
+--subnet-pool-ip=
v6 args
+  The IPv6 counterpart of ``--subnet-pool``=2E Repeatable main-con=
fig directive=2E
+
+  Valid syntax:
+  ::
+
+     subnet-pool-ipv6 tag netw=
ork/bits [gateway]
+
+  ``bits`` must be between 64 and 124; ``gateway`` de=
faults to the first
+  address of the network, is never assigned to a clien=
t, and is pushed to the
+  pool's clients as the remote end of their ``ifco=
nfig-ipv6``=2E A tag may name
+  an IPv4 pool, an IPv6 pool, or both; a cli=
ent referencing it with
+  ``--subnet-pool-tag`` is then assigned an addres=
s from each family the tag
+  defines=2E
+
+  Requires ``--server-ipv6`` wi=
th ``--dev tun`` and ``--topology subnet``=2E
+  ``network`` must have no h=
ost bits set, ``gateway`` must be a host address
+  inside it, each ``tag``=
 may be defined only once and no pool may overlap
+  another one or the ``-=
-server-ipv6`` network=2E As for ``--subnet-pool``, the
+  server routes ea=
ch pool's network into the tun device=2E
+
 --subnet-pool-tag tag
-  Assign=
 this client to the ``--subnet-pool`` named ``tag``=2E Must be
-  associate=
d with a specific client instance via ``--client-config-dir`` or
-  ``--cli=
ent-connect``=2E Several clients may reference the same tag and are
-  then=
 served from the same shared pool=2E
+  Assign this client to the ``--subne=
t-pool`` / ``--subnet-pool-ipv6`` named
+  ``tag``=2E Must be associated wi=
th a specific client instance via
+  ``--client-config-dir`` or ``--client-=
connect``=2E Several clients may
+  reference the same tag and are then ser=
ved from the same shared pool(s)=2E
 
 --ifconfig-ipv6-push args
   for ``-=
-client-config-dir`` per-client static IPv6 interface
diff --git a/src/open=
vpn/multi=2Ec b/src/openvpn/multi=2Ec
index e8d51da=2E=2E1ec8515 100644
---=
 a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -393,6 +393,10 @@
 =
    {
         multi_get_group_pool(m, &t->options, d->tag);
     }
+    fo=
r (const struct subnet_pool6_def *d =3D t->options=2Esubnet_pools_ipv6; d; =
d =3D d->next)
+    {
+        multi_get_group_pool(m, &t->options, d->tag)=
;
+    }
 
     /*
      * Help us keep track of routing table=2E
@@ -1471,=
16 +1475,31 @@
     }
 
     const struct subnet_pool_def *d4 =3D subnet_po=
ol_by_tag(o->subnet_pools, tag);
-    ASSERT(d4);
+    const struct subnet_=
pool6_def *d6 =3D subnet_pool6_by_tag(o->subnet_pools_ipv6, tag);
+    cons=
t char *pool_tag =3D d4 ? d4->tag : (d6 ? d6->tag : NULL);
+    ASSERT(pool=
_tag);
     ALLOC_OBJ_CLEAR(sp, struct subnet_pool);
-    sp->tag =3D d4->t=
ag;
-    /* the configured dynamic range, or else every host address of the=

-     * subnet, minus the gateway reserved below if it falls inside it */
=
-    const in_addr_t start =3D d4->pool_start ? d4->pool_start : d4->networ=
k + 1;
-    const in_addr_t end =3D d4->pool_end ? d4->pool_end : (d4->netw=
ork | ~d4->netmask) - 1;
-    sp->pool =3D ifconfig_pool_init(true, IFCONFI=
G_POOL_INDIV, start, end, o->duplicate_cn, false,
-                        =
          in6addr_any, 0);
-    ifconfig_pool_reserve_ip(sp->pool, d4->gate=
way);
+    sp->tag =3D pool_tag;
+    /* the IPv4 range (configured, or els=
e every host address of the subnet)
+     * and every host address of the I=
Pv6 network, minus the gateways reserved
+     * below (the IPv4 and the IP=
v6 address of a client share one pool handle) */
+    in_addr_t start =3D 0=
, end =3D 0;
+    if (d4)
+    {
+        start =3D d4->pool_start ? d4->po=
ol_start : d4->network + 1;
+        end =3D d4->pool_end ? d4->pool_end : =
(d4->network | ~d4->netmask) - 1;
+    }
+    sp->pool =3D ifconfig_pool_in=
it(d4 !=3D NULL, IFCONFIG_POOL_INDIV, start, end, o->duplicate_cn,
+       =
                           d6 !=3D NULL, d6 ? add_in6_addr(d6->network, 1) =
: in6addr_any,
+                                  d6 ? (int)d6->netbits : 0=
);
+    if (d4)
+    {
+        ifconfig_pool_reserve_ip(sp->pool, d4->gate=
way);
+    }
+    if (d6)
+    {
+        ifconfig_pool_reserve_ipv6(sp->po=
ol, &d6->gateway);
+    }
     sp->next =3D m->subnet_pools;
     m->subnet=
_pools =3D sp;
     return sp->pool;
@@ -1514,6 +1533,19 @@
             mi=
->context=2Eoptions=2Esubnet_pool_gateway =3D d->gateway;
         }
     }=

+    if (mi->context=2Eoptions=2Esubnet_pool_tag)
+    {
+        const st=
ruct subnet_pool6_def *d =3D subnet_pool6_by_tag(
+            m->top=2Eopt=
ions=2Esubnet_pools_ipv6, mi->context=2Eoptions=2Esubnet_pool_tag);
+
+    =
    mi->context=2Eoptions=2Esubnet_pool_ipv6_defined =3D d !=3D NULL;
+    =
    if (d)
+        {
+            mi->context=2Eoptions=2Esubnet_pool_ipv6=
_network =3D d->network;
+            mi->context=2Eoptions=2Esubnet_pool_i=
pv6_netbits =3D d->netbits;
+            mi->context=2Eoptions=2Esubnet_poo=
l_ipv6_gateway =3D d->gateway;
+        }
+    }
 
     /*
      * If ifcon=
fig addresses were set by dynamic config file,
@@ -1548,15 +1580,16 @@
    =
             "MULTI_sva: WARNING: if --ifconfig-push is used for IPv4, auto=
matic IPv6 assignment from --ifconfig-ipv6-pool does not work=2E  Use --ifc=
onfig-ipv6-push for IPv6 then=2E");
         }
     }
-    else if (mi->con=
text=2Eoptions=2Esubnet_pool_defined)
+    else if (mi->context=2Eoptions=
=2Esubnet_pool_defined
+             || mi->context=2Eoptions=2Esubnet_pool=
_ipv6_defined)
     {
-        /* dynamic address from this client's --subn=
et-pool group */
+        /* dynamic address(es) from this client's --subne=
t-pool group */
         struct ifconfig_pool *group =3D
             multi=
_get_group_pool(m, &m->top=2Eoptions, mi->context=2Eoptions=2Esubnet_pool_t=
ag);
 
         /* the address may have been acquired before the tag was kn=
own (from
          * the global pool) or for a tag that a later handler ov=
errode: drop
-         * it so we serve this client from its current group =
*/
+         * it so we serve this client from its current group only */
  =
       if (mi->vaddr_handle >=3D 0 && mi->vaddr_pool !=3D group)
         {=

             ifconfig_pool_release(mi->vaddr_pool ? mi->vaddr_pool : m->if=
config_pool,
@@ -1571,27 +1604,44 @@
         if (mi->vaddr_handle < 0)
   =
      {
             in_addr_t local =3D 0, remote =3D 0;
+            stru=
ct in6_addr remote_ipv6;
             const char *cn =3D NULL;
 
+         =
   CLEAR(remote_ipv6);
             if (!mi->context=2Eoptions=2Eduplicate_=
cn)
             {
                 cn =3D tls_common_name(mi->context=2Ec2=
=2Etls_multi, true);
             }
 
             mi->vaddr_pool =3D group=
;
-            mi->vaddr_handle =3D ifconfig_pool_acquire(mi->vaddr_pool, &=
local, &remote, NULL, cn);
-            if (mi->vaddr_handle >=3D 0)
-     =
       {
-                mi->context=2Ec2=2Epush_ifconfig_local =3D remote=
;
-                mi->context=2Ec2=2Epush_ifconfig_remote_netmask =3D
-   =
                 mi->context=2Eoptions=2Esubnet_pool_netmask;
-            =
    mi->context=2Ec2=2Epush_ifconfig_defined =3D true;
-            }
-    =
        else
+            mi->vaddr_handle =3D
+                ifconfig_po=
ol_acquire(mi->vaddr_pool, &local, &remote, &remote_ipv6, cn);
+           =
 if (mi->vaddr_handle < 0)
             {
                 msg(D_MULTI_ERRO=
RS, "MULTI: no free --subnet-pool addresses are available for %s",
        =
             multi_instance_string(mi, false, &gc));
             }
+      =
      else
+            {
+                if (mi->context=2Eoptions=2Esubn=
et_pool_defined)
+                {
+                    mi->context=2Ec2=
=2Epush_ifconfig_local =3D remote;
+                    mi->context=2Ec2=2E=
push_ifconfig_remote_netmask =3D
+                        mi->context=2Eopt=
ions=2Esubnet_pool_netmask;
+                    mi->context=2Ec2=2Epush_if=
config_defined =3D true;
+                }
+                if (mi->contex=
t=2Eoptions=2Esubnet_pool_ipv6_defined)
+                {
+               =
     /* the server's own address is off-link for this client:
+            =
         * hand out the pool gateway as the remote end instead */
+        =
            mi->context=2Ec2=2Epush_ifconfig_ipv6_local =3D remote_ipv6;
+ =
                   mi->context=2Ec2=2Epush_ifconfig_ipv6_remote =3D
+      =
                  mi->context=2Eoptions=2Esubnet_pool_ipv6_gateway;
+      =
              mi->context=2Ec2=2Epush_ifconfig_ipv6_netbits =3D
+          =
              mi->context=2Eoptions=2Esubnet_pool_ipv6_netbits;
+          =
          mi->context=2Ec2=2Epush_ifconfig_ipv6_defined =3D true;
+        =
        }
+            }
         }
     }
     else if (m->ifconfig_pool &=
& mi->vaddr_handle < 0) /* otherwise, choose a pool address */
@@ -2932,7 +=
2982,9 @@
     }
 
     if (mi->context=2Eoptions=2Esubnet_pool_tag
-      =
  && !subnet_pool_by_tag(m->top=2Eoptions=2Esubnet_pools, mi->context=2Eopt=
ions=2Esubnet_pool_tag))
+        && !subnet_pool_by_tag(m->top=2Eoptions=
=2Esubnet_pools, mi->context=2Eoptions=2Esubnet_pool_tag)
+        && !subn=
et_pool6_by_tag(m->top=2Eoptions=2Esubnet_pools_ipv6,
+                    =
            mi->context=2Eoptions=2Esubnet_pool_tag))
     {
         msg(D=
_MULTI_ERRORS, "MULTI: client has been rejected due to unknown --subnet-poo=
l-tag '%s'",
             mi->context=2Eoptions=2Esubnet_pool_tag);
diff --=
git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index eb0bcfd=2E=2E=
dff301a 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
=
@@ -457,6 +457,8 @@
     "                  pool of addresses outside the -=
-server network, selected\n"
     "                  per client with --subn=
et-pool-tag=2E start/end restrict the\n"
     "                  dynamicall=
y assigned range=2E\n"
+    "--subnet-pool-ipv6 tag network/bits [gateway] =
: IPv6 counterpart of\n"
+    "                  --subnet-pool=2E\n"
     "=
--subnet-pool-tag tag : Assign this client to the --subnet-pool named tag=
=2E\n"
     "                  Only valid in a client-specific config file=
=2E\n"
     "--ifconfig-push local remote-netmask : Push an ifconfig option=
 to remote,\n"
@@ -1919,6 +1921,20 @@
             subnet_pools_check(optio=
ns->subnet_pools, options->server_network,
                                =
options->server_netmask, M_USAGE);
         }
+        if (options->subnet_=
pools_ipv6)
+        {
+            if (!options->server_ipv6_defined)
+   =
         {
+                msg(M_USAGE, "--subnet-pool-ipv6 requires --ser=
ver-ipv6");
+            }
+            if (dev_type_enum(options->dev, opt=
ions->dev_type) !=3D DEV_TYPE_TUN
+                || options->topology !=
=3D TOP_SUBNET)
+            {
+                msg(M_USAGE, "--subnet-pool=
-ipv6 requires --dev tun and --topology subnet");
+            }
+         =
   subnet_pools6_check(options->subnet_pools_ipv6, &options->server_network=
_ipv6,
+                                options->server_netbits_ipv6, M_USA=
GE);
+        }
         MUST_BE_UNDEF(allow_recursive_routing, "allow-recu=
rsive-routing");
         if (options->auth_user_pass_file)
         {
@@ -=
1986,6 +2002,7 @@
         MUST_BE_UNDEF(ifconfig_pool_persist_filename, "i=
fconfig-pool-persist");
         MUST_BE_UNDEF(ifconfig_ipv6_pool_defined, =
"ifconfig-ipv6-pool");
         MUST_BE_UNDEF(subnet_pools, "subnet-pool");=

+        MUST_BE_UNDEF(subnet_pools_ipv6, "subnet-pool-ipv6");
         MU=
ST_BE_UNDEF(real_hash_size, "hash-size");
         MUST_BE_UNDEF(virtual_ha=
sh_size, "hash-size");
         MUST_BE_UNDEF(learn_address_script, "learn-=
address");
@@ -3119,8 +3136,9 @@
 }
 
 /*
- * The server's tun device is on=
ly configured with the --server network, so
- * route each --subnet-pool ne=
twork into it as well: without this the server
+ * The server's tun device =
is only configured with the --server and
+ * --server-ipv6 networks, so rou=
te each --subnet-pool and --subnet-pool-ipv6
+ * network into it as well: w=
ithout this the server
  * could not reach its subnet-pool clients when the=
 data channel runs in
  * userspace=2E  Under DCO on Linux and FreeBSD the =
routes are installed on-link,
  * see subnet_pool_routes_onlink()=2E
@@ -31=
38,6 +3156,16 @@
                                       o->route_default_ta=
ble_id);
         ro->on_link =3D subnet_pool_routes_onlink(o);
     }
+
+ =
   for (const struct subnet_pool6_def *d =3D o->subnet_pools_ipv6; d; d =3D=
 d->next)
+    {
+        struct buffer prefix =3D alloc_buf_gc(64, &o->gc)=
;
+
+        buf_printf(&prefix, "%s/%u", print_in6_addr(d->network, 0, &o-=
>gc), d->netbits);
+        rol6_check_alloc(o);
+        add_route_ipv6_to=
_option_list(o->routes_ipv6, BSTR(&prefix), NULL, NULL,
+                  =
                    o->route_default_table_id);
+    }
 }
 
 static void
@@=
 -6314,6 +6342,37 @@
         sp->next =3D options->subnet_pools;
         =
options->subnet_pools =3D sp;
     }
+    else if (streq(p[0], "subnet-pool=
-ipv6") && p[1] && p[2] && !p[4])
+    {
+        struct subnet_pool6_def *=
sp;
+        struct in6_addr network, gateway;
+        unsigned int netbit=
s =3D 0;
+
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        if (!get_ipv=
6_addr(p[2], &network, &netbits, msglevel))
+        {
+            msg(msg=
level, "cannot parse --subnet-pool-ipv6 network");
+            goto err;
+=
        }
+        if (netbits < 64 || netbits > 124)
+        {
+         =
   msg(msglevel, "--subnet-pool-ipv6 network must be between /64 and /124 (=
not /%u)",
+                netbits);
+            goto err;
+        }
+  =
      if (p[3] && !get_ipv6_addr(p[3], &gateway, NULL, msglevel))
+        =
{
+            msg(msglevel, "cannot parse --subnet-pool-ipv6 gateway");
+ =
           goto err;
+        }
+        ALLOC_OBJ_GC(sp, struct subnet_poo=
l6_def, &options->gc);
+        sp->tag =3D p[1];
+        sp->network =3D =
network;
+        sp->netbits =3D netbits;
+        sp->gateway =3D p[3] ? =
gateway : add_in6_addr(network, 1);
+        sp->next =3D options->subnet_p=
ools_ipv6;
+        options->subnet_pools_ipv6 =3D sp;
+    }
     else if =
(streq(p[0], "subnet-pool-tag") && p[1] && !p[2])
     {
         VERIFY_PE=
RMISSION(OPT_P_INSTANCE);
diff --git a/src/openvpn/options=2Eh b/src/openvp=
n/options=2Eh
index 568bae6=2E=2Ef3bbde9 100644
--- a/src/openvpn/options=
=2Eh
+++ b/src/openvpn/options=2Eh
@@ -267,6 +267,16 @@
     in_addr_t pool=
_end;
 };
 
+/* The IPv6 counterpart of struct subnet_pool_def (--subnet-po=
ol-ipv6)=2E */
+struct subnet_pool6_def
+{
+    struct subnet_pool6_def *ne=
xt;
+    const char *tag;
+    struct in6_addr network;
+    unsigned int n=
etbits;
+    struct in6_addr gateway;
+};
+
 /* Command line options */
 st=
ruct options
 {
@@ -533,12 +543,17 @@
     bool push_ifconfig_constraint_de=
fined;
     in_addr_t push_ifconfig_constraint_network;
     in_addr_t push=
_ifconfig_constraint_netmask;
-    struct subnet_pool_def *subnet_pools; /*=
 named pools (server config) */
-    const char *subnet_pool_tag;          =
/* which pool this client uses (CCD) */
-    bool subnet_pool_defined;     =
        /* resolved from the tag at connect */
+    struct subnet_pool_def =
*subnet_pools;       /* named IPv4 pools (server config) */
+    struct sub=
net_pool6_def *subnet_pools_ipv6; /* named IPv6 pools (server config) */
+ =
   const char *subnet_pool_tag;                /* which pool this client us=
es (CCD) */
+    bool subnet_pool_defined;                   /* resolved fr=
om the tag at connect */
     in_addr_t subnet_pool_network;
     in_addr_t=
 subnet_pool_netmask;
     in_addr_t subnet_pool_gateway;
+    bool subnet_=
pool_ipv6_defined; /* resolved from the tag at connect */
+    struct in6_a=
ddr subnet_pool_ipv6_network;
+    unsigned int subnet_pool_ipv6_netbits;
+=
    struct in6_addr subnet_pool_ipv6_gateway;
     bool push_ifconfig_ipv4_=
blocked;           /* IPv4 */
     bool push_ifconfig_ipv6_defined;        =
   /* IPv6 */
     struct in6_addr push_ifconfig_ipv6_local;  /* IPv6 */
di=
ff --git a/src/openvpn/options_util=2Ec b/src/openvpn/options_util=2Ec
inde=
x 862bf7c=2E=2Ee853682 100644
--- a/src/openvpn/options_util=2Ec
+++ b/src/=
openvpn/options_util=2Ec
@@ -130,6 +130,108 @@
     return true;
 }
 
+/* v=
alue of bit <i> (0 =3D most significant) of an IPv6 address */
+static bool=

+in6_bit(const struct in6_addr *a, unsigned int i)
+{
+    return a->s6_ad=
dr[i / 8] & (0x80 >> (i % 8));
+}
+
+/* true if the first <bits> bits of th=
e two addresses are equal */
+static bool
+in6_prefix_equal(const struct in=
6_addr *a, const struct in6_addr *b, unsigned int bits)
+{
+    for (unsign=
ed int i =3D 0; i < bits; ++i)
+    {
+        if (in6_bit(a, i) !=3D in6_b=
it(b, i))
+        {
+            return false;
+        }
+    }
+    retu=
rn true;
+}
+
+/* true if every bit of <a> from bit <from> on is zero */
+s=
tatic bool
+in6_suffix_zero(const struct in6_addr *a, unsigned int from)
+{=

+    for (unsigned int i =3D from; i < 128; ++i)
+    {
+        if (in6_b=
it(a, i))
+        {
+            return false;
+        }
+    }
+    retu=
rn true;
+}
+
+bool
+subnet_pools6_check(const struct subnet_pool6_def *poo=
ls, const struct in6_addr *server_network,
+                    unsigned in=
t server_netbits, msglvl_t msglevel)
+{
+    for (const struct subnet_pool6=
_def *d =3D pools; d; d =3D d->next)
+    {
+        if (d->netbits < 64 ||=
 d->netbits > 124)
+        {
+            msg(msglevel, "--subnet-pool-ipv=
6 %s: network must be between /64 and /124 (not /%u)",
+                d->=
tag, d->netbits);
+            return false;
+        }
+
+        if (!in6=
_suffix_zero(&d->network, d->netbits))
+        {
+            msg(msglevel=
, "--subnet-pool-ipv6 %s: network has host bits set", d->tag);
+           =
 return false;
+        }
+
+        if (!in6_prefix_equal(&d->gateway, &d-=
>network, d->netbits)
+            || in6_suffix_zero(&d->gateway, d->netbi=
ts))
+        {
+            msg(msglevel,
+                "--subnet-pool-=
ipv6 %s: gateway must be a host address inside the network",
+             =
   d->tag);
+            return false;
+        }
+
+        if (server_net=
bits
+            && in6_prefix_equal(&d->network, server_network, min_uint=
(d->netbits, server_netbits)))
+        {
+            msg(msglevel, "--sub=
net-pool-ipv6 %s: network overlaps the --server-ipv6 network",
+           =
     d->tag);
+            return false;
+        }
+
+        for (const s=
truct subnet_pool6_def *e =3D d->next; e; e =3D e->next)
+        {
+      =
      if (!strcmp(d->tag, e->tag))
+            {
+                msg(msgl=
evel, "--subnet-pool-ipv6 %s: tag defined more than once", d->tag);
+      =
          return false;
+            }
+            if (in6_prefix_equal(&d=
->network, &e->network, min_uint(d->netbits, e->netbits)))
+            {
+=
                msg(msglevel, "--subnet-pool-ipv6 %s and %s: networks overl=
ap", d->tag, e->tag);
+                return false;
+            }
+      =
  }
+    }
+
+    return true;
+}
+
+const struct subnet_pool6_def *
+subne=
t_pool6_by_tag(const struct subnet_pool6_def *pools, const char *tag)
+{
+ =
   for (const struct subnet_pool6_def *d =3D pools; d; d =3D d->next)
+    =
{
+        if (!strcmp(d->tag, tag))
+        {
+            return d;
+   =
     }
+    }
+    return NULL;
+}
+
 const char *
 parse_auth_failed_temp(=
struct options *o, const char *reason)
 {
diff --git a/src/openvpn/options_=
util=2Eh b/src/openvpn/options_util=2Eh
index f1e63e15=2E=2E6ddded3 100644
=
--- a/src/openvpn/options_util=2Eh
+++ b/src/openvpn/options_util=2Eh
@@ -5=
5,6 +55,25 @@
 bool subnet_pools_check(const struct subnet_pool_def *pools,=
 in_addr_t server_network,
                         in_addr_t server_netmas=
k, msglvl_t msglevel);
 
+/**
+ * IPv6 counterpart of subnet_pools_check():=
 network between /64 and /124
+ * without host bits, gateway a host address=
 inside it, unique tags, and no
+ * network overlapping another pool or the=
 --server-ipv6 network=2E
+ *
+ * @param pools           head of the --subn=
et-pool-ipv6 list (may be NULL)
+ * @param server_network  the --server-ipv=
6 network
+ * @param server_netbits  the --server-ipv6 prefix length, or 0 =
if there is none
+ * @param msglevel        level of the message logged on =
the first error
+ * @return                true if every definition is vali=
d
+ */
+bool subnet_pools6_check(const struct subnet_pool6_def *pools,
+   =
                      const struct in6_addr *server_network, unsigned int s=
erver_netbits,
+                         msglvl_t msglevel);
+
+/** IPv6 co=
unterpart of subnet_pool_by_tag()=2E */
+const struct subnet_pool6_def *sub=
net_pool6_by_tag(const struct subnet_pool6_def *pools,
+                   =
                                const char *tag);
+
 
 /** Checks if the st=
ring is a valid integer by checking if it can be
  *  converted to an integ=
er */
diff --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec
index 5c5b3f=
e=2E=2E2cdaa71 100644
--- a/src/openvpn/pool=2Ec
+++ b/src/openvpn/pool=2Ec=

@@ -446,6 +446,22 @@
     return true;
 }
 
+bool
+ifconfig_pool_reserve_i=
pv6(struct ifconfig_pool *pool, const struct in6_addr *addr)
+{
+    const =
ifconfig_pool_handle h =3D ifconfig_pool_ipv6_base_to_handle(pool, addr);
+=

+    if (h < 0)
+    {
+        return false;
+    }
+
+    ifconfig_pool_=
entry_free(&pool->list[h], true);
+    pool->list[h]=2Ein_use =3D true;
+  =
  pool->list[h]=2Ereserved =3D true;
+    return true;
+}
+
 static in_addr=
_t
 ifconfig_pool_handle_to_ip_base(const struct ifconfig_pool *pool, ifcon=
fig_pool_handle hand)
 {
diff --git a/src/openvpn/pool=2Eh b/src/openvpn/po=
ol=2Eh
index 497dcda=2E=2Efda87ed 100644
--- a/src/openvpn/pool=2Eh
+++ b/s=
rc/openvpn/pool=2Eh
@@ -98,6 +98,9 @@
  */
 bool ifconfig_pool_reserve_ip(s=
truct ifconfig_pool *pool, in_addr_t addr);
 
+/** IPv6 counterpart of ifco=
nfig_pool_reserve_ip()=2E */
+bool ifconfig_pool_reserve_ipv6(struct ifconf=
ig_pool *pool, const struct in6_addr *addr);
+
 struct ifconfig_pool_persis=
t *ifconfig_pool_persist_init(const char *filename, int refresh_freq);
 
 v=
oid ifconfig_pool_persist_close(struct ifconfig_pool_persist *persist);
dif=
f --git a/tests/unit_tests/openvpn/test_subnet_pool=2Ec b/tests/unit_tests/=
openvpn/test_subnet_pool=2Ec
index 4022233=2E=2E5c2e336 100644
--- a/tests/=
unit_tests/openvpn/test_subnet_pool=2Ec
+++ b/tests/unit_tests/openvpn/test=
_subnet_pool=2Ec
@@ -158,12 +158,88 @@
     assert_false(subnet_pools_check=
(&adup, 0, 0, M_WARN));
 }
 
+/* the IPv6 counterpart resolves independentl=
y: a tag may name a v4 pool, a
+ * v6 pool, or both=2E */
+static void
+tes=
t_subnet_pool6_by_tag(void **state)
+{
+    struct subnet_pool6_def c =3D {=
 =2Enext =3D NULL, =2Etag =3D "grpC", =2Enetbits =3D 64 };
+    struct subn=
et_pool6_def b =3D { =2Enext =3D &c, =2Etag =3D "grpB", =2Enetbits =3D 96 }=
;
+    struct subnet_pool6_def a =3D { =2Enext =3D &b, =2Etag =3D "grpA", =
=2Enetbits =3D 64 };
+
+    assert_ptr_equal(subnet_pool6_by_tag(&a, "grpA"=
), &a);
+    assert_ptr_equal(subnet_pool6_by_tag(&a, "grpB"), &b);
+    as=
sert_ptr_equal(subnet_pool6_by_tag(&a, "grpC"), &c);
+    assert_int_equal(=
subnet_pool6_by_tag(&a, "grpB")->netbits, 96);
+    assert_null(subnet_pool=
6_by_tag(&a, "nope"));
+    assert_null(subnet_pool6_by_tag(NULL, "grpA"));=

+}
+
+/* <prefix>::<host> as an in6_addr */
+static struct in6_addr
+in6(c=
onst char *addr)
+{
+    struct in6_addr a;
+
+    assert_int_equal(inet_pt=
on(AF_INET6, addr, &a), 1);
+    return a;
+}
+
+/* a single IPv6 pool, che=
cked against the fd00:8::/64 --server-ipv6 network */
+static bool
+check6_=
one(const char *net, unsigned int bits, const char *gw)
+{
+    const struc=
t in6_addr server =3D in6("fd00:8::");
+    struct subnet_pool6_def d =3D {=
 =2Enext =3D NULL, =2Etag =3D "grp", =2Enetwork =3D in6(net), =2Enetbits =
=3D bits, =2Egateway =3D in6(gw) };
+
+    return subnet_pools6_check(&d, &=
server, 64, M_WARN);
+}
+
+static void
+test_subnet_pools6_check(void **sta=
te)
+{
+    /* /64 =2E=2E /124, any host address of the network as gateway =
*/
+    assert_true(check6_one("fd00:9::", 64, "fd00:9::1"));
+    assert_t=
rue(check6_one("fd00:9::", 124, "fd00:9::1"));
+    assert_true(check6_one(=
"fd00:9::", 112, "fd00:9::ffff"));
+    assert_false(check6_one("fd00:9::",=
 63, "fd00:9::1"));
+    assert_false(check6_one("fd00:9::", 125, "fd00:9::=
1"));
+
+    /* host bits in the network, gateway =3D network or outside it=
 */
+    assert_false(check6_one("fd00:9::5", 64, "fd00:9::1"));
+    asser=
t_false(check6_one("fd00:9::", 64, "fd00:9::"));
+    assert_false(check6_o=
ne("fd00:9::", 64, "fd00:a::1"));
+
+    /* overlapping the --server-ipv6 n=
etwork, inside or covering it */
+    assert_false(check6_one("fd00:8::", 9=
6, "fd00:8::1"));
+
+    /* two pools: disjoint, overlapping, same tag */
+=
    const struct in6_addr server =3D in6("fd00:8::");
+    struct subnet_po=
ol6_def b =3D { =2Enext =3D NULL, =2Etag =3D "grpB", =2Enetwork =3D in6("fd=
00:a::"), =2Enetbits =3D 64, =2Egateway =3D in6("fd00:a::1") };
+    struct=
 subnet_pool6_def a =3D { =2Enext =3D &b, =2Etag =3D "grpA", =2Enetwork =3D=
 in6("fd00:9::"), =2Enetbits =3D 64, =2Egateway =3D in6("fd00:9::1") };
+
+=
    assert_true(subnet_pools6_check(&a, &server, 64, M_WARN));
+    assert_=
true(subnet_pools6_check(&a, &server, 0, M_WARN));
+
+    /* a /120 grpB in=
side grpA */
+    struct subnet_pool6_def bin =3D { =2Enext =3D NULL, =2Eta=
g =3D "grpB", =2Enetwork =3D in6("fd00:9::100"), =2Enetbits =3D 120, =2Egat=
eway =3D in6("fd00:9::101") };
+    struct subnet_pool6_def ain =3D { =2Ene=
xt =3D &bin, =2Etag =3D "grpA", =2Enetwork =3D in6("fd00:9::"), =2Enetbits =
=3D 64, =2Egateway =3D in6("fd00:9::1") };
+    assert_false(subnet_pools6_=
check(&ain, &server, 64, M_WARN));
+
+    /* the same tag defined twice */
=
+    struct subnet_pool6_def bdup =3D { =2Enext =3D NULL, =2Etag =3D "grpA"=
, =2Enetwork =3D in6("fd00:a::"), =2Enetbits =3D 64, =2Egateway =3D in6("fd=
00:a::1") };
+    struct subnet_pool6_def adup =3D { =2Enext =3D &bdup, =2E=
tag =3D "grpA", =2Enetwork =3D in6("fd00:9::"), =2Enetbits =3D 64, =2Egatew=
ay =3D in6("fd00:9::1") };
+    assert_false(subnet_pools6_check(&adup, &se=
rver, 64, M_WARN));
+}
+
 const struct CMUnitTest subnet_pool_tests[] =3D {=

     cmocka_unit_test(test_subnet_pool_by_tag),
     cmocka_unit_test(test=
_subnet_pools_check_netmask),
     cmocka_unit_test(test_subnet_pools_check=
_gateway),
     cmocka_unit_test(test_subnet_pools_check_range),
     cmock=
a_unit_test(test_subnet_pools_check_overlap),
+    cmocka_unit_test(test_su=
bnet_pool6_by_tag),
+    cmocka_unit_test(test_subnet_pools6_check),
 };
 
=
 int

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I64e0850d4=
8647a2c0e3d385c2f20a9f445931727
Gerrit-Change-Number: 1786
Gerrit-PatchSet:=
 8
Gerrit-Owner: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>

--YYNXK6PTauU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Antonio Quartulli <strong>upl=
oaded patch set #8</strong> to this change=2E</p><p><a href=3D"https://gerr=
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
ol=2Ec<br>9 files changed, 394 insertions(+), 31 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/86/1786/8</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/doc/man-sections/server-options=2Erst b/=
doc/man-sections/server-options=2Erst</span><br><span>index 9434e5d=2E=2E48=
4cd43 100644</span><br><span>--- a/doc/man-sections/server-options=2Erst</s=
pan><br><span>+++ b/doc/man-sections/server-options=2Erst</span><br><span>@=
@ -366,11 +366,32 @@</span><br><span>   and FreeBSD the IPv4 route is insta=
lled on-link, without a gateway, so its</span><br><span>   ``route_gateway_=
{n}`` is not set for ``--route-up`` scripts=2E</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+--subnet-pool-ipv6 args</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  The IPv6 counterpart of =
``--subnet-pool``=2E Repeatable main-config directive=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  Valid syntax:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  ::</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     subnet-pool-ipv=
6 tag network/bits [gateway]</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``bits``=
 must be between 64 and 124; ``gateway`` defaults to the first</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  address of the network, is nev=
er assigned to a client, and is pushed to the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  pool&#39;s clients as the remote end of their `=
`ifconfig-ipv6``=2E A tag may name</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  an IPv4 pool, an IPv6 pool, or both; a client referencing =
it with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--subnet=
-pool-tag`` is then assigned an address from each family the tag</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  defines=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  Requires ``--server-ipv6`` with ``--dev tun`` and ``--=
topology subnet``=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  ``network`` must have no host bits set, ``gateway`` must be a host addre=
ss</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  inside it, each=
 ``tag`` may be defined only once and no pool may overlap</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  another one or the ``--server-ipv6`=
` network=2E As for ``--subnet-pool``, the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  server routes each pool&#39;s network into the tun=
 device=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> --subnet-pool-tag tag</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  Assign this client to the ``--subnet-pool`` named ``tag``=2E Mus=
t be</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  associated with=
 a specific client instance via ``--client-config-dir`` or</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  ``--client-connect``=2E Several clie=
nts may reference the same tag and are</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  then served from the same shared pool=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  Assign this client to the ``--sub=
net-pool`` / ``--subnet-pool-ipv6`` named</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  ``tag``=2E Must be associated with a specific clien=
t instance via</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``-=
-client-config-dir`` or ``--client-connect``=2E Several clients may</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  reference the same tag an=
d are then served from the same shared pool(s)=2E</span><br><span> </span><=
br><span> --ifconfig-ipv6-push args</span><br><span>   for ``--client-confi=
g-dir`` per-client static IPv6 interface</span><br><span>diff --git a/src/o=
penvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index e8d51da=2E=
=2E1ec8515 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><sp=
an>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -393,6 +393,10 @@</span><=
br><span>     {</span><br><span>         multi_get_group_pool(m, &amp;t-&gt=
;options, d-&gt;tag);</span><br><span>     }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    for (const struct subnet_pool6_def *d =3D t-&g=
t;options=2Esubnet_pools_ipv6; d; d =3D d-&gt;next)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        multi_get_group_pool(m, &amp;t-&gt;options, d-&=
gt;tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span> </span><br><span>     /*</span><br><span>      * Help us keep t=
rack of routing table=2E</span><br><span>@@ -1471,16 +1475,31 @@</span><br>=
<span>     }</span><br><span> </span><br><span>     const struct subnet_poo=
l_def *d4 =3D subnet_pool_by_tag(o-&gt;subnet_pools, tag);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(d4);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct subnet_pool6_def *d6 =3D=
 subnet_pool6_by_tag(o-&gt;subnet_pools_ipv6, tag);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *pool_tag =3D d4 ? d4-&gt;=
tag : (d6 ? d6-&gt;tag : NULL);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ASSERT(pool_tag);</span><br><span>     ALLOC_OBJ_CLEAR(sp, =
struct subnet_pool);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   sp-&gt;tag =3D d4-&gt;tag;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    /* the configured dynamic range, or else every host address of =
the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * subnet, min=
us the gateway reserved below if it falls inside it */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    const in_addr_t start =3D d4-&gt;pool_=
start ? d4-&gt;pool_start : d4-&gt;network + 1;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    const in_addr_t end =3D d4-&gt;pool_end ? d4-=
&gt;pool_end : (d4-&gt;network | ~d4-&gt;netmask) - 1;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    sp-&gt;pool =3D ifconfig_pool_init(tru=
e, IFCONFIG_POOL_INDIV, start, end, o-&gt;duplicate_cn, false,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                  =
in6addr_any, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
fconfig_pool_reserve_ip(sp-&gt;pool, d4-&gt;gateway);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;tag =3D pool_tag;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* the IPv4 range (configure=
d, or else every host address of the subnet)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * and every host address of the IPv6 network,=
 minus the gateways reserved</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * below (the IPv4 and the IPv6 address of a client share one =
pool handle) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
in_addr_t start =3D 0, end =3D 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (d4)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
start =3D d4-&gt;pool_start ? d4-&gt;pool_start : d4-&gt;network + 1;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        end =3D d4-&gt;po=
ol_end ? d4-&gt;pool_end : (d4-&gt;network | ~d4-&gt;netmask) - 1;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;pool =3D ifconfig_pool_init(d4=
 !=3D NULL, IFCONFIG_POOL_INDIV, start, end, o-&gt;duplicate_cn,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
    d6 !=3D NULL, d6 ? add_in6_addr(d6-&gt;network, 1) : in6addr_any,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
         d6 ? (int)d6-&gt;netbits : 0);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (d4)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      ifconfig_pool_reserve_ip(sp-&gt;pool, d4-&gt;gateway);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (d6)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        ifconfig_pool_reserve_ipv6(sp-&gt;pool, &amp;d6-&gt;gateway);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n>     sp-&gt;next =3D m-&gt;subnet_pools;</span><br><span>     m-&gt;subne=
t_pools =3D sp;</span><br><span>     return sp-&gt;pool;</span><br><span>@@=
 -1514,6 +1533,19 @@</span><br><span>             mi-&gt;context=2Eoptions=
=2Esubnet_pool_gateway =3D d-&gt;gateway;</span><br><span>         }</span>=
<br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (mi-&gt;context=2Eoptions=2Esubnet_pool_tag)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        const struct subnet_pool6_def *d =3D subnet_pool6_by=
_tag(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m-=
&gt;top=2Eoptions=2Esubnet_pools_ipv6, mi-&gt;context=2Eoptions=2Esubnet_po=
ol_tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;context=2Eoptio=
ns=2Esubnet_pool_ipv6_defined =3D d !=3D NULL;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (d)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_network=
 =3D d-&gt;network;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_netbits =3D d-&gt;n=
etbits;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_gateway =3D d-&gt;gateway;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br>=
<span>     /*</span><br><span>      * If ifconfig addresses were set by dyn=
amic config file,</span><br><span>@@ -1548,15 +1580,16 @@</span><br><span> =
                &quot;MULTI_sva: WARNING: if --ifconfig-push is used for IP=
v4, automatic IPv6 assignment from --ifconfig-ipv6-pool does not work=2E  U=
se --ifconfig-ipv6-push for IPv6 then=2E&quot;);</span><br><span>         }=
</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    else if (mi-&gt;context=2Eoptions=2Esubnet_pool_defined)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    else if (mi-&gt;context=2Eop=
tions=2Esubnet_pool_defined</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+             || mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_defined=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        /* dynamic address from this client&#39;s --subnet-pool group */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* dynamic =
address(es) from this client&#39;s --subnet-pool group */</span><br><span> =
        struct ifconfig_pool *group =3D</span><br><span>             multi_=
get_group_pool(m, &amp;m-&gt;top=2Eoptions, mi-&gt;context=2Eoptions=2Esubn=
et_pool_tag);</span><br><span> </span><br><span>         /* the address may=
 have been acquired before the tag was known (from</span><br><span>        =
  * the global pool) or for a tag that a later handler overrode: drop</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-         * it so we serve t=
his client from its current group */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+         * it so we serve this client from its current gro=
up only */</span><br><span>         if (mi-&gt;vaddr_handle &gt;=3D 0 &amp;=
&amp; mi-&gt;vaddr_pool !=3D group)</span><br><span>         {</span><br><s=
pan>             ifconfig_pool_release(mi-&gt;vaddr_pool ? mi-&gt;vaddr_poo=
l : m-&gt;ifconfig_pool,</span><br><span>@@ -1571,27 +1604,44 @@</span><br>=
<span>         if (mi-&gt;vaddr_handle &lt; 0)</span><br><span>         {</=
span><br><span>             in_addr_t local =3D 0, remote =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            struct in6_addr re=
mote_ipv6;</span><br><span>             const char *cn =3D NULL;</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
CLEAR(remote_ipv6);</span><br><span>             if (!mi-&gt;context=2Eopti=
ons=2Eduplicate_cn)</span><br><span>             {</span><br><span>        =
         cn =3D tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, true);</sp=
an><br><span>             }</span><br><span> </span><br><span>             =
mi-&gt;vaddr_pool =3D group;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            mi-&gt;vaddr_handle =3D ifconfig_pool_acquire(mi-&gt;vad=
dr_pool, &amp;local, &amp;remote, NULL, cn);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            if (mi-&gt;vaddr_handle &gt;=3D 0)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                mi-&gt;context=2Ec2=
=2Epush_ifconfig_local =3D remote;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                mi-&gt;context=2Ec2=2Epush_ifconfig_remote_net=
mask =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       mi-&gt;context=2Eoptions=2Esubnet_pool_netmask;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                mi-&gt;context=2Ec2=2Epush=
_ifconfig_defined =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       mi-&gt;vaddr_handle =3D</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                ifconfig_pool_acquire(mi-&gt;vaddr_pool, &amp;lo=
cal, &amp;remote, &amp;remote_ipv6, cn);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (mi-&gt;vaddr_handle &lt; 0)</span><br>=
<span>             {</span><br><span>                 msg(D_MULTI_ERRORS, &=
quot;MULTI: no free --subnet-pool addresses are available for %s&quot;,</sp=
an><br><span>                     multi_instance_string(mi, false, &amp;gc)=
);</span><br><span>             }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            else</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                if (mi-&gt;context=2Eoptions=2Esubnet_pool_defined)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    mi-&=
gt;context=2Ec2=2Epush_ifconfig_local =3D remote;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    mi-&gt;context=2Ec2=2Epus=
h_ifconfig_remote_netmask =3D</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                        mi-&gt;context=2Eoptions=2Esubnet_pool_ne=
tmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       mi-&gt;context=2Ec2=2Epush_ifconfig_defined =3D true;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                if (mi-&gt;context=
=2Eoptions=2Esubnet_pool_ipv6_defined)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    /* the server&#39;s own address is off=
-link for this client:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                     * hand out the pool gateway as the remote end inste=
ad */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local =3D remote_ipv6;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    mi-&g=
t;context=2Ec2=2Epush_ifconfig_ipv6_remote =3D</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        mi-&gt;context=2Eoptions=
=2Esubnet_pool_ipv6_gateway;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_netbi=
ts =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
           mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_netbits;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    mi-&gt;cont=
ext=2Ec2=2Epush_ifconfig_ipv6_defined =3D true;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span>         }</span><b=
r><span>     }</span><br><span>     else if (m-&gt;ifconfig_pool &amp;&amp;=
 mi-&gt;vaddr_handle &lt; 0) /* otherwise, choose a pool address */</span><=
br><span>@@ -2932,7 +2982,9 @@</span><br><span>     }</span><br><span> </sp=
an><br><span>     if (mi-&gt;context=2Eoptions=2Esubnet_pool_tag</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; !subnet_pool_=
by_tag(m-&gt;top=2Eoptions=2Esubnet_pools, mi-&gt;context=2Eoptions=2Esubne=
t_pool_tag))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 &amp;&amp; !subnet_pool_by_tag(m-&gt;top=2Eoptions=2Esubnet_pools, mi-&gt;=
context=2Eoptions=2Esubnet_pool_tag)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        &amp;&amp; !subnet_pool6_by_tag(m-&gt;top=2Eoption=
s=2Esubnet_pools_ipv6,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                mi-&gt;context=2Eoptions=2Esubnet_pool_t=
ag))</span><br><span>     {</span><br><span>         msg(D_MULTI_ERRORS, &q=
uot;MULTI: client has been rejected due to unknown --subnet-pool-tag &#39;%=
s&#39;&quot;,</span><br><span>             mi-&gt;context=2Eoptions=2Esubne=
t_pool_tag);</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/ope=
nvpn/options=2Ec</span><br><span>index eb0bcfd=2E=2Edff301a 100644</span><b=
r><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/opt=
ions=2Ec</span><br><span>@@ -457,6 +457,8 @@</span><br><span>     &quot;   =
               pool of addresses outside the --server network, selected\n&q=
uot;</span><br><span>     &quot;                  per client with --subnet-=
pool-tag=2E start/end restrict the\n&quot;</span><br><span>     &quot;     =
             dynamically assigned range=2E\n&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &quot;--subnet-pool-ipv6 tag network/bit=
s [gateway] : IPv6 counterpart of\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;                  --subnet-pool=2E\n&quot;<=
/span><br><span>     &quot;--subnet-pool-tag tag : Assign this client to th=
e --subnet-pool named tag=2E\n&quot;</span><br><span>     &quot;           =
       Only valid in a client-specific config file=2E\n&quot;</span><br><sp=
an>     &quot;--ifconfig-push local remote-netmask : Push an ifconfig optio=
n to remote,\n&quot;</span><br><span>@@ -1919,6 +1921,20 @@</span><br><span=
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
pass_file)</span><br><span>         {</span><br><span>@@ -1986,6 +2002,7 @@=
</span><br><span>         MUST_BE_UNDEF(ifconfig_pool_persist_filename, &qu=
ot;ifconfig-pool-persist&quot;);</span><br><span>         MUST_BE_UNDEF(ifc=
onfig_ipv6_pool_defined, &quot;ifconfig-ipv6-pool&quot;);</span><br><span> =
        MUST_BE_UNDEF(subnet_pools, &quot;subnet-pool&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(subnet_pool=
s_ipv6, &quot;subnet-pool-ipv6&quot;);</span><br><span>         MUST_BE_UND=
EF(real_hash_size, &quot;hash-size&quot;);</span><br><span>         MUST_BE=
_UNDEF(virtual_hash_size, &quot;hash-size&quot;);</span><br><span>         =
MUST_BE_UNDEF(learn_address_script, &quot;learn-address&quot;);</span><br><=
span>@@ -3119,8 +3136,9 @@</span><br><span> }</span><br><span> </span><br><=
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
serspace=2E  Under DCO on Linux and FreeBSD the routes are installed on-lin=
k,</span><br><span>  * see subnet_pool_routes_onlink()=2E</span><br><span>@=
@ -3138,6 +3156,16 @@</span><br><span>                                     =
  o-&gt;route_default_table_id);</span><br><span>         ro-&gt;on_link =
=3D subnet_pool_routes_onlink(o);</span><br><span>     }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (const struct subnet_pool6_def *d =3D o-&gt;subne=
t_pools_ipv6; d; d =3D d-&gt;next)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        struct buffer prefix =3D alloc_buf_gc(64, &amp;o-&gt;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        buf_printf(&amp;prefix, &quot;%s/%u&quo=
t;, print_in6_addr(d-&gt;network, 0, &amp;o-&gt;gc), d-&gt;netbits);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        rol6_check_alloc(o=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        add_route=
_ipv6_to_option_list(o-&gt;routes_ipv6, BSTR(&amp;prefix), NULL, NULL,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
              o-&gt;route_default_table_id);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><br><span> </span><=
br><span> static void</span><br><span>@@ -6314,6 +6342,37 @@</span><br><spa=
n>         sp-&gt;next =3D options-&gt;subnet_pools;</span><br><span>      =
   options-&gt;subnet_pools =3D sp;</span><br><span>     }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;subne=
t-pool-ipv6&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        struct subnet_pool6_def *sp;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct in6_addr=
 network, gateway;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       unsigned int netbits =3D 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (!get_ipv6_addr(p[2], &amp;network, &amp;netbi=
ts, msglevel))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg=
(msglevel, &quot;cannot parse --subnet-pool-ipv6 network&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (netbits &lt; 64 || netbits=
 &gt; 124)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msg=
level, &quot;--subnet-pool-ipv6 network must be between /64 and /124 (not /=
%u)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       netbits);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(p[3] &amp;&amp; !get_ipv6_addr(p[3], &amp;gateway, NULL, msglevel))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;cann=
ot parse --subnet-pool-ipv6 gateway&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            goto err;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        ALLOC_OBJ_GC(sp, struct subnet_pool6_def, &amp;opti=
ons-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 sp-&gt;tag =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        sp-&gt;network =3D network;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        sp-&gt;netbits =3D netbits;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;gateway =3D p[3] ? gateway=
 : add_in6_addr(network, 1);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        sp-&gt;next =3D options-&gt;subnet_pools_ipv6;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;subnet_pool=
s_ipv6 =3D sp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span>     else if (streq(p[0], &quot;subnet-pool-tag&quot;) &am=
p;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>     =
    VERIFY_PERMISSION(OPT_P_INSTANCE);</span><br><span>diff --git a/src/ope=
nvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index 568bae6=2E=
=2Ef3bbde9 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><=
span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -267,6 +267,16 @@</sp=
an><br><span>     in_addr_t pool_end;</span><br><span> };</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The IPv6 counter=
part of struct subnet_pool_def (--subnet-pool-ipv6)=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+struct subnet_pool6_def</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct subnet_pool6_def *next;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const char *tag;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr network;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int netbits;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr =
gateway;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Command=
 line options */</span><br><span> struct options</span><br><span> {</span><=
br><span>@@ -533,12 +543,17 @@</span><br><span>     bool push_ifconfig_cons=
traint_defined;</span><br><span>     in_addr_t push_ifconfig_constraint_net=
work;</span><br><span>     in_addr_t push_ifconfig_constraint_netmask;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct subnet_pool_def=
 *subnet_pools; /* named pools (server config) */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    const char *subnet_pool_tag;          /* wh=
ich pool this client uses (CCD) */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    bool subnet_pool_defined;             /* resolved from the=
 tag at connect */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct subnet_pool_def *subnet_pools;       /* named IPv4 pools (server =
config) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t subnet_pool6_def *subnet_pools_ipv6; /* named IPv6 pools (server config) =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *s=
ubnet_pool_tag;                /* which pool this client uses (CCD) */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool subnet_pool_def=
ined;                   /* resolved from the tag at connect */</span><br><s=
pan>     in_addr_t subnet_pool_network;</span><br><span>     in_addr_t subn=
et_pool_netmask;</span><br><span>     in_addr_t subnet_pool_gateway;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    bool subnet_pool_ipv6_=
defined; /* resolved from the tag at connect */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct in6_addr subnet_pool_ipv6_network;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int subn=
et_pool_ipv6_netbits;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct in6_addr subnet_pool_ipv6_gateway;</span><br><span>     bool p=
ush_ifconfig_ipv4_blocked;           /* IPv4 */</span><br><span>     bool p=
ush_ifconfig_ipv6_defined;           /* IPv6 */</span><br><span>     struct=
 in6_addr push_ifconfig_ipv6_local;  /* IPv6 */</span><br><span>diff --git =
a/src/openvpn/options_util=2Ec b/src/openvpn/options_util=2Ec</span><br><sp=
an>index 862bf7c=2E=2Ee853682 100644</span><br><span>--- a/src/openvpn/opti=
ons_util=2Ec</span><br><span>+++ b/src/openvpn/options_util=2Ec</span><br><=
span>@@ -130,6 +130,108 @@</span><br><span>     return true;</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* value of bit &lt;i&gt; (0 =3D most significant) of an IPv6 address */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+in6_bit(const struct in6_ad=
dr *a, unsigned int i)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return a-&g=
t;s6_addr[i / 8] &amp; (0x80 &gt;&gt; (i % 8));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* true i=
f the first &lt;bits&gt; bits of the two addresses are equal */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+in6_prefix_equal(const struct in6_addr =
*a, const struct in6_addr *b, unsigned int bits)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    for (unsigned int i =3D 0; i &lt; bits; ++i)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (in6_bit(a, i) !=3D in6_bit(b, i))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            return false;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* true if every=
 bit of &lt;a&gt; from bit &lt;from&gt; on is zero */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+in6_suffix_zero(const struct in6_addr *a, unsigne=
d int from)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for (unsigned int i =
=3D from; i &lt; 128; ++i)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (in6_bit(a, i))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+subnet_p=
ools6_check(const struct subnet_pool6_def *pools, const struct in6_addr *se=
rver_network,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              unsigned int server_netbits, msglvl_t msglevel)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    for (const struct subnet_pool6_def *d =3D pools=
; d; d =3D d-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(d-&gt;netbits &lt; 64 || d-&gt;netbits &gt; 124)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            msg(msglevel, &quot;--subnet-pool-ipv6 %s: =
network must be between /64 and /124 (not /%u)&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                d-&gt;tag, d-&gt;netbits)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!in6_suffix_zero(&amp;d-&gt;n=
etwork, d-&gt;netbits))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      msg(msglevel, &quot;--subnet-pool-ipv6 %s: network has host bits set&=
quot;, d-&gt;tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           return false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!in6_prefix_=
equal(&amp;d-&gt;gateway, &amp;d-&gt;network, d-&gt;netbits)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            || in6_suffix_zero(&am=
p;d-&gt;gateway, d-&gt;netbits))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(msglevel,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                &quot;--subnet-pool-ipv6 %s: gateway must be a hos=
t address inside the network&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                d-&gt;tag);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (server_netbits</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            &amp;&amp; in6_prefix_equal(&amp;d-&gt;network, server_=
network, min_uint(d-&gt;netbits, server_netbits)))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(msglevel, &quot;--subnet-pool-ipv6 %s:=
 network overlaps the --server-ipv6 network&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                d-&gt;tag);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        for (const struct subnet_pool6_def *e =3D d-&gt;nex=
t; e; e =3D e-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      if (!strcmp(d-&gt;tag, e-&gt;tag))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                msg(msglevel, &quot;--subnet-pool-ipv6 %s: t=
ag defined more than once&quot;, d-&gt;tag);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                return false;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            if (in6_prefix_equal(&amp;d-&gt;ne=
twork, &amp;e-&gt;network, min_uint(d-&gt;netbits, e-&gt;netbits)))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel, &qu=
ot;--subnet-pool-ipv6 %s and %s: networks overlap&quot;, d-&gt;tag, e-&gt;t=
ag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const struct subnet=
_pool6_def *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+subnet_=
pool6_by_tag(const struct subnet_pool6_def *pools, const char *tag)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (const struct subnet_pool6_def *d =3D=
 pools; d; d =3D d-&gt;next)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (!strcmp(d-&gt;tag, tag))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            return d;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const char *</span><br>=
<span> parse_auth_failed_temp(struct options *o, const char *reason)</span>=
<br><span> {</span><br><span>diff --git a/src/openvpn/options_util=2Eh b/sr=
c/openvpn/options_util=2Eh</span><br><span>index f1e63e15=2E=2E6ddded3 1006=
44</span><br><span>--- a/src/openvpn/options_util=2Eh</span><br><span>+++ b=
/src/openvpn/options_util=2Eh</span><br><span>@@ -55,6 +55,25 @@</span><br>=
<span> bool subnet_pools_check(const struct subnet_pool_def *pools, in_addr=
_t server_network,</span><br><span>                         in_addr_t serve=
r_netmask, msglvl_t msglevel);</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * IPv6 counterpart of subnet_pools_check(): network between /=
64 and /124</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * witho=
ut host bits, gateway a host address inside it, unique tags, and no</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * network overlapping anot=
her pool or the --server-ipv6 network=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param pools           head of the --subnet-pool-ipv6 list (may be N=
ULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param serve=
r_network  the --server-ipv6 network</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param server_netbits  the --server-ipv6 prefix length,=
 or 0 if there is none</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param msglevel        level of the message logged on the first error=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return         =
       true if every definition is valid</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+bool subnet_pools6_check(const struct subnet_pool6_def *pools,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                         co=
nst struct in6_addr *server_network, unsigned int server_netbits,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                         msgl=
vl_t msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/** IPv6 counterpart of=
 subnet_pool_by_tag()=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+const struct subnet_pool6_def *subnet_pool6_by_tag(const struct sub=
net_pool6_def *pools,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                                   const char *tag);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span=
><br><span> /** Checks if the string is a valid integer by checking if it c=
an be</span><br><span>  *  converted to an integer */</span><br><span>diff =
--git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec</span><br><span>index 5=
c5b3fe=2E=2E2cdaa71 100644</span><br><span>--- a/src/openvpn/pool=2Ec</span=
><br><span>+++ b/src/openvpn/pool=2Ec</span><br><span>@@ -446,6 +446,22 @@<=
/span><br><span>     return true;</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ifconfig_pool_reserve_ipv6(struct ifcon=
fig_pool *pool, const struct in6_addr *addr)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const ifconfig_pool_handle h =3D ifconfig_pool_ipv6_base_to_hand=
le(pool, addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (h &lt; 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ifconfig_pool_entry_free(&amp;pool-&gt;list[h], true);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    pool-&gt;list[h]=2Ein_use =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pool-&=
gt;list[h]=2Ereserved =3D true;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> static in_addr_t</span><br><span> ifconfig_pool_handle_to_ip_base(=
const struct ifconfig_pool *pool, ifconfig_pool_handle hand)</span><br><spa=
n> {</span><br><span>diff --git a/src/openvpn/pool=2Eh b/src/openvpn/pool=
=2Eh</span><br><span>index 497dcda=2E=2Efda87ed 100644</span><br><span>--- =
a/src/openvpn/pool=2Eh</span><br><span>+++ b/src/openvpn/pool=2Eh</span><br=
><span>@@ -98,6 +98,9 @@</span><br><span>  */</span><br><span> bool ifconfi=
g_pool_reserve_ip(struct ifconfig_pool *pool, in_addr_t addr);</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** IPv6 count=
erpart of ifconfig_pool_reserve_ip()=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+bool ifconfig_pool_reserve_ipv6(struct ifconfig_pool=
 *pool, const struct in6_addr *addr);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> struct ifconfig_pool_persist *ifconfig_=
pool_persist_init(const char *filename, int refresh_freq);</span><br><span>=
 </span><br><span> void ifconfig_pool_persist_close(struct ifconfig_pool_pe=
rsist *persist);</span><br><span>diff --git a/tests/unit_tests/openvpn/test=
_subnet_pool=2Ec b/tests/unit_tests/openvpn/test_subnet_pool=2Ec</span><br>=
<span>index 4022233=2E=2E5c2e336 100644</span><br><span>--- a/tests/unit_te=
sts/openvpn/test_subnet_pool=2Ec</span><br><span>+++ b/tests/unit_tests/ope=
nvpn/test_subnet_pool=2Ec</span><br><span>@@ -158,12 +158,88 @@</span><br><=
span>     assert_false(subnet_pools_check(&amp;adup, 0, 0, M_WARN));</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* the IPv6 counterpart resolves independently: a tag may name a=
 v4 pool, a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * v6 po=
ol, or both=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_subne=
t_pool6_by_tag(void **state)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t subnet_pool6_def c =3D { =2Enext =3D NULL, =2Etag =3D &quot;grpC&quot;, =
=2Enetbits =3D 64 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct subnet_pool6_def b =3D { =2Enext =3D &amp;c, =2Etag =3D &quot;g=
rpB&quot;, =2Enetbits =3D 96 };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct subnet_pool6_def a =3D { =2Enext =3D &amp;b, =2Etag =
=3D &quot;grpA&quot;, =2Enetbits =3D 64 };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_ptr_equal(subnet_pool6_by_tag(&amp;a, &quot;grpA&quot;), &am=
p;a);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr=
_equal(subnet_pool6_by_tag(&amp;a, &quot;grpB&quot;), &amp;b);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(subnet_pool=
6_by_tag(&amp;a, &quot;grpC&quot;), &amp;c);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(subnet_pool6_by_tag(&amp;a, &=
quot;grpB&quot;)-&gt;netbits, 96);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_null(subnet_pool6_by_tag(&amp;a, &quot;nope&quot;=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(=
subnet_pool6_by_tag(NULL, &quot;grpA&quot;));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* &lt;pref=
ix&gt;::&lt;host&gt; as an in6_addr */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static struct in6_addr</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+in6(const char *addr)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct in6_addr a;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(inet_pton(AF_INET6, addr, &amp;a), 1);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return a;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* a single I=
Pv6 pool, checked against the fd00:8::/64 --server-ipv6 network */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+check6_one(const char *net, unsigned=
 int bits, const char *gw)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const s=
truct in6_addr server =3D in6(&quot;fd00:8::&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6_def d =3D { =2Ene=
xt =3D NULL, =2Etag =3D &quot;grp&quot;, =2Enetwork =3D in6(net), =2Enetbit=
s =3D bits, =2Egateway =3D in6(gw) };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return subnet_pools6_check(&amp;d, &amp;server, 64, M_WARN);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
est_subnet_pools6_check(void **state)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* /64 =2E=2E /124, any host address of the network as gateway */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(check6_on=
e(&quot;fd00:9::&quot;, 64, &quot;fd00:9::1&quot;));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(check6_one(&quot;fd00:9::=
&quot;, 124, &quot;fd00:9::1&quot;));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(check6_one(&quot;fd00:9::&quot;, 112, &qu=
ot;fd00:9::ffff&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_false(check6_one(&quot;fd00:9::&quot;, 63, &quot;fd00:9::1&=
quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
false(check6_one(&quot;fd00:9::&quot;, 125, &quot;fd00:9::1&quot;));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* host bits in the network, gateway =3D =
network or outside it */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_false(check6_one(&quot;fd00:9::5&quot;, 64, &quot;fd00:9::1=
&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_false(check6_one(&quot;fd00:9::&quot;, 64, &quot;fd00:9::&quot;));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check6_one=
(&quot;fd00:9::&quot;, 64, &quot;fd00:a::1&quot;));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* overlapping the --server-ipv6 network, inside or cove=
ring it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_false(check6_one(&quot;fd00:8::&quot;, 96, &quot;fd00:8::1&quot;));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* two pools: disjoint, overlapping, sam=
e tag */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const s=
truct in6_addr server =3D in6(&quot;fd00:8::&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6_def b =3D { =2Ene=
xt =3D NULL, =2Etag =3D &quot;grpB&quot;, =2Enetwork =3D in6(&quot;fd00:a::=
&quot;), =2Enetbits =3D 64, =2Egateway =3D in6(&quot;fd00:a::1&quot;) };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool=
6_def a =3D { =2Enext =3D &amp;b, =2Etag =3D &quot;grpA&quot;, =2Enetwork =
=3D in6(&quot;fd00:9::&quot;), =2Enetbits =3D 64, =2Egateway =3D in6(&quot;=
fd00:9::1&quot;) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(sub=
net_pools6_check(&amp;a, &amp;server, 64, M_WARN));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(subnet_pools6_check(&amp;=
a, &amp;server, 0, M_WARN));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a /=
120 grpB inside grpA */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct subnet_pool6_def bin =3D { =2Enext =3D NULL, =2Etag =3D &quo=
t;grpB&quot;, =2Enetwork =3D in6(&quot;fd00:9::100&quot;), =2Enetbits =3D 1=
20, =2Egateway =3D in6(&quot;fd00:9::101&quot;) };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct subnet_pool6_def ain =3D { =2Enex=
t =3D &amp;bin, =2Etag =3D &quot;grpA&quot;, =2Enetwork =3D in6(&quot;fd00:=
9::&quot;), =2Enetbits =3D 64, =2Egateway =3D in6(&quot;fd00:9::1&quot;) };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(su=
bnet_pools6_check(&amp;ain, &amp;server, 64, M_WARN));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* the same tag defined twice */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6_def bdup =3D { =
=2Enext =3D NULL, =2Etag =3D &quot;grpA&quot;, =2Enetwork =3D in6(&quot;fd0=
0:a::&quot;), =2Enetbits =3D 64, =2Egateway =3D in6(&quot;fd00:a::1&quot;) =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet=
_pool6_def adup =3D { =2Enext =3D &amp;bdup, =2Etag =3D &quot;grpA&quot;, =
=2Enetwork =3D in6(&quot;fd00:9::&quot;), =2Enetbits =3D 64, =2Egateway =3D=
 in6(&quot;fd00:9::1&quot;) };</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_false(subnet_pools6_check(&amp;adup, &amp;server, 64,=
 M_WARN));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const str=
uct CMUnitTest subnet_pool_tests[] =3D {</span><br><span>     cmocka_unit_t=
est(test_subnet_pool_by_tag),</span><br><span>     cmocka_unit_test(test_su=
bnet_pools_check_netmask),</span><br><span>     cmocka_unit_test(test_subne=
t_pools_check_gateway),</span><br><span>     cmocka_unit_test(test_subnet_p=
ools_check_range),</span><br><span>     cmocka_unit_test(test_subnet_pools_=
check_overlap),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
cmocka_unit_test(test_subnet_pool6_by_tag),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    cmocka_unit_test(test_subnet_pools6_check),</sp=
an><br><span> };</span><br><span> </span><br><span> int</span><br></pre><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?u=
sp=3Demail">change 1786</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1786?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchse=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 1786 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerri=
t-Owner: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--YYNXK6PTauU=--


--===============1747645944105701265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1747645944105701265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1747645944105701265==--

