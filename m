Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F42C44507
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 21:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=CU3b4+LteXk/GXTyIK/V7aFuae+LEcGJKkkzkYLh9MY=; b=YL2y7/hqmqbcuV
	vRnR69IfDDga9Iw+d1r9ZAy+JjkBzBh3YNo0vLYqGXIUIgP4KiU+BqVP1ZFH9T1RRy2ggpqdqncs6
	zZ4UHA/bqxOdVoHr/WMdPElssq11KY+zeBpL84UxHN9kQfycDvxFfQOzhzLsjU+8aQnRsGI8V5U80
	uWM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk71g-0002xA-GT;
	Wed, 15 Jul 2026 21:20:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk71T-0002wv-Va
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 21:20:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C99IUIj6UPKxlb6rbuHo0DVGlpZdx9LDWedQeARi0tA=; b=RjJXxG837s0QXQLTglQ7oMYKH6
 9MW3kVk1Yo+2w0LtUABFratXX7afC/w6jMfgy/noeAoJLnU/huqR/RRN/Az6MLjwkjcVeIW/pqQvp
 PASFaYTXsbk6sz1+5hGo3cqro4SRmogfGOP/Csw6+xq2iBfHUV7yyuxFK774u1H9n7LM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=C99IUIj6UPKxlb6rbuHo0DVGlpZdx9LDWedQeARi0tA=; b=G
 39s8bWOzsWyRYDcNIWzIA1Mru3LLdZR4h8qwWKYHKCGzf29Xqohd0dySVHwZWGB0Hb5+kGRRFCap8
 5A9p6chiqlDHCmxWKnhJC9Y66Jd8ZJI4kaIDxS+wXEAqHQq1JvNy3my7ddJYnxSK64D4I9K4jk24i
 z9nZgNE/KLVGvRRU=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk71N-0001Tw-PG for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 21:20:05 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so5195855f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 14:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784150395; x=1784755195; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C99IUIj6UPKxlb6rbuHo0DVGlpZdx9LDWedQeARi0tA=;
 b=MFNVsRj8FMC1r4L8psUK54jIrcFiC9eMv2MbKnyE1AVAN7anqb6SqHDYQh8XZtGWyn
 lpZyEdm0m17KGiiOKJM940PEPJgWN+vwH5ECC35qb05HCpbpx4DCOCsyYdOjD5DYmdJ9
 yQbiSCW3EfXELbzh7gV3pX6LIWJyhHstzh0cgQUgbTFaFX2Tp9n6lMj8OTqs3pUOQrVx
 dg9hTO4ND8+oH79VL6qt322zPyyHwUkRe5m5AIvhRoBL2/T+3TD3+hcmCuYInoslkqTI
 a5fCkkN4VioaADoVnPWMN/ni6FoaQuIfvnOuefnveZBAFvll+OOxMNoDaj9+YLrPjLDk
 AdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784150395; x=1784755195;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C99IUIj6UPKxlb6rbuHo0DVGlpZdx9LDWedQeARi0tA=;
 b=os+AfvarFHO6nP9GxK7qx2T3lbBGtaXIl2ICg6l9T+xLZbYNpMIhbYCcemaYxIwO5y
 be447869iUOGShmse1bfXLi5vCgkLKcQOKeuF/A8x/keNnIpRAL7AEfAWFojy9cYEGaM
 3sndFIJEx0xIIRMaY6iWN/0BMh1g1D+zfmK98/JCA5Q5NL/GO9/hXUGIM4zTNIbWRoLh
 B6MtRGlYQqaBvkDYQEm8Ku2mK/JCdO+IRb0253W8mkH0rAGYAzHcB2lEfKbz4qvKdyWl
 YBwGq488VnfhUQgR25bCmwS0Up6z/JzyZ4GCkgAtNgrk4WO1kOCQZXm8g8zF1TjOkC8S
 E6Cg==
X-Gm-Message-State: AOJu0YwpFkxxSHzKYRTd24j30Nmcn+pehKkfaFNvOIDuS878UNnqa/8U
 AqycU8BtxY92HNYblZRjNsWFbtGiIit4+jBd1DPXsSwd9JMpYnkvmYXuk9WgIxUeI4Obv1OV7G+
 jvAe+OOtk15iTqpymXze8PlH4MkNHxLdhs2k2yWNqgjAEwVQ3gt7eXvIFIDRIzmDl9ETTSZmnKH
 w4aoZT8A==
X-Gm-Gg: AfdE7cn5OU+9J7F7vQ+eLbhnnTN2IJmEwNuehuNBam+s5JfTkRRR5raSgk+AWyaxFg1
 Vro1tPwOtlM6kWbUMOQLdHQgutLvzDrqysTIgKeDFKsZgm7Mvi2HP3F6cYkvRPauv6++qAYSwSj
 TkYGjr25eDwtRAni2FO0+eOMrREvOJbK5dsXM79vPJTsyR1NXlRU1gxL9SyIwQeIx18NnszO0Sb
 AOwuBGSjO0vtfHOgGyiFCVtEgOhe+DhhVaKwPbgbwgjChJ3umcEcETSh7UEN4emRDJPm0KoD6Zb
 Xnyu1trnWrhn634JLCH1AYecgu/HE/qFSMMkCJXCLVPQ4lEJWPRHlpcoAawhABP9DldG9l8Dho7
 Cp1pZG9TyIvyJTwBxPBy0R8Qt2TsiB8I500rv1v4Sq0yRKHvh1la/SYPd7FsWzpFcTMFRiUwO/V
 TPJgGYiqvzHH45u9WKRcI5/w/adNfS/Fg9DCIfH9/rOboq9XHolturhqQwhQnLkaB4h3ADr6G5F
 xIiqhJwGkdgSiP2AQ5IUJYX7GcpzeVGd9KeqKN7tsF9BLoMeKxhYKvyDJ40lPltI7LFumN8gHtY
 kiE=
X-Received: by 2002:a05:6000:40d9:b0:478:3f4b:348b with SMTP id
 ffacd0b85a97d-47f4fcc8180mr5296896f8f.7.1784150394501; 
 Wed, 15 Jul 2026 14:19:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c4320sm18601214f8f.32.2026.07.15.14.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 14:19:54 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 21:19:53 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05
X-Gerrit-Change-Number: 1790
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1790?usp=email>
X-Gerrit-Commit: 4860795e539180ed0d6bd1e38e73c8376f653cf7
References: <gerrit.1784150390000.I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MTUwMzkwMDAwLkkwYmZmOGQwYTU0OWE2NWI3ZGEwMWVhMGU3ODViN2VjOGJlYTE3ZjA1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <06759929a21713b074cd70a5e272cb4a8943630c-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk71N-0001Tw-PG
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8811418454849734567=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8811418454849734567==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9RwUR6i9tTk="; charset=UTF-8

--9RwUR6i9tTk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1790?usp=3Demail

to review the following change=2E


Chang=
e subject: pool, multi: persist subnet pools via --ifconfig-pool-persist
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

pool, multi: =
persist subnet pools via --ifconfig-pool-persist

Extend --ifconfig-pool-pe=
rsist so its single file covers the global pool
and every --subnet-pool=2E =
ifconfig_pool_read()/ifconfig_pool_write() now
operate on the set of pools:=
 each persisted entry is routed to the pool
whose address range owns it, an=
d an entry matching no configured pool is
ignored on load (e=2Eg=2E a --sub=
net-pool that was removed)=2E When persist is
enabled the subnet pools are =
created eagerly at startup so their saved
allocations can be reloaded befor=
e the first client connects=2E

Change-Id: I0bff8d0a549a65b7da01ea0e785b7ec=
8bea17f05
GitHub: closes openvpn/OpenVPN#987
Signed-off-by: Antonio Quartul=
li <antonio@mandelbit=2Ecom>
---
M CMakeLists=2Etxt
M doc/man-sections/serv=
er-options=2Erst
M src/openvpn/multi=2Ec
M src/openvpn/options=2Ec
M src/op=
envpn/pool=2Ec
M src/openvpn/pool=2Eh
M tests/unit_tests/openvpn/Makefile=
=2Eam
A tests/unit_tests/openvpn/test_pool=2Ec
8 files changed, 393 inserti=
ons(+), 39 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/90/1790/1

