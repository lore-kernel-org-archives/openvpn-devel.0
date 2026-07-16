Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86564C4450A
	for <openvpn-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fQuFOYQDxG3CDX0/EB8jsbZGsrcm3qhFbsbRric2A/U=; b=b6pcvWoE4JejhFjhznfcRK7TDn
	g1kJyUfdUacNfzVnum1gxhjSF+wcsSbTT6sb/jlGD/W9Azw5SnubM1FiMH9OMZEeB8+bbSIMW5Th7
	umlyGnSNgoOTGWao2ln0kPNNrrXfHVQlEM3Wg5eQZubT/Y/VUCUQpOFjyYX5VTRqut04=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkJuq-0008Pm-DA;
	Thu, 16 Jul 2026 11:06:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkJuo-0008Pf-Ox
 for openvpn-devel@lists.sourceforge.net;
 Thu, 16 Jul 2026 11:06:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=iTq9RGmiFhTtfV5prZ2YE5ry5ccg/vVwzfoQe4YglRY=; b=KcRwMtdYj51DIhcWLyURLKTW0U
 Y8b+Lx03xp6i12JOKqvSb3c7ctQVDp0X/ci8/lxlRW10pY2Ov1h9iBzeTrmipBlRHFom6fGjQ5EYo
 7nlkD9pVDJ3RfQ+QxgQnZYeDKht/4hNabjIQIxrhZhH8hzPWGWh4fbXIW2YSTmSTNaBQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iTq9RGmiFhTtfV5prZ2YE5ry5ccg/vVwzfoQe4YglRY=; b=Q
 EF5DGKug2+Eg2/JfaTV+JlDkQFLuMGIrb6JMjytHbjsNfDRvZ5ck1zjpylY1ipCz56+hnPeYDzIcX
 XOxpQ9Fn1Un3IglHf30sRuQ6LO4QpEMSA15QEbHHt3d1Br0JvNlZJwWLay3UAGSmFxv6rpLzeMrud
 SH0fLR2+2bo+rLsE=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkJui-000185-0J for openvpn-devel@lists.sourceforge.net;
 Thu, 16 Jul 2026 11:06:03 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493f4638f4aso26889005e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 16 Jul 2026 04:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784199953; x=1784804753; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iTq9RGmiFhTtfV5prZ2YE5ry5ccg/vVwzfoQe4YglRY=;
 b=SfuXkI/XO5gWsFI2F4F8jUXgJNVg0MRZ8oQ9M/m+Z2ZUZ8p+5L+ueluioZuR5LK0FE
 p36GqivYa1CFc1+I9sqA+DxYV7MiNy8493UWeHEzbfvQL5bsS40TkZEkUC9Bvs2yaiDf
 KmIcRQO5RllQHEf3uSpTSB3VKazLB+fbt4HuAMU+/kz0Mjluy+mOdwiDSMV5bZA7gXk4
 wrKd3k+wDshVd99BzSx1Rl0eceC6G1mJVr03BI6lymKmXIIbnuJL3wcllwoYmsizBY6c
 bqhFAg6yOXLTwzC9j6/ouYFIF6ILEto0KqnFJnR9wIHDvOcL2Eh34U5WREmkrzBbsa4w
 5qig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784199953; x=1784804753;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iTq9RGmiFhTtfV5prZ2YE5ry5ccg/vVwzfoQe4YglRY=;
 b=cQ7EcR0t+fHo+GnXz0cDXK+WDEFkFN/44u65z94/7OhxxE478mE2cwLHeDkQCgudij
 ZuPCp10mJZUEkKekGwQ2SmdRYGwUTueejuOLI/auxjuFzii9BV1+UMxaM8s92IYE66ON
 /KhiO6U5O1PDLkIX8t/lVFCzk54SWKMAYa1cd/8bbaAw310tO81Gx8Dp1zpPSF4WbPDK
 S/FcPUirW+eKD0pbzOdc3Bqsml1T3av8EGFyrqoSLP7IC0BiRSy+mL4QkoFjW4qOShiT
 hNLL1XWUDv24ROyHq6luDFZxTkoaqGtxFPpiGP8MK/6uJuOiV9bMq0E7kH8OIGhL1oLl
 ImtA==
X-Gm-Message-State: AOJu0YxQ2aZfSvkUkJJCJDT2k5ii6EXQrc7lz7Pzc7kj+wmHpAxtQADv
 k+HCVFpE38FGVqbSm66bdwM/dtfsWLkNzQIFJlC8lTWtvUf13ElLMm8ohtJkRQEGy0dcUXfAS6N
 1hK+C2Nsd2u/oyDPmErmndJUFrDpCAIByrz5F4YnzwPJ3/e+Emu1r93Dq/ZSBaAfyUgSu
X-Gm-Gg: AfdE7cmuYdF3L15vdQVq1Si4Wq7SmXUbAB26xQFj3+KQ62OEtQ4Qu15464R9Do4VLqp
 37KalLnlmOCRiewYgP60uB8kKLlvbpBTWXX1toG4ly30tqrsITrqnOdsMlCRrGwAhxXccJDZgd2
 yhfWRhjOBYH4N2ASAVZPBDnGEmxBIy7ZCFPIoGO0AkiuPNHgETbnfFB7Jo7JPpOmzwYTH+p6cK/
 JRVfF1M+O7iGHugMT9BA2AQi06Ey1bEdHUQ+P0FQ/R4+nM99X/vKkqqeM+zGT5QiV81oZyTK3mM
 yBHiYedIE0WIeqoFoyBRjr47/X5kl/vz/gXayK2aPVD7z11FXjhQucOKRE+M6QXjJmYCDBfI0Sw
 DjhTLfD3XRHzCHiAbKsd7ZDj0vLUIIAPZkSzz9NsRCDveLpksexmBF4hjexivbsRKxXWtI55Lzc
 hykuAwnW/1lsI5j0REROZTJnYhKb0h/+KUPbO0RnM6HFkkMy5I5LzpJWrzTtNmX4ZKxHIUYo1c3
 xqREB5jFwF1d9/FER412sG/V2CmWb7YpBdEW8nL2prq/5ixj6/4ug2wWXsYLh2cVNvJ
