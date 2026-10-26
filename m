Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F13C606A31B
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XmBM/A6Q;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=b40cuIk0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OONBRCiJ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VTeLmrmy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=iXYe15c7cr70CzuHAly/te9qbt7ygfMl9oE3sYDOKfg=; b=XmBM/A6Qu9zEWNF9Q77lmK16xa
	Wgt2P6GcePifLhnT7bbIu8m37CbbDyzkKNVfK0dsg1O0xpOT4YRKgcYL67Pc1FkgqpCT+xb+HEeXn
	CZumz25dC4kWWG7urjDLKBA2I1pbDWPPoqSYBU5phHIqbuhbQpfG4UTrkVTrVXgYzPNw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLM8z-000000004rT-3uyk;
	Mon, 26 Oct 2026 14:57:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLM8v-000000004Uz-29al
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 14:57:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OSobxlJ3abs9kui4iKcuy99msVDux5Fh9LnY2f23kbY=; b=b40cuIk0Fc+ahIc8/KTTXgIgbO
 JgH1SexumNEmdJe7Gyka11dLER495UrJAhctY98C/eAWc//JPAHLC6ztTBmz3vcDd42Wp+A5WUHXP
 HyQjQXFHA3MUtjbAW0OXPo9YV0vv2qMrTQbXXZNs/vWz7qsoe8VmOhBPG+mojaNMQcb8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OSobxlJ3abs9kui4iKcuy99msVDux5Fh9LnY2f23kbY=; b=OONBRCiJiZ/MyL+kBERyRISs1W
 Q/cADzeThpihn/cQzYmo1Th8IrfALRAFte72Xr/p+eqLAQXyxF8EqPZGazvdRaCYeX+D7u+AHq/oC
 i/CvI+UKr3aieZfm3NqY8yRHNzkLaX53MA95PaIzW2KhtF1AELm8X7dEsw2QuuFM9WMg=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLM8c-000000004OM-0fx3 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 14:57:30 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a7992e2f7dso1460195e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793026640; x=1793631440; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OSobxlJ3abs9kui4iKcuy99msVDux5Fh9LnY2f23kbY=;
 b=VTeLmrmy2B8z/RHiu9+m0ZERnv2Su9/P5sDtSBp06ENpWlei3voWyryi5L5XjpfFVo
 h0345a2MxNkAYWD0ZpSE0LTXs2XJOF0vMTT4MXdvQoTWTZnx3O+GfYlKEx1TMdP9lDsG
 Zbp5XnOMpAlKn9nG9BBZL+vk31pp5GfIgNV1MXQ17I60mlht72og4qxI+W8pfOz1pKtc
 zQ+tXiKTm2er+N2o0z4G0X507ZJTY56AW21/Xcaqa6UQlvjSKhrg+IqFz8tZ+kgaibKG
 tzCQCBUxN3RDBbGyVXGcDnIdq58ilDOfBgbXthS7mY+1WM2Wk5q6aq+xJDND6kvOtyOh
 YzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793026640; x=1793631440;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OSobxlJ3abs9kui4iKcuy99msVDux5Fh9LnY2f23kbY=;
 b=qvX0VeI08ZDrsti64zfIrqDviAlnOEU+HQB6AK47xEx1OM0BZFv3SzKPdGGUW4riVZ
 U/td+bYYVtsRCpV6+YhPVG/7zunEXf1kJuXDqh7dcGG/J39nUEUHUS58h6FwikQgDz4K
 okSj08Breq48YjMuwjdz2O5D/G+rxntUPQ5eQGuzlx6FrwMfw9gnPtP6h7dRqENa+6og
 gBifIoKiuj2q+h1ZGpaaMA1YbpMfkoAIwvRhpf/xy7TQkmG1Pw/loR+FZNO0XVmjVA/o
 4FXctkrXOgCBssWpOlgK0OhfTrm/O7Msbo4qbzyjcC7dQzp8AxXOA592sBWEY5D4sX32
 WLoQ==
X-Gm-Message-State: AFq9FYJgQ816MzWbmo7EUcc4sYlMviaO1C89H4Mbx/J3ofJB+dHg2nqU
 RFIqPFFrBhbaredlv8DXb7pUhDeXAqsiccy5mEWRkkfS6383tNlGX3xZVz96N7rXc9SvRw9YXZy
 jmjuxW9GICz+weAgQdKO9qSnDW4nzCglOZp2tyHMKHYUl9UlyXP5TS8ASxRjQIP+oc4M7
X-Gm-Gg: AYBFou0s36HCgbQHPCO+M3T+2Lqxw7s+6EXlMcGTlwoH3x/I+MtOI6Gs18lukIWVFMS
 rM99mcOeHyTXgpAWSpT90rC+IHbr8m4RV7qIT2twcrf5qIYREiM+MiFiYwkXEvGq+gGQDv4v6tS
 kNxkrlt9/mJihS9HJK1rL+8VGgEguwpxTqTk2uVH38lQs3slLJKFnz2q2v4Z+UNTUKRp/EascpF
 4k0LfpFeepEusRT0GEMAxtYU5dtElUPO9X365+jqSZdamIxesDg+EPPZmChBcZIlmqqnppt3kVI
 C9M2MLa+1/XBfWcuQeIfzus/bP5mcvXHN3t3/49SohQkKyGdNSUhHZgMPA6z0dWjzACl0+SaIjz
 10T/mz/cVt4gMi3t8VeOrS/D0NdQWscsDMpZ8e4tS4YWmyJQ1DpRUVP/pyWv3Uja+hYeJGWQu94
 bviXNQm/zNYu7Avien8DptmDsia8a6zmPijpMBMH1b2e6/cDH+0GsV5jNKniLhuC1l7eUF3UtGG
 eMDqhBp93qMMhp2DpTswDLWl1PoMyWUfiXzCWWRhcwRirDNdFezJqjfSrmflgGUw+3UvBWn7FWD
 j8DEstgvAPTyh7KWHzJOUxZgM4Aug+wRSDpZbcSIRMe/YUng3e1V0Yj+QGtDQGh8x/hqzZVbsXi
 1bpbzJOoKZF/Zz15PP8f5Vj35Lhajnc+KP/E5jmddp1q3kWYkbKrwa6A+2ZFuUrg=
X-Received: by 2002:a05:600c:b86:b0:4a1:f68a:9736 with SMTP id
 5b1f17b1804b1-4a35acaa66fmr134720215e9.26.1793026639020; 
 Mon, 26 Oct 2026 07:57:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a5822a7sm207103995e9.11.2026.10.26.07.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 07:57:18 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 14:57:08 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727
X-Gerrit-Change-Number: 1786
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1786?usp=email>
X-Gerrit-Commit: 51c1aa36f1972fc8b23a22a936c1909ad8234058
In-Reply-To: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
References: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkk2NGUwODUwZDQ4NjQ3YTJjMGUzZDM4NWMyZjIwYTlmNDQ1OTMxNzI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4eb1cc7f78b863840deb25039d3e2e8e3627abce-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLM8c-000000004OM-0fx3
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
Content-Type: multipart/mixed; boundary="===============2932876708899130578=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2932876708899130578==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IDI9vDI8uZQ="; charset=UTF-8

--IDI9vDI8uZQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli=2E

Hello Arne Schw=
abe, 

I'd like you to reexamine a change=2E Please visit

    https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail

to look at the new patch s=
et (#9)=2E


Change subject: multi: assign IPv6 addresses from a tagged sub=
net-pool
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mult=
i: assign IPv6 addresses from a tagged subnet-pool

Add the IPv6 counterpar=
t of --subnet-pool:

  subnet-pool-ipv6 <tag> <network>/<bits> [<gateway>] =
  (main config)

selected by the same per-client --subnet-pool-tag=2E A cli=
ent's tag is
resolved against the IPv6 pool list too and, when it matches, =
an IPv6
address is handed out from the group's pool alongside any IPv4 one =
(a
single dual-stack ifconfig_pool per tag)=2E The pool gateway is pushed a=
s
the remote end of the client's ifconfig-ipv6, as the server's own
address=
 is off-link for it=2E A tag matching neither family is still
declined with=
 AUTH_FAILED=2E

As for IPv4 the pools are checked when the config is loade=
d (network
between /64 and /124 without host bits, gateway a host address i=
nside
it, unique tags, no overlap with another pool or the --server-ipv6
ne=
twork), created at startup with their gateway reserved, and routed
into the=
 server's tun device=2E

Change-Id: I64e0850d48647a2c0e3d385c2f20a9f4459317=
27
GitHub: closes openvpn/OpenVPN#987
Signed-off-by: Antonio Quartulli <ant=
onio@mandelbit=2Ecom>
---
M doc/man-sections/server-options=2Erst
M src/ope=
nvpn/multi=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M src/op=
envpn/options_util=2Ec
M src/openvpn/options_util=2Eh
M src/openvpn/pool=2E=
c
M src/openvpn/pool=2Eh
M tests/unit_tests/openvpn/test_misc=2Ec
M tests/u=
nit_tests/openvpn/test_subnet_pool=2Ec
M tests/unit_tests/openvpn/test_subn=
et_pool=2Eh
11 files changed, 398 insertions(+), 31 deletions(-)


  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/86/1786/9

diff =
--git a/doc/man-sections/server-options=2Erst b/doc/man-sections/server-opt=
ions=2Erst
index 9434e5d=2E=2E484cd43 100644
--- a/doc/man-sections/server-=
options=2Erst
+++ b/doc/man-sections/server-options=2Erst
@@ -366,11 +366,3=
2 @@
   and FreeBSD the IPv4 route is installed on-link, without a gateway,=
 so its
   ``route_gateway_{n}`` is not set for ``--route-up`` scripts=2E
 =

+--subnet-pool-ipv6 args
+  The IPv6 counterpart of ``--subnet-pool``=2E R=
epeatable main-config directive=2E
+
+  Valid syntax:
+  ::
+
+     subnet-=
pool-ipv6 tag network/bits [gateway]
+
+  ``bits`` must be between 64 and 1=
24; ``gateway`` defaults to the first
+  address of the network, is never a=
ssigned to a client, and is pushed to the
+  pool's clients as the remote e=
nd of their ``ifconfig-ipv6``=2E A tag may name
+  an IPv4 pool, an IPv6 po=
ol, or both; a client referencing it with
+  ``--subnet-pool-tag`` is then =
assigned an address from each family the tag
+  defines=2E
+
+  Requires ``=
--server-ipv6`` with ``--dev tun`` and ``--topology subnet``=2E
+  ``networ=
k`` must have no host bits set, ``gateway`` must be a host address
+  insid=
e it, each ``tag`` may be defined only once and no pool may overlap
+  anot=
her one or the ``--server-ipv6`` network=2E As for ``--subnet-pool``, the
+=
  server routes each pool's network into the tun device=2E
+
 --subnet-pool=
-tag tag
-  Assign this client to the ``--subnet-pool`` named ``tag``=2E Mu=
st be
-  associated with a specific client instance via ``--client-config-d=
ir`` or
-  ``--client-connect``=2E Several clients may reference the same t=
ag and are
-  then served from the same shared pool=2E
+  Assign this clien=
t to the ``--subnet-pool`` / ``--subnet-pool-ipv6`` named
+  ``tag``=2E Mus=
t be associated with a specific client instance via
+  ``--client-config-di=
r`` or ``--client-connect``=2E Several clients may
+  reference the same ta=
g and are then served from the same shared pool(s)=2E
 
 --ifconfig-ipv6-pu=
sh args
   for ``--client-config-dir`` per-client static IPv6 interface
dif=
f --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index e8d51da=2E=2E=
1ec8515 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -=
393,6 +393,10 @@
     {
         multi_get_group_pool(m, &t->options, d->ta=
g);
     }
+    for (const struct subnet_pool6_def *d =3D t->options=2Esubn=
et_pools_ipv6; d; d =3D d->next)
+    {
+        multi_get_group_pool(m, &t=
->options, d->tag);
+    }
 
     /*
      * Help us keep track of routing =
table=2E
@@ -1471,16 +1475,31 @@
     }
 
     const struct subnet_pool_def=
 *d4 =3D subnet_pool_by_tag(o->subnet_pools, tag);
-    ASSERT(d4);
+    co=
nst struct subnet_pool6_def *d6 =3D subnet_pool6_by_tag(o->subnet_pools_ipv=
6, tag);
+    const char *pool_tag =3D d4 ? d4->tag : (d6 ? d6->tag : NULL)=
;
+    ASSERT(pool_tag);
     ALLOC_OBJ_CLEAR(sp, struct subnet_pool);
-   =
 sp->tag =3D d4->tag;
-    /* the configured dynamic range, or else every h=
ost address of the
-     * subnet, minus the gateway reserved below if it f=
alls inside it */
-    const in_addr_t start =3D d4->pool_start ? d4->pool_=
start : d4->network + 1;
-    const in_addr_t end =3D d4->pool_end ? d4->po=
ol_end : (d4->network | ~d4->netmask) - 1;
-    sp->pool =3D ifconfig_pool_=
init(true, IFCONFIG_POOL_INDIV, start, end, o->duplicate_cn, false,
-      =
                            in6addr_any, 0);
-    ifconfig_pool_reserve_ip(=
sp->pool, d4->gateway);
+    sp->tag =3D pool_tag;
+    /* the IPv4 range (=
configured, or else every host address of the subnet)
+     * and every hos=
t address of the IPv6 network, minus the gateways reserved
+     * below (t=
he IPv4 and the IPv6 address of a client share one pool handle) */
+    in_=
addr_t start =3D 0, end =3D 0;
+    if (d4)
+    {
+        start =3D d4->p=
ool_start ? d4->pool_start : d4->network + 1;
+        end =3D d4->pool_end=
 ? d4->pool_end : (d4->network | ~d4->netmask) - 1;
+    }
+    sp->pool =
=3D ifconfig_pool_init(d4 !=3D NULL, IFCONFIG_POOL_INDIV, start, end, o->du=
plicate_cn,
+                                  d6 !=3D NULL, d6 ? add_in6_a=
ddr(d6->network, 1) : in6addr_any,
+                                  d6 ? =
(int)d6->netbits : 0);
+    if (d4)
+    {
+        ifconfig_pool_reserve_i=
p(sp->pool, d4->gateway);
+    }
+    if (d6)
+    {
+        ifconfig_pool=
_reserve_ipv6(sp->pool, &d6->gateway);
+    }
     sp->next =3D m->subnet_p=
ools;
     m->subnet_pools =3D sp;
     return sp->pool;
@@ -1514,6 +1533,1=
9 @@
             mi->context=2Eoptions=2Esubnet_pool_gateway =3D d->gatewa=
y;
         }
     }
+    if (mi->context=2Eoptions=2Esubnet_pool_tag)
+   =
 {
+        const struct subnet_pool6_def *d =3D subnet_pool6_by_tag(
+    =
        m->top=2Eoptions=2Esubnet_pools_ipv6, mi->context=2Eoptions=2Esubne=
t_pool_tag);
+
+        mi->context=2Eoptions=2Esubnet_pool_ipv6_defined =
=3D d !=3D NULL;
+        if (d)
+        {
+            mi->context=2Eopti=
ons=2Esubnet_pool_ipv6_network =3D d->network;
+            mi->context=2Eo=
ptions=2Esubnet_pool_ipv6_netbits =3D d->netbits;
+            mi->context=
=2Eoptions=2Esubnet_pool_ipv6_gateway =3D d->gateway;
+        }
+    }
 
 =
    /*
      * If ifconfig addresses were set by dynamic config file,
@@ -1=
548,15 +1580,16 @@
                 "MULTI_sva: WARNING: if --ifconfig-push=
 is used for IPv4, automatic IPv6 assignment from --ifconfig-ipv6-pool does=
 not work=2E  Use --ifconfig-ipv6-push for IPv6 then=2E");
         }
     =
}
-    else if (mi->context=2Eoptions=2Esubnet_pool_defined)
+    else if (=
mi->context=2Eoptions=2Esubnet_pool_defined
+             || mi->context=2E=
options=2Esubnet_pool_ipv6_defined)
     {
-        /* dynamic address from=
 this client's --subnet-pool group */
+        /* dynamic address(es) from =
this client's --subnet-pool group */
         struct ifconfig_pool *group =