diff --git a/CMakeLists=2Etxt b/CMakeLists=2E=
txt
index 3463b5a=2E=2E0259234 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLis=
ts=2Etxt
@@ -668,6 +668,7 @@
         "test_options_parse"
         "test_p=
acket_id"
         "test_pkt"
+        "test_pool"
         "test_provider"=

         "test_socket"
         "test_ssl"
@@ -835,6 +836,15 @@
         s=
rc/openvpn/options_util=2Ec
         )
 
+    target_sources(test_pool PRIV=
ATE
+        tests/unit_tests/openvpn/mock_get_random=2Ec
+        src/open=
vpn/pool=2Ec
+        src/openvpn/status=2Ec
+        src/openvpn/otime=2Ec=

+        src/openvpn/fdmisc=2Ec
+        src/openvpn/interval=2Ec
+       =
 )
+
     target_sources(test_ncp PRIVATE
         src/openvpn/crypto_epoch=
=2Ec
         src/openvpn/crypto_mbedtls=2Ec
diff --git a/doc/man-sections/=
server-options=2Erst b/doc/man-sections/server-options=2Erst
index 0146594=
=2E=2E910a414 100644
--- a/doc/man-sections/server-options=2Erst
+++ b/doc/=
man-sections/server-options=2Erst
@@ -275,6 +275,11 @@
   ``file`` is a com=
ma-delimited ASCII file, formatted as
   :code:`<Common-Name>,<IP-address>`=
=2E
 
+  A single ``file`` covers the global pool and every ``--subnet-pool=
``: each
+  entry is associated with a pool by its address, and on load an =
entry whose
+  address falls in no configured pool (for example a ``--subne=
t-pool`` that is
+  no longer defined) is ignored=2E
+
   If ``seconds`` =
=3D :code:`0`, ``file`` will be treated as read-only=2E This
   is useful i=
f you would like to treat ``file`` as a configuration file=2E
 
diff --git =
a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 1cd84b6=2E=2Ea281764 =
100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -65,6 +65=
,41 @@
     struct ifconfig_pool *pool;
 };
 
+static struct ifconfig_pool =
*multi_get_group_pool(struct multi_context *m,
+                           =
                       const struct options *o, const char *tag);
+
+/*
+ *=
 Collect every address pool (the global one plus each --subnet-pool group)
=
+ * into a gc-allocated array, for the single combined --ifconfig-pool-pers=
ist
+ * file=2E  Returns the number of pools=2E
+ */
+static int
+multi_all=
_pools(struct multi_context *m, struct gc_arena *gc, struct ifconfig_pool *=
**pools)
+{
+    struct subnet_pool *sp;
+    int n =3D m->ifconfig_pool ? =
1 : 0;
+
+    for (sp =3D m->subnet_pools; sp; sp =3D sp->next)
+    {
+   =
     n++;
+    }
+
+    struct ifconfig_pool **arr =3D gc_malloc(n * sizeof=
(struct ifconfig_pool *), true, gc);
+    int i =3D 0;
+
+    if (m->ifconf=
ig_pool)
+    {
+        arr[i++] =3D m->ifconfig_pool;
+    }
+    for (sp=
 =3D m->subnet_pools; sp; sp =3D sp->next)
+    {
+        arr[i++] =3D sp-=
>pool;
+    }
+
+    *pools =3D arr;
+    return n;
+}
+
 /*#define MULTI_D=
EBUG_EVENT_LOOP*/
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
@@ -161,11 +196,16 @@
 v=
oid
 multi_ifconfig_pool_persist(struct multi_context *m, bool force)
 {
- =
   /* write pool data to file */
-    if (m->ifconfig_pool && m->top=2Ec1=
=2Eifconfig_pool_persist
+    /* write the global pool and every --subnet-p=
ool to the one persist file */
+    if (m->top=2Ec1=2Eifconfig_pool_persist=

         && (force || ifconfig_pool_write_trigger(m->top=2Ec1=2Eifconfig_p=
ool_persist)))
     {
-        ifconfig_pool_write(m->top=2Ec1=2Eifconfig_p=
ool_persist, m->ifconfig_pool);
+        struct gc_arena gc =3D gc_new();
+=
        struct ifconfig_pool **pools;
+        int n =3D multi_all_pools(m,=
 &gc, &pools);
+
+        ifconfig_pool_write(m->top=2Ec1=2Eifconfig_pool_p=
ersist, pools, n);
+        gc_free(&gc);
     }
 }
 
@@ -368,12 +408,29 @@=

             t->options=2Eifconfig_pool_end, t->options=2Eduplicate_cn,
  =
           t->options=2Eifconfig_ipv6_pool_defined, t->options=2Eifconfig_i=
pv6_pool_base,
             t->options=2Eifconfig_ipv6_pool_netbits);
+    =
}
 
-        /* reload pool data from file */
-        if (t->c1=2Eifconfig=
_pool_persist)
+    /* With --ifconfig-pool-persist the single file covers =
the global pool and
+     * every configured --subnet-pool, so eagerly crea=
te the subnet pools and
+     * reload them all in one pass (entries for un=
known pools are ignored)=2E */
+    if (t->c1=2Eifconfig_pool_persist)
+   =
 {
+        struct gc_arena gc =3D gc_new();
+        struct ifconfig_pool =
**pools;
+        int n;
+
+        for (const struct subnet_pool_def *d =
=3D t->options=2Esubnet_pools; d; d =3D d->next)
         {
-            if=
config_pool_read(t->c1=2Eifconfig_pool_persist, m->ifconfig_pool);
+       =
     multi_get_group_pool(m, &t->options, d->tag);
         }
+        for =
(const struct subnet_pool6_def *d =3D t->options=2Esubnet_pools_ipv6; d; d =
=3D d->next)
+        {
+            multi_get_group_pool(m, &t->options, d=
->tag);
+        }
+
+        n =3D multi_all_pools(m, &gc, &pools);
+     =
   ifconfig_pool_read(t->c1=2Eifconfig_pool_persist, pools, n);
+        gc=
_free(&gc);
     }
 
     /*
@@ -1425,7 +1482,7 @@
  * on first use from th=
e matching --subnet-pool definition=2E
  */
 static struct ifconfig_pool *
=
-multi_get_group_pool(struct multi_context *m, const char *tag)
+multi_get_=
group_pool(struct multi_context *m, const struct options *o, const char *ta=
g)
 {
     struct subnet_pool *sp;
 
@@ -1437,14 +1494,13 @@
         }
   =
  }
 
-    const struct subnet_pool_def *d4 =3D subnet_pool_by_tag(m->top=
=2Eoptions=2Esubnet_pools, tag);
-    const struct subnet_pool6_def *d6 =3D=
 subnet_pool6_by_tag(m->top=2Eoptions=2Esubnet_pools_ipv6, tag);
+    const=
 struct subnet_pool_def *d4 =3D subnet_pool_by_tag(o->subnet_pools, tag);
+=
    const struct subnet_pool6_def *d6 =3D subnet_pool6_by_tag(o->subnet_poo=
ls_ipv6, tag);
     ALLOC_OBJ_CLEAR(sp, struct subnet_pool);
     sp->tag =
=3D d4 ? d4->tag : d6->tag;
     sp->pool =3D ifconfig_pool_init(d4 !=3D NU=
LL, IFCONFIG_POOL_INDIV, d4 ? d4->network + 2 : 0,
-                       =
           d4 ? (d4->network | ~d4->netmask) - 1 : 0,
-                    =
              m->top=2Eoptions=2Eduplicate_cn, d6 !=3D NULL,
-             =
                     d6 ? add_in6_addr(d6->network, 2) : in6addr_any,
+    =
                              d4 ? (d4->network | ~d4->netmask) - 1 : 0, o-=
>duplicate_cn,
+                                  d6 !=3D NULL, d6 ? add_in=
6_addr(d6->network, 2) : in6addr_any,
                                   d6=
 ? (int)d6->netbits : 0);
     sp->next =3D m->subnet_pools;
     m->subnet=