X-Received: by 2002:a05:600c:3baa:b0:495:43ab:4f6b with SMTP id
 5b1f17b1804b1-49543ab504dmr18670745e9.8.1784199952872; 
 Thu, 16 Jul 2026 04:05:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49541e8c2a3sm57363405e9.7.2026.07.16.04.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 04:05:52 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 16 Jul 2026 11:05:48 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05
X-Gerrit-Change-Number: 1790
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1790?usp=email>
X-Gerrit-Commit: 17d00ffc7d8c5851bc10f3b1c03e5c3c2badabef
In-Reply-To: <gerrit.1784150390000.I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05@gerrit.openvpn.net>
References: <gerrit.1784150390000.I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MTUwMzkwMDAwLkkwYmZmOGQwYTU0OWE2NWI3ZGEwMWVhMGU3ODViN2VjOGJlYTE3ZjA1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <97bb1a552448bbde208b02484ee81def10e02a2b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkJui-000185-0J
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5337675181607579444=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5337675181607579444==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PIqemK6mI9M="; charset=UTF-8

--PIqemK6mI9M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

Hello flichtenhe=
ld, plaisthos, 

I'd like you to reexamine a change=2E Please visit

    ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail

to look at the ne=
w patch set (#2)=2E


Change subject: pool, multi: persist subnet pools via=
 --ifconfig-pool-persist
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

pool, multi: persist subnet pools via --ifconfig-pool-persist=


Extend --ifconfig-pool-persist so its single file covers the global pool
=
and every --subnet-pool=2E ifconfig_pool_read()/ifconfig_pool_write() now
o=
perate on the set of pools: each persisted entry is routed to the pool
whos=
e address range owns it, and an entry matching no configured pool is
ignore=
d on load (e=2Eg=2E a --subnet-pool that was removed)=2E When persist is
en=
abled the subnet pools are created eagerly at startup so their saved
alloca=
tions can be reloaded before the first client connects=2E

Change-Id: I0bff=
8d0a549a65b7da01ea0e785b7ec8bea17f05
GitHub: closes openvpn/OpenVPN#987
Sig=
ned-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
---
M CMakeLists=2E=
txt
M doc/man-sections/server-options=2Erst
M src/openvpn/multi=2Ec
M src/o=
penvpn/options=2Ec
M src/openvpn/pool=2Ec
M src/openvpn/pool=2Eh
M tests/un=
it_tests/openvpn/Makefile=2Eam
A tests/unit_tests/openvpn/test_pool=2Ec
8 f=
iles changed, 393 insertions(+), 39 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/90/1790/2

diff --git a/CMakeLi=
sts=2Etxt b/CMakeLists=2Etxt
index 3463b5a=2E=2E0259234 100644
--- a/CMakeL=
ists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -668,6 +668,7 @@
         "test_option=
s_parse"
         "test_packet_id"
         "test_pkt"
+        "test_pool"=

         "test_provider"
         "test_socket"
         "test_ssl"
@@ -83=
5,6 +836,15 @@
         src/openvpn/options_util=2Ec
         )
 
+    targ=
et_sources(test_pool PRIVATE
+        tests/unit_tests/openvpn/mock_get_ran=
dom=2Ec
+        src/openvpn/pool=2Ec
+        src/openvpn/status=2Ec
+    =
    src/openvpn/otime=2Ec
+        src/openvpn/fdmisc=2Ec
+        src/open=
vpn/interval=2Ec
+        )
+
     target_sources(test_ncp PRIVATE
        =
 src/openvpn/crypto_epoch=2Ec
         src/openvpn/crypto_mbedtls=2Ec
diff =
--git a/doc/man-sections/server-options=2Erst b/doc/man-sections/server-opt=
ions=2Erst
index 0146594=2E=2E910a414 100644
--- a/doc/man-sections/server-=
options=2Erst
+++ b/doc/man-sections/server-options=2Erst
@@ -275,6 +275,11=
 @@
   ``file`` is a comma-delimited ASCII file, formatted as
   :code:`<Co=
mmon-Name>,<IP-address>`=2E
 
+  A single ``file`` covers the global pool a=
nd every ``--subnet-pool``: each
+  entry is associated with a pool by its =
address, and on load an entry whose
+  address falls in no configured pool =
(for example a ``--subnet-pool`` that is
+  no longer defined) is ignored=
=2E
+
   If ``seconds`` =3D :code:`0`, ``file`` will be treated as read-onl=
y=2E This
   is useful if you would like to treat ``file`` as a configurati=
on file=2E
 
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
ind=
ex 1cd84b6=2E=2Ea281764 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvp=
n/multi=2Ec
@@ -65,6 +65,41 @@
     struct ifconfig_pool *pool;
 };
 