=3D
             multi_get_group_pool(m, &m->top=2Eoptions, mi->context=2Eo=
ptions=2Esubnet_pool_tag);
 
         /* the address may have been acquired=
 before the tag was known (from
          * the global pool) or for a tag t=
hat a later handler overrode: drop
-         * it so we serve this client f=
rom its current group */
+         * it so we serve this client from its cu=
rrent group only */
         if (mi->vaddr_handle >=3D 0 && mi->vaddr_pool =
!=3D group)
         {
             ifconfig_pool_release(mi->vaddr_pool ? =
mi->vaddr_pool : m->ifconfig_pool,
@@ -1571,27 +1604,44 @@
         if (mi-=
>vaddr_handle < 0)
         {
             in_addr_t local =3D 0, remote =
=3D 0;
+            struct in6_addr remote_ipv6;
             const char *c=
n =3D NULL;
 
+            CLEAR(remote_ipv6);
             if (!mi->contex=
t=2Eoptions=2Eduplicate_cn)
             {
                 cn =3D tls_comm=
on_name(mi->context=2Ec2=2Etls_multi, true);
             }
 
             =
mi->vaddr_pool =3D group;
-            mi->vaddr_handle =3D ifconfig_pool_a=
cquire(mi->vaddr_pool, &local, &remote, NULL, cn);
-            if (mi->vad=
dr_handle >=3D 0)
-            {
-                mi->context=2Ec2=2Epush_i=
fconfig_local =3D remote;
-                mi->context=2Ec2=2Epush_ifconfig=
_remote_netmask =3D
-                    mi->context=2Eoptions=2Esubnet_poo=
l_netmask;
-                mi->context=2Ec2=2Epush_ifconfig_defined =3D tr=
ue;
-            }
-            else
+            mi->vaddr_handle =3D
+   =
             ifconfig_pool_acquire(mi->vaddr_pool, &local, &remote, &remote=
_ipv6, cn);
+            if (mi->vaddr_handle < 0)
             {
         =
        msg(D_MULTI_ERRORS, "MULTI: no free --subnet-pool addresses are ava=
ilable for %s",
                     multi_instance_string(mi, false, &gc))=
;
             }
+            else
+            {
+                if (mi->=
context=2Eoptions=2Esubnet_pool_defined)
+                {
+              =
      mi->context=2Ec2=2Epush_ifconfig_local =3D remote;
+                 =
   mi->context=2Ec2=2Epush_ifconfig_remote_netmask =3D
+                   =
     mi->context=2Eoptions=2Esubnet_pool_netmask;
+                    mi->=
context=2Ec2=2Epush_ifconfig_defined =3D true;
+                }
+        =
        if (mi->context=2Eoptions=2Esubnet_pool_ipv6_defined)
+            =
    {
+                    /* the server's own address is off-link for this=
 client:
+                     * hand out the pool gateway as the remote en=
d instead */
+                    mi->context=2Ec2=2Epush_ifconfig_ipv6_loc=
al =3D remote_ipv6;
+                    mi->context=2Ec2=2Epush_ifconfig_i=
pv6_remote =3D
+                        mi->context=2Eoptions=2Esubnet_pool=
_ipv6_gateway;
+                    mi->context=2Ec2=2Epush_ifconfig_ipv6_n=
etbits =3D
+                        mi->context=2Eoptions=2Esubnet_pool_ipv=
6_netbits;
+                    mi->context=2Ec2=2Epush_ifconfig_ipv6_defin=
ed =3D true;
+                }
+            }
         }
     }
     else =
if (m->ifconfig_pool && mi->vaddr_handle < 0) /* otherwise, choose a pool a=
ddress */
@@ -2932,7 +2982,9 @@
     }
 
     if (mi->context=2Eoptions=2Es=
ubnet_pool_tag
-        && !subnet_pool_by_tag(m->top=2Eoptions=2Esubnet_po=
ols, mi->context=2Eoptions=2Esubnet_pool_tag))
+        && !subnet_pool_by_=
tag(m->top=2Eoptions=2Esubnet_pools, mi->context=2Eoptions=2Esubnet_pool_ta=
g)
+        && !subnet_pool6_by_tag(m->top=2Eoptions=2Esubnet_pools_ipv6,
+=
                                mi->context=2Eoptions=2Esubnet_pool_tag))
 =
    {
         msg(D_MULTI_ERRORS, "MULTI: client has been rejected due to =
unknown --subnet-pool-tag '%s'",
             mi->context=2Eoptions=2Esubne=
t_pool_tag);
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec=

index eb0bcfd=2E=2Edff301a 100644
--- a/src/openvpn/options=2Ec
+++ b/src/=
openvpn/options=2Ec
@@ -457,6 +457,8 @@
     "                  pool of add=
resses outside the --server network, selected\n"
     "                  pe=
r client with --subnet-pool-tag=2E start/end restrict the\n"
     "        =
          dynamically assigned range=2E\n"
+    "--subnet-pool-ipv6 tag net=
work/bits [gateway] : IPv6 counterpart of\n"
+    "                  --subn=
et-pool=2E\n"
     "--subnet-pool-tag tag : Assign this client to the --sub=
net-pool named tag=2E\n"
     "                  Only valid in a client-spe=
cific config file=2E\n"
     "--ifconfig-push local remote-netmask : Push a=
n ifconfig option to remote,\n"
@@ -1919,6 +1921,20 @@
             subnet_=
pools_check(options->subnet_pools, options->server_network,
               =
                 options->server_netmask, M_USAGE);
         }