_pools =3D sp;
@@ -1549,7 +1605,8 @@
                 cn =3D tls_common_nam=
e(mi->context=2Ec2=2Etls_multi, true);
             }
 
-            mi->va=
ddr_pool =3D multi_get_group_pool(m, mi->context=2Eoptions=2Esubnet_pool_ta=
g);
+            mi->vaddr_pool =3D
+                multi_get_group_pool(m=
, &m->top=2Eoptions, mi->context=2Eoptions=2Esubnet_pool_tag);
            =
 mi->vaddr_handle =3D
                 ifconfig_pool_acquire(mi->vaddr_pool=
, &local, &remote, &remote_ipv6, cn);
             if (mi->vaddr_handle < 0=
)
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index b448=
5ca=2E=2E40a195d 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/opt=
ions=2Ec
@@ -441,6 +441,7 @@
     "--ifconfig-pool-persist file [seconds] :=
 Persist/unpersist ifconfig-pool\n"
     "                  data to file, a=
t seconds intervals (default=3D600)=2E\n"
     "                  If second=
s=3D0, file will be treated as read-only=2E\n"
+    "                  Cove=
rs the global pool and every --subnet-pool=2E\n"
     "--ifconfig-ipv6-pool=
 base-IP/bits : set aside an IPv6 network block\n"
     "                  =
to be dynamically allocated to connecting clients=2E\n"
     "--subnet-pool=
 tag network netmask [gateway] : Define a named pool of\n"
@@ -2566,10 +256=
7,11 @@
         MUST_BE_UNDEF(route_delay_defined, "route-delay");
       =
  MUST_BE_UNDEF(up_delay, "up-delay");
         if (!options->ifconfig_pool=
_defined && !options->ifconfig_ipv6_pool_defined
+            && !options->=
subnet_pools && !options->subnet_pools_ipv6
             && options->ifconf=
ig_pool_persist_filename)
         {
-            msg(M_USAGE,
-           =
     "--ifconfig-pool-persist must be used with --ifconfig-pool or --ifconf=
ig-ipv6-pool");
+            msg(M_USAGE, "--ifconfig-pool-persist must be =
used with --ifconfig-pool, "
+                         "--ifconfig-ipv6-poo=
l or --subnet-pool");
         }
         if (options->ifconfig_ipv6_pool_d=
efined && !options->ifconfig_ipv6_local)
         {
diff --git a/src/openvp=
n/pool=2Ec b/src/openvpn/pool=2Ec
index ff74e7c=2E=2Eb260cc8 100644
--- a/s=
rc/openvpn/pool=2Ec
+++ b/src/openvpn/pool=2Ec
@@ -583,13 +583,14 @@
 }
 
 =
void
-ifconfig_pool_read(struct ifconfig_pool_persist *persist, struct ifco=
nfig_pool *pool)
+ifconfig_pool_read(struct ifconfig_pool_persist *persist,=
 struct ifconfig_pool **pools,
+                   int n_pools)
 {
     con=
st int buf_size =3D 128;
 
     update_time();
 
-    if (persist && persis=
t->file && pool)
+    if (persist && persist->file && n_pools > 0)
     {
 =
        struct gc_arena gc =3D gc_new();
         struct buffer in =3D allo=
c_buf_gc(256, &gc);
@@ -634,6 +635,9 @@
                 continue;
        =
     }
 
+            /* the address selects which pool this entry belongs =
to; an entry
+             * matching none of the configured pools is ignor=
ed */
+            struct ifconfig_pool *pool =3D NULL;
             ifconf=
ig_pool_handle h =3D -1, h6 =3D -1;
 
             if (strlen(ip_buf) > 0)
=
@@ -647,10 +651,13 @@
                 }
                 else
            =
     {
-                    h =3D ifconfig_pool_ip_base_to_handle(pool, add=
r);
-                    if (h < 0)
+                    for (int i =3D 0; =
i < n_pools && !pool; ++i)
                     {
-                        =
msg(M_WARN, "pool: IPv4 (%s) out of pool range for CN=3D%s", ip_buf, cn_buf=
);
+                        h =3D ifconfig_pool_ip_base_to_handle(pools[i],=
 addr);
+                        if (h >=3D 0)
+                        {
+=
                            pool =3D pools[i];
+                        }
 =
                    }
                 }
             }
@@ -663,12 +670,20 =
@@
                 {
                     msg(M_WARN, "pool: invalid IPv6 =
(%s) for CN=3D%s", ip6_buf, cn_buf);
                 }
+                el=
se if (pool)
+                {
+                    /* IPv4 already picked=
 the pool; v4 and v6 share the handle */
+                    h6 =3D ifconf=
ig_pool_ipv6_base_to_handle(pool, &addr6);
+                }
             =
    else
                 {
-                    h6 =3D ifconfig_pool_ipv6_=
base_to_handle(pool, &addr6);
-                    if (h6 < 0)
+           =
         for (int i =3D 0; i < n_pools && !pool; ++i)
                     =
{
-                        msg(M_WARN, "pool: IPv6 (%s) out of pool range f=
or CN=3D%s", ip6_buf, cn_buf);
+                        h6 =3D ifconfig_poo=
l_ipv6_base_to_handle(pools[i], &addr6);
+                        if (h6 >=
=3D 0)
+                        {
+                            pool =3D poo=
ls[i];
+                        }
                     }
 
                =
     /* Rely on IPv6 if no IPv4 was provided or the one provided
@@ -681,40=
 +696,44 @@
                 }
             }
 
-            /* at the mome=
nt IPv4 and IPv6 share the same pool, therefore offsets
-             * hav=
e to match for the same client=2E
-             *
-             * If offset=
s differ we use the IPv4, therefore warn the user about this=2E
-          =
   */
+            /* IPv4 and IPv6 share the same pool handle, so their of=
fsets have
+             * to match; if they differ we use the IPv4 and war=
n */
             if ((h6 >=3D 0) && (h !=3D h6))
             {
          =
       msg(M_WARN, "pool: IPv4 (%s) and IPv6 (%s) have different offsets! R=
elying on IPv4",
                     ip_buf, ip6_buf);
             }
 
- =
           /* if at least one among v4 and v6 was properly parsed, attempt
=
-             * setting an handle for this client
-             */
-       =
     if (h >=3D 0)
+            /* set the handle if the entry belongs to o=
ne of the pools */
+            if (pool && h >=3D 0)
             {
-     =
           msg(M_INFO, "succeeded -> ifconfig_pool_set(hand=3D%d)", h);
   =
              ifconfig_pool_set(pool, cn_buf, h, persist->fixed);
         =
    }
         }
 
-        ifconfig_pool_msg(pool, D_IFCONFIG_POOL);
+    =
    for (int i =3D 0; i < n_pools; ++i)
+        {
+            ifconfig_po=
ol_msg(pools[i], D_IFCONFIG_POOL);
+        }
 
         gc_free(&gc);
    =
 }
 }
 
 void
-ifconfig_pool_write(struct ifconfig_pool_persist *persist, c=
onst struct ifconfig_pool *pool)
+ifconfig_pool_write(struct ifconfig_pool_=
persist *persist, struct ifconfig_pool *const *pools,
+                    =
int n_pools)
 {
-    if (persist && persist->file && (status_rw_flags(persi=
st->file) & STATUS_OUTPUT_WRITE) && pool)
+    if (persist && persist->file=
 && (status_rw_flags(persist->file) & STATUS_OUTPUT_WRITE))
     {
        =
 status_reset(persist->file);
-        ifconfig_pool_list(pool, persist->fi=
le);
+        for (int i =3D 0; i < n_pools; ++i)
+        {
+            i=
f (pools[i])
+            {
+                ifconfig_pool_list(pools[i], p=
ersist->file);
+            }
+        }
         status_flush(persist->fil=
e);
     }
 }
diff --git a/src/openvpn/pool=2Eh b/src/openvpn/pool=2Eh
inde=
x e2d3f82=2E=2E79f3ac5 100644
--- a/src/openvpn/pool=2Eh
+++ b/src/openvpn/=
pool=2Eh
@@ -92,9 +92,15 @@
 
 bool ifconfig_pool_write_trigger(struct ifco=
nfig_pool_persist *persist);
 
-void ifconfig_pool_read(struct ifconfig_poo=
l_persist *persist, struct ifconfig_pool *pool);
+/* Read a persist file in=
to a set of pools, routing each entry to the pool
+ * whose address range o=
wns it=2E  Entries matching no pool (e=2Eg=2E a --subnet-pool
+ * that is n=
o longer configured) are ignored=2E */
+void ifconfig_pool_read(struct ifco=
nfig_pool_persist *persist, struct ifconfig_pool **pools,
+                =
        int n_pools);
 
-void ifconfig_pool_write(struct ifconfig_pool_pers=
ist *persist, const struct ifconfig_pool *pool);
+/* Write a set of pools t=
o a single persist file=2E */
+void ifconfig_pool_write(struct ifconfig_poo=
l_persist *persist,
+                         struct ifconfig_pool *const *=
pools, int n_pools);
 
 #ifdef IFCONFIG_POOL_TEST
 void ifconfig_pool_test(=
in_addr_t start, in_addr_t end);
diff --git a/tests/unit_tests/openvpn/Make=
file=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index bfb7284=2E=2Ed1d95=
74 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tes=
ts/openvpn/Makefile=2Eam
@@ -17,6 +17,7 @@
 	options_parse_testdriver \
 	p=
acket_id_testdriver \
 	pkt_testdriver \
+	pool_testdriver \
 	provider_tes=
tdriver \
 	push_update_msg_testdriver \
 	socket_testdriver \
@@ -362,6 +3=
63,23 @@
 	$(top_srcdir)/src/openvpn/platform=2Ec \
 	$(top_srcdir)/src/ope=
nvpn/mbuf=2Ec
 
+pool_testdriver_CFLAGS  =3D \
+	-I$(top_srcdir)/include -I=
$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	@TEST_CFLAGS@
+
+p=
ool_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
+
+pool_testdriver_SOURCES =3D te=
st_pool=2Ec \
+	mock_msg=2Ec test_common=2Eh \
+	mock_get_random=2Ec \
+	$(=
top_srcdir)/src/openvpn/pool=2Ec \
+	$(top_srcdir)/src/openvpn/status=2Ec \=

+	$(top_srcdir)/src/openvpn/buffer=2Ec \
+	$(top_srcdir)/src/openvpn/otime=
=2Ec \
+	$(top_srcdir)/src/openvpn/platform=2Ec \
+	$(top_srcdir)/src/openv=
pn/fdmisc=2Ec \
+	$(top_srcdir)/src/openvpn/interval=2Ec
+
 subnet_pool_tes=
tdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat =
-I$(top_srcdir)/src/openvpn \
 	@TEST_CFLAGS@
diff --git a/tests/unit_tests=
/openvpn/test_pool=2Ec b/tests/unit_tests/openvpn/test_pool=2Ec
new file mo=
de 100644
index 0000000=2E=2Edaadb32
--- /dev/null
+++ b/tests/unit_tests/o=
penvpn/test_pool=2Ec
@@ -0,0 +1,237 @@
+/*
+ *  OpenVPN -- An application t=
o securely tunnel IP networks
+ *             over a single UDP port, with =
support for SSL/TLS-based
+ *             session authentication and key ex=
change,
+ *             packet encryption, packet authentication, and
+ *  =
           packet compression=2E
+ *
+ *  Copyright (C) 2026 OpenVPN Inc <s=
ales@openvpn=2Enet>
+ *
+ *  This program is free software; you can redistr=
ibute it and/or modify
+ *  it under the terms of the GNU General Public Li=
cense version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ =
*  This program is distributed in the hope that it will be useful,
+ *  but=
 WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTAB=
ILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Publ=
ic License for more details=2E
+ *
+ *  You should have received a copy of =
the GNU General Public License along
+ *  with this program; if not, see <h=
ttps://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include=
 "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdlib=2Eh>
+#=
include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "pool=2Eh"
+#includ=
e "buffer=2Eh"
+#include "test_common=2Eh"
+#include "mock_msg=2Eh"
+
+/*
+=
 * pool=2Ec pulls in a few socket=2Ec/socket_util=2Ec helpers for address p=
arsing and
+ * formatting=2E  The pool logic under test does not need the f=
ull socket stack,
+ * so provide small IPv4 implementations here (the IPv6 =
ones are not reached by
+ * these IPv4-only pools, but must exist to link)=
=2E
+ */
+struct signal_info;
+
+in_addr_t
+getaddr(unsigned int flags, con=
st char *hostname, int resolve_retry_seconds, bool *succeeded,
+        str=
uct signal_info *sig_info)
+{
+    struct in_addr a;
+    int ok =3D inet_p=
ton(AF_INET, hostname, &a) =3D=3D 1;
+
+    if (succeeded)
+    {
+        =
*succeeded =3D ok;
+    }
+    return ok ? ntohl(a=2Es_addr) : 0;
+}
+
+con=
st char *
+print_in_addr_t(in_addr_t addr, unsigned int flags, struct gc_ar=
ena *gc)
+{
+    struct in_addr a =3D { =2Es_addr =3D htonl(addr) };
+    c=
har buf[INET_ADDRSTRLEN] =3D { 0 };
+
+    inet_ntop(AF_INET, &a, buf, size=
of(buf));
+    return string_alloc(buf, gc);
+}
+
+bool
+get_ipv6_addr(cons=
t char *hostname, struct in6_addr *network, unsigned int *netbits,
+       =
       msglvl_t msglevel)
+{
+    return false;
+}
+
+const char *
+print_i=
n6_addr(struct in6_addr a6, unsigned int flags, struct gc_arena *gc)
+{
+  =
  return "";
+}
+
+struct in6_addr
+add_in6_addr(struct in6_addr base, uint=
32_t add)
+{
+    return base;
+}
+
+#define IP(a, b, c, d) (((in_addr_t)(a=
) << 24) | ((b) << 16) | ((c) << 8) | (d))
+
+/* three non-overlapping /24 =
pools: the global one and two --subnet-pool groups */
+#define GLOBAL_START=
 IP(10, 1, 1, 2)
