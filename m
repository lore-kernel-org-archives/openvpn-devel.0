Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E09A606A326
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bbhu3Ywj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SRgZhtrB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZJeLEFAY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=alSN6Pl+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Upzb+/ygXUkSM6tK+BS7gOVz+sElbbtQ5dwK6BC1oqg=; b=bbhu3YwjXg2AqXVpU7+4er9O3E
	J68vsYVbAtqyZnh6knDABFaaABzq3op+kVFhPi4J+GKw/AK1nI237sItheUMSXqUERhlqE6hcKuzR
	K3gusymeE3DyAmclaBYCROngL3fufSxLKSSpC6Gcy5KdZ5R1f30NLDkZIs644eKEU8gg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLRnn-0000000075F-30XS;
	Mon, 26 Oct 2026 21:00:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLRnm-00000000759-1DTI
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 21:00:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/m8umB+oAVYnahJZzS+9C4KZinOCh7FiDVE5u5Gwm1Y=; b=SRgZhtrBn99PPhSn9yOOWrDUxV
 heVxsODXNCrraaz2CwS/2bpdWNBjw+x8CkEHagiARYwBpKE1R9M42UUCzcY0f66rxUABjhAyZagw1
 zD7/KjF5VtI//zGtDujDjzSeUzGgGpnNfZJ0N9meeA0WfgxCtKLO1jVpL0mjWX1lu4cE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/m8umB+oAVYnahJZzS+9C4KZinOCh7FiDVE5u5Gwm1Y=; b=ZJeLEFAYHN3C90E684lUjuqmju
 N8RJd4ice7yGHde0yewiZR7nJazWqgVdCQ/TxGu3sH8Mfv+rgo0TXdMB12Dz4cAw7DSIvGC/Yk6wk
 CIwMUGywqwEqOUN5VKfceyAslFO+sYXrdD5hi3Od0r8BZrV0YD51cdFibS1vDkhOfCzI=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLRne-000000004AT-3Mcq for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 21:00:18 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso22809245e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 14:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793048404; x=1793653204; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/m8umB+oAVYnahJZzS+9C4KZinOCh7FiDVE5u5Gwm1Y=;
 b=alSN6Pl+J4aL0C0Qfqr3g7Z5JCNSS28sBLMd20LK9ps8e06XQV3G9kBt6h3YTheaqC
 C/FgEzgBARiIWl5Br6VKAgLF2QO7gRnfSf0DMHL4vcY8Hxxf/lxa2r8MEjyo1f0H7ugX
 Jky/lnNAPWCyXfPPCembVYsxkv6Ntv0I9IrHlJ4Fwux2eKJUFl5af+Yb760J4unHaZaQ
 +gDR0sk6rD2jN0nFIlRMs6W0dCFtZYO3l1utwM4Mrr8CN2CVOCiGDWpqiSP3UtgpGCEl
 fUW3oa4NdsLuknQ8Skmsk80n4HIsOcrMmc2DtyShz58eei4yWwBJ5RbIoDAfaly4KjUI
 x4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793048404; x=1793653204;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/m8umB+oAVYnahJZzS+9C4KZinOCh7FiDVE5u5Gwm1Y=;
 b=U7oIi+TvXMPbWOuY+4KACQT1s+sYA0TabTip6AWU87tt60vWSOBOYqdntTJTaRjZoP
 AtcjeNMrfShh34L2dkZNw0KlbhPKhK4pvDoCHjU6pdeECp2GV5NDObVWGSL+v+xGOOTf
 MeNkYqq7aJ1wy2Oe7iL5FEi0vqiclwwb41X816vLGhDnlvbFQHe1cTGH2GWDT0y4Aynz
 IB10GZ8p7ka1P6dzbIPEYW3+jdXXD3HdjWrCpRuKDtolYarMO/keToKeMuWlnZ8jFaGH
 LmYvQH18qcpkyatss0mZZ7rz/lpxnBysJD/O3lNi7bTh5BkudC8Oo53ISok97WkWwLXg
 J50Q==
X-Gm-Message-State: AFq9FYLmT4w70/4Jz8GPA12JM2nV9RJUFG1JYdDe1uRxBGhpQ9VgKbfp
 FiuRsDaYS/yTkWulhollcuExEhflQU7tM/cWb6MHnckFiYyjYEvZRdw2ocoIPymbc7GWxuRjDYY
 xc/LeOySAf7Owx398jbVqyENc5M9KVYWU3Wf778nAZL1p7A3mYcr4L994xScTdcq0W+k+G/sOmM
 ZXx+k0vg==
X-Gm-Gg: AYBFou2PeBSAC8eTqKoXhkaeY48GcPsEm+9ehXuH9q86v8g/DvKMKwLJVbTRf/VWUFk
 rFh5GRsB3ZP71OylrrcF/fjsvEuw1sZp7czseETfBfU/DftxfMtyKRe5DLCNSa1Uo8uLHCS2L1y
 gkFG3lORsZcRQ9gj2KL3GHFzdpFo3nJEbQlQjVotatw/dEe8+SBVSaD0+F05bZV6rQ9kPb2rDvF
 c1sEQGDDidj7htsaQQ8tHrqU1VePv9yiFzqKTpdY5SmGiy6QlER0cEzwPYGY7VaBEQ+OuTB/9Le
 OHR93Gju372Yr00edbVyCZy6sA+CrKEInQTe2EQaPLuWZvP2oxiWpWXbvT7VkeytgCJODQo6Y2G
 v41KvO4e5KsjRlBCck/tsK7nm5AKuIs48Cf49sXK6HDlqk1exE6qpBq79bDHbUjiHR0gxw3b4tr
 H4dmkqDDIvePIG5wmEtMwmVEK9t/LTfLGQVle3wEVaq17l/ykRoiq7zkWK1vbWeI7FuVW6tmw2z
 Bzcw7rR2jBUGcuX5AZhUoFbzk1RTqDkqBDHIDNvz7/ZRVf9BBXAOeJQ9SjzWw8QUduguR+vYtlI
 DxcLGaNACk9DO84jGt00mQXuD5oVonDxoWkKb5JOvhDGltd6tNAAPJmTf8mJXhjasRjSU/lDedw
 2SOZGY61RBzC6hVB9KDHxEestcosyIIpFdqLnNd2nh1+SC98vRWcX/6opTCL2wCGM
X-Received: by 2002:a05:600c:4ece:b0:4a1:fbd2:f689 with SMTP id
 5b1f17b1804b1-4a35ac9d100mr141597425e9.7.1793048403683; 
 Mon, 26 Oct 2026 14:00:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a30e22csm219229845e9.2.2026.10.26.14.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:00:02 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 20:59:55 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727
X-Gerrit-Change-Number: 1786
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1786?usp=email>
X-Gerrit-Commit: 7c7c3df067fd900392d0d9c5f25f6fb60939f3d3
In-Reply-To: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
References: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkk2NGUwODUwZDQ4NjQ3YTJjMGUzZDM4NWMyZjIwYTlmNDQ1OTMxNzI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <adc1acbb331063e1b96aeb40fe9142510c4f29d4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLRne-000000004AT-3Mcq
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multi: assign IPv6
 addresses from a named subnet-pool
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
Content-Type: multipart/mixed; boundary="===============4942842631746114752=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4942842631746114752==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GNcWJQxpf20="; charset=UTF-8

--GNcWJQxpf20=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli=2E

Hello Arne Schw=
abe, 

I'd like you to reexamine a change=2E Please visit

    https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail

to look at the new patch s=
et (#12)=2E


Change subject: multi: assign IPv6 addresses from a named sub=
net-pool
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mult=
i: assign IPv6 addresses from a named subnet-pool

Add the IPv6 counterpart=
 of --subnet-pool:

  subnet-pool-ipv6 <name> <network>/<bits> [<gateway>] =
 (main config)

selected by the same per-client --subnet-pool-name=2E A cli=
ent's name is
resolved against the IPv6 pool list too and, when it matches,=
 an IPv6
address is handed out from the group's pool alongside any IPv4 one=
 (a
single dual-stack ifconfig_pool per name)=2E The pool gateway is pushed=
 as
the remote end of the client's ifconfig-ipv6, as the server's own
addre=
ss is off-link for it=2E A name matching neither family is still
declined w=
ith AUTH_FAILED=2E

As for IPv4 the pools are checked when the config is lo=
aded (network
between /64 and /124 without host bits, gateway a host addres=
s inside
it, unique names, no overlap with another pool or the --server-ipv=
6
network), created at startup with their gateway reserved, and routed
into=
 the server's tun device=2E

Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445=
931727
GitHub: closes openvpn/OpenVPN#987
Signed-off-by: Antonio Quartulli =
<antonio@mandelbit=2Ecom>
---
M doc/man-sections/server-options=2Erst
M src=
/openvpn/multi=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M sr=
c/openvpn/options_util=2Ec
M src/openvpn/options_util=2Eh
M src/openvpn/poo=
l=2Ec
M src/openvpn/pool=2Eh
M tests/unit_tests/openvpn/test_misc=2Ec
M tes=
ts/unit_tests/openvpn/test_subnet_pool=2Ec
M tests/unit_tests/openvpn/test_=
subnet_pool=2Eh
11 files changed, 406 insertions(+), 34 deletions(-)


  gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/86/1786/12

=
diff --git a/doc/man-sections/server-options=2Erst b/doc/man-sections/serve=
r-options=2Erst
index b9ed47a=2E=2E138fcc9 100644
--- a/doc/man-sections/se=
rver-options=2Erst
+++ b/doc/man-sections/server-options=2Erst
@@ -366,11 +=
366,32 @@
   and FreeBSD the IPv4 route is installed on-link, without a gat=
eway, so its
   ``route_gateway_{n}`` is not set for ``--route-up`` scripts=
=2E
 
+--subnet-pool-ipv6 args
+  The IPv6 counterpart of ``--subnet-pool``=
=2E Repeatable main-config directive=2E
+
+  Valid syntax:
+  ::
+
+     su=
bnet-pool-ipv6 name network/bits [gateway]
+
+  ``bits`` must be between 64=
 and 124; ``gateway`` defaults to the first
+  address of the network, is n=
ever assigned to a client, and is pushed to the
+  pool's clients as the re=
mote end of their ``ifconfig-ipv6``=2E A name may refer to
+  an IPv4 pool,=
 an IPv6 pool, or both; a client referencing it with
+  ``--subnet-pool-nam=
e`` is then assigned an address from each family the name
+  defines=2E
+
+=
  Requires ``--server-ipv6`` with ``--dev tun`` and ``--topology subnet``=
=2E
+  ``network`` must have no host bits set, ``gateway`` must be a host a=
ddress
+  inside it, each ``name`` may be defined only once and no pool may=
 overlap
+  another one or the ``--server-ipv6`` network=2E As for ``--subn=
et-pool``, the
+  server routes each pool's network into the tun device=2E
=
+
 --subnet-pool-name name
-  Assign this client to the ``--subnet-pool`` n=
amed ``name``=2E Must be
-  associated with a specific client instance via =
``--client-config-dir`` or
-  ``--client-connect``=2E Several clients may r=
eference the same name and are
-  then served from the same shared pool=2E
=
+  Assign this client to the ``--subnet-pool`` / ``--subnet-pool-ipv6`` nam=
ed
+  ``name``=2E Must be associated with a specific client instance via
+ =
 ``--client-config-dir`` or ``--client-connect``=2E Several clients may
+  =
reference the same name and are then served from the same shared pool(s)=2E=

 
 --ifconfig-ipv6-push args
   for ``--client-config-dir`` per-client sta=
tic IPv6 interface
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec
index 150660c=2E=2Eda01f8a 100644
--- a/src/openvpn/multi=2Ec
+++ b/sr=
c/openvpn/multi=2Ec
@@ -393,6 +393,10 @@
     {
         multi_get_group_po=
ol(m, &t->options, d->name);
     }
+    for (const struct subnet_pool6_def=
 *d =3D t->options=2Esubnet_pools_ipv6; d; d =3D d->next)
+    {
+        m=
ulti_get_group_pool(m, &t->options, d->name);
+    }
 
     /*
      * Help=
 us keep track of routing table=2E
@@ -1471,16 +1475,31 @@
     }
 
     co=
nst struct subnet_pool_def *d4 =3D subnet_pool_by_name(o->subnet_pools, nam=
e);
-    ASSERT(d4);
+    const struct subnet_pool6_def *d6 =3D subnet_pool=
6_by_name(o->subnet_pools_ipv6, name);
+    const char *pool_name =3D d4 ? =
d4->name : (d6 ? d6->name : NULL);
+    ASSERT(pool_name);
     ALLOC_OBJ_C=
LEAR(sp, struct subnet_pool);
-    sp->name =3D d4->name;
-    /* the confi=
gured dynamic range, or else every host address of the
-     * subnet, minu=
s the gateway reserved below if it falls inside it */
-    const in_addr_t =
start =3D d4->pool_start ? d4->pool_start : d4->network + 1;
-    const in_=
addr_t end =3D d4->pool_end ? d4->pool_end : (d4->network | ~d4->netmask) -=
 1;
-    sp->pool =3D ifconfig_pool_init(true, IFCONFIG_POOL_INDIV, start, =
end, o->duplicate_cn, false,
-                                  in6addr_any=
, 0);
-    ifconfig_pool_reserve_ip(sp->pool, d4->gateway);
+    sp->name =
=3D pool_name;
+    /* the IPv4 range (configured, or else every host addre=
ss of the subnet)
+     * and every host address of the IPv6 network, minus=
 the gateways reserved
+     * below (the IPv4 and the IPv6 address of a cl=
ient share one pool handle) */
+    in_addr_t start =3D 0, end =3D 0;
+    =
if (d4)
+    {
+        start =3D d4->pool_start ? d4->pool_start : d4->net=
work + 1;
+        end =3D d4->pool_end ? d4->pool_end : (d4->network | ~d4=
->netmask) - 1;
+    }
+    sp->pool =3D ifconfig_pool_init(d4 !=3D NULL, I=
FCONFIG_POOL_INDIV, start, end, o->duplicate_cn,
+                         =
         d6 !=3D NULL, d6 ? add_in6_addr(d6->network, 1) : in6addr_any,
+  =
                                d6 ? (int)d6->netbits : 0);
+    if (d4)
+ =
   {
+        ifconfig_pool_reserve_ip(sp->pool, d4->gateway);
+    }
+    =
if (d6)
+    {
+        ifconfig_pool_reserve_ipv6(sp->pool, &d6->gateway);=

+    }
     sp->next =3D m->subnet_pools;
     m->subnet_pools =3D sp;
   =
  return sp->pool;
@@ -1514,6 +1533,19 @@
             mi->context=2Eoption=
s=2Esubnet_pool_gateway =3D d->gateway;
         }
     }
+    if (mi->cont=
ext=2Eoptions=2Esubnet_pool_name)
+    {
+        const struct subnet_pool6=
_def *d =3D subnet_pool6_by_name(
+            m->top=2Eoptions=2Esubnet_po=
ols_ipv6, mi->context=2Eoptions=2Esubnet_pool_name);
+
+        mi->context=
=2Eoptions=2Esubnet_pool_ipv6_defined =3D d !=3D NULL;
+        if (d)
+   =
     {
+            mi->context=2Eoptions=2Esubnet_pool_ipv6_network =3D d-=
>network;
+            mi->context=2Eoptions=2Esubnet_pool_ipv6_netbits =3D=
 d->netbits;
+            mi->context=2Eoptions=2Esubnet_pool_ipv6_gateway =
=3D d->gateway;
+        }
+    }
 
     /*
      * If ifconfig addresses w=
ere set by dynamic config file,
@@ -1548,15 +1580,16 @@
                 "M=
ULTI_sva: WARNING: if --ifconfig-push is used for IPv4, automatic IPv6 assi=
gnment from --ifconfig-ipv6-pool does not work=2E  Use --ifconfig-ipv6-push=
 for IPv6 then=2E");
         }
     }
-    else if (mi->context=2Eoptions=
=2Esubnet_pool_defined)
+    else if (mi->context=2Eoptions=2Esubnet_pool_d=
efined
+             || mi->context=2Eoptions=2Esubnet_pool_ipv6_defined)
 =
    {
-        /* dynamic address from this client's --subnet-pool group */=

+        /* dynamic address(es) from this client's --subnet-pool group */
=
         struct ifconfig_pool *group =3D
             multi_get_group_pool(=
m, &m->top=2Eoptions, mi->context=2Eoptions=2Esubnet_pool_name);
 
        =
 /* the address may have been acquired before the name was known (from
    =
      * the global pool) or for a name that a later handler overrode: drop
=
-         * it so we serve this client from its current group */
+         =
* it so we serve this client from its current group only */
         if (mi=
->vaddr_handle >=3D 0 && mi->vaddr_pool !=3D group)
         {
            =
 ifconfig_pool_release(mi->vaddr_pool ? mi->vaddr_pool : m->ifconfig_pool,
=
@@ -1571,30 +1604,52 @@
         if (mi->vaddr_handle < 0)
         {
     =
        in_addr_t local =3D 0, remote =3D 0;
+            struct in6_addr r=
emote_ipv6;
             const char *cn =3D NULL;
 
+            CLEAR(remo=
te_ipv6);
             if (!mi->context=2Eoptions=2Eduplicate_cn)
         =
    {
                 cn =3D tls_common_name(mi->context=2Ec2=2Etls_multi,=
 true);
             }
 
             mi->vaddr_pool =3D group;
-          =
  mi->vaddr_handle =3D ifconfig_pool_acquire(mi->vaddr_pool, &local, &remot=
e, NULL, cn);
-            if (mi->vaddr_handle >=3D 0)
-            {
-   =
             mi->context=2Ec2=2Epush_ifconfig_local =3D remote;
-          =
      mi->context=2Ec2=2Epush_ifconfig_remote_netmask =3D
-                =
    mi->context=2Eoptions=2Esubnet_pool_netmask;
-                mi->conte=
xt=2Ec2=2Epush_ifconfig_defined =3D true;
-
-                msg(M_INFO, "M=
ULTI_sva: --subnet-pool '%s' returned IPv4=3D%s",
-                    mi->=
context=2Eoptions=2Esubnet_pool_name, print_in_addr_t(remote, 0, &gc));
-  =
          }
-            else
+            mi->vaddr_handle =3D
+          =
      ifconfig_pool_acquire(mi->vaddr_pool, &local, &remote, &remote_ipv6, =
cn);
+            if (mi->vaddr_handle < 0)
             {
                =
 msg(D_MULTI_ERRORS, "MULTI: no free --subnet-pool '%s' addresses are avail=
able for %s",
                     mi->context=2Eoptions=2Esubnet_pool_name=
, multi_instance_string(mi, false, &gc));
             }
+            else
=
+            {
+                if (mi->context=2Eoptions=2Esubnet_pool_def=
ined)
+                {
+                    mi->context=2Ec2=2Epush_ifcon=
fig_local =3D remote;
+                    mi->context=2Ec2=2Epush_ifconfig=
_remote_netmask =3D
+                        mi->context=2Eoptions=2Esubnet=
_pool_netmask;
+                    mi->context=2Ec2=2Epush_ifconfig_define=
d =3D true;
+                }
+                if (mi->context=2Eoptions=
=2Esubnet_pool_ipv6_defined)
+                {
+                    /* the=
 server's own address is off-link for this client:
+                     * =
hand out the pool gateway as the remote end instead */
+                   =
 mi->context=2Ec2=2Epush_ifconfig_ipv6_local =3D remote_ipv6;
+            =
        mi->context=2Ec2=2Epush_ifconfig_ipv6_remote =3D
+                 =
       mi->context=2Eoptions=2Esubnet_pool_ipv6_gateway;
+                 =
   mi->context=2Ec2=2Epush_ifconfig_ipv6_netbits =3D
+                     =
   mi->context=2Eoptions=2Esubnet_pool_ipv6_netbits;
+                    m=
i->context=2Ec2=2Epush_ifconfig_ipv6_defined =3D true;
+                }
+=

+                msg(M_INFO, "MULTI_sva: --subnet-pool '%s' returned IPv4=
=3D%s, IPv6=3D%s",
+                    mi->context=2Eoptions=2Esubnet_pool=
_name,
+                    mi->context=2Eoptions=2Esubnet_pool_defined ? p=
rint_in_addr_t(remote, 0, &gc)
+                                           =
                 : "(Not enabled)",
+                    mi->context=2Eopti=
ons=2Esubnet_pool_ipv6_defined
+                        ? print_in6_addr(re=
mote_ipv6, 0, &gc)
+                        : "(Not enabled)");
+          =
  }
         }
     }
     else if (m->ifconfig_pool && mi->vaddr_handle < =
0) /* otherwise, choose a pool address */
@@ -2935,7 +2990,9 @@
     }
 
  =
   if (mi->context=2Eoptions=2Esubnet_pool_name
-        && !subnet_pool_by=
_name(m->top=2Eoptions=2Esubnet_pools, mi->context=2Eoptions=2Esubnet_pool_=
name))
+        && !subnet_pool_by_name(m->top=2Eoptions=2Esubnet_pools, mi=
->context=2Eoptions=2Esubnet_pool_name)
+        && !subnet_pool6_by_name(m=
->top=2Eoptions=2Esubnet_pools_ipv6,
+                                 mi->=
context=2Eoptions=2Esubnet_pool_name))
     {
         msg(D_MULTI_ERRORS, =
"MULTI: client has been rejected due to unknown --subnet-pool-name '%s'",
 =
            mi->context=2Eoptions=2Esubnet_pool_name);
diff --git a/src/ope=
nvpn/options=2Ec b/src/openvpn/options=2Ec
index cae6a28=2E=2E089b35d 10064=
4
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -457,6 +45=
7,8 @@
     "                  pool of addresses outside the --server netwo=
rk, selected\n"
     "                  per client with --subnet-pool-name=
=2E start/end restrict the\n"
     "                  dynamically assigned =
range=2E\n"
+    "--subnet-pool-ipv6 name network/bits [gateway] : IPv6 cou=
nterpart of\n"
+    "                  --subnet-pool=2E\n"
     "--subnet-p=
ool-name name : Assign this client to the --subnet-pool named name=2E\n"
  =
   "                  Only valid in a client-specific config file=2E\n"
   =
  "--ifconfig-push local remote-netmask : Push an ifconfig option to remote=
,\n"
@@ -1919,6 +1921,20 @@
             subnet_pools_check(options->subnet=
_pools, options->server_network,
                                options->s=
erver_netmask, M_USAGE);
         }
