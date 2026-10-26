Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F344606A31D
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MSOhLzzd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iF4O07xr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TYKurYjk;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YkualtPt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=n2v4FPSNbddRlFtVEF+G+GiJkj6Ggl4u/Wfx/9U8RlM=; b=MSOhLzzdy656Kg26XXtd/aVnsF
	AzKHui2DePNUplB+9XVaS8fd38jWrxn1ez9XPpH9DH5iZmVc1sB4c5PIKy3dgr3FGTMLKvw9606as
	tKQd6Ixk+vrdZPaKqCAN8aNTu1ws6J7g9EvqMbvm9OYuVH3jfwFoxnOEQeIuZZes4BJk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLMSr-0000000050o-0Idb;
	Mon, 26 Oct 2026 15:18:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLMSp-0000000050W-0VHw
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 15:18:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=98tyxXDfJYHPq07m9S5ZnTKKyHmsSu/iGGM6OiuGikk=; b=iF4O07xr9o/e1hk4hoiiasIVDB
 bdyEmy6v2PvgAjVeyFoNwtlOstTnUtpOHGWEEiTdC2ZJnPW4mR0wOL7J39nU8M/S6dsuppkV0D5Yd
 0QwpaDAQBYFhTt6tArP5Vss8bGMm6C/YdPqxu0oqcZcXBTwhweh22tjKPKdD4ZLZNCIc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=98tyxXDfJYHPq07m9S5ZnTKKyHmsSu/iGGM6OiuGikk=; b=TYKurYjk+L4bCsvkioomGOyzoy
 ool8AtDoKXJbm4jerHSR8Q/S3AOEg/UjO/1latzk9bAOHVfNlNVS31ahOUtuyqGdWOvfQXjcdZzfa
 luI4gLPcRYW3WaEd3KzwKLK5UCU85eYYCIs8/oAmAeztFdgTB02cdG9JtWzaZtxcHSHE=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLMSi-000000004rm-0r3p for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 15:18:19 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a2d6cf958bso11094835e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 08:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793027885; x=1793632685; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=98tyxXDfJYHPq07m9S5ZnTKKyHmsSu/iGGM6OiuGikk=;
 b=YkualtPtDt3693Evx6kYtEELbTmO6PW2yu3k4bffMVfc4jTyH88X8Mc6jDyudnfBBj
 7pPUzZxf3tFIQW3/K0dzfRrXsBYuk1HeZn3fimfQ+9Cg/66fAGZPwTD9r/EN2nGhJCOn
 gw//aetHX99OydSCPYP2ULmY/mu3zhLd9UFEND6qW7vDckDw80+Nip05ncG5YseZ2nHw
 u5ELTnjc4P5xmdaU3okgtaM974LHDKWdvNe9h/Tv4w11BSvmRXUmSH3eORk4eBcjXOSR
 U3CET2WDc5ePfs0wTt0VwJka4c7W0AaOYXeYlgmkBEevDL57DAYwil+UyYbYYcyjwdPP
 yNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793027886; x=1793632686;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=98tyxXDfJYHPq07m9S5ZnTKKyHmsSu/iGGM6OiuGikk=;
 b=wQ8c0mSQtEclFjPyf/6B4APns/zmurvdney8uDbNsMg2whnWTarQL83PYnXOeiSEu0
 9d/DwciOABEvP7qX3PT60WfS8o0l7mR8j9AbU9XS2792Chu+GSHAc9Gcqoab4PLH61o7
 lB+vGqpQ44c2zNLqbbHND2leWU302rp+PzwPXYjk+FfSDV8aouyEC2ZDSz/rP1YywQxh
 7sWb5xURMN3viZrO1zYgjl1Dh6t/K4u4M/w5iWcbrIF55PkRpDTFC5OBFcS4JPRDeoVx
 gnqzsHW3QSR7MMb2ocErEggYo99FqVKne2KgYW36vTa7GBEp5i5mxD8RwobxY7CnNk+C
 dJGQ==
X-Gm-Message-State: AFq9FYK3NDD690QUC7CUGwbDxkY09GTwtn6jDu06skiJGuyl5h7itfVn
 /Pa39sCubwAaYToxhtz6xHREJiQtx5LdoiPB7si2cSR/wZebiMUInVfMMvtVuupVzT/Clfqh1gE
 B9+R+xsSeT2gzPQutMoXTfydqUg29mTiaP8usBNtyfTmAfc5LYlCKOW3wsuXuDx5fScSj
X-Gm-Gg: AYBFou0pF++mSjnXrBzxuRSXnyvR1nsEBN4VkUGZogaJTnfoPDJ9JU/VYpxybc/Mq4Y
 4LXWt+ougtrGO6lTZZNZkLEDu0tSv6wASFr6pMBo6YQTv/KiCiJccz61mL9OV/aHzHulaNvK6Yh
 f0VFi8JFGKMg6rX+iuEB0p02hJDd/HkY8olwOw8430J93SeF6qZVDSQwDHnXaSJV+/r2cAQnKz+
 jXvKzPmqqwj6RmMqwzdfRkr7ZiN28oQCwrxgRkVYWJVsNu82MRXHL2kZV7d2OX/XlfBCw6/zQbW
 LvoB4jm3qQIAKkefPUTErbV6DYA24kzkNFwnt6/DkKb0OyTFoMFAqjqBvIIA6HO+S8kderaON4b
 yyrd34et08tVtpKfbe/sgKt/Otq/hmeh1kn874bbDSnXuNYjHkwR0h0dQTpJ9EbS2+Gr4F0BKX8
 +Pp2ga9q/h2yNenfgdjjwnGLW4JD9qZWM2e4UlsQNyxzWpbmc3JPNpz41EqpqEP96Ayx6jOHrHk
 pZtNjEle9MISNoKAPtnZuT2kRFZszuo8UBThpB7iBtQo7JMInAqBXq6EHvwKh+YVnY4kW93kh6U
 F0faRjk6YsGD4W/UWhInQkSiRRV5MVzQtS8umDXqMKTw7Y2ZAsRhsOhLptffzB5eb5C4Ltt5qMs
 EaE/0opr88Kpp3X/wtsw/JDxcUodkQ7K3UrAJsPe7PA==
X-Received: by 2002:a05:600c:5253:b0:4a2:1a:a120 with SMTP id
 5b1f17b1804b1-4a35ac99828mr120811885e9.6.1793027884975; 
 Mon, 26 Oct 2026 08:18:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a55e99fsm205348875e9.4.2026.10.26.08.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 08:18:04 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 15:17:56 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727
X-Gerrit-Change-Number: 1786
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1786?usp=email>
X-Gerrit-Commit: 550f1eb1ed2249cbeb168cf4e73612b337dc2194
In-Reply-To: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
References: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkk2NGUwODUwZDQ4NjQ3YTJjMGUzZDM4NWMyZjIwYTlmNDQ1OTMxNzI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e1a14b90b40dac9f964597fd2005ce8dc2bc2b7f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLMSi-000000004rm-0r3p
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
Content-Type: multipart/mixed; boundary="===============3322770726358044121=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3322770726358044121==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="l0CY/2nraqA="; charset=UTF-8

--l0CY/2nraqA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli=2E

Hello Arne Schw=
abe, 

I'd like you to reexamine a change=2E Please visit

    https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail

to look at the new patch s=
et (#11)=2E


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
11 files changed, 398 insertions(+), 31 deletions(-)


  gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/86/1786/11

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
index 5a832b0=2E=2Efe4a511 100644
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
@@ -1571,27 +1604,44 @@
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
-            }
-            else
=
+            mi->vaddr_handle =3D
+                ifconfig_pool_acquire(mi=
->vaddr_pool, &local, &remote, &remote_ipv6, cn);
+            if (mi->vadd=
r_handle < 0)
             {
                 msg(D_MULTI_ERRORS, "MULTI: n=
o free --subnet-pool addresses are available for %s",
                     =
multi_instance_string(mi, false, &gc));
             }
+            else
+ =
           {
+                if (mi->context=2Eoptions=2Esubnet_pool_defin=
ed)
+                {
+                    mi->context=2Ec2=2Epush_ifconfi=
g_local =3D remote;
+                    mi->context=2Ec2=2Epush_ifconfig_r=
emote_netmask =3D
+                        mi->context=2Eoptions=2Esubnet_p=
ool_netmask;
+                    mi->context=2Ec2=2Epush_ifconfig_defined =
=3D true;
+                }
+                if (mi->context=2Eoptions=2Es=
ubnet_pool_ipv6_defined)
+                {
+                    /* the ser=
ver's own address is off-link for this client:
+                     * hand=
 out the pool gateway as the remote end instead */
+                    mi-=
>context=2Ec2=2Epush_ifconfig_ipv6_local =3D remote_ipv6;
+                =
    mi->context=2Ec2=2Epush_ifconfig_ipv6_remote =3D
+                     =
   mi->context=2Eoptions=2Esubnet_pool_ipv6_gateway;
+                    m=
i->context=2Ec2=2Epush_ifconfig_ipv6_netbits =3D
+                        m=
i->context=2Eoptions=2Esubnet_pool_ipv6_netbits;
+                    mi->c=
ontext=2Ec2=2Epush_ifconfig_ipv6_defined =3D true;
+                }
+    =
        }
         }
     }
     else if (m->ifconfig_pool && mi->vaddr_han=
dle < 0) /* otherwise, choose a pool address */
@@ -2932,7 +2982,9 @@
     =
}
 
     if (mi->context=2Eoptions=2Esubnet_pool_name
-        && !subnet_p=
ool_by_name(m->top=2Eoptions=2Esubnet_pools, mi->context=2Eoptions=2Esubnet=
_pool_name))
+        && !subnet_pool_by_name(m->top=2Eoptions=2Esubnet_poo=
ls, mi->context=2Eoptions=2Esubnet_pool_name)
+        && !subnet_pool6_by_=
name(m->top=2Eoptions=2Esubnet_pools_ipv6,
+                               =
  mi->context=2Eoptions=2Esubnet_pool_name))
     {
         msg(D_MULTI_ER=
RORS, "MULTI: client has been rejected due to unknown --subnet-pool-name '%=
s'",
             mi->context=2Eoptions=2Esubnet_pool_name);
diff --git a/s=
rc/openvpn/options=2Ec b/src/openvpn/options=2Ec
index cae6a28=2E=2E089b35d=
 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -457=
,6 +457,8 @@
     "                  pool of addresses outside the --server=
 network, selected\n"
     "                  per client with --subnet-pool=
-name=2E start/end restrict the\n"
     "                  dynamically assi=
gned range=2E\n"
+    "--subnet-pool-ipv6 name network/bits [gateway] : IPv=
6 counterpart of\n"
+    "                  --subnet-pool=2E\n"
     "--sub=
net-pool-name name : Assign this client to the --subnet-pool named name=2E\=
n"
     "                  Only valid in a client-specific config file=2E\n=
"
     "--ifconfig-push local remote-netmask : Push an ifconfig option to r=
emote,\n"
@@ -1919,6 +1921,20 @@
             subnet_pools_check(options->s=
ubnet_pools, options->server_network,
                                optio=
ns->server_netmask, M_USAGE);
         }