+#define GLOBAL_END   IP(10, 1, 1, 254)
+#define A_START  =
    IP(10, 2, 1, 2)
+#define A_END        IP(10, 2, 1, 254)
+#define B_STAR=
T      IP(10, 2, 2, 2)
+#define B_END        IP(10, 2, 2, 254)
+
+static st=
ruct ifconfig_pool *
+make_pool(in_addr_t start, in_addr_t end)
+{
+    str=
uct in6_addr any =3D { 0 };
+
+    return ifconfig_pool_init(true, IFCONFIG=
_POOL_INDIV, start, end, false, false, any, 0);
+}
+
+static in_addr_t
+acq=
uire(struct ifconfig_pool *pool, const char *cn)
+{
+    in_addr_t local =
=3D 0, remote =3D 0;
+
+    ifconfig_pool_acquire(pool, &local, &remote, NU=
LL, cn);
+    return remote;
+}
+
+/* whether any entry of the pool is rese=
rved for common name cn */
+static bool
+pool_has_cn(const struct ifconfig_=
pool *pool, const char *cn)
+{
+    for (int i =3D 0; i < pool->size; ++i)
=
+    {
+        if (pool->list[i]=2Ecommon_name && !strcmp(pool->list[i]=2E=
common_name, cn))
+        {
+            return true;
+        }
+    }
+ =
   return false;
+}
+
+static const char *persist_file;
+
+/* Write {global=
, A, B} to one persist file, reload into a fresh set, and check
+ * that ev=
ery entry was routed back to the pool that owns its address=2E */
+static v=
oid
+test_persist_roundtrip(void **state)
+{
+    struct ifconfig_pool *g =
=3D make_pool(GLOBAL_START, GLOBAL_END);
+    struct ifconfig_pool *a =3D m=
ake_pool(A_START, A_END);
+    struct ifconfig_pool *b =3D make_pool(B_STAR=
T, B_END);
+
+    assert_int_equal(acquire(g, "alice"), GLOBAL_START);
+   =
 assert_int_equal(acquire(a, "bob"), A_START);
+    assert_int_equal(acquir=
e(b, "carol"), B_START);
+
+    struct ifconfig_pool *pools[] =3D { g, a, b=
 };
+    struct ifconfig_pool_persist *wp =3D ifconfig_pool_persist_init(pe=
rsist_file, 5);
+    ifconfig_pool_write(wp, pools, 3);
+    ifconfig_pool_=
persist_close(wp);
+
+    struct ifconfig_pool *g2 =3D make_pool(GLOBAL_STA=
RT, GLOBAL_END);
+    struct ifconfig_pool *a2 =3D make_pool(A_START, A_END=
);
+    struct ifconfig_pool *b2 =3D make_pool(B_START, B_END);
+    struct=
 ifconfig_pool *pools2[] =3D { g2, a2, b2 };
+    struct ifconfig_pool_pers=
ist *rp =3D ifconfig_pool_persist_init(persist_file, 0);
+    ifconfig_pool=
_read(rp, pools2, 3);
+    ifconfig_pool_persist_close(rp);
+
+    /* each =
client was routed to its own pool (handle 0 =3D=3D the pool's base) */
+   =
 assert_string_equal(g2->list[0]=2Ecommon_name, "alice");
+    assert_strin=
g_equal(a2->list[0]=2Ecommon_name, "bob");
+    assert_string_equal(b2->lis=
t[0]=2Ecommon_name, "carol");
+
+    /* and nowhere else */
+    assert_fal=
se(pool_has_cn(g2, "bob"));
+    assert_false(pool_has_cn(g2, "carol"));
+ =
   assert_false(pool_has_cn(a2, "alice"));
+
+    /* the reservation is hon=
oured: the same CN gets its persisted address back */
+    assert_int_equal=
(acquire(a2, "bob"), A_START);
+
+    ifconfig_pool_free(g);
+    ifconfig_=
pool_free(a);
+    ifconfig_pool_free(b);
+    ifconfig_pool_free(g2);
+   =
 ifconfig_pool_free(a2);
+    ifconfig_pool_free(b2);
+}
+
+/* An entry who=
se address matches no configured pool (here: B's, when B is not
+ * in the =
set) is ignored on load and does not disturb the other pools=2E */
+static =
void
+test_persist_ignore_unknown(void **state)
+{
+    struct ifconfig_poo=
l *g =3D make_pool(GLOBAL_START, GLOBAL_END);
+    struct ifconfig_pool *a =
=3D make_pool(A_START, A_END);
+    struct ifconfig_pool *b =3D make_pool(B=
_START, B_END);
+
+    acquire(g, "alice");
+    acquire(a, "bob");
+    ac=
quire(b, "carol");
+
+    struct ifconfig_pool *pools[] =3D { g, a, b };
+ =
   struct ifconfig_pool_persist *wp =3D ifconfig_pool_persist_init(persist_=
file, 5);
+    ifconfig_pool_write(wp, pools, 3);
+    ifconfig_pool_persis=
t_close(wp);
+
+    /* reload into a set WITHOUT pool B: carol's entry now =
matches no pool */
+    struct ifconfig_pool *g2 =3D make_pool(GLOBAL_START=
, GLOBAL_END);
+    struct ifconfig_pool *a2 =3D make_pool(A_START, A_END);=

+    struct ifconfig_pool *pools2[] =3D { g2, a2 };
+    struct ifconfig_p=
ool_persist *rp =3D ifconfig_pool_persist_init(persist_file, 0);
+    ifcon=
fig_pool_read(rp, pools2, 2);
+    ifconfig_pool_persist_close(rp);
+
+    =
assert_string_equal(g2->list[0]=2Ecommon_name, "alice");
+    assert_string=
_equal(a2->list[0]=2Ecommon_name, "bob");
+    assert_false(pool_has_cn(g2,=
 "carol"));
+    assert_false(pool_has_cn(a2, "carol"));
+
+    ifconfig_po=
ol_free(g);
+    ifconfig_pool_free(a);
+    ifconfig_pool_free(b);
+    if=
config_pool_free(g2);
+    ifconfig_pool_free(a2);
+}
+
+const struct CMUni=
tTest pool_tests[] =3D {
+    cmocka_unit_test(test_persist_roundtrip),
+  =
  cmocka_unit_test(test_persist_ignore_unknown),
+};
+
+int
+main(void)
+{
=
+    char template[] =3D "/tmp/ovpn_pool_persist_ut=2EXXXXXX";
+    int fd =
=3D mkstemp(template);
+
+    assert_true(fd >=3D 0);
+    close(fd);
+    =
persist_file =3D template;
+
+    openvpn_unit_test_setup();
+    int ret =
=3D cmocka_run_group_tests(pool_tests, NULL, NULL);
+
+    unlink(template)=
;
+    return ret;
+}

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1790?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05
Gerrit-Change-Number: 1790
Ger=
rit-PatchSet: 1
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Review=
er: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvp=
n@rfc2549=2Eorg>