+        if (options->subnet_pools_ipv6=
)
+        {
+            if (!options->server_ipv6_defined)
+            {=

+                msg(M_USAGE, "--subnet-pool-ipv6 requires --server-ipv6")=
;
+            }
+            if (dev_type_enum(options->dev, options->dev_=
type) !=3D DEV_TYPE_TUN
+                || options->topology !=3D TOP_SUBN=
ET)
+            {
+                msg(M_USAGE, "--subnet-pool-ipv6 requir=
es --dev tun and --topology subnet");
+            }
+            subnet_po=
ols6_check(options->subnet_pools_ipv6, &options->server_network_ipv6,
+    =
                            options->server_netbits_ipv6, M_USAGE);
+      =
  }
         MUST_BE_UNDEF(allow_recursive_routing, "allow-recursive-routin=
g");
         if (options->auth_user_pass_file)
         {
@@ -1986,6 +2002=
,7 @@
         MUST_BE_UNDEF(ifconfig_pool_persist_filename, "ifconfig-pool=
-persist");
         MUST_BE_UNDEF(ifconfig_ipv6_pool_defined, "ifconfig-ip=
v6-pool");
         MUST_BE_UNDEF(subnet_pools, "subnet-pool");
+        MU=
ST_BE_UNDEF(subnet_pools_ipv6, "subnet-pool-ipv6");
         MUST_BE_UNDEF(=
real_hash_size, "hash-size");
         MUST_BE_UNDEF(virtual_hash_size, "ha=
sh-size");
         MUST_BE_UNDEF(learn_address_script, "learn-address");
@=
@ -3119,8 +3136,9 @@
 }
 
 /*
- * The server's tun device is only configure=
d with the --server network, so
- * route each --subnet-pool network into i=
t as well: without this the server
+ * The server's tun device is only conf=
igured with the --server and
+ * --server-ipv6 networks, so route each --su=
bnet-pool and --subnet-pool-ipv6
+ * network into it as well: without this =
the server
  * could not reach its subnet-pool clients when the data channe=
l runs in
  * userspace=2E  Under DCO on Linux and FreeBSD the routes are i=
nstalled on-link,
  * see subnet_pool_routes_onlink()=2E
@@ -3138,6 +3156,1=
6 @@
                                       o->route_default_table_id);
   =
      ro->on_link =3D subnet_pool_routes_onlink(o);
     }
+
+    for (cons=
t struct subnet_pool6_def *d =3D o->subnet_pools_ipv6; d; d =3D d->next)
+ =
   {
+        struct buffer prefix =3D alloc_buf_gc(64, &o->gc);
+
+       =
 buf_printf(&prefix, "%s/%u", print_in6_addr(d->network, 0, &o->gc), d->net=
bits);
+        rol6_check_alloc(o);
+        add_route_ipv6_to_option_list=
(o->routes_ipv6, BSTR(&prefix), NULL, NULL,
+                              =
        o->route_default_table_id);
+    }
 }
 
 static void
@@ -6314,6 +63=
42,37 @@
         sp->next =3D options->subnet_pools;
         options->sub=
net_pools =3D sp;
     }
+    else if (streq(p[0], "subnet-pool-ipv6") && p=
[1] && p[2] && !p[4])
+    {
+        struct subnet_pool6_def *sp;
+       =
 struct in6_addr network, gateway;
+        unsigned int netbits =3D 0;
+
+=
        VERIFY_PERMISSION(OPT_P_GENERAL);
+        if (!get_ipv6_addr(p[2],=
 &network, &netbits, msglevel))
+        {
+            msg(msglevel, "cann=
ot parse --subnet-pool-ipv6 network");
+            goto err;
+        }
+ =
       if (netbits < 64 || netbits > 124)
+        {
+            msg(msgle=
vel, "--subnet-pool-ipv6 network must be between /64 and /124 (not /%u)",
+=
                netbits);
+            goto err;
+        }
+        if (p[=
3] && !get_ipv6_addr(p[3], &gateway, NULL, msglevel))
+        {
+         =
   msg(msglevel, "cannot parse --subnet-pool-ipv6 gateway");
+            g=
oto err;
+        }
+        ALLOC_OBJ_GC(sp, struct subnet_pool6_def, &opt=
ions->gc);
+        sp->name =3D p[1];
+        sp->network =3D network;
+ =
       sp->netbits =3D netbits;
+        sp->gateway =3D p[3] ? gateway : a=
dd_in6_addr(network, 1);
+        sp->next =3D options->subnet_pools_ipv6;
=
+        options->subnet_pools_ipv6 =3D sp;
+    }
     else if (streq(p[0]=
, "subnet-pool-name") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(O=
PT_P_INSTANCE);
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=
=2Eh
index fcfb9e2=2E=2Ea9c6b22 100644
--- a/src/openvpn/options=2Eh
+++ b/=
src/openvpn/options=2Eh
@@ -267,6 +267,16 @@
     in_addr_t pool_end;
 };
 =

+/* The IPv6 counterpart of struct subnet_pool_def (--subnet-pool-ipv6)=2E=
 */
+struct subnet_pool6_def
+{
+    struct subnet_pool6_def *next;
+    co=
nst char *name;
+    struct in6_addr network;
+    unsigned int netbits;
+ =
   struct in6_addr gateway;
+};
+
 /* Command line options */
 struct optio=
ns
 {
@@ -533,12 +543,17 @@
     bool push_ifconfig_constraint_defined;
   =
  in_addr_t push_ifconfig_constraint_network;
     in_addr_t push_ifconfig_=
constraint_netmask;
-    struct subnet_pool_def *subnet_pools; /* named poo=
ls (server config) */
-    const char *subnet_pool_name;         /* which p=
ool this client uses (CCD) */
-    bool subnet_pool_defined;             /*=
 resolved from the name at connect */
+    struct subnet_pool_def *subnet_p=
ools;       /* named IPv4 pools (server config) */
+    struct subnet_pool6=
_def *subnet_pools_ipv6; /* named IPv6 pools (server config) */
+    const =
char *subnet_pool_name;               /* which pool this client uses (CCD) =
*/
+    bool subnet_pool_defined;                   /* resolved from the na=
me at connect */
     in_addr_t subnet_pool_network;
     in_addr_t subnet_=
pool_netmask;
     in_addr_t subnet_pool_gateway;
+    bool subnet_pool_ipv=
6_defined; /* resolved from the name at connect */
+    struct in6_addr sub=
net_pool_ipv6_network;
+    unsigned int subnet_pool_ipv6_netbits;
+    str=
uct in6_addr subnet_pool_ipv6_gateway;
     bool push_ifconfig_ipv4_blocked=
;           /* IPv4 */
     bool push_ifconfig_ipv6_defined;           /* I=
Pv6 */
     struct in6_addr push_ifconfig_ipv6_local;  /* IPv6 */
diff --gi=
t a/src/openvpn/options_util=2Ec b/src/openvpn/options_util=2Ec
index bb52f=
e7=2E=2E808afa6 100644
--- a/src/openvpn/options_util=2Ec
+++ b/src/openvpn=
/options_util=2Ec
@@ -130,6 +130,108 @@
     return true;
 }
 
+/* value of=
 bit <i> (0 =3D most significant) of an IPv6 address */
+static bool
+in6_b=
it(const struct in6_addr *a, unsigned int i)
+{
+    return a->s6_addr[i / =
8] & (0x80 >> (i % 8));
+}
+
+/* true if the first <bits> bits of the two a=
ddresses are equal */
+static bool
+in6_prefix_equal(const struct in6_addr =
*a, const struct in6_addr *b, unsigned int bits)
+{
+    for (unsigned int =
i =3D 0; i < bits; ++i)
+    {
+        if (in6_bit(a, i) !=3D in6_bit(b, i=
))
+        {
+            return false;
+        }
+    }
+    return true=
;
+}
+
+/* true if every bit of <a> from bit <from> on is zero */
+static b=
ool
+in6_suffix_zero(const struct in6_addr *a, unsigned int from)
+{
+    f=
or (unsigned int i =3D from; i < 128; ++i)
+    {
+        if (in6_bit(a, i=
))
+        {
+            return false;
+        }
+    }
+    return true=
;
+}
+
+bool
+subnet_pools6_check(const struct subnet_pool6_def *pools, con=
st struct in6_addr *server_network,
+                    unsigned int serve=
r_netbits, msglvl_t msglevel)
+{
+    for (const struct subnet_pool6_def *d=
 =3D pools; d; d =3D d->next)
+    {
+        if (d->netbits < 64 || d->net=
bits > 124)
+        {
+            msg(msglevel, "--subnet-pool-ipv6 %s: n=
etwork must be between /64 and /124 (not /%u)",
+                d->name, d=
->netbits);
+            return false;
+        }
+
+        if (!in6_suffi=
x_zero(&d->network, d->netbits))
+        {
+            msg(msglevel, "--s=
ubnet-pool-ipv6 %s: network has host bits set", d->name);
+            retu=
rn false;
+        }
+
+        if (!in6_prefix_equal(&d->gateway, &d->netw=
ork, d->netbits)
+            || in6_suffix_zero(&d->gateway, d->netbits))
=
+        {
+            msg(msglevel,
+                "--subnet-pool-ipv6 =
%s: gateway must be a host address inside the network",
+                d-=
>name);
+            return false;
+        }
+
+        if (server_netbits=

+            && in6_prefix_equal(&d->network, server_network, min_uint(d->=
netbits, server_netbits)))
+        {
+            msg(msglevel, "--subnet-=
pool-ipv6 %s: network overlaps the --server-ipv6 network",
+               =
 d->name);
+            return false;
+        }
+
+        for (const stru=
ct subnet_pool6_def *e =3D d->next; e; e =3D e->next)
+        {
+         =
   if (!strcmp(d->name, e->name))
+            {
+                msg(msgle=
vel, "--subnet-pool-ipv6 %s: name defined more than once", d->name);
+     =
           return false;
+            }
+            if (in6_prefix_equal(&=
d->network, &e->network, min_uint(d->netbits, e->netbits)))
+            {
=
+                msg(msglevel, "--subnet-pool-ipv6 %s and %s: networks over=
lap", d->name, e->name);
+                return false;
+            }
+   =
     }
+    }
+
+    return true;
+}
+
+const struct subnet_pool6_def *
+su=
bnet_pool6_by_name(const struct subnet_pool6_def *pools, const char *name)
=
+{
+    for (const struct subnet_pool6_def *d =3D pools; d; d =3D d->next)
=
+    {
+        if (!strcmp(d->name, name))
+        {
+            return =
d;
+        }
+    }
+    return NULL;
+}
+
 const char *
 parse_auth_faile=
d_temp(struct options *o, const char *reason)
 {
diff --git a/src/openvpn/o=
ptions_util=2Eh b/src/openvpn/options_util=2Eh
index 5fa4735=2E=2Eab8122d1 =
100644
--- a/src/openvpn/options_util=2Eh
+++ b/src/openvpn/options_util=2E=
h
@@ -55,6 +55,25 @@
 bool subnet_pools_check(const struct subnet_pool_def =
*pools, in_addr_t server_network,
                         in_addr_t server=
_netmask, msglvl_t msglevel);
 
+/**
+ * IPv6 counterpart of subnet_pools_c=
heck(): network between /64 and /124
+ * without host bits, gateway a host =
address inside it, unique names, and no
+ * network overlapping another poo=
l or the --server-ipv6 network=2E
+ *
+ * @param pools           head of th=
e --subnet-pool-ipv6 list (may be NULL)
+ * @param server_network  the --se=
rver-ipv6 network
+ * @param server_netbits  the --server-ipv6 prefix lengt=
h, or 0 if there is none
+ * @param msglevel        level of the message lo=
gged on the first error
+ * @return                true if every definition=
 is valid
+ */
+bool subnet_pools6_check(const struct subnet_pool6_def *poo=
ls,
+                         const struct in6_addr *server_network, unsign=
ed int server_netbits,
+                         msglvl_t msglevel);
+
+/**=
 IPv6 counterpart of subnet_pool_by_name()=2E */
+const struct subnet_pool6=
_def *subnet_pool6_by_name(const struct subnet_pool6_def *pools,
+         =
                                           const char *name);
+
 
 /** Chec=
ks if the string is a valid integer by checking if it can be
  *  converted=
 to an integer */
diff --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec
=
index 5c5b3fe=2E=2E2cdaa71 100644
--- a/src/openvpn/pool=2Ec
+++ b/src/open=
vpn/pool=2Ec
@@ -446,6 +446,22 @@
     return true;
 }
 
+bool
+ifconfig_po=
ol_reserve_ipv6(struct ifconfig_pool *pool, const struct in6_addr *addr)
+{=

+    const ifconfig_pool_handle h =3D ifconfig_pool_ipv6_base_to_handle(po=
ol, addr);
+
+    if (h < 0)
+    {
+        return false;
+    }
+
+    if=
config_pool_entry_free(&pool->list[h], true);
+    pool->list[h]=2Ein_use =
=3D true;
+    pool->list[h]=2Ereserved =3D true;
+    return true;
+}
+
 s=
tatic in_addr_t
 ifconfig_pool_handle_to_ip_base(const struct ifconfig_pool=
 *pool, ifconfig_pool_handle hand)
 {
diff --git a/src/openvpn/pool=2Eh b/s=
rc/openvpn/pool=2Eh
index 497dcda=2E=2Efda87ed 100644
--- a/src/openvpn/poo=
l=2Eh
+++ b/src/openvpn/pool=2Eh
@@ -98,6 +98,9 @@
  */
 bool ifconfig_pool=
_reserve_ip(struct ifconfig_pool *pool, in_addr_t addr);
 
+/** IPv6 counte=
rpart of ifconfig_pool_reserve_ip()=2E */
+bool ifconfig_pool_reserve_ipv6(=
struct ifconfig_pool *pool, const struct in6_addr *addr);
+
 struct ifconfi=
g_pool_persist *ifconfig_pool_persist_init(const char *filename, int refres=
h_freq);
 
 void ifconfig_pool_persist_close(struct ifconfig_pool_persist *=
persist);
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_=
tests/openvpn/test_misc=2Ec
index 191ab2b=2E=2E0c7d81e 100644
--- a/tests/u=
nit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2E=
c
@@ -568,6 +568,8 @@
     cmocka_unit_test(test_subnet_pools_check_gateway=
),
     cmocka_unit_test(test_subnet_pools_check_range),
     cmocka_unit_t=
est(test_subnet_pools_check_overlap),
+    cmocka_unit_test(test_subnet_poo=
l6_by_name),
+    cmocka_unit_test(test_subnet_pools6_check),
 };
 
 int
di=
ff --git a/tests/unit_tests/openvpn/test_subnet_pool=2Ec b/tests/unit_tests=
/openvpn/test_subnet_pool=2Ec
index 7f40b74=2E=2E43ddb7b 100644
--- a/tests=
/unit_tests/openvpn/test_subnet_pool=2Ec
+++ b/tests/unit_tests/openvpn/tes=
t_subnet_pool=2Ec
@@ -158,3 +158,77 @@
     struct subnet_pool_def adup =3D=
 { =2Enext =3D &bdup, =2Ename =3D "grpA", =2Enetwork =3D 0x0a090000, =2Enet=
mask =3D 0xffffff00, =2Egateway =3D 0x0a090001 };
     assert_false(subnet_=
pools_check(&adup, 0, 0, M_WARN));
 }
+
+/* the IPv6 counterpart resolves i=
ndependently: a name may refer to a v4 pool, a
+ * v6 pool, or both=2E */
+=
void
+test_subnet_pool6_by_name(void **state)
+{
+    struct subnet_pool6_d=
ef c =3D { =2Enext =3D NULL, =2Ename =3D "grpC", =2Enetbits =3D 64 };
+    =
struct subnet_pool6_def b =3D { =2Enext =3D &c, =2Ename =3D "grpB", =2Enetb=
its =3D 96 };
+    struct subnet_pool6_def a =3D { =2Enext =3D &b, =2Ename =
=3D "grpA", =2Enetbits =3D 64 };
+
+    assert_ptr_equal(subnet_pool6_by_na=
me(&a, "grpA"), &a);
+    assert_ptr_equal(subnet_pool6_by_name(&a, "grpB")=
, &b);
+    assert_ptr_equal(subnet_pool6_by_name(&a, "grpC"), &c);
+    as=
sert_int_equal(subnet_pool6_by_name(&a, "grpB")->netbits, 96);
+    assert_=
null(subnet_pool6_by_name(&a, "nope"));
+    assert_null(subnet_pool6_by_na=
me(NULL, "grpA"));
+}
+
+/* <prefix>::<host> as an in6_addr */
+static stru=
ct in6_addr
+in6(const char *addr)
+{
+    struct in6_addr a;
+
+    assert=
_int_equal(inet_pton(AF_INET6, addr, &a), 1);
+    return a;
+}
+
+/* a sin=
gle IPv6 pool, checked against the fd00:8::/64 --server-ipv6 network */
+st=
atic bool
+check6_one(const char *net, unsigned int bits, const char *gw)
+=
{
+    const struct in6_addr server =3D in6("fd00:8::");
+    struct subnet=
_pool6_def d =3D { =2Enext =3D NULL, =2Ename =3D "grp", =2Enetwork =3D in6(=
net), =2Enetbits =3D bits, =2Egateway =3D in6(gw) };
+
+    return subnet_p=
ools6_check(&d, &server, 64, M_WARN);
+}
+
+void
+test_subnet_pools6_check(=
void **state)
+{
+    /* /64 =2E=2E /124, any host address of the network a=
s gateway */
+    assert_true(check6_one("fd00:9::", 64, "fd00:9::1"));
+  =
  assert_true(check6_one("fd00:9::", 124, "fd00:9::1"));
+    assert_true(c=
heck6_one("fd00:9::", 112, "fd00:9::ffff"));
+    assert_false(check6_one("=
fd00:9::", 63, "fd00:9::1"));
+    assert_false(check6_one("fd00:9::", 125,=
 "fd00:9::1"));
+
+    /* host bits in the network, gateway =3D network or =
outside it */
+    assert_false(check6_one("fd00:9::5", 64, "fd00:9::1"));
=
+    assert_false(check6_one("fd00:9::", 64, "fd00:9::"));
+    assert_fals=
e(check6_one("fd00:9::", 64, "fd00:a::1"));
+
+    /* overlapping the --ser=
ver-ipv6 network, inside or covering it */
+    assert_false(check6_one("fd=
00:8::", 96, "fd00:8::1"));
+
+    /* two pools: disjoint, overlapping, sam=
e name */
+    const struct in6_addr server =3D in6("fd00:8::");
+    struc=
t subnet_pool6_def b =3D { =2Enext =3D NULL, =2Ename =3D "grpB", =2Enetwork=
 =3D in6("fd00:a::"), =2Enetbits =3D 64, =2Egateway =3D in6("fd00:a::1") };=

+    struct subnet_pool6_def a =3D { =2Enext =3D &b, =2Ename =3D "grpA", =
=2Enetwork =3D in6("fd00:9::"), =2Enetbits =3D 64, =2Egateway =3D in6("fd00=
:9::1") };
+
+    assert_true(subnet_pools6_check(&a, &server, 64, M_WARN))=
;
+    assert_true(subnet_pools6_check(&a, &server, 0, M_WARN));
+
+    /* =
a /120 grpB inside grpA */
+    struct subnet_pool6_def bin =3D { =2Enext =
=3D NULL, =2Ename =3D "grpB", =2Enetwork =3D in6("fd00:9::100"), =2Enetbits=
 =3D 120, =2Egateway =3D in6("fd00:9::101") };
+    struct subnet_pool6_def=
 ain =3D { =2Enext =3D &bin, =2Ename =3D "grpA", =2Enetwork =3D in6("fd00:9=
::"), =2Enetbits =3D 64, =2Egateway =3D in6("fd00:9::1") };
+    assert_fal=
se(subnet_pools6_check(&ain, &server, 64, M_WARN));
+
+    /* the same name=
 defined twice */
+    struct subnet_pool6_def bdup =3D { =2Enext =3D NULL,=
 =2Ename =3D "grpA", =2Enetwork =3D in6("fd00:a::"), =2Enetbits =3D 64, =2E=
gateway =3D in6("fd00:a::1") };
+    struct subnet_pool6_def adup =3D { =2E=
next =3D &bdup, =2Ename =3D "grpA", =2Enetwork =3D in6("fd00:9::"), =2Enetb=
its =3D 64, =2Egateway =3D in6("fd00:9::1") };
+    assert_false(subnet_poo=
ls6_check(&adup, &server, 64, M_WARN));
+}
diff --git a/tests/unit_tests/op=
envpn/test_subnet_pool=2Eh b/tests/unit_tests/openvpn/test_subnet_pool=2Eh
=
index 07ba374=2E=2Ee4df687 100644
--- a/tests/unit_tests/openvpn/test_subne=
t_pool=2Eh
+++ b/tests/unit_tests/openvpn/test_subnet_pool=2Eh
@@ -34,4 +34=
,8 @@
 
 void test_subnet_pools_check_overlap(void **state);
 
+void test_s=
ubnet_pool6_by_name(void **state);
+
+void test_subnet_pools6_check(void **=
state);
+
 #endif

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1786?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I64e0850d48647a2c0e3d385c2f20a9f445931727
Gerrit-Change-Number: 1786
Ger=
rit-PatchSet: 12
Gerrit-Owner: Antonio Quartulli <antonio@mandelbit=2Ecom>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Antoni=
o Quartulli <antonio@mandelbit=2Ecom>

--GNcWJQxpf20=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli=2E </p>
<p>Antonio Quartulli <stron=
g>uploaded patch set #12</strong> to this change=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">multi: assign IPv6 addresses from a named subnet-pool<br><br>A=
dd the IPv6 counterpart of --subnet-pool:<br><br>  subnet-pool-ipv6 &lt;nam=
e&gt; &lt;network&gt;/&lt;bits&gt; [&lt;gateway&gt;]  (main config)<br><br>=
selected by the same per-client --subnet-pool-name=2E A client&#39;s name i=
s<br>resolved against the IPv6 pool list too and, when it matches, an IPv6<=
br>address is handed out from the group&#39;s pool alongside any IPv4 one (=
a<br>single dual-stack ifconfig_pool per name)=2E The pool gateway is pushe=
d as<br>the remote end of the client&#39;s ifconfig-ipv6, as the server&#39=
;s own<br>address is off-link for it=2E A name matching neither family is s=
till<br>declined with AUTH_FAILED=2E<br><br>As for IPv4 the pools are check=
ed when the config is loaded (network<br>between /64 and /124 without host =
bits, gateway a host address inside<br>it, unique names, no overlap with an=
other pool or the --server-ipv6<br>network), created at startup with their =
gateway reserved, and routed<br>into the server&#39;s tun device=2E<br><br>=
Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727<br>GitHub: closes open=
vpn/OpenVPN#987<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=
=2Ecom&gt;<br>---<br>M doc/man-sections/server-options=2Erst<br>M src/openv=
pn/multi=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M=
 src/openvpn/options_util=2Ec<br>M src/openvpn/options_util=2Eh<br>M src/op=
envpn/pool=2Ec<br>M src/openvpn/pool=2Eh<br>M tests/unit_tests/openvpn/test=
_misc=2Ec<br>M tests/unit_tests/openvpn/test_subnet_pool=2Ec<br>M tests/uni=
t_tests/openvpn/test_subnet_pool=2Eh<br>11 files changed, 406 insertions(+)=
, 34 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/86/1786/12</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-=
sections/server-options=2Erst b/doc/man-sections/server-options=2Erst</span=
><br><span>index b9ed47a=2E=2E138fcc9 100644</span><br><span>--- a/doc/man-=
sections/server-options=2Erst</span><br><span>+++ b/doc/man-sections/server=
-options=2Erst</span><br><span>@@ -366,11 +366,32 @@</span><br><span>   and=
 FreeBSD the IPv4 route is installed on-link, without a gateway, so its</sp=
an><br><span>   ``route_gateway_{n}`` is not set for ``--route-up`` scripts=
=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+--subnet-pool-ipv6 args</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  The IPv6 counterpart of ``--subnet-pool``=2E Repeatable main-config=
 directive=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  Valid syntax:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  ::</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     subnet-pool-ipv6 name network/bits [gateway]</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  ``bits`` must be between 64 and 124; ``gateway`` d=
efaults to the first</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  address of the network, is never assigned to a client, and is pushed to =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  pool&#39;s cli=
ents as the remote end of their ``ifconfig-ipv6``=2E A name may refer to</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  an IPv4 pool, an IPv=
6 pool, or both; a client referencing it with</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  ``--subnet-pool-name`` is then assigned an addr=
ess from each family the name</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  defines=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Requires ``--s=
erver-ipv6`` with ``--dev tun`` and ``--topology subnet``=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  ``network`` must have no host bi=
ts set, ``gateway`` must be a host address</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  inside it, each ``name`` may be defined only once =
and no pool may overlap</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  another one or the ``--server-ipv6`` network=2E As for ``--subnet-poo=
l``, the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  server ro=
utes each pool&#39;s network into the tun device=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --subnet-pool-name name=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Assign this client =
to the ``--subnet-pool`` named ``name``=2E Must be</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-  associated with a specific client instance v=
ia ``--client-config-dir`` or</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  ``--client-connect``=2E Several clients may reference the same na=
me and are</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  then serv=
ed from the same shared pool=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  Assign this client to the ``--subnet-pool`` / ``--subnet-pool=
-ipv6`` named</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``na=
me``=2E Must be associated with a specific client instance via</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  ``--client-config-dir`` or ``-=
-client-connect``=2E Several clients may</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  reference the same name and are then served from the=
 same shared pool(s)=2E</span><br><span> </span><br><span> --ifconfig-ipv6-=
push args</span><br><span>   for ``--client-config-dir`` per-client static =
IPv6 interface</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/ope=
nvpn/multi=2Ec</span><br><span>index 150660c=2E=2Eda01f8a 100644</span><br>=
<span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=
=2Ec</span><br><span>@@ -393,6 +393,10 @@</span><br><span>     {</span><br>=
<span>         multi_get_group_pool(m, &amp;t-&gt;options, d-&gt;name);</sp=
an><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    for (const struct subnet_pool6_def *d =3D t-&gt;options=2Esubnet_pools_=
ipv6; d; d =3D d-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 multi_get_group_pool(m, &amp;t-&gt;options, d-&gt;name);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><sp=
an>     /*</span><br><span>      * Help us keep track of routing table=2E</=
span><br><span>@@ -1471,16 +1475,31 @@</span><br><span>     }</span><br><sp=
an> </span><br><span>     const struct subnet_pool_def *d4 =3D subnet_pool_=
by_name(o-&gt;subnet_pools, name);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    ASSERT(d4);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const struct subnet_pool6_def *d6 =3D subnet_pool6_by_name(o-&=
gt;subnet_pools_ipv6, name);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const char *pool_name =3D d4 ? d4-&gt;name : (d6 ? d6-&gt;name=
 : NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT=
(pool_name);</span><br><span>     ALLOC_OBJ_CLEAR(sp, struct subnet_pool);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sp-&gt;name =3D d4=
-&gt;name;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* the =
configured dynamic range, or else every host address of the</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-     * subnet, minus the gateway rese=
rved below if it falls inside it */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    const in_addr_t start =3D d4-&gt;pool_start ? d4-&gt;pool=
_start : d4-&gt;network + 1;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    const in_addr_t end =3D d4-&gt;pool_end ? d4-&gt;pool_end : (d4-=
&gt;network | ~d4-&gt;netmask) - 1;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    sp-&gt;pool =3D ifconfig_pool_init(true, IFCONFIG_POOL_IN=
DIV, start, end, o-&gt;duplicate_cn, false,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                  in6addr_any, 0);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifconfig_pool_reserv=
e_ip(sp-&gt;pool, d4-&gt;gateway);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    sp-&gt;name =3D pool_name;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* the IPv4 range (configured, or else every =
host address of the subnet)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * and every host address of the IPv6 network, minus the gatewa=
ys reserved</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * b=
elow (the IPv4 and the IPv6 address of a client share one pool handle) */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t start =
=3D 0, end =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (d4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        start =3D d4-&gt=
;pool_start ? d4-&gt;pool_start : d4-&gt;network + 1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        end =3D d4-&gt;pool_end ? d4-&gt;=
pool_end : (d4-&gt;network | ~d4-&gt;netmask) - 1;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    sp-&gt;pool =3D ifconfig_pool_init(d4 !=3D NULL, IFCON=
FIG_POOL_INDIV, start, end, o-&gt;duplicate_cn,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                  d6 !=3D NULL,=
 d6 ? add_in6_addr(d6-&gt;network, 1) : in6addr_any,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                  d6 ? (i=
nt)d6-&gt;netbits : 0);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (d4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ifconfig_p=
ool_reserve_ip(sp-&gt;pool, d4-&gt;gateway);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (d6)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ifc=
onfig_pool_reserve_ipv6(sp-&gt;pool, &amp;d6-&gt;gateway);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     sp-&gt;ne=
xt =3D m-&gt;subnet_pools;</span><br><span>     m-&gt;subnet_pools =3D sp;<=
/span><br><span>     return sp-&gt;pool;</span><br><span>@@ -1514,6 +1533,1=
9 @@</span><br><span>             mi-&gt;context=2Eoptions=2Esubnet_pool_ga=
teway =3D d-&gt;gateway;</span><br><span>         }</span><br><span>     }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;conte=
xt=2Eoptions=2Esubnet_pool_name)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       const struct subnet_pool6_def *d =3D subnet_pool6_by_name(</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            m-&gt;top=2Eoptio=
ns=2Esubnet_pools_ipv6, mi-&gt;context=2Eoptions=2Esubnet_pool_name);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        mi-&gt;context=2Eoptions=2Esubnet_po=
ol_ipv6_defined =3D d !=3D NULL;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (d)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_network =3D d-&gt;net=
work;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi=
-&gt;context=2Eoptions=2Esubnet_pool_ipv6_netbits =3D d-&gt;netbits;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=
=2Eoptions=2Esubnet_pool_ipv6_gateway =3D d-&gt;gateway;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     /*<=
/span><br><span>      * If ifconfig addresses were set by dynamic config fi=
le,</span><br><span>@@ -1548,15 +1580,16 @@</span><br><span>               =
  &quot;MULTI_sva: WARNING: if --ifconfig-push is used for IPv4, automatic =
IPv6 assignment from --ifconfig-ipv6-pool does not work=2E  Use --ifconfig-=
ipv6-push for IPv6 then=2E&quot;);</span><br><span>         }</span><br><sp=
an>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if =
(mi-&gt;context=2Eoptions=2Esubnet_pool_defined)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    else if (mi-&gt;context=2Eoptions=2Esubnet=
_pool_defined</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
       || mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_defined)</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* =
dynamic address from this client&#39;s --subnet-pool group */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        /* dynamic address(es) fr=
om this client&#39;s --subnet-pool group */</span><br><span>         struct=
 ifconfig_pool *group =3D</span><br><span>             multi_get_group_pool=
(m, &amp;m-&gt;top=2Eoptions, mi-&gt;context=2Eoptions=2Esubnet_pool_name);=
</span><br><span> </span><br><span>         /* the address may have been ac=
quired before the name was known (from</span><br><span>          * the glob=
al pool) or for a name that a later handler overrode: drop</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-         * it so we serve this client =
from its current group */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+         * it so we serve this client from its current group only */<=
/span><br><span>         if (mi-&gt;vaddr_handle &gt;=3D 0 &amp;&amp; mi-&g=
t;vaddr_pool !=3D group)</span><br><span>         {</span><br><span>       =
      ifconfig_pool_release(mi-&gt;vaddr_pool ? mi-&gt;vaddr_pool : m-&gt;i=
fconfig_pool,</span><br><span>@@ -1571,30 +1604,52 @@</span><br><span>     =
    if (mi-&gt;vaddr_handle &lt; 0)</span><br><span>         {</span><br><s=
pan>             in_addr_t local =3D 0, remote =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            struct in6_addr remote_ipv6;<=
/span><br><span>             const char *cn =3D NULL;</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            CLEAR(remot=
e_ipv6);</span><br><span>             if (!mi-&gt;context=2Eoptions=2Edupli=
cate_cn)</span><br><span>             {</span><br><span>                 cn=
 =3D tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, true);</span><br><spa=
n>             }</span><br><span> </span><br><span>             mi-&gt;vadd=
r_pool =3D group;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        mi-&gt;vaddr_handle =3D ifconfig_pool_acquire(mi-&gt;vaddr_pool, &a=
mp;local, &amp;remote, NULL, cn);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            if (mi-&gt;vaddr_handle &gt;=3D 0)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                mi-&gt;context=2Ec2=2Epush_ifc=
onfig_local =3D remote;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                mi-&gt;context=2Ec2=2Epush_ifconfig_remote_netmask =3D</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    mi-&=
gt;context=2Eoptions=2Esubnet_pool_netmask;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                mi-&gt;context=2Ec2=2Epush_ifconfig_d=
efined =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_INFO=
, &quot;MULTI_sva: --subnet-pool &#39;%s&#39; returned IPv4=3D%s&quot;,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    mi-&g=
t;context=2Eoptions=2Esubnet_pool_name, print_in_addr_t(remote, 0, &amp;gc)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            else</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;vaddr_handl=
e =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  ifconfig_pool_acquire(mi-&gt;vaddr_pool, &amp;local, &amp;remote, &amp;re=
mote_ipv6, cn);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (mi-&gt;vaddr_handle &lt; 0)</span><br><span>             {</spa=
n><br><span>                 msg(D_MULTI_ERRORS, &quot;MULTI: no free --sub=
net-pool &#39;%s&#39; addresses are available for %s&quot;,</span><br><span=
>                     mi-&gt;context=2Eoptions=2Esubnet_pool_name, multi_in=
stance_string(mi, false, &amp;gc));</span><br><span>             }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                if (mi-&gt;context=2E=
options=2Esubnet_pool_defined)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    mi-&gt;context=2Ec2=2Epush_ifconfig_local =3D =
remote;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        mi-&gt;context=2Ec2=2Epush_ifconfig_remote_netmask =3D</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        mi-&gt;c=
ontext=2Eoptions=2Esubnet_pool_netmask;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    mi-&gt;context=2Ec2=2Epush_ifconfig=
_defined =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             if (mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_defined)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    /* the =
server&#39;s own address is off-link for this client:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                     * hand out the pool =
gateway as the remote end instead */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    mi-&gt;context=2Ec2=2Epush_ifconfig_ip=
v6_local =3D remote_ipv6;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_remote =
=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
        mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_gateway;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    mi-&gt;context=
=2Ec2=2Epush_ifconfig_ipv6_netbits =3D</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                        mi-&gt;context=2Eoptions=2Esubne=
t_pool_ipv6_netbits;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_defined =3D t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                msg(M_INFO, &quot;MU=
LTI_sva: --subnet-pool &#39;%s&#39; returned IPv4=3D%s, IPv6=3D%s&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    mi=
-&gt;context=2Eoptions=2Esubnet_pool_name,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    mi-&gt;context=2Eoptions=2Esubne=
t_pool_defined ? print_in_addr_t(remote, 0, &amp;gc)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
                   : &quot;(Not enabled)&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    mi-&gt;context=2Eoptions=2E=
subnet_pool_ipv6_defined</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                        ? print_in6_addr(remote_ipv6, 0, &amp;gc)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
: &quot;(Not enabled)&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span>         }</span><br><span>     }</=
span><br><span>     else if (m-&gt;ifconfig_pool &amp;&amp; mi-&gt;vaddr_ha=
ndle &lt; 0) /* otherwise, choose a pool address */</span><br><span>@@ -293=
5,7 +2990,9 @@</span><br><span>     }</span><br><span> </span><br><span>   =
  if (mi-&gt;context=2Eoptions=2Esubnet_pool_name</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        &amp;&amp; !subnet_pool_by_name(m-&gt;t=
op=2Eoptions=2Esubnet_pools, mi-&gt;context=2Eoptions=2Esubnet_pool_name))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !=
subnet_pool_by_name(m-&gt;top=2Eoptions=2Esubnet_pools, mi-&gt;context=2Eop=
tions=2Esubnet_pool_name)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        &amp;&amp; !subnet_pool6_by_name(m-&gt;top=2Eoptions=2Esubnet=
_pools_ipv6,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                          mi-&gt;context=2Eoptions=2Esubnet_pool_name))</sp=
an><br><span>     {</span><br><span>         msg(D_MULTI_ERRORS, &quot;MULT=
I: client has been rejected due to unknown --subnet-pool-name &#39;%s&#39;&=
quot;,</span><br><span>             mi-&gt;context=2Eoptions=2Esubnet_pool_=
name);</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/o=
ptions=2Ec</span><br><span>index cae6a28=2E=2E089b35d 100644</span><br><spa=
n>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=
=2Ec</span><br><span>@@ -457,6 +457,8 @@</span><br><span>     &quot;       =
           pool of addresses outside the --server network, selected\n&quot;=
</span><br><span>     &quot;                  per client with --subnet-pool=
-name=2E start/end restrict the\n&quot;</span><br><span>     &quot;        =
          dynamically assigned range=2E\n&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    &quot;--subnet-pool-ipv6 name network/bits =
[gateway] : IPv6 counterpart of\n&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    &quot;                  --subnet-pool=2E\n&quot;</s=
pan><br><span>     &quot;--subnet-pool-name name : Assign this client to th=
e --subnet-pool named name=2E\n&quot;</span><br><span>     &quot;          =
        Only valid in a client-specific config file=2E\n&quot;</span><br><s=
pan>     &quot;--ifconfig-push local remote-netmask : Push an ifconfig opti=
on to remote,\n&quot;</span><br><span>@@ -1919,6 +1921,20 @@</span><br><spa=
n>             subnet_pools_check(options-&gt;subnet_pools, options-&gt;ser=
ver_network,</span><br><span>                                options-&gt;se=
rver_netmask, M_USAGE);</span><br><span>         }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (options-&gt;subnet_pools_ipv6)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            if (!options-&gt;se=
rver_ipv6_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         msg(M_USAGE, &quot;--subnet-pool-ipv6 requires --server-ipv6&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (dev_typ=
e_enum(options-&gt;dev, options-&gt;dev_type) !=3D DEV_TYPE_TUN</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                || options-&gt;=
topology !=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                msg(M_USAGE, &quot;--subnet-pool-ipv6 requires --dev tun an=
d --topology subnet&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            subnet_pools6_check(options-&gt;subnet_pools_ipv6, &amp;optio=
ns-&gt;server_network_ipv6,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                options-&gt;server_netbits_ipv6, M_=
USAGE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span>         MUST_BE_UNDEF(allow_recursive_routing, &quot;allow-r=
ecursive-routing&quot;);</span><br><span>         if (options-&gt;auth_user=
_pass_file)</span><br><span>         {</span><br><span>@@ -1986,6 +2002,7 @=
@</span><br><span>         MUST_BE_UNDEF(ifconfig_pool_persist_filename, &q=
uot;ifconfig-pool-persist&quot;);</span><br><span>         MUST_BE_UNDEF(if=
config_ipv6_pool_defined, &quot;ifconfig-ipv6-pool&quot;);</span><br><span>=
         MUST_BE_UNDEF(subnet_pools, &quot;subnet-pool&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(subnet_poo=
ls_ipv6, &quot;subnet-pool-ipv6&quot;);</span><br><span>         MUST_BE_UN=
DEF(real_hash_size, &quot;hash-size&quot;);</span><br><span>         MUST_B=
E_UNDEF(virtual_hash_size, &quot;hash-size&quot;);</span><br><span>        =
 MUST_BE_UNDEF(learn_address_script, &quot;learn-address&quot;);</span><br>=
<span>@@ -3119,8 +3136,9 @@</span><br><span> }</span><br><span> </span><br>=
<span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * The serve=
r&#39;s tun device is only configured with the --server network, so</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * route each --subnet-pool n=
etwork into it as well: without this the server</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * The server&#39;s tun device is only configur=
ed with the --server and</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * --server-ipv6 networks, so route each --subnet-pool and --subnet-po=
ol-ipv6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * network i=
nto it as well: without this the server</span><br><span>  * could not reach=
 its subnet-pool clients when the data channel runs in</span><br><span>  * =
userspace=2E  Under DCO on Linux and FreeBSD the routes are installed on-li=
nk,</span><br><span>  * see subnet_pool_routes_onlink()=2E</span><br><span>=
@@ -3138,6 +3156,16 @@</span><br><span>                                    =
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
 sp-&gt;name =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        sp-&gt;network =3D network;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        sp-&gt;netbits =3D netbits;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;gateway =3D p[3] ? gatewa=
y : add_in6_addr(network, 1);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        sp-&gt;next =3D options-&gt;subnet_pools_ipv6;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;subnet_poo=
ls_ipv6 =3D sp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span>     else if (streq(p[0], &quot;subnet-pool-name&quot;) &=
amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>   =
      VERIFY_PERMISSION(OPT_P_INSTANCE);</span><br><span>diff --git a/src/o=
penvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index fcfb9e2=
=2E=2Ea9c6b22 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><b=
r><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -267,6 +267,16 @@<=
/span><br><span>     in_addr_t pool_end;</span><br><span> };</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The IPv6 coun=
terpart of struct subnet_pool_def (--subnet-pool-ipv6)=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+struct subnet_pool6_def</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct subnet_pool6_def *next;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const char *name;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr network;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int netbi=
ts;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct in6_a=
ddr gateway;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Com=
mand line options */</span><br><span> struct options</span><br><span> {</sp=
an><br><span>@@ -533,12 +543,17 @@</span><br><span>     bool push_ifconfig_=
constraint_defined;</span><br><span>     in_addr_t push_ifconfig_constraint=
_network;</span><br><span>     in_addr_t push_ifconfig_constraint_netmask;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct subnet_pool=
_def *subnet_pools; /* named pools (server config) */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const char *subnet_pool_name;         /=
* which pool this client uses (CCD) */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    bool subnet_pool_defined;             /* resolved from=
 the name at connect */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct subnet_pool_def *subnet_pools;       /* named IPv4 pools (se=
rver config) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct subnet_pool6_def *subnet_pools_ipv6; /* named IPv6 pools (server con=
fig) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ch=
ar *subnet_pool_name;               /* which pool this client uses (CCD) */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool subnet_poo=
l_defined;                   /* resolved from the name at connect */</span>=
<br><span>     in_addr_t subnet_pool_network;</span><br><span>     in_addr_=
t subnet_pool_netmask;</span><br><span>     in_addr_t subnet_pool_gateway;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool subnet_pool=
_ipv6_defined; /* resolved from the name at connect */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr subnet_pool_ipv6_net=
work;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned i=
nt subnet_pool_ipv6_netbits;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct in6_addr subnet_pool_ipv6_gateway;</span><br><span>    =
 bool push_ifconfig_ipv4_blocked;           /* IPv4 */</span><br><span>    =
 bool push_ifconfig_ipv6_defined;           /* IPv6 */</span><br><span>    =
 struct in6_addr push_ifconfig_ipv6_local;  /* IPv6 */</span><br><span>diff=
 --git a/src/openvpn/options_util=2Ec b/src/openvpn/options_util=2Ec</span>=
<br><span>index bb52fe7=2E=2E808afa6 100644</span><br><span>--- a/src/openv=
pn/options_util=2Ec</span><br><span>+++ b/src/openvpn/options_util=2Ec</spa=
n><br><span>@@ -130,6 +130,108 @@</span><br><span>     return true;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* value of bit &lt;i&gt; (0 =3D most significant) of an IPv6 add=
ress */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+in6_bit(const struct=
 in6_addr *a, unsigned int i)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn a-&gt;s6_addr[i / 8] &amp; (0x80 &gt;&gt; (i % 8));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
 true if the first &lt;bits&gt; bits of the two addresses are equal */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+in6_prefix_equal(const struct in=
6_addr *a, const struct in6_addr *b, unsigned int bits)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (unsigned int i =3D 0; i &lt; bits; ++i)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (in6_bit(a, i) !=3D in6_bit(b,=
 i))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            return false;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* tru=
e if every bit of &lt;a&gt; from bit &lt;from&gt; on is zero */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+in6_suffix_zero(const struct in6_addr *=
a, unsigned int from)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (unsigne=
d int i =3D from; i &lt; 128; ++i)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (in6_bit(a, i))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          return false;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
subnet_pools6_check(const struct subnet_pool6_def *pools, const struct in6_=
addr *server_network,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    unsigned int server_netbits, msglvl_t msglevel)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (const struct subnet_pool6_def *d=
 =3D pools; d; d =3D d-&gt;next)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (d-&gt;netbits &lt; 64 || d-&gt;netbits &gt; 124)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--subnet-pool=
-ipv6 %s: network must be between /64 and /124 (not /%u)&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                d-&gt;name, d-&=
gt;netbits);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (!in6_suffix_zero(&=
amp;d-&gt;network, d-&gt;netbits))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            msg(msglevel, &quot;--subnet-pool-ipv6 %s: network has hos=
t bits set&quot;, d-&gt;name);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            return false;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
!in6_prefix_equal(&amp;d-&gt;gateway, &amp;d-&gt;network, d-&gt;netbits)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            || in6_suf=
fix_zero(&amp;d-&gt;gateway, d-&gt;netbits))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            msg(msglevel,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                &quot;--subnet-pool-ipv6 %s: gateway m=
ust be a host address inside the network&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                d-&gt;name);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (server_netbits</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            &amp;&amp; in6_prefix_equal(&amp;d-&gt;ne=
twork, server_network, min_uint(d-&gt;netbits, server_netbits)))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--subnet=
-pool-ipv6 %s: network overlaps the --server-ipv6 network&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                d-&gt;name);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        for (const struct subnet_pool6_def *=
e =3D d-&gt;next; e; e =3D e-&gt;next)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if (!strcmp(d-&gt;name, e-&gt;name))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;--sub=
net-pool-ipv6 %s: name defined more than once&quot;, d-&gt;name);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                return false;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (in6_prefi=
x_equal(&amp;d-&gt;network, &amp;e-&gt;network, min_uint(d-&gt;netbits, e-&=
gt;netbits)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    msg(msglevel, &quot;--subnet-pool-ipv6 %s and %s: networks overlap&quot=
;, d-&gt;name, e-&gt;name);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                return false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+const struct subnet_pool6_def *</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+subnet_pool6_by_name(const struct subnet_pool6_def *pools, =
const char *name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (const struc=
t subnet_pool6_def *d =3D pools; d; d =3D d-&gt;next)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (!strcmp(d-&gt;name, name))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            return d;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> const char *</span><br><span> parse_auth_failed_temp(struct options *o,=
 const char *reason)</span><br><span> {</span><br><span>diff --git a/src/op=
envpn/options_util=2Eh b/src/openvpn/options_util=2Eh</span><br><span>index=
 5fa4735=2E=2Eab8122d1 100644</span><br><span>--- a/src/openvpn/options_uti=
l=2Eh</span><br><span>+++ b/src/openvpn/options_util=2Eh</span><br><span>@@=
 -55,6 +55,25 @@</span><br><span> bool subnet_pools_check(const struct subn=
et_pool_def *pools, in_addr_t server_network,</span><br><span>             =
            in_addr_t server_netmask, msglvl_t msglevel);</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * IPv6 counterpart of subnet_pools=
_check(): network between /64 and /124</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * without host bits, gateway a host address inside it, =
unique names, and no</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * network overlapping another pool or the --server-ipv6 network=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param pools           head of the --s=
ubnet-pool-ipv6 list (may be NULL)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param server_network  the --server-ipv6 network</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param server_netbits  th=
e --server-ipv6 prefix length, or 0 if there is none</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param msglevel        level of the me=
ssage logged on the first error</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @return                true if every definition is valid</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool subnet_pools6_check(const struct s=
ubnet_pool6_def *pools,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                         const struct in6_addr *server_network, unsigne=
d int server_netbits,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                         msglvl_t msglevel);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/** IPv6 counterpart of subnet_pool_by_name()=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+const struct subnet_pool6_def *subn=
et_pool6_by_name(const struct subnet_pool6_def *pools,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                        =
            const char *name);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> </span><br><span> /** Checks if the string is =
a valid integer by checking if it can be</span><br><span>  *  converted to =
an integer */</span><br><span>diff --git a/src/openvpn/pool=2Ec b/src/openv=
pn/pool=2Ec</span><br><span>index 5c5b3fe=2E=2E2cdaa71 100644</span><br><sp=
an>--- a/src/openvpn/pool=2Ec</span><br><span>+++ b/src/openvpn/pool=2Ec</s=
pan><br><span>@@ -446,6 +446,22 @@</span><br><span>     return true;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ifco=
nfig_pool_reserve_ipv6(struct ifconfig_pool *pool, const struct in6_addr *a=
ddr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const ifconfig_pool_handle h =
=3D ifconfig_pool_ipv6_base_to_handle(pool, addr);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (h &lt; 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_entry_free(&amp;p=
ool-&gt;list[h], true);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    pool-&gt;list[h]=2Ein_use =3D true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    pool-&gt;list[h]=2Ereserved =3D true;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> static in_addr_t</span><br><span=
> ifconfig_pool_handle_to_ip_base(const struct ifconfig_pool *pool, ifconfi=
g_pool_handle hand)</span><br><span> {</span><br><span>diff --git a/src/ope=
nvpn/pool=2Eh b/src/openvpn/pool=2Eh</span><br><span>index 497dcda=2E=2Efda=
87ed 100644</span><br><span>--- a/src/openvpn/pool=2Eh</span><br><span>+++ =
b/src/openvpn/pool=2Eh</span><br><span>@@ -98,6 +98,9 @@</span><br><span>  =
*/</span><br><span> bool ifconfig_pool_reserve_ip(struct ifconfig_pool *poo=
l, in_addr_t addr);</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/** IPv6 counterpart of ifconfig_pool_reserve_ip()=2E */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ifconfig_pool_r=
eserve_ipv6(struct ifconfig_pool *pool, const struct in6_addr *addr);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> struct =
ifconfig_pool_persist *ifconfig_pool_persist_init(const char *filename, int=
 refresh_freq);</span><br><span> </span><br><span> void ifconfig_pool_persi=
st_close(struct ifconfig_pool_persist *persist);</span><br><span>diff --git=
 a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_m=
isc=2Ec</span><br><span>index 191ab2b=2E=2E0c7d81e 100644</span><br><span>-=
-- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_misc=2Ec</span><br><span>@@ -568,6 +568,8 @@</span><br=
><span>     cmocka_unit_test(test_subnet_pools_check_gateway),</span><br><s=
pan>     cmocka_unit_test(test_subnet_pools_check_range),</span><br><span> =
    cmocka_unit_test(test_subnet_pools_check_overlap),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_subnet_pool6_b=
y_name),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_=
unit_test(test_subnet_pools6_check),</span><br><span> };</span><br><span> <=
/span><br><span> int</span><br><span>diff --git a/tests/unit_tests/openvpn/=
test_subnet_pool=2Ec b/tests/unit_tests/openvpn/test_subnet_pool=2Ec</span>=
<br><span>index 7f40b74=2E=2E43ddb7b 100644</span><br><span>--- a/tests/uni=
t_tests/openvpn/test_subnet_pool=2Ec</span><br><span>+++ b/tests/unit_tests=
/openvpn/test_subnet_pool=2Ec</span><br><span>@@ -158,3 +158,77 @@</span><b=
r><span>     struct subnet_pool_def adup =3D { =2Enext =3D &amp;bdup, =2Ena=
me =3D &quot;grpA&quot;, =2Enetwork =3D 0x0a090000, =2Enetmask =3D 0xffffff=
00, =2Egateway =3D 0x0a090001 };</span><br><span>     assert_false(subnet_p=
ools_check(&amp;adup, 0, 0, M_WARN));</span><br><span> }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* the IPv6 counterpart resolves independently: a name ma=
y refer to a v4 pool, a</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * v6 pool, or both=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_=
subnet_pool6_by_name(void **state)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct subnet_pool6_def c =3D { =2Enext =3D NULL, =2Ename =3D &quot;grpC&q=
uot;, =2Enetbits =3D 64 };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct subnet_pool6_def b =3D { =2Enext =3D &amp;c, =2Ename =3D =
&quot;grpB&quot;, =2Enetbits =3D 96 };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct subnet_pool6_def a =3D { =2Enext =3D &amp;b, =
=2Ename =3D &quot;grpA&quot;, =2Enetbits =3D 64 };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_ptr_equal(subnet_pool6_by_name(&amp;a, &quot;grpA&qu=
ot;), &amp;a);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_ptr_equal(subnet_pool6_by_name(&amp;a, &quot;grpB&quot;), &amp;b);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(s=
ubnet_pool6_by_name(&amp;a, &quot;grpC&quot;), &amp;c);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(subnet_pool6_by_na=
me(&amp;a, &quot;grpB&quot;)-&gt;netbits, 96);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_null(subnet_pool6_by_name(&amp;a, &qu=
ot;nope&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_null(subnet_pool6_by_name(NULL, &quot;grpA&quot;));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* &lt;prefix&gt;::&lt;host&gt; as an in6_addr */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static struct in6_addr</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+in6(const char *addr)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct in6_addr a;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(inet_pton(AF_INET6, addr, &amp;a), 1);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return a;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* a single IPv6 pool, checked against the fd00:8::/64 --server-ipv6 netw=
ork */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+check6_one(const char=
 *net, unsigned int bits, const char *gw)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const struct in6_addr server =3D in6(&quot;fd00:8::&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6_def=
 d =3D { =2Enext =3D NULL, =2Ename =3D &quot;grp&quot;, =2Enetwork =3D in6(=
net), =2Enetbits =3D bits, =2Egateway =3D in6(gw) };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return subnet_pools6_check(&amp;d, &amp;server, 64, M_WA=
RN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+test_subnet_pools6_check(void **state)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* /64 =2E=2E /124, any host address of the network as gateway=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(=
check6_one(&quot;fd00:9::&quot;, 64, &quot;fd00:9::1&quot;));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(check6_one(&quot;=
fd00:9::&quot;, 124, &quot;fd00:9::1&quot;));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_true(check6_one(&quot;fd00:9::&quot;, =
112, &quot;fd00:9::ffff&quot;));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_false(check6_one(&quot;fd00:9::&quot;, 63, &quot;fd=
00:9::1&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_false(check6_one(&quot;fd00:9::&quot;, 125, &quot;fd00:9::1&quot;))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* host bits in the network, gate=
way =3D network or outside it */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_false(check6_one(&quot;fd00:9::5&quot;, 64, &quot;f=
d00:9::1&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_false(check6_one(&quot;fd00:9::&quot;, 64, &quot;fd00:9::&quot;));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ch=
eck6_one(&quot;fd00:9::&quot;, 64, &quot;fd00:a::1&quot;));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* overlapping the --server-ipv6 network, inside o=
r covering it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_false(check6_one(&quot;fd00:8::&quot;, 96, &quot;fd00:8::1&quot;));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* two pools: disjoint, overlappin=
g, same name */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const struct in6_addr server =3D in6(&quot;fd00:8::&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6_def b =3D {=
 =2Enext =3D NULL, =2Ename =3D &quot;grpB&quot;, =2Enetwork =3D in6(&quot;f=
d00:a::&quot;), =2Enetbits =3D 64, =2Egateway =3D in6(&quot;fd00:a::1&quot;=
) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subn=
et_pool6_def a =3D { =2Enext =3D &amp;b, =2Ename =3D &quot;grpA&quot;, =2En=
etwork =3D in6(&quot;fd00:9::&quot;), =2Enetbits =3D 64, =2Egateway =3D in6=
(&quot;fd00:9::1&quot;) };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(subnet_pools6_check(&amp;a, &amp;server, 64, M_WARN));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(subnet_pools6_check(=
&amp;a, &amp;server, 0, M_WARN));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* a /120 grpB inside grpA */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct subnet_pool6_def bin =3D { =2Enext =3D NULL, =2Ename =
=3D &quot;grpB&quot;, =2Enetwork =3D in6(&quot;fd00:9::100&quot;), =2Enetbi=
ts =3D 120, =2Egateway =3D in6(&quot;fd00:9::101&quot;) };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6_def ain =3D =
{ =2Enext =3D &amp;bin, =2Ename =3D &quot;grpA&quot;, =2Enetwork =3D in6(&q=
uot;fd00:9::&quot;), =2Enetbits =3D 64, =2Egateway =3D in6(&quot;fd00:9::1&=
quot;) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_false(subnet_pools6_check(&amp;ain, &amp;server, 64, M_WARN));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* the same name defined twice */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6_def bdup=
 =3D { =2Enext =3D NULL, =2Ename =3D &quot;grpA&quot;, =2Enetwork =3D in6(&=
quot;fd00:a::&quot;), =2Enetbits =3D 64, =2Egateway =3D in6(&quot;fd00:a::1=
&quot;) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t subnet_pool6_def adup =3D { =2Enext =3D &amp;bdup, =2Ename =3D &quot;grpA=
&quot;, =2Enetwork =3D in6(&quot;fd00:9::&quot;), =2Enetbits =3D 64, =2Egat=
eway =3D in6(&quot;fd00:9::1&quot;) };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_false(subnet_pools6_check(&amp;adup, &amp;ser=
ver, 64, M_WARN));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span>diff --git a/tests/unit_tests/openvpn/test_subnet_pool=2Eh=
 b/tests/unit_tests/openvpn/test_subnet_pool=2Eh</span><br><span>index 07ba=
374=2E=2Ee4df687 100644</span><br><span>--- a/tests/unit_tests/openvpn/test=
_subnet_pool=2Eh</span><br><span>+++ b/tests/unit_tests/openvpn/test_subnet=
_pool=2Eh</span><br><span>@@ -34,4 +34,8 @@</span><br><span> </span><br><sp=
an> void test_subnet_pools_check_overlap(void **state);</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_subnet_pool=
6_by_name(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_subn=
et_pools6_check(void **state);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> #endif</span><br></pre><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail">change 1=
786</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1786 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: Antonio=
 Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>

</body></h=
tml>
--GNcWJQxpf20=--


--===============4942842631746114752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4942842631746114752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4942842631746114752==--