+        if (options->subnet_pools=
_ipv6)
+        {
+            if (!options->server_ipv6_defined)
+        =
    {
+                msg(M_USAGE, "--subnet-pool-ipv6 requires --server-i=
pv6");
+            }
+            if (dev_type_enum(options->dev, options-=
>dev_type) !=3D DEV_TYPE_TUN
+                || options->topology !=3D TOP=
_SUBNET)
+            {
+                msg(M_USAGE, "--subnet-pool-ipv6 r=
equires --dev tun and --topology subnet");
+            }
+            subn=
et_pools6_check(options->subnet_pools_ipv6, &options->server_network_ipv6,
=
+                                options->server_netbits_ipv6, M_USAGE);
+ =
       }
         MUST_BE_UNDEF(allow_recursive_routing, "allow-recursive-r=
outing");
         if (options->auth_user_pass_file)
         {
@@ -1986,6 =
+2002,7 @@
         MUST_BE_UNDEF(ifconfig_pool_persist_filename, "ifconfig=
-pool-persist");
         MUST_BE_UNDEF(ifconfig_ipv6_pool_defined, "ifconf=
ig-ipv6-pool");
         MUST_BE_UNDEF(subnet_pools, "subnet-pool");
+     =
   MUST_BE_UNDEF(subnet_pools_ipv6, "subnet-pool-ipv6");
         MUST_BE_U=
NDEF(real_hash_size, "hash-size");
         MUST_BE_UNDEF(virtual_hash_size=
, "hash-size");
         MUST_BE_UNDEF(learn_address_script, "learn-address=
");
@@ -3119,8 +3136,9 @@
 }
 
 /*
- * The server's tun device is only conf=
igured with the --server network, so
- * route each --subnet-pool network i=
nto it as well: without this the server
+ * The server's tun device is only=
 configured with the --server and
+ * --server-ipv6 networks, so route each=
 --subnet-pool and --subnet-pool-ipv6
+ * network into it as well: without =
this the server
  * could not reach its subnet-pool clients when the data c=
hannel runs in
  * userspace=2E  Under DCO on Linux and FreeBSD the routes =
are installed on-link,
  * see subnet_pool_routes_onlink()=2E
@@ -3138,6 +3=
156,16 @@
                                       o->route_default_table_id)=
;
         ro->on_link =3D subnet_pool_routes_onlink(o);
     }
+
+    for =
(const struct subnet_pool6_def *d =3D o->subnet_pools_ipv6; d; d =3D d->nex=
t)
+    {
+        struct buffer prefix =3D alloc_buf_gc(64, &o->gc);
+
+  =
      buf_printf(&prefix, "%s/%u", print_in6_addr(d->network, 0, &o->gc), d=
->netbits);
+        rol6_check_alloc(o);
+        add_route_ipv6_to_option=
_list(o->routes_ipv6, BSTR(&prefix), NULL, NULL,
+                         =
             o->route_default_table_id);
+    }
 }
 
 static void
@@ -6314,=
6 +6342,37 @@
         sp->next =3D options->subnet_pools;
         options=
->subnet_pools =3D sp;
     }
+    else if (streq(p[0], "subnet-pool-ipv6")=
 && p[1] && p[2] && !p[4])
+    {
+        struct subnet_pool6_def *sp;
+  =
      struct in6_addr network, gateway;
+        unsigned int netbits =3D 0=
;
+
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        if (!get_ipv6_addr(=
p[2], &network, &netbits, msglevel))
+        {
+            msg(msglevel, =
"cannot parse --subnet-pool-ipv6 network");
+            goto err;
+       =
 }
+        if (netbits < 64 || netbits > 124)
+        {
+            msg(=
msglevel, "--subnet-pool-ipv6 network must be between /64 and /124 (not /%u=
)",
+                netbits);
+            goto err;
+        }
+        i=
f (p[3] && !get_ipv6_addr(p[3], &gateway, NULL, msglevel))
+        {
+    =
        msg(msglevel, "cannot parse --subnet-pool-ipv6 gateway");
+        =
    goto err;
+        }
+        ALLOC_OBJ_GC(sp, struct subnet_pool6_def,=
 &options->gc);
+        sp->name =3D p[1];
+        sp->network =3D networ=
k;
+        sp->netbits =3D netbits;
+        sp->gateway =3D p[3] ? gatewa=
y : add_in6_addr(network, 1);
+        sp->next =3D options->subnet_pools_i=
pv6;
+        options->subnet_pools_ipv6 =3D sp;
+    }
     else if (streq=
(p[0], "subnet-pool-name") && p[1] && !p[2])
     {
         VERIFY_PERMISS=
ION(OPT_P_INSTANCE);
diff --git a/src/openvpn/options=2Eh b/src/openvpn/opt=
ions=2Eh
index fcfb9e2=2E=2Ea9c6b22 100644
--- a/src/openvpn/options=2Eh
++=
+ b/src/openvpn/options=2Eh
@@ -267,6 +267,16 @@
     in_addr_t pool_end;
 =
};
 
+/* The IPv6 counterpart of struct subnet_pool_def (--subnet-pool-ipv6=
)=2E */
+struct subnet_pool6_def
+{
+    struct subnet_pool6_def *next;
+  =
  const char *name;
+    struct in6_addr network;
+    unsigned int netbits=
;
+    struct in6_addr gateway;
+};
+
 /* Command line options */
 struct o=
ptions
 {
@@ -533,12 +543,17 @@
     bool push_ifconfig_constraint_defined;=

     in_addr_t push_ifconfig_constraint_network;
     in_addr_t push_ifcon=
fig_constraint_netmask;
-    struct subnet_pool_def *subnet_pools; /* named=
 pools (server config) */
-    const char *subnet_pool_name;         /* whi=
ch pool this client uses (CCD) */
-    bool subnet_pool_defined;           =
  /* resolved from the name at connect */
+    struct subnet_pool_def *subn=
et_pools;       /* named IPv4 pools (server config) */
+    struct subnet_p=
ool6_def *subnet_pools_ipv6; /* named IPv6 pools (server config) */
+    co=
nst char *subnet_pool_name;               /* which pool this client uses (C=
CD) */
+    bool subnet_pool_defined;                   /* resolved from th=
e name at connect */
     in_addr_t subnet_pool_network;
     in_addr_t sub=
net_pool_netmask;
     in_addr_t subnet_pool_gateway;
+    bool subnet_pool=
_ipv6_defined; /* resolved from the name at connect */
+    struct in6_addr=
 subnet_pool_ipv6_network;
+    unsigned int subnet_pool_ipv6_netbits;
+   =
 struct in6_addr subnet_pool_ipv6_gateway;
     bool push_ifconfig_ipv4_blo=
cked;           /* IPv4 */
     bool push_ifconfig_ipv6_defined;           =
/* IPv6 */
     struct in6_addr push_ifconfig_ipv6_local;  /* IPv6 */
diff =
--git a/src/openvpn/options_util=2Ec b/src/openvpn/options_util=2Ec
index b=
b52fe7=2E=2E808afa6 100644
--- a/src/openvpn/options_util=2Ec
+++ b/src/ope=
nvpn/options_util=2Ec
@@ -130,6 +130,108 @@
     return true;
 }
 
+/* valu=
e of bit <i> (0 =3D most significant) of an IPv6 address */
+static bool
+i=
n6_bit(const struct in6_addr *a, unsigned int i)
+{
+    return a->s6_addr[=
i / 8] & (0x80 >> (i % 8));
+}
+
+/* true if the first <bits> bits of the t=
wo addresses are equal */
+static bool
+in6_prefix_equal(const struct in6_a=
ddr *a, const struct in6_addr *b, unsigned int bits)
+{
+    for (unsigned =
int i =3D 0; i < bits; ++i)
+    {
+        if (in6_bit(a, i) !=3D in6_bit(=
b, i))
+        {
+            return false;
+        }
+    }
+    return =
true;
+}
+
+/* true if every bit of <a> from bit <from> on is zero */
+stat=
ic bool
+in6_suffix_zero(const struct in6_addr *a, unsigned int from)
+{
+ =
   for (unsigned int i =3D from; i < 128; ++i)
+    {
+        if (in6_bit(=
a, i))
+        {
+            return false;
+        }
+    }
+    return =
true;
+}
+
+bool
+subnet_pools6_check(const struct subnet_pool6_def *pools,=
 const struct in6_addr *server_network,
+                    unsigned int s=
erver_netbits, msglvl_t msglevel)
+{
+    for (const struct subnet_pool6_de=
f *d =3D pools; d; d =3D d->next)
+    {
+        if (d->netbits < 64 || d-=
>netbits > 124)
+        {
+            msg(msglevel, "--subnet-pool-ipv6 %=
s: network must be between /64 and /124 (not /%u)",
+                d->nam=
e, d->netbits);
+            return false;
+        }
+
+        if (!in6_s=
uffix_zero(&d->network, d->netbits))
+        {
+            msg(msglevel, =
"--subnet-pool-ipv6 %s: network has host bits set", d->name);
+            =
return false;
+        }
+
+        if (!in6_prefix_equal(&d->gateway, &d->=
network, d->netbits)
+            || in6_suffix_zero(&d->gateway, d->netbit=
s))
+        {
+            msg(msglevel,
+                "--subnet-pool-i=
pv6 %s: gateway must be a host address inside the network",
+              =
  d->name);
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
     d->name);
+            return false;
+        }
+
+        for (const =
struct subnet_pool6_def *e =3D d->next; e; e =3D e->next)
+        {
+     =
       if (!strcmp(d->name, e->name))
+            {
+                msg(m=
sglevel, "--subnet-pool-ipv6 %s: name defined more than once", d->name);
+ =
               return false;
+            }
+            if (in6_prefix_equ=
al(&d->network, &e->network, min_uint(d->netbits, e->netbits)))
+          =
  {
+                msg(msglevel, "--subnet-pool-ipv6 %s and %s: networks =
overlap", d->name, e->name);
+                return false;
+            }
=
+        }
+    }
+
+    return true;
+}
+
+const struct subnet_pool6_def *=

+subnet_pool6_by_name(const struct subnet_pool6_def *pools, const char *na=
me)
+{
+    for (const struct subnet_pool6_def *d =3D pools; d; d =3D d->ne=
xt)
+    {
+        if (!strcmp(d->name, name))
+        {
+            ret=
urn d;
+        }
+    }
+    return NULL;
+}
+
 const char *
 parse_auth_f=
ailed_temp(struct options *o, const char *reason)
 {
diff --git a/src/openv=
pn/options_util=2Eh b/src/openvpn/options_util=2Eh
index 5fa4735=2E=2Eab812=
2d1 100644
--- a/src/openvpn/options_util=2Eh
+++ b/src/openvpn/options_uti=
l=2Eh
@@ -55,6 +55,25 @@
 bool subnet_pools_check(const struct subnet_pool_=
def *pools, in_addr_t server_network,
                         in_addr_t se=
rver_netmask, msglvl_t msglevel);
 
+/**
+ * IPv6 counterpart of subnet_poo=
ls_check(): network between /64 and /124
+ * without host bits, gateway a h=
ost address inside it, unique names, and no
+ * network overlapping another=
 pool or the --server-ipv6 network=2E
+ *
+ * @param pools           head o=
f the --subnet-pool-ipv6 list (may be NULL)
+ * @param server_network  the =
--server-ipv6 network
+ * @param server_netbits  the --server-ipv6 prefix l=
ength, or 0 if there is none
+ * @param msglevel        level of the messag=
e logged on the first error
+ * @return                true if every defini=
tion is valid
+ */
+bool subnet_pools6_check(const struct subnet_pool6_def =
*pools,
+                         const struct in6_addr *server_network, un=
signed int server_netbits,
+                         msglvl_t msglevel);
+
=
+/** IPv6 counterpart of subnet_pool_by_name()=2E */
+const struct subnet_p=
ool6_def *subnet_pool6_by_name(const struct subnet_pool6_def *pools,
+     =
                                               const char *name);
+
 
 /** =
Checks if the string is a valid integer by checking if it can be
  *  conve=
rted to an integer */
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
index 191ab2b=2E=2E0c7d81e 100644
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
_pool6_by_name),
+    cmocka_unit_test(test_subnet_pools6_check),
 };
 
 in=
t
diff --git a/tests/unit_tests/openvpn/test_subnet_pool=2Ec b/tests/unit_t=
ests/openvpn/test_subnet_pool=2Ec
index 7f40b74=2E=2E43ddb7b 100644
--- a/t=
ests/unit_tests/openvpn/test_subnet_pool=2Ec
+++ b/tests/unit_tests/openvpn=
/test_subnet_pool=2Ec
@@ -158,3 +158,77 @@
     struct subnet_pool_def adup=
 =3D { =2Enext =3D &bdup, =2Ename =3D "grpA", =2Enetwork =3D 0x0a090000, =
=2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a090001 };
     assert_false(s=
ubnet_pools_check(&adup, 0, 0, M_WARN));
 }
+
+/* the IPv6 counterpart reso=
lves independently: a name may refer to a v4 pool, a
+ * v6 pool, or both=
=2E */
+void
+test_subnet_pool6_by_name(void **state)
+{
+    struct subnet=
_pool6_def c =3D { =2Enext =3D NULL, =2Ename =3D "grpC", =2Enetbits =3D 64 =
};
+    struct subnet_pool6_def b =3D { =2Enext =3D &c, =2Ename =3D "grpB",=
 =2Enetbits =3D 96 };
+    struct subnet_pool6_def a =3D { =2Enext =3D &b, =
=2Ename =3D "grpA", =2Enetbits =3D 64 };
+
+    assert_ptr_equal(subnet_poo=
l6_by_name(&a, "grpA"), &a);
+    assert_ptr_equal(subnet_pool6_by_name(&a,=
 "grpB"), &b);
+    assert_ptr_equal(subnet_pool6_by_name(&a, "grpC"), &c);=

+    assert_int_equal(subnet_pool6_by_name(&a, "grpB")->netbits, 96);
+   =
 assert_null(subnet_pool6_by_name(&a, "nope"));
+    assert_null(subnet_poo=
l6_by_name(NULL, "grpA"));
+}
+
+/* <prefix>::<host> as an in6_addr */
+sta=
tic struct in6_addr
+in6(const char *addr)
+{
+    struct in6_addr a;
+
+  =
  assert_int_equal(inet_pton(AF_INET6, addr, &a), 1);
+    return a;
+}
+
+=
/* a single IPv6 pool, checked against the fd00:8::/64 --server-ipv6 networ=
k */
+static bool
+check6_one(const char *net, unsigned int bits, const cha=
r *gw)
+{
+    const struct in6_addr server =3D in6("fd00:8::");
+    struc=
t subnet_pool6_def d =3D { =2Enext =3D NULL, =2Ename =3D "grp", =2Enetwork =
=3D in6(net), =2Enetbits =3D bits, =2Egateway =3D in6(gw) };
+
+    return =
subnet_pools6_check(&d, &server, 64, M_WARN);
+}
+
+void
+test_subnet_pools=
6_check(void **state)
+{
+    /* /64 =2E=2E /124, any host address of the n=
etwork as gateway */
+    assert_true(check6_one("fd00:9::", 64, "fd00:9::1=
"));
+    assert_true(check6_one("fd00:9::", 124, "fd00:9::1"));
+    asser=
t_true(check6_one("fd00:9::", 112, "fd00:9::ffff"));
+    assert_false(chec=
k6_one("fd00:9::", 63, "fd00:9::1"));
+    assert_false(check6_one("fd00:9:=
:", 125, "fd00:9::1"));
+
+    /* host bits in the network, gateway =3D net=
work or outside it */
+    assert_false(check6_one("fd00:9::5", 64, "fd00:9=
::1"));
+    assert_false(check6_one("fd00:9::", 64, "fd00:9::"));
+    ass=
ert_false(check6_one("fd00:9::", 64, "fd00:a::1"));
+
+    /* overlapping t=
he --server-ipv6 network, inside or covering it */
+    assert_false(check6=
_one("fd00:8::", 96, "fd00:8::1"));
+
+    /* two pools: disjoint, overlapp=
ing, same name */
+    const struct in6_addr server =3D in6("fd00:8::");
+ =
   struct subnet_pool6_def b =3D { =2Enext =3D NULL, =2Ename =3D "grpB", =
=2Enetwork =3D in6("fd00:a::"), =2Enetbits =3D 64, =2Egateway =3D in6("fd00=
:a::1") };
+    struct subnet_pool6_def a =3D { =2Enext =3D &b, =2Ename =3D=
 "grpA", =2Enetwork =3D in6("fd00:9::"), =2Enetbits =3D 64, =2Egateway =3D =
in6("fd00:9::1") };
+
+    assert_true(subnet_pools6_check(&a, &server, 64,=
 M_WARN));
+    assert_true(subnet_pools6_check(&a, &server, 0, M_WARN));
+=

+    /* a /120 grpB inside grpA */
+    struct subnet_pool6_def bin =3D { =
=2Enext =3D NULL, =2Ename =3D "grpB", =2Enetwork =3D in6("fd00:9::100"), =
=2Enetbits =3D 120, =2Egateway =3D in6("fd00:9::101") };
+    struct subnet=
_pool6_def ain =3D { =2Enext =3D &bin, =2Ename =3D "grpA", =2Enetwork =3D i=
n6("fd00:9::"), =2Enetbits =3D 64, =2Egateway =3D in6("fd00:9::1") };
+    =
assert_false(subnet_pools6_check(&ain, &server, 64, M_WARN));
+
+    /* the=
 same name defined twice */
+    struct subnet_pool6_def bdup =3D { =2Enext=
 =3D NULL, =2Ename =3D "grpA", =2Enetwork =3D in6("fd00:a::"), =2Enetbits =
=3D 64, =2Egateway =3D in6("fd00:a::1") };
+    struct subnet_pool6_def adu=
p =3D { =2Enext =3D &bdup, =2Ename =3D "grpA", =2Enetwork =3D in6("fd00:9::=
"), =2Enetbits =3D 64, =2Egateway =3D in6("fd00:9::1") };
+    assert_false=
(subnet_pools6_check(&adup, &server, 64, M_WARN));
+}
diff --git a/tests/un=
it_tests/openvpn/test_subnet_pool=2Eh b/tests/unit_tests/openvpn/test_subne=
t_pool=2Eh
index 07ba374=2E=2Ee4df687 100644
--- a/tests/unit_tests/openvpn=
/test_subnet_pool=2Eh
+++ b/tests/unit_tests/openvpn/test_subnet_pool=2Eh
@=
@ -34,4 +34,8 @@
 
 void test_subnet_pools_check_overlap(void **state);
 
+=
void test_subnet_pool6_by_name(void **state);
+
+void test_subnet_pools6_ch=
eck(void **state);
+
 #endif

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1786?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727
Gerrit-Change-Num=
ber: 1786
Gerrit-PatchSet: 11
Gerrit-Owner: Antonio Quartulli <antonio@mand=
elbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: Antonio Quartulli <antonio@mandelbit=2Ecom>

--l0CY/2nraqA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli=2E </p>
<p>Antonio Quartulli <stron=
g>uploaded patch set #11</strong> to this change=2E</p><p><a href=3D"https:=
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
t_tests/openvpn/test_subnet_pool=2Eh<br>11 files changed, 398 insertions(+)=
, 31 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/86/1786/11</pre><pre style=3D"font-famil=
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
nvpn/multi=2Ec</span><br><span>index 5a832b0=2E=2Efe4a511 100644</span><br>=
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
fconfig_pool,</span><br><span>@@ -1571,27 +1604,44 @@</span><br><span>     =
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
efined =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            e=
lse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&=
gt;vaddr_handle =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                ifconfig_pool_acquire(mi-&gt;vaddr_pool, &amp;local, &amp;r=
emote, &amp;remote_ipv6, cn);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            if (mi-&gt;vaddr_handle &lt; 0)</span><br><span>     =
        {</span><br><span>                 msg(D_MULTI_ERRORS, &quot;MULTI:=
 no free --subnet-pool addresses are available for %s&quot;,</span><br><spa=
n>                     multi_instance_string(mi, false, &amp;gc));</span><b=
r><span>             }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          if (mi-&gt;context=2Eoptions=2Esubnet_pool_defined)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    mi-&gt;context=
=2Ec2=2Epush_ifconfig_local =3D remote;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    mi-&gt;context=2Ec2=2Epush_ifconfig=
_remote_netmask =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        mi-&gt;context=2Eoptions=2Esubnet_pool_netmask;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    mi-=
&gt;context=2Ec2=2Epush_ifconfig_defined =3D true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                if (mi-&gt;context=2Eoptions=
=2Esubnet_pool_ipv6_defined)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    /* the server&#39;s own address is off-link for =
this client:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
              * hand out the pool gateway as the remote end instead */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    mi-&=
gt;context=2Ec2=2Epush_ifconfig_ipv6_local =3D remote_ipv6;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    mi-&gt;context=
=2Ec2=2Epush_ifconfig_ipv6_remote =3D</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                        mi-&gt;context=2Eoptions=2Esubnet=
_pool_ipv6_gateway;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_netbits =3D</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
  mi-&gt;context=2Eoptions=2Esubnet_pool_ipv6_netbits;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    mi-&gt;context=2Ec2=
=2Epush_ifconfig_ipv6_defined =3D true;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span>         }</span><br><span>=
     }</span><br><span>     else if (m-&gt;ifconfig_pool &amp;&amp; mi-&gt;=
vaddr_handle &lt; 0) /* otherwise, choose a pool address */</span><br><span=
>@@ -2932,7 +2982,9 @@</span><br><span>     }</span><br><span> </span><br><=
span>     if (mi-&gt;context=2Eoptions=2Esubnet_pool_name</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; !subnet_pool_by_name=
(m-&gt;top=2Eoptions=2Esubnet_pools, mi-&gt;context=2Eoptions=2Esubnet_pool=
_name))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp=
;&amp; !subnet_pool_by_name(m-&gt;top=2Eoptions=2Esubnet_pools, mi-&gt;cont=
ext=2Eoptions=2Esubnet_pool_name)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        &amp;&amp; !subnet_pool6_by_name(m-&gt;top=2Eoptions=
=2Esubnet_pools_ipv6,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                 mi-&gt;context=2Eoptions=2Esubnet_pool_n=
ame))</span><br><span>     {</span><br><span>         msg(D_MULTI_ERRORS, &=
quot;MULTI: client has been rejected due to unknown --subnet-pool-name &#39=
;%s&#39;&quot;,</span><br><span>             mi-&gt;context=2Eoptions=2Esub=
net_pool_name);</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/=
openvpn/options=2Ec</span><br><span>index cae6a28=2E=2E089b35d 100644</span=
><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/=
options=2Ec</span><br><span>@@ -457,6 +457,8 @@</span><br><span>     &quot;=
                  pool of addresses outside the --server network, selected\=
n&quot;</span><br><span>     &quot;                  per client with --subn=
et-pool-name=2E start/end restrict the\n&quot;</span><br><span>     &quot; =
                 dynamically assigned range=2E\n&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    &quot;--subnet-pool-ipv6 name networ=
k/bits [gateway] : IPv6 counterpart of\n&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &quot;                  --subnet-pool=2E\n&q=
uot;</span><br><span>     &quot;--subnet-pool-name name : Assign this clien=
t to the --subnet-pool named name=2E\n&quot;</span><br><span>     &quot;   =
               Only valid in a client-specific config file=2E\n&quot;</span=
><br><span>     &quot;--ifconfig-push local remote-netmask : Push an ifconf=
ig option to remote,\n&quot;</span><br><span>@@ -1919,6 +1921,20 @@</span><=
br><span>             subnet_pools_check(options-&gt;subnet_pools, options-=
&gt;server_network,</span><br><span>                                options=
-&gt;server_netmask, M_USAGE);</span><br><span>         }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt;subnet_pools_=
ipv6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!options=
-&gt;server_ipv6_defined)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                msg(M_USAGE, &quot;--subnet-pool-ipv6 requires --server-ipv=
6&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (=
dev_type_enum(options-&gt;dev, options-&gt;dev_type) !=3D DEV_TYPE_TUN</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                || optio=
ns-&gt;topology !=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                msg(M_USAGE, &quot;--subnet-pool-ipv6 requires --dev=
 tun and --topology subnet&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            subnet_pools6_check(options-&gt;subnet_pools_ipv6, &am=
p;options-&gt;server_network_ipv6,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                options-&gt;server_netbits_i=
pv6, M_USAGE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span>         MUST_BE_UNDEF(allow_recursive_routing, &quot;=
allow-recursive-routing&quot;);</span><br><span>         if (options-&gt;au=
th_user_pass_file)</span><br><span>         {</span><br><span>@@ -1986,6 +2=
002,7 @@</span><br><span>         MUST_BE_UNDEF(ifconfig_pool_persist_filen=
ame, &quot;ifconfig-pool-persist&quot;);</span><br><span>         MUST_BE_U=
NDEF(ifconfig_ipv6_pool_defined, &quot;ifconfig-ipv6-pool&quot;);</span><br=
><span>         MUST_BE_UNDEF(subnet_pools, &quot;subnet-pool&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(sub=
net_pools_ipv6, &quot;subnet-pool-ipv6&quot;);</span><br><span>         MUS=
T_BE_UNDEF(real_hash_size, &quot;hash-size&quot;);</span><br><span>        =
 MUST_BE_UNDEF(virtual_hash_size, &quot;hash-size&quot;);</span><br><span> =
        MUST_BE_UNDEF(learn_address_script, &quot;learn-address&quot;);</sp=
an><br><span>@@ -3119,8 +3136,9 @@</span><br><span> }</span><br><span> </sp=
an><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Th=
e server&#39;s tun device is only configured with the --server network, so<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * route each --subnet=
-pool network into it as well: without this the server</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * The server&#39;s tun device is only c=
onfigured with the --server and</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * --server-ipv6 networks, so route each --subnet-pool and --su=
bnet-pool-ipv6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ne=
twork into it as well: without this the server</span><br><span>  * could no=
t reach its subnet-pool clients when the data channel runs in</span><br><sp=
an>  * userspace=2E  Under DCO on Linux and FreeBSD the routes are installe=
d on-link,</span><br><span>  * see subnet_pool_routes_onlink()=2E</span><br=
><span>@@ -3138,6 +3156,16 @@</span><br><span>                             =
          o-&gt;route_default_table_id);</span><br><span>         ro-&gt;on=
_link =3D subnet_pool_routes_onlink(o);</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    for (const struct subnet_pool6_def *d =3D o-&gt=
;subnet_pools_ipv6; d; d =3D d-&gt;next)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        struct buffer prefix =3D alloc_buf_gc(64, &amp;o-&gt;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;prefix, &quot;%s/=
%u&quot;, print_in6_addr(d-&gt;network, 0, &amp;o-&gt;gc), d-&gt;netbits);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        rol6_check_a=
lloc(o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        add=
_route_ipv6_to_option_list(o-&gt;routes_ipv6, BSTR(&amp;prefix), NULL, NULL=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                    o-&gt;route_default_table_id);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><br><span> </=
span><br><span> static void</span><br><span>@@ -6314,6 +6342,37 @@</span><b=
r><span>         sp-&gt;next =3D options-&gt;subnet_pools;</span><br><span>=
         options-&gt;subnet_pools =3D sp;</span><br><span>     }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot=
;subnet-pool-ipv6&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        struct subnet_pool6_def *s=
p;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct in=
6_addr network, gateway;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        unsigned int netbits =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (!get_ipv6_addr(p[2], &amp;network, &amp=
;netbits, msglevel))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msg(msglevel, &quot;cannot parse --subnet-pool-ipv6 network&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (netbits &lt; 64 || n=
etbits &gt; 124)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
sg(msglevel, &quot;--subnet-pool-ipv6 network must be between /64 and /124 =
(not /%u)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             netbits);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (p[3] &amp;&amp; !get_ipv6_addr(p[3], &amp;gateway, NULL, msglevel))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quo=
t;cannot parse --subnet-pool-ipv6 gateway&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            goto err;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        ALLOC_OBJ_GC(sp, struct subnet_pool6_def, &=
amp;options-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        sp-&gt;name =3D p[1];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        sp-&gt;network =3D network;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        sp-&gt;netbits =3D netbits;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;gateway =3D p[3] =
? gateway : add_in6_addr(network, 1);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        sp-&gt;next =3D options-&gt;subnet_pools_ipv6;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;su=
bnet_pools_ipv6 =3D sp;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span>     else if (streq(p[0], &quot;subnet-pool-name&=
quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><=
span>         VERIFY_PERMISSION(OPT_P_INSTANCE);</span><br><span>diff --git=
 a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index =
fcfb9e2=2E=2Ea9c6b22 100644</span><br><span>--- a/src/openvpn/options=2Eh</=
span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -267,6 +267=
,16 @@</span><br><span>     in_addr_t pool_end;</span><br><span> };</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The IP=
v6 counterpart of struct subnet_pool_def (--subnet-pool-ipv6)=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+struct subnet_pool6_def</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6_def *next;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *name;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr netw=
ork;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned in=
t netbits;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t in6_addr gateway;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 /* Command line options */</span><br><span> struct options</span><br><span=
> {</span><br><span>@@ -533,12 +543,17 @@</span><br><span>     bool push_if=
config_constraint_defined;</span><br><span>     in_addr_t push_ifconfig_con=
straint_network;</span><br><span>     in_addr_t push_ifconfig_constraint_ne=
tmask;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct subn=
et_pool_def *subnet_pools; /* named pools (server config) */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    const char *subnet_pool_name;   =
      /* which pool this client uses (CCD) */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    bool subnet_pool_defined;             /* resolv=
ed from the name at connect */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct subnet_pool_def *subnet_pools;       /* named IPv4 po=
ols (server config) */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct subnet_pool6_def *subnet_pools_ipv6; /* named IPv6 pools (ser=
ver config) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *subnet_pool_name;               /* which pool this client uses (=
CCD) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool sub=
net_pool_defined;                   /* resolved from the name at connect */=
</span><br><span>     in_addr_t subnet_pool_network;</span><br><span>     i=
n_addr_t subnet_pool_netmask;</span><br><span>     in_addr_t subnet_pool_ga=
teway;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool subn=
et_pool_ipv6_defined; /* resolved from the name at connect */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr subnet_pool_i=
pv6_network;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uns=
igned int subnet_pool_ipv6_netbits;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct in6_addr subnet_pool_ipv6_gateway;</span><br><sp=
an>     bool push_ifconfig_ipv4_blocked;           /* IPv4 */</span><br><sp=
an>     bool push_ifconfig_ipv6_defined;           /* IPv6 */</span><br><sp=
an>     struct in6_addr push_ifconfig_ipv6_local;  /* IPv6 */</span><br><sp=
an>diff --git a/src/openvpn/options_util=2Ec b/src/openvpn/options_util=2Ec=
</span><br><span>index bb52fe7=2E=2E808afa6 100644</span><br><span>--- a/sr=
c/openvpn/options_util=2Ec</span><br><span>+++ b/src/openvpn/options_util=
=2Ec</span><br><span>@@ -130,6 +130,108 @@</span><br><span>     return true=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* value of bit &lt;i&gt; (0 =3D most significant) of an=
 IPv6 address */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in6_bit(con=
st struct in6_addr *a, unsigned int i)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return a-&gt;s6_addr[i / 8] &amp; (0x80 &gt;&gt; (i % 8));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* true if the first &lt;bits&gt; bits of the two addresses are equa=
l */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+in6_prefix_equal(const =
struct in6_addr *a, const struct in6_addr *b, unsigned int bits)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    for (unsigned int i =3D 0; i &lt; bits; ++i)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (in6_bit(a, i) !=3D in=
6_bit(b, i))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retur=
n false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* true if every bit of &lt;a&gt; from bit &lt;from&gt; on is zero */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+in6_suffix_zero(const struct in6_=
addr *a, unsigned int from)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (u=
nsigned int i =3D from; i &lt; 128; ++i)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (in6_bit(a, i))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            return false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return tru=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+subnet_pools6_check(const struct subnet_pool6_def *pools, const struc=
t in6_addr *server_network,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    unsigned int server_netbits, msglvl_t msglevel)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    for (const struct subnet_pool6_de=
f *d =3D pools; d; d =3D d-&gt;next)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (d-&gt;netbits &lt; 64 || d-&gt;netbits &gt; 124)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--subnet-=
pool-ipv6 %s: network must be between /64 and /124 (not /%u)&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                d-&gt;name,=
 d-&gt;netbits);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!in6_suffix_ze=
ro(&amp;d-&gt;network, d-&gt;netbits))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            msg(msglevel, &quot;--subnet-pool-ipv6 %s: network has=
 host bits set&quot;, d-&gt;name);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            return false;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (!in6_prefix_equal(&amp;d-&gt;gateway, &amp;d-&gt;network, d-&gt;netbits=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            || in6=
_suffix_zero(&amp;d-&gt;gateway, d-&gt;netbits))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            msg(msglevel,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                &quot;--subnet-pool-ipv6 %s: gatew=
ay must be a host address inside the network&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                d-&gt;name);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            return false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (server_netbits</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            &amp;&amp; in6_prefix_equal(&amp;d-&=
gt;network, server_network, min_uint(d-&gt;netbits, server_netbits)))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--s=
ubnet-pool-ipv6 %s: network overlaps the --server-ipv6 network&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                d-&gt;nam=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retu=
rn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        for (const struct subnet_pool6_=
def *e =3D d-&gt;next; e; e =3D e-&gt;next)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            if (!strcmp(d-&gt;name, e-&gt;name))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;--=
subnet-pool-ipv6 %s: name defined more than once&quot;, d-&gt;name);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                return fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (in6_pr=
efix_equal(&amp;d-&gt;network, &amp;e-&gt;network, min_uint(d-&gt;netbits, =
e-&gt;netbits)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       msg(msglevel, &quot;--subnet-pool-ipv6 %s and %s: networks overlap&q=
uot;, d-&gt;name, e-&gt;name);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                return false;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+const struct subnet_pool6_def *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+subnet_pool6_by_name(const struct subnet_pool6_def *pool=
s, const char *name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (const st=
ruct subnet_pool6_def *d =3D pools; d; d =3D d-&gt;next)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (!strcmp(d-&gt;name, name))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return d;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return NULL;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> const char *</span><br><span> parse_auth_failed_temp(struct option=
s *o, const char *reason)</span><br><span> {</span><br><span>diff --git a/s=
rc/openvpn/options_util=2Eh b/src/openvpn/options_util=2Eh</span><br><span>=
index 5fa4735=2E=2Eab8122d1 100644</span><br><span>--- a/src/openvpn/option=
s_util=2Eh</span><br><span>+++ b/src/openvpn/options_util=2Eh</span><br><sp=
an>@@ -55,6 +55,25 @@</span><br><span> bool subnet_pools_check(const struct=
 subnet_pool_def *pools, in_addr_t server_network,</span><br><span>        =
                 in_addr_t server_netmask, msglvl_t msglevel);</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * IPv6 counterpart of subnet_=
pools_check(): network between /64 and /124</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * without host bits, gateway a host address inside=
 it, unique names, and no</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * network overlapping another pool or the --server-ipv6 network=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param pools           head of the =
--subnet-pool-ipv6 list (may be NULL)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param server_network  the --server-ipv6 network</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param server_netbits =
 the --server-ipv6 prefix length, or 0 if there is none</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param msglevel        level of the =
message logged on the first error</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @return                true if every definition is valid</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bool subnet_pools6_check(const struct=
 subnet_pool6_def *pools,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                         const struct in6_addr *server_network, unsig=
ned int server_netbits,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                         msglvl_t msglevel);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/** IPv6 counterpart of subnet_pool_by_name()=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+const struct subnet_pool6_def *su=
bnet_pool6_by_name(const struct subnet_pool6_def *pools,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                      =
              const char *name);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> </span><br><span> /** Checks if the string i=
s a valid integer by checking if it can be</span><br><span>  *  converted t=
o an integer */</span><br><span>diff --git a/src/openvpn/pool=2Ec b/src/ope=
nvpn/pool=2Ec</span><br><span>index 5c5b3fe=2E=2E2cdaa71 100644</span><br><=
span>--- a/src/openvpn/pool=2Ec</span><br><span>+++ b/src/openvpn/pool=2Ec<=
/span><br><span>@@ -446,6 +446,22 @@</span><br><span>     return true;</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if=
config_pool_reserve_ipv6(struct ifconfig_pool *pool, const struct in6_addr =
*addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const ifconfig_pool_handle =
h =3D ifconfig_pool_ipv6_base_to_handle(pool, addr);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (h &lt; 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_entry_free(&am=
p;pool-&gt;list[h], true);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    pool-&gt;list[h]=2Ein_use =3D true;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    pool-&gt;list[h]=2Ereserved =3D true;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> static in_addr_t</span><br><s=
pan> ifconfig_pool_handle_to_ip_base(const struct ifconfig_pool *pool, ifco=
nfig_pool_handle hand)</span><br><span> {</span><br><span>diff --git a/src/=
openvpn/pool=2Eh b/src/openvpn/pool=2Eh</span><br><span>index 497dcda=2E=2E=
fda87ed 100644</span><br><span>--- a/src/openvpn/pool=2Eh</span><br><span>+=
++ b/src/openvpn/pool=2Eh</span><br><span>@@ -98,6 +98,9 @@</span><br><span=
>  */</span><br><span> bool ifconfig_pool_reserve_ip(struct ifconfig_pool *=
pool, in_addr_t addr);</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/** IPv6 counterpart of ifconfig_pool_reserve_ip()=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ifconfig_poo=
l_reserve_ipv6(struct ifconfig_pool *pool, const struct in6_addr *addr);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> stru=
ct ifconfig_pool_persist *ifconfig_pool_persist_init(const char *filename, =
int refresh_freq);</span><br><span> </span><br><span> void ifconfig_pool_pe=
rsist_close(struct ifconfig_pool_persist *persist);</span><br><span>diff --=
git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/tes=
t_misc=2Ec</span><br><span>index 191ab2b=2E=2E0c7d81e 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/=
unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -568,6 +568,8 @@</span>=
<br><span>     cmocka_unit_test(test_subnet_pools_check_gateway),</span><br=
><span>     cmocka_unit_test(test_subnet_pools_check_range),</span><br><spa=
n>     cmocka_unit_test(test_subnet_pools_check_overlap),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_subnet_pool=
6_by_name),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmoc=
ka_unit_test(test_subnet_pools6_check),</span><br><span> };</span><br><span=
> </span><br><span> int</span><br><span>diff --git a/tests/unit_tests/openv=
pn/test_subnet_pool=2Ec b/tests/unit_tests/openvpn/test_subnet_pool=2Ec</sp=
an><br><span>index 7f40b74=2E=2E43ddb7b 100644</span><br><span>--- a/tests/=
unit_tests/openvpn/test_subnet_pool=2Ec</span><br><span>+++ b/tests/unit_te=
sts/openvpn/test_subnet_pool=2Ec</span><br><span>@@ -158,3 +158,77 @@</span=
><br><span>     struct subnet_pool_def adup =3D { =2Enext =3D &amp;bdup, =
=2Ename =3D &quot;grpA&quot;, =2Enetwork =3D 0x0a090000, =2Enetmask =3D 0xf=
fffff00, =2Egateway =3D 0x0a090001 };</span><br><span>     assert_false(sub=
net_pools_check(&amp;adup, 0, 0, M_WARN));</span><br><span> }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* the IPv6 counterpart resolves independently: a na=
me may refer to a v4 pool, a</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * v6 pool, or both=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_subnet_pool6_by_name(void **state)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct subnet_pool6_def c =3D { =2Enext =3D NULL, =2Ename =3D &quot;g=
rpC&quot;, =2Enetbits =3D 64 };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct subnet_pool6_def b =3D { =2Enext =3D &amp;c, =2Ename=
 =3D &quot;grpB&quot;, =2Enetbits =3D 96 };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct subnet_pool6_def a =3D { =2Enext =3D &am=
p;b, =2Ename =3D &quot;grpA&quot;, =2Enetbits =3D 64 };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_ptr_equal(subnet_pool6_by_name(&amp;a, &quot;gr=
pA&quot;), &amp;a);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_ptr_equal(subnet_pool6_by_name(&amp;a, &quot;grpB&quot;), &amp;b=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_eq=
ual(subnet_pool6_by_name(&amp;a, &quot;grpC&quot;), &amp;c);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(subnet_pool6_=
by_name(&amp;a, &quot;grpB&quot;)-&gt;netbits, 96);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_null(subnet_pool6_by_name(&amp=
;a, &quot;nope&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_null(subnet_pool6_by_name(NULL, &quot;grpA&quot;));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* &lt;prefix&gt;::&lt;host&gt; as an in6_addr */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static struct in6_addr</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+in6(const char *addr)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct in6_addr a;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(inet_pton(AF_INET6, addr, &amp;a), 1);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return a;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* a single IPv6 pool, checked against the fd00:8::/64 --server-ipv=
6 network */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check6_one(cons=
t char *net, unsigned int bits, const char *gw)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const struct in6_addr server =3D in6(&quot;fd00:8::&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_poo=
l6_def d =3D { =2Enext =3D NULL, =2Ename =3D &quot;grp&quot;, =2Enetwork =
=3D in6(net), =2Enetbits =3D bits, =2Egateway =3D in6(gw) };</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return subnet_pools6_check(&amp;d, &amp;server, 6=
4, M_WARN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_subnet_pools6_check(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* /64 =2E=2E /124, any host address of the network as =
gateway */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_true(check6_one(&quot;fd00:9::&quot;, 64, &quot;fd00:9::1&quot;));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(check6_one=
(&quot;fd00:9::&quot;, 124, &quot;fd00:9::1&quot;));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(check6_one(&quot;fd00:9::=
&quot;, 112, &quot;fd00:9::ffff&quot;));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_false(check6_one(&quot;fd00:9::&quot;, 63, =
&quot;fd00:9::1&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_false(check6_one(&quot;fd00:9::&quot;, 125, &quot;fd00:9::1=
&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* host bits in the netwo=
rk, gateway =3D network or outside it */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_false(check6_one(&quot;fd00:9::5&quot;, 64,=
 &quot;fd00:9::1&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_false(check6_one(&quot;fd00:9::&quot;, 64, &quot;fd00:9::&=
quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
false(check6_one(&quot;fd00:9::&quot;, 64, &quot;fd00:a::1&quot;));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* overlapping the --server-ipv6 network, =
inside or covering it */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_false(check6_one(&quot;fd00:8::&quot;, 96, &quot;fd00:8::1&=
quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* two pools: disjoint, ov=
erlapping, same name */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const struct in6_addr server =3D in6(&quot;fd00:8::&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6_def=
 b =3D { =2Enext =3D NULL, =2Ename =3D &quot;grpB&quot;, =2Enetwork =3D in6=
(&quot;fd00:a::&quot;), =2Enetbits =3D 64, =2Egateway =3D in6(&quot;fd00:a:=
:1&quot;) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct subnet_pool6_def a =3D { =2Enext =3D &amp;b, =2Ename =3D &quot;grpA&quo=
t;, =2Enetwork =3D in6(&quot;fd00:9::&quot;), =2Enetbits =3D 64, =2Egateway=
 =3D in6(&quot;fd00:9::1&quot;) };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(subnet_pools6_check(&amp;a, &amp;server, 64, M_WARN));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(subnet_pools=
6_check(&amp;a, &amp;server, 0, M_WARN));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* a /120 grpB inside grpA */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct subnet_pool6_def bin =3D { =2Enext =3D NULL, =
=2Ename =3D &quot;grpB&quot;, =2Enetwork =3D in6(&quot;fd00:9::100&quot;), =
=2Enetbits =3D 120, =2Egateway =3D in6(&quot;fd00:9::101&quot;) };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6_def =
ain =3D { =2Enext =3D &amp;bin, =2Ename =3D &quot;grpA&quot;, =2Enetwork =
=3D in6(&quot;fd00:9::&quot;), =2Enetbits =3D 64, =2Egateway =3D in6(&quot;=
fd00:9::1&quot;) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_false(subnet_pools6_check(&amp;ain, &amp;server, 64, M_WARN));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* the same name defined twice */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool=
6_def bdup =3D { =2Enext =3D NULL, =2Ename =3D &quot;grpA&quot;, =2Enetwork=
 =3D in6(&quot;fd00:a::&quot;), =2Enetbits =3D 64, =2Egateway =3D in6(&quot=
;fd00:a::1&quot;) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct subnet_pool6_def adup =3D { =2Enext =3D &amp;bdup, =2Ename =3D =
&quot;grpA&quot;, =2Enetwork =3D in6(&quot;fd00:9::&quot;), =2Enetbits =3D =
64, =2Egateway =3D in6(&quot;fd00:9::1&quot;) };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_false(subnet_pools6_check(&amp;adup=
, &amp;server, 64, M_WARN));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span>diff --git a/tests/unit_tests/openvpn/test_subne=
t_pool=2Eh b/tests/unit_tests/openvpn/test_subnet_pool=2Eh</span><br><span>=
index 07ba374=2E=2Ee4df687 100644</span><br><span>--- a/tests/unit_tests/op=
envpn/test_subnet_pool=2Eh</span><br><span>+++ b/tests/unit_tests/openvpn/t=
est_subnet_pool=2Eh</span><br><span>@@ -34,4 +34,8 @@</span><br><span> </sp=
an><br><span> void test_subnet_pools_check_overlap(void **state);</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_s=
ubnet_pool6_by_name(void **state);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
 test_subnet_pools6_check(void **state);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> #endif</span><br></pre><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail=
">change 1786</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
786?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1786 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner=
: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>

<=
/body></html>
--l0CY/2nraqA=--


--===============3322770726358044121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3322770726358044121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3322770726358044121==--