--9RwUR6i9tTk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1790?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">po=
ol, multi: persist subnet pools via --ifconfig-pool-persist<br><br>Extend -=
-ifconfig-pool-persist so its single file covers the global pool<br>and eve=
ry --subnet-pool=2E ifconfig_pool_read()/ifconfig_pool_write() now<br>opera=
te on the set of pools: each persisted entry is routed to the pool<br>whose=
 address range owns it, and an entry matching no configured pool is<br>igno=
red on load (e=2Eg=2E a --subnet-pool that was removed)=2E When persist is<=
br>enabled the subnet pools are created eagerly at startup so their saved<b=
r>allocations can be reloaded before the first client connects=2E<br><br>Ch=
ange-Id: I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05<br>GitHub: closes openvp=
n/OpenVPN#987<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ec=
om&gt;<br>---<br>M CMakeLists=2Etxt<br>M doc/man-sections/server-options=2E=
rst<br>M src/openvpn/multi=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvp=
n/pool=2Ec<br>M src/openvpn/pool=2Eh<br>M tests/unit_tests/openvpn/Makefile=
=2Eam<br>A tests/unit_tests/openvpn/test_pool=2Ec<br>8 files changed, 393 i=
nsertions(+), 39 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/90/1790/1</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 3463b5a=2E=2E0=
259234 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/=
CMakeLists=2Etxt</span><br><span>@@ -668,6 +668,7 @@</span><br><span>      =
   &quot;test_options_parse&quot;</span><br><span>         &quot;test_packe=
t_id&quot;</span><br><span>         &quot;test_pkt&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        &quot;test_pool&quot;</span><b=
r><span>         &quot;test_provider&quot;</span><br><span>         &quot;t=
est_socket&quot;</span><br><span>         &quot;test_ssl&quot;</span><br><s=
pan>@@ -835,6 +836,15 @@</span><br><span>         src/openvpn/options_util=
=2Ec</span><br><span>         )</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    target_sources(test_pool PRIVATE</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/ope=
nvpn/mock_get_random=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        src/openvpn/pool=2Ec</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        src/openvpn/status=2Ec</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        src/openvpn/otime=2Ec</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/fdmisc=2Ec</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/interval=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        )</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     tar=
get_sources(test_ncp PRIVATE</span><br><span>         src/openvpn/crypto_ep=
och=2Ec</span><br><span>         src/openvpn/crypto_mbedtls=2Ec</span><br><=
span>diff --git a/doc/man-sections/server-options=2Erst b/doc/man-sections/=
server-options=2Erst</span><br><span>index 0146594=2E=2E910a414 100644</spa=
n><br><span>--- a/doc/man-sections/server-options=2Erst</span><br><span>+++=
 b/doc/man-sections/server-options=2Erst</span><br><span>@@ -275,6 +275,11 =
@@</span><br><span>   ``file`` is a comma-delimited ASCII file, formatted a=
s</span><br><span>   :code:`&lt;Common-Name&gt;,&lt;IP-address&gt;`=2E</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  A si=
ngle ``file`` covers the global pool and every ``--subnet-pool``: each</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  entry is associated wi=
th a pool by its address, and on load an entry whose</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  address falls in no configured pool (fo=
r example a ``--subnet-pool`` that is</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  no longer defined) is ignored=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   If ``seconds`` =3D :c=
ode:`0`, ``file`` will be treated as read-only=2E This</span><br><span>   i=
s useful if you would like to treat ``file`` as a configuration file=2E</sp=
an><br><span> </span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/ope=
nvpn/multi=2Ec</span><br><span>index 1cd84b6=2E=2Ea281764 100644</span><br>=
<span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=
=2Ec</span><br><span>@@ -65,6 +65,41 @@</span><br><span>     struct ifconfi=
g_pool *pool;</span><br><span> };</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static struct ifconfig_pool *multi_get_gr=
oup_pool(struct multi_context *m,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                                  const struc=
t options *o, const char *tag);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Collect every address=
 pool (the global one plus each --subnet-pool group)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * into a gc-allocated array, for the sin=