+        if =
(options->subnet_pools_ipv6)
+        {
+            if (!options->server_i=
pv6_defined)
+            {
+                msg(M_USAGE, "--subnet-pool-ip=
v6 requires --server-ipv6");
+            }
+            if (dev_type_enum(=
options->dev, options->dev_type) !=3D DEV_TYPE_TUN
+                || opti=
ons->topology !=3D TOP_SUBNET)
+            {
+                msg(M_USAGE,=
 "--subnet-pool-ipv6 requires --dev tun and --topology subnet");
+         =
   }
+            subnet_pools6_check(options->subnet_pools_ipv6, &options-=
>server_network_ipv6,
+                                options->server_netb=
its_ipv6, M_USAGE);
+        }
         MUST_BE_UNDEF(allow_recursive_routi=
ng, "allow-recursive-routing");
         if (options->auth_user_pass_file)
=
         {
@@ -1986,6 +2002,7 @@
         MUST_BE_UNDEF(ifconfig_pool_persi=
st_filename, "ifconfig-pool-persist");
         MUST_BE_UNDEF(ifconfig_ipv6=
_pool_defined, "ifconfig-ipv6-pool");
         MUST_BE_UNDEF(subnet_pools, =
"subnet-pool");
+        MUST_BE_UNDEF(subnet_pools_ipv6, "subnet-pool-ipv6=
");
         MUST_BE_UNDEF(real_hash_size, "hash-size");
         MUST_BE_U=
NDEF(virtual_hash_size, "hash-size");
         MUST_BE_UNDEF(learn_address_=
script, "learn-address");
@@ -3119,8 +3136,9 @@
 }
 
 /*
- * The server's t=
un device is only configured with the --server network, so
- * route each -=
-subnet-pool network into it as well: without this the server
+ * The serve=
r's tun device is only configured with the --server and
+ * --server-ipv6 n=
etworks, so route each --subnet-pool and --subnet-pool-ipv6
+ * network int=
o it as well: without this the server
  * could not reach its subnet-pool c=
lients when the data channel runs in
  * userspace=2E  Under DCO on Linux a=
nd FreeBSD the routes are installed on-link,
  * see subnet_pool_routes_onl=
ink()=2E
@@ -3138,6 +3156,16 @@
                                       o->r=
oute_default_table_id);
         ro->on_link =3D subnet_pool_routes_onlink(=
o);
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
@@ -6314,6 +6342,37 @@
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
 /64 and /124 (not /%u)",
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
index 568bae6=2E=2Ef3bbde9 100644
--- a/src/=
openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -267,6 +267,16 @@
    =
 in_addr_t pool_end;
 };
 
+/* The IPv6 counterpart of struct subnet_pool_d=
ef (--subnet-pool-ipv6)=2E */
+struct subnet_pool6_def
+{
+    struct subne=
t_pool6_def *next;
+    const char *tag;
+    struct in6_addr network;
+   =
 unsigned int netbits;
+    struct in6_addr gateway;
+};
+
 /* Command line=
 options */
 struct options
 {
@@ -533,12 +543,17 @@
     bool push_ifconfi=
g_constraint_defined;
     in_addr_t push_ifconfig_constraint_network;
    =
 in_addr_t push_ifconfig_constraint_netmask;
-    struct subnet_pool_def *s=
ubnet_pools; /* named pools (server config) */
-    const char *subnet_pool=
_tag;          /* which pool this client uses (CCD) */
-    bool subnet_poo=
l_defined;             /* resolved from the tag at connect */
+    struct s=
ubnet_pool_def *subnet_pools;       /* named IPv4 pools (server config) */
=
+    struct subnet_pool6_def *subnet_pools_ipv6; /* named IPv6 pools (serve=
r config) */
+    const char *subnet_pool_tag;                /* which pool=
 this client uses (CCD) */
+    bool subnet_pool_defined;                  =
 /* resolved from the tag at connect */
     in_addr_t subnet_pool_network;=

     in_addr_t subnet_pool_netmask;
     in_addr_t subnet_pool_gateway;
+ =
   bool subnet_pool_ipv6_defined; /* resolved from the tag at connect */
+ =
   struct in6_addr subnet_pool_ipv6_network;
+    unsigned int subnet_pool_=
ipv6_netbits;
+    struct in6_addr subnet_pool_ipv6_gateway;
     bool push=
_ifconfig_ipv4_blocked;           /* IPv4 */
     bool push_ifconfig_ipv6_d=
efined;           /* IPv6 */
     struct in6_addr push_ifconfig_ipv6_local;=
  /* IPv6 */
diff --git a/src/openvpn/options_util=2Ec b/src/openvpn/option=
s_util=2Ec
index 862bf7c=2E=2Ee853682 100644
--- a/src/openvpn/options_util=
=2Ec
+++ b/src/openvpn/options_util=2Ec
@@ -130,6 +130,108 @@
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
index f1e63e15=2E=2E=
6ddded3 100644
--- a/src/openvpn/options_util=2Eh
+++ b/src/openvpn/options=
_util=2Eh
@@ -55,6 +55,25 @@
 bool subnet_pools_check(const struct subnet_p=
ool_def *pools, in_addr_t server_network,
                         in_addr_=
t server_netmask, msglvl_t msglevel);
 
+/**
+ * IPv6 counterpart of subnet=
_pools_check(): network between /64 and /124
+ * without host bits, gateway=
 a host address inside it, unique tags, and no
+ * network overlapping anot=
her pool or the --server-ipv6 network=2E
+ *
+ * @param pools           hea=
d of the --subnet-pool-ipv6 list (may be NULL)
+ * @param server_network  t=
he --server-ipv6 network
+ * @param server_netbits  the --server-ipv6 prefi=
x length, or 0 if there is none
+ * @param msglevel        level of the mes=
sage logged on the first error
+ * @return                true if every def=
inition is valid
+ */
+bool subnet_pools6_check(const struct subnet_pool6_d=
ef *pools,
+                         const struct in6_addr *server_network,=
 unsigned int server_netbits,
+                         msglvl_t msglevel);=

+
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
diff --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=
=2Ec
index 5c5b3fe=2E=2E2cdaa71 100644
--- a/src/openvpn/pool=2Ec
+++ b/src=
/openvpn/pool=2Ec
@@ -446,6 +446,22 @@
     return true;
 }
 
+bool
+ifconf=
ig_pool_reserve_ipv6(struct ifconfig_pool *pool, const struct in6_addr *add=
r)
+{
+    const ifconfig_pool_handle h =3D ifconfig_pool_ipv6_base_to_hand=
le(pool, addr);
+
+    if (h < 0)
+    {
+        return false;
+    }
+
+ =
   ifconfig_pool_entry_free(&pool->list[h], true);
+    pool->list[h]=2Ein_=
use =3D true;
+    pool->list[h]=2Ereserved =3D true;
+    return true;
+}
=
+
 static in_addr_t
 ifconfig_pool_handle_to_ip_base(const struct ifconfig_=
pool *pool, ifconfig_pool_handle hand)
 {
diff --git a/src/openvpn/pool=2Eh=
 b/src/openvpn/pool=2Eh
index 497dcda=2E=2Efda87ed 100644
--- a/src/openvpn=
/pool=2Eh
+++ b/src/openvpn/pool=2Eh
@@ -98,6 +98,9 @@
  */
 bool ifconfig_=
pool_reserve_ip(struct ifconfig_pool *pool, in_addr_t addr);
 
+/** IPv6 co=
unterpart of ifconfig_pool_reserve_ip()=2E */
+bool ifconfig_pool_reserve_i=
pv6(struct ifconfig_pool *pool, const struct in6_addr *addr);
+
 struct ifc=
onfig_pool_persist *ifconfig_pool_persist_init(const char *filename, int re=
fresh_freq);
 
 void ifconfig_pool_persist_close(struct ifconfig_pool_persi=
st *persist);
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/u=
nit_tests/openvpn/test_misc=2Ec
index 06fd9aa=2E=2Ed46c230 100644
--- a/tes=
ts/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_mis=
c=2Ec
@@ -568,6 +568,8 @@
     cmocka_unit_test(test_subnet_pools_check_gat=
eway),
     cmocka_unit_test(test_subnet_pools_check_range),
     cmocka_un=
it_test(test_subnet_pools_check_overlap),
+    cmocka_unit_test(test_subnet=
_pool6_by_tag),
+    cmocka_unit_test(test_subnet_pools6_check),
 };
 
 int=

diff --git a/tests/unit_tests/openvpn/test_subnet_pool=2Ec b/tests/unit_te=
sts/openvpn/test_subnet_pool=2Ec
index 10c0bc5=2E=2E2d08684 100644
--- a/te=
sts/unit_tests/openvpn/test_subnet_pool=2Ec
+++ b/tests/unit_tests/openvpn/=
test_subnet_pool=2Ec
@@ -158,3 +158,77 @@
     struct subnet_pool_def adup =
=3D { =2Enext =3D &bdup, =2Etag =3D "grpA", =2Enetwork =3D 0x0a090000, =2En=
etmask =3D 0xffffff00, =2Egateway =3D 0x0a090001 };
     assert_false(subne=
t_pools_check(&adup, 0, 0, M_WARN));
 }
+
+/* the IPv6 counterpart resolves=
 independently: a tag may name a v4 pool, a
+ * v6 pool, or both=2E */
+voi=
d
+test_subnet_pool6_by_tag(void **state)
+{
+    struct subnet_pool6_def c=
 =3D { =2Enext =3D NULL, =2Etag =3D "grpC", =2Enetbits =3D 64 };
+    struc=
t subnet_pool6_def b =3D { =2Enext =3D &c, =2Etag =3D "grpB", =2Enetbits =
=3D 96 };
+    struct subnet_pool6_def a =3D { =2Enext =3D &b, =2Etag =3D "=
grpA", =2Enetbits =3D 64 };
+
+    assert_ptr_equal(subnet_pool6_by_tag(&a,=
 "grpA"), &a);
+    assert_ptr_equal(subnet_pool6_by_tag(&a, "grpB"), &b);
=
+    assert_ptr_equal(subnet_pool6_by_tag(&a, "grpC"), &c);
+    assert_int=
_equal(subnet_pool6_by_tag(&a, "grpB")->netbits, 96);
+    assert_null(subn=
et_pool6_by_tag(&a, "nope"));
+    assert_null(subnet_pool6_by_tag(NULL, "g=
rpA"));
+}
+
+/* <prefix>::<host> as an in6_addr */
+static struct in6_addr=

+in6(const char *addr)
+{
+    struct in6_addr a;
+
+    assert_int_equal(=
inet_pton(AF_INET6, addr, &a), 1);
+    return a;
+}
+
+/* a single IPv6 po=
ol, checked against the fd00:8::/64 --server-ipv6 network */
+static bool
+=
check6_one(const char *net, unsigned int bits, const char *gw)
+{
+    cons=
t struct in6_addr server =3D in6("fd00:8::");
+    struct subnet_pool6_def =
d =3D { =2Enext =3D NULL, =2Etag =3D "grp", =2Enetwork =3D in6(net), =2Enet=
bits =3D bits, =2Egateway =3D in6(gw) };
+
+    return subnet_pools6_check(=
&d, &server, 64, M_WARN);
+}
+
+void
+test_subnet_pools6_check(void **state=
)
+{
+    /* /64 =2E=2E /124, any host address of the network as gateway */=

+    assert_true(check6_one("fd00:9::", 64, "fd00:9::1"));
+    assert_tru=
e(check6_one("fd00:9::", 124, "fd00:9::1"));
+    assert_true(check6_one("f=
d00:9::", 112, "fd00:9::ffff"));
+    assert_false(check6_one("fd00:9::", 6=
3, "fd00:9::1"));
+    assert_false(check6_one("fd00:9::", 125, "fd00:9::1"=
));
+
+    /* host bits in the network, gateway =3D network or outside it *=
/
+    assert_false(check6_one("fd00:9::5", 64, "fd00:9::1"));
+    assert_=
false(check6_one("fd00:9::", 64, "fd00:9::"));
+    assert_false(check6_one=
("fd00:9::", 64, "fd00:a::1"));
+
+    /* overlapping the --server-ipv6 net=
work, inside or covering it */
+    assert_false(check6_one("fd00:8::", 96,=
 "fd00:8::1"));
+
+    /* two pools: disjoint, overlapping, same tag */
+  =
  const struct in6_addr server =3D in6("fd00:8::");
+    struct subnet_pool=
6_def b =3D { =2Enext =3D NULL, =2Etag =3D "grpB", =2Enetwork =3D in6("fd00=
:a::"), =2Enetbits =3D 64, =2Egateway =3D in6("fd00:a::1") };
+    struct s=
ubnet_pool6_def a =3D { =2Enext =3D &b, =2Etag =3D "grpA", =2Enetwork =3D i=
n6("fd00:9::"), =2Enetbits =3D 64, =2Egateway =3D in6("fd00:9::1") };
+
+  =
  assert_true(subnet_pools6_check(&a, &server, 64, M_WARN));
+    assert_tr=
ue(subnet_pools6_check(&a, &server, 0, M_WARN));
+
+    /* a /120 grpB insi=
de grpA */
+    struct subnet_pool6_def bin =3D { =2Enext =3D NULL, =2Etag =
=3D "grpB", =2Enetwork =3D in6("fd00:9::100"), =2Enetbits =3D 120, =2Egatew=
ay =3D in6("fd00:9::101") };
+    struct subnet_pool6_def ain =3D { =2Enext=
 =3D &bin, =2Etag =3D "grpA", =2Enetwork =3D in6("fd00:9::"), =2Enetbits =
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
diff --git a/tests/unit_tests/openvpn/test_subnet_po=
ol=2Eh b/tests/unit_tests/openvpn/test_subnet_pool=2Eh
index 2a1f882=2E=2E4=
d57380 100644
--- a/tests/unit_tests/openvpn/test_subnet_pool=2Eh
+++ b/tes=
ts/unit_tests/openvpn/test_subnet_pool=2Eh
@@ -34,4 +34,8 @@
 
 void test_s=
ubnet_pools_check_overlap(void **state);
 
+void test_subnet_pool6_by_tag(v=
oid **state);
+
+void test_subnet_pools6_check(void **state);
+
 #endif

--=
 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I64e0850d48647a2c0=
e3d385c2f20a9f445931727
Gerrit-Change-Number: 1786
Gerrit-PatchSet: 9
Gerri=
t-Owner: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@m=
andelbit=2Ecom>

--IDI9vDI8uZQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli=2E </p>
<p>Antonio Quartulli <stron=
g>uploaded patch set #9</strong> to this change=2E</p><p><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail">View Change</a></p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">multi: assign IPv6 addresses from a tagged subnet-pool<br><br>A=
dd the IPv6 counterpart of --subnet-pool:<br><br>  subnet-pool-ipv6 &lt;tag=
&gt; &lt;network&gt;/&lt;bits&gt; [&lt;gateway&gt;]   (main config)<br><br>=
selected by the same per-client --subnet-pool-tag=2E A client&#39;s tag is<=
br>resolved against the IPv6 pool list too and, when it matches, an IPv6<br=
>address is handed out from the group&#39;s pool alongside any IPv4 one (a<=
br>single dual-stack ifconfig_pool per tag)=2E The pool gateway is pushed a=
s<br>the remote end of the client&#39;s ifconfig-ipv6, as the server&#39;s =
own<br>address is off-link for it=2E A tag matching neither family is still=
<br>declined with AUTH_FAILED=2E<br><br>As for IPv4 the pools are checked w=
hen the config is loaded (network<br>between /64 and /124 without host bits=
, gateway a host address inside<br>it, unique tags, no overlap with another=
 pool or the --server-ipv6<br>network), created at startup with their gatew=
ay reserved, and routed<br>into the server&#39;s tun device=2E<br><br>Chang=
e-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727<br>GitHub: closes openvpn/O=
penVPN#987<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&=
gt;<br>---<br>M doc/man-sections/server-options=2Erst<br>M src/openvpn/mult=
i=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/op=
envpn/options_util=2Ec<br>M src/openvpn/options_util=2Eh<br>M src/openvpn/p=
ool=2Ec<br>M src/openvpn/pool=2Eh<br>M tests/unit_tests/openvpn/test_misc=
=2Ec<br>M tests/unit_tests/openvpn/test_subnet_pool=2Ec<br>M tests/unit_tes=
ts/openvpn/test_subnet_pool=2Eh<br>11 files changed, 398 insertions(+), 31 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/86/1786/9</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sectio=
ns/server-options=2Erst b/doc/man-sections/server-options=2Erst</span><br><=
span>index 9434e5d=2E=2E484cd43 100644</span><br><span>--- a/doc/man-sectio=
ns/server-options=2Erst</span><br><span>+++ b/doc/man-sections/server-optio=
ns=2Erst</span><br><span>@@ -366,11 +366,32 @@</span><br><span>   and FreeB=
SD the IPv4 route is installed on-link, without a gateway, so its</span><br=
><span>   ``route_gateway_{n}`` is not set for ``--route-up`` scripts=2E</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--su=
bnet-pool-ipv6 args</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  The IPv6 counterpart of ``--subnet-pool``=2E Repeatable main-config direc=
tive=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  Valid syntax:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  ::</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     subnet-pool-ipv6 tag network/bits [gateway]</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  ``bits`` must be between 64 and 124; ``gateway`` defaults=
 to the first</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  addr=
ess of the network, is never assigned to a client, and is pushed to the</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  pool&#39;s clients as=
 the remote end of their ``ifconfig-ipv6``=2E A tag may name</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  an IPv4 pool, an IPv6 pool, or b=
oth; a client referencing it with</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  ``--subnet-pool-tag`` is then assigned an address from each=
 family the tag</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  de=
fines=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  Requires ``--server-ipv6`` w=
ith ``--dev tun`` and ``--topology subnet``=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  ``network`` must have no host bits set, ``gate=
way`` must be a host address</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  inside it, each ``tag`` may be defined only once and no pool may=
 overlap</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  another o=
ne or the ``--server-ipv6`` network=2E As for ``--subnet-pool``, the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  server routes each pool&=
#39;s network into the tun device=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> --subnet-pool-tag tag</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  Assign this client to the ``--subnet-p=
ool`` named ``tag``=2E Must be</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  associated with a specific client instance via ``--client-config=
-dir`` or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``--client=
-connect``=2E Several clients may reference the same tag and are</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  then served from the same shar=
ed pool=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Assign =
this client to the ``--subnet-pool`` / ``--subnet-pool-ipv6`` named</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  ``tag``=2E Must be associ=
ated with a specific client instance via</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  ``--client-config-dir`` or ``--client-connect``=2E S=
everal clients may</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 reference the same tag and are then served from the same shared pool(s)=2E=
</span><br><span> </span><br><span> --ifconfig-ipv6-push args</span><br><sp=
an>   for ``--client-config-dir`` per-client static IPv6 interface</span><b=
r><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><b=
r><span>index e8d51da=2E=2E1ec8515 100644</span><br><span>--- a/src/openvpn=
/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -=
393,6 +393,10 @@</span><br><span>     {</span><br><span>         multi_get_=
group_pool(m, &amp;t-&gt;options, d-&gt;tag);</span><br><span>     }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for (const struct subn=
et_pool6_def *d =3D t-&gt;options=2Esubnet_pools_ipv6; d; d =3D d-&gt;next)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        multi_get_group_pool(m, &=
amp;t-&gt;options, d-&gt;tag);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span> </span><br><span>     /*</span><br><span>=
      * Help us keep track of routing table=2E</span><br><span>@@ -1471,16 =
+1475,31 @@</span><br><span>     }</span><br><span> </span><br><span>     c=
onst struct subnet_pool_def *d4 =3D subnet_pool_by_tag(o-&gt;subnet_pools, =
tag);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(d4);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct sub=
net_pool6_def *d6 =3D subnet_pool6_by_tag(o-&gt;subnet_pools_ipv6, tag);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *pool_t=
ag =3D d4 ? d4-&gt;tag : (d6 ? d6-&gt;tag : NULL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ASSERT(pool_tag);</span><br><span>     A=
LLOC_OBJ_CLEAR(sp, struct subnet_pool);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    sp-&gt;tag =3D d4-&gt;tag;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    /* the configured dynamic range, or else eve=
ry host address of the</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-     * subnet, minus the gateway reserved below if it falls inside it */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const in_addr_t sta=
rt =3D d4-&gt;pool_start ? d4-&gt;pool_start : d4-&gt;network + 1;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    const in_addr_t end =3D d4=
-&gt;pool_end ? d4-&gt;pool_end : (d4-&gt;network | ~d4-&gt;netmask) - 1;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sp-&gt;pool =3D ifc=
onfig_pool_init(true, IFCONFIG_POOL_INDIV, start, end, o-&gt;duplicate_cn, =
false,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
                   in6addr_any, 0);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    ifconfig_pool_reserve_ip(sp-&gt;pool, d4-&gt;gateway);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;tag =3D poo=
l_tag;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the IP=
v4 range (configured, or else every host address of the subnet)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * and every host address o=
f the IPv6 network, minus the gateways reserved</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * below (the IPv4 and the IPv6 address of =
a client share one pool handle) */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    in_addr_t start =3D 0, end =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (d4)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        start =3D d4-&gt;pool_start ? d4-&gt;pool_start : d4-&g=
t;network + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   end =3D d4-&gt;pool_end ? d4-&gt;pool_end : (d4-&gt;network | ~d4-&gt;ne=
tmask) - 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;pool =3D if=
config_pool_init(d4 !=3D NULL, IFCONFIG_POOL_INDIV, start, end, o-&gt;dupli=
cate_cn,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                       d6 !=3D NULL, d6 ? add_in6_addr(d6-&gt;network, 1) :=
 in6addr_any,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                            d6 ? (int)d6-&gt;netbits : 0);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (d4)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        ifconfig_pool_reserve_ip(sp-&gt;pool, d4-&gt;gatew=
ay);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (d6)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        ifconfig_pool_reserve_ipv6(sp-&gt;pool, &am=
p;d6-&gt;gateway);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span>     sp-&gt;next =3D m-&gt;subnet_pools;</span><br><sp=
an>     m-&gt;subnet_pools =3D sp;</span><br><span>     return sp-&gt;pool;=
</span><br><span>@@ -1514,6 +1533,19 @@</span><br><span>             mi-&gt=
;context=2Eoptions=2Esubnet_pool_gateway =3D d-&gt;gateway;</span><br><span=
>         }</span><br><span>     }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (mi-&gt;context=2Eoptions=2Esubnet_pool_tag)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const struct subnet_pool6_def *d =
=3D subnet_pool6_by_tag(</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            m-&gt;top=2Eoptions=2Esubnet_pools_ipv6, mi-&gt;context=2E=
options=2Esubnet_pool_tag);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-=
&gt;context=2Eoptions=2Esubnet_pool_ipv6_defined =3D d !=3D NULL;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (d)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            mi-&gt;context=2Eoptions=2Esubne=
t_pool_ipv6_network =3D d-&gt;network;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_=
netbits =3D d-&gt;netbits;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_gateway =3D =
d-&gt;gateway;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span> </span><br><span>     /*</span><br><span>      * If ifconfig addres=
ses were set by dynamic config file,</span><br><span>@@ -1548,15 +1580,16 @=
@</span><br><span>                 &quot;MULTI_sva: WARNING: if --ifconfig-=
push is used for IPv4, automatic IPv6 assignment from --ifconfig-ipv6-pool =
does not work=2E  Use --ifconfig-ipv6-push for IPv6 then=2E&quot;);</span><=
br><span>         }</span><br><span>     }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    else if (mi-&gt;context=2Eoptions=2Esubnet_pool_de=
fined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (=
mi-&gt;context=2Eoptions=2Esubnet_pool_defined</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+             || mi-&gt;context=2Eoptions=2Esubne=
t_pool_ipv6_defined)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        /* dynamic address from this client&#39;s --s=
ubnet-pool group */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        /* dynamic address(es) from this client&#39;s --subnet-pool group *=
/</span><br><span>         struct ifconfig_pool *group =3D</span><br><span>=
             multi_get_group_pool(m, &amp;m-&gt;top=2Eoptions, mi-&gt;conte=
xt=2Eoptions=2Esubnet_pool_tag);</span><br><span> </span><br><span>        =
 /* the address may have been acquired before the tag was known (from</span=
><br><span>          * the global pool) or for a tag that a later handler o=
verrode: drop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
 * it so we serve this client from its current group */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         * it so we serve this client f=
rom its current group only */</span><br><span>         if (mi-&gt;vaddr_han=
dle &gt;=3D 0 &amp;&amp; mi-&gt;vaddr_pool !=3D group)</span><br><span>    =
     {</span><br><span>             ifconfig_pool_release(mi-&gt;vaddr_pool=
 ? mi-&gt;vaddr_pool : m-&gt;ifconfig_pool,</span><br><span>@@ -1571,27 +16=
04,44 @@</span><br><span>         if (mi-&gt;vaddr_handle &lt; 0)</span><br=
><span>         {</span><br><span>             in_addr_t local =3D 0, remot=
e =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 struct in6_addr remote_ipv6;</span><br><span>             const char *cn =
=3D NULL;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            CLEAR(remote_ipv6);</span><br><span>             if (!m=
i-&gt;context=2Eoptions=2Eduplicate_cn)</span><br><span>             {</spa=
n><br><span>                 cn =3D tls_common_name(mi-&gt;context=2Ec2=2Et=
ls_multi, true);</span><br><span>             }</span><br><span> </span><br=
><span>             mi-&gt;vaddr_pool =3D group;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            mi-&gt;vaddr_handle =3D ifconfig_poo=
l_acquire(mi-&gt;vaddr_pool, &amp;local, &amp;remote, NULL, cn);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            if (mi-&gt;vaddr_han=
dle &gt;=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 mi-&gt;context=2Ec2=2Epush_ifconfig_local =3D remote;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                mi-&gt;context=2Ec2=2Epush=
_ifconfig_remote_netmask =3D</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    mi-&gt;context=2Eoptions=2Esubnet_pool_netmask;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                mi-&gt=
;context=2Ec2=2Epush_ifconfig_defined =3D true;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            else</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            mi-&gt;vaddr_handle =3D</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                ifconfig_pool_acquire(mi-&gt=
;vaddr_pool, &amp;local, &amp;remote, &amp;remote_ipv6, cn);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            if (mi-&gt;vaddr_handl=
e &lt; 0)</span><br><span>             {</span><br><span>                 m=
sg(D_MULTI_ERRORS, &quot;MULTI: no free --subnet-pool addresses are availab=
le for %s&quot;,</span><br><span>                     multi_instance_string=
(mi, false, &amp;gc));</span><br><span>             }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                if (mi-&gt;context=2Eoptions=2Esub=
net_pool_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                mi-&gt;context=2Ec2=2Epush_ifconfig_local =3D remote;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    mi-&g=
t;context=2Ec2=2Epush_ifconfig_remote_netmask =3D</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        mi-&gt;context=2Eopti=
ons=2Esubnet_pool_netmask;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    mi-&gt;context=2Ec2=2Epush_ifconfig_defined =3D =
true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
if (mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_defined)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    /* the server&#39;s =
own address is off-link for this client:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                     * hand out the pool gateway as th=
e remote end instead */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local =3D =
remote_ipv6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_remote =3D</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                        mi-&gt=
;context=2Eoptions=2Esubnet_pool_ipv6_gateway;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    mi-&gt;context=2Ec2=2Epush_i=
fconfig_ipv6_netbits =3D</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                        mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_ne=
tbits;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_defined =3D true;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span> =
        }</span><br><span>     }</span><br><span>     else if (m-&gt;ifconf=
ig_pool &amp;&amp; mi-&gt;vaddr_handle &lt; 0) /* otherwise, choose a pool =
address */</span><br><span>@@ -2932,7 +2982,9 @@</span><br><span>     }</sp=
an><br><span> </span><br><span>     if (mi-&gt;context=2Eoptions=2Esubnet_p=
ool_tag</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&=
amp; !subnet_pool_by_tag(m-&gt;top=2Eoptions=2Esubnet_pools, mi-&gt;context=
=2Eoptions=2Esubnet_pool_tag))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        &amp;&amp; !subnet_pool_by_tag(m-&gt;top=2Eoptions=2Esub=
net_pools, mi-&gt;context=2Eoptions=2Esubnet_pool_tag)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !subnet_pool6_by_tag(=
m-&gt;top=2Eoptions=2Esubnet_pools_ipv6,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                mi-&gt;context=2Eoptio=
ns=2Esubnet_pool_tag))</span><br><span>     {</span><br><span>         msg(=
D_MULTI_ERRORS, &quot;MULTI: client has been rejected due to unknown --subn=
et-pool-tag &#39;%s&#39;&quot;,</span><br><span>             mi-&gt;context=
=2Eoptions=2Esubnet_pool_tag);</span><br><span>diff --git a/src/openvpn/opt=
ions=2Ec b/src/openvpn/options=2Ec</span><br><span>index eb0bcfd=2E=2Edff30=
1a 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++=
 b/src/openvpn/options=2Ec</span><br><span>@@ -457,6 +457,8 @@</span><br><s=
pan>     &quot;                  pool of addresses outside the --server net=
work, selected\n&quot;</span><br><span>     &quot;                  per cli=
ent with --subnet-pool-tag=2E start/end restrict the\n&quot;</span><br><spa=
n>     &quot;                  dynamically assigned range=2E\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--subnet-pool-ip=
v6 tag network/bits [gateway] : IPv6 counterpart of\n&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    &quot;                  --subne=
t-pool=2E\n&quot;</span><br><span>     &quot;--subnet-pool-tag tag : Assign=
 this client to the --subnet-pool named tag=2E\n&quot;</span><br><span>    =
 &quot;                  Only valid in a client-specific config file=2E\n&q=
uot;</span><br><span>     &quot;--ifconfig-push local remote-netmask : Push=
 an ifconfig option to remote,\n&quot;</span><br><span>@@ -1919,6 +1921,20 =
@@</span><br><span>             subnet_pools_check(options-&gt;subnet_pools=
, options-&gt;server_network,</span><br><span>                             =
   options-&gt;server_netmask, M_USAGE);</span><br><span>         }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt;sub=
net_pools_ipv6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if=
 (!options-&gt;server_ipv6_defined)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                msg(M_USAGE, &quot;--subnet-pool-ipv6 requires --=
server-ipv6&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      if (dev_type_enum(options-&gt;dev, options-&gt;dev_type) !=3D DEV_TYP=
E_TUN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  || options-&gt;topology !=3D TOP_SUBNET)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                msg(M_USAGE, &quot;--subnet-pool-ipv6 requ=
ires --dev tun and --topology subnet&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            subnet_pools6_check(options-&gt;subnet_pools=
_ipv6, &amp;options-&gt;server_network_ipv6,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                options-&gt;server=
_netbits_ipv6, M_USAGE);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span>         MUST_BE_UNDEF(allow_recursive_routi=
ng, &quot;allow-recursive-routing&quot;);</span><br><span>         if (opti=
ons-&gt;auth_user_pass_file)</span><br><span>         {</span><br><span>@@ =
-1986,6 +2002,7 @@</span><br><span>         MUST_BE_UNDEF(ifconfig_pool_per=
sist_filename, &quot;ifconfig-pool-persist&quot;);</span><br><span>        =
 MUST_BE_UNDEF(ifconfig_ipv6_pool_defined, &quot;ifconfig-ipv6-pool&quot;);=
</span><br><span>         MUST_BE_UNDEF(subnet_pools, &quot;subnet-pool&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE=
_UNDEF(subnet_pools_ipv6, &quot;subnet-pool-ipv6&quot;);</span><br><span>  =
       MUST_BE_UNDEF(real_hash_size, &quot;hash-size&quot;);</span><br><spa=
n>         MUST_BE_UNDEF(virtual_hash_size, &quot;hash-size&quot;);</span><=
br><span>         MUST_BE_UNDEF(learn_address_script, &quot;learn-address&q=
uot;);</span><br><span>@@ -3119,8 +3136,9 @@</span><br><span> }</span><br><=
span> </span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * The server&#39;s tun device is only configured with the --server ne=
twork, so</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * route eac=
h --subnet-pool network into it as well: without this the server</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * The server&#39;s tun device=
 is only configured with the --server and</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * --server-ipv6 networks, so route each --subnet-poo=
l and --subnet-pool-ipv6</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * network into it as well: without this the server</span><br><span>  =
* could not reach its subnet-pool clients when the data channel runs in</sp=
an><br><span>  * userspace=2E  Under DCO on Linux and FreeBSD the routes ar=
e installed on-link,</span><br><span>  * see subnet_pool_routes_onlink()=2E=
</span><br><span>@@ -3138,6 +3156,16 @@</span><br><span>                   =
                    o-&gt;route_default_table_id);</span><br><span>        =
 ro-&gt;on_link =3D subnet_pool_routes_onlink(o);</span><br><span>     }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (const struct subnet_pool6_def *d=
 =3D o-&gt;subnet_pools_ipv6; d; d =3D d-&gt;next)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        struct buffer prefix =3D alloc_buf_gc(64, &amp;o-&=
gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;prefix,=
 &quot;%s/%u&quot;, print_in6_addr(d-&gt;network, 0, &amp;o-&gt;gc), d-&gt;=
netbits);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ro=
l6_check_alloc(o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       add_route_ipv6_to_option_list(o-&gt;routes_ipv6, BSTR(&amp;prefix), =
NULL, NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                              o-&gt;route_default_table_id);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><br=
><span> </span><br><span> static void</span><br><span>@@ -6314,6 +6342,37 @=
@</span><br><span>         sp-&gt;next =3D options-&gt;subnet_pools;</span>=
<br><span>         options-&gt;subnet_pools =3D sp;</span><br><span>     }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p=
[0], &quot;subnet-pool-ipv6&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&am=
p; !p[4])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct subnet_po=
ol6_def *sp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 struct in6_addr network, gateway;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        unsigned int netbits =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!get_ipv6_addr(p[2], &amp;net=
work, &amp;netbits, msglevel))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            msg(msglevel, &quot;cannot parse --subnet-pool-ipv6 network&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            go=
to err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (netbits &l=
t; 64 || netbits &gt; 124)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         msg(msglevel, &quot;--subnet-pool-ipv6 network must be between /64=
 and /124 (not /%u)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                netbits);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            goto err;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (p[3] &amp;&amp; !get_ipv6_addr(p[3], &amp;gateway, NULL, m=
sglevel))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msgl=
evel, &quot;cannot parse --subnet-pool-ipv6 gateway&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ALLOC_OBJ_GC(sp, struct subnet_po=
ol6_def, &amp;options-&gt;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        sp-&gt;tag =3D p[1];</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        sp-&gt;network =3D network;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;netbits =3D netbits;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;gateway =
=3D p[3] ? gateway : add_in6_addr(network, 1);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        sp-&gt;next =3D options-&gt;subnet_pools=
_ipv6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        optio=
ns-&gt;subnet_pools_ipv6 =3D sp;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;subnet-p=
ool-tag&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</sp=
an><br><span>         VERIFY_PERMISSION(OPT_P_INSTANCE);</span><br><span>di=
ff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><spa=
n>index 568bae6=2E=2Ef3bbde9 100644</span><br><span>--- a/src/openvpn/optio=
ns=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -26=
7,6 +267,16 @@</span><br><span>     in_addr_t pool_end;</span><br><span> };=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* The IPv6 counterpart of struct subnet_pool_def (--subnet-pool-ipv6)=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct subnet_pool6=
_def</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6_def *next=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *ta=
g;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct in6_ad=
dr network;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsi=
gned int netbits;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct in6_addr gateway;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> /* Command line options */</span><br><span> struct options</span><b=
r><span> {</span><br><span>@@ -533,12 +543,17 @@</span><br><span>     bool =
push_ifconfig_constraint_defined;</span><br><span>     in_addr_t push_ifcon=
fig_constraint_network;</span><br><span>     in_addr_t push_ifconfig_constr=
aint_netmask;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct subnet_pool_def *subnet_pools; /* named pools (server config) */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *subnet_pool_t=
ag;          /* which pool this client uses (CCD) */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    bool subnet_pool_defined;             /=
* resolved from the tag at connect */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct subnet_pool_def *subnet_pools;       /* named =
IPv4 pools (server config) */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct subnet_pool6_def *subnet_pools_ipv6; /* named IPv6 poo=
ls (server config) */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const char *subnet_pool_tag;                /* which pool this client=
 uses (CCD) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
ool subnet_pool_defined;                   /* resolved from the tag at conn=
ect */</span><br><span>     in_addr_t subnet_pool_network;</span><br><span>=
     in_addr_t subnet_pool_netmask;</span><br><span>     in_addr_t subnet_p=
ool_gateway;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    boo=
l subnet_pool_ipv6_defined; /* resolved from the tag at connect */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr subnet_p=
ool_ipv6_network;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  unsigned int subnet_pool_ipv6_netbits;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct in6_addr subnet_pool_ipv6_gateway;</span><b=
r><span>     bool push_ifconfig_ipv4_blocked;           /* IPv4 */</span><b=
r><span>     bool push_ifconfig_ipv6_defined;           /* IPv6 */</span><b=
r><span>     struct in6_addr push_ifconfig_ipv6_local;  /* IPv6 */</span><b=
r><span>diff --git a/src/openvpn/options_util=2Ec b/src/openvpn/options_uti=
l=2Ec</span><br><span>index 862bf7c=2E=2Ee853682 100644</span><br><span>---=
 a/src/openvpn/options_util=2Ec</span><br><span>+++ b/src/openvpn/options_u=
til=2Ec</span><br><span>@@ -130,6 +130,108 @@</span><br><span>     return t=
rue;</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* value of bit &lt;i&gt; (0 =3D most significant) of=
 an IPv6 address */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in6_bit(=
const struct in6_addr *a, unsigned int i)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return a-&gt;s6_addr[i / 8] &amp; (0x80 &gt;&gt; (i % 8));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* true if the first &lt;bits&gt; bits of the two addresses are e=
qual */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+in6_prefix_equal(con=
st struct in6_addr *a, const struct in6_addr *b, unsigned int bits)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (unsigned int i =3D 0; i &lt; bits; +=
+i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (in6_bit(a, i) !=3D=
 in6_bit(b, i))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* true if every bit of &lt;a&gt; from bit &lt;from&gt; on is zero */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+in6_suffix_zero(const struct i=
n6_addr *a, unsigned int from)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for=
 (unsigned int i =3D from; i &lt; 128; ++i)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (in6_bit(a, i))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            return false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+subnet_pools6_check(const struct subnet_pool6_def *pools, const st=
ruct in6_addr *server_network,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    unsigned int server_netbits, msglvl_t msglev=
el)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    for (const struct subnet_pool6=
_def *d =3D pools; d; d =3D d-&gt;next)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (d-&gt;netbits &lt; 64 || d-&gt;netbits &gt; 124)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--subn=
et-pool-ipv6 %s: network must be between /64 and /124 (not /%u)&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                d-&gt;ta=
g, d-&gt;netbits);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           return false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!in6_suffix_=
zero(&amp;d-&gt;network, d-&gt;netbits))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            msg(msglevel, &quot;--subnet-pool-ipv6 %s: network h=
as host bits set&quot;, d-&gt;tag);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (!in6_prefix_equal(&amp;d-&gt;gateway, &amp;d-&gt;network, d-&gt;netbit=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            || in=
6_suffix_zero(&amp;d-&gt;gateway, d-&gt;netbits))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            msg(msglevel,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                &quot;--subnet-pool-ipv6 %s: gate=
way must be a host address inside the network&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                d-&gt;tag);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            return false;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (server_netbits</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            &amp;&amp; in6_prefix_equal(&amp;d-&g=
t;network, server_network, min_uint(d-&gt;netbits, server_netbits)))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--su=
bnet-pool-ipv6 %s: network overlaps the --server-ipv6 network&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                d-&gt;tag)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        for (const struct subnet_pool6_de=
f *e =3D d-&gt;next; e; e =3D e-&gt;next)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (!strcmp(d-&gt;tag, e-&gt;tag))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;--sub=
net-pool-ipv6 %s: tag defined more than once&quot;, d-&gt;tag);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                return false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if (in6_prefix_=
equal(&amp;d-&gt;network, &amp;e-&gt;network, min_uint(d-&gt;netbits, e-&gt=
;netbits)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  msg(msglevel, &quot;--subnet-pool-ipv6 %s and %s: networks overlap&quot;,=
 d-&gt;tag, e-&gt;tag);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                return false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
const struct subnet_pool6_def *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+subnet_pool6_by_tag(const struct subnet_pool6_def *pools, const=
 char *tag)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for (const struct subn=
et_pool6_def *d =3D pools; d; d =3D d-&gt;next)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (!strcmp(d-&gt;tag, tag))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            return d;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> cons=
t char *</span><br><span> parse_auth_failed_temp(struct options *o, const c=
har *reason)</span><br><span> {</span><br><span>diff --git a/src/openvpn/op=
tions_util=2Eh b/src/openvpn/options_util=2Eh</span><br><span>index f1e63e1=
5=2E=2E6ddded3 100644</span><br><span>--- a/src/openvpn/options_util=2Eh</s=
pan><br><span>+++ b/src/openvpn/options_util=2Eh</span><br><span>@@ -55,6 +=
55,25 @@</span><br><span> bool subnet_pools_check(const struct subnet_pool_=
def *pools, in_addr_t server_network,</span><br><span>                     =
    in_addr_t server_netmask, msglvl_t msglevel);</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * IPv6 counterpart of subnet_pools_check=
(): network between /64 and /124</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * without host bits, gateway a host address inside it, unique=
 tags, and no</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * net=
work overlapping another pool or the --server-ipv6 network=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param pools           head of the --subnet-poo=
l-ipv6 list (may be NULL)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param server_network  the --server-ipv6 network</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param server_netbits  the --serve=
r-ipv6 prefix length, or 0 if there is none</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param msglevel        level of the message logg=
ed on the first error</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @return                true if every definition is valid</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+bool subnet_pools6_check(const struct subnet_pool=
6_def *pools,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                   const struct in6_addr *server_network, unsigned int serv=
er_netbits,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                 msglvl_t msglevel);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
* IPv6 counterpart of subnet_pool_by_tag()=2E */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+const struct subnet_pool6_def *subnet_pool6_by=
_tag(const struct subnet_pool6_def *pools,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                                   c=
onst char *tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> </span><br><span> /** Checks if the string is a valid intege=
r by checking if it can be</span><br><span>  *  converted to an integer */<=
/span><br><span>diff --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec</s=
pan><br><span>index 5c5b3fe=2E=2E2cdaa71 100644</span><br><span>--- a/src/o=
penvpn/pool=2Ec</span><br><span>+++ b/src/openvpn/pool=2Ec</span><br><span>=
@@ -446,6 +446,22 @@</span><br><span>     return true;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ifconfig_pool_rese=
rve_ipv6(struct ifconfig_pool *pool, const struct in6_addr *addr)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const ifconfig_pool_handle h =3D ifconfig_p=
ool_ipv6_base_to_handle(pool, addr);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (h &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ifconfig_pool_entry_free(&amp;pool-&gt;list[h=
], true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pool-&=
gt;list[h]=2Ein_use =3D true;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    pool-&gt;list[h]=2Ereserved =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> static in_addr_t</span><br><span> ifconfig_p=
ool_handle_to_ip_base(const struct ifconfig_pool *pool, ifconfig_pool_handl=
e hand)</span><br><span> {</span><br><span>diff --git a/src/openvpn/pool=2E=
h b/src/openvpn/pool=2Eh</span><br><span>index 497dcda=2E=2Efda87ed 100644<=
/span><br><span>--- a/src/openvpn/pool=2Eh</span><br><span>+++ b/src/openvp=
n/pool=2Eh</span><br><span>@@ -98,6 +98,9 @@</span><br><span>  */</span><br=
><span> bool ifconfig_pool_reserve_ip(struct ifconfig_pool *pool, in_addr_t=
 addr);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/** IPv6 counterpart of ifconfig_pool_reserve_ip()=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool ifconfig_pool_reserve_ipv6(=
struct ifconfig_pool *pool, const struct in6_addr *addr);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> struct ifconfig_poo=
l_persist *ifconfig_pool_persist_init(const char *filename, int refresh_fre=
q);</span><br><span> </span><br><span> void ifconfig_pool_persist_close(str=
uct ifconfig_pool_persist *persist);</span><br><span>diff --git a/tests/uni=
t_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</spa=
n><br><span>index 06fd9aa=2E=2Ed46c230 100644</span><br><span>--- a/tests/u=
nit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/open=
vpn/test_misc=2Ec</span><br><span>@@ -568,6 +568,8 @@</span><br><span>     =
cmocka_unit_test(test_subnet_pools_check_gateway),</span><br><span>     cmo=
cka_unit_test(test_subnet_pools_check_range),</span><br><span>     cmocka_u=
nit_test(test_subnet_pools_check_overlap),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    cmocka_unit_test(test_subnet_pool6_by_tag),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(tes=
t_subnet_pools6_check),</span><br><span> };</span><br><span> </span><br><sp=
an> int</span><br><span>diff --git a/tests/unit_tests/openvpn/test_subnet_p=
ool=2Ec b/tests/unit_tests/openvpn/test_subnet_pool=2Ec</span><br><span>ind=
ex 10c0bc5=2E=2E2d08684 100644</span><br><span>--- a/tests/unit_tests/openv=
pn/test_subnet_pool=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test=
_subnet_pool=2Ec</span><br><span>@@ -158,3 +158,77 @@</span><br><span>     =
struct subnet_pool_def adup =3D { =2Enext =3D &amp;bdup, =2Etag =3D &quot;g=
rpA&quot;, =2Enetwork =3D 0x0a090000, =2Enetmask =3D 0xffffff00, =2Egateway=
 =3D 0x0a090001 };</span><br><span>     assert_false(subnet_pools_check(&am=
p;adup, 0, 0, M_WARN));</span><br><span> }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* the IPv6 counterpart resolves independently: a tag may name a v4 poo=
l, a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * v6 pool, or =
both=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+test_subnet_pool6_by_tag=
(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6=
_def c =3D { =2Enext =3D NULL, =2Etag =3D &quot;grpC&quot;, =2Enetbits =3D =
64 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct sub=
net_pool6_def b =3D { =2Enext =3D &amp;c, =2Etag =3D &quot;grpB&quot;, =2En=
etbits =3D 96 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct subnet_pool6_def a =3D { =2Enext =3D &amp;b, =2Etag =3D &quot;grpA&=
quot;, =2Enetbits =3D 64 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
ptr_equal(subnet_pool6_by_tag(&amp;a, &quot;grpA&quot;), &amp;a);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(subnet_p=
ool6_by_tag(&amp;a, &quot;grpB&quot;), &amp;b);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_ptr_equal(subnet_pool6_by_tag(&amp;a=
, &quot;grpC&quot;), &amp;c);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(subnet_pool6_by_tag(&amp;a, &quot;grpB&quot;=
)-&gt;netbits, 96);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_null(subnet_pool6_by_tag(&amp;a, &quot;nope&quot;));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(subnet_pool6_by=
_tag(NULL, &quot;grpA&quot;));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* &lt;prefix&gt;::&lt;hos=
t&gt; as an in6_addr */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static struct in6_addr</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+in6(const char *addr)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t in6_addr a;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(inet=
_pton(AF_INET6, addr, &amp;a), 1);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return a;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* a single IPv6 pool, check=
ed against the fd00:8::/64 --server-ipv6 network */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+check6_one(const char *net, unsigned int bits, co=
nst char *gw)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct in6_add=
r server =3D in6(&quot;fd00:8::&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct subnet_pool6_def d =3D { =2Enext =3D NULL, =
=2Etag =3D &quot;grp&quot;, =2Enetwork =3D in6(net), =2Enetbits =3D bits, =
=2Egateway =3D in6(gw) };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return su=
bnet_pools6_check(&amp;d, &amp;server, 64, M_WARN);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_subnet_pools6=
_check(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* /64 =2E=2E=
 /124, any host address of the network as gateway */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(check6_one(&quot;fd00:9::=
&quot;, 64, &quot;fd00:9::1&quot;));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(check6_one(&quot;fd00:9::&quot;, 124, &quo=
t;fd00:9::1&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_true(check6_one(&quot;fd00:9::&quot;, 112, &quot;fd00:9::ffff&q=
uot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_f=
alse(check6_one(&quot;fd00:9::&quot;, 63, &quot;fd00:9::1&quot;));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check6_one(=
&quot;fd00:9::&quot;, 125, &quot;fd00:9::1&quot;));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* host bits in the network, gateway =3D network or outs=
ide it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_false(check6_one(&quot;fd00:9::5&quot;, 64, &quot;fd00:9::1&quot;));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check6_o=
ne(&quot;fd00:9::&quot;, 64, &quot;fd00:9::&quot;));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(check6_one(&quot;fd00:9:=
:&quot;, 64, &quot;fd00:a::1&quot;));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* overlapping the --server-ipv6 network, inside or covering it */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check6_o=
ne(&quot;fd00:8::&quot;, 96, &quot;fd00:8::1&quot;));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* two pools: disjoint, overlapping, same tag */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct in6_addr s=
erver =3D in6(&quot;fd00:8::&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct subnet_pool6_def b =3D { =2Enext =3D NULL, =2Et=
ag =3D &quot;grpB&quot;, =2Enetwork =3D in6(&quot;fd00:a::&quot;), =2Enetbi=
ts =3D 64, =2Egateway =3D in6(&quot;fd00:a::1&quot;) };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6_def a =3D { =2E=
next =3D &amp;b, =2Etag =3D &quot;grpA&quot;, =2Enetwork =3D in6(&quot;fd00=
:9::&quot;), =2Enetbits =3D 64, =2Egateway =3D in6(&quot;fd00:9::1&quot;) }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(subnet_pools6_check(&=
amp;a, &amp;server, 64, M_WARN));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(subnet_pools6_check(&amp;a, &amp;server, 0, M=
_WARN));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* a /120 grpB inside grpA=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subne=
t_pool6_def bin =3D { =2Enext =3D NULL, =2Etag =3D &quot;grpB&quot;, =2Enet=
work =3D in6(&quot;fd00:9::100&quot;), =2Enetbits =3D 120, =2Egateway =3D i=
n6(&quot;fd00:9::101&quot;) };</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct subnet_pool6_def ain =3D { =2Enext =3D &amp;bin, =2Et=
ag =3D &quot;grpA&quot;, =2Enetwork =3D in6(&quot;fd00:9::&quot;), =2Enetbi=
ts =3D 64, =2Egateway =3D in6(&quot;fd00:9::1&quot;) };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_false(subnet_pools6_check(&a=
mp;ain, &amp;server, 64, M_WARN));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* the same tag defined twice */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct subnet_pool6_def bdup =3D { =2Enext =3D NULL, =2Eta=
g =3D &quot;grpA&quot;, =2Enetwork =3D in6(&quot;fd00:a::&quot;), =2Enetbit=
s =3D 64, =2Egateway =3D in6(&quot;fd00:a::1&quot;) };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6_def adup =3D { =
=2Enext =3D &amp;bdup, =2Etag =3D &quot;grpA&quot;, =2Enetwork =3D in6(&quo=
t;fd00:9::&quot;), =2Enetbits =3D 64, =2Egateway =3D in6(&quot;fd00:9::1&qu=
ot;) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_f=
alse(subnet_pools6_check(&amp;adup, &amp;server, 64, M_WARN));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/t=
ests/unit_tests/openvpn/test_subnet_pool=2Eh b/tests/unit_tests/openvpn/tes=
t_subnet_pool=2Eh</span><br><span>index 2a1f882=2E=2E4d57380 100644</span><=
br><span>--- a/tests/unit_tests/openvpn/test_subnet_pool=2Eh</span><br><spa=
n>+++ b/tests/unit_tests/openvpn/test_subnet_pool=2Eh</span><br><span>@@ -3=
4,4 +34,8 @@</span><br><span> </span><br><span> void test_subnet_pools_chec=
k_overlap(void **state);</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void test_subnet_pool6_by_tag(void **state);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void test_subnet_pools6_check(void **state);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #en=
dif</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1786?usp=3Demail">change 1786</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: I64e0850d48647a2c0e3d385c=
2f20a9f445931727 </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
1786 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: Antonio Quartulli &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Antonio Quartulli &lt;ant=
onio@mandelbit=2Ecom&gt; </div>

</body></html>
--IDI9vDI8uZQ=--


--===============2932876708899130578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2932876708899130578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2932876708899130578==--

