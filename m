Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22653CCF2C7
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 22:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vxrDndLIOyzeiW+tHFcEV/ucAX/JLobDShRVexsbhfc=; b=a98r8g3vUvD07Lg8zwDvgK1GQq
	TwuydN/Jz2RQYSJ18E2bpecFraP87dnl882fHdBp6S7lrja4G4q54yiHlOJdjZdAx7stTahZVT0OF
	5/ys8sq/n6UEO89fzxFs8LH1VjKoqo5cr6Bj//0eCk3nYivdoloB8t2kL040U16/s6tc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIDGg-0002u9-Jg;
	Sat, 17 Oct 2026 22:52:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIDGd-0002u2-Ra
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 22:52:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=GakJJjJP9rcRtqWrO5GQct4CiAtjamzKWXNvtcO//js=; b=OM2GeY7HAPSllUpXyYv8ReH+Nj
 5rUuXbgNByVfQN/1bOe7nAjPUGEobEEDAcqIu6ViLyOPaRMdR8tMJ2OazEZ/Sz/GDGAGYJZMm8Yfc
 6RMnPspqqraQ8odMMj9cnIZSN9QRlbxShLthRSHKKrazUCY4b4WX9nMFSd4ovEdOvVj4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GakJJjJP9rcRtqWrO5GQct4CiAtjamzKWXNvtcO//js=; b=a
 l82Y5iRQeuBsqavR2UFjUUoDur8iPv0n4DWHgsAlOtAejra0SlGw5/0F8SAdZRg5v+9COtX3SOS1h
 djHy80qv3aLdl6XUeYitAwQOW3VmIYRCn2UkxI4VdoEd7LGNAyE1L15FwDuU0sJjj/FsACdQPmATY
 Q4LPNGnf34RTULfs=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIDGY-0004TH-5Z for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 22:52:41 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso321878f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 15:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792277552; x=1792882352; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GakJJjJP9rcRtqWrO5GQct4CiAtjamzKWXNvtcO//js=;
 b=L/X238lOzE98aRABjfNEcCGnorZP9XHfJVWtpfLlZh314Wc/Olhjfk2mBsdtpmkdIO
 NnSy5E2lj4p3bj9+hIQ1IkmWBtVCXxiWfAxLB/wck8xS9YW8guCl2aAIom0V/yfqgImS
 /qWPnRyj8RVyG7HcCLXwS+TtHvXA2ra56h8Ham71YrnNfuNYAgfaN6hCaCKLKwg4cc4b
 ta+Q02ZrVIFgZFrxIlAQMhRqZZXyq6AmQ4S0PPAcIb74szk8oFoua2GYK79ZDi1kKDZn
 nhsgFpqeA+z40ZcBYKZ4rebuMwqsXx4cNlpTSMi0iOQQIQn/80JACd6MddOp3gG7p9WE
 KF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792277552; x=1792882352;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GakJJjJP9rcRtqWrO5GQct4CiAtjamzKWXNvtcO//js=;
 b=uXxl85XERWNCrVCyzGQ+wu5x9dD5NyrHeLfxY4qoUmwP0is6guVnmN+R3JT+ycEfbL
 D1dXNMoxMWfDeK2bOpBMTMWCdE9QOabI2D2HmrHI6m9au003iRklWDVyu0QpuekslPus
 bOdE4NOVV5v/YxxSC0A5TUNH7Cr8kFgNdV6czUEoYu+A0koyv6YdndkH4SqgyM84tNUj
 OVyP8u/SGC1Q6SMwfgdWA0kDFuQRB60F0Id9PwYydednbaRIbmnp/nTVOcRyV2W3mxXE
 sTzFegWUB9zdPSPR3mVp36YAnHhxGjhGYPGHG3S2aZnRxp7Xk0KDE7nIuKQxASecYCP4
 I/2A==
X-Gm-Message-State: AFq9FYLSUetJHdm6qoETwZPRG6bxDZy3EkmQhus7UPa8fTcsY2GwaGuS
 moM8wXA8xPl7jQV1MJgqqa83XjCiLC3CpjdPUwDQgbteQU+nGNG2V8dDOPS/net8J3v8lMgLm52
 aDq13x0iRV00d2nXtSVpZQDg69SpNQkG78aO+URleaMjJc6gEmD3qkBGbtivLxAp3y70Hb688rW
 TP1APM5g==
X-Gm-Gg: AYBFou3E6bA85YOZfnbI0IFAdA0kcIsE3l/0rxn64Qe8zT8oSPA+ClxiE1ryP8mDGYp
 KOiLINQzsPQmxNFHeJJ0cl6dfATKanGYsv/S8xl5Q5nXnQO97HqYvCNw3WIIcSfbnRt/JR84cF1
 TJMPUusyKc9ODGepifNh61wrVhQXq6QQCGz+ek6k6jFK52CCYWjsInQhhSh0DAPLedMNrZ1taMn
 QRh1H0YyQv1g7pmaDQpCeGPOqrfYOnVraa+IOlwRlEGg4eGNFjXHm5lgdEA/KkMXGkah6JMkvck
 pYc7wPaDggUd0Et9LLtFM2qjACFKjBIhtU3DacyEswaoxhPm4hc5iMwoCNkQEMB2HxJQ7v7a/D1
 x3MUo7PQ48WcQ8wBmwg7UcWhQi1tgmkCwQyh7V4KL+kP2LEdl7tiGTIIe8K3Eq6LKKyiUMgeh7b
 S4XdIGOFkAT/R5JYYGKEHb2uj+HDHFgqXohj8TuVGDK9tcMCR+Y7xbgt/hLA3tdqDIDfsxZSU6J
 hpvaqo+k2qce6OwswxqShyumOXOxtW0fjeqrE6oeJdb4VB5yAhHiySC+ZYQPL3gkf4JCQKsEebn
 YLAyinszGVn/PM2nRU9WWmVYOzPdmxIGtD1mciamwPqGafH6xrLxYvdqsBNK3KQ7c7bj1kA=
X-Received: by 2002:a05:600c:3e85:b0:4a0:25d5:e853 with SMTP id
 5b1f17b1804b1-4a1d7631660mr72025215e9.35.1792277551279; 
 Sat, 17 Oct 2026 15:52:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d2e93a01sm142163355e9.0.2026.10.17.15.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 15:52:29 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 22:52:22 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05
X-Gerrit-Change-Number: 1790
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1790?usp=email>
X-Gerrit-Commit: 44098a9680f21625574a938910c9dfb4ab53bc3a
In-Reply-To: <gerrit.1784150390000.I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05@gerrit.openvpn.net>
References: <gerrit.1784150390000.I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MTUwMzkwMDAwLkkwYmZmOGQwYTU0OWE2NWI3ZGEwMWVhMGU3ODViN2VjOGJlYTE3ZjA1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c0e650ac3dd54658f1fd3d5314132b450de7e0ba-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIDGY-0004TH-5Z
Subject: [Openvpn-devel] [L] Change in openvpn[master]: pool,
 multi: persist subnet pools via --ifconfig-pool-persist
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
Content-Type: multipart/mixed; boundary="===============8877277976219821238=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8877277976219821238==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C75jLMnAZdg="; charset=UTF-8

--C75jLMnAZdg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

H=
ello Arne Schwabe, Frank Lichtenheld, 

I'd like you to reexamine a change=
=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=
=3Demail

to look at the new patch set (#3)=2E


Change subject: pool, mult=
i: persist subnet pools via --ifconfig-pool-persist
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

pool, multi: persist subnet pools =
via --ifconfig-pool-persist

Extend --ifconfig-pool-persist so its single f=
ile covers the global pool
and every --subnet-pool=2E ifconfig_pool_read()/=
ifconfig_pool_write() now
operate on the set of pools: each persisted entry=
 is routed to the pool
whose address range owns it, and an entry matching n=
o configured pool
(e=2Eg=2E a --subnet-pool that was removed) is ignored wi=
th a warning=2E The
subnet pools already exist at startup, so their saved a=
llocations are
reloaded before the first client connects; a persisted entry=
 cannot take
over a reserved pool gateway=2E

Change-Id: I0bff8d0a549a65b7d=
a01ea0e785b7ec8bea17f05
GitHub: closes openvpn/OpenVPN#987
Signed-off-by: A=
ntonio Quartulli <antonio@mandelbit=2Ecom>
---
M CMakeLists=2Etxt
M doc/man=
-sections/server-options=2Erst
M src/openvpn/multi=2Ec
M src/openvpn/option=
s=2Ec
M src/openvpn/pool=2Ec
M src/openvpn/pool=2Eh
M tests/unit_tests/open=
vpn/Makefile=2Eam
A tests/unit_tests/openvpn/test_pool=2Ec
8 files changed,=
 453 insertions(+), 34 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/90/1790/3

diff --git a/CMakeLists=2Etxt b/CM=
akeLists=2Etxt
index 4e87a6a=2E=2E1f5f244 100644
--- a/CMakeLists=2Etxt
+++=
 b/CMakeLists=2Etxt
@@ -691,6 +691,7 @@
         "test_options_parse"
     =
    "test_packet_id"
         "test_pkt"
+        "test_pool"
         "tes=
t_provider"
         "test_socket"
         "test_ssl"
@@ -874,6 +875,15 @@=

         src/openvpn/options_util=2Ec
         )
 