gle combined --ifconfig-pool-persist</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * file=2E  Returns the number of pools=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+multi_all_pools(struct multi_context *m, struct gc_arena *gc=
, struct ifconfig_pool ***pools)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct subnet_pool *sp;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int n =3D m-&gt;ifconfig_pool ? 1 : 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    for (sp =3D m-&gt;subnet_pools; sp; sp =3D sp-&gt;next)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        n++;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct ifconfig_pool **arr =3D gc_malloc(n * sizeof(struct ifconfig_pool *), =
true, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (m-&gt;ifconfig_pool)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        arr[i++] =3D m-&gt;ifconfig_=
pool;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    for (sp =3D m-&gt;subnet=
_pools; sp; sp =3D sp-&gt;next)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      arr[i++] =3D sp-&gt;pool;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *pools =3D arr;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return n;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> /*#define MULTI_DEBUG_EVENT=
_LOOP*/</span><br><span> </span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</s=
pan><br><span>@@ -161,11 +196,16 @@</span><br><span> void</span><br><span> =
multi_ifconfig_pool_persist(struct multi_context *m, bool force)</span><br>=
<span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* write =
pool data to file */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (m-&gt;ifconfig_pool &amp;&amp; m-&gt;top=2Ec1=2Eifconfig_pool_persis=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* write the g=
lobal pool and every --subnet-pool to the one persist file */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (m-&gt;top=2Ec1=2Eifconfig=
_pool_persist</span><br><span>         &amp;&amp; (force || ifconfig_pool_w=
rite_trigger(m-&gt;top=2Ec1=2Eifconfig_pool_persist)))</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ifconfig_po=
ol_write(m-&gt;top=2Ec1=2Eifconfig_pool_persist, m-&gt;ifconfig_pool);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena =
gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     struct ifconfig_pool **pools;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        int n =3D multi_all_pools(m, &amp;gc, &amp;pools);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        ifconfig_pool_write(m-&gt;top=2E=
c1=2Eifconfig_pool_persist, pools, n);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span>     }</span><=
br><span> }</span><br><span> </span><br><span>@@ -368,12 +408,29 @@</span><=
br><span>             t-&gt;options=2Eifconfig_pool_end, t-&gt;options=2Edu=
plicate_cn,</span><br><span>             t-&gt;options=2Eifconfig_ipv6_pool=
_defined, t-&gt;options=2Eifconfig_ipv6_pool_base,</span><br><span>        =
     t-&gt;options=2Eifconfig_ipv6_pool_netbits);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /* reload pool data from file */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (t-&gt;c1=2Ei=
fconfig_pool_persist)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* With --ifconfig-pool-persist the single file covers the global poo=
l and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * every c=
onfigured --subnet-pool, so eagerly create the subnet pools and</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * reload them all in one p=
ass (entries for unknown pools are ignored)=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (t-&gt;c1=2Eifconfig_pool_persist)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new=
();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct i=
fconfig_pool **pools;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        int n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (const str=
uct subnet_pool_def *d =3D t-&gt;options=2Esubnet_pools; d; d =3D d-&gt;nex=
t)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            ifconfig_pool_read(t-&gt;c1=2Eifconfig_pool_persist, m-=
&gt;ifconfig_pool);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            multi_get_group_pool(m, &amp;t-&gt;options, d-&gt;tag);</span><=
br><span>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        for (const struct subnet_pool6_def *d =3D t-&gt;options=2Esubnet_po=
ols_ipv6; d; d =3D d-&gt;next)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            multi_get_group_pool(m, &amp;t-&gt;options, d-&gt;tag);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        n =3D multi_all_pools(m, &amp;gc, &amp;pools);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ifconfig_poo=
l_read(t-&gt;c1=2Eifconfig_pool_persist, pools, n);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span=
>     }</span><br><span> </span><br><span>     /*</span><br><span>@@ -1425,=
7 +1482,7 @@</span><br><span>  * on first use from the matching --subnet-po=
ol definition=2E</span><br><span>  */</span><br><span> static struct ifconf=
ig_pool *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_get_gr=
oup_pool(struct multi_context *m, const char *tag)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+multi_get_group_pool(struct multi_context *m=
, const struct options *o, const char *tag)</span><br><span> {</span><br><s=
pan>     struct subnet_pool *sp;</span><br><span> </span><br><span>@@ -1437=
,14 +1494,13 @@</span><br><span>         }</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const str=
uct subnet_pool_def *d4 =3D subnet_pool_by_tag(m-&gt;top=2Eoptions=2Esubnet=
_pools, tag);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cons=
t struct subnet_pool6_def *d6 =3D subnet_pool6_by_tag(m-&gt;top=2Eoptions=
=2Esubnet_pools_ipv6, tag);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const struct subnet_pool_def *d4 =3D subnet_pool_by_tag(o-&gt;s=
ubnet_pools, tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const struct subnet_pool6_def *d6 =3D subnet_pool6_by_tag(o-&gt;subnet_p=
ools_ipv6, tag);</span><br><span>     ALLOC_OBJ_CLEAR(sp, struct subnet_poo=
l);</span><br><span>     sp-&gt;tag =3D d4 ? d4-&gt;tag : d6-&gt;tag;</span=
><br><span>     sp-&gt;pool =3D ifconfig_pool_init(d4 !=3D NULL, IFCONFIG_P=
OOL_INDIV, d4 ? d4-&gt;network + 2 : 0,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                                  d4 ? (d4-&gt;network | =
~d4-&gt;netmask) - 1 : 0,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                  m-&gt;top=2Eoptions=2Eduplicate_cn, d=
6 !=3D NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                         d6 ? add_in6_addr(d6-&gt;network, 2) : in6addr_any=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                d4 ? (d4-&gt;network | ~d4-&gt;netmask) - 1 : 0, o-&gt;dupl=
icate_cn,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                        d6 !=3D NULL, d6 ? add_in6_addr(d6-&gt;network, 2) =
: in6addr_any,</span><br><span>                                   d6 ? (int=
)d6-&gt;netbits : 0);</span><br><span>     sp-&gt;next =3D m-&gt;subnet_poo=
ls;</span><br><span>     m-&gt;subnet_pools =3D sp;</span><br><span>@@ -154=
9,7 +1605,8 @@</span><br><span>                 cn =3D tls_common_name(mi-&=
gt;context=2Ec2=2Etls_multi, true);</span><br><span>             }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
mi-&gt;vaddr_pool =3D multi_get_group_pool(m, mi-&gt;context=2Eoptions=2Esu=
bnet_pool_tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        mi-&gt;vaddr_pool =3D</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                multi_get_group_pool(m, &amp;m-&gt;top=2Eoptions,=
 mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</span><br><span>             =
mi-&gt;vaddr_handle =3D</span><br><span>                 ifconfig_pool_acqu=
ire(mi-&gt;vaddr_pool, &amp;local, &amp;remote, &amp;remote_ipv6, cn);</spa=
n><br><span>             if (mi-&gt;vaddr_handle &lt; 0)</span><br><span>di=
ff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><spa=
n>index b4485ca=2E=2E40a195d 100644</span><br><span>--- a/src/openvpn/optio=
ns=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -44=
1,6 +441,7 @@</span><br><span>     &quot;--ifconfig-pool-persist file [seco=
nds] : Persist/unpersist ifconfig-pool\n&quot;</span><br><span>     &quot; =
                 data to file, at seconds intervals (default=3D600)=2E\n&qu=
ot;</span><br><span>     &quot;                  If seconds=3D0, file will =
be treated as read-only=2E\n&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &quot;                  Covers the global pool and every=
 --subnet-pool=2E\n&quot;</span><br><span>     &quot;--ifconfig-ipv6-pool b=
ase-IP/bits : set aside an IPv6 network block\n&quot;</span><br><span>     =
&quot;                  to be dynamically allocated to connecting clients=
=2E\n&quot;</span><br><span>     &quot;--subnet-pool tag network netmask [g=
ateway] : Define a named pool of\n&quot;</span><br><span>@@ -2566,10 +2567,=
11 @@</span><br><span>         MUST_BE_UNDEF(route_delay_defined, &quot;rou=
te-delay&quot;);</span><br><span>         MUST_BE_UNDEF(up_delay, &quot;up-=
delay&quot;);</span><br><span>         if (!options-&gt;ifconfig_pool_defin=
ed &amp;&amp; !options-&gt;ifconfig_ipv6_pool_defined</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; !options-&gt;subne=
t_pools &amp;&amp; !options-&gt;subnet_pools_ipv6</span><br><span>         =
    &amp;&amp; options-&gt;ifconfig_pool_persist_filename)</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 msg(M_USAGE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        &quot;--ifconfig-pool-persist must be used with --ifconfig-pool or =
--ifconfig-ipv6-pool&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            msg(M_USAGE, &quot;--ifconfig-pool-persist must be use=
d with --ifconfig-pool, &quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                         &quot;--ifconfig-ipv6-pool or --subnet-=
pool&quot;);</span><br><span>         }</span><br><span>         if (option=
s-&gt;ifconfig_ipv6_pool_defined &amp;&amp; !options-&gt;ifconfig_ipv6_loca=
l)</span><br><span>         {</span><br><span>diff --git a/src/openvpn/pool=
=2Ec b/src/openvpn/pool=2Ec</span><br><span>index ff74e7c=2E=2Eb260cc8 1006=
44</span><br><span>--- a/src/openvpn/pool=2Ec</span><br><span>+++ b/src/ope=
nvpn/pool=2Ec</span><br><span>@@ -583,13 +583,14 @@</span><br><span> }</spa=
n><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-ifconfig_pool_read(struct ifconfig_pool_persist *persist, str=
uct ifconfig_pool *pool)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ifconfig_pool_read(struct ifconfig_pool_persist *persist, struct ifcon=
fig_pool **pools,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                 int n_pools)</span><br><span> {</span><br><span>     const=
 int buf_size =3D 128;</span><br><span> </span><br><span>     update_time()=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (persist &amp;&amp; persist-&gt;file &amp;&amp; pool)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (persist &amp;&amp; persist-&=
gt;file &amp;&amp; n_pools &gt; 0)</span><br><span>     {</span><br><span> =
        struct gc_arena gc =3D gc_new();</span><br><span>         struct bu=
ffer in =3D alloc_buf_gc(256, &amp;gc);</span><br><span>@@ -634,6 +635,9 @@=
</span><br><span>                 continue;</span><br><span>             }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          /* the address selects which pool this entry belongs to; an entry=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * matc=
hing none of the configured pools is ignored */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            struct ifconfig_pool *pool =3D NULL=
;</span><br><span>             ifconfig_pool_handle h =3D -1, h6 =3D -1;</s=
pan><br><span> </span><br><span>             if (strlen(ip_buf) &gt; 0)</sp=
an><br><span>@@ -647,10 +651,13 @@</span><br><span>                 }</span=
><br><span>                 else</span><br><span>                 {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    h =3D ifc=
onfig_pool_ip_base_to_handle(pool, addr);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    if (h &lt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    for (int i =3D 0; i &=
lt; n_pools &amp;&amp; !pool; ++i)</span><br><span>                     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
 msg(M_WARN, &quot;pool: IPv4 (%s) out of pool range for CN=3D%s&quot;, ip_=
buf, cn_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                  h =3D ifconfig_pool_ip_base_to_handle(pools[i], addr);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
  if (h &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                       {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                            pool =3D pools[i];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        }</span><br><span=
>                     }</span><br><span>                 }</span><br><span>=
             }</span><br><span>@@ -663,12 +670,20 @@</span><br><span>      =
           {</span><br><span>                     msg(M_WARN, &quot;pool: i=
nvalid IPv6 (%s) for CN=3D%s&quot;, ip6_buf, cn_buf);</span><br><span>     =
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          else if (pool)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    /* IPv4 already picked the pool; v4 and v6 share the=
 handle */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           h6 =3D ifconfig_pool_ipv6_base_to_handle(pool, &amp;addr6);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</span>=
<br><span>                 else</span><br><span>                 {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    h6 =3D ifc=
onfig_pool_ipv6_base_to_handle(pool, &amp;addr6);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    if (h6 &lt; 0)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    for (int i =
=3D 0; i &lt; n_pools &amp;&amp; !pool; ++i)</span><br><span>              =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
           msg(M_WARN, &quot;pool: IPv6 (%s) out of pool range for CN=3D%s&=
quot;, ip6_buf, cn_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                        h6 =3D ifconfig_pool_ipv6_base_to_handle(pools=
[i], &amp;addr6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      if (h6 &gt;=3D 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                            pool =3D pools[i];</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
  }</span><br><span>                     }</span><br><span> </span><br><spa=
n>                     /* Rely on IPv6 if no IPv4 was provided or the one p=
rovided</span><br><span>@@ -681,40 +696,44 @@</span><br><span>             =
    }</span><br><span>             }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            /* at the moment IPv4 and IPv6=
 share the same pool, therefore offsets</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-             * have to match for the same client=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-             *</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-             * If offsets differ w=
e use the IPv4, therefore warn the user about this=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-             */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            /* IPv4 and IPv6 share the same poo=
l handle, so their offsets have</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+             * to match; if they differ we use the IPv4 and war=
n */</span><br><span>             if ((h6 &gt;=3D 0) &amp;&amp; (h !=3D h6)=
)</span><br><span>             {</span><br><span>                 msg(M_WAR=
N, &quot;pool: IPv4 (%s) and IPv6 (%s) have different offsets! Relying on I=
Pv4&quot;,</span><br><span>                     ip_buf, ip6_buf);</span><br=
><span>             }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            /* if at least one among v4 and v6 was proper=
ly parsed, attempt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
          * setting an handle for this client</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-             */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            if (h &gt;=3D 0)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            /* set the handle if the entry belon=
gs to one of the pools */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            if (pool &amp;&amp; h &gt;=3D 0)</span><br><span>        =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 msg(M_INFO, &quot;succeeded -&gt; ifconfig_pool_set(hand=3D%d)&quot;, h);<=
/span><br><span>                 ifconfig_pool_set(pool, cn_buf, h, persist=
-&gt;fixed);</span><br><span>             }</span><br><span>         }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
ifconfig_pool_msg(pool, D_IFCONFIG_POOL);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; n_pools; ++i)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            ifconfig_pool_msg(pools[=
i], D_IFCONFIG_POOL);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span> </span><br><span>         gc_free(&amp;gc);</s=
pan><br><span>     }</span><br><span> }</span><br><span> </span><br><span> =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ifconfig_pool_wri=
te(struct ifconfig_pool_persist *persist, const struct ifconfig_pool *pool)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ifconfig_pool_write=
(struct ifconfig_pool_persist *persist, struct ifconfig_pool *const *pools,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 int n_pools)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (persist &amp;&amp; persist-&gt;file &amp;&amp; (status_r=
w_flags(persist-&gt;file) &amp; STATUS_OUTPUT_WRITE) &amp;&amp; pool)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (persist &amp;&amp=
; persist-&gt;file &amp;&amp; (status_rw_flags(persist-&gt;file) &amp; STAT=
US_OUTPUT_WRITE))</span><br><span>     {</span><br><span>         status_re=
set(persist-&gt;file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        ifconfig_pool_list(pool, persist-&gt;file);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; n_pools;=
 ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (pools[i]=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                ifconfig=
_pool_list(pools[i], persist-&gt;file);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span>         status_flush(persist-&gt;f=
ile);</span><br><span>     }</span><br><span> }</span><br><span>diff --git =
a/src/openvpn/pool=2Eh b/src/openvpn/pool=2Eh</span><br><span>index e2d3f82=
=2E=2E79f3ac5 100644</span><br><span>--- a/src/openvpn/pool=2Eh</span><br><=
span>+++ b/src/openvpn/pool=2Eh</span><br><span>@@ -92,9 +92,15 @@</span><b=
r><span> </span><br><span> bool ifconfig_pool_write_trigger(struct ifconfig=
_pool_persist *persist);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-void ifconfig_pool_read(struct ifconfig_pool_persist *=
persist, struct ifconfig_pool *pool);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* Read a persist file into a set of pools, routing each =
entry to the pool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 whose address range owns it=2E  Entries matching no pool (e=2Eg=2E a --sub=
net-pool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * that is =
no longer configured) are ignored=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void ifconfig_pool_read(struct ifconfig_pool_persist *p=
ersist, struct ifconfig_pool **pools,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                        int n_pools);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-void ifconfig_pool_writ=
e(struct ifconfig_pool_persist *persist, const struct ifconfig_pool *pool);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Write a set of p=
ools to a single persist file=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void ifconfig_pool_write(struct ifconfig_pool_persist *pers=
ist,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
          struct ifconfig_pool *const *pools, int n_pools);</span><br><span=
> </span><br><span> #ifdef IFCONFIG_POOL_TEST</span><br><span> void ifconfi=
g_pool_test(in_addr_t start, in_addr_t end);</span><br><span>diff --git a/t=
ests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=
=2Eam</span><br><span>index bfb7284=2E=2Ed1d9574 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_=
tests/openvpn/Makefile=2Eam</span><br><span>@@ -17,6 +17,7 @@</span><br><sp=
an> 	options_parse_testdriver \</span><br><span> 	packet_id_testdriver \</s=
pan><br><span> 	pkt_testdriver \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	pool_testdriver \</span><br><span> 	provider_testdriver \</sp=
an><br><span> 	push_update_msg_testdriver \</span><br><span> 	socket_testdr=
iver \</span><br><span>@@ -362,6 +363,23 @@</span><br><span> 	$(top_srcdir)=
/src/openvpn/platform=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/mbu=
f=2Ec</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+pool_testdriver_CFLAGS  =3D \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_s=
rcdir)/src/openvpn \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	@TEST_CFLAGS@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+pool_testdriver_LDFLAGS=
 =3D @TEST_LDFLAGS@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pool_testdriver_SOU=
RCES =3D test_pool=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	mock_msg=2Ec test_common=2Eh \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	mock_get_random=2Ec \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/pool=2Ec \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/status=2Ec=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/sr=
c/openvpn/buffer=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	$(top_srcdir)/src/openvpn/otime=2Ec \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/fdmi=
sc=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcd=
ir)/src/openvpn/interval=2Ec</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> subnet_pool_testdriver_CFLAGS  =3D \</span><br><=
span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/s=
rc/openvpn \</span><br><span> 	@TEST_CFLAGS@</span><br><span>diff --git a/t=
ests/unit_tests/openvpn/test_pool=2Ec b/tests/unit_tests/openvpn/test_pool=
=2Ec</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=
=2Edaadb32</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_t=
ests/openvpn/test_pool=2Ec</span><br><span>@@ -0,0 +1,237 @@</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP=
 networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     over a single UDP port, with support for SSL/TLS-based</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *             session authenticati=