+stat=
ic struct ifconfig_pool *multi_get_group_pool(struct multi_context *m,
+   =
                                               const struct options *o, con=
st char *tag);
+
+/*
+ * Collect every address pool (the global one plus ea=
ch --subnet-pool group)
+ * into a gc-allocated array, for the single combi=
ned --ifconfig-pool-persist
+ * file=2E  Returns the number of pools=2E
+ *=
/
+static int
+multi_all_pools(struct multi_context *m, struct gc_arena *gc=
, struct ifconfig_pool ***pools)
+{
+    struct subnet_pool *sp;
+    int n=
 =3D m->ifconfig_pool ? 1 : 0;
+
+    for (sp =3D m->subnet_pools; sp; sp =
=3D sp->next)
+    {
+        n++;
+    }
+
+    struct ifconfig_pool **arr=
 =3D gc_malloc(n * sizeof(struct ifconfig_pool *), true, gc);
+    int i =
=3D 0;
+
+    if (m->ifconfig_pool)
+    {
+        arr[i++] =3D m->ifconfi=
g_pool;
+    }
+    for (sp =3D m->subnet_pools; sp; sp =3D sp->next)
+    =
{
+        arr[i++] =3D sp->pool;
+    }
+
+    *pools =3D arr;
+    return=
 n;
+}
+
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
 #ifdef MULTI_DEBUG_EVENT_LO=
OP
@@ -161,11 +196,16 @@
 void
 multi_ifconfig_pool_persist(struct multi_co=
ntext *m, bool force)
 {
-    /* write pool data to file */
-    if (m->ifc=
onfig_pool && m->top=2Ec1=2Eifconfig_pool_persist
+    /* write the global =
pool and every --subnet-pool to the one persist file */
+    if (m->top=2Ec=
1=2Eifconfig_pool_persist
         && (force || ifconfig_pool_write_trigger=
(m->top=2Ec1=2Eifconfig_pool_persist)))
     {
-        ifconfig_pool_write=
(m->top=2Ec1=2Eifconfig_pool_persist, m->ifconfig_pool);
+        struct gc=
_arena gc =3D gc_new();
+        struct ifconfig_pool **pools;
+        int=
 n =3D multi_all_pools(m, &gc, &pools);
+
+        ifconfig_pool_write(m->t=
op=2Ec1=2Eifconfig_pool_persist, pools, n);
+        gc_free(&gc);
     }
 =
}
 
@@ -368,12 +408,29 @@
             t->options=2Eifconfig_pool_end, t->o=
ptions=2Eduplicate_cn,
             t->options=2Eifconfig_ipv6_pool_defined=
, t->options=2Eifconfig_ipv6_pool_base,
             t->options=2Eifconfig_=
ipv6_pool_netbits);
+    }
 
-        /* reload pool data from file */
-   =
     if (t->c1=2Eifconfig_pool_persist)
+    /* With --ifconfig-pool-persis=
t the single file covers the global pool and
+     * every configured --sub=
net-pool, so eagerly create the subnet pools and
+     * reload them all in=
 one pass (entries for unknown pools are ignored)=2E */
+    if (t->c1=2Eif=
config_pool_persist)
+    {
+        struct gc_arena gc =3D gc_new();
+    =
    struct ifconfig_pool **pools;
+        int n;
+
+        for (const str=
uct subnet_pool_def *d =3D t->options=2Esubnet_pools; d; d =3D d->next)
   =
      {
-            ifconfig_pool_read(t->c1=2Eifconfig_pool_persist, m->i=
fconfig_pool);
+            multi_get_group_pool(m, &t->options, d->tag);
 =
        }
+        for (const struct subnet_pool6_def *d =3D t->options=2Es=
ubnet_pools_ipv6; d; d =3D d->next)
+        {
+            multi_get_group=
_pool(m, &t->options, d->tag);
+        }
+
+        n =3D multi_all_pools(=
m, &gc, &pools);
+        ifconfig_pool_read(t->c1=2Eifconfig_pool_persist,=
 pools, n);
+        gc_free(&gc);
     }
 
     /*
@@ -1425,7 +1482,7 @@
 =
 * on first use from the matching --subnet-pool definition=2E
  */
 static =
struct ifconfig_pool *
-multi_get_group_pool(struct multi_context *m, const=
 char *tag)
+multi_get_group_pool(struct multi_context *m, const struct opt=
ions *o, const char *tag)
 {
     struct subnet_pool *sp;
 
@@ -1437,14 +14=
94,13 @@
         }
     }
 
-    const struct subnet_pool_def *d4 =3D subn=
et_pool_by_tag(m->top=2Eoptions=2Esubnet_pools, tag);
-    const struct sub=
net_pool6_def *d6 =3D subnet_pool6_by_tag(m->top=2Eoptions=2Esubnet_pools_i=
pv6, tag);
+    const struct subnet_pool_def *d4 =3D subnet_pool_by_tag(o->=
subnet_pools, tag);
+    const struct subnet_pool6_def *d6 =3D subnet_pool6=
_by_tag(o->subnet_pools_ipv6, tag);
     ALLOC_OBJ_CLEAR(sp, struct subnet_=
pool);
     sp->tag =3D d4 ? d4->tag : d6->tag;
     sp->pool =3D ifconfig_=
pool_init(d4 !=3D NULL, IFCONFIG_POOL_INDIV, d4 ? d4->network + 2 : 0,
-   =
                               d4 ? (d4->network | ~d4->netmask) - 1 : 0,
-=
                                  m->top=2Eoptions=2Eduplicate_cn, d6 !=3D =
NULL,
-                                  d6 ? add_in6_addr(d6->network, 2) =
: in6addr_any,
+                                  d4 ? (d4->network | ~d4->=
netmask) - 1 : 0, o->duplicate_cn,
+                                  d6 !=
=3D NULL, d6 ? add_in6_addr(d6->network, 2) : in6addr_any,
                =
                   d6 ? (int)d6->netbits : 0);
     sp->next =3D m->subnet_=
pools;
     m->subnet_pools =3D sp;
@@ -1549,7 +1605,8 @@
                 =
cn =3D tls_common_name(mi->context=2Ec2=2Etls_multi, true);
             }
=
 
-            mi->vaddr_pool =3D multi_get_group_pool(m, mi->context=2Eopt=
ions=2Esubnet_pool_tag);
+            mi->vaddr_pool =3D
+                m=
ulti_get_group_pool(m, &m->top=2Eoptions, mi->context=2Eoptions=2Esubnet_po=
ol_tag);
             mi->vaddr_handle =3D
                 ifconfig_pool_a=