+    target_sources(tes=
t_pool PRIVATE
+        tests/unit_tests/openvpn/mock_get_random=2Ec
+     =
   src/openvpn/pool=2Ec
+        src/openvpn/status=2Ec
+        src/openvp=
n/otime=2Ec
+        src/openvpn/fdmisc=2Ec
+        src/openvpn/interval=
=2Ec
+        )
+
     target_sources(test_ncp PRIVATE
         src/openvpn=
/crypto_epoch=2Ec
         src/openvpn/crypto_mbedtls=2Ec
diff --git a/doc/=
man-sections/server-options=2Erst b/doc/man-sections/server-options=2Erst
i=
ndex eb07d06=2E=2Ed59f9d8 100644
--- a/doc/man-sections/server-options=2Ers=
t
+++ b/doc/man-sections/server-options=2Erst
@@ -275,6 +275,11 @@
   ``fil=
e`` is a comma-delimited ASCII file, formatted as
   :code:`<Common-Name>,<=
IP-address>`=2E
 
+  A single ``file`` covers the global pool and every ``-=
-subnet-pool``: each
+  entry is associated with a pool by its address, and=
 on load an entry whose
+  address falls in no configured pool (for example=
 a ``--subnet-pool`` that is
+  no longer defined) is ignored with a warnin=
g=2E
+
   If ``seconds`` =3D :code:`0`, ``file`` will be treated as read-on=
ly=2E This
   is useful if you would like to treat ``file`` as a configurat=
ion file=2E
 
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
in=
dex ac3962d=2E=2E8d43894 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openv=
pn/multi=2Ec
@@ -69,6 +69,38 @@
 static struct ifconfig_pool *multi_get_gro=
up_pool(struct multi_context *m,
                                          =
         const struct options *o, const char *tag);
 
+/*
+ * Collect every=
 address pool (the global one plus each --subnet-pool group)
+ * into a gc-=
allocated array, for the single combined --ifconfig-pool-persist
+ * file=
=2E  Returns the number of pools=2E
+ */
+static int
+multi_all_pools(struc=
t multi_context *m, struct gc_arena *gc, struct ifconfig_pool ***pools)
+{
=
+    struct subnet_pool *sp;
+    int n =3D m->ifconfig_pool ? 1 : 0;
+
+  =
  for (sp =3D m->subnet_pools; sp; sp =3D sp->next)
+    {
+        n++;
+ =
   }
+
+    struct ifconfig_pool **arr =3D gc_malloc(n * sizeof(struct ifco=
nfig_pool *), true, gc);
+    int i =3D 0;
+
+    if (m->ifconfig_pool)
+  =
  {
+        arr[i++] =3D m->ifconfig_pool;
+    }
+    for (sp =3D m->subn=
et_pools; sp; sp =3D sp->next)
+    {
+        arr[i++] =3D sp->pool;
+    =
}
+
+    *pools =3D arr;
+    return n;
+}
+
 /*#define MULTI_DEBUG_EVENT_L=
OOP*/
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
@@ -165,11 +197,16 @@
 void
 multi_i=
fconfig_pool_persist(struct multi_context *m, bool force)
 {
-    /* write =
pool data to file */
-    if (m->ifconfig_pool && m->top=2Ec1=2Eifconfig_po=
ol_persist
+    /* write the global pool and every --subnet-pool to the one=
 persist file */
+    if (m->top=2Ec1=2Eifconfig_pool_persist
         && (=
force || ifconfig_pool_write_trigger(m->top=2Ec1=2Eifconfig_pool_persist)))=

     {
-        ifconfig_pool_write(m->top=2Ec1=2Eifconfig_pool_persist, m=
->ifconfig_pool);
+        struct gc_arena gc =3D gc_new();
+        struct=
 ifconfig_pool **pools;
+        int n =3D multi_all_pools(m, &gc, &pools);=

+
+        ifconfig_pool_write(m->top=2Ec1=2Eifconfig_pool_persist, pools,=
 n);
+        gc_free(&gc);
     }
 }
 
@@ -378,12 +415,6 @@
             t=
->options=2Eifconfig_pool_end, t->options=2Eduplicate_cn,
             t->o=
ptions=2Eifconfig_ipv6_pool_defined, t->options=2Eifconfig_ipv6_pool_base,
=
             t->options=2Eifconfig_ipv6_pool_netbits);
-
-        /* reload=
 pool data from file */
-        if (t->c1=2Eifconfig_pool_persist)
-      =
  {
-            ifconfig_pool_read(t->c1=2Eifconfig_pool_persist, m->ifcon=
fig_pool);
-        }
     }
 
     /* create every --subnet-pool group up =
front rather than on first use, so
@@ -397,6 +428,18 @@
         multi_get_=
group_pool(m, &t->options, d->tag);
     }
 
+    /* With --ifconfig-pool-p=
ersist the single file covers the global pool and
+     * every configured =
--subnet-pool: reload them all in one pass */
+    if (t->c1=2Eifconfig_poo=
l_persist)
+    {
+        struct gc_arena gc =3D gc_new();
+        struct=
 ifconfig_pool **pools;
+        int n =3D multi_all_pools(m, &gc, &pools);=

+
+        ifconfig_pool_read(t->c1=2Eifconfig_pool_persist, pools, n);
+ =
       gc_free(&gc);
+    }
+
     /*
      * Help us keep track of routing=
 table=2E
      */
diff --git a/src/openvpn/options=2Ec b/src/openvpn/optio=
ns=2Ec
index 95b0ab4=2E=2E21f8335 100644
--- a/src/openvpn/options=2Ec
+++ =
b/src/openvpn/options=2Ec
@@ -450,6 +450,7 @@
     "--ifconfig-pool-persist=
 file [seconds] : Persist/unpersist ifconfig-pool\n"
     "                =
  data to file, at seconds intervals (default=3D600)=2E\n"
     "          =
        If seconds=3D0, file will be treated as read-only=2E\n"
+    "     =
             Covers the global pool and every --subnet-pool=2E\n"
     "--i=
fconfig-ipv6-pool base-IP/bits : set aside an IPv6 network block\n"
     " =
                 to be dynamically allocated to connecting clients=2E\n"
  =
   "--subnet-pool tag network netmask [gateway] : Define a named pool of\n"=