on and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *             packet encryption, packet authentication, and</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 OpenVPN In=
c &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Thi=
s program is free software; you can redistribute it and/or modify</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the=
 GNU General Public License version 2</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  as published by the Free Software Foundation=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the ho=
pe that it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a co=
py of the GNU General Public License along</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=
=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;pool=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_co=
mmon=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;mock_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * pool=2Ec pulls in a few =
socket=2Ec/socket_util=2Ec helpers for address parsing and</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * formatting=2E  The pool logic und=
er test does not need the full socket stack,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * so provide small IPv4 implementations here (the=
 IPv6 ones are not reached by</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * these IPv4-only pools, but must exist to link)=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+struct signal_info;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+in_addr_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ge=
taddr(unsigned int flags, const char *hostname, int resolve_retry_seconds, =
bool *succeeded,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     struct signal_info *sig_info)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct in_addr a;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int ok =3D inet_pton(AF_INET, hostname, &amp;a) =3D=3D 1;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (succeeded)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        *succeeded =3D ok;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return ok ? ntohl(a=2Es_addr) : 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+print_in_addr_t(in_addr_t=
 addr, unsigned int flags, struct gc_arena *gc)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct in_addr a =3D { =2Es_addr =3D htonl(addr) };</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    char buf[INET_ADDRSTRLEN]=
 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    inet_ntop(AF_INET, &amp=
;a, buf, sizeof(buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return string_alloc(buf, gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+get_ipv6_addr(const char *hostname,=
 struct in6_addr *network, unsigned int *netbits,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+              msglvl_t msglevel)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+print_in6_addr(struct=
 in6_addr a6, unsigned int flags, struct gc_arena *gc)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return &quot;&quot;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct in6_addr=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_in6_addr(struct=
 in6_addr base, uint32_t add)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn base;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define IP(a, b, c, d) (((in_addr_t)(a) &lt;&lt;=
 24) | ((b) &lt;&lt; 16) | ((c) &lt;&lt; 8) | (d))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* three non-overlapping /24 pools: the global one and two --su=
bnet-pool groups */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define GLOBAL_START IP(10, 1, 1, 2)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define GLOBAL_END   IP(10, 1, 1, 254)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define A_START      IP(10, 2, 1, 2)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define A_END        I=
P(10, 2, 1, 254)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine B_START      IP(10, 2, 2, 2)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define B_END        IP(10, 2, 2, 254)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static struct ifconfig_pool *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+make_pool(in_addr_t start, in_addr_t end)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct in6_addr any =3D { 0 };</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return ifconfig_pool_init(true, IFCONFIG_POOL_=
INDIV, start, end, false, false, any, 0);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static in_addr_=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+acquire(struct ifc=
onfig_pool *pool, const char *cn)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
in_addr_t local =3D 0, remote =3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ifconfig_pool_acquire(pool, &amp;local, &amp;remote, NULL, cn);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return remote;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* whether any entry of the pool is reserved for common name cn */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+pool_has_cn(const struct ifc=
onfig_pool *pool, const char *cn)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
for (int i =3D 0; i &lt; pool-&gt;size; ++i)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (pool-&gt;list[i]=2Ecommon_name &amp;&amp; !strcmp(po=
ol-&gt;list[i]=2Ecommon_name, cn))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            return true;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static const char *persist_file;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* Write {global, A, B} to one persist file, reload into a =
fresh set, and check</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * that every entry was routed back to the pool that owns its address=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+test_persist_roundtrip(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool *g=
 =3D make_pool(GLOBAL_START, GLOBAL_END);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct ifconfig_pool *a =3D make_pool(A_START, A_=
END);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifc=
onfig_pool *b =3D make_pool(B_START, B_END);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(acquire(g, &quot;alice&quot;), GLOBAL_START);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(a=
cquire(a, &quot;bob&quot;), A_START);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(acquire(b, &quot;carol&quot;), B_STA=
RT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool *pools[] =
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
const struct CMUnitTest pool_tests[] =3D {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    cmocka_unit_test(test_persist_roundtrip),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_=
persist_ignore_unknown),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+main(void)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    char template[] =3D &quot;/tmp/ovpn_pool_persist_ut=2EXXXXXX&quot;;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int fd =3D mkstemp=
(template);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(fd &gt;=3D =
0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    close(fd);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    persist_file =3D =
template;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_test_setup()=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D cm=
ocka_run_group_tests(pool_tests, NULL, NULL);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    unlink(template);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail">change 1790</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0bff8d0a549a=
65b7da01ea0e785b7ec8bea17f05 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1790 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>

</body></html>
--9RwUR6i9tTk=--


--===============8811418454849734567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8811418454849734567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8811418454849734567==--