cquire(mi->vaddr_pool, &local, &remote, &remote_ipv6, cn);
             if =
(mi->vaddr_handle < 0)
diff --git a/src/openvpn/options=2Ec b/src/openvpn/o=
ptions=2Ec
index b4485ca=2E=2E40a195d 100644
--- a/src/openvpn/options=2Ec
=
+++ b/src/openvpn/options=2Ec
@@ -441,6 +441,7 @@
     "--ifconfig-pool-per=
sist file [seconds] : Persist/unpersist ifconfig-pool\n"
     "            =
      data to file, at seconds intervals (default=3D600)=2E\n"
     "      =
            If seconds=3D0, file will be treated as read-only=2E\n"
+    " =
                 Covers the global pool and every --subnet-pool=2E\n"
     =
"--ifconfig-ipv6-pool base-IP/bits : set aside an IPv6 network block\n"
   =
  "                  to be dynamically allocated to connecting clients=2E\n=
"
     "--subnet-pool tag network netmask [gateway] : Define a named pool o=
f\n"
@@ -2566,10 +2567,11 @@
         MUST_BE_UNDEF(route_delay_defined, "r=
oute-delay");
         MUST_BE_UNDEF(up_delay, "up-delay");
         if (!o=
ptions->ifconfig_pool_defined && !options->ifconfig_ipv6_pool_defined
+    =
        && !options->subnet_pools && !options->subnet_pools_ipv6
          =
   && options->ifconfig_pool_persist_filename)
         {
-            msg(=
M_USAGE,
-                "--ifconfig-pool-persist must be used with --ifco=
nfig-pool or --ifconfig-ipv6-pool");
+            msg(M_USAGE, "--ifconfig-=
pool-persist must be used with --ifconfig-pool, "
+                        =
 "--ifconfig-ipv6-pool or --subnet-pool");
         }
         if (options-=
>ifconfig_ipv6_pool_defined && !options->ifconfig_ipv6_local)
         {
di=
ff --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec
index ff74e7c=2E=2Eb=
260cc8 100644
--- a/src/openvpn/pool=2Ec
+++ b/src/openvpn/pool=2Ec
@@ -583=
,13 +583,14 @@
 }
 
 void
-ifconfig_pool_read(struct ifconfig_pool_persist =
*persist, struct ifconfig_pool *pool)
+ifconfig_pool_read(struct ifconfig_p=
ool_persist *persist, struct ifconfig_pool **pools,
+                   int=
 n_pools)
 {
     const int buf_size =3D 128;
 
     update_time();
 
-    =
if (persist && persist->file && pool)
+    if (persist && persist->file && =
n_pools > 0)
     {
         struct gc_arena gc =3D gc_new();
         stru=
ct buffer in =3D alloc_buf_gc(256, &gc);
@@ -634,6 +635,9 @@
              =
   continue;
             }
 
+            /* the address selects which poo=
l this entry belongs to; an entry
+             * matching none of the conf=
igured pools is ignored */
+            struct ifconfig_pool *pool =3D NULL=
;
             ifconfig_pool_handle h =3D -1, h6 =3D -1;
 
             if =
(strlen(ip_buf) > 0)
@@ -647,10 +651,13 @@
                 }
             =
    else
                 {
-                    h =3D ifconfig_pool_ip_bas=
e_to_handle(pool, addr);
-                    if (h < 0)
+                 =
   for (int i =3D 0; i < n_pools && !pool; ++i)
                     {
-   =
                     msg(M_WARN, "pool: IPv4 (%s) out of pool range for CN=
=3D%s", ip_buf, cn_buf);
+                        h =3D ifconfig_pool_ip_ba=
se_to_handle(pools[i], addr);
+                        if (h >=3D 0)
+     =
                   {
+                            pool =3D pools[i];
+     =
                   }
                     }
                 }
            =
 }
@@ -663,12 +670,20 @@
                 {
                     msg(M_WARN=
, "pool: invalid IPv6 (%s) for CN=3D%s", ip6_buf, cn_buf);
                =
 }
+                else if (pool)
+                {
+                    =
/* IPv4 already picked the pool; v4 and v6 share the handle */
+           =
         h6 =3D ifconfig_pool_ipv6_base_to_handle(pool, &addr6);
+         =
       }
                 else
                 {
-                    h6 =
=3D ifconfig_pool_ipv6_base_to_handle(pool, &addr6);
-                    i=
f (h6 < 0)
+                    for (int i =3D 0; i < n_pools && !pool; ++i=
)
                     {
-                        msg(M_WARN, "pool: IPv6 (=
%s) out of pool range for CN=3D%s", ip6_buf, cn_buf);
+                    =
    h6 =3D ifconfig_pool_ipv6_base_to_handle(pools[i], &addr6);
+          =
              if (h6 >=3D 0)
+                        {
+                  =
          pool =3D pools[i];
+                        }
                   =
  }
 
                     /* Rely on IPv6 if no IPv4 was provided or the o=
ne provided
@@ -681,40 +696,44 @@
                 }
             }
 
-    =
        /* at the moment IPv4 and IPv6 share the same pool, therefore offse=
ts
-             * have to match for the same client=2E
-             *
-  =
           * If offsets differ we use the IPv4, therefore warn the user abo=
ut this=2E
-             */
+            /* IPv4 and IPv6 share the same po=
ol handle, so their offsets have
+             * to match; if they differ w=
e use the IPv4 and warn */
             if ((h6 >=3D 0) && (h !=3D h6))
   =
          {
                 msg(M_WARN, "pool: IPv4 (%s) and IPv6 (%s) hav=
e different offsets! Relying on IPv4",
                     ip_buf, ip6_buf=
);
             }
 
-            /* if at least one among v4 and v6 was pro=
perly parsed, attempt
-             * setting an handle for this client
-  =
           */
-            if (h >=3D 0)
+            /* set the handle if =
the entry belongs to one of the pools */
+            if (pool && h >=3D 0)=

             {
-                msg(M_INFO, "succeeded -> ifconfig_pool_se=
t(hand=3D%d)", h);
                 ifconfig_pool_set(pool, cn_buf, h, pers=
ist->fixed);
             }
         }
 
-        ifconfig_pool_msg(pool, D=
_IFCONFIG_POOL);
+        for (int i =3D 0; i < n_pools; ++i)
+        {
+ =
           ifconfig_pool_msg(pools[i], D_IFCONFIG_POOL);
+        }
 
     =
    gc_free(&gc);
     }
 }
 
 void
-ifconfig_pool_write(struct ifconfig_po=
ol_persist *persist, const struct ifconfig_pool *pool)
+ifconfig_pool_write=
(struct ifconfig_pool_persist *persist, struct ifconfig_pool *const *pools,=

+                    int n_pools)
 {
-    if (persist && persist->file && =
(status_rw_flags(persist->file) & STATUS_OUTPUT_WRITE) && pool)
+    if (pe=
rsist && persist->file && (status_rw_flags(persist->file) & STATUS_OUTPUT_W=
RITE))
     {
         status_reset(persist->file);
-        ifconfig_pool_=
list(pool, persist->file);
+        for (int i =3D 0; i < n_pools; ++i)
+  =
      {
+            if (pools[i])
+            {
+                ifconfig=
_pool_list(pools[i], persist->file);
+            }
+        }
         sta=
tus_flush(persist->file);
     }
 }
diff --git a/src/openvpn/pool=2Eh b/src=
/openvpn/pool=2Eh
index e2d3f82=2E=2E79f3ac5 100644
--- a/src/openvpn/pool=
=2Eh
+++ b/src/openvpn/pool=2Eh
@@ -92,9 +92,15 @@
 
 bool ifconfig_pool_wr=
ite_trigger(struct ifconfig_pool_persist *persist);
 
-void ifconfig_pool_r=
ead(struct ifconfig_pool_persist *persist, struct ifconfig_pool *pool);
+/*=
 Read a persist file into a set of pools, routing each entry to the pool
+ =
* whose address range owns it=2E  Entries matching no pool (e=2Eg=2E a --su=
bnet-pool
+ * that is no longer configured) are ignored=2E */
+void ifconfi=
g_pool_read(struct ifconfig_pool_persist *persist, struct ifconfig_pool **p=
ools,
+                        int n_pools);
 
-void ifconfig_pool_write(st=
ruct ifconfig_pool_persist *persist, const struct ifconfig_pool *pool);
+/*=
 Write a set of pools to a single persist file=2E */
+void ifconfig_pool_wr=
ite(struct ifconfig_pool_persist *persist,
+                         struct=
 ifconfig_pool *const *pools, int n_pools);
 
 #ifdef IFCONFIG_POOL_TEST
 v=
oid ifconfig_pool_test(in_addr_t start, in_addr_t end);
diff --git a/tests/=
unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
i=
ndex bfb7284=2E=2Ed1d9574 100644
--- a/tests/unit_tests/openvpn/Makefile=2E=
am
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -17,6 +17,7 @@
 	options=
_parse_testdriver \
 	packet_id_testdriver \
 	pkt_testdriver \
+	pool_test=
driver \
 	provider_testdriver \
 	push_update_msg_testdriver \
 	socket_te=
stdriver \
@@ -362,6 +363,23 @@
 	$(top_srcdir)/src/openvpn/platform=2Ec \
=
 	$(top_srcdir)/src/openvpn/mbuf=2Ec
 
+pool_testdriver_CFLAGS  =3D \
+	-I$=
(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn=
 \
+	@TEST_CFLAGS@
+
+pool_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
+
+pool_te=
stdriver_SOURCES =3D test_pool=2Ec \
+	mock_msg=2Ec test_common=2Eh \
+	moc=
k_get_random=2Ec \
+	$(top_srcdir)/src/openvpn/pool=2Ec \
+	$(top_srcdir)/s=
rc/openvpn/status=2Ec \
+	$(top_srcdir)/src/openvpn/buffer=2Ec \
+	$(top_sr=
cdir)/src/openvpn/otime=2Ec \
+	$(top_srcdir)/src/openvpn/platform=2Ec \
+	=
$(top_srcdir)/src/openvpn/fdmisc=2Ec \
+	$(top_srcdir)/src/openvpn/interval=
=2Ec
+
 subnet_pool_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I$(=
top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	@TEST_CFLAGS@
diff -=
-git a/tests/unit_tests/openvpn/test_pool=2Ec b/tests/unit_tests/openvpn/te=
st_pool=2Ec
new file mode 100644
index 0000000=2E=2Ed07395d
--- /dev/null
+=
++ b/tests/unit_tests/openvpn/test_pool=2Ec
@@ -0,0 +1,237 @@
+/*
+ *  Open=
VPN -- An application to securely tunnel IP networks
+ *             over a=
 single UDP port, with support for SSL/TLS-based
+ *             session au=
thentication and key exchange,
+ *             packet encryption, packet au=
thentication, and
+ *             packet compression=2E
+ *
+ *  Copyright =
(C) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free so=
ftware; you can redistribute it and/or modify
+ *  it under the terms of th=
e GNU General Public License version 2
+ *  as published by the Free Softwa=
re Foundation=2E
+ *
+ *  This program is distributed in the hope that it w=
ill be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warr=
anty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See th=
e
+ *  GNU General Public License for more details=2E
+ *
+ *  You should h=
ave received a copy of the GNU General Public License along
+ *  with this =
program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef =
HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#=
include <stdlib=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#incl=
ude "pool=2Eh"
+#include "buffer=2Eh"
+#include "platform=2Eh"
+#include "t=
est_common=2Eh"
+#include "mock_msg=2Eh"
+
+/*
+ * pool=2Ec pulls in a few =
socket=2Ec/socket_util=2Ec helpers for address parsing and
+ * formatting=
=2E  The pool logic under test does not need the full socket stack,
+ * so =
provide small IPv4 implementations here (the IPv6 ones are not reached by
+=
 * these IPv4-only pools, but must exist to link)=2E
+ */
+struct signal_in=
fo;
+
+in_addr_t
+getaddr(unsigned int flags, const char *hostname, int res=
olve_retry_seconds, bool *succeeded,
+        struct signal_info *sig_info)=

+{
+    struct in_addr a;
+    int ok =3D inet_pton(AF_INET, hostname, &a)=
 =3D=3D 1;
+
+    if (succeeded)
+    {
+        *succeeded =3D ok;
+    }
=
+    return ok ? ntohl(a=2Es_addr) : 0;
+}
+
+const char *
+print_in_addr_t=
(in_addr_t addr, unsigned int flags, struct gc_arena *gc)
+{
+    struct in=
_addr a =3D { =2Es_addr =3D htonl(addr) };
+    char buf[INET_ADDRSTRLEN] =
=3D { 0 };
+
+    inet_ntop(AF_INET, &a, buf, sizeof(buf));
+    return str=
ing_alloc(buf, gc);
+}
+
+bool
+get_ipv6_addr(const char *hostname, struct =
in6_addr *network, unsigned int *netbits,
+              msglvl_t msglevel)=

+{
+    return false;
+}
+
+const char *
+print_in6_addr(struct in6_addr a=
6, unsigned int flags, struct gc_arena *gc)
+{
+    return "";
+}
+
+struct=
 in6_addr
+add_in6_addr(struct in6_addr base, uint32_t add)
+{
+    return =
base;
+}
+
+#define IP(a, b, c, d) (((in_addr_t)(a) << 24) | ((b) << 16) | =
((c) << 8) | (d))
+
+/* three non-overlapping /24 pools: the global one and=
 two --subnet-pool groups */
+#define GLOBAL_START IP(10, 1, 1, 2)
+#define=
 GLOBAL_END   IP(10, 1, 1, 254)
+#define A_START      IP(10, 2, 1, 2)
+#def=
ine A_END        IP(10, 2, 1, 254)
+#define B_START      IP(10, 2, 2, 2)
+#=
define B_END        IP(10, 2, 2, 254)
+
+static struct ifconfig_pool *
+mak=
e_pool(in_addr_t start, in_addr_t end)
+{
+    struct in6_addr any =3D { 0 =
};
+
+    return ifconfig_pool_init(true, IFCONFIG_POOL_INDIV, start, end, =
false, false, any, 0);
+}
+
+static in_addr_t
+acquire(struct ifconfig_pool=
 *pool, const char *cn)
+{
+    in_addr_t local =3D 0, remote =3D 0;
+
+   =
 ifconfig_pool_acquire(pool, &local, &remote, NULL, cn);
+    return remote=
;
+}
+
+/* whether any entry of the pool is reserved for common name cn */
=
+static bool
+pool_has_cn(const struct ifconfig_pool *pool, const char *cn)=

+{
+    for (int i =3D 0; i < pool->size; ++i)
+    {
+        if (pool->l=
ist[i]=2Ecommon_name && !strcmp(pool->list[i]=2Ecommon_name, cn))
+        =
{
+            return true;
+        }
+    }
+    return false;
+}
+
+stat=
ic const char *persist_file;
+
+/* Write {global, A, B} to one persist file=
, reload into a fresh set, and check
+ * that every entry was routed back t=
o the pool that owns its address=2E */
+static void
+test_persist_roundtrip=
(void **state)
+{
+    struct ifconfig_pool *g =3D make_pool(GLOBAL_START, =
GLOBAL_END);
+    struct ifconfig_pool *a =3D make_pool(A_START, A_END);
+ =
   struct ifconfig_pool *b =3D make_pool(B_START, B_END);
+
+    assert_int=
_equal(acquire(g, "alice"), GLOBAL_START);
+    assert_int_equal(acquire(a,=
 "bob"), A_START);
+    assert_int_equal(acquire(b, "carol"), B_START);
+
+=
    struct ifconfig_pool *pools[] =3D { g, a, b };
+    struct ifconfig_poo=
l_persist *wp =3D ifconfig_pool_persist_init(persist_file, 5);
+    ifconfi=
g_pool_write(wp, pools, 3);
+    ifconfig_pool_persist_close(wp);
+
+    st=
ruct ifconfig_pool *g2 =3D make_pool(GLOBAL_START, GLOBAL_END);
+    struct=
 ifconfig_pool *a2 =3D make_pool(A_START, A_END);
+    struct ifconfig_pool=
 *b2 =3D make_pool(B_START, B_END);
+    struct ifconfig_pool *pools2[] =3D=
 { g2, a2, b2 };
+    struct ifconfig_pool_persist *rp =3D ifconfig_pool_pe=
rsist_init(persist_file, 0);
+    ifconfig_pool_read(rp, pools2, 3);
+    i=
fconfig_pool_persist_close(rp);
+
+    /* each client was routed to its own=
 pool (handle 0 =3D=3D the pool's base) */
+    assert_string_equal(g2->lis=
t[0]=2Ecommon_name, "alice");
+    assert_string_equal(a2->list[0]=2Ecommon=
_name, "bob");
+    assert_string_equal(b2->list[0]=2Ecommon_name, "carol")=
;
+
+    /* and nowhere else */
+    assert_false(pool_has_cn(g2, "bob"));
=
+    assert_false(pool_has_cn(g2, "carol"));
+    assert_false(pool_has_cn(=
a2, "alice"));
+
+    /* the reservation is honoured: the same CN gets its =
persisted address back */
+    assert_int_equal(acquire(a2, "bob"), A_START=
);
+
+    ifconfig_pool_free(g);
+    ifconfig_pool_free(a);
+    ifconfig_=
pool_free(b);
+    ifconfig_pool_free(g2);
+    ifconfig_pool_free(a2);
+  =
  ifconfig_pool_free(b2);
+}
+
+/* An entry whose address matches no config=
ured pool (here: B's, when B is not
+ * in the set) is ignored on load and =
does not disturb the other pools=2E */
+static void
+test_persist_ignore_un=
known(void **state)
+{
+    struct ifconfig_pool *g =3D make_pool(GLOBAL_ST=
ART, GLOBAL_END);
+    struct ifconfig_pool *a =3D make_pool(A_START, A_END=
);
+    struct ifconfig_pool *b =3D make_pool(B_START, B_END);
+
+    acqui=
re(g, "alice");
+    acquire(a, "bob");
+    acquire(b, "carol");
+
+    st=
ruct ifconfig_pool *pools[] =3D { g, a, b };
+    struct ifconfig_pool_pers=
ist *wp =3D ifconfig_pool_persist_init(persist_file, 5);
+    ifconfig_pool=
_write(wp, pools, 3);
+    ifconfig_pool_persist_close(wp);
+
+    /* reloa=
d into a set WITHOUT pool B: carol's entry now matches no pool */
+    stru=
ct ifconfig_pool *g2 =3D make_pool(GLOBAL_START, GLOBAL_END);
+    struct i=
fconfig_pool *a2 =3D make_pool(A_START, A_END);
+    struct ifconfig_pool *=
pools2[] =3D { g2, a2 };
+    struct ifconfig_pool_persist *rp =3D ifconfig=
_pool_persist_init(persist_file, 0);
+    ifconfig_pool_read(rp, pools2, 2)=
;
+    ifconfig_pool_persist_close(rp);
+
+    assert_string_equal(g2->list=
[0]=2Ecommon_name, "alice");
+    assert_string_equal(a2->list[0]=2Ecommon_=
name, "bob");
+    assert_false(pool_has_cn(g2, "carol"));
+    assert_fals=
e(pool_has_cn(a2, "carol"));
+
+    ifconfig_pool_free(g);
+    ifconfig_po=
ol_free(a);
+    ifconfig_pool_free(b);
+    ifconfig_pool_free(g2);
+    i=
fconfig_pool_free(a2);
+}
+
+const struct CMUnitTest pool_tests[] =3D {
+  =
  cmocka_unit_test(test_persist_roundtrip),
+    cmocka_unit_test(test_pers=
ist_ignore_unknown),
+};
+
+int
+main(void)
+{
+    struct gc_arena gc =3D =
gc_new();
+
+    persist_file =3D platform_create_temp_file(NULL, "pool_per=
sist_ut", &gc);
+    assert_non_null(persist_file);
+
+    openvpn_unit_tes=
t_setup();
+    int ret =3D cmocka_run_group_tests(pool_tests, NULL, NULL);=

+
+    platform_unlink(persist_file);
+    gc_free(&gc);
+    return ret;
=
+}

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0bff8d0a549=
a65b7da01ea0e785b7ec8bea17f05
Gerrit-Change-Number: 1790
Gerrit-PatchSet: 2=

Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention:=
 ordex <antonio@mandelbit=2Ecom>

--PIqemK6mI9M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>ordex <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
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
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/90/1790/2</pre><pre style=3D=
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
=2Ed07395d</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_t=
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
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;platfor=
m=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;test_common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;mock_msg=2Eh&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * pool=2Ec p=
ulls in a few socket=2Ec/socket_util=2Ec helpers for address parsing and</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * formatting=2E  The =
pool logic under test does not need the full socket stack,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * so provide small IPv4 implementat=
ions here (the IPv6 ones are not reached by</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * these IPv4-only pools, but must exist to link)=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+struct signal_info;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+in_addr_t</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+getaddr(unsigned int flags, const char *hostname, int resolve=
_retry_seconds, bool *succeeded,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        struct signal_info *sig_info)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct in_addr a;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int ok =3D inet_pton(AF_INET, hostname, &amp;a) =3D=3D 1=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (succeeded)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        *succeeded =3D ok;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return ok ? ntohl(a=2Es_addr) : 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+co=
nst char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+print_in_=
addr_t(in_addr_t addr, unsigned int flags, struct gc_arena *gc)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct in_addr a =3D { =2Es_addr =3D htonl(ad=
dr) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char buf[=
INET_ADDRSTRLEN] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    inet_nt=
op(AF_INET, &amp;a, buf, sizeof(buf));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return string_alloc(buf, gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_ipv6_addr(cons=
t char *hostname, struct in6_addr *network, unsigned int *netbits,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+              msglvl_t msgle=
vel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+const char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+prin=
t_in6_addr(struct in6_addr a6, unsigned int flags, struct gc_arena *gc)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return &quot;&quot;;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+struct in6_addr</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ad=
d_in6_addr(struct in6_addr base, uint32_t add)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return base;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define IP(a, b, c, d) (((in_ad=
dr_t)(a) &lt;&lt; 24) | ((b) &lt;&lt; 16) | ((c) &lt;&lt; 8) | (d))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* three non-overlapping /24 pools: the global=
 one and two --subnet-pool groups */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define GLOBAL_START IP(10, 1, 1, 2)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define GLOBAL_END   IP(10, 1, 1, 254)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define A_START      I=
P(10, 2, 1, 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne A_END        IP(10, 2, 1, 254)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define B_START      IP(10, 2, 2, 2)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define B_END        IP(10, 2, 2, 254)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static struct ifconfig_pool *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+make_pool(in_addr_t start, in_addr=
_t end)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr any =3D { =
0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return ifconfig_pool_init(true=
, IFCONFIG_POOL_INDIV, start, end, false, false, any, 0);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static in_addr_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ac=
quire(struct ifconfig_pool *pool, const char *cn)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    in_addr_t local =3D 0, remote =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ifconfig_pool_acquire(pool, &amp;local, &amp;remote, NUL=
L, cn);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return r=
emote;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* whether any entry of the pool is reserved for c=
ommon name cn */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pool_has_cn=
(const struct ifconfig_pool *pool, const char *cn)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    for (int i =3D 0; i &lt; pool-&gt;size; ++i)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (pool-&gt;list[i]=2Ecommon_name &amp=
;&amp; !strcmp(pool-&gt;list[i]=2Ecommon_name, cn))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return true;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static const char *persist_file;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* Write {global, A, B} to one persist f=
ile, reload into a fresh set, and check</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * that every entry was routed back to the pool that ow=
ns its address=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_pe=
rsist_roundtrip(void **state)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct ifconfig_pool *g =3D make_pool(GLOBAL_START, GLOBAL_END);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool *a =3D ma=
ke_pool(A_START, A_END);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct ifconfig_pool *b =3D make_pool(B_START, B_END);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(acquire(g, &quot;alice&quot;)=
, GLOBAL_START);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(acquire(a, &quot;bob&quot;), A_START);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(acquire(b, &quot;=
carol&quot;), B_START);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifco=
nfig_pool *pools[] =3D { g, a, b };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct ifconfig_pool_persist *wp =3D ifconfig_pool_pers=
ist_init(persist_file, 5);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ifconfig_pool_write(wp, pools, 3);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ifconfig_pool_persist_close(wp);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct ifconfig_pool *g2 =3D make_pool(GLOBAL_S=
TART, GLOBAL_END);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct ifconfig_pool *a2 =3D make_pool(A_START, A_END);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool *b2 =3D mak=
e_pool(B_START, B_END);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct ifconfig_pool *pools2[] =3D { g2, a2, b2 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool_persist *rp=
 =3D ifconfig_pool_persist_init(persist_file, 0);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ifconfig_pool_read(rp, pools2, 3);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_persist_=
close(rp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* each client was route=
d to its own pool (handle 0 =3D=3D the pool&#39;s base) */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(g2-&gt;list[=
0]=2Ecommon_name, &quot;alice&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_string_equal(a2-&gt;list[0]=2Ecommon_name, &qu=
ot;bob&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_string_equal(b2-&gt;list[0]=2Ecommon_name, &quot;carol&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* and nowhere else */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_false(pool_has_cn(g2, &quot=
;bob&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_false(pool_has_cn(g2, &quot;carol&quot;));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_false(pool_has_cn(a2, &quot;alice&qu=
ot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* the reservation is honour=
ed: the same CN gets its persisted address back */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(acquire(a2, &quot;bob&q=
uot;), A_START);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_free=
(g);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_po=
ol_free(a);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifco=
nfig_pool_free(b);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ifconfig_pool_free(g2);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ifconfig_pool_free(a2);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ifconfig_pool_free(b2);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* An entry wh=
ose address matches no configured pool (here: B&#39;s, when B is not</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * in the set) is ignored =
on load and does not disturb the other pools=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+test_persist_ignore_unknown(void **state)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct ifconfig_pool *g =3D make_pool(GLOBAL=
_START, GLOBAL_END);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct ifconfig_pool *a =3D make_pool(A_START, A_END);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool *b =3D mak=
e_pool(B_START, B_END);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    acquire(g, =
&quot;alice&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    acquire(a, &quot;bob&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    acquire(b, &quot;carol&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct ifconfig_pool *pools[] =3D { g, a, b };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool_persist *w=
p =3D ifconfig_pool_persist_init(persist_file, 5);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ifconfig_pool_write(wp, pools, 3);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_persist=
_close(wp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* reload into a set WI=
THOUT pool B: carol&#39;s entry now matches no pool */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool *g2 =3D make_po=
ol(GLOBAL_START, GLOBAL_END);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct ifconfig_pool *a2 =3D make_pool(A_START, A_END);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool =
*pools2[] =3D { g2, a2 };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct ifconfig_pool_persist *rp =3D ifconfig_pool_persist_init(p=
ersist_file, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ifconfig_pool_read(rp, pools2, 2);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ifconfig_pool_persist_close(rp);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_string_equal(g2-&gt;list[0]=2Ecommon_name, &quot;=
alice&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_string_equal(a2-&gt;list[0]=2Ecommon_name, &quot;bob&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(pool_has_cn(=
g2, &quot;carol&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_false(pool_has_cn(a2, &quot;carol&quot;));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ifconfig_pool_free(g);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    ifconfig_pool_free(a);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_free(b);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_free(g2);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_free(a2)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+const struct CMUnitTest pool_tests[] =3D {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_persis=
t_roundtrip),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cm=
ocka_unit_test(test_persist_ignore_unknown),</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+main(void)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    persist_file =3D platform_create_temp_file(NULL, &qu=
ot;pool_persist_ut&quot;, &amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_non_null(persist_file);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    openvpn_unit_test_setup();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int ret =3D cmocka_run_group_tests(pool_tests, N=
ULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    platform_unlink(persist=
_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(=
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1790?usp=3Demail">change 1790</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I0bff8d0a549a65b7da01ea0e7=
85b7ec8bea17f05 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
790 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>

</body></html>
--PIqemK6mI9M=--


--===============5337675181607579444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5337675181607579444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5337675181607579444==--