@@ -1923,10 +1924,11 @@
         MUST_BE_UNDEF(route_delay_defined, "route=
-delay");
         MUST_BE_UNDEF(up_delay, "up-delay");
         if (!optio=
ns->ifconfig_pool_defined && !options->ifconfig_ipv6_pool_defined
+        =
    && !options->subnet_pools && !options->subnet_pools_ipv6
             &=
& options->ifconfig_pool_persist_filename)
         {
-            msg(M_US=
AGE,
-                "--ifconfig-pool-persist must be used with --ifconfig=
-pool or --ifconfig-ipv6-pool");
+            msg(M_USAGE, "--ifconfig-pool=
-persist must be used with --ifconfig-pool, "
+                         "--=
ifconfig-ipv6-pool or --subnet-pool");
         }
         if (options->ifc=
onfig_ipv6_pool_defined && !options->ifconfig_ipv6_local)
         {
diff -=
-git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec
index 8f899d3=2E=2E2e4f2=
94 100644
--- a/src/openvpn/pool=2Ec
+++ b/src/openvpn/pool=2Ec
@@ -621,13 =
+621,14 @@
 }
 
 void
-ifconfig_pool_read(struct ifconfig_pool_persist *per=
sist, struct ifconfig_pool *pool)
+ifconfig_pool_read(struct ifconfig_pool_=
persist *persist, struct ifconfig_pool **pools,
+                   int n_p=
ools)
 {
     const int buf_size =3D 128;
 
     update_time();
 
-    if (=
persist && persist->file && pool)
+    if (persist && persist->file && n_po=
ols > 0)
     {
         struct gc_arena gc =3D gc_new();
         struct b=
uffer in =3D alloc_buf_gc(256, &gc);
@@ -672,6 +673,9 @@
                 c=
ontinue;
             }
 
+            /* the address selects which pool th=
is entry belongs to; an entry
+             * matching none of the configur=
ed pools is ignored */
+            struct ifconfig_pool *pool =3D NULL;
  =
           ifconfig_pool_handle h =3D -1, h6 =3D -1;
 
             if (str=
len(ip_buf) > 0)
@@ -685,10 +689,18 @@
                 }
                 =
else
                 {
-                    h =3D ifconfig_pool_ip_base_to=
_handle(pool, addr);
-                    if (h < 0)
+                    f=
or (int i =3D 0; i < n_pools && !pool; ++i)
                     {
-       =
                 msg(M_WARN, "pool: IPv4 (%s) out of pool range for CN=3D%s=
", ip_buf, cn_buf);
+                        h =3D ifconfig_pool_ip_base_to=
_handle(pools[i], addr);
+                        if (h >=3D 0)
+          =
              {
+                            pool =3D pools[i];
+          =
              }
+                    }
+                    if (!pool)
+   =
                 {
+                        msg(M_WARN, "pool: IPv4 (%s) fo=
r CN=3D%s is outside every configured pool",
+                            i=
p_buf, cn_buf);
                     }
                 }
             }
@@=
 -701,12 +713,30 @@
                 {
                     msg(M_WARN, "po=
ol: invalid IPv6 (%s) for CN=3D%s", ip6_buf, cn_buf);
                 }
- =
               else
+                else if (pool)
                 {
+   =
                 /* IPv4 already picked the pool; v4 and v6 share the handl=
e */
                     h6 =3D ifconfig_pool_ipv6_base_to_handle(pool, &a=
ddr6);
                     if (h6 < 0)
                     {
-           =
             msg(M_WARN, "pool: IPv6 (%s) out of pool range for CN=3D%s", i=
p6_buf, cn_buf);
+                        msg(M_WARN, "pool: IPv6 (%s) for =
CN=3D%s is outside the pool of IPv4 (%s)",
+                            ip6=
_buf, cn_buf, ip_buf);
+                    }
+                }
+         =
       else
+                {
+                    for (int i =3D 0; i < n=
_pools && !pool; ++i)
+                    {
+                        h6 =
=3D ifconfig_pool_ipv6_base_to_handle(pools[i], &addr6);
+                 =
       if (h6 >=3D 0)
+                        {
+                         =
   pool =3D pools[i];
+                        }
+                    }
+  =
                  if (!pool)
+                    {
+                      =
  msg(M_WARN, "pool: IPv6 (%s) for CN=3D%s is outside every configured pool=
",
+                            ip6_buf, cn_buf);
                     }
 
=
                     /* Rely on IPv6 if no IPv4 was provided or the one pro=
vided
@@ -719,40 +749,44 @@
                 }
             }
 
-          =
  /* at the moment IPv4 and IPv6 share the same pool, therefore offsets
-  =
           * have to match for the same client=2E
-             *
-        =
     * If offsets differ we use the IPv4, therefore warn the user about thi=
s=2E
-             */
+            /* IPv4 and IPv6 share the same pool han=
dle, so their offsets have
+             * to match; if they differ we use =
the IPv4 and warn */
             if ((h6 >=3D 0) && (h !=3D h6))
         =
    {
                 msg(M_WARN, "pool: IPv4 (%s) and IPv6 (%s) have diff=
erent offsets! Relying on IPv4",
                     ip_buf, ip6_buf);
   =
          }
 
-            /* if at least one among v4 and v6 was properly =
parsed, attempt
-             * setting an handle for this client
-        =
     */
-            if (h >=3D 0)
+            /* set the handle if the en=
try belongs to one of the pools */
+            if (pool && h >=3D 0)
     =
        {
-                msg(M_INFO, "succeeded -> ifconfig_pool_set(hand=
=3D%d)", h);
                 ifconfig_pool_set(pool, cn_buf, h, persist->f=
ixed);
             }
         }
 
-        ifconfig_pool_msg(pool, D_IFCON=
FIG_POOL);
+        for (int i =3D 0; i < n_pools; ++i)
+        {
+       =
     ifconfig_pool_msg(pools[i], D_IFCONFIG_POOL);
+        }
 
         gc=
_free(&gc);
     }
 }
 
 void
-ifconfig_pool_write(struct ifconfig_pool_per=
sist *persist, const struct ifconfig_pool *pool)
+ifconfig_pool_write(struc=
t ifconfig_pool_persist *persist, struct ifconfig_pool *const *pools,
+    =
                int n_pools)
 {
-    if (persist && persist->file && (statu=
s_rw_flags(persist->file) & STATUS_OUTPUT_WRITE) && pool)
+    if (persist =
&& persist->file && (status_rw_flags(persist->file) & STATUS_OUTPUT_WRITE))=

     {
         status_reset(persist->file);
-        ifconfig_pool_list(p=
ool, persist->file);
+        for (int i =3D 0; i < n_pools; ++i)
+        =
{
+            if (pools[i])
+            {
+                ifconfig_pool_=
list(pools[i], persist->file);
+            }
+        }
         status_fl=
ush(persist->file);
     }
 }
diff --git a/src/openvpn/pool=2Eh b/src/openv=
pn/pool=2Eh
index fda87ed=2E=2E8e50020 100644
--- a/src/openvpn/pool=2Eh
++=
+ b/src/openvpn/pool=2Eh
@@ -107,9 +107,17 @@
 
 bool ifconfig_pool_write_t=
rigger(struct ifconfig_pool_persist *persist);
 
-void ifconfig_pool_read(s=
truct ifconfig_pool_persist *persist, struct ifconfig_pool *pool);
+/**
+ *=
 Read a persist file into a set of pools, routing each entry to the pool
+ =
* whose address range owns it=2E  Entries matching no pool (e=2Eg=2E a --su=
bnet-pool
+ * that is no longer configured) are ignored with a warning=2E
+=
 */
+void ifconfig_pool_read(struct ifconfig_pool_persist *persist, struct =
ifconfig_pool **pools,
+                        int n_pools);
 
-void ifcon=
fig_pool_write(struct ifconfig_pool_persist *persist, const struct ifconfig=
_pool *pool);
+/* Write a set of pools to a single persist file=2E */
+void=
 ifconfig_pool_write(struct ifconfig_pool_persist *persist,
+              =
           struct ifconfig_pool *const *pools, int n_pools);
 
 #ifdef IFCO=
NFIG_POOL_TEST
 void ifconfig_pool_test(in_addr_t start, in_addr_t end);
di=
ff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvp=
n/Makefile=2Eam
index 78f4b6c=2E=2E20bfd6c 100644
--- a/tests/unit_tests/op=
envpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -17,6 +=
17,7 @@
 	options_parse_testdriver \
 	packet_id_testdriver \
 	pkt_testdri=
ver \
+	pool_testdriver \
 	provider_testdriver \
 	push_update_msg_testdri=
ver \
 	socket_testdriver \
@@ -385,6 +386,23 @@
 	$(top_srcdir)/src/openvp=
n/platform=2Ec \
 	$(top_srcdir)/src/openvpn/mbuf=2Ec
 
+pool_testdriver_CF=
LAGS  =3D \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_sr=
cdir)/src/openvpn \
+	@TEST_CFLAGS@
+
+pool_testdriver_LDFLAGS =3D @TEST_LD=
FLAGS@
+
+pool_testdriver_SOURCES =3D test_pool=2Ec \
+	mock_msg=2Ec test_c=
ommon=2Eh \
+	mock_get_random=2Ec \
+	$(top_srcdir)/src/openvpn/pool=2Ec \
=
+	$(top_srcdir)/src/openvpn/status=2Ec \
+	$(top_srcdir)/src/openvpn/buffer=
=2Ec \
+	$(top_srcdir)/src/openvpn/otime=2Ec \
+	$(top_srcdir)/src/openvpn/=
platform=2Ec \
+	$(top_srcdir)/src/openvpn/fdmisc=2Ec \
+	$(top_srcdir)/src=
/openvpn/interval=2Ec
+
 subnet_pool_testdriver_CFLAGS  =3D \
 	-I$(top_src=
dir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	@TE=
ST_CFLAGS@
diff --git a/tests/unit_tests/openvpn/test_pool=2Ec b/tests/unit=
_tests/openvpn/test_pool=2Ec
new file mode 100644
index 0000000=2E=2E16008d=
f
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_pool=2Ec
@@ -0,0 +1,299=
 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *  =
           over a single UDP port, with support for SSL/TLS-based
+ *      =
       session authentication and key exchange,
+ *             packet encr=
yption, packet authentication, and
+ *             packet compression=2E
+ =
*
+ *  Copyright (C) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This p=
rogram is free software; you can redistribute it and/or modify
+ *  it unde=
r the terms of the GNU General Public License version 2
+ *  as published b=
y the Free Software Foundation=2E
+ *
+ *  This program is distributed in t=
he hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even=
 the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR P=
URPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
=
+ *  You should have received a copy of the GNU General Public License alon=
g
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=
=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include=
 "syshead=2Eh"
+
+#include <stdlib=2Eh>
+#include <setjmp=2Eh>
+#include <c=
mocka=2Eh>
+
+#include "pool=2Eh"
+#include "buffer=2Eh"
+#include "platfor=
m=2Eh"
+#include "test_common=2Eh"
+#include "mock_msg=2Eh"
+
+/*
+ * pool=
=2Ec pulls in a few socket=2Ec/socket_util=2Ec helpers for address parsing =
and
+ * formatting=2E  The pool logic under test does not need the full soc=
ket stack,
+ * so provide small IPv4 implementations here (the IPv6 ones ar=
e not reached by
+ * these IPv4-only pools, but must exist to link)=2E
+ */=

+struct signal_info;
+
+in_addr_t
+getaddr(unsigned int flags, const char =
*hostname, int resolve_retry_seconds, bool *succeeded,
+        struct sign=
al_info *sig_info)
+{
+    struct in_addr a;
+    int ok =3D inet_pton(AF_I=
NET, hostname, &a) =3D=3D 1;
+
+    if (succeeded)
+    {
+        *succeed=
ed =3D ok;
+    }
+    return ok ? ntohl(a=2Es_addr) : 0;
+}
+
+const char =
*
+print_in_addr_t(in_addr_t addr, unsigned int flags, struct gc_arena *gc)=

+{
+    struct in_addr a =3D { =2Es_addr =3D htonl(addr) };
+    char buf[=
INET_ADDRSTRLEN] =3D { 0 };
+
+    inet_ntop(AF_INET, &a, buf, sizeof(buf))=
;
+    return string_alloc(buf, gc);
+}
+
+bool
+get_ipv6_addr(const char *=
hostname, struct in6_addr *network, unsigned int *netbits,
+              m=
sglvl_t msglevel)
+{
+    return false;
+}
+
+const char *
+print_in6_addr(=
struct in6_addr a6, unsigned int flags, struct gc_arena *gc)
+{
+    return=
 "";
+}
+
+struct in6_addr
+add_in6_addr(struct in6_addr base, uint32_t add=
)
+{
+    return base;
+}
+
+#define IP(a, b, c, d) (((in_addr_t)(a) << 24)=
 | ((b) << 16) | ((c) << 8) | (d))
+
+/* three non-overlapping /24 pools: t=
he global one and two --subnet-pool groups */
+#define GLOBAL_START IP(10, =
1, 1, 2)
+#define GLOBAL_END   IP(10, 1, 1, 254)
+#define A_START      IP(1=
0, 2, 1, 2)
+#define A_END        IP(10, 2, 1, 254)
+#define B_START      I=
P(10, 2, 2, 2)
+#define B_END        IP(10, 2, 2, 254)
+
+static struct ifc=
onfig_pool *
+make_pool(in_addr_t start, in_addr_t end)
+{
+    struct in6_=
addr any =3D { 0 };
+
+    return ifconfig_pool_init(true, IFCONFIG_POOL_IN=
DIV, start, end, false, false, any, 0);
+}
+
+static in_addr_t
+acquire(str=
uct ifconfig_pool *pool, const char *cn)
+{
+    in_addr_t local =3D 0, rem=
ote =3D 0;
+
+    ifconfig_pool_acquire(pool, &local, &remote, NULL, cn);
+=
    return remote;
+}
+
+/* whether any entry of the pool is reserved for c=
ommon name cn */
+static bool
+pool_has_cn(const struct ifconfig_pool *pool=
, const char *cn)
+{
+    for (int i =3D 0; i < pool->size; ++i)
+    {
+  =
      if (pool->list[i]=2Ecommon_name && !strcmp(pool->list[i]=2Ecommon_nam=
e, cn))
+        {
+            return true;
+        }
+    }
+    return =
false;
+}
+
+static const char *persist_file;
+
+/* Write {global, A, B} to=
 one persist file, reload into a fresh set, and check
+ * that every entry =
was routed back to the pool that owns its address=2E */
+static void
+test_=
persist_roundtrip(void **state)
+{
+    struct ifconfig_pool *g =3D make_po=
ol(GLOBAL_START, GLOBAL_END);
+    struct ifconfig_pool *a =3D make_pool(A_=
START, A_END);
+    struct ifconfig_pool *b =3D make_pool(B_START, B_END);
=
+
+    assert_int_equal(acquire(g, "alice"), GLOBAL_START);
+    assert_int=
_equal(acquire(a, "bob"), A_START);
+    assert_int_equal(acquire(b, "carol=
"), B_START);
+
+    struct ifconfig_pool *pools[] =3D { g, a, b };
+    st=
ruct ifconfig_pool_persist *wp =3D ifconfig_pool_persist_init(persist_file,=
 5);
+    ifconfig_pool_write(wp, pools, 3);
+    ifconfig_pool_persist_clo=
se(wp);
+
+    struct ifconfig_pool *g2 =3D make_pool(GLOBAL_START, GLOBAL_=
END);
+    struct ifconfig_pool *a2 =3D make_pool(A_START, A_END);
+    str=
uct ifconfig_pool *b2 =3D make_pool(B_START, B_END);
+    struct ifconfig_p=
ool *pools2[] =3D { g2, a2, b2 };
+    struct ifconfig_pool_persist *rp =3D=
 ifconfig_pool_persist_init(persist_file, 0);
+    ifconfig_pool_read(rp, p=
ools2, 3);
+    ifconfig_pool_persist_close(rp);
+
+    /* each client was =
routed to its own pool (handle 0 =3D=3D the pool's base) */
+    assert_str=
ing_equal(g2->list[0]=2Ecommon_name, "alice");
+    assert_string_equal(a2-=
>list[0]=2Ecommon_name, "bob");
+    assert_string_equal(b2->list[0]=2Ecomm=
on_name, "carol");
+
+    /* and nowhere else */
+    assert_false(pool_has=
_cn(g2, "bob"));
+    assert_false(pool_has_cn(g2, "carol"));
+    assert_f=
alse(pool_has_cn(a2, "alice"));
+
+    /* the reservation is honoured: the =
same CN gets its persisted address back */
+    assert_int_equal(acquire(a2=
, "bob"), A_START);
+
+    ifconfig_pool_free(g);
+    ifconfig_pool_free(a=
);
+    ifconfig_pool_free(b);
+    ifconfig_pool_free(g2);
+    ifconfig_p=
ool_free(a2);
+    ifconfig_pool_free(b2);
+}
+
+/* An entry whose address =
matches no configured pool (here: B's, when B is not
+ * in the set) is ign=
ored on load and does not disturb the other pools=2E */
+static void
+test_=
persist_ignore_unknown(void **state)
+{
+    struct ifconfig_pool *g =3D ma=
ke_pool(GLOBAL_START, GLOBAL_END);
+    struct ifconfig_pool *a =3D make_po=
ol(A_START, A_END);
+    struct ifconfig_pool *b =3D make_pool(B_START, B_E=
ND);
+
+    acquire(g, "alice");
+    acquire(a, "bob");
+    acquire(b, "c=
arol");
+
+    struct ifconfig_pool *pools[] =3D { g, a, b };
+    struct i=
fconfig_pool_persist *wp =3D ifconfig_pool_persist_init(persist_file, 5);
+=
    ifconfig_pool_write(wp, pools, 3);
+    ifconfig_pool_persist_close(wp)=
;
+
+    /* reload into a set WITHOUT pool B: carol's entry now matches no =
pool */
+    struct ifconfig_pool *g2 =3D make_pool(GLOBAL_START, GLOBAL_EN=
D);
+    struct ifconfig_pool *a2 =3D make_pool(A_START, A_END);
+    struc=
t ifconfig_pool *pools2[] =3D { g2, a2 };
+    struct ifconfig_pool_persist=
 *rp =3D ifconfig_pool_persist_init(persist_file, 0);
+    ifconfig_pool_re=
ad(rp, pools2, 2);
+    ifconfig_pool_persist_close(rp);
+
+    assert_stri=
ng_equal(g2->list[0]=2Ecommon_name, "alice");
+    assert_string_equal(a2->=
list[0]=2Ecommon_name, "bob");
+    assert_false(pool_has_cn(g2, "carol"));=

+    assert_false(pool_has_cn(a2, "carol"));
+
+    ifconfig_pool_free(g);=

+    ifconfig_pool_free(a);
+    ifconfig_pool_free(b);
+    ifconfig_pool=
_free(g2);
+    ifconfig_pool_free(a2);
+}
+
+/* A --subnet-pool gateway is=
 reserved inside the pool range (here in the
+ * middle of a /29): it is ne=
ver handed out, nor released=2E */
+static void
+test_reserve_gateway(void =
**state)
+{
+    struct ifconfig_pool *p =3D make_pool(IP(10, 2, 3, 1), IP(=
10, 2, 3, 6));
+    const char *cns[] =3D { "c1", "c2", "c3", "c4", "c5" };=

+    in_addr_t local =3D 0, remote =3D 0;
+
+    assert_false(ifconfig_poo=
l_reserve_ip(p, IP(10, 2, 4, 1)));
+    assert_true(ifconfig_pool_reserve_i=
p(p, IP(10, 2, 3, 4)));
+
+    /* the five other addresses go to five clien=
ts, the gateway to none */
+    for (int i =3D 0; i < 5; ++i)
+    {
+     =
   const in_addr_t a =3D acquire(p, cns[i]);
+
+        assert_true(a >=3D =
IP(10, 2, 3, 1) && a <=3D IP(10, 2, 3, 6));
+        assert_int_not_equal(a=
, IP(10, 2, 3, 4));
+    }
+    assert_true(ifconfig_pool_acquire(p, &local=
, &remote, NULL, "c6") < 0);
+
+    /* releasing the reserved slot is refus=
ed */
+    assert_false(ifconfig_pool_release(p, 3, true));
+    assert_tru=
e(ifconfig_pool_acquire(p, &local, &remote, NULL, "c6") < 0);
+
+    ifconf=
ig_pool_free(p);
+}
+
+/* A persisted entry pointing at a now-reserved addr=
ess (e=2Eg=2E a gateway that
+ * was handed out before the pool definition =
changed) does not take it over=2E */
+static void
+test_reserve_survives_pe=
rsist(void **state)
+{
+    struct ifconfig_pool *p =3D make_pool(IP(10, 2,=
 3, 1), IP(10, 2, 3, 6));
+
+    assert_int_equal(acquire(p, "alice"), IP(1=
0, 2, 3, 1));
+    assert_int_equal(acquire(p, "mallory"), IP(10, 2, 3, 2))=
;
+
+    struct ifconfig_pool *pools[] =3D { p };
+    struct ifconfig_pool=
_persist *wp =3D ifconfig_pool_persist_init(persist_file, 5);
+    ifconfig=
_pool_write(wp, pools, 1);
+    ifconfig_pool_persist_close(wp);
+
+    str=
uct ifconfig_pool *p2 =3D make_pool(IP(10, 2, 3, 1), IP(10, 2, 3, 6));
+   =
 assert_true(ifconfig_pool_reserve_ip(p2, IP(10, 2, 3, 2)));
+    struct if=
config_pool *pools2[] =3D { p2 };
+    struct ifconfig_pool_persist *rp =3D=
 ifconfig_pool_persist_init(persist_file, 0);
+    ifconfig_pool_read(rp, p=
ools2, 1);
+    ifconfig_pool_persist_close(rp);
+
+    assert_true(pool_ha=
s_cn(p2, "alice"));
+    assert_false(pool_has_cn(p2, "mallory"));
+    ass=
ert_int_equal(acquire(p2, "alice"), IP(10, 2, 3, 1));
+    assert_int_not_e=
qual(acquire(p2, "mallory"), IP(10, 2, 3, 2));
+
+    ifconfig_pool_free(p)=
;
+    ifconfig_pool_free(p2);
+}
+
+const struct CMUnitTest pool_tests[] =
=3D {
+    cmocka_unit_test(test_persist_roundtrip),
+    cmocka_unit_test(=
test_persist_ignore_unknown),
+    cmocka_unit_test(test_reserve_gateway),
=
+    cmocka_unit_test(test_reserve_survives_persist),
+};
+
+int
+main(void=
)
+{
+    struct gc_arena gc =3D gc_new();
+
+    persist_file =3D platform=
_create_temp_file(NULL, "pool_persist_ut", &gc);
+    assert_non_null(persi=
st_file);
+
+    openvpn_unit_test_setup();
+    int ret =3D cmocka_run_gro=
up_tests(pool_tests, NULL, NULL);
+
+    platform_unlink(persist_file);
+  =
  gc_free(&gc);
+    return ret;
+}

-- 
To view, visit https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1790?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05
Gerrit-Chang=
e-Number: 1790
Gerrit-PatchSet: 3
Gerrit-Owner: Antonio Quartulli <antonio@=
mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ant=
onio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>

--C75jLMnAZdg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>Antonio Qu=
artulli <strong>uploaded patch set #3</strong> to this change=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail">View Ch=
ange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">pool, multi: persist subnet pools via --ifconfig-=
pool-persist<br><br>Extend --ifconfig-pool-persist so its single file cover=
s the global pool<br>and every --subnet-pool=2E ifconfig_pool_read()/ifconf=
ig_pool_write() now<br>operate on the set of pools: each persisted entry is=
 routed to the pool<br>whose address range owns it, and an entry matching n=
o configured pool<br>(e=2Eg=2E a --subnet-pool that was removed) is ignored=
 with a warning=2E The<br>subnet pools already exist at startup, so their s=
aved allocations are<br>reloaded before the first client connects; a persis=
ted entry cannot take<br>over a reserved pool gateway=2E<br><br>Change-Id: =
I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05<br>GitHub: closes openvpn/OpenVPN=
#987<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br=
>---<br>M CMakeLists=2Etxt<br>M doc/man-sections/server-options=2Erst<br>M =
src/openvpn/multi=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/pool=2E=
c<br>M src/openvpn/pool=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>=
A tests/unit_tests/openvpn/test_pool=2Ec<br>8 files changed, 453 insertions=
(+), 34 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/90/1790/3</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeL=
ists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 4e87a6a=2E=2E1f5f244 10=
0644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeList=
s=2Etxt</span><br><span>@@ -691,6 +691,7 @@</span><br><span>         &quot;=
test_options_parse&quot;</span><br><span>         &quot;test_packet_id&quot=
;</span><br><span>         &quot;test_pkt&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        &quot;test_pool&quot;</span><br><span> =
        &quot;test_provider&quot;</span><br><span>         &quot;test_socke=
t&quot;</span><br><span>         &quot;test_ssl&quot;</span><br><span>@@ -8=
74,6 +875,15 @@</span><br><span>         src/openvpn/options_util=2Ec</span=
><br><span>         )</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    target_sources(test_pool PRIVATE</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/mock_=
get_random=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   src/openvpn/pool=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        src/openvpn/status=2Ec</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        src/openvpn/otime=2Ec</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        src/openvpn/fdmisc=2Ec</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/interval=2Ec</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        )</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     target_sources=
(test_ncp PRIVATE</span><br><span>         src/openvpn/crypto_epoch=2Ec</sp=
an><br><span>         src/openvpn/crypto_mbedtls=2Ec</span><br><span>diff -=
-git a/doc/man-sections/server-options=2Erst b/doc/man-sections/server-opti=
ons=2Erst</span><br><span>index eb07d06=2E=2Ed59f9d8 100644</span><br><span=
>--- a/doc/man-sections/server-options=2Erst</span><br><span>+++ b/doc/man-=
sections/server-options=2Erst</span><br><span>@@ -275,6 +275,11 @@</span><b=
r><span>   ``file`` is a comma-delimited ASCII file, formatted as</span><br=
><span>   :code:`&lt;Common-Name&gt;,&lt;IP-address&gt;`=2E</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  A single ``file=
`` covers the global pool and every ``--subnet-pool``: each</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  entry is associated with a pool b=
y its address, and on load an entry whose</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  address falls in no configured pool (for example a =
``--subnet-pool`` that is</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  no longer defined) is ignored with a warning=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   If ``seconds`` =3D =
:code:`0`, ``file`` will be treated as read-only=2E This</span><br><span>  =
 is useful if you would like to treat ``file`` as a configuration file=2E</=
span><br><span> </span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/o=
penvpn/multi=2Ec</span><br><span>index ac3962d=2E=2E8d43894 100644</span><b=
r><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=
=2Ec</span><br><span>@@ -69,6 +69,38 @@</span><br><span> static struct ifco=
nfig_pool *multi_get_group_pool(struct multi_context *m,</span><br><span>  =
                                                 const struct options *o, c=
onst char *tag);</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Collect every address pool (the global one plus each --subnet-pool group)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * into a gc-allocat=
ed array, for the single combined --ifconfig-pool-persist</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * file=2E  Returns the number of poo=
ls=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+multi_all_pools(struct multi_context *m=
, struct gc_arena *gc, struct ifconfig_pool ***pools)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct subnet_pool *sp;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int n =3D m-&gt;ifconfig_pool ? 1 : 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    for (sp =3D m-&gt;subnet_pools; sp; sp =3D =
sp-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        n++;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct ifconfig_pool **arr =3D gc_malloc(n * sizeof(stru=
ct ifconfig_pool *), true, gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int i =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (m-=
&gt;ifconfig_pool)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        arr[i++=
] =3D m-&gt;ifconfig_pool;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for=
 (sp =3D m-&gt;subnet_pools; sp; sp =3D sp-&gt;next)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        arr[i++] =3D sp-&gt;pool;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    *pools =3D arr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*#de=
fine MULTI_DEBUG_EVENT_LOOP*/</span><br><span> </span><br><span> #ifdef MUL=
TI_DEBUG_EVENT_LOOP</span><br><span>@@ -165,11 +197,16 @@</span><br><span> =
void</span><br><span> multi_ifconfig_pool_persist(struct multi_context *m, =
bool force)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    /* write pool data to file */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (m-&gt;ifconfig_pool &amp;&amp; m-&gt;top=2Ec1=
=2Eifconfig_pool_persist</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* write the global pool and every --subnet-pool to the one persis=
t file */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (m-=
&gt;top=2Ec1=2Eifconfig_pool_persist</span><br><span>         &amp;&amp; (f=
orce || ifconfig_pool_write_trigger(m-&gt;top=2Ec1=2Eifconfig_pool_persist)=
))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        ifconfig_pool_write(m-&gt;top=2Ec1=2Eifconfig_pool_persist, m-&=
gt;ifconfig_pool);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        struct ifconfig_pool **pools;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        int n =3D multi_all_pools(m, =
&amp;gc, &amp;pools);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ifconfig_=
pool_write(m-&gt;top=2Ec1=2Eifconfig_pool_persist, pools, n);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><=
br><span>     }</span><br><span> }</span><br><span> </span><br><span>@@ -37=
8,12 +415,6 @@</span><br><span>             t-&gt;options=2Eifconfig_pool_e=
nd, t-&gt;options=2Eduplicate_cn,</span><br><span>             t-&gt;option=
s=2Eifconfig_ipv6_pool_defined, t-&gt;options=2Eifconfig_ipv6_pool_base,</s=
pan><br><span>             t-&gt;options=2Eifconfig_ipv6_pool_netbits);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        /* reload pool data from file */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (t-&gt;c1=2Eifco=
nfig_pool_persist)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ifc=
onfig_pool_read(t-&gt;c1=2Eifconfig_pool_persist, m-&gt;ifconfig_pool);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span=
>     }</span><br><span> </span><br><span>     /* create every --subnet-poo=
l group up front rather than on first use, so</span><br><span>@@ -397,6 +42=
8,18 @@</span><br><span>         multi_get_group_pool(m, &amp;t-&gt;options=
, d-&gt;tag);</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* With --ifconfig-pool-persist the =
single file covers the global pool and</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * every configured --subnet-pool: reload them all i=
n one pass */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (t-&gt;c1=2Eifconfig_pool_persist)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        struct ifconfig_pool **pools;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        int n =3D multi_all_pools(=
m, &amp;gc, &amp;pools);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ifconf=
ig_pool_read(t-&gt;c1=2Eifconfig_pool_persist, pools, n);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>     /*</span><br><span>    =
  * Help us keep track of routing table=2E</span><br><span>      */</span><=
br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</sp=
an><br><span>index 95b0ab4=2E=2E21f8335 100644</span><br><span>--- a/src/op=
envpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><=
span>@@ -450,6 +450,7 @@</span><br><span>     &quot;--ifconfig-pool-persist=
 file [seconds] : Persist/unpersist ifconfig-pool\n&quot;</span><br><span> =
    &quot;                  data to file, at seconds intervals (default=3D6=
00)=2E\n&quot;</span><br><span>     &quot;                  If seconds=3D0,=
 file will be treated as read-only=2E\n&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &quot;                  Covers the global poo=
l and every --subnet-pool=2E\n&quot;</span><br><span>     &quot;--ifconfig-=
ipv6-pool base-IP/bits : set aside an IPv6 network block\n&quot;</span><br>=
<span>     &quot;                  to be dynamically allocated to connectin=
g clients=2E\n&quot;</span><br><span>     &quot;--subnet-pool tag network n=
etmask [gateway] : Define a named pool of\n&quot;</span><br><span>@@ -1923,=
10 +1924,11 @@</span><br><span>         MUST_BE_UNDEF(route_delay_defined, =
&quot;route-delay&quot;);</span><br><span>         MUST_BE_UNDEF(up_delay, =
&quot;up-delay&quot;);</span><br><span>         if (!options-&gt;ifconfig_p=
ool_defined &amp;&amp; !options-&gt;ifconfig_ipv6_pool_defined</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; !options-=
&gt;subnet_pools &amp;&amp; !options-&gt;subnet_pools_ipv6</span><br><span>=
             &amp;&amp; options-&gt;ifconfig_pool_persist_filename)</span><=
br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          msg(M_USAGE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                &quot;--ifconfig-pool-persist must be used with --ifconfig=
-pool or --ifconfig-ipv6-pool&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            msg(M_USAGE, &quot;--ifconfig-pool-persist mu=
st be used with --ifconfig-pool, &quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                         &quot;--ifconfig-ipv6-pool or =
--subnet-pool&quot;);</span><br><span>         }</span><br><span>         i=
f (options-&gt;ifconfig_ipv6_pool_defined &amp;&amp; !options-&gt;ifconfig_=
ipv6_local)</span><br><span>         {</span><br><span>diff --git a/src/ope=
nvpn/pool=2Ec b/src/openvpn/pool=2Ec</span><br><span>index 8f899d3=2E=2E2e4=
f294 100644</span><br><span>--- a/src/openvpn/pool=2Ec</span><br><span>+++ =
b/src/openvpn/pool=2Ec</span><br><span>@@ -621,13 +621,14 @@</span><br><spa=
n> }</span><br><span> </span><br><span> void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-ifconfig_pool_read(struct ifconfig_pool_persist *per=
sist, struct ifconfig_pool *pool)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ifconfig_pool_read(struct ifconfig_pool_persist *persist, str=
uct ifconfig_pool **pools,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                   int n_pools)</span><br><span> {</span><br><span> =
    const int buf_size =3D 128;</span><br><span> </span><br><span>     upda=
te_time();</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (persist &amp;&amp; persist-&gt;file &amp;&amp; pool)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (persist &amp;&amp; =
persist-&gt;file &amp;&amp; n_pools &gt; 0)</span><br><span>     {</span><b=
r><span>         struct gc_arena gc =3D gc_new();</span><br><span>         =
struct buffer in =3D alloc_buf_gc(256, &amp;gc);</span><br><span>@@ -672,6 =
+673,9 @@</span><br><span>                 continue;</span><br><span>      =
       }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            /* the address selects which pool this entry belongs to;=
 an entry</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
   * matching none of the configured pools is ignored */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            struct ifconfig_pool *pool=
 =3D NULL;</span><br><span>             ifconfig_pool_handle h =3D -1, h6 =
=3D -1;</span><br><span> </span><br><span>             if (strlen(ip_buf) &=
gt; 0)</span><br><span>@@ -685,10 +689,18 @@</span><br><span>              =
   }</span><br><span>                 else</span><br><span>                =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 h =3D ifconfig_pool_ip_base_to_handle(pool, addr);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    if (h &lt; 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    for (int =
i =3D 0; i &lt; n_pools &amp;&amp; !pool; ++i)</span><br><span>            =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
             msg(M_WARN, &quot;pool: IPv4 (%s) out of pool range for CN=3D%=
s&quot;, ip_buf, cn_buf);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                        h =3D ifconfig_pool_ip_base_to_handle(pools[i=
], addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
              if (h &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                            pool =3D pools[i];</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    if =
(!pool)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
              msg(M_WARN, &quot;pool: IPv4 (%s) for CN=3D%s is outside ever=
y configured pool&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                            ip_buf, cn_buf);</span><br><span>         =
            }</span><br><span>                 }</span><br><span>          =
   }</span><br><span>@@ -701,12 +713,30 @@</span><br><span>                =
 {</span><br><span>                     msg(M_WARN, &quot;pool: invalid IPv=
6 (%s) for CN=3D%s&quot;, ip6_buf, cn_buf);</span><br><span>               =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                el=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                e=
lse if (pool)</span><br><span>                 {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    /* IPv4 already picked the=
 pool; v4 and v6 share the handle */</span><br><span>                     h=
6 =3D ifconfig_pool_ipv6_base_to_handle(pool, &amp;addr6);</span><br><span>=
                     if (h6 &lt; 0)</span><br><span>                     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
  msg(M_WARN, &quot;pool: IPv6 (%s) out of pool range for CN=3D%s&quot;, ip=
6_buf, cn_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                    msg(M_WARN, &quot;pool: IPv6 (%s) for CN=3D%s is outsid=
e the pool of IPv4 (%s)&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                            ip6_buf, cn_buf, ip_buf);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    for (int i =
=3D 0; i &lt; n_pools &amp;&amp; !pool; ++i)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        h6 =3D ifconfig_pool_ipv=
6_base_to_handle(pools[i], &amp;addr6);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                        if (h6 &gt;=3D 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
 pool =3D pools[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    if (!pool)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                        msg(M_WARN, &quot;pool: IPv6 (=
%s) for CN=3D%s is outside every configured pool&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                            ip6_buf, cn=
_buf);</span><br><span>                     }</span><br><span> </span><br><=
span>                     /* Rely on IPv6 if no IPv4 was provided or the on=
e provided</span><br><span>@@ -719,40 +749,44 @@</span><br><span>          =
       }</span><br><span>             }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            /* at the moment IPv4 and I=
Pv6 share the same pool, therefore offsets</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-             * have to match for the same client=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-             *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-             * If offsets diffe=
r we use the IPv4, therefore warn the user about this=2E</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-             */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            /* IPv4 and IPv6 share the same =
pool handle, so their offsets have</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+             * to match; if they differ we use the IPv4 and =
warn */</span><br><span>             if ((h6 &gt;=3D 0) &amp;&amp; (h !=3D =
h6))</span><br><span>             {</span><br><span>                 msg(M_=
WARN, &quot;pool: IPv4 (%s) and IPv6 (%s) have different offsets! Relying o=
n IPv4&quot;,</span><br><span>                     ip_buf, ip6_buf);</span>=
<br><span>             }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            /* if at least one among v4 and v6 was pro=
perly parsed, attempt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
             * setting an handle for this client</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-             */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            if (h &gt;=3D 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            /* set the handle if the entry be=
longs to one of the pools */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if (pool &amp;&amp; h &gt;=3D 0)</span><br><span>     =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    msg(M_INFO, &quot;succeeded -&gt; ifconfig_pool_set(hand=3D%d)&quot;, h=
);</span><br><span>                 ifconfig_pool_set(pool, cn_buf, h, pers=
ist-&gt;fixed);</span><br><span>             }</span><br><span>         }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   ifconfig_pool_msg(pool, D_IFCONFIG_POOL);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; n_pools; ++i)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            ifconfig_pool_msg(poo=
ls[i], D_IFCONFIG_POOL);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span> </span><br><span>         gc_free(&amp;gc);=
</span><br><span>     }</span><br><span> }</span><br><span> </span><br><spa=
n> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ifconfig_pool_=
write(struct ifconfig_pool_persist *persist, const struct ifconfig_pool *po=
ol)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ifconfig_pool_wr=
ite(struct ifconfig_pool_persist *persist, struct ifconfig_pool *const *poo=
ls,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    int n_pools)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (persist &amp;&amp; persist-&gt;file &amp;&amp; (statu=
s_rw_flags(persist-&gt;file) &amp; STATUS_OUTPUT_WRITE) &amp;&amp; pool)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (persist &amp;&=
amp; persist-&gt;file &amp;&amp; (status_rw_flags(persist-&gt;file) &amp; S=
TATUS_OUTPUT_WRITE))</span><br><span>     {</span><br><span>         status=
_reset(persist-&gt;file);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        ifconfig_pool_list(pool, persist-&gt;file);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; n_pool=
s; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (pools[=
i])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                ifconf=
ig_pool_list(pools[i], persist-&gt;file);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span>         status_flush(persist-&gt=
;file);</span><br><span>     }</span><br><span> }</span><br><span>diff --gi=
t a/src/openvpn/pool=2Eh b/src/openvpn/pool=2Eh</span><br><span>index fda87=
ed=2E=2E8e50020 100644</span><br><span>--- a/src/openvpn/pool=2Eh</span><br=
><span>+++ b/src/openvpn/pool=2Eh</span><br><span>@@ -107,9 +107,17 @@</spa=
n><br><span> </span><br><span> bool ifconfig_pool_write_trigger(struct ifco=
nfig_pool_persist *persist);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-void ifconfig_pool_read(struct ifconfig_pool_persi=
st *persist, struct ifconfig_pool *pool);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Read a persist file into a set of pools, routing each entry to the=
 pool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * whose addre=
ss range owns it=2E  Entries matching no pool (e=2Eg=2E a --subnet-pool</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * that is no longer co=
nfigured) are ignored with a warning=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void ifconfig_pool_read(struct ifconfig_pool_persist *persist, struct i=
fconfig_pool **pools,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                        int n_pools);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void ifconfig_pool_write(struct ifconfi=
g_pool_persist *persist, const struct ifconfig_pool *pool);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/* Write a set of pools to a single=
 persist file=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void ifconfig_pool_write(struct ifconfig_pool_persist *persist,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                         struct=
 ifconfig_pool *const *pools, int n_pools);</span><br><span> </span><br><sp=
an> #ifdef IFCONFIG_POOL_TEST</span><br><span> void ifconfig_pool_test(in_a=
ddr_t start, in_addr_t end);</span><br><span>diff --git a/tests/unit_tests/=
openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><s=
pan>index 78f4b6c=2E=2E20bfd6c 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Make=
file=2Eam</span><br><span>@@ -17,6 +17,7 @@</span><br><span> 	options_parse=
_testdriver \</span><br><span> 	packet_id_testdriver \</span><br><span> 	pk=
t_testdriver \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	pool=
_testdriver \</span><br><span> 	provider_testdriver \</span><br><span> 	pus=
h_update_msg_testdriver \</span><br><span> 	socket_testdriver \</span><br><=
span>@@ -385,6 +386,23 @@</span><br><span> 	$(top_srcdir)/src/openvpn/platf=
orm=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/mbuf=2Ec</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+pool_testdrive=
r_CFLAGS  =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-I$=
(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	@TEST_CFLAGS@</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+pool_testdriver_LDFLAGS =3D @TEST_LDFLAGS=
@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+pool_testdriver_SOURCES =3D test_pool=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg=2Ec=
 test_common=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
mock_get_random=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	$(top_srcdir)/src/openvpn/pool=2Ec \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/status=2Ec \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/buffer=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir=
)/src/openvpn/otime=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/fdmisc=2Ec \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/=
interval=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> subnet_pool_testdriver_CFLAGS  =3D \</span><br><span> 	-I$(top_s=
rcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</sp=
an><br><span> 	@TEST_CFLAGS@</span><br><span>diff --git a/tests/unit_tests/=
openvpn/test_pool=2Ec b/tests/unit_tests/openvpn/test_pool=2Ec</span><br><s=
pan>new file mode 100644</span><br><span>index 0000000=2E=2E16008df</span><=
br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_=
pool=2Ec</span><br><span>@@ -0,0 +1,299 @@</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a single=
 UDP port, with support for SSL/TLS-based</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *             session authentication and key exchang=
e,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pa=
cket encryption, packet authentication, and</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 OpenVPN Inc &lt;sales@openvp=
n=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free =
software; you can redistribute it and/or modify</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Publi=
c License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  as published by the Free Software Foundation=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is distributed in the hope that it will b=
e useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WI=
THOUT ANY WARRANTY; without even the implied warranty of</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A P=
ARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  GNU General Public License for more details=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU Gene=
ral Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/license=
s/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &lt;stdlib=2Eh&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;pool=2Eh&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;platform=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;mock_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * pool=2Ec pulls in a few sock=
et=2Ec/socket_util=2Ec helpers for address parsing and</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * formatting=2E  The pool logic under t=
est does not need the full socket stack,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * so provide small IPv4 implementations here (the IPv=
6 ones are not reached by</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * these IPv4-only pools, but must exist to link)=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+struct signal_info;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+in_addr_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+getadd=
r(unsigned int flags, const char *hostname, int resolve_retry_seconds, bool=
 *succeeded,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 struct signal_info *sig_info)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct in_addr a;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt ok =3D inet_pton(AF_INET, hostname, &amp;a) =3D=3D 1;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (succeeded)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        *succeeded =3D ok;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return ok ? ntohl(a=2Es_addr) : 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+print_in_addr_t(in_addr_t add=
r, unsigned int flags, struct gc_arena *gc)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct in_addr a =3D { =2Es_addr =3D htonl(addr) };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    char buf[INET_ADDRSTRLEN] =3D=
 { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    inet_ntop(AF_INET, &amp;a, =
buf, sizeof(buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return string_alloc(buf, gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+get_ipv6_addr(const char *hostname, str=
uct in6_addr *network, unsigned int *netbits,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+              msglvl_t msglevel)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+print_in6_addr(struct in6=
_addr a6, unsigned int flags, struct gc_arena *gc)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return &quot;&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct in6_addr</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+add_in6_addr(struct in6=
_addr base, uint32_t add)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return b=
ase;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define IP(a, b, c, d) (((in_addr_t)(a) &lt;&lt; 24)=
 | ((b) &lt;&lt; 16) | ((c) &lt;&lt; 8) | (d))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* three non-overlapping /24 pools: the global one and two --subnet=
-pool groups */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine GLOBAL_START IP(10, 1, 1, 2)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define GLOBAL_END   IP(10, 1, 1, 254)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define A_START      IP(10, 2, 1, 2)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define A_END        IP(=
10, 2, 1, 254)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne B_START      IP(10, 2, 2, 2)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define B_END        IP(10, 2, 2, 254)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static struct ifconfig_pool *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+make_pool(in_addr_t start, in_addr_t end)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct in6_addr any =3D { 0 };</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return ifconfig_pool_init(true, IFCONFIG_POOL_IND=
IV, start, end, false, false, any, 0);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static in_addr_t</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+acquire(struct ifconf=
ig_pool *pool, const char *cn)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_=
addr_t local =3D 0, remote =3D 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
fconfig_pool_acquire(pool, &amp;local, &amp;remote, NULL, cn);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return remote;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* whether any entry of the pool is reserved for common name cn */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+pool_has_cn(const struct ifconf=
ig_pool *pool, const char *cn)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for=
 (int i =3D 0; i &lt; pool-&gt;size; ++i)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (pool-&gt;list[i]=2Ecommon_name &amp;&amp; !strcmp(pool-=
&gt;list[i]=2Ecommon_name, cn))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            return true;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static const char *persist_file;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Write {global, A, B} to one persist file, reload into a f=
resh set, and check</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * that every entry was routed back to the pool that owns its address=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+test_persist_roundtrip(void=
 **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool *g =
=3D make_pool(GLOBAL_START, GLOBAL_END);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct ifconfig_pool *a =3D make_pool(A_START, A_E=
ND);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifco=
nfig_pool *b =3D make_pool(B_START, B_END);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(acquire(g, &quot;alice&quot;), GLOBAL_START);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ac=
quire(a, &quot;bob&quot;), A_START);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_int_equal(acquire(b, &quot;carol&quot;), B_STAR=
T);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool *pools[] =
=3D { g, a, b };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct ifconfig_pool_persist *wp =3D ifconfig_pool_persist_init(persist_fi=
le, 5);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig=
_pool_write(wp, pools, 3);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ifconfig_pool_persist_close(wp);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct ifconfig_pool *g2 =3D make_pool(GLOBAL_START, GLOBAL_END);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_=
pool *a2 =3D make_pool(A_START, A_END);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct ifconfig_pool *b2 =3D make_pool(B_START, B_E=
ND);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifco=
nfig_pool *pools2[] =3D { g2, a2, b2 };</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct ifconfig_pool_persist *rp =3D ifconfig_pool_=
persist_init(persist_file, 0);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ifconfig_pool_read(rp, pools2, 3);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ifconfig_pool_persist_close(rp);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* each client was routed to its own pool (=
handle 0 =3D=3D the pool&#39;s base) */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_string_equal(g2-&gt;list[0]=2Ecommon_name, &=
quot;alice&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_string_equal(a2-&gt;list[0]=2Ecommon_name, &quot;bob&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(=
b2-&gt;list[0]=2Ecommon_name, &quot;carol&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* and nowhere else */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_false(pool_has_cn(g2, &quot;bob&quot;));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(pool_has=
_cn(g2, &quot;carol&quot;));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_false(pool_has_cn(a2, &quot;alice&quot;));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* the reservation is honoured: the same CN get=
s its persisted address back */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(acquire(a2, &quot;bob&quot;), A_START);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_free(g);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_free(a);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_free(b);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_fr=
ee(g2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig=
_pool_free(a2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
ifconfig_pool_free(b2);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* An entry whose address matches=
 no configured pool (here: B&#39;s, when B is not</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * in the set) is ignored on load and does no=
t disturb the other pools=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+test_persist_ignore_unknown(void **state)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct ifconfig_pool *g =3D make_pool(GLOBAL_START, GLOBAL_END)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfi=
g_pool *a =3D make_pool(A_START, A_END);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct ifconfig_pool *b =3D make_pool(B_START, B_E=
ND);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    acquire(g, &quot;alice&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    acquire(a, &quo=
t;bob&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ac=
quire(b, &quot;carol&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 ifconfig_pool *pools[] =3D { g, a, b };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct ifconfig_pool_persist *wp =3D ifconfig_pool=
_persist_init(persist_file, 5);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ifconfig_pool_write(wp, pools, 3);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ifconfig_pool_persist_close(wp);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* reload into a set WITHOUT pool B: carol=
&#39;s entry now matches no pool */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct ifconfig_pool *g2 =3D make_pool(GLOBAL_START, GL=
OBAL_END);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t ifconfig_pool *a2 =3D make_pool(A_START, A_END);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool *pools2[] =3D { g2,=
 a2 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct if=
config_pool_persist *rp =3D ifconfig_pool_persist_init(persist_file, 0);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_read=
(rp, pools2, 2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ifconfig_pool_persist_close(rp);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_string_equal(g2-&gt;list[0]=2Ecommon_name, &quot;alice&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(a2=
-&gt;list[0]=2Ecommon_name, &quot;bob&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_false(pool_has_cn(g2, &quot;carol&quot=
;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fals=
e(pool_has_cn(a2, &quot;carol&quot;));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ifconfig_pool_free(g);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ifconfig_pool_free(a);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ifconfig_pool_free(b);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ifconfig_pool_free(g2);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ifconfig_pool_free(a2);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* A --subnet-pool gateway is reserved inside the pool range (here in the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * middle of a /29): =
it is never handed out, nor released=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_reserve_gateway(void **state)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct ifconfig_pool *p =3D make_pool(IP(10, 2, 3, 1), IP(1=
0, 2, 3, 6));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst char *cns[] =3D { &quot;c1&quot;, &quot;c2&quot;, &quot;c3&quot;, &quot=
;c4&quot;, &quot;c5&quot; };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    in_addr_t local =3D 0, remote =3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_false(ifconfig_pool_reserve_ip(p, IP(10, 2, 4, 1)));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ifco=
nfig_pool_reserve_ip(p, IP(10, 2, 3, 4)));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* the five other addresses go to five clients, the gateway to none=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =
=3D 0; i &lt; 5; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cons=
t in_addr_t a =3D acquire(p, cns[i]);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       assert_true(a &gt;=3D IP(10, 2, 3, 1) &amp;&amp; a &lt;=3D IP(10, 2,=
 3, 6));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ass=
ert_int_not_equal(a, IP(10, 2, 3, 4));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(ifconfig_pool_acquire(p, &amp;local, &amp;remote, NULL=
, &quot;c6&quot;) &lt; 0);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* relea=
sing the reserved slot is refused */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_false(ifconfig_pool_release(p, 3, true));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ifconfig_=
pool_acquire(p, &amp;local, &amp;remote, NULL, &quot;c6&quot;) &lt; 0);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_free(p);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* A persisted entry pointing at a now-reserved address (e=2Eg=2E a gat=
eway that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * was han=
ded out before the pool definition changed) does not take it over=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+test_reserve_survives_persist(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool =
*p =3D make_pool(IP(10, 2, 3, 1), IP(10, 2, 3, 6));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(acquire(p, &quot;alice&quot;), IP(10, 2=
, 3, 1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(acquire(p, &quot;mallory&quot;), IP(10, 2, 3, 2));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct ifconfig_pool *pools[] =3D { p };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool_pe=
rsist *wp =3D ifconfig_pool_persist_init(persist_file, 5);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_write(wp, pools, 1=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool=
_persist_close(wp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig=
_pool *p2 =3D make_pool(IP(10, 2, 3, 1), IP(10, 2, 3, 6));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ifconfig_pool_reserv=
e_ip(p2, IP(10, 2, 3, 2)));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct ifconfig_pool *pools2[] =3D { p2 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool_persist *rp =3D=
 ifconfig_pool_persist_init(persist_file, 0);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ifconfig_pool_read(rp, pools2, 1);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_persist_clos=
e(rp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(pool_has_cn(p2, =
&quot;alice&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_false(pool_has_cn(p2, &quot;mallory&quot;));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(acquire(p2, &quot=
;alice&quot;), IP(10, 2, 3, 1));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_not_equal(acquire(p2, &quot;mallory&quot;), IP(=
10, 2, 3, 2));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_free(p=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool=
_free(p2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+const struct CMUnitTest pool_tests[] =3D {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(te=
st_persist_roundtrip),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    cmocka_unit_test(test_persist_ignore_unknown),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_reserve_gateway=
),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_t=
est(test_reserve_survives_persist),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+main(void)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    persist_file =3D platform_create_temp_file(NULL, &quot;pool_p=
ersist_ut&quot;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_non_null(persist_file);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    openvpn_unit_test_setup();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    int ret =3D cmocka_run_group_tests(pool_tests, NULL, NULL=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    platform_unlink(persist_file);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br></pre><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=
=3Demail">change 1790</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1790?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 1790 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-=
Owner: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: Antonio Quartulli &lt;a=
ntonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html=
>
--C75jLMnAZdg=--


--===============8877277976219821238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8877277976219821238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8877277976219821238==--

